Return-Path: <linux-kselftest+bounces-23420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF99F33DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 15:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2805F1889AE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9914D2E628;
	Mon, 16 Dec 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ok6tCfPp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8wjjAlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC35A7B8;
	Mon, 16 Dec 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361120; cv=none; b=BU/L26lD3tBykVOxFMr5SHzwAxPXS5tKuzeifZEJFF/PN7K2+0pvHV7/HtSwhWCSwAm7xc/1kUAuks6jsJaRhKqKCSJz5Oymqw1MDwO8GkluhZ7RInNbpogPbExsi4qfAm+KiHLghilKX7NXuGs4Yf6Jo0vDDmp0LC9GP2GBjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361120; c=relaxed/simple;
	bh=nlf0Yxx6UKvn6nqsgP+w5Iqpx0SjIQugHe3KgYtgA4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1qTq2KG346E6NazA1IEPV2wsHJ9eb3XAz2XTyT0n5gx77n5yhorbnm6yle8kx8JkjkGBkMr7OdCgLVwTWHWSjB6zw3FhV3f/O3yu69VYICZTVAH+ArXlwnb3fAFgBDFJL6qifrvJfGduNssojnB8VwGX14OtImPIX1E91RSX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ok6tCfPp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8wjjAlx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9673E114010F;
	Mon, 16 Dec 2024 09:58:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Dec 2024 09:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734361115; x=
	1734447515; bh=4XBq1mDxi4SzfyCw4lX9Mf93iiY2ozvFddpAqp2jBbI=; b=o
	k6tCfPpSyBuTLktjGCYrQRJ33/Y/XVp4LE3CCECtGCy6l1wjV2omsWAmIDEplrB5
	jD8SRZAV9F0ZQzauG6Kt8N8HW/ceFgYBgkMob/gOlsOtz2OKOI1r/ypmvsSSNKZj
	p5Sjd0J3szY7Ti86BbOaxci9rnl6kHAUhyOcpCuyZmqaeoJDzdIrSZkSxQTrSY8a
	VsCYo05pp7B5XXjtsFjDTFYXoxlJ6Iz74eCo3mCqNk7w8xVwCHvsQjXJCJmr66fG
	kiQrfQ6pwW8sonTpLOp9oVPEraEM4DTpm6jNTBn0HJFIq5jND2LzFJ+o8O3COT8X
	nGttWaURPcbExRqJ7wotQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734361115; x=1734447515; bh=4XBq1mDxi4SzfyCw4lX9Mf93iiY2ozvFddp
	Aqp2jBbI=; b=C8wjjAlxif49JI+JhLz1wv0qjYaK1qSjvfb8JTp1pAd2+A6Gcan
	I+bZPysIaWZTnS603Z7wxwOyIrTVS0dY5yJmtZLgRKECNNcd+g1TH41XFs4LFCxV
	bwz9hAEOWYr4b+TdJyySnQ/YosluHGPbGv4E5T9hnXATfODNvdvFsGbUrqIWHMip
	YDdGAJ9xRdTKsuP86i8hP6eDbr3SOboVRyWshfNcucz5Hsg3jHuOfa0R4eUTUhXF
	VyF/S8Sg4R6OSiqtTkY/7c8Rq7d+mLLjs3iixdePcli7RkrKEegg4IQDRkUrRzNb
	7gIoE7sWByL3iDmyTig8X8xAMqnhGLhcKYQ==
X-ME-Sender: <xms:GkBgZ4VrCg3dcohlirDETmkXNKx_OW78OOvR19qK--DIYJMbF5e3wQ>
    <xme:GkBgZ8lhm6ZsL5CYplEYlhvi9VDeW0VdaOEN8-TDPZmA1gH-0jALSILaK_lZ8Scgm
    GzBKBkjHziEjc3lqpk>
X-ME-Received: <xmr:GkBgZ8aQr_T8lAGtx4Rwd8TbhcaylKKBM8OKj_65ATTDpR49SPJknPeKIswN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:GkBgZ3X0PVoI_t3tK6BIujJsa1Q9LlyLlx0tAHxrEuoFMsaQUrnyhw>
    <xmx:GkBgZyn4ISTQxv5EteUGO_Qh4JV9NQ0ev-iSucareyFPwIrPKXIdXA>
    <xmx:GkBgZ8cbHrywgPoI-f9_wUssqu-R6bOn39750nrG-1iAK7OibpXmIg>
    <xmx:GkBgZ0Ev2MVFBa2FwF1BYaK2Me71DtmrPc_ru2wUeMIUEH66iFh5Cw>
    <xmx:G0BgZ4khlVxkMABGmB0LZSGMij5t7y7N0YsJa1oLI9GHSNqXJ9aiehke>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 09:58:34 -0500 (EST)
