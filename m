Return-Path: <linux-kselftest+bounces-3412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FAD8390B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EFF1F22923
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB15F848;
	Tue, 23 Jan 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OpekmM8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84115F847
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018446; cv=none; b=KQN+p4BJwbQCKZOtCKSNs3JKGJR0l3PZhmwxOWQPi2Ix9dAh//gJF9/0j2OTE1oZDjvseK/wj9jUtNDQUSbRwZMeXiALm+7eFw8WqBWlSuGkkAARxe9GkP9Wag0bs1KJioHjO6Rmqek7aWRF0un9Q/xldLTpep2pSDUpUv53vSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018446; c=relaxed/simple;
	bh=HfTTP4HiHIHu/yGIr9ubM6o+VjSVWEcNiX9LA06o0qM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=DDOt8d1X9/SxRH9FBK2Cfxn1obE63cjs5rYCJOBPs+rqnD6mF+p1ooo8x+cRP9lhkWof89YQDGFpvU7jUJEI3XruiIuc4gJDetIyyuMG232d9gKFaewxd9ZMqB6BHJvSfPH7yojmYIIXfe9kCiEZbMZpFBxlH4Rz2k+bYSBmSps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OpekmM8y; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf0eba6a30so10379471fa.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706018443; x=1706623243; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=1KHCL2eWY+J5yaLVKaDnfM9HQAC/swZ3GAjvIgfyRfA=;
        b=OpekmM8yJrmumR72sJoOxHnlsfQPKWCin10Wy2REw9Z1Xn6Iw6QIRd0uEh7KvNwYAd
         u5NUGrM8Ts8ZsEXhCNNQ+X6/z54Vj7PwuqpJq07b6PSLLHMWM+mCqarnqtQgvDa5fgXf
         qjRjF3q3LixyATOlRT1uBgkqAUz89fZhOkFrcIXLoEqbLq3fY1kd3rQG5c8cW1N6F0F8
         95iCfSCDBEW5rBwn1560S3Q1wtkAksyUG7Sb7ZTd4jaWN/9K/e9y1Dr9i1vESDTa71Kf
         sEyKBSSCK9gKlorRVN4ux46xBvMGjffnnAnaD7bdkihFi+5qZRSrT23Z9NJDAZ2IhAny
         Qcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018443; x=1706623243;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KHCL2eWY+J5yaLVKaDnfM9HQAC/swZ3GAjvIgfyRfA=;
        b=aldAH3/+OGCW4COw7HuiY+kEqDHeAaI7bGujFFVoWmAi6JldC7XEUPwH8byLPCMzq8
         NdrI7VspMqUZqxM/GMqoNKprxy4bKwj6tucJRHimRfTJYGr4SQKUHhcllFgVBDoHn5T4
         9DZPfMeNt7NGEkTLhr0FLQY86dLTz1lr0As46qAU9EI8jEn9knCRAQj2j2sFXY0auz29
         F8nsMCFtUhiX+6xGo02ZtujXOhzkd5V8TRo2FeWIXgQ0s5nEA6AWLHQj8Rzbj0OvWN5u
         0iTPAFohblzo+VouZMwlsx2y+sd3H+HbzBM3fgwzofxAwTGGtQrXC/e3C0xxhTAo/yoU
         Z8kg==
X-Gm-Message-State: AOJu0Yy4IVuds/kghtutBdVWokWf8b3/s/RY1TLGroVcxnaTTU1qns+Y
	iGPSMKWQDROzisQDct1fRo/qpFWCoStn2Y7/UiUGXA5fV3aTZLQCdrEzESMfj90=
X-Google-Smtp-Source: AGHT+IHLSZ+f7GlY5ABTmNvEvaR9SxzepmPzhZW7LhBSj1vVxbHJE6a6+WytHsG73qmXIo1DQqPf0g==
X-Received: by 2002:a05:651c:1025:b0:2cf:e66:6408 with SMTP id w5-20020a05651c102500b002cf0e666408mr720855ljm.92.1706018442743;
        Tue, 23 Jan 2024 06:00:42 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1bb])
        by smtp.gmail.com with ESMTPSA id q25-20020a056402041900b0055c104274e7sm3347872edv.78.2024.01.23.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:00:42 -0800 (PST)
References: <20240122203528.672004-1-kuba@kernel.org>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, razor@blackwall.org,
 idosch@nvidia.com, horms@kernel.org, kuniyu@amazon.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: fill in some missing configs for net
