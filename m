Return-Path: <linux-kselftest+bounces-24071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED105A0637A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 18:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1403A1394
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A503A20010B;
	Wed,  8 Jan 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHciAqjY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592F1A2541;
	Wed,  8 Jan 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357501; cv=none; b=e3K7HSH1ColxvRm7q1LA5N+ebyq0UT25YSvEp39h5jMDufWKMZAT+S392H1Xk2acbXVMLNDi99pJfqdkau4NKt107oigXZqPoQYX7xiV3OmqLVHbqsv2fkCEmrRuEs5QfT4Lzbt9OGbWUqT1mezrv9SXN8tPiZURcHxlVC4QJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357501; c=relaxed/simple;
	bh=nFNghkqYK0OyBrmna6riJjtdRf/DJ2kks0ygjdBlGVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdVuEVCtu9hO2jJQ4QF/RHTNX6uHNrJozYhfwYlrTxx5JYmUmx9RTjElJn3iH/uV3hkyIxgjRg0kNkCOL6vzggd0ANi90za6VMeX+Q8gIkfuTnFJFOmEioi8/mVAELz+elq+KP2sjCSbO9dQM2H9a4Za/AGCewQuNRKgVpDMTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHciAqjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A24C4CED3;
	Wed,  8 Jan 2025 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736357500;
	bh=nFNghkqYK0OyBrmna6riJjtdRf/DJ2kks0ygjdBlGVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dHciAqjYDmfJ4f1GrLA+k2mHdvH/PcVoEoaHp5l6oKUNCl2H/rGngM0bwH32RiDGA
	 RKqyu4tcA5nz7uUemz8c9pBwQy5/Yl8okpkaljtV2r2hG4AolL+jj/8d3xoqFgJj/k
	 A8Gm9TIsj/lz+b3kQ9boVv/nZhWvr6TKHL4QkMBonYptSr9cZeQpQoKuXcOHybpkHo
	 e98f1a4tvA5J5nyWISRW/K9JoOD2UBjXudUvXF9tlj/7wrEctr/u5Qqq3QhEk/fT8p
	 UuTt5BSsN/f7ZpDAzFwxdIWvEiqXFx0/T5vxvOySo2ialJKoOi0JYP1ThEhqIye8Rl
	 dB8lzKIIuuacA==
Date: Wed, 8 Jan 2025 09:31:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 02/11] rtnetlink: Pack newlink() params into
 struct
Message-ID: <20250108093139.126716e9@kernel.org>
In-Reply-To: <CABAhCORV_s9m-EJ8914zUXCXt6O_e1wsaOVdSKUtm0Rbvc4orQ@mail.gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
	<20250104125732.17335-3-shaw.leon@gmail.com>
	<20250107123805.748080ab@kernel.org>
	<CABAhCORV_s9m-EJ8914zUXCXt6O_e1wsaOVdSKUtm0Rbvc4orQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 16:36:26 +0800 Xiao Liang wrote:
> On Wed, Jan 8, 2025 at 4:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Sat,  4 Jan 2025 20:57:23 +0800 Xiao Liang wrote: =20
> > > -static int amt_newlink(struct net *net, struct net_device *dev,
> > > -                    struct nlattr *tb[], struct nlattr *data[],
> > > -                    struct netlink_ext_ack *extack)
> > > +static int amt_newlink(struct rtnl_newlink_params *params)
> > >  {
> > > -     struct amt_dev *amt =3D netdev_priv(dev);
> > > +     struct netlink_ext_ack *extack =3D params->extack;
> > > +     struct net_device *dev =3D params->dev;
> > > +     struct nlattr **data =3D params->data;
> > > +     struct nlattr **tb =3D params->tb;
> > > +     struct net *net =3D params->net;
> > > +     struct amt_dev *amt; =20
> >
> > IMHO you packed a little too much into the struct.
> > Could you take the dev and the extack back out? =20
>=20
> Sure. I thought you were suggesting packing them all
> in review of v3...

Sorry about that, I wasn't very clear :(

What I had in mind was similar to how we define ethtool ops,
(especially the more recent ones which have extack)
for example:

	int	(*set_mm)(struct net_device *dev, struct ethtool_mm_cfg *cfg,
			  struct netlink_ext_ack *extack);

