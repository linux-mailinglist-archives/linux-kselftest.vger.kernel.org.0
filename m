Return-Path: <linux-kselftest+bounces-22632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0B49DEB60
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 18:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E0163297
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9914A624;
	Fri, 29 Nov 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="IELm5I2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="raccWWOV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A13224;
	Fri, 29 Nov 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899624; cv=none; b=U8jPiEbL0rX0Ert1cjLztLdferR4i62yMryfaJ98itba0W4SPi5MYSxYwoSTKT5veQJ7VmmXKeaxVcn9bfxrYa27HKUzxGyoHihJtvnz1/ZBcc46YPI6BBGuOhjRUXe/11rDuflWOFR5DnMineEelDPKCX8Xhv7CiRxL3B5qaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899624; c=relaxed/simple;
	bh=CtNzinqF27+J7mwoo0xd6N7UlEds77+5yvAiOjYpCc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4r2UJP3jUstejRBjAmuBOxr48toZvgpQY1Cse19TX4/KATXA3x89x4Lj0n9bHTYLF9DcKtliWSk0c58UvGKflxe/v26PqUGG6AcONKe23Ji1y1vDjClqX5cVZzl9gHmRUyx3b4ywQWZt9bO8iexAG45mgf77tbPNjtDe3y4WgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=IELm5I2a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=raccWWOV; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 0D5981D40E15;
	Fri, 29 Nov 2024 12:00:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 29 Nov 2024 12:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732899618; x=
	1732903218; bh=vCE1zA7yi53FRV7humf9JVIisBT66Uzk/D9uQNQavhY=; b=I
	ELm5I2a5NXbgjCWiWYREEVQZcDrdguNkRHXu6W5IuWZ0nNCWvmD43G7Ib2Klrv2Y
	n+2eUv8JlHcVCzU4L77YvPl8M6pbUXVPKjAa44i6eklZJU0LnUOVWk4uys8n2FMh
	3JXGEH3nBTKcM49rk7oeirsswbgbcA+71LQgABi+j35c12Hei/mstreQdj59KDCu
	3wM5O8VpgQbkKPnZyZSkFrAVQylc9FRJ1aH/nxhF6bdVYQh4uRD2rRy57yRMzfDN
	wgwqkjHfVUnI4GlZw+KwOcds8GkhTYy2AB8y6bFsuiiOAAaPifMkJHKdO6SF8SWZ
	RTr5QxrI6CklpX+WParrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732899618; x=1732903218; bh=vCE1zA7yi53FRV7humf9JVIisBT66Uzk/D9
	uQNQavhY=; b=raccWWOVFBvPEEjUI06/G1PUS2N24zz3LJCuvlkhAaHZ6iLfgTZ
	mCaSzfEIeAnSSVIPuFEYHwm22LmNvct9a1h+fK91XhUyAgz7cCKfKHYvrzA07rxR
	qeTCA5hlF19NLpBtXFmHZC0ZhMBNDmRZzKAJP2rj8WMVz++Vbbh0LJf2WStP2PLQ
	yuCkYHpotwj/iKsSZQ5UbqZFrj9341B4p5uMDVZr/CjPJ8gBZKSdwO0BIsikwcA8
	umMbo03ZDzoCKF6i/5ftDSTSC7lob/GcqvnEa93DWBTMVj+b0L3AarGYEbAsRWAD
	/g6/Fa/iltagiYYL3oRpi0huEZFGHcBfhMQ==
X-ME-Sender: <xms:IfNJZwRNfydcXxZb-CUjNYjlEjnAkqHQMiKAGEZxsAyzPyCeThFNWQ>
    <xme:IfNJZ9x-C_Aq0o-do3WyPXEZsEeX4wuechzypK1VBB3iHx0WqB86yi-UeQoyacloK
    knJjWPtCtYwMDgtlrU>
