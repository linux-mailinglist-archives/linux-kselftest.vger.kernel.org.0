Return-Path: <linux-kselftest+bounces-26514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86722A33D30
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3471D188C3B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322592135D0;
	Thu, 13 Feb 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tk0QKQlc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704B20A5E3;
	Thu, 13 Feb 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444431; cv=none; b=evzNN/p4oqOTEGfM+4p3iHRIs4idH11RE/hgxpyL71hqfN00jIr9DPXxlfHawGTIerW81yjsw8oGjEaJCv0wYAp1tRMd/EvZ6xFnJjznssD4Om1xDFIhnfw/rkmM/EAq7xa8d0g9Pk2YqvtsVD2FCh2MobpoNr3UHEpibHfj1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444431; c=relaxed/simple;
	bh=yt4q0aiydpz/xrX8H61gkGQoaptx4FvmQGKDE/dCBJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=si9x4LrP7eomOeVZPafCoxsHThFkA9pWr5QHP9teOuMtvBTHYV7fLdjm5EZ+ECDilWfjfVTEb4ytu26bhzYwefQV9v6OUAkh4ObXCyL9DHXtsN8sVnzCIin63JSonKhOLBxHpVHp/5uhJXbIi1BOyn56NRSgPzibyLyY/N4PdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tk0QKQlc; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739444430; x=1770980430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6a76+cOw96XPtQyXhpo63qOZBEMTvYTLb5LP/CLpRQ=;
  b=tk0QKQlc3u/1SAi5Xqns1sf+D2V4YvQhH2PsiZYIr2IoWB07lP1mycKf
   UqAOMg62AMhNg9TO1We5QHcYKpY9ySyZaH0fpKMo48/sKwEJJtkGZq3hO
   UPfMzLr1HG7Pw+sAkP749yzIt/QgQGIdoG+B2LSL2eJ6hbknyFxtfiD+V
   o=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="270835605"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:00:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:61563]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id 84cbae71-03ca-491c-8392-66d89dbb8c97; Thu, 13 Feb 2025 11:00:24 +0000 (UTC)
X-Farcaster-Flow-ID: 84cbae71-03ca-491c-8392-66d89dbb8c97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 11:00:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 11:00:14 +0000
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
Subject: Re: [PATCH net-next v9 06/11] net: ipv6: Use link netns in newlink() of rtnl_link_ops
Date: Thu, 13 Feb 2025 20:00:04 +0900
Message-ID: <20250213110004.38415-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
References: <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 17:55:32 +0800
> On Thu, Feb 13, 2025 at 4:37 PM Xiao Liang <shaw.leon@gmail.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 3:05 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > >
> > [...]
> > > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > > index 863852abe8ea..108600dc716f 100644
> > > > --- a/net/ipv6/ip6_gre.c
> > > > +++ b/net/ipv6/ip6_gre.c
> > > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
> > > >       tunnel = netdev_priv(dev);
> > > >
> > > >       tunnel->dev = dev;
> > > > -     tunnel->net = dev_net(dev);
> > > > +     if (!tunnel->net)
> > > > +             tunnel->net = dev_net(dev);
> > >
> > > Same question as patch 5 for here and other parts.
> > > Do we need this check and assignment ?
> > >
> > > ip6gre_newlink_common
> > > -> nt->net = dev_net(dev)
> > > -> register_netdevice
> > >   -> ndo_init / ip6gre_tunnel_init()
> > >     -> ip6gre_tunnel_init_common
> > >       -> tunnel->net = dev_net(dev)
> >
> > Will remove this line.
> 
> However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
> tunnel->net == NULL here. Take ip6_tunnel for example:
> 
> ip6_tnl_init_net()
>     -> ip6_fb_tnl_dev_init()
>     -> register_netdev()
>         -> register_netdevice()
>             -> ip6_tnl_dev_init()
> 
> This code path (including ip6_fb_tnl_dev_init()) doesn't set
> tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.

Ah, okay.  Then, let's set net in a single place, which would
be better than spreading net assignment and adding null check
in ->ndo_init(), and maybe apply the same to IPv4 tunnels ?

