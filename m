Return-Path: <linux-kselftest+bounces-45682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E70C5FDBD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 03:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40ACF35C1E2
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA21E0B9C;
	Sat, 15 Nov 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RynawGdT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442F14B950;
	Sat, 15 Nov 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172150; cv=none; b=IN2Ce1/SuXl27TzuoVfZjiYyk4zvwQ0NUVR5dew9JY4cYyX9RXfW7CG5nTGzFQnCJ0dFV0LOTL3juif1jfYSU1l3biT7z9MB9NXfRTnRaRvnkXpboBXjmrLrh5W2zLvkidAe3eFaNW8mpeeGhRz4miENDDbjngQDvDj56hu+i+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172150; c=relaxed/simple;
	bh=XRBbg6O1jgM78OoEPta9VGkKHRKfrdD6QyAbsEaC3Qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RbNfmci95ArUjDDS22Kd5OTkgu5vZPtyoOloCVEyduy4j6NJe+Q+a/yxsh1USQtLd8xflpMVX/qSmG5StWsYZBv7gMc1SPL7qCrZ/HFMCpYZjXhbKfX7aVwcp1G+wCGuvWjUjIcD7EGcDDsbUVXxkTM4qe/iOzVlLqB2pIhMPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RynawGdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7C7C4CEF8;
	Sat, 15 Nov 2025 02:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763172150;
	bh=XRBbg6O1jgM78OoEPta9VGkKHRKfrdD6QyAbsEaC3Qc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RynawGdTLLO03mtGuSDdH6arc1RvkCoppyx0kD1NO00HqEjkBdi5dwpqKTJ9llLFR
	 P84yOUQM1bKcdaRxfymXdcRbBvHAnMHzeYSqhyGxshZ+9jMNlfNzOyL5m552HPAYpd
	 Ck/5Hbw4rakcJ9X9PsRcVMRd2+7AubH94hqJvKeUvCpQWRzVz3s3dggX0air/Hc62e
	 MLoL+3dOow1xMu1bGmmsJ4BAZhINCLFjlLKujeek01JapuXua18kcXHWwMII+b1ufD
	 Oq1wlP8quntXRSQ05KTloiM12y1N7emB4eKA9FQiEB2gyE2lh0IK1JUHVfjG6U4ZyK
	 PnIQpUp22c2Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEA43A78A62;
	Sat, 15 Nov 2025 02:01:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: xdp: Fix register spill
 error
 with clang 20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317211824.1905277.15336116375736366070.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:01:58 +0000
References: <20251113043102.4062150-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20251113043102.4062150-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, mohsin.bashr@gmail.com, martin.lau@kernel.org,
 ameryhung@gmail.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 20:31:02 -0800 you wrote:
> On clang 20.1.8 the XDP program fails to load with a register spill error.
> Since hdr_len is a __u32, the compiler decided it only needed the lower
> 32-bits of ctx->data, which later triggers the register spill verifier
> error.
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: xdp: Fix register spill error with clang 20
    https://git.kernel.org/netdev/net-next/c/e1215d1d38c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



