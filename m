Return-Path: <linux-kselftest+bounces-26496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253E9A33780
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 06:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD113A929D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 05:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEEE206F09;
	Thu, 13 Feb 2025 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nwD1LstI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AEEC4;
	Thu, 13 Feb 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425761; cv=none; b=W/gCcg/krm92sU5LgC8PIu257m8uB+JaMZvcmtrHEFnyQBynWylvie1HHuRJKUhVXbhQ3w84+GZZ/gZfjAMw4Dlr8j65da840jUiA+r5ACdMCESUC81Ssqokso9htu73nyA5JX0Xhb2V3WGfJzP3EZ9PmtTpvK/fA7PLmg3xaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425761; c=relaxed/simple;
	bh=JZO8hTv+tJW2aK5aBTAN6q5T0bbD7q/X0NgiV9zstAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzLT03bdJi4baPjIoiWkQM/dxnozna6rG+gqZFzrZof0cdsqds2wwaj0+6xY0c7HRxDlgTmTnXPamHsVV5RnalWMWs+kU0AjlIDC8Rtf8CHc9lEPyzPHCk9qNc+7reI7Yln6ai7EnLWx5VMzxVuANZQH+lw58TLMFwjFYuAbqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nwD1LstI; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739425760; x=1770961760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2H6L2IVdEyIK/cEvvFHgSWxdXbDY3pM4JrV+qKQ3oRc=;
  b=nwD1LstIkQvD8ffPyPrZevRMPI3+41cyFCrQF0TC6xlj8S0pfaFZgLPO
   3P/XI66tK5WRqgtPMy2aC9JLg11Ma1YuTBr0SYTzuPqhKX8eVenq5pJQP
   bPbhjwlJJGGGO3+Etl4NIF8hsOXVM0ZZc9LMJ5m2ASxZJfr0tXLJaDGLg
   g=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="471752672"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:49:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:24405]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525] with esmtp (Farcaster)
 id 4661396c-a15f-4263-9318-13d4ea54af5c; Thu, 13 Feb 2025 05:49:12 +0000 (UTC)
X-Farcaster-Flow-ID: 4661396c-a15f-4263-9318-13d4ea54af5c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 05:49:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 05:49:03 +0000
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
Subject: Re: [PATCH net-next v9 04/11] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
Date: Thu, 13 Feb 2025 14:48:53 +0900
Message-ID: <20250213054853.285-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210133002.883422-5-shaw.leon@gmail.com>
References: <20250210133002.883422-5-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 10 Feb 2025 21:29:55 +0800
> Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
> source netns by design, but 6lowpan uses dev_net.
> 
> Note dev->netns_local is set to true and currently link_net is
> implemented via a netns change. These together effectively reject
> IFLA_LINK_NETNSID.
> 
> This patch adds a validation to ensure link_net is either NULL or
> identical to dev_net. Thus it would be fine to continue using dev_net
> when rtnetlink core begins to create devices directly in target netns.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

