Return-Path: <linux-kselftest+bounces-9541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2D8BD3BC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4778F2853E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D315746C;
	Mon,  6 May 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfwxNr0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CB157463;
	Mon,  6 May 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016018; cv=none; b=gnBgBSvZEt7+OR72wdLT9X1WzVYufWeHpGBaBl9PzAicRUD6xuyHu+OEeQatEG3lyNdOHZVLfJzFs3umXeZLK2j/GndKqaRnbwTNLTJJbrtKeKsue/vi62rKUPbCoVJYiKIo6VjP+b99reUsYhP2vfoeCHYFXSyEth4JdPe/dOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016018; c=relaxed/simple;
	bh=zTR4Fx+0VuqaciyKhhBIeFfsOGSgd7NnE83iq5V1HY8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gDOC3M7Bxplk5x2HTmGR72CFBgs+HlIzKb2LSkbkAI15du4pzBjlFNUtJvpR18bpb8sOCWakKgZt5S0B9z9HF2UWPKELt85NBESLmkCAvXLRsnwIJbFLWm11dxCOrMc8LzvvVRukycRWhFhKA54wh0oEPIjEj1TfRc8t5e+HeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfwxNr0i; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7928d2a03e8so171664685a.2;
        Mon, 06 May 2024 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715016015; x=1715620815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0y+XnyAvMNLz7GBeXTnyBjUN7V568BYArXNaTPpjqk=;
        b=bfwxNr0ie7phfHeVvieJTXY40l2Irkism8J3ALFjV5WrR/exOV4Jv4nRQjLLpaLBZK
         2KmPFCLchroJghso6lEqKf0zUyyZXci/UhO58z2cCI8tw4Aneg7RTllqv1nfIf8OUu6Z
         NHFlRNeGg2jAZNpQH5VsfFpA8v8yr0GfqVHwrHDqr7ORdeSscEtOfdfo8BfyTWzpwQN/
         +6WTu+uFQEJNGIvM1qc+2Sbm9EH1jq8bZoN4O1qGtCxyp135hCG/otW4uZTiLW7dqExZ
         G3TnEnduE8RPUnMq2+deAlVg2YOlDSQmYR8u3AmmNHEMrl3iTZd3/Meno59cVJoqZsHR
         P5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016015; x=1715620815;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0y+XnyAvMNLz7GBeXTnyBjUN7V568BYArXNaTPpjqk=;
        b=btUmnJ9HtQ+qZCgzjQmZ5Ugds22sukZ1fjCWBGtEP7FrjNV4YEYOxMnCsdpkBMDP9y
         7j2veqpmtarD69jaY4vPhcxH5lApwSf7wisiotXyZkCuKTPcfozVGR0JFOL60R1F9fV1
         MdaOhayLumV88QfdOfCJ7jzD61RtUultoEARVDvlJkxIgGVXzyWBSABunp1ZxIqTtb21
         ldxpaDV9we0PCyIUQwgWWIJP6vTtzYmDQjqXIz6/iyAqqy8csC5fE+ArcV1pab30zDP1
         A9hJq2WxkPHyTmqmRdYYzd+E6uWdFEj3ZORs/KLlpVFpAnndw9UetnakAuVO+8LsoBEc
         M9xA==
X-Forwarded-Encrypted: i=1; AJvYcCURtBQWIVwJdW09FIKN1fPA6Y9ezwTyRqRVi6BgnUsdp9oL3MmTsPV2HNuXWaSj6DoiYhgQnxrsEDXA9tqFq0Bp4L9vJDCjDkegVUn7Az1D1lSyGQHuh2O/jOcp4K+cZ86Yyck1N2httNoBDdUZFFVRpXcYNa02hR/0b78wysqDYRcyBIi9
X-Gm-Message-State: AOJu0YwvZon4GpX5//KIus3k2PXfQX7U1iZSz4FPmJHTrlsy9cNjcbhy
	a5aC9BAsAAW8pnun7rbuFaMIre95iMZtJPyrXSru/YJPOqLR9kXW
X-Google-Smtp-Source: AGHT+IFvUdHjpr3BUQ8xBSgo+rN17aYkuc/zDYQVtz23p2qARAxsHGJL9+ZJ4GTwq2dY0hfaulgVgw==
X-Received: by 2002:a05:620a:4493:b0:792:8448:8cbd with SMTP id x19-20020a05620a449300b0079284488cbdmr10610327qkp.26.1715016015267;
        Mon, 06 May 2024 10:20:15 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a0bc600b0078ede411c92sm4068185qki.27.2024.05.06.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:20:14 -0700 (PDT)
Date: Mon, 06 May 2024 13:20:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 alobakin@pm.me, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 alexander.duyck@gmail.com
Message-ID: <6639114eab050_516de29444@willemb.c.googlers.com.notmuch>
In-Reply-To: <1ed21e6d-7cbc-43e3-8933-fc40562b70b2@gmail.com>
References: <20240506093550.128210-1-richardbgobert@gmail.com>
 <1ed21e6d-7cbc-43e3-8933-fc40562b70b2@gmail.com>
