Return-Path: <linux-kselftest+bounces-23984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44F9A03FEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 13:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816367A420E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14F31EF0B8;
	Tue,  7 Jan 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCYsGSj0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40A1E9B18;
	Tue,  7 Jan 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254440; cv=none; b=phWYxdIL48pZ49OMKLmuN/Et6Fb3W5dvTDRCTwik57sFZbGpqdnaB8U62RUFJWAUBIiic03ss3pr/gVy52lpat42ucl/AFIjl0/xs2V7A9+say7drb6S9IXsQVMM1T4CcTae403vmQkNAa/5AfzEpNXSrAzvqTYF5tjm/GUk90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254440; c=relaxed/simple;
	bh=inq18haWLx2b6yOB0em2RillkH2hQMFoTDPjGmfyXlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np1nWXoiIYYydbRvvx1bySUGoR4D3tQRPNIqDnKcoEnt4+o4vrDwjssrSvsK4xb6MvNpmqND002eOQhi2FUkBXTVgAGp2tdTaW3Py/WRaMEdNHhdx4v3nWaeGuXf0z9RV4l/OOHsyX1ba6qfEndooZ0VRG4Psg8bPPLbJX9nVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCYsGSj0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862df95f92so6821154f8f.2;
        Tue, 07 Jan 2025 04:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736254437; x=1736859237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F66Eu0GAg36EcgkwSAQsoLttohjhJJSzBhrgfuDrfa8=;
        b=JCYsGSj0Ozsv7WXXWBE5vGxLV1giyFmwp9fqNQ6SV5l2qzXDhqqTTwbNTXRKipgTMU
         GP6kQJGdbCBi7fh9CJnvDm42jAq/WoMXlgwKRpZISOwRczhcQt1LoE2B8FOakd+WYa0M
         jPKT3sJAV/OQQyy4dkbWEWcqOYEPn8LR+Ytl1Ykxxa9RFdqEhCENHQ9slSy0/RuZoFNl
         FdtRCqsdPaN2yDv2T/hnH89K9magsbWh44CaVoOH06zzN80+oMn0flWYrF/awZL0Tj6l
         Ioc5B5LHKzsT+DxOwjr3vZ43oHFQnCsWWPqp6QRBQX5bHbOZjlhIhVZnoYMYk05WGZaG
         F0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254437; x=1736859237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F66Eu0GAg36EcgkwSAQsoLttohjhJJSzBhrgfuDrfa8=;
        b=OoMfESW2J/Dmb/B1e0+l0EfcD43Wu4xqAALbcm6/TIxdp7Pmj3Zno3ansvVcJhiKSm
         vkf5F7y05TfDigbxRJPnK0fHXT25OhnZa9gVzljWYODYfr+7BtT+iFRx3W5sG2qp8nCv
         vFhI3RMVyQlrdV/9zm+ZItobJGVxc+ptQvMPAEPkazHulH4GDhUJITH3ODMnELvLbWjU
         4UWRsJ+3B1EtWklqLX9+sOdh+10OHX2yE2OEbc3wNef0sbg4ieM+cJ77YY0ZUdJ7C34U
         9cxxey+/GujSzfOI22SLGuUWwovPNq0QyIyItWc2Qt1h0Nfl/JUsnMacu2wsziMjS2K+
         n/rg==
X-Forwarded-Encrypted: i=1; AJvYcCU0XnkoQ5hoIx9QAVhUquF/kQa0Z//9pvCeGJ0pCC1wJlrsltT84CgagfEoycR9QbujJJZJKds3HYpZ@vger.kernel.org, AJvYcCUE/0Adt020PWhyAsC2bKBHweiflNywzgpY5Biymkxgfplk6WReW7ltvOAyp9uXMn/SPObppyTSwZBgUyAXS52D@vger.kernel.org, AJvYcCVeQ1enEUxexP1GhEdy7ur8hyWjLfM4eWl2aeNSPDINEhWl3stmuvVYDQZrui5mLuS4dgamDxOk8xsyaA==@vger.kernel.org, AJvYcCVoYovxlTxVqdHC1hTGJLJee3Od/uvGHG6A84Plf02IguVCtJjSyWz9HBjTnqtnlZNGuQFNmwQVew48QQ==@vger.kernel.org, AJvYcCW+xm/Ymz7i7TFlRoiHFSB31ghWDK+a7TYUMmLt3jUl79mcCAaC9i5kI1LA6JSpyy/GfnqpOMlkSeolHmYH0/k=@vger.kernel.org, AJvYcCWKSm2v0nDKKLIJ1fmRYOaps1hTWdvV0MmFVqVwUqc6Xaw/p7JO3SqFrxyDw3V4kcyThFv2kL2t6j335Fqc@vger.kernel.org, AJvYcCWUJe8yuL5zTp7DNhaETLOmQwHojSuBzJPF3g+/V0EbhOy6yUekoj/hOjNQr0lNynrExQgamy0woPVp@vger.kernel.org, AJvYcCX8viDrYX/X8hWsPb9GZiUs47am/zXkLXR5PDP5IoRdHFUCPnhZa2EiaZSj5BjRz+2h4+Ks4i4x@vger.kernel.org, AJvYcCXfJzmDwYlSccjdYPBHZXCCDsbveNI39VlZrTAW4Of4oAO6Nb3KLbznKGgzKrfg84mi6FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjRZtVjM75gxKDr8ugr5xAC4uQ5OUgJFumt8H7RrW6mZA5UsG
	rpk4i4weRqjt9we9041ooy//ivV3sRmugCiAsk0emOh5xWfnyRfL0XkAd+QhPG+vtWlZ24oNRJ+
	V5UitLeTLfglYaJprvEBdaam4OhM=
