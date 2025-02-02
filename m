Return-Path: <linux-kselftest+bounces-25527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4296A2506E
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 23:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE79188406D
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Feb 2025 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80901FECC0;
	Sun,  2 Feb 2025 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="JpbuBqU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWGYJVi8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E61D5143;
	Sun,  2 Feb 2025 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738537026; cv=none; b=LUaaKUdIBrffm83W8gNwsw2GzcU837Ez40Gnji+z5+yfPTrNwgDr1vXuEZLx6ZPjyciuUllZv7vqSn/fYnsBXjT1Ve9t0D++9pvZhy9G7iP7pIqGeACzpLX8KXM6cOuEVhPYGQfdIV3M+0XaaFW/GGUC3FsGNOeq21C7kcERejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738537026; c=relaxed/simple;
	bh=OcXyK7bwwgI9h4bw6stcRM8pwNwW34UUhHFlf3wAQv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmfp77S0OlxEol+g0Yz5YAXa1twsCNyaG2kIpPXllFRqCTtCtv6q3IAHYZeXuCr426vS1/cVsVnj3LIc+83x30MS7AUM0MtZVVxQOVFQZE/FRbbDtNGh6sPxW+TNIgxF476K+v0fKBfbSoL2PeYMXSS6TSIAlzcD+Udx6+PPjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=JpbuBqU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWGYJVi8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 74C9B114009F;
	Sun,  2 Feb 2025 17:57:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 02 Feb 2025 17:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738537021; x=
	1738623421; bh=VsVhn7TsWFkiGhBgMcGseU2C8V1FuoE6pCFZYwtMzzM=; b=J
	pbuBqU+Qq05tsPCaTLyi8PkVthcjzyB0jYkpiIk5/wXO04Odk9dZcmDHzJOnRuIB
	D5X1qR2J8CV6qPunaC3M3KjgJzf/mAJs6vlTcz6FAIfFc08Lt9m5xc7IgEtZX/Cf
	C6Pv//38rhfCfhsgrSmjuE/ZkQj4Ruxtiz5XUVWI8pBCu9B7sV+EZ2juhcCaQg8/
	b8fyBDcWcUaxSWNormj0Qie2LmCAKB9LVuIa+Yf/huUqT68dNgBLz5LnwtUmktyJ
	m5R17rWb1eTTwrlTFS/QSumy5LoFn9tenP6kuQYu6Fm2TOUGdAmLkmibjFG0mWrV
	cpNmgLJuWhO2hgxZ8iK7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738537021; x=1738623421; bh=VsVhn7TsWFkiGhBgMcGseU2C8V1FuoE6pCF
	ZYwtMzzM=; b=OWGYJVi8e4NGXqSnj2j3UVgYa0KWQ0dpUrwfZPPFXBrzpLV3qbw
	lhlwq3+vbfda2/da2wwJ/8uoBsUV4PiuDAjlMV4P8OEX2sdLqt7Xuvv3CnSwGClA
	Y5TXxUwH96CXwMxanh2F8tFKaGuuVXUjBfJpEtaQRoQuP4sZCorZpRBMcvgN1BPE
	P4vSwGfjvQMtw+2GqwhefkRETwXtj1YaoQt/bmQ9qMZ2HzHWPlYQS7Pt/NAb95+I
	k0CHDF/ys3a/4k8U6CGlphM9SnYbVmYZ2Awn7sZam4geDkslefw6sVWY8metnEUn
	0wDKKdIbPIth62QgJYM52/rhimoVjlAsPzA==
X-ME-Sender: <xms:PPifZ_m_OqW7SmIDl9Rncu5-zASjv2z34ZIYdX2dU3FQMfXZ0UXJEg>
    <xme:PPifZy2P_1FrLD3rhJV-6v7mSrm5EY148Y2QBvvHhVCdjdXVWgipaCNgblpbXFyNG
    FF1WVPnJbgjQzosbI8>
X-ME-Received: <xmr:PPifZ1q8Tn9Zt4I6163Ubqkx9a5XkiiyMNEvWQUls5FogVOoTp8EgILNoeUF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:PPifZ3l6muUv4RY8-GwzD9SWhbENRF074jdlNEiE7PUzIJZoL7pibw>
    <xmx:PPifZ92fnp7Mvj-RPYxrlYN4tvmCl9w0OnDY5SRI9hQ-xUggfJc4fw>
    <xmx:PPifZ2s7zZNIOiAMOYOIotAzlg1Y1PED__lG_YIoDZ2iEY-Xh1o87Q>
    <xmx:PPifZxUABlW4LKYPYQ73IJPAQUkLtfwYFeOtAdqVrPvli1mAS2Qw2w>
    <xmx:PfifZ82c0uPha1-qE69f5MlS33SVAAStrzM1gfZ3SnvEjlZTX0Dhtq0g>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 17:57:00 -0500 (EST)
Date: Sun, 2 Feb 2025 23:56:58 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 05/25] ovpn: introduce the ovpn_peer object
Message-ID: <Z5_4OmdmKvHJ5P-_@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-5-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-5-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:24 +0100, Antonio Quartulli wrote:
> +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
> +			     enum ovpn_del_peer_reason reason)
> +{
> +	struct ovpn_peer *tmp;
> +
> +	lockdep_assert_held(&peer->ovpn->lock);
> +
> +	tmp = rcu_dereference_protected(peer->ovpn->peer,
> +					lockdep_is_held(&peer->ovpn->lock));
> +	if (tmp != peer) {
> +		DEBUG_NET_WARN_ON_ONCE(1);

I think this WARN should be removed. If 2 almost-simultanenous
DEL_PEER manage to fetch the peer, the first will delete it and NULL
peer->ovpn->peer, then when it releases ovpn->lock, the 2nd will find
NULL != peer and hit this WARN.

(probably not happening in practical cases, but syzbot will manage to
hit it)

> +		return -ENOENT;
> +	}
> +
> +	ovpn_peer_remove(peer, reason);
> +
> +	return 0;
> +}

-- 
Sabrina

