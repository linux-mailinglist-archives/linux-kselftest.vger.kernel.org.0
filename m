Return-Path: <linux-kselftest+bounces-39894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B8DB34F8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 01:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBED3B122D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 23:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1461529B8CE;
	Mon, 25 Aug 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWAFhq0s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0971E32DB;
	Mon, 25 Aug 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163401; cv=none; b=kiOQI4NbIxml6xvbLaj3LPPudwDjSdw00b/N+rMxvSNHNtwt2rvtyj/4uTFQGb4bowAPDbpKwLibUIKfdxgFmAZcs5WZclDIwTvVZL1B1fnqknrCGGuDB+7PSxdgeQZVsuiKmOI7Pe1iaD50D9CLcXQnxnGUS5x2Y3dyUheAlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163401; c=relaxed/simple;
	bh=vccet8eGicWe9Xr+i7u7kD4Y1huOxJLngM2a+gcoxIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JTJetA9O9I6GgJAn/TEAWKUtS8sz687iN64YfJlUsFlDGEGynh3mbmdcPjI4BVybiVdTg0CWDf8fjhR7FDb9ybGaWyJ9sB8UNzNcjlhmcuph5V8Q+kn+4SHmNiTjYZ3NpM9/4iOHgxzi0VIrR6oXZq/c1SU6nwRWBlE1VhPIrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWAFhq0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A65EC4CEED;
	Mon, 25 Aug 2025 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756163400;
	bh=vccet8eGicWe9Xr+i7u7kD4Y1huOxJLngM2a+gcoxIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UWAFhq0snlJZsQF32B5mX5blOpwSiWtLWtPtm/5SIRaR/NqqQuORX/j7Snj36WQfz
	 JsUFbu1Xq3YJmO1riP7WrfLkQ2TpfBGcQQSl+6fgKG1K09LDR62GZZrBlY0BhQFYB6
	 1nwU0HpMer6g4aL+V7NCb289COVWD/dF/jf041wqPB2WoqNSn5zxRM5aFhut7Uqkdq
	 J7D0Uf1BAF4L30/gY+JWfPEXifMeNMegu5GIDiiIlN/S8v2+v23e3N4xGEGDZ6BqEc
	 8ZrtluAzudTfJI2UdBIYfQXYYnP+urCusfyMmrAypJ25ro4AVYjR4P9JXBw8chlKcL
	 Aljmh4ogIWmcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C71383BF70;
	Mon, 25 Aug 2025 23:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: rtnetlink: skip tests if tools or
 feats are missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616340800.3590689.4133856229422004642.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 23:10:08 +0000
References: <20250822140633.891360-2-alessandro@0x65c.net>
In-Reply-To: <20250822140633.891360-2-alessandro@0x65c.net>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: liuhangbin@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 16:03:40 +0200 you wrote:
> Some rtnetlink selftests assume the presence of ifconfig and iproute2
> support for the `proto` keyword in `ip address` commands. These
> assumptions can cause test failures on modern systems (e.g. Debian
> Bookworm) where:
> 
>  - ifconfig is not installed by default
>  - The iproute2 version lacks support for address protocol
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: rtnetlink: skip tests if tools or feats are missing
    https://git.kernel.org/netdev/net-next/c/e79012967b26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



