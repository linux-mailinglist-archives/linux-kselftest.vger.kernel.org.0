Return-Path: <linux-kselftest+bounces-26506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B8A33A15
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 09:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB157166231
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C420C016;
	Thu, 13 Feb 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRc5W9mq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDED20C009;
	Thu, 13 Feb 2025 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435804; cv=none; b=VU9HhqIQ5jA3lzulC0VwfihacfVhclvYzL25La/F36/eeRiuPdxXABr3xJ6jKNMnWilWy8clHSLtJAfDjxlyWK19j6MOdLuQSEfGvwB9COMkE62tEOJQEcxqDtQgG7iNw/YxWmBmes9dVrh+EsHM4NT7YtVICRgvL3C0czRABf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435804; c=relaxed/simple;
	bh=tlbb2csC6KUltjhzwmihFO7uJRUrwtFdmIctqTsBzaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l45VPRlX95txOl+FT2KmkG2A0wY/yNp6szT81rIwP1JXGgO5dXKAYyr3exohHF23hNpH2L/IRc3d9OE9MVSkZge0WQ0kYjA5gLFc65adrXoFE8w7znzhfhNLaJ5j5mQD+7rTKdAp6Hvx/vFg/Wl97a1HrwMtFHsCu95dkXoZxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRc5W9mq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so6264055e9.3;
        Thu, 13 Feb 2025 00:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435800; x=1740040600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEMTU9K2wwIY9JpwBI5RzgY3pZNF2c520syU90CJZKI=;
        b=MRc5W9mq7XWPYx3SvFM8RXmtMCi5nLUksJm6GckYnj0La9E6L5SmbiryOTI23sZLdU
         JRQXsJ6eiwj//NUc8Bexv85DuSlwnG17mPZNszNDdRv3J7kVcg68z7v4W6dZe2xxMYUe
         Twhz+XKWat2E0PtD0mo6reNXQM1MTYhZl0heDlWxmuS82qxEFtCQzXpie5B73SSqnY7M
         kV+qpYi/W8dw3rzpZPSGZyhxT1HoVcxhGh566g/4VTh2HLfhtXX7+Qe6g4WOYl+utYTi
         /xma8sIfJM/Ddi90bD9WVLWxsH8CHA/td4JocfY5rXPAzFuF/pejagW/5kHhGEYrua+I
         AACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435800; x=1740040600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEMTU9K2wwIY9JpwBI5RzgY3pZNF2c520syU90CJZKI=;
        b=iPPEY9h+0YIZezivxrJqVmOtVoIw5FTm6jwMR4q6Qu8kkligFqywQu42pbwIiEOkZX
         9TN0QjcSV26ySNYg2b5V3ynQ6w2zC8jldw3OdLvc/QiduV2v/WPjPpGiKY4ieFR/YxFr
         PkLmUrJ82mBwi01csrlYsHbc3WQD1omAmeb5nhIvwqNbXtrwe9+QEm/VV7zroqcbyGxN
         xzoLGOEip0/Ai2g2M79gsHf4V4hijdNIeBlxzlfhV3s/U1klq/D/N4OjEMAziEL7gcmf
         JlIWejJF98HhyBg+VLk8Ae3Yk9vHhH+oaIbBvyv6gcF1cWyCNPCqjxDxKtpsnv0/QZ4H
         6fwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+wIowBfr3qjbkuz8Kmb9aWLmdwM4yMsfF7LTUMrHUlNr4EnmBvKj3fxUGYNJIk7AlM+zttNuAZrbealLX@vger.kernel.org, AJvYcCUMch1ljQ35l93tIgHe25aGnTxhYPgCqkjNW221j8OvhTD+UemLc8GPzyj30g8QVjmMvtMk1OUMm52Amg==@vger.kernel.org, AJvYcCVFKuBzyfZ7MtjVY1hy/dxh2cUXqnS7my9uWIckKoK2t+kraSLR71XUrwixM6S95PTDWnM=@vger.kernel.org, AJvYcCW17oWKOe+viGpgFzuvIUO4NBohO0ZN1VVPk7Y2ZucmGCm3dehBpE9r5b9rCtGBqNcX7X1Q+fVkRfxU/ddEQ8o=@vger.kernel.org, AJvYcCW8+Y2HC01snaCkJgKt0HwGGNmHJCXvX2q8pR0/r8aIM2mxSnDX5p+Dss9TZdlOlGGEGAqizn406Bc8Gt7FX4jL@vger.kernel.org, AJvYcCWSf+mqjjFEKQvOyiq1ePUjDc/8QZKJZhtvGVQiyu4k3qCBWm8lOhLtiVASetASM7WeqwGiR8OTt4s0@vger.kernel.org, AJvYcCWfc+qu7YXE0ND1JsNWYOEdD4ruraA/472XRI5P21yNrkL5/NbGUJLEQ+nrjHuLTlJ6mX17vRrIXJxlLw==@vger.kernel.org, AJvYcCXcMsnwFCTC0ceYpDTN6522B7X4CVzvHr9QrYanzYqFcGz6JIXuhECwNgkvuE7wCnfUL1dGAGtGI/m5@vger.kernel.org, AJvYcCXtDAt6bHPvZS5FI/RaIehcSg7us9kRVvIxlAgxdUnJ96TGqz7g1MlbrS7Y2qjrFKTLOKayMdyB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2PFhFSikg0y+oPiCjYhL3K3ermxR0+tm9qmI2smWdl498flf1
	wNOH3C2ee0qA3DB7S9V8+n32J+jXlKJ8q4t/ok3Hw7jgFSldqsJURkRNYXh5l8OZ2cS1W05fxrX
	4vaxYe00u3/pvRcTezVyUJxkRQag=
