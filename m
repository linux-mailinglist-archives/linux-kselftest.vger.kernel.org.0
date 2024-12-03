Return-Path: <linux-kselftest+bounces-22759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B8B9E268B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 17:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7609167DA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8E01F76D5;
	Tue,  3 Dec 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CpNww9DN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxWEPaY3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3881ADA;
	Tue,  3 Dec 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242207; cv=none; b=i8HZ/K6NhJtlyUx4aWs4nJACHw6JGxU43SVqbf7fpUOWHSK4CFstd1DX2yRdqIzcOLBQpRvmHJFpNlBMHE8JJ8txKvLh51Z538a6G94hB8VGbsW9O98WBdjpx1lTB6Fjy3vGxnpVZsfiqkOr5IbAFv/J5qusUgddtdibWjRbj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242207; c=relaxed/simple;
	bh=8pAHF54ui4zA+Mj4UHdwG1hk0crm6ZJaVaOSy/hclf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLI0F0NAGSi6w0ObWhy4BBk1tQZhxSuHv/06BOSWtxau0RU1T5jZujo2PBZ9gcFU+YNIxp78jFwOMZpEll+w9JzFvAi6zN7zQw62RHjTezXAPVr2QKW+Knt7MVCobUr2Xa5VwKHt41om1bgKGWrpOIp+qoTb6XWMqsyYAOVhZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CpNww9DN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxWEPaY3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A812311400E2;
	Tue,  3 Dec 2024 11:10:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 03 Dec 2024 11:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1733242202; x=
	1733328602; bh=RzGwZAu9mlE2QMETXgnsEf6IwW4zhq+aCq4xASv7ZF0=; b=C
	pNww9DNQEYeNcbr5JjoNABjeIQu8wjz7pzrXiEjruKGHKH4FPUoNwVtbegy0j1dx
	WFPe/onNZCH1omZXzQz4HebBWtMxxWvLJJJ+/dieLUrt00RFxGL4KgCrX+cjusxl
	Pp4IjyX5BeZNl8cPjaOJpSg6HanXOaI8WbeEV/63ppFIzvHW0I7ZX5M79r/4THK0
	hJTmdFr1UhHO77RGbHEvcX+/cnGtAs31kYD9O5Uhr0xgmuOjUhMhtFHh0DRvP33w
	eGJKXeKBavXx/jAqM01aSg3lazYa1riVmQwie9OTbjg9/PeRnkf6e7TObJw8eGSX
	wq/Cfss5OWCPwvYPyFaCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733242202; x=1733328602; bh=RzGwZAu9mlE2QMETXgnsEf6IwW4zhq+aCq4
	xASv7ZF0=; b=XxWEPaY3aeEbK65xYQJpEiZtof3I/2R+fwVMqHU8snwA+BI0t82
	G0/iZN4M4xMHeg6aYb2Cx0PM5L3V//q1pufcrvQ39ArW47ZspdVttN1szeCwQ8ZC
	pSoq0fRHb4MlMUeJuNLK0wOkI5Xn2VhPH4+Ez1IZbP4W8jpLgHRCwQh9hGPIZIpw
	dFRcXS80cxwL6KnuHkPYoSy7ivNX4v16npE4kbYTw7jYzKW/sKq/9ssCEHfkWpOZ
	Urd6IZ7qt7ANX98E4gHxd36ykdd7Jx6VI4NtYVPQMj24E2VElNRPkd54dX2MA3oo
	yR41jJFgMWANRX6R+i4GrS9KmDIlxn4Iuug==
X-ME-Sender: <xms:Wi1PZ-RKs4CV2dw3pvOjr_LldADvLKDNiUPa1QGnEaG0LvbmgqQCig>
    <xme:Wi1PZzzXxeub_8Y584N2KxRhDk0IlQ_j7Famvf9jBEkWBzlaajckMMxPyeDtREN5F
    -7f6f7cvJfFomGf01E>
X-ME-Received: <xmr:Wi1PZ73kTI23uaUr2ChYGeHx1PL3OnP-79Wo7xPQlZ7J-fuOPq64jHvVYbtr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtthho
    pehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgv
    lhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Wi1PZ6CeXkjHU0kiZODljeL8K3ck430Gsw6JoM-Yne3hJGHXq3e9PA>
    <xmx:Wi1PZ3gOkQpD9mPhOUWKU6u8_GjayXo2glBqcNDxwDk1ejwueXEVZg>
    <xmx:Wi1PZ2qVSbqD-ihe2WyAr7JNcVMUlKoRDOFVkZ_dFCMZcVTyqaG2xw>
    <xmx:Wi1PZ6hr54nRYZZRC9QasRt7lCwtH8XDjqe9l-Y1B7AlZVv1tjj8NQ>
    <xmx:Wi1PZwamZUEZq7Cv_d0iaWEHK60RkI3DAuxLV2jjMWcmU8CQO3ogzfYD>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 11:10:01 -0500 (EST)
Date: Tue, 3 Dec 2024 17:09:59 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	ryazanov.s.a@gmail.com, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v12 13/22] ovpn: implement peer lookup logic
Message-ID: <Z08tV5vQe2S4iawi@hog>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-13-239ff733bf97@openvpn.net>
 <5052453b-edd8-44e2-8df7-00ea439805ad@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5052453b-edd8-44e2-8df7-00ea439805ad@openvpn.net>

2024-12-03, 15:58:17 +0100, Antonio Quartulli wrote:
> On 02/12/2024 16:07, Antonio Quartulli wrote:
> [...]
> > +#define ovpn_get_hash_slot(_key, _key_len, _tbl) ({	\
> > +	typeof(_tbl) *__tbl = &(_tbl);			\
> > +	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl);	\
> > +})
> > +
> > +#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
> > +	typeof(_tbl) *__tbl = &(_tbl);				\
> > +	&(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];	\
> > +})
> 
> clang a reporting various warnings like this:
> 
> ../drivers/net/ovpn/peer.c:406:9: warning: variable '__tbl' is uninitialized
> when used within its own initialization [-Wuninitialized]
>   406 |         head = ovpn_get_hash_head(ovpn->peers->by_id, &peer_id,
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   407 |                                   sizeof(peer_id));
>       |                                   ~~~~~~~~~~~~~~~~
> ../drivers/net/ovpn/peer.c:179:48: note: expanded from macro
> 'ovpn_get_hash_head'
>   179 |         &(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];  \
>       |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> ../drivers/net/ovpn/peer.c:173:26: note: expanded from macro
> 'ovpn_get_hash_slot'
>   173 |         typeof(_tbl) *__tbl = &(_tbl);                  \
>       |                       ~~~~~     ^~~~
> 
> Anybody willing to help me understand this issue?
> 
> I have troubles figuring out how __tbl is being used uninitialized.
> I wonder if the parameters naming is fooling clang (or me) somehow.

Not really a solution to this specific issue, but do you actually need
ovpn_get_hash_slot as a separate macro? AFAICT all users could also be
converted to ovpn_get_hash_head, then you can merge ovpn_get_hash_slot
into ovpn_get_hash_head and maybe clang won't get confused?

No guarantee that this fixes anything (except saving one or two lines
in a few functions).

-- 
Sabrina