Subject: Re: [PATCH net-next v8 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
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
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used in
> all merging UDP and TCP flows.
> 
> These checks need to be done only once and only against the found p skb,
> since they only affect flush and not same_flow.
> 
> This patch leverages correct network header offsets from the cb for both
> outer and inner network headers - allowing these checks to be done only
> once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
> NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks are
> more declarative and contained in inet_gro_flush, thus removing the need
> for flush_id in napi_gro_cb.
> 
> This results in less parsing code for non-loop flush tests for TCP and UDP
> flows.
> 
> To make sure results are not within noise range - I've made netfilter drop
> all TCP packets, and measured CPU performance in GRO (in this case GRO is
> responsible for about 50% of the CPU utilization).
> 
> perf top while replaying 64 parallel IP/TCP streams merging in GRO:
> (gro_network_flush is compiled inline to tcp_gro_receive)
> net-next:
>         6.94% [kernel] [k] inet_gro_receive
>         3.02% [kernel] [k] tcp_gro_receive
> 
> patch applied:
>         4.27% [kernel] [k] tcp_gro_receive
>         4.22% [kernel] [k] inet_gro_receive
> 
> perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (same
> results for any encapsulation, in this case inet_gro_receive is top
> offender in net-next)
> net-next:
>         10.09% [kernel] [k] inet_gro_receive
>         2.08% [kernel] [k] tcp_gro_receive
> 
> patch applied:
>         6.97% [kernel] [k] inet_gro_receive
>         3.68% [kernel] [k] tcp_gro_receive

Thanks for getting the additional numbers. The savings are not huge.

But +1 on the change also because it simplifies this non-obvious
logic. It makes sense to separate flow matching and flush logic.

Btw please include Alexander Duyck in the Cc: of this series. 
> +static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
> +				 struct sk_buff *p, bool outer)
> +{
> +	const u32 id = ntohl(*(__be32 *)&iph->id);
> +	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
> +	const u16 flush_id = (id >> 16) - (id2 >> 16);
> +	const u16 count = NAPI_GRO_CB(p)->count;
> +	const u32 df = id & IP_DF;
> +	u32 is_atomic;
> +	int flush;
> +
> +	/* All fields must match except length and checksum. */
> +	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
> +
> +	if (outer && df)
> +		return flush;

Does the fixed id logic apply equally to inner and outer IPv4?

> +
> +	/* When we receive our second frame we can make a decision on if we
> +	 * continue this flow as an atomic flow with a fixed ID or if we use
> +	 * an incrementing ID.
> +	 */
> +	NAPI_GRO_CB(p)->is_atomic |= (count == 1 && df && flush_id == 0);
> +	is_atomic = (df && NAPI_GRO_CB(p)->is_atomic) - 1;
> +
> +	return flush | (flush_id ^ (count & is_atomic));

This is a good time to consider making this logical more obvious.

First off, the flush check can be part of the outer && df above, as
flush is not modified after.

Subjective, but I find the following more readable, and not worth
saving a few branches.

        if (count == 1 && df && !flush_id)
                NAPI_GRO_CB(p)->is_atomic = true;

	ip_fixedid_matches = NAPI_GRO_CB(p)->is_atomic ^ df;
	ipid_offset_matches = ipid_offset - count;

	return ip_fixedid_matches & ipid_offset_matches;

Have to be a bit careful about types. Have not checked that in detail.

And while nitpicking:
ipid_offset may be a more descriptive variable name than flush_id, and
ip_fixedid  than is_atomic. If changing those does not result in a lot
of code churn.

> +}
> +
> +static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
> +{
> +	/* <Version:4><Traffic_Class:8><Flow_Label:20> */
> +	__be32 first_word = *(__be32 *)iph ^ *(__be32 *)iph2;
> +
> +	/* Flush if Traffic Class fields are different. */
> +	return !!((first_word & htonl(0x0FF00000)) |
> +		(__force __be32)(iph->hop_limit ^ iph2->hop_limit));
> +}
> +
> +static inline int gro_network_flush(const void *th, const void *th2, struct sk_buff *p, int off)
> +{
> +	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;

Is this correct when udp_gro_complete clears this for tunnels?

> +	int flush = 0;
> +	int i;
> +
> +	for (i = 0; i <= encap_mark; i++) {
> +		const u16 diff = off - NAPI_GRO_CB(p)->network_offsets[i];
> +		const void *nh = th - diff;
> +		const void *nh2 = th2 - diff;
> +
> +		if (((struct iphdr *)nh)->version == 6)
> +			flush |= ipv6_gro_flush(nh, nh2);
> +		else
> +			flush |= inet_gro_flush(nh, nh2, p, i != encap_mark);
> +	}

Maybe slightly better for branch prediction, and more obvious, if
creating a helper function __gro_network_flush and calling

    __gro_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offsets[0])
    if (NAPI_GRO_CB(p)->encap_mark)
            __gro_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offsets[1])

> +
> +	return flush;
> +}
> +
>  int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
>  

