Return-Path: <linux-kselftest+bounces-28249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D7A4F13E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C436D1889D7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 23:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6825DD1C;
	Tue,  4 Mar 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="jozOdXtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="33arta1Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A61FFC75;
	Tue,  4 Mar 2025 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129772; cv=none; b=MU68Xm3PVLxiImp9giWKBpeGqbXbCxU0CAdssHRxw8V7QcynX6Qr2J47ajGrELVMthxQIPZXl+uuAH5dosCWYNAO2Ljau9/TAslo6KDVv/GiuOYuY2bGP4CdNIZaHiDmD8aiygjoAYhh3gHXKrxqr5OYzdykuTUOq41YMgaypT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129772; c=relaxed/simple;
	bh=q40/rgSvCjoosg2U1Wkr/p76YD3osU7sXdgPHcq2Ijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTTmkCrVJ6gUceB1ii3cGw/rc0NVlXc0ZbEIU7l0FRCfvAZJ3KHGfv+O88pvKVgOtTM5D+9Sbwl5ISpr4JMovZas4sP73a+ugzDkVlbIQD9op9Wz0tNwHjLq1HDwIj/udcUMTNoS44AvytsK0rIq/mMqagpD8L+bn1fcNDUk8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=jozOdXtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=33arta1Y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id A07761381125;
	Tue,  4 Mar 2025 18:09:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Tue, 04 Mar 2025 18:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741129767; x=
	1741216167; bh=wtdm/fUGVEjzzSbcrQ7Os+OPL1GEYeRAyGx41pPtUaE=; b=j
	ozOdXtZcW2LEBD/ETQv9TiBxVFJC78nybIvLKwV3qUPqf9AEiOF4/vS3bzS/a4FG
	JztRDZ2n1aAG2itI5V0THI/Pqb+yTShUQOcqA9GkPjD6eVOm/IYY51UxW8NaO9yh
	cCqcjDde/DsOBoCaOPwAVDCa+pYMs21P0UMh84bbncEuzkMRPxFz1yaKYBqAwtYJ
	HnpWh4lDATSPm030NptKj8DZLhRiEBOSTxzIRu1lFzmWDyGDJ+uZPJwYzi8/wpIi
	c1a4B8bCCfUCQUtlEJdD5R+FLhJFMiDKFQRn4WxAHef5QTaa/dxQZ2H5MaHXa3CL
	YMlOAEOsW+PYSDoj+5U3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741129767; x=1741216167; bh=wtdm/fUGVEjzzSbcrQ7Os+OPL1GEYeRAyGx
	41pPtUaE=; b=33arta1YQ0MUx4XwM4dhmgQZ2RPs2ZIvTbCTKG4ZulQ6e9B8vYO
	j6Jy3bIQ6B1d+V0hcca1HBvpWDqdD+lKFPj9dOQ0yTZC47j25ojSl3gNgSiezYCS
	qpfJi6/Oz0KtJfCnX1IdGUv28AhIqs22wy3OlvccC2Q/MDZU8RkXN5RSyA9R632j
	e+BCSafgB5BHoEzDxa3iz095dOplcBjbGc3PaPFuL2NMtvn0BYGrPPyrWzo4Bnvu
	oyPTv3fCWhWk+yoP/EncRHGkNtRMFrgtdxGeuITgA+FciRKY9QIlXDV8oFJdqQff
	UdjpPVL6gcFMxM5HrVBg4nBoCBoGxbJkKzQ==
X-ME-Sender: <xms:J4jHZ73quXoYZ1RSAqlY2jJfMxb2rLJ0L4SjtrF2HKtU1_p5c-bKAg>
    <xme:J4jHZ6HcQN7WJxE6E_0IU6DVZXl9zqKFjErbCbRWGPJorblyXHpLThctOh8388ZRb
    3NifRikRPz-2O7nJLI>
