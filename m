Return-Path: <linux-kselftest+bounces-10299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE858C794D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 17:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9B3B21457
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C910614D444;
	Thu, 16 May 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsbox4WI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAA14D439;
	Thu, 16 May 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873119; cv=none; b=MxI1B+N3xjc2KMAx7xnLqz8JGxa/b3A2x5D4uy5HzH//O95/Xroqs8B06FGmxeC1N1nid5WkodN9F/qwCVoak4t0Xx/pq9WNett8gqU3zem7s9dU3eEp/sjuFpRdgasdJH+zutYi4uy6Ko6c3nxsppBUN5axUprjDHylClN0ZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873119; c=relaxed/simple;
	bh=hjj/nXZu32n4CjvTA1Xw1/LPmTE9VwI8rF+cAW747CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJV/5DLSki2xNsf3u9pTSiDzsfwiYJzWVFw8RD4Uddi8mJkLJQjDQdVWJmO764PbnE7XsSkXMJZVi328LEXwgWMyhhbyDbPlz2bS9roagYl7/il6CzNenxBoCWFZdQtjigJ5Fx5cQ/ebJR34v/7xFt/zaKulUk0Jb8u64vU7iQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsbox4WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F6AC113CC;
	Thu, 16 May 2024 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715873119;
	bh=hjj/nXZu32n4CjvTA1Xw1/LPmTE9VwI8rF+cAW747CU=;
	h=From:To:Cc:Subject:Date:From;
	b=gsbox4WIarrcvlGApHd3bAgvUb14EEBRLQdy9wYXYbyAUhMURC4QHzxvk8Xtkm9eq
	 3TQaW6gbJczpa3JF62JxDdeqpTmiBe7rNSPNMBu5zzHxi7rLLCt/TQqJHnnBBjgF2b
	 a4rVOSiqoJM2P4ZUOCRRSqSso3Z+mH2Ym4FbuxCQYaOGdYzF9VCfQIwhzUVgQNcRXA
	 QWN40g8z2mIuugW9VXPNYpVDZyN3/Y2o6Vy6zpCfmgtEsUbnpTj57hHYpgyfi005Lc
	 TKt5v0PEiZ5M2DnQGfeQsEdfD5cJKvQ6oVqIAJDHiLqKMmJk2hQ+Fo/3EZhMTR/g17
	 jLSHHkAXamOdg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Petr Machata <petrm@nvidia.com>,
	vladimir.oltean@nxp.com
Subject: [PATCH net v3] selftests: net: local_termination: annotate the expected failures
Date: Thu, 16 May 2024 08:25:13 -0700
Message-ID: <20240516152513.1115270-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vladimir said when adding this test:

  The bridge driver fares particularly badly [...] mainly because
  it does not implement IFF_UNICAST_FLT.

See commit 90b9566aa5cd ("selftests: forwarding: add a test for
local_termination.sh").

We don't want to hide the known gaps, but having a test which
always fails prevents us from catching regressions. Report
the cases we know may fail as XFAIL.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: liuhangbin@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: Petr Machata <petrm@nvidia.com>
CC: vladimir.oltean@nxp.com

v3:
 - use xfail_on_veth correctly as a "prefix" call
 - dropping Vladimir's tags since the code is quite different now
v2: https://lore.kernel.org/r/20240509235553.5740-1-kuba@kernel.org/
 - remove duplicated log_test_xfail
v1: https://lore.kernel.org/all/20240509235553.5740-1-kuba@kernel.org/
---
 .../net/forwarding/local_termination.sh       | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index c5b0cbc85b3e..4b364cdf3ef0 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -155,25 +155,30 @@ run_test()
 		"$smac > $MACVLAN_ADDR, ethertype IPv4 (0x0800)" \
 		true
 
-	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
-		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
-		false
+	xfail_on_veth $h1 \
+		check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
+			"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
+			false
 
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, promisc" \
 		"$smac > $UNKNOWN_UC_ADDR2, ethertype IPv4 (0x0800)" \
 		true
 
-	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, allmulti" \
-		"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
-		false
+	xfail_on_veth $h1 \
+		check_rcv $rcv_if_name \
+			"Unicast IPv4 to unknown MAC address, allmulti" \
+			"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
+			false
 
 	check_rcv $rcv_if_name "Multicast IPv4 to joined group" \
 		"$smac > $JOINED_MACV4_MC_ADDR, ethertype IPv4 (0x0800)" \
 		true
 
-	check_rcv $rcv_if_name "Multicast IPv4 to unknown group" \
-		"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
-		false
+	xfail_on_veth $h1 \
+		check_rcv $rcv_if_name \
+			"Multicast IPv4 to unknown group" \
+			"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
+			false
 
 	check_rcv $rcv_if_name "Multicast IPv4 to unknown group, promisc" \
 		"$smac > $UNKNOWN_MACV4_MC_ADDR2, ethertype IPv4 (0x0800)" \
@@ -187,9 +192,10 @@ run_test()
 		"$smac > $JOINED_MACV6_MC_ADDR, ethertype IPv6 (0x86dd)" \
 		true
 
-	check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
-		"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
-		false
+	xfail_on_veth $h1 \
+		check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
+			"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
+			false
 
 	check_rcv $rcv_if_name "Multicast IPv6 to unknown group, promisc" \
 		"$smac > $UNKNOWN_MACV6_MC_ADDR2, ethertype IPv6 (0x86dd)" \
-- 
2.45.0


