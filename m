Return-Path: <linux-kselftest+bounces-27247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A1A403EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 01:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261101898E45
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A271804A;
	Sat, 22 Feb 2025 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgLMzxPG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21BA33FE
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Feb 2025 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183135; cv=none; b=LljrdFmvdBiXnfqqzAWVk9/9WPmEW+HMWiqGSyO3+s/MpTrr9mudoi09sb9Bnr5AQub/VEwFTxY2DCdcU98wp+DYYySuamYZgChL0+dPv4hV//EqZ+AyJU6Lk+jNXb+DGuo8btzCEuVxlh4ZsGPh5MecBXvHhlikntrCmBwPCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183135; c=relaxed/simple;
	bh=B1hwoRNB9HuzKa57LjzrK3wWUEjd8Av4gd//kmf+51k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oblVDniV8lATXnOAx+RxKly4MpBvxdhYK5KfITzOXggJuGvd1GuYamU1Wihh7aY1TQZ+6GG736fhYOZz2xV9+nz6QgxbGsM4qtVA55zEF7Fb37AoYfHCL3JHOnE0xUg8yXvtWC7NkIS1QKaXb3vpU9PQO1eBdpMn/TiUNt1kHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgLMzxPG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e0575f5bso59705ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 16:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740183132; x=1740787932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNhX55ca2mVeq83qzHMQskDLc21cDfCiisVHrc35vn0=;
        b=LgLMzxPGMmpNr9gY+nLHSQZCMGFXdYXrrj8/hg1izvLFnzwQy+sh20DoVGYfQGmGOZ
         HQhSC3WsPsDGYLmhWbkC4AVz//poDZvPRPF784uAGg8JtLp4Ro4nxrF40G1wMSYz0Som
         m3yK9WhedOtB5gXvO1HaPDMMsTSDy5JXCoY5rhOn5EyXzIZhUhhL8RWbxKKWj14n+O6b
         dqU2E9WSsGHMefFEtxVNEB9caCloJAauEOviuUjwWPwYRzN7ZbQMasNas+2pHhVtnDI5
         UeVIaFZ6Ybj8GW8GTjkAOJa+ltSEOjwQJfrHp9rEKG2pnmKIbetmbCcNJav8tClGHIfd
         69rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183132; x=1740787932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNhX55ca2mVeq83qzHMQskDLc21cDfCiisVHrc35vn0=;
        b=jMg/vJ15L25AZjnuSrXR/1Z5LA+7AQmjxhTNlql73hUVLGIsj/iezzHLzO4b0vrMuN
         L2PcSnyllAC2CK9J/nde35O99sASyB7vRuRFaJPHP9Cb1bji0uyW+ze3tAXFN4qGR/DU
         ponLvtnlrRcPBejQ/bw81GTxq+Fsyd8lFbndkBxz1kdaGe7hI69RsLzqqWoSQqZO2FFf
         wzC1O5/YSeTtrhttbE0nn+9Ihb9bZn1eXyFrHT6gTHuIQDb5VLtviWGDpUQ5xaT/rjYk
         TIhU+dUyqaLbWPPOaSfLocHU/O98QheCOhIDOFhPYYglRRm5miHp5jb+2JN59bFYJWo5
         JUGw==
X-Forwarded-Encrypted: i=1; AJvYcCW9SowoxvP2TMgxRqyyvWBww7FaywWGnghmAKVbHoiuhE0ZJkXNgwwz1FB7HdweA2Tep4jGYAf15/DyYr7bmz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWY8J5g6sVudI1dCzIpxz8WvMVu+FX4+KPBRbBrJLEqm/40Aiw
	4IUQV2ROAlcs8mppud8PzwYk/eIEysCNNTY0xS/cxZuKusrAaYWmlnLfHGpPpnRABz+cawG3Fo2
	OcggWC7mtG+DMgf2JsEzbICBbMK3neEEq7Doq
