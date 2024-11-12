Return-Path: <linux-kselftest+bounces-21886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D043C9C5DA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1091F21BE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2189D207213;
	Tue, 12 Nov 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kNKy5euu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A0JPWRgg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6C20720E;
	Tue, 12 Nov 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430065; cv=none; b=egj3vNTz1gEq8PN4HZ3hTAnk8StSvBuSNrjs7Jh4O09E5l86+zmgEaRWyrN4+/Gnsa3LNLGfDq9cEpxcscKajJLRy6flpbKGPX0r8ewLporOq3xjGidXOz88ZoOfjQP2XYSpXCCDBK16f6afsvXb0Z8ckAeu+gRl5VRRqFmxVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430065; c=relaxed/simple;
	bh=ZzNKDiqf8EYHXh9cVoPgd9CqqlRUC39S0XXWU70zxBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teLINO6urYjRWg07aLt5bd8SNbwXz1aEhT0CS5vQV51qQriWq9jjCVTQst6pscUbD+zLIuZVPtxO2eGlkqVk/2W8eYej5qkWTvmejG/nWTwT1fjtMt96ddpGHSaHx7o8ovdfk0TVMqd1qVRLEt9g9Z3k+sPwRJS1sLPl+4t5U3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kNKy5euu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A0JPWRgg; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id AB0891D40362;
	Tue, 12 Nov 2024 11:47:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 12 Nov 2024 11:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731430059; x=
	1731433659; bh=mjBh6lGGOL7kWEbog/DbMVJwFE+VluwZ4NBVspvbpMw=; b=k
	NKy5euuQ8i7BZ8C6Ou12k4jHPmW4m4flIL3kN9vP5OgHVzNVJKel2xAcJABV9rP2
	u8O6ueDs9I7aUX9zlSJLCpTtd3hO7ofAv6+80cLWb//nh921/918u+rxkKiToxoh
	mJaNlixa9mvMebn6HNvipMonezODj/4b7A1I/sf6v2LDAG9M+zVUeUntjb8paPw4
	271/VWFUJgBaY6uvT4xCeaKHYdiaw6krsACB8qUxhihTFN7MF38aE0YmJ9GndG14
	ROyFWqCO2WBcs1JOyK3vIvJvGKAYu75ttbtmakWeCOS93WMmdkkY3npXeAoCU3a/
	Z5TtmB9OPqhtO+2NghGDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731430059; x=1731433659; bh=mjBh6lGGOL7kWEbog/DbMVJwFE+VluwZ4NB
	VspvbpMw=; b=A0JPWRggkrMoDEVemxz5qTyCDdHISEpvb+9X+fqax2w1YRTCwD6
	BilUHEm24CtlgFe6yQC4tW5XNMQ89GL06i1Kq880UXXA9g6tKIe0rvw+glYiLCVL
	oVp5plN7Ax+UJG/Pmgtd8GGbklTses8qnQsYrkWAQoJvY2lLh6sn4EShK6Wu2FEy
	qiOSGqJ8qx/pa/KE9RMXh3zOOaUyHRPz1qQWrLjyH2xEVtSrPe/isA9p8wZ0D7G8
	cG7IP+v1j5z3EYKLKYxtW2EusaunE5JKHBAC9AENhxmzQIZvNE54kwB/UnU6ZtPC
	ghgDKIdi+kWc4tx+waFqn6lt2vaVPsd4NWQ==
X-ME-Sender: <xms:qoYzZxc-ivRYtK3nSBtzv-3sRHAoL5pMI7VqBcna_piHufK8clabOw>
    <xme:qoYzZ_M1z8lKvlD5b6IhBEOE_hPqtAxwaSFObXkMkEQWOahSBdzl9Byx7HxL-5Gbo
    05M7zubpcVR9o9i7AE>
X-ME-Received: <xmr:qoYzZ6iiFoU1XeNoAkwqQdwWLabzSNbWBoni1OYRxBQMXd5UWRuMeBSdTZB1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdeklecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:qoYzZ6-dieiEvbKm0WW98CgSdGFNo0L3QUdDpD9wwGJM45kf4LA5PA>
    <xmx:qoYzZ9sh2wEkundcfu3zccUkDVvBB8BaSxAgAINeXFZLIxn97s6RLQ>
    <xmx:qoYzZ5HIgkupaP9q0HX6cTf0xzdCEC53yg2eYjaJHSBenvTIDVDruQ>
    <xmx:qoYzZ0M9K72F9mbvbLa_xcutkknhVU6Wfx16gmn_Cwhs4W7rxKji6Q>
    <xmx:q4YzZzCF0-MX0hHel1r4J3IZnbHGDzDsE8699IyjdqpYcJn6UuIMkfCv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 11:47:38 -0500 (EST)
Date: Tue, 12 Nov 2024 17:47:36 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <ZzOGqP9AAGSN2E7y@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
 <2fd3dc9c-9d6a-494c-a4d8-a45221bf250d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fd3dc9c-9d6a-494c-a4d8-a45221bf250d@gmail.com>

2024-11-09, 03:01:21 +0200, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
> > +/* When the OpenVPN protocol is ran in AEAD mode, use
> > + * the OpenVPN packet ID as the AEAD nonce:
> > + *
> > + *    00000005 521c3b01 4308c041
> > + *    [seq # ] [  nonce_tail   ]
> > + *    [     12-byte full IV    ] -> NONCE_SIZE
> > + *    [4-bytes                   -> NONCE_WIRE_SIZE
> > + *    on wire]
> > + */
> 
> Nice diagram! Can we go futher and define the OpenVPN packet header as a
> stucture? Referencing the structure instead of using magic sizes and offsets
> can greatly improve the code readability. Especially when it comes to header
> construction/parsing in the encryption/decryption code.
> 
> E.g. define a structures like this:
> 
> struct ovpn_pkt_hdr {
>   __be32 op;
>   __be32 pktid;
>   u8 auth[];
> } __attribute__((packed));
> 
> struct ovpn_aead_iv {
>   __be32 pktid;
>   u8 nonce[OVPN_NONCE_TAIL_SIZE];
> } __attribute__((packed));

__attribute__((packed)) should not be needed here as the fields in
both structs look properly aligned, and IIRC using packed can cause
the compiler to generate worse code.


> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> > index 8516c1ccd57a7c7634a538fe3ac16c858f647420..84d294aab20b79b8e9cb9b736a074105c99338f3 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -1975,4 +1975,19 @@ enum {
> >   #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
> > +/* OVPN section */
> > +
> > +enum ovpn_mode {
> > +	OVPN_MODE_P2P,
> > +	OVPN_MODE_MP,
> > +};
> 
> Mode min/max values can be defined here and the netlink policy can reference
> these values:
> 
> enum ovpn_mode {
>   OVPN_MODE_P2P,
>   OVPN_MODE_MP,
>   __OVPN_MODE_MAX
> };
> 
> #define OVPN_MODE_MIN OVPN_MODE_P2P
> #define OVPN_MODE_MAX (__OVPN_MODE_MAX - 1)
> 
> ... = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_MIN, OVPN_MODE_MAX)

I don't think there's much benefit to that, other than making the diff
smaller on a (very unlikely) patch that would add a new mode in the
future. It even looks more inconvenient to me when reading the code
("ok what are _MIN and _MAX?  the code is using _P2P and _MP, do they
match?").

-- 
Sabrina