X-ME-Received: <xmr:IfNJZ90DDzs6nCR_kR1o1R1yywUYHWpcMXet-jXlJtZu8ukydvQEABo4Uxzl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdelfecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:IfNJZ0CffB1Y_xp9dHTt_Ujsf3MyJmCKT-YItExT9FafTjCQ9Bqd-w>
    <xmx:IfNJZ5gSZxA6E8Ug-KKsXfw_e1W4D5TCG69MHkP_AbwcCVKkZfOXzQ>
    <xmx:IfNJZwoXngtXpsSlW4IojqsalD8eDc7gQVajDZGHeCzEGRnRJpsvLQ>
    <xmx:IfNJZ8hc2FYcm3yKsJ8rW1dklHeRYKAUrfB6ClFl3jF8Z-fzh_q1vg>
    <xmx:IvNJZ6WdqvQKEu_UCIlXiPKXKbHYXft45fx0_yCyLrIM61LIXkwV-iew>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Nov 2024 12:00:16 -0500 (EST)
Date: Fri, 29 Nov 2024 18:00:14 +0100
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
Message-ID: <Z0nzHn3OsNeUIQPZ@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>
 <ZzIlxRbic7qLVD4F@hog>
 <136282ad-77d9-4799-bd2d-f3c3c9df99c0@openvpn.net>
 <ZzSH-Ke4wuJcis0q@hog>
 <5ae6f624-5196-42f7-a0b8-85e2847b3fdf@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ae6f624-5196-42f7-a0b8-85e2847b3fdf@openvpn.net>

2024-11-14, 11:32:36 +0100, Antonio Quartulli wrote:
> On 13/11/2024 12:05, Sabrina Dubroca wrote:
> > 2024-11-12, 15:26:59 +0100, Antonio Quartulli wrote:
> > > On 11/11/2024 16:41, Sabrina Dubroca wrote:
> > > > 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
> > > > > +void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
> > > > > +	__must_hold(&peer->ovpn->peers->lock)
> > > > 
> > > > Changes to peer->vpn_addrs are not protected by peers->lock, so those
> > > > could be getting updated while we're rehashing (and taking peer->lock
> > > > in ovpn_nl_peer_modify as I'm suggesting above also wouldn't prevent
> > > > that).
> > > > 
> > > 
> > > /me screams :-D
> > 
> > Sorry :)
> > 
> > > Indeed peers->lock is only about protecting the lists, not the content of
> > > the listed objects.
> > > 
> > > How about acquiring the peers->lock before calling ovpn_nl_peer_modify()?
> > 
> > It seems like it would work. Maybe a bit weird to have conditional
> > locking (MP mode only), but ok. You already have this lock ordering
> > (hold peers->lock before taking peer->lock) in
> > ovpn_peer_keepalive_work_mp, so there should be no deadlock from doing
> > the same thing in the netlink code.
> 
> Yeah.
> 
> > 
> > Then I would also do that in ovpn_peer_float to protect that rehash.
> 
> I am not extremely comfortable with this, because it means acquiring
> peers->lock on every packet (right now we do so only on peer->lock) and it
> may defeat the advantage of the RCU locking on the hashtables.
> Wouldn't you agree?

Hmpf, yeah. Then I think you could keep most of the current code,
except doing the rehash under both locks (peers + peer), and get
ss+sa_len for the rehash directly from peer->bind (instead of using
the ones we just defined locally in ovpn_peer_float, since they may
have changed while we released peer->lock to grab peers->lock). We may
end up "rehashing" twice into the same bucket if we have 2 concurrent
peer_float calls (call 1 sets remote r1, call 2 sets a new one r2,
call 1 hashes according to r2, call 2 also rehashes based on r2). That
should be ok (it can happen anyway that a "real" rehash lands in the
same bucket).

peer_float {
  spin_lock(peer)
  match/update bind
  spin_unlock(peer)

  if (MP) {
    spin_lock(peers)
    spin_lock(peer)
    rehash using peer->bind->remote rather than ss
    spin_unlock(peer)
    spin_unlock(peers)
  }
}


Does that sound reasonable?

-- 
Sabrina

