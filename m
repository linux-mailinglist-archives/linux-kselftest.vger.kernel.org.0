Return-Path: <linux-kselftest+bounces-26499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF204A33846
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 07:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D41D1889C23
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7022080EE;
	Thu, 13 Feb 2025 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WdpfLdzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917D207E1D;
	Thu, 13 Feb 2025 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429661; cv=none; b=a6dafJQ9vXAgmO41UbuPDeWyy0EDBuYoTp1fKBaqDetj17SuPkbQktt3NAKVDO8m0WVpstSM3KOJW0rwDH4dLL0ZeLbwgJG7TGd4luHlV8ZpBayW9iRmy7hBai2HYIyT9+777zm7yvic9lGjCunPKc1FimREXy3wRERQlZf9XXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429661; c=relaxed/simple;
	bh=nZV33AN7SHxF49UljDZORZmZFbtlMfPemo7/r9z68QU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kf8G2c0v8fLAteCGy9GX1cTep6WFecCPqI8YNODt8TWuxilSynYQXPujRDRSQ8q+AiiBYgkyIvvIwc7wOq9BX1fwGdplD5v3dOnn6XXd6UmdDe44iedSk9tXImjjomfUoP02ecuFfL+nPpyl5l8cqGWEUwo37156CXvBGBDF+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WdpfLdzK; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739429659; x=1770965659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJk+OOP08wb+BW+/huJFBkOKxAdi/eEFURshZRzHTxA=;
  b=WdpfLdzKdjV4Prcx6UvjJ6PZbYDK5LF455zyEUMpKSMzR87uKXFmiF0O
   +480cS10VWNM+OLm3OznnPtIv6ZStPhJwQmHxUPmeqGTD6Ym8mMLWPioo
   Q5rUhKSBQwCwG12RxaZri+54XSUOCw6v21OYly5YC9yjlLeO/uiE9Ubw4
   4=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="22171230"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:54:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:56641]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id d7a2dd72-4afe-411d-a503-05d091406983; Thu, 13 Feb 2025 06:54:17 +0000 (UTC)
X-Farcaster-Flow-ID: d7a2dd72-4afe-411d-a503-05d091406983
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 06:54:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 06:54:01 +0000
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
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into struct
Date: Thu, 13 Feb 2025 15:53:48 +0900
Message-ID: <20250213065348.8507-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-3-shaw.leon@gmail.com>
References: <20250210133002.883422-3-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:53 +0800
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
> This patch packs existing newlink() parameters, along with the source
> netns, link netns and peer netns, into a struct. The old "src_net"
> is renamed to "net" to avoid confusion with real source netns, and
> will be deprecated later. The use of src_net are converted to
> params->net trivially.
> 
> To make the semantics more clear, two helper functions -
> rtnl_newlink_link_net() and rtnl_newlink_peer_net() - are provided
> for netns fallback logic. Peer netns falls back to link netns, and
> link netns falls back to source netns.
> 
> In following patches, to prepare for creating link in target netns
> directly:
> 
>   - For device drivers that are aware of the old "src_net", the use of
>     it are replace with one of the two helper functions.
>   - And for those that takes dev_net() as link netns, we try
>     params->link_net and then dev_net(), in order to maintain
>     compatibility with the old behavior.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I left small comments below.


[...]
> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
> index 523025106a64..0f7281e3e448 100644
> --- a/include/linux/if_macvlan.h
> +++ b/include/linux/if_macvlan.h
> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct macvlan_dev *vlan,
>  
>  extern void macvlan_common_setup(struct net_device *dev);
>  
> -extern int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
> -				  struct nlattr *tb[], struct nlattr *data[],
> +struct rtnl_newlink_params;

You can just include <net/rtnetlink.h> and remove it from .c
files, then this forward declaration will be unnecessary.


> +
> +extern int macvlan_common_newlink(struct net_device *dev,
> +				  struct rtnl_newlink_params *params,
>  				  struct netlink_ext_ack *extack);
>  
>  extern void macvlan_dellink(struct net_device *dev, struct list_head *head);


[...]
> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> index bc0069a8b6ea..00c086ca0c11 100644
> --- a/include/net/rtnetlink.h
> +++ b/include/net/rtnetlink.h
> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
>  		return AF_UNSPEC;
>  }
>  
> +/**
> + *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()

The '\t' after '*' should be single '\s'.

Same for lines below.


> + *
> + *	@net: Netns of interest
> + *	@src_net: Source netns of rtnetlink socket
> + *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
> + *	@peer_net: Peer netns
> + *	@tb: IFLA_* attributes
> + *	@data: IFLA_INFO_DATA attributes
> + */
> +struct rtnl_newlink_params {

[...]
> +/* Get effective link netns from newlink params. Generally, this is link_net
> + * and falls back to src_net. But for compatibility, a driver may * choose to
> + * use dev_net(dev) instead.
> + */
> +static inline struct net *rtnl_newlink_link_net(struct rtnl_newlink_params *p)
> +{
> +	return p->link_net ? : p->src_net;
> +}
> +
> +/* Get peer netns from newlink params. Fallback to link netns if peer netns is
> + * not specified explicitly.
> + */
> +static inline struct net *rtnl_newlink_peer_net(struct rtnl_newlink_params *p)
> +{
> +	return p->peer_net ? : rtnl_newlink_link_net(p);
> +}

These helpers should belong to patch 2 ?

