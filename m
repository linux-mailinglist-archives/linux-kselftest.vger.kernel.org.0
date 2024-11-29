Return-Path: <linux-kselftest+bounces-22620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B649DE725
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 14:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A8B20757
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77119D083;
	Fri, 29 Nov 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="fej70535";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctI3S9Eo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B11991AA;
	Fri, 29 Nov 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886430; cv=none; b=bcSYRoRu6uevk6tP8kbUZHtu60GPigT1WyQmUr0gpGDxCigGOg61w86YkvrOcsmv91wYtbt2NHr7dGGew7PvOiQfr50R6qNruXyZ2XHuo/rbH6PxsSD1oqAUIXViXhQWTpu+VZuyJEfgVjY2jzHcroLN2J2dREJOVoXLc7oXI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886430; c=relaxed/simple;
	bh=iTbx20FnA7mezjqwLAY+/IuoW3ith2+9M0JvvXtPX0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtDOhdmV1IA/M9NGScNHH/U37HUeTYJA9rcRzzoscbj4YD+AqO85HMfynKxg86zCOzO7nshKC8tVyz83XVO+GkJN+dsJJD9M8pbRajgJlS1XpC8JH5el9lgdqxA3e7gEaP8zbIgR2CcYqMolauMiTE+87DgKU+Q3oqRlUcCl1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=fej70535; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctI3S9Eo; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 7329F1D40683;
	Fri, 29 Nov 2024 08:20:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 29 Nov 2024 08:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1732886424; x=1732890024; bh=EPOGgKgGObNAQHsXiiSQb3xlJnijbFXb
	QhOX2B+lx+o=; b=fej70535UCBmHVKcXNhfAhlR/jhGtidVpo5pJLtCAeKk4Ajg
	YSZ7/lJ6dq8iH8Z5TaizYpMLp8+FXg3R12gu2riF+hEIJcYqW0/qYwUDkel1W343
	AUQEAgISgADcpT9Y4aAHJ1Hc9YS5ad52QaURVDkMt++gVPdZIZSWB4i6DAVRfcMy
	9P//AMmZbgfnhymgQU1lSAICeuTt/mvhLvKB0oow8Yr6bcjvLeUTY6foeO9HvtLY
	AnNnpXTyTglYBpVctpzbI58ri/y4CehM/c5ap4I5o7CeCrRyDw6ITXWdpTO/JfpN
	Ata/Ac5X0zzhMRmEN9IgO4+QT0kQHPT2iMzR7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886424; x=
	1732890024; bh=EPOGgKgGObNAQHsXiiSQb3xlJnijbFXbQhOX2B+lx+o=; b=c
	tI3S9EoPo5o6+rdHq3rlUq5B+Q9EdRJakWYdd7Xvgn4XAN3+yuTBpARoQgqoG1TC
	I2Bp7NM28MRrI7/smYkv3c+5FvcSY5tRoxk5O4IJBcQWh1JSeA6Eses1WVHRVZze
	5cAgZNSfaYoIpS5oqAlMr0/u2egGZf3z091/c0OoD7JO+gn6TLTBCF8oTGUtG4Kk
	vdM/xeymOBZoxE3Ihsx3pTUkZSU0OH12SAZ1Lbi15+X3Lht5fnAUSynoSAOS/Wi1
	/puTtTqNpJTP6nJN5SaWD6xOyGOWgj16ygoEKTu0lwAvvX7mgaKQFjHD7w5uccKu
	L3Xrtn2a9auBDT2ien31g==
X-ME-Sender: <xms:l79JZ3bjareX1OoILt0RdP2mC7HxbqBSkD64le-FJi_TPEkx18lPXw>
    <xme:l79JZ2b5nG08rsza_SKqyUXClt7O7KXaxi3Y5o7tnRrnjEQ2iUWg4CfhTXX0u0MbT
    qO2vG5JOB4gdjQHSyo>
X-ME-Received: <xmr:l79JZ58sUAn_4Nb5tvvakj0FcfkMK2nw9EvUXYLEO0otawtgEXr7ELpn2kNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfeg
    ueehteevveegveejudelfeffieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehrhigriigrnhhovhdrshdrrges
    ghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:l79JZ9pFsUgccpZ76qwWHD8PMyfPmurXvaGJBnGVQuTsKjYplic9ZA>
    <xmx:l79JZypeeOU6SnqpYwAuLEmeUhAf9qAyKu7iMltcqN3UETcHD-tZQQ>
    <xmx:l79JZzRweJSzXH-AekE8R-D2QOevQfEneS-aIHZ_FGSzPZagLJjUJw>
    <xmx:l79JZ6oPpGYxnV1ZyaIrER1XaUhMrsdmofa8rCDFfg8Gm6u4UnLWHA>
    <xmx:l79JZ-d6bw3TTaAxKu9jFa9BgSuSuxp3uIRgxLTqFt7VjByWLt7LnJ9J>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Nov 2024 08:20:23 -0500 (EST)
