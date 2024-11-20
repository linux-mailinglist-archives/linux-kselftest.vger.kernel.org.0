Return-Path: <linux-kselftest+bounces-22346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD79D3A8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 13:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E2B275C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB9D19F41C;
	Wed, 20 Nov 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="UVHT/tL8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGj11eCc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D319F114;
	Wed, 20 Nov 2024 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103818; cv=none; b=ifSzzNcuvcMYMShBQVRt9xqpeYjJU3MXTktpADH4nTyELbiVVIJSxz5jjwsoRTTTRnaYToiwmySt57BUTs1PedFVDQQF/nghLbujZ7TUXUwD16U06GhTSK5IYwgYqC5t9gNpEKwM8oeuh+ofZND3QCUieNfksLBX7qwpLo/1wGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103818; c=relaxed/simple;
	bh=nXn8VLayjc9h1QTOCTp3FpY6WR+H7Ywm1uuWtcTXJsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYqlH7ak5hnRPgbCb+0cdrZzhsD0Sjox8mfLtX6N32bDcYXKCY/dNuPtmr4ugzA3irUDholNieKvxnYiRlYuDoOiSKlUMpiiape1dTK2k5vz8rebUzna47dyJCkszuqMaEtk8XNasuLQh2fmwHDTv1LSfU02LzBS6HxXgWYFQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=UVHT/tL8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGj11eCc; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id EDECE1D406A4;
	Wed, 20 Nov 2024 06:56:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 06:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732103814; x=
	1732107414; bh=3wzTO1++4Ztyr65JdrAwE0ye/gOHnqzkIkXETjXcGRw=; b=U
	VHT/tL8MEtdmKD525NAXltOXH6qRK+PqpVQ3g0+zNoeXcFXwbCXibJl2r3B3qvCi
	bXe/HRvFSjfbsASrpumZlwRUffPke+3gGeqwUnfWZbh/rwnZSE+EkFIBsblhYIKR
	P4bjKqtj4CM0nIWWYDdXXpQU6GbENwLMUwugXevUmwMdrmNu/kMhIXi16MV0mUb2
	bdcr8U8JkMvz8tTTOiqruU+z1YPChpXFs6oSnV4zYJNhV3SOrTFy1KuhqFpY/vLK
	m7pd7/kEe5yYa9dr3U6/LCPCIg0UPkwp83EvO/CA//8gqq6sezAgEn6X2g1UDyTT
	FlACyFpney0bsPd6npDYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732103814; x=1732107414; bh=3wzTO1++4Ztyr65JdrAwE0ye/gOHnqzkIkX
	ETjXcGRw=; b=IGj11eCcS/0X/9SjB3VSzwLtMKQVUi4O2jkSUH8dwH28mwpudES
	kKtqbRXZP3M/qeWqgDkzbafBFUa09DT3peZW1cBosxWDHZve8pB1mMwDUz/47oq4
	KCLt1h8lhXGzEAGyWFUHs1vvVzaxnZdaGtluta0QMxe10gy6/614UaP5ETXidTT9
	/l50IC+fSxqBbFfJkY6tea/HAZLRyqla+feqt4KZzYa1yIp3ckXdJil5g0lhzoz5
	7Rsq+Z8F5TS+oyTowG4UPewXWeEtdw8fCE/KprSJ9KFJEUzHBmUErvGVI0Re6nq5
	TOtT1tjKbuJUxRpOU5Tv5/M5oLVBfdpQGFw==
X-ME-Sender: <xms:hs49Z1_O7mXIu3NEOKfSuEuGlIGSJm3AkPJCIEJ29KjcQ704SS65fg>
    <xme:hs49Z5tUod3xVeKRnO_jNRJDSVO7b-jDK6TYFbt1r2P93wrojwd2TFAI089NvN977
    McswUY7ipGO8_sQy3Y>
X-ME-Received: <xmr:hs49ZzCg-K-JkFxLnoeML0X1Z1-DQDuiG1WqszTPg91ybH1GOQHK620fI2oh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdeffecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:hs49Z5fA6t1LheRrUpB90eWvwt8RgUtTtmkT4tRONpBQGSUI5oNwPw>
    <xmx:hs49Z6Nucx_ZfYgxu1nYYWY3gMBamT7cwEMrTqElS9_tnxFw_prjtg>
    <xmx:hs49Z7kpt_LiirtzBcu5VQrTb-JXnm1wg8pZfD4DNZBj_90UO-vS5w>
    <xmx:hs49Z0uLoj5hRFI0XQWQ8ddx7bFK5KhJNtCgHVOMUm4A_uGAtXArJQ>
    <xmx:hs49Z7j0z2y8ebToUc98ly-j8ji8BIbBu9aC-7QejHGqWiFiwSCf11uO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 06:56:53 -0500 (EST)
Date: Wed, 20 Nov 2024 12:56:52 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
Message-ID: <Zz3OhFzo2ve6cKAr@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>

2024-10-29, 11:47:19 +0100, Antonio Quartulli wrote:
> +/**
> + * struct ovpn_peer - the main remote peer object
> + * @ovpn: main openvpn instance this peer belongs to
> + * @id: unique identifier
> + * @vpn_addrs: IP addresses assigned over the tunnel
> + * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
> + * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
> + * @dst_cache: cache for dst_entry used to send to peer
> + * @bind: remote peer binding
> + * @halt: true if ovpn_peer_mark_delete was called

nit: It's initialized to false in ovpn_peer_new, but then never set to
true nor read. Drop it?

> + * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
> + * @lock: protects binding to peer (bind)

nit: as well as the keepalive values that are introduced later?
(I guess the comment should be fixed up in patch 15 when the keepalive
mechanism is added)

-- 
Sabrina

