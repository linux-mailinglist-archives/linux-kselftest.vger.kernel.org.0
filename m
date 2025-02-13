Return-Path: <linux-kselftest+bounces-26512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14428A33BB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 10:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700B13A6619
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4120F09C;
	Thu, 13 Feb 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgv6vE5O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F001E2847;
	Thu, 13 Feb 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440573; cv=none; b=J5NZZd28TaBQFYOpjc7IETliVp74icp8HXKsiOwyFE0OuvHJ98uaKZK+WiOtDHY8jmXUIrC2lgH3NZisehKb/LUReCo4Wg8JPaWzCN55vSSgL0sLr/5E94R4ZJ6W9Tzq03923tgjZ32dlx8lytAUdNuxVdqBnmWFhQhtf0vBE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440573; c=relaxed/simple;
	bh=jA7SlTyYhz1+j8HlAbKGMC97RbplB7cAQ05gjyR9wTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljFqXsZBz/cCTXvyiELCRwK8Yn0EReMcoyN7t180HYamxX/vT5gWOq4RjoU1fRkopJ1nz6dLl9iHFWpoRj24quZLzMxTDM/knz14elGADkUeH92zbQJAAufL0KXGYSm6sBAVHCAG0iixTQSIOgHzqQZjssAP6X2E8IIju0+bN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgv6vE5O; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43946b5920cso4042075e9.1;
        Thu, 13 Feb 2025 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739440570; x=1740045370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VgtMhO6+jJX1RjKLdoncmTjEAD+6FhglRm1uezg6DA=;
        b=Hgv6vE5OsWur1EsBJTLkf5Yw349pSAE6Lp05HWKlRPG9+m+5WbsPo1CKJXvt/IGa/i
         xrpkiDUqstn2jgmm1AEfDcAf7auFjEvOOVHdf/N3ci2O4QZ7HtvIHt9DcxH39UkdqUHr
         DPGuIFrFPLJiZyz1b+1j9t7AAUFpYw4+Pt9so5H+Mf86NJ+TaqJ8ErEH4w6yLRtzW4mS
         FPABPpgYwymr/VpnDAXX8kN0uUdXvQ0sPHcd03M1dUoZ5M+aqGrB3wZptr/npYEAMUwA
         Yj8WLB9zzESuYDWXBahaBchabIyKp215y8uYPaKE7rIOZguBG5p/PngrPctt+k/IweJl
         VYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440570; x=1740045370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VgtMhO6+jJX1RjKLdoncmTjEAD+6FhglRm1uezg6DA=;
        b=qyEc0vfGeC0PcSiu83lNKFijhQbIXr4mp09nmXwlq/AS6u7hZcaKpltCzBfdB0xh72
         +xOVgjCBIxZRWkInHbvQ4J4kg7I/nzOQPGbtJB1T9HNYmwUJKO1pCI1qzvHqmSE2h1kB
         HAdvWkB3iNQ0kSc41L/2ZRAX6Hh+9L0UUVCEU9PRr6SpIMbF4XcsITyF+3H2BpL5glGx
         NrLN2LtS+RoB/J6mVO3y6dnB3TpAjOc88o+9064c4nQKqMfgw2oMO3NXU1Ql/foCALbC
         RWgCXRa05662Gc1XlAnrfd6seM/ShpO7iN/mrCpua3ObXcyriqtWbfFq9MkJr+7Rd/+h
         uivA==
