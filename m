Return-Path: <linux-kselftest+bounces-21785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C1C9C4211
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DCB2636E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630F19E98D;
	Mon, 11 Nov 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lds1yNdb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSGDwWyT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD380034;
	Mon, 11 Nov 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339724; cv=none; b=J5Mgm5Ab0lNb2APRYVd0SaSHLnp0lSFFFIqN0HMUigKrNZ5CZOAhOAR0CXY0qlx055ZlN13vt/ZBIaBaIzywCYSAJsfF4o8XEfW9riUb0N59qOGJhOW9joh/x2+Pw9a5GTL74d6qxm6JOyJlk8PeVuPZXLb6QjgKE/j80Ss4q9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339724; c=relaxed/simple;
	bh=3OJmGoihESTrOrgiy0coovfJtZ+7veVRHNykmklgQyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP48dl5e6zOVMOAB8MmbbDiVy2NybF67VUZ7bXSRkWrwa8xr/LtlM+ElOVM20AVrywjZWaCRI5JqA4v/YLDX936Lg/1msUVfdynraGaOG51vuyuxZtwwQEB+999oa/sBeodngER7QotNmC6/IvhbwY91dRieNSd3suKD8OTfqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lds1yNdb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSGDwWyT; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 2B1EA200556;
	Mon, 11 Nov 2024 10:42:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 10:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731339720; x=
	1731343320; bh=XVDWgeaEJmiQKgUHorSqJOs8sTvGLw1bTj4SGmPTfiw=; b=l
	ds1yNdbxk2u1A3z22JSKddyOr/l7ZNNw/1dNVNi6dMQ8o3zJxwxW01sSQsSAx16D
	+znk1SOKwQfPbklIq0R77PNZTJcFlvjXGSoVjrxed2ljhPDNNTPv7WhAhGGS8qyk
	cqNZ8o9UX6bw27e3THQDAddTW9RVgULQYIk7olLqMg+HAU7zsxCzgtqScE1nolWQ
	+LY7kI7aRh4GKOIamesrwFycxVyJkOU+em2PJH/Q0HsSffHZfyXoUjv0gq3NN8o5
	yAjg1fx/zrV0xho6AmjHS+w4UQdLbPpcMVDBjj8YJaSMoCqZuNrxhoSTQkExV1hN
	W2CyC7BZgtCEMs4Fzi9LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339720; x=1731343320; bh=XVDWgeaEJmiQKgUHorSqJOs8sTvGLw1bTj4
	SGmPTfiw=; b=fSGDwWyT95KbTL2qeLpMyco24vTKdwz/R1JSewfSJugXWIHoCOI
	KxUYOUKVikEF/RV/Can2sRJo7GiRC9cjToscImzTynDFks9U258nnu8IE5z1shxD
	AG1zqwM6TA1qsN0FsbLbzNORMtg80EV0gCFh+riznjy3rdpKxaXxmtGGOzdjfvbZ
	EOGIpTXBV+bwcCXCmDXlI83S1yR2AbeNj/uu05OgYjxIkHRP5VdaAkD9+93u3ejO
	s8ImBCu6wIQlJq+SRpMOvq1e5EMLqNyGaKNk0jWXt3nzL27V3kt8TOXhiIu/uonx
	mftOOts/AzRp2bpKAoEMH6t7LmG4U0uVKxQ==
X-ME-Sender: <xms:xyUyZ468rxPCf6QGv_9uopXUrWB-Z3iPsZXg40NpB_Di1i9VEbwDPg>
    <xme:xyUyZ574GIQ4HqVgWQGYlGZmJXohyMFqu9imt2sqNtxjabSUHZsHLEK7TntjuWcc6
    wmS2Efc49Rohi-rgbE>
X-ME-Received: <xmr:xyUyZ3cnCNtzqcreUDjzG9vk9TI8HmW7m5VYT810Z7_23GADa5te6p_SQKlt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejlecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:xyUyZ9IjhW4TH-ibtzY5-2xc786f1Shg9-tSavOO7oB3CYEfGOeMcQ>
    <xmx:xyUyZ8KwugoH5D4rInHKqHD-f7Bmv0mfxqirGFZKcvn_PeunGnn6Yw>
    <xmx:xyUyZ-wqCvyB0VMgiWvQzoxp2va8oKnXrfkRDNV962N7ut9K-hDgRQ>
    <xmx:xyUyZwLgER8hmIQKf2yyU8aWCMVdKd7rm0eSS0UN4FPeWV_8im3uBw>
    <xmx:xyUyZ7_b-2ahKsCrCtMRbPa1n2RwRiXtz_xZCKPwBvE5jHHo8C78d0i2>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:41:59 -0500 (EST)
