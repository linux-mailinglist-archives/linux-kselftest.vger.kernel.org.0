Return-Path: <linux-kselftest+bounces-48656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A70D0CBEE
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52018304484D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F5234984;
	Sat, 10 Jan 2026 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnoSyp9x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FB2A1CF;
	Sat, 10 Jan 2026 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009420; cv=none; b=WScxvXMfSTui5vKCOcUONKzVCCuyXYXK3barFscTGFzKeNJG/5UwoR+NBeNp1ScVI0GwuuGDWRNdyUHmNU9ToEagag/mm+d2wf14EqR1CWyqZvLV+V+RY0laNdgOXhCVl6HJDrHSyJCLECKujABshRuZ52bbwuYBqU51Qk4uaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009420; c=relaxed/simple;
	bh=GNsDzZ21fqlFwLg1DwOC+ef5yX1GNRz9PGSit1JclRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pp/sxFZGpWCqf4QTRGcL+srlozRhQEIlsjbB3+0b/XteyjT5SbKul4RbRRpVgb0dA+Wleael8v6ZpDK9Rd3ugQPADfUgocadVk9utKvXr6j1RiUu/pEpBinYCv04Ksd/Zb7K5lAFWv8ClBEzMQOZ3dhOhwE4/JELSj4bBiYlD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnoSyp9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60B9C16AAE;
	Sat, 10 Jan 2026 01:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768009419;
	bh=GNsDzZ21fqlFwLg1DwOC+ef5yX1GNRz9PGSit1JclRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FnoSyp9x/6SH6FR4ThL2UIaaRFo6rasewVb8h+Dz03HPcyuGf4eT296I9l5y5p2mX
	 /1yDXivWEZ7jCuiuKEjXnEWt+0VJXqE8UVh9uXMwdSgxCl18YAO0+5nuPJ5eS/PFSg
	 1nDhJvtswnLaKaVKbbncTEf1NyGaVL0g+fRw7Gt6Sqpq8XIimwUTG7hW3Et5k52luM
	 hWIIc34Yx4MSieTKTfRELrvlMurN4gEz4HDPdm95x69A4fglOLBtqLBG3QahUUPHJb
	 jsJUdBuHT2z9tO7ZcOFG56IwP8Wj+ePitIHx5nG+70857HybN+SIhYLYioH+hGIc5Y
	 fifS8f3IksPTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786863AA9F46;
	Sat, 10 Jan 2026 01:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: gro: increase the rcvbuf
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176800921502.446502.17034098573250179681.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 01:40:15 +0000
References: <20260107232557.2147760-1-kuba@kernel.org>
In-Reply-To: <20260107232557.2147760-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemb@google.com, anubhavsinggh@google.com, mohsin.bashr@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jan 2026 15:25:57 -0800 you wrote:
> The gro.py test (testing software GRO) is slightly flaky when
> running against fbnic. We see one flake per roughly 20 runs in NIPA,
> mostly in ipip.large, and always including some EAGAIN:
> 
>   # Shouldn't coalesce if exceed IP max pkt size: Test succeeded
>   # Expected {65475 899 }, Total 2 packets
>   # Received {65475 899 }, Total 2 packets.
>   # Expected {64576 900 900 }, Total 3 packets
>   # Received {64576 /home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/gro: could not receive: Resource temporarily unavailable
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: gro: increase the rcvbuf size
    https://git.kernel.org/netdev/net-next/c/a0ac0ff38276

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



