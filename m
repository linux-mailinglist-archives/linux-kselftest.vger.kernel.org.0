Return-Path: <linux-kselftest+bounces-24125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC3A074B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B103D188A1BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B449F216E24;
	Thu,  9 Jan 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="cJfr+Ohc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OhPnAzi2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5882165EE;
	Thu,  9 Jan 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422144; cv=none; b=AM/9aU4SebCLdKgd2hhJxsLPMaUR91ruOVp7mkH6uSX7COHahYATdIhTocL7jx7ebww6b/Ac+LXZzmcKQXL0FWUa/HO04Fd9famZGQ7NlY9KajmatNyUrNV1eO1RNct5wZIrOiIDh4wB6I33oG1PWe51zgcqzDan6L6wvqX/0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422144; c=relaxed/simple;
	bh=rkXuufHqQoqIHgf9Yzlav8lBv20YKoIHoEhtyKSvS1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYgPRvxWO73+QP6fDbb5TkcnTgoxvvgKVvld+vRfLJ4ZYZWRVZRwxqa2ZC7pIT4ZI8+JYK5L2oSM78g/cfAS3meL/aaTcaDdvRuZ3YrPzitSZKI/TmUfPZRhBmUMZWCJ8NcCiN7TkN0M8rVWr5tksRi8/QbN5tAwG+SpHe1u8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cJfr+Ohc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OhPnAzi2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D89713808F8;
	Thu,  9 Jan 2025 06:29:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 09 Jan 2025 06:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1736422140; x=
	1736508540; bh=KVDojhJmRQ5azyKMB2mFDvDBplD3q2Ap9fB/qaZInQc=; b=c
	Jfr+Ohcrj/VnSVwJQWGukkTXrcKGNLIfOKQvkEkWyDf+nRZhzK0IFHYrveRmJ53Q
	uDCkqqLF+/0hTjdwRrsKMDv7JHm+fcRTcgMnDGsGkKxnIz0zDBSJOdnVZ1OKLJCf
	m+OxsFIJTNwOuwaSZbQJvH4/y0pgCy/DlMbjbnWpStqOHAvk2HA2HWMwB/YlFwHO
	SG26KaLWnKy0sNaxZXdzdfzMCn+1aFkn3NmX0u2+ERwFz016V2QNZCYNrkp9jW3B
	3g9BoTQrlaedLq/vrbjap7U2EN3ykERTtENxUS4IOCDF2ylUkSoUP8MlNxnxJGtC
	Qi5eVlNoPq+J+1qQEXOEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736422140; x=1736508540; bh=KVDojhJmRQ5azyKMB2mFDvDBplD3q2Ap9fB
	/qaZInQc=; b=OhPnAzi2g79rh+6tvGHPb2ne7s90cjOq/de8V8A/ghRj3uzQNxd
	IaKbnXw11p/rCydBsRZYN9zs6GzPJJdeEwF0AHTx9zVmAhDD0MJhJrm4OfzncYOd
	+jQDALuJ3O5X29MUMgCzbKKpAmQjQDUn7iDq0C/VUTHAWzwnSA2izkolP2dNsGzA
	fbVg6Yzy3C7H3IRtr7u8vlyhMI+DJorGTiiDE5uPngE2RqtH4J1FHNOFzB3/g9+Z
	DO8HoUoBI45gzgUdsJY8e2STKkXiK2TJL23ZAvL912JtgeSoppauhECcTnrBSihD
	XA2Ie97sKEkf/MF2oHfY++flrBmBg4LtzPA==
X-ME-Sender: <xms:-rJ_Z1vLhUyS1mXqBXgk8qOVRDep716TIo-DLC8WMPWsZ5eAlzpKtg>
    <xme:-rJ_Z-dzhXNe705Hy53F_WZg0Z3x5JTQn2kQQudN1xUsGgChucOgGqzKxptZRvzJ_
    5zVJf1ao7ultj3pjf8>
X-ME-Received: <xmr:-rJ_Z4w7SDjY5t3xhE4ZkwhLNsNp-32WS2-lTRVgrZkkj7Ni5POW-nsY0k8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtth
    hopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:-rJ_Z8OONG7I1vcptxNbXnVFKb2sSlGnhYeo11VYxOyR-urs4cKVnw>
    <xmx:-rJ_Z1-_qxaxTtV9Byr7lNrNpZtmIByP9BpKCI4H9mLm-I3zfT2XYA>
    <xmx:-rJ_Z8VxikNOp3P2q_HCcybnbYQ6dmCszckLJcboGtnvb5jD70W_og>
    <xmx:-rJ_Z2cAY04VV1XKk6CMDNiPXZmS9RMeGDq-NqxmIP4VQmB_ySdFhg>
    <xmx:_LJ_Z5V0K5_CwYgQiUB3zIB9CCcxUQ8lnSbphRnP-YSumAGzp3QmkRCE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 06:28:58 -0500 (EST)
