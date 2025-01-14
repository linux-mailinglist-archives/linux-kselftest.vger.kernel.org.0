Return-Path: <linux-kselftest+bounces-24427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77903A0FFFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 05:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5CF188855D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 04:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21EB2253E0;
	Tue, 14 Jan 2025 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="COW1ZdIw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9924023E;
	Tue, 14 Jan 2025 04:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736830201; cv=none; b=pbYde5fm7Ox4qq8hNdUlImXGPOvWXIOmYv6U7kwnARd1b2Z64xGzCCjxfDbVSjeBgzfX3aTxaEJyscGmXZUpiD3LM5sc74gUfr2FQiKztv3OzEuT8rquJs3YupVi8xWQdsb5xHtmm1vmf7Z2eigCSrjhRyNqAv1D1v3Qt0MsfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736830201; c=relaxed/simple;
	bh=CG5ADQvDH2PcbnFujbCeqXAd7kbVHN7UAWyREHlgoEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cf03h3EbKqqkPku1QkeD4WG5PPBtMV2PLDcOxM/xtCoRtF/A00AbI1ril7/cgQvj1ec6x1Z0dxbk5lAQGy8oWdOUaAdeEZ9D8ddIfUQX2cp+a9Z+zCDDv+xAS6InI0Tuuj07gqwHShS3b5Qotx4ssy/LdsTeD1P+u3ZSGvvgAbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=COW1ZdIw; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736830201; x=1768366201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4qSpa9PKTl3u7k1DQyLqfv8mgl5yR42K0bhyD7dYtE=;
  b=COW1ZdIwZiklBml6Wt/rKHHhfhf0eL4SlXcS5jjqeHHLzX9kF+aJ6MLt
   UHKkt6j6aRIzzo2r/7GrRfWU7vwdmVX7+L+ZtGXjUtMV8k7KRAb+2pFSg
   WgRtxA6fzX2AAKW8eClhT1+Tk+4SEFJYAUeZ4LXBN96EqpoN6Fu4S+1nN
   I=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="57499934"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 04:49:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:22602]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.93:2525] with esmtp (Farcaster)
 id 7019b803-c524-49e9-8de0-4c37547d545c; Tue, 14 Jan 2025 04:49:53 +0000 (UTC)
X-Farcaster-Flow-ID: 7019b803-c524-49e9-8de0-4c37547d545c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 04:49:53 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 04:49:44 +0000
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
Subject: Re: [PATCH net-next v8 06/11] net: ipv6: Use link netns in newlink() of rtnl_link_ops
Date: Tue, 14 Jan 2025 13:49:35 +0900
Message-ID: <20250114044935.26418-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250113143719.7948-3-shaw.leon@gmail.com>
References: <20250113143719.7948-3-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 13 Jan 2025 22:37:14 +0800
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 2a6a424806aa..ac5e402c34bc 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -564,10 +564,12 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>  	return 0;
>  }
>  
> -static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
> -			struct nlattr *tb[], struct nlattr *data[],
> +static int bond_newlink(struct net_device *bond_dev,
> +			struct rtnl_newlink_params *params,
>  			struct netlink_ext_ack *extack)
>  {
> +	struct nlattr **data = params->data;
> +	struct nlattr **tb = params->tb;
>  	int err;
>  
>  	err = bond_changelink(bond_dev, tb, data, extack);

Note that IFLA_BOND_ACTIVE_SLAVE uses dev_net(dev) for
__dev_get_by_index().


[...]
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index fed4fe2a4748..0c496aa1f706 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1565,11 +1565,12 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(macvlan_common_newlink);
>  
> -static int macvlan_newlink(struct net *src_net, struct net_device *dev,
> -			   struct nlattr *tb[], struct nlattr *data[],
> +static int macvlan_newlink(struct net_device *dev,
> +			   struct rtnl_newlink_params *params,
>  			   struct netlink_ext_ack *extack)
>  {
> -	return macvlan_common_newlink(src_net, dev, tb, data, extack);
> +	return macvlan_common_newlink(params->net, dev, params->tb,
> +				      params->data, extack);

Pass params as is as you did for ipvlan_link_new().

Same for macvtap_newlink().


[...]
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 1e1b00756be7..1e9eadc77da2 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -327,10 +327,13 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
>  
>  static struct rtnl_link_ops netkit_link_ops;
>  
> -static int netkit_new_link(struct net *peer_net, struct net_device *dev,
> -			   struct nlattr *tb[], struct nlattr *data[],
> +static int netkit_new_link(struct net_device *dev,
> +			   struct rtnl_newlink_params *params,
>  			   struct netlink_ext_ack *extack)
>  {
> +	struct nlattr **data = params->data;
> +	struct net *peer_net = params->net;
> +	struct nlattr **tb = params->tb;

nit: please keep the reverse xmas tree order.


>  	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;

you can define *tbp here and initialise it later.

  	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp, *attr;

>  	enum netkit_action policy_prim = NETKIT_PASS;
>  	enum netkit_action policy_peer = NETKIT_PASS;


[...]
> @@ -1064,6 +1067,11 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
>  	struct net_device *dev;
>  	struct nlmsghdr *nlh;
>  	struct sk_buff *msg;
> +	struct rtnl_newlink_params params = {
> +		.net = &init_net,
> +		.tb = tb,
> +		.data = data,
> +	};

nit: Reverse xmas tree order


[...]
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ec98349b9620..7ff5e96f6ba7 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3766,6 +3766,14 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
>  	struct net_device *dev;
>  	char ifname[IFNAMSIZ];
>  	int err;
> +	struct rtnl_newlink_params params = {

nit: Reverse xmas tree order


> +		.net = net,

Use sock_net(skb->sk) directly here and remove net defined above,
which is no longer used in this function.

---8<---
        unsigned char name_assign_type = NET_NAME_USER;
        struct rtnl_newlink_params params = {
                .net = sock_net(skb->sk),
                .src_net = net,
                .link_net = link_net,
                .peer_net = peer_net,
                .tb = tb,
                .data = data,
        };
        u32 portid = NETLINK_CB(skb).portid;
---8<---


[...]
> @@ -1698,6 +1702,10 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
>  	LIST_HEAD(list_kill);
>  	struct ip_tunnel *t;
>  	int err;
> +	struct rtnl_newlink_params params = {
> +		.net = net,
> +		.tb = tb,
> +	};
>  
>  	memset(&tb, 0, sizeof(tb));

nit: Reverse xmas tree

