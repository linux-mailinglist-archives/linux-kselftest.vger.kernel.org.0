Return-Path: <linux-kselftest+bounces-25529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D103A25096
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 00:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CC018849EB
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7611FECC0;
	Sun,  2 Feb 2025 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="OdMFmDt1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="siC0HCfQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562641FDA90;
	Sun,  2 Feb 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738537643; cv=none; b=B0LHbCzIasRDeAbzpPJg9qAp21pJUWHZ2gzywmWMxrykuZbgkGQF+T2aMW66Uigj7iwZEJgJCiyuoYoUbPswtlez59q68p6HSIZDdvhy1ePIafs7p1eu8Ee4OZuIoF+WoFf3tJGRyydZblBJkKiJ2uFsX1w7Y1cgiKuacR1tjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738537643; c=relaxed/simple;
	bh=9gVeuqoUPF160LlPKssl/ECX3xfu3p7wCdpPGVaQhoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkogRqgjjQZPebWx/REr/oT62ri91dEPEMAgRHdo20PX9SKg9qH4Cu7jEWdW2Ftja6YxXO1yhcuvE5cEF8tsFeSsJng+lvSfbvlGfZuCXuRc+ObllyzSGBfhg17oEM098SVLafBNVL9wsRNvh7DNJO+mrlY2x1ASx1Bu9NjD1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=OdMFmDt1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=siC0HCfQ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 08B8211400D8;
	Sun,  2 Feb 2025 18:07:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 02 Feb 2025 18:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738537638; x=
	1738624038; bh=b8vxyUo2+X0+IZqkuu9170OSmww4EAw9XZWfoUl1MjU=; b=O
	dMFmDt1EsiLVabvfBUvSem0oNoF60VU+sFI8csXSAkkSzNwd1EvUDuY/ybp6MKqB
	9w6rYsn9Ehj1l2ak7i9JD+Te87tQ7F8PhW3Q/ilpMZh+ZMXpT+1D9n6U2JLZpB+Y
	Pbg1Xf0JMrW+H6TcfbgXLGRNQxtm1iYlEtCRm+1bv3JR39ZsJOUpL0zND90BiTHj
	RLDqmi1VtPUbs3z1YuLDehPmicwyh6Uj4MVunsuzAzM4A2yLRUElpEeOvQwWp7NB
	q/be8bqelTVHenQXUEM0VCvWrxri72vA+UMxpiWahKlWVxPdVllkKoZwzHJBlrPz
	jDQifd5aK9NxWlkNFDppg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738537638; x=1738624038; bh=b8vxyUo2+X0+IZqkuu9170OSmww4EAw9XZW
	foUl1MjU=; b=siC0HCfQkklPmSdK8cQG4T27dbd2P99wHAEkuP9MQ92s3afdFZ6
	C5k1jE15LdMHrZLq0TnYL8ejsFLtMMYxWFyuN6lKYGWE/xNCLy8QYO+XHh6KQEbZ
	kl0qtTls8+8NoY0ztozJYOLPcYYm5p+SyE1QcHxv8CXfyYoXw7zE7IQd+yOoVPgU
	0k3GuZ2M8eJ2qcyenLu0Y9wFyqrQEUuRTpk0As2JjnxuyOFpf43raxoUCCoziA4t
	ph6JmoowkFrCOWbJjNfjFZ3BOeHjls3oqNX9b7HT6A9NfL+kvCwnXO/ELNojveM9
	hubH3z3U5an9t8pk3FkabT1zDD5k9K6WlTA==
X-ME-Sender: <xms:pvqfZ0r7VEYE265W1BIhGT7TftXP_v4u2xjQDRrWi9cMkUwHY1AR0g>
    <xme:pvqfZ6qWIWi3NJXIsqLRcVnpneVWKYxoxN8_5HWuDrvwm_3ZkrMa3urJyMFbupn6J
    8U31eYCqhlkZdxe8Js>
X-ME-Received: <xmr:pvqfZ5M6wssxgqmNNisuvLsB-9qZ_b2HUrKV0ccAUI2aW4bz6AfRLYmDV9Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:pvqfZ75uugAveFN6dlaxF2MgcLMVtKza16yvGafINQIYbwSYRd3hoA>
    <xmx:pvqfZz6fS-YnknOTvgkvLpCTIRFsHGPKObd1TAeT_W4DVZk7BZacrA>
    <xmx:pvqfZ7gdUxGXKGw8dZUzRRnRCs5bLdrrAsIMc5Du5qnNOd8s_n_soA>
    <xmx:pvqfZ96IVHVUr-sM1SJpir-EzZ44Fj7kxF7d7hQx4JeK8nAgvvkQWQ>
    <xmx:pvqfZ6J_04S0EBLV4dJMXRe7OGksLyB7z9rOWJydTj0xyTPZbvtO4RJG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 18:07:17 -0500 (EST)
