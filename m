Return-Path: <linux-kselftest+bounces-9148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A3E8B7B54
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A351F234D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863F5143736;
	Tue, 30 Apr 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZmcD39V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC61152799;
	Tue, 30 Apr 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490432; cv=none; b=Ly6OPH7fsV6p9TPhp9KLrt6SjxnOGuntBzXyrbNqyxtAIqCN8thYVrXcundYVfRatjd6UMii3C86QMnLOcabRsIztnmB6CfJolvzA272HSdXr8QzdQ6IKYrNgHqlUjzB+Ycj3396Tk2sXZgn9dxhtqUk9OdewlorlP+nyxDzOBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490432; c=relaxed/simple;
	bh=8RKsDLKFxHNFsoPYcuLW5YXWla9fw22pqt2LsmxYKsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GrRGF2mZOdZo4MDO53qkrILkL1pQO25w99XrRhoBgrZYTRf5XbkvGrZpHeDFwxzV3he0HO0A9MNMjHKggaCKdN2ID801hpu5lqjHMui2NuGMH86FNLWuf57VL2n25DUuu24VqzhW67UbOJ1VCfrsdwDx/HWn3hWxyvRRBLPoz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZmcD39V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4B4AC4AF19;
	Tue, 30 Apr 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714490431;
	bh=8RKsDLKFxHNFsoPYcuLW5YXWla9fw22pqt2LsmxYKsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KZmcD39VHHk0ClFCuf2BgWcVwc55VhLnKFG6+gw9dxuf0/ocHQz6TH+NfNfzyjLBZ
	 KzvYwEvd1+o94W4A9U+OfusvCOEN5xELlnDAWX9QU6hqiyEn4L1jcjxjSqRF4uE7Mr
	 2yMym75Kh8JyvVLQxV14Eknba/z9/b7gp0mL1m5/SZQNMeHD0+VEhNrj+8uJw7dDNB
	 00xceVBUfMPtfelX2FxP0S0CbsKZ/Ym9dEYn6hVEfLqINrL4HgQ8iCsxm9N+wXkKKf
	 MXOq15337A4L0heEQCTwgZrrsIdW3QQOeBgVQs6DlfLnVnVUhrhfCffmzTGM6eOYmz
	 sPipX2ZaxoYig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1F7BC43616;
	Tue, 30 Apr 2024 15:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] selftests: net: page_poll allocation error
 injection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171449043085.29434.16486450052469503597.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 15:20:30 +0000
References: <20240429144426.743476-1-kuba@kernel.org>
In-Reply-To: <20240429144426.743476-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 07:44:20 -0700 you wrote:
> Add a test for exercising driver memory allocation failure paths.
> page pool is a bit tricky to inject errors into at the page allocator
> level because of the bulk alloc and recycling, so add explicit error
> injection support "in front" of the caches.
> 
> Add a test to exercise that using only the standard APIs.
> This is the first useful test for the new tests with an endpoint.
> There's no point testing netdevsim here, so this is also the first
> HW-only test in Python.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: page_pool: support error injection
    https://git.kernel.org/netdev/net-next/c/12b6c3a0380a
  - [net-next,v2,2/6] selftests: drv-net-hw: support using Python from net hw tests
    https://git.kernel.org/netdev/net-next/c/ff4b2bfa63bd
  - [net-next,v2,3/6] selftests: net: py: extract tool logic
    https://git.kernel.org/netdev/net-next/c/32a4ca1361d7
  - [net-next,v2,4/6] selftests: net: py: avoid all ports < 10k
    https://git.kernel.org/netdev/net-next/c/ee2512d6bf41
  - [net-next,v2,5/6] selftests: drv-net: support generating iperf3 load
    https://git.kernel.org/netdev/net-next/c/0f0cdf312ecc
  - [net-next,v2,6/6] selftests: drv-net-hw: add test for memory allocation failures with page pool
    https://git.kernel.org/netdev/net-next/c/9da271f825e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



