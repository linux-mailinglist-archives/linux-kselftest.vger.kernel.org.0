Return-Path: <linux-kselftest+bounces-37904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B231B0FE9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 04:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610945881AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D51D86DC;
	Thu, 24 Jul 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT8YoktX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D51D63C6;
	Thu, 24 Jul 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322427; cv=none; b=hwkPl2LEXJ3IVhKeieNBIufaCKOl4VE6DNsSkjGrKnPTwNibeWFzLxhT5ArgX0NCEBhj/8hmYm50PNJh+YEkI7vkpIyn/LieVtS7RSGee+09nB/ilnQWTQllGm1Ig8xVWM5FqrgZCtUlFOw9M5KYSANwgpBxBigLLCnag/INIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322427; c=relaxed/simple;
	bh=vW1Y82bQz5Cnb0iD9jSF+gH9byMYZIWwv4s7PFcNCv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cQKlRfIYAmCnkAdR/lYlvzMTt/3pJj1dWa/D6VQoNxnXv/rRTxwy3tbisddjmPkbdLFda59klOuUi1mC1TA1Psli7B5maMfKjNipABX+xVfj7pyxcFYVRsk/aplrb5I1mrBFZdh0vOBPxfxBXyV66WQ3jF9tcGavvsj1M5Cf7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT8YoktX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F455C4CEE7;
	Thu, 24 Jul 2025 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753322426;
	bh=vW1Y82bQz5Cnb0iD9jSF+gH9byMYZIWwv4s7PFcNCv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DT8YoktXzkQW9yfEzPUCG0UyswGa5KjG7w2pMnMkA1wacjof4OtSoyYF5Uwa2kUfX
	 RzCsC0xMl1GAGgCDgGJW9rVY2gfbtBa7hAAu4L3p2f95kpMfU2B54yI7Gbq8UdIxPw
	 FNOFgEDfhR1AfWKju2ypfeHJJsvmSj2CFuIdbSKAQN0be8i+qE42HdeNqGy43DepXP
	 0k/0n3jcRAmBQFGv3us2zvxbuRxAmj4HWER+71apunJ41sIAU0IfbvnZJse20Fb307
	 CsZKEVYpOyiMBWcK6TGBLbygGj8om8mls/HczCYRpmwR7qEbqgn+uzkD9bMunlbFCY
	 6iOJW2Q6hHfBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC7F383BF4E;
	Thu, 24 Jul 2025 02:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v26 net-next 0/6] DUALPI2 patch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175332244424.1844642.13296732935919605611.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 02:00:44 +0000
References: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250722095915.24485-1-chia-yu.chang@nokia-bell-labs.com>
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: alok.a.tiwari@oracle.com, pctammela@mojatatu.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 11:59:09 +0200 you wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
>   Please find the DualPI2 patch v26.
> 
>   This patch serise adds DualPI Improved with a Square (DualPI2) with following features:
> * Supports congestion controls that comply with the Prague requirements in RFC9331 (e.g. TCP-Prague)
> * Coupled dual-queue that separates the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
> * Configurable overload strategies
> * Use of sojourn time to reliably estimate queue delay
> * Supports ECN L4S-identifier (IP.ECN==0b*1) to classify traffic into respective queues
> 
> [...]

Here is the summary with links:
  - [v26,net-next,1/6] sched: Struct definition and parsing of dualpi2 qdisc
    https://git.kernel.org/netdev/net-next/c/320d031ad6e4
  - [v26,net-next,2/6] sched: Dump configuration and statistics of dualpi2 qdisc
    https://git.kernel.org/netdev/net-next/c/d4de8bffbef4
  - [v26,net-next,3/6] sched: Add enqueue/dequeue of dualpi2 qdisc
    https://git.kernel.org/netdev/net-next/c/8f9516daedd6
  - [v26,net-next,4/6] selftests/tc-testing: Fix warning and style check on tdc.sh
    https://git.kernel.org/netdev/net-next/c/51217c659e74
  - [v26,net-next,5/6] selftests/tc-testing: Add selftests for qdisc DualPI2
    https://git.kernel.org/netdev/net-next/c/032f0e9e15a4
  - [v26,net-next,6/6] Documentation: netlink: specs: tc: Add DualPI2 specification
    https://git.kernel.org/netdev/net-next/c/68db0ff2f76a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



