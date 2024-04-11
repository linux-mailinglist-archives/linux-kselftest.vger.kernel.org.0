Return-Path: <linux-kselftest+bounces-7670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFDD8A06E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 05:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D885A284352
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8F413BAE3;
	Thu, 11 Apr 2024 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtM/QZBe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B252629C;
	Thu, 11 Apr 2024 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712807080; cv=none; b=r3/hmYInA7FIPjJaYL1dReTZSvaCVIYPZQ5u5C0qKegULH7cVMYaFe4qCEFmFnMUiF60yYblzRf+hfTI4O0+kPAkUrHevREeM7L+PsUwML1hCBPLwJdZS+cRzCQgAWxpRB6gDLeBu5hwST+7GlZs94YrmweqKx/LqQSPykLVZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712807080; c=relaxed/simple;
	bh=4EdgFjnPVt0AqnOMX6obmaUYeHbpAimK73X4vdQVn54=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HsZQ5+mk8eGvPNaYH6u6FkID2BO7SnKI1T9CUmGpGU+Fg6Pvx+sJo6VOAV1dTDLE/kl52F0+9ogkkttOoyjrB/7WrV2X1szdyP6f35IYCcrMhFKvuFbgC4zFCHrP1vHkuHPzWHU1LSSvi9oq5Vw9EzlY/X0jaogawmqWRRXogyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtM/QZBe; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479cbfc62e9so2203491137.0;
        Wed, 10 Apr 2024 20:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712807078; x=1713411878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4mBwnW823TZuDVksWLosgM7erJBTdnXQcLXGCSz0Ak=;
        b=UtM/QZBe85Zg76PdH1bbWd5kkC8K7QFToyPbtR8kkUBPbSldJuZUpc078tZdiVekjQ
         vPI0/YrfX793QR7ZSdRqMfZxhm32jShSidIYFmfaYqm3jhwbtth6nR9aUF7V6/WE1WYG
         7YLMM9rxUtQc5mOmBF+lScZi63uI9ECjOnaOKnsj4boDUskNPUIym9ntFf1tERne+7Xy
         NWmS5juSjiH4flQpWWYqLJa4AnxeCol0xtCF0j9VaIdSbKFpZROW+lOH1TnREqiCetNV
         KPeQz7YH0XdyRWdWnYC1MvtS1WsQLCprSiUzqXbSEBU1YScZiF3pEewccwHqSh+3Bhvs
         3UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712807078; x=1713411878;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s4mBwnW823TZuDVksWLosgM7erJBTdnXQcLXGCSz0Ak=;
        b=vSZB7I5XK3AbcECdIKHHKdeXTo/4Ms/SEHsrQnqB3ybl1IOpgdDEVaeb7tDNqJCysm
         E0RabrcdqQGLVuTZQGRJc1Y8zZ9Im7Ah2yu3mZ/gJ+NjZzSE/yGilzCxxqgqUvRbUT5E
         fYbrRr/zvvCfKrmCBJjYz2w2ooiNm/LHlrwGVVhPDmqX1nI34Iy0LH1l8eeubRkaWsg1
         fzAmAA9b/jvKM3j2Sr0s9PoADawj4tPNkdtKm8eG0SxSsJURWsg2KAFZYUm8MtLJjdri
         MXKkdemRstTj7WD5s85IDcFMuwuU00fyy5Y/wrlDjVnDziBEFvzNoVQIwXDVHioB5Iyr
         mECw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Xrbhol6o6Wsq3IbREajWyjkA3HePMhqxQPvCak374YW9gQ1L7MtQPPoahX/QVW8VymbjaEKjTlpaYpiDP4POqalrZ8bASDmKYWetOsrnZC9tu0R+c1KdETM6/ocDvbTSL3Sj19nmOk6166YiMUhhKwXm92gCdFMCMX8gAQg6ocVMUvCh
X-Gm-Message-State: AOJu0Yx17zMRY1l0hcn/FlN30y7XzvOiQTvdQWSyv2DywlB5VVeD1N3t
	d9iH/enTPNRwVesgAo0vsv2fraT8tkFFmc5mO/UuFVrdpfDDKNWw
