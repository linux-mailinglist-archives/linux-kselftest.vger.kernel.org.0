Return-Path: <linux-kselftest+bounces-23175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE629ECC22
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 13:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF511889252
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B39722686D;
	Wed, 11 Dec 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blc9NYK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1425225A52;
	Wed, 11 Dec 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920596; cv=none; b=gDOIKfNFZAQnjMETwT5AUDf7v2hm9KrDpX4X19h3qsBicn9TeYtiUmWx2MK+KPYuY21Pe/pk+1omSseHtXu7S3MAodnUVhDxyfh09VjDa50C09IwzB5PShrCAnON4pEMWx4TSBKSeeLbub+szUwsg/nONRF2k+ifPON2qzHwa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920596; c=relaxed/simple;
	bh=d+3c4oeYnNG5VZggoWcVgV1cEkYGeGV7XnEQJqAKBEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/vYXWv5YstD9xozOvFqUq1+lGUaEetiSdeBNravRoCJ86/Fb+3JOCFcd+Z8pZExcBuu/NdApguItWCY0+Qq919XIGQwYmQFHjJW1lDzl9FNCB0uouhI5OB0U0VCmRqT2mUgA3cpu+wjyT9tZJRsOLHaa26Tge6lzuos7k5nko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Blc9NYK5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43621d27adeso205085e9.2;
        Wed, 11 Dec 2024 04:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733920593; x=1734525393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/kOzw7CTerxYmVUA4xiFtkocX/wHzc5BLZXQPSJs9I=;
        b=Blc9NYK5xWGcCijNTGZ0b1vxDI6R+OXpacc1sG53HqnCYKazvT09dxi1XcNVoa0qvD
         PcgbnZ1aBq01c3B9VZ/KnZoTG8QPTePbbJCpDtaFLDkKBiaj+gpQYfDnkLKuNgUVW+SK
         fFRmh4oJuRVelwfROi9ywtVSjAXtNN27k7Ur8l3PHGi/P7lzXg2WLC0ro53lyPBReIrr
         eFZ8fNbLcAMlkZOzut5eQ1CgjTNWyKcsaMzU5iH/iP7oIx/ZQ6VXV00IRqCrE1bcWrvO
         XUDQvp5Zjee+XIncTBh6vAqGIe1NfXDtNjZrG9ltyaU7MBZax9HiWKdBQ2YJ5CbyYBMm
         5g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733920593; x=1734525393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/kOzw7CTerxYmVUA4xiFtkocX/wHzc5BLZXQPSJs9I=;
        b=q1XMFIoC1dfptG62almVSOO9q0rY7s51kEJLztZ1SFWS+XBOVhSjZM2aLWYQj7BZEl
         Z+nkS7lB4jlffaIlWqGN5LvYdMBAIp4c0eyrAvktAHMT7p8XiMbC9W0f/EncPRVRBin6
         LiIQa0FQfzkSqpxTGMpvs3GPyaB0Qdyg09hdVLPglIYNzrqUWT/CjBpK9JxGGSB7NQY+
         6KKzMTv0133+AVHO/4vjZZwww+LJMshjaUc5Ak7ewcbAH34XsRUu/8Miu3l3XvmS6Kvd
         klBNbDZqKwh71wlCBtqNQkSBEsiEgt3yS9lgE2JU9Auvt8jjmsP7C0rt39n6FD+AP6+x
         Fylw==
X-Forwarded-Encrypted: i=1; AJvYcCV6A7TQBkOFqr4wSPoAX85WvgCbmGVMIoT5N/JSVbcv69ADh2l06aqoC+4Ntq/N2mWexbi+NOdePGxc/g11c6pz@vger.kernel.org, AJvYcCXyITyGFS9ihC1M6MUAo9BD439RFIF0kyAkc3qmVQOU+uKDqoe1LiJQwf9hgLuAMfVjIXXNlcX9D+iIKLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3K0X+4gmzhhBcgBvhizqUs0ave/cSFNFiQ5497Sw4wKh79O4L
	Wsfwpo4HERannxdQWH2vH+NXTEUkhCFy8z8/FwLuOMkHl5BpjjXPLqnEJ2DA8gdncAkl4m3y+Q/
	CXhBx2/SthpJkzlpjML0L1Hw+KHE=
X-Gm-Gg: ASbGncv8t/V33i2wGNGCotyO2MQu4vzxQ2niKl5PnKhSkw3bnsZJGMtCJhga4+08myE
	hVqOlKnCv7Texx9cfALRJn+n71R/vuxu4ng==
