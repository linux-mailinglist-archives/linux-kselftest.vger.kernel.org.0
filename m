Return-Path: <linux-kselftest+bounces-46843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27BC98EB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 20:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFBF3A48FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB698241103;
	Mon,  1 Dec 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSJ97xtt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41810F1
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618767; cv=none; b=EfXZ3cGCjSHSKRwL/++XEVR3fiO9RZAQDjALJDSCMbnJb5Tru3bQNwzn2R8+YEx6dfsxHwwOe+nQ6kTOgUU3SA0hoxFA9/tRPeh+ejM5yVOzzWxyaH4UbG4E1WQLKmNhHAemOkugEMA9Mp3UranZdA/TPjLicJJ36kFcEzIPEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618767; c=relaxed/simple;
	bh=8MUOzw68ESrWDnroAv8LhfLlXFPmVBMxNYCgDlG2Crw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H35qTEEErOb6aYmqc/PlsxRW0bxSaLVkEfXdLSoaSExwk4gDH4VHqHHujdsfs4L+FUdlnR08uaEK6q6qVKNNnbW6glzn5NMr0PZI8NgdGwwG7mQO743TeQi0WcUmZ4JvFGFm42I/stuB1uh11/6EOjPmilODz6G2SSerSoR9KNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSJ97xtt; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7881b67da53so43008227b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 11:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764618765; x=1765223565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukxcfNeIHOLPW1NfuM1mukBFBPznM6uJdqjJDXn4M7g=;
        b=YSJ97xttAZfeNo/2jQgkT7zAmVlq5BMNOGx5fCpWzbtQVAUJZTGT3WOL5fIe59WP+X
         6rWJYc5XUD26jKe2M/0NqKuVdGh2jWhpGonkUTGvp2P81cT6CkFggWSh7uaQcD7uYSKR
         5e3MaQCe20wXApKfvQzPcyE+oYEEklCRzCrRpj1wbX6/YKe9I49U8OB5KTG0ShTtty73
         ZvUl3Y8A+H67aG4XZC+l0tu4izmG6K8BpNBJcncGuFRvyn1o2AKK5R5dO2X3iwFLNdLX
         fvA2xF93P7SwGNP9RwnGQwLPHZOi3Pdz/u4nNZ69H1glYzu76uS3+OufADSpE9QD7qLE
         IVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764618765; x=1765223565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukxcfNeIHOLPW1NfuM1mukBFBPznM6uJdqjJDXn4M7g=;
        b=k+by9cVVDg3jVhDKN/k1f9SiYm87YEXm8qwfZUkVBRbJ1pLSm6TydQ6GeT5bgL1s70
         qIM0Zd6OuWdCwb++YTVK4I/ImvcQcTARHG6NEiCY33vKd/JhDrdc/W9FO8wpEU+sRu2w
         L0Fub8TskzZQsCmzkEMbJFJrUhg5wMvW1Y4x9NCXl4MkZEK8HG9HAsY14+cNEX+at5PU
         41+3uf9wbxsDkVQ6fbtfzP1uEL+udtX3OwJMLXUqDchHLQKpmgdbCjlJiA/YweNbclYa
         m40k+et5cS1WolRlv+NT03FpXRS/lSYwRoVkd1SVe9Ux9FJZiz9d/8KXN9/xVug42hd6
         BrGw==
X-Forwarded-Encrypted: i=1; AJvYcCXgdXDeSs4BvG/LleUg3MYo2B5FXQNfog+8ZbiVs6W/DRBsK9UgSUwivenaznV8MRUd3hX1T+mNz2CJ6yid/vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsAYGDP5n9uKMsPRDHGnMj2JYEO4FFKxGe+hsC6dVqwgrO7AZ
	Oh2YF+ygOLgfKBnnfgRDnSxXzobMHvc6Rex6qDEqX5w+Rs1bopgOhUg78kualUOU07rxCAiX0On
	B+L+6oUtK4f+NzXn9Loo0jxbttc3bIz8uHiK0
