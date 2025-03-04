Return-Path: <linux-kselftest+bounces-28201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1ACA4DD5E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 13:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383B5177427
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 12:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4D202C48;
	Tue,  4 Mar 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TRq7FFwn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQjeh8ZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC1202C40;
	Tue,  4 Mar 2025 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089649; cv=none; b=a8U7gM3y5mIiMWuPPwXamgyUhbVYnF8InQXdYWu/YtlwR1ycEIfuxNgXhnB3xuBAUEcYbmY6ndpaZIgnHQT7cE5HQ1pvEQlUS20cVEucEYHtz9RLnz0+H1KUh9eKxponet0TpA4fHUdzgvsbDqEVzU29sGChB3CwclzRFcAQlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089649; c=relaxed/simple;
	bh=llzvKCGJNXnxmJEoqeRL2gqLJuprf35ORc99c8kkCVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwDAkJXsoZTIvYjKSJXPouUfRR0oWD5SUmWjq7E5g7tvPTtifHDzA4qfjkOFGG6UhHvcUiCG+HeslFPYDpg3Uh05oNiMNf2WpIOdCdRbGwP8Meoq+rtfFU1/MEDQSq9S+lbOuyKo40GwmwE/uYzhvs6chgj/Tzn2K6/8RPxFWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TRq7FFwn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQjeh8ZA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDD731140223;
	Tue,  4 Mar 2025 07:00:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 07:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741089644; x=
	1741176044; bh=uIiaTK+BiKB8xl9aYkMLVI+7Bb2XzXCNKJ0MtNy8+xc=; b=T
	Rq7FFwn0tjeqvPJXVToq0krNscd+7Pqg7/Z1pSkJacvdXDlQSmloA2GYCQrT7aV5
	Lv6tOyLRzMzJM0HnzOG31jgjxtjtXalRFJ3tMIhkxaD/lNGABcOJjPv/hQWAF771
	kP2Tq8zV9xJHwZ4kjMQhh0ZFc5nFm49bYISxuHF4R419wYJK5MfdzhpaZdQW94f1
	Pe+ytFzjnPbYU4BErmpMbSHXnYq37NApCaWB4ghwahPM6T0+Y1ZXeZSSxOlj2eFj
	Bac/A+3sz11lTwyw/ASGv+rOLHZuk4/dPDhl0JuVSw3YgiAEOkSLpBIAMLakiS8k
	PuhRf6HxibJT4puIgD/Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741089644; x=1741176044; bh=uIiaTK+BiKB8xl9aYkMLVI+7Bb2XzXCNKJ0
	MtNy8+xc=; b=SQjeh8ZA/fuP84rWIG4fVWw21Orc9eeiSdC+1TcJOaP/GwwLkv8
	wlLmMtm17BBGFwo90VzcOlhYEYUYAMZQcsU6xO4SOhQKOmQBddGl2QBx06zuxL7o
	rtF8ZUaerOB7LxZ6MtIErpsiPIBPOpabF7COocR6o9TW2IcyA5MCfpUBRqw8gC69
	GZZjCGCMTzP3YZNpVgqfjDFqbvCW1kaAqQKijIZmUejmUDVN2jWuTeC2u8MdSwZs
	kXuwRee6QMI05cfxlTMhZjW25ddzVODYlbAswTnEvhtv84Edw0Lb/3OU1YvNpIvc
	cMj7wVRvA683rqfo9aGsAcZtC8ArAxgTFQA==
X-ME-Sender: <xms:bOvGZ58ceUWGQvEBj9siiUDVi2hhV88YKvswfjVIUndu3D0yRL2HeA>
    <xme:bOvGZ9sl0vALrmx6uWrhisvC2aCe4dG0gWnoCP1XJHY3l__IgHdMxfwjPrg-4BRx3
    bNeKzEWAYG8uvkBQ24>
