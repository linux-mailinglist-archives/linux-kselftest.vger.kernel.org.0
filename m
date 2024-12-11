Return-Path: <linux-kselftest+bounces-23181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3EA9ECEC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 15:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD6165CC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95740185939;
	Wed, 11 Dec 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMjz4VGo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D4183CBB;
	Wed, 11 Dec 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927895; cv=none; b=TTYyS0o+AiqnxNNwNzWsYFXIISsWQCIvBF/zZq1vrZdJNnkbEDL3EzWDKHQuEmY44kKvxfVqvpjoVAFx/XoWNML+ME/uSPZnLgKdIln3Ub4HTS7WN/KTLqQPiBY/EqBBS8Y7ieuYFM7suMaQMta00ZhHmxZYhQCFMwzIsw+49/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927895; c=relaxed/simple;
	bh=eDn/KEEuWg9ykTMqAFi7uDaqkbW37rB44oyXqF55IWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kefpj0CzaocnDTM4yJPmdWmtMQ7k6G9cw5N54scJP8dsOS0q6/ty7EEpfy29QCuCmj4bxS6pAQ1TxI4Fgsc55dz89DH9oYOwlV0HUycu5U4AhurEW6AA1gtk8CnIiPX71ZcUCZAWoqYBbhwP0wIKqDxq4R39tmqackTyIzBN9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMjz4VGo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434e3953b65so31492175e9.1;
        Wed, 11 Dec 2024 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733927892; x=1734532692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQuPW53YSaLNHqZEn69qaiJmpFeJpkI4ahVvWi4pfW4=;
        b=PMjz4VGo2vZ9wBRId7nnyDP3M9MpITPk9KPt5TCwDyInysIQTbEDcVKbLjUdEnJpOh
         wokbIAOKVLSEIsD17f4hpKpAZhp66An2ZvASp2oMjSO9m4sy/0oxKOC58TKlQOytjfbN
         U3MmIapKD7I53lMbYnNwRQtbJBeorFHZq2dg/jS8tYdOaeiBDr5oTR1uLhpkVcjPNJN6
         k3eAQFpn4aHFvIcS5+rTjepcmcytKEmuFK+pbF4PtLnnipKMB8Ct+qK9cvAzO6+4eWGr
         ZEestMefVEPd2iaV3enlg/fq+sp0d1U4uGGC3+NoU277XS8avgA6EA5ZUj9l4UQcGef4
         WRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733927892; x=1734532692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQuPW53YSaLNHqZEn69qaiJmpFeJpkI4ahVvWi4pfW4=;
        b=hr87bxoJsQcSwIsbb9TSjqxeB2/007hgmrTyibJxWED/PxFnQV9TAHVxGnozDrHhiU
         CHa7WkdhB5ppBUe6Bg/D8s7wVkct0C/s9HmZpn2BV1KpK6i4aU35F/Wq+IyfnpAWBsGK
         xaooZjoW8Ys/+D/OAyR2EZWImBtnVqm2TyAjmUYC6WfRJcSRN7tapEbi+Ekq9omr8yqY
         /+QHFFwFo64FaFJJg4vYztH0xsifvnHJi3bsggpiBx7/eAif9VqyPv1DO3XuVcXvXcS2
         s07OFX7c9alLbtUCHXMVsXlt8zVQcQE3ZSY+JS4674KwJg/SJzoPt6bIE8VBFHX0iyCT
         qw0A==
X-Forwarded-Encrypted: i=1; AJvYcCVYJ92Q7/Oog3Oxg/wrLkfkuTVdeJAhjoIR+StzHa5l6PrXXYhGCXYAWIe++hBa5F2fywjtaSrMDnK9w+c=@vger.kernel.org, AJvYcCX20cghMooYaQJ8TJJiHUv0AmxG8qScJ5/ewIllHs0myBnEUjtukHPig8C6PvBe0I+4oUlICIuat7nSidILdV9S@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoqY5lYph80c4JxgkOVqfFk8Mip0AU4ZgUWMniQ8ej9arR+Cp
	e+TN6YLEjJO0OdeFw4+1kObGgYUinjt2SuhlKBJzyqruHaXQOVhn7JW9RAHgegOdsFf+pOmpi8e
	vRuYYMte9JGDPoZpSDVIiOlsT11ka6C+rQ4saYjw7
