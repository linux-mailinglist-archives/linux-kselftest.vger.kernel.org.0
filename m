Return-Path: <linux-kselftest+bounces-25557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921D2A25651
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA423A8233
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294E7200115;
	Mon,  3 Feb 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="E/SDR0nl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acB4QbB+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD601FF7D8;
	Mon,  3 Feb 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576369; cv=none; b=JUf9KdelJnjFjLYNkBHy/3iV6xDpmhyn7P4iQiFstkVkSC0qvbZ0oZuNekJtttMAM7nkpqVxZ6nJElUqn8n9bnVO61tpc93Lo7b/77w5slnd5c71pI4s/sGtXaTYufe3Ij/e7nzW7AIFticGP8fSVkV7WM7Tlh8bVv7VIkf2At0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576369; c=relaxed/simple;
	bh=sc3q3OibCw7WSVkx2yTY9q8HnBuuSuxWs5PHz6SDl1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I07ABolydKqLO5trt2FTgwb3ZqtT7R3IqBtUx4hqRmwTGD9+dnLmplZWp3KQM8phgMMx7C7/1IYOfWZqKxlm2XMPJSgNcelNpPCILWrwz06E728tx6Z0BX9+t9I4MaLZ4aOOkFS2tBNasgeO4fhD4PW46Y8TBcyFQNh3EqnS7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=E/SDR0nl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acB4QbB+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45E0411400C6;
	Mon,  3 Feb 2025 04:52:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Feb 2025 04:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738576364; x=
	1738662764; bh=dbbvERRV/N8aAD3CD8DoV3d/HZiD7swxk/GF0WG8Bic=; b=E
	/SDR0nl4A50kz3kmtJh1srjk83W+aZHYfuWZ7Pfxnmhk7wv3lOejwKq4m0bsPJZn
	Um6tmpNJW6oMRa+l6zGXkmCLKK5YrzVuUmvVliNuMBnAtWbgn8PkJqcxPKrE29JB
	a4FZf1AmM2Xi0yBRKTszhKXkvQv1QvwCADiuNV3FAuppVq9AduW4K+983KOS0npa
	7oTQ0ZHEcenAigU/2ghEBWm9XY8Gzy+cleUMPbDIaI1Z4rDhqBTgwZ3SYJxEcXuc
	W0SYa9gQesE///47HKS2RToYEvHelRoeGdxY9G8h/kJt2wnjEFBhj0S5EKuScKt9
	VdtjfPW7okB6TnKhIfQ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738576364; x=1738662764; bh=dbbvERRV/N8aAD3CD8DoV3d/HZiD7swxk/G
	F0WG8Bic=; b=acB4QbB+UhWx695KL+ylD3fBRNKV+r43pMb2hpJtSj/aoYyCwpN
	nQJnMVh/feQUKtfsnP0N8rbHll6OuXw42KmqzHEGLG5i4ScHAMkZe6agBWY7LfJ4
	W7nyEDvl2rJfZ4o7gndECLHVzyeJ1mVM5CMRVq+Wy47yB/3Sfl1xwPVLWxcUpLBw
	VHBS85EyC6NR9VTyFXZ82gxesQHO09Q2AryECEVRivcajlnR+M0pUEWpzLgsU9vk
	KjVulVliblPQH+SJ8u4G5p7Q/Y8QJgq1E83XLdN1R+8w0+mdzL2uOsNAIGXeWAVL
	nslL3wPBYhjv42fQN5lxLRPIVarKsqARfkg==
X-ME-Sender: <xms:65GgZxice6U08Z6cOvp8JifPgZ5uSCgo0LZMpSYfoG7_vW3gTmY9GQ>
    <xme:65GgZ2Ai9YHIDlw_RbIy4mdbsYTfucZOwf8SuaHldhBDTvKodvAayZYPYLwY1UtkJ
    fo652GykLg2I9bAtb0>
X-ME-Received: <xmr:65GgZxE7Inpp5DqJ73Lj1lFE9eftfM4rJDnzMvNzNzE8CfILbg6ZSyWi0Ix6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:65GgZ2TYMzheBXJBQEvAYbIhrCmzDAuZl5JKYGZb6zUYMrOc0KllBw>
    <xmx:65GgZ-y-8PLSXdUR65542pNdSiUxuOKPCMKSBcLlMxTsC1NIEVBATw>
    <xmx:65GgZ87uf-aS_SV3KzuKDCx3yY8pFJT2HVuF8R6145TWcxAjY-DPNQ>
    <xmx:65GgZzxTi1HEeNAMvjTFc70HHjb5ZXmW2zMKF6Ahj3_Lru8XN6F7TA>
    <xmx:7JGgZyiru_sXWAds0gyVuI8KhbEw13bpFs-sooOtxwcwonNXBM3hwgrT>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 04:52:43 -0500 (EST)
Date: Mon, 3 Feb 2025 10:52:41 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 07/25] ovpn: implement basic TX path (UDP)
Message-ID: <Z6CR6QGVrMqauP2H@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-7-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-7-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:26 +0100, Antonio Quartulli wrote:
> +static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
> +{
> +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
> +
> +	if (unlikely(ret < 0))
> +		goto err;
> +
> +	skb_mark_not_on_list(skb);
> +
> +	switch (peer->sock->sock->sk->sk_protocol) {

We have a ref on the peer, but not on the ovpn_sock. DEL_PEER could
have detached the sock by the time the crypto completes.

(unfortunately I don't have any idea to fix this yet)

> +	case IPPROTO_UDP:
> +		ovpn_udp_send_skb(peer, skb);
> +		break;
> +	default:
> +		/* no transport configured yet */
> +		goto err;
> +	}
> +	/* skb passed down the stack - don't free it */
> +	skb = NULL;
> +err:
> +	if (unlikely(skb))
> +		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
> +	ovpn_peer_put(peer);
> +	kfree_skb(skb);
> +}

-- 
Sabrina

