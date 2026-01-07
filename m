Return-Path: <linux-kselftest+bounces-48443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB21D00641
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 00:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36AC33012746
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 23:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0421B2F4A14;
	Wed,  7 Jan 2026 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g721AQMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBF1534EC;
	Wed,  7 Jan 2026 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828368; cv=none; b=BdgE3jJ5D3s2vB0TqJZpJvSBk5dV3D0nhiLRVL+hrB2gJ8AWTDz1MsfHO4vxJg9aIvX0DvWNRlTze4xdIFP98+Ef6ZTZK4O9HaZrNEGwrw5f4nE/dOrjxCNaGTBtZpiAU+KeyimpfLHjCPs7yMULeyvniCCT+jQRpStf01qDYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828368; c=relaxed/simple;
	bh=GDfF3beoIj2+JIdkwa+FLR8Ai72iWdivJ31XxrF8XSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aba9KiqZlUoQEn9G8AAbSpsD/38RHUHgGIo4hw/aTplHz6F0jX3eZSXONj036ESe08lSG1GnUhOqcchOH5e1r5K5WQzl8vCBh/a5uWUZwpc+hD4TOZ5XsdvjsCOUDp8kC5IfK6+cjkbHaNYtPwnVms2qC46wOdFSqYdqlUNqTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g721AQMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C77C4CEF1;
	Wed,  7 Jan 2026 23:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767828367;
	bh=GDfF3beoIj2+JIdkwa+FLR8Ai72iWdivJ31XxrF8XSM=;
	h=From:To:Cc:Subject:Date:From;
	b=g721AQMZV8//ZwACaEJgkCUpsEwXLuI45j88Tx+wLAIBEjIras8Qq1ubOfceleQd+
	 56UT6gOYyi2VWv17TxgSp3JlhvtJptcF0/kg5rLvMX/cDUq0scl1CzTWUxJK2jDGBQ
	 +eWIuacP82BgzuYhzhlBwBEtkmN7YX52QK7lonNUtL5rcP/9spmuXpDXYY+5UOxIBY
	 eAVZaNtERK2L1+v/wWX7+o7X1n5h1gTpzKFGoWTkhOZeEAn3PBNkVpzbuvqtpJa+Xr
	 jOfPwgrVPY96ScbIM03jW88pc0bokiOqcqGVyxPs5AXRDxHbHG1qz+c+9P5iKAoLWU
	 ZqxI9z7VwErhw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	willemb@google.com,
	anubhavsinggh@google.com,
	mohsin.bashr@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: gro: increase the rcvbuf size
Date: Wed,  7 Jan 2026 15:25:57 -0800
Message-ID: <20260107232557.2147760-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gro.py test (testing software GRO) is slightly flaky when
running against fbnic. We see one flake per roughly 20 runs in NIPA,
mostly in ipip.large, and always including some EAGAIN:

  # Shouldn't coalesce if exceed IP max pkt size: Test succeeded
  # Expected {65475 899 }, Total 2 packets
  # Received {65475 899 }, Total 2 packets.
  # Expected {64576 900 900 }, Total 3 packets
  # Received {64576 /home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/gro: could not receive: Resource temporarily unavailable

The test sends 2 large frames (64k + change). Looks like the default
packet socket rcvbuf (~200kB) may not be large enough to hold them.
Bump the rcvbuf to 1MB.

Add a debug print showing socket statistics to make debugging this
issue easier in the future. Without the rcvbuf increase we see:

  # Shouldn't coalesce if exceed IP max pkt size: Test succeeded
  # Expected {65475 899 }, Total 2 packets
  # Received {65475 899 }, Total 2 packets.
  # Expected {64576 900 900 }, Total 3 packets
  # Received {64576 Socket stats: packets=7, drops=3
                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # /home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/gro: could not receive: Resource temporarily unavailable

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: willemb@google.com
CC: anubhavsinggh@google.com
CC: mohsin.bashr@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/gro.c | 25 ++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e894037d2e3e..751a8103f408 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -926,6 +926,28 @@ static void set_timeout(int fd)
 		error(1, errno, "cannot set timeout, setsockopt failed");
 }
 
+static void set_rcvbuf(int fd)
+{
+	int bufsize = 1 * 1024 * 1024; /* 1 MB */
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &bufsize, sizeof(bufsize)))
+		error(1, errno, "cannot set rcvbuf size, setsockopt failed");
+}
+
+static void recv_error(int fd, int rcv_errno)
+{
+	struct tpacket_stats stats;
+	socklen_t len;
+
+	len = sizeof(stats);
+	if (getsockopt(fd, SOL_PACKET, PACKET_STATISTICS, &stats, &len))
+		error(1, errno, "can't get stats");
+
+	fprintf(stderr, "Socket stats: packets=%u, drops=%u\n",
+		stats.tp_packets, stats.tp_drops);
+	error(1, rcv_errno, "could not receive");
+}
+
 static void check_recv_pkts(int fd, int *correct_payload,
 			    int correct_num_pkts)
 {
@@ -950,7 +972,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
 		ip_ext_len = 0;
 		pkt_size = recv(fd, buffer, IP_MAXPACKET + ETH_HLEN + 1, 0);
 		if (pkt_size < 0)
-			error(1, errno, "could not receive");
+			recv_error(fd, errno);
 
 		if (iph->version == 4)
 			ip_ext_len = (iph->ihl - 5) * 4;
@@ -1126,6 +1148,7 @@ static void gro_receiver(void)
 		error(1, 0, "socket creation");
 	setup_sock_filter(rxfd);
 	set_timeout(rxfd);
+	set_rcvbuf(rxfd);
 	bind_packetsocket(rxfd);
 
 	ksft_ready();
-- 
2.52.0


