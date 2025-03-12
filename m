Return-Path: <linux-kselftest+bounces-28808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A47A5D8F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 10:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4BA3B6CCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A3239597;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJYgb969"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77462239579;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770688; cv=none; b=RUUDXhKDJZA3XeoNJY4DibmH77icZE5LxWFtfzl0CSCv8QaqeXnYik+0kss6XC+tz3zqs/y/P6XMQIsBL+bHUHdJVylfD2743ftOS+G1qpbNoQt3RaC/f5+a+UhR/WDpWG4I3MnQQX/Rb5uGU/drGuuijEhyDsahfElYcGaIFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770688; c=relaxed/simple;
	bh=d+wnV8BFYNRyME4yFJz5Xjp7mfgq9OnZi3w4//dPrxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UK/wUK2419+VreSy8ysg7St4XATTKibCIl2lIIkF/ABUgbsqE0burxzgK3+6FKHQBXtrjEVTTvdrkzI6Zo5uti8Tnqth3+gn9EvGUeQ1sE1F6wFCQRSOWzqsYHAyG1RkLyg8whVXrZox2hYBEdn3MT+xA8EzZ/mrFr+pbBuEycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJYgb969; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02552C4CEEE;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770688;
	bh=d+wnV8BFYNRyME4yFJz5Xjp7mfgq9OnZi3w4//dPrxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fJYgb969g3PaVGRbQJLvqRFLe/Tacmm2/xdJWJeRz4ezmhh9mJPFYw4Pg8hoibhW2
	 7tO5j2y6NSJtVEu/+hint+kpkGRDBacapZU13qlbu2+lJfZp6LL+/Ogpr/HK5zOpDW
	 ocWY1MK3xvVNQgq7JUCksfMZJUr8vXEcKbMD2I+0RgUFlbuzYqEdOVFcpUl0Oav/Ie
	 jD8fzvE9o7TyUdMocwodM67m82gOXupd3DaWefUhAJNGeJlPG8wikJ3hRnDDyupXPu
	 3+4iJMT5MC3rctLcEvHqSK+Js8qVcoesKplJfXHKLDnYloYlTWTazJfTLHW/Qc5T7p
	 jnkP8jLt9axTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC1AC2BA1B;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 12 Mar 2025 09:11:01 +0000
Subject: [PATCH net 7/7] selftests/net: Drop timeout argument from
 test_client_verify()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-tcp-ao-selftests-polling-v1-7-72a642b855d5@gmail.com>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741770685; l=12054;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=JksmPY+LaK+nVqq8odsNUu6RsdKwBhLvAGpTpKJEsZo=;
 b=nUj19BVSIG7IOmoPch21ioC5IhvGY1wj+uWd1vNdV7ZCComaCZwpOZnpYvXnXsvMo98TkSZ/Q
 8Xwm0yL45TDCXgQyPh2EQcabo2ZGMoh6PmFpfkyRyH5Eanx4vRDOMrf
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

It's always TEST_TIMEOUT_SEC, with an unjustified exception in rst test,
that is more paranoia-long timeout rather than based on requirements.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/connect.c        |  2 +-
 tools/testing/selftests/net/tcp_ao/icmps-discard.c  |  3 +--
 tools/testing/selftests/net/tcp_ao/key-management.c |  8 ++++----
 tools/testing/selftests/net/tcp_ao/lib/aolib.h      |  3 +--
 tools/testing/selftests/net/tcp_ao/lib/sock.c       | 15 +++++++--------
 tools/testing/selftests/net/tcp_ao/restore.c        |  2 +-
 tools/testing/selftests/net/tcp_ao/rst.c            |  6 +++---
 tools/testing/selftests/net/tcp_ao/self-connect.c   |  4 ++--
 tools/testing/selftests/net/tcp_ao/seq-ext.c        |  4 ++--
 9 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/connect.c b/tools/testing/selftests/net/tcp_ao/connect.c
index 45f2307483d3bab8c96df26c9dca28c898283c0c..340f00e979eaf6a134a61fa679b37bfcdb273323 100644
--- a/tools/testing/selftests/net/tcp_ao/connect.c
+++ b/tools/testing/selftests/net/tcp_ao/connect.c
@@ -53,7 +53,7 @@ static void *client_fn(void *arg)
 	if (test_get_tcp_counters(sk, &ao1))
 		test_error("test_get_tcp_counters()");
 
