Return-Path: <linux-kselftest+bounces-29983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE419A77B54
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706D616BD7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 12:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B88202F9C;
	Tue,  1 Apr 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Lb3BdI4S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqVwJ0zg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255331EC01F;
	Tue,  1 Apr 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511901; cv=none; b=ILhCjHwedd8uGL9SCvxpcQrFs9Uiq8h76mnSD7wtrvpi6vqUHDGTmrOIS4l4BO9s+ZmLyJia4tj5VVUYEocO2ueSiNbIKoXcgZZMc6asSMfJC0VYbzMzXt0BmcGEq4L3kKAqAnsSEeZH4zBuzw6vJFuEf27flk43yaZ0i2Di1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511901; c=relaxed/simple;
	bh=DHOcwlcVKS72DNSBiJSZOaaJO9qOgf7Tm10Ulnaq2tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXLift/KJEws28Hta4ZYWs+NwDUJae/KOVe3g7Fd43lyutz9qFUPwgS91e5yuOSVhqlbXh+5+b2W4UpXerAhPKvqUE3ocBSTn3vmF6NuAXcxu/y09xxVjhzQkQlVbly0e/RydMsB8YErUG7ENjEWKQM1N8LqvDuJw+PaDeSYv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Lb3BdI4S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqVwJ0zg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D329C25400A0;
	Tue,  1 Apr 2025 08:51:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Apr 2025 08:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743511896; x=
	1743598296; bh=FcH0/cGkd+r0b1nlk9gurxdGutVFNxoiOGhv00cAXHQ=; b=L
	b3BdI4SRwv2AfKncl4vSeSJJhQBAbVTd++5aa64rOmzByrDSPOwxN/nOfd/VDRY8
	71dMzi2KEApzx0DCiA6BM1SPwercvapYwOh22CFz7CkGLJH5yZktTL7aVuKrmijM
	vZssfrtEPPpjtqy6vUHLCc9dRL2E3g0oJrTwAZ8k3yRE61XHHgi5kFQWj4J1NfTw
	mUbM+0/nM5D3zSTX/H75Gm34G1sEP0s3jvHz7YwcvB19KrcDEvJyA6sSUWEWMo3l
	YiwPNKsIOlmj8J5PBW62qMl1qCg1eQJJX8qu4fusZ+jiN62Yu7WlGBS7u9aFqq/J
	s7svqKY6lsWC/vPq+L50Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743511896; x=1743598296; bh=FcH0/cGkd+r0b1nlk9gurxdGutVFNxoiOGh
	v00cAXHQ=; b=BqVwJ0zgLMIlONK2a7B6kxRtNBBvvakMbp/BConZ2VglO3CXmjc
	V9fsx26eeXcv+iiL3TgxqDQkJ0hYN2ZVneZHH/DoVmOlsbtNaCtMUCYAcAgYBQEZ
	yOJTdT0bB9fIYa+U1hohAZn/ct2Dup+WgScJpr1JAZPRVIDgD9LD+2FJQMsloq5Z
	2mDhVo60tFx8xk/MVT5ETv8mglAkP/DiFdiUh7+6VVDvOMNokmt+4zGKjx8GNR7v
	GI50jPcm7oORzQ7nl6exrs4vRKqGYqDFZ9VxqiMr78/FjHyNkvqHbz4XQlt0+KXv
	9/IAkFW4q0yUQZOXrGboIoauAo3sId5ld/g==
X-ME-Sender: <xms:WOHrZ_VPOCBDgcyMaD0d3uwaw6VhCpmxljjYIXo3pds2WwqAcg_Y6A>
    <xme:WOHrZ3lFosNSBlRUCpIvz2y_24WBz6jGyA7BsTsmy93QqKqqvMHcsewH5RXAR8mfC
    RWinBY0o0wvwaK3sLA>
X-ME-Received: <xmr:WOHrZ7aibgcHhMQcL1FcVCWfiSJbw8ThFRyQjrvbRF5F-vjVcn0L4rHL0-QN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvkedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WOHrZ6U39qiz0OZGl73pb7TllO2LZupUkps0rFYbFMah_rBbE7C3cg>
    <xmx:WOHrZ5mzM8WzzRLrXTniJk7p2v1sxgg4Vs3UcT3jwGihOCd3HWxrOA>
    <xmx:WOHrZ3eKUSpK2WgbDpwQCjT7i65rjS8chqD_2dlGFtOBHRd3v6nqHA>
    <xmx:WOHrZzFwcJGhmwEbbzpXC0MAJ1jYIyayiH-PYYLmcA_ldnyheCHTIw>
    <xmx:WOHrZ7lTHlM8MXI8xYx1oGcR87drK-ZxWg_lcEenlF0PNWcUCQmOjOxF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 08:51:35 -0400 (EDT)
Date: Tue, 1 Apr 2025 14:51:33 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 16/23] ovpn: implement keepalive mechanism
Message-ID: <Z-vhVdMThx7NQgW0@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-16-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-ovpn-v24-16-3ec4ab5c4a77@openvpn.net>

2025-03-18, 02:40:51 +0100, Antonio Quartulli wrote:
> @@ -124,6 +154,13 @@ void ovpn_decrypt_post(void *data, int ret)
>  			goto drop;
>  		}
>  
> +		if (ovpn_is_keepalive(skb)) {
> +			net_dbg_ratelimited("%s: ping received from peer %u\n",
> +					    netdev_name(peer->ovpn->dev),
> +					    peer->id);
> +			goto drop_nocount;
> +		}
> +
>  		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
>  				     netdev_name(peer->ovpn->dev), peer->id);
>  		goto drop;
> @@ -149,6 +186,7 @@ void ovpn_decrypt_post(void *data, int ret)
>  drop:
>  	if (unlikely(skb))
>  		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +drop_nocount:
>  	if (likely(peer))
>  		ovpn_peer_put(peer);
>  	if (likely(ks))
>  	kfree_skb(skb);
>  }

Again a small thing: in the case of a keepalive message, it would also
be nice to use consume_skb instead of kfree_skb. Quoting from the doc
for consume_skb:

 *	Functions identically to kfree_skb, but kfree_skb assumes that the frame
 *	is being dropped after a failure and notes that



Something like this maybe (not compiled):

	/* skb is passed to upper layer - don't free it */
	skb = NULL;
drop:
	if (unlikely(skb))
		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
	kfree_skb(skb);
	skb = NULL;
drop_nocount:
	if (likely(peer))
		ovpn_peer_put(peer);
	if (likely(ks))
		ovpn_crypto_key_slot_put(ks);
	consume_skb(skb);



-- 
Sabrina

