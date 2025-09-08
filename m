Return-Path: <linux-kselftest+bounces-41004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E070B49C57
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64C44E39AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340B2E0B48;
	Mon,  8 Sep 2025 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ijyvcCdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Idw82lCi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760919644B;
	Mon,  8 Sep 2025 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368146; cv=none; b=h9bz93tTk4oE4uu0hMIb8JAje2o4EpHdsIVmQ3AzZWffZd4IOxjh+qxFkwZ16QU6FBPm+Pj+Yjz5rwlxa3nMdJJJBAILXQVw95iW+CARNcmv+2g8HBJVCoNYolFHZJDL1QuGJnexgyD52FcEmneYrOXINaCNnQ5+W14lGw3KmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368146; c=relaxed/simple;
	bh=xZwtgP/SMxO4gXjpndSJj3OnJPcQq5Kzza2m2kq/YC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwRVzarooIAqydrWxRBQn0BT2GPVFSXTP8893VhmPcoct5IdvMjlXBqXEqsYo9tkKNChMt8pHolwquWFjsn5X8ahuVr9QBnAk0qpiBdO+EvfGw3b6COzN4mMC1O2iTPKQ3hKLe7fzGMSnlPTHGYkDwzE+3kAfEpRGBsre66rGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ijyvcCdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Idw82lCi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E284A7A00B2;
	Mon,  8 Sep 2025 17:49:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 17:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757368141; x=
	1757454541; bh=62PV9PUcHNBx3VeoR1lvE5yI4zsYl4Rz5Cp/8QhlRYU=; b=i
	jyvcCdI2DydQgkTJZJRTCnVufP7BySkuCwAMRRwJ89vEUSdFr08RzB8QlP/XljID
	yiXwxnUhEw9G4SCIBUToq8HhIwnj+TXtc/gqSxeasFePP5+zOqBNC9szevVzRH+q
	mxo8vGL430f9W/4i1uSyMTSRlpxCZlow0MiAaDBxXg3yUOVFMk0WgxA+oPFVzV+2
	pPvHo963OsYL6frYQXBkuNZh2iD3lC2Z6Bu3mxKojt1pMzhyr1JRPhe39xW0e6sm
	wOZnudT7hsYiP2CTArKp1pfNXil2T0qitOAjPLrMmgsYP+jBPQRV1Ypcsfljv2ty
	O/r0nb4JXg5oT15LOeoUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757368141; x=1757454541; bh=62PV9PUcHNBx3VeoR1lvE5yI4zsYl4Rz5Cp
	/8QhlRYU=; b=Idw82lCiLKBSUuAl7bxnOKBUKRyVMY5QVJnkZHs6g3w/spwqIgd
	QaFBPLhAiVYZugtH640jHc6c3zHUgJmjiiZvt4Y8ifJKIFAmxHiJIS95bk5+/5VS
	T+UogD268hHUAGlTp/DGX2IEUxSVqjfHr0tz5fuSeqI0h4kkQF84h/xNV5SqZRC/
	e2p6ric5XIUIMNzhfHROUqr8Obt9yC4Zg91DTrnGnrfvOknpYDaW0J4FfLEEicwP
	UXxLD7CW9BL8iNhrWPOQJRpUwFrjVJVc0a4itmQlQC8lLvoNxeNyZipFxrbZl3z3
	R0ALNmtla7afgYema2E73TtWA0ChVRXQ6PQ==
X-ME-Sender: <xms:TU-_aHw62BNmUDVr7nLT1CZpBgtgefnYNMUXyZpAUeOXaxlBHFEwsg>
    <xme:TU-_aJgBrDa-gpUHa3v8YFu30-nlhNQ9fr-eibpwhcPtMg0fxUOkUMV60rgcHw8l3
    SBh4fCrxxcac1vEczo>
X-ME-Received: <xmr:TU-_aGzZ87WENkF6V6HOhZRW3Jejh48TTkWqBJuWXNCDjmqtg-tBzI-_JHIt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvhesjhhvohhssghurhhghhdrnhgvthdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhirhhisehrvghsnhhulhhlihdruh
    hs
