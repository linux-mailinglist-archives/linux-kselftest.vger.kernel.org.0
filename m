Return-Path: <linux-kselftest+bounces-24914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D348CA18DB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 09:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807EF188B45A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B81C3054;
	Wed, 22 Jan 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="gUcW/6bW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHMWA15I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A911537D4;
	Wed, 22 Jan 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535539; cv=none; b=Xla1A+C9dq2adgOT3ofOtcTzWXZ/3Yc9JFsgssYG8ZHsfzL1dOiqv5bBLk7N385m5DRwu75TDyXHDHAoAH3l6e2zKClqUBh1704qOkRquMKasyjaP+U0FfKgQdC3s6GRQkQgrjD8QTveQZ0cV6OBfalx+4ZPHRA4NVWo8e7AwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535539; c=relaxed/simple;
	bh=lMhDuo/P3P2M5DD5I0k4CknCdt7/GQ7XZGaTrfZYav0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sroz4qoO4u1meApYHkp3pc/4o+E48N6y+SZsEksSFklpnZ+dKkTS/x8cpG24SNcB8SRHTl/1ANv/+/NXNekUkeWtLNkMqEJ7Pk4ldmEYQLbLRns/yTIWNhPoHRXADa38fAWuJJKeg8IXhVYq0CRcK6eysupkLhSwLI4qBnqT7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=gUcW/6bW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHMWA15I; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0668F114018A;
	Wed, 22 Jan 2025 03:45:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 22 Jan 2025 03:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1737535533; x=1737621933; bh=2aUVEzk4TfyeXUpH0Xxzvd9ZvvkILAX9
	r1AUaXNwLOI=; b=gUcW/6bWg1+R4kyMfY7rG0++SVSsUObq0hegbvNOeI80JfTI
	PsbrAW5M0GNqElBOP0WScOSzRu5tMLmts1cPNxngFkn0HiKbqymnnZd5UZny0YOh
	BSxv0lwQjoXLMMhAiLqYz3KSQg8l+jwLZvDNGOcBnmQYC9fpnTqOmZ95/iEZu4Ga
	6svALQHuTRVqLufvIZ/h0RD3IDCMAVq5t6BgCd2uHrS5OE2gtQ0GAJFj52BIuVKv
	PNI3AuTDD421GEETsO8t+4yC0g+fE9rCJK4MVWC1YplTTEf1akXQ/ets7T4ce2U3
	UdSZdnPcA6A8k/KL/nMB7e6hH3jDMKq/BMovGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737535533; x=
	1737621933; bh=2aUVEzk4TfyeXUpH0Xxzvd9ZvvkILAX9r1AUaXNwLOI=; b=M
	HMWA15Il/gDN/JLBNG6zXo2UowLurwSQ+jWQ4DD4R+HTtUh3drGLdzWXZj2lELDl
	SNs9JkLHOvL04mBwMZDp8VjqlQgUtSCvwkdqgTX7FVG3rXJEEC5FIaGGuq+D3oQz
	NHJ6KJhaQYoM/DLcURAsNjmUpl8XrWUCUy6dxPnJ6oj10myAv3XCE9ZAHUnMUli7
	0zW4UgCtFcBnUZMDxiSGjYliw+SEpu6NYOKKeMqqMn4IVtZfibHfQn/Lqp12kG0m
	c7c5x/ZkW5JS32vOmGg3bwlBDKbdOu1+uv7CW/vUhmKk3J9pEHuQdL2DJLVKoq8S
	JamgcGGCO70121DDvgg8A==
X-ME-Sender: <xms:LbCQZ6xJNUfh57K28HffpLbJMs_EYoT0BcX_sRRgeLcO83YiwDHRpw>
    <xme:LbCQZ2QCZ4xzg18z6RnxWXj-fHN7debzKXkeQiuQgci6JNKJ1q1sUR5cgYdgKkFWQ
    pzQS0FiVTvCvhrUi3U>
