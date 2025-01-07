Return-Path: <linux-kselftest+bounces-23980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22905A03CD4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9D18853E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B031EBA08;
	Tue,  7 Jan 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpjNhOIS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485F1EBA0D;
	Tue,  7 Jan 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246839; cv=none; b=dpJvGG5OGRtSXO2cSQZi97Fw5PVcO2gsSEEwwzbftzFLHJX8SQgVjQdGa2Ql1o+Uh1RKBNgMEn+FFQTTbGg9G3ITeHT2xaeU45TyZMQv3+/7CPjFF6Yhj2K6darGVjAhXdjsFvj0HfZ9PdAhyd5bFVZMW9aaDwyy8XbR8qOJvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246839; c=relaxed/simple;
	bh=rmV+IrFXiYRmJO8m/Th28rKjbiFt6MRkkO4Sbqpe3Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNb14KTZ/Gk9LUtJWYCr1QUzqn5NyplQvLv55/qnCE8Zu6ZAo2BAdxeqNqO6QHLuogJ5r69RWkq8BwohWTpreKTnNE+1ULcyCA9R7VYJX2omtq7CvUnuY6rc2vFS5UpK0nv9UmFu6fKGOuKyrvsDt2rJ3BGBfcv3gOPsWYxvq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpjNhOIS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862df95f92so6746814f8f.2;
        Tue, 07 Jan 2025 02:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736246836; x=1736851636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh0AFKuAKxAUWXpt7kGI1qVooHVbo7SNiy/9flSEnaA=;
        b=CpjNhOISeqslgdQr8wnZOAp9ApHs2YwkPksnqk1MKQ3QUOLtcQZk7hA0hrb07/9/7w
         DeCq7eKw8HMlHv/jTgrClZY/UpKs0dm6fFCNyiHME+4jwmttynV65KVfS5bhPgIuZSyB
         NUJc6AHKEfCN1BBVj30d3b9oN7m0Lm5DNKA8F3l+Pg2XPvx8UXMNJFLLMuafrBPbM8sT
         BWzb4jejI0sE0nYIv9saiZIA0NS2yVLt8jp3rV/VWq+7fHcsZqm3w25fmO/t7IbvdDSZ
         QmD6Oc7ZQuc1QSx7yVyG8Py/QtnR73wSV9l0ttm/E2hQEfOn3zA4Cars7nJHrcXWM09e
         o4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736246836; x=1736851636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh0AFKuAKxAUWXpt7kGI1qVooHVbo7SNiy/9flSEnaA=;
        b=mFtrPvJjBAGjxAmAZWbxXqEIyL3aC9hidFvitNPDzHXsPypEbgQzSWR5x4LmpKblzE
         6nRbfhLPdrGEUiYO3/Kzw1yNVqvr9Y6P035rGl9ZcdfNZ/MZAupgjm5o58zWOOx3Dvlh
         4+Bmw1MvV2f/xAmMUECW2xG7XCgZocbkXvCLP2nKWEkgoxrEAkKqYma6NAgpwyk+2OnJ
         47Cfb6Tw4Yz/lvDa3jzYgFZ0C7378AZkuABGCYmYCM5ckf+8gz+4SgXp/zFtQRxRRujl
         m20u1bMQWjrVCLE1h82pSnf75G6KdXPDznnHie9YpeMfZZxvDHkX0Pqd3wqJsqrCxJke
         bEJA==
X-Forwarded-Encrypted: i=1; AJvYcCUBK8ZOT4hMZho0bTffApVOjCLJuhuMqDWczKlvOjbrrZVAsKp+qrEhuZoCc5MfI9b5FYY=@vger.kernel.org, AJvYcCUfHeUaTrTME02pjvkkXLPDOgj7wqJdQlhkzI/V4tzlB1p0B+L+IeYV00CwK4gMso3e2Q39pF3+yOFVgQ==@vger.kernel.org, AJvYcCV6VJPvg9gAUyI7S2BjNXlFtJ1na2/IckmZj0hgV9rWo4kpjFPPnNnzEGrDMIVYdYDGs/W/FfYj1mPe2SpUo0QH@vger.kernel.org, AJvYcCVB/oQ5RAPRCmg3OHubbU4edbCPbpeTIHQHWDs266UAIAJoaIL9/8QnORdjLv/LI6LeVDxczpLbWfMWA8JASGY=@vger.kernel.org, AJvYcCWtpdhJfVVcbI++sm9qYQXuDvFFa/z8W27l4CgSiGStsQOumx5cFLIPPGfqXtrGPxv3UwyQB9W4@vger.kernel.org, AJvYcCX4aI1OkbVCkO3dZ6bdwISAOJtS2vCZ1CF3fAxLy17kqeDR8q2pU0S7QbFKdxdtR1xyyee7e3puIbu7@vger.kernel.org, AJvYcCXUQKrQ0wF2qtY5oOa9v8p6wlWfobcXO5/U5rTmHbot+cStJfWy9e8YNroJ/OujX0M56A8RadBWFo56C5Au@vger.kernel.org, AJvYcCXY8EACV/lA1hY4o105sAatpGB/KNJov3S+W3coJ80N7vX7AIPEuzTtyntcHkwCiXa2gU52CJ33xaTWuA==@vger.kernel.org, AJvYcCXxX0J4F8Jj8JiKybWKhtXJg0TOQObvD7HIyKoS1Z27pLyIO51GPCyfC+8SG5g4c99TNOp2nxcMW2dO@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7xZHmlYBFjisBzLTlIh6j1zZY0Cd8IVSNcA7I2X0h04MqW17
	s6eRsNRpJOsrbCMXi9rC9QmOvf5t68olKOc+D9AKSQH4U4fcBckxUY09lkHaqTZEgI2ORXAUMdR
	3EbLSjbuinzW+g692W18EmOZEMbiJEKd9
