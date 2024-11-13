Return-Path: <linux-kselftest+bounces-21914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D769C6DCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A052285367
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355081FF043;
	Wed, 13 Nov 2024 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="nGTyBxRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KiaNvIii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114F1F80AF;
	Wed, 13 Nov 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497141; cv=none; b=CvMG43ynz/c9PzTnB1XGTB14fYD9IlQ9hWUgiQMk6dUC2EheKtckVpW4vSZ3++7uchaNJJtjY6J1A24sWD9rDjPZ02Jhthy5cE5/f66ZwFSvZAsLIF6vZWPu84npQdxns970VuNOKu1PqU3ZILMqAW1fr/jqx6DmJ3PvIR03FH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497141; c=relaxed/simple;
	bh=YHQWcbEHKaHc/P7TUG5kLlyBMors0zniB0SXNRzu1P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx0oLG4lwDVfxly8YbbUhX/g1i1iGrTursBMqR+TcOnq12ej7NqbEaer4yro7HP+0vrxKfNwjPN+C0N0Gl9TYqJzXzrHuf+15ZMVbAoWg9UtXaimkEoG9E93VXXW704b19r3GGI9VK0CpQTy+teyOKDjSRPqZbV+xpyRtl1PbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=nGTyBxRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KiaNvIii; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 232D72012D5;
	Wed, 13 Nov 2024 06:25:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 13 Nov 2024 06:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731497137; x=
	1731500737; bh=p+EBDf5BfjiBMMhc/gpjtuneMWwTLxbD154IjpxkN3U=; b=n
	GTyBxRjGtaSJybNcRw2FycJiZ42dGQfOdcA4HLfpOYRduKaJS97rBnTOBSO6Jac8
	mZ+RsA+ED0n43ttdVo1mgBgnVa07m2alBnIoFjGorfrZL0KkAdF3VShGF+g+2065
	rGHKNhtJqmGSA5VSDonnDH3o2UZmiVDIbhFzPoNsWp+T7pfYUV8FHCx5Um+aDv3l
	PjxYyVC72LIDhirHszFqFT7xylSepsh/Zf/m+DqtNoB/Uqnjtpa0tS6dLG7ad7C5
	UHPVUnWVlSKXnNhetOYw7Ku7fMobA9bmRBcxQc2B+cnjrIj8TKqgSPd6ZGJzaRem
	dVkwl1Bcw8LpG6S0cCLFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731497137; x=1731500737; bh=p+EBDf5BfjiBMMhc/gpjtuneMWwTLxbD154
	IjpxkN3U=; b=KiaNvIii7g1gjPnKgr/YeoiCDN1+T6UHhKzsDhA4qBUytP//hOc
	L+KcDPsId14Pv033NTJhUPN1Yn3DVUg7sI75+6+4snq8yz2NJlAypa5hefnfKTNG
	wF/wsys8W4QTRazulNvpd9GAcAV3NbZVChXb51bEhqwOhtuRBHqV1muZp7sZjNHZ
	YqHU0FIok+fpfo64El3q+2RJOatjbGPJ4mWCvsbIJIv2S8OlSfL/HQb+xhK9uUZz
	AAWp6SDwnA/v1MXO9oFYwKeK246NCGGUFlLgNbdaluHgzc1CFVEjenNdarfkmz5r
	6I6q4yU3vGyyVpqv4RR2DWly412i8bPaz2A==
X-ME-Sender: <xms:sIw0Z-UkTq3CivOWH6djwBdxiDdxe2f5ix1oksvwLA7AdSXjlpa73Q>
    <xme:sIw0Z6mPfeCpULLG5-tl6_BlU029Skck9F4mQFFdm5a6lXDNA0ZyEpu93lp1T0sZI
    8pFQ7nRT6AO2UBgLfI>
X-ME-Received: <xmr:sIw0ZyZZtFlx3G4hCR7YDk21vtmOmd2DOm5YeoQXBT7jiwHUDyDNZ6GpjiZK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddvjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:sIw0Z1WFzaFswqvsW3bc0Nn8A4x5I9SoQAeO8kDvqj2hnPKd_8MGzw>
    <xmx:sIw0Z4nn62Z7xYyRgljV0J0iZ7mXLwXg_hl6ajSoNOhGwOPFrdQqjw>
    <xmx:sIw0Z6dHqYWVHwVoDBj9SeXpYOFotxRZYRiLQzb3U6JdXdY8u8aWxQ>
    <xmx:sIw0Z6EdBVIO1aIRUktFFD6AePShjAb-ekdTvvNAYH9hRhy_wRUTPQ>
    <xmx:sIw0Zy7XYwx7MrUgeoaMYXZ5FmM3yJidc_l1jiiz6wpqrAENcG4d4iBl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 06:25:36 -0500 (EST)
Date: Wed, 13 Nov 2024 12:25:34 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 17/23] ovpn: add support for peer floating
Message-ID: <ZzSMrgFmbxX9NtIp@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net>
 <ZzM0U81dmvdEWqdF@hog>
 <955030bd-e230-448c-8a63-1b356590dd15@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <955030bd-e230-448c-8a63-1b356590dd15@openvpn.net>

2024-11-12, 15:03:00 +0100, Antonio Quartulli wrote:
> On 12/11/2024 11:56, Sabrina Dubroca wrote:
> > 2024-10-29, 11:47:30 +0100, Antonio Quartulli wrote:
> > > diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> > > index 63c140138bf98e5d1df79a2565b666d86513323d..0e8a6f2c76bc7b2ccc287ad1187cf50f033bf261 100644
> > > --- a/drivers/net/ovpn/io.c
> > > +++ b/drivers/net/ovpn/io.c
> > > @@ -135,6 +135,15 @@ void ovpn_decrypt_post(void *data, int ret)
> > >   	/* keep track of last received authenticated packet for keepalive */
> > >   	peer->last_recv = ktime_get_real_seconds();
> > > +	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP) {
> > 
> > What prevents peer->sock from being replaced and released
> > concurrently?
> 
> Technically nothing.
> Userspace currently does not even support updating a peer socket at runtime,
> but I wanted ovpn to be flexible enough from the beginning.

Is there a reason to do that? With TCP the peer would have to
reconnect, and I guess fully restart the whole process (become a new
peer with a new ID etc). With UDP, do you need to replace the socket?

> One approach might be to go back to peer->sock being unmutable and forget
> about this.
> 
> OTOH, if we want to keep this flexibility (which I think is nice), I think I
> should make peer->sock an RCU pointer and access it accordingly.

You already use kfree_rcu for ovpn_socket, so the only difference
would be the __rcu annotation and helpers? (+ rcu_read_lock/unlock in
a few places)

Adding rcu_read_lock for peer->sock in ovpn_tcp_tx_work looks
painful... (another place that I missed where things could go bad if
the socket was updated in the current implementation, btw)

Maybe save that for later since you don't have a use case for it yet?

-- 
Sabrina