X-Gm-Gg: ASbGnct7sURxE8SaEYkAYByjySI4/3k9KG9a1MUuj0Ou30yZ8EP52iZdNU7Bh1DWbuE
	hpgKB0spICQJVWeTveqrFoxhrSvghJWUG5x5GVNNGj2LP9ztJRDTtm9clPIMd6KkDFFMpVZbl9K
	cW1MAz2dk=
X-Google-Smtp-Source: AGHT+IFxl0HV9bELtKW1Lxo/V9NemOF1k08SgzpnQLv2+EwTyeatCDUpFu0V4b2QrnCMZCrUA+AZK4dcUGvskrOyfBY=
X-Received: by 2002:a17:903:41c6:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-22258843c6emr451255ad.1.1740183131774; Fri, 21 Feb 2025
 16:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-7-almasrymina@google.com> <Z7d-7P8kPthyr3bG@mini-arch>
In-Reply-To: <Z7d-7P8kPthyr3bG@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Feb 2025 16:11:58 -0800
X-Gm-Features: AWEUYZlkYd93d0T228Zc61iCz21ScjCC0AyNSTtmFsAwe1lJgbPNMd4CVgia2uE
Message-ID: <CAHS8izO2PU-A9gQHkJpB=QkFkiKvVUNCm5Von5GFY+5qV5+Oog@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/9] net: enable driver support for netmem TX
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:13=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 02/20, Mina Almasry wrote:
> > Drivers need to make sure not to pass netmem dma-addrs to the
> > dma-mapping API in order to support netmem TX.
> >
> > Add helpers and netmem_dma_*() helpers that enables special handling of
> > netmem dma-addrs that drivers can use.
> >
> > Document in netmem.rst what drivers need to do to support netmem TX.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v4:
> > - New patch
> > ---
> >  .../networking/net_cachelines/net_device.rst  |  1 +
> >  Documentation/networking/netdev-features.rst  |  5 +++++
> >  Documentation/networking/netmem.rst           | 14 +++++++++++--
> >  include/linux/netdevice.h                     |  2 ++
> >  include/net/netmem.h                          | 20 +++++++++++++++++++
> >  5 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/networking/net_cachelines/net_device.rst b/D=
ocumentation/networking/net_cachelines/net_device.rst
> > index 15e31ece675f..e3043b033647 100644
> > --- a/Documentation/networking/net_cachelines/net_device.rst
> > +++ b/Documentation/networking/net_cachelines/net_device.rst
> > @@ -10,6 +10,7 @@ Type                                Name             =
           fastpath_tx_acce
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  unsigned_long:32                    priv_flags                  read_m=
ostly                             __dev_queue_xmit(tx)
> >  unsigned_long:1                     lltx                        read_m=
ostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLO=
CK(tx)
> > +unsigned long:1                          netmem_tx:1;                r=
ead_mostly
> >  char                                name[16]
> >  struct netdev_name_node*            name_node
> >  struct dev_ifalias*                 ifalias
> > diff --git a/Documentation/networking/netdev-features.rst b/Documentati=
on/networking/netdev-features.rst
> > index 5014f7cc1398..02bd7536fc0c 100644
> > --- a/Documentation/networking/netdev-features.rst
> > +++ b/Documentation/networking/netdev-features.rst
> > @@ -188,3 +188,8 @@ Redundancy) frames from one port to another in hard=
ware.
> >  This should be set for devices which duplicate outgoing HSR (High-avai=
lability
> >  Seamless Redundancy) or PRP (Parallel Redundancy Protocol) tags automa=
tically
> >  frames in hardware.
> > +
> > +* netmem-tx
> > +
> > +This should be set for devices which support netmem TX. See
> > +Documentation/networking/netmem.rst
> > diff --git a/Documentation/networking/netmem.rst b/Documentation/networ=
king/netmem.rst
> > index 7de21ddb5412..43054d44c407 100644
> > --- a/Documentation/networking/netmem.rst
> > +++ b/Documentation/networking/netmem.rst
> > @@ -19,8 +19,8 @@ Benefits of Netmem :
> >  * Simplified Development: Drivers interact with a consistent API,
> >    regardless of the underlying memory implementation.
> >
> > -Driver Requirements
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Driver RX Requirements
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  1. The driver must support page_pool.
> >
> > @@ -77,3 +77,13 @@ Driver Requirements
> >     that purpose, but be mindful that some netmem types might have long=
er
> >     circulation times, such as when userspace holds a reference in zero=
copy
> >     scenarios.
> > +
> > +Driver TX Requirements
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1. Driver should use netmem_dma_unmap_page_attrs() in lieu of
> > +   dma_unmap_page[_attrs](), and netmem_dma_unmap_addr_set() in lieu o=
f
> > +   dma_unmap_addr_set(). The netmem variants will handle netmems that =
should
> > +   not be dma-unmapped by the driver, such as dma-buf netmems.
>
> Not all drivers use dma_unmap_addr_xxx APIs (looking at mlx5). Might
> be worth mentioning that for the drivers managing the mappings
> differently, care might be taken to not unmap netmems?
>

