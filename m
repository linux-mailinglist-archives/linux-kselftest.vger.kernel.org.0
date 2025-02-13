Return-Path: <linux-kselftest+bounces-26507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53606A33A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 09:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B68E1679A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8120C470;
	Thu, 13 Feb 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh89uhYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28220C023;
	Thu, 13 Feb 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435894; cv=none; b=ujdrfKUJPe/2xRbFH79QM2t0lRB4gJJIEDCtd/vBELRfDqObuk7K8NOLNzaTYL4o+TeOL7DqbXikPJnwWzvds6xY3r+4s9RXce1UxdFoLZY45GzJKUOpNlm//beafLOrOtscLddAPiDbZfMhcCUCw+ELbvYXMz4jvfcDHar3ymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435894; c=relaxed/simple;
	bh=V6goxLXN+yG7yW8tdELZQRKGodN4+Plo7TAYWn7z2WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7jO1jE+QnUDuiuGYW6g3aRdhpX9M1PA7lrDbtnpxgAeVhp7eLSVyTIf537d7wJR4WKA6F/MAhwKm7eH8N/1K6/odb3sm6kMXQZLmhebhyq++Pmi5UNkAN4Gyx4y5iqXjAGkGs7qY2k2BSsVHMxX5n5JFaDXrK5F8lZApiGScNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh89uhYB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so362333f8f.0;
        Thu, 13 Feb 2025 00:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435891; x=1740040691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N497oJdjUhCNRwjALBc63pGnF5BIugJi+C5NT1OFjnk=;
        b=Uh89uhYBhiuW3/XKBu2W1c5ZIdRYEkbyq/w3SNsyVlMWeC6o9UnriB8LhDMebwmmkF
         j8RtW6pJ+D/kQdJiSg/MS1ftl2XifhZsgc0levoQD0Yvz9j6frXF6rZUYXrqfHazqYkw
         PtUuB+L8HX2i4jY7RVo6rSYXBoEEVesjE3qNUSwaFRqrfh39XbC+wTc+Z+3QK3vM1/iD
         ctc30AByfvC8Mm1liKx3nEkYtQQ0Sw0Ns3fidZZ8wBFocqXwP28+gcRkIXOZaeoEpEF9
         Y/yOiB8GmrX7zmMggE7iW1jJk0h76D4PDjT+V5gscNxOuRLLc3GfozoeCaB7jjaHELNV
         rDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435891; x=1740040691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N497oJdjUhCNRwjALBc63pGnF5BIugJi+C5NT1OFjnk=;
        b=C0UmfEdHFTz5u/bQ4RTz5kUKfX5mmuIN8s3him+HoKUDpD5FOrHYM9xPFhTwFmShuv
         jUWpp/rMc1KAPoT3dNrTnZXprQwgd205aCagRg2d6ndK0XyEK81fH58gNlsagTirR5Xr
         m3qYnS+iOYAhDg7ruJ47AmId0oib4NrIZbSDFbuAk22Wbl6jwPRAMi9tE6kKptCSRKBB
         P8K7S8EHXCL8gSqbdVqcWRCLoPMVFei4/DxLgw+s0fkxj5dgd8W7/9yX94AOOEcjr/sj
         MJhxb1TW7zX5kfpeGzTnBkJAZK59n0RZEpcnSvL+/xEyYxBc42/FDD2fQwtw+a9OPprV
         5JQw==
