Return-Path: <linux-kselftest+bounces-21913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837789C6D5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A922B24CB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA701FF055;
	Wed, 13 Nov 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ztLYBqrE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZHedxEd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC826AEC;
	Wed, 13 Nov 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495942; cv=none; b=kfqcx8q0ickh6PW/k1bNxfebqdxvVg2EfokLJkpjwufh9jfnBfzzyyEPYjbWFk0XuZI0FNlIAS5cFCBBLwaNt/s5e35OT+cDjLifkQPImhzo+zZFwhA5vDF/AthQ+sFWXEUKJSbHN9FxuHIY2rhHfdtOKQ5K3sKb6obMqAzcMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495942; c=relaxed/simple;
	bh=GD4gByPstTIU3nrMg6gQmFEf+Qd6NKDrcxPg4CyqgLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjStks6Nd3hiuCIDY0MzL7Zid1MMtGFMhb+FgHj+qnT64fZsFbUUMZ4g770Tts7QOmkOVnlZU3iGclTdfQzxHCphkBGx9BO9GlFs2hQKjAAWoV79838XEnLAVXIBimIXshFQPSnPQoF9e/hzW+Yak4hUp5ucYpL77QsaJ2oSTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ztLYBqrE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZHedxEd; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 1ED512012FD;
	Wed, 13 Nov 2024 06:05:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 06:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731495931; x=
	1731499531; bh=69GT+STK140nVuOaNvcX8BqmelgV+XdakSOOQdJxEF4=; b=z
	tLYBqrEJdWRx3UvQoMoXVMLwlkxpacX2TlxndF8Enr4/DeYf+fCLdQg7SVwCjbx1
	if/7nT815/KMTo355fyFYIqFR+6nU17hhGkzxG6u7YL7HFEEGU3IefS7it6FJsWv
	eH5Nfk3Zdf1MvnFpwP2GWx+3kFWdcQIV+QA75T47kjdiKOVEuLbhOarfOpNVt3Oo
	4QYjves43oHaNAsnWtIzJzxUVuvgCOI+ego/4NJGUn9KkjnqUjaTbSyzcpNY3B5Y
	/DmbExPnCxNOzkkyQ3Y8+L1L8FDMtxgNLlWHsYqIAo0bFrkXU63ufF5/Edaqwap/
	WkC6/uUzAjZdpXd1EKY1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731495931; x=1731499531; bh=69GT+STK140nVuOaNvcX8BqmelgV+XdakSO
	OQdJxEF4=; b=mZHedxEdOYApXc+9/rY+rf8QVGoNVnukVqMcfQAWxKLRx37r7D1
	K/p4AMS5v4i3mZ4m4bEXR7R0OntwjZMwGD399aDYO0iynicVpc2EIB+HqDbqEDrb
	8X/T971PejU0Dv/omBh/17CmO3rrI6fqvFKvLGHenO79BIX/EW23yQYy4kKWpPXO
	bvo4/DjFDAWSotfzhgwN2+OwZ0zeHbEN4KJ60UJPuCarkAEC+yLWWNYVq35QOoWK
	g7i1YwkeG4vXz7qGHOFjTX+9/LWpsawS0A+orFCbLmYmTTZkzf7IfQZShxW7Xc+O
	cpf5+owWzgQA+9Zjj7u8PkO5iaQZLCHK2Xg==
X-ME-Sender: <xms:-oc0Z4BvJBhi9DYu0n78J16ZpklTRpYScszyYMYbxoGmtj6HuKSH-w>
    <xme:-oc0Z6iVphU3FJqbbEnwuUupUi89EEaO2RupbppqmzupuSySiUtv-KNE-I4yvQ1PQ
    8wSCzvnwlB6DZEDHME>
X-ME-Received: <xmr:-oc0Z7kAo4CvV-JIwebaWiwVgRHauPREbG39WclGprwCIFkk2KpJB2NPQdjy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhu
    nhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-oc0Z-zwfJV8VhGgw-LKe9TL17MBqh1Q0wpcTyq1oO6cyBl9CYHtGQ>
    <xmx:-oc0Z9RgeuRHTX1qY-UD4D5lnjZAXg6gitbx9dTYiqsX72uCWn-HSQ>
    <xmx:-oc0Z5ZOcNfZ7hRG-gounmdV5qAlIJG4l2dAJE7s-3BTCyWiWhYwcQ>
    <xmx:-oc0Z2TLUZpf3H2--2Yf4jvdDvI8XOT4pTNBsMbby9W1gGu1Prdgog>
    <xmx:-oc0Z4GJ59p71RfOSv1qZFrWYJ4gjL1Jt5zzmgzZ4isHU43ZMVV6bW7t>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 06:05:30 -0500 (EST)
Date: Wed, 13 Nov 2024 12:05:28 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <ZzSH-Ke4wuJcis0q@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>
 <ZzIlxRbic7qLVD4F@hog>
 <136282ad-77d9-4799-bd2d-f3c3c9df99c0@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <136282ad-77d9-4799-bd2d-f3c3c9df99c0@openvpn.net>

2024-11-12, 15:26:59 +0100, Antonio Quartulli wrote:
> On 11/11/2024 16:41, Sabrina Dubroca wrote:
> > 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
> > > +void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
> > > +	__must_hold(&peer->ovpn->peers->lock)
> > 
> > Changes to peer->vpn_addrs are not protected by peers->lock, so those
> > could be getting updated while we're rehashing (and taking peer->lock
> > in ovpn_nl_peer_modify as I'm suggesting above also wouldn't prevent
> > that).
> > 
> 
> /me screams :-D

Sorry :)

> Indeed peers->lock is only about protecting the lists, not the content of
> the listed objects.
> 
> How about acquiring the peers->lock before calling ovpn_nl_peer_modify()?

It seems like it would work. Maybe a bit weird to have conditional
locking (MP mode only), but ok. You already have this lock ordering
(hold peers->lock before taking peer->lock) in
ovpn_peer_keepalive_work_mp, so there should be no deadlock from doing
the same thing in the netlink code.

Then I would also do that in ovpn_peer_float to protect that rehash.

It feels like peers->lock is turning into a duplicate of
ovpn->lock. ovpn->lock used for P2P mode, peers->lock used
equivalently for MP mode. You might consider merging them (but I
wouldn't see it as necessary for merging the series unless there's a
locking issue with the current proposal).

-- 
Sabrina

