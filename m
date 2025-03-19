Return-Path: <linux-kselftest+bounces-29412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CEA68380
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 04:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D7C19C2ED7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 03:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F2824EAB4;
	Wed, 19 Mar 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXTNxLkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA024E4CB;
	Wed, 19 Mar 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354052; cv=none; b=XCC7L6yKx0Vp2FglajyALhSs3wCDGUHpy2qZFnk4JeKdPz7Qau97ed3n2b9PsLuDGQnYyP4c9hd0bt3m6ckrNIR16kAwRQ7Y2wtIExnVYe/4MHlzRgM2Vv/i1rMiRU59g9B/be179MRf99j/Z2gSWfTrTsnGYSl3VVuk0Mq2hlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354052; c=relaxed/simple;
	bh=gBsn8Ch0aBisW2PG3xJHBQu8kAW5yp44TVOPJmWPl4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVRD5vjZw7HUvpFJqGZjO2jOxdtim0z4P4EMz3u9GUJUF4X0xC3QCtmVuFuR7FwmWzOUPOA6UVkFWYmHHW3gzeuxztcTQuRbK105CN4egvBKHXGhmsJ+xckbn5xWZylri+pCzsL6m7jONl35qcV9D4CyC246BJ70VqzvVYW7Gp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXTNxLkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C0F9C4CEF6;
	Wed, 19 Mar 2025 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742354052;
	bh=gBsn8Ch0aBisW2PG3xJHBQu8kAW5yp44TVOPJmWPl4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RXTNxLkB6t2xGFnEZLdMYZj5xWwO2X7tj7BLvOdnXaUxoCh4t1FLJzYUK+4H+WVbc
	 7HPDUB9kuiauu7tysUxRS95TwmxIwbzXZH4icly7No2iX/zopB+aaqeJNLQ5KiFeUQ
	 3nSsT5ugl2a0MNu2JcTlIVh/ITAkADWW8MBadF9KFbrJsr2p1PSZRxWWRIygRxSuWI
	 44u1V6VX5IDOhfINK1V8hClSFf1JUSBaezpzRIShblvSamRc4R4RPVJPuagvPVHZOf
	 Nt7GhacGw3CuWtPB0veNRNRNCUWHDsVBV/pdRwABci/MKfTcVqYY85S8uD1Q8XCXUl
	 q4GFdFY2n55Xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FBC35FF3;
	Wed, 19 Mar 2025 03:14:12 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 19 Mar 2025 03:13:37 +0000
Subject: [PATCH net-next v2 4/7] selftests/net: Add mixed select()+polling
 mode to TCP-AO tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-tcp-ao-selftests-polling-v2-4-da48040153d1@gmail.com>
References: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
In-Reply-To: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742354050; l=26572;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=JX4Gi/EsCtepimZGUNZznkQ6psONn6XGLPaxojlHsQs=;
 b=Liqz+GvKLEfM00H1u8dHG+kVDLvLaE598WtmZCwWLNONUqIqc6cXsWg5hWh3akuJETbgjdVSL
 4FA0U/XxGVeAQePSeAxqDvSU9FcMmNbpsa3dBCufV4upTTKGwyIsY/A
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Currently, tcp_ao tests have two timeouts: TEST_RETRANSMIT_SEC and
TEST_TIMEOUT_SEC [by default 1 and 5 seconds]. The first one,
TEST_RETRANSMIT_SEC is used for operations that are expected to succeed
in order for a test to pass. It is usually not consumed and exists only
to avoid indefinite test run if the operation didn't complete.
The second one, TEST_RETRANSMIT_SEC exists for the tests that checking
operations, that are expected to fail/timeout. It is shorter as it is
fully consumed, with an expectation that if operation didn't succeed
during that period, it will timeout. And the related test that expects
the timeout is passing. The actual operation failure is then
cross-verified by other means like counters checks.

The issue with TEST_RETRANSMIT_SEC timeout is that 1 second is the exact
initial TCP timeout. So, in case the initial segment gets lost (quite
unlikely on local veth interface between two net namespaces, yet happens
in slow VMs), the retransmission never happens and as a result, the test
is not actually testing the functionality. Which in the end fails
counters checks.

As I want tcp_ao selftests to be fast and finishing in a reasonable
amount of time on manual run, I didn't consider increasing
TEST_RETRANSMIT_SEC.

