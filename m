Return-Path: <linux-kselftest+bounces-23879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3FA00C7F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 18:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913B618847E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA61FBEA6;
	Fri,  3 Jan 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TaJDmglc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aP3Lz1Uo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DAD1FBCAA;
	Fri,  3 Jan 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923643; cv=none; b=Efkhp1jcldYcogEmAv7Fm6sltcJ+GV1uhRnYsdtJLqjsyPHByc35g3k+BH8HYKRL4C58aMGG+S7h+5/tsnpZ8gUMJYW+B+3s/duf+2cUfqaG9a7U+Vf9L5kvOyugTxSxGsQ5/SBeNUvPOX+wjOACEYHd3jGLXZnx/8DxoM/2ESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923643; c=relaxed/simple;
	bh=ohJQE+kFTnvf341Hc2fu8YtRxKrOXKg+uSuvKebbJAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVJRZYFKdZMhotbtzJdgaf5A8Ub4gzN7jAYCsbfhshbYKcxFpJjnAnG1MfKnkh9v+H8W1tPp+yN1749rC0SY3+lhrnV1dHM33913uf9XMvJdoAgHQ21r6UaRSlO0+OEDA+9ruNxfhy5CRNpY75yJkbVi105Jyb0jvSg2kwzp2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TaJDmglc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aP3Lz1Uo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2323B1140264;
	Fri,  3 Jan 2025 12:00:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 12:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1735923638; x=
	1736010038; bh=sGvx2u03+QbmNTX8zDpPuiAikIJPFGN89aJNoG9Sgi0=; b=T
	aJDmglcOFKAyIHLycHlStNg42Kwaya8EC6/xAm95190B0y7PCVxXga7eztFyKjpm
	cYqjyvaHgwLCoeTi22fuebG2fTG1I57DIaFsRk4VRtfwxSgVgAPXnk8BInAHTRDO
	dWUdPXn3Od6Fo9aiL8wCgt0JmwOyeDnK9/uSoFYdyxyin7QWyI/66W599R4MlCJH
	Ic4DtodRV76V/ApTdaUVc8Aq3VpJJ+52+rV1mGl6VVFoUbA5Pc7yRbPo3KFj2e1A
	7xQ4P/fHVvLonkct0fOESPTJ/mz84JrfUcn5DzY9GReP2+K7SRuVV9+TrMeYl+Uw
	jttvfDJC6flnt+zhb0hzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735923638; x=1736010038; bh=sGvx2u03+QbmNTX8zDpPuiAikIJPFGN89aJ
	NoG9Sgi0=; b=aP3Lz1UorIy71IZbEDwbvufwzAsjZa0AQjlKtEU1GYfHfk+DQJc
	d7uG+WTd9/H3BJ2hoBx4pJsqI7FJvg792/LxuxRtcEG/FDHlBLcuHoH8uBJieefC
	R+Q3e+dDGUMFYz84Hxv/S2u04VADMTT0iUXycAGB76b+OZokx82kTB4ytZ1Y4tbo
	//gcyof188L2JEwPtQCtxTzzafbDwt+RBneeq6JRUPsTMjM7rYHhZPEppFE/pwua
	LOZtmTa3VxQb+oI3Odg95dCQRnEKofjdtAyI/iIdX6suNLYoIz09ZNpZRfpaXP7w
	LX5tlqo+IUA37NYSNB/Vr/OnB+BVy5po4qQ==
X-ME-Sender: <xms:tRd4Z-XW9jUC3pZZ4T9rZSubyDArTGRh6TZPOMO1Smqhv29mBmRIfg>
    <xme:tRd4Z6lZPbhAr1kEIyQwdgKt5FZEA4YfIr_2xQ8kWsGcZr3czCe-rqZ_EjgGsfc9W
    dNE1A4bGfWXOO3fgv4>
X-ME-Received: <xmr:tRd4ZyZb2b0NxKniEQqhCYkdvFmFjXBngcdq_kXDvkhshFvWfkt-Igp5F_k3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepveejheeugfeutddufffggeejfeelkedu
    heegvdejhffgudehtdevuedvjefffeejnecuffhomhgrihhnpehskhgptggsrdhskhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhu
    vggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghp
    thhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtph
    htthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhihrgiirghnohhvrdhsrd
    grsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthh
X-ME-Proxy: <xmx:tRd4Z1VfW10NiiZOjTuSe4NbZhy41r4kLxwiofgxSVHatdQfPH63Qg>
    <xmx:tRd4Z4m5LazTX9xuQQJOiolLhPli1FfiAa5hllguoHUPhGhZ3-FAuQ>
    <xmx:tRd4Z6exW70xT1r_qkkXjl2_ulYQWeBrGBul5M4UNkUWwyq0H7w1OA>
    <xmx:tRd4Z6E_OAyFjdiXf3tCvqUKKAs_gatUYeldVg3xKMLaDnvKyBYNkg>
    <xmx:thd4Z9_tlBulJ6_KVlGtA0EXeask5QtLe7_wqAFNSp2x_hVT_-8ldC6o>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 12:00:36 -0500 (EST)
