Return-Path: <linux-kselftest+bounces-49084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8334FD2B1F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 05:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84CDE30381B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 04:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E3934320A;
	Fri, 16 Jan 2026 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7qdsJkx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52319339707;
	Fri, 16 Jan 2026 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536231; cv=none; b=IuNcxjblca+y3pJZMXI0yyvTNZLEbiKQqM65JTYxsFSU5TcYMxa7H7yY9Bc2t3W7J2dFGq0wf7qY/NSQb6U+PcLd/Zo5V4pGQJXMavS/hDYCrsqbijLlRjyNeVDpQ7fEK6Koof+Ol6wOeEo2Wu9M3oxZDFzrSgHph5DJNIaFSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536231; c=relaxed/simple;
	bh=Ffghix47mFa5R29sU17LM5muZM0SYqxlU7P7oiihxaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=upbLq/Ybcwhz2B8hlQii7ry/s/qsYoZXc9QzRoLy187HiJSYRyYbQOl+oEVSJt4uBFEUo6btgtlcxxCJQ0Q1gAhqBoVGTD2RAxkQKxHrEfB3xmDzy5uk+U5qVmhNtNpYW3LLQSaXh+IuOMUt2lodKtPES8A30iHJAP1ZWTrQ3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7qdsJkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63CCC116C6;
	Fri, 16 Jan 2026 04:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536230;
	bh=Ffghix47mFa5R29sU17LM5muZM0SYqxlU7P7oiihxaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f7qdsJkx/yxG2T08M2GjtIGul/U+xyT2shwzE+CnHv7vazOkR5sa8WUBIK9PwwqeO
	 fUxHCB3H04QhNVQx0nvFGddfwovk2Zv0XIR8NxzOVe07Jm+Y8VlYeR23AuInEhbOKK
	 4zJ6RYcO+4ohkdUcHJ0UMgYZ0lxdA234LnuqkOuncqYAj6XkklDtadawAHOPU2rXFr
	 uUECXj3YjthubVixQpaiz0eiYKUlXBLzI6eTzB5U3zWKuChFkrV1Lav8xgjT0iECp9
	 IveLP/qs8Xb/7cI1NP7ddgO6jRX4YTkjZz2yeiU/cAPDO8NXCewUmDbEcOPu3I1oil
	 PERwdCs6O1/wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A19380AA4C;
	Fri, 16 Jan 2026 04:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: net: fib-onlink-tests: Convert to use
 namespaces by default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853602279.76642.4532293769374598050.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:00:22 +0000
References: <20260113-selftests-net-fib-onlink-v2-1-89de2b931389@suse.com>
In-Reply-To: <20260113-selftests-net-fib-onlink-v2-1-89de2b931389@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, dsahern@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, fmancera@suse.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 12:37:44 -0300 you wrote:
> Currently, the test breaks if the SUT already has a default route
> configured for IPv6. Fix by avoiding the use of the default namespace.
> 
> Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: net: fib-onlink-tests: Convert to use namespaces by default
    https://git.kernel.org/netdev/net/c/4f5f148dd7c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



