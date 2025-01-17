Return-Path: <linux-kselftest+bounces-24718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35CAA14F10
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 13:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2031677E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CC1FDE37;
	Fri, 17 Jan 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="eqJfxF7q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cSt8qx6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A71FC0EC;
	Fri, 17 Jan 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116217; cv=none; b=p8R8Sa6YcyXLMyOWqMX/WtD+5nWJxh2VlPTPSVhRyzYK7Suqd5JUztkOHL1pVAvl83WuwOYm2xHuGo0hxBTuhCFCjEWDFAxxMnq2GdeEXPS1x31CCecedFrlulhISjIpRYKvo4Nx0CzyrS7qDYhD3h5uVHykY5pPzg70cYeDHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116217; c=relaxed/simple;
	bh=kTV/v+V/cycXsCi3SiMzEUMn87AolYcVMl4Tzpz9Y1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocm31nDK3tzFGwwyry6Q/udHMW5Q+NF3zHameXtB4Xv5cG67ieT1MWR73zd48CMOFHPtGiCioov15ntDvLQl1hpQLomgTqFzqISAthDUqiyGt39eKpeVj3KqpbL797J/H88bCJCxWkQJ8bimxThlBmbpMLqAl6yqn2OKMrPyNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=eqJfxF7q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cSt8qx6k; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BDFE3114017D;
	Fri, 17 Jan 2025 07:16:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 17 Jan 2025 07:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1737116212; x=
	1737202612; bh=CyahNqnw/YyFCY6Rx2T0hKkQbVlMcU0W2AtHSdPDGSs=; b=e
	qJfxF7qNSzZ+MlWPVOvsHfOUucrFvwkdjlWt5oHbtjUWQ/g0ZpmnF7WMToyhcuXA
	W4wXc589vLdn5fxejMC5ENjCB6AiT5Ui1UmBPtry2jy1VM/ZxnNRnY8wh89TPtos
	4+QA+A0SdWIT+k+F9Zynd4rVhglsG7pAXBCumU6CYCYFmb7eoOgR6JUL7aQ9OUpW
	lOV6oDyw14G/GSWHDu5RY1B4nXMeeyjgrhkPcdBz6qsjjj7A/RQB51XNrfxbPsco
	K3LW3gDEgCTPtShqi0lF5SH464S75R9ZTLUoIGliVuMKDfHSfLXlYMrt0Vz91gBF
	dILuYsQDasQ5aehmEXWKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737116212; x=1737202612; bh=CyahNqnw/YyFCY6Rx2T0hKkQbVlMcU0W2At
	HSdPDGSs=; b=cSt8qx6k8dqxV7fIbGO/ZS2Q35Lx6BLpO5Dj5TfTl+kZ7rf31ak
	+pmHN1pXrXfysdw9OAPnHqO35PLjutfM9ReEnQH8WReONn0Zn7Md1qRkxLgPdU5/
	rh80XlkdC8BbzIz5FJRBuIjlK3k7OMpZYtqp9XoCR2kAaUWg1HstPeVyy0tQV50l
	KsZ4oSHPN/PQ8wSLYgSsSjCC7gp7n8bFt6gnzR8Hp+/9JcXY8E4eyw5hifGL4iLE
	2QnfXE3z4DhD6PCCSRMWtQdFswhOHS/fx9qdgN91UxyVgBpwcvanS3M9pypyGh93
	8pf/JRJgAuVuAe/o3W+jgPyzRMI+ajcB8xA==
X-ME-Sender: <xms:NEqKZ6aBN9PksvNWf2M6Gj8Y0CDHR3fPwDzvHMmtQyTq3--7KFbLTA>
    <xme:NEqKZ9ZzG45tr_P3aWUE8HgH_IS0mXglVyVb5Km7wjqCCQ6cJkNFhw0uINcsWA5ZM
    QeYGm4Nnbx7yNiRT_A>
X-ME-Received: <xmr:NEqKZ0_uaoA8iQiiLmzeP52Zs1Qq3xefduxDNHEaUKt2B4T74P4lbK8D7g3->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtth
    hopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:NEqKZ8rdWTcyM2u9FzPpll0WXjT0qswkdODhLevH1xR32lvpDf5tWg>
    <xmx:NEqKZ1qvAi2CA363jqVQOMCAK2xPPfJE5p8LMgXH4XOP7oGOmLT7Yw>
    <xmx:NEqKZ6Qhjsd6Yo6SuRfcIeXTfKmgnR1Abu_QmOVeF7QZi5IKTLQb6w>
    <xmx:NEqKZ1o8i1fhh3FBCk5cx18ZeztxvOVITdwv4AVbaTTC7Ta3qAdi4Q>
    <xmx:NEqKZ27eu2CHW-z8LYIa9X8gxfxxG4kGmJBt8p91DUqjPIL_y-yTLkAK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 07:16:51 -0500 (EST)
Date: Fri, 17 Jan 2025 13:16:50 +0100
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
Message-ID: <Z4pKMkDrujMWMlCW@hog>
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

2025-01-13, 10:31:28 +0100, Antonio Quartulli wrote:
>  static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>  {
> -	ovpn_skb_cb(skb)->peer = peer;
> +	struct ovpn_crypto_key_slot *ks;
> +
> +	if (unlikely(skb->ip_summed == CHECKSUM_PARTIAL &&
> +		     skb_checksum_help(skb))) {
> +		net_warn_ratelimited("%s: cannot compute checksum for outgoing packet for peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		return false;
> +	}
> +
> +	/* get primary key to be used for encrypting data */
> +	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
> +	if (unlikely(!ks))
> +		return false;
>  
>  	/* take a reference to the peer because the crypto code may run async.
>  	 * ovpn_encrypt_post() will release it upon completion
> @@ -118,7 +244,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)

Adding in the few lines that got snipped:

	/* take a reference to the peer because the crypto code may run async.
	 * ovpn_encrypt_post() will release it upon completion
	 */
	if (unlikely(!ovpn_peer_hold(peer))) {
		DEBUG_NET_WARN_ON_ONCE(1);
		return false;
	}

This should never happen, but just in case, we'd want
ovpn_crypto_key_slot_put() here.

>  		return false;
>  	}

-- 
Sabrina

