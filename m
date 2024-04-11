Return-Path: <linux-kselftest+bounces-7714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFF8A1B75
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 19:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229D01C2090A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D0E86AD4;
	Thu, 11 Apr 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1+AS0AU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1E8626E;
	Thu, 11 Apr 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851341; cv=none; b=efueYSsl9XvyzsEwu9pVPA/cGyGtafWmHWhRLA0aq4oWxIOkarjZNA9kbyiGbQsjUqD72NRvZUsmkctZNsBy6Ksyhq2Dc5NGaVuoHqFm5L+/fS7ygk/TXIwYVfE+wqhXw2jMMM2NYtc6gVABYP+OEc2C+8p6cwzAePpCBcm7aMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851341; c=relaxed/simple;
	bh=kUEBF7CcpnWJcFQn84+a9EN2Ecvh6cmF+sHJDM4ps4w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eiasRexX+x1oQQJILa6IkDLntBjJ0NRoU7GSmgRudFXabGEMy/1g26oJbm684i6hUPIxTbFDXgMYAq65kQpLuitjvR4C7LiSbJWLPN18i2ZqkUmhVHZPD04wv8HA6CTz/M84P2uVzOspRcf/lBBRGWwSUSqDaoNKRwHXnq2+E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1+AS0AU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d543db3a4so353349885a.0;
        Thu, 11 Apr 2024 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712851338; x=1713456138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LJZphD0DVGbGRB4OxVsf9g+ACSEjuMO2pVQ4Cfg/fc=;
        b=m1+AS0AUCgrmATKR5EwFiu2Ij575CiMo5k9QQL7ItuRFeXc+P+n958gFv8yUoSz1OS
         iu2LTcmeM7y/jpWUtQiRU7FUmRoVniMK5dIZziJ0KbgJWhaOe7C1HxB2gukIvVIO94wJ
         YAyxA5b382QVb0cwPu51ywAUJEcHZH3Cb6Xc8g6emVgyfYxzAT9bOn8e3+f7wx3DOpsl
         9zbs57H1qFtFyWD4Yl5XL8lxGS1RHDe3Js4Qt8x5yiBGljquPy/fulsRQ8M/ZFL92LJR
         hG6m5JLg3IKYa9LCr21/XFP+2AhuHLaL7IsmD+178PMHjtIJTISn4txDyX8ePpbUMOf+
         zjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851338; x=1713456138;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1LJZphD0DVGbGRB4OxVsf9g+ACSEjuMO2pVQ4Cfg/fc=;
        b=EScTNFW0oaVTzwiEoajtd59a6Jwx/nTzzCX+pXBxq7Jkw+tJP3S9oPvZykpBcMUPYm
         bbwVNxuYZA5j2sU3HoJzHE6iTSgFv1EP7PFB2KYNtko5iUpwQq+tII9kXocsa7mfy8nv
         pWPjzYeqCMlDro493TdubO/jyLtVHTP0LhZiVCJZNgrqtcGSbSmVA3QyYydeJNLO7yEp
         DfXQ3zL2VRg6vkmLsLkKzlhufof0hX1UJbg1G9zf+vAaLSluFU0ikWpep/mvmqGryjVk
         vrFEasCy62x6vTFQ5jIV0baFnEdITNW0stxPWBCQTUGAPwjCzfzDVbbkv64tqDbvG3MC
         qOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg+9wwpvqvJ3ugBrqodzM7BUnynMBusAHyMCAM4M+ZQRfH/I319fgxzk8mNi9pBa2mWS+MEuC2+z74t5i/julbhHHHuErzQ7/lyRjdrgCVMQDbjyqmtl0qyM9i0AtMEdeV0lEtOLnvwNwE4h3Ua5umc8nG73xx/7nOiUnJwLzP1SuZzkGG
X-Gm-Message-State: AOJu0YxGn9+DdnahlMH4pXl/NmvOjgiUswl595TaJ1br3W8UUdvyPLTc
	movpWveVvK5Gwing8Dn5k12Lvxskw6GNp03sRtLPAc6Ww2ybwORS
