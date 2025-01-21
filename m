Return-Path: <linux-kselftest+bounces-24841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26ABA17ADC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 11:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5F61640A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBAE1F0E36;
	Tue, 21 Jan 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="gvnMzFxu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHCv/cn/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31B1F0E3D;
	Tue, 21 Jan 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453555; cv=none; b=WeLziWOvf0VK4Y0nsbB0kDuJZC5/qgM7Vtuv5wlFmByLkLNO35E1IssxlT4XWqOgZ8HoRqSO6MAMpPjbqKm67LEVzBcM2a0iMnQ9HZGyAZiForb6LkmwD+A07uCJvtkG+1URSINk3cf/FD2qfgOkTwm8NgFVM6RnluEtyFMQVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453555; c=relaxed/simple;
	bh=LVKqpiduUEiIE0WCvdEPHjeLOf0relobPkqN9nmrAhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8nDMmm9qtO3DDamtYoL5i4PkOy6Fk5adxregtIoGnwsQPl/HfVzEu4sj0RGSlvuxwOIz25Eys3A/Rxgp/4cvcbg08kjSbEI1iaPDKzyIuc7Stp8PPt2kdqqSR//C0nt/Bt0FLFGaiUQtC3jJMr53Dgpgt6m2gdTtRTJbDD3SSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=gvnMzFxu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHCv/cn/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29F2625401A9;
	Tue, 21 Jan 2025 04:59:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Jan 2025 04:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1737453551; x=1737539951; bh=RyXroQptzAiQEwzDVd4c7B8jEu30/OGL
	RPXRANdcL1M=; b=gvnMzFxuSuHChMmdQBlXUfoOQaB0YMQEbxuiw4ROnBx3v/Wj
	EnX+O427nZkIUXWm+hJcLxlEQIwon4c9a3b6x9QAw5oCqeuoeoePf//6iDdJIDQf
	yZ6jHRoyEybJ8yL1GAoKZyB8m17tGTKkEW8hq4ndOv8fLxuSz1c3GcI8PBPhGf7l
	YDQnEVJflmxxlEQX+YDe5MGnXE3ptlPl9QYzlDN7IDmEkoYyWf25f+7Hd6vERt+T
	7V9SYF4qjw3xo337YDptG2XJ1EC7zaxar2Dk7ZYCzckKvt6sZzT98g4rEc2iEXdx
	SrknjXfeU4ye4+vwdKeXtKn59wz08t9KgIwYJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737453551; x=
	1737539951; bh=RyXroQptzAiQEwzDVd4c7B8jEu30/OGLRPXRANdcL1M=; b=I
	HCv/cn/CyWI/WoObyKGR66dxRTyaySztEGsbAQOs/toaGSjCqsNh/XE4OUD9s0sz
	gzlgNHCJpC9YhtVv15XcYt5f/4p1xlLlD81C8RxoWEH5K8DcNUTR71/9OIoYETEN
	4jt1H3oxBPzZhAxIVXJ6ylTdFXv4PuPeBRTVSi/WMmdao6QX+IyQdQ2S5X8GXTjP
	IYXbK9vgNfyBNtGlR3ARy+3KrIVpVJMkRCXf2IwFK6uEKWeRkq6ex7HQQ/rSZOSJ
	ejZ9BHckNiGxSEO1mIfO8rhKxHJco+Fds8ZuW/T3NKJIYIFvj/j3vO0j0LTdKWF+
	bXx7SEgsRsSvmpb09AUZQ==
X-ME-Sender: <xms:7m-PZ2h8PJb5qfUL_9FzNlQOmdDU5RBC7yHX34VWbWRTojai0xeISw>
    <xme:7m-PZ3CEXHc6awYrg36B7TiTi0cmG0Zm6SYsRgcgGeOm4NtLI-9TuLRvSDTALkiE-
    4n4w7bvz7o1wdwYS7I>
X-ME-Received: <xmr:7m-PZ-FbASDVpKbYeR3uI6oOgKMjrLWgX_81Qi8q_viUbwTNRnYUVWeFhp0O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeevuddvtdevheetkedvieeugeehieev
    jeekteefgfeffeefjefgvdeftdelueefgeenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgu
    sehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhhiohesohhpvghnvhhpnhdrnhgvthdp
    rhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtth
    hopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughu
    mhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshh
    hurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghv
    sehluhhnnhdrtghh
X-ME-Proxy: <xmx:7m-PZ_Swb-8OamiMetuIbv7Oa32NFIc-r8bCGMYNkZ2Orp9rkPVkzQ>
    <xmx:7m-PZzxUvUBCAXakg2DBO9md2yRK-lt6jNT2xT8uYmEXD3632sksKg>
    <xmx:7m-PZ95hgdrJ0QJtvBs0H55vYdyaWaWVN8hjJ_C6-v9eZKdPSHlDkA>
    <xmx:7m-PZwyxSXZqay0m2EQ_XZjdYe7-R1z0flKVR7LA1DTkNWl9El5J6g>
    <xmx:7m-PZ7gAau3uUsd9XYpDFj6pQ3DQpNTQpdP4FurA_PiDHMzIFRa44uM0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 04:59:10 -0500 (EST)