X-Google-Smtp-Source: AGHT+IFckMWU8asZlpol2UkeUkPVYl0ylGfdLJFoqv0bxQpg0yfK0SJxv39TvrGZFaeIgXQKUTVw+w==
X-Received: by 2002:a05:6102:4746:b0:479:fd28:6d37 with SMTP id ej6-20020a056102474600b00479fd286d37mr4211250vsb.20.1712807078365;
        Wed, 10 Apr 2024 20:44:38 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id p1-20020a05620a22e100b0078d752367e9sm450364qki.79.2024.04.10.20.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 20:44:38 -0700 (PDT)
Date: Wed, 10 Apr 2024 23:44:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Richard Gobert <richardbgobert@gmail.com>, 
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
Message-ID: <66175ca5e3621_2dde6a2947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <6617493095ee1_2d6bc6294fc@willemb.c.googlers.com.notmuch>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
 <20240410153423.107381-3-richardbgobert@gmail.com>
 <6617493095ee1_2d6bc6294fc@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Richard Gobert wrote:
> > Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
> > additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
> > complete phase of gro. The functions always return skb->network_header,
> > which in the case of encapsulated packets at the gro complete phase, is
> > always set to the innermost L3 of the packet. That means that calling
> > {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> > gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
> > L3/L4 may return an unexpected value.
> > 
> > This incorrect usage leads to a bug in GRO's UDP socket lookup.
> > udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> > *_hdr functions return network_header which will point to the innermost L3,
> > resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> > encapsulated packets.
> > 
> > To fix this issue p_off param is used in *_gro_complete to pass off the
> > offset of the previous layer.
> 
> What exactly does this mean?
> 
> This patch changes the definition of gro_complete to add a thoff
> alongside the existing "nhoff"..
> 
>     > -     int                     (*gro_complete)(struct sk_buff *skb, int nhoff);
>     > +     int                     (*gro_complete)(struct sk_buff *skb, int nhoff,
>     > +                                             int thoff);
> 
> .. but also fixes up implementations to interpret the existing
> argument as a thoff
> 
>     > -INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>     > +INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int nhoff,
>     > +                                           int thoff)
>     >  {
>     > -     const struct iphdr *iph = ip_hdr(skb);
>     > -     struct tcphdr *th = tcp_hdr(skb);
>     > +     const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
>     > +     struct tcphdr *th = (struct tcphdr *)(skb->data + thoff);
> 
> But in some cases the new argument is not nhoff but p_off, e.g.,
> 
>     >  static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
>     > -                            int nhoff)
>     > +                            int p_off, int nhoff)
> 
> Really, the argument is the start of the next header, each callback
> just casts to its expected header (ethhdr, tcphdr, etc.)
> 
> The only place where we need to pass an extra argument is in udp,
> because that needs a pointer to the network header right before the
> transport header pointed to by nhoff.
> 
> And only due to possible IPv4 options or IPv6 extension headers, we
> cannot just do
> 
> +        struct udphdr *iph = (struct iphdr *)(skb->data + nhoff - sizeof(*iph));
>          struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
> 
> I also do not immediately see an a way to avoid all the boilerplate
> of a new argument in every callback. Aside from a per_cpu var -- but
> that is excessive.
> 
> But it can just be left zero in all callsites, except for
> inet_gro_complete/ipv6_gro_complete, which pass in nhoff.

Actually, we can avoid the boilerplate changes that add an extra arg.

By changing the contract between network layer callbacks
(inet_gro_complete/ipv6_gro_complete) and transport layer callbacks
(tcp4_gro_complete et al).

If the first pass their own unmodified offset, nhoff:

        err = INDIRECT_CALL_2(ops->callbacks.gro_complete,
                              tcp4_gro_complete, udp4_gro_complete,
-                             skb, nhoff + sizeof(*iph));
+                             skb, nhoff);

And the latter parse the network header for total_len/payload_len, to
find their original offset.

It's also a bit of a hack. But a lot smaller patch, probably.

