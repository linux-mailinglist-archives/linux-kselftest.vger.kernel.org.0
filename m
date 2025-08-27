Return-Path: <linux-kselftest+bounces-40020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8BEB37663
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 03:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC11204295
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF491EB9E3;
	Wed, 27 Aug 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3ONXkFE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1423595C;
	Wed, 27 Aug 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256421; cv=none; b=MssUvpRNFFC2eI0kn55jPbEQuhGUNPg6XUDR1Dzd74NSDm/0U9j8q7ILMzDzjzotID5Baq5bC0fPeUr2jVhPM1ilwAWDgSeCr2It8Zwdgo52Qvie1l79PPj11TwHgDShVjNKHNGZqof5bz2ddxcqc8GeM59fnYLMFjzz2CBZIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256421; c=relaxed/simple;
	bh=Qb0Bn6XOd6kOJUcc0HaKqexJdc+0YjozBiZtiT/nIlw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ESad0wj4Qc7ZGGZc4k1MhCCLqrSU3o/KZAKc59jWJUqJmghCVJTvhgU4VQfbF47uoZSioVrO5e6OFDm+EqnAHoQUQDd2fDQpaGsBjKKuKzKnw5Nc07UfjkSu+uZ0XOY9n1oXlye6N0cRpucwpl32XCWv3JRVmB0n97LxNg6kqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3ONXkFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8842C4CEF1;
	Wed, 27 Aug 2025 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756256420;
	bh=Qb0Bn6XOd6kOJUcc0HaKqexJdc+0YjozBiZtiT/nIlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c3ONXkFEaLLe35SdcifFyxf+BbiwGZz1ONX7WISfe6qkcB0QzAhHe6yV++szA7s1Q
	 Mc772RnRopgA2aghhQGN+rWf1DJhM4W3OHg5lplipSep0xdBkzL61TE0/2gltqlPKR
	 VBUeukasPgc1p1e9XEWXJeNwPbA0AooXr1zdQg2Zi4Vhwrz0ERKpV/Vylye4C9VxlT
	 vayeDO1pwbX+03dzQE+FFJUEXZjK9IMG6gwozk2dCbapSFHvyh4FyxR4IoQYkc2327
	 bgHRhcEWYFy0R+IpuWxC/0EtlinAJocqbGi2wpf+3KWtnM2XG6QYrgU031TCF9mcoP
	 bOeMs2ZX3DJHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F22383BF70;
	Wed, 27 Aug 2025 01:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] selftests: drv-net: ncdevmem: fix error
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625642798.155051.9564153907183706947.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 01:00:27 +0000
References: <20250825180447.2252977-1-kuba@kernel.org>
In-Reply-To: <20250825180447.2252977-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 almasrymina@google.com, sdf@fomichev.me, joe@dama.to,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 11:04:42 -0700 you wrote:
> Make ncdevmem clean up after itself. While at it make sure it sets
> HDS threshold to 0 automatically.
> 
> v2: rework patch 4 into separate patches 4 and 5
> v1: https://lore.kernel.org/20250822200052.1675613-1-kuba@kernel.org
> 
> Jakub Kicinski (5):
>   selftests: drv-net: ncdevmem: remove use of error()
>   selftests: drv-net: ncdevmem: save IDs of flow rules we added
>   selftests: drv-net: ncdevmem: restore old channel config
>   selftests: drv-net: ncdevmem: restore original HDS setting before
>     exiting
>   selftests: drv-net: ncdevmem: explicitly set HDS threshold to 0
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] selftests: drv-net: ncdevmem: remove use of error()
    https://git.kernel.org/netdev/net-next/c/6925f6171439
  - [net-next,v2,2/5] selftests: drv-net: ncdevmem: save IDs of flow rules we added
    https://git.kernel.org/netdev/net-next/c/6d04b36c73fd
  - [net-next,v2,3/5] selftests: drv-net: ncdevmem: restore old channel config
    https://git.kernel.org/netdev/net-next/c/b9f4f9529828
  - [net-next,v2,4/5] selftests: drv-net: ncdevmem: restore original HDS setting before exiting
    https://git.kernel.org/netdev/net-next/c/6351fadbd5bb
  - [net-next,v2,5/5] selftests: drv-net: ncdevmem: explicitly set HDS threshold to 0
    https://git.kernel.org/netdev/net-next/c/a9d533fbba0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



