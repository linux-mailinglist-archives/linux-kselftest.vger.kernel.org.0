Return-Path: <linux-kselftest+bounces-26505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4656A339E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 09:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C8F188C224
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1177F20B815;
	Thu, 13 Feb 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3ye2SOJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31927250EC;
	Thu, 13 Feb 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435281; cv=none; b=QeflDjJfJ4c92g0Qna6g7+XiEBr/6rUvFVbJpZDa2TVNohTvFFrxYJ2DbLS11oXXQIvamlNytOODg9VO2PzPOwvuVRLOkzEX8allXG0AFVF4bckap5TxQQNp9usZudHbd5FcX2DVkxcKL9m00jdx0d3K6hiAebmQ2EKr8O6/5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435281; c=relaxed/simple;
	bh=SyjaIWe3i0tkwC2EB8hBIa5rxw02yA5yYTi3aTzBhxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFJ9PxK9Ocrl2InyN32M57ftpwC5DqcePItvU3hPL+AZUvpE3GXkurpWEVJJGwazzmq8bqKzil/6zvl7X6N8gA2NPmunkOaBW7gtG1fK6wtjmqYgGSjqnIL1H3MG6V0NuQ0Opar/+PtTnUBfM6HX1LQnWey3obHjpYLpp1f8YfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3ye2SOJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so149057f8f.2;
        Thu, 13 Feb 2025 00:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435278; x=1740040078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYDCewrdvYreNRJlqbHeSMs4C/POtyIRcHlnfcP0ZCY=;
        b=A3ye2SOJB44xTi+FmdYUXU7HtQzXaYbSeqMu+kxZi4F2BA/6a0Lmcfv+nb1CGGpKBe
         xfzLLY06okJS1eTY5Hyut98obh2g7Z3ZIpwtLON0kwljBMBWMulLPwNFeOMi0qF1a7qT
         WGz2wg3LleMPTdrcYLLOx9v29VzMQ0E5/dDJoEmF4zWK8K82QrXiNBp6p1rux1pbc6o6
         AUVuMqPWJw7DfUjPymrQWXvfdhuMnkS0H+F0kb4ODXxnMv8jAML96KcyhAqmfteEyoB2
         mRsCaRzl/eS1vj7SpJe4QAC6bCZVaUfILNKoih2Ou8pJQVPKKbe7S2EwOWD+COarANi0
         uQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435278; x=1740040078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYDCewrdvYreNRJlqbHeSMs4C/POtyIRcHlnfcP0ZCY=;
        b=TkK8rDTEgNYcIYiTfpZWCKTSJspC6YxVeCXn3gFMbeF1hhD81/8JiRj+i7xwlgTR8z
         5svd8ODmlUSu08hysmg0A/kpJt+wtKPULsku346t1881cOqNGC2fNwmkNvSTyTetH49m
         PDZvn9EQYaTR57soBU0NxdZ+SESDJ+VC8/gya09ld26mwio4mLtOK+uwW1G4jznXND5i
         h2ZC7d0wVsbyLke+AShcAc21HTrK+tSy7RGnTrIeTPPNcz3M1C3XSfy1ov7fr5S2Akyq
         hoFXPhF2uxcsWSspTWHoeYtic5c6W6E+dZfZKtJ2mFaqB1zLeq+XR5frW1xSN5FQKizI
         Xvpg==
X-Forwarded-Encrypted: i=1; AJvYcCURKmCOO33QVWYjDCRw9XrVAi+Yz67YG58sRnsSbqtI8VMJw98uI6PzPcpvdY3uYRE4rEzRiGqc2cf/mQ==@vger.kernel.org, AJvYcCW/3MkdA5kSdZ0P3fdvMPB+PENbIBCPWi5LfvdT671T16SVVoEBuCunOOO8WWMpuI0PNUWdWA1GpFl8lg==@vger.kernel.org, AJvYcCW6S9HEEr7V78lSla0SUASyt8k1ped+v1sYNgPzSAmHCxaALwI9WXhUl87/qFvPKiunEJjAxOCSvCpZ+tZM@vger.kernel.org, AJvYcCWFtatVQE0OdXevi5Te66/kAwwf5dXoq4d3frTEBQgnbbihbJ4nYYYjbKNvuQVZUHnsNmXcen6vs5vr9CWFI8k=@vger.kernel.org, AJvYcCWSUUq6XjoUdMwDSuU2u1P4W+/zziOoYextG5fSDQiM9OnTzi5sWyghU9pfou/u+jOea7hLWdW2AWri@vger.kernel.org, AJvYcCWcX1CXa6ZjPtNhx1FXprtT3nJu68xkewofyinr5bsNI8M5afIR3KOm50OrOfT/ikHoAJcYX54u@vger.kernel.org, AJvYcCX7YFJAyeqY7iWQbrqhOeHItqLS8YD0GDx+wvm5inTaYD83ztALZxGPaCBco+AkdktOn40=@vger.kernel.org, AJvYcCXP3DsdUvsqtqgWviWOHgZyg703DmoeR9Q6cnKEupV3OX3O211OnwCqlXa7PKAWISTz0EzE04YXh8IVYGONVVdk@vger.kernel.org, AJvYcCXbbPT7HIxUzdB+HOZ5LBhtIfFcQweTtqxbCD6b3nE1lkDZNJip10I2M6uMUS4O51ZE6OiwM5B/JbHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNFoepgV9sRBdYjILHID0O7pMIzyX1GpSB9nkxqmt4uPHN2cL
	beQOVM3PHoCAomihREN/SFhKZwJK0SGctQjrqgBXadu4qO/H402Rx4pzYHXDmENnnKeSs2mKI58
	iO+tgX0D6tmQx0GyPGO0VsuKMsv8=
