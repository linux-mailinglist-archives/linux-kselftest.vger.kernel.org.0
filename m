Return-Path: <linux-kselftest+bounces-37966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C33B11620
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 03:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A45AE026C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 01:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A51EDA1A;
	Fri, 25 Jul 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLsHdueA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA110E4;
	Fri, 25 Jul 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408793; cv=none; b=pCESA/Y3HReheL9r8Fj9YsiguljbVORsFKI5ztUaGJNBdmg40Lc7p5u7bRDmfwJJeMXC2KbssAnoBhDnk4jzMxmBzv7uEaAYJ7HSxGqfoIrG7NJedeAXuGem3DYzEsTThAE9UVa8psN+60JY+vFIXhLfZJU2fngRmWN2iCUACSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408793; c=relaxed/simple;
	bh=i/EY8HwF3v5WgegoMJ1dk4JMAPDlIwwNTv3uTZqgjLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NdXCQ+SD/pfPqpWVu7Dm21ckI9s9uihuvMO8uSPugK31HyQAdJLjIcbBv4085YRD+oBLEq3XBkrkCFaxzKDzZ0kFmUjhpqtrQapJmcwobFLbGDEU7lYyrvVrVHw7W79MPLLv7him3g90H6M2jqLunFJH1cAFndVEhLEXAyjneDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLsHdueA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41507C4CEED;
	Fri, 25 Jul 2025 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408793;
	bh=i/EY8HwF3v5WgegoMJ1dk4JMAPDlIwwNTv3uTZqgjLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SLsHdueA2VzBvO1sGJSxkBmeijGni5hsX+XxN7Hx/DghXRScJalbel3UAPsbsGPur
	 h5p5Nr7sQbdG59ABx81PVwzbCwDZ0qzXAaJRQFJ6WA7jrKtQVrKYnTzgbpE7z78yRc
	 WY27Dd5jh9SkX1Dvb/8VcNkOnI9H5RzKrJ0SJKR9W0eJ80aBeGF7p8pnNAlksKYCdk
	 45lYEeTsZdAzZTun1OsYzJbOaBXG2DjqERRHQ21Nq2ylnf14MGF+8v8pvauGLZ3UAd
	 pPqYfGhN38qsV8p1gIkLdfAq1TFAjideFKJEdTNAJAiXBmRJAYI9qe/Yx8fAgce0Qi
	 ywlotSEFNzAbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A84383BF4E;
	Fri, 25 Jul 2025 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: drv-net: tso: fix issues with tso
 selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175340881100.2604761.14479845091806537313.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 02:00:11 +0000
References: <20250723184740.4075410-1-daniel.zahka@gmail.com>
In-Reply-To: <20250723184740.4075410-1-daniel.zahka@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, willemb@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 11:47:35 -0700 you wrote:
> There are a couple issues with the tso selftest.
> 
>  - Features required for test cases are detected by searching the set
>    of active features at test start, so if a feature is supported by
>    hw, but disabled, the test will report that the feature under test
>    is not available and fail.
>  - The vxlan test cases do not use the correct ip link flags based on
>    the gso feature under test
>  - The non-tunneled tso6 test case is showing up with the wrong name.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: drv-net: tso: enable test cases based on hw_features
    https://git.kernel.org/netdev/net/c/266b835e5e84
  - [net,2/3] selftests: drv-net: tso: fix vxlan tunnel flags to get correct gso_type
    https://git.kernel.org/netdev/net/c/2cfbcc5d8af9
  - [net,3/3] selftests: drv-net: tso: fix non-tunneled tso6 test case name
    https://git.kernel.org/netdev/net/c/b25b44cd178c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



