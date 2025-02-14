Return-Path: <linux-kselftest+bounces-26643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8B8A35A2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 10:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC5516F0E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 09:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9F23A9AC;
	Fri, 14 Feb 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMRAt9LF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFB22D799;
	Fri, 14 Feb 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524989; cv=none; b=Eaz1jWVYhWq7rXLyN7VldzT3IIUNlvRzUzO6VApj01fSvYTemVwxJbsuLRmdujvF+Lr2RxRCsXOZ0+57Xq/c+4jStH8wsdDMvrJlZ7eGzSQVftiAR9PCtSYrp9BoQnlcRM5TWA24QB80Nei55dFu/hVaWkxMj/aHFJ0DtGY7kDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524989; c=relaxed/simple;
	bh=+h2GkDj+OoeHXnuD3ME91MATvB8iz1ermwPdmsLVLQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHtPFM3/1qY4pRfIWbNR7TJ95kJXF97jommWMs0YaJx2tWN/kDtzeIv5ViB1HdXIBYYojA07hLiVLmwPXaOMtF71hwzobu4KEeT0af1IeF/D/h6PqPD+vg28sQme/fntyLcGX00o93A+h443IEg052mRSEQnxg2LaK4vUxITZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMRAt9LF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43955067383so12629595e9.0;
        Fri, 14 Feb 2025 01:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739524986; x=1740129786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7BNqikEMUFZIk3bGCtvMWc4aGoto03Aq8Yw25jOfXg=;
        b=YMRAt9LFnElc16Ouol8JFp4gzR3cXZXDALXu5n6ncVKRwdDp9v7DetV8WPqTDh5K73
         +v9pFEVUe+7jgv7MKXCO81anJm7E0vYVHeDvh3bgpu3tuq86g+WJEHVL/82OnN5qqFrY
         2T7IWjAfQQRQ0WAdvYi9Nf7A+Av42zLx6BN0BHfCBmBLRt0eAkWu7fmsBZbD+j0kDaUh
         W8GlWHLWgKas4VSOro2PbVsexv5IopnDECZ+f+DImh710H2/kVaJSn6xNh5eBAhuOwcp
         wdX7joD6A3GEPq0Aqc0YVDrZgCvXh1S2YvSpZjoGVSrpHJu3kVxmPdhdtvxjTtAKqqdc
         Gypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524986; x=1740129786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7BNqikEMUFZIk3bGCtvMWc4aGoto03Aq8Yw25jOfXg=;
        b=LfY6sRiHUntAYFQvL0lXHITiPLuOts9iQrrRdjozk32f8ez6204iqb0GBCTdiLn6V3
         GIBdgLm3fpN/2ZOYpU4VmcI5zKA3cu+s5a9NicLcAHLAgy87BNxd5SJO7HJYyCPeDM+b
         tzFWIpt3zo7UDZYAjx2Xys2/eT1cCpsfoeq1Yt1DwjAH1G6l9QwPZU9PFOcQY1pqIUd3
         /DUHGIQV8sSQIULAKk7+5FcrzgFeFiAiLjQcLf6i8FwA7+cdR3FtCvBWSWitMBbr+K/g
         J8IWVdPuBxR5XpbQZ9w+7RAKSzBSxuYa/9Z/et1dD5NmO75JYjiKj1uGMPmMQmRUUPGe
         7YZw==
X-Forwarded-Encrypted: i=1; AJvYcCUnnvSbX2MWFPaAfXYiQbo2HS/d88eYV/KyoNdLJcynlEE/NK5t0a6E1uEMQw75SNBCEZMAX4U2gMhNn/MWTys=@vger.kernel.org, AJvYcCV2Ca/PSqhyZOZzEjL3MYiZpcQnyc0IhEY0OAH0xHc41VB9Y+wvxuHgqyIVuW6JHRODgj2vHQX9@vger.kernel.org, AJvYcCVSB2JKEhtLU5CJnMLkhwhMATfIWOmG3/pcZGGZ3pQBscuFvqGuTV/AE7GJmr5TnC1NpiSOsBaeiNImxg==@vger.kernel.org, AJvYcCVSHp0GqTfGvVd7tqlnKFSERZoNAgYInCRhWJZYlJ8nxWR9ZP7MpYNIfZOBwbEPm8aIIL1oQaokReHk3Q==@vger.kernel.org, AJvYcCVvjyAylXesngMqj81v3+QJyPnokoSiAqxGv1q6g9Jtt2FdJ+YXsW3C+R9K1QXdiLf8DDbqNntAWM6I@vger.kernel.org, AJvYcCVxwGaRuOz/bV7o7/4hc8s0WahLaEHYefU7QAjJD6kI1V8gsIPLfI/S93yQt9RKhZG3dFJ5Hs9iM57s@vger.kernel.org, AJvYcCWtgqdrCtJuhnUnP4oURVgJdnpWMVsMi8UuKlJULRjghQwm8ZmtNGdplC2sgScHT/10F2BASluuiHNF5zuHcT4J@vger.kernel.org, AJvYcCXjKFedsaJetbpF0dFPoertji1xiR1BgGOv61AdmSVO6HdpcrZNJNX9Jf2n4QaP6RFS0qg=@vger.kernel.org, AJvYcCXpdmdRUWBURKezBx6aM1QdA1HOt7XVM1NAhyxNJOnFoEn9J4lmG9u7h0InDDIdQzHQPVRfVaDuyQIj+fzZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7xnnC5yMcRGieheNtcO55dpuGVPURgkkfOvwVKyvunNzDHiX
	qqk3NzUB986go9dapYDsW19No6QE9RqMmO4MfSfDuafRzU1dyLCkzhwuLVUroWxyQvxSywts2dl
	Huom25Jjhf4xDkQjftJgZw/TJHkY=
