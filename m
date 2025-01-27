Return-Path: <linux-kselftest+bounces-25244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A3A1DBD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 19:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC0B164B27
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EC018A6DE;
	Mon, 27 Jan 2025 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa1i/Uqj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83D153808;
	Mon, 27 Jan 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001085; cv=none; b=BghCQGr3wpesljYMhRc78izPvuWBY1eAORiVG8AE0cfoQFRe0aM6zgPorZfS6Ob6TWGc5Q/SuYq9NI8mY3vV24UNnhmYJEaR3+fF4YDBMMHNv9kjv25pFBnlWyTBp5306NtQXZnn+IG9GZYq9nmuCGhQODh9Mf3XpUgKdTzLsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001085; c=relaxed/simple;
	bh=H/TAc9fGLArvc2BRtJuDGahSmYMiOfZlb3sEWjWRvdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4YPJobzaTzIVE03OCabjQqMGEt8hrqHejbahLIDpFcGTIsPv9qWYmCSX/zRg/ZG/z3NgV8Ninsk91W8IiczlvXloocvtxFmahAlaT2S7GErq6WMWPxWxbO2jNebI0absyOgsnX3U0nkuLb0DKwHBG0KSTZw431dbStlruhYSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa1i/Uqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F93BC4CED2;
	Mon, 27 Jan 2025 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738001084;
	bh=H/TAc9fGLArvc2BRtJuDGahSmYMiOfZlb3sEWjWRvdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pa1i/Uqj8nt3XnOgB4es4hq3WXqmWYJe+K+7Ypr1PhtZKUOMb+h3wCHGV8pGfCXWf
	 V/jNdW1KJ0DAgBElQtp27kbynF6Xdb64ebEeDtcaavOt9nt3wH1DLI4Alev/ln14Z5
	 8MnTCYVHpwTy5t3/GnzlRYIwYejiGooeUjDn1YgpVCFKG0fB11N85ZNFumQQbSP2kU
	 WigdIP+MK+4Ziy2Bpk1ilyK4PIrxFTjdf+y0w2rgNqfwu0cfUToiNhOhF8q3sAM18+
	 xPG+JfYTyHktRw2Gk07i3VSNMzu5ZS6RERP5ylIMJESoE+MWfyQ7kbBA6E5MKHoZY2
	 EGi/oAiz8W3jA==
Date: Mon, 27 Jan 2025 10:04:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Florian Bezdeka
 <florian.bezdeka@siemens.com>, "Song, Yoong Siang"
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
Message-ID: <20250127100441.0b11e1b8@kernel.org>
In-Reply-To: <87bjvwqvtl.fsf@toke.dk>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
	<20250116155350.555374-5-yoong.siang.song@intel.com>
	<AS1PR10MB5675499EE0ED3A579151D3D3EBE02@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
	<PH0PR11MB583095A2F12DA10D57781D18D8E02@PH0PR11MB5830.namprd11.prod.outlook.com>
	<ea087229cc6f7953875fc69f1b73df1ae1ee9b72.camel@siemens.com>
	<Z5KdSlzmyCKUyXTn@mini-arch>
	<87bjvwqvtl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jan 2025 12:45:42 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> I think there is no simple fix for that. That needs some discussion
> >> around the "expectations" to the headroom / meta data area in front of
> >> the actual packet data. =20
> >
> > By 'simple' you mean without some new UAPI to signal the size of that
> > 'reserved area' by the driver? I don't see any other easy way out as we=
ll :-/ =20
>=20
> Yeah, I don't think we can impose UAPI restrictions on the metadata area
> at this point. I guess the best we can do is to educate users that they
> should call the timestamp kfunc before they modify the metadata?

I may be misunderstanding the discussion, but I think the answer=20
is that the driver must be fixed. The metadata-in-prepend problem
also exists for simple adjust head use case, so it existed since
early days of BPF. The driver should copy out (or parse) the metadata
before it invokes the XDP prog. The nfp driver does that.

