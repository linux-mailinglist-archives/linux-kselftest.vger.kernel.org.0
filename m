Return-Path: <linux-kselftest+bounces-25553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DABFCA255AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC4E3A14FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03741FE46B;
	Mon,  3 Feb 2025 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Vd9frdIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PwVTjJiB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC635966;
	Mon,  3 Feb 2025 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574440; cv=none; b=sMRsBSfdw24NmRNm1uXF31zkoe1p9JdCknpxoN9Y9AGoLAQgGKHrOCZs1ZRRscrjGsESms7Sk/tH0rFJuvfNUPNj7npSFDUWNyBWNv0kPIU7TmD1DLjQHXl1fdC4EQ6IdnPJ3YoS+mKjvcauFspnINNWmeiPrDaEjADEMnBYBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574440; c=relaxed/simple;
	bh=eH8RTlzzHp4UeP8KiQIoY8gIaSQQAs8szmF27FWar1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im5urJQGPGBkkh2GicJuWFjFq2aCuxPhakddrf7rA+nATCWLZHlb1z/6ds02w76uRXX+LWSuT2kiwsBgzUOQtog8K8/is2nD4FWB1Z7Se1KQznGZpIak+XrzqApRq4H2RyW3mQmacfep/bwufX7UYRuBXVtadejmexaBtZv3MIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Vd9frdIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PwVTjJiB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B06D91140172;
	Mon,  3 Feb 2025 04:20:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 03 Feb 2025 04:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1738574435; x=
	1738660835; bh=YlFWSO22bl8+fawPp6D8ReMiTZsYoX3fNRXYOkRD+pw=; b=V
	d9frdImBGEGNN6HH2PlR+iCuevMDIBikfhw4bmf75WnKy+9Z7tbZ04hBVaY84Riu
	Uph5qGx28t6hoVT2oryTI6NtMqQFvOA5bj/JLb1rAcQc5zQOAyrEVvokxYQDr/Dw
	a/nYrtj4RdP+MaBKefxEADAAC9qLBIs9u9z5dBzOssEZVm/4wx78C5ZyyDySmVCf
	A54zf6kamdGTQUDGTdzcwon1px8SPICo7zl5N88vDdyoliIxObIsTx+E4s9p8Y1M
	BAy/4Y8FzMug6ogRBbATemrBr6F6RtzxRGFIDt+ahEbLLhzB7vl1OrdDWiqB8lJ0
	rzCPNVlU30vqYC+MuUNIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738574435; x=1738660835; bh=YlFWSO22bl8+fawPp6D8ReMiTZsYoX3fNRX
	YOkRD+pw=; b=PwVTjJiBiXi7CTfXdINoIOd4rhsNSaUgd+VjZnANQkP6MtjXRyr
	MWWOcx2YT9Fky0JpKDlM860arvHGo0ayBJjIAz9Zc3NWPFSjl6ufOfk1LBI7YSmr
	5967oyQBaT5sp/ajyfZHt9LtTx/4QJz07YUrnJyPICKBbqsmmAruGqkoIXhSeVqe
	qAr1FN0GH7Fmb+Wahw4JXkz2cKNWuHvjHYR/xdLrLaVmc1jat4vzFLwSTkppUrDA
	SzsVF3kb3Eo4cfcKfeJZiqcy6QXNLoecHHeLyAjO9VhtwkxrGJpeQxuXAAov0Q4w
	KLxsSOUEs430dKjjqWUkXXIngioMAARNmiw==
X-ME-Sender: <xms:Y4qgZ0xiJL2pHo30aU6RUjj96V8IbO1-CPZliu8s8dvhxsZC-h01YA>
    <xme:Y4qgZ4Q-1AYIZ9q984zLi_ufHU2-Lgro1CHVvu8nVEZmCcozYj-6OdJCUhH-UlNvU
    wxIusuFsIqOg3gVm00>
X-ME-Received: <xmr:Y4qgZ2WOmal_QazD6njrFgBxcz4JVy5tGdq87D4aek7nC0ZcGIdmy5kC0CyD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Y4qgZyjLT0xB8dfB7DdEccyatt-wj7AG_zD9tkqFXRWPtF0vQeJhEw>
    <xmx:Y4qgZ2A0o2M6tB16kz4-wmyPDnvjYK6heajikhBXcCrCKanJv9nFsA>
    <xmx:Y4qgZzIp8hawpGgAcneq0QdkIRG64HRxGPX5sqISHEnFa5O-C5De6w>
    <xmx:Y4qgZ9AH1B5tJ8pteapfOqSz4_CyrR1_kG92cTppsJnmeFl4xC0PXQ>
    <xmx:Y4qgZyxPWjB6oEh6m5Rxs1fM623tW9bSHiMHva57f12qoQFffNCkjBK0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 04:20:34 -0500 (EST)
Date: Mon, 3 Feb 2025 10:20:32 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 17/25] ovpn: implement keepalive mechanism
Message-ID: <Z6CKYA8ueI-ZGybN@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-17-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-17-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:36 +0100, Antonio Quartulli wrote:
> +void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
> +		       const unsigned int len)
> +{
> +	struct ovpn_priv *ovpn;
> +	struct sk_buff *skb;
> +
> +	ovpn = peer->ovpn;
> +	if (unlikely(!ovpn))
> +		return;
> +
> +	skb = alloc_skb(256 + len, GFP_ATOMIC);
> +	if (unlikely(!skb))
> +		return;
> +
> +	skb_reserve(skb, 128);
> +	skb->priority = TC_PRIO_BESTEFFORT;
> +	__skb_put_data(skb, data, len);
> +
> +	/* increase reference counter when passing peer to sending queue */
> +	if (!ovpn_peer_hold(peer)) {
> +		netdev_dbg(ovpn->dev,
> +			   "cannot hold peer reference for sending special packet\n");
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	ovpn_send(ovpn, skb, peer);
> +}

[...]
> +static void ovpn_peer_keepalive_send(struct work_struct *work)
> +{
> +	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
> +					      keepalive_work);
> +
> +	local_bh_disable();
> +	ovpn_xmit_special(peer, ovpn_keepalive_message,
> +			  sizeof(ovpn_keepalive_message));
> +	local_bh_enable();
> +	ovpn_peer_put(peer);

nit: could we simply drop this put and the hold in ovpn_xmit_special?
ovpn_peer_keepalive_send has a reference on the peer from the WQ, just
transfer it to ovpn_xmit_special and then ovpn_send. No need to
pretend to acquire one for ovpn_send's sake and drop the one we got
from the WQ? (ovpn_xmit_special would need to _put(peer) in case of
early return)

> +}

-- 
Sabrina

