Return-Path: <linux-kselftest+bounces-3440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BAB839E43
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 02:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA191C28250
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2951381;
	Wed, 24 Jan 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqDlkBal"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A94137B;
	Wed, 24 Jan 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059830; cv=none; b=ejB+YyY4N4UjD+0bxcYPD4HfvZe1bWeqS/XgiRNKmZY+WwPLH2CKNc6nFAuk3PqOsHxs0BdpjLFAIhs9mFAW2tTusdpR1MdYpA/jNUOrOdLWesZl1Z9F91b+0CJb9BfRm+JNLCpeRUpHTWPdZmtF0e7/QYvxZMFaa3fll9F5i34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059830; c=relaxed/simple;
	bh=XnfFMjUV2XIQYfqtnGjkhhq/oEU0A9Q2Eg+Pte71IFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F89f3wjfXJkjWdHwEiVqQwroKyW3ttUTBc9oU8JaXAQ5UaCy0UPniVXiDDrqCYTJOCMpSZ72o+pDsX3cnBu32rSjo178YBzuOZt+MlkxT/HSLwzjTgpfIkaliCtJf8uv2Ed4r3yqrFP/o4NSLt3vpx5r+g5y4EzUn2ctSj12yrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqDlkBal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 758A5C433C7;
	Wed, 24 Jan 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706059830;
	bh=XnfFMjUV2XIQYfqtnGjkhhq/oEU0A9Q2Eg+Pte71IFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WqDlkBalHshnOmrcY6l20Tg6xvotN8GbLPj5IzqGL+yqA9XchW6MHQZd9I9Detc8m
	 dOYFLuK0/VYen/Ych0jUS6k1pD3Jt3S1R+hFCFXuHHSUT1nDzupn058DYcU9TlzLUP
	 pTvY7SIsZDSDhhJSX36GWr5iwaTszku8f4R0ad259MM99e6EWE21qRYxcP+ICJKkcM
	 qkJIJYkniGaSZkTfdTME0pgtCj3PaIpMT+N9ANNeqjU4lvEg9fhjMYCC0iNm+Y9WCO
	 SD/pXOvclEGmys0Jm1+5TD/u0vi4Etsqb1zfBaPgKJJDx6H4r2YyEw9FfWbfx6CWFY
	 zV5DVxkQFa0qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E555DFF760;
	Wed, 24 Jan 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: fill in some missing configs for net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605983038.14933.17102781859036984029.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 01:30:30 +0000
References: <20240122203528.672004-1-kuba@kernel.org>
In-Reply-To: <20240122203528.672004-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, razor@blackwall.org, idosch@nvidia.com,
 horms@kernel.org, jakub@cloudflare.com, kuniyu@amazon.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 12:35:28 -0800 you wrote:
> We are missing a lot of config options from net selftests,
> it seems:
> 
> tun/tap:     CONFIG_TUN, CONFIG_MACVLAN, CONFIG_MACVTAP
> fib_tests:   CONFIG_NET_SCH_FQ_CODEL
> l2tp:        CONFIG_L2TP, CONFIG_L2TP_V3, CONFIG_L2TP_IP, CONFIG_L2TP_ETH
> sctp-vrf:    CONFIG_INET_DIAG
> txtimestamp: CONFIG_NET_CLS_U32
> vxlan_mdb:   CONFIG_BRIDGE_VLAN_FILTERING
> gre_gso:     CONFIG_NET_IPGRE_DEMUX, CONFIG_IP_GRE, CONFIG_IPV6_GRE
> srv6_end_dt*_l3vpn:   CONFIG_IPV6_SEG6_LWTUNNEL
> ip_local_port_range:  CONFIG_MPTCP
> fib_test:    CONFIG_NET_CLS_BASIC
> rtnetlink:   CONFIG_MACSEC, CONFIG_NET_SCH_HTB, CONFIG_XFRM_INTERFACE
>              CONFIG_NET_IPGRE, CONFIG_BONDING
> fib_nexthops: CONFIG_MPLS, CONFIG_MPLS_ROUTING
> vxlan_mdb:   CONFIG_NET_ACT_GACT
> tls:         CONFIG_TLS, CONFIG_CRYPTO_CHACHA20POLY1305
> psample:     CONFIG_PSAMPLE
> fcnal:       CONFIG_TCP_MD5SIG
> 
> [...]

Here is the summary with links:
  - [net] selftests: fill in some missing configs for net
    https://git.kernel.org/netdev/net/c/04fe7c5029cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



