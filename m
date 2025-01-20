Return-Path: <linux-kselftest+bounces-24783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A07A16A82
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24997A02BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93931AF0AE;
	Mon, 20 Jan 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="KEAs55OG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCpOx46V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126463398B;
	Mon, 20 Jan 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367754; cv=none; b=g1kj6fTxESjevuWS3UKN0sEWaIH6Qpw7ghkLHejgIpnxLfCt/jWERhpYrkgN4rOIz5hWZFznO1u5iIJSOsmIzaU0szdOxhqyZkbUBbMMUOnYKovE1DG3PgVDUKsI6p9CkooZg+KaFLnnsgbxgDwGO+MrbWsJFL2AGHd6QuLSxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367754; c=relaxed/simple;
	bh=XH23n71DeL1i9KIo1p2fK2BbqdyYrQe0PBbsqyqJHkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHDcxOcKQzznwnlZkEOQSLDFT/OHypy8a+JXlzYK1tHPznBF4TuxvqfhfxGZ9Bfe19YZfXGILZffDGs2ohowe37eY8Bhu1zsbyULYBEbotCDwXqDWZQ6SRG0gVFHl5n1Gt1hdtVWRjVnXJJ7XcsXFLHRk8DQGYpOv2ElVSl0qKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KEAs55OG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCpOx46V; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AFC0254018F;
	Mon, 20 Jan 2025 05:09:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 20 Jan 2025 05:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737367749; x=
	1737454149; bh=BUp8aXKVXZnAYl3NyVGL5x3bGBCfB+C3Mkm1ITPH3yM=; b=K
	EAs55OG9bvFq0mercZH5cFjd/6brQqIuRMc/sM4AYgKHvuYbJmNXI7OiOH3ceeNE
	/Y57jOlhCb9/5ATbpIRETgFDd7+PCJv1+vru2jH7LB9mfyx3JgbaY6bVRKl5XWDf
	aLVoov4rMnj9oAnxMaiBFLAFG2lRXmnVC9EJOwkuNE1sPZvMOmvjZ/LqPmrSUzGC
	vx07uVhX9SRIVgmg9l+x3+1ITzXeeUcd9vXmguXs66SMt/UTOg8RDKobQaFFIZHR
	gUQQGtA8twPNvlG3H9R6awtaxAcPbkMwRaEqKOUeQ7tSsY7LKAuIS2Emqx+cnd+y
	wzcTQ1/8uurEts4YhwO4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737367749; x=1737454149; bh=BUp8aXKVXZnAYl3NyVGL5x3bGBCfB+C3Mkm
	1ITPH3yM=; b=XCpOx46VWGAi4PrdvXEqtfCiVOVdCXChuxydb2m21n499A6b5RA
	8VHA3Juf8JQYuftbeqnI7Bd6bLBB//mQYN4E1gWvIm8jpJKJR5ELISoYQRy0Pobi
	dKYNV5xPQmmBxZAE2zb9W1rsjebm+KjZedi3rp+OPD/SDTBU6uU8VP6fW7lc7Dgw
	EYfzdIBK36GJ++IVRzxw/gvXXZ3ETTS2QA4QSHiHb3IYweUNTnJ7gutyyUpS0KAP
	MY5GxpcvGZcBRWGKFKsG0T7jFj4kvMJhtb19orIJnBQkoxj7rZgIT4PJMRWUWanC
	C49sR4vyIOsCtIIMButnai1/GQ8NRZJRWog==
X-ME-Sender: <xms:xCCOZ1J3-rqTkkG286uW_W3NFMc-u-i51cVIZq4KWvotLDB9QB1xNA>
    <xme:xCCOZxKWZgehUrb6DSFuauqmHgKpU3qS9RfHuwNn6eALUCsAtfssknljjau_Ovo3L
    hqPiVPu7rHMzgIpaP4>