Date: Mon, 11 Nov 2024 16:41:57 +0100
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
Message-ID: <ZzIlxRbic7qLVD4F@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>

2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
> +			       struct nlattr **attrs)
> +{
> +	struct sockaddr_storage ss = {};
> +	u32 sockfd, interv, timeout;
> +	struct socket *sock = NULL;
> +	u8 *local_ip = NULL;
> +	bool rehash = false;
> +	int ret;
> +
> +	if (attrs[OVPN_A_PEER_SOCKET]) {
> +		/* lookup the fd in the kernel table and extract the socket
> +		 * object
> +		 */
> +		sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
> +		/* sockfd_lookup() increases sock's refcounter */
> +		sock = sockfd_lookup(sockfd, &ret);
> +		if (!sock) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "cannot lookup peer socket (fd=%u): %d",
> +					       sockfd, ret);
> +			return -ENOTSOCK;
> +		}
> +
> +		/* Only when using UDP as transport protocol the remote endpoint
> +		 * can be configured so that ovpn knows where to send packets
> +		 * to.
> +		 *
> +		 * In case of TCP, the socket is connected to the peer and ovpn
> +		 * will just send bytes over it, without the need to specify a
> +		 * destination.
> +		 */
> +		if (sock->sk->sk_protocol != IPPROTO_UDP &&
> +		    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
> +		     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "unexpected remote IP address for non UDP socket");
> +			sockfd_put(sock);
> +			return -EINVAL;
> +		}
> +
> +		if (peer->sock)
> +			ovpn_socket_put(peer->sock);
> +
> +		peer->sock = ovpn_socket_new(sock, peer);

I don't see anything preventing concurrent updates of peer->sock. I
think peer->lock should be taken from the start of
ovpn_nl_peer_modify. Concurrent changes to peer->vpn_addrs and
peer->keepalive_* are also not prevented with the current code.


> +		if (IS_ERR(peer->sock)) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "cannot encapsulate socket: %ld",
> +					       PTR_ERR(peer->sock));
> +			sockfd_put(sock);
> +			peer->sock = NULL;
> +			return -ENOTSOCK;
> +		}
> +	}
> +
> +	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss) != AF_UNSPEC) {
> +		/* we carry the local IP in a generic container.
> +		 * ovpn_peer_reset_sockaddr() will properly interpret it
> +		 * based on ss.ss_family
> +		 */
> +		local_ip = ovpn_nl_attr_local_ip(attrs);
> +
> +		spin_lock_bh(&peer->lock);
> +		/* set peer sockaddr */
> +		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
> +		if (ret < 0) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "cannot set peer sockaddr: %d",
> +					       ret);
> +			spin_unlock_bh(&peer->lock);
> +			return ret;
> +		}
> +		spin_unlock_bh(&peer->lock);
> +	}
> +
> +	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
> +		rehash = true;
> +		peer->vpn_addrs.ipv4.s_addr =
> +			nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
> +	}
> +
> +	if (attrs[OVPN_A_PEER_VPN_IPV6]) {
> +		rehash = true;
> +		peer->vpn_addrs.ipv6 =
> +			nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
> +	}
> +
> +	/* when setting the keepalive, both parameters have to be configured */
> +	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
> +	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
> +		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
> +		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
> +		ovpn_peer_keepalive_set(peer, interv, timeout);
> +	}
> +
> +	netdev_dbg(peer->ovpn->dev,
> +		   "%s: peer id=%u endpoint=%pIScp/%s VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
> +		   __func__, peer->id, &ss,
> +		   peer->sock->sock->sk->sk_prot_creator->name,
> +		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
> +
> +	return rehash ? 1 : 0;
> +}
> +

[...]
> +void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
> +	__must_hold(&peer->ovpn->peers->lock)

Changes to peer->vpn_addrs are not protected by peers->lock, so those
could be getting updated while we're rehashing (and taking peer->lock
in ovpn_nl_peer_modify as I'm suggesting above also wouldn't prevent
that).

> +{
> +	struct hlist_nulls_head *nhead;
> +
> +	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
> +		/* remove potential old hashing */
> +		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
> +
> +		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
> +					   &peer->vpn_addrs.ipv4,
> +					   sizeof(peer->vpn_addrs.ipv4));
> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
> +	}
> +
> +	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
> +		/* remove potential old hashing */
> +		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
> +
> +		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
> +					   &peer->vpn_addrs.ipv6,
> +					   sizeof(peer->vpn_addrs.ipv6));
> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
> +	}
> +}

-- 
Sabrina

