Return-Path: <linux-kselftest+bounces-21911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233C9C6C4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218A12887E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74DD1FB88E;
	Wed, 13 Nov 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AL91kOU5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cU0ZSi8j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CA1FAC48;
	Wed, 13 Nov 2024 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492243; cv=none; b=jAaCV5wKlq4+m1GotU6q0CeqRM6LcDlNilk4uJcXz0ksQ0hfs1KsEzdDgWoO1URxho7lyjAH2lSVCnfkS6Ndy8FNPU+y8/idjEC04cxwDlZObrlxq/V87DkeG8MBVVY0loq4LMtpmvxNf4+9TBAiPq3OJPiBh+OJl43VLAVJrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492243; c=relaxed/simple;
	bh=9WgOqZ7pkkEtVVakWuhfW72XbEP2znkm7oYKso1f9Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6+I0NCiSxbAo2YFJ1jzP/6IDrRjw70ipkKgFz+Bm/rDt+ddkuc6DBZeYgffeXhwItIdpfpDWvJEdnuXVW03c8lEoMW97CtHkwA3Vw/mDRfCcQAxZz+ZmanZzvR6BZ3KOYT5bDd5slpyxUE038D9t/H+A5itFeCTk3zxQosxFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AL91kOU5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cU0ZSi8j; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id B20842018EE;
	Wed, 13 Nov 2024 05:03:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 05:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731492238; x=
	1731495838; bh=Ez/gX/Lx9KP5A6YSj3GZt6+aAN/V+id/rFQYWBdeg+4=; b=A
	L91kOU58sCjmTlQJdgMjC5zUvg8oJLltEG1/JXMtFP8DKXriavohggJBOq+nh4dt
	6NFDXq/jC3+z7K16HSXnK5YL1iRHnmOrBaAFhpS2N+zl4RReG4HvQdIQ1nxcqjBc
	ATYUctYhl6w/BlPLfcmNKYhTkR0OT78loFBn4KUS6SRMUG50ZK19Yp4qrI+iisyf
	Ael/GXblmdV6M3tCsGA0xpn66tVpuEDJjMiH0jyYs3bMz62Tv+pzR4z5Z+DlK7jr
	Z2jWZKVyTpypvt+xMTSJ5Mx5zTi7TJ010kw+D6y6piuUbTX+Cqip2DSiuhn/zfHI
	/fFMUn0IYAyNzbIa0oCDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731492238; x=1731495838; bh=Ez/gX/Lx9KP5A6YSj3GZt6+aAN/V+id/rFQ
	YWBdeg+4=; b=cU0ZSi8jFa20seQjI3WTu4Fjrg/W3li2sTAH2U4YqtegfVVvrxI
	RQu9RzmZTj8GWYG8km5CNxbBCt6E8uEXA7T/QSv7m7I+Yo5HJhu7iBMvlO1mZAJJ
	tGTWecC3+ryJbr0CgDFc7rjl3xQ4RRD94mZplJ/IM0uv0lWKuKdd8eaiIU4SiHv7
	cj6iqQXXqvyoxyiOLsxo0FoHvYMaTZoAgxmL0X4xs4ZOL7nZxubZCUVWUt+JU8pF
	RgpkwRvVuVc2EtDGk3Vz3gVNpY+8a8ZUDDcSMtKPkxcHNyUa9MFqewvq5Myg/5Hs
	Wk/9DdeXTSBplufBz/ooRpwHegwLAfRth6Q==
X-ME-Sender: <xms:jnk0Z_vsGs6JcAKwsl1cYiLFuNY3kUjZaYHydsW2N2mGh2RD7e09YA>
    <xme:jnk0ZweFultluEIzEi1IFLb3b4xwsj6NVIF-r5b6qzhdG-9MQr1OA__yPcIHcTzUY
    vkqMQ-5diiY_Oo6ki0>
X-ME-Received: <xmr:jnk0ZyxGw02KP2KYJGxmRDj4io7HFztf0hRKDKjqdItVFwPeIyuxSjN0kNs5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrhigriigrnh
    hovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhtohhnihhosehophgv
    nhhvphhnrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jnk0Z-PUo6qciVVGOANqRs-bY-b0lMgcJLxwjOc6GCPghlRhs4vuPw>
    <xmx:jnk0Z_9ajTA4p42cbzvUlQNMFz1EpzDBW1BgyhI0ASW9nZk1Sb2gdg>
    <xmx:jnk0Z-V06zGIFJfG3gGz-ng1yHb6-baSgoZ4TihcDy2nYvOAJw51Sw>
    <xmx:jnk0ZwcVAJiiOCDZHlqPDZGyXm-gDTXovwzEAEWM0TSG3uQdo3FkVw>
    <xmx:jnk0Z7QRwMjJcd-5pKRmAt0K8PDhQkS-emb5OJadk1R8Qx_Ryt4fRzbm>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 05:03:57 -0500 (EST)