X-Gm-Gg: ASbGncvHPs1gO/K5DtrLU3Fc7l8gmHUhw7i+XbRoR1HwIjqzWuPcgJMqb7TXKvfVVSN
	V0EPvUk1VJRZslgoJYxRg+bXniYbw9eOrqirMLszhKtMMOvJtXQCIF+IDhrS+b0xHmMbWPnU=
X-Google-Smtp-Source: AGHT+IFc4q5LtCR4oH56B/JnsUWjOnr2P8qnhLaQaAQF/xsTMWgc84lPizP0lboCQWCd1BP4FsSRkQxEWx0I5MF+EcM=
X-Received: by 2002:a05:6000:18ae:b0:38f:23bc:c19e with SMTP id
 ffacd0b85a97d-38f23bcc233mr9719529f8f.29.1739524985787; Fri, 14 Feb 2025
 01:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
 <20250213110004.38415-1-kuniyu@amazon.com>
In-Reply-To: <20250213110004.38415-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 14 Feb 2025 17:22:28 +0800
X-Gm-Features: AWEUYZmC-_4d4WbO4zj0CDnf9myDuv_5df2UqBnW8RiGwAq7tiZ7QonxxL4s5P4
Message-ID: <CABAhCOSsZqzrsqct+c613TVhGJdubv+_wTDxmjH8z6-PL1Mu2A@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 7:00=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Thu, 13 Feb 2025 17:55:32 +0800
> > On Thu, Feb 13, 2025 at 4:37=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com=
> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@ama=
zon.com> wrote:
> > > >
> > > [...]
> > > > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > > > index 863852abe8ea..108600dc716f 100644
> > > > > --- a/net/ipv6/ip6_gre.c
> > > > > +++ b/net/ipv6/ip6_gre.c
> > > > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct=
 net_device *dev)
> > > > >       tunnel =3D netdev_priv(dev);
> > > > >
> > > > >       tunnel->dev =3D dev;
> > > > > -     tunnel->net =3D dev_net(dev);
> > > > > +     if (!tunnel->net)
> > > > > +             tunnel->net =3D dev_net(dev);
> > > >
> > > > Same question as patch 5 for here and other parts.
> > > > Do we need this check and assignment ?
> > > >
> > > > ip6gre_newlink_common
> > > > -> nt->net =3D dev_net(dev)
> > > > -> register_netdevice
> > > >   -> ndo_init / ip6gre_tunnel_init()
> > > >     -> ip6gre_tunnel_init_common
> > > >       -> tunnel->net =3D dev_net(dev)
> > >
> > > Will remove this line.
> >
> > However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
> > tunnel->net =3D=3D NULL here. Take ip6_tunnel for example:
> >
> > ip6_tnl_init_net()
> >     -> ip6_fb_tnl_dev_init()
> >     -> register_netdev()
> >         -> register_netdevice()
> >             -> ip6_tnl_dev_init()
> >
> > This code path (including ip6_fb_tnl_dev_init()) doesn't set
> > tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.
>
> Ah, okay.  Then, let's set net in a single place, which would
> be better than spreading net assignment and adding null check
> in ->ndo_init(), and maybe apply the same to IPv4 tunnels ?

Tunnels are created in three ways: a) rtnetlink newlink,
b) ioctl SIOCADDTUNNEL and c) during per netns init (fb).
The code paths don't have much in common, and refactoring
to set net in a single place is somewhat beyond the scope
of this series. But for now I think we could put a general rule:
net should be set prior to register_netdevice().

For IPv4 tunnels, tunnel->net of a) is set in ip_tunnel_newlink().
b) and c) are set in __ip_tunnel_create():
ip_tunnel_init_net() -> __ip_tunnel_create()
ip_tunnel_ctl() -> ip_tunnel_create() -> __ip_tunnel_create()
So net has already been initialized when register_netdevice()
is called.

But it varies for IPv6 tunnels. Some set net for a) or c) while
some don't. This patch has "fixed" for a). As for c) we can
adopt the way of ip6_gre - setting net in *_fb_tunnel_init(),
then remove the check in ndo_init().

Is it reasonable?

Thanks.