Date: Tue, 23 Jan 2024 14:55:59 +0100
In-reply-to: <20240122203528.672004-1-kuba@kernel.org>
Message-ID: <878r4gtaif.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 22, 2024 at 12:35 PM -08, Jakub Kicinski wrote:
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
> Try to add them in a semi-alphabetical order.
>
> Fixes: 62199e3f1658 ("selftests: net: Add VXLAN MDB test")
> Fixes: c12e0d5f267d ("self-tests: introduce self-tests for RPS default mask")
> Fixes: ae5439658cce ("selftests/net: Cover the IP_LOCAL_PORT_RANGE socket option")

MPTCP coverage is a recent (Dec '23) addition. I must have missed it.

Fortunately we don't need to backport that far. Should be:

Fixes: 122db5e3634b ("selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE")

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> These are not all the options we're missing. Since the merge window
> is over I may not have the time to dig into it myself :(
>
> Adding Fixes tag for 3 semi-random commits which I think missed things.
> The full list would be very long.
>
> CC: shuah@kernel.org
> CC: razor@blackwall.org
> CC: idosch@nvidia.com
> CC: horms@kernel.org
> CC: jakub@cloudflare.com
> CC: kuniyu@amazon.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/config | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 8da562a9ae87..19ff75051660 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -1,5 +1,6 @@
>  CONFIG_USER_NS=y
>  CONFIG_NET_NS=y
> +CONFIG_BONDING=m
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_TEST_BPF=m
>  CONFIG_NUMA=y
> @@ -14,9 +15,13 @@ CONFIG_VETH=y
>  CONFIG_NET_IPVTI=y
>  CONFIG_IPV6_VTI=y
>  CONFIG_DUMMY=y
> +CONFIG_BRIDGE_VLAN_FILTERING=y
>  CONFIG_BRIDGE=y
> +CONFIG_CRYPTO_CHACHA20POLY1305=m
>  CONFIG_VLAN_8021Q=y
>  CONFIG_IFB=y
> +CONFIG_INET_DIAG=y
> +CONFIG_IP_GRE=m
>  CONFIG_NETFILTER=y
>  CONFIG_NETFILTER_ADVANCED=y
>  CONFIG_NF_CONNTRACK=m
> @@ -25,15 +30,36 @@ CONFIG_IP6_NF_IPTABLES=m
>  CONFIG_IP_NF_IPTABLES=m
>  CONFIG_IP6_NF_NAT=m
>  CONFIG_IP_NF_NAT=m
> +CONFIG_IPV6_GRE=m
> +CONFIG_IPV6_SEG6_LWTUNNEL=y
> +CONFIG_L2TP_ETH=m
> +CONFIG_L2TP_IP=m
> +CONFIG_L2TP=m
> +CONFIG_L2TP_V3=y
> +CONFIG_MACSEC=m
> +CONFIG_MACVLAN=y
> +CONFIG_MACVTAP=y
> +CONFIG_MPLS=y
> +CONFIG_MPTCP=y
>  CONFIG_NF_TABLES=m
>  CONFIG_NF_TABLES_IPV6=y
>  CONFIG_NF_TABLES_IPV4=y
>  CONFIG_NFT_NAT=m
> +CONFIG_NET_ACT_GACT=m
> +CONFIG_NET_CLS_BASIC=m
> +CONFIG_NET_CLS_U32=m
> +CONFIG_NET_IPGRE_DEMUX=m
> +CONFIG_NET_IPGRE=m
> +CONFIG_NET_SCH_FQ_CODEL=m
> +CONFIG_NET_SCH_HTB=m
>  CONFIG_NET_SCH_FQ=m
>  CONFIG_NET_SCH_ETF=m
>  CONFIG_NET_SCH_NETEM=y
> +CONFIG_PSAMPLE=m
> +CONFIG_TCP_MD5SIG=y
>  CONFIG_TEST_BLACKHOLE_DEV=m
>  CONFIG_KALLSYMS=y
> +CONFIG_TLS=m
>  CONFIG_TRACEPOINTS=y
>  CONFIG_NET_DROP_MONITOR=m
>  CONFIG_NETDEVSIM=m
> @@ -48,7 +74,9 @@ CONFIG_BAREUDP=m
>  CONFIG_IPV6_IOAM6_LWTUNNEL=y
>  CONFIG_CRYPTO_SM4_GENERIC=y
>  CONFIG_AMT=m
> +CONFIG_TUN=y
>  CONFIG_VXLAN=m
>  CONFIG_IP_SCTP=m
>  CONFIG_NETFILTER_XT_MATCH_POLICY=m
>  CONFIG_CRYPTO_ARIA=y
> +CONFIG_XFRM_INTERFACE=m


