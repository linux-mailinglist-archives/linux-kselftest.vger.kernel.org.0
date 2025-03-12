Return-Path: <linux-kselftest+bounces-28804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10534A5D8EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 10:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A04177637
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51272239083;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1FGkBCk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953A238D38;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770688; cv=none; b=gm4jGL0CC87VYm6u99BE37kYqPxWgsChV+kgNeljw/f42iZISHnk9S12b+2n3jWV5YHwoaV59USZ/QmzwZ6grWWyTK0B2qqqvXPORlIOzuEP51M8Gt4PyfVFSp+Bt9D7IQtuAJz3bu+NImYPkfyd82dBIgIcHte4pCFh7eUu6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770688; c=relaxed/simple;
	bh=TVEAi5fA+gEtT8dypXb3lGeWW4DfBCk++5CCii/Ghto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6ZQkvSyZS4R5ekCsMQ8qJyJ2Z6+cEuZEkcnAkWskUSvNI0Zps0teuyurANTBBRCARsZ+wdsKx8qYkhsju3VF1IAgmRrDlM994cbPKI4h+4dne3NNZ2F562yHOuJpSH/MJCeUe55XMzyXsapdfi7pgUbyvvI/cY5DT0WL3lesuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1FGkBCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F89C4CEF2;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770687;
	bh=TVEAi5fA+gEtT8dypXb3lGeWW4DfBCk++5CCii/Ghto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D1FGkBCk+QM1S7MgaMiS3SbQXx4540wjRv0/wlu7VGxRWtDvSR6nsTrOqNk3Gm3hJ
	 jm02jgeRIU46pdCLvDKe8nn/eNiwGHOvuq+c1hqlt2f2ChyeggIGMIKy6qXjybrmqG
	 coalrUUjxkOl5iDLDfGvNPS+27m2YNEGWa3p0CNM3P8Yyw9ymnm9kH1gTJ1ZfQbbqU
	 W25jTlFt+chASlse9J4rw9ob1Cd2K8opyjtqdLqcgQSVq4zU0XBug5XJlEByF6dnxN
	 f6YTAiyV1TDA7oVEGEDfrl8PrYRWvv0wWb/ZpnMwuWhX8XEmpa4AZFuI69+bf/u+8h
	 aQ0N8ZYn/hOLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FF3C28B28;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 12 Mar 2025 09:10:57 +0000
Subject: [PATCH net 3/7] selftests/net: Fetch and check TCP-MD5 counters
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-tcp-ao-selftests-polling-v1-3-72a642b855d5@gmail.com>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741770685; l=46949;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=u4mRRLNJ2CHlq4ZPaoALRxmpJNN4CejrLYaofpTLoTw=;
 b=I8M4uJAHc1WkMMnLJkDZxR9Ak0zgAhxPyjG1rOiGmySIehGiOkUEKtWF2TaaQ5K+prQAI/Pes
 l7g1eVmcdgvAVI4/xDJXtfFJ4M6XvO9NUYTo9CkGTASV/7OsCFdwJFN
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

There are related TCP-MD5 <=> TCP and TCP-MD5 <=> TCP-AO tests
that can benefit from checking the related counters, not only from
validating operations timeouts.

It also prepares the code for introduction of mixed select()+poll mode,
see the follow-up patches.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/connect-deny.c  | 26 ++++----
 tools/testing/selftests/net/tcp_ao/connect.c       | 18 +++---
 tools/testing/selftests/net/tcp_ao/icmps-discard.c | 14 ++---
 .../testing/selftests/net/tcp_ao/key-management.c  | 64 +++++++++----------
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     | 63 ++++++++++++-------
 tools/testing/selftests/net/tcp_ao/lib/sock.c      | 72 ++++++++++++----------
 tools/testing/selftests/net/tcp_ao/restore.c       | 56 ++++++++---------
 tools/testing/selftests/net/tcp_ao/rst.c           | 34 +++++-----
 tools/testing/selftests/net/tcp_ao/self-connect.c  | 12 ++--
 tools/testing/selftests/net/tcp_ao/seq-ext.c       | 26 ++++----
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  | 23 ++++---
 11 files changed, 219 insertions(+), 189 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
index 42223a1a7a822d84661c727ab1c8125fef534fa0..919e8d2b91345b453313f25b98cee27b80f1e984 100644
--- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -34,7 +34,7 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 		       const char *cnt_name, test_cnt cnt_expected,
 		       fault_t inj)
 {
-	struct tcp_ao_counters ao_cnt1, ao_cnt2;
+	struct tcp_counters cnt1, cnt2;
 	uint64_t before_cnt = 0, after_cnt = 0; /* silence GCC */
 	int lsk, err, sk = 0;
 	time_t timeout;
@@ -46,8 +46,8 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 
 	if (cnt_name)
 		before_cnt = netstat_get_one(cnt_name, NULL);
-	if (pwd && test_get_tcp_ao_counters(lsk, &ao_cnt1))
-		test_error("test_get_tcp_ao_counters()");
+	if (pwd && test_get_tcp_counters(lsk, &cnt1))
+		test_error("test_get_tcp_counters()");
 
 	synchronize_threads(); /* preparations done */
 
@@ -72,13 +72,13 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 	}
 
 	synchronize_threads(); /* before counter checks */
-	if (pwd && test_get_tcp_ao_counters(lsk, &ao_cnt2))
-		test_error("test_get_tcp_ao_counters()");
+	if (pwd && test_get_tcp_counters(lsk, &cnt2))
+		test_error("test_get_tcp_counters()");
 
 	close(lsk);
 
 	if (pwd)
-		test_assert_counters(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+		test_assert_counters(tst_name, &cnt1, &cnt2, cnt_expected);
 
 	if (!cnt_name)
 		goto out;
@@ -163,7 +163,7 @@ static void try_connect(const char *tst_name, unsigned int port,
 			uint8_t sndid, uint8_t rcvid,
 			test_cnt cnt_expected, fault_t inj)
 {
-	struct tcp_ao_counters ao_cnt1, ao_cnt2;
+	struct tcp_counters cnt1, cnt2;
 	time_t timeout;
 	int sk, ret;
 
@@ -174,8 +174,8 @@ static void try_connect(const char *tst_name, unsigned int port,
 	if (pwd && test_add_key(sk, pwd, addr, prefix, sndid, rcvid))
 		test_error("setsockopt(TCP_AO_ADD_KEY)");
 
-	if (pwd && test_get_tcp_ao_counters(sk, &ao_cnt1))
-		test_error("test_get_tcp_ao_counters()");
+	if (pwd && test_get_tcp_counters(sk, &cnt1))
+		test_error("test_get_tcp_counters()");
 
 	synchronize_threads(); /* preparations done */
 
@@ -202,9 +202,11 @@ static void try_connect(const char *tst_name, unsigned int port,
 	else
 		test_ok("%s: connected", tst_name);
 	if (pwd && ret > 0) {
-		if (test_get_tcp_ao_counters(sk, &ao_cnt2))
-			test_error("test_get_tcp_ao_counters()");
-		test_assert_counters(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+		if (test_get_tcp_counters(sk, &cnt2))
+			test_error("test_get_tcp_counters()");
+		test_assert_counters(tst_name, &cnt1, &cnt2, cnt_expected);
+	} else if (pwd) {
+		test_tcp_counters_free(&cnt1);
 	}
 out:
 	synchronize_threads(); /* close() */
diff --git a/tools/testing/selftests/net/tcp_ao/connect.c b/tools/testing/selftests/net/tcp_ao/connect.c
index 87647f38e7e6a6c0fde9a2789debe98e22a178dd..45f2307483d3bab8c96df26c9dca28c898283c0c 100644
--- a/tools/testing/selftests/net/tcp_ao/connect.c
+++ b/tools/testing/selftests/net/tcp_ao/connect.c
@@ -35,7 +35,7 @@ static void *client_fn(void *arg)
 	uint64_t before_aogood, after_aogood;
 	const size_t nr_packets = 20;
 	struct netstat *ns_before, *ns_after;
-	struct tcp_ao_counters ao1, ao2;
+	struct tcp_counters ao1, ao2;
 
 	if (sk < 0)
 		test_error("socket()");
@@ -50,8 +50,8 @@ static void *client_fn(void *arg)
 
 	ns_before = netstat_read();
 	before_aogood = netstat_get(ns_before, "TCPAOGood", NULL);
-	if (test_get_tcp_ao_counters(sk, &ao1))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &ao1))
+		test_error("test_get_tcp_counters()");
 
 	if (test_client_verify(sk, 100, nr_packets, TEST_TIMEOUT_SEC)) {
 		test_fail("verify failed");
@@ -60,8 +60,8 @@ static void *client_fn(void *arg)
 
 	ns_after = netstat_read();
 	after_aogood = netstat_get(ns_after, "TCPAOGood", NULL);
-	if (test_get_tcp_ao_counters(sk, &ao2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &ao2))
+		test_error("test_get_tcp_counters()");
 	netstat_print_diff(ns_before, ns_after);
 	netstat_free(ns_before);
 	netstat_free(ns_after);
@@ -75,10 +75,10 @@ static void *client_fn(void *arg)
 		return NULL;
 
 	test_ok("connect TCPAOGood %" PRIu64 "/%" PRIu64 "/%" PRIu64 " => %" PRIu64 "/%" PRIu64 "/%" PRIu64 ", sent %zu",
-			before_aogood, ao1.ao_info_pkt_good,
-			ao1.key_cnts[0].pkt_good,
-			after_aogood, ao2.ao_info_pkt_good,
-			ao2.key_cnts[0].pkt_good,
+			before_aogood, ao1.ao.ao_info_pkt_good,
+			ao1.ao.key_cnts[0].pkt_good,
+			after_aogood, ao2.ao.ao_info_pkt_good,
+			ao2.ao.key_cnts[0].pkt_good,
 			nr_packets);
 	return NULL;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
index e2958a6a0e28efa0c8a339b1a014f2fabf0dd7ce..61a5e8e2d7e0d7bd1938c297e847384bf7e1d2c5 100644
--- a/tools/testing/selftests/net/tcp_ao/icmps-discard.c
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -53,7 +53,7 @@ static void serve_interfered(int sk)
 	ssize_t test_quota = packet_size * packets_nr * 10;
 	uint64_t dest_unreach_a, dest_unreach_b;
 	uint64_t icmp_ignored_a, icmp_ignored_b;
-	struct tcp_ao_counters ao_cnt1, ao_cnt2;
+	struct tcp_counters cnt1, cnt2;
 	bool counter_not_found;
 	struct netstat *ns_after, *ns_before;
 	ssize_t bytes;
@@ -61,16 +61,16 @@ static void serve_interfered(int sk)
 	ns_before = netstat_read();
 	dest_unreach_a = netstat_get(ns_before, dst_unreach, NULL);
 	icmp_ignored_a = netstat_get(ns_before, tcpao_icmps, NULL);
-	if (test_get_tcp_ao_counters(sk, &ao_cnt1))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt1))
+		test_error("test_get_tcp_counters()");
 	bytes = test_server_run(sk, test_quota, 0);
 	ns_after = netstat_read();
 	netstat_print_diff(ns_before, ns_after);
 	dest_unreach_b = netstat_get(ns_after, dst_unreach, NULL);
 	icmp_ignored_b = netstat_get(ns_after, tcpao_icmps,
 					&counter_not_found);
-	if (test_get_tcp_ao_counters(sk, &ao_cnt2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt2))
+		test_error("test_get_tcp_counters()");
 
 	netstat_free(ns_before);
 	netstat_free(ns_after);
@@ -91,9 +91,9 @@ static void serve_interfered(int sk)
 		return;
 	}
 #ifdef TEST_ICMPS_ACCEPT
-	test_assert_counters(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD);
+	test_assert_counters(NULL, &cnt1, &cnt2, TEST_CNT_GOOD);
 #else
-	test_assert_counters(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD | TEST_CNT_AO_DROPPED_ICMP);
+	test_assert_counters(NULL, &cnt1, &cnt2, TEST_CNT_GOOD | TEST_CNT_AO_DROPPED_ICMP);
 #endif
 	if (icmp_ignored_a >= icmp_ignored_b) {
 		test_icmps_fail("%s counter didn't change: %" PRIu64 " >= %" PRIu64,
diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index 2c55c686285acedcdc5a836f7818e35be1ad9d91..c4087a15bdb3b68b51489a2d419bd911879c6c08 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -629,11 +629,11 @@ static int key_collection_socket(bool server, unsigned int port)
 }
 
 static void verify_counters(const char *tst_name, bool is_listen_sk, bool server,
-			    struct tcp_ao_counters *a, struct tcp_ao_counters *b)
+			    struct tcp_counters *a, struct tcp_counters *b)
 {
 	unsigned int i;
 
-	test_assert_counters_ao(tst_name, a, b, TEST_CNT_GOOD);
+	test_assert_counters_sk(tst_name, a, b, TEST_CNT_GOOD);
 
 	for (i = 0; i < collection.nr_keys; i++) {
 		struct test_key *key = &collection.keys[i];
@@ -652,12 +652,12 @@ static void verify_counters(const char *tst_name, bool is_listen_sk, bool server
 			rx_cnt_expected = key->used_on_server_tx;
 		}
 
-		test_assert_counters_key(tst_name, a, b,
+		test_assert_counters_key(tst_name, &a->ao, &b->ao,
 					 rx_cnt_expected ? TEST_CNT_KEY_GOOD : 0,
 					 sndid, rcvid);
 	}
-	test_tcp_ao_counters_free(a);
-	test_tcp_ao_counters_free(b);
+	test_tcp_counters_free(a);
+	test_tcp_counters_free(b);
 	test_ok("%s: passed counters checks", tst_name);
 }
 
@@ -791,17 +791,17 @@ static void verify_keys(const char *tst_name, int sk,
 }
 
 static int start_server(const char *tst_name, unsigned int port, size_t quota,
-			struct tcp_ao_counters *begin,
+			struct tcp_counters *begin,
 			unsigned int current_index, unsigned int rnext_index)
 {
-	struct tcp_ao_counters lsk_c1, lsk_c2;
+	struct tcp_counters lsk_c1, lsk_c2;
 	ssize_t bytes;
 	int sk, lsk;
 
 	synchronize_threads(); /* 1: key collection initialized */
 	lsk = key_collection_socket(true, port);
-	if (test_get_tcp_ao_counters(lsk, &lsk_c1))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(lsk, &lsk_c1))
+		test_error("test_get_tcp_counters()");
 	synchronize_threads(); /* 2: MKTs added => connect() */
 	if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
 		test_error("test_wait_fd()");
@@ -809,12 +809,12 @@ static int start_server(const char *tst_name, unsigned int port, size_t quota,
 	sk = accept(lsk, NULL, NULL);
 	if (sk < 0)
 		test_error("accept()");
-	if (test_get_tcp_ao_counters(sk, begin))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, begin))
+		test_error("test_get_tcp_counters()");
 
 	synchronize_threads(); /* 3: accepted => send data */
-	if (test_get_tcp_ao_counters(lsk, &lsk_c2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(lsk, &lsk_c2))
+		test_error("test_get_tcp_counters()");
 	verify_keys(tst_name, lsk, true, true);
 	close(lsk);
 
@@ -830,12 +830,12 @@ static int start_server(const char *tst_name, unsigned int port, size_t quota,
 }
 
 static void end_server(const char *tst_name, int sk,
-		       struct tcp_ao_counters *begin)
+		       struct tcp_counters *begin)
 {
-	struct tcp_ao_counters end;
+	struct tcp_counters end;
 
-	if (test_get_tcp_ao_counters(sk, &end))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &end))
+		test_error("test_get_tcp_counters()");
 	verify_keys(tst_name, sk, false, true);
 
 	synchronize_threads(); /* 4: verified => closed */
