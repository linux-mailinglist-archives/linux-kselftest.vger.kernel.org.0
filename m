Return-Path: <linux-kselftest+bounces-32062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 221BDAA5A5B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 06:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D941C019CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 04:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25834231841;
	Thu,  1 May 2025 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fDapGKHo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545FA230BFD;
	Thu,  1 May 2025 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746074621; cv=none; b=A2NKFHtBdljy10BSXrvd0y7mVawdCpp5n+DDsviiJP/H8XN3CEga+BVGfaoPf70z+6OpyMEnDHQwpVGlrpG46IikfDK6jNbXiGVqtPGsWGEfEmpdPKHskPwdooBMkJbqLNSFQmkwrUb8hC1C9UafqKaVvK57ZLLklvSENzmb79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746074621; c=relaxed/simple;
	bh=FJMIZAAlsRBCDZIUUWk6FiHiAllsWImKRgkb2mx31Tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSG1hKfIhMKtKrQrsElP0QJCUXi8qeEr6fQaE0fF6rzcNxeMaXXRvf4hZQhsEJt89VgyqF31+x3iZ3+OnlanU2aNze/PgYAoPzpjqgay9xZSQdLWkhlh2DOv75ZLZJTIdhR4Z0PGyYjwRjjTLg1/gYCqe1q9L9Np70R/mYbBL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fDapGKHo; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746074620; x=1777610620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nmWVsEqVJv451jTaseIeYwxvxKSGxFUAPewNfehCRt4=;
  b=fDapGKHoTVq3CO5WEwd5lB8lShsCdFglQ0/S7q/ksnOOn2zW5+0+MugO
   1vLRBSOAbHcTiTfjqgNRRCriAne4hpP80KWvQQTPVq0Hfg8RWd4R1STXn
   D74oq4Bmvo0kjZ6cVS1aYz5m53WIHLjYlqLYexQWGGujvKEQ4awv0pUvT
   w=;
X-IronPort-AV: E=Sophos;i="6.15,253,1739836800"; 
   d="scan'208";a="820675791"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 04:43:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:40716]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id f5294a6a-507c-4dca-b1cc-456173d24f3b; Thu, 1 May 2025 04:43:33 +0000 (UTC)
X-Farcaster-Flow-ID: f5294a6a-507c-4dca-b1cc-456173d24f3b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 04:43:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 04:43:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jiayuan.chen@linux.dev>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC net-next v1 1/2] udp: Introduce UDP_STOP_RCV option for UDP
Date: Wed, 30 Apr 2025 21:42:24 -0700
Message-ID: <20250501044321.83028-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501035116.69391-1-jiayuan.chen@linux.dev>
References: <20250501035116.69391-1-jiayuan.chen@linux.dev>
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

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Thu,  1 May 2025 11:51:08 +0800
> For some services we are using "established-over-unconnected" model.
> 
> '''
> // create unconnected socket and 'listen()'
> srv_fd = socket(AF_INET, SOCK_DGRAM)
> setsockopt(srv_fd, SO_REUSEPORT)
> bind(srv_fd, SERVER_ADDR, SERVER_PORT)
> 
> // 'accept()'
> data, client_addr = recvmsg(srv_fd)
> 
> // create a connected socket for this request
> cli_fd = socket(AF_INET, SOCK_DGRAM)
> setsockopt(cli_fd, SO_REUSEPORT)
> bind(cli_fd, SERVER_ADDR, SERVER_PORT)
> connect(cli, client_addr)
> ...
> // do handshake with cli_fd
> '''
> 
> This programming pattern simulates accept() using UDP, creating a new
> socket for each client request. The server can then use separate sockets
> to handle client requests, avoiding the need to use a single UDP socket
> for I/O transmission.
> 
> But there is a race condition between the bind() and connect() of the
> connected socket:
> We might receive unexpected packets belonging to the unconnected socket
> before connect() is executed, which is not what we need.
> (Of course, before connect(), the unconnected socket will also receive
> packets from the connected socket, which is easily resolved because
> upper-layer protocols typically require explicit boundaries, and we
> receive a complete packet before creating a connected socket.)
> 
> Before this patch, the connected socket had to filter requests at recvmsg
> time, acting as a dispatcher to some extent. With this patch, we can
> consider the bind and connect operations to be atomic.

SO_ATTACH_REUSEPORT_EBPF is what you want.

The socket won't receive any packets until the socket is added to
the BPF map.

No need to reinvent a subset of BPF functionalities.