X-ME-Received: <xmr:xCCOZ9tpej1_KogsHDkMDmH3N2iIAdHzHkrAP8xtasVqtiYYNj_g03Wu4HXr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgtdekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:xCCOZ2ZAAe1wj-GGzBeuUaUQwDGXaSYCxoArIxYwfyCW2PqzPcmECw>
    <xmx:xCCOZ8bTrxew55MAV-8T48lhp-ezaJVUl0OB0iCDZJigQj4pw0R5bQ>
    <xmx:xCCOZ6Crj31K3rjv_WnHaV4wku4ytyZ-LG0Is5sTR836e_ckQSHZBQ>
    <xmx:xCCOZ6Zke_QQRlqzCDQoLL2wrjSTeN64Itv1-UQi-8MCU-CVqfhDNg>
    <xmx:xSCOZ8odLpvXHdhp8NZsAro-DU92x2ml1xSQXpcRaEE8vFfMqxNFwTi_>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 05:09:08 -0500 (EST)
Date: Mon, 20 Jan 2025 11:09:06 +0100
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
Message-ID: <Z44gwl2d8ThTshzQ@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
 <Z4pDpqN2hCc-7DGt@hog>
 <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net>
 <Z4qPjuK3_fQUYLJi@hog>
 <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net>

2025-01-19, 14:12:05 +0100, Antonio Quartulli wrote:
> On 17/01/2025 18:12, Sabrina Dubroca wrote:
> > 2025-01-17, 13:59:35 +0100, Antonio Quartulli wrote:
> > > On 17/01/2025 12:48, Sabrina Dubroca wrote:
> > > > 2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
> > > > >    int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
> > > > >    {
> > > > > -	return -EOPNOTSUPP;
> > > > > +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
> > > > > +	struct ovpn_priv *ovpn = info->user_ptr[0];
> > > > > +	struct ovpn_socket *ovpn_sock;
> > > > > +	struct socket *sock = NULL;
> > > > > +	struct ovpn_peer *peer;
> > > > > +	u32 sockfd, peer_id;
> > > > > +	int ret;
> > > > > +
> > > > > +	/* peers can only be added when the interface is up and running */
> > > > > +	if (!netif_running(ovpn->dev))
> > > > > +		return -ENETDOWN;
> > > > 
> > > > Since we're not under rtnl_lock here, the device could go down while
> > > > we're creating this peer, and we may end up with a down device that
> > > > has a peer anyway.
> > > 
> > > hmm, indeed. This means we must hold the rtnl_lock to prevent ending up in
> > > an inconsistent state.
> > > 
> > > > 
> > > > I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
> > > > trying to accomplish. Is it a problem to keep peers when the netdevice
> > > > is down?
> > > 
> > > This is the result of my discussion with Sergey that started in v23 5/23:
> > > 
> > > https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net/
> > > 
> > > The idea was to match operational state with actual connectivity to peer(s).
> > > 
> > > Originally I wanted to simply kee the carrier always on, but after further
> > > discussion (including the meaning of the openvpn option --persist-tun) we
> > > agreed on following the logic where an UP device has a peer connected (logic
> > > is slightly different between MP and P2P).
> > > 
> > > I am not extremely happy with the resulting complexity, but it seemed to be
> > > blocker for Sergey.
> > 
> > [after re-reading that discussion with Sergey]
> > 
> > I don't understand why "admin does 'ip link set tun0 down'" means "we
> > should get rid of all peers. For me the carrier situation goes the
> > other way: no peer, no carrier (as if I unplugged the cable from my
> > ethernet card), and it's independent of what the user does (ip link
> > set XXX up/down). You have that with netif_carrier_{on,off}, but
> > flushing peers when the admin does "ip link set tun0 down" is separate
> > IMO.
> 
> The reasoning was "the user is asking the VPN to go down - it should be
> assumed that from that moment on no VPN traffic whatsoever should flow in
> either direction".
> Similarly to when you bring an Eth interface dwn - the phy link goes down as
> well.
> 
> Does it make sense?

I'm not sure. If I turn the ovpn interface down for a second, the
peers are removed. Will they come back when I bring the interface back
up?  That'd have to be done by userspace (which could also watch for
the DOWN events and tell the kernel to flush the peers) - but some of
the peers could have timed out in the meantime.

If I set the VPN interface down, I expect no packets flowing through
that interface (dropping the peers isn't necessary for that), but all
non-data (key exchange etc sent by openvpn's userspace) should still
go through, and IMO peer keepalive fits in that "non-data" category.


What does openvpn currently do if I do
    ip link set tun0 down ; sleep 5 ; ip link set tun0 up
with a tuntap interface?

-- 
Sabrina

