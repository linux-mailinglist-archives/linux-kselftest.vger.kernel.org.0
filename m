Return-Path: <linux-kselftest+bounces-25866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E8A29C1E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591B63A7791
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE0215067;
	Wed,  5 Feb 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="T1Us9Yk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/j+JXMQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCDF510;
	Wed,  5 Feb 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792218; cv=none; b=R3CqMAclvm2TJw3BlitlPCE47w3+t56vjfOVR4eeiF05gUp7cziYY6lcsrnoaVojI6lPBpvxHLK/W/crwSlF8y7mA/hGeaQL2CAJptH6X0nsjZ2Rc5SRt/7nOWOscApkN8WZxpuQ4m7XEgLPsSNIwDje2U8T9+CBI7Tiow4MUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792218; c=relaxed/simple;
	bh=VZeDDWElS97HftJUqI0ZV7tLfTYxf1l0eS3m7HaFToY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0RhmKEMdJ5epfXB1iQm6iBTavVOJweFeXnU4ZHiAnFCHdC30qZda/bp8chY7iHOh0kfPkFb5Jgm9lLM2qtuJ1UygkjFjY6A2y5e/YPYE8TMqanGEJI3s+Nq7IrNgiUzLeFdHv9KHr277lpHktVT7Iz7XNA5QP+ei1rT6fEyp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=T1Us9Yk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/j+JXMQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 32B1213801B0;
	Wed,  5 Feb 2025 16:50:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 16:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738792213; x=
	1738878613; bh=dPn7JSPXiqgSq7Z0EgBkucMtw2n7J3jmDFtkNsgBHQY=; b=T
	1Us9Yk7qBaMNBNqtEWnDx1fAoiVbkQg0Sr3/VAifh5QW4ruSq2o2NFM6y+NJ9p/h
	WVXWALuhd4z72hfCQT0OEEKUidWPsLyRDRILL//EFvmraF9l4V3KJKiRM2drHESs
	mGKeAfMGNr11F35lNkpFYVnTY3mT5sj3uP/ucN/lNMzD4ksT8Rwp98haePqHzrDm
	BQoLOZpGucLzzDWWRMCmEDlXMnECrubDSL3P+ahmYp7+Vx1BYJ4uz74qx7TTkPDT
	/S3hHFiL0LISAR1+iDB/PW4/hMmah8rT5LgPisRyOIZbXTu/fQzEXqFDCACs1D+t
	9aS8ZOx9liM95ZVKzp3+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738792213; x=1738878613; bh=dPn7JSPXiqgSq7Z0EgBkucMtw2n7J3jmDFt
	kNsgBHQY=; b=D/j+JXMQftftoZ647xleulPgDaCzNOStyuEUxGUk36Klyb/vqd0
	Ut6Jxr0L20+DYS5h4Z+KQIAvMKcNrdxDoaz2IYF6ebjVTqx/BoQyctGxmTp5p23j
	7uibMqbvblQ8ZYPALwHbMex4VP11xm8vpUKKMnw6cx8WtFsBDcDSzRP5j0TusHEO
	EjYS/e1W/k7/mlk22VFBWjg/vM0l3/wFOIGc6xGu3B8OrK0/fIAxvZHpYNt9G22t
	+KFoMZtuCdcYmkBpSGwRhgzolVTHMqPINazhT+K1YJIt17iHCrf61ffNdudbLXBY
	Yij779PND+Z7cYzkCu+yAK78JKot1eg2jxg==
X-ME-Sender: <xms:FN2jZ88iTlPQWcddEpMZn1rgmJXRCHWbFBO6Gvm0AP513rKEQY8qtQ>
    <xme:FN2jZ0voVIy4HCglPJ5QUGy2hm9y7dCnmZ3F3ywcjbGhPiCJ6hLB3I5luFLxzfpdu
    BMxDGYY8N36rtcOL6w>
X-ME-Received: <xmr:FN2jZyCiXi-4MC2o4zcmomeJRMFOCQxVKwkZcagomOPiNHtEo6NyFsveQ1tn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:FN2jZ8czV6t1zJaziXPuoZHv03Xl_YSAZXlv78R5sy8lRO_JqEz9BA>
    <xmx:FN2jZxOaXdbi32br8lRCivxfq0s5A2S6sRh-_98BWwQAShDc6Gd0eQ>
    <xmx:FN2jZ2lIsmKSDGCfRoHOSiWebZ3Cm9-z70evuF9pnOshIpaf_h-iNQ>
    <xmx:FN2jZzu8YHRg-PWvkQtPEXPRoljEC4mcZHMO5vUAWpOuCKfAPJw6Pw>
    <xmx:Fd2jZ3tE71NpQiJheY5hLBK3BHWbpQ1jt_eqbmO6h39bxrDEfA0cFHuF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 16:50:12 -0500 (EST)
Date: Wed, 5 Feb 2025 22:50:10 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 09/25] ovpn: implement packet processing
Message-ID: <Z6PdEurGNirlnkoM@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-9-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-9-1f00db9c2bd6@openvpn.net>

Hi Antonio,

Another one I should have spotted a long time ago :(

2025-01-13, 10:31:28 +0100, Antonio Quartulli wrote:
> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
> +		      struct sk_buff *skb)
> +{
> +	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
> +	struct aead_request *req;
> +	struct sk_buff *trailer;
> +	struct scatterlist *sg;
> +	u8 iv[OVPN_NONCE_SIZE];

You'll have to kmalloc this as well, it gets passed to the crypto API
and with async crypto, it'll be used after ovpn_aead_encrypt has
returned.

[...]
> +	/* setup async crypto operation */
> +	aead_request_set_tfm(req, ks->encrypt);
> +	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
> +	aead_request_set_crypt(req, sg, sg,
> +			       skb->len - ovpn_aead_encap_overhead(ks), iv);
                                                                        ^^
passed here


> +	aead_request_set_ad(req, OVPN_AAD_SIZE);
> +
> +	/* encrypt it */
> +	return crypto_aead_encrypt(req);
> +free_sg:
> +	kfree(ovpn_skb_cb(skb)->sg);
> +	ovpn_skb_cb(skb)->sg = NULL;
> +	return ret;
> +}
> +
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

And same here.

(maybe something for the todolist: ovpn could copy the alloc trick
from esp_alloc_tmp, like I did for macsec_alloc_req -- not required,
but could be nice to avoid many small allocs and all their failure
checks)

-- 
Sabrina

