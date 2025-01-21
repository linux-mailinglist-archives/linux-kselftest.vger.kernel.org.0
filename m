Return-Path: <linux-kselftest+bounces-24830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2CA17A5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22741188C694
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63901DF26F;
	Tue, 21 Jan 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="WvRvgBEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHYW+ILN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C311BF7E8;
	Tue, 21 Jan 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452346; cv=none; b=BE0n5p1McGkGVtdqwrPPsSzBjQ4AgCBgGg35f3G4tETqHnhZebcozEVcG7pqRYvmQVgM/LNObGW2O6WCgl1AEHTbI4vN5EAcQhoea0ZC22LPGVqhK7sFdMVZ2mAg0aSUyJUGR8uizjODjD+eJuJg1KP/mfm8YpgCpiqJRYSMqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452346; c=relaxed/simple;
	bh=PxHWvQWY5H4WME1g/lqw1JF5uDvI8oJ8ccjH0qdzxO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/CQTCVlVMek1jwhb0AGj1cOuzIuVA2+kpq4UrT70X+6rG0hXXnTcYqDy8Pit/NbMz1l8OKbi2T2nzuP7l1+gPm6TXqeT42kGNT4ToCpijC3cXPg5+1czL0+YvVUNipOuI1VgRfkCx6BwaWuOg5DOdVL6saLlQOui9rA0j+vvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=WvRvgBEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHYW+ILN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CD5EB114018B;
	Tue, 21 Jan 2025 04:39:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 21 Jan 2025 04:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737452342; x=
	1737538742; bh=8iPjQvMHt5735HgKU0QmyShw6p9Hs7LNczIpafwvS+g=; b=W
	vRvgBElSxB7BiVhYfvRz7msScibrGV9fbx2sYKUNvYeG/Qvv7Kmy4k1NpA09UPE/
	99oySUcregnD5ozaCEe44CygT7IUjdIVnUxnRZXJgprCUgqLF7IiwNGfVRH1pnuq
	lHfUSWhQMMzGZUP4QaKDx9jBulxQMkkvfeUixILT4ETRlAczxQs57Nm3uA9zDdLN
	9VT68giCsIEKsKPyvbI7o+RKbIl4aJV0YwlfPH/PQ6+k2tkz0XUGVVIBImjS1dhH
	NXzTXG06AONuNQQdpi3ROzZMAlM1SskUpqURv/xZoVAn4Py3c0S7zqJfDnKXwGWR
	An656fp4PFGyR1ZJQm2ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737452342; x=1737538742; bh=8iPjQvMHt5735HgKU0QmyShw6p9Hs7LNczI
	pafwvS+g=; b=EHYW+ILNp3oUm0uyJvzKtInyoTIdxsiKzBMaQvErWKDCNgTphBS
	8UmB2/uvCeBgFBCbINa4pqEq46kubBScGuieW6ZPvvC5q/D6FmFkBrDLjt3dxkDS
	9qWuz/Jer3VpIWXDUSyvAgfn2m6xaqovRw0Z07OLpDMr5QGO4kLyU1khcRoecTqK
	rrcjs+rEsRn2peFTrICaVMEt/vu9Q1PQ0slG2r3oS8U2gI1zED26SWEd0hALSeCy
	xd4jPp/I0Y1zl8pCsreA4ME8sloVTbpg4Iq4bb7qnA9Ggf3a05/PPkW4Apk0Bj0q
	EKBywitF87Jvf479vQHhOdWCCYgLtczoYQw==
X-ME-Sender: <xms:NmuPZ2X5OPLz30fHPsljiRC65TWTTXLSJRbhEdMzOlTsQ2POCeXvXQ>
    <xme:NmuPZykKZRnbB9xV5UPsa4apkzihQ7IkRD6N6DrzTdXhghVBkOlEj_erIT5hU2MOA
    TR1qvjeApPW-nWnPtE>
X-ME-Received: <xmr:NmuPZ6aBUnrlLO9zruIvaY54lpSUPLJ6mNeBoajJiK6rlC4H_Xer2cBUDBgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejuddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfet
    ffeffefghedvvefhjeejvdekfeelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsuges
    qhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhr
    tghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthho
    peguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuh
    grhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvhes
    lhhunhhnrdgthh
X-ME-Proxy: <xmx:NmuPZ9XDh_MpiDNhlODDlaBLKVLXS2h_uB6109aoMMCIJAFY-K6Uwg>
    <xmx:NmuPZwmEXyV90Tdlooep2bH3S5ZF96MIT_DMhBroPnVa72tMXjGdDQ>
    <xmx:NmuPZyfqfcEAvbT9e-cSac-6tFc9NLP31JHw0Juig7ICR-RD6slT4A>
    <xmx:NmuPZyFOjaOed4m71foccCLUxP_GPU_3H5va_wvZ-zzXSrskuCg82w>
    <xmx:NmuPZ-meFHAUXViyHENJ4Td1fUbEwD-gKDXitDKIoNtyI2xPkJiLK-y0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 04:39:01 -0500 (EST)
