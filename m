Return-Path: <linux-kselftest+bounces-39428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D4B2EB5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75B344E3248
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 02:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59B2D97BF;
	Thu, 21 Aug 2025 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZq5Recj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824802D97AC;
	Thu, 21 Aug 2025 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744028; cv=none; b=uJFmpzCLGgNAWaHBoCoZVOmX4CxfQYpL4qbUkZWR+a0/qqBH1ob/axZzGWu2WO25KdvOY6h4gsAjvspIGEo7qTWKIDoh8Lccyzv06x2PEs6mIVA6alu+iA1JrEPREBAdUEPc8MDlHgb+hqbLnA78TsA/WrVeS8cp8cjyjaMMLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744028; c=relaxed/simple;
	bh=p6J28krG4f7lZM8W41t/qhSp1UEt0ZpO3YDjqLJIHIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ub9JotqpC+b2XBJRdz8yXOTWDKw6MNoD+Empq1KPMHd1VHcYWwsTM5cXq5ADEPWW+r09RWf46HiA2E3+PkTO/0g5YNdML6wIgHfe8yN2deG/dvDs31Pomdn4YKgyMzfsMs8lBY3XV2ZTLD/GXfRqR8Avr/CY8sQNnM/J8aQRK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZq5Recj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D50AC4AF09;
	Thu, 21 Aug 2025 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744028;
	bh=p6J28krG4f7lZM8W41t/qhSp1UEt0ZpO3YDjqLJIHIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NZq5Recj1xXDnzhH/Q+pgrSwHDMSd8yJ3wP4oM4fE9keiAj5f4IXq7tBE2m/SlPNK
	 iq7pZVeh86g/8510wllgeqIuiWNwSAqgI1ZA6jSHw6mB4CbR0puoMQFA2OfMDr1Vvu
	 yyLRcXLyMlDQqc/JumR/UDBG5hpsNHp9S+nHL7ri7XvrRxUxQT6Qj5j3jNM4Kh+fiQ
	 yvw8vBvvjScpJEWPrEVJlaPR0TRGUr83mV2NZwnyrLaAR+xLBh8e1m/5hk/KlgWYjY
	 4k6ZzrgcOhOCse8ha58e2OdpB9woNR8kSRjtNTMeU4n0wjT9pA2LxWWXcc+4vxI83l
	 uZBYUVwHQ2iQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8B383BF4E;
	Thu, 21 Aug 2025 02:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: rtnetlink: print device info on
 preferred_lft test failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574403724.482952.16387694626145075781.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:40:37 +0000
References: <20250819074749.388064-1-liuhangbin@gmail.com>
In-Reply-To: <20250819074749.388064-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 fw@strlen.de, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 07:47:49 +0000 you wrote:
> Even with slowwait used to avoid system sleep in the preferred_lft test,
> failures can still occur after long runtimes.
> 
> Print the device address info when the test fails to provide better
> troubleshooting data.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: rtnetlink: print device info on preferred_lft test failure
    https://git.kernel.org/netdev/net-next/c/781bf2cc0616

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



