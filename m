Return-Path: <linux-kselftest+bounces-7668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A058A05C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 04:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1521C223B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B3633FE;
	Thu, 11 Apr 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upp2YEQF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC96217D;
	Thu, 11 Apr 2024 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802100; cv=none; b=I6LxsnhsmWOkGdBrG73rYJq2ByBoHrIdZik4HAkEbnebzdtzd8ahxJI0exCVw29o4uD4F6uHOg+Xp60Bdw5WBeVmBkvdd8E4FQSi6QaubCuM7yx5B9xgRu6b7Kg+iD4Aw4IjkNuf5j6aqu89ShdSWX2ccga2cquvTR5+ccy2vSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802100; c=relaxed/simple;
	bh=KD3rDXWHvk1CxdwHisdkYO4Vhfo45BdzIC+WxYtdhM8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=chtxbYS8rh23eT9nDXoWbtBIczO2Zd3hhoM7NS3quINqbxYPbZvol0uDD29xEaZajjO4F7gF14wdfPSgTR6EMPUdFYG0M9tysR0cbYDhneUGEy7rRhzhUPXHUcxyg8PbCr3Msqwm+is5c/s/Fb83nLo2JsTZCBK+276Pdewv6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Upp2YEQF; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a2a97c296so425856085a.2;
        Wed, 10 Apr 2024 19:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712802097; x=1713406897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmdPnOyH2qPhBHVtcKTf50Z6ubxOLyjpPuA4rsppEgc=;
        b=Upp2YEQFCi1dmWC7c6UqoCeRk7ZmaSfdzETjhAq2iXJM9TpGD2eqwikhtFdh5xV8gF
         u56wbaGAWaIZxdq+255pCAfmtLK3gA8vRqAhQ/iJkseLgEgu4jri2pwFNTCYFhvB6M40
         LBFbkctrWVu51eS9oDMd8dKa+GBhNnVnVbMevylct1AOQK7qxidhm6NrIM2yu7ofLKmk
         T2qIW8InUf6OX66jqj9G+3EWnM0runWB72amEQrxSkbaaeI3wgtn7FZuBrcf1B9lURv9
         xuTEg+b8WuU372K3bsCTIAQzQ7KJwrruv18wsprntRxsHTMVYKm+r+fYr7X6+ZTSJsiA
         zO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712802097; x=1713406897;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmdPnOyH2qPhBHVtcKTf50Z6ubxOLyjpPuA4rsppEgc=;
        b=Or9Yfdy1y2RxCDcnafmEnhXp3+sLu9irO+N/0BujXRpzulzvLSmT6fKgl0Pte6pAsm
         S1vuyK3c/wLGdwoD+Drdg8bUIUvEx7xdxWJq2QUsriyXj0XOt7jBt/dqNdsWu/+tDF9V
         CgYdRfQUhkygHbJHvsEz5YMQ4T5iAu3WqXrrAz/Fn2JCfZr5IzKRqOEs1U+0rpT23KE0
         NQkE7NqSrmrYdMlB9Qh8yVkEls0fhxkVG+dMgJVlbIVADiiwzWQUuRglfmZtpOXUx5bg
         DkmIBGqBlNpi/9nSmzdUYevCWjLxErJOXC5pZe2aijjVpLuOJpW/gRo9nAetnZZ5bQLe
         vV6A==
X-Forwarded-Encrypted: i=1; AJvYcCVSnNgv/qvuLkjbBU74WAV+WTmQQ+WL0TBHgu8DKDTtLRPNzAnAfimuyoizof43+606QzPzNiPe1pTLuVbP6L4jNx3hjLONlazFQrtZqZfXQTSey00Ro+Ml9SCQ4ifIr1s9OMQgxklI6Ocv+ujnFKbXh7vcGDjdubkpcpYAfromAvA9bu1a
X-Gm-Message-State: AOJu0YzlELDN4MgYcmdI+tuIVpgzO4aiObJGVEZSEd7PFYat393Y/iRa
	Z62eXGbcdb+4T/5n9eF1UBwbItI1wCGSajeqVr7GW28dHUPDsNvB
