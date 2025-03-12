Return-Path: <linux-kselftest+bounces-28801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA2A5D8E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5376189C396
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB2A238D53;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYSup2qi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1B23816C;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770688; cv=none; b=gXYLQWWd7NuRe56FZIRPaxWNmtR0S45FGPUw4HsIDlvO5IryjbSMayaV8NOjLiUVi6WHBd/MUeG7OYJYto7RtzMhtF9lNMGgxPw79lVyLjiwL8Zmy4HbVaT8G5LbAav4pHj4PmOtwxk5WMIg9Hm2p1ZMUWaNLr0T9j3igJ1ISvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770688; c=relaxed/simple;
	bh=10NxpNo8fTjEr+j3mXL4/5XrU2dG1VFIHha/kNdeluU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KiHrSeVjX2cmB747l26xLN6+d6UpBgupjHHIedYm9DCVQ2m6UTHheq3f/0PnZJkeXhRjk5cm/f1SFnf0CiBbsU5pvI57il2r1+kM/YGfV5lhwxcRA5N6/rznBHksT4TGD2xRFk3DfLUcn3IHdRvwpyVPQCojqbW6/abc43BqWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYSup2qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F2C2C4CEEF;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770687;
	bh=10NxpNo8fTjEr+j3mXL4/5XrU2dG1VFIHha/kNdeluU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qYSup2qiDs3WfLoHdTkz3z7dgPjck4jLxUEmf64mxMpN2+DhSTZdISbBZ/3FsMgMe
	 4vR3/lDifNDbbo+u+xs1IDqjE6e1yoQmqKQVErD2IcN4MVMdfsgfOvnBsZfyc/1te+
	 fws/CbPFtwN9RXg2YcKH51PJ/DaffDkCjWUqo4nOXdLU54H0o+IYS6bnn4VXwr0NZE
	 99NkPLoWZXX5M99+qVVqq+A4SQBEBl8/h8Q302rwE9pz3H4Cgue0nxGiC6ZwbGrCE8
	 1J5Vt9D5FG8GyPwQ3ouE1vqgr8wvswW+FVDemCOGU8nBKhR5WfEpz0VFRhD/lmkxzO
	 yzBVQAeWJlaug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BA7C35FF1;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 12 Mar 2025 09:10:56 +0000
Subject: [PATCH net 2/7] selftests/net: Provide tcp-ao counters comparison
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-tcp-ao-selftests-polling-v1-2-72a642b855d5@gmail.com>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741770685; l=17907;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=4gAghp1JnLqbEN+mlAbL7HebZyV/n3ZZqw2jMyLo0cs=;
 b=A3ANeGosrRmYbDCBOpkSs8ASTAL4pk8v9Gav0uL0sMBsaaT3S4LEfETfWdIQX85+VKXTRrJyw
 XmkuMfkfpH/AMo2BE/gZ42ahGqTK4KPBRuPLKl3PWx8p/s1pZPbuBV1
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Rename __test_tcp_ao_counters_cmp() into test_assert_counters_ao() and
test_tcp_ao_key_counters_cmp() into test_assert_counters_key() as they
are asserts, rather than just compare functions.

Provide test_cmp_counters() helper, that's going to be used to compare
ao_info and netns counters as a stop condition for polling the sockets.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |  4 +-
 tools/testing/selftests/net/tcp_ao/connect.c       |  2 +-
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |  4 +-
 .../testing/selftests/net/tcp_ao/key-management.c  |  8 +--
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     | 33 ++++++---
 tools/testing/selftests/net/tcp_ao/lib/sock.c      | 83 ++++++++++++----------
 tools/testing/selftests/net/tcp_ao/restore.c       |  4 +-
 tools/testing/selftests/net/tcp_ao/rst.c           |  6 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  2 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  4 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  2 +-
 11 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
index d418162d335f4c7b584fe81a7206f721d4efc20c..42223a1a7a822d84661c727ab1c8125fef534fa0 100644
--- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -78,7 +78,7 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 	close(lsk);
 
 	if (pwd)
