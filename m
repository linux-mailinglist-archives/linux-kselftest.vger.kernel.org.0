Return-Path: <linux-kselftest+bounces-27126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CBA3EB44
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 04:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6129C3AE974
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 03:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0121F8901;
	Fri, 21 Feb 2025 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AdVglnvK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A601F5839;
	Fri, 21 Feb 2025 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740108313; cv=none; b=MrYPk47om16/Gv9vaNQfX7o/FejHNTIkVdG4X0/GJfYpqNzSs7evzWtbOvW95DXvanUjxuz31TPma1Er+3a7NdqoJcqaS6Pc11aCqStMdtYKi001TYATvDFglVOCBX2IPFoCcGJv+ANE8XSegyHi2uHdfgCrmZkBKEChZLqkTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740108313; c=relaxed/simple;
	bh=80AdJ7ZcONXQAx9BgLf5F2RhrRhVoagkS64xbotAsp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBOoR4o98hxQoEUUC/VqN+udBYoMRF9oW7kv2W2D8XZE6tN8uFEacxB9yZaS66F72IPkh17FuVaq1mWy6Kggce1fMOuAFi5NmPIRE/ZxGqb5JzUYr9W1kfvPSx0yXpTcomungU2VSHoRqH3KV+PBRKuZ6mgf1P79oUsXfaDc+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AdVglnvK; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740108312; x=1771644312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=98eKIkOj5zDaaN0aeg/8QMarn/Dvke+2ZuIrd8oeP2I=;
  b=AdVglnvK8TbVyXlEPRf84DUIqPCl0WrQk0NbkqBxgJh5ko65IBfPz26X
   Y0pwlJ092oQArq8RmWNbgs/Zs0DHRN8mCdfg+Ys8H09+JiwwZl1whA7xT
   Lp3jQP+wSg9h7EA1E89dmAYVdTN7QVpX6W2mwhSfrt4xbzl4/gPAoZo0j
   E=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200"; 
   d="scan'208";a="171680556"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:25:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:29611]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.181:2525] with esmtp (Farcaster)
 id 878d6712-a911-4454-a3d1-f12dc573cc97; Fri, 21 Feb 2025 03:25:09 +0000 (UTC)
X-Farcaster-Flow-ID: 878d6712-a911-4454-a3d1-f12dc573cc97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 03:25:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 03:24:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <alex.aring@gmail.com>, <andrew+netdev@lunn.ch>,
	<b.a.t.m.a.n@lists.open-mesh.org>, <bpf@vger.kernel.org>,
	<bridge@lists.linux.dev>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <herbert@gondor.apana.org.au>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-ppp@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <osmocom-net-gprs@lists.osmocom.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <stefan@datenfreihafen.org>,
	<steffen.klassert@secunet.com>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v10 02/13] rtnetlink: Pack newlink() params into struct
Date: Thu, 20 Feb 2025 19:24:49 -0800
Message-ID: <20250221032449.73597-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-3-shaw.leon@gmail.com>
References: <20250219125039.18024-3-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:28 +0800
> There are 4 net namespaces involved when creating links:
> 
>  - source netns - where the netlink socket resides,
>  - target netns - where to put the device being created,
>  - link netns - netns associated with the device (backend),
>  - peer netns - netns of peer device.
> 
> Currently, two nets are passed to newlink() callback - "src_net"
> parameter and "dev_net" (implicitly in net_device). They are set as
> follows, depending on netlink attributes in the request.
> 
>  +------------+-------------------+---------+---------+
>  | peer netns | IFLA_LINK_NETNSID | src_net | dev_net |
>  +------------+-------------------+---------+---------+
>  |            | absent            | source  | target  |
>  | absent     +-------------------+---------+---------+
>  |            | present           | link    | link    |
>  +------------+-------------------+---------+---------+
>  |            | absent            | peer    | target  |
>  | present    +-------------------+---------+---------+
>  |            | present           | peer    | link    |
>  +------------+-------------------+---------+---------+
> 
> When IFLA_LINK_NETNSID is present, the device is created in link netns
> first and then moved to target netns. This has some side effects,
> including extra ifindex allocation, ifname validation and link events.
> These could be avoided if we create it in target netns from
> the beginning.
> 
> On the other hand, the meaning of src_net parameter is ambiguous. It
> varies depending on how parameters are passed. It is the effective
> link (or peer netns) by design, but some drivers ignore it and use
> dev_net instead.
> 
> To provide more netns context for drivers, this patch packs existing
> newlink() parameters, along with the source netns, link netns and peer
> netns, into a struct. The old "src_net" is renamed to "net" to avoid
> confusion with real source netns, and will be deprecated later. The use
> of src_net are converted to params->net trivially.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

