Return-Path: <linux-kselftest+bounces-38608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CFEB1EE4F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 20:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9A5A34D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 18:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532821E0AF;
	Fri,  8 Aug 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfC27LuA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B57B218EBF;
	Fri,  8 Aug 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677195; cv=none; b=cbq7QgfYUWOVW03Kv0bPpcatsiaizOlDgbyuyxaNDcW8i+VD37/aQuCUyNaCuOjv+ZZHQOC6rRKHj9kMFDu3J9HRW4vKMAFWB8UxJTFO9+GAnj0qgWfsovVd8X7mB9xPv4skyl9sGX5VbuqXzQ2fjLYrPZlxlAsFsZoWQMsJu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677195; c=relaxed/simple;
	bh=pNRpBCH+11HQ62i/eKnNGeatXPFMO65FgC7hQ2/stmY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fpExLQ2JDfcnD6ahPBgkNwkJ0T/PA5HPTQatdi3yU/En704C0jhfnxSLwvXiB3Xd/AKMRVnVoy6ZfJiqHhCx6NqjBjHiBNaVzWOKD634vk8wUMxNNLpJySO4Uih9jEGz/svprUiPwQPzsbpHftkFbrJRnCCUrc5jwgU1ke9lRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfC27LuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B819FC4CEED;
	Fri,  8 Aug 2025 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754677194;
	bh=pNRpBCH+11HQ62i/eKnNGeatXPFMO65FgC7hQ2/stmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cfC27LuAz0KUY9df/QNZP1cLBaplvql/KXs8Bko0GWC5z16sUHy1ct987GJuwjhJx
	 qKl3pXuJhsLpyZ/PKmsJPteOlsLARbo3OKkwyz8tDX4XmVvYG8MPoG+5CKkc4ku9Nl
	 Dzd7BvIrIKKoqJahwgP0mcQr5QUnaITAQ762czNLss+WU1wwd0litj4d8pIFhNaHKb
	 b4jSPTvNc0aWrMb1/r6XxzgLkRVaLoD1gf265SzZOqrq+b/uMMLFSxiMjSFos318Ed
	 6nxFqMYcfbIbRwKVszbHNIJXIR3XH5KkwvGBpLRKtvRTfanPrq/Ft3VAk72c6zFBLd
	 h7cRLB+07ILeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3435D383BF5A;
	Fri,  8 Aug 2025 18:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 iproute2-next 0/3] DUALPI2 iproute2 patch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175467720800.225370.4571833137902033089.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 18:20:08 +0000
References: <20250804122019.57829-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250804122019.57829-1-chia-yu.chang@nokia-bell-labs.com>
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: dsahern@kernel.org, alok.a.tiwari@oracle.com, donald.hunter@gmail.com,
 xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  4 Aug 2025 14:20:16 +0200 you wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Please find DUALPI2 iproute2 patch v12.
> 
> For more details of DualPI2, please refer IETF RFC9332
> (https://datatracker.ietf.org/doc/html/rfc9332).
> 
> [...]

Here is the summary with links:
  - [v12,iproute2-next,1/3] Move get_float() from ip/iplink_can.c to lib/utils.c
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=86527787f1fb
  - [v12,iproute2-next,2/3] Add get_float_min_max() in lib/utils.c
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3dfc7dad0a6a
  - [v12,iproute2-next,3/3] tc: add dualpi2 scheduler module
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0ad8fef32236

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