-		test_tcp_ao_counters_cmp(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+		test_assert_counters(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
 
 	if (!cnt_name)
 		goto out;
@@ -204,7 +204,7 @@ static void try_connect(const char *tst_name, unsigned int port,
 	if (pwd && ret > 0) {
 		if (test_get_tcp_ao_counters(sk, &ao_cnt2))
 			test_error("test_get_tcp_ao_counters()");
-		test_tcp_ao_counters_cmp(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+		test_assert_counters(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
 	}
 out:
 	synchronize_threads(); /* close() */
diff --git a/tools/testing/selftests/net/tcp_ao/connect.c b/tools/testing/selftests/net/tcp_ao/connect.c
index f1d8d29e393f619d53ff0f370779ff5d227a7f5b..87647f38e7e6a6c0fde9a2789debe98e22a178dd 100644
--- a/tools/testing/selftests/net/tcp_ao/connect.c
+++ b/tools/testing/selftests/net/tcp_ao/connect.c
@@ -71,7 +71,7 @@ static void *client_fn(void *arg)
 				nr_packets, after_aogood, before_aogood);
 		return NULL;
 	}
-	if (test_tcp_ao_counters_cmp("connect", &ao1, &ao2, TEST_CNT_GOOD))
+	if (test_assert_counters("connect", &ao1, &ao2, TEST_CNT_GOOD))
 		return NULL;
 
 	test_ok("connect TCPAOGood %" PRIu64 "/%" PRIu64 "/%" PRIu64 " => %" PRIu64 "/%" PRIu64 "/%" PRIu64 ", sent %zu",
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
index a1614f0d8c44882e683adbdd6e010bb5a8bad9d3..e2958a6a0e28efa0c8a339b1a014f2fabf0dd7ce 100644
--- a/tools/testing/selftests/net/tcp_ao/icmps-discard.c
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -91,9 +91,9 @@ static void serve_interfered(int sk)
 		return;
 	}
 #ifdef TEST_ICMPS_ACCEPT
-	test_tcp_ao_counters_cmp(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD);
+	test_assert_counters(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD);
 #else
-	test_tcp_ao_counters_cmp(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD | TEST_CNT_AO_DROPPED_ICMP);
+	test_assert_counters(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD | TEST_CNT_AO_DROPPED_ICMP);
 #endif
 	if (icmp_ignored_a >= icmp_ignored_b) {
 		test_icmps_fail("%s counter didn't change: %" PRIu64 " >= %" PRIu64,
diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index d4385b52c10b6bda6e047bbb09ae8f32f284042c..2c55c686285acedcdc5a836f7818e35be1ad9d91 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -633,7 +633,7 @@ static void verify_counters(const char *tst_name, bool is_listen_sk, bool server
 {
 	unsigned int i;
 
-	__test_tcp_ao_counters_cmp(tst_name, a, b, TEST_CNT_GOOD);
+	test_assert_counters_ao(tst_name, a, b, TEST_CNT_GOOD);
 
 	for (i = 0; i < collection.nr_keys; i++) {
 		struct test_key *key = &collection.keys[i];
@@ -652,9 +652,9 @@ static void verify_counters(const char *tst_name, bool is_listen_sk, bool server
 			rx_cnt_expected = key->used_on_server_tx;
 		}
 
-		test_tcp_ao_key_counters_cmp(tst_name, a, b,
-					     rx_cnt_expected ? TEST_CNT_KEY_GOOD : 0,
-					     sndid, rcvid);
+		test_assert_counters_key(tst_name, a, b,
+					 rx_cnt_expected ? TEST_CNT_KEY_GOOD : 0,
+					 sndid, rcvid);
 	}
 	test_tcp_ao_counters_free(a);
 	test_tcp_ao_counters_free(b);
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index 5db2f65cddc4e7f0186caf538e512416ddaf7286..d6557940ef1fa6bf52da9efea04156edd9b10b7e 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -528,6 +528,22 @@ extern int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out);
 #define TEST_CNT_NS_DROPPED_ICMP	BIT(11)
 typedef uint16_t test_cnt;
 
+#define _for_each_counter(f)						\
+do {									\
+	/* per-netns */							\
+	f(netns_ao_good,		TEST_CNT_NS_GOOD);		\
+	f(netns_ao_bad,			TEST_CNT_NS_BAD);		\
+	f(netns_ao_key_not_found,	TEST_CNT_NS_KEY_NOT_FOUND);	\
+	f(netns_ao_required,		TEST_CNT_NS_AO_REQUIRED);	\
+	f(netns_ao_dropped_icmp,	TEST_CNT_NS_DROPPED_ICMP);	\
+	/* per-socket */						\
+	f(ao_info_pkt_good,		TEST_CNT_SOCK_GOOD);		\
+	f(ao_info_pkt_bad,		TEST_CNT_SOCK_BAD);		\
+	f(ao_info_pkt_key_not_found,	TEST_CNT_SOCK_KEY_NOT_FOUND);	\
+	f(ao_info_pkt_ao_required,	TEST_CNT_SOCK_AO_REQUIRED);	\
+	f(ao_info_pkt_dropped_icmp,	TEST_CNT_SOCK_DROPPED_ICMP);	\
+} while (0)
+
 #define TEST_CNT_AO_GOOD		(TEST_CNT_SOCK_GOOD | TEST_CNT_NS_GOOD)
 #define TEST_CNT_AO_BAD			(TEST_CNT_SOCK_BAD | TEST_CNT_NS_BAD)
 #define TEST_CNT_AO_KEY_NOT_FOUND	(TEST_CNT_SOCK_KEY_NOT_FOUND | \
@@ -539,10 +555,10 @@ typedef uint16_t test_cnt;
 #define TEST_CNT_GOOD			(TEST_CNT_KEY_GOOD | TEST_CNT_AO_GOOD)
 #define TEST_CNT_BAD			(TEST_CNT_KEY_BAD | TEST_CNT_AO_BAD)
 
-extern int __test_tcp_ao_counters_cmp(const char *tst_name,
+extern int test_assert_counters_ao(const char *tst_name,
 		struct tcp_ao_counters *before, struct tcp_ao_counters *after,
 		test_cnt expected);
-extern int test_tcp_ao_key_counters_cmp(const char *tst_name,
+extern int test_assert_counters_key(const char *tst_name,
 		struct tcp_ao_counters *before, struct tcp_ao_counters *after,
 		test_cnt expected, int sndid, int rcvid);
 extern void test_tcp_ao_counters_free(struct tcp_ao_counters *cnts);
@@ -552,18 +568,17 @@ extern void test_tcp_ao_counters_free(struct tcp_ao_counters *cnts);
  * to test_get_tcp_ao_counters(). Check key counters manually if they
  * may change.
  */
-static inline int test_tcp_ao_counters_cmp(const char *tst_name,
-					   struct tcp_ao_counters *before,
-					   struct tcp_ao_counters *after,
-					   test_cnt expected)
+static inline int test_assert_counters(const char *tst_name,
+				       struct tcp_ao_counters *before,
+				       struct tcp_ao_counters *after,
+				       test_cnt expected)
 {
 	int ret;
 
-	ret = __test_tcp_ao_counters_cmp(tst_name, before, after, expected);
+	ret = test_assert_counters_ao(tst_name, before, after, expected);
 	if (ret)
 		goto out;
-	ret = test_tcp_ao_key_counters_cmp(tst_name, before, after,
-					   expected, -1, -1);
+	ret = test_assert_counters_key(tst_name, before, after, expected, -1, -1);
 out:
 	test_tcp_ao_counters_free(before);
 	test_tcp_ao_counters_free(after);
diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 0ffda966c677b36929ed939ddb42b25c6612e22c..2a2586b2ffa2bdf805562255e597ccd09597b33c 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -403,55 +403,66 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
 	return 0;
 }
 
-int __test_tcp_ao_counters_cmp(const char *tst_name,
-			       struct tcp_ao_counters *before,
-			       struct tcp_ao_counters *after,
-			       test_cnt expected)
+int test_cmp_counters(struct tcp_ao_counters *before, struct tcp_ao_counters *after)
 {
-#define __cmp_ao(cnt, expecting_inc)					\
+#define __cmp(cnt, e_cnt)						\
+do {									\
+	if (before->cnt > after->cnt)					\
+		return -1;						\
+	if (before->cnt != after->cnt)					\
+		ret |= e_cnt;						\
+} while (0)
+
+	int ret = 0;
+	size_t i;
+
+	if (before->nr_keys != after->nr_keys)
+		return -1;
+
+	_for_each_counter(__cmp);
+
+	i = before->nr_keys;
+	while (i--) {
+		__cmp(key_cnts[i].pkt_good, TEST_CNT_KEY_GOOD);
+		__cmp(key_cnts[i].pkt_bad, TEST_CNT_KEY_BAD);
+	}
+#undef __cmp
+	return ret;
+}
+
+int test_assert_counters_ao(const char *tst_name,
+			    struct tcp_ao_counters *before,
+			    struct tcp_ao_counters *after,
+			    test_cnt expected)
+{
+#define __cmp_ao(cnt, e_cnt)						\
 do {									\
 	if (before->cnt > after->cnt) {					\
 		test_fail("%s: Decreased counter " __stringify(cnt) " %" PRIu64 " > %" PRIu64, \
-			  tst_name ?: "", before->cnt, after->cnt);		\
+			  tst_name ?: "", before->cnt, after->cnt);	\
 		return -1;						\
 	}								\
-	if ((before->cnt != after->cnt) != (expecting_inc)) {		\
+	if ((before->cnt != after->cnt) != !!(expected & e_cnt)) {	\
 		test_fail("%s: Counter " __stringify(cnt) " was %sexpected to increase %" PRIu64 " => %" PRIu64, \
-			  tst_name ?: "", (expecting_inc) ? "" : "not ",	\
+			  tst_name ?: "", (expected & e_cnt) ? "" : "not ",	\
 			  before->cnt, after->cnt);			\
 		return -1;						\
 	}								\
-} while(0)
+} while (0)
 
 	errno = 0;
-	/* per-netns */
-	__cmp_ao(netns_ao_good, !!(expected & TEST_CNT_NS_GOOD));
-	__cmp_ao(netns_ao_bad, !!(expected & TEST_CNT_NS_BAD));
-	__cmp_ao(netns_ao_key_not_found,
-		 !!(expected & TEST_CNT_NS_KEY_NOT_FOUND));
-	__cmp_ao(netns_ao_required, !!(expected & TEST_CNT_NS_AO_REQUIRED));
-	__cmp_ao(netns_ao_dropped_icmp,
-		 !!(expected & TEST_CNT_NS_DROPPED_ICMP));
-	/* per-socket */
-	__cmp_ao(ao_info_pkt_good, !!(expected & TEST_CNT_SOCK_GOOD));
-	__cmp_ao(ao_info_pkt_bad, !!(expected & TEST_CNT_SOCK_BAD));
-	__cmp_ao(ao_info_pkt_key_not_found,
-		 !!(expected & TEST_CNT_SOCK_KEY_NOT_FOUND));
-	__cmp_ao(ao_info_pkt_ao_required, !!(expected & TEST_CNT_SOCK_AO_REQUIRED));
-	__cmp_ao(ao_info_pkt_dropped_icmp,
-		 !!(expected & TEST_CNT_SOCK_DROPPED_ICMP));
+	_for_each_counter(__cmp_ao);
 	return 0;
 #undef __cmp_ao
 }
 
-int test_tcp_ao_key_counters_cmp(const char *tst_name,
-				 struct tcp_ao_counters *before,
-				 struct tcp_ao_counters *after,
-				 test_cnt expected,
-				 int sndid, int rcvid)
+int test_assert_counters_key(const char *tst_name,
+			     struct tcp_ao_counters *before,
+			     struct tcp_ao_counters *after,
+			     test_cnt expected, int sndid, int rcvid)
 {
 	size_t i;
-#define __cmp_ao(i, cnt, expecting_inc)					\
+#define __cmp_ao(i, cnt, e_cnt)					\
 do {									\
 	if (before->key_cnts[i].cnt > after->key_cnts[i].cnt) {		\
 		test_fail("%s: Decreased counter " __stringify(cnt) " %" PRIu64 " > %" PRIu64 " for key %u:%u", \
@@ -461,16 +472,16 @@ do {									\
 			  before->key_cnts[i].rcvid);			\
 		return -1;						\
 	}								\
-	if ((before->key_cnts[i].cnt != after->key_cnts[i].cnt) != (expecting_inc)) {		\
+	if ((before->key_cnts[i].cnt != after->key_cnts[i].cnt) != !!(expected & e_cnt)) {		\
 		test_fail("%s: Counter " __stringify(cnt) " was %sexpected to increase %" PRIu64 " => %" PRIu64 " for key %u:%u", \
-			  tst_name ?: "", (expecting_inc) ? "" : "not ",\
+			  tst_name ?: "", (expected & e_cnt) ? "" : "not ",\
 			  before->key_cnts[i].cnt,			\
 			  after->key_cnts[i].cnt,			\
 			  before->key_cnts[i].sndid,			\
 			  before->key_cnts[i].rcvid);			\
 		return -1;						\
 	}								\
-} while(0)
+} while (0)
 
 	if (before->nr_keys != after->nr_keys) {
 		test_fail("%s: Keys changed on the socket %zu != %zu",
@@ -485,8 +496,8 @@ do {									\
 			continue;
 		if (rcvid >= 0 && before->key_cnts[i].rcvid != rcvid)
 			continue;
-		__cmp_ao(i, pkt_good, !!(expected & TEST_CNT_KEY_GOOD));
-		__cmp_ao(i, pkt_bad, !!(expected & TEST_CNT_KEY_BAD));
+		__cmp_ao(i, pkt_good, TEST_CNT_KEY_GOOD);
+		__cmp_ao(i, pkt_bad, TEST_CNT_KEY_BAD);
 	}
 	return 0;
 #undef __cmp_ao
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
index ecc6f1e3a41418204a541ec4859cb22bbcf36856..ad8505f77023bcfb0712108c8148f5c94def67b1 100644
--- a/tools/testing/selftests/net/tcp_ao/restore.c
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -69,7 +69,7 @@ static void try_server_run(const char *tst_name, unsigned int port,
 		test_error("test_get_tcp_ao_counters()");
 	after_cnt = netstat_get_one(cnt_name, NULL);
 
-	test_tcp_ao_counters_cmp(tst_name, &ao1, &ao2, cnt_expected);
+	test_assert_counters(tst_name, &ao1, &ao2, cnt_expected);
 
 	if (after_cnt <= before_cnt) {
 		test_fail("%s: %s counter did not increase: %" PRIu64 " <= %" PRIu64,
@@ -182,7 +182,7 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 		test_error("test_get_tcp_ao_counters()");
 	after_cnt = netstat_get_one(cnt_name, NULL);
 
-	test_tcp_ao_counters_cmp(tst_name, &ao1, &ao2, cnt_expected);
+	test_assert_counters(tst_name, &ao1, &ao2, cnt_expected);
 
 	if (after_cnt <= before_cnt) {
 		test_fail("%s: %s counter did not increase: %" PRIu64 " <= %" PRIu64,
diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
index 6364facaa63ed79d17bdbfda57441c51d9039279..9cd257a995bb35fafad868faf0f325168cea5572 100644
--- a/tools/testing/selftests/net/tcp_ao/rst.c
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -120,7 +120,7 @@ static void test_server_active_rst(unsigned int port)
 	synchronize_threads(); /* 5: closed active sk */
 
 	synchronize_threads(); /* 6: counters checks */
-	if (test_tcp_ao_counters_cmp("active RST server", &cnt1, &cnt2, TEST_CNT_GOOD))
+	if (test_assert_counters("active RST server", &cnt1, &cnt2, TEST_CNT_GOOD))
 		test_fail("MKT counters (server) have not only good packets");
 	else
 		test_ok("MKT counters are good on server");
@@ -165,7 +165,7 @@ static void test_server_passive_rst(unsigned int port)
 	close(sk);
 
 	synchronize_threads(); /* 5: restore the socket, send more data */
-	test_tcp_ao_counters_cmp("passive RST server", &ao1, &ao2, TEST_CNT_GOOD);
+	test_assert_counters("passive RST server", &ao1, &ao2, TEST_CNT_GOOD);
 
 	synchronize_threads(); /* 6: server exits */
 }
@@ -431,7 +431,7 @@ static void test_client_passive_rst(unsigned int port)
 
 	synchronize_threads(); /* 6: server exits */
 	close(sk);
-	test_tcp_ao_counters_cmp("client passive RST", &ao1, &ao2, TEST_CNT_GOOD);
+	test_assert_counters("client passive RST", &ao1, &ao2, TEST_CNT_GOOD);
 }
 
 static void *client_fn(void *arg)
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index 3ecd2b58de6a396dfa559fd10a6a00f64b4daf83..ebdf8e5d951f024efa4e41a9b67d6adf7cfa8ac7 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -93,7 +93,7 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 		return;
 	}
 
-	if (test_tcp_ao_counters_cmp(tst, &before_ao, &after_ao, TEST_CNT_GOOD)) {
+	if (test_assert_counters(tst, &before_ao, &after_ao, TEST_CNT_GOOD)) {
 		close(sk);
 		return;
 	}
diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
index 8901a6785dc8158227414cf90b461c5d2fe39689..ea8a84edbd10f9250e90a44c16dd0f971c6b385b 100644
--- a/tools/testing/selftests/net/tcp_ao/seq-ext.c
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -140,7 +140,7 @@ static void *server_fn(void *arg)
 		test_error("test_get_tcp_ao_counters()");
 	after_good = netstat_get_one("TCPAOGood", NULL);
 
-	test_tcp_ao_counters_cmp(NULL, &ao1, &ao2, TEST_CNT_GOOD);
+	test_assert_counters(NULL, &ao1, &ao2, TEST_CNT_GOOD);
 
 	if (after_good <= before_good) {
 		test_fail("TCPAOGood counter did not increase: %" PRIu64 " <= %" PRIu64,
@@ -226,7 +226,7 @@ static void *client_fn(void *arg)
 		test_error("test_get_tcp_ao_counters()");
 	after_good = netstat_get_one("TCPAOGood", NULL);
 
-	test_tcp_ao_counters_cmp(NULL, &ao1, &ao2, TEST_CNT_GOOD);
+	test_assert_counters(NULL, &ao1, &ao2, TEST_CNT_GOOD);
 
 	if (after_good <= before_good) {
 		test_fail("TCPAOGood counter did not increase: %" PRIu64 " <= %" PRIu64,
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index f779e5892bc162374fe6a64f5258b7227f19ba7a..f403ca25bbe6eb0b89f7467dc70b2a5a826838c4 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -108,7 +108,7 @@ static void try_accept(const char *tst_name, unsigned int port,
 			tst_name, cnt_name, before_cnt, after_cnt);
 	}
 	if (ao_addr)
-		test_tcp_ao_counters_cmp(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+		test_assert_counters(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
 
 out:
 	synchronize_threads(); /* test_kill_sk() */

-- 
2.42.2