Date: Mon, 3 Feb 2025 00:07:16 +0100
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
Message-ID: <Z5_6pC-zsVzukJs3@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
> +static int ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
> +					struct sockaddr_storage *ss)
> +{
> +	struct sockaddr_in6 *sin6;
> +	struct sockaddr_in *sin;
> +	struct in6_addr *in6;
> +	__be16 port = 0;
> +	__be32 *in;
> +	int af;
> +
> +	ss->ss_family = AF_UNSPEC;
> +
> +	if (attrs[OVPN_A_PEER_REMOTE_PORT])
> +		port = nla_get_be16(attrs[OVPN_A_PEER_REMOTE_PORT]);
> +
> +	if (attrs[OVPN_A_PEER_REMOTE_IPV4]) {
> +		af = AF_INET;
> +		ss->ss_family = AF_INET;
> +		in = nla_data(attrs[OVPN_A_PEER_REMOTE_IPV4]);
> +	} else if (attrs[OVPN_A_PEER_REMOTE_IPV6]) {
> +		af = AF_INET6;
> +		ss->ss_family = AF_INET6;
> +		in6 = nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]);
> +	} else {
> +		return AF_UNSPEC;
> +	}
> +
> +	switch (ss->ss_family) {
> +	case AF_INET6:
> +		/* If this is a regular IPv6 just break and move on,
> +		 * otherwise switch to AF_INET and extract the IPv4 accordingly
> +		 */
> +		if (!ipv6_addr_v4mapped(in6)) {
> +			sin6 = (struct sockaddr_in6 *)ss;
> +			sin6->sin6_port = port;
> +			memcpy(&sin6->sin6_addr, in6, sizeof(*in6));
> +			break;
> +		}
> +
> +		/* v4-mapped-v6 address */
> +		ss->ss_family = AF_INET;
> +		in = &in6->s6_addr32[3];
> +		fallthrough;
> +	case AF_INET:
> +		sin = (struct sockaddr_in *)ss;
> +		sin->sin_port = port;
> +		sin->sin_addr.s_addr = *in;
> +		break;
> +	}
> +
> +	/* don't return ss->ss_family as it may have changed in case of
> +	 * v4-mapped-v6 address
> +	 */

nit: I'm not sure that matters since the only thing the caller checks
is ret != AF_UNSPEC, and at this point, while ss_family could have
been changed, it would have changed from AF_INET6 to AF_INET, so it's
!= AF_UNSPEC.

> +	return af;
> +}

[...]
> +static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
> +				 struct genl_info *info,
> +				 struct nlattr **attrs)
> +{
[...]
> +
> +	/* VPN IPs are needed only in MP mode for selecting the right peer */
> +	if (ovpn->mode == OVPN_MODE_P2P && (attrs[OVPN_A_PEER_VPN_IPV4] ||
> +					    attrs[OVPN_A_PEER_VPN_IPV6])) {

And in MP mode, at least one VPN_IP* is required?


[...]
>  int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>  {
[...]
> +	/* Only when using UDP as transport protocol the remote endpoint
> +	 * can be configured so that ovpn knows where to send packets to.
> +	 *
> +	 * In case of TCP, the socket is connected to the peer and ovpn
> +	 * will just send bytes over it, without the need to specify a
> +	 * destination.
> +	 */
> +	if (sock->sk->sk_protocol != IPPROTO_UDP &&
> +	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
> +	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {

Is a peer on a UDP socket without any remote (neither
OVPN_A_PEER_REMOTE_IPV4 nor OVPN_A_PEER_REMOTE_IPV6) valid? We just
wait until we get data from it to update the endpoint?

Or should there be a check to make sure that one was provided?

> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "unexpected remote IP address for non UDP socket");
> +		sockfd_put(sock);
> +		return -EINVAL;
> +	}
> +
> +	ovpn_sock = ovpn_socket_new(sock, peer);
> +	if (IS_ERR(ovpn_sock)) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot encapsulate socket: %ld",
> +				       PTR_ERR(ovpn_sock));
> +		sockfd_put(sock);
> +		return -ENOTSOCK;

Maybe s/-ENOTSOCK/PTR_ERR(ovpn_sock)/ ?
Overwriting ovpn_socket_new's -EBUSY etc with -ENOTSOCK is a bit
misleading to the caller.

> +	}
> +
> +	peer->sock = ovpn_sock;
> +
> +	ret = ovpn_nl_peer_modify(peer, info, attrs);
> +	if (ret < 0)
> +		goto peer_release;
> +
> +	ret = ovpn_peer_add(ovpn, peer);
> +	if (ret < 0) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot add new peer (id=%u) to hashtable: %d\n",
> +				       peer->id, ret);
> +		goto peer_release;
> +	}
> +
> +	return 0;
> +
> +peer_release:

I think you need to add:

	ovpn_socket_release(peer);

If ovpn_socket_new succeeded, ovpn_peer_release only takes care of the
peer but not its socket.

> +	/* release right away because peer is not used in any context */
> +	ovpn_peer_release(peer);
> +
> +	return ret;
>  }
>  
>  int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
[...]
> +	if (attrs[OVPN_A_PEER_SOCKET]) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "socket cannot be modified");
> +		return -EINVAL;
> +	}
> +
> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
> +	if (!peer) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot find peer with id %u", peer_id);
> +		return -ENOENT;
> +	}

The check for non-UDP socket with a remote address configured should
be replicated here, no?

-- 
Sabrina

