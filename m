Return-Path: <linux-kselftest+bounces-28068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8616A4C560
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C041160EB9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4E1C84A8;
	Mon,  3 Mar 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="gfyVgLKw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A1oiCjgT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02D190468;
	Mon,  3 Mar 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016321; cv=none; b=V3H7VVAn+CGSb0IAMgtGle3ufWuSCQrOjiwLuyJ2RrepatL6kD7vBF1bCzhBiIFnvvGgQN4aos49lsfkK9TQW7D4aF34ruu1OoPeV0lnFVp0V+UBLe8fTx12FG/VYZFXbTinIyVMuA1NEDrsMxVvX9t3w2SjCh+Qin1xD6zUyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016321; c=relaxed/simple;
	bh=zwcRo8Jb1qRhXHfePb8v1xljWs0mJ5UAz4GPWrIhfuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgb4OywEkK3ceO1GptVJ/D7cHo9NrCjPeYD9rKduFJ+eRL0DEq70y9+ywcCtSoUpiYvGuoNmr8nsntOTGF2CTsAS5hxvMo2q9kCnDVKsJA0p3H7vR0t9mbNZgXcIg6oHr9ysv7ZzF0mMQmhzarjyj0Z6td2/qnzSUYjC80J8tQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=gfyVgLKw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A1oiCjgT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EEE425401FA;
	Mon,  3 Mar 2025 10:38:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 10:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741016316; x=
	1741102716; bh=O1f/uHg0aPjtGKCT9KiWQYEt0A1Zdgh12YD7b9SeJK0=; b=g
	fyVgLKwmlgD+q/LWPncJcwJh0nZRMkPlUWXzrvf/QX/rFbUDkZuV/XAG7OP39sdR
	1e0kJXlFvgE/n1DQf9hjs0DKG9ZnYKXZ35suwBXQ4A+a52Oo2S/qiUnPwhwgA65p
	xNORG1MwBQkS/oXZI4KKXY764i3FtcvJ5E4OzdCIM7vskIb0egvIGHJ38J8Dgs4G
	W2j8CVXCUA0e2NI7wQ4ICFIIiakvGGfii1gSTx+9gL5CEYn15G2VfEUXXKYggZHe
	nlzAuI0BAH/ZhxEO1ZX9PrnFGK2CE1qYEj4esJoipdqW5LJnia0ywyfakfn9Fk7U
	/kqFK0LZPH+MebWUtAWjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741016316; x=1741102716; bh=O1f/uHg0aPjtGKCT9KiWQYEt0A1Zdgh12YD
	7b9SeJK0=; b=A1oiCjgTowaGp+i2BJteKXRqRJ1xjsnSoME3lqE9hoqCuUG5PZk
	1vRF5y1RwoB5WI6dLVby8nIZM+Nej7Norkf3zzKNphrJqKvtehLESbqSdj2VdDQ8
	KK5Dj5Nml73aVakpEnJjb2Q9g1GoWUAsQxTfWuGW0pWlruDqUq+GLVDp1RwtPqft
	YqRbiazom928cNST79mLrlIpRbh9Kqt4V4SPenJ7KzU/I22G/R/ji/1RpMDZlZAq
	VJWnxT3SsNkNT+kXf4mtBMhDwHc14FroJ6PjZoI4iiV/DrUpN4ar2of+w3DUOt1k
	prDy9YUqDbDJ5Kt7ptHl/h0ziT57tmshRJw==
X-ME-Sender: <xms:_MzFZ7CBzETl4XS4mg9Zb0Q9LsUlMrA4vUY4w3aJuhtkQOSUu7gnMQ>
    <xme:_MzFZxh0zX37Uac9085qE7D2AAzJDvxXXCdskkd1B7OxEi4VbNMmgaNK8LZlRpqRt
    tPjb68XYx_GotX3AfU>
X-ME-Received: <xmr:_MzFZ2lWSPTJyr7PXHTAk0XT8Bu3CF-yeqTeMFS3hyfp-bAX1tcUiwaU60SY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeghffftdevudfgkeffjedvieeilefh
    tefffeefgfehvdevhfejjedvkeefleeggfenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgu
    sehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhhiohesohhpvghnvhhpnhdrnhgvthdp
    rhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhigriigrnhhovh
    drshdrrgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghv
    sehluhhnnhdrtghh
X-ME-Proxy: <xmx:_MzFZ9yMHvyXfXiX_OqQfHQsmGC-muLeLJJqdWYlnePg3B9HZB24bg>
    <xmx:_MzFZwRmo6r_Twm2u976IvcrptgmPadn2fBcN6dsGWF4NYFdJ-KL7w>
    <xmx:_MzFZwak0HnaYdR6BEcQ10bftjc-COx8ESLw6D0OAvzxrO-cP5DRmg>
    <xmx:_MzFZxTMWC3A9yA6vWxWt9hTfkoNThPWCbyNzzODUK7gSlcjd8u-iw>
    <xmx:_MzFZyAd8xjTBdGSaZlbYlP6apyWu0GKk1M1auvtRfkuJtuOkZMbhLEV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 10:38:36 -0500 (EST)
Date: Mon, 3 Mar 2025 16:38:34 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v20 15/25] ovpn: implement multi-peer support
Message-ID: <Z8XM-g0LUz4djxvL@hog>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-15-93f363310834@openvpn.net>
 <Z8WpxDpHYzG9pXNl@hog>
 <2682e274-6be1-4366-a2f6-c870aa9e1252@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2682e274-6be1-4366-a2f6-c870aa9e1252@openvpn.net>

2025-03-03, 15:45:23 +0100, Antonio Quartulli wrote:
> On 03/03/2025 14:08, Sabrina Dubroca wrote:
> > > +			if (ovpn_sock && ovpn_sock->sock->sk == sk)
> > > +				skip = false;
> > > +			rcu_read_unlock();
> > > +
> > > +			if (skip)
> > > +				continue;
> > 
> > 
> > The skip/continue logic looks a tiny bit strange to me, maybe this:
> 
> Hehe, it's like a double negation. I agree it can be improved.
> 
> > 
> > 	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
> > 		bool remove = true;
> 
> does the netdev coding style allow to use locally scoped variables?
> Or should I declare everything at the beginning of the function?
> 
> I had this rule in mind, but it may have been eliminated by now.

Based on a few samples from net/core/dev.c, I'd say it's allowed:
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/core/dev.c?id=357660d7596b#n4634
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/core/dev.c?id=357660d7596b#n11404
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/core/dev.c?id=357660d7596b#n12319
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/core/dev.c?id=357660d7596b#n12531

> > 
> > 		/* if a socket was passed as argument, skip all peers except
> > 		 * those using it
> > 		 */
> > 		if (sk) {
> > 			rcu_read_lock();
> > 			ovpn_sock = rcu_dereference(peer->sock);
> > 			remove = ovpn_sock && ovpn_sock->sock->sk == sk;
> > 			rcu_read_unlock();
> > 		}
> > 
> > 		if (remove)
> > 			ovpn_peer_remove(peer, reason, &release_list);
> > 	}
> > 
> > 
> > (only if you agree it looks better - if it's my opinion against yours,
> > ignore me since it's really just coding style/taste)
> 
> Yours look simpler/cleaner. I'll go with it.

ok :)

-- 
Sabrina