Date: Tue, 21 Jan 2025 10:39:00 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: ryazanov.s.a@gmail.com, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z49rNP6KRQ8H0job@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
 <Z4pDpqN2hCc-7DGt@hog>
 <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net>
 <Z4qPjuK3_fQUYLJi@hog>
 <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net>
 <Z44gwl2d8ThTshzQ@hog>
 <94e44fdb-314c-41b0-8091-cff5789735b2@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94e44fdb-314c-41b0-8091-cff5789735b2@openvpn.net>

2025-01-20, 11:45:55 +0100, Antonio Quartulli wrote:
> On 20/01/2025 11:09, Sabrina Dubroca wrote:
> > 2025-01-19, 14:12:05 +0100, Antonio Quartulli wrote:
> > > On 17/01/2025 18:12, Sabrina Dubroca wrote:
> > > > 2025-01-17, 13:59:35 +0100, Antonio Quartulli wrote:
> > > > > On 17/01/2025 12:48, Sabrina Dubroca wrote:
> > > > > > 2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
> > > > > > >     int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
> > > > > > >     {
> > > > > > > -	return -EOPNOTSUPP;
> > > > > > > +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
> > > > > > > +	struct ovpn_priv *ovpn = info->user_ptr[0];
> > > > > > > +	struct ovpn_socket *ovpn_sock;
> > > > > > > +	struct socket *sock = NULL;
> > > > > > > +	struct ovpn_peer *peer;
> > > > > > > +	u32 sockfd, peer_id;
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	/* peers can only be added when the interface is up and running */
> > > > > > > +	if (!netif_running(ovpn->dev))
> > > > > > > +		return -ENETDOWN;
> > > > > > 
> > > > > > Since we're not under rtnl_lock here, the device could go down while
> > > > > > we're creating this peer, and we may end up with a down device that
> > > > > > has a peer anyway.
> > > > > 
> > > > > hmm, indeed. This means we must hold the rtnl_lock to prevent ending up in
> > > > > an inconsistent state.
> > > > > 
> > > > > > 
> > > > > > I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
> > > > > > trying to accomplish. Is it a problem to keep peers when the netdevice
> > > > > > is down?
> > > > > 
> > > > > This is the result of my discussion with Sergey that started in v23 5/23:
> > > > > 
> > > > > https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net/
> > > > > 
> > > > > The idea was to match operational state with actual connectivity to peer(s).
> > > > > 
> > > > > Originally I wanted to simply kee the carrier always on, but after further
> > > > > discussion (including the meaning of the openvpn option --persist-tun) we
> > > > > agreed on following the logic where an UP device has a peer connected (logic
> > > > > is slightly different between MP and P2P).
> > > > > 
> > > > > I am not extremely happy with the resulting complexity, but it seemed to be
> > > > > blocker for Sergey.
> > > > 
> > > > [after re-reading that discussion with Sergey]
> > > > 
> > > > I don't understand why "admin does 'ip link set tun0 down'" means "we
> > > > should get rid of all peers. For me the carrier situation goes the
> > > > other way: no peer, no carrier (as if I unplugged the cable from my
> > > > ethernet card), and it's independent of what the user does (ip link
> > > > set XXX up/down). You have that with netif_carrier_{on,off}, but
> > > > flushing peers when the admin does "ip link set tun0 down" is separate
> > > > IMO.
> > > 
> > > The reasoning was "the user is asking the VPN to go down - it should be
> > > assumed that from that moment on no VPN traffic whatsoever should flow in
> > > either direction".
> > > Similarly to when you bring an Eth interface dwn - the phy link goes down as
> > > well.
> > > 
> > > Does it make sense?
> > 
> > I'm not sure. If I turn the ovpn interface down for a second, the
> > peers are removed. Will they come back when I bring the interface back
> > up?  That'd have to be done by userspace (which could also watch for
> > the DOWN events and tell the kernel to flush the peers) - but some of
> > the peers could have timed out in the meantime.
> > 
> > If I set the VPN interface down, I expect no packets flowing through
> > that interface (dropping the peers isn't necessary for that), but all
> > non-data (key exchange etc sent by openvpn's userspace) should still
> > go through, and IMO peer keepalive fits in that "non-data" category.
> 
> This was my original thought too and my original proposal followed this idea
> :-)
> 
> However Sergey had a strong opinion about "the user expect no traffic
> whatsoever".
> 
> I'd be happy about going again with your proposed approach, but I need to be
> sure that on the next revision nobody will come asking to revert this logic
> again :(

Sure.

> > What does openvpn currently do if I do
> >      ip link set tun0 down ; sleep 5 ; ip link set tun0 up
> > with a tuntap interface?
> 
> I think nothing happens, because userspace doesn't monitor the netdev
> status. Therefore, unless tun closed the socket (which I think it does only
> when the interface is destroyed), userspace does not even realize that the
> interface went down.

So if this behavior changes once users switch from tuntap to ovpn,
they may be surprised/unhappy.

-- 
Sabrina

