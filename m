Return-Path: <linux-kselftest+bounces-29632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C1A6D89D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 11:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158E17A20AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB925D91D;
	Mon, 24 Mar 2025 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="cs1RwFin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xNZUBPh0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3525D1F7;
	Mon, 24 Mar 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813330; cv=none; b=lYnAs2h35lHarKAiqFC/wKSw2SxCAIkk3x9b/AtiLPF9lZ3Uyc2/2mS8yZup8xb7b6G9bRHOxUGruBLevEpSYHe2Bresgc6t4CLspEOEwsONo534vZGu+6ye4MiUnor/W+YAZkG4N99gU5YUGU8lsw7SwRY2eLIWdBZi17o8fdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813330; c=relaxed/simple;
	bh=k7s/4dYnuB5Y9hvO3sDnwXmjAY9995T1s1leSSrjA5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtY/NTLLcev+rF4nBC37gRixl7zFOJOg0ydKXt6ZSKqADZ5bIM3xIh4p/ueJZhFY069Uj/mdTCiiXdXSgiOFZUDDCoqOo972g7Gs7JC+Uie9cn5R1xxhDVktdAxEEXDA/npQnd51ccsM8qyxf/ctyr1WxQftm6k+JZOLN/5J4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cs1RwFin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xNZUBPh0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CF9B513833B1;
	Mon, 24 Mar 2025 06:48:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 24 Mar 2025 06:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742813326; x=
	1742899726; bh=MFtiNuutFA7OlS1WlGis14BsYkU3TAQKcH5X747aQmo=; b=c
	s1RwFinAT2iu7PwAhfVY+OuLXjqUpIH5aimfFJrTExyqaZw/7LLh2PtuLeJHfW/y
	azU/c4EO+Ir5fLunUSZiNWCO++RCrcXOlxFtXymFkk/iu4C2nmEuZjD2K946/pWn
	28ul64Rnh7wnyYbF8T/Q+BEYQSCQJBZhdmJanZ2p9dQRprylnDJBc3/6h9+82zGM
	0q9g3Ofg7gIne79DhAcbcZeJt1vDaB6MI9fPCLZPbdWV5/PDL1KVa7wULxNl9ak+
	jwdT96drtWgAg/Mz4L5+DLYxTE32scWgKPuhk6wyG+4U1kkhEaN1qMg/5QgJnlTC
	h0QKuOuzqaMGAHhEzf/Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742813326; x=1742899726; bh=MFtiNuutFA7OlS1WlGis14BsYkU3TAQKcH5
	X747aQmo=; b=xNZUBPh0qchAWcqdPcpKjh4VeotHPD/sXoiQuH7YldRQ7Gwyx6Q
	lyzVUPpl13k+At8Ms77LyGe06Fzrlam8Uudva8sF0W1jEQsKD+SVTKUnQjZdhR2g
	oqQ2e/PyLYuVh2/eHmVcvVPby0XHYqZUMfUHBzO8VgK3BiwNNYJGZMiLSjNH7ye4
	O+WVOCp1GaABH5ZxzScBK3X1yMnLErvqpmRczunFVH+vLkOedN80DOOVhnYHnRww
	7lmq0DD0F4BxWHqflfLVbJdqYHTlkbUA1FsIBWz9bQNxTG1WDeDQPhuYy3ggEtEe
	2bT01DfQAJqxqG97yrvZ67dPUBYx4QN8qhA==
X-ME-Sender: <xms:jjjhZ8eDtWwZo5xm0UTKnRUiydGnWNqc2Bj3ymPrL_4f49_blUN_kA>
    <xme:jjjhZ-MBGLPrLti63E-3QNWyg5mjRKNr4C2oM1XSL39gOQIlnPFiY4PGf8BBwiv7m
    s2TtT6UTL6vJQwXXSA>
X-ME-Received: <xmr:jjjhZ9gXj2E0DcjBE5PLmhbt_jJF5iwBwoV5Hv_p04dEu44yV-DtkZEy0l4V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnth
    honhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnth
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:jjjhZx-jXKl0aDe2zysK7k8NILGv4jAuZ7QUJCAvxQPLmoPNhUNnBg>
    <xmx:jjjhZ4sS19X0nW7u2m6Rvr8AJyf-GDG_hXEVNJDSttT9X4PEaGHPmA>
    <xmx:jjjhZ4FjRmpqTcXqvZjaPzGdBo45t5E5po2Ow6QmXA-wLljdh29X_A>
    <xmx:jjjhZ3PV54hW2U25fzD_7BXJopMd9UOzYTn5lqPzvIshhCwiBLPIxA>
    <xmx:jjjhZ1M3OiMFxfmODOmhhtkZO_Rh6zwqvX2D3B_nCacv5WkC8za9ezgd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 06:48:45 -0400 (EDT)
Date: Mon, 24 Mar 2025 11:48:43 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z-E4i587M54Os5Yo@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-18-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-ovpn-v24-18-3ec4ab5c4a77@openvpn.net>

Hello Antonio,

A few questions wrt the API:

2025-03-18, 02:40:53 +0100, Antonio Quartulli wrote:
> +static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
> +					 struct sockaddr_storage *ss)
> +{
> +	struct sockaddr_in6 *sin6;
> +	struct sockaddr_in *sin;
> +	struct in6_addr *in6;
> +	__be16 port = 0;
> +	__be32 *in;
> +
> +	ss->ss_family = AF_UNSPEC;
> +
> +	if (attrs[OVPN_A_PEER_REMOTE_PORT])
> +		port = nla_get_be16(attrs[OVPN_A_PEER_REMOTE_PORT]);

What's the expected behavior if REMOTE_PORT isn't provided? We'll send
packets do port 0 (which I'm guessing will get dropped on the other
side) until we get a message from the peer and float sets the correct
port/address?


> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
> +			       struct nlattr **attrs)
> +{
[...]
> +	/* when setting the keepalive, both parameters have to be configured */
> +	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
> +	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
> +		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
> +		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
> +		ovpn_peer_keepalive_set(peer, interv, timeout);

Should we interpret OVPN_A_PEER_KEEPALIVE_INTERVAL = 0 &&
OVPN_A_PEER_KEEPALIVE_TIMEOUT == 0 as "disable keepalive/timeout" on
an active peer?  And maybe "one set to 0, the other set to some
non-zero value" as invalid?  Setting either value to 0 doesn't seem
very useful (timeout = 0 will probably kill the peer immediately, and
I suspect interval = 0 would be quite spammy).

-- 
Sabrina