X-Gm-Gg: ASbGncsTONgZgyE2X7IM4+HIcEKSBdwCbzhE8lgyqlRee7wuV/6sHzIVCQ8BbLLN4X2
	srNBsmR44ZzqwPIXkj2mCY1gDkL92LMaOmpZv
X-Google-Smtp-Source: AGHT+IHp1K2L48YKiIQv0pwnQlZPYX8cMCBbRBU/fwg+IEmnnlA8QF5/odQWLMrNcSpCZK0F/LO3cHqTWVNEZ39orXM=
X-Received: by 2002:a05:6000:480a:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-38a221fa8c6mr57843141f8f.33.1736246835555; Tue, 07 Jan 2025
 02:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com> <20250107085646.42302-1-kuniyu@amazon.com>
In-Reply-To: <20250107085646.42302-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 7 Jan 2025 18:46:38 +0800
Message-ID: <CABAhCOQAqspiaFO-486UtZpEWsua51f+1f6-LocNhHVfAqW=NQ@mail.gmail.com>
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
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Sat,  4 Jan 2025 20:57:21 +0800
[...]
> > - In amt_newlink() drivers/net/amt.c:
> >
> >     amt->net =3D net;
> >     ...
> >     amt->stream_dev =3D dev_get_by_index(net, ...
> >
> >   Uses net, but amt_lookup_upper_dev() only searches in dev_net.
> >   So the AMT device may not be properly deleted if it's in a different
> >   netns from lower dev.
>
> I think you are right, and the upper device will be leaked
> and UAF will happen.
>
> amt must manage a list linked to a lower dev.
>
> Given no one has reported the issue, another option would be
> drop cross netns support in a short period.

Yes. I also noticed AMT sets dev->netns_local to prevent netns
change. Probably it also assumes the same netns during creation.

[...]
> >
> > - In gtp_newlink() in drivers/net/gtp.c:
> >
> >     gtp->net =3D src_net;
> >     ...
> >     gn =3D net_generic(dev_net(dev), gtp_net_id);
> >     list_add_rcu(&gtp->list, &gn->gtp_dev_list);
> >
> >   Uses src_net, but priv is linked to list in dev_net. So it may not be
> >   properly deleted on removal of link netns.
>
> The device is linked to a list in the same netns, so the
> device will not be leaked.  See gtp_net_exit_batch_rtnl().
>
> Rather, the problem is the udp tunnel socket netns could be
> freed earlier than the dev netns.

Yes, you're right. Actually I mean the netns of the socket by "link netns"
(there's some clarification about this in patch 02).

[...]
> >
> > - In pfcp_newlink() in drivers/net/pfcp.c:
> >
> >     pfcp->net =3D net;
> >     ...
> >     pn =3D net_generic(dev_net(dev), pfcp_net_id);
> >     list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
> >
> >   Same as above.
>
> I haven't tested pfcp but it seems to have the same problem.
>
> I'll post patches for gtp and pfcp.
>

It would be nice.

>
> >
> > - In lowpan_newlink() in net/ieee802154/6lowpan/core.c:
> >
> >     wdev =3D dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK])=
);
> >
> >   Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
> >   in link netns.
>
> I guess you mean the ifindex is defined in src_net instead.
> Not sure if it's too late to change the behaviour.

Yes, it's source net for lowpan. I think it depends on whether
the interpretation of IFLA_LINK should be considered as part API
provided by rtnetlink core, or something customizable by driver.
In the former case, this can be considered as a bug.

Thanks.