X-Gm-Gg: ASbGncvnaVbPJ3JhZ71KOzYJ4CwLufoXDkeyyqfT6cXBtd/4VehOXPLwMGE609mSvr7
	2rUlZ7/YJGzMNo0BBp5nh7l96AxA2fMHxTg==
X-Google-Smtp-Source: AGHT+IEyDUgLjsh47qA+3KzQCjlYxJ7r0aym9yvvdF+I9bFcJhBWyOtYgyrHdwfNn+9MVP1MFQLIy/+GxNFq6HkmIEY=
X-Received: by 2002:a5d:5886:0:b0:385:faad:bfb9 with SMTP id
 ffacd0b85a97d-3864ce8644emr2517003f8f.8.1733927891701; Wed, 11 Dec 2024
 06:38:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-17-ea243cf16417@openvpn.net> <CABAhCOSJCoZFuevjcwvdJ+==TpGEJZPmvvHfT=U3Kf_-Ob+BnA@mail.gmail.com>
 <5a3d1c9b-f000-45c1-afd3-c7a10d2a50e8@openvpn.net> <CABAhCOSNRu1QfVr_0Las+dSMsbrVE=HLT6pzqQHODkUTxBi0-Q@mail.gmail.com>
 <4471b912-d8df-41ba-9c3b-a46906ca797d@openvpn.net> <CABAhCOT-waHW4HJ30a6qLoRBTQN67Y4PmFD0djCoP4iRYnQ5Kg@mail.gmail.com>
 <42e268a6-e0d1-4892-b76a-68ba937e29bf@openvpn.net>
In-Reply-To: <42e268a6-e0d1-4892-b76a-68ba937e29bf@openvpn.net>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 11 Dec 2024 22:37:34 +0800
Message-ID: <CABAhCOQ=9NVXGUF7kc0pjtvcw9S__OHhDJ-YEeY2HDr9eoeSyQ@mail.gmail.com>
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