X-Forwarded-Encrypted: i=1; AJvYcCU3tufqHBLGggpJeFu65M+QbZVD429u7flhjGSDj/85RnmuNFG1PQj0bCCQV8dIeXjsMIA1ZwlQ+HDBIA==@vger.kernel.org, AJvYcCUONQ7XX7uLvj48uVklyR+VJLpW4z2NQxK24HnrwFybQ3vvhS1e9zcghReuNKbF70OfdLEQW69W5yeK@vger.kernel.org, AJvYcCUf0wHUNrSkIC/xM0udslXpYo1J0xvgm7TV40ujYbdY4XqO9pBLvd11CAVReK3Hiu47+h4ZlvKdnffQ@vger.kernel.org, AJvYcCWL1nrIGCkCXkdQfkLa3BD/0SmQzsOGkzjyRWvIDsY1K1DSNoif/iA+lhsNSUYOVK8bMlO4kkplbS9jdQ==@vger.kernel.org, AJvYcCWd5CL/Ua/0CfWu9WdCQ+GDtCjaDkxOpMfSZl6OWziX5Tx+aLu//CQfsRZPyrg38SdajsrEwvxNL8+hPTvV8129@vger.kernel.org, AJvYcCWob7ogA+GYpPAPqUqbMYZUQly6RgXxaroCCdYzCdOzAvVC7Ney4aj+mOCbcfRpbunabcozjbsjxzeea7XSyHg=@vger.kernel.org, AJvYcCWp/m1hrbPiZpLaY9J8YODGgNBEa7rJ7badKg9j3GOGKug9YnFO6/kUyOqETE+9h2cNQn8sbBFg@vger.kernel.org, AJvYcCX6ica7pCcIoAR7FarPfjWHEm5Kz6oFBzcgU6ga3QWGYPKAXfFv11FSk1Kn7vqYF70bmdl+RLG+ft/FQ0Sc@vger.kernel.org, AJvYcCXMbL+LehLmsLp3NRaW043Xs6yfE5/fMWwln8WGm42ln44YrJwvqevLhVDjSjQzYM/O1kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhfnzbWv4146UK9fZoCbq12Ri4Lx21+M2E7M87d4axe6x976y5
	rhYXDi1WR04M9nGm5hEYx236T8+X1CAghHa7yTwaPpK+rRT7e6f0wiUsvNHKHrCnqrtV9tTChN0
	V66bsK3SpHhy5zQDoyxnhMdRa6PY=
X-Gm-Gg: ASbGncvhpXdXkmbRtpGTViKawpv8rCyIEZNt++CLA7mIvgMongPg4qNIIgyc/3SoNWs
	JZX1CQnHTuLdJMNRAR8Vy45SiqsnMGtk+p8XELQJHfwpWcF3dPLDF39MsnrX2ObPy7K49EGM=
X-Google-Smtp-Source: AGHT+IF4vz9ZMNWiLlURtMBrw7f64+VQaaApf4FQsQ85yq8rGSoIhlhaKmw+1l1LVh0uOeuQn3pwG9KU0hl60Rc/heo=
X-Received: by 2002:a5d:5889:0:b0:38f:24f9:8bac with SMTP id
 ffacd0b85a97d-38f24f9912fmr1885857f8f.23.1739440569419; Thu, 13 Feb 2025
 01:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133002.883422-7-shaw.leon@gmail.com> <20250213070533.9926-1-kuniyu@amazon.com>
 <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
In-Reply-To: <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 17:55:32 +0800
X-Gm-Features: AWEUYZkW9l6r7KSPGBGbQx_PCRCw6eQRHHUgG_KYRCauok2SpPFULcU0b728Vqw
Message-ID: <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/11] net: ipv6: Use link netns in newlink()
 of rtnl_link_ops
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev, 
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org, 
	stefan@datenfreihafen.org, steffen.klassert@secunet.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 4:37=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> wr=
ote:
>
> On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
> >
> [...]
> > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > index 863852abe8ea..108600dc716f 100644
> > > --- a/net/ipv6/ip6_gre.c
> > > +++ b/net/ipv6/ip6_gre.c
> > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net=
_device *dev)
> > >       tunnel =3D netdev_priv(dev);
> > >
> > >       tunnel->dev =3D dev;
> > > -     tunnel->net =3D dev_net(dev);
> > > +     if (!tunnel->net)
> > > +             tunnel->net =3D dev_net(dev);
> >
> > Same question as patch 5 for here and other parts.
> > Do we need this check and assignment ?
> >
> > ip6gre_newlink_common
> > -> nt->net =3D dev_net(dev)
> > -> register_netdevice
> >   -> ndo_init / ip6gre_tunnel_init()
> >     -> ip6gre_tunnel_init_common
> >       -> tunnel->net =3D dev_net(dev)
>
> Will remove this line.

However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
tunnel->net =3D=3D NULL here. Take ip6_tunnel for example:

ip6_tnl_init_net()
    -> ip6_fb_tnl_dev_init()
    -> register_netdev()
        -> register_netdevice()
            -> ip6_tnl_dev_init()

This code path (including ip6_fb_tnl_dev_init()) doesn't set
tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.