-	if (test_client_verify(sk, 100, nr_packets, TEST_TIMEOUT_SEC)) {
+	if (test_client_verify(sk, 100, nr_packets)) {
 		test_fail("verify failed");
 		return NULL;
 	}
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
index 61a5e8e2d7e0d7bd1938c297e847384bf7e1d2c5..85c1a1e958c68fd4f2a609f7ae48664149541ff7 100644
--- a/tools/testing/selftests/net/tcp_ao/icmps-discard.c
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -395,7 +395,6 @@ static void icmp_interfere(const size_t nr, uint32_t rcv_nxt, void *src, void *d
 
 static void send_interfered(int sk)
 {
-	const unsigned int timeout = TEST_TIMEOUT_SEC;
 	struct sockaddr_in6 src, dst;
 	socklen_t addr_sz;
 
@@ -409,7 +408,7 @@ static void send_interfered(int sk)
 	while (1) {
 		uint32_t rcv_nxt;
 
-		if (test_client_verify(sk, packet_size, packets_nr, timeout)) {
+		if (test_client_verify(sk, packet_size, packets_nr)) {
 			test_fail("client: connection is broken");
 			return;
 		}
diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index c4087a15bdb3b68b51489a2d419bd911879c6c08..69d9a7a05d5c1a29741dd45afacad18f933bd6f6 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -918,7 +918,7 @@ static int run_client(const char *tst_name, unsigned int port,
 	collection.keys[rnext_index].used_on_server_tx = 1;
 
 	synchronize_threads(); /* 3: accepted => send data */
-	if (test_client_verify(sk, msg_sz, msg_nr, TEST_TIMEOUT_SEC)) {
+	if (test_client_verify(sk, msg_sz, msg_nr)) {
 		test_fail("verify failed");
 		close(sk);
 		if (before)
@@ -1016,7 +1016,7 @@ static void try_unmatched_keys(int sk, int *rnext_index, unsigned int port)
 	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, this_ip_addr, this_ip_dest,
 			      -1, port, 0, -1, -1, -1, -1, -1,
 			      -1, key->server_keyid, -1);
-	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
+	if (test_client_verify(sk, msg_len, nr_packets))
 		test_fail("verify failed");
 	*rnext_index = i;
 }
@@ -1061,7 +1061,7 @@ static void check_current_back(const char *tst_name, unsigned int port,
 			      port, -1, 0, -1, -1, -1, -1, -1,
 			      collection.keys[rotate_to_index].client_keyid,
 			      collection.keys[current_index].client_keyid, -1);
-	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
+	if (test_client_verify(sk, msg_len, nr_packets))
 		test_fail("verify failed");
 	/* There is a race here: between setting the current_key with
 	 * setsockopt(TCP_AO_INFO) and starting to send some data - there
@@ -1099,7 +1099,7 @@ static void roll_over_keys(const char *tst_name, unsigned int port,
 				collection.keys[i].server_keyid, -1);
 		if (test_set_key(sk, -1, collection.keys[i].server_keyid))
 			test_error("Can't change the Rnext key");
-		if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC)) {
+		if (test_client_verify(sk, msg_len, nr_packets)) {
 			test_fail("verify failed");
 			close(sk);
 			test_tcp_counters_free(&tmp);
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index e4d3d5016b619ef30362bc03802a2455b6aee99c..ebb2899c12fe0abfe8b8292fdf6fa69b800eb8e0 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -484,8 +484,7 @@ static inline int test_set_ao_flags(int sk, bool ao_required, bool accept_icmps)
 }
 
 extern ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec);
-extern int test_client_verify(int sk, const size_t msg_len, const size_t nr,
-			      time_t timeout_sec);
+extern int test_client_verify(int sk, const size_t msg_len, const size_t nr);
 
 struct tcp_ao_key_counters {
 	uint8_t sndid;
diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 7863ebc36f3c6ced463bd3c8d2c082d5ad152e01..ef8e9031d47a3e91786290e558b5d203cbd126f7 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -646,7 +646,7 @@ int test_skpair_server(int sk, ssize_t quota, test_cnt cond, volatile int *err)
 
 static ssize_t test_client_loop(int sk, size_t buf_sz, const size_t msg_len,
 				struct tcp_counters *c, test_cnt cond,
-				volatile int *err, time_t timeout_sec)
+				volatile int *err)
 {
 	char msg[msg_len];
 	int nodelay = 1;
@@ -665,7 +665,7 @@ static ssize_t test_client_loop(int sk, size_t buf_sz, const size_t msg_len,
 		size_t sent, bytes = min(msg_len, buf_sz - i);
 		int ret;
 
-		ret = __test_skpair_poll(sk, 1, timeout_sec, c, cond, err);
+		ret = __test_skpair_poll(sk, 1, TEST_TIMEOUT_SEC, c, cond, err);
 		if (ret)
 			return ret;
 
@@ -679,7 +679,8 @@ static ssize_t test_client_loop(int sk, size_t buf_sz, const size_t msg_len,
 		do {
 			ssize_t got;
 
-			ret = __test_skpair_poll(sk, 0, timeout_sec, c, cond, err);
+			ret = __test_skpair_poll(sk, 0, TEST_TIMEOUT_SEC,
+						 c, cond, err);
 			if (ret)
 				return ret;
 
@@ -698,13 +699,12 @@ static ssize_t test_client_loop(int sk, size_t buf_sz, const size_t msg_len,
 	return i;
 }
 
-int test_client_verify(int sk, const size_t msg_len, const size_t nr,
-		       time_t timeout_sec)
+int test_client_verify(int sk, const size_t msg_len, const size_t nr)
 {
 	size_t buf_sz = msg_len * nr;
 	ssize_t ret;
 
-	ret = test_client_loop(sk, buf_sz, msg_len, NULL, 0, NULL, timeout_sec);
+	ret = test_client_loop(sk, buf_sz, msg_len, NULL, 0, NULL);
 	if (ret < 0)
 		return (int)ret;
 	return ret != buf_sz ? -1 : 0;
@@ -722,8 +722,7 @@ int test_skpair_client(int sk, const size_t msg_len, const size_t nr,
 		test_error("test_get_tcp_counters()");
 	synchronize_threads(); /* 1: init skpair & read nscounters */
 
-	ret = test_client_loop(sk, buf_sz, msg_len, &c, cond, err,
-			       TEST_TIMEOUT_SEC);
+	ret = test_client_loop(sk, buf_sz, msg_len, &c, cond, err);
 	test_tcp_counters_free(&c);
 	if (ret < 0)
 		return (int)ret;
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
index 1c7264a5498a693b246c11414cdc20aa73c55117..9a059b6c45231d118a6f5324afba511b7d339ece 100644
--- a/tools/testing/selftests/net/tcp_ao/restore.c
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -124,7 +124,7 @@ static void test_get_sk_checkpoint(unsigned int server_port, sockaddr_af *saddr,
 		test_error("failed to connect()");
 
 	synchronize_threads(); /* 2: accepted => send data */
-	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
+	if (test_client_verify(sk, msg_len, nr_packets))
 		test_fail("pre-migrate verify failed");
 
 	test_enable_repair(sk);
diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
index e51be747e2b4f5e0a02f413afd011168a8554302..883cddf377cff899f79220439bc58fe66f5da4d8 100644
--- a/tools/testing/selftests/net/tcp_ao/rst.c
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -287,7 +287,7 @@ static void test_client_active_rst(unsigned int port)
 		test_error("failed to connect()");
 
 	synchronize_threads(); /* 3: close listen socket */
-	if (test_client_verify(sk[0], packet_sz, quota / packet_sz, TEST_TIMEOUT_SEC))
+	if (test_client_verify(sk[0], packet_sz, quota / packet_sz))
 		test_fail("Failed to send data on connected socket");
 	else
 		test_ok("Verified established tcp connection");
@@ -340,7 +340,7 @@ static void test_client_passive_rst(unsigned int port)
 		test_error("failed to connect()");
 
 	synchronize_threads(); /* 2: accepted => send data */
-	if (test_client_verify(sk, packet_sz, quota / packet_sz, TEST_TIMEOUT_SEC))
+	if (test_client_verify(sk, packet_sz, quota / packet_sz))
 		test_fail("Failed to send data on connected socket");
 	else
 		test_ok("Verified established tcp connection");
@@ -416,7 +416,7 @@ static void test_client_passive_rst(unsigned int port)
 	 * IP 10.0.254.1.7011 > 10.0.1.1.59772: Flags [R], seq 3215596252, win 0,
 	 *    options [tcp-ao keyid 100 rnextkeyid 100 mac 0x0bcfbbf497bce844312304b2], length 0
 	 */
-	err = test_client_verify(sk, packet_sz, quota / packet_sz, 2 * TEST_TIMEOUT_SEC);
+	err = test_client_verify(sk, packet_sz, quota / packet_sz);
 	/* Make sure that the connection was reset, not timeouted */
 	if (err && err == -ECONNRESET)
 		test_ok("client sock was passively reset post-seq-adjust");
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index 10927cfa23840d31a67e4de34fa2211f9b54cf4b..73b2f2276f3f5410aaa74bede7f366f81761bd6e 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -70,7 +70,7 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 		test_error("failed to connect()");
 	}
 
-	if (test_client_verify(sk, 100, nr_packets, TEST_TIMEOUT_SEC)) {
+	if (test_client_verify(sk, 100, nr_packets)) {
 		test_fail("%s: tcp connection verify failed", tst);
 		close(sk);
 		return;
@@ -136,7 +136,7 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 	test_ao_restore(sk, &ao_img);
 	test_disable_repair(sk);
 	test_sock_state_free(&img);
-	if (test_client_verify(sk, 100, nr_packets, TEST_TIMEOUT_SEC)) {
+	if (test_client_verify(sk, 100, nr_packets)) {
 		test_fail("%s: tcp connection verify failed", tst);
 		close(sk);
 		return;
diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
index ec2c93b6dc8e721e25b5fc342ef204ecdcab3642..f00245263b20d95942f49b2fcb7c90604b43f39f 100644
--- a/tools/testing/selftests/net/tcp_ao/seq-ext.c
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -191,7 +191,7 @@ static void *client_fn(void *arg)
 		test_error("failed to connect()");
 
 	synchronize_threads(); /* 2: accepted => send data */
-	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC)) {
+	if (test_client_verify(sk, msg_len, nr_packets)) {
 		test_fail("pre-migrate verify failed");
 		return NULL;
 	}
@@ -216,7 +216,7 @@ static void *client_fn(void *arg)
 			     test_server_port + 1, &cnt1);
 
 	synchronize_threads(); /* 5: verify the connection during SEQ-number rollover */
-	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
+	if (test_client_verify(sk, msg_len, nr_packets))
 		test_fail("post-migrate verify failed");
 	else
 		test_ok("post-migrate connection alive");

-- 
2.42.2