Date: Fri, 29 Nov 2024 14:20:20 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
Message-ID: <Z0m_lNTOAV7yL9wo@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
 <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
 <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com>
 <4c24d8ba-35d0-4aff-b207-9eca6eeda1fc@openvpn.net>
 <a4a537df-900b-43e6-bcc2-5049036b1ca2@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4a537df-900b-43e6-bcc2-5049036b1ca2@openvpn.net>

2024-11-27, 02:40:02 +0100, Antonio Quartulli wrote:
> On 26/11/2024 09:49, Antonio Quartulli wrote:
> [...]
> > > 
> > > The potential issue is tricky since we create it patch-by-patch.
> > > 
> > > Up to this patch the socket releasing procedure looks solid and
> > > reliable. E.g. the P2P netdev destroying:
> > > 
> > >    ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
> > >      ovpn_peer_release_p2p
> > >        ovpn_peer_del_p2p
> > >          ovpn_peer_put
> > >            ovpn_peer_release_kref
> > >              ovpn_peer_release
> > >                ovpn_socket_put
> > >                  ovpn_socket_release_kref
> > >                    ovpn_socket_detach
> > >                      ovpn_udp_socket_detach
> > >                        setup_udp_tunnel_sock
> > >    netdev_run_todo
> > >      rcu_barrier  <- no running ovpn_udp_encap_recv after this point
> > >      free_netdev
> > > 
> > > After the setup_udp_tunnel_sock() call no new ovpn_udp_encap_recv()
> > > will be spawned. And after the rcu_barrier() all running
> > > ovpn_udp_encap_recv() will be done. All good.
> > > 
> > 
> > ok
> > 
> > > Then, the following patch 'ovpn: implement TCP transport' disjoin
> > > ovpn_socket_release_kref() and ovpn_socket_detach() by scheduling
> > > the socket detach function call:
> > > 
> > >    ovpn_socket_release_kref
> > >      ovpn_socket_schedule_release
> > >        schedule_work(&sock->work)
> > > 
> > > And long time after the socket will be actually detached:
> > > 
> > >    ovpn_socket_release_work
> > >      ovpn_socket_detach
> > >        ovpn_udp_socket_detach
> > >          setup_udp_tunnel_sock
> > > 
> > > And until this detaching will take a place, UDP handler can call
> > > ovpn_udp_encap_recv() whatever number of times.
> > > 
> > > So, we can end up with this scenario:
> > > 
> > >    ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
> > >      ovpn_peer_release_p2p
> > >        ovpn_peer_del_p2p
> > >          ovpn_peer_put
> > >            ovpn_peer_release_kref
> > >              ovpn_peer_release
> > >                ovpn_socket_put
> > >                  ovpn_socket_release_kref
> > >                    ovpn_socket_schedule_release
> > >                      schedule_work(&sock->work)
> > >    netdev_run_todo
> > >      rcu_barrier
> > >      free_netdev
> > > 
> > >    ovpn_udp_encap_recv  <- called for an incoming UDP packet
> > >      ovpn_from_udp_sock <- returns pointer to freed memory
> > >      // Any access to ovpn pointer is the use-after-free
> > > 
> > >    ovpn_socket_release_work  <- kernel finally ivoke the work
> > >      ovpn_socket_detach
> > >        ovpn_udp_socket_detach
> > >          setup_udp_tunnel_sock
> > > 
> > > To address the issue, I see two possible solutions:
> > > 1. flush the workqueue somewhere before the netdev release
> > 
> > yes! This is what I was missing. This will also solve the "how can the
> > module wait for all workers to be done before unloading?"
> > 
> 
> Actually there might be even a simpler solution: each ovpn_socket will hold
> a reference to an ovpn_peer (TCP) or to an ovpn_priv (UDP).
> I can simply increase the refcounter those objects while they are referenced
> by the socket and decrease it when the socket is fully released (in the
> detach() function called by the worker).
> 
> This way the netdev cannot be released until all socket (and all peers) are
> gone.
> 
> This approach doesn't require any local workqueue or any other special
> coordination as we'll just force the whole cleanup to happen in a specific
> order.
> 
> Does it make sense?

This dependency between refcounts worries me. I'm already having a
hard time remembering how all objects interact together.

And since ovpn_peer_release already calls ovpn_socket_put, you'd get a
refcount loop if ovpn_socket now also has a ref on the peer, no?

-- 
Sabrina

