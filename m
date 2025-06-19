Return-Path: <linux-kselftest+bounces-35393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627CAE0FF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 01:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA6A5A26A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 23:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63C28DF44;
	Thu, 19 Jun 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alyKC85k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B028DF3B;
	Thu, 19 Jun 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375198; cv=none; b=pNqXI7XZvsptcI1VyYssz25hvgZ3EFYrLKN0JVdEnPLJyrHbKSLIIuskkGV5y8JzV/hyKT3O4EK9cwoWhnJlJo/L2m5UUHoCTYyXavSus4TsS4TWfXcUBIJ3aTDV1Ivx6cylPXuA6MTR6Q9Stwz1wbmDkmsIceW6oUmbTjqLAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375198; c=relaxed/simple;
	bh=vebIs/UoufwnNP8MVgPAlX9dhRYxs9Loe44ZLFLYVlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lTOdSrw24B8wyqOMRqaVoz8RjTVMLaAoxDwkD7gXFPAckRgUa1cd7y1Tga9mxIzf8bWurGVJeJ39D2fe2GKXGMWKFmlSV6m3ajoIFSct+fVzeG/+0k+t6hFz2oTFOqw3yrSxDfNVeUIy4Vo9qFT3lHY7yVdmw2xvI7os7wHsM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alyKC85k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D5AC4CEF0;
	Thu, 19 Jun 2025 23:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750375198;
	bh=vebIs/UoufwnNP8MVgPAlX9dhRYxs9Loe44ZLFLYVlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=alyKC85ku1caXXj/QcgvZixFReJHQFGjGyv6wv/H1yY58aa4yeFaHYU29EMIQQz/4
	 NHA30u/Zk7Wdm6wNHmSYJnXdCN87VIFlOwS8+YmUGR50D7OgtVhlHx2kyNVdkVTEyB
	 CbW/26D6kL1U7W1EdiJMwCwbh1yXpWKdTPgqhzxGOY60l64IFCqb3K8e1bjRnXpgZN
	 /teLssqz9wfWmWVJCHUAYka1mXujb2GFVqq8olYQ7K9K+9st1U4D3eNQ/0ZX5cuqfI
	 yqQboEu6818rZflq/crTGe4OqI88RriARiJLj3TPFm4+M3DaO9+2+rsagnCuJwUq8w
	 iZ6SEGaywy7ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5038111DD;
	Thu, 19 Jun 2025 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] netdevsim: implement RX statistics using
 NETDEV_PCPU_STAT_DSTATS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037522573.1016629.13558361368033224988.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 23:20:25 +0000
References: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
In-Reply-To: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, dw@davidwei.uk, shuah@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, gustavold@gmail.com, joe@dama.to

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 01:32:41 -0700 you wrote:
> The netdevsim driver previously lacked RX statistics support, which
> prevented its use with the GenerateTraffic() test framework, as this
> framework verifies traffic flow by checking RX byte counts.
> 
> This patch migrates netdevsim from its custom statistics collection to
> the NETDEV_PCPU_STAT_DSTATS framework, as suggested by Jakub. This
> change not only standardizes the statistics handling but also adds the
> necessary RX statistics support required by the test framework.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] netdevsim: migrate to dstats stats collection
    https://git.kernel.org/netdev/net-next/c/f9e2511d80c2
  - [net-next,v4,2/4] netdevsim: collect statistics at RX side
    https://git.kernel.org/netdev/net-next/c/788eb4de608b
  - [net-next,v4,3/4] net: add dev_dstats_rx_dropped_add() helper
    https://git.kernel.org/netdev/net-next/c/27480a7c8f02
  - [net-next,v4,4/4] netdevsim: account dropped packet length in stats on queue free
    https://git.kernel.org/netdev/net-next/c/2a68a22304f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