X-Gm-Gg: ASbGnctZ07FUMQ9rF2P0TzdYcDfFQU6aRqxIkGR07zQu5FdmsPqmB2KAu01lqzhBpej
	nRDucgefzTnaONNGNA7bsD5Mxod+SN6JvB6rSMpICkul8asLrXqGZioS3nhR2XBU68t66/QQ=
X-Google-Smtp-Source: AGHT+IGZE6zJIuhM6pmlASWXo0USdC2hFnASTias2WRNOVzNleb2xd7k0p6fviBFvki3FKkZ15YNMXus/cLozeOxCp8=
X-Received: by 2002:a5d:598e:0:b0:38f:21ce:aa28 with SMTP id
 ffacd0b85a97d-38f21ceb0famr3670345f8f.36.1739435278200; Thu, 13 Feb 2025
 00:27:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133002.883422-6-shaw.leon@gmail.com> <20250213062031.4547-1-kuniyu@amazon.com>
In-Reply-To: <20250213062031.4547-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:27:21 +0800
X-Gm-Features: AWEUYZkYMDLgFWGQwQihDPwSk4qrLNJu_sLyRJOyUa3GWsERW-M3HJO2WaC6w5g
Message-ID: <CABAhCOSqruMoMTg_=6Apo=gvnfe1j2fptADzoi=Gb8cdJqhgVw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/11] net: ip_tunnel: Use link netns in
 newlink() of rtnl_link_ops
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

On Thu, Feb 13, 2025 at 2:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Mon, 10 Feb 2025 21:29:56 +0800
> > When link_net is set, use it as link netns instead of dev_net(). This
> > prepares for rtnetlink core to create device in target netns directly,
> > in which case the two namespaces may be different.
> >
> > Convert common ip_tunnel_newlink() to accept an extra link netns
> > argument. Don't overwrite ip_tunnel.net in ip_tunnel_init().
>
> Why... ?  see a comment below.
>
>
> [...]
> > diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> > index 1fe9b13d351c..26d15f907551 100644
> > --- a/net/ipv4/ip_gre.c
> > +++ b/net/ipv4/ip_gre.c
> > @@ -1413,7 +1413,8 @@ static int ipgre_newlink(struct net_device *dev,
> >       err =3D ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
> >       if (err < 0)
> >               return err;
> > -     return ip_tunnel_newlink(dev, tb, &p, fwmark);
> > +     return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, =
tb, &p,
>
> This is duplicate at all call sites, let's move it into
> ip_tunnel_newlink() by passing params.
>

Existing tunnels use `params->link_net ? : dev_net(dev)` for
backward compatibility. But I think we can leave the choice of netns
to future tunnel drivers because rtnl_newlink_link_net() is preferred
in general.

>
> > +                              fwmark);
> >  }
> >
> >  static int erspan_newlink(struct net_device *dev,
> >
> >
> > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > index 09b73acf037a..618a50d5c0c2 100644
> > --- a/net/ipv4/ip_tunnel.c
> > +++ b/net/ipv4/ip_tunnel.c
> > @@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *ne=
t_list, unsigned int id,
> >  }
> >  EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
> >
> > -int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
> > -                   struct ip_tunnel_parm_kern *p, __u32 fwmark)
> > +int ip_tunnel_newlink(struct net *net, struct net_device *dev,
> > +                   struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
> > +                   __u32 fwmark)
> >  {
> >       struct ip_tunnel *nt;
> > -     struct net *net =3D dev_net(dev);
> >       struct ip_tunnel_net *itn;
> >       int mtu;
> >       int err;
> > @@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
> >       }
> >
> >       tunnel->dev =3D dev;
> > -     tunnel->net =3D dev_net(dev);
> > +     if (!tunnel->net)
> > +             tunnel->net =3D dev_net(dev);
>
> Isn't tunnel->net always non-NULL ?
>
> ip_tunnel_newlink
> -> netdev_priv(dev)->net =3D net
> -> register_netdevice(dev)
>   -> dev->netdev_ops->ndo_init(dev)
>     -> ip_tunnel_init(dev)
>       -> netdev_priv(dev)->net =3D dev_net(dev)

Didn't find a path that can leave tunnel->net to NULL either.
I think we can remove this.

Thanks.

