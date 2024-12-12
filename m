Return-Path: <linux-kselftest+bounces-23266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9319EF1D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81A11797A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362A2253E0;
	Thu, 12 Dec 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MjnYmpAC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHBFjBgS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC18223E98;
	Thu, 12 Dec 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020378; cv=none; b=YlP6hhF6sXY6p1keVBu5eYgjqABN871hf3OQWH2WwnuTucxYwUuigU2tLIMUFBVlhybcvrVYKX40uLnDKSMBbWArK6BzixLD/cUO276JDdqSFwcMAehwaoAZI3AbjI6KmhiW38vGfkljqK1AFPrkaMXFhdM6h6//UT/o8FwKccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020378; c=relaxed/simple;
	bh=w216NyfW1oxIY2+Gq63plKSQ6r+1ySMwciBz7cCBkQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUc8iUklxXT2MLv58xZMfyW320LV6mRnuComZDYV6DDZ5Rp5Oqj6/X7LF2j0kQEJv5tKO2o8SoteoEpyU/VvlArqRv9AQ2qmfm+x55kD0MugSQMMUOWnpEaKDV5cO25x6gzqtgAnMNrX+VU/DtbtbCMyzNJYOINg1ySGZ1M3NLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MjnYmpAC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHBFjBgS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EE2F01140126;
	Thu, 12 Dec 2024 11:19:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 12 Dec 2024 11:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734020373; x=
	1734106773; bh=C0k2bwpb7K+Z89BBfh8KWMaxfFFAR3kLSH99DukfYyQ=; b=M
	jnYmpAClQxmo43CaCkbnBWOLUEFqAzX7qM0GO5z3jOyvDBkWo+2udaXPtoV9W/k9
	kQh6CKOjJahlYzVjf5GeawyfrtNjYO/xb46HEyaYTmSFWUFC7LcXE0ieq/Ea1/0+
	mCnAt/wzPW2TG4flVVPlqdxjr3lBMPQB7Z4bOtTSNvY51vjgFknrPgXYPdeaextM
	jCouM/EbFLrBu9f6mO1MmE8V8M13BkjonVTRVW3CIrlVRnlgLmtiFnUaSeoeMyGr
	mJm0SahcJXHA72C4mrHGjPzKqL5V3M4T8LCO73UQila3s3U3BrjAvCW3ctO2WZJ6
	i6XVLM30Lg8jsVtIaJIjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734020373; x=1734106773; bh=C0k2bwpb7K+Z89BBfh8KWMaxfFFAR3kLSH9
	9DukfYyQ=; b=AHBFjBgSA/j15YHY4n9YD+jZIeHsHoxDCs5bmTJQGD1Yfs4gp39
	lYOx/ZzuSTO1MOuKwQNXti/FfX/DCKmFNvTdonHHU30xg8Jk6wtZxN2Xm3Y929sN
	KgM/t3KpPNo15TJS4ZO5UvlNpgvcpvHArkXksPR9u2JewMOEQHms8R33OUPjQ1tR
	2hDS0ZwTu7I+QKAN13aZqbetWGNFmAwIc7yj7+PUnHY9Ofy8AtWz8p6Q79n32heI
	+3g8EAjxDzejKcsSDS/0Gp/THbP3l4eBvwl8TGNzBEeapEt5+z+31ic+kaDeFsQO
	DXfXk5oqCCX2c+JDWZuWXVRv+69bnEPrt2A==
X-ME-Sender: <xms:FQ1bZwVys6JLznzzXhZvUeclxp79V4EVllFTddM9NLgwOVci7GmsWg>
    <xme:FQ1bZ0kmajk4W9ARk4ajmAvz7p8DsB1E6fOzlb_9MU7EkUn95wrjGxRo3QQWZOGP6
    HTJHn8kIUps92uDTaU>
X-ME-Received: <xmr:FQ1bZ0Y7RGGRzjxfRe4LnI1u5l8rfr-MsjrDioenRynvQe2KKzw1gn5EHF2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:FQ1bZ_WMuVRfMZien5stnUO5tjvCmn9a2H1k3FfcUH-jhPYqN6sMCQ>
    <xmx:FQ1bZ6nmxGu8B5zthDTf8zLtTDY8mEIrDUsWnPKRzwF7ZmsxPfQIPw>
    <xmx:FQ1bZ0eoxHwHfy8jDHis-ZVdy91-AX1tzz227tznKo2iBreZMj1JAg>
    <xmx:FQ1bZ8EB_fRkce0SbjQqQ8Yh5X6dj85M8Skttb2Qy0pcJLdeAxJ7Mw>
    <xmx:FQ1bZ__UU06aWK2NwfUpayGfFNCus7CSZH7BsmNgcWxTC7Hu7KusKkMn>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 11:19:32 -0500 (EST)
Date: Thu, 12 Dec 2024 17:19:30 +0100
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
Subject: Re: [PATCH net-next v15 06/22] ovpn: introduce the ovpn_socket object
Message-ID: <Z1sNEgQLMzZua3mS@hog>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-6-314e2cad0618@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-b4-ovpn-v15-6-314e2cad0618@openvpn.net>

2024-12-11, 22:15:10 +0100, Antonio Quartulli wrote:
> +static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +
> +	rcu_read_lock();
> +	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
> +	if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))

Could we hit this situation when we're removing the last peer (so
detaching its socket) just as we're adding a new one? ovpn_socket_new
finds the socket already attached and goes through the EALREADY path,
but the refcount has already dropped to 0?

Then we'd also return NULL from ovpn_socket_new [1], which I don't
think is handled well by the caller (at least the netdev_dbg call at
the end of ovpn_nl_peer_modify, maybe other spots too).

(I guess it's not an issue you would see with the existing userspace
if it's single-threaded)

[...]
> +struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +	int ret;
> +
> +	ret = ovpn_socket_attach(sock, peer);
> +	if (ret < 0 && ret != -EALREADY)
> +		return ERR_PTR(ret);
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
> +		sockfd_put(sock);

[1] so we would need to add

    if (!ovpn_sock)
        return -EAGAIN;

> +		return ovpn_sock;
> +	}
> +

[...]
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

(since I'm commenting on this patch:)

s/Unlikely/Unlike/

[I have some more nits/typos here and there but I worry the
maintainers will get "slightly" annoyed if I make you repost 22
patches once again :) -- if that's all I find in the next few days,
everyone might be happier if I stash them and we get them fixed after
merging?]

-- 
Sabrina

