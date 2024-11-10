Return-Path: <linux-kselftest+bounces-21744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759079C31CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5E11F211DC
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0C2155C9E;
	Sun, 10 Nov 2024 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2q4eROq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366A13C82E;
	Sun, 10 Nov 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731238130; cv=none; b=c+zhV7g1L+2sDeXqhyb0MtDTyswtyV7QgM3WF/b2HhfX2LNZgfdBW51BIsUJRxBqST5WutnFJZ/GQrmAKDnDilptzl/uYH5ONvR42NLDPIA3iiskkPG7kU5i+WuBROESdJvclhbAoq10KWDtmALDvLf7gec4NjmJixvWgKPROqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731238130; c=relaxed/simple;
	bh=2065ZepCc8TmmwTzDyEJlb10FhFkTwoAsEpqw2WZ010=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEFaaRDEaNNhdkNKkyEmtRa02oCqri+NnTdqHveMKUFUkfRa3lHuQQYCDzsg55wQPAwEmqaUFKMYCnjY71dqf6Z4o5lDYFvLkgvbvgsBB8scS3N+zvCL/gHHOQ2cs1NUlSKdh+wzyakqfB4irnO4j5hcgOorbzVmFCqqPHKHlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2q4eROq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 094092540105;
	Sun, 10 Nov 2024 06:28:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 10 Nov 2024 06:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731238126; x=1731324526; bh=7taAjRSS2x+xLAe/qHIkb1U6ykRJGqjh1dk
	T+5MQurM=; b=f2q4eROqBjCEAG3rcap/B6ffM4ntI786WtDxHYS1RTlugh4pDom
	BY3jr7/U/KX+uf44JhPS6rHI9Lnk1CC28fD8JJsYS9lRfyjIvgVNbr/HMr30NdkW
	ZX6wdTh9jHRNak4tx8CmNm24lj6Dn+qcOu61Sot11wgCygskUGr/AXFeMmZJXhWN
	Nx1kJbDLy7THadO/mtgPc6WhkIDYwSevKPRihpujaCuXm35v0B8BGwt+DpTjGE9G
	uax8NMU9xWZzA/NDCYiEpoppkiCjUlbKOzq4OkjppxIweVb76Jq+zzCckK+ZgjHp
	MXXXkvGjiNHd49vYeQAVNR5xDdLEXnRkzDw==
X-ME-Sender: <xms:7ZgwZ1kNQnSEcCrYhmXeJeFfhpAAFfAg7udihNyGnyriqQvDrdz8JA>
    <xme:7ZgwZw3BH5xJbV7dKiPu5I8HF1Cf1PVErhTTm_qtUr0EFXdxnc63o49VcxEj-lAR-
    kbxH5ccaUTMyVE>
X-ME-Received: <xmr:7ZgwZ7o4UzbNxrKE3BCQxC32FlIRIeM41eEHgfIPA_9CnJKdthzz0f9HB5z5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceo
    ihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufeevke
    ehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughosh
    gthhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopeguvghlihhrrghnsehvvghrughitghtrdhgghdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegushgrhhgvrhhnsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvg
    htpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7ZgwZ1mvwcL5ck5qwIrjBiDrnDKYurUPQV-Sg8qaOnuloLOjXocO0g>
    <xmx:7ZgwZz1jUQBztB4CKlIWC8QH-p42Yb0DLY7xIDA9c5oaeRcQCAWehw>
    <xmx:7ZgwZ0ur8iRzSXK6nqJFxzoUe8TilOUwYViPoKk2LMq0T04Ugqmfcw>
    <xmx:7ZgwZ3Xi-SZQE1TY06w_w7XvIhjB6IfVQ9lbYp9RYR3qVqbFTAAfbQ>
    <xmx:7pgwZ8s-ex9ihCvfWApkrZvICBfophayKV_0hI2wR3wtOdnriXGPUE3l>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 06:28:45 -0500 (EST)
Date: Sun, 10 Nov 2024 13:28:42 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, linux-kselftest@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	horms@kernel.org, gnault@redhat.com
Subject: Re: [PATCH net-next v10] net: ipv4: Cache pmtu for all packet paths
 if multipath enabled
Message-ID: <ZzCY6kD4G2BVDNQs@shredder>
References: <20241108093427.317942-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108093427.317942-1-deliran@verdict.gg>

On Fri, Nov 08, 2024 at 09:34:24AM +0000, Vladimir Vdovin wrote:
> Check number of paths by fib_info_num_path(),
> and update_or_create_fnhe() for every path.
> Problem is that pmtu is cached only for the oif
> that has received icmp message "need to frag",
> other oifs will still try to use "default" iface mtu.
> 
> An example topology showing the problem:
> 
>                     |  host1
>                 +---------+
>                 |  dummy0 | 10.179.20.18/32  mtu9000
>                 +---------+
>         +-----------+----------------+
>     +---------+                     +---------+
>     | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
>     +---------+                     +---------+
>         |    (all here have mtu 9000)    |
>     +------+                         +------+
>     | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
>     +------+                         +------+
>         |                                |
> ---------+------------+-------------------+------
>                         |
>                     +-----+
>                     | ro3 | 10.10.10.10  mtu1500
>                     +-----+
>                         |
>     ========================================
>                 some networks
>     ========================================
>                         |
>                     +-----+
>                     | eth0| 10.10.30.30  mtu9000
>                     +-----+
>                         |  host2
> 
> host1 have enabled multipath and
> sysctl net.ipv4.fib_multipath_hash_policy = 1:
> 
> default proto static src 10.179.20.18
>         nexthop via 10.179.2.12 dev ens17f1 weight 1
>         nexthop via 10.179.2.140 dev ens17f0 weight 1
> 
> When host1 tries to do pmtud from 10.179.20.18/32 to host2,
> host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=1500.
> And host1 caches it in nexthop exceptions cache.
> 
> Problem is that it is cached only for the iface that has received icmp,
> and there is no way that ro3 will send icmp msg to host1 via another path.
> 
> Host1 now have this routes to host2:
> 
> ip r g 10.10.30.30 sport 30000 dport 443
> 10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
>     cache expires 521sec mtu 1500
> 
> ip r g 10.10.30.30 sport 30033 dport 443
> 10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
>     cache
> 
> So when host1 tries again to reach host2 with mtu>1500,
> if packet flow is lucky enough to be hashed with oif=ens17f1 its ok,
> if oif=ens17f0 it blackholes and still gets icmp msgs from ro3 to ens17f1,
> until lucky day when ro3 will send it through another flow to ens17f0.
> 
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

