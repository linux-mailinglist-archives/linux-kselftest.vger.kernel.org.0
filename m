Return-Path: <linux-kselftest+bounces-39125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602FB28867
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 00:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A74AE4E8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D40246798;
	Fri, 15 Aug 2025 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtN+LK2e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D690317715;
	Fri, 15 Aug 2025 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297668; cv=none; b=NEIZ9shjww+zt1nW7xT8eR/rnR4+GCh4qPeIkn9uFhC+hAmu+wrbv4G5Mmhnnn/ycwJxYHJH40fpjZ9U5IBLDWkl1gMS76j3ISQKZK+IX68S7Fnqci1Z15oqmXljZJNXpS9kJskvAb8eSFfIM6OqFNoHQY/FQrzn+vApqyPjShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297668; c=relaxed/simple;
	bh=uFKEJJOjRDhjSKoXQ6Fe8Zn8RG1bPOxAlF+QEogDX4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkbD4dSayMgiDcwF9WavZe90akfi/1QRYsbv4B02Befu5yb+SUVOX9GNs9hZSBGQiWuvvhgvqHEMp0EOEgiXXFtDo6xtFG027GLjJpTYSRux1iC3SMA73aDdj3s552I8Bk6hb4qft/0Y6Ma41nBJ87GN4/qmMVKgky4eA0QLcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtN+LK2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24505C4CEEB;
	Fri, 15 Aug 2025 22:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755297667;
	bh=uFKEJJOjRDhjSKoXQ6Fe8Zn8RG1bPOxAlF+QEogDX4o=;
	h=From:To:Cc:Subject:Date:From;
	b=PtN+LK2ev2AUcW+NwEZzv6yD3zPVUpPAS4wwhfpKAP37ldhvxzAg2Tg9A/RlBfOUp
	 5wyB6mfEyUbP8o18TV39lRP1LLMmaxg9H9CvSKvuQ7gj2jH7xAiPGLziyLmq35syWa
	 zBWhjJcgyyNoS1emzBqqYR+jshYWZ26VeJqECPpcQ935JJCjgsfyeQIIfJWUbCVHMI
	 9E+P2fgcBpkYT9D8kSVDI0a3iOQk04eJfO5zqpM1OSjOjVVrDtb+9qFg4Yuhw5gwCM
	 gVqnetbMHs98bjs2HEsCUtxYBUn2a7sl+Z1qxlJw2q+KqsITo2PTOnojDsxJba9cE9
	 Rz9ttSskS8c1g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: tso: increase the retransmit threshold
Date: Fri, 15 Aug 2025 15:41:00 -0700
Message-ID: <20250815224100.363438-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We see quite a few flakes during the TSO test against virtualized
devices in NIPA. There's often 10-30 retransmissions during the
test. Sometimes as many as 100. Set the retransmission threshold
at 1/4th of the wire frame target.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: daniel.zahka@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/tso.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index c13dd5efa27a..0998e68ebaf0 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -60,16 +60,17 @@ from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
         sock_wait_drain(sock)
         qstat_new = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
 
-        # No math behind the 10 here, but try to catch cases where
-        # TCP falls back to non-LSO.
-        ksft_lt(tcp_sock_get_retrans(sock), 10)
-        sock.close()
-
         # Check that at least 90% of the data was sent as LSO packets.
         # System noise may cause false negatives. Also header overheads
         # will add up to 5% of extra packes... The check is best effort.
         total_lso_wire  = len(buf) * 0.90 // cfg.dev["mtu"]
         total_lso_super = len(buf) * 0.90 // cfg.dev["tso_max_size"]
+
+        # Make sure we have order of magnitude more LSO packets than
+        # retransmits, in case TCP retransmitted all the LSO packets.
+        ksft_lt(tcp_sock_get_retrans(sock), total_lso_wire / 4)
+        sock.close()
+
         if should_lso:
             if cfg.have_stat_super_count:
                 ksft_ge(qstat_new['tx-hw-gso-packets'] -
-- 
2.50.1