Date: Thu, 9 Jan 2025 12:28:56 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v16 07/26] ovpn: introduce the ovpn_socket object
Message-ID: <Z3-y-AwfTyf924tP@hog>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
 <20241219-b4-ovpn-v16-7-3e3001153683@openvpn.net>
 <Z3gXs65jjYc-g2iw@hog>
 <9634a1e1-6cc4-45ef-89d8-30d0e50ba319@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9634a1e1-6cc4-45ef-89d8-30d0e50ba319@openvpn.net>

2025-01-06, 00:27:28 +0100, Antonio Quartulli wrote:
> Hi Sabrina,
> 
> On 03/01/2025 18:00, Sabrina Dubroca wrote:
> > Hello Antonio,
> > 
> > 2024-12-19, 02:42:01 +0100, Antonio Quartulli wrote:
> > > +static void ovpn_socket_release_kref(struct kref *kref)
> > > +	__releases(sock->sock->sk)
> > > +{
> > > +	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
> > > +						refcount);
> > > +
> > 
> > [extend with bits of patch 9]
> > > 	/* UDP sockets are detached in this kref callback because
> > > 	 * we now know for sure that all concurrent users have
> > > 	 * finally gone (refcounter dropped to 0).
> > > 	 *
> > > 	 * Moreover, detachment is performed under lock to prevent
> > > 	 * a concurrent ovpn_socket_new() call with the same socket
> > > 	 * to find the socket still attached but with refcounter 0.
> > 
> > I'm not convinced this really works, because ovpn_socket_new() doesn't
> > use the same lock. lock_sock and bh_lock_sock both "lock the socket"
> > in some sense, but they're not mutually exclusive (we talked about
> > that around the TCP patch).
> 
> You're right - but what prevents us from always using bh_lock_sock?

TCP detach can sleep, and UDP attach as well (setup_udp_tunnel_sock ->
udp_tunnel_encap_enable -> udp_encap_enable -> static_branch_inc ->
static_key_slow_inc -> cpus_read_lock). UDP detach would also not work
under bh_lock_sock if it really disabled encap on the socket (we end
up in udp_tunnel_encap_enable but that doesn't do anything since encap
is already turned on -- but a "real" detach should disable the encap
and do static_branch_dec).

So attach/detach need to be under lock_sock, not bh_lock_sock.

> > Are you fundamentally opposed to making attach permanent? ie, once
> > a UDP or TCP socket is assigned to an ovpn instance, it can't be
> > detached and reused. I think it would be safer, simpler, and likely
> > sufficient (I don't know openvpn much, but I don't see a use case for
> > moving a socket from one ovpn instance to another, or using it without
> > encap).
> 
> I hardly believe a socket will ever be moved to a different instance.
> There is no use case (and no userspace support) for that at the moment.
> 
> > 
> > Rough idea:
> >   - ovpn_socket_new is pretty much unchanged (locking still needed to
> >     protect against another simultaneous attach attempt, EALREADY case
> >     becomes a bit easier)
> >   - ovpn_peer_remove doesn't do anything socket-related
> >   - use ->encap_destroy/ovpn_tcp_close() to clean up sk_user_data
> >   - no more refcounting on ovpn_socket (since the encap can't be
> >     removed, the lifetime to ovpn_socket is tied to its socket)
> > 
> > What do you think?
> 
> hmm how would that work with UDP?
> On a server all clients may disconnect, but the UDP socket is expected to
> still survive and be re-used for new clients (userspace will keep it alive
> and keep listening for new clients).
> 
> Or you're saying that the socket will remain "attached" (i.e. sk_user_data
> set to the ovpn_priv*) even when no more clients are connected?

Yes. Once attached, it stays attached.

> > 
> > I'm trying to poke holes into this idea now. close() vs attach worries
> > me a bit.
> 
> Can that truly happen?

Actually it can't, so this isn't a concern.

> If a socket is going through close(), there should be some way to mark it as
> "non-attachable".
> 
> Actually, do we even need to clean up sk_user_data? The socket is being
> destroyed - why clean that up at all?

If we allocated some memory to store per-socket info, we need to free
it when we detach or close. There's no generic mechanism to free
sk_user_data since the core can't know where it came from, maybe
kfree() isn't appropriate.

-- 
Sabrina

