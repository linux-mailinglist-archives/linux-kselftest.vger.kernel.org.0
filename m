Return-Path: <linux-kselftest+bounces-29735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEFEA6ECE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 10:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6124B3A8109
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878C253B64;
	Tue, 25 Mar 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="XtLZHqs9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AujYp9nI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53031FAC3D;
	Tue, 25 Mar 2025 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895642; cv=none; b=Cpk9lDrgZwjWhAbjVgBtxdEi/e6VKTg1MbopVmbAwCb/HAbJhXuzxM/GS0rhbwA38nh2vNUTFeKh3nQR1usjU/IkYhPYkHYI3jhacfeiaRlaw5KozCI3N8n2KqjEMHecIOWbGFlW0M9ogjU2CGWW05inFAhxfV76Jyn1rvV1xEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895642; c=relaxed/simple;
	bh=eud//FrrPTn/NL9oNFt/scdtsVUNC3WUkl6HvB+h21I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDiqjFJ+1Q7PVu1aEmVqeukrp5Olq6gr6jGuWC6smP58C9OQoljhM7JixslgVJGp+ptoi8i0UKL+2UYjHTibQ7KIiI9EepmTT+wPinA3c1soF5hco3dLdbaBYLgwE4vpVxjeTnz9whZ5XKJPVQO/mLI9N7MgJXgYRxNSgLSJohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=XtLZHqs9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AujYp9nI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3DBE11402AF;
	Tue, 25 Mar 2025 05:40:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Mar 2025 05:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742895637; x=
	1742982037; bh=jJPAD2UcHldTjErdg3Kf7WH+pXGiXV6MKPRaF1AAmD8=; b=X
	tLZHqs9AgHLr1kLcEAoRmL+WNrUdMjZNi/wlElR9ByrLL5zn6m/GxaiQKnHivG06
	WvVjui0aG24m6qEh4cE7A6tAR46pGZpwfO1uCiI8Y8cDHwHJQD92VMG6meBQJojk
	7+Cdps11bKHRiIlrBi/ar2kspXrT/SOqTMeJ4ZwFMko5ecbnzmNkUcnSzKebS1tm
	QsMowBqYXF9tWW3FwhbiyKtH3iNtgf7lB+qgPtCH2HWMDZWm5uk2FiQ7kIVSniS6
	NwCl0L26eA0T587BZ987x60v5s9uh3O9p7u2VrQWUK1ejNP08GD3CxGFdRDyp6Nk
	MNkPGods9D2TxlrEAd6Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742895637; x=1742982037; bh=jJPAD2UcHldTjErdg3Kf7WH+pXGiXV6MKPR
	aF1AAmD8=; b=AujYp9nITJlK//rS43Gr10ZLd+shKs1Og20Pb1uMq2JQ+HQN/M3
	DEpErdnCWySL/BQhwE/Hks0OvlDsnCeklzWd+WkhHg48bq3ru+Ji1ItnBh8NDwDJ
	jSpot9UVM7fRgJK4nQUOiZqUyQUA3mXTHRK0grTwyo/j1W2H4gAmDSudcscKx45E
	k0e29rJ31hhqasNWsJAV5L0eeqoGH362N7UTYOqhTSxaJUFwAyhWy4M/RqSSbkvs
	msnvuiawgrvJWrCcxcVc6QqUl+hL1wni4R25uZYuEGL8rOYFMEY2sEgQl+mXe9mx
	py5yMwYMDYHmQkPq/2KCPmdpq4ShPIfisTA==
X-ME-Sender: <xms:FXriZ8uJQWN9AMjb-7FeO80wRmTJN7u8IUt_VZfLzGje0zs8_zsJUA>
    <xme:FXriZ5cpzn2OT48ugIRXwZHGUQOVBl6dVjQja735_6jPcx9YxGQbsEZ1PGvbwCdvc
    hUaUFezBqVS9n9ilik>
X-ME-Received: <xmr:FXriZ3y3uQpydWUEkAuBq5qDvag92B_B0djhDbD_fasn2Oi1wZjKxdMUix2T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvfeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:FXriZ_PzH1_2lmZRkmn8CYwcJqsqWo5i11g3ExFDqlzZW_5gm0OsVQ>
    <xmx:FXriZ8_0DhBEqBhNrtDZ4b4QqaY3DkqPeXOjLLOUB1cuCmj4ze_I8A>
    <xmx:FXriZ3XSCvioqBjHsh6m5MECSV_YYZ96ZhSOlUNusU_JOo3lqkjIOQ>
    <xmx:FXriZ1dLKkIaPeuoheJeWz35FqaXM-hAr39j2AsDghQ9iIDaO6khBg>
    <xmx:FXriZ2fuh1nrrdKCKQIBvDjIIdQQYbDBH3vcpDnpmDzTeYBj1sPFtKAZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 05:40:36 -0400 (EDT)
Date: Tue, 25 Mar 2025 10:40:34 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
Message-ID: <Z-J6EmX-wZRUYt4f@krikkit>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
 <Z-E70n1tkzKdepTo@krikkit>
 <ae9f3c18-7b03-4a49-83a4-a3e7d8c52a3e@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae9f3c18-7b03-4a49-83a4-a3e7d8c52a3e@openvpn.net>

2025-03-24, 21:53:02 +0100, Antonio Quartulli wrote:
> On 24/03/2025 12:02, Sabrina Dubroca wrote:
> > 2025-03-18, 02:40:44 +0100, Antonio Quartulli wrote:
> > > +int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
> > > +			    const struct ovpn_peer_key_reset *pkr)
> > > +{
> > > +	struct ovpn_crypto_key_slot *old = NULL, *new;
> > > +	u8 idx;
> > > +
> > > +	if (pkr->slot != OVPN_KEY_SLOT_PRIMARY &&
> > > +	    pkr->slot != OVPN_KEY_SLOT_SECONDARY)
> > > +		return -EINVAL;
> > > +
> > > +	new = ovpn_aead_crypto_key_slot_new(&pkr->key);
> > > +	if (IS_ERR(new))
> > > +		return PTR_ERR(new);
> > > +
> > > +	spin_lock_bh(&cs->lock);
> > 
> > At this point, should there be a check that we're not installing 2
> > keys with the same key_id at the same time? I expect a well-behaved
> > userspace never does that, but it would confuse
> > ovpn_crypto_key_id_to_slot if it ever happened.
> > 
> > ["well, then the tunnel is broken. if userspace sets up a broken
> > config that's not the kernel's problem." is an acceptable answer]
> > 
> 
> The behaviour of ovpn_crypto_key_id_to_slot() is still "deterministic" as we
> will first lookup the primary key.
> 
> Therefore we will simply always use the primary key and never the other,
> which is what we should expect in this situation from the code.
> 
> I'd say this is just an ill-formed configuration, yet not invalid.
> As per your statement, I'd say it's userspace's problem.

Ok, sounds good, thanks.

-- 
Sabrina

