Return-Path: <linux-kselftest+bounces-21851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C99C562F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 12:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB8328D938
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A86227B82;
	Tue, 12 Nov 2024 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="jxjmmB5Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OrZrs7Ii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C4226B88;
	Tue, 12 Nov 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408986; cv=none; b=uviVlLrjjb8Mv4KXSZ590NNhlYfO8WIsTi8k+9+4pglpdEpu/EgZZK2lQOdda4/JiOrG8TUuoBf8JzXIRKo/pMNlYn61t+Y49iTvLLEqIGvNkEgG+RnHdzBBKe78bDNZX1MbE1Y62VUNKVo8gpCuaQi37IhyfcrozjSdm3PleBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408986; c=relaxed/simple;
	bh=cw+MfT95YAhX/0hs0XJcoCzuCnfI/HJJ/hHCJeYPspY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biyGJRSgClPwyHfJDaa9+nrY3IOWUq1uiauTQ+pO03q4OwuadamRz6NWgYgUvA8BXr7C5yQMLszWp5NLA3ZQyg4WCsO3FeTDg3QwrNeSHOp35a05I9j0rIoyyOKpv3HssFw1E8m4XCni45qvqyIHNcEID/JYe4GznsTTuLqPlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=jxjmmB5Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OrZrs7Ii; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 61318200A6E;
	Tue, 12 Nov 2024 05:56:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 12 Nov 2024 05:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731408982; x=
	1731412582; bh=ZwYYSGG6zgmMQwyFMLiLhe2O5PD1kFprIqbGRmWdxuo=; b=j
	xjmmB5ZUM7qDMfgY1FEN8CLjjH4rn0yxmf6F1ReTlHL/T8sqC/+GNphKTbV2miiS
	HUYcgNpk1sX6GYvqRR0srsuxgLX97IbWJkfjgqLp/BIu0cL55ONWZduTObLwWZFr
	GQ9VPf1q49sL+DxIkQC4pwqsKqoRTpM7LK49tZfXInyNpvlF5BZLbl7fWexG+ru1
	cRm4rmSxuU6JbEdh5B+noI6JqZZv4RAdGIMTQZ9lHhZA+bahMYt7R4fOYMAWSyUO
	eQCcLagtHZ2i+zsAxW4d997GWaIuik6m+StdmZxaf2tv3b6CTivofM0TLX69iSYW
	wwa/mILkuXUx8wvfPBoHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731408982; x=1731412582; bh=ZwYYSGG6zgmMQwyFMLiLhe2O5PD1kFprIqb
	GRmWdxuo=; b=OrZrs7IiHfEF0GABQUZ3lNjqpd4ix9WQzbsoGPanfxaawaUNcL+
	R091V9fvCdDJANt26C3CLipgqPUJLzm3bk69ESuUoDS7B3ozN3qej65/rFBiBdn4
	N46N55+wGxegHjY3YQ5je1mfq+j8wKCQXVGZFFPzPfmJ55hORDt+rLfnKSya+JJ5
	NAptGviUAWhnyYFKvgUQQUlCNNOKF8SAOXb9UHY8TSwrT3zcL70uwqP3vsIxKvCv
	Fu1UVp2oUdEvq9eIZZjWr5yCMzgK/Peq9o/CyKbO6NED/r2g76oeOGUn0SVnuNdo
	P3tWMwUXXWIvMLnao1LLQ2en68iAix8SpoA==
X-ME-Sender: <xms:VTQzZ6LSOJzHcwsAXQ8YnEjnH4mlivfcxJPbnXBzwmph2nvcqvzH8w>
    <xme:VTQzZyJXvYIhFkd0a4lfobcQ-8zYAMup23PaoZyKz2ePDuZM_Se_gu82PnGHoFfL9
    DZHgN5pUfuQLmBoB6M>
X-ME-Received: <xmr:VTQzZ6v9no1MkrL897MBqETcqvOXYChz-PfOITIJByQO06g-dJ9xCJpJ-k54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddulecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:VTQzZ_YPIY0Ym-BJMFUogFpGBHhLBk20ACPap7NhQgyFzOVRkh2Pwg>
    <xmx:VTQzZxaUdhKyt1q-unCxsqfwpnXBH-QTfQTsTHDpyCYbpHlSla_T9w>
    <xmx:VTQzZ7Btt360WfzZcr3BTtS0x3AcQPx0aHQo3tH-HwFenSJKT5PMrg>
    <xmx:VTQzZ3Zlg_FEeUgCQgzulKGdkQXzHg_ZTrI6b3X_IOLxlAM11XRFYw>
    <xmx:VTQzZ_OmhHzrwY-lyBQdNyg2XZKMVTnhvlrCu8guNqFvlw62TkzDOJRx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:56:21 -0500 (EST)
Date: Tue, 12 Nov 2024 11:56:19 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 17/23] ovpn: add support for peer floating
Message-ID: <ZzM0U81dmvdEWqdF@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net>

2024-10-29, 11:47:30 +0100, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 63c140138bf98e5d1df79a2565b666d86513323d..0e8a6f2c76bc7b2ccc287ad1187cf50f033bf261 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -135,6 +135,15 @@ void ovpn_decrypt_post(void *data, int ret)
>  	/* keep track of last received authenticated packet for keepalive */
>  	peer->last_recv = ktime_get_real_seconds();
>  
> +	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP) {

What prevents peer->sock from being replaced and released
concurrently?

Or possibly reading the error value that ovpn_socket_new can return
before peer->sock is reset to NULL, just noticed this in
ovpn_nl_peer_modify:

	if (attrs[OVPN_A_PEER_SOCKET]) {
		// ...
		peer->sock = ovpn_socket_new(sock, peer);
		if (IS_ERR(peer->sock)) {
			// ...
			peer->sock = NULL;


(ovpn_encrypt_post has a similar check on
peer->sock->sock->sk->sk_protocol that I don't think is safe either)


> +		/* check if this peer changed it's IP address and update
> +		 * state
> +		 */
> +		ovpn_peer_float(peer, skb);
> +		/* update source endpoint for this peer */
> +		ovpn_peer_update_local_endpoint(peer, skb);

Why not do both in the same function? They're not called anywhere else
(at least in this version of the series). They both modify peer->bind
depending on skb_protocol_to_family(skb), and operate under
peer->lock.


> +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	struct hlist_nulls_head *nhead;
> +	struct sockaddr_storage ss;
> +	const u8 *local_ip = NULL;
> +	struct sockaddr_in6 *sa6;
> +	struct sockaddr_in *sa;
> +	struct ovpn_bind *bind;
> +	sa_family_t family;
> +	size_t salen;
> +
> +	rcu_read_lock();
> +	bind = rcu_dereference(peer->bind);
> +	if (unlikely(!bind)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	spin_lock_bh(&peer->lock);

You could take the lock from the start, instead of using rcu_read_lock
to get peer->bind. It would guarantee that the bind we got isn't
already being replaced just as we wait to update it. And same in
ovpn_peer_update_local_endpoint, it would make sure we're updating the
local IP for the active bind.

(sorry I didn't think about that last time we discussed this)

> +	if (likely(ovpn_bind_skb_src_match(bind, skb)))
> +		goto unlock;
> +
> +	family = skb_protocol_to_family(skb);
> +

-- 
Sabrina

