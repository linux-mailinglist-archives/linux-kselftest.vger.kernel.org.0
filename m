Return-Path: <linux-kselftest+bounces-27982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F5A4B43C
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 19:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A5F3B0CF6
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76011EB9FF;
	Sun,  2 Mar 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hlSHkZmx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bj8DWwQI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85611EB1B8;
	Sun,  2 Mar 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941967; cv=none; b=bb/Kelv5O42XDP4LjWNVWyiMiCSfBfIGDa4SYYYq7oIY1ienZF1HwDTdbN+bmbx4ubs17xQ0HBioxUWjJkhvTleKndoHMJFII+BDuKRQ/qD/P9ovkhvsEpn5G6jua46DFUwQTz8r83k/IMwOjL4ig8RasjasJUmc0ZcsTnBcFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941967; c=relaxed/simple;
	bh=UYb319UmdfGOCWVEJRBhTzQpIvhNbQXAbWaVXUu8ZwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMiQv+IZ67pI8AdcufHF6YXru/HAc+x2jQ4QIOUtnxkU6bFf4N4t5x0Kzc8xtDSf58bx1Z7WF3zZCVqMI01f5+az4vBjtNtAU/akNem3mOhaefGMEyT2KSKmeVmqgxk/VUFMq0UpPN1Yj5Ry1/e4u+cqx1RdKFYK4zVqszObtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hlSHkZmx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bj8DWwQI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AB97254018B;
	Sun,  2 Mar 2025 13:59:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 02 Mar 2025 13:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1740941963; x=
	1741028363; bh=ByETV/vKdhAC0W6D+ZlHSo+SPgq3hi6yYES5IcYx+80=; b=h
	lSHkZmxSo/bJJB3bMrtPl8i1LvnY3dCCmMUBe7ZgO5WVNwuWCiwZGzCYjhvO73XB
	TyxUJEJtsYDTqbUe6b4mezwVdofWOL8lPFEyO2v9R0KHnL6fJ0uuXK1KKEixrNuA
	/kmHLWsgwVv+8P0F+sXzNMgXurnqZcrihl5yx8KepxJoTPtKY8YXiEO9jJqtOBi3
	dAB785QSNi+tb8PGdPxHDYAAOFcta+muDApRn1Usy1ZTir8RirDK/rq7UfJcHFLa
	JOsVsnQ48vUjzAy2KjJLxOhhn1Rd02PC6TEVQaxE89FGNpD8rz3wsz63AQ8Wn9LB
	k3WkFoLeAALyJtjbYZdBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740941963; x=1741028363; bh=ByETV/vKdhAC0W6D+ZlHSo+SPgq3hi6yYES
	5IcYx+80=; b=bj8DWwQIzQY8vH95wDZuDtp9o2nrxQe0tMolt0o7gFPYfEeWnhL
	4O1SrIJ2zLvPik0FrDoeiOgR+t1djCrq6VTMxY73wDCca0pjt20MzSjgYzWdb/sB
	5HPvlxyq6atZMINuu1DhcBsx4zRIuIzc78ZyTUXKP8w4qBmJ7fF2yxp3bum5amNb
	COd2FAHW4cIJRSZRJYYxCvBokPHiGBRDvF0izD6j59KQv8LDnvmE629L6yRKi+G4
	CMn8QwxVcr9DjBVgsUr9h+wv7C2PazcalgZ+H5v6VeJJqA1Txphu+LnZDyTXVTgC
	DhJcqIloQNKocekcJMq46MRQFqyqTAWHQvA==
X-ME-Sender: <xms:iqrEZ3NJDbn1bYS-a0Eh1dZfsWfWcGv6jfOC1a2a_m2iKhxIQCmAVw>
    <xme:iqrEZx-0n3IWI4rjwOUgoUKjAqYBEUg1qas4B58-_Y3W6mkDAJAQogDLmCwa-CPU5
    _T_6LkyIzg2OBfOuQs>
X-ME-Received: <xmr:iqrEZ2Tjxy9k0Bejz88-q_4DiOYgp2SgTmHRoNQfLgXQPoZMypzQida9rBYB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:iqrEZ7sVe4tDvW961QRgG9Qo6g1iLM-e3H9rCplRT7ti_g6SDiTolQ>
    <xmx:iqrEZ_cGlmcfBYChseWwVCw7Ja28oW3TdiJWayszuzMXxpEgZ5gQdA>
    <xmx:iqrEZ319vQNjXX2Wu8FtzXUWfAmqzPnBd8yEo0gGwfwm9_f3EOst9A>
    <xmx:iqrEZ79NRl4sx90F6knyNDgFqFLXoY51pDFlU8YuVKwM4sXGRJsjgg>
    <xmx:i6rEZ60TqJSyQgwN7xRfqD9KF6PVsNVUjBWdyOWynUlu9ZRBQeIPz7ps>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Mar 2025 13:59:22 -0500 (EST)
Date: Sun, 2 Mar 2025 19:59:20 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next v20 12/25] ovpn: implement TCP transport
Message-ID: <Z8SqiJedxrFhGuB9@hog>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-12-93f363310834@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-b4-ovpn-v20-12-93f363310834@openvpn.net>

2025-02-27, 02:21:37 +0100, Antonio Quartulli wrote:
> Moreover export tcp_release_cb by means of EXPORT_SYMBOL instead of
> EXPORT_IPV6_MOD, so that other modules can use it, even if IPV6 is
> not compiled in.

Is that really needed? You're saving tcp.sk_cb.prot, so you could just
call peer->tcp.sk_cb.prot->release_cb? (with a bit of care since it's
called after peer_put)

[I don't know what the maintainers' preference is wrt "re-exporting"
symbols that got moved to EXPORT_IPV6_MOD]


[...]
> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
> +{
> +	struct sk_buff *skb = peer->tcp.out_msg.skb;
> +
> +	if (!skb)
> +		return;
> +
> +	if (peer->tcp.tx_in_progress)
> +		return;
> +
> +	peer->tcp.tx_in_progress = true;
> +
> +	do {
> +		int ret = skb_send_sock_locked(sk, skb,
> +					       peer->tcp.out_msg.offset,
> +					       peer->tcp.out_msg.len);
> +		if (unlikely(ret < 0)) {
> +			if (ret == -EAGAIN)
> +				goto out;
> +
> +			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
> +					     netdev_name(peer->ovpn->dev),
> +					     peer->id, ret);
> +
> +			/* in case of TCP error we can't recover the VPN
> +			 * stream therefore we abort the connection
> +			 */
> +			ovpn_peer_del(peer,
> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);

I don't think this works:

ovpn_peer_del -> unlock_ovpn -> ovpn_socket_release -> might_sleep

but we can get to ovpn_tcp_send_sock in a few contexts that are not
allowed to sleep:

ovpn_tcp_send_skb -> ovpn_tcp_send_sock_skb -> ovpn_tcp_send_sock
__sk_flush_backlog -> release_cb = ovpn_tcp_release -> ovpn_tcp_send_sock_skb
release_sock       -> release_cb = ovpn_tcp_release -> ovpn_tcp_send_sock_skb


(I checked all other paths leading to unlock_ovpn/ovpn_socket_release,
this is the only one I could find that is not allowed to sleep. So it
would likely be easier to push this peer_del (or even just the
handling of release_list) into some other sleepable context than
trying to reshuffle all the other paths)

-- 
Sabrina

