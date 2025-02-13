Return-Path: <linux-kselftest+bounces-26501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CDDA3387C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 08:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609517A3E4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3B207DFB;
	Thu, 13 Feb 2025 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QgfaSyLr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9F20764A;
	Thu, 13 Feb 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430358; cv=none; b=Ge3JwAu16qDyA+sPwZ3b/HstrfdVrB40OqvYx7G0foin6/MkQFrQDWLoRfdx70og90UM3U4MSAs2ALTEB21Rsp0+X1Vxjvcf7EM2lBSdaTJKH/KULQzuU8pMUf4MtNJ1KoInGP7cqqbi1yv2cP8vYWwf+DNC5/9CE9TFKMifgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430358; c=relaxed/simple;
	bh=kmgtqvckZ0e6iFNH8XDXdMK5sQI2GFWf7IJ95MBADfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5gWreDSseocFp+5sW6swJWeKNKPHwe+tp2E7y4Ef59dfBikrDYmZzKPoJTvv5Y4A7lJ2C6/luZTV0J4Z2jlSuDgaf9D5D67oAhubxb+nN0W/cxfA7UwQeBmlfSLkgj1UAqfFHKWc89YkWCKXditO9czA0CailBD7mF+LixWabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QgfaSyLr; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739430357; x=1770966357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HIz1Atlqpi5tnoN7n4BPu3eHETPxx2TUlMkVpEwhuEo=;
  b=QgfaSyLrgHl/mTSXPfa1O1cScChJD9IlWGd8eMDbkZuzCWMyBI5znAao
   +oebj9g9O3QcE4mKdwnQ324nwwAjpwy0Ll9o74E1a4i7iPpaPXhr9EYbH
   Bz+dF79qwKu5tSpHFMLm+9JFzuSw5Q33bGG/M3J5HJNyiPfAy7o+cNlGM
   w=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="462133403"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:05:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:18133]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id 044845a0-eb50-4d20-a33f-ef53eec55ed0; Thu, 13 Feb 2025 07:05:50 +0000 (UTC)
X-Farcaster-Flow-ID: 044845a0-eb50-4d20-a33f-ef53eec55ed0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 07:05:50 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 07:05:42 +0000
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
Date: Thu, 13 Feb 2025 16:05:33 +0900
Message-ID: <20250213070533.9926-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-7-shaw.leon@gmail.com>
References: <20250210133002.883422-7-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:57 +0800
> When link_net is set, use it as link netns instead of dev_net(). This
> prepares for rtnetlink core to create device in target netns directly,
> in which case the two namespaces may be different.
> 
> Set correct netns in priv before registering device, and avoid
> overwriting it in ndo_init() path.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  net/ipv6/ip6_gre.c    | 20 ++++++++++----------
>  net/ipv6/ip6_tunnel.c | 13 ++++++++-----
>  net/ipv6/ip6_vti.c    | 10 ++++++----
>  net/ipv6/sit.c        | 11 +++++++----
>  4 files changed, 31 insertions(+), 23 deletions(-)
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 863852abe8ea..108600dc716f 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
>  	tunnel = netdev_priv(dev);
>  
>  	tunnel->dev = dev;
> -	tunnel->net = dev_net(dev);
> +	if (!tunnel->net)
> +		tunnel->net = dev_net(dev);

Same question as patch 5 for here and other parts.
Do we need this check and assignment ?

ip6gre_newlink_common
-> nt->net = dev_net(dev)
-> register_netdevice
  -> ndo_init / ip6gre_tunnel_init()
    -> ip6gre_tunnel_init_common
      -> tunnel->net = dev_net(dev)