Date: Tue, 21 Jan 2025 10:59:08 +0100
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
Message-ID: <Z49v7Ah4nUPMVgMM@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
 <Z4pDpqN2hCc-7DGt@hog>
 <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net>
 <Z4qPjuK3_fQUYLJi@hog>
 <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net>
 <Z44gwl2d8ThTshzQ@hog>
 <94e44fdb-314c-41b0-8091-cff5789735b2@openvpn.net>
 <4238ae90-9d3f-4c6a-b540-bea3c2e1addc@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4238ae90-9d3f-4c6a-b540-bea3c2e1addc@openvpn.net>

2025-01-20, 22:20:40 +0100, Antonio Quartulli wrote:
> On 20/01/2025 11:45, Antonio Quartulli wrote:
> [...]
> > > > > > > I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
> > > > > > > trying to accomplish. Is it a problem to keep peers
> > > > > > > when the netdevice
> > > > > > > is down?
> > > > > > 
> > > > > > This is the result of my discussion with Sergey that
> > > > > > started in v23 5/23:
> > > > > > 
> > > > > > https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-
> > > > > > de4698c73a25@openvpn.net/
> > > > > > 
> > > > > > The idea was to match operational state with actual
> > > > > > connectivity to peer(s).
> > > > > > 
> > > > > > Originally I wanted to simply kee the carrier always on,
> > > > > > but after further
> > > > > > discussion (including the meaning of the openvpn option
> > > > > > --persist- tun) we
> > > > > > agreed on following the logic where an UP device has a
> > > > > > peer connected (logic
> > > > > > is slightly different between MP and P2P).
> > > > > > 
> > > > > > I am not extremely happy with the resulting complexity,
> > > > > > but it seemed to be
> > > > > > blocker for Sergey.
> > > > > 
> > > > > [after re-reading that discussion with Sergey]
> > > > > 
> > > > > I don't understand why "admin does 'ip link set tun0 down'" means "we
> > > > > should get rid of all peers. For me the carrier situation goes the
> > > > > other way: no peer, no carrier (as if I unplugged the cable from my
> > > > > ethernet card), and it's independent of what the user does (ip link
> > > > > set XXX up/down). You have that with netif_carrier_{on,off}, but
> > > > > flushing peers when the admin does "ip link set tun0 down" is separate
> > > > > IMO.
> > > > 
> > > > The reasoning was "the user is asking the VPN to go down - it should be
> > > > assumed that from that moment on no VPN traffic whatsoever
> > > > should flow in
> > > > either direction".
> > > > Similarly to when you bring an Eth interface dwn - the phy link
> > > > goes down as
> > > > well.
> > > > 
> > > > Does it make sense?
> > > 
> > > I'm not sure. If I turn the ovpn interface down for a second, the
> > > peers are removed. Will they come back when I bring the interface back
> > > up?  That'd have to be done by userspace (which could also watch for
> > > the DOWN events and tell the kernel to flush the peers) - but some of
> > > the peers could have timed out in the meantime.
> > > 
> > > If I set the VPN interface down, I expect no packets flowing through
> > > that interface (dropping the peers isn't necessary for that), but all
> > > non-data (key exchange etc sent by openvpn's userspace) should still
> > > go through, and IMO peer keepalive fits in that "non-data" category.
> > 
> > This was my original thought too and my original proposal followed this
> > idea :-)
> > 
> > However Sergey had a strong opinion about "the user expect no traffic
> > whatsoever".
> > 
> > I'd be happy about going again with your proposed approach, but I need
> > to be sure that on the next revision nobody will come asking to revert
> > this logic again :(
> > 
> > > 
> > > 
> > > What does openvpn currently do if I do
> > >      ip link set tun0 down ; sleep 5 ; ip link set tun0 up
> > > with a tuntap interface?
> > 
> > I think nothing happens, because userspace doesn't monitor the netdev
> > status. Therefore, unless tun closed the socket (which I think it does
> > only when the interface is destroyed), userspace does not even realize
> > that the interface went down.
> 
> What does IPsec do in this case? Does it keep connections open and
> keepalives flowing?

I don't think IPsec is a good comparison, because it can be used
without any interface at all (and without UDP/TCP encap sockets), and
they're not strongly tied to packet processing. If an interface is
used, the implementation will send the packets through it, otherwise
it's perfectly happy to send packets back and forth without it.

MACsec is a bit more similar (all crypto state is bound to the macsec
netdevice -- but no socket and no keepalive), and here the key
exchange packets all flow directly through the real interface (eth0 or
whatever), without worrying about the state of the macsec device
(although I guess the userspace taking care of key exchange is free to
stop sending when the admin turns the link down).

> One counter example we have in the kernel are 802.11 interfaces.
> Any 802.11 interface must be brought up before you can possibly establish a
> WiFi link. If you bring the interface down the link is closed and no 802.11
> control packets flow anymore.
> 
> However, 802.11 is different as we are controlling a "physical behaviour",
> while in ovpn (like other tunneling modules) we are controlling a "virtual
> behaviour".

Agree, 802.11 is a bit special.

(I see you already answered my previous message, but since I've
written all this anyway... :))

-- 
Sabrina

