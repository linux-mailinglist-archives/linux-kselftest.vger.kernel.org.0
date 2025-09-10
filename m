Return-Path: <linux-kselftest+bounces-41083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E817B509DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A8B1C61491
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 00:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B84481B1;
	Wed, 10 Sep 2025 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="HRjMja/4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="efNTW2+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D83BB48;
	Wed, 10 Sep 2025 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463514; cv=none; b=XHHmMIw7bteE05M+/eycLHTDA3hIaewbD9jcjofWtg5N/AN5eKO2qp1sS2k1twuuMHPbUoTPQQvxfUaChxgrbA8qsopvenf08PrvSdFa2Ga18yiuoPXv6reVjQ1bQ2v6LFjIvh1KzcZMYqeweUQGNDGj+qV9+jFt6G08SGqZwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463514; c=relaxed/simple;
	bh=aOH0Jq201iLiKSg/quvkkXH53ymUMzpbza9iH6WfWkg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=TR7Nz5jNDLr1w4t2xD3SRLxVyHm9gXZwbGMbzgcbGzWPPSL5+oAFlsTzXf3xBecFP+TPI7vH+Y4z+kuI3Q6jtw0DPACdiWd+yiiYCP23fa3Umel+MrP5l0huZOlANf34bLxsm6ckkshq0H7rH3zxDKLGd6oAu2dGiWH800rEXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=HRjMja/4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=efNTW2+U; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id F1B891D001A1;
	Tue,  9 Sep 2025 20:18:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 20:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757463508; x=
	1757549908; bh=tVXgzjU/XUoqT7AJ6v4aTSUob1Q0o5B4bDZFNZjqRO0=; b=H
	RjMja/4XZSLLS1DeCx0ydinru7rgC6h6V3zU6svcdW7OMyEbKbk+69BLv92UduIH
	OglTvba2DFIOOJcgW7QUPpIDUf5Dp9NuCtIBp6B8uegI7RqGIYedH1D16pro8SDq
	uXKXTbgbL1D21KsVE5r05l5/Fk9gJchqnzXuqGXSt/mH319FQa6TjNV4NdAaync2
	Ob5QgL04lf6lV/L1nwlp+GXNnJzE1Qu3nxbmsrY3vwvKyGAqtjCn4z40SFVGF3uo
	u400zhRngsclY5y2ew5qWyEtT4lvYJRXdNhLNGVzfzzKgLCGsrtXkU8tSZFLwMfA
	Y5M2IHZJAwV2usRDfXLwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757463508; x=1757549908; bh=t
	VXgzjU/XUoqT7AJ6v4aTSUob1Q0o5B4bDZFNZjqRO0=; b=efNTW2+UtpRG4yrBj
	+Gl7CBqfaWpUZr2n1fBGM3vFZTUaKCJmb81sSu5RYYdZPJAqulH3Veutm03e21al
	QWUDgFVyJ7tihEyixK5FqQ8FDQ+utKg7ON7UgxMIMAyOLnEwLSlWd6lvpx+MAqJJ
	d+LQQeLJoHL9XxR0EoCGyAJeLCy9DZ9LqzQSuwjjFk51Jr89cAuoO2A8MPXOXbKG
	MS38XLBueP69seAGf4cUb2de4BVvfIkWKbT4QDdRWV7acPCFb1kr6vRUsqH1Hrii
	nKU7/pe8JMFEFT/4DwU/31gZ/Z/5LfdNr4nSwlTjwqqiI0P6PpdAMnhZKqL9D4cr
	/sZ4Q==
X-ME-Sender: <xms:1MPAaH-kse870N3cS2DoSnGbi_yuQUUq8R6jZCU1hcjyK1jtBUQlag>
    <xme:1MPAaH3Gdilw8ATRMZoJ5jVXUxNO3R8HIUTq32kTgTvLnAymBWe3JvWY9qGHiaYYe
    42_10Ox1d27TsKbvyc>
