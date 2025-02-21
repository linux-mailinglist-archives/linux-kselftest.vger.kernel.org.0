Return-Path: <linux-kselftest+bounces-27130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6DA3EB97
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 05:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94ED53B9114
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 04:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA11F8EFC;
	Fri, 21 Feb 2025 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j2ICIJh6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB82A1C9;
	Fri, 21 Feb 2025 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740110832; cv=none; b=AZI3Sc+SsrqyluHaEVdqTOOSv1VFsSj09d2RUwQWBiR5vAquBAjw3omIJpz7TFYd9hKGldRitHXxHCP2ijxPNcCGll+C0CXtWsCkj5YbCV4It4GJ/xo3Q2OL6/d7cWOwcOXZax3GazGAOJOw1Cnd1mZpmqQwA+ZSrMJKLWmtxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740110832; c=relaxed/simple;
	bh=GdpHKn3K97vSsRdy53s5lxOxzv2f9wU9DSHD/AKaplA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9vzq1QgeEzYhrur8GM9/R+GTuo8I12qaw31rb8xucLFgIG5KW1mIlf0UaThQyZWrXuRkBTPIw2g3SvES1q2JEZYNVfeFNZPC67CZi7HKQQTj1GkRFa2FCXawRRHrbflGv0zKZFmtWyQ2wPzHvfybjwB7rHwfUjIcu+Ll9dYxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=j2ICIJh6; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740110831; x=1771646831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tKX8JdqFzrTi/1BQO/FO5wDgGYCQeQS6PgW1/5We6so=;
  b=j2ICIJh65csevEzUP2kgHy/e1h803N9wfmp92gk1wGMRDvHbzRgqiujk
   OHsS8iZ/4dIhlwxRQ7bS5H9KZHbnXQLwNv+mwTPqlVz3oYIV/pioZIHWB
   6jgDCy79c/W23Np6Q3w89uaJYWPTwUmmVwfSYBkhmHdStenvEPewrKioA
   8=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200"; 
   d="scan'208";a="67970952"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:06:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:51376]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id fca782d6-17f8-4d01-a8eb-9a81adbd66b0; Fri, 21 Feb 2025 04:06:56 +0000 (UTC)
X-Farcaster-Flow-ID: fca782d6-17f8-4d01-a8eb-9a81adbd66b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:06:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:06:50 +0000
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
Subject: Re: [PATCH net-next v10 07/13] net: ipv6: Init tunnel link-netns before registering dev
Date: Thu, 20 Feb 2025 20:06:41 -0800
Message-ID: <20250221040641.77646-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-8-shaw.leon@gmail.com>
References: <20250219125039.18024-8-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:33 +0800
> Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
> ndo_init(), which is called in register_netdevice(). However, it lacks
> the context of link-netns when we enable cross-net tunnels at device
> registration time.
> 
> Let's move the init of tunnel link-netns before register_netdevice().
> 
> ip6_gre has already initialized netns, so just remove the redundant
> assignment.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

left a small comment, but not a blocker.


> @@ -1565,6 +1565,7 @@ static int ipip6_newlink(struct net_device *dev,
>  	int err;
>  
>  	nt = netdev_priv(dev);
> +	nt->net = net;

This hunk is not necessary as we'll call ipip6_tunnel_locate(),
but it's harmless and not worth reposting the whole series given
we are alredy in v10.  You can just post a follow-up patch after
the series is applied.

Thanks!

