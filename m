Return-Path: <linux-kselftest+bounces-28301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74EA4FB5E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7113A4A7F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5C205AAC;
	Wed,  5 Mar 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="f4PMkdPd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+pTjfBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC71E2847;
	Wed,  5 Mar 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169506; cv=none; b=PxDWLI/TFcky9lRNyLB4AUFFZXKTXUNAVx45EVl0W9ZqEERr7gWykTNGbx3kzl1F4NvMUXmBrwhuUbmrVCxpR7ATVrjJ1T5OwUqgLML5HZnLqxbdGXJDpk1kK2ELCs4dPwYfgc+lwn/evBmYpEJLT3u8vUXpgfRGtHvVURW9j3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169506; c=relaxed/simple;
	bh=u8nSbs0xTwX5BtGNGGk1U4xJg451vP+0nM368luQfKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj/HLeiRDTNYJ7HnIHyXj6pFMbsVN1cMsneRTCIHmGPlIBaTJoUX78nYwy0c9EKYM7XTKDsU9mmHwP0kB7vOA8vz2eg3O+iA6UiFoyB4a+Ormrse4eFCbtTbKMQ09g/i3KMbzbEBmhjhQzKbCWGs+7PLkh0Vhi/DjIpshXNGf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=f4PMkdPd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+pTjfBM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ABD2011400C7;
	Wed,  5 Mar 2025 05:11:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Mar 2025 05:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741169503; x=
	1741255903; bh=FgqevE7dp9jIfFGQb8KyY7Usp35oeBUE8Vi5Z6q1pgo=; b=f
	4PMkdPdzhOAgVvNaujf/h2UbyV/FUe0m26HKbbJl0/sQYut7W1336g8bsGMM6UbS
	LGQOowu62xtfd7P1aNtmKsR4G7PMHr9p/7lbQxUxouzQt7UtARkWx5dGK5xsjsMO
	Q0/iDzlkMTqdQX1G4/jIWmxxJb7D2mJTRfPPcG7uN3P6Bwew7sxtI3tZnUOGc0MC
	7TKX9ZKMjZBFYUfyhF9Qc2Pg4dPqYudHS2MYjWxd+f5DcJjWj0wjACUqU8k0nJFT
	vOZDquu+pbrKYmrnmSlLeMob2DT7clhOj8dIfREzVY6SFKJYPuHwLqnj55Zq8WsU
	+q/ykWUEl7pj25bLW0+gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741169503; x=1741255903; bh=FgqevE7dp9jIfFGQb8KyY7Usp35oeBUE8Vi
	5Z6q1pgo=; b=W+pTjfBMAKYVc5L3Ldg6L+dO1hz2jiJ/AZWtyPf9BJHRWNDdkIm
	5E+svGGsu0CdiU2OSYVeMBHWvGl6C6Sq9aeFsYVHLLmZ7oyXJF7Ocdaw3SKkeIM3
	oa0x+42YCpA61Bg+j/ItbjuN+Brrz0YrcehV3JYwOK36jpPMJIMEjCGAtDZPsvpq
	suLw1AiaNua7nVzVy8osPm6BRcfti/cqf46w6heqfJnMC3SjebG/O/mfA4ZJ/WLM
	hY3ZU5R6XIxtrbpwT0qhopsHfq1+VObXNLLzYYknpHePAd9luRrA7EX+eoTM7yiR
	lZ9qKhoJozyo9wbTsNjCsbLOlG5g7wwAzdQ==
X-ME-Sender: <xms:XyPIZ-m5w2fvBjED8u53ZLNp-yxFM5lfPSP_Nuh9uIAB8k7ikIq0-g>
    <xme:XyPIZ12aH8BJIAKCBSbS1TMM_mmD3axiaYG9UdPrRVJUGPLnTVdo02J4LJTz6U_a0
    Yc0F5v5Fzmk_-fy0bo>
X-ME-Received: <xmr:XyPIZ8qfQB1PHBpRr9PMQvOYGihyBbOGsECUwMkc6kyoWP2o6Q4E_ohvvuyJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgefhffdtvedugfekffejvdeiieel
    hfetffeffefghedvvefhjeejvdekfeelgefgnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    ugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvght
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhihrgiirghnoh
    hvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggv
    vheslhhunhhnrdgthh
X-ME-Proxy: <xmx:XyPIZynxLkMwU1dS3B3gmluF7RqutfIl5jCYp0RrBR1x7m6hISL4QQ>
    <xmx:XyPIZ81It-Om4u5CkzG0BdXTKUlku7sSKcocsG7yXMXm0flW67P2sQ>
    <xmx:XyPIZ5vJVAS0zyQppNYiSCfRVbkxT74JW-hz9C2d8lNyi7QM-Nyltg>
    <xmx:XyPIZ4WqvLyEr6N5ubGlWp_GA70lVuB6lHKoYGHdw6b2-tMDbItinA>
    <xmx:XyPIZ32a6YS_g4zYcQrOEzp-A-FWLjUNpRMSLH4ACUe-ECxL99PgSUUW>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 05:11:42 -0500 (EST)
Date: Wed, 5 Mar 2025 11:11:40 +0100
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
Message-ID: <Z8gjXLepPcRByLTZ@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-20-d3cbb74bb581@openvpn.net>
 <Z8braoc3yeBY7lcE@hog>
 <07c73e1d-3c9c-46c7-92cd-28d728929d18@openvpn.net>
 <Z8eIJH1LtTtfljSj@hog>
 <71c1db26-f147-4578-89ae-c5b95da0ec9a@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71c1db26-f147-4578-89ae-c5b95da0ec9a@openvpn.net>

2025-03-05, 02:00:21 +0100, Antonio Quartulli wrote:
> On 05/03/2025 00:09, Sabrina Dubroca wrote:
> > 2025-03-04, 13:11:28 +0100, Antonio Quartulli wrote:
> > > On 04/03/2025 13:00, Sabrina Dubroca wrote:
> > > > 2025-03-04, 01:33:50 +0100, Antonio Quartulli wrote:
> > > > >    int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
> > > > >    {
> > > > ...
> > > > > +	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
> > > > > +	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
> > > > > +	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
> > > > 
> > > > 
> > > > [...]
> > > > > +static int ovpn_nl_send_key(struct sk_buff *skb, const struct genl_info *info,
> > > > > +			    u32 peer_id, enum ovpn_key_slot slot,
> > > > > +			    const struct ovpn_key_config *keyconf)
> > > > > +{
> > > > ...
> > > > > +	if (nla_put_u32(skb, OVPN_A_KEYCONF_SLOT, slot) ||
> > > > > +	    nla_put_u32(skb, OVPN_A_KEYCONF_KEY_ID, keyconf->key_id) ||
> > > > > +	    nla_put_u32(skb, OVPN_A_KEYCONF_CIPHER_ALG, keyconf->cipher_alg))
> > > > 
> > > > That's a bit inconsistent. nla_put_u32 matches the generated policy,
> > > > but the nla_get_u{8,16} don't (and nla_get_u16 also doesn't match "u8
> > > > key_id" it's getting stored into).
> > > > 
> > > > [also kind of curious that the policy/spec uses U32 with max values of 1/2/7]
> > > 
> > >  From https://www.kernel.org/doc/html/next/userspace-api/netlink/specs.html#fix-width-integer-types
> > > 
> > > "Note that types smaller than 32 bit should be avoided as using them does
> > > not save any memory in Netlink messages (due to alignment)."
> > > 
> > > Hence I went for u32 attributes, although values stored into them are much
> > > smaller.
> > 
> > Right.
> 
> What's wrong with key_id being u8 tough?

Nothing. It would make a little bit more sense to use nla_get_u16 if
key_id was u16 (even with OVPN_A_KEYCONF_KEY_ID defined as U32), or to
use nla_get_u8 for u8, but here it was just 3 different int sizes and
that triggered my "uh? what?" :)

> I am a bit reluctant to change all key_id fields/variables to u32, just
> because the netlink APIs prefers using u32 instead of u8.
> 
> Keeping variables/fields u8 allows to understand what values we're going to
> store internally.

Sure.

> And thanks to the netlink policy we know that no larger value will be
> attempted to be saved, even if the field is actually u32.

Yes.

-- 
Sabrina

