Return-Path: <linux-kselftest+bounces-23177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D779ECDB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 14:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C289163CCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BED23369C;
	Wed, 11 Dec 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noX0duqL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA22210E5;
	Wed, 11 Dec 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925250; cv=none; b=Zu1GXyP39HECA1fyd64njf6p4Q5cAe2z5K1Uy9qN1v805PboeaYyInY9SRrv+w/YI+teSFKOD1LGQqBWDZlNxyCFWDHKbG+23JVVsHvAToKfkslRoVWyAk/Kfa1xS65fkVq1PzDje7uuAlpzxn18vhBlkt9xRDPgey0Irf/qr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925250; c=relaxed/simple;
	bh=QB4Bow+9GW0sBUE37UabSea3Zhi+ysLLX4vFFDn9Agc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHvgoj972XfMODDOG8Tamb7HP5AYkpo+gRDPmwdQSP/fTqMrghIlJOIrlJwL+vMkK9fUmSjieBIT60dUp/F8ZZm8mi/9fAqG1PgP7AARsC+Y/ygeZEwNAZDGxB2GuX4rj2UJdaEJ6Y2T0zUxmCX/RO2Ow1iPJkSYU5lABUvVA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noX0duqL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso7864095e9.3;
        Wed, 11 Dec 2024 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733925247; x=1734530047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3/6/j3h6dqCxjpmQkBhTHb5v4QS1qnzY1GCaBF3fRM=;
        b=noX0duqLDwxd4vhkh+/vtsXDBpRyPAirRnPJBY3bZE+jSePb5F6fvxnCLm3KGa1/zZ
         42rn4RfiY52F2is05aSHjIzhD0t0sJ6/7GZhE9iDsgOW91Z7JOKc/90qEbM7BYYeKfzu
         0ucuqp4IyUB9hCPkNJmE7I8EqUjVrpivvcPVguDtfk8ZG6QDMFcqqFxmWHaPdpTdvQRs
         R/ghqbUFu/NhxXBVjaKv2D/BmPYIF+POwwuH8mN8vhFYvh8ihQDYvVCn8AGSIPaP7Z7l
         QXtVh+Y/gQ2rYrYTy8jTFETMPEFsfjcytH+Fz85YqZ9SyfwrCiF3/FuxKQGMBo/RUc1D
         2vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925247; x=1734530047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3/6/j3h6dqCxjpmQkBhTHb5v4QS1qnzY1GCaBF3fRM=;
        b=d4CrHn1U687o0KxEHeBeggJwVjM3bBGluHk+1wSx7BMFJ0OokT3/OrhRlqYrXz2saC
         kERuW8x/0115uQlhc3R5UHU7cjhMUE/WNClwaoXHYnaNKdu6qzfq6GkOVM2GYy+F6ZYh
         t9/O1tnRpJpq/Mq57i/7ekLcTUCxW7GczIaAAwXyoxb8geesUV25RUBePbSPQzxq1o2U
         bvDtHiiGZ3yaVYhnBQiQqVeCXmd86lIrsieVJFkp1H3vAjf0J9RJlS0ZhtaFuCuj3SGB
         T5heJ5Uym7rKjLI06GX2gNMiZ6ZCwEunrTB7hsJbUhcrFQ/uHn6NpY4R7Fm7GBgjSP5U
         74jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC/Zt4LaBFnCWPNN+hp6Pe6fFs2v3ZNPKNEtFvdzHJok4O1oQ11dfqpf281Jd4qB2yIF0biAODPWNFHjA=@vger.kernel.org, AJvYcCXZVA4y3ra+HeiiNLuyq3o2W8YnG//x7Y6jGByCq107S6SO9UAWb93rrSnHzIBe7gGjwFvOW5o3rEqTRmBcvIwz@vger.kernel.org
X-Gm-Message-State: AOJu0YwYo5iaJuu6Ri+Vjgw81vj/xsX/7wF4k+Dtzq7ZqWlXQior/ByN
	htCvcp6JhMHNfkJkH3rqcoqJ99rE3LclmnpEKjD/IY+6cQTjBgwYPGevH2vq5I6Qq/MgFMeVpea
	QdHrcYWC71XISD/QNJuNhnYSOKpQ=
X-Gm-Gg: ASbGncu3TGJMoVSDT/wlUTwryVqpKxebeMR0XgVYTrm9s1SkeLNd4EwuY71378C22Ir
	lQIJd/PzyMcSfSJlrGM89qB2Wx7L2RXSWBw==
X-Google-Smtp-Source: AGHT+IG5uplu66yszvnKS/2I3ATE07NcmoaF7cAUKph8S7T8gYDj11TPtCcXXAz4sgaZkJG1rKR3/VRBzw59Xp44jEA=
X-Received: by 2002:a05:600c:3b84:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-4361c43d3d2mr20361295e9.27.1733925246491; Wed, 11 Dec 2024
 05:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-17-ea243cf16417@openvpn.net> <CABAhCOSJCoZFuevjcwvdJ+==TpGEJZPmvvHfT=U3Kf_-Ob+BnA@mail.gmail.com>
 <5a3d1c9b-f000-45c1-afd3-c7a10d2a50e8@openvpn.net> <CABAhCOSNRu1QfVr_0Las+dSMsbrVE=HLT6pzqQHODkUTxBi0-Q@mail.gmail.com>
 <4471b912-d8df-41ba-9c3b-a46906ca797d@openvpn.net>
