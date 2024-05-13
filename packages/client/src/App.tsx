import { ConnectKitButton } from 'connectkit';
import { useMUD } from "./MUDContext";
import { useState } from 'react';

function App() {
  const {
    systemCalls: { joinMatch },
  } = useMUD();

  const [matchID, setMatchID] = useState<string>('');

  const execute = async () => {
    if (!matchID) {
      alert('Please paste a match ID');
      return;
    }
    await joinMatch(matchID as `0x${string}`);
  }

  return (
    <>
      <div className="container">
        <h1>🃏 The Joker Wants To Play</h1>
        <div className='step'>
            <ConnectKitButton />
        </div>
        <div className='step'>
            <p>Paste a match ID to invite the bot</p>
            <div className="input-group">
                <input type="text" onChange={(e) => setMatchID(e.target.value)} value={matchID} placeholder="Paste Match ID" />
                <button onClick={execute}>Execute</button>
            </div>
        </div>
      </div>
      <div className="links">
          <a href="https://play.skystrife.xyz/">Tutorial</a>
          <a href="https://play.skystrife.xyz/">Twitter</a>
      </div>
    </>
  );
}

export default App;