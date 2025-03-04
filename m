Return-Path: <linux-kselftest+bounces-28238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA83A4EC99
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 20:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5DD188FCDC
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85132512FB;
	Tue,  4 Mar 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lHabd9vs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ev+jCEBw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4924EABA;
	Tue,  4 Mar 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114946; cv=none; b=p4LDFqCnIw1Bj2I9IcDuoeRAwX3BH+XjXDzQBybDvgJ8jfcw6bCjNKws0W2pXhGHnmEuVgYp/2cZP58fSiFczyv9wgTZlYEKZgSoJ41IfQ6PmBPW3uOvOWsvL9AUyFPDfHtyFxHBYVEIVVUUzw4pe+fDSJKUEAXQhiP3rUvdR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114946; c=relaxed/simple;
	bh=oeO3k+fQ2uc2xW3PAoVoZusaYb/VRHAyBWTKFEnt+OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRSGT5oL5sB2CNhYJo9iuFlg1LIUYVDybs/VidzSmBUHpsFXyHeAmOyY04/bRof3XPkfWkdSg2cPjtCd28Ukc0EJ6ZQfGMdkgPGPXHzw99AjKMON184eg9KAsLdX6PP6+NfVX4hzyzYopjEFAEEm05h1NKvgPVyXIPzQnUsC4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lHabd9vs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ev+jCEBw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 294C61140109;
	Tue,  4 Mar 2025 14:02:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Mar 2025 14:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741114942; x=
	1741201342; bh=Pgi+DunqwLwq74Jly3YwOvG4Ta4hOiz0xroRVd15Urw=; b=l
	Habd9vs30fdL28oTItRbA1XW+04wrHPY5ODRttgyEguacL3rY/m+PJS+sEbwU233
	BmqT6V8s4lQa8kNge/9sGtF5D7dnNi2cBFAWNLFDNKdZW0GE4/macfFpiaTBd3kR
	m8cC98Lp6mJI2907ZezUlvLGsEr64b7j2aJoQBcIHv5HjriqJkBY259yw4VrY7IA
	qMycTjQIVNntwRVftQTX/vk+a80/0zqz95iMtL48C/D+e0cTW8c+F2+p8i7PsNev
	oFzu+u6rmgRex+JDBuWQAynOsN/uFB21ZGIDh5LEle873yrTNFcvExg/IE//mffE
	NoCvEDi7btr1jEsbz4Z+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741114942; x=1741201342; bh=Pgi+DunqwLwq74Jly3YwOvG4Ta4hOiz0xro
	RVd15Urw=; b=Ev+jCEBwgjl+CCT5iDqMekTBNCU2vL9lY5sYtgpide4sM81W/C2
	PKXxDqa7n7NfdSjuF/wcKHL0pSJTAbCsbggHy4G7BsZv3J97QfY9wzbXOQgd9U/h
	AJy6WZJzMEmwrRBAt7x+uehZDsPX87DfLdlO1t/v+msZ1ijaNiof7S6GlAOnV0oQ
	kbE2AbEOKNzNIiqOfVwOF7ynglupW33s+SP6l5u9YYcK/gxy3OwwMvyLpIEB9LeW
	3E9+HcMLCO/YvFzSSAHWe3XdcK5aoZaOHfwptvLku/USF9zExk2b/9DqtXqeMW6O
	ffJW2JyXTynfTyFiSmR/1QMvoBnWWRthPuw==
X-ME-Sender: <xms:PU7HZ5YJaYoe3gBUiQdMtZcL_S6evoKtVMTWuwWHHU5YeORy_N4fBg>
    <xme:PU7HZwb1k3_T_U657_1x1p1uIO3jMzzSao1wnpWGuPq9UzeaPMtdDllWu6VWS8j77
    x0TNFwF8RDqlpLD9Y0>
X-ME-Received: <xmr:PU7HZ78PC01jiQHPUtrAFZmiTb83BAwkRqA84QWLADDTOsCXnBy8fDwTAvKz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvkeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PU7HZ3q60ijFSyPaYi875yQA9SYT06ZrmrAYtnVXUQL68g_0y2bIoA>
    <xmx:PU7HZ0rG_qUw2z0DBkJzZ5BM2pME_11XtYPZHfex2tqLuQrVJGQWeQ>
    <xmx:PU7HZ9SFvwxCDmVEKjsZBn3bBnBBY7O9tT4DT0qIsX1ygk8uRR3kCw>
    <xmx:PU7HZ8oE1ilRcAHF2QGVk_qNg9JJdf2ZhITX2riumaUzfezeucodng>
    <xmx:Pk7HZx4ileAH-OCVIQb-UsPWKcNc6GMp4HwKKCsZ29BOdn4DiYjRa1dJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 14:02:20 -0500 (EST)
Date: Tue, 4 Mar 2025 20:02:19 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH v21 09/24] ovpn: implement packet processing
Message-ID: <Z8dOOy9tSpJ1UCiR@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-9-d3cbb74bb581@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-b4-ovpn-tmp-v21-9-d3cbb74bb581@openvpn.net>

2025-03-04, 01:33:39 +0100, Antonio Quartulli wrote:
> +struct crypto_aead *ovpn_aead_init(const char *title, const char *alg_name,
> +				   const unsigned char *key,
> +				   unsigned int keylen)

nit: static? I don't see it used outside this file.


[...]
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

I'd go with slots[0] and slots[1], since it doesn't really matter
whether we check the primary or secondary first. It would avoid a
possible reload of cs->primary_idx (which might be updated
concurrently by a key swap and cause us to look into the same slot
twice) -- a READ_ONCE would also prevent that.

> +	ks = rcu_dereference(cs->slots[idx]);
> +	if (ks && ks->key_id == key_id) {
> +		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
> +			ks = NULL;
> +		goto out;
> +	}
> +
> +	ks = rcu_dereference(cs->slots[!idx]);
> +	if (ks && ks->key_id == key_id) {
> +		if (unlikely(!ovpn_crypto_key_slot_hold(ks)))
> +			ks = NULL;
> +		goto out;
> +	}
> +
> +	/* when both key slots are occupied but no matching key ID is found, ks
> +	 * has to be reset to NULL to avoid carrying a stale pointer
> +	 */
> +	ks = NULL;
> +out:
> +	rcu_read_unlock();
> +
> +	return ks;
> +}

-- 
Sabrina

