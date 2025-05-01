Return-Path: <linux-kselftest+bounces-32065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC11AA5B52
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 09:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8CE9C2570
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E807262813;
	Thu,  1 May 2025 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="piT+hAhN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873CF213255;
	Thu,  1 May 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746083604; cv=none; b=A/lw/V+0ezLpUY8kwo82RoSdMBP1sZGBoOhwW7qhYBFgvbIXEpl0YrT3mGCuA3imSFW4Ov/5ivWtncIr4X1v1FmQSFWL6vcZK+N+PQ5MV92MD8iTw01YchYnPGcnxY33FKtFtN4O6qaN8mI5WhHSoQF9+dPudLdAxhiWl5u3mTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746083604; c=relaxed/simple;
	bh=zPYU6GYNdy0mMALSF3glm6SldvCR75nV5Wr/ewBREMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdrA2KP4jVj42E+0wnZQtnDV2Izwpz7ilyJ1RKz8ZRazq1mOH/ZO6iNCpWtNjk1wDtRSntsmccvZ4sjHmjBD+ap26tgBHKsFy6N4/FULWvdp929bEyf4MZjHNpGtHzacDfXRjnrlRElCGff/4HTaQb19wR0oORPJP17tq4cYey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=piT+hAhN; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746083602; x=1777619602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vx0+NHqu1wQYPq/J+n4ZB7E7XDRzuoqX7tjLl8vX3Gc=;
  b=piT+hAhN1GgAsvekVq13STCGXudkscunKP8ilmMCcn8ARjKXG4In+XuP
   Q4OxKry8KbQuxu+HVbFKGxD/Az14HBdty0UpyDkJjYdC6I8R56YqXvf7u
   sMYFG9W8v+FBg9zlw9mEoQwiPRppLqKL3OakOxSw5Uf+xejkbxJp7qn8E
   E=;
X-IronPort-AV: E=Sophos;i="6.15,253,1739836800"; 
   d="scan'208";a="45627745"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 07:13:21 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:1121]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.105:2525] with esmtp (Farcaster)
 id cfb02766-30b7-414e-8a08-12f6538f65e7; Thu, 1 May 2025 07:13:20 +0000 (UTC)
X-Farcaster-Flow-ID: cfb02766-30b7-414e-8a08-12f6538f65e7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 07:13:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 07:13:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jiayuan.chen@linux.dev>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC net-next v1 1/2] udp: Introduce UDP_STOP_RCV option for UDP
Date: Thu, 1 May 2025 00:12:08 -0700
Message-ID: <20250501071308.1931-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <1f4d3fb4eed397e346efb3ef597e29204e5a2f4b@linux.dev>
References: <1f4d3fb4eed397e346efb3ef597e29204e5a2f4b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Date: Thu, 01 May 2025 06:22:17 +0000
> 2025/5/1 12:42, "Kuniyuki Iwashima" <kuniyu@amazon.com> wrote:
> 
> > 
> > From: Jiayuan Chen <jiayuan.chen@linux.dev>
> > 
> > Date: Thu, 1 May 2025 11:51:08 +0800
> > 
> > > 
> > > For some services we are using "established-over-unconnected" model.
> > > 
> > >  
> > > 
> > >  '''
> > > 
> > >  // create unconnected socket and 'listen()'
> > > 
> > >  srv_fd = socket(AF_INET, SOCK_DGRAM)
> > > 
> > >  setsockopt(srv_fd, SO_REUSEPORT)
> > > 
> > >  bind(srv_fd, SERVER_ADDR, SERVER_PORT)
> > > 
> > >  
> > > 
> > >  // 'accept()'
> > > 
> > >  data, client_addr = recvmsg(srv_fd)
> > > 
> > >  
> > > 
> > >  // create a connected socket for this request
> > > 
> > >  cli_fd = socket(AF_INET, SOCK_DGRAM)
> > > 
> > >  setsockopt(cli_fd, SO_REUSEPORT)
> > > 
> > >  bind(cli_fd, SERVER_ADDR, SERVER_PORT)
> > > 
> > >  connect(cli, client_addr)
> > > 
> > >  ...
> > > 
> > >  // do handshake with cli_fd
> > > 
> > >  '''
> > > 
> > >  
> > > 
> > >  This programming pattern simulates accept() using UDP, creating a new
> > > 
> > >  socket for each client request. The server can then use separate sockets
> > > 
> > >  to handle client requests, avoiding the need to use a single UDP socket
> > > 
> > >  for I/O transmission.
> > > 
> > >  
> > > 
> > >  But there is a race condition between the bind() and connect() of the
> > > 
> > >  connected socket:
> > > 
> > >  We might receive unexpected packets belonging to the unconnected socket
> > > 
> > >  before connect() is executed, which is not what we need.
> > > 
> > >  (Of course, before connect(), the unconnected socket will also receive
> > > 
> > >  packets from the connected socket, which is easily resolved because
> > > 
> > >  upper-layer protocols typically require explicit boundaries, and we
> > > 
> > >  receive a complete packet before creating a connected socket.)
> > > 
> > >  
> > > 
> > >  Before this patch, the connected socket had to filter requests at recvmsg
> > > 
> > >  time, acting as a dispatcher to some extent. With this patch, we can
> > > 
> > >  consider the bind and connect operations to be atomic.
> > > 
> > 
> > SO_ATTACH_REUSEPORT_EBPF is what you want.
> > 
> > The socket won't receive any packets until the socket is added to
> > 
> > the BPF map.
> > 
> > No need to reinvent a subset of BPF functionalities.
> >
> 
> I think this feature is for selecting one socket, not filtering out certain
> sockets.
> 
> Does this mean that I need to first capture all sockets bound to the same
> port, and then if the kernel selects a socket that I don't want to receive
> packets on, I'll need to implement an algorithm in the BPF program to
> choose another socket from the ones I've captured, in order to avoid
> returning that socket?

Right.

If you want a set of sockets to listen on the port, you can implement
as such with BPF; register the sockets to the BPF map, and if kernel pick
up other sockets and triggers the BPF prog, just return one of the
registerd sk.

Even when you have connect()ed sockets on the same port, kernel will
fall back to the normal scoring to find the best one, and it's not a
problem as the last 'result' is one selected by BPF or a connected sk,
and the packet won't be routed to not-yet-registered unconnected sk.


> 
> This looks like it completely bypasses the kernel's built-in scoring
> logic. Or is expanding BPF_PROG_TYPE_SK_REUSEPORT to have filtering
> capabilities also an acceptable solution?