Date: Fri, 3 Jan 2025 18:00:35 +0100
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
Message-ID: <Z3gXs65jjYc-g2iw@hog>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
 <20241219-b4-ovpn-v16-7-3e3001153683@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241219-b4-ovpn-v16-7-3e3001153683@openvpn.net>

Hello Antonio,

2024-12-19, 02:42:01 +0100, Antonio Quartulli wrote:
> +static void ovpn_socket_release_kref(struct kref *kref)
> +	__releases(sock->sock->sk)
> +{
> +	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
> +						refcount);
> +

[extend with bits of patch 9]
>	/* UDP sockets are detached in this kref callback because
>	 * we now know for sure that all concurrent users have
>	 * finally gone (refcounter dropped to 0).
>	 *
>	 * Moreover, detachment is performed under lock to prevent
>	 * a concurrent ovpn_socket_new() call with the same socket
>	 * to find the socket still attached but with refcounter 0.

I'm not convinced this really works, because ovpn_socket_new() doesn't
use the same lock. lock_sock and bh_lock_sock both "lock the socket"
in some sense, but they're not mutually exclusive (we talked about
that around the TCP patch).

Are you fundamentally opposed to making attach permanent? ie, once
a UDP or TCP socket is assigned to an ovpn instance, it can't be
detached and reused. I think it would be safer, simpler, and likely
sufficient (I don't know openvpn much, but I don't see a use case for
moving a socket from one ovpn instance to another, or using it without
encap).

Rough idea:
 - ovpn_socket_new is pretty much unchanged (locking still needed to
   protect against another simultaneous attach attempt, EALREADY case
   becomes a bit easier)
 - ovpn_peer_remove doesn't do anything socket-related
 - use ->encap_destroy/ovpn_tcp_close() to clean up sk_user_data
 - no more refcounting on ovpn_socket (since the encap can't be
   removed, the lifetime to ovpn_socket is tied to its socket)

What do you think?

I'm trying to poke holes into this idea now. close() vs attach worries
me a bit.


>	 */
>	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
>		ovpn_udp_socket_detach(sock->sock);


> +	bh_unlock_sock(sock->sock->sk);
> +	sockfd_put(sock->sock);
> +	kfree_rcu(sock, rcu);
> +}

[...]
> +struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +	int ret;
> +
> +	lock_sock(sock->sk);
> +
> +	ret = ovpn_socket_attach(sock, peer);
> +	if (ret < 0 && ret != -EALREADY)
> +		goto err_release;
> +
> +	/* if this socket is already owned by this interface, just increase the
> +	 * refcounter and use it as expected.
> +	 *
> +	 * Since UDP sockets can be used to talk to multiple remote endpoints,
> +	 * openvpn normally instantiates only one socket and shares it among all
> +	 * its peers. For this reason, when we find out that a socket is already
> +	 * used for some other peer in *this* instance, we can happily increase
> +	 * its refcounter and use it normally.
> +	 */
> +	if (ret == -EALREADY) {
> +		/* caller is expected to increase the sock refcounter before
> +		 * passing it to this function. For this reason we drop it if
> +		 * not needed, like when this socket is already owned.
> +		 */
> +		ovpn_sock = ovpn_socket_get(sock);
> +		release_sock(sock->sk);
> +		sockfd_put(sock);
> +		return ovpn_sock;
> +	}
> +
> +	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
> +	if (!ovpn_sock) {
> +		ret = -ENOMEM;
> +		goto err_detach;
> +	}
> +
> +	ovpn_sock->ovpn = peer->ovpn;
> +	ovpn_sock->sock = sock;
> +	kref_init(&ovpn_sock->refcount);
> +
> +	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
> +	release_sock(sock->sk);
> +
> +	return ovpn_sock;
> +err_detach:
> +	if (sock->sk->sk_protocol == IPPROTO_UDP)
> +		ovpn_udp_socket_detach(sock);

This would leave the TCP socket half-attached, and if userspace tries
to attach the same socket again (I don't think the ovpn module would
prevent that since sk_user_data is still unset), both ->sk_data_ready
and tcp.sk_cb.sk_data_ready will be set to ovpn's (same for
sk_write_space with ovpn_tcp_write_space which will recurse into
itself when called).

I think it'd be easier to do the alloc first, then attach. Handling a
failure to attach would be a simple kfree, while handling a failure to
alloc is a detach (or part of a detach) which is not as easy.



> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
> +{
> +	struct ovpn_socket *old_data;
> +	int ret = 0;
> +
> +	/* make sure no pre-existing encapsulation handler exists */
> +	rcu_read_lock();
> +	old_data = rcu_dereference_sk_user_data(sock->sk);
> +	if (!old_data) {
> +		/* socket is currently unused - we can take it */
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	/* socket is in use. We need to understand if it's owned by this ovpn
> +	 * instance or by something else.
> +	 * In the former case, we can increase the refcounter and happily
> +	 * use it, because the same UDP socket is expected to be shared among
> +	 * different peers.
> +	 *
> +	 * Unlikely TCP, a single UDP socket can be used to talk to many remote

nit: s/Unlikely/Unlike/

> +	 * hosts and therefore openvpn instantiates one only for all its peers
> +	 */

-- 
Sabrina

