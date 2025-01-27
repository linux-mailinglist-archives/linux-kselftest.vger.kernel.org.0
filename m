Return-Path: <linux-kselftest+bounces-25245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF798A1DC09
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 19:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0136F1888A1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549518E37D;
	Mon, 27 Jan 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="A1zeyUFF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998DB13C9C4
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002588; cv=none; b=Ln2qczlEn4v7vHHjN37+BBgZiPINZIGLYev92RnTFXSZAkpSWnUOyYDFYbUVOfDPvz0uUra4plUTWZnIE7sIGz32wTNobWHG7skz3IAxjAIv7wYvcms1Sp5xQ1zO0BgF9pD7cNig2IIawsNju0vmA/2MUTIwsn+1iRW1FfufpeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002588; c=relaxed/simple;
	bh=6panixb/x0os5ZapLWWRdFuJUYpBXz06VpJ2DjP+mog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6LCAQ1N+ulMn/D3CUtj1WcXm3Eufg6X4yUVv6rhGkRqkAC5UBg8L7PVZ6ZpEAVEtutq5aDbu9b48BYMPW/NswGUkeM6RAKHK1PKyoF4IAlgBicY0s5Xch4eZc6/nWGNQqxR6Bbk8o4w1K+WugDEAy4pVv1dVs+TzkMy/izHUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=A1zeyUFF; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202501271829361827218133cdf42840
        for <linux-kselftest@vger.kernel.org>;
        Mon, 27 Jan 2025 19:29:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6panixb/x0os5ZapLWWRdFuJUYpBXz06VpJ2DjP+mog=;
 b=A1zeyUFFCuD1/01IlvyP8a7nStl/yDefRzLmN46eDButuHBxshahsCwHerO9PK5bZUwBaa
 JjuZ5wN8wapbhPC7RQH833+3AZaTuy5Hg9Ykwfzz2qbR4tv9DDUEljsoo1ZPr0Oe7Ctz7mC+
 wTnT8ep8aZOaz2/vVNjJtHPEGReehUgGbNGdIiGu/viqY/zVDKE21ZWEMttrkvLeZcasGW7/
 bUjQ/l9tUym2erHZPCi2O/EuxulhwAgkra8vG+fKXFKYgN5pwU4OI0YQpq+ElJ/AqKR+EZmY
 GFEQX2KONvo3NAcX/+vsmHnehfI7eOIDOwh9xoWZpnQY3dJH4fvY2VUg==;
Message-ID: <221bb71f7d2464cd566e4a4110423ea56b173cf6.camel@siemens.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v6 4/4] igc: Add launch time
 support to XDP ZC
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jakub Kicinski <kuba@kernel.org>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?=
	 <toke@redhat.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, "Song, Yoong Siang"
 <yoong.siang.song@intel.com>, "Bouska, Zdenek" <zdenek.bouska@siemens.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Bjorn Topel
 <bjorn@kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, "Damato, Joe" <jdamato@fastly.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Mina
 Almasry <almasrymina@google.com>, Daniel Jurgens <danielj@nvidia.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Date: Mon, 27 Jan 2025 19:29:35 +0100
In-Reply-To: <20250127100441.0b11e1b8@kernel.org>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
	 <20250116155350.555374-5-yoong.siang.song@intel.com>
	 <AS1PR10MB5675499EE0ED3A579151D3D3EBE02@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
	 <PH0PR11MB583095A2F12DA10D57781D18D8E02@PH0PR11MB5830.namprd11.prod.outlook.com>
	 <ea087229cc6f7953875fc69f1b73df1ae1ee9b72.camel@siemens.com>
	 <Z5KdSlzmyCKUyXTn@mini-arch> <87bjvwqvtl.fsf@toke.dk>
	 <20250127100441.0b11e1b8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2025-01-27 at 10:04 -0800, Jakub Kicinski wrote:
> On Fri, 24 Jan 2025 12:45:42 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > > > I think there is no simple fix for that. That needs some discussion
> > > > around the "expectations" to the headroom / meta data area in front=
 of
> > > > the actual packet data. =20
> > >=20
> > > By 'simple' you mean without some new UAPI to signal the size of that
> > > 'reserved area' by the driver? I don't see any other easy way out as =
well :-/ =20
> >=20
> > Yeah, I don't think we can impose UAPI restrictions on the metadata are=
a
> > at this point. I guess the best we can do is to educate users that they
> > should call the timestamp kfunc before they modify the metadata?
>=20
> I may be misunderstanding the discussion, but I think the answer=20
> is that the driver must be fixed. The metadata-in-prepend problem
> also exists for simple adjust head use case, so it existed since
> early days of BPF. The driver should copy out (or parse) the metadata
> before it invokes the XDP prog. The nfp driver does that.

That would have to happen for each packet, without affecting ZC
performance. How can that be achieved?

So we have at least two drivers with that problem, igc + nfp.=20

My main point: Enabling and implementing ZC (zero copy) mode at one
hand, but then starting to copy the meta data for each packet doesn't
sound reasonable.