X-ME-Received: <xmr:1MPAaCCQZwhJmEoad_VAzhBK20DpRBslsCM8i8TF4E1RdlYIAJrhDSy7B5plP__Ob5O_gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtfffksehttdertdertddvnecuhfhrohhmpeflrgihucggohhs
    sghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epjedvgffhteevvddufedvjeegleetveekveegtdfhudekveeijeeuheekgeffjedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvh
    hoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopehlvghithgrohesuggvsghirghnrdhorhhgpdhrtghpthhtoheprghsrghnthhoshht
    tgesghhmrghilhdrtghomhdprhgtphhtthhopegvfhgruhhlthesghhmgidruggvpdhrtg
    hpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopeguvggt
    ohhtsehgohhoghhlvghrshdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1MPAaOC59v9Scb9GQPc7MMgrSJWR3oGt2jked5PGLq99FbyeTLBXPQ>
    <xmx:1MPAaDM9MmTlJWaUGke5P3h-GP69vlSH0Bp2HVIHp8GQ2LLqRkyD0Q>
    <xmx:1MPAaIOTI37BCrupPgHsjNa-62m_fE9FjDBx3DzFeIFHMaGcYCajYQ>
    <xmx:1MPAaHscmt_Xkc9Wr_TKpXMBsXOlc9BEvzjcYTn0af0BEbZoKCTqTQ>
    <xmx:1MPAaERXujxLuFOuRrJPwTXaM31tgNxvlN8lRB5kmpthpLl7i75-bUrZ>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 20:18:27 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id C55109FCB4; Tue,  9 Sep 2025 17:18:26 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id C34F09FC62;
	Tue,  9 Sep 2025 17:18:26 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jakub Kicinski <kuba@kernel.org>
cc: Calvin Owens <calvin@wbinvd.org>, Breno Leitao <leitao@debian.org>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
    david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
    asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com,
    stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
In-reply-to: <20250908182958.23dc4ba0@kernel.org>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
 <aL9A3JDyx3TxAzLf@mozart.vkv.me> <20250908182958.23dc4ba0@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Mon, 08 Sep 2025 18:29:58 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2930647.1757463506.1@famine>
Date: Tue, 09 Sep 2025 17:18:26 -0700
Message-ID: <2930648.1757463506@famine>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Mon, 8 Sep 2025 13:47:24 -0700 Calvin Owens wrote:
>> I wonder if there might be a demon lurking in bonding+netpoll that this
>> was papering over? Not a reason not to fix the leaks IMO, I'm just
>> curious, I don't want to spend time on it if you already did :)
>
>+1, I also feel like it'd be good to have some bonding tests in place
>when we're removing a hack added specifically for bonding.

	I'll disclaimer this by saying up front that I'm not super
familiar with the innards of netpoll.

	That said, I looked at commit efa95b01da18 ("netpoll: fix use
after free") and the relevant upstream discussion, and I'm not sure the
assertion that "After a bonding master reclaims the netpoll info struct,
slaves could still hold a pointer to the reclaimed data" is correct.

	I'm not sure the efa9 patch's reference count math is
correct (more on that below).

	Second, I'm a bit unsure what's going on with the struct netpoll
*np parameter of __netpoll_setup for the second and subsequent netpoll
instances (i.e., second and later call), as the function will
unconditionally do

	npinfo->netpoll = np;

	which it seems like would overwrite the "np" supplied by any
prior calls to __netpoll_setup.  In bonding, slave_enable_netpoll()
stashes the "np" it allocates as slave->np, and slave_disable_netpoll
relies on __netpoll_free to free it, so I don't think it's lost, but it
seems like netpoll internally only tracks one of these at a time,
regardless of the reference count.

	On the reference counting, the upstream example from the prior
discussion includes:

    mkdir /sys/kernel/config/netconsole/blah
    echo 0 > /sys/kernel/config/netconsole/blah/enabled
    echo bond0 > /sys/kernel/config/netconsole/blah/dev_name
    echo 192.168.56.42 > /sys/kernel/config/netconsole/blah/remote_ip
    echo 1 > /sys/kernel/config/netconsole/blah/enabled
    # npinfo refcnt ->1
    ifenslave bond0 eth1
    # npinfo refcnt ->2
    ifenslave bond0 eth0
    # (this should be optional, preventing ndo_cleanup_nepoll below)
    # npinfo refcnt ->3

	I'm suspicious of the refcnt values here; both then and now, the
npinfo for each of the relevant interfaces is a separate per-interface
allocation in __netpoll_setup, so I'm not sure what exactly is supposed
to be getting a refcnt of 3.

	If there are two netpoll instances using the slave in question
(either directly or via the bond itself), then clearing the
np->dev->npinfo pointer looks like the wrong thing to do until the last
reference is released.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

