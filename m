Return-Path: <linux-kselftest+bounces-23256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E9D9EE6EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 13:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080102831D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4012135B0;
	Thu, 12 Dec 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtCTHG9c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA6212F9E;
	Thu, 12 Dec 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007307; cv=none; b=H+uRk9BPpCjvQ8mhJkmAnkmVEiQsolymkN/BAebhAV3G1fpccUfix8FvVrT9LM3CiuaQBSjnBy4VnAlFNi5e/p4OKP2+wrC7dcMHKpj50OGFG/E0a+EDaAExJn8HW+4dkt1d9l+IxHhCAgbVT4UvMekW/8ETLxBdf4l23EyfSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007307; c=relaxed/simple;
	bh=jo2gukOfLEvouFNhtdX1Kl6/D7IkbXWRkgRk3E64PLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRa8uGyxizZveQWF+8FoGjgTUxIErxcudlV7T2ajHb+N6qFHRBvSM4ZTZVm4hGGVFqHVgycC+DWFea6KwIDvaevIclyJGhbD3aE4P7/SYhlkLO8W34IEDOB5h4eryoOCysRrVUzKXMtK8ATlDeXYq0NBu+0l754xfjc67azAhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtCTHG9c; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so6136815e9.0;
        Thu, 12 Dec 2024 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734007303; x=1734612103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdqXBrFz+MhhB28jjWBHlFWKaOr9dT3/Vp6X30ps4DU=;
        b=RtCTHG9cS3eoTTd2KCWow/hepNeQnAYwlY6lHSixeAW1b3fVztcDM5jzG301JWaHXj
         1Df24Gq1ix5yy+ymwYF/biR7A88m9sg0hh2/tnjgzUPq7lMcXlp6/KT57yzqtTy0cL47
         E3tM32y2IGBwiAvaOzVlGx5+mOQytM76EL8h8LUW6PpqpqW/GcPqmrCjjBtPYedkMeXA
         S+AY9sGOYkix3e6O1MEWxJl/pBNytj5NdXUU1D/JHKmKwYnn5hLp2uzLFlKjBR2/jwz+
         UqrGHuzW/2eMDIm7cGFH2JHGsbij7Su2lCGY7DzftJVjBGvAxPG/Y7WjpfI9CKTTFQUY
         60Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007303; x=1734612103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdqXBrFz+MhhB28jjWBHlFWKaOr9dT3/Vp6X30ps4DU=;
        b=pIKq8+9wDVXu3BC9M11burBtQQc7MGGMy6h4QR8mxijdlNv9HdDQnjb3R5CNvNmRdV
         EG+jOxaxK0LMDnVhxEOw0DcLTAUFylDBTAzqOsQxVTQEYrYqdfsSXrJFwbqD5MheIX5B
         x8zwkYhofJBwe4zZdx176ywIFQ7GkgLG8bw2lZ7AxmANw6LzuyCFROWQOpXKWqh+CmJa
         QFW6LT3/yQ7l0Dej2A/Ls3MVWrppyUYULuWLFVaIWXKlZhn0GkWF8N3dcCDA/uIMEJZ9
         TZGzJf2k17aEwwPXpVuGPnRactMRingc1TV/9JmBfo9cAGxd9wxDtwZDvfYRscaMobSA
         u9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU+qtQ7jmvGher16t2jyNTtAQlyDOI5zueQFAlcKClOHPwPcKwIsncAnzdwqdM7pV6a3+NRM+48OZwmpA==@vger.kernel.org, AJvYcCU0uNwB6RNMnIJjdUqimBKnfLaubomdWU0KujD6x1F+oG9ZUKlw2wvSAPhxdIajLL+pt+yRxf8Ly/WRlwpbJic=@vger.kernel.org, AJvYcCUILYc95y/qpsSLSNrbJYcaNFeA4c1AXytvwQq2ZBUhv2gMEYqPgkkSSxIm3nzfjRmjUzLirY7ClPtH@vger.kernel.org, AJvYcCUbIvk8szrAvBHYDz+rz+LZN7/WQawizTw1a/SZIqJaJac0NLhonpqAym/vC1+ELDySVQ0V7ZHEL23Y@vger.kernel.org, AJvYcCVXAUFpY91WrEp4OBtYrOX6SzU1tbSRN6v6R6z2hr8xLvScBq7gvQwI5Cp4Uw1UK3LHOvDHnRlqk87adCE6@vger.kernel.org, AJvYcCWOtaf+qKj4NRzhSMFovPECSTLJ5xdnbCOJOvc7E798Hj5ULcMsl8AVIgXSE1OzU55Xwfd/8SJFdsQM9g==@vger.kernel.org, AJvYcCXduIiLrQCwkvkZ3pduUERsp4y9AO1BY0yCYgO9wVdBBzhj8M0QtaGHzOtS6t2lTM5+yHQ=@vger.kernel.org, AJvYcCXxcmfs7q/5TCS1mP3TitPfo7WoKsCfZa7HD5prGmW1QCfVLab62BFpK93tthqIdSKxq2xTmkgBt3A1KswdKxUC@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoGbINz+t7IpRJNaOBSs0NnHXtrKdtniXsv2F7OGq3iepBv0h
	NCDkFYH0KqklngSrPmdzGOg1hZDVV5au3PjDGw2f31k+JUC+NePnj9IzAgTLw6vkOq8aHZUDOpQ
	QpMEbrsm8qAz4Lwq5DsU26PwyXJs=
