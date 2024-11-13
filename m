Return-Path: <linux-kselftest+bounces-21944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8309C745A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2FB287378
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592E203700;
	Wed, 13 Nov 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AnVGeE8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W/HHoSl+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10376203705;
	Wed, 13 Nov 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508118; cv=none; b=uuDxM46KWKMUkDxczmj6lADX7CKcXkIIxz/ueWZ662fIQKQNAeE+3vhozDfVxfoW5/2w/rgKem134l0g/EjM9QRNM/V+N2DkJf6qDOT1ACCG9Y/dXUfe5F44gQIjBXS5VjKsH5CzzpwP9pL/88uU0H54kQ1FU3lc2/pyMtMXasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508118; c=relaxed/simple;
	bh=T6WWtGB0J+rpj2jwFqRdZVX7AMs5ZhTnpPxZDMuLMcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvGH8d9yhyjVJ0h/fkR1GJwUNqedWGMBUsQuFPNYe5KQsBqL0dFGe+VPyybDBrZ1gLH0ogZEycWFgyjbRtSlzqLaFFdYxorbZWquHy2yIqFAuv+Oj2p+wHuVmJpqDRn+tcdwbF2v+aBTwonZuCngG6kB3ZJmSmDK3TQ6V/E3sLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AnVGeE8o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W/HHoSl+; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id EEB7E201018;
	Wed, 13 Nov 2024 09:28:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 Nov 2024 09:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731508112; x=
	1731511712; bh=pUl1r2Mvx6ff00sQzE72QitBkkVyOc7aFSVWrul/nDg=; b=A
	nVGeE8oeVvqjhxCBodOu9W//Aqg9htFS2aZzRPyhpADYJkfePHJIvOClRuNyawYg
	lOSR6b9FJv1sRkqbQ72BQ7OCNuCMPbJrdCHGjqhMRkygJpw7VxsP+pkkOqxLSDNw
	DGxgvYhFlWeR61w5OppTNCqVNFrt5p2NvYgGHhh95ITP5Ithjq2lNAHTj4vIEWk/
	QA9phHVQsQsYdKmSOEVlGV6il5u0GW6hSMCAD64CXjI6I6YmO2JZo7kzKr/j3Ojc
	hMyRJRxXZiq9pQ7/5iDDlQxzv4HhZI419P0tQZFN3B34Nf1sgAC31nQD0kz911K9
	s68jTYdKkVO0vaMGBQGcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731508112; x=1731511712; bh=pUl1r2Mvx6ff00sQzE72QitBkkVyOc7aFSV
	Wrul/nDg=; b=W/HHoSl++OrpJRU9YCjLqVCvayoqcvlC3IT+G7I/gJMP0n2Jq1o
	M5sCZS4szHmtSq5K6Oe2JUiZjs9vYeO9IVezPcFo+sgEjV7IPGdvFbv8putnQ4Ya
	c/hiMAn1w+iwPEoTQXlCl5vAVNvr9naYwin05kfS9yuNYDi+rCGGQuDM5rGjOB/F
	LbrcX8fgrk4VpyjfNR+Kf7MbBtU56bE/JtdITGYjSa/VvV9HkmnFCTg+BhW/HNIH
	QTTrRYBk2j37Wb6uAHK5qxGdITXkjEMVJz4tVOrHH6yUrIAij8sNQOUI+vJGNu6Y
	vDvn7VRdMZCpx5bNZWLmGGs3SoO05Y9uTAw==
X-ME-Sender: <xms:kLc0Z69e1qEpxwPp6FTd0Fu8wZOySMsBAP91DlYyI02GaKD4sk8kiw>
    <xme:kLc0Z6umodRV-r_wryJbO9irNktiE4kR61fN0yg_dX5IsORgeGV4-n8u8Boj0U709
    HJJ1vnnmaPnZGUsziI>
X-ME-Received: <xmr:kLc0ZwDxlashxqeT-niw115NrT9yiCu9IPmLDASfY2ts59H9WGHjpj0JF-Ai>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdeigecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:kLc0ZycJQTY4-unAljXlxtbCM129uhAzAtPqWz_bvhNq2oOHWY8k-A>
    <xmx:kLc0Z_OzIQZc983itz_PARnbOkrPYuh2HTJgXbXDT_VH-IgDfVTONg>
    <xmx:kLc0Z8mM8ALLDeQsZbsm7eJUeUk_bUBwio7liBqEOFm34B7yVSrkLg>
    <xmx:kLc0ZxsZ0ujjsNBJpq7j2fO7pgGWJZZvB9BTSMct9Br60uGa3F9ybQ>
    <xmx:kLc0Z4gZoyju8d-iWlQ6cbt_4EVBn5nIDBcbuH65DqmH_OMej9pQ6nwL>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 09:28:32 -0500 (EST)
Date: Wed, 13 Nov 2024 15:28:30 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 20/23] ovpn: kill key and notify userspace
 in case of IV exhaustion
Message-ID: <ZzS3jgNQoDH_0TvK@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-20-de4698c73a25@openvpn.net>
 <Zyn0aYyPVaaQJg3r@hog>
 <816d8b43-8c19-4a4c-9e37-98a3415848b5@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <816d8b43-8c19-4a4c-9e37-98a3415848b5@openvpn.net>

2024-11-12, 16:44:09 +0100, Antonio Quartulli wrote:
> On 05/11/2024 11:33, Sabrina Dubroca wrote:
> > 2024-10-29, 11:47:33 +0100, Antonio Quartulli wrote:
> > > +int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
> > > +{
> > [...]
> > > +
> > > +	nla_nest_end(msg, k_attr);
> > > +	genlmsg_end(msg, hdr);
> > > +
> > > +	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
> > > +				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
> > > +
> > 
> > Is openvpn meant to support moving the device to a different netns? In
> > that case I'm not sure the netns the ovpn netdevice is in is the right
> > one, the userspace client will be in the encap socket's netns instead
> > of the netdevice's?
> > 
> > (same thing in the next patch)
> 
> Well, moving between netns's may not be among the most common use cases, but
> I can see people doing all kind of weird things, if not forbidden.

The idea would be that only the ovpn device is in one particular
netns, so that no packets can make it out of that netns unencrypted. I
don't know if anybody actually does that.

> Hence, I would not assume the netdevice to always stay in the same netns all
> time long.
> 
> This said, what you say assumes that the userspace process won't change
> netns after having added the peer.

That shouldn't matter as long as it's still listening to multicast
messages in the original netns.

Around that same "which netns" question, ovpn_udp{4,6}_output uses the
socket's, but ovpn_nexthop_from_rt{4,6} uses the netdev's.

-- 
Sabrina

