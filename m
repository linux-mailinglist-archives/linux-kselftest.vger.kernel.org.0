Return-Path: <linux-kselftest+bounces-25248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C07A1DC9E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 20:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92641885B5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E4F18FDC9;
	Mon, 27 Jan 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/EKy9Og"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B318A6CE;
	Mon, 27 Jan 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005648; cv=none; b=eoaSH+WsXJTuroO+GM/mPxvj39xskMYBHGQeFg/O9JOWLtuUzwK7ec78qT1ben7j5CLKCeG/Gw1XSTcqHZ/lSvT7qKwT3aPVknSnTCnf/4atc+fyFGEgo02Rnt1PqVHcw5ZUnY93+l2JXsiJAUERsTOFSuEQBEaxV1K0ykbkL9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005648; c=relaxed/simple;
	bh=YeJVXMPKQVT2qsyx36ahTAqXBMoa9oYa3q1Abfi3NGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVVEhHmCAhkG675aIOSq6SI7pIROOYAhiFg0EjFE36l+437MmP+va2Mp1BilJWpdvcA5cSV3ojLtP4s34US6S9y6Z5IC9Z4A4H5L6GMNcfkcNm65Q5UgglwlIAVX9gpa2WfK9AEc1gI2w89Z/yunCeb752BWeyztM/6vaCceetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/EKy9Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1C8C4CED2;
	Mon, 27 Jan 2025 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738005648;
	bh=YeJVXMPKQVT2qsyx36ahTAqXBMoa9oYa3q1Abfi3NGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/EKy9OgP8a/LbZ2+lTRgcEO98s5Q0e1iAJTMz4l9hD2J3dHrzjvTTRln8GGKfwMx
	 gXoEPDaOxs1078NbidR7ETR3lQXPuvQj6o97rpdgTt5nmVX7CnW9kVpybWiq52kcjO
	 PnQSV0eQyFqEIM6fwU09ysiQVyygIu5mQBoh6wcWh00yGxuCAqMy84r6TrUt3JqcGQ
	 Ige7cvkgY8D7eTqbUJ4smnrzZK9K6t1/No66UKwMjSznrq7Izo3TDhCW3hQRaV2U8A
	 EL0zrywHlI0Sj+Y7YMn+op7H7PbtXeAbIz0riCWqAKG/P6SGefd57yFL550KIAwfnZ
	 TbJou8dble8Xw==
Date: Mon, 27 Jan 2025 11:20:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=  <toke@redhat.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, "Song, Yoong Siang"
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
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v6 4/4] igc: Add launch time
 support to XDP ZC
Message-ID: <20250127112045.7e3997fc@kernel.org>
In-Reply-To: <221bb71f7d2464cd566e4a4110423ea56b173cf6.camel@siemens.com>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
	<20250116155350.555374-5-yoong.siang.song@intel.com>
	<AS1PR10MB5675499EE0ED3A579151D3D3EBE02@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
	<PH0PR11MB583095A2F12DA10D57781D18D8E02@PH0PR11MB5830.namprd11.prod.outlook.com>
	<ea087229cc6f7953875fc69f1b73df1ae1ee9b72.camel@siemens.com>
	<Z5KdSlzmyCKUyXTn@mini-arch>
	<87bjvwqvtl.fsf@toke.dk>
	<20250127100441.0b11e1b8@kernel.org>
	<221bb71f7d2464cd566e4a4110423ea56b173cf6.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 19:29:35 +0100 Florian Bezdeka wrote:
> > > Yeah, I don't think we can impose UAPI restrictions on the metadata a=
rea
> > > at this point. I guess the best we can do is to educate users that th=
ey
> > > should call the timestamp kfunc before they modify the metadata? =20
> >=20
> > I may be misunderstanding the discussion, but I think the answer=20
> > is that the driver must be fixed. The metadata-in-prepend problem
> > also exists for simple adjust head use case, so it existed since
> > early days of BPF. The driver should copy out (or parse) the metadata
> > before it invokes the XDP prog. The nfp driver does that. =20
>=20
> That would have to happen for each packet, without affecting ZC
> performance. How can that be achieved?

Are you asking how we can make it not affect performance?
We should really see some benchmarks before we say that it is okay
to sacrifice correctness..

> So we have at least two drivers with that problem, igc + nfp.=20

To be clear nfp copies the HW metadata out before calling XDP.
So XDP program can do whatever it wants to the space before the packet.

> My main point: Enabling and implementing ZC (zero copy) mode at one
> hand, but then starting to copy the meta data for each packet doesn't
> sound reasonable.

=F0=9F=A4=B7=EF=B8=8F