X-ME-Received: <xmr:J4jHZ77uouHQTcb-LulzFsiG7V9CVm7s8JhxIUqTsMd-K1tuh4iIy79bZpOZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefvdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:J4jHZw3H6ZTdQvU68R9X9SFVMtSWdipP1yBx_rgphdBwWKASIwN3Cw>
    <xmx:J4jHZ-Eyn3IFjUcz3yQIhyRJL2KzNZnGSe7x9uk2o231N-02BzD4ZA>
    <xmx:J4jHZx9s0VvmNqABwYlIM85AKYyfU0nPVdXkjaCiMGpVEivVduHOGQ>
    <xmx:J4jHZ7l0gECFvfqAqcBVwHKsWhZW1F4Q4-nHXE2WtL_6n8zEby0Hzw>
    <xmx:J4jHZ7cKwY8mFvU0FUyprS7vpOzCkBcbC94291Px1ZhsOstAmGoKoKLn>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 18:09:26 -0500 (EST)
Date: Wed, 5 Mar 2025 00:09:24 +0100
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
Message-ID: <Z8eIJH1LtTtfljSj@hog>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-20-d3cbb74bb581@openvpn.net>
 <Z8braoc3yeBY7lcE@hog>
 <07c73e1d-3c9c-46c7-92cd-28d728929d18@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07c73e1d-3c9c-46c7-92cd-28d728929d18@openvpn.net>

2025-03-04, 13:11:28 +0100, Antonio Quartulli wrote:
> On 04/03/2025 13:00, Sabrina Dubroca wrote:
> > 2025-03-04, 01:33:50 +0100, Antonio Quartulli wrote:
> > >   int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
> > >   {
> > ...
> > > +	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
> > > +	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
> > > +	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
> > 
> > 
> > [...]
> > > +static int ovpn_nl_send_key(struct sk_buff *skb, const struct genl_info *info,
> > > +			    u32 peer_id, enum ovpn_key_slot slot,
> > > +			    const struct ovpn_key_config *keyconf)
> > > +{
> > ...
> > > +	if (nla_put_u32(skb, OVPN_A_KEYCONF_SLOT, slot) ||
> > > +	    nla_put_u32(skb, OVPN_A_KEYCONF_KEY_ID, keyconf->key_id) ||
> > > +	    nla_put_u32(skb, OVPN_A_KEYCONF_CIPHER_ALG, keyconf->cipher_alg))
> > 
> > That's a bit inconsistent. nla_put_u32 matches the generated policy,
> > but the nla_get_u{8,16} don't (and nla_get_u16 also doesn't match "u8
> > key_id" it's getting stored into).
> > 
> > [also kind of curious that the policy/spec uses U32 with max values of 1/2/7]
> 
> From https://www.kernel.org/doc/html/next/userspace-api/netlink/specs.html#fix-width-integer-types
> 
> "Note that types smaller than 32 bit should be avoided as using them does
> not save any memory in Netlink messages (due to alignment)."
> 
> Hence I went for u32 attributes, although values stored into them are much
> smaller.

Right.


> > >   int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
> > >   {
> > ...
> > > +	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
> > 
> > 
> > 
> > >   int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
> > >   {
> > ...
> > > +	slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
> 
> Right. Since actual values are smaller I sometimes used the smaller macro.

Which only works on little-endian if the other side is using the full
size?

              LE        BE
put_u32(1) -> 01000000  00000001
get_u8        ^^        ^^
              =1        =0


(and put_u8(1) vs get_u32 would result in fetching 0x1000000 in BE)

> I guess I better convert them all to u32.

SGTM


> > A few more inconsistencies:
> > 
> > * OVPN_A_IFNAME is defined in the uapi but never used (I guess
> >    leftover from genl link creation)
> 
> Ouch, I guess you're right about it being a leftover.
> 
> > 
> > * OVPN_A_PEER_DEL_REASON (u32 vs u8)
> > drivers/net/ovpn/netlink-gen.c:52:      [OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 4),
> > drivers/net/ovpn/netlink.c:1131:        if (nla_put_u8(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
> 
> Like above, probably better to convert them all to u32.
[...]
> 
> u32 should be enough for packets - but yeah, going UINT is better as I don't
> need to care if it really fits 4B or not.

And that SGTM too. Thanks.

-- 
Sabrina

