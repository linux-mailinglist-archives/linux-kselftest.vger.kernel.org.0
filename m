Return-Path: <linux-kselftest+bounces-48358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEDFCFB855
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 02:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E4493047107
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 01:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987920B810;
	Wed,  7 Jan 2026 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiKdoE/G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02C520297C;
	Wed,  7 Jan 2026 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747813; cv=none; b=t0kSEh9S5uvUItFGJDdIj0R3dvuVOsM3nyQFuLO99c55UVNgvNryaoSAFeGRTZf+m2O9hBD/5mYfydGRNGDen4iT6+23/X4AH4y2QQDqhUQxSKjJf+mYURnY/R68VPbhiB4y8Nme72AmtzUl6/F2cfQp15zbWIX+uxCneBEgQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747813; c=relaxed/simple;
	bh=BxBpuyB0UTB+GKjoQYki3lsncSyEqpYjFlZFsxN57TE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qbp7s6ezFrYuEN5V0GZrV6gmsSCejXAwIqTZNgbDHR8VTQn6UmWN90uMKpRXmvqT21KDs8adFGbnVwM9er1RKJzAysoYtAVdWgZT/Aj83xMxEshoFq7hdfVVr+kOS95uuKTZlH5A21NvkxxALq5R1E+7oq+3Yen8e/EfAJ4GZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiKdoE/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F50AC116C6;
	Wed,  7 Jan 2026 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767747813;
	bh=BxBpuyB0UTB+GKjoQYki3lsncSyEqpYjFlZFsxN57TE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hiKdoE/GJ3jr8IZWQUOijlnUhDhvc7FQhTVgUB1Hx8HSArbK/M9HG78hSO9bBpkb7
	 VGwgdAJTlgXsZE41osZBkG8BubRi8rPHQICeK5ZM3xCbjyzneVHEhXvv2cSsh1Hql7
	 IKClXLWwKtk80rKpR9+baxCHtsLil3yC65zHl0Xf90/kfcRjumAWIR83QqMY5EQgiD
	 MPMrK0DEsy4XWe+RqriUjA1A6jDaQxWLVpsfIlR5jCw06kIS4swHQN18mFs1VyHPnz
	 Y2jY2fSu4fPoVS3k1pGA5tq9/H9oJU2rTmdLTmEhPKqVr/xK6KuSn4hZJfzQuUa2xI
	 JnP2KLwwsDGUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BB82380CEF5;
	Wed,  7 Jan 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: hw-net: rss-input-xfrm: try to enable
 the
 xfrm at the start
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774761102.2183630.422567193178212909.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:00:11 +0000
References: <20260104184600.795280-1-kuba@kernel.org>
In-Reply-To: <20260104184600.795280-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 gal@nvidia.com, noren@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Jan 2026 10:46:00 -0800 you wrote:
> The test currently SKIPs if the symmetric RSS xfrm is not enabled
> by default. This leads to spurious SKIPs in the Intel CI reporting
> results to NIPA.
> 
> Testing on CX7:
> 
>  # ./drivers/net/hw/rss_input_xfrm.py
>   TAP version 13
>   1..2
>   ok 1 rss_input_xfrm.test_rss_input_xfrm_ipv4 # SKIP Test requires IPv4 connectivity
>   # Sym input xfrm already enabled: {'sym-or-xor'}
>   ok 2 rss_input_xfrm.test_rss_input_xfrm_ipv6
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: hw-net: rss-input-xfrm: try to enable the xfrm at the start
    https://git.kernel.org/netdev/net-next/c/c4df070a57de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



