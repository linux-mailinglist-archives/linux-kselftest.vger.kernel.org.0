Return-Path: <linux-kselftest+bounces-26500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66DA33855
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 07:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63DA1680B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95CB207DF3;
	Thu, 13 Feb 2025 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BRoMzwdc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D9207A11;
	Thu, 13 Feb 2025 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429733; cv=none; b=LwnnpIJUcJK25DC5UDs2v8hVgR9owPF8LEb1w7wL23/7OHNF1c32go+so4q31q7noTjh5t6q9/UWoQmzEwmcovYxlp4gFOYXXyRTDqD+ytIWO0DFi11FfqY2EusmLJM7XCsax7CUcth5ro4RL+Ajr4MgCwY7wvUO9hsBmN4LHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429733; c=relaxed/simple;
	bh=pzVOa8TMmsifg2ueyS/bcaAb3MJ+O9q9vr126AjlrS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtkdqHUtrOdVBnLMI+VqTIyNdqCEuakBOp4PJ2Xe9xHNQOjCbxJv6nbWdCF5FPPSZoRfJtiVG4iAllEaTpWAR7V98bgsMX0bYId52jTjfcrgNiGHT1BNG3o4QMAwOX78uMqQeYn6QRR2kDpkGkXN80M4llw+cTwfRADyJT4b//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BRoMzwdc; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739429732; x=1770965732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6vhqwcHgjQ9crHQuKcOHH1ChdkHGoRglO+wy/6/WSQ=;
  b=BRoMzwdc+AnxqWgne0up9L8FJBjQaVL9uR+IbjaLD3JwayzTK+RILbcW
   LXAnW8tEsY+3NLzvY5Gim7wBX/ALwZG4a6bCQa5YVaMXtw+QAfiaUayYU
   B0lslLmJOpdfzpSPbCe3CmXg8JZjeoksQgR+5+SMwJ16I3xLRaJarQYwJ
   s=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="270777830"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:55:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:9280]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.246:2525] with esmtp (Farcaster)
 id 0c153c97-2bf1-4a6b-942d-4cbd218ce4f6; Thu, 13 Feb 2025 06:55:25 +0000 (UTC)
X-Farcaster-Flow-ID: 0c153c97-2bf1-4a6b-942d-4cbd218ce4f6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 06:55:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 06:55:16 +0000
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
Subject: Re: [PATCH net-next v9 03/11] net: Use link netns in newlink() of rtnl_link_ops
Date: Thu, 13 Feb 2025 15:55:06 +0900
Message-ID: <20250213065506.8720-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-4-shaw.leon@gmail.com>
References: <20250210133002.883422-4-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:54 +0800
> These netdevice drivers already uses netns parameter in newlink()
> callback. Convert them to use rtnl_newlink_link_net() or
> rtnl_newlink_peer_net() for clarity and deprecate params->net.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 8151e91395e2..ab7e5b6649b2 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -122,8 +122,8 @@ static int rmnet_newlink(struct net_device *dev,
>  			 struct netlink_ext_ack *extack)
>  {
>  	u32 data_format = RMNET_FLAGS_INGRESS_DEAGGREGATION;
> +	struct net *link_net = rtnl_newlink_link_net(params);

nit: reverse xmas tree


>  	struct nlattr **data = params->data;
> -	struct net *src_net = params->net;
>  	struct nlattr **tb = params->tb;
>  	struct net_device *real_dev;
>  	int mode = RMNET_EPMODE_VND;