X-Gm-Gg: ASbGncvcV/qQ8bIfcb/ftwfvdhVmV6PRkHqg57nFt3b3Yu3tM9Hk5aWp4JVs2ufS1Iv
	t3MdSyR39YNiOJTyl1LXhJ+ummvh0kyVzCUIiIwhLR6FNpkNgOKBz9boIycJ5qErSuSRMFZc=
X-Google-Smtp-Source: AGHT+IEezeJ/RlI8/fvqsCpwdXF55uEWmtOYc3P4zBx3ojP1z2I7SGCdQ1/EUaOR3dd1EY2OITuGZF4nnmEaOHg8QZ0=
X-Received: by 2002:a05:600c:19c8:b0:439:55fc:81a9 with SMTP id
 5b1f17b1804b1-4395816f13dmr68016965e9.7.1739435800139; Thu, 13 Feb 2025
 00:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133002.883422-3-shaw.leon@gmail.com> <20250213065348.8507-1-kuniyu@amazon.com>
In-Reply-To: <20250213065348.8507-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:36:02 +0800
X-Gm-Features: AWEUYZncbGUNO7oNcYsuGlVcwlKbEKWZpPvVt5uCQTeloMATtiMLOZ95K2VoEX4
Message-ID: <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into struct
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

On Thu, Feb 13, 2025 at 2:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
[...]
> > diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
> > index 523025106a64..0f7281e3e448 100644
> > --- a/include/linux/if_macvlan.h
> > +++ b/include/linux/if_macvlan.h
> > @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct mac=
vlan_dev *vlan,
> >
> >  extern void macvlan_common_setup(struct net_device *dev);
> >
> > -extern int macvlan_common_newlink(struct net *src_net, struct net_devi=
ce *dev,
> > -                               struct nlattr *tb[], struct nlattr *dat=
a[],
> > +struct rtnl_newlink_params;
>
> You can just include <net/rtnetlink.h> and remove it from .c
> files, then this forward declaration will be unnecessary.

OK. Was not sure if it's desirable to include include/net files from
include/linux.

>
>
> > +
> > +extern int macvlan_common_newlink(struct net_device *dev,
> > +                               struct rtnl_newlink_params *params,
> >                                 struct netlink_ext_ack *extack);
> >
> >  extern void macvlan_dellink(struct net_device *dev, struct list_head *=
head);
>
>
> [...]
> > diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> > index bc0069a8b6ea..00c086ca0c11 100644
> > --- a/include/net/rtnetlink.h
> > +++ b/include/net/rtnetlink.h
> > @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsg=
hdr *nlh)
> >               return AF_UNSPEC;
> >  }
> >
> > +/**
> > + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink=
()
>
> The '\t' after '*' should be single '\s'.
>
> Same for lines below.
>

This is copied from other structs in the same file. Should I change it?

>
> > + *
> > + *   @net: Netns of interest
> > + *   @src_net: Source netns of rtnetlink socket
> > + *   @link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
> > + *   @peer_net: Peer netns
> > + *   @tb: IFLA_* attributes
> > + *   @data: IFLA_INFO_DATA attributes
> > + */
> > +struct rtnl_newlink_params {
>
> [...]
> > +/* Get effective link netns from newlink params. Generally, this is li=
nk_net
> > + * and falls back to src_net. But for compatibility, a driver may * ch=
oose to
> > + * use dev_net(dev) instead.
> > + */
> > +static inline struct net *rtnl_newlink_link_net(struct rtnl_newlink_pa=
rams *p)
> > +{
> > +     return p->link_net ? : p->src_net;
> > +}
> > +
> > +/* Get peer netns from newlink params. Fallback to link netns if peer =
netns is
> > + * not specified explicitly.
> > + */
> > +static inline struct net *rtnl_newlink_peer_net(struct rtnl_newlink_pa=
rams *p)
> > +{
> > +     return p->peer_net ? : rtnl_newlink_link_net(p);
> > +}
>
> These helpers should belong to patch 2 ?

I was trying to split API and driver changes. Can move this to
next patch if it's better.

