Return-Path: <linux-kselftest+bounces-27252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF6AA40441
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 01:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D8719C2285
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088944644E;
	Sat, 22 Feb 2025 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ikt/RDOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB63597D;
	Sat, 22 Feb 2025 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184527; cv=none; b=tOkeKxJpNrSbiOqBJCaepOK6rvGTGv2swWaVhvt0BJnmOLjFIPA1xPxi/wRUAVRWdrQDRqsWnN/L6LL3v/NS6eBdxwL/vpJAIb2gcORbL8//DE4x8amDCWKa9dzdhwm9Ri1o5j1nIz8hboV5UlfnSBCKw9GpPv67A1ZKWHNW6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184527; c=relaxed/simple;
	bh=A/U7E1kvmOIAm34x3bsa6I7eO8q1nXzHWrVjh3Cd3qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXbhpC8vwLxNzBEbaEKc7yZyko/0mT/vcxzdKRU4gnc0t8vYoUlnPPUNTWpP6ad5ZnEGZTV5bfwGbOwaOzTeA0hU8lcV0VJQwiR0QClGUmXXHbzp8A33HvJyJK2fdes064LGrlNEj+b3rjGSNcRaYQQbaPgpPsvEUIAXNjcRSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ikt/RDOr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc1f410186so6683315a91.0;
        Fri, 21 Feb 2025 16:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740184525; x=1740789325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDsaJerQGd1Bqxw/Zj/tNEGHvZAzlmCa/b+i2T0mnRQ=;
        b=Ikt/RDOrk3tj+bW9QPpzcBr2sP7Yaza2h7KdmFCZMZlLvjiz6HOgJC8bIyZKxXssW8
         4L8nsyfeh7Uk0JR6yCcVa0BhxYbYoL4p+9GMvg9/hbtxWU6EdU2Srz/2aC1AVF0Xs1Bx
         KzkGhIMSd3HuNDa2shSKv8yQbrbOECvP0UjmkCY4EusCJRlFNuOf87Y5A/6poQmuTiNs
         p+b/R0mrQ46ynfx5jgJLLu425cwwV/FtcvSOjY19DTK7ylZaE45vjImrA0PaFFk1CrAw
         wkXXSXD7oGEIyAlHxaUSHFYw8jL/slpaDviBSRiVk+kVHPtpgm5TTFb1xPr0B3w0yf6f
         FHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740184525; x=1740789325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDsaJerQGd1Bqxw/Zj/tNEGHvZAzlmCa/b+i2T0mnRQ=;
        b=sL/MLJ6CrnWN3piWcbxfDOXoh61b+/tCxlDKd2JM2HXLnQiKqKbNsMWZwx2rhT5aaF
         VHdgCf48F6atamfzK1AHo9sVFLMPEHHoT1qMZyhFic34JLjeo8gwFRYl0xp+x2W36MSg
         QrRkf6sODt04n1zF2GaFq4uGYEcn/DbTl33Dd1m9ZFEX5rmw8g1rYjzIfksKty1qPDpa
         PjaaVRgPhmX6CNnY3tch8uv5P/mj75kNnYqHRCls4dDbsAMjFmWYeT46s48uTFw120iD
         xciqxtk7FPiJU3HXghdEc7k1texxWTQ2OsTvW8qY2pADxKwaTXa7orexpB2R6Bz/kgWI
         W0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ax7MQE7R7X+2jj1b1S0j+9sFhVJgq2oTg+hOk6asCiIofEKlKVxjp+uZl6vFAZ+gR31kYlcuGvup@vger.kernel.org, AJvYcCUgiTMa35bqPCAzX2rhFkeXsFWAhHGf6acPtc2j0uVWNZeQueJUDvi34XZHy/Id9/wE8fi01lZf4R5ihsdx@vger.kernel.org, AJvYcCWADHbZ6Rd3Y9RKERhCeWPZe4u9YkVhkr747ZodyAvHwL9dSKXAxpE9/JZanLw6UOs2GEk=@vger.kernel.org, AJvYcCWidF8JlXHNaOHNtkSdu9hmU35/VYebbvHQgvo+0O6//vLbj6ih8DngS1zH/DvfLeiPrPjeAannTlUsNAf0N52k@vger.kernel.org
