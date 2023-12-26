Return-Path: <linux-kselftest+bounces-2448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C502881EA39
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 22:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EECA283232
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B2522A;
	Tue, 26 Dec 2023 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0qV7KFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004F5224;
	Tue, 26 Dec 2023 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f9f6163a1so24386206d6.1;
        Tue, 26 Dec 2023 13:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703627989; x=1704232789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OblgP4W4GkCiW7SIZrzViOqyCU7TP6eEbBjt7az5RUk=;
        b=V0qV7KFacFQXxh47eLgVK87fsyA5iXWO8XqrhacXk4WUIWmNYwmOiNBF6/bDXkV6np
         dovqDSFbdJtT7SJ2hiata+Lo4+vEfZCzNQzlLGIIIIczElIRFd6zltiq/1qbH2Ld9Twc
         RGJ08zy5SaUsMPWJxFoLuScdra9DVDCrkEMS7bkK+WNgRdFGGY5+B/Smang8cqDmNBWA
         mkG/ZikOioqabdR9iq8+yhW9ZQw3+PE/7NiKqHCmsBkvfVlIwMi7PWlohylsqBT1I36r
         q3hfEJqm5Bpr6j8Dqr6Sutfh40S/cINxFJcxFEy19dhh9sKQc5AXORyh/x9QYv4eV2bV
         5DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703627989; x=1704232789;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OblgP4W4GkCiW7SIZrzViOqyCU7TP6eEbBjt7az5RUk=;
        b=ps+BTe79EqxLTjdMvkpSwYtnOAn4yYJ2zcT0tZfOtTdorAVSP7l72Watf36So3ijlR
         rEpxvf+3HGGerQ8DDaDgnVfIL3iLWfLc0EnQsW52nS+vxYm8Rywmlr3NQlU9Bp9PG3GK
         ROghrzVXnhJa9e8M5si4E0NhUpsCJ6WUm42re4sczuVLfrG+GoMB+a+ttNvjlaFkLYZB
         76UH1au5K1bNqRhA838MGzfTW+iZyU0l3OTQIXfq4dskfhD76A5BFtPhaK8K3qVryuTd
         eokGYx4hDRoQmHXy/4HtgBQ4LIdkVbidN4FvAvzJQPKlQzzfijbpGYYNnFZ5kzd3P84i
         ixew==
X-Gm-Message-State: AOJu0YxG+bqBWg8dsb5XL+Y2orwJjNpI1OXrCOgsv8fTVOcRHB+zhn8z
	CPE8gVFPlbuGRbW7rj1SJxo=
X-Google-Smtp-Source: AGHT+IFnxbmUjuRx5kdS4z+tLhtW7m/pldsFaDbutGy4OdxI6KHX/ryN2maUaEvQ1lcuePJX0YVqxg==
X-Received: by 2002:a05:6214:14f4:b0:67f:a0a5:39f5 with SMTP id k20-20020a05621414f400b0067fa0a539f5mr6947083qvw.56.1703627988686;
        Tue, 26 Dec 2023 13:59:48 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id bj5-20020a05620a190500b0078118b6cd18sm4624088qkb.43.2023.12.26.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 13:59:48 -0800 (PST)
Date: Tue, 26 Dec 2023 16:59:48 -0500
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
Message-ID: <658b4cd4241c8_5c2a929499@willemb.c.googlers.com.notmuch>
In-Reply-To: <32febbc9-e603-4400-addd-bdb97ce56c1d@gmail.com>
References: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
 <32febbc9-e603-4400-addd-bdb97ce56c1d@gmail.com>