X-Gm-Gg: ASbGncsnEC+M2QkIBO6xEEP8l5uw8BRQPqHE7RDj45I/WLjKqxgeVzodevQ/qa3Nduv
	6xKLd5roce3h+WMqgbqd9/uISrwO2f85p1F4QceVWcF2eI6W12IZ2mZuOGfza/bYyZYYQtCFtm9
	uvRVdrM4abi6Ug8D9t5/l7JTTpsGH0CGwPvKEzZcd3bR+2y1X69B+SZGdupUHMwUF1VKap3DaBH
	i92Nxf+XcqnOcmPLLTFgj1+Z7K3+3u3MK6i8z3J47x9LOif4FBCRQ2ouJQrKtfYNbfHS4GHpbcq
	N+f6
X-Google-Smtp-Source: AGHT+IGvVaZ28++/jLtLsHwDYfDZfjA0jZXCxwXEjV9/leMSdeKZ58eWSu020+gEAXzwztS/Xn87qN4od+07+/vEJ9w=
X-Received: by 2002:a05:690c:3383:b0:786:2f01:16fb with SMTP id
 00721157ae682-78a8b499e1amr336642907b3.26.1764618765077; Mon, 01 Dec 2025
 11:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201102817.301552-1-jonas.gorski@gmail.com>
 <20251201102817.301552-2-jonas.gorski@gmail.com> <aS2qnzL2WC-sFlnJ@horms.kernel.org>
In-Reply-To: <aS2qnzL2WC-sFlnJ@horms.kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 1 Dec 2025 20:52:34 +0100
X-Gm-Features: AWmQ_bn_3VNOfcboUxyIrP6GzrSjs_4ElvAa-ipPBD9VjAt0vsz6sjCYLC19MdM
Message-ID: <CAOiHx=mog+8Grm1QTnqU_F3=BnWmJqTj+ko-nZiRMAb4-hvSqw@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next v2 1/5] net: dsa: deny bridge VLAN with
 existing 8021q upper on any port
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 1, 2025 at 3:48=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Dec 01, 2025 at 11:28:13AM +0100, Jonas Gorski wrote:
>
> ...
>
> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index f59d66f0975d..fa1fe0f1493a 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -653,21 +653,30 @@ static int dsa_user_port_attr_set(struct net_devi=
ce *dev, const void *ctx,
> >
> >  /* Must be called under rcu_read_lock() */
> >  static int
> > -dsa_user_vlan_check_for_8021q_uppers(struct net_device *user,
> > +dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
> >                                    const struct switchdev_obj_port_vlan=
 *vlan)
> >  {
> > -     struct net_device *upper_dev;
> > -     struct list_head *iter;
> > +     struct dsa_switch *ds =3D dp->ds;
> > +     struct dsa_port *other_dp;
> >
> > -     netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
> > -             u16 vid;
> > +     dsa_switch_for_each_user_port(other_dp, ds) {
> > +             struct net_device *user =3D other_dp->user;
>
> Hi Jonas,
>
> The AI robot is concerned that user may be NULL here.
> And I can't convince myself that cannot be the case.
>
> Could you take a look?
>
> https://netdev-ai.bots.linux.dev/ai-review.html?id=3D3d47057e-e740-4b66-9=
d60-9ec2a7ee92a1#patch-0

At this point it can be NULL. But it being NULL is not an issue, as ...
>
> > +             struct net_device *upper_dev;
> > +             struct list_head *iter;
> >
> > -             if (!is_vlan_dev(upper_dev))
> > +             if (!dsa_port_bridge_same(dp, other_dp))
> >                       continue;

... this condition will filter all cases where it is NULL. For
dsa_port_bridge_same() to return true both ports need to be attached
to a bridge (and to the same bridge), and to be attached to a bridge a
net_device is required, so other_dp->user cannot be NULL. And we only
access user after here.

Best regards,
Jonas