In-Reply-To: <4471b912-d8df-41ba-9c3b-a46906ca797d@openvpn.net>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 11 Dec 2024 21:53:28 +0800
Message-ID: <CABAhCOT-waHW4HJ30a6qLoRBTQN67Y4PmFD0djCoP4iRYnQ5Kg@mail.gmail.com>
Subject: Re: [PATCH net-next v14 17/22] ovpn: implement peer
 add/get/dump/delete via netlink
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, 
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:51=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
>
> On 11/12/2024 13:35, Xiao Liang wrote:
> > On Wed, Dec 11, 2024 at 7:30=E2=80=AFPM Antonio Quartulli <antonio@open=
vpn.net> wrote:
> >>
> >> Hi Xiao and thanks for chiming in,
> >>
> >> On 11/12/2024 04:08, Xiao Liang wrote:
> >>> On Mon, Dec 9, 2024 at 6:48=E2=80=AFPM Antonio Quartulli <antonio@ope=
nvpn.net> wrote:
> >>> [...]
> >>>> +/**
> >>>> + * ovpn_nl_peer_modify - modify the peer attributes according to th=
e incoming msg
> >>>> + * @peer: the peer to modify
> >>>> + * @info: generic netlink info from the user request
> >>>> + * @attrs: the attributes from the user request
> >>>> + *
> >>>> + * Return: a negative error code in case of failure, 0 on success o=
r 1 on
> >>>> + *        success and the VPN IPs have been modified (requires reha=
shing in MP
> >>>> + *        mode)
> >>>> + */
> >>>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_=
info *info,
> >>>> +                              struct nlattr **attrs)
> >>>> +{
> >>>> +       struct sockaddr_storage ss =3D {};
> >>>> +       struct ovpn_socket *ovpn_sock;
> >>>> +       u32 sockfd, interv, timeout;
> >>>> +       struct socket *sock =3D NULL;
> >>>> +       u8 *local_ip =3D NULL;
> >>>> +       bool rehash =3D false;
> >>>> +       int ret;
> >>>> +
> >>>> +       if (attrs[OVPN_A_PEER_SOCKET]) {
> >>>
> >>> Similar to link attributes in other tunnel drivers (e.g. IFLA_GRE_LIN=
K,
> >>> IFLA_GRE_FWMARK), user-supplied sockets could have sockopts
> >>> (e.g. oif, fwmark, TOS). Since some of them may affect encapsulation
> >>> and routing decision, which are supported in datapath? And do we need
> >>> some validation here?
> >>
> >> Thanks for pointing this out.
> >> At the moment ovpn doesn't expect any specific socket option.
> >> I haven't investigated how they could be used and what effect they wou=
ld
> >> have on the packet processing.
> >> This is something we may consider later.
> >>
> >> At this point, do you still think I should add a check here of some so=
rt?
> >>
> >
> > I think some sockopts are important. Especially when oif is a VRF,
> > the destination can be totally different than using the default routing
> > table. If we don't support them now, it would be good to deny sockets
> > with non-default values.
>
> I see - openvpn in userspace doesn't set any specific oif for the
> socket, but I understand ovpn should at least claim that those options
> are not supported.
>
> I am a bit lost regarding this aspect. Do you have a pointer for me
> where I can see how other modules are doing similar checks?
>

The closest thing I can find is L2TP, which has some checks in
l2tp_validate_socket(). However, it uses ip_queue_xmit() /
inet6_csk_xmit() to send packets, where many sockopts are handled.
Maybe someone else can give a more suitable example. I guess we
can start with sockopts relevant to fields in struct flowi{4,6} and encap
headers?
Or at least add some documentation about this.

> >
> >>>
> >>> [...]
> >>>> +static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl=
_info *info,
> >>>> +                            const struct ovpn_peer *peer, u32 porti=
d, u32 seq,
> >>>> +                            int flags)
> >>>> +{
> >>>> +       const struct ovpn_bind *bind;
> >>>> +       struct nlattr *attr;
> >>>> +       void *hdr;
> >>>> +
> >>>> +       hdr =3D genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags=
,
> >>>> +                         OVPN_CMD_PEER_GET);
> >>>> +       if (!hdr)
> >>>> +               return -ENOBUFS;
> >>>> +
> >>>> +       attr =3D nla_nest_start(skb, OVPN_A_PEER);
> >>>> +       if (!attr)
> >>>> +               goto err;
> >>>> +
> >>>> +       if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
> >>>> +               goto err;
> >>>> +
> >>>
> >>> I think it would be helpful to include the netns ID and supported soc=
kopts
> >>> of the peer socket in peer info message.
> >>
> >> Technically the netns is the same as where the openvpn process in
> >> userspace is running, because it'll be it to open the socket and pass =
it
> >> down to ovpn.
> >
> > A userspace process could open UDP sockets in one namespace
> > and the netlink socket in another. And the ovpn link could also be
> > moved around. At this moment, we can remember the initial netns,
> > or perhaps link-netns, of the ovpn link, and validate if the socket
> > is in the same one.
> >
>
> You are correct, but we don't want to force sockets and link to be in
> the same netns.
>
> Openvpn in userspace may have been started in the global netns, where
> all sockets are expected to live (transport layer), but then the
> link/device is moved - or maybe created - somewhere else (tunnel layer).
> This is not an issue.
>
> Does it clarify?

If netns id is not included, then when the link has been moved,
we can't infer which netns the socket is in from peer info message,
thus can not figure out how packets are routed. Other tunnel drivers
usually use IFLA_LINK_NETNSID for this. Probably have a look at
rtnl_fill_link_netnsid()?

Thanks.

