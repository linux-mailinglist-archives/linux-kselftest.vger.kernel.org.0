Return-Path: <linux-kselftest+bounces-29218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3020A64FA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 13:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CC91887605
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 12:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20426224241;
	Mon, 17 Mar 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CZfoZPdL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="59jkkaMh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E661E51D;
	Mon, 17 Mar 2025 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215674; cv=none; b=Q4AtOKBiDrYHj+/78Jh2Kp/sSLWHF+pCPYlbScQS3apLHl1tc1Z76PVoBTwxWzrqcdap334qmcsj4wUiaIDfzHy2MeEY32Gcqd8kYznh3/TI0wHhdKH92jSSzJbvV/VyFtt+eCXIwE3S66p7ZTW6YljpHpizoXYOTTqXNGXbIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215674; c=relaxed/simple;
	bh=Ye5Gao2ubxI+kT38MqsJdM2eFmSxaCCF5YnrUkgWwwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6Qk89FgJgQdK97gqmM58BctbIXsRurJC1s6YuA/vmJCM99FJN9PhJzOh8S5/bykJZ8iiRclyF7tjIlK+StkublPQ7IAX4KOlrs8naqfW2+9opYR8CUbOfQ34SgDzJ5H8/E8M0fwa07x4ZFWROz9RIc9DrHsPDXTqSq7PS8Bih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CZfoZPdL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=59jkkaMh; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 39ECD11401AC;
	Mon, 17 Mar 2025 08:47:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 17 Mar 2025 08:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742215669; x=
	1742302069; bh=7689idzZmsV6rCPPWrq4dbeF4f2EAXHJXFHVxjUy7l0=; b=C
	ZfoZPdLOZn7vB7EkZsYEWiZEYd6H8ai2Aer2bruzHUvlramKZDuylJQzjZ45hQty
	zww1LtbK3Pu9bQ6kb0HFTN4xiHIjzOzRnRGJWp8nsZI3UCozaO2SXQuLm5d7FJi1
	zfwTr/iIVTPPSUR94IUGlDEyl/c+DFpwo7cm99LZURCSXCXAEHsKEMp8446DJL6d
	isD6agpykjr6grTnSl1pzgZvJCIiwo5he3WSyUaOj4B2orvdcd/9oz1JX/GGSE57
	VUzneaUkzAhjAUU5GPh/6jaeKdddKbU20pZaR1I8iuxJ+u12XclmaA4RZ6Eh3iI3
	7MuRRDEnhZm+MsJ51RVXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742215669; x=1742302069; bh=7689idzZmsV6rCPPWrq4dbeF4f2EAXHJXFH
	VxjUy7l0=; b=59jkkaMhASm5Rgf9v5kmdP3pD0iP2OtpAnIaQ5DshOtwr+B5KPN
	9nq9fom8FiSedksRMRwuO5yUXSHHXpxOiWWLDPlO0voxecyaEHD3e7UWSTQctqjL
	um8ic+nHqsFO32uYmGrhkvoh6G7E4xCONFNlS0nO4+NpYvHtOdm1ttL7pAS/DXsb
	VpYSk6JB/WDJZN7+s6IDoNbrx9G7tbP+Tal7S6PrWA4Sti612N++tVJkQna3/9Jm
	QtTUAPHMar6pye+I2ezqpbN7aRof+EgFoWscF0kpuBjvkRerKOJpt23KiWASbbr2
	8ZWqmcv3DyNzDCwxemA+SaA9bWwPvfD8vQg==
X-ME-Sender: <xms:9BnYZ3XlOgWppPvX6G-thwrWMhq6QysEDEK6UvDvTJc5HUbx1Riq4Q>
    <xme:9BnYZ_nsDGrfrsgm_Urj86ZRpcKQiBb304tsrJtCsB9UuBim0hgHfaEfok8PdYVHI
    iao3w3ziGHI6lZihnQ>
X-ME-Received: <xmr:9BnYZzb0VB81EbF12joiQlXubw73Z-rdctX8jEHwpNL04t1DszpD-9a2gsoH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:9BnYZyXrP-Wj9aJ_8V1IWWiKCloS0zrgVwFTn2kOLC8C3PUVDDPRIw>
    <xmx:9BnYZxkh2iHmNHxuaexFt9DfO8Nv3Cy-PNLfQYIlEu2hpeV16xZ1zQ>
    <xmx:9BnYZ_cpjxWk2vVUFXtSD_CGHtku8YxRZSzW843idKuDMAzPUxRsAA>
    <xmx:9BnYZ7FZ-iEWBW08wkJ_aO1GsSJo9kjccE5jpw9Sy0ZQTATt-CFjcw>
    <xmx:9RnYZzmf0eA5UKoAP4C6ZARdBF_T5zjpBFc79IPnFXznLLx-oclh2Ezv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 08:47:47 -0400 (EDT)
Date: Mon, 17 Mar 2025 13:47:46 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v23 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z9gZ8l9mrF75M-Ih@krikkit>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
 <20250312-b4-ovpn-v23-18-76066bc0a30c@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312-b4-ovpn-v23-18-76066bc0a30c@openvpn.net>

Hello,

A few comments since it seems you'll have to send one more version
(otherwise they could be fixed later).

2025-03-12, 21:54:27 +0100, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 8d267d4c82283d9b5f989478102086ce385195d5..407b5b908be431625a3c258e7887211ef0f4b197 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
[...]
> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
> +			       struct nlattr **attrs)
> +{
> +	struct sockaddr_storage ss = {};
> +	void *local_ip = NULL;
> +	u32 interv, timeout;
> +	bool rehash = false;
> +	int ret;
> +
> +	spin_lock_bh(&peer->lock);
> +
> +	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss)) {
> +		/* we carry the local IP in a generic container.
> +		 * ovpn_peer_reset_sockaddr() will properly interpret it
> +		 * based on ss.ss_family
> +		 */
> +		local_ip = ovpn_nl_attr_local_ip(attrs);
> +
> +		/* set peer sockaddr */
> +		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
> +		if (ret < 0) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "cannot set peer sockaddr: %d",
> +					       ret);
> +			goto err_unlock;
> +		}

Similar to the floating case, this should reset the peer dst_cache? In
both cases we're updating the remote peer's address and our local
address.


...
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 0d8b12fd5de4cd6fe15455b435c7d6807203a825..aead1d75400a604a320c886aed5308fb20475da3 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
...
> @@ -1335,8 +1356,11 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
>  		netdev_dbg(ovpn->dev,
>  			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
>  			   next_run, now, next_run - now);
> +		/* due to the waiting above, the next_run deadline may have
> +		 * passed: in this case we reschedule the worker immediately
> +		 */
>  		schedule_delayed_work(&ovpn->keepalive_work,
> -				      (next_run - now) * HZ);
> +				      (now - next_run) * HZ);

This whole hunk should be dropped, no? The comment is outdated, and
the sign swap is confusing me.

-- 
Sabrina