X-Gm-Gg: ASbGncsVhoCwfPPNt/S+ohS/TQ5R7pM0/Emgr9ZFJ1FDYQ16SDRxb7TUaHi6ZhLIpWa
	v4JE1Ha+C6bPyFdhd3mANmJCwkLuylPpDaCNS
X-Google-Smtp-Source: AGHT+IHLmQYT6Nfe/TxqetejkNmjRWULhNkXti9Y+FoSO0oNz6JKWmwppacRVdUE20hj8uvdZwuWTQu822tlGBPGUFc=
X-Received: by 2002:adf:a15d:0:b0:38a:615c:8222 with SMTP id
 ffacd0b85a97d-38a615c828emr14509037f8f.4.1736254436561; Tue, 07 Jan 2025
 04:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com> <20250107085646.42302-1-kuniyu@amazon.com>
In-Reply-To: <20250107085646.42302-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 7 Jan 2025 20:53:19 +0800
Message-ID: <CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 00/11] net: Improve netns handling in rtnetlink
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org, 
	bpf@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net, 
	donald.hunter@gmail.com, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, liuhangbin@gmail.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
[...]
>
> We can fix this by linking the dev to the socket's netns and
> clean them up in __net_exit hook as done in bareudp and geneve.
>
> ---8<---
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 89a996ad8cd0..77638a815873 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -70,6 +70,7 @@ struct pdp_ctx {
>  /* One instance of the GTP device. */
>  struct gtp_dev {
>         struct list_head        list;
> +       struct list_head        sock_list;
>
>         struct sock             *sk0;
>         struct sock             *sk1u;
> @@ -102,6 +103,7 @@ static unsigned int gtp_net_id __read_mostly;
>
>  struct gtp_net {
>         struct list_head gtp_dev_list;
> +       struct list_head gtp_sock_list;

After a closer look at the GTP driver, I'm confused about
the gtp_dev_list here. GTP device is linked to this list at
creation time, but netns can be changed afterwards.
The list is used in gtp_net_exit_batch_rtnl(), but to my
understanding net devices can already be deleted in
default_device_exit_batch() by default.
And I wonder if the use in gtp_genl_dump_pdp() can be
replaced by something like for_each_netdev_rcu().


>  };
>
>  static u32 gtp_h_initval;
> @@ -1526,6 +1528,10 @@ static int gtp_newlink(struct net *src_net, struct=
 net_device *dev,
>
>         gn =3D net_generic(dev_net(dev), gtp_net_id);
>         list_add_rcu(&gtp->list, &gn->gtp_dev_list);
> +
> +       gn =3D net_generic(src_net, gtp_net_id);
> +       list_add(&gtp->sock_list, &gn->gtp_sock_list);
> +
>         dev->priv_destructor =3D gtp_destructor;
>
>         netdev_dbg(dev, "registered new GTP interface\n");
> @@ -1552,6 +1558,7 @@ static void gtp_dellink(struct net_device *dev, str=
uct list_head *head)
>                         pdp_context_delete(pctx);
>
>         list_del_rcu(&gtp->list);
> +       list_del(&gtp->sock_list);
>         unregister_netdevice_queue(dev, head);
>  }
>
> @@ -2465,6 +2472,8 @@ static int __net_init gtp_net_init(struct net *net)
>         struct gtp_net *gn =3D net_generic(net, gtp_net_id);
>
>         INIT_LIST_HEAD(&gn->gtp_dev_list);
> +       INIT_LIST_HEAD(&gn->gtp_sock_list);
> +
>         return 0;
>  }
>
> @@ -2475,9 +2484,12 @@ static void __net_exit gtp_net_exit_batch_rtnl(str=
uct list_head *net_list,
>
>         list_for_each_entry(net, net_list, exit_list) {
>                 struct gtp_net *gn =3D net_generic(net, gtp_net_id);
> -               struct gtp_dev *gtp;
> +               struct gtp_dev *gtp, *next;
> +
> +               list_for_each_entry_safe(gtp, next, &gn->gtp_dev_list, li=
st)
> +                       gtp_dellink(gtp->dev, dev_to_kill);
>
> -               list_for_each_entry(gtp, &gn->gtp_dev_list, list)
> +               list_for_each_entry_safe(gtp, next, &gn->gtp_sock_list, s=
ock_list)
>                         gtp_dellink(gtp->dev, dev_to_kill);
>         }
>  }
> ---8<---

