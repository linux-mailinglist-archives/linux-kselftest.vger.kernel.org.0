Return-Path: <linux-kselftest+bounces-24588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE8A129D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 18:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4786716621D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE7F1C1AAA;
	Wed, 15 Jan 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="SOPkBzoe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gf0Z5MB3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616A543ACB;
	Wed, 15 Jan 2025 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961950; cv=none; b=C7jTR72YtTVxs/F4kTe0dWqt77b5CDhoKdHoKN5+W0QKCOxQUgthAtPXcffklVQER8zwdU9/FAONSuKuR3QjG+zN8ySyC7NMWLKage4Z1+Pv2kNDwGiITVZQ3BZIHS9mvhksAdl/ulZLvXwARSs7loI+knDWC4XJ120psbpl204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961950; c=relaxed/simple;
	bh=L/y/gio9PHgozPJQ5DdFgec3HVA+WmVn2Yosa/ULK/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+Ov6yhHEGIgRzLU3/Ga2auY4uOzrFxd+YRdnAvhY1ZeCetu10mewSaIMg6doM6rJMcqMrLT6fj2pwcDcFKbu3zuSN4jSaf/bXXZEyrLPVE9d85imqnXPopRwItXzJAjxCH0nJtalYfSxvcimsk96NnWxP05oqWamxoU9fTGqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=SOPkBzoe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gf0Z5MB3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53A75114017A;
	Wed, 15 Jan 2025 12:25:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 15 Jan 2025 12:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1736961946; x=
	1737048346; bh=yj/IsjT0ULiPtO76mLIqcNBspRAdw74njWDzregRk4A=; b=S
	OPkBzoeR3sU0W8SJW0BxpdupLdfVxNkLTzq3D4PhITXJzWPYxy56UiQLIqD+KwLB
	wzx4yd8JZQcrOO8tVkKcaVxPFbltNXRu4oM/G1DbmOTpbn9bpDklzJmhbsxlJ3G1
	oIw/VuguGPmASTE2RpqukqavwT4MYYtx0WPoZikZEFvNQAt5kqgTy4lKnTM59YGj
	JFUojxw24DHZEtjMZyuKfQ4Po1TGM+NSI9DrbYeD7SlpyGdRXa9YKgmwvsg3jmUC
	D8QndnLVJMEl+ybkBdTZ2+6Vj5jP8Zgf9DvUSC2pJ0+BSYtHnuY3GvxlCL65iVuM
	oiWD8fBs4d92ina1m4Umg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736961946; x=1737048346; bh=yj/IsjT0ULiPtO76mLIqcNBspRAdw74njWD
	zregRk4A=; b=Gf0Z5MB34TFHCZstZpWY6QPp/MNd2/Lmqtyeb4MEvRtdyZpqbXi
	jnzT0CtsFbMBtIF5fnRHKq2EZBlAdIkWTGLF4JdA21A2PDbP0B+8m2hpbV2dIsK0
	H6MFjrpWUHZ2N8SfIJTGXgXwqUWBKm+tPRaOHCekL48WzCk1OuS8SBZiRbsGMEld
	qpFvodyD47mwj3iEYRD+gJxX2a8BN0QC+FtyreGamgkR007Xz/q/w9YtmMIx8Ere
	CEhdo82WWvHKdkAC3ux1dmWSrYV7eaH1GfhQXJ8RXplbDeDgRWSnkZaQJxIJYgkt
	S1uXefX/nsZJT3j7YYAUQckg/zvmJ9K1swA==
X-ME-Sender: <xms:me-HZwXv2Het-Bo3gDp8ev62BLDNt3dE5d7AQ_2E0ZqZbsPQQEdC_g>
    <xme:me-HZ0lfruSFtiUT-T3-tO-vU-u9CQOmWvl1clXlDPp5Fp2JOE1bnOluLK4wDBkMK
    qRjdZAZIkT7nivRDSA>
X-ME-Received: <xmr:me-HZ0aAhiS5ScO2S-DQqSA9Bv5r2XQHvS62tKqFk7VqYBw8nrWX-Qvy8Op1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtth
    hopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:me-HZ_Xt7p0hoWuLpl70YZQhEYNrXrZQSjap42s3l9LXQiX9cPzBfw>
    <xmx:me-HZ6kzpfjlNneShT473xgNo1G7qvEl80JQXwQQ6xhRt7R6JEUs6g>
    <xmx:me-HZ0dxc_nPDJrglcLVqYahmghfz0ow8Ry7hkehvLbQffSu5cqjQA>
    <xmx:me-HZ8GW_l9VkDELXHtAuKh-Pj-ds14DD1NrRIfpXb4NxlwJC3Wo1w>
    <xmx:mu-HZwmT09v6y9uvrbBdUdGC9VMzDjEE-kEtNDT347prHvsMlR_IxkRZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 12:25:45 -0500 (EST)
Date: Wed, 15 Jan 2025 18:25:43 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 12/25] ovpn: implement TCP transport
Message-ID: <Z4fvl9Rk1tuD7Oq7@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-12-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-12-1f00db9c2bd6@openvpn.net>

@maintainers could I get another day or two to poke at the new socket
release mechanism? I haven't had time to look at it in depth yet.


Just a small thing I saw on this patch:

2025-01-13, 10:31:31 +0100, Antonio Quartulli wrote:
> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
> +{
> +	struct strp_callbacks cb = {
> +		.rcv_msg = ovpn_tcp_rcv,
> +		.parse_msg = ovpn_tcp_parse,
> +	};
> +	int ret;
> +
> +	/* make sure no pre-existing encapsulation handler exists */
> +	if (sock->sk->sk_user_data)
> +		return -EBUSY;
> +
> +	/* only a fully connected socket is expected. Connection should be
> +	 * handled in userspace
> +	 */
> +	if (sock->sk->sk_state != TCP_ESTABLISHED) {
> +		net_err_ratelimited("%s: provided TCP socket is not in ESTABLISHED state: %d\n",
> +				    netdev_name(peer->ovpn->dev),
> +				    sock->sk->sk_state);
> +		return -EINVAL;
> +	}
> +
> +	ret = strp_init(&peer->tcp.strp, sock->sk, &cb);
> +	if (ret < 0) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		release_sock(sock->sk);

Leftover from the old locking scheme. Could probably get snipped when
applying if we decide this version is good otherwise.

> +		return ret;
> +	}

-- 
Sabrina