Date: Mon, 16 Dec 2024 15:58:32 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v15 09/22] ovpn: implement packet processing
Message-ID: <Z2BAGHX2Dd8Gjagz@hog>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-9-314e2cad0618@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-b4-ovpn-v15-9-314e2cad0618@openvpn.net>

(just a few nits here)

2024-12-11, 22:15:13 +0100, Antonio Quartulli wrote:
> +static inline struct ovpn_crypto_key_slot *
> +ovpn_crypto_key_id_to_slot(const struct ovpn_crypto_state *cs, u8 key_id)
> +{
> +	struct ovpn_crypto_key_slot *ks;
> +	u8 idx;
> +
> +	if (unlikely(!cs))
> +		return NULL;
> +
> +	rcu_read_lock();
> +	idx = cs->primary_idx;
> +	ks = rcu_dereference(cs->slots[idx]);
> +	if (ks && ks->key_id == key_id) {
> +		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
> +			ks = NULL;
> +		goto out;
> +	}
> +
> +	ks = rcu_dereference(cs->slots[idx ^ 1]);

nit: for consistency with the other uses of the secondary slot, I'd
switch that to cs->slots[!idx]

[...]
> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
> +		      struct sk_buff *skb)
> +{
[...]
> +	/* add packet op as head of additional data */
> +	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->id);
> +	__skb_push(skb, OVPN_OPCODE_SIZE);
> +	BUILD_BUG_ON(sizeof(op) != OVPN_OPCODE_SIZE);
> +	*((__force __be32 *)skb->data) = htonl(op);
> +
> +	/* AEAD Additional data */
> +	sg_set_buf(sg, skb->data, OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE);

You could add

#define OVPN_AAD_SIZE (OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE)

and then use it in a few places in ovpn_aead_encrypt and
ovpn_aead_decrypt.


[...]
> +int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
> +		      struct sk_buff *skb)
> +{
> +	const unsigned int tag_size = crypto_aead_authsize(ks->decrypt);
> +	int ret, payload_len, nfrags;
> +	unsigned int payload_offset;
> +	struct aead_request *req;
> +	struct sk_buff *trailer;
> +	struct scatterlist *sg;
> +	u8 iv[OVPN_NONCE_SIZE];
> +	unsigned int sg_len;
> +
> +	payload_offset = OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE + tag_size;

OVPN_AAD_SIZE + tag_size


[...]
> +	sg_init_table(sg, nfrags + 2);
> +
> +	/* packet op is head of additional data */
> +	sg_len = OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE;

This variable can probably be dropped if you add OVPN_AAD_SIZE.

[...]
> +	/* setup async crypto operation */
> +	aead_request_set_tfm(req, ks->decrypt);
> +	aead_request_set_callback(req, 0, ovpn_decrypt_post, skb);
> +	aead_request_set_crypt(req, sg, sg, payload_len + tag_size, iv);
> +
> +	aead_request_set_ad(req, OVPN_NONCE_WIRE_SIZE + OVPN_OPCODE_SIZE);

and this op is flipped but it's still OVPN_AAD_SIZE.

> +
> +	/* decrypt it */
> +	return crypto_aead_decrypt(req);
> +free_sg:
> +	kfree(ovpn_skb_cb(skb)->sg);
> +	ovpn_skb_cb(skb)->sg = NULL;
> +	return ret;
> +}
> +

[...]
> @@ -80,7 +83,10 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
>   */
>  static void ovpn_peer_release(struct ovpn_peer *peer)
>  {
> +	ovpn_crypto_state_release(&peer->crypto);
> +	spin_lock_bh(&peer->lock);
>  	ovpn_bind_reset(peer, NULL);

At this point in the series, ovpn_bind_reset also tries to take
peer->lock (gets fixed in the "peer floating" patch).

(but if you're tired of moving chunks around, I can live with it)

> +	spin_unlock_bh(&peer->lock);
>  	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
>  	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>  }

-- 
Sabrina