X-Google-Smtp-Source: AGHT+IGnPcYWlct4vY84EYxCwoBIu0Tj8/40/oeibhD1iwqZ0YOVZkuapO+eRRjhSno2rkz+Nv6l9g==
X-Received: by 2002:a05:620a:3951:b0:78a:40f0:3cad with SMTP id qs17-20020a05620a395100b0078a40f03cadmr6075758qkn.31.1712802097262;
        Wed, 10 Apr 2024 19:21:37 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id bk37-20020a05620a1a2500b0078d6b2b6fdbsm369629qkb.133.2024.04.10.19.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 19:21:36 -0700 (PDT)
Date: Wed, 10 Apr 2024 22:21:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 dsahern@kernel.org, 
 aduyck@mirantis.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <6617493095ee1_2d6bc6294fc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240410153423.107381-3-richardbgobert@gmail.com>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
 <20240410153423.107381-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v6 2/6] net: gro: add p_off param in
 *_gro_complete
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
> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
> complete phase of gro. The functions always return skb->network_header,
> which in the case of encapsulated packets at the gro complete phase, is
> always set to the innermost L3 of the packet. That means that calling
> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
> L3/L4 may return an unexpected value.
> 
> This incorrect usage leads to a bug in GRO's UDP socket lookup.
> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> *_hdr functions return network_header which will point to the innermost L3,
> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> encapsulated packets.
> 
> To fix this issue p_off param is used in *_gro_complete to pass off the
> offset of the previous layer.

What exactly does this mean?

This patch changes the definition of gro_complete to add a thoff
alongside the existing "nhoff"..

    > -     int                     (*gro_complete)(struct sk_buff *skb, int nhoff);
    > +     int                     (*gro_complete)(struct sk_buff *skb, int nhoff,
    > +                                             int thoff);

.. but also fixes up implementations to interpret the existing
argument as a thoff

    > -INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
    > +INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int nhoff,
    > +                                           int thoff)
    >  {
    > -     const struct iphdr *iph = ip_hdr(skb);
    > -     struct tcphdr *th = tcp_hdr(skb);
    > +     const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
    > +     struct tcphdr *th = (struct tcphdr *)(skb->data + thoff);

But in some cases the new argument is not nhoff but p_off, e.g.,

    >  static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
    > -                            int nhoff)
    > +                            int p_off, int nhoff)

Really, the argument is the start of the next header, each callback
just casts to its expected header (ethhdr, tcphdr, etc.)

The only place where we need to pass an extra argument is in udp,
because that needs a pointer to the network header right before the
transport header pointed to by nhoff.

And only due to possible IPv4 options or IPv6 extension headers, we
cannot just do

+        struct udphdr *iph = (struct iphdr *)(skb->data + nhoff - sizeof(*iph));
         struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);

I also do not immediately see an a way to avoid all the boilerplate
of a new argument in every callback. Aside from a per_cpu var -- but
that is excessive.

But it can just be left zero in all callsites, except for
inet_gro_complete/ipv6_gro_complete, which pass in nhoff.

> 
> Reproduction example:
> 
> Endpoint configuration example (fou + local address bind)
> 
>     # ip fou add port 6666 ipproto 4
>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
>     # ip link set tun1 up
>     # ip a add 1.1.1.2/24 dev tun1
> 
> Netperf TCP_STREAM result on net-next before patch is applied:
> 
> net-next main, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.28        2.37
> 
> net-next main, GRO disabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.01     2745.06
> 
> patch applied, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.01     2877.38
> 
> Fixes: 57c67ff4bd92 ("udp: additional GRO support")

This and the previous change should really target net, as they are
bug fixes.