X-Gm-Gg: ASbGncvsdT6DNV65BM/GFrSD768quk64y244O923Eij/aK0pSu8/EgBzDcBGGPpmTgr
	HWchv8+cebnQfRFofAvdqsr/592PBKIelvA4I
X-Google-Smtp-Source: AGHT+IFqFk9dpKGWg1iKfKEea53yF0KmGIqYqHw17PI/mHu0HdGMd6qhUvlxmt/ZCzWy1qtAEPF2qQKT7Apiv7Ssc/8=
X-Received: by 2002:a05:6000:a0b:b0:385:f44a:a68 with SMTP id
 ffacd0b85a97d-3878769805bmr3014357f8f.35.1734007303234; Thu, 12 Dec 2024
 04:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209140151.231257-1-shaw.leon@gmail.com> <20241209140151.231257-4-shaw.leon@gmail.com>
 <2b89667d-ccd6-40b7-b355-1c71e159d14f@redhat.com>
In-Reply-To: <2b89667d-ccd6-40b7-b355-1c71e159d14f@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 12 Dec 2024 20:41:06 +0800
Message-ID: <CABAhCOTv1tDOXBEE56CL1-S_J6ADZTcvso5GHtkarzJMqOC4xQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] rtnetlink: Decouple net namespaces in rtnl_newlink_create()
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, linux-rdma@vger.kernel.org, 
	linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	bpf@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, 
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/9/24 15:01, Xiao Liang wrote:
> > There are 4 net namespaces involved when creating links:
> >
> >  - source netns - where the netlink socket resides,
> >  - target netns - where to put the device being created,
> >  - link netns - netns associated with the device (backend),
> >  - peer netns - netns of peer device.
> >
> > Currently, two nets are passed to newlink() callback - "src_net"
> > parameter and "dev_net" (implicitly in net_device). They are set as
> > follows, depending on netlink attributes.
> >
> >  +------------+-------------------+---------+---------+
> >  | peer netns | IFLA_LINK_NETNSID | src_net | dev_net |
> >  +------------+-------------------+---------+---------+
> >  |            | absent            | source  | target  |
> >  | absent     +-------------------+---------+---------+
> >  |            | present           | link    | link    |
> >  +------------+-------------------+---------+---------+
> >  |            | absent            | peer    | target  |
> >  | present    +-------------------+---------+---------+
> >  |            | present           | peer    | link    |
> >  +------------+-------------------+---------+---------+
> >
> > When IFLA_LINK_NETNSID is present, the device is created in link netns
> > first. This has some side effects, including extra ifindex allocation,
> > ifname validation and link notifications. There's also an extra step to
> > move the device to target netns. These could be avoided if we create it
> > in target netns at the beginning.
> >
> > On the other hand, the meaning of src_net is ambiguous. It varies
> > depending on how parameters are passed. It is the effective link or pee=
r
> > netns by design, but some drivers ignore it and use dev_net instead.
> >
> > This patch refactors netns handling by packing newlink() parameters int=
o
> > a struct, and passing source, link and peer netns as is through this
> > struct. Fallback logic is implemented in helper functions -
> > rtnl_newlink_link_net() and rtnl_newlink_peer_net(). If is not set, pee=
r
> > netns falls back to link netns, and link netns falls back to source net=
ns.
> > rtnl_newlink_create() now creates devices in target netns directly,
> > so dev_net is always target netns.
> >
> > For drivers that use dev_net as fallback of link_netns, current behavio=
r
> > is kept for compatibility.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
>
> I must admit this patch is way too huge for me to allow any reasonable
> review except that this has the potential of breaking a lot of things.
>
> I think you should be splitted to make it more palatable; i.e.
> - a patch just add the params struct with no semantic changes.
> - a patch making the dev_change_net_namespace() conditional on net !=3D
> tge_net[1]
> - many per-device patches creating directly the device in the target
> namespace.
> - a patch reverting [1]
>
> Other may have different opinions, I'd love to hear them.

Thanks. I understand your concern. Since the device is created in common
code, how about splitting the patch this way:

 1) make the params struct contain both current src_net and other netns:
        struct rtnl_newlink_params {
                struct net *net;        // renamed from current src_net
                struct net *src_net;    // real src_net
                struct net *link_net;
                ...
        };
 2) convert each driver to use the accurate netns,
 3) remove "net", which is not used now, from params struct,
 4) change rtnl_newlink_create() to create device in target netns
    directly.

So 1) will be a big one but has no semantic changes.
And I will send Patch 1 in this series to the net tree instead.

>
> > diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> > index 98c6205ed19f..2f7bf50e05d2 100644
> > --- a/drivers/net/amt.c
> > +++ b/drivers/net/amt.c
> > @@ -3161,14 +3161,17 @@ static int amt_validate(struct nlattr *tb[], st=
ruct nlattr *data[],
> >       return 0;
> >  }
> >
> > -static int amt_newlink(struct net *net, struct net_device *dev,
> > -                    struct nlattr *tb[], struct nlattr *data[],
> > -                    struct netlink_ext_ack *extack)
> > +static int amt_newlink(struct rtnl_newlink_params *params)
> >  {
> > +     struct net_device *dev =3D params->dev;
> > +     struct nlattr **tb =3D params->tb;
> > +     struct nlattr **data =3D params->data;
> > +     struct netlink_ext_ack *extack =3D params->extack;
> > +     struct net *link_net =3D rtnl_newlink_link_net(params);
> >       struct amt_dev *amt =3D netdev_priv(dev);
> >       int err =3D -EINVAL;
>
> Minor nit: here and and many other places, please respect the reverse
> xmas tree order.

Will fix this.

