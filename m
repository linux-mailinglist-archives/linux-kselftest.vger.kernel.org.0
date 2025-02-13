Return-Path: <linux-kselftest+bounces-26513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B4A33BE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824C4188CA49
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB1211474;
	Thu, 13 Feb 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F27HBhco"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FC2066D6;
	Thu, 13 Feb 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440901; cv=none; b=RXeuubzBsdSRhAD7TPBIAlYBskSP4cN0ISFmpxQoS6v0oZ5ykwODqiWhIjzzc2Ia0uhqw/19LyWVkSeYqinfMbhrlGRfktr68BQEeoS4p+f59/n0J1IwaLVe+wVKUB8mkMbnv4vkDHDMKIl3y22sVYvGdNDhKpTey82g41QvfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440901; c=relaxed/simple;
	bh=iBDt2glmR7cHZRLk9T83XH+ffn4f88bkjS2lrtyqh/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR9UU+8MbQLKO4dtmkRZZrRmPzy5O3dzfAioqxon5feqjXNXsNda4uChAvOo0vSrrzFq86j08XYn94bQEQC3Is/scJoc05/gmETs8Bg2qLOayRABLVtJ7xmB5t+3f8U7hEIPfkuMLFZXrTzd/a46sR97M8oeDQ32ZpR2TQDA7ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F27HBhco; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so564731f8f.3;
        Thu, 13 Feb 2025 02:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739440897; x=1740045697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzLT98ZLU5P2fWKiTUzwgsTrlPg66ER6fTAj9aLF8fM=;
        b=F27HBhcoSLzT3sL8Ku2e7U5GQt/ymD89GKSeWZlf/5QENZWPh+kuLggyLZ/rxwb2kG
         1lWmSEJFm1nanoZH8lzQYxqzFdv1aT8avZ8CiKMBVadaxBFS5Nhei7I1azcLd3UknIeU
         7xCN6uF85Bg/byZNEoSGJa7IE92JToAeBbxDZ+N/OHtVkGxfjoQ8B+2ahS3I3he/BRfe
         voVYcN8Xy+kIhbOxs4jl9NWMinbGuYNk3kSMc0LhPMyQ5lv9oc71ZPVl6d35rHyP34Gc
         305R481UgfWnLplk1bjNDkEakdTcSswJF9ACcvjc4j6kB9pRpZiLwPIZmx6R7xRvW6gR
         zhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440897; x=1740045697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzLT98ZLU5P2fWKiTUzwgsTrlPg66ER6fTAj9aLF8fM=;
        b=w/4FJa5msYAQJpJhJXwSXY+yhFHB9fC70zQrODeZin4AGk/JLQxCbh1+BmRbNIBJ37
         v/bW5ResExA5w6DFs/F2y9rek5ApVhSKXcS6lwHZvZxT47RpGqwvr4UIrcXXOZsbutgu
         H7z7OSIO9FkEaPYVHVvYFrAL9F5wPOWqx4kvpArHvrie0kCL1n4SzR1AyIwNduQNkBHK
         OqXP7Ylf5m5I+7ChyHVzDhkBtLzho3DAG7P22wVvV/fAtrNLWkRLa4B7x818+74v/+KH
         AJMKULG9I3RuFvPVmyZ8IG3wolvotA7Mj3eHWYVW3xXmXmihN3URstIjCrdpBXjpgBdn
         /URQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1+CJP2buiM8/DxyTwCPZzncnVfzcHgbuW3iKWvO1do77cctij23fXYVMF+zPMUBIlDAWneUmKjYWb@vger.kernel.org, AJvYcCU3xVynTwG8NrgXxLb7gBh4boQSM9N6pAptrklcVVHiMAauHD/DLvj/330EBetonOrcStljQebi@vger.kernel.org, AJvYcCU9RszRKzCoJBNMYdeoEmirhOP+/Z7UvxFkk4miHcL92h/mznww2um2vaB2l21V2mwhB0AMXY6bIkbQ@vger.kernel.org, AJvYcCUlHjPbPYBcFUBnLno3QU/H7ZKwfzUtXeWsLzqgnsUvjI5tp7d/4tLe+AenraLxD7kOF+vfY6QhEqlPQWR4NbKo@vger.kernel.org, AJvYcCV5m1qs3UWLXCzIj0GXli0fon4S2fR94mmwGaf27nnzuEb5bn9tlCloTROXEq9sW6AhAos7aeAa6d9NVg==@vger.kernel.org, AJvYcCVAobNqM+lKxqtaHDsZ3TiXORLTkhwZNVSN0pp2Iewv+c3y0k89ZUaL47DrixFT2Sv9e6Q=@vger.kernel.org, AJvYcCWJfA6NgWgPy/KwsXVIXwhdc0qKrz8imABc7dSy4xwWmneKxn91nCyZard0PfeuVG8G3p3rYz9AQP/wNg==@vger.kernel.org, AJvYcCWuKH9C0H7oOrCWBWyXGhLxS9XWDvAurO6q57+Iaqjuww+4z6zpdpHbc+oLf90dx5alhlvytjTdaTmhjhCt@vger.kernel.org, AJvYcCXKd+b2ZizvRrFEsf16e5WCsJX29pqkNYvM/CvV2eLp2bEFouszvQk3N1/ulCMBfWcWp/yfrTg3obqgTA+ACtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDHQ2ULy/b3H8iPETyqOKkf4JPLz9z4KSNCCA/04557xoG4CO
	6lCnISj2AVQzeLgwoP7mZe823KPU3kwQ1qEjVA/Q5AdxgvbjZnt0+V91qa8ynycnCERKaZEjPgX
	8/ePJ1IQFmihptsKGmu7JdZhS9q0=