Date: Wed, 13 Nov 2024 11:03:55 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
Message-ID: <ZzR5i9sO-xwoJcDB@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
 <b7d3ec11-afe4-409c-970e-8bc647364a08@gmail.com>
 <ZzORATd5hG614dta@hog>
 <e543a3de-44f1-4a2d-90ef-1786e222f0d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e543a3de-44f1-4a2d-90ef-1786e222f0d8@gmail.com>

2024-11-13, 03:37:13 +0200, Sergey Ryazanov wrote:
> On 12.11.2024 19:31, Sabrina Dubroca wrote:
> > 2024-11-10, 15:38:27 +0200, Sergey Ryazanov wrote:
> > > On 29.10.2024 12:47, Antonio Quartulli wrote:
> > > > An ovpn_peer object holds the whole status of a remote peer
> > > > (regardless whether it is a server or a client).
> > > > 
> > > > This includes status for crypto, tx/rx buffers, napi, etc.
> > > > 
> > > > Only support for one peer is introduced (P2P mode).
> > > > Multi peer support is introduced with a later patch.
> > > 
> > > Reviewing the peer creation/destroying code I came to a generic question.
> > > Did you consider keeping a single P2P peer in the peers table as well?
> > > 
> > > Looks like such approach can greatly simply the code by dropping all these
> > > 'switch (ovpn->mode)' checks and implementing a unified peer management. The
> > > 'peer' field in the main private data structure can be kept to accelerate
> > > lookups, still using peers table for management tasks like removing all the
> > > peers on the interface teardown.
> > 
> > It would save a few 'switch(mode)', but force every client to allocate
> > the hashtable for no reason at all. That tradeoff doesn't look very
> > beneficial to me, the P2P-specific code is really simple. And if you
> > keep ovpn->peer to make lookups faster, you're not removing that many
> > 'switch(mode)'.
> 
> Looking at the done review, I can retrospectively conclude that I personally
> do not like short 'switch' statements and special handlers :)
> 
> Seriously, this module has a highest density of switches per KLOC from what
> I have seen before and a major part of it dedicated to handle the special
> case of P2P connection.

I think it's fine. Either way there will be two implementations of
whatever mode-dependent operation needs to be done. switch doesn't
make it more complex than an ops structure.

If you're reading the current version and find ovpn_peer_add, you see
directly that it'll do either ovpn_peer_add_mp or
ovpn_peer_add_p2p. With an ops structure, you'd have a call to
ovpn->ops->peer_add, and you'd have to look up all possible ops
structures to know that it can be either ovpn_peer_add_mp or
ovpn_peer_add_p2p. If there's an undefined number of implementations
living in different modules (like net_device_ops, or L4 protocols),
you don't have a choice.

xfrm went the opposite way to what you're proposing a few years ago
(see commit 0c620e97b349 ("xfrm: remove output indirection from
xfrm_mode") and others), and it made the code simpler.


> What together look too unusual, so it feels like a
> flaw in the design.

I don't think it's a flaw in the design, maybe just different needs
from other code you've seen (but similar in some ways to xfrm).

> I racked my brains to come up with a better solution and
> failed. So I took a different approach, inviting people to discuss item
> pieces of the code to find a solution collectively or to realize that there
> is no better solution for now.

Sure. And I think there is no better solution, so I'm answering this
thread to say that.

> The problem is that all these hash tables become inefficient with the single
> entry (P2P case). I was thinking about allocating a table with a single bin,
> but it still requires hash function run to access the indexed entry.

And the current implementation relies on fixed-size hashtables
(hash_for_each_safe -> HASH_SIZE -> ARRAY_SIZE -> sizeof).

> And back to the hashtable(s) size for the MP mode. 8k-bins table looks a
> good choice for a normal server with 1-2Gb uplink serving up to 1k
> connections. But it sill unclear, how this choice can affect installations
> with a bigger number of connections? Or is this module applicable for
> embedded solutions? E.g. running a couple of VPN servers on a home router
> with a few actual connections looks like a waste of RAM. I was about to
> suggest to use rhashtable due to its dynamic sizing feature, but the module
> needs three tables. Any better idea?

For this initial implementation I think it's fine. Sure, converting to
rhashtable (or some other type of dynamically-sized hashtable, if
rhashtable doesn't fit) in the future would make sense. But I don't
think it's necessary to get the patches into net-next.

-- 
Sabrina

