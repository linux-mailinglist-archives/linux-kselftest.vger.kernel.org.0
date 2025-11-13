Return-Path: <linux-kselftest+bounces-45549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41EAC5882C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77A73BACA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114234D395;
	Thu, 13 Nov 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnB/RU3e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73F34A3B1;
	Thu, 13 Nov 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047631; cv=none; b=Pvdlht9MPGmbWZxgxPc66qP4SVxLj0yNzfBG8g1Vje0t7TCzgVtwHQ0jzeTYtpLD2rp1kKMfkt8Nq1iuTz1Nar+/JkioQKYORlBE6n4hp3T4Zpd9aJ83HixvTqcqh1HrnJ9ZFW0bSj7mUb4ZBd1PEbKymFt7ZjerOSWtQNi3VgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047631; c=relaxed/simple;
	bh=5eaPFfI+HlHbNzT3zzfguX5CVQKRrLGDBh5wEdnnF2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOa8Bl7ltxXJoDJZUKS5oXSH8ZndmDwlSZTPKp1usyZ5IaaRLepXhy3ClTF7LJeTSRKldqx9DJxkqRnDGwlXYrV6G4y5ZDAM6FN0GDANXV5s0IwygVTeiX8opK/H7nnuIuYeNfZMg/PLE/aVjcUr7ft1L9/P6JNPH+xjXAtqs7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnB/RU3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C36C4CEF5;
	Thu, 13 Nov 2025 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047630;
	bh=5eaPFfI+HlHbNzT3zzfguX5CVQKRrLGDBh5wEdnnF2E=;
	h=From:To:Cc:Subject:Date:From;
	b=OnB/RU3efm8nGAoj6grcx9AIwV2K/Zc94hfJZl2kXYXz+MrWgOwdq631sgp1tDKr7
	 O+PJKVvxAgUbm+/9sa5AmKmuz+G88Xog3VqhggYlsvn0/dfO1pwFGkw2D7ZtjdH7OA
	 I+RA77+T8INvxABoCvBLNXHOWcWAGmsiNpMWpjXSmsWhidi6wVRTgzvTxjKL3VbgTs
	 PufuO8UM6Lfg/KMEkwVS13+0th/tm2zv87ILc+ck8jEWyDVS38XDVowtiE2mV9Kz05
	 o9osHMQYBtGExiBe0LnxZ96iVYEu4ufDPy+KPNbHEFryE+w35gSS3XiX753r5lQK+/
	 gYKxKzsk7/uZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: xdp: make the XDP qstats tests less flaky
Date: Thu, 13 Nov 2025 07:27:03 -0800
Message-ID: <20251113152703.3819756-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XDP qstats tests send 2k packets over a single socket.
Looks like when netdev CI is busy running those tests in QEMU
occasionally flakes. The target doesn't get to run at all
before all 2000 packets are sent.

Lower the number of packets to 1000 and reopen the socket
every 50 packets, to give RSS a chance to spread the packets
to multiple queues.

For the netdev CI testing either lowering the count or using
multiple sockets is enough, but let's do both for extra resiliency.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: ast@kernel.org
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/xdp.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index a148004e1c36..834a37ae7d0d 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -687,9 +687,12 @@ from lib.py import ip, bpftool, defer
         "/dev/null"
     # Listener runs on "remote" in case of XDP_TX
     rx_host = cfg.remote if act == XDPAction.TX else None
-    # We want to spew 2000 packets quickly, bash seems to do a good enough job
-    tx_udp =  f"exec 5<>/dev/udp/{cfg.addr}/{port}; " \
-        "for i in `seq 2000`; do echo a >&5; done; exec 5>&-"
+    # We want to spew 1000 packets quickly, bash seems to do a good enough job
+    # Each reopening of the socket gives us a differenot local port (for RSS)
+    tx_udp = "for _ in `seq 20`; do " \
+        f"exec 5<>/dev/udp/{cfg.addr}/{port}; " \
+        "for i in `seq 50`; do echo a >&5; done; " \
+        "exec 5>&-; done"
 
     cfg.wait_hw_stats_settle()
     # Qstats have more clearly defined semantics than rtnetlink.
@@ -704,11 +707,11 @@ from lib.py import ip, bpftool, defer
     cfg.wait_hw_stats_settle()
     after = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
 
-    ksft_ge(after['rx-packets'] - before['rx-packets'], 2000)
+    expected_pkts = 1000
+    ksft_ge(after['rx-packets'] - before['rx-packets'], expected_pkts)
     if act == XDPAction.TX:
-        ksft_ge(after['tx-packets'] - before['tx-packets'], 2000)
+        ksft_ge(after['tx-packets'] - before['tx-packets'], expected_pkts)
 
-    expected_pkts = 2000
     stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
     ksft_eq(stats[XDPStats.RX.value], expected_pkts, "XDP RX stats mismatch")
     if act == XDPAction.TX:
-- 
2.51.1