On Wed, Dec 11, 2024 at 10:07=E2=80=AFPM Antonio Quartulli <antonio@openvpn=
.net> wrote:
>
> On 11/12/2024 14:53, Xiao Liang wrote:
> > On Wed, Dec 11, 2024 at 8:51=E2=80=AFPM Antonio Quartulli <antonio@open=
vpn.net> wrote:
> >>
> >> On 11/12/2024 13:35, Xiao Liang wrote:
> >>> On Wed, Dec 11, 2024 at 7:30=E2=80=AFPM Antonio Quartulli <antonio@op=
envpn.net> wrote:
> >>>>
> >>>> Hi Xiao and thanks for chiming in,
> >>>>
> >>>> On 11/12/2024 04:08, Xiao Liang wrote:
> >>>>> On Mon, Dec 9, 2024 at 6:48=E2=80=AFPM Antonio Quartulli <antonio@o=
penvpn.net> wrote:
> >>>>> [...]
> >>>>>> +/**
> >>>>>> + * ovpn_nl_peer_modify - modify the peer attributes according to =
the incoming msg
> >>>>>> + * @peer: the peer to modify
> >>>>>> + * @info: generic netlink info from the user request
> >>>>>> + * @attrs: the attributes from the user request
> >>>>>> + *
> >>>>>> + * Return: a negative error code in case of failure, 0 on success=
 or 1 on
> >>>>>> + *        success and the VPN IPs have been modified (requires re=
hashing in MP
> >>>>>> + *        mode)
> >>>>>> + */
> >>>>>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct gen=
l_info *info,
> >>>>>> +                              struct nlattr **attrs)
> >>>>>> +{
> >>>>>> +       struct sockaddr_storage ss =3D {};
> >>>>>> +       struct ovpn_socket *ovpn_sock;
> >>>>>> +       u32 sockfd, interv, timeout;
> >>>>>> +       struct socket *sock =3D NULL;
> >>>>>> +       u8 *local_ip =3D NULL;
> >>>>>> +       bool rehash =3D false;
> >>>>>> +       int ret;
> >>>>>> +
> >>>>>> +       if (attrs[OVPN_A_PEER_SOCKET]) {
> >>>>>
> >>>>> Similar to link attributes in other tunnel drivers (e.g. IFLA_GRE_L=
INK,
> >>>>> IFLA_GRE_FWMARK), user-supplied sockets could have sockopts
> >>>>> (e.g. oif, fwmark, TOS). Since some of them may affect encapsulatio=
n
> >>>>> and routing decision, which are supported in datapath? And do we ne=
ed
> >>>>> some validation here?
> >>>>
> >>>> Thanks for pointing this out.
> >>>> At the moment ovpn doesn't expect any specific socket option.
> >>>> I haven't investigated how they could be used and what effect they w=
ould
> >>>> have on the packet processing.
> >>>> This is something we may consider later.
> >>>>
> >>>> At this point, do you still think I should add a check here of some =
sort?
> >>>>
> >>>
> >>> I think some sockopts are important. Especially when oif is a VRF,
> >>> the destination can be totally different than using the default routi=
ng
> >>> table. If we don't support them now, it would be good to deny sockets
> >>> with non-default values.
> >>
> >> I see - openvpn in userspace doesn't set any specific oif for the
> >> socket, but I understand ovpn should at least claim that those options
> >> are not supported.
> >>
> >> I am a bit lost regarding this aspect. Do you have a pointer for me
> >> where I can see how other modules are doing similar checks?
> >>
> >
> > The closest thing I can find is L2TP, which has some checks in
> > l2tp_validate_socket(). However, it uses ip_queue_xmit() /
> > inet6_csk_xmit() to send packets, where many sockopts are handled.
>
> mhh l2tp_sk_to_tunnel() doesn't have more checks than what we already hav=
e.
>
> > Maybe someone else can give a more suitable example. I guess we
> > can start with sockopts relevant to fields in struct flowi{4,6} and enc=
ap
> > headers?
>
> Since I have little experience with sockopts in general, and this is not
> truly mission critical, how would you feel about sending a patch for
> this once ovpn has been merged?
> I'd truly appreciate it.

Honestly I'm not an expert on this. Will see if I can.

>
> >
> >>>
> >>>>>
> >>>>> [...]
> >>>>>> +static int ovpn_nl_send_peer(struct sk_buff *skb, const struct ge=
nl_info *info,
> >>>>>> +                            const struct ovpn_peer *peer, u32 por=
tid, u32 seq,
> >>>>>> +                            int flags)
> >>>>>> +{
> >>>>>> +       const struct ovpn_bind *bind;
> >>>>>> +       struct nlattr *attr;
> >>>>>> +       void *hdr;
> >>>>>> +
> >>>>>> +       hdr =3D genlmsg_put(skb, portid, seq, &ovpn_nl_family, fla=
gs,
> >>>>>> +                         OVPN_CMD_PEER_GET);
> >>>>>> +       if (!hdr)
> >>>>>> +               return -ENOBUFS;
> >>>>>> +
> >>>>>> +       attr =3D nla_nest_start(skb, OVPN_A_PEER);
> >>>>>> +       if (!attr)
> >>>>>> +               goto err;
> >>>>>> +
> >>>>>> +       if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
> >>>>>> +               goto err;
> >>>>>> +
> >>>>>
> >>>>> I think it would be helpful to include the netns ID and supported s=
ockopts
> >>>>> of the peer socket in peer info message.
> >>>>
> >>>> Technically the netns is the same as where the openvpn process in
> >>>> userspace is running, because it'll be it to open the socket and pas=
s it
> >>>> down to ovpn.
> >>>
> >>> A userspace process could open UDP sockets in one namespace
> >>> and the netlink socket in another. And the ovpn link could also be
> >>> moved around. At this moment, we can remember the initial netns,
> >>> or perhaps link-netns, of the ovpn link, and validate if the socket
> >>> is in the same one.
> >>>
> >>
> >> You are correct, but we don't want to force sockets and link to be in
> >> the same netns.
> >>
> >> Openvpn in userspace may have been started in the global netns, where
> >> all sockets are expected to live (transport layer), but then the
> >> link/device is moved - or maybe created - somewhere else (tunnel layer=
).
> >> This is not an issue.
> >>
> >> Does it clarify?
> >
> > If netns id is not included, then when the link has been moved,
> > we can't infer which netns the socket is in from peer info message,
> > thus can not figure out how packets are routed. Other tunnel drivers
> > usually use IFLA_LINK_NETNSID for this. Probably have a look at
> > rtnl_fill_link_netnsid()?
> >
>
> Ok, I see what you mean.
> I was assuming this was not needed, because we'd always have a running
> openvpn process and it would live in the socket netns.
> But it still makes sense to report it with the peer info.
>
> I'll add this new attribute and fill it on PEER_GET.
>

That would be nice. Thanks!

