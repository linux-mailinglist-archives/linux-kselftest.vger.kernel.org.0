Return-Path: <linux-kselftest+bounces-21463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381F79BD433
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 19:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1061C22A7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9A1E572C;
	Tue,  5 Nov 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QwuaJBOx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQC+p7Ic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD61DD0D9;
	Tue,  5 Nov 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830248; cv=none; b=cLGrOUb5Fs+z7a8vs8ii/tPrfOKShxQDHEHy/lSNNXUp54kH2SRDIzVAjkhY45XK0Um+shSnwhoyUGLvXwwdj8VD4AyyXvZYHyIRjJZLWHz0X4yDM8SKpIEopDOsn+9+2absGTxnaTxnj+o6xIAFtG+DbKAUgESGOQcoMwdeQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830248; c=relaxed/simple;
	bh=HYFJ7RWaNQ2AEXPknfwHbU/2U57StmxJYIi970vv5+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSrFKNFJdXO6pU8oip4U5s4OLzenMVwT8u2GjTjLs7YKCO7dDHoE6Spg4jpB+O+RrZ0xvk8FqyULJkXfZQA0GeCgJiP7EjLh7LLvDazbN63Yh4zw1ldAyDH89jlS+TzZoVUGxsV+JusuB/DUjYuIm5DG7oyAwog0Kjvpyyof+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QwuaJBOx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQC+p7Ic; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id D652B200A10;
	Tue,  5 Nov 2024 13:10:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 05 Nov 2024 13:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730830242; x=
	1730833842; bh=BXNbcK4oaF8kcZTEnhmbdhVlGxHXjezB9T7ZvovImjs=; b=Q
	wuaJBOx1KXK0n4SdD5hfrmh6eU3LS/xFav53iaU4P9/q9l1ydJTiqv8CfE/ol4jf
	w/QluleuwKJ/Gsu266AeH50o99vmmeY2Iet9zJw42E8yzWP/z6rX98CUfDxvXD+L
	EY10N9zOWnojlyNK5PUxEsmQz9vkmW8Gw2HM9WH5FsXdyxm5IdT+Lwhxt6m0gTaQ
	bSTzZMXfE4KXjKpnRbD4PAA9nTpT8T3OF4VmEncq8Yq16WtuSS3qBbf+uQS1SvF2
	dEvMC6IXvIIjO4O+Hbc6UpuHzJ36+3os56lT87i5BrEe1QvKyHYJkf8LEu9LETHx
	JmyQeXhv6ysD1U296uxNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730830242; x=1730833842; bh=BXNbcK4oaF8kcZTEnhmbdhVlGxHXjezB9T7
	ZvovImjs=; b=WQC+p7IcqYC4Lf3gjZNqslp0rDtbBD8Xh8V5vmZuX8R0MVR7IlN
	En3MvVpV/FMetgoeHUJ1UdQjg+YAfpxDq/cuLEnJ2kzHt7LN/nTkIZgeeKJD5AEV
	MR8D519/6zwiDZtD5vjaee111PXnGIvgfytQomYLKxges77wow9CrbmIoxeSj4HT
	MzMvxtxKEMXDwo1mB3PYjasgPxLyjbrXs2uZaLOwRkP1zCBr7egHtzuV6dM3CrhI
	7+aBjoHd0DyUl62LNKne6B9SOb7aNVnEJZ8htdqbWlKlfj2a365uXCssjyjy9F24
	BYQLe632L1rSpDyQcxz169OCdM5/9yxXKhg==
X-ME-Sender: <xms:ol8qZ5RdL8C2QcbwHV4wLQwrD-Yyvo8O499FymMjwfvR-bDD_q3lIw>
    <xme:ol8qZyzso0YKXm6tP98lx-ZT5tEecsTJO9hIMeg7DRsQK0eTu8rSOAyyj_MqoHpr5
    iGK7S7-a9ejCUJnJi0>
X-ME-Received: <xmr:ol8qZ-1u6zGroZhkL2rdSuCBsHC-E6AmOD1D_sBty59vGsgxjuf3fCM2z4ny>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgdektdcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:ol8qZxCVRtRSGL8WwBLeSW4NQSKONwiljAhyO6I9C2QfbGPlue4slA>
    <xmx:ol8qZyic_VJkcPTIKnmbIDzBhdYgzHHhNGOv8JB_p1NFgtgnV0osQg>
    <xmx:ol8qZ1oJDlYuRroaWRIWrswdgr3ADMHIfmR70hRy9Vxms3T2Ys-CiA>
    <xmx:ol8qZ9ho9l1L_5mtA07EU64XD7D3VJ3Cl4kbde6MJ14NjyxY0y0GEA>
    <xmx:ol8qZ7Xst97bNAXgDwHW38Y-c3nApBuUL_7AzvCP74xt8voe8qZ0JXKX>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 13:10:42 -0500 (EST)
Date: Tue, 5 Nov 2024 19:10:39 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 15/23] ovpn: implement keepalive mechanism
Message-ID: <ZypfnyfToF1b6YAZ@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net>