X-Gm-Message-State: AOJu0YyHyKz/Z/prLr+eUtiOBdaob1gsGZUwqCTU+QRlJ/GgA4O5av+6
	DYWgDNAvLyg/g6ENLquQFaVGtG6fhdd52fw805ZcOEnkd06h6EY=
X-Gm-Gg: ASbGnct3qSWIpSCJlPBtAKuU+rgl75M1lqAvifw2o8F3/V6BO2NlXxSPdlufMTCPg88
	LOf1DcJPOwS/jjfRFWLoXl308UwRv5yX5DHuh8zYSdO+jh2O+Oo/b3B3j6/4L+XeN1kRZrHm1I3
	gA6n9y2QT1MSbvH8rBsz9USL15UtabltXLAawEG5TpP81ER+SyV63HyUx5TE0WlDBI2bfjk+EzU
	dm0XoJo20Km8A0I9p3vB4eQ3r/+7f/3+eEeZsUQRZ2l9OT/r7zADCaZv4Jg4iGAkbm9zxdQD4fO
	esosSUJbJQaueCXp/vI1HQQFiA==
X-Google-Smtp-Source: AGHT+IET/SzbSrTVKUnnK0GqjFXKwFRmQS4ofsUjliII251jmk4kh/bg7fWjJNmQshjMuEInDZQ6dw==
X-Received: by 2002:a17:90b:56cd:b0:2fa:22a2:26a3 with SMTP id 98e67ed59e1d1-2fce7ae91d9mr8697512a91.6.1740184525301;
        Fri, 21 Feb 2025 16:35:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb04c45dsm1987382a91.20.2025.02.21.16.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:35:24 -0800 (PST)
Date: Fri, 21 Feb 2025 16:35:24 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 6/9] net: enable driver support for netmem TX
Message-ID: <Z7kbzJSl_nNUoPnR@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-7-almasrymina@google.com>
 <Z7d-7P8kPthyr3bG@mini-arch>
 <CAHS8izO2PU-A9gQHkJpB=QkFkiKvVUNCm5Von5GFY+5qV5+Oog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO2PU-A9gQHkJpB=QkFkiKvVUNCm5Von5GFY+5qV5+Oog@mail.gmail.com>