Yes now that I take a closer look, it's poorly worded to imply the
issue is limited to dma_unmap. I will reword to say that all
dma_map*() APIs must be avoided, and we have helpers for
dma_unmap_*(), and more helpers can be added if needed (similar to
wording in the Driver RX requirements).

> > +2. Driver should declare support by setting `netdev->netmem_tx =3D tru=
e`
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index fccc03cd2164..d8cfd5d69ddf 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1753,6 +1753,7 @@ enum netdev_reg_state {
> >   *   @lltx:          device supports lockless Tx. Deprecated for real =
HW
> >   *                   drivers. Mainly used by logical interfaces, such =
as
> >   *                   bonding and tunnels
> > + *   @netmem_tx:     device support netmem_tx.
> >   *
> >   *   @name:  This is the first field of the "visible" part of this str=
ucture
> >   *           (i.e. as seen by users in the "Space.c" file).  It is the=
 name
> > @@ -2061,6 +2062,7 @@ struct net_device {
> >       struct_group(priv_flags_fast,
> >               unsigned long           priv_flags:32;
> >               unsigned long           lltx:1;
> > +             unsigned long           netmem_tx:1;
> >       );
> >       const struct net_device_ops *netdev_ops;
> >       const struct header_ops *header_ops;
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index a2148ffb203d..1fb39ad63290 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -8,6 +8,7 @@
> >  #ifndef _NET_NETMEM_H
> >  #define _NET_NETMEM_H
> >
> > +#include <linux/dma-mapping.h>
> >  #include <linux/mm.h>
> >  #include <net/net_debug.h>
> >
> > @@ -267,4 +268,23 @@ static inline unsigned long netmem_get_dma_addr(ne=
tmem_ref netmem)
> >  void get_netmem(netmem_ref netmem);
> >  void put_netmem(netmem_ref netmem);
> >
>
> [..]
>
> > +#define netmem_dma_unmap_addr_set(NETMEM, PTR, ADDR_NAME, VAL)   \
> > +     do {                                                     \
> > +             if (!netmem_is_net_iov(NETMEM))                  \
> > +                     dma_unmap_addr_set(PTR, ADDR_NAME, VAL); \
> > +             else                                             \
> > +                     dma_unmap_addr_set(PTR, ADDR_NAME, 0);   \
> > +     } while (0)
>
> Any reason not do to static inline instaed?

Because the args passed to dma_unmap_addr_set are quite unique,
AFAICT. PTR is a pointer to any struct that has a field (anywhere)
inside of it called ADDR_NAME, then dma_unmap_addr_set does something
like:

PTR->ADDR_NAME =3D VAL;

A static inline needs well defined types, and I couldn't figure out
how to do that (or if it is possible), so a macro it is I guess.

Where I could, I went with static inline.

--=20
Thanks,
Mina

