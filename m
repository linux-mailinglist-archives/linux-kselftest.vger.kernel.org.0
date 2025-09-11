Return-Path: <linux-kselftest+bounces-41268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF9B53D87
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 23:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD1D1BC2484
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0967A2D8788;
	Thu, 11 Sep 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FplmLsfk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7E1DA55;
	Thu, 11 Sep 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625009; cv=none; b=F9tWIP2eHFNHJ98J0TIxE0bf69wOrhFu4v9YEifQ9IZbnGE6CaPnSyGFdcnO85j+ToBFQz+VxxDczkTNUGxv3ObqLrsaeVsZOkpULR9g5QrX/tJ0nQJrhLN96E+y5iYPUzM4yszt99g9m7FqG5Pnbzv1iXWrxkx7Z1iy3vJcPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625009; c=relaxed/simple;
	bh=FWAIwdvUNs+VfhZmeFQIOIGqW4Ncymbm8d8vyNuVGS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mpLsZNPLpxfw/MDlS5Q3gN0EjghU3lMTHhnTSNsI6b6FXcKiRWR3VfVQNipshHAoF0SjpmFDKZ7kBXrWBTPTUafEVrZ+RyzCApwnd9hjcC2VRuuEZW3tvj1ZLwoGxT04j6G/zRRl3hv6gPE0b4+D9nzoNHkGgW/NWzVN6GF1dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FplmLsfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F15C4CEF0;
	Thu, 11 Sep 2025 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757625009;
	bh=FWAIwdvUNs+VfhZmeFQIOIGqW4Ncymbm8d8vyNuVGS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FplmLsfkxuXgfgIOHwCvJaT7xutHU5WD0di9Z3x4y/6ZL34TIoaEVKe6yiCl1BUYS
	 a6GWUFSo4j8agHzN7y4kmEC3Wv/dx14PKZIrGVdXCcbX2XbAe46n9Lowx0DeZUx5uw
	 2MlAwXjKCnMvy2/79OZxS4WWh6U67eKYv8vFuRLSAxqe3a/UmQkbr7+/2SjqGyVekW
	 w51tQ+FupG6pfbe90V8nLF416Ay+n5/Bo78QTmq6mwmGazczGy4FQlMOt5gwZGUr0j
	 /ue07EIyQk6FEGVo1njEE1+p1e0XHmssMHdYvlDU3W8LRxgsX0rNmiKkfM6ipYPrpy
	 H4B0htgTvETzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC0383BF69;
	Thu, 11 Sep 2025 21:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv5 iproute2-next] iplink: bond_slave: add support for
 actor_port_prio
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175762501226.2314970.10917315881007643115.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 21:10:12 +0000
References: <20250902064738.360874-1-liuhangbin@gmail.com>
In-Reply-To: <20250902064738.360874-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, corbet@lwn.net, petrm@nvidia.com,
 amcohen@nvidia.com, vladimir.oltean@nxp.com, stephen@networkplumber.org,
 dsahern@gmail.com, jonas.gorski@gmail.com, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue,  2 Sep 2025 06:47:38 +0000 you wrote:
> Add support for the actor_port_prio option for bond slaves.
> This per-port priority can be used by the bonding driver in ad_select to
> choose the higher-priority aggregator during failover.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v5: rename port in ad_select_tbl to actor_port_prio
> v4: no update
> v3: rename ad_actor_port_prio to actor_port_prio
> v2: no update
> 
> [...]

Here is the summary with links:
  - [PATCHv5,iproute2-next] iplink: bond_slave: add support for actor_port_prio
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=41b981c133a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