Rather, initially, BPF_SOCK_OPS_TIMEOUT_INIT looked promising as a lever
to make the initial TCP timeout shorter. But as it's not a socket bpf
attached thing, but sock_ops (attaches to cgroups), the selftests would
have to use libbpf, which I wanted to avoid if not absolutely required.

Instead, use a mixed select() and counters polling mode with the longer
TEST_TIMEOUT_SEC timeout to detect running-away failed tests. It
actually not only allows losing segments and succeeding after
the previous TEST_RETRANSMIT_SEC timeout was consumed, but makes
the tests expecting timeout/failure pass faster.

The only test case taking longer (TEST_TIMEOUT_SEC) now is connect-deny
"wrong snd id", which checks for no key on SYN-ACK for which there is no
counter in the kernel (see tcp_make_synack()). Yet it can be speed up
by poking skpair from the trace event (see trace_tcp_ao_synack_no_key).

Fixes: ed9d09b309b1 ("selftests/net: Add a test for TCP-AO keys matching")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20241205070656.6ef344d7@kernel.org/
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/connect-deny.c |  32 +++--
 tools/testing/selftests/net/tcp_ao/lib/aolib.h    |  37 ++++-
 tools/testing/selftests/net/tcp_ao/lib/sock.c     | 162 +++++++++++++++++++---
 tools/testing/selftests/net/tcp_ao/restore.c      |  17 ++-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c |  51 ++++---
 5 files changed, 232 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
index 919e8d2b91345b453313f25b98cee27b80f1e984..93b61e9a36f1fc77a5fb4d05a5326e0177dd81be 100644
--- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -4,6 +4,7 @@
 #include "aolib.h"
 
 #define fault(type)	(inj == FAULT_ ## type)