Subject: Re: [PATCH net-next 2/3] net: gro: parse ipv6 ext headers without
 frag0
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
> This commit utilizes a new helper function, ipv6_gro_pull_exthdrs, which
> is used in ipv6_gro_receive to pull ipv6 ext headers instead of
> ipv6_gso_pull_exthdrs. To use ipv6_gso_pull_exthdr, pskb_pull and
> __skb_push must be used, and frag0 must be invalidated. This commit
> removes unnecessary code around the call to ipv6_gso_pull_exthdrs and
> enables the frag0 fast path in IPv6 packets with ext headers.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index 0e0b5fed0995..a3b8d9127dbb 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -37,6 +37,40 @@
>  		INDIRECT_CALL_L4(cb, f2, f1, head, skb);	\
>  })
>  
> +static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
> +{
> +	const struct net_offload *ops = NULL;
> +	struct ipv6_opt_hdr *opth;
> +
> +	for (;;) {
> +		int len;
> +
> +		ops = rcu_dereference(inet6_offloads[proto]);
> +
> +		if (unlikely(!ops))
> +			break;
> +
> +		if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
> +			break;
> +
> +		opth = skb_gro_header(skb, off + 8, off);

When changing this code, it would be great to make it more self
documenting. It's not entirely clear what that 8 is based on.
sizeof(*opth) is only 2. Probably an optimization to handle the most
common extension headers in a single pskb_may_pull? If so, this new
code does not have that concern, so can just use sizeof(*opth). Or
else add a const int likely_max_opt_hdr_len = 8 or so.


> +		if (unlikely(!opth))
> +			break;
> +
> +		len = ipv6_optlen(opth);
> +
> +		opth = skb_gro_header(skb, off + len, off);
> +		if (unlikely(!opth))
> +			break;
> +		proto = opth->nexthdr;
> +
> +		off += len;
> +	}
> +
> +	skb_gro_pull(skb, off - skb_network_offset(skb));
> +	return proto;
> +}
> +
>  static int ipv6_gso_pull_exthdrs(struct sk_buff *skb, int proto)
>  {
>  	const struct net_offload *ops = NULL;
> @@ -203,28 +237,25 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>  		goto out;
>  
>  	skb_set_network_header(skb, off);
> -	skb_gro_pull(skb, sizeof(*iph));
> -	skb_set_transport_header(skb, skb_gro_offset(skb));
>  
> -	flush += ntohs(iph->payload_len) != skb_gro_len(skb);
> +	flush += ntohs(iph->payload_len) != skb->len - hlen;
>  
>  	proto = iph->nexthdr;
>  	ops = rcu_dereference(inet6_offloads[proto]);
>  	if (!ops || !ops->callbacks.gro_receive) {
> -		pskb_pull(skb, skb_gro_offset(skb));
> -		skb_gro_frag0_invalidate(skb);
> -		proto = ipv6_gso_pull_exthdrs(skb, proto);
> -		skb_gro_pull(skb, -skb_transport_offset(skb));
> -		skb_reset_transport_header(skb);
> -		__skb_push(skb, skb_gro_offset(skb));
> +		proto = ipv6_gro_pull_exthdrs(skb, hlen, proto);
>  
>  		ops = rcu_dereference(inet6_offloads[proto]);
>  		if (!ops || !ops->callbacks.gro_receive)
>  			goto out;
>  
> -		iph = ipv6_hdr(skb);
> +		iph = skb_gro_network_header(skb);
> +	} else {
> +		skb_gro_pull(skb, sizeof(*iph));
>  	}

This code is non-obvious and has proven fragile (57ea52a8651). Changes
are best as simple as they can be, with ample documentation. My
attempt, as arrived at during review:

The existing always pulls the IPv6 header and sets the transport
offset initially. Then optionally again pulls any extension headers
in ipv6_gso_pull_exthdrs and sets the transport offset again on
return from that call.

The new code adds a small optimization to only pull and set transport
offset once.

The existing code needs to set skb->data at the start of the first
extension header before calling ipv6_gso_pull_exthdrs, and must
disable the frag0 optimization because that function uses
pskb_may_pull/pskb_pull instead of skb_gro_ helpers. It sets the
GRO offset to the inner TCP header with skb_gro_pull and sets the
transport header. Then returns skb->data to its position before
this block.

The new code is much simpler: it does not have to modify skb->data,
as all operations are with skb_gro_ helpers.

Aside from the small comment above, and suggestion to include
something like this summary in the code and/or avoid the extra
optimization,

Reviewed-by: Willem de Bruijn <willemb@google.com>

>  
> +	skb_set_transport_header(skb, skb_gro_offset(skb));
> +
>  	NAPI_GRO_CB(skb)->proto = proto;
>  
>  	flush--;
> -- 
> 2.36.1
> 



