Return-Path: <linux-kselftest+bounces-2446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F681E9F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 21:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4CA1F22A6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6BB23C6;
	Tue, 26 Dec 2023 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORjdSmL4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28B5C99;
	Tue, 26 Dec 2023 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f95d69115so37265766d6.1;
        Tue, 26 Dec 2023 12:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703622282; x=1704227082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl6Kuu/ALuZR/sdx4zNZvmQxUqB5ciNVSwHOslt17vE=;
        b=ORjdSmL43XZClASgLtZMN0DuvgM4vHVd/meaJ1jUD5NJKVQNkJK6M1POqc48HJdc9L
         GmEy0AEjhSGtQhetP/MYTEogyPJ7CZLEqmGB+432usd6/2U6+QWQhHbq3W7EZJyN5JKP
         +XUsBBhasTz7z4Sea6pkZv8DFsWtkPrDB2EDIXcx1EttE9bZ/fhMsscdkdq5ndwH2MXE
         Z5Sh4oND3aXH8EIVLDS3pkWpkgjEG5B+l808o7ifha6Cc98PUfZENQQGjjpD86pM5xHe
         h9tsmrgKgtJQCG85w1quqYY3Z/zS5X7dzuyrT5Rt7EgRlK59I8B7usT1Tw1cdoN89DSX
         DnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703622282; x=1704227082;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl6Kuu/ALuZR/sdx4zNZvmQxUqB5ciNVSwHOslt17vE=;
        b=F7+XXpcc7InlBllXWV0i1efEqeqyLiZUutLfRKc1awS0KkCL8iugNqDN5KgsL6TBZj
         rOWra/E1Ur8FGbx1Ju2XMrFc5WtbQpBwDLTNEJlDOw+0DJBCDN8vgpgvw+BWS6N78mu8
         TnRYxOe90JOn0OLi13TIp5OYGMIB8MwReLoUFwQnVKBMVbpAHF6mkw3D5rgx/FJWDWhj
         OQdWwpW3LFC6WoduNDftUBwzKuUZSUJP9dTCK6fEJF4Afa2PAnUBiGiokj/P71yKtuno
         00mYKijjeLU74Ffovel9pwKT0iJ0R0988ZdC2vE4CwOutfsZBqoPqu5JnC/9fup1V69H
         Zuug==
X-Gm-Message-State: AOJu0YyHgKEGEsS9FFrciBehIRVek1FV+tInuxcHh8iKZ2ijz7/DLSXG
	wlFOVh/BaTaOUARejg8bzWE=
X-Google-Smtp-Source: AGHT+IH72VShS62e4pXXAuWhXOUSygfdgQG//sat+7h0LKfG3WHIS8NctiXPO/L52z4PY9EtNV6siQ==
X-Received: by 2002:ad4:5f0d:0:b0:67f:65e1:fdd1 with SMTP id fo13-20020ad45f0d000000b0067f65e1fdd1mr12860190qvb.127.1703622282342;
        Tue, 26 Dec 2023 12:24:42 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id ec17-20020ad44e71000000b0067f90426698sm4230255qvb.23.2023.12.26.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:24:42 -0800 (PST)
Date: Tue, 26 Dec 2023 15:24:41 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <658b3689d3617_5c2a929422@willemb.c.googlers.com.notmuch>
In-Reply-To: <e8b01e54-b623-44ec-84d5-406ea3b0c80b@gmail.com>
References: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
 <e8b01e54-b623-44ec-84d5-406ea3b0c80b@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: gso: add HBH extension header offload
 support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> This commit adds net_offload to IPv6 Hop-by-Hop extension headers (as it
> is done for routing and dstopts) since it is supported in GSO and GRO.
> This allows to remove specific HBH conditionals in GSO and GRO when
> pulling and parsing an incoming packet.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  net/ipv6/exthdrs_offload.c | 11 +++++++++++
>  net/ipv6/ip6_offload.c     | 25 +++++++++++--------------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs_offload.c b/net/ipv6/exthdrs_offload.c
> index 06750d65d480..4c00398f4dca 100644
> --- a/net/ipv6/exthdrs_offload.c
> +++ b/net/ipv6/exthdrs_offload.c
> @@ -16,6 +16,10 @@ static const struct net_offload dstopt_offload = {
>  	.flags		=	INET6_PROTO_GSO_EXTHDR,
>  };
>  
> +static const struct net_offload hbh_offload = {
> +	.flags		=	INET6_PROTO_GSO_EXTHDR,
> +};
> +
>  int __init ipv6_exthdrs_offload_init(void)
>  {
>  	int ret;
> @@ -28,9 +32,16 @@ int __init ipv6_exthdrs_offload_init(void)
>  	if (ret)
>  		goto out_rt;
>  
> +	ret = inet6_add_offload(&hbh_offload, IPPROTO_HOPOPTS);
> +	if (ret)
> +		goto out_dstopts;
> +
>  out:
>  	return ret;
>  
> +out_dstopts:
> +	inet6_del_offload(&dstopt_offload, IPPROTO_DSTOPTS);
> +
>  out_rt:
>  	inet6_del_offload(&rthdr_offload, IPPROTO_ROUTING);
>  	goto out;
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index d6314287338d..0e0b5fed0995 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -45,15 +45,13 @@ static int ipv6_gso_pull_exthdrs(struct sk_buff *skb, int proto)
>  		struct ipv6_opt_hdr *opth;
>  		int len;
>  
> -		if (proto != NEXTHDR_HOP) {
> -			ops = rcu_dereference(inet6_offloads[proto]);
> +		ops = rcu_dereference(inet6_offloads[proto]);
>  
> -			if (unlikely(!ops))
> -				break;
> +		if (unlikely(!ops))
> +			break;
>  
> -			if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
> -				break;
> -		}
> +		if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
> +			break;
>  
>  		if (unlikely(!pskb_may_pull(skb, 8)))
>  			break;
> @@ -171,13 +169,12 @@ static int ipv6_exthdrs_len(struct ipv6hdr *iph,
>  
>  	proto = iph->nexthdr;
>  	for (;;) {
> -		if (proto != NEXTHDR_HOP) {
> -			*opps = rcu_dereference(inet6_offloads[proto]);
> -			if (unlikely(!(*opps)))
> -				break;
> -			if (!((*opps)->flags & INET6_PROTO_GSO_EXTHDR))
> -				break;
> -		}
> +		*opps = rcu_dereference(inet6_offloads[proto]);
> +		if (unlikely(!(*opps)))
> +			break;
> +		if (!((*opps)->flags & INET6_PROTO_GSO_EXTHDR))
> +			break;
> +
>  		opth = (void *)opth + optlen;
>  		optlen = ipv6_optlen(opth);
>  		len += optlen;
> -- 
> 2.36.1
> 