+static volatile int sk_pair;
 
 static inline int test_add_key_maclen(int sk, const char *key, uint8_t maclen,
 				      union tcp_addr in_addr, uint8_t prefix,
@@ -36,8 +37,8 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 {
 	struct tcp_counters cnt1, cnt2;
 	uint64_t before_cnt = 0, after_cnt = 0; /* silence GCC */
+	test_cnt poll_cnt = (cnt_expected == TEST_CNT_GOOD) ? 0 : cnt_expected;
 	int lsk, err, sk = 0;
-	time_t timeout;
 
 	lsk = test_listen_socket(this_ip_addr, port, 1);
 
@@ -51,16 +52,19 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 
 	synchronize_threads(); /* preparations done */
 
-	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
-	err = test_wait_fd(lsk, timeout, 0);
+	err = test_skpair_wait_poll(lsk, 0, poll_cnt, &sk_pair);
 	if (err == -ETIMEDOUT) {
+		sk_pair = err;
 		if (!fault(TIMEOUT))
-			test_fail("timed out for accept()");
+			test_fail("%s: timed out for accept()", tst_name);
+	} else if (err == -EKEYREJECTED) {
+		if (!fault(KEYREJECT))
+			test_fail("%s: key was rejected", tst_name);
 	} else if (err < 0) {
-		test_error("test_wait_fd()");
+		test_error("test_skpair_wait_poll()");
 	} else {
 		if (fault(TIMEOUT))
-			test_fail("ready to accept");
+			test_fail("%s: ready to accept", tst_name);
 
 		sk = accept(lsk, NULL, NULL);
 		if (sk < 0) {
@@ -109,7 +113,7 @@ static void *server_fn(void *arg)
 
 	try_accept("Non-AO server + AO client", port++, NULL,
 		   this_ip_dest, -1, 100, 100, 0,
-		   "TCPAOKeyNotFound", 0, FAULT_TIMEOUT);
+		   "TCPAOKeyNotFound", TEST_CNT_NS_KEY_NOT_FOUND, FAULT_TIMEOUT);
 
 	try_accept("AO server + Non-AO client", port++, DEFAULT_TEST_PASSWORD,
 		   this_ip_dest, -1, 100, 100, 0,
@@ -135,8 +139,9 @@ static void *server_fn(void *arg)
 		   wrong_addr, -1, 100, 100, 0,
 		   "TCPAOKeyNotFound", TEST_CNT_AO_KEY_NOT_FOUND, FAULT_TIMEOUT);
 
+	/* Key rejected by the other side, failing short through skpair */
 	try_accept("Client: Wrong addr", port++, NULL,
-		   this_ip_dest, -1, 100, 100, 0, NULL, 0, FAULT_TIMEOUT);
+		   this_ip_dest, -1, 100, 100, 0, NULL, 0, FAULT_KEYREJECT);
 
 	try_accept("rcv id != snd id", port++, DEFAULT_TEST_PASSWORD,
 		   this_ip_dest, -1, 200, 100, 0,
@@ -164,7 +169,6 @@ static void try_connect(const char *tst_name, unsigned int port,
 			test_cnt cnt_expected, fault_t inj)
 {
 	struct tcp_counters cnt1, cnt2;
-	time_t timeout;
 	int sk, ret;
 
 	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
@@ -179,11 +183,10 @@ static void try_connect(const char *tst_name, unsigned int port,
 
 	synchronize_threads(); /* preparations done */
 
-	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
-	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
-
+	ret = test_skpair_connect_poll(sk, this_ip_dest, port, cnt_expected, &sk_pair);
 	synchronize_threads(); /* before counter checks */
 	if (ret < 0) {
+		sk_pair = ret;
 		if (fault(KEYREJECT) && ret == -EKEYREJECTED) {
 			test_ok("%s: connect() was prevented", tst_name);
 		} else if (ret == -ETIMEDOUT && fault(TIMEOUT)) {
@@ -243,6 +246,11 @@ static void *client_fn(void *arg)
 	try_connect("Wrong rcv id", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	/*
+	 * XXX: The test doesn't increase any counters, see tcp_make_synack().
+	 * Potentially, it can be speed up by setting sk_pair = -ETIMEDOUT
+	 * but the price would be increased complexity of the tracer thread.
+	 */
 	trace_ao_event_sk_expect(TCP_AO_SYNACK_NO_KEY, this_ip_dest, addr_any,
 				 port, 0, 100, 100);
 	try_connect("Wrong snd id", port++, DEFAULT_TEST_PASSWORD,
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index b88d15df76886b336cb5f5966fa1e4b2c8eb4a81..3c8c5ac2a878a7a4f5949055bdc2a9f05f3d1de5 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -331,6 +331,7 @@ static inline int test_listen_socket(const union tcp_addr taddr,
  * If set to 0 - kernel will try to retransmit SYN number of times, set in
  * /proc/sys/net/ipv4/tcp_syn_retries
  * By default set to 1 to make tests pass faster on non-busy machine.
+ * [in process of removal, don't use in new tests]
  */
 #ifndef TEST_RETRANSMIT_SEC
 #define TEST_RETRANSMIT_SEC	1
@@ -483,8 +484,6 @@ static inline int test_set_ao_flags(int sk, bool ao_required, bool accept_icmps)
 }
 
 extern ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec);
-extern ssize_t test_client_loop(int sk, char *buf, size_t buf_sz,
-				const size_t msg_len, time_t timeout_sec);
 extern int test_client_verify(int sk, const size_t msg_len, const size_t nr,
 			      time_t timeout_sec);
 
@@ -580,6 +579,40 @@ extern int test_assert_counters_key(const char *tst_name,
 		test_cnt expected, int sndid, int rcvid);
 extern void test_tcp_counters_free(struct tcp_counters *cnts);
 
+/*
+ * Polling for netns and socket counters during select()/connect() and also
+ * client/server messaging. Instead of constant timeout on underlying select(),
+ * check the counters and return early. This allows to pass the tests where
+ * timeout is expected without waiting for that fixing timeout (tests speed-up).
+ * Previously shorter timeouts were used for tests expecting to time out,
+ * but that leaded to sporadic false positives on counter checks failures,
+ * as one second timeouts aren't enough for TCP retransmit.
+ *
+ * Two sides of the socketpair (client/server) should synchronize failures
+ * using a shared variable *err, so that they can detect the other side's
+ * failure.
+ */
+extern int test_skpair_wait_poll(int sk, bool write, test_cnt cond,
+				 volatile int *err);
+extern int _test_skpair_connect_poll(int sk, const char *device,
+				     void *addr, size_t addr_sz,
+				     test_cnt cond, volatile int *err);
+static inline int test_skpair_connect_poll(int sk, const union tcp_addr taddr,
+					   unsigned int port,
+					   test_cnt cond, volatile int *err)
+{
+	sockaddr_af addr;
+
+	tcp_addr_to_sockaddr_in(&addr, &taddr, htons(port));
+	return _test_skpair_connect_poll(sk, veth_name,
+					 (void *)&addr, sizeof(addr), cond, err);
+}
+
+extern int test_skpair_client(int sk, const size_t msg_len, const size_t nr,
+			      test_cnt cond, volatile int *err);
+extern int test_skpair_server(int sk, ssize_t quota,
+			      test_cnt cond, volatile int *err);
+
 /*
  * Frees buffers allocated in test_get_tcp_counters().
  * The function doesn't expect new keys or keys removed between calls
diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 7ffde4dd794219cd43e056da3394deaea9696971..1befaf0aa98f9de83fa466cd68a24f467c541a2d 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -34,10 +34,8 @@ int __test_listen_socket(int backlog, void *addr, size_t addr_sz)
 	return sk;
 }
 
-int test_wait_fd(int sk, time_t sec, bool write)
+static int __test_wait_fd(int sk, struct timeval *tv, bool write)
 {
-	struct timeval tv = { .tv_sec = sec };
-	struct timeval *ptv = NULL;
 	fd_set fds, efds;
 	int ret;
 	socklen_t slen = sizeof(ret);
@@ -47,14 +45,11 @@ int test_wait_fd(int sk, time_t sec, bool write)
 	FD_ZERO(&efds);
 	FD_SET(sk, &efds);
 
-	if (sec)
-		ptv = &tv;
-
 	errno = 0;
 	if (write)
-		ret = select(sk + 1, NULL, &fds, &efds, ptv);
+		ret = select(sk + 1, NULL, &fds, &efds, tv);
 	else
-		ret = select(sk + 1, &fds, NULL, &efds, ptv);
+		ret = select(sk + 1, &fds, NULL, &efds, tv);
 	if (ret < 0)
 		return -errno;
 	if (ret == 0) {
@@ -69,6 +64,52 @@ int test_wait_fd(int sk, time_t sec, bool write)
 	return 0;
 }
 
+int test_wait_fd(int sk, time_t sec, bool write)
+{
+	struct timeval tv = { .tv_sec = sec, };
+
+	return __test_wait_fd(sk, sec ? &tv : NULL, write);
+}
+
+static bool __skpair_poll_should_stop(int sk, struct tcp_counters *c,
+				      test_cnt condition)
+{
+	struct tcp_counters c2;
+	test_cnt diff;
+
+	if (test_get_tcp_counters(sk, &c2))
+		test_error("test_get_tcp_counters()");
+
+	diff = test_cmp_counters(c, &c2);
+	test_tcp_counters_free(&c2);
+	return (diff & condition) == condition;
+}
+
+/* How often wake up and check netns counters & paired (*err) */
+#define POLL_USEC	150
+static int __test_skpair_poll(int sk, bool write, uint64_t timeout,
+			      struct tcp_counters *c, test_cnt cond,
+			      volatile int *err)
+{
+	uint64_t t;
+
+	for (t = 0; t <= timeout * 1000000; t += POLL_USEC) {
+		struct timeval tv = { .tv_usec = POLL_USEC, };
+		int ret;
+
+		ret = __test_wait_fd(sk, &tv, write);
+		if (ret != -ETIMEDOUT)
+			return ret;
+		if (c && cond && __skpair_poll_should_stop(sk, c, cond))
+			break;
+		if (err && *err)
+			return *err;
+	}
+	if (err)
+		*err = -ETIMEDOUT;
+	return -ETIMEDOUT;
+}
+
 int __test_connect_socket(int sk, const char *device,
 			  void *addr, size_t addr_sz, time_t timeout)
 {
@@ -113,6 +154,43 @@ int __test_connect_socket(int sk, const char *device,
 	return err;
 }
 
+int test_skpair_wait_poll(int sk, bool write,
+			  test_cnt cond, volatile int *err)
+{
+	struct tcp_counters c;
+	int ret;
+
+	*err = 0;
+	if (test_get_tcp_counters(sk, &c))
+		test_error("test_get_tcp_counters()");
+	synchronize_threads(); /* 1: init skpair & read nscounters */
+
+	ret = __test_skpair_poll(sk, write, TEST_TIMEOUT_SEC, &c, cond, err);
+	test_tcp_counters_free(&c);
+	return ret;
+}
+
+int _test_skpair_connect_poll(int sk, const char *device,
+			      void *addr, size_t addr_sz,
+			      test_cnt condition, volatile int *err)
+{
+	struct tcp_counters c;
+	int ret;
+
+	*err = 0;
+	if (test_get_tcp_counters(sk, &c))
+		test_error("test_get_tcp_counters()");
+	synchronize_threads(); /* 1: init skpair & read nscounters */
+	ret = __test_connect_socket(sk, device, addr, addr_sz, -1);
+	if (ret < 0) {
+		test_tcp_counters_free(&c);
+		return (*err = ret);
+	}
+	ret = __test_skpair_poll(sk, 1, TEST_TIMEOUT_SEC, &c, condition, err);
+	test_tcp_counters_free(&c);
+	return ret;
+}
+
 int __test_set_md5(int sk, void *addr, size_t addr_sz, uint8_t prefix,
 		   int vrf, const char *password)
 {
@@ -515,7 +593,9 @@ void test_tcp_counters_free(struct tcp_counters *cnts)
 }
 
 #define TEST_BUF_SIZE 4096
-ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec)
+static ssize_t _test_server_run(int sk, ssize_t quota, struct tcp_counters *c,
+				test_cnt cond, volatile int *err,
+				time_t timeout_sec)
 {
 	ssize_t total = 0;
 
@@ -524,7 +604,7 @@ ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec)
 		ssize_t bytes, sent;
 		int ret;
 
-		ret = test_wait_fd(sk, timeout_sec, 0);
+		ret = __test_skpair_poll(sk, 0, timeout_sec, c, cond, err);
 		if (ret)
 			return ret;
 
@@ -535,7 +615,7 @@ ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec)
 		if (bytes == 0)
 			break;
 
-		ret = test_wait_fd(sk, timeout_sec, 1);
+		ret = __test_skpair_poll(sk, 1, timeout_sec, c, cond, err);
 		if (ret)
 			return ret;
 
@@ -550,13 +630,41 @@ ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec)
 	return total;
 }
 
-ssize_t test_client_loop(int sk, char *buf, size_t buf_sz,
-			 const size_t msg_len, time_t timeout_sec)
+ssize_t test_server_run(int sk, ssize_t quota, time_t timeout_sec)
+{
+	return _test_server_run(sk, quota, NULL, 0, NULL,
+				timeout_sec ?: TEST_TIMEOUT_SEC);
+}
+
+int test_skpair_server(int sk, ssize_t quota, test_cnt cond, volatile int *err)
+{
+	struct tcp_counters c;
+	ssize_t ret;
+
+	*err = 0;
+	if (test_get_tcp_counters(sk, &c))
+		test_error("test_get_tcp_counters()");
+	synchronize_threads(); /* 1: init skpair & read nscounters */
+
+	ret = _test_server_run(sk, quota, &c, cond, err, TEST_TIMEOUT_SEC);
+	test_tcp_counters_free(&c);
+	return ret;
+}
+
+static ssize_t test_client_loop(int sk, size_t buf_sz, const size_t msg_len,
+				struct tcp_counters *c, test_cnt cond,
+				volatile int *err, time_t timeout_sec)
 {
 	char msg[msg_len];
 	int nodelay = 1;
+	char *buf;
 	size_t i;
 
+	buf = alloca(buf_sz);
+	if (!buf)
+		return -ENOMEM;
+	randomize_buffer(buf, buf_sz);
+
 	if (setsockopt(sk, IPPROTO_TCP, TCP_NODELAY, &nodelay, sizeof(nodelay)))
 		test_error("setsockopt(TCP_NODELAY)");
 
@@ -564,7 +672,7 @@ ssize_t test_client_loop(int sk, char *buf, size_t buf_sz,
 		size_t sent, bytes = min(msg_len, buf_sz - i);
 		int ret;
 
-		ret = test_wait_fd(sk, timeout_sec, 1);
+		ret = __test_skpair_poll(sk, 1, timeout_sec, c, cond, err);
 		if (ret)
 			return ret;
 
@@ -578,7 +686,7 @@ ssize_t test_client_loop(int sk, char *buf, size_t buf_sz,
 		do {
 			ssize_t got;
 
-			ret = test_wait_fd(sk, timeout_sec, 0);
+			ret = __test_skpair_poll(sk, 0, timeout_sec, c, cond, err);
 			if (ret)
 				return ret;
 
@@ -601,11 +709,29 @@ int test_client_verify(int sk, const size_t msg_len, const size_t nr,
 		       time_t timeout_sec)
 {
 	size_t buf_sz = msg_len * nr;
-	char *buf = alloca(buf_sz);
 	ssize_t ret;
 
-	randomize_buffer(buf, buf_sz);
-	ret = test_client_loop(sk, buf, buf_sz, msg_len, timeout_sec);
+	ret = test_client_loop(sk, buf_sz, msg_len, NULL, 0, NULL, timeout_sec);
+	if (ret < 0)
+		return (int)ret;
+	return ret != buf_sz ? -1 : 0;
+}
+
+int test_skpair_client(int sk, const size_t msg_len, const size_t nr,
+		       test_cnt cond, volatile int *err)
+{
+	struct tcp_counters c;
+	size_t buf_sz = msg_len * nr;
+	ssize_t ret;
+
+	*err = 0;
+	if (test_get_tcp_counters(sk, &c))
+		test_error("test_get_tcp_counters()");
+	synchronize_threads(); /* 1: init skpair & read nscounters */
+
+	ret = test_client_loop(sk, buf_sz, msg_len, &c, cond, err,
+			       TEST_TIMEOUT_SEC);
+	test_tcp_counters_free(&c);
 	if (ret < 0)
 		return (int)ret;
 	return ret != buf_sz ? -1 : 0;
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
index 4b98f06725ef9e8be7742c951d8c160279bab0da..1c7264a5498a693b246c11414cdc20aa73c55117 100644
--- a/tools/testing/selftests/net/tcp_ao/restore.c
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -16,11 +16,11 @@ const size_t quota = nr_packets * msg_len;
 static void try_server_run(const char *tst_name, unsigned int port,
 			   fault_t inj, test_cnt cnt_expected)
 {
+	test_cnt poll_cnt = (cnt_expected == TEST_CNT_GOOD) ? 0 : cnt_expected;
 	const char *cnt_name = "TCPAOGood";
 	struct tcp_counters cnt1, cnt2;
 	uint64_t before_cnt, after_cnt;
-	int sk, lsk;
-	time_t timeout;
+	int sk, lsk, dummy;
 	ssize_t bytes;
 
 	if (fault(TIMEOUT))
@@ -51,8 +51,7 @@ static void try_server_run(const char *tst_name, unsigned int port,
 	if (test_get_tcp_counters(sk, &cnt1))
 		test_error("test_get_tcp_counters()");
 
-	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
-	bytes = test_server_run(sk, quota, timeout);
+	bytes = test_skpair_server(sk, quota, poll_cnt, &dummy);
 	if (fault(TIMEOUT)) {
 		if (bytes > 0)
 			test_fail("%s: server served: %zd", tst_name, bytes);
@@ -139,11 +138,11 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 			    struct tcp_ao_repair *ao_img,
 			    fault_t inj, test_cnt cnt_expected)
 {
+	test_cnt poll_cnt = (cnt_expected == TEST_CNT_GOOD) ? 0 : cnt_expected;
 	const char *cnt_name = "TCPAOGood";
 	struct tcp_counters cnt1, cnt2;
 	uint64_t before_cnt, after_cnt;
-	time_t timeout;
-	int sk;
+	int sk, dummy;
 
 	if (fault(TIMEOUT))
 		cnt_name = "TCPAOBad";
@@ -165,18 +164,18 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 	test_disable_repair(sk);
 	test_sock_state_free(img);
 
-	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
-	if (test_client_verify(sk, msg_len, nr_packets, timeout)) {
+	if (test_skpair_client(sk, msg_len, nr_packets, poll_cnt, &dummy)) {
 		if (fault(TIMEOUT))
 			test_ok("%s: post-migrate connection is broken", tst_name);
 		else
 			test_fail("%s: post-migrate connection is working", tst_name);
 	} else {
 		if (fault(TIMEOUT))
-			test_fail("%s: post-migrate connection still working", tst_name);
+			test_fail("%s: post-migrate connection is working", tst_name);
 		else
 			test_ok("%s: post-migrate connection is alive", tst_name);
 	}
+
 	synchronize_threads(); /* 3: counters checks */
 	if (test_get_tcp_counters(sk, &cnt2))
 		test_error("test_get_tcp_counters()");
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index 602dc04e3087be428106b0c03667c44a1aa0e53c..4cde2c9f7f49c9ae5a7e1bf73745ef77c7b4706a 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -6,6 +6,7 @@
 #define fault(type)	(inj == FAULT_ ## type)
 static const char *md5_password = "Some evil genius, enemy to mankind, must have been the first contriver.";
 static const char *ao_password = DEFAULT_TEST_PASSWORD;
+static volatile int sk_pair;
 
 static union tcp_addr client2;
 static union tcp_addr client3;
@@ -43,8 +44,8 @@ static void try_accept(const char *tst_name, unsigned int port,
 {
 	struct tcp_counters cnt1, cnt2;
 	uint64_t before_cnt = 0, after_cnt = 0; /* silence GCC */
-	int lsk, err, sk = 0;
-	time_t timeout;
+	test_cnt poll_cnt = (cnt_expected == TEST_CNT_GOOD) ? 0 : cnt_expected;
+	int lsk, err, sk = -1;
 
 	if (needs_tcp_md5 && should_skip_test(tst_name, KCONFIG_TCP_MD5))
 		return;
@@ -68,17 +69,20 @@ static void try_accept(const char *tst_name, unsigned int port,
 
 	synchronize_threads(); /* preparations done */
 
-	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
-	err = test_wait_fd(lsk, timeout, 0);
+	err = test_skpair_wait_poll(lsk, 0, poll_cnt, &sk_pair);
 	synchronize_threads(); /* connect()/accept() timeouts */
 	if (err == -ETIMEDOUT) {
+		sk_pair = err;
 		if (!fault(TIMEOUT))
-			test_fail("timed out for accept()");
+			test_fail("%s: timed out for accept()", tst_name);
+	} else if (err == -EKEYREJECTED) {
+		if (!fault(KEYREJECT))
+			test_fail("%s: key was rejected", tst_name);
 	} else if (err < 0) {
-		test_error("test_wait_fd()");
+		test_error("test_skpair_wait_poll()");
 	} else {
 		if (fault(TIMEOUT))
-			test_fail("ready to accept");
+			test_fail("%s: ready to accept", tst_name);
 
 		sk = accept(lsk, NULL, NULL);
 		if (sk < 0) {
@@ -112,7 +116,7 @@ static void try_accept(const char *tst_name, unsigned int port,
 
 out:
 	synchronize_threads(); /* test_kill_sk() */
-	if (sk > 0)
+	if (sk >= 0)
 		test_kill_sk(sk);
 }
 
@@ -172,19 +176,19 @@ static void *server_fn(void *arg)
 
 	try_accept("MD5 server (INADDR_ANY): AO client", port++, &addr_any, 0,
 		   NULL, 0, 0, 0, 0, 0, "TCPAOKeyNotFound",
-		   0, 1, FAULT_TIMEOUT);
+		   TEST_CNT_NS_KEY_NOT_FOUND, 1, FAULT_TIMEOUT);
 	try_accept("MD5 server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
 		   NULL, 0, 0, 0, 0, 0, NULL, 0, 1, 0);
 	try_accept("MD5 server (INADDR_ANY): no sign client", port++, &addr_any,
 		   0, NULL, 0, 0, 0, 0, 0, "TCPMD5NotFound",
-		   0, 1, FAULT_TIMEOUT);
+		   TEST_CNT_NS_MD5_NOT_FOUND, 1, FAULT_TIMEOUT);
 
 	try_accept("no sign server: AO client", port++, NULL, 0,
 		   NULL, 0, 0, 0, 0, 0, "TCPAOKeyNotFound",
-		   TEST_CNT_AO_KEY_NOT_FOUND, 0, FAULT_TIMEOUT);
+		   TEST_CNT_NS_KEY_NOT_FOUND, 0, FAULT_TIMEOUT);
 	try_accept("no sign server: MD5 client", port++, NULL, 0,
 		   NULL, 0, 0, 0, 0, 0, "TCPMD5Unexpected",
-		   0, 1, FAULT_TIMEOUT);
+		   TEST_CNT_NS_MD5_UNEXPECTED, 1, FAULT_TIMEOUT);
 	try_accept("no sign server: no sign client", port++, NULL, 0,
 		   NULL, 0, 0, 0, 0, 0, "CurrEstab", 0, 0, 0);
 
@@ -222,12 +226,13 @@ static void *server_fn(void *arg)
 		   100, 100, 0, "TCPMD5NotFound",
 		   TEST_CNT_NS_MD5_NOT_FOUND, 1, FAULT_TIMEOUT);
 
+	/* Key rejected by the other side, failing short through skpair */
 	try_accept("AO+MD5 server: client with both [TCP-MD5] and TCP-AO keys",
 		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
-		   100, 100, 0, NULL, 0, 1, FAULT_TIMEOUT);
+		   100, 100, 0, NULL, 0, 1, FAULT_KEYREJECT);
 	try_accept("AO+MD5 server: client with both TCP-MD5 and [TCP-AO] keys",
 		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
-		   100, 100, 0, NULL, 0, 1, FAULT_TIMEOUT);
+		   100, 100, 0, NULL, 0, 1, FAULT_KEYREJECT);
 
 	server_add_fail_tests(&port);
 
@@ -262,7 +267,6 @@ static void try_connect(const char *tst_name, unsigned int port,
 		       uint8_t sndid, uint8_t rcvid, uint8_t vrf,
 		       fault_t inj, int needs_tcp_md5, union tcp_addr *bind_addr)
 {
-	time_t timeout;
 	int sk, ret;
 
 	if (needs_tcp_md5 && should_skip_test(tst_name, KCONFIG_TCP_MD5))
@@ -284,11 +288,10 @@ static void try_connect(const char *tst_name, unsigned int port,
 
 	synchronize_threads(); /* preparations done */
 
-	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
-	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
-
+	ret = test_skpair_connect_poll(sk, this_ip_dest, port, 0, &sk_pair);
 	synchronize_threads(); /* connect()/accept() timeouts */
 	if (ret < 0) {
+		sk_pair = ret;
 		if (fault(KEYREJECT) && ret == -EKEYREJECTED)
 			test_ok("%s: connect() was prevented", tst_name);
 		else if (ret == -ETIMEDOUT && fault(TIMEOUT))
@@ -308,8 +311,7 @@ static void try_connect(const char *tst_name, unsigned int port,
 
 out:
 	synchronize_threads(); /* test_kill_sk() */
-	/* _test_connect_socket() cleans up on failure */
-	if (ret > 0)
+	if (ret > 0) /* test_skpair_connect_poll() cleans up on failure */
 		test_kill_sk(sk);
 }
 
@@ -440,7 +442,6 @@ static void try_to_add(const char *tst_name, unsigned int port,
 		       int ao_vrf, uint8_t sndid, uint8_t rcvid,
 		       int needs_tcp_md5, fault_t inj)
 {
-	time_t timeout;
 	int sk, ret;
 
 	if (needs_tcp_md5 && should_skip_test(tst_name, KCONFIG_TCP_MD5))
@@ -453,11 +454,10 @@ static void try_to_add(const char *tst_name, unsigned int port,
 
 	synchronize_threads(); /* preparations done */
 
-	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
-	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
+	ret = test_skpair_connect_poll(sk, this_ip_dest, port, 0, &sk_pair);
 
 	synchronize_threads(); /* connect()/accept() timeouts */
-	if (ret <= 0) {
+	if (ret < 0) {
 		test_error("%s: connect() returned %d", tst_name, ret);
 		goto out;
 	}
@@ -493,8 +493,7 @@ static void try_to_add(const char *tst_name, unsigned int port,
 
 out:
 	synchronize_threads(); /* test_kill_sk() */
-	/* _test_connect_socket() cleans up on failure */
-	if (ret > 0)
+	if (ret > 0) /* test_skpair_connect_poll() cleans up on failure */
 		test_kill_sk(sk);
 }
 

-- 
2.42.2



