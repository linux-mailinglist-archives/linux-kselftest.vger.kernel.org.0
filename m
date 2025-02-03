Return-Path: <linux-kselftest+bounces-25554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29065A255DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31313A8B3D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA611FF5EF;
	Mon,  3 Feb 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="T/3RFYO7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LqRJ97VC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA11FBEB9;
	Mon,  3 Feb 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575007; cv=none; b=TxBBQvCs71aQJeLzAr//xKq1y0vFmrscuIPjZmJzIYwtW7wach2EdrIIEmENKFeiPSFj6mQgXGdik9xrokmXHa/LRXcV57dS7P/JhyhoANs3Utcs6rSa8KSgzGbmVaot4PWuRqXZGbbyjUR5OVVCnWN0F/3pceOZ3bmF7jrfXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575007; c=relaxed/simple;
	bh=MFhOnjLBXPAwreWqtPn9AaCb1UTrwDZV2mnF/c2eUeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxrXLMaCBCrpX/SA/VZJJbjEPiE+D2pa46qCy99gR0IFM3+ewPaGxfussrzntZkRbu9vK3s4wnVIgh40Wvjug6Ecp/qDwR1bprrgYcffQEwrAorf39qbqqISRQAlJt4FX66tPAC3xciSAuSTfUKluxSDVG5ISJx6keSJ5RkS2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=T/3RFYO7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LqRJ97VC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3AE21140173;
	Mon,  3 Feb 2025 04:30:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 03 Feb 2025 04:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738575003; x=
	1738661403; bh=Iu0c4P+pd0rwbChSBCxBM/nO9XHU1xVgF+psuWmP558=; b=T
	/3RFYO7IzYIHRUsMkuttG7bza5Qd+HCi7z18653rI/QttfeSvgeAJ/cCsuWar4JQ
	yM/kE9O+bWoxuwneDYNN2PP4hqvpLBmkFlZ+XO3XiOo1HrtT+9Ebg3q3GlTjZyjC
	cXmbBCZsaQWQ4ajM8qOe8MDFaXADR3SSe2uZisq/Y3Wp5FLnUwD5WDx7fuKNr36l
	gckyJbBlCoMLKrIy9nkGzDfx/1z2skfW73pqhOd1GU0lDe+MFwdHqP2nOhO+Rso/
	NXZYKbcATGh6DE5sFQZge7eba7LsxGov0xpfd1lK3CCv1Lq3nII0eAYvwtfdZHRh
	esnQInAcmOgUi34xvAOCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738575003; x=1738661403; bh=Iu0c4P+pd0rwbChSBCxBM/nO9XHU1xVgF+p
	suWmP558=; b=LqRJ97VC9vUj/TdgDan1lt0TeuwVUuAVfmHCWczCC6XzaWkv51l
	teByD8Q9fhuW1/3gTiisLvfiPxJlIYcJ+9Mvib0FAn0I+BWgoIExMEqwWcBuoK0N
	p8tKOQE6sDbmeVzlutWY5mvRrIToBuOE5VcQBO2XozXKxRk0LppuEyH6foizU1eQ
	Pf6p7OP0RaOOaTr3qvwQCmDQ74M3M8xH4NhVs6TRCIN6BfHB1irFiV8MCZ3ed4uP
	FPzEod73/Rz/wSTTb+m+7dVl8Iek+47Gutep2IaAQFfWE4Ejru1j9C4T2lUSlpWg
	suAFpxxxTPcgBGb3MoeTQ2OE+Kf0YwNQ7sw==
X-ME-Sender: <xms:m4ygZzrfF2r8ZqmcYKHpMLon5-acHFLOdJtrJNndVsxqAz3B3slbLw>
    <xme:m4ygZ9pDJvw_plz2q4f7OcJg6SK-tPB37EulnuhisYS8bM5cOrSqb6_Bkov4KqjAk
    B1sO0VYDFYhv01a-Nw>
X-ME-Received: <xmr:m4ygZwMYmU3KomBMVBMydMWeDbKIf2NuGwwTT_RpsZQzrtRyzkRBG-16leWC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:m4ygZ25XaZdSACzb_Ie_LdK4x_8hWek7mXwBOV8VR_MNvhx_Z_V3Kg>
    <xmx:m4ygZy7SElYzTtKhsHiFFQBJaS-7zedRNMEN6_5gvobjCYH-nkXQHw>
    <xmx:m4ygZ-htJ7bWx8LtFiqBl5N9C8xCiVJOnq5b8lPoqfrkOGvPJtQ4Jw>
    <xmx:m4ygZ07NBfCCDEEXGpoMqeSo2JUUZJUsaCLdWfqtZd1f71KD8L8Kvw>
    <xmx:m4ygZ1KPAmQusdby0fIoJiAM3MQVsfSmHc0zFkyMxY8UIIWpQymgBCE5>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 04:30:02 -0500 (EST)
Date: Mon, 3 Feb 2025 10:30:00 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 08/25] ovpn: implement basic RX path (UDP)
Message-ID: <Z6CMmJyJwZBuV-lC@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-8-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-8-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:27 +0100, Antonio Quartulli wrote:
> +/**
> + * ovpn_opcode_from_skb - extract OP code from skb at specified offset
> + * @skb: the packet to extract the OP code from
> + * @offset: the offset in the data buffer where the OP code is located
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first byte.

nit:
                   "first byte"

> + *
> + * Return: the OP code
> + */
> +static inline u8 ovpn_opcode_from_skb(const struct sk_buff *skb, u16 offset)
> +{
> +	u32 opcode = be32_to_cpu(*(__be32 *)(skb->data + offset));

vs 4 bytes actually read?

Also for ovpn_key_id_from_skb introduced in another patch. I guess
that's a consequence of switching to those FIELD macros.


> +/**
> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
> + * @sk: socket over which the packet was received
> + * @skb: the received packet
> + *
> + * If the first byte of the payload is DATA_V2, the packet is further processed,
> + * otherwise it is forwarded to the UDP stack for delivery to user space.

nit: not consistent with the implementation in the case of DATA_V1 packets

> + * Return:
> + *  0 if skb was consumed or dropped
> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
> + */
> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
> +{
[...]
> +	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
> +	if (unlikely(opcode != OVPN_DATA_V2)) {
> +		/* DATA_V1 is not supported */
> +		if (opcode == OVPN_DATA_V1)
> +			goto drop;

-- 
Sabrina