2024-10-29, 11:47:28 +0100, Antonio Quartulli wrote:
> @@ -105,6 +132,9 @@ void ovpn_decrypt_post(void *data, int ret)
>  		goto drop;
>  	}
>  
> +	/* keep track of last received authenticated packet for keepalive */
> +	peer->last_recv = ktime_get_real_seconds();

It doesn't look like we're locking the peer here so that should be a
WRITE_ONCE() (and READ_ONCE(peer->last_recv) for all reads).

> +
>  	/* point to encapsulated IP packet */
>  	__skb_pull(skb, payload_offset);
>  
> @@ -121,6 +151,12 @@ void ovpn_decrypt_post(void *data, int ret)
>  			goto drop;
>  		}
>  
> +		if (ovpn_is_keepalive(skb)) {
> +			net_dbg_ratelimited("%s: ping received from peer %u\n",
> +					    peer->ovpn->dev->name, peer->id);
> +			goto drop;

To help with debugging connectivity issues, maybe keepalives shouldn't
be counted as drops? (consume_skb instead of kfree_skb, and not
incrementing rx_dropped)
The packet was successfully received and did all it had to do.

> +		}
> +
>  		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
>  				     peer->ovpn->dev->name, peer->id);
>  		goto drop;
> @@ -221,6 +257,10 @@ void ovpn_encrypt_post(void *data, int ret)
>  		/* no transport configured yet */
>  		goto err;
>  	}
> +
> +	/* keep track of last sent packet for keepalive */
> +	peer->last_sent = ktime_get_real_seconds();

And another WRITE_ONCE() here (also paired with READ_ONCE() on the
read side).


> +static int ovpn_peer_del_nolock(struct ovpn_peer *peer,
> +				enum ovpn_del_peer_reason reason)
> +{
> +	switch (peer->ovpn->mode) {
> +	case OVPN_MODE_MP:

I think it would be nice to add

    lockdep_assert_held(&peer->ovpn->peers->lock);

> +		return ovpn_peer_del_mp(peer, reason);
> +	case OVPN_MODE_P2P:

and here

    lockdep_assert_held(&peer->ovpn->lock);

(I had to check that ovpn_peer_del_nolock is indeed called with those
locks held since they're taken by ovpn_peer_keepalive_work_{mp,p2p},
adding these assertions would make it clear that ovpn_peer_del_nolock
is not an unsafe version of ovpn_peer_del)

> +		return ovpn_peer_del_p2p(peer, reason);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  /**
>   * ovpn_peers_free - free all peers in the instance
>   * @ovpn: the instance whose peers should be released
> @@ -830,3 +871,150 @@ void ovpn_peers_free(struct ovpn_struct *ovpn)
>  		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
>  	spin_unlock_bh(&ovpn->peers->lock);
>  }
> +
> +static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
> +						time64_t now)
> +{
> +	time64_t next_run1, next_run2, delta;
> +	unsigned long timeout, interval;
> +	bool expired;
> +
> +	spin_lock_bh(&peer->lock);
> +	/* we expect both timers to be configured at the same time,
> +	 * therefore bail out if either is not set
> +	 */
> +	if (!peer->keepalive_timeout || !peer->keepalive_interval) {
> +		spin_unlock_bh(&peer->lock);
> +		return 0;
> +	}
> +
> +	/* check for peer timeout */
> +	expired = false;
> +	timeout = peer->keepalive_timeout;
> +	delta = now - peer->last_recv;

I'm not sure that's always > 0 if we finish decrypting a packet just
as the workqueue starts:

  ovpn_peer_keepalive_work
    now = ...

                                       ovpn_decrypt_post
                                         peer->last_recv = ...

  ovpn_peer_keepalive_work_single
    delta: now < peer->last_recv



> +	if (delta < timeout) {
> +		peer->keepalive_recv_exp = now + timeout - delta;

I'd shorten that to

    peer->keepalive_recv_exp = peer->last_recv + timeout;

it's a bit more readable to my eyes and avoids risks of wrapping
values.

So I'd probably get rid of delta and go with:

    last_recv = READ_ONCE(peer->last_recv)
    if (now < last_recv + timeout) {
    	peer->keepalive_recv_exp = last_recv + timeout;
    	next_run1 = peer->keepalive_recv_exp;
    } else if ...

> +		next_run1 = peer->keepalive_recv_exp;
> +	} else if (peer->keepalive_recv_exp > now) {
> +		next_run1 = peer->keepalive_recv_exp;
> +	} else {
> +		expired = true;
> +	}

[...]
> +	/* check for peer keepalive */
> +	expired = false;
> +	interval = peer->keepalive_interval;
> +	delta = now - peer->last_sent;
> +	if (delta < interval) {
> +		peer->keepalive_xmit_exp = now + interval - delta;
> +		next_run2 = peer->keepalive_xmit_exp;

and same here

-- 
Sabrina