X-Google-Smtp-Source: AGHT+IGDXwe2mrxulLuRTp4RHhGp2pKNTl00StdYb7EW+YLHYwkZN1XElvD83fcuTqegxhuiCCpTxdRdc8oRwqvuzxk=
X-Received: by 2002:a05:6000:471b:b0:385:e88b:1a76 with SMTP id
 ffacd0b85a97d-3864ce601cbmr2245543f8f.30.1733920592915; Wed, 11 Dec 2024
 04:36:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-17-ea243cf16417@openvpn.net> <CABAhCOSJCoZFuevjcwvdJ+==TpGEJZPmvvHfT=U3Kf_-Ob+BnA@mail.gmail.com>
 <5a3d1c9b-f000-45c1-afd3-c7a10d2a50e8@openvpn.net>
In-Reply-To: <5a3d1c9b-f000-45c1-afd3-c7a10d2a50e8@openvpn.net>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 11 Dec 2024 20:35:56 +0800
Message-ID: <CABAhCOSNRu1QfVr_0Las+dSMsbrVE=HLT6pzqQHODkUTxBi0-Q@mail.gmail.com>
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

On Wed, Dec 11, 2024 at 7:30=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
>
> Hi Xiao and thanks for chiming in,
>
> On 11/12/2024 04:08, Xiao Liang wrote:
> > On Mon, Dec 9, 2024 at 6:48=E2=80=AFPM Antonio Quartulli <antonio@openv=
pn.net> wrote:
> > [...]
> >> +/**
> >> + * ovpn_nl_peer_modify - modify the peer attributes according to the =
incoming msg
> >> + * @peer: the peer to modify
> >> + * @info: generic netlink info from the user request
> >> + * @attrs: the attributes from the user request
> >> + *
> >> + * Return: a negative error code in case of failure, 0 on success or =
1 on
> >> + *        success and the VPN IPs have been modified (requires rehash=
ing in MP
> >> + *        mode)
> >> + */
> >> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_in=
fo *info,
> >> +                              struct nlattr **attrs)
> >> +{
> >> +       struct sockaddr_storage ss =3D {};
> >> +       struct ovpn_socket *ovpn_sock;
> >> +       u32 sockfd, interv, timeout;
> >> +       struct socket *sock =3D NULL;
> >> +       u8 *local_ip =3D NULL;
> >> +       bool rehash =3D false;
> >> +       int ret;
> >> +
> >> +       if (attrs[OVPN_A_PEER_SOCKET]) {
> >
> > Similar to link attributes in other tunnel drivers (e.g. IFLA_GRE_LINK,
> > IFLA_GRE_FWMARK), user-supplied sockets could have sockopts
> > (e.g. oif, fwmark, TOS). Since some of them may affect encapsulation
> > and routing decision, which are supported in datapath? And do we need
> > some validation here?
>
> Thanks for pointing this out.
> At the moment ovpn doesn't expect any specific socket option.
> I haven't investigated how they could be used and what effect they would
> have on the packet processing.
> This is something we may consider later.
>
> At this point, do you still think I should add a check here of some sort?
>

I think some sockopts are important. Especially when oif is a VRF,
the destination can be totally different than using the default routing
table. If we don't support them now, it would be good to deny sockets
with non-default values.

> >
> > [...]
> >> +static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_i=
nfo *info,
> >> +                            const struct ovpn_peer *peer, u32 portid,=
 u32 seq,
> >> +                            int flags)
> >> +{
> >> +       const struct ovpn_bind *bind;
> >> +       struct nlattr *attr;
> >> +       void *hdr;
> >> +
> >> +       hdr =3D genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
> >> +                         OVPN_CMD_PEER_GET);
> >> +       if (!hdr)
> >> +               return -ENOBUFS;
> >> +
> >> +       attr =3D nla_nest_start(skb, OVPN_A_PEER);
> >> +       if (!attr)
> >> +               goto err;
> >> +
> >> +       if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
> >> +               goto err;
> >> +
> >
> > I think it would be helpful to include the netns ID and supported socko=
pts
> > of the peer socket in peer info message.
>
> Technically the netns is the same as where the openvpn process in
> userspace is running, because it'll be it to open the socket and pass it
> down to ovpn.

A userspace process could open UDP sockets in one namespace
and the netlink socket in another. And the ovpn link could also be
moved around. At this moment, we can remember the initial netns,
or perhaps link-netns, of the ovpn link, and validate if the socket
is in the same one.

Thanks.

> Therefore I am not sure there is any value in echoing back the netns ID.
> Wouldn't you agree?
>
> Regarding sockopts, as mentioned above, this is somewhat unsupported for
> now, so I Am not sure we have anything to send back.
>
>
> Regards,
>
> --
> Antonio Quartulli
> OpenVPN Inc.
>

