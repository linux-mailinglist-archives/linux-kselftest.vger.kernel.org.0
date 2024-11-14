Return-Path: <linux-kselftest+bounces-22016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C09C858C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 10:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752241F25E75
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4481E8859;
	Thu, 14 Nov 2024 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="xD8RPzrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B47WamvU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F829CFB;
	Thu, 14 Nov 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575047; cv=none; b=llFhWmYHCb2QENNhWdFwad/nqA+8LcfsSULw9SpNA8qj6r/XhCX76StTwrj8KPv2oPifjG9V0l3m2IimRUN3xcWBBa3QCosaXMa4r8LG87RRk2n2iP3JCRNxso5ElFCD3ZjcpYMndOHjuznsF+102mcrjPjPmsf63Ec8dg4WFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575047; c=relaxed/simple;
	bh=7BSoh5CYIXrW3QX1oTbrz1UW2luLIHecRtvcsgMl0lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RawcZypRfqUcobQyXUx+27T9zBXZZu5nWt4SZVT0bML8HUywIfBvG1amWI8duwP+dp+mpucBEHsIDBHuu7bHH54MXymawl4BShWHiM1vdqu92Q9EUkY+DC6i5YzV9WblMvqH1t8Qaiy8nbyZecdy1ya7JlZEoERJzEvbaCqbj80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=xD8RPzrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B47WamvU; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id EA698200C81;
	Thu, 14 Nov 2024 04:04:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 14 Nov 2024 04:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731575042; x=
	1731578642; bh=k+8HC8Ob/86QBDrUTivKmSt66P20tDmJvCeyr0tVG9w=; b=x
	D8RPzrCztteIqD4p3M7Ba8G+dJMd6+D2LvxM0J7dpSgMht1nR4UkZ6TwQxojqa9+
	pPIyqTnobBaddhPHPDTNf/B61QLw7xLL//l4bAJ+OOH0dtI3DLmr4HTm9HEgYxFW
	/7PfIsQTcBcCDXHRijiXWRawu8t8lRW5nI9tUXPyS0iwnCcdWYbtpmmzK7erSyv7
	65GVqOBdOq//9OjGGYiVmDMpb87gwaBPmlKBt25p8n+8cdKEpKVQgnZ5zxj6I/ba
	zDUJoDBkMdAnKN9lkdf7KdHi9LXKkXASOxYoLoPDgW4b9a6iLNSbyv1Hz93SDXhM
	Ci94OSyh6YjHzUjGO7GKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731575042; x=1731578642; bh=k+8HC8Ob/86QBDrUTivKmSt66P20tDmJvCe
	yr0tVG9w=; b=B47WamvU4RG2pWk6h03rqkfKW61ad3Anab38pbhF6Mb3oXqWh7X
	Cmc1BrUQvTCzEs11M7CBDVeX1QF+B9FWc7UU5A+ql2C4gCtTIoff3e1apj1IuG3j
	ugl/6cugWD6oD6yZlpUN8APDJr7QNNhfitfhJmFAPNtgUekyLzYtxI1UA4oP3wtI
	IO5y2hIoOhWhlNUH4eaTFCLIg2GX7PI4bJd5Se+IzJ7z53W4XPOpjZG0dcFcZ5cN
	oljWvOUrAFZOX1MJG0MEzKqLrCQBsENUu0p1b51SQxehw7lz2w/AQh21u3P3gezC
	IgPjVzfAvytfe1yQXH8gC3iEtypKp1HvVkA==
X-ME-Sender: <xms:Ar01Z3de4E1RpvXIKIr5lQ6m0nGpP2blWzet4BT4lcIrCUnjIkgzrA>
    <xme:Ar01Z9M-EU2zFLHei38II9Mz6ZY5Hnz6LQx9i58VXa6YgLcrURvhmAhG6VdwSNLnD
    WZ6Lld3VFTgjepYlm4>
X-ME-Received: <xmr:Ar01ZwiqrSqpHvx4ifxQmhF5JZ_LMvoavPEw-xoQ7jUbAdRlGcDjUs4XRQh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhh
    uhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ar01Z48B-Ca23chCb9uhiGujUw1dlCoonUO0dnbzSA3FaiBY0bIJSA>
    <xmx:Ar01ZzvoFhcdTTi1zd4FZfZCqd7w3OkKQexIGQutTAsqJ9MS9gpOmA>
    <xmx:Ar01Z3F_sCr8Ba2h_-SOgJThx48tyUuZI9ga21KID-cceWBkT2qSRA>
    <xmx:Ar01Z6Nab6yQ8alFBli5ezi6J8FcJ1_bShW6Z7_3OSuj-hcNsLw_FA>
    <xmx:Ar01Z5Aku3Ttdt_QMeuy_51B4pZmBYL2fUPmpGKmhREpQJmKFEUJlyfy>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 04:04:02 -0500 (EST)
Date: Thu, 14 Nov 2024 10:03:59 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 15/23] ovpn: implement keepalive mechanism
Message-ID: <ZzW8_3MzprfwPS4o@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net>
 <ZypfnyfToF1b6YAZ@hog>
 <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net>
 <ZzSBG-RPUlpgVFhA@hog>
 <2a90f702-3061-46b6-aafa-cf8c1ba3d0de@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a90f702-3061-46b6-aafa-cf8c1ba3d0de@openvpn.net>

2024-11-14, 09:12:01 +0100, Antonio Quartulli wrote:
> On 13/11/2024 11:36, Sabrina Dubroca wrote:
> > 2024-11-12, 14:20:45 +0100, Antonio Quartulli wrote:
> > > On 05/11/2024 19:10, Sabrina Dubroca wrote:
> > > > 2024-10-29, 11:47:28 +0100, Antonio Quartulli wrote:
> > > > > +	/* check for peer timeout */
> > > > > +	expired = false;
> > > > > +	timeout = peer->keepalive_timeout;
> > > > > +	delta = now - peer->last_recv;
> > > > 
> > > > I'm not sure that's always > 0 if we finish decrypting a packet just
> > > > as the workqueue starts:
> > > > 
> > > >     ovpn_peer_keepalive_work
> > > >       now = ...
> > > > 
> > > >                                          ovpn_decrypt_post
> > > >                                            peer->last_recv = ...
> > > > 
> > > >     ovpn_peer_keepalive_work_single
> > > >       delta: now < peer->last_recv
> > > > 
> > > 
> > > Yeah, there is nothing preventing this from happening...but is this truly a
> > > problem? The math should still work, no?
> > 
> > We'll fail "delta < timeout" (which we shouldn't), so we'll end up
> > either in the "expired = true" case, or not updating
> > keepalive_recv_exp. Both of these seem not ideal.
> 
> delta is signed, so it'll end up being a negative value and "delta <
> timeout" should not fail then. Unless I am missing something.

But timeout is "unsigned long", so the comparison will be done as
unsigned.

> Anyway, this was just an exercise to understand what was going on.
> I already changed the code as per your suggestion (the fact that we are
> still discussing this chunk proves that it needed to be simplified :))

:)

-- 
Sabrina