X-ME-Received: <xmr:bOvGZ3A4wR6uiJg4CFjAPyHBqb8M8nCFav_34PlFHqbG6uWNGjQw5t9p19-P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduleekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:bOvGZ9cTHR1uzoFISZDtd1gg9PRMs5FE-PYBfv_55hRT0Lkd_Fpq3w>
    <xmx:bOvGZ-NgrH3k6H8BF5hv9qw2RgFI5ZoaYYiDDPmv2odt9kq8wXXcPA>
    <xmx:bOvGZ_nOmw2zZzm3MGXqPM0tVYkUitd_ECG-83PMS0LSRe4h0Am1kQ>
    <xmx:bOvGZ4tndPVZk8yknlu0hoKSx-Xunmyr9-6gZWyRQCSQXe3kiJOLFw>
    <xmx:bOvGZ1kjv23uJ3slutM5OiUjnjLf7KcG2Mc8HeigCrNy1H9zEg4L4mq6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 07:00:43 -0500 (EST)
Date: Tue, 4 Mar 2025 13:00:42 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH v21 20/24] ovpn: implement key add/get/del/swap via
 netlink
Message-ID: <Z8braoc3yeBY7lcE@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-20-d3cbb74bb581@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-b4-ovpn-tmp-v21-20-d3cbb74bb581@openvpn.net>

2025-03-04, 01:33:50 +0100, Antonio Quartulli wrote:
>  int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
>  {
...
> +	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
> +	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
> +	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);


[...]
> +static int ovpn_nl_send_key(struct sk_buff *skb, const struct genl_info *info,
> +			    u32 peer_id, enum ovpn_key_slot slot,
> +			    const struct ovpn_key_config *keyconf)
> +{
...
> +	if (nla_put_u32(skb, OVPN_A_KEYCONF_SLOT, slot) ||
> +	    nla_put_u32(skb, OVPN_A_KEYCONF_KEY_ID, keyconf->key_id) ||
> +	    nla_put_u32(skb, OVPN_A_KEYCONF_CIPHER_ALG, keyconf->cipher_alg))

That's a bit inconsistent. nla_put_u32 matches the generated policy,
but the nla_get_u{8,16} don't (and nla_get_u16 also doesn't match "u8
key_id" it's getting stored into).

[also kind of curious that the policy/spec uses U32 with max values of 1/2/7]



>  int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
>  {
...
> +	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);



>  int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
>  {
...
> +	slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);



A few more inconsistencies:

* OVPN_A_IFNAME is defined in the uapi but never used (I guess
  leftover from genl link creation)

* OVPN_A_PEER_DEL_REASON (u32 vs u8)
drivers/net/ovpn/netlink-gen.c:52:      [OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 4),
drivers/net/ovpn/netlink.c:1131:        if (nla_put_u8(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))

* OVPN_A_PEER_LINK_TX_PACKETS/OVPN_A_PEER_LINK_RX_PACKETS (uint vs u32):
drivers/net/ovpn/netlink-gen.c-57-      [OVPN_A_PEER_LINK_RX_BYTES] = { .type = NLA_UINT, },
drivers/net/ovpn/netlink-gen.c-58-      [OVPN_A_PEER_LINK_TX_BYTES] = { .type = NLA_UINT, },
drivers/net/ovpn/netlink-gen.c-59-      [OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_U32, },
drivers/net/ovpn/netlink-gen.c:60:      [OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_U32, },
--
drivers/net/ovpn/netlink.c-618-     /* link RX stats */
drivers/net/ovpn/netlink.c-619-     nla_put_uint(skb, OVPN_A_PEER_LINK_RX_BYTES,
drivers/net/ovpn/netlink.c-620-                  atomic64_read(&peer->link_stats.rx.bytes)) ||
drivers/net/ovpn/netlink.c-621-     nla_put_uint(skb, OVPN_A_PEER_LINK_RX_PACKETS,
drivers/net/ovpn/netlink.c-622-                  atomic64_read(&peer->link_stats.rx.packets)) ||
drivers/net/ovpn/netlink.c-623-     /* link TX stats */
drivers/net/ovpn/netlink.c-624-     nla_put_uint(skb, OVPN_A_PEER_LINK_TX_BYTES,
drivers/net/ovpn/netlink.c-625-                  atomic64_read(&peer->link_stats.tx.bytes)) ||
drivers/net/ovpn/netlink.c:626:     nla_put_uint(skb, OVPN_A_PEER_LINK_TX_PACKETS,
drivers/net/ovpn/netlink.c-627-                  atomic64_read(&peer->link_stats.tx.packets)))

I guess all the stats should be UINT.

-- 
Sabrina

