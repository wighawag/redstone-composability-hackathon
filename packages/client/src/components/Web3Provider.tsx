import React from 'react';

import { WagmiProvider, createConfig } from 'wagmi';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ConnectKitProvider, getDefaultConfig } from 'connectkit';
import { anvil } from 'viem/chains';

const config = createConfig(
  getDefaultConfig({
    appName: 'ConnectKit Vite demo',
    chains: [anvil],
    walletConnectProjectId: import.meta.env.VITE_WALLETCONNECT_PROJECT_ID!,
  })
);

const queryClient = new QueryClient();

export const Web3Provider = ({ children }: { children: React.ReactNode }) => {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <ConnectKitProvider debugMode theme='retro'>{children}</ConnectKitProvider>
      </QueryClientProvider>
    </WagmiProvider>
  );
};