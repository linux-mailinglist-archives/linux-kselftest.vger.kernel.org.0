Return-Path: <linux-kselftest+bounces-29978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB3A7784A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 11:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC0216B6C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514841EFFAD;
	Tue,  1 Apr 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VM9xcbZ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8GGpwHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8EDCA4B;
	Tue,  1 Apr 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501554; cv=none; b=Z3VUvBDQTdHcR4Mb4z7IYvj5dkrrBWoHTO/ryR44dRYU7+7fwzMPNbT3eDF4hXGP8JFMtyujBr/Vus+pveUbCY/TMOMr7qhiHlyVrqe0+iF1LmYNtClWMpnQ7nr5JUdGviKtyRHzW6nzrwBKk26Tl6ZydpT4DpeGg9f8Aioy4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501554; c=relaxed/simple;
	bh=Qqfak2UrvIEyXtb8So6PD7qTuEEQK52pCV08VP7kOFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjY8qCcYh9VThccTJTVQgBDnXdcFLHijMmlQv7GbFmY0AyJAGyY9bdhyA5SEH2NHXgMuUKeJbND1wv/Feq3iITWbllmEV1+Kfne0hVNupYBHb/Tb9oifMmVIK5rtKKE0m34qLYDKvtvHVluRGtq/xdMBE8sJLE67fRSLJtR8+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VM9xcbZ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8GGpwHF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B41525401C2;
	Tue,  1 Apr 2025 05:59:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 05:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743501550; x=
	1743587950; bh=Hz18F4NI0H8OQmza2BzZAHc1fArX+giecmzxAvAwMA8=; b=V
	M9xcbZ6e46z6mIVZrXVmA30AdQP18dsZGj6VYEFstIkdnSPYOdX+R+adP8bWMu3G
	IlGLvNW+0f7FhQdViHxgSNoRJ3nruyr2DgJU2BFRJNJs2MyNWbB26V1nZqHGbUuw
	NBsYGXhrCJbVZ0R29j8mNfIvB/aggafgZfdSvE2nKsAj3vo/j2GwO8EhtvfmGSRA
	uYW4gCseQyldE7gjPmOIU7J2s4un8LAfNaJTk86p07hiiBIIrQdwL5DIEK/L2CCh
	0ogbhtPwytEya5kCPXBSqExTeuYJNSLpSzBb9AhPMO825g9prrgLHiep52yV3CDl
	Q86ZGeUY3vdckoROZXRnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743501550; x=1743587950; bh=Hz18F4NI0H8OQmza2BzZAHc1fArX+giecmz
	xAvAwMA8=; b=A8GGpwHFGpXrFaqFqXdbpm7G+S5iJYlt5RjTiRHNuV2DfykZIRW
	9SdDQl9Tmiutqcmw0tuwb7L9+3y8TPO0MHf4XsC+KUJUxZ5iJE4iy1qVW3e3t+Vi
	ZrEs3NBhuvKOESQzmpy7OV0+YPgMtgieYcRStSWqI5YLPNA9OymDQjzRUQ/OwUKK
	Q8QBvojB1fKb0Y6+okfwV5UIMKWXCZudhXLQRhu+24cQgIzAL7fXCAw+GFxOt7rl
	6+AsSdRwlNndMLghkIEkQr34yzlJZjixtpJl94Zk1uLjoX3XcbtLzsejbYyfXcWE
	XKlcrA5DO1/mVGCJ4K0zLPXI10h/pnzIq6g==
X-ME-Sender: <xms:7bjrZ2lIyirOMToXYE1bnbJdlw3kgm78I4DJ9G4cUkW-kDe3A4GSdA>
    <xme:7bjrZ91G8Qt67hDsF8Wz6AN4VrFrLbPJavWG92EnfnDAmNm8g_-Jnyl2wIOY5D5U4
    lqanY8FHI7k7LBF3ws>
X-ME-Received: <xmr:7bjrZ0oSgsxHAXtxxgCwSbZGVcWZ21Uc8KQHCIi3nfoAfuPCPpfXiLFe_d_5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvhedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7bjrZ6mx6zwRUQDHyHNIPsuse5RRaevYRt4W8QV9c1FjVEbMXQalyA>
    <xmx:7bjrZ00_CESBraqMgkBxNvOdhEfpLL01cTGRu_m4VD114bnIXk4o5A>
    <xmx:7bjrZxu-RAIpwx0ZxWo-Ko1eB0G_J6HEUoSnZjBcYAj-erhb4AiacQ>
    <xmx:7bjrZwXFkteSWDEO6F2dmeUMlYXfXdBC6rIvHnh4-ipK60RYPUIvyw>
    <xmx:7rjrZ_0ChUTFZYO_riZ4ZDJw_fEc61lsVCmX7WWJoUp7wTGqzH65TLgn>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 05:59:09 -0400 (EDT)
Date: Tue, 1 Apr 2025 11:59:07 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
Message-ID: <Z-u46_82tkR8TsOa@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>

2025-03-18, 02:40:44 +0100, Antonio Quartulli wrote:
> +/* this swap is not atomic, but there will be a very short time frame where the
> + * old_secondary key won't be available. This should not be a big deal as most
> + * likely both peers are already using the new primary at this point.
> + */

This is not the case anymore.

> +void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
> +{
> +	const struct ovpn_crypto_key_slot *old_primary, *old_secondary;
> +	u8 idx;
> +
> +	spin_lock_bh(&cs->lock);
> +	idx = cs->primary_idx;
> +	old_primary = rcu_dereference_protected(cs->slots[idx],
> +						lockdep_is_held(&cs->lock));
> +	old_secondary = rcu_dereference_protected(cs->slots[!idx],
> +						  lockdep_is_held(&cs->lock));
> +	/* perform real swap by switching the index of the primary key */
> +	WRITE_ONCE(cs->primary_idx, !cs->primary_idx);
> +
> +	pr_debug("key swapped: (old primary) %d <-> (new primary) %d\n",
> +		 old_primary ? old_primary->key_id : -1,
> +		 old_secondary ? old_secondary->key_id : -1);
> +
> +	spin_unlock_bh(&cs->lock);
> +}

[...]
> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
> +		      struct sk_buff *skb)
> +{
[...]
> +	/* encrypt it */
> +	return crypto_aead_encrypt(req);
> +free_iv:
> +	kfree(ovpn_skb_cb(skb)->iv);
> +	ovpn_skb_cb(skb)->iv = NULL;
> +free_sg:
> +	kfree(ovpn_skb_cb(skb)->sg);
> +	ovpn_skb_cb(skb)->sg = NULL;

nit: Those shouldn't really be needed, since we'll call
ovpn_encrypt_post that will take care of iv/sg/req. But it's fine if
you leave them.

(same thing on the decrypt side)

> +	return ret;
> +}


[...]
> +/**
> + * ovpn_key_id_from_skb - extract key ID from the skb head
> + * @skb: the packet to extract the key ID code from
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first byte.

nit: another "first byte" that I missed previously :(

> + *
> + * Return: the key ID
> + */
> +static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
> +{
> +	u32 opcode = be32_to_cpu(*(__be32 *)skb->data);
> +
> +	return FIELD_GET(OVPN_OPCODE_KEYID_MASK, opcode);
> +}

-- 
Sabrina

