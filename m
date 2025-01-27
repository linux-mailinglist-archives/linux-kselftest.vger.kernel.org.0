Return-Path: <linux-kselftest+bounces-25258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1C5A20093
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2345F1886FC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC10A1DDA17;
	Mon, 27 Jan 2025 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2RMlrF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67EB1DBB19;
	Mon, 27 Jan 2025 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017012; cv=none; b=sRIPW8DwaIr2itkb5rL27xhjUVUeAeO8O1oSXrEOxgPFw9MqbALYryoRqb5tz7yOEKOsyNgiH6PKIeL7IWDpTAOd/BAADl5Ra7RYBLtjgyXONjDMwD0oU/e8jkyHC2vQlJlCsePLWxYr9huiGUAiJIAYVc7UZezgXkMG3bY2vqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017012; c=relaxed/simple;
	bh=QjYVtcxok/QmrRLchrO7jn7VkjM/qbaJ9qevY2e3USI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o8Q/MOCNpK4V7Efbfu9V20Msr0cSw6Y+Cu24NzVKDf4LQ/7HrOeMmU2UnZ1ftPrrjCuLbJxBy+Fs9Evx3ugMV6CF5pl+etTBP3TQokBrQL/Ngy3NPmxiz8vUdVYUllkp0CR4sIHx+tdC03iEStspGp+LSCcGeSoW6rTkzd534Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2RMlrF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27607C4CEE3;
	Mon, 27 Jan 2025 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017012;
	bh=QjYVtcxok/QmrRLchrO7jn7VkjM/qbaJ9qevY2e3USI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o2RMlrF3rptGS8gGcRXni+x5O52DKTKt/qtfRTtMqR7xB1IqwAHiqN9eeC98W0UFZ
	 INxtMohSyfAmxVLHb+RrKkeb+98Q/g5K5+y+j/6EtHLZmpJoHUZcViyww4Saxy74dl
	 khyauNTkjMlwH9MMihHx/0L7GdCbsKsxXRHH+K3iXM2emS/S0xKID51qxmk2LM5hqX
	 s/cChcRBIoAq7KGOpcfsvXjGVD6W6wYJLeLonx4Ierxj0pIIULpK7vqHy3gCnBUgvo
	 e54ieJwoiG7eEAGFLDkleOcsAMnV7cMRRvbvtrmGYsbXAmhykedZ+0HUWxW2CgwkbK
	 oHcJCZ0qAAUTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAE0380AA63;
	Mon, 27 Jan 2025 22:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: netdevsim: try to close UDP port harness races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801703774.3242514.7632581450583878601.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:30:37 +0000
References: <20250122224503.762705-1-kuba@kernel.org>
In-Reply-To: <20250122224503.762705-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 syzbot+2e5de9e3ab986b71d2bf@syzkaller.appspotmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jan 2025 14:45:03 -0800 you wrote:
> syzbot discovered that we remove the debugfs files after we free
> the netdev. Try to clean up the relevant dir while the device
> is still around.
> 
> Reported-by: syzbot+2e5de9e3ab986b71d2bf@syzkaller.appspotmail.com
> Fixes: 424be63ad831 ("netdevsim: add UDP tunnel port offload support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: netdevsim: try to close UDP port harness races
    https://git.kernel.org/netdev/net/c/50bf398e1cea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