X-ME-Proxy: <xmx:TU-_aHy6WfAoRbt-jr2ZyfjZIOOpQp6jUoRhTPyFoltIs8ou__30gA>
    <xmx:TU-_aApmKshoaxwGdZ6ziamKjb8tY38LfNW83HZgL56QEWlzQNvFlA>
    <xmx:TU-_aKktqao7-eJxbfy7gjgcDBNKToUjmdrV7lMuzYruFAVNjWMqlw>
    <xmx:TU-_aJz90FKSpG6RW7dma-84cBltYyc2rprhYhzGU-3EN03YRF4uJA>
    <xmx:TU-_aCj90on4DFro_qdziXvCreuezMrZAOd4PNiA9iaSbfIyi1VsPbQ6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:49:00 -0400 (EDT)
Date: Mon, 8 Sep 2025 23:48:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aL9PSoTwhn-HFWrH@krikkit>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
 <aLyoEiWnuvQ-5ODz@krikkit>
 <aL5YamjbZB5gsL30@fedora>
 <aL6jlYPhsPfDKT8C@krikkit>
 <aL6soY3gEj-LIovi@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aL6soY3gEj-LIovi@fedora>

2025-09-08, 10:14:57 +0000, Hangbin Liu wrote:
> On Mon, Sep 08, 2025 at 11:36:21AM +0200, Sabrina Dubroca wrote:
> > > The esp-hw-offload is fixed on netdevsim
> > > 
> > > # ethtool -k eni0np1 | grep -i esp-hw-offload
> > > esp-hw-offload: on [fixed]
> > > 
> > > There is no way to disable it.
> > 
> > I don't think this is intentional. nsim_ipsec_init only adds
> > NSIM_ESP_FEATURES to ->features but not to ->hw_features, but I think
> > it was just forgotten. I added a few in 494bd83bb519 ("netdevsim: add
> > more hw_features"), extending nsim_ipsec_init (and nsim_macsec_init
> > since I made the same mistake) to also add features to ->hw_features
> > would make sense to me.
> 
> This could be done in another patch.

If it's not needed for this series, sure.


> > > After we add the netdevsim to bond,
> > > the bond also shows "esp-hw-offload off" as the flag is inherit
> > > in dev->hw_enc_features, not dev->features.
> > 
> > Did you mean dev->hw_features?
> 
> No, the xfrm_features in patch 01 updates dev->hw_enc_features, not
> dev->hw_features.

Ok. But hw_enc_features is not the reason ethtool shows
"esp-hw-offload off". This line is:

	bond_dev->hw_features |= BOND_XFRM_FEATURES;

(from bond_setup)

> Do you think if we should update dev->hw_features in the
> patch?

For dev->hw_features (and dev->features) maybe not, since that depends
on the upper device's features and implementation. I'm not sure we can
have a common function without changing the behavior on at least one
type of device.

But maybe ndo_fix_features could use a common
netdev_fix_features_from_lowers? bond/team/bridge have very similar
implementations.

> > > It looks the only way to check if bond dev->hw_enc_features has NETIF_F_HW_ESP
> > > is try set xfrm offload. As
> > 
> > Was this test meant to check hw_enc_features?
> > 
> > To check hw_enc_features, I think the only way would be sending GSO
> > packets, since it's only used in those situations.
> 
> Oh.. That would make the test complex. Can we ignore this test first?

Ok for me.

> BTW, I'm a bit lost in the callbacks.gso_segment. e.g.
> 
> esp4_gso_segment
>  - xfrm4_outer_mode_gso_segment
>    - xfrm4_transport_gso_segment
>      - ops->callbacks.gso_segment
> 
> But who calls esp4_gso_segment? I can't find where the features is assigned.

inet_gso_segment via inet_offloads[] (ESP is a L4 proto like UDP etc).

-- 
Sabrina

