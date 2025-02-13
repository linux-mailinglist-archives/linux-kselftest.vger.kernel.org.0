Return-Path: <linux-kselftest+bounces-26497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE2EA337D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 07:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E7D188AD4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75A1207A0C;
	Thu, 13 Feb 2025 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lD82rsbR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D920766E;
	Thu, 13 Feb 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427652; cv=none; b=KPamYYd/kfAiLkNVwM9frj9ZfXkJbpUsAJHYtXbC86STbmtuDG0Fp3qWKYLgmW7s2FkjHcwtGG05XHEjPI8DLGK87XEljsjjgrBnphAYGQ4OxtPFzJSK5rZc9WvNCFGEJKNer+K/SY2YZlNGcA28RZ7oR9q+Qy1nfFhUsKORy44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427652; c=relaxed/simple;
	bh=yi8Ds+rvTqCkr4AEhdDx106k9cpqjnHqkzb+kOgIoPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0qjCe4fcGytDkPlpHQQGmKhvu4i/roiwN5zae3sPApBE37LsriDE4dIGEPYDHLuSfj59zJoIoN7UtpScREXiPAzgSm6D2leJvbaCrYaBdBbErMeTnac/yIk9tRuZRYUEs7PY6+k4/+vWzJiDiAB85isruIJ+ZxJ6SgB1PcTv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lD82rsbR; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739427651; x=1770963651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0qqspgyXFQAiVZhV1is4ipJluGgHz+aCeCybrjLYs8=;
  b=lD82rsbRUA1s05HFp36u9KEP2nYnQQfURmf2nx3i+VvSSFd2YRte+adE
   JzCPoOmLzU3sZcJJHmDzIUJM7SBlt7FnW09PVvIx+caneYm1mSQE9ayC3
   AkzngNe3/QJ9ZpepPVQTsgOhLlQZerpNgdafxGeFMFUJv1mYgl/qFLG7y
   4=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="169268254"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:20:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:11164]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id 6c86040e-10d2-4a2e-98fc-c45ba71a877d; Thu, 13 Feb 2025 06:20:48 +0000 (UTC)
X-Farcaster-Flow-ID: 6c86040e-10d2-4a2e-98fc-c45ba71a877d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 06:20:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 06:20:40 +0000
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
Subject: Re: [PATCH net-next v9 05/11] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Thu, 13 Feb 2025 15:20:31 +0900
Message-ID: <20250213062031.4547-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-6-shaw.leon@gmail.com>
References: <20250210133002.883422-6-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:56 +0800
> When link_net is set, use it as link netns instead of dev_net(). This
> prepares for rtnetlink core to create device in target netns directly,
> in which case the two namespaces may be different.
> 
> Convert common ip_tunnel_newlink() to accept an extra link netns
> argument. Don't overwrite ip_tunnel.net in ip_tunnel_init().

Why... ?  see a comment below.


[...]
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 1fe9b13d351c..26d15f907551 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1413,7 +1413,8 @@ static int ipgre_newlink(struct net_device *dev,
>  	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
>  	if (err < 0)
>  		return err;
> -	return ip_tunnel_newlink(dev, tb, &p, fwmark);
> +	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,

This is duplicate at all call sites, let's move it into
ip_tunnel_newlink() by passing params.


> +				 fwmark);
>  }
>  
>  static int erspan_newlink(struct net_device *dev,
> 
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 09b73acf037a..618a50d5c0c2 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
>  }
>  EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
>  
> -int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
> -		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
> +int ip_tunnel_newlink(struct net *net, struct net_device *dev,
> +		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
> +		      __u32 fwmark)
>  {
>  	struct ip_tunnel *nt;
> -	struct net *net = dev_net(dev);
>  	struct ip_tunnel_net *itn;
>  	int mtu;
>  	int err;
> @@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
>  	}
>  
>  	tunnel->dev = dev;
> -	tunnel->net = dev_net(dev);
> +	if (!tunnel->net)
> +		tunnel->net = dev_net(dev);

Isn't tunnel->net always non-NULL ?

ip_tunnel_newlink
-> netdev_priv(dev)->net = net
-> register_netdevice(dev)
  -> dev->netdev_ops->ndo_init(dev)
    -> ip_tunnel_init(dev)
      -> netdev_priv(dev)->net = dev_net(dev)