X-ME-Received: <xmr:LbCQZ8U0kjeyQ-uWShog4ILO38vWU-Vwdqj9My_ndaTlkmlpkelzOrbvxKR6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvgeeitefffedvgfdutdelgeei
    hfegueehteevveegveejudelfeffieehledvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnth
    honhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnth
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:LbCQZwjiKMW5CY9swS-ghD-n-8iaNIWnkQUN9JLKQXNv4z9-1iFomg>
    <xmx:LbCQZ8AxHznf032Ju4e3x-XWomtDuPWdaik0aPmTVGFcISiUqj8PEg>
    <xmx:LbCQZxJL4TYi28bWvS7ucCjOiDHS1jGcNesRTyW4v-fgU_3wVMv-gA>
    <xmx:LbCQZzC0lArWgqxzKy_0yY56prgn0gBxh__PWQzZhne9SIqkRPsP3A>
    <xmx:LbCQZwzsdHPmtlt53HPNHmqJy5OhUzFIWhw6AvMfiCPr1KIncZRkPoV5>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 03:45:32 -0500 (EST)
Date: Wed, 22 Jan 2025 09:45:31 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z5CwK-xf2uC9cqb3@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
 <Z4pDpqN2hCc-7DGt@hog>
 <30c50783-096b-4114-aa55-c3edbeb38d49@openvpn.net>
 <10bb8eb7-fdcc-4ab6-8ddb-52491933659e@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10bb8eb7-fdcc-4ab6-8ddb-52491933659e@openvpn.net>

2025-01-22, 00:26:50 +0100, Antonio Quartulli wrote:
> On 20/01/2025 15:52, Antonio Quartulli wrote:
> > On 17/01/2025 12:48, Sabrina Dubroca wrote:
> > [...]
> > > -------- 8< --------
> > > 
> > > diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> > > index 72357bb5f30b..19aa4ee6d468 100644
> > > --- a/drivers/net/ovpn/netlink.c
> > > +++ b/drivers/net/ovpn/netlink.c
> > > @@ -733,6 +733,9 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb,
> > > struct genl_info *info)
> > >       netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
> > >       ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
> > > +    if (ret >= 0 && peer->sock)
> > > +        wait_for_completion(&peer->sock_detach);
> > > +
> > >       ovpn_peer_put(peer);
> > >       return ret;
> > > diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> > > index b032390047fe..6120521d0c32 100644
> > > --- a/drivers/net/ovpn/peer.c
> > > +++ b/drivers/net/ovpn/peer.c
> > > @@ -92,6 +92,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv
> > > *ovpn, u32 id)
> > >       ovpn_peer_stats_init(&peer->vpn_stats);
> > >       ovpn_peer_stats_init(&peer->link_stats);
> > >       INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
> > > +    init_completion(&peer->sock_detach);
> > >       ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
> > >       if (ret < 0) {
> > > diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> > > index 7a062cc5a5a4..8c54bf5709ef 100644
> > > --- a/drivers/net/ovpn/peer.h
> > > +++ b/drivers/net/ovpn/peer.h
> > > @@ -112,6 +112,7 @@ struct ovpn_peer {
> > >       struct rcu_head rcu;
> > >       struct work_struct remove_work;
> > >       struct work_struct keepalive_work;
> > > +    struct completion sock_detach;
> > >   };
> > >   /**
> > > diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> > > index a5c3bc834a35..7cefac42c3be 100644
> > > --- a/drivers/net/ovpn/socket.c
> > > +++ b/drivers/net/ovpn/socket.c
> > > @@ -31,6 +31,8 @@ static void ovpn_socket_release_kref(struct kref *kref)
> > >       sockfd_put(sock->sock);
> > >       kfree_rcu(sock, rcu);
> > > +
> > > +    complete(&sock->peer->sock_detach);
> 
> I am moving this line to ovpn_socket_put(), right after kref_put() so that
> every peer going through the socket release will get their complete()
> invoked.
> 
> If the peer happens to be the last one owning the socket, kref_put() will
> first do the detach and only then complete() gets called.
> 
> This requires ovpn_socket_release/put() to take the peer as argument, but
> that's ok.
> 
> This way we should achieve what we needed.

This seems like it would, thanks.

-- 
Sabrina

