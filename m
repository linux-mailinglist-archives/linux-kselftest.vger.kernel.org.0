Return-Path: <linux-kselftest+bounces-29979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC38A77861
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5878816A69D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCD71EF0BE;
	Tue,  1 Apr 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Qnit6ZkA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1bf62y+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA991EEA32;
	Tue,  1 Apr 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501741; cv=none; b=Ta7PxhFo9sPQmO41DVPTHL+NpQETg9c5lO9RzDRrMb5UMrS3m8EFSaVET9BrwJeCCsn+c8E+gl1hX1nFUdkretXOGjSMUmKs5Vgp0PvRGhd2K2ioZDQzll7ff1O57XndlyFtuFaphhGFTG/MMdv19I+kSZZOojy86tFJrlWn2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501741; c=relaxed/simple;
	bh=0G+OT2pQwUNKSHab5Fy4mnmlGrelRgXgUBd1aoOUvP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUeD7g/odjocHf0yMpRNKUo6hFLqAgIZ2NeesZOLF7IXFCo5OV5AZOU4VpzZ1DjTWscYfxAexcICgotfH0uyqPI0i2jU0qjT8drN+Ip5kssrnsGOCEZ+pENpszAFp/VFC6O7TFLyG0EWHwKykvwMKYVLkqHsTTkyfuaC4OFX6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Qnit6ZkA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1bf62y+; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9470254015C;
	Tue,  1 Apr 2025 06:02:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 01 Apr 2025 06:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743501738; x=
	1743588138; bh=naKOvTTnyh/Yn6zwyw/B/wVoUWu8X7hEjoOiqbRrAeY=; b=Q
	nit6ZkA8iHx7Mn48PHhyEvKdumdVge8QJmXbVOL4C5/+TF0cL/hEe+PI36qlQ3v0
	6MG7IL/rKBbp0ZaV1ulQhFJytOdQ5JZZ1Z9ZYoih8m109lhdfwIxjDT4uAnWqChU
	uH9GN08pwFTvE+FX3NOMdmQXz3WQ5c+w3G+uOhpjlVAo4Tdxeta799JvdCfRKoUX
	HwmWf/zOKOevymTamh3nHeVw+LZZ3D6jrGYMXuOITP4ZmWJk7n/LrKcJvyaoP5G/
	gKxQFuVoCzpZgveWkYKzsd+YlttnFwcEaPVTObH8i1Ipfa0rNieiKm9ReueLsljT
	3rjVrxTzoWxVyGyh7lPDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743501738; x=1743588138; bh=naKOvTTnyh/Yn6zwyw/B/wVoUWu8X7hEjoO
	iqbRrAeY=; b=I1bf62y+BB6FEA6WzhMAvqoEIWoC6bKTPgHfdNy9p4yvyM5ZnhP
	JjwNNSqto6qfIPbz4HfqfLI2sd8XLlo0oWh5UzQv2d00D9OFExCJamav1gwOieyJ
	+U4k1i7tzrIJX3lk3cXlA/W++Xx8xFqNpykI/PB6tnoTNvbCrSX93ZjI7rrg2uAt
	n5xW3tSa/U4jOP4gzu9PpubCHAx92GZXuwA7EkN+qwHy/n/73GUbOASgBUy4UL6x
	fnStn3zCFoKLiqosopfnlWwNdfCI1GpizdDqsHlaqvSZQjV/GnQBCSLJRZRtZCLh
	ZQFwoDsMvng4/ZWHi4wtwrrc4CPHqzJ5iHQ==
X-ME-Sender: <xms:qrnrZ5BRn5c6Nf6IGBbup6Gzu98wgU5FNNCwg3QQKRBoyZpYyd3wAw>
    <xme:qrnrZ3g20wqlTmIHjTB7kZBQ6K-roxoXNlNDETPZyZ0rK0lBtb0Y1xab-4LGgNtMF
    NXsRLf_y_o1PQLu-fo>
X-ME-Received: <xmr:qrnrZ0lZ3pwGYOZB3onQH8yOMEfAUt6Rja_iV-zVzJicIGLl1X_qer1KheTC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnth
    honhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnth
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:qrnrZzwGE3HVSm-s5eWnY69wBxKE8Bk0UpFfO_vVmJtOcJtR8UJNdg>
    <xmx:qrnrZ-RTR0BQAVYHsBPgYhx6G3YwxiIUuqCnqI8ZnCxFyJG78PGcIw>
    <xmx:qrnrZ2Ys1ALpmj9bojQqmbs_TgR2g9UiHc8h0h5Xq6oXyUu1vc60Ow>
    <xmx:qrnrZ_Qc4KhnYyJNbJS-5QqhGfiQfSsgbbyC4YlGzrdJL79luwoOmQ>
    <xmx:qrnrZ6pL-5RsRoLjbDzjG6MOgtWHQqodR5W1I8fpAJwM9-NnBBundA0h>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 06:02:17 -0400 (EDT)
Date: Tue, 1 Apr 2025 12:02:15 +0200
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
Subject: Re: [PATCH net-next v24 11/23] ovpn: implement TCP transport
Message-ID: <Z-u5p_QLkLKtcxsb@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-11-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-ovpn-v24-11-3ec4ab5c4a77@openvpn.net>

2025-03-18, 02:40:46 +0100, Antonio Quartulli wrote:
> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
> +{
[...]
> +	/* we need the first byte of data to be accessible

nit: and "first byte" here too (that comment could maybe just be dropped?)

> +	 * to extract the opcode and the key ID later on
> +	 */
> +	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
> +		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		goto err;
> +	}

-- 
Sabrina