X-Forwarded-Encrypted: i=1; AJvYcCVGji/2zbYbTFX+QCEoTOnfd/rxUYb5gViMhkrX3gt4kZl40YVMiAL3/LiWf5q0Fa1J7j8=@vger.kernel.org, AJvYcCVMzTQerCQd/vNucplIquiLOab1mh4tKj6btoqa8qc4eHTGo6UJYJMKQtfe5Fm0xBSC5Z6jow5O5+ixiezgLs6L@vger.kernel.org, AJvYcCWH3n9qfD1699SmYXKuB9HyaBrli1+aJzKUYI2b3QhbJBNkMPghV4Zu+2tATo1xKR65ENDgyxidz70jqw==@vger.kernel.org, AJvYcCWUmWnLeTSbUOp9AYbwvdFSoY+hh09qjtbWC9gpzSVeW3BV9Cf8H/eOD6DvVdSen4yrROAcByrXAEDAmg5H8l4=@vger.kernel.org, AJvYcCWur6ALmmwEXpt4WuTxdeECT/s6Hb48CdXs6D8xZVv4Fy8NE0J5M30hFhBsCGoBHXG1rL6wEZ9XWUvg5A==@vger.kernel.org, AJvYcCX6vCOndeQT/jyP8z+HVY7qyNzJz98pb+i+XIV+t8oskCs4abMkf8Ro70oBtuh7XoRMBcsbMUCr6Vsq@vger.kernel.org, AJvYcCXO3VhVnHhGicyB6PQn3/F3cWOTv7/xDmmYw2mI6cdUNFN49xCMafgH/ETp5HWwM+oTabCNq1IUGbRL@vger.kernel.org, AJvYcCXg0czI5J/Zx/A43/8yD42v2wUIGzAbtMRnGiwB/Hu47xOzNuf4IpEX/Fsgx1wBZR/Y6+C618GL@vger.kernel.org, AJvYcCXkpqqpIov0vXOElz/0aH94bUwGIiNOZ0xSfMLT3gTmlvReqEQzfzI/shxeY5iUzlWuUxY/7q30YuyYca0W@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxHQ0ylJ/CjRXQSbyqamFx8hzQ0PL/vCHhTUGt1iXe4lebhFd
	3Xn3xobODGiZK/4EQu3/hmgwLVUjRYzPkHsr1Iiwq80+XXPVyCsLdWDEA+wzBWQKMITqJ9SUFNj
	6ln5EIHXmuZjJDw4asuJhTLj1rDU=
X-Gm-Gg: ASbGnctwtIG6nQi2OJaU+176OrI5n2gIW8tSmuCDRSzN+vP0wwUuQZXsuvGmF1uR6+Y
	k5tZ2mUnCe+jLlPXJ50wQ0+3nMlzhUMFXSAYmu5cCavBhLwkZAdklBovUpC8mN1aCFcfdHQ4=
X-Google-Smtp-Source: AGHT+IGWOHKGGlDa4+BOJnu+aApZc9NQsBvpdTnebLsDtomfgfUQKAEsY8KxAxXyKMsTrm9S+vIZHhG3h4B48IT9F4E=
X-Received: by 2002:a5d:47a1:0:b0:38d:d299:7098 with SMTP id
 ffacd0b85a97d-38f244d4b2fmr2390520f8f.10.1739435890988; Thu, 13 Feb 2025
 00:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133002.883422-7-shaw.leon@gmail.com> <20250213070533.9926-1-kuniyu@amazon.com>
In-Reply-To: <20250213070533.9926-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:37:34 +0800
X-Gm-Features: AWEUYZmLH4fO7VI_1h6eRsVKRwr1I73htkPFG-ZDVD1uQ9yC1n8P3g2_7anIJyE
Message-ID: <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
[...]
> > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > index 863852abe8ea..108600dc716f 100644
> > --- a/net/ipv6/ip6_gre.c
> > +++ b/net/ipv6/ip6_gre.c
> > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_d=
evice *dev)
> >       tunnel =3D netdev_priv(dev);
> >
> >       tunnel->dev =3D dev;
> > -     tunnel->net =3D dev_net(dev);
> > +     if (!tunnel->net)
> > +             tunnel->net =3D dev_net(dev);
>
> Same question as patch 5 for here and other parts.
> Do we need this check and assignment ?
>
> ip6gre_newlink_common
> -> nt->net =3D dev_net(dev)
> -> register_netdevice
>   -> ndo_init / ip6gre_tunnel_init()
>     -> ip6gre_tunnel_init_common
>       -> tunnel->net =3D dev_net(dev)

Will remove this line.