X-Google-Smtp-Source: AGHT+IEk74XeANDVeWRZwZLjcTBczHLRj9jrY2LHneMNSaw8Ueb8qJAFam/uzy49fuZnfw/Q98cg0Q==
X-Received: by 2002:a05:620a:26a6:b0:78d:5d37:6823 with SMTP id c38-20020a05620a26a600b0078d5d376823mr49111qkp.55.1712851338192;
        Thu, 11 Apr 2024 09:02:18 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a080700b0078ec3aa9cc7sm850908qks.25.2024.04.11.09.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:02:17 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:02:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <661809892b2a_2f1f4c294a3@willemb.c.googlers.com.notmuch>
In-Reply-To: <66175ca5e3621_2dde6a2947c@willemb.c.googlers.com.notmuch>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
 <20240410153423.107381-3-richardbgobert@gmail.com>
 <6617493095ee1_2d6bc6294fc@willemb.c.googlers.com.notmuch>
 <66175ca5e3621_2dde6a2947c@willemb.c.googlers.com.notmuch>
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
> Willem de Bruijn wrote:
> > Richard Gobert wrote:
> > > Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
> > > additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
> > > complete phase of gro. The functions always return skb->network_header,
> > > which in the case of encapsulated packets at the gro complete phase, is
> > > always set to the innermost L3 of the packet. That means that calling
> > > {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> > > gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
> > > L3/L4 may return an unexpected value.
> > > 
> > > This incorrect usage leads to a bug in GRO's UDP socket lookup.
> > > udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> > > *_hdr functions return network_header which will point to the innermost L3,
> > > resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> > > encapsulated packets.
> > > 
> > > To fix this issue p_off param is used in *_gro_complete to pass off the
> > > offset of the previous layer.
> > 
> > What exactly does this mean?
> > 
> > This patch changes the definition of gro_complete to add a thoff
> > alongside the existing "nhoff"..
> > 
> >     > -     int                     (*gro_complete)(struct sk_buff *skb, int nhoff);
> >     > +     int                     (*gro_complete)(struct sk_buff *skb, int nhoff,
> >     > +                                             int thoff);
> > 
> > .. but also fixes up implementations to interpret the existing
> > argument as a thoff
> > 
> >     > -INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
> >     > +INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int nhoff,
> >     > +                                           int thoff)
> >     >  {
> >     > -     const struct iphdr *iph = ip_hdr(skb);
> >     > -     struct tcphdr *th = tcp_hdr(skb);
> >     > +     const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
> >     > +     struct tcphdr *th = (struct tcphdr *)(skb->data + thoff);
> > 
> > But in some cases the new argument is not nhoff but p_off, e.g.,
> > 
> >     >  static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
> >     > -                            int nhoff)
> >     > +                            int p_off, int nhoff)
> > 
> > Really, the argument is the start of the next header, each callback
> > just casts to its expected header (ethhdr, tcphdr, etc.)
> > 
> > The only place where we need to pass an extra argument is in udp,
> > because that needs a pointer to the network header right before the
> > transport header pointed to by nhoff.
> > 
> > And only due to possible IPv4 options or IPv6 extension headers, we
> > cannot just do
> > 
> > +        struct udphdr *iph = (struct iphdr *)(skb->data + nhoff - sizeof(*iph));
> >          struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
> > 
> > I also do not immediately see an a way to avoid all the boilerplate
> > of a new argument in every callback. Aside from a per_cpu var -- but
> > that is excessive.
> > 
> > But it can just be left zero in all callsites, except for
> > inet_gro_complete/ipv6_gro_complete, which pass in nhoff.
> 
> Actually, we can avoid the boilerplate changes that add an extra arg.
> 
> By changing the contract between network layer callbacks
> (inet_gro_complete/ipv6_gro_complete) and transport layer callbacks
> (tcp4_gro_complete et al).

Actually, only when calling udp4_gro_complete or udp6_gro_complete.

> It's also a bit of a hack. But a lot smaller patch, probably.

Feel free to disagree with this approach. Just a suggestion.

