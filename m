Return-Path: <linux-kselftest+bounces-30069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342BA7A5D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 17:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D67188D75D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D302459EE;
	Thu,  3 Apr 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AlREv/Be";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sDGJSyx7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F475288A2;
	Thu,  3 Apr 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692423; cv=none; b=LZSlEGcBPqqyX/NxMwDEc0/q8tU+VnDTxDipO4siJhQQ4EVsSdw2vz7GP0BuqfWkjraEk9Wqmsksl50WroXAJf080b+7Qb16n+RZbelxpAHh4yDFoGPhUY+HFedwOhp907kfDKu2/2uSosvs7WbV5tc0YzchogwuWc8B50GkToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692423; c=relaxed/simple;
	bh=A5bneBRwa4biwD4j8TttMJZ0PtIZZOB8/P7wbEjjoIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2owJilf9JoftZ0cHxsRlv1rw6D3s70G0/CR1Zspb34vWM88Rej9gNBrqRKXrk5qjKci9mAqadDi5rWyHjQC9VOyQqNZa8gQwI4+jcIGvZI6M+W9xd1BH+eJKfxrrrnkBpfsA/YZtRvX4D8D9bXhCunDhoH2l9zYwDEl4efQmd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AlREv/Be; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sDGJSyx7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CD0C711401A2;
	Thu,  3 Apr 2025 11:00:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 03 Apr 2025 11:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743692418; x=
	1743778818; bh=OIn7b8m7z/9VxxSKHbVoT6q2dMgc8aTGH8Ol8ApjPV8=; b=A
	lREv/Be6+MT482wtRKFZwjAoIQC7yUBthiCTFazzthnCK5NnhKYHcm61dX0usRb2
	cxOmCbzt4Nzs8CQwzLK3tJmpJzbvcGzcZVyJ1GgKXUrWycOj9UzZNPsGMBYcYg6y
	fd1pTQyHuxE8J+U6vQrxclt1oPeJBidyP9JkqlgTVXWI5FYguiScJJmbScBk89tT
	+3Q4J73a/sTKFvTVPDCHaLY4z7LmwMsDsFAvQ4OwAYUlr2DXoPrz2Jl2MkeYxrV/
	08+GcPy2KLModlK97D/eBCVQdj0biO2F3pFQFI+U2V5EW42nO6LxKunSuP9uDJ28
	XcNwpk1dfNSDbyzg2ddnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743692418; x=1743778818; bh=OIn7b8m7z/9VxxSKHbVoT6q2dMgc8aTGH8O
	l8ApjPV8=; b=sDGJSyx71dvESw1g7o+HhRF7kJIOj5yqsJ944xT9DU7kK5lApMH
	vudCnLEZU/UepT8iyZ5qw3KP8BxX4+CZv3UG0ZQyUZKUyP2OgAN9JQwVgPFvJ4TI
	VaFKsvfeo9lR2546R2hPU7dDZnIIGXLL2cArcdHapq37Avnc4wI1OFU8Uy7mREPV
	qa8RUt5h6j2653XDpfjmhW1XuO6BWozrByTmlcqBAYp7v8sLIr+p6EwULYBoBXnG
	ikr3BKoEhVg1+IGG/Zm+xZ06rL/hrLWuDcBQGg12XiTUfpAxjypn+fdqedP5HCj7
	CdM9r9KCmB8TNqiCIhM8bYiM2wlu+87YNBg==
X-ME-Sender: <xms:gaLuZ7ci6PJ0Rm3VR2nfB91gXq-oQFadGQSloTm-fonsJ5MD6rn00w>
    <xme:gaLuZxNOsfZfapZneN5oh32qjEKb4x9c8KL_yfy_oxM71pV5S_JxNDG2AZTQZmStu
    jpU__QzCzxgmyZD8GY>
X-ME-Received: <xmr:gaLuZ0ioh8Dr_2kk56lQoXiNfsHOMrXfzjtNKxNRwRR1vBm0kaE4y8yG1b9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuh
    hhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslh
    hunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuh
    gsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gaLuZ8_CNrItYlo1JoM_rig2N05mnwxW09gZzWuHWnhoG9eq2fQX4Q>
    <xmx:gaLuZ3uwbmmew4agUuetaq9vV-cMTt_66tlq6OFKYUgpSPTv-EtlAg>
    <xmx:gaLuZ7FC-jIb9Z_ougOXzuCejljmCo-51AADbUZ9gNcmhr7DNhHFOQ>
    <xmx:gaLuZ-P8Qvj2-6QBMiSPFh3Hp3y3F8BSI2oGElFOkaH2JvYEb08-TA>
    <xmx:gqLuZ4NZF16D0RQx2VeJnVT72PmIih4V7s48k_Qjh75pB4GQwgoDxXFe>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 11:00:16 -0400 (EDT)
Date: Thu, 3 Apr 2025 17:00:14 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/3] ipvlan: fix NETDEV_UP/NETDEV_DOWN event handling
Message-ID: <Z-6ifi46d2JmnIch@krikkit>
References: <20250403085857.17868-1-liuhangbin@gmail.com>
 <20250403085857.17868-2-liuhangbin@gmail.com>
 <Z-5i5rsrIyE0fM-V@krikkit>
 <Z-6IbvorOVx6hpxM@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-6IbvorOVx6hpxM@fedora>

2025-04-03, 13:09:02 +0000, Hangbin Liu wrote:
> Hi Sabrina,
> On Thu, Apr 03, 2025 at 12:28:54PM +0200, Sabrina Dubroca wrote:
> > Hello Hangbin,
> > 
> > 2025-04-03, 08:58:55 +0000, Hangbin Liu wrote:
> > > When setting the lower-layer link up/down, the ipvlan device synchronizes
> > > its state via netif_stacked_transfer_operstate(), which only checks the
> > > carrier state. However, setting the link down does not necessarily change
> > > the carrier state for virtual interfaces like bonding. This causes the
> > > ipvlan state to become out of sync with the lower-layer link state.
> > > 
> > > If the lower link and ipvlan are in the same namespace, this issue is
> > > hidden because ip link show checks the link state in IFLA_LINK and has
> > > a m_flag to control the state, displaying M-DOWN in the flags. However,
> > > if the ipvlan and the lower link are in different namespaces, this
> > > information is not available, and the ipvlan link state remains unchanged.
> > 
> > Is the issue with the actual behavior (sending/receiving packets,
> > etc), or just in how it's displayed by iproute?
> 
> The upper link in netns up while lower link down will cause the traffic break
> in the pod.

That seems like the correct behavior based on the actual (not
displayed) state of the links.


I wonder if netif_stacked_transfer_operstate should consider the admin
state of the lower device as well as link state:

@@ -10724,7 +10724,7 @@ void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 	else
 		netif_testing_off(dev);
 
-	if (netif_carrier_ok(rootdev))
+	if (netif_carrier_ok(rootdev) && rootdev->flags & IFF_UP)
 		netif_carrier_on(dev);
 	else
 		netif_carrier_off(dev);


but I haven't looked at all the consequences and possible side
effects.

-- 
Sabrina

