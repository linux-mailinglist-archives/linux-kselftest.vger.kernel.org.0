Return-Path: <linux-kselftest+bounces-22413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0DF9D505B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 17:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90188B221C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0686C19E7D1;
	Thu, 21 Nov 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TWPDTvVP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsoRE5mx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6B158A33;
	Thu, 21 Nov 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204943; cv=none; b=ar9CknIm75CXPGKB5nLmdtryM0gsHZwCv9RODjgYvuoZ2TI816c1RtFzs5wF60NNCo/azM4hBIfXjzKQWeRSfq5l+wDlRiLE5QzpmHwakEVwvL4LQd4PAnCdTgQx/j9mnEmZj2kET9InO9keTCGkGsAfELZ8VA496+Ybk/EDNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204943; c=relaxed/simple;
	bh=dBHlf6+aZ1hAOrvQPwSccNRc472d+mPq6Pqy8pnvfqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTez54ssCs/Dd/tEl0s04ydXTsWl+D6l74I5yeKaa6eX2qC+vFs5zydd89O7DC8cQyxxzc0VU9yAZbOKofdK+hHhm62hkFL/P97SXrGzkNHaJu3c7FUP0+qq4Oj8m6SRk0pHr9AECkAuoT6tmmuI7bZeIZr9zPuEs/j+YIl0J3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TWPDTvVP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsoRE5mx; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id EEB67200637;
	Thu, 21 Nov 2024 11:02:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 21 Nov 2024 11:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732204938; x=
	1732208538; bh=pO3PALF2awA+eBkc4VARw2inhjxAJiO5t86BEffGEBw=; b=T
	WPDTvVPJ6FmJbTIVJ9cjEwSdbk+CQXtbYOIod/ngJcXW4TWzv8qJlZTYYFak6mGn
	KGTsig9Hs8eAtEMHVLfaTIcH3qdySAKtLCXx1ukd+ikhGODWIlgkebyY5vQnkp2b
	qPdIRjyy4rtk5lGMgQLTnOcxcIC8MietnDM9xfW6Q5iFjgzuPN4lw/GpeCS5RvFl
	/zfIgRwIos7ZmN3/WD13n8g3G24l0bk3rxfvk5Efkd85iWkyy1Jrku24hx6A+afQ
	NA4nMTRAPSneMcclwaU6ZCcIin80Bq8bWFIY3e1S92rizQBHcaXSyFbdBspvdEIE
	IWXze/N0lWC4d+Mp7nq1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732204938; x=1732208538; bh=pO3PALF2awA+eBkc4VARw2inhjxAJiO5t86
	BEffGEBw=; b=JsoRE5mxhUvnoibuHggM8f9j0HS3wCPZT3oK+JNDED+a5Io456B
	2P41QTC3Xz3PJQovzdxpoc6bYbT22dWh1BKU9fSIinuMJ+Z1eyTaBmBcyOxSdVvt
	PWM2JrzWS3mqaPBERNu1j3lORoSLcCI7MIHzXo0DStbrChajPHuhFkG7rh41zIf5
	BhAfmtA6a7/+zETJB48Vo4KkcDWKyXd2mrXbaCEBVtWQ62AYVuarA7hFE/NKCD4q
	an68PAZqGQ6BzmyYWfzdIOWlyp+73kPJIqtYP2cEmSvM1MKW6rq0iICIB0XYsgQp
	KAi0izO2lzizHWr7hauK10svFfeBmZqy6/A==
X-ME-Sender: <xms:ilk_Zzo0kvxi0-8n6fCkCA24K5CkyUYcMk7atmcZrkPozFaxQ1PxuQ>
    <xme:ilk_Z9p0mp4zrGaZJT-kz2gf6XsTOJET8TTJ-n63m-De-WQuC-E5SkE-LPh5_WrDJ
    1h5a4joHZP4Xn7d84U>
X-ME-Received: <xmr:ilk_ZwP1FwnkqlDMWvWy2roaQHiqTRmSZ2ZxwVOHe-hqE8ALy9_E5eQqj4XS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigdekvdcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:ilk_Z25w-yK-e58Q3JfDsVJIFxeV6ELe7jvji-q9k3hnHgEwnTMLUQ>
    <xmx:ilk_Zy53vRHhMrOHg3FZEcQfMJxA_EVBqx2w2OqKgL01p7XiBkBfHA>
    <xmx:ilk_Z-iuDQpl-psr7P3DlL8Eqj9AmNeM8NUqs-UuRNwIxN5dpVe6Kg>
    <xmx:ilk_Z056dXOzePiJl8WqbSw9XDqPJrSJ4mRxQP5aunuXly-DHtXOgg>
    <xmx:ilk_Z0skCtz4O2b9xjq7tt7lay1y8a72X5c38yerGPvt4f4IhyScrpsS>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 11:02:17 -0500 (EST)
Date: Thu, 21 Nov 2024 17:02:15 +0100
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
Message-ID: <Zz9Zh-5hZrbal5Ww@hog>
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

[I'm still thinking about the locking problems for ovpn_peer_float,
but just noticed this while staring at the rehash code]

2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
> +void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
> +	__must_hold(&peer->ovpn->peers->lock)
> +{
> +	struct hlist_nulls_head *nhead;
> +
> +	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
> +		/* remove potential old hashing */
> +		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);

s/hash_entry_transp_addr/hash_entry_addr4/ ?


> +		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
> +					   &peer->vpn_addrs.ipv4,
> +					   sizeof(peer->vpn_addrs.ipv4));
> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
> +	}
> +
> +	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
> +		/* remove potential old hashing */
> +		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);

s/hash_entry_transp_addr/hash_entry_addr6/ ?


> +		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
> +					   &peer->vpn_addrs.ipv6,
> +					   sizeof(peer->vpn_addrs.ipv6));
> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
> +	}
> +}

-- 
Sabrina

