Return-Path: <linux-kselftest+bounces-46166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7DC7701D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 03:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE5BD34BCFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 02:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F070271467;
	Fri, 21 Nov 2025 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE9LHaH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F451D88D7;
	Fri, 21 Nov 2025 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692258; cv=none; b=dPHnyaTR9B6xi0/9s2ptKYpGIv0LO+JLLSJalvU3GXUq3MRF/lmhWw6fZE1vSyOprSFRbxdyp4NAjk6C0PS20YsjsDPHdj+jYMc1nIA411Q6LlsjqjHZ+9NWk4M7nFs2JgsFBWrfWfQBXyb8ls+uSM/nZ1wxzBHW4zNxg9FOca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692258; c=relaxed/simple;
	bh=ZNJ7IlFBKgvQnIy25U/SmLqcjvdVTuAY1B/5dIQjkoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LV5SxFLmqDvyWt2oVgsJPB4CQMB2x0tjll+hRFVwUCIw1yk88GsnKyP4+D6n7qD2CzTXhZ35wOwylcs+T5jk2IoN5GOAhmn2+t1whfDixiV3omWlsDWjJybBfGC6p6jAwpzbRgtOdi7eNOZMXKp6PxQ0kqkGBQjwpclVnt/xiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE9LHaH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7258C4CEF1;
	Fri, 21 Nov 2025 02:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763692257;
	bh=ZNJ7IlFBKgvQnIy25U/SmLqcjvdVTuAY1B/5dIQjkoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eE9LHaH34o5ZZtIFzNHhp3nUqnl9CrxnoLy2aPRtRvjnQ9Jz9A6or900iSUXGUt9F
	 zVk7/j3NMc4QZcyrsNIrXxXjmTErW04ErU2cI+fWhZwzuLsqOIcdp9G8IuJqlwQyuO
	 oUn4lxJ4E0aUaZdfnaSDG2AGxPRGHbspJeSQ39dtqA3CnXQ9ogQSIz2OC6gf5gQMM1
	 jAX0OrtyYNtebBeRKP9R66X3zvc7fW0Yx1nHYo/0R43N5m3k0wdWswmNL2G48N4gcu
	 mRu5XVsL2wZH3/aRRBk6tUJFr92Fm73ORFottCQq+6h//MjkR51SZ3RCIXDPLrJK6s
	 LuKuG/At0xyJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECA3A41003;
	Fri, 21 Nov 2025 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369222275.1865531.9454432875896275033.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:30:22 +0000
References: <20251120021024.2944527-1-kuba@kernel.org>
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, shuah@kernel.org, sdf@fomichev.me,
 krakauer@google.com, linux-kselftest@vger.kernel.org, petrm@nvidia.com,
 matttbe@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 18:10:12 -0800 you wrote:
> Main objective of this series is to convert the gro.sh and toeplitz.sh
> tests to be "NIPA-compatible" - meaning make use of the Python env,
> which lets us run the tests against either netdevsim or a real device.
> 
> The tests seem to have been written with a different flow in mind.
> Namely they source different bash "setup" scripts depending on arguments
> passed to the test. While I have nothing against the use of bash and
> the overall architecture - the existing code needs quite a bit of work
> (don't assume MAC/IP addresses, support remote endpoint over SSH).
> If I'm the one fixing it, I'd rather convert them to our "simplistic"
> Python.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/12] selftests: net: py: coding style improvements
    https://git.kernel.org/netdev/net-next/c/5cb7b71b76f1
  - [net-next,v3,02/12] selftests: net: py: extract the case generation logic
    https://git.kernel.org/netdev/net-next/c/80970e0fc07e
  - [net-next,v3,03/12] selftests: net: py: add test variants
    https://git.kernel.org/netdev/net-next/c/6ae67f115986
  - [net-next,v3,04/12] selftests: drv-net: xdp: use variants for qstat tests
    https://git.kernel.org/netdev/net-next/c/173227d7d6c4
  - [net-next,v3,05/12] selftests: net: relocate gro and toeplitz tests to drivers/net
    https://git.kernel.org/netdev/net-next/c/89268f7dbca1
  - [net-next,v3,06/12] selftests: net: py: support ksft ready without wait
    https://git.kernel.org/netdev/net-next/c/e02b52ecef5b
  - [net-next,v3,07/12] selftests: net: py: read ip link info about remote dev
    https://git.kernel.org/netdev/net-next/c/15011a57d0ec
  - [net-next,v3,08/12] netdevsim: pass packets thru GRO on Rx
    https://git.kernel.org/netdev/net-next/c/40dd789bc5a7
  - [net-next,v3,09/12] selftests: drv-net: add a Python version of the GRO test
    https://git.kernel.org/netdev/net-next/c/fdb0267d565a
  - [net-next,v3,10/12] selftests: drv-net: hw: convert the Toeplitz test to Python
    https://git.kernel.org/netdev/net-next/c/9cf9aa77a1f6
  - [net-next,v3,11/12] netdevsim: add loopback support
    https://git.kernel.org/netdev/net-next/c/358008f41d9b
  - [net-next,v3,12/12] selftests: net: remove old setup_* scripts
    https://git.kernel.org/netdev/net-next/c/bd28e5bddc1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