On 02/21, Mina Almasry wrote:
> On Thu, Feb 20, 2025 at 11:13 AM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 02/20, Mina Almasry wrote:
> > > Drivers need to make sure not to pass netmem dma-addrs to the
> > > dma-mapping API in order to support netmem TX.
> > >
> > > Add helpers and netmem_dma_*() helpers that enables special handling of
> > > netmem dma-addrs that drivers can use.
> > >
> > > Document in netmem.rst what drivers need to do to support netmem TX.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > v4:
> > > - New patch
> > > ---
> > >  .../networking/net_cachelines/net_device.rst  |  1 +
> > >  Documentation/networking/netdev-features.rst  |  5 +++++
> > >  Documentation/networking/netmem.rst           | 14 +++++++++++--
> > >  include/linux/netdevice.h                     |  2 ++
> > >  include/net/netmem.h                          | 20 +++++++++++++++++++
> > >  5 files changed, 40 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> > > index 15e31ece675f..e3043b033647 100644
> > > --- a/Documentation/networking/net_cachelines/net_device.rst
> > > +++ b/Documentation/networking/net_cachelines/net_device.rst
> > > @@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
> > >  =================================== =========================== =================== =================== ===================================================================================
> > >  unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
> > >  unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
> > > +unsigned long:1                          netmem_tx:1;                read_mostly
> > >  char                                name[16]
> > >  struct netdev_name_node*            name_node
> > >  struct dev_ifalias*                 ifalias
> > > diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
> > > index 5014f7cc1398..02bd7536fc0c 100644
> > > --- a/Documentation/networking/netdev-features.rst
> > > +++ b/Documentation/networking/netdev-features.rst
> > > @@ -188,3 +188,8 @@ Redundancy) frames from one port to another in hardware.
> > >  This should be set for devices which duplicate outgoing HSR (High-availability
> > >  Seamless Redundancy) or PRP (Parallel Redundancy Protocol) tags automatically
> > >  frames in hardware.
> > > +
> > > +* netmem-tx
> > > +
> > > +This should be set for devices which support netmem TX. See
> > > +Documentation/networking/netmem.rst
> > > diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> > > index 7de21ddb5412..43054d44c407 100644
> > > --- a/Documentation/networking/netmem.rst
> > > +++ b/Documentation/networking/netmem.rst
> > > @@ -19,8 +19,8 @@ Benefits of Netmem :
> > >  * Simplified Development: Drivers interact with a consistent API,
> > >    regardless of the underlying memory implementation.
> > >
> > > -Driver Requirements
> > > -===================
> > > +Driver RX Requirements
> > > +======================
> > >
> > >  1. The driver must support page_pool.
> > >
> > > @@ -77,3 +77,13 @@ Driver Requirements
> > >     that purpose, but be mindful that some netmem types might have longer
> > >     circulation times, such as when userspace holds a reference in zerocopy
> > >     scenarios.
> > > +
> > > +Driver TX Requirements
> > > +======================
> > > +
> > > +1. Driver should use netmem_dma_unmap_page_attrs() in lieu of
> > > +   dma_unmap_page[_attrs](), and netmem_dma_unmap_addr_set() in lieu of
> > > +   dma_unmap_addr_set(). The netmem variants will handle netmems that should
> > > +   not be dma-unmapped by the driver, such as dma-buf netmems.
> >
> > Not all drivers use dma_unmap_addr_xxx APIs (looking at mlx5). Might
> > be worth mentioning that for the drivers managing the mappings
> > differently, care might be taken to not unmap netmems?
> >
> 
> Yes now that I take a closer look, it's poorly worded to imply the
> issue is limited to dma_unmap. I will reword to say that all
> dma_map*() APIs must be avoided, and we have helpers for
> dma_unmap_*(), and more helpers can be added if needed (similar to
> wording in the Driver RX requirements).
> 
> > > +2. Driver should declare support by setting `netdev->netmem_tx = true`
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index fccc03cd2164..d8cfd5d69ddf 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -1753,6 +1753,7 @@ enum netdev_reg_state {
> > >   *   @lltx:          device supports lockless Tx. Deprecated for real HW
> > >   *                   drivers. Mainly used by logical interfaces, such as
> > >   *                   bonding and tunnels
> > > + *   @netmem_tx:     device support netmem_tx.
> > >   *
> > >   *   @name:  This is the first field of the "visible" part of this structure
> > >   *           (i.e. as seen by users in the "Space.c" file).  It is the name
> > > @@ -2061,6 +2062,7 @@ struct net_device {
> > >       struct_group(priv_flags_fast,
> > >               unsigned long           priv_flags:32;
> > >               unsigned long           lltx:1;
> > > +             unsigned long           netmem_tx:1;
> > >       );
> > >       const struct net_device_ops *netdev_ops;
> > >       const struct header_ops *header_ops;
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index a2148ffb203d..1fb39ad63290 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -8,6 +8,7 @@
> > >  #ifndef _NET_NETMEM_H
> > >  #define _NET_NETMEM_H
> > >
> > > +#include <linux/dma-mapping.h>
> > >  #include <linux/mm.h>
> > >  #include <net/net_debug.h>
> > >
> > > @@ -267,4 +268,23 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
> > >  void get_netmem(netmem_ref netmem);
> > >  void put_netmem(netmem_ref netmem);
> > >
> >
> > [..]
> >
> > > +#define netmem_dma_unmap_addr_set(NETMEM, PTR, ADDR_NAME, VAL)   \
> > > +     do {                                                     \
> > > +             if (!netmem_is_net_iov(NETMEM))                  \
> > > +                     dma_unmap_addr_set(PTR, ADDR_NAME, VAL); \
> > > +             else                                             \
> > > +                     dma_unmap_addr_set(PTR, ADDR_NAME, 0);   \
> > > +     } while (0)
> >
> > Any reason not do to static inline instaed?
> 
> Because the args passed to dma_unmap_addr_set are quite unique,
> AFAICT. PTR is a pointer to any struct that has a field (anywhere)
> inside of it called ADDR_NAME, then dma_unmap_addr_set does something
> like:
> 
> PTR->ADDR_NAME = VAL;
> 
> A static inline needs well defined types, and I couldn't figure out
> how to do that (or if it is possible), so a macro it is I guess.
> 
> Where I could, I went with static inline.

Ah dma_unmap_addr_set itself is an ugly define :-( Makes sense.