@@ -848,7 +848,7 @@ static void end_server(const char *tst_name, int sk,
 static void try_server_run(const char *tst_name, unsigned int port, size_t quota,
 			   unsigned int current_index, unsigned int rnext_index)
 {
-	struct tcp_ao_counters tmp;
+	struct tcp_counters tmp;
 	int sk;
 
 	sk = start_server(tst_name, port, quota, &tmp,
@@ -860,7 +860,7 @@ static void server_rotations(const char *tst_name, unsigned int port,
 			     size_t quota, unsigned int rotations,
 			     unsigned int current_index, unsigned int rnext_index)
 {
-	struct tcp_ao_counters tmp;
+	struct tcp_counters tmp;
 	unsigned int i;
 	int sk;
 
@@ -886,7 +886,7 @@ static void server_rotations(const char *tst_name, unsigned int port,
 
 static int run_client(const char *tst_name, unsigned int port,
 		      unsigned int nr_keys, int current_index, int rnext_index,
-		      struct tcp_ao_counters *before,
+		      struct tcp_counters *before,
 		      const size_t msg_sz, const size_t msg_nr)
 {
 	int sk;
@@ -904,8 +904,8 @@ static int run_client(const char *tst_name, unsigned int port,
 		if (test_set_key(sk, sndid, rcvid))
 			test_error("failed to set current/rnext keys");
 	}
-	if (before && test_get_tcp_ao_counters(sk, before))
-		test_error("test_get_tcp_ao_counters()");
+	if (before && test_get_tcp_counters(sk, before))
+		test_error("test_get_tcp_counters()");
 
 	synchronize_threads(); /* 2: MKTs added => connect() */
 	if (test_connect_socket(sk, this_ip_dest, port++) <= 0)
@@ -922,7 +922,7 @@ static int run_client(const char *tst_name, unsigned int port,
 		test_fail("verify failed");
 		close(sk);
 		if (before)
-			test_tcp_ao_counters_free(before);
+			test_tcp_counters_free(before);
 		return -1;
 	}
 
@@ -931,7 +931,7 @@ static int run_client(const char *tst_name, unsigned int port,
 
 static int start_client(const char *tst_name, unsigned int port,
 			unsigned int nr_keys, int current_index, int rnext_index,
-			struct tcp_ao_counters *before,
+			struct tcp_counters *before,
 			const size_t msg_sz, const size_t msg_nr)
 {
 	if (init_default_key_collection(nr_keys, true))
@@ -943,9 +943,9 @@ static int start_client(const char *tst_name, unsigned int port,
 
 static void end_client(const char *tst_name, int sk, unsigned int nr_keys,
 		       int current_index, int rnext_index,
-		       struct tcp_ao_counters *start)
+		       struct tcp_counters *start)
 {
-	struct tcp_ao_counters end;
+	struct tcp_counters end;
 
 	/* Some application may become dependent on this kernel choice */
 	if (current_index < 0)
@@ -955,8 +955,8 @@ static void end_client(const char *tst_name, int sk, unsigned int nr_keys,
 	verify_current_rnext(tst_name, sk,
 			     collection.keys[current_index].client_keyid,
 			     collection.keys[rnext_index].server_keyid);
-	if (start && test_get_tcp_ao_counters(sk, &end))
-		test_error("test_get_tcp_ao_counters()");
+	if (start && test_get_tcp_counters(sk, &end))
+		test_error("test_get_tcp_counters()");
 	verify_keys(tst_name, sk, false, false);
 	synchronize_threads(); /* 4: verify => closed */
 	close(sk);
@@ -1048,7 +1048,7 @@ static void check_current_back(const char *tst_name, unsigned int port,
 			       unsigned int current_index, unsigned int rnext_index,
 			       unsigned int rotate_to_index)
 {
-	struct tcp_ao_counters tmp;
+	struct tcp_counters tmp;
 	int sk;
 
 	sk = start_client(tst_name, port, nr_keys, current_index, rnext_index,
@@ -1081,7 +1081,7 @@ static void roll_over_keys(const char *tst_name, unsigned int port,
 			   unsigned int nr_keys, unsigned int rotations,
 			   unsigned int current_index, unsigned int rnext_index)
 {
-	struct tcp_ao_counters tmp;
+	struct tcp_counters tmp;
 	unsigned int i;
 	int sk;
 
@@ -1102,7 +1102,7 @@ static void roll_over_keys(const char *tst_name, unsigned int port,
 		if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC)) {
 			test_fail("verify failed");
 			close(sk);
-			test_tcp_ao_counters_free(&tmp);
+			test_tcp_counters_free(&tmp);
 			return;
 		}
 		verify_current_rnext(tst_name, sk, -1,
@@ -1116,7 +1116,7 @@ static void roll_over_keys(const char *tst_name, unsigned int port,
 static void try_client_run(const char *tst_name, unsigned int port,
 			   unsigned int nr_keys, int current_index, int rnext_index)
 {
-	struct tcp_ao_counters tmp;
+	struct tcp_counters tmp;
 	int sk;
 
 	sk = start_client(tst_name, port, nr_keys, current_index, rnext_index,
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index d6557940ef1fa6bf52da9efea04156edd9b10b7e..b88d15df76886b336cb5f5966fa1e4b2c8eb4a81 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -512,7 +512,15 @@ struct tcp_ao_counters {
 	size_t nr_keys;
 	struct tcp_ao_key_counters *key_cnts;
 };
-extern int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out);
+
+struct tcp_counters {
+	struct tcp_ao_counters ao;
+	uint64_t netns_md5_notfound;
+	uint64_t netns_md5_unexpected;
+	uint64_t netns_md5_failure;
+};
+
+extern int test_get_tcp_counters(int sk, struct tcp_counters *out);
 
 #define TEST_CNT_KEY_GOOD		BIT(0)
 #define TEST_CNT_KEY_BAD		BIT(1)
@@ -526,22 +534,29 @@ extern int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out);
 #define TEST_CNT_NS_KEY_NOT_FOUND	BIT(9)
 #define TEST_CNT_NS_AO_REQUIRED		BIT(10)
 #define TEST_CNT_NS_DROPPED_ICMP	BIT(11)
+#define TEST_CNT_NS_MD5_NOT_FOUND	BIT(12)
+#define TEST_CNT_NS_MD5_UNEXPECTED	BIT(13)
+#define TEST_CNT_NS_MD5_FAILURE		BIT(14)
 typedef uint16_t test_cnt;
 
 #define _for_each_counter(f)						\
 do {									\
 	/* per-netns */							\
-	f(netns_ao_good,		TEST_CNT_NS_GOOD);		\
-	f(netns_ao_bad,			TEST_CNT_NS_BAD);		\
-	f(netns_ao_key_not_found,	TEST_CNT_NS_KEY_NOT_FOUND);	\
-	f(netns_ao_required,		TEST_CNT_NS_AO_REQUIRED);	\
-	f(netns_ao_dropped_icmp,	TEST_CNT_NS_DROPPED_ICMP);	\
+	f(ao.netns_ao_good,		TEST_CNT_NS_GOOD);		\
+	f(ao.netns_ao_bad,		TEST_CNT_NS_BAD);		\
+	f(ao.netns_ao_key_not_found,	TEST_CNT_NS_KEY_NOT_FOUND);	\
+	f(ao.netns_ao_required,		TEST_CNT_NS_AO_REQUIRED);	\
+	f(ao.netns_ao_dropped_icmp,	TEST_CNT_NS_DROPPED_ICMP);	\
 	/* per-socket */						\
-	f(ao_info_pkt_good,		TEST_CNT_SOCK_GOOD);		\
-	f(ao_info_pkt_bad,		TEST_CNT_SOCK_BAD);		\
-	f(ao_info_pkt_key_not_found,	TEST_CNT_SOCK_KEY_NOT_FOUND);	\
-	f(ao_info_pkt_ao_required,	TEST_CNT_SOCK_AO_REQUIRED);	\
-	f(ao_info_pkt_dropped_icmp,	TEST_CNT_SOCK_DROPPED_ICMP);	\
+	f(ao.ao_info_pkt_good,		TEST_CNT_SOCK_GOOD);		\
+	f(ao.ao_info_pkt_bad,		TEST_CNT_SOCK_BAD);		\
+	f(ao.ao_info_pkt_key_not_found,	TEST_CNT_SOCK_KEY_NOT_FOUND);	\
+	f(ao.ao_info_pkt_ao_required,	TEST_CNT_SOCK_AO_REQUIRED);	\
+	f(ao.ao_info_pkt_dropped_icmp,	TEST_CNT_SOCK_DROPPED_ICMP);	\
+	/* non-AO */							\
+	f(netns_md5_notfound,		TEST_CNT_NS_MD5_NOT_FOUND);	\
+	f(netns_md5_unexpected,		TEST_CNT_NS_MD5_UNEXPECTED);	\
+	f(netns_md5_failure,		TEST_CNT_NS_MD5_FAILURE);	\
 } while (0)
 
 #define TEST_CNT_AO_GOOD		(TEST_CNT_SOCK_GOOD | TEST_CNT_NS_GOOD)
@@ -555,33 +570,37 @@ do {									\
 #define TEST_CNT_GOOD			(TEST_CNT_KEY_GOOD | TEST_CNT_AO_GOOD)
 #define TEST_CNT_BAD			(TEST_CNT_KEY_BAD | TEST_CNT_AO_BAD)
 
-extern int test_assert_counters_ao(const char *tst_name,
-		struct tcp_ao_counters *before, struct tcp_ao_counters *after,
+extern test_cnt test_cmp_counters(struct tcp_counters *before,
+				  struct tcp_counters *after);
+extern int test_assert_counters_sk(const char *tst_name,
+		struct tcp_counters *before, struct tcp_counters *after,
 		test_cnt expected);
 extern int test_assert_counters_key(const char *tst_name,
 		struct tcp_ao_counters *before, struct tcp_ao_counters *after,
 		test_cnt expected, int sndid, int rcvid);
-extern void test_tcp_ao_counters_free(struct tcp_ao_counters *cnts);
+extern void test_tcp_counters_free(struct tcp_counters *cnts);
+
 /*
- * Frees buffers allocated in test_get_tcp_ao_counters().
+ * Frees buffers allocated in test_get_tcp_counters().
  * The function doesn't expect new keys or keys removed between calls
- * to test_get_tcp_ao_counters(). Check key counters manually if they
+ * to test_get_tcp_counters(). Check key counters manually if they
  * may change.
  */
 static inline int test_assert_counters(const char *tst_name,
-				       struct tcp_ao_counters *before,
-				       struct tcp_ao_counters *after,
+				       struct tcp_counters *before,
+				       struct tcp_counters *after,
 				       test_cnt expected)
 {
 	int ret;
 
-	ret = test_assert_counters_ao(tst_name, before, after, expected);
+	ret = test_assert_counters_sk(tst_name, before, after, expected);
 	if (ret)
 		goto out;
-	ret = test_assert_counters_key(tst_name, before, after, expected, -1, -1);
+	ret = test_assert_counters_key(tst_name, &before->ao, &after->ao,
+				       expected, -1, -1);
 out:
-	test_tcp_ao_counters_free(before);
-	test_tcp_ao_counters_free(after);
+	test_tcp_counters_free(before);
+	test_tcp_counters_free(after);
 	return ret;
 }
 
diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 2a2586b2ffa2bdf805562255e597ccd09597b33c..7ffde4dd794219cd43e056da3394deaea9696971 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -333,12 +333,12 @@ do {									\
 	return 0;
 }
 
-int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
+int test_get_tcp_counters(int sk, struct tcp_counters *out)
 {
 	struct tcp_ao_getsockopt *key_dump;
 	socklen_t key_dump_sz = sizeof(*key_dump);
 	struct tcp_ao_info_opt info = {};
-	bool c1, c2, c3, c4, c5;
+	bool c1, c2, c3, c4, c5, c6, c7, c8;
 	struct netstat *ns;
 	int err, nr_keys;
 
@@ -346,25 +346,30 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
 
 	/* per-netns */
 	ns = netstat_read();
-	out->netns_ao_good = netstat_get(ns, "TCPAOGood", &c1);
-	out->netns_ao_bad = netstat_get(ns, "TCPAOBad", &c2);
-	out->netns_ao_key_not_found = netstat_get(ns, "TCPAOKeyNotFound", &c3);
-	out->netns_ao_required = netstat_get(ns, "TCPAORequired", &c4);
-	out->netns_ao_dropped_icmp = netstat_get(ns, "TCPAODroppedIcmps", &c5);
+	out->ao.netns_ao_good = netstat_get(ns, "TCPAOGood", &c1);
+	out->ao.netns_ao_bad = netstat_get(ns, "TCPAOBad", &c2);
+	out->ao.netns_ao_key_not_found = netstat_get(ns, "TCPAOKeyNotFound", &c3);
+	out->ao.netns_ao_required = netstat_get(ns, "TCPAORequired", &c4);
+	out->ao.netns_ao_dropped_icmp = netstat_get(ns, "TCPAODroppedIcmps", &c5);
+	out->netns_md5_notfound = netstat_get(ns, "TCPMD5NotFound", &c6);
+	out->netns_md5_unexpected = netstat_get(ns, "TCPMD5Unexpected", &c7);
+	out->netns_md5_failure = netstat_get(ns, "TCPMD5Failure", &c8);
 	netstat_free(ns);
-	if (c1 || c2 || c3 || c4 || c5)
+	if (c1 || c2 || c3 || c4 || c5 || c6 || c7 || c8)
 		return -EOPNOTSUPP;
 
 	err = test_get_ao_info(sk, &info);
+	if (err == -ENOENT)
+		return 0;
 	if (err)
 		return err;
 
 	/* per-socket */
-	out->ao_info_pkt_good		= info.pkt_good;
-	out->ao_info_pkt_bad		= info.pkt_bad;
-	out->ao_info_pkt_key_not_found	= info.pkt_key_not_found;
-	out->ao_info_pkt_ao_required	= info.pkt_ao_required;
-	out->ao_info_pkt_dropped_icmp	= info.pkt_dropped_icmp;
+	out->ao.ao_info_pkt_good = info.pkt_good;
+	out->ao.ao_info_pkt_bad = info.pkt_bad;
+	out->ao.ao_info_pkt_key_not_found = info.pkt_key_not_found;
+	out->ao.ao_info_pkt_ao_required = info.pkt_ao_required;
+	out->ao.ao_info_pkt_dropped_icmp = info.pkt_dropped_icmp;
 
 	/* per-key */
 	nr_keys = test_get_ao_keys_nr(sk);
@@ -372,7 +377,7 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
 		return nr_keys;
 	if (nr_keys == 0)
 		test_error("test_get_ao_keys_nr() == 0");
-	out->nr_keys = (size_t)nr_keys;
+	out->ao.nr_keys = (size_t)nr_keys;
 	key_dump = calloc(nr_keys, key_dump_sz);
 	if (!key_dump)
 		return -errno;
@@ -386,53 +391,54 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
 		return -errno;
 	}
 
-	out->key_cnts = calloc(nr_keys, sizeof(out->key_cnts[0]));
-	if (!out->key_cnts) {
+	out->ao.key_cnts = calloc(nr_keys, sizeof(out->ao.key_cnts[0]));
+	if (!out->ao.key_cnts) {
 		free(key_dump);
 		return -errno;
 	}
 
 	while (nr_keys--) {
-		out->key_cnts[nr_keys].sndid = key_dump[nr_keys].sndid;
-		out->key_cnts[nr_keys].rcvid = key_dump[nr_keys].rcvid;
-		out->key_cnts[nr_keys].pkt_good = key_dump[nr_keys].pkt_good;
-		out->key_cnts[nr_keys].pkt_bad = key_dump[nr_keys].pkt_bad;
+		out->ao.key_cnts[nr_keys].sndid = key_dump[nr_keys].sndid;
+		out->ao.key_cnts[nr_keys].rcvid = key_dump[nr_keys].rcvid;
+		out->ao.key_cnts[nr_keys].pkt_good = key_dump[nr_keys].pkt_good;
+		out->ao.key_cnts[nr_keys].pkt_bad = key_dump[nr_keys].pkt_bad;
 	}
 	free(key_dump);
 
 	return 0;
 }
 
-int test_cmp_counters(struct tcp_ao_counters *before, struct tcp_ao_counters *after)
+test_cnt test_cmp_counters(struct tcp_counters *before,
+			   struct tcp_counters *after)
 {
 #define __cmp(cnt, e_cnt)						\
 do {									\
 	if (before->cnt > after->cnt)					\
-		return -1;						\
+		test_error("counter " __stringify(cnt) " decreased");	\
 	if (before->cnt != after->cnt)					\
 		ret |= e_cnt;						\
 } while (0)
 
-	int ret = 0;
+	test_cnt ret = 0;
 	size_t i;
 
-	if (before->nr_keys != after->nr_keys)
-		return -1;
+	if (before->ao.nr_keys != after->ao.nr_keys)
+		test_error("the number of keys has changed");
 
 	_for_each_counter(__cmp);
 
-	i = before->nr_keys;
+	i = before->ao.nr_keys;
 	while (i--) {
-		__cmp(key_cnts[i].pkt_good, TEST_CNT_KEY_GOOD);
-		__cmp(key_cnts[i].pkt_bad, TEST_CNT_KEY_BAD);
+		__cmp(ao.key_cnts[i].pkt_good, TEST_CNT_KEY_GOOD);
+		__cmp(ao.key_cnts[i].pkt_bad, TEST_CNT_KEY_BAD);
 	}
 #undef __cmp
 	return ret;
 }
 
-int test_assert_counters_ao(const char *tst_name,
-			    struct tcp_ao_counters *before,
-			    struct tcp_ao_counters *after,
+int test_assert_counters_sk(const char *tst_name,
+			    struct tcp_counters *before,
+			    struct tcp_counters *after,
 			    test_cnt expected)
 {
 #define __cmp_ao(cnt, e_cnt)						\
@@ -503,9 +509,9 @@ do {									\
 #undef __cmp_ao
 }
 
-void test_tcp_ao_counters_free(struct tcp_ao_counters *cnts)
+void test_tcp_counters_free(struct tcp_counters *cnts)
 {
-	free(cnts->key_cnts);
+	free(cnts->ao.key_cnts);
 }
 
 #define TEST_BUF_SIZE 4096
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
index ad8505f77023bcfb0712108c8148f5c94def67b1..4b98f06725ef9e8be7742c951d8c160279bab0da 100644
--- a/tools/testing/selftests/net/tcp_ao/restore.c
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -17,7 +17,7 @@ static void try_server_run(const char *tst_name, unsigned int port,
 			   fault_t inj, test_cnt cnt_expected)
 {
 	const char *cnt_name = "TCPAOGood";
-	struct tcp_ao_counters ao1, ao2;
+	struct tcp_counters cnt1, cnt2;
 	uint64_t before_cnt, after_cnt;
 	int sk, lsk;
 	time_t timeout;
@@ -48,8 +48,8 @@ static void try_server_run(const char *tst_name, unsigned int port,
 	}
 
 	before_cnt = netstat_get_one(cnt_name, NULL);
-	if (test_get_tcp_ao_counters(sk, &ao1))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt1))
+		test_error("test_get_tcp_counters()");
 
 	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
 	bytes = test_server_run(sk, quota, timeout);
@@ -65,17 +65,17 @@ static void try_server_run(const char *tst_name, unsigned int port,
 			test_ok("%s: server alive", tst_name);
 	}
 	synchronize_threads(); /* 3: counters checks */
-	if (test_get_tcp_ao_counters(sk, &ao2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt2))
+		test_error("test_get_tcp_counters()");
 	after_cnt = netstat_get_one(cnt_name, NULL);
 
-	test_assert_counters(tst_name, &ao1, &ao2, cnt_expected);
+	test_assert_counters(tst_name, &cnt1, &cnt2, cnt_expected);
 
 	if (after_cnt <= before_cnt) {
-		test_fail("%s: %s counter did not increase: %" PRIu64 " <= %" PRIu64,
-				tst_name, cnt_name, after_cnt, before_cnt);
+		test_fail("%s(server): %s counter did not increase: %" PRIu64 " <= %" PRIu64,
+			  tst_name, cnt_name, after_cnt, before_cnt);
 	} else {
-		test_ok("%s: counter %s increased %" PRIu64 " => %" PRIu64,
+		test_ok("%s(server): counter %s increased %" PRIu64 " => %" PRIu64,
 			tst_name, cnt_name, before_cnt, after_cnt);
 	}
 
@@ -92,16 +92,16 @@ static void *server_fn(void *arg)
 {
 	unsigned int port = test_server_port;
 
-	try_server_run("TCP-AO migrate to another socket", port++,
+	try_server_run("TCP-AO migrate to another socket (server)", port++,
 		       0, TEST_CNT_GOOD);
-	try_server_run("TCP-AO with wrong send ISN", port++,
+	try_server_run("TCP-AO with wrong send ISN (server)", port++,
 		       FAULT_TIMEOUT, TEST_CNT_BAD);
-	try_server_run("TCP-AO with wrong receive ISN", port++,
+	try_server_run("TCP-AO with wrong receive ISN (server)", port++,
 		       FAULT_TIMEOUT, TEST_CNT_BAD);
-	try_server_run("TCP-AO with wrong send SEQ ext number", port++,
+	try_server_run("TCP-AO with wrong send SEQ ext number (server)", port++,
 		       FAULT_TIMEOUT, TEST_CNT_BAD);
-	try_server_run("TCP-AO with wrong receive SEQ ext number", port++,
-		       FAULT_TIMEOUT, TEST_CNT_NS_BAD | TEST_CNT_GOOD);
+	try_server_run("TCP-AO with wrong receive SEQ ext number (server)",
+		       port++, FAULT_TIMEOUT, TEST_CNT_NS_BAD | TEST_CNT_GOOD);
 
 	synchronize_threads(); /* don't race to exit: client exits */
 	return NULL;
@@ -140,7 +140,7 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 			    fault_t inj, test_cnt cnt_expected)
 {
 	const char *cnt_name = "TCPAOGood";
-	struct tcp_ao_counters ao1, ao2;
+	struct tcp_counters cnt1, cnt2;
 	uint64_t before_cnt, after_cnt;
 	time_t timeout;
 	int sk;
@@ -159,8 +159,8 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 		test_error("setsockopt(TCP_AO_ADD_KEY)");
 	test_ao_restore(sk, ao_img);
 
-	if (test_get_tcp_ao_counters(sk, &ao1))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt1))
+		test_error("test_get_tcp_counters()");
 
 	test_disable_repair(sk);
 	test_sock_state_free(img);
@@ -178,11 +178,11 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 			test_ok("%s: post-migrate connection is alive", tst_name);
 	}
 	synchronize_threads(); /* 3: counters checks */
-	if (test_get_tcp_ao_counters(sk, &ao2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt2))
+		test_error("test_get_tcp_counters()");
 	after_cnt = netstat_get_one(cnt_name, NULL);
 
-	test_assert_counters(tst_name, &ao1, &ao2, cnt_expected);
+	test_assert_counters(tst_name, &cnt1, &cnt2, cnt_expected);
 
 	if (after_cnt <= before_cnt) {
 		test_fail("%s: %s counter did not increase: %" PRIu64 " <= %" PRIu64,
@@ -203,7 +203,7 @@ static void *client_fn(void *arg)
 	sockaddr_af saddr;
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
-	test_sk_restore("TCP-AO migrate to another socket", port++,
+	test_sk_restore("TCP-AO migrate to another socket (client)", port++,
 			&saddr, &tcp_img, &ao_img, 0, TEST_CNT_GOOD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
@@ -212,7 +212,7 @@ static void *client_fn(void *arg)
 			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
 			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
-	test_sk_restore("TCP-AO with wrong send ISN", port++,
+	test_sk_restore("TCP-AO with wrong send ISN (client)", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT, TEST_CNT_BAD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
@@ -221,7 +221,7 @@ static void *client_fn(void *arg)
 			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
 			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
-	test_sk_restore("TCP-AO with wrong receive ISN", port++,
+	test_sk_restore("TCP-AO with wrong receive ISN (client)", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT, TEST_CNT_BAD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
@@ -229,8 +229,8 @@ static void *client_fn(void *arg)
 	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
 			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	/* not expecting server => client mismatches as only snd sne is broken */
-	test_sk_restore("TCP-AO with wrong send SEQ ext number", port++,
-			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
+	test_sk_restore("TCP-AO with wrong send SEQ ext number (client)",
+			port++, &saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
 			TEST_CNT_NS_BAD | TEST_CNT_GOOD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
@@ -238,8 +238,8 @@ static void *client_fn(void *arg)
 	/* not expecting client => server mismatches as only rcv sne is broken */
 	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
 			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
-	test_sk_restore("TCP-AO with wrong receive SEQ ext number", port++,
-			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
+	test_sk_restore("TCP-AO with wrong receive SEQ ext number (client)",
+			port++, &saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
 			TEST_CNT_NS_GOOD | TEST_CNT_BAD);
 
 	return NULL;
diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
index 9cd257a995bb35fafad868faf0f325168cea5572..f752df511ba2e646384cf02ccae3c2f807ebaed1 100644
--- a/tools/testing/selftests/net/tcp_ao/rst.c
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -84,15 +84,15 @@ static void close_forced(int sk)
 
 static void test_server_active_rst(unsigned int port)
 {
-	struct tcp_ao_counters cnt1, cnt2;
+	struct tcp_counters cnt1, cnt2;
 	ssize_t bytes;
 	int sk, lsk;
 
 	lsk = test_listen_socket(this_ip_addr, port, backlog);
 	if (test_add_key(lsk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
 		test_error("setsockopt(TCP_AO_ADD_KEY)");
-	if (test_get_tcp_ao_counters(lsk, &cnt1))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(lsk, &cnt1))
+		test_error("test_get_tcp_counters()");
 
 	synchronize_threads(); /* 1: MKT added */
 	if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
@@ -103,8 +103,8 @@ static void test_server_active_rst(unsigned int port)
 		test_error("accept()");
 
 	synchronize_threads(); /* 2: connection accept()ed, another queued */
-	if (test_get_tcp_ao_counters(lsk, &cnt2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(lsk, &cnt2))
+		test_error("test_get_tcp_counters()");
 
 	synchronize_threads(); /* 3: close listen socket */
 	close(lsk);
@@ -128,7 +128,7 @@ static void test_server_active_rst(unsigned int port)
 
 static void test_server_passive_rst(unsigned int port)
 {
-	struct tcp_ao_counters ao1, ao2;
+	struct tcp_counters cnt1, cnt2;
 	int sk, lsk;
 	ssize_t bytes;
 
@@ -147,8 +147,8 @@ static void test_server_passive_rst(unsigned int port)
 
 	synchronize_threads(); /* 2: accepted => send data */
 	close(lsk);
-	if (test_get_tcp_ao_counters(sk, &ao1))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt1))
+		test_error("test_get_tcp_counters()");
 
 	bytes = test_server_run(sk, quota, TEST_TIMEOUT_SEC);
 	if (bytes != quota) {
@@ -160,12 +160,12 @@ static void test_server_passive_rst(unsigned int port)
 
 	synchronize_threads(); /* 3: checkpoint the client */
 	synchronize_threads(); /* 4: close the server, creating twsk */
-	if (test_get_tcp_ao_counters(sk, &ao2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt2))
+		test_error("test_get_tcp_counters()");
 	close(sk);
 
 	synchronize_threads(); /* 5: restore the socket, send more data */
-	test_assert_counters("passive RST server", &ao1, &ao2, TEST_CNT_GOOD);
+	test_assert_counters("passive RST server", &cnt1, &cnt2, TEST_CNT_GOOD);
 
 	synchronize_threads(); /* 6: server exits */
 }
@@ -323,7 +323,7 @@ static void test_client_active_rst(unsigned int port)
 
 static void test_client_passive_rst(unsigned int port)
 {
-	struct tcp_ao_counters ao1, ao2;
+	struct tcp_counters cnt1, cnt2;
 	struct tcp_ao_repair ao_img;
 	struct tcp_sock_state img;
 	sockaddr_af saddr;
@@ -397,8 +397,8 @@ static void test_client_passive_rst(unsigned int port)
 		test_error("setsockopt(TCP_AO_ADD_KEY)");
 	test_ao_restore(sk, &ao_img);
 
-	if (test_get_tcp_ao_counters(sk, &ao1))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt1))
+		test_error("test_get_tcp_counters()");
 
 	test_disable_repair(sk);
 	test_sock_state_free(&img);
@@ -426,12 +426,12 @@ static void test_client_passive_rst(unsigned int port)
 	else
 		test_fail("client sock is yet connected post-seq-adjust");
 
-	if (test_get_tcp_ao_counters(sk, &ao2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt2))
+		test_error("test_get_tcp_counters()");
 
 	synchronize_threads(); /* 6: server exits */
 	close(sk);
-	test_assert_counters("client passive RST", &ao1, &ao2, TEST_CNT_GOOD);
+	test_assert_counters("client passive RST", &cnt1, &cnt2, TEST_CNT_GOOD);
 }
 
 static void *client_fn(void *arg)
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index ebdf8e5d951f024efa4e41a9b67d6adf7cfa8ac7..93732732c60c03ccdec093de4964cf9f8caa7b0d 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -30,7 +30,7 @@ static void setup_lo_intf(const char *lo_intf)
 static void tcp_self_connect(const char *tst, unsigned int port,
 			     bool different_keyids, bool check_restore)
 {
-	struct tcp_ao_counters before_ao, after_ao;
+	struct tcp_counters before, after;
 	uint64_t before_aogood, after_aogood;
 	struct netstat *ns_before, *ns_after;
 	const size_t nr_packets = 20;
@@ -60,8 +60,8 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 
 	ns_before = netstat_read();
 	before_aogood = netstat_get(ns_before, "TCPAOGood", NULL);
-	if (test_get_tcp_ao_counters(sk, &before_ao))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &before))
+		test_error("test_get_tcp_counters()");
 
 	if (__test_connect_socket(sk, "lo", (struct sockaddr *)&addr,
 				  sizeof(addr), TEST_TIMEOUT_SEC) < 0) {
@@ -78,8 +78,8 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 
 	ns_after = netstat_read();
 	after_aogood = netstat_get(ns_after, "TCPAOGood", NULL);
-	if (test_get_tcp_ao_counters(sk, &after_ao))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &after))
+		test_error("test_get_tcp_counters()");
 	if (!check_restore) {
 		/* to debug: netstat_print_diff(ns_before, ns_after); */
 		netstat_free(ns_before);
@@ -93,7 +93,7 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 		return;
 	}
 
-	if (test_assert_counters(tst, &before_ao, &after_ao, TEST_CNT_GOOD)) {
+	if (test_assert_counters(tst, &before, &after, TEST_CNT_GOOD)) {
 		close(sk);
 		return;
 	}
diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
index ea8a84edbd10f9250e90a44c16dd0f971c6b385b..ec2c93b6dc8e721e25b5fc342ef204ecdcab3642 100644
--- a/tools/testing/selftests/net/tcp_ao/seq-ext.c
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -40,7 +40,7 @@ static void test_adjust_seqs(struct tcp_sock_state *img,
 static int test_sk_restore(struct tcp_sock_state *img,
 			   struct tcp_ao_repair *ao_img, sockaddr_af *saddr,
 			   const union tcp_addr daddr, unsigned int dport,
-			   struct tcp_ao_counters *cnt)
+			   struct tcp_counters *cnt)
 {
 	int sk;
 
@@ -54,8 +54,8 @@ static int test_sk_restore(struct tcp_sock_state *img,
 		test_error("setsockopt(TCP_AO_ADD_KEY)");
 	test_ao_restore(sk, ao_img);
 
-	if (test_get_tcp_ao_counters(sk, cnt))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, cnt))
+		test_error("test_get_tcp_counters()");
 
 	test_disable_repair(sk);
 	test_sock_state_free(img);
@@ -65,7 +65,7 @@ static int test_sk_restore(struct tcp_sock_state *img,
 static void *server_fn(void *arg)
 {
 	uint64_t before_good, after_good, after_bad;
-	struct tcp_ao_counters ao1, ao2;
+	struct tcp_counters cnt1, cnt2;
 	struct tcp_sock_state img;
 	struct tcp_ao_repair ao_img;
 	sockaddr_af saddr;
@@ -114,7 +114,7 @@ static void *server_fn(void *arg)
 	test_adjust_seqs(&img, &ao_img, true);
 	synchronize_threads(); /* 4: dump finished */
 	sk = test_sk_restore(&img, &ao_img, &saddr, this_ip_dest,
-			     client_new_port, &ao1);
+			     client_new_port, &cnt1);
 
 	trace_ao_event_sne_expect(TCP_AO_SND_SNE_UPDATE, this_ip_addr,
 			this_ip_dest, test_server_port + 1, client_new_port, 1);
@@ -136,11 +136,11 @@ static void *server_fn(void *arg)
 	}
 
 	synchronize_threads(); /* 6: verify counters after SEQ-number rollover */
-	if (test_get_tcp_ao_counters(sk, &ao2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt2))
+		test_error("test_get_tcp_counters()");
 	after_good = netstat_get_one("TCPAOGood", NULL);
 
-	test_assert_counters(NULL, &ao1, &ao2, TEST_CNT_GOOD);
+	test_assert_counters(NULL, &cnt1, &cnt2, TEST_CNT_GOOD);
 
 	if (after_good <= before_good) {
 		test_fail("TCPAOGood counter did not increase: %" PRIu64 " <= %" PRIu64,
@@ -173,7 +173,7 @@ static void *server_fn(void *arg)
 static void *client_fn(void *arg)
 {
 	uint64_t before_good, after_good, after_bad;
-	struct tcp_ao_counters ao1, ao2;
+	struct tcp_counters cnt1, cnt2;
 	struct tcp_sock_state img;
 	struct tcp_ao_repair ao_img;
 	sockaddr_af saddr;
@@ -213,7 +213,7 @@ static void *client_fn(void *arg)
 	test_adjust_seqs(&img, &ao_img, false);
 	synchronize_threads(); /* 4: dump finished */
 	sk = test_sk_restore(&img, &ao_img, &saddr, this_ip_dest,
-			     test_server_port + 1, &ao1);
+			     test_server_port + 1, &cnt1);
 
 	synchronize_threads(); /* 5: verify the connection during SEQ-number rollover */
 	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
@@ -222,11 +222,11 @@ static void *client_fn(void *arg)
 		test_ok("post-migrate connection alive");
 
 	synchronize_threads(); /* 5: verify counters after SEQ-number rollover */
-	if (test_get_tcp_ao_counters(sk, &ao2))
-		test_error("test_get_tcp_ao_counters()");
+	if (test_get_tcp_counters(sk, &cnt2))
+		test_error("test_get_tcp_counters()");
 	after_good = netstat_get_one("TCPAOGood", NULL);
 
-	test_assert_counters(NULL, &ao1, &ao2, TEST_CNT_GOOD);
+	test_assert_counters(NULL, &cnt1, &cnt2, TEST_CNT_GOOD);
 
 	if (after_good <= before_good) {
 		test_fail("TCPAOGood counter did not increase: %" PRIu64 " <= %" PRIu64,
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index f403ca25bbe6eb0b89f7467dc70b2a5a826838c4..602dc04e3087be428106b0c03667c44a1aa0e53c 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -41,7 +41,7 @@ static void try_accept(const char *tst_name, unsigned int port,
 		       const char *cnt_name, test_cnt cnt_expected,
 		       int needs_tcp_md5, fault_t inj)
 {
-	struct tcp_ao_counters ao_cnt1, ao_cnt2;
+	struct tcp_counters cnt1, cnt2;
 	uint64_t before_cnt = 0, after_cnt = 0; /* silence GCC */
 	int lsk, err, sk = 0;
 	time_t timeout;
@@ -63,8 +63,8 @@ static void try_accept(const char *tst_name, unsigned int port,
 
 	if (cnt_name)
 		before_cnt = netstat_get_one(cnt_name, NULL);
-	if (ao_addr && test_get_tcp_ao_counters(lsk, &ao_cnt1))
-		test_error("test_get_tcp_ao_counters()");
+	if (ao_addr && test_get_tcp_counters(lsk, &cnt1))
+		test_error("test_get_tcp_counters()");
 
 	synchronize_threads(); /* preparations done */
 
@@ -89,8 +89,8 @@ static void try_accept(const char *tst_name, unsigned int port,
 		}
 	}
 
-	if (ao_addr && test_get_tcp_ao_counters(lsk, &ao_cnt2))
-		test_error("test_get_tcp_ao_counters()");
+	if (ao_addr && test_get_tcp_counters(lsk, &cnt2))
+		test_error("test_get_tcp_counters()");
 	close(lsk);
 
 	if (!cnt_name) {
@@ -108,7 +108,7 @@ static void try_accept(const char *tst_name, unsigned int port,
 			tst_name, cnt_name, before_cnt, after_cnt);
 	}
 	if (ao_addr)
-		test_assert_counters(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+		test_assert_counters(tst_name, &cnt1, &cnt2, cnt_expected);
 
 out:
 	synchronize_threads(); /* test_kill_sk() */
@@ -158,7 +158,7 @@ static void *server_fn(void *arg)
 		   TEST_CNT_GOOD, 0, 0);
 	try_accept("AO server (INADDR_ANY): MD5 client", port++, NULL, 0,
 		   &addr_any, 0, 0, 100, 100, 0, "TCPMD5Unexpected",
-		   0, 1, FAULT_TIMEOUT);
+		   TEST_CNT_NS_MD5_UNEXPECTED, 1, FAULT_TIMEOUT);
 	try_accept("AO server (INADDR_ANY): no sign client", port++, NULL, 0,
 		   &addr_any, 0, 0, 100, 100, 0, "TCPAORequired",
 		   TEST_CNT_AO_REQUIRED, 0, FAULT_TIMEOUT);
@@ -204,10 +204,12 @@ static void *server_fn(void *arg)
 		   100, 100, 0, NULL, 0, 1, 0);
 	try_accept("AO+MD5 server: MD5 client (misconfig, matching AO)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
-		   100, 100, 0, "TCPMD5Unexpected", 0, 1, FAULT_TIMEOUT);
+		   100, 100, 0, "TCPMD5Unexpected",
+		   TEST_CNT_NS_MD5_UNEXPECTED, 1, FAULT_TIMEOUT);
 	try_accept("AO+MD5 server: MD5 client (misconfig, non-matching)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
-		   100, 100, 0, "TCPMD5Unexpected", 0, 1, FAULT_TIMEOUT);
+		   100, 100, 0, "TCPMD5Unexpected",
+		   TEST_CNT_NS_MD5_UNEXPECTED, 1, FAULT_TIMEOUT);
 	try_accept("AO+MD5 server: no sign client (unmatched)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "CurrEstab", 0, 1, 0);
@@ -217,7 +219,8 @@ static void *server_fn(void *arg)
 		   TEST_CNT_AO_REQUIRED, 1, FAULT_TIMEOUT);
 	try_accept("AO+MD5 server: no sign client (misconfig, matching MD5)",
 		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
-		   100, 100, 0, "TCPMD5NotFound", 0, 1, FAULT_TIMEOUT);
+		   100, 100, 0, "TCPMD5NotFound",
+		   TEST_CNT_NS_MD5_NOT_FOUND, 1, FAULT_TIMEOUT);
 
 	try_accept("AO+MD5 server: client with both [TCP-MD5] and TCP-AO keys",
 		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,

-- 
2.42.2