X-Gm-Gg: ASbGnct8IV7hqIfFWMa1uEEF3ywnGb75LQi5LuYw616qX3swxvG2KRqgIZ2w+8VpnXp
	CXcBA54kofPJRtHwBVhF2eyAY4pNByTx0SHMt6d0bDAMn4qDWaiYtZrb3ma2a6/lJUb6DFz4=
X-Google-Smtp-Source: AGHT+IGNZlywLnJxQSbfEuVU5lxBk1mvVT9ugQLIpGpywWHBNNSM0YY4phrOkk812RGul4zBJlRkLm/hRcXNfYkCEHg=
X-Received: by 2002:a5d:64e2:0:b0:38f:21eb:5d02 with SMTP id
 ffacd0b85a97d-38f21eb5f2dmr4477949f8f.22.1739440897336; Thu, 13 Feb 2025
 02:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133002.883422-3-shaw.leon@gmail.com> <20250213065348.8507-1-kuniyu@amazon.com>
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com> <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
In-Reply-To: <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 18:01:00 +0800
X-Gm-Features: AWEUYZkc6f7IS5VLx0dDxpZ4gB9UzsINfw32PuUeMd1tOC9C9cBZAvSRCBGNkQM
Message-ID: <CABAhCOQLHgiwkydm9vQAkVYZRyrCCu=E9Nh=wwkWFXox0x5uvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into struct
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alex.aring@gmail.com, andrew+netdev@lunn.ch, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev, 
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, shuah@kernel.org, 
	stefan@datenfreihafen.org, steffen.klassert@secunet.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/13/25 9:36 AM, Xiao Liang wrote:
> > On Thu, Feb 13, 2025 at 2:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > [...]
> >>> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
> >>> index 523025106a64..0f7281e3e448 100644
> >>> --- a/include/linux/if_macvlan.h
> >>> +++ b/include/linux/if_macvlan.h
> >>> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct m=
acvlan_dev *vlan,
> >>>
> >>>  extern void macvlan_common_setup(struct net_device *dev);
> >>>
> >>> -extern int macvlan_common_newlink(struct net *src_net, struct net_de=
vice *dev,
> >>> -                               struct nlattr *tb[], struct nlattr *d=
ata[],
> >>> +struct rtnl_newlink_params;
> >>
> >> You can just include <net/rtnetlink.h> and remove it from .c
> >> files, then this forward declaration will be unnecessary.
> >
> > OK. Was not sure if it's desirable to include include/net files from
> > include/linux.
>
> I think we are better of with the forward declaration instead of adding
> more intra header dependencies, which will slow down the build and will
> produces artifacts in the CI runs (increases of reported warning in the
> incremental build, as any warns from the included header will be
> 'propagated' to more files).
>
> >>> +extern int macvlan_common_newlink(struct net_device *dev,
> >>> +                               struct rtnl_newlink_params *params,
> >>>                                 struct netlink_ext_ack *extack);
> >>>
> >>>  extern void macvlan_dellink(struct net_device *dev, struct list_head=
 *head);
> >>
> >>
> >> [...]
> >>> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> >>> index bc0069a8b6ea..00c086ca0c11 100644
> >>> --- a/include/net/rtnetlink.h
> >>> +++ b/include/net/rtnetlink.h
> >>> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlm=
sghdr *nlh)
> >>>               return AF_UNSPEC;
> >>>  }
> >>>
> >>> +/**
> >>> + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newli=
nk()
> >>
> >> The '\t' after '*' should be single '\s'.
> >>
> >> Same for lines below.
> >
> > This is copied from other structs in the same file. Should I change it?
>
> https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/process/mai=
ntainer-netdev.rst#L376
>
> In this series, just use the good formatting for the new code.

Got it. Thanks.

>
> Thanks,
>
> Paolo
>

