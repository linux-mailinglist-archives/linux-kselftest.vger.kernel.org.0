Return-Path: <linux-kselftest+bounces-37053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00910B010BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 03:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7217660C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D718191F74;
	Fri, 11 Jul 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2n0g5tg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD018DF8D;
	Fri, 11 Jul 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196813; cv=none; b=cn96bobEKFNAFpR1w/vYzOFx+dlAgr0uWe3J9FVojmBDDn/yK4qm0L0d/LiuYiIki3UC1LAtjUFiKAL0p8Ru5BKPnl09Vr8oncpKPuf2WFfZIvpUfBEw0O5yF7Ej3DIfaliZuVklkebnkiGuUcWKfEXyD0OUMmE3cs3Ndg0Ft04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196813; c=relaxed/simple;
	bh=SJjbaF0jMt9NSas1Z2Zap5OAWI4uDia0JXviSMwQxcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kb3QaAf+qiHPaAd0EZwEAUuP62hDXRbLPKWNY9t2ZVHF8xPXMvlPvK2lZgQ14vdgHA4cLaVGKkG+9sojw0HQ9zKTPQ+ksQ4AGCthCNyT9eYeAmjPt9iWS76Sr4hGyIdNHhbXf6zCv2btzHlScwzN3yt+qwMJWq9hbH2v7bmbgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2n0g5tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A35C4CEE3;
	Fri, 11 Jul 2025 01:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752196812;
	bh=SJjbaF0jMt9NSas1Z2Zap5OAWI4uDia0JXviSMwQxcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F2n0g5tgvXkF7JKvBzLjgpbLHesk2/PWGQNN12Hl4Z8nFbjh1eOJyA/QlUmSg20Ck
	 ORBVwawpEoyEG4jHViuntPb74wTCBGzBc7p/euQ06tAIOXOQAoPG3esSmkr+PjruFq
	 izuWNfDS6J0J5Ys67L9oFlkCVaSET1NT7jL78pJ/eUl7+CkyXrKIDNCm+stY/FQmdi
	 fr2g4elZsCsqED2R/j0+91RBo0gP4H2snWUuWBELJ/+t6Hd5bzIPFZYAWdWGiR+sFB
	 AZ8vrgYfge+CDawT+c8DLEmpHqOVRwsL2FvHBanm+i09MFEoYcWv/AiIV5Pw0NfrQq
	 7oDaMDGUmbiCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FB6383B266;
	Fri, 11 Jul 2025 01:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] ethtool: rss: report which fields are
 configured
 for hashing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219683475.1724831.15606568154839115182.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:20:34 +0000
References: <20250708220640.2738464-1-kuba@kernel.org>
In-Reply-To: <20250708220640.2738464-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, maxime.chevallier@bootlin.com,
 ecree.xilinx@gmail.com, gal@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Jul 2025 15:06:35 -0700 you wrote:
> Add support for reading flow hash configuration via Netlink ethtool.
> 
>   $ ynl --family ethtool --dump rss-get
>      [{
>         "header": {
>             "dev-index": 1,
>             "dev-name": "enp1s0"
>         },
>         "hfunc": 1,
>         "hkey": b"...",
>         "indir": [0, 1, ...],
>         "flow-hash": {
>             "ether": {"l2da"},
>             "ah-esp4": {"ip-src", "ip-dst"},
>             "ah-esp6": {"ip-src", "ip-dst"},
>             "ah4": {"ip-src", "ip-dst"},
>             "ah6": {"ip-src", "ip-dst"},
>             "esp4": {"ip-src", "ip-dst"},
>             "esp6": {"ip-src", "ip-dst"},
>             "ip4": {"ip-src", "ip-dst"},
>             "ip6": {"ip-src", "ip-dst"},
>             "sctp4": {"ip-src", "ip-dst"},
>             "sctp6": {"ip-src", "ip-dst"},
>             "udp4": {"ip-src", "ip-dst"},
>             "udp6": {"ip-src", "ip-dst"}
>             "tcp4": {"l4-b-0-1", "l4-b-2-3", "ip-src", "ip-dst"},
>             "tcp6": {"l4-b-0-1", "l4-b-2-3", "ip-src", "ip-dst"},
>         },
>      }]
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ethtool: rss: make sure dump takes the rss lock
    https://git.kernel.org/netdev/net-next/c/400244eaa2c9
  - [net-next,2/5] tools: ynl: decode enums in auto-ints
    https://git.kernel.org/netdev/net-next/c/f7c595c9d9f4
  - [net-next,3/5] ethtool: mark ETHER_FLOW as usable for Rx hash
    https://git.kernel.org/netdev/net-next/c/d7974697de4d
  - [net-next,4/5] ethtool: rss: report which fields are configured for hashing
    https://git.kernel.org/netdev/net-next/c/178331743ca8
  - [net-next,5/5] selftests: drv-net: test RSS header field configuration
    https://git.kernel.org/netdev/net-next/c/0c8754b75e69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



