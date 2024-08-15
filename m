Return-Path: <linux-kselftest+bounces-15456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A23953CAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C15B1C24496
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D2153BF0;
	Thu, 15 Aug 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlZFwsno"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D314F12F;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757570; cv=none; b=oAjB1fSxnn8KG40Yd2bmP4SLJSkEcgRqIHRu5rynk5CoER69PFFqbam5NAq0h4jWHkNUBtbq9odp+LUjwySLN2m3WwI0cJ0d6nqOw/Q5KTYl0+MHoiRVs9OVmN+9z4+Z5RAVq1uSQ1tbg3gASX7mSXm9BrXPmXQTwpWYGDg7+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757570; c=relaxed/simple;
	bh=qaIxzhJ+auD33h9udz/QNyEoZ851JZn2dE3kSu2mnnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxrpvyLUWbAzzSxooeT+QIiJZ2AxzJ6Ki+ApuQobLFArgbVlTyFE2kD0sOUJD+gM2x6YCCBJkWL/FuYh6sl1rdZ304jZmqfH6BE8Ty0e/hj83K8uBxgdeigiqOY0nrf0eEmCEcT3TnHpurg6W8kt2KcGCeeL3dCys72AXD06PMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlZFwsno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD923C4AF1A;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723757569;
	bh=qaIxzhJ+auD33h9udz/QNyEoZ851JZn2dE3kSu2mnnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nlZFwsnoPvVD89ruV+4WNhD5yEdX6Yfn4XxCnLnvmql9X21xBaQJ6BR4tJs/pLOvw
	 9jQ0yZohU2SF7cenxHT8GmIcXz93kGFa984l99KdKZVlSHfYxzn8dsRMNOUO7Ew8k3
	 /c1GyBoE0IUYhQ7Rx9EzSlxXyMFTytXSDaXScxjIg0rtTLzljAihey6O34tQg+dddC
	 MDlosv4JQpBt6SIJMvhnEMoSgz2DgHCpcKh7ShClGYXs83SkHPXKxN6OJSnqLL6TNr
	 xXEZRp44e/hk9wFB0HqawdJU8Z4RtDC+DdkVGtSddZxPs1OxYQlk+/pBzzmql7aQ2F
	 FURW9oOWdQMpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0560C531DD;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 15 Aug 2024 22:32:31 +0100
Subject: [PATCH net-next v3 6/8] selftests/tcp_ao: Fix printing format for
 uint64_t
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-tcp-ao-selftests-upd-6-12-v3-6-7bd2e22bb81c@gmail.com>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723757567; l=8808;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=YPEKLzEz54yx6GuwPZWnAYt7STgja9OwIZZWpccDw5M=;
 b=ElNHsCt4HVwbb8NzBNDDu0qU9dUO/XkO0yRzgdoFtCUjST86MtvOeUIBVE3xtTMEp918QFnEq
 ApBJPHuYtL3DWo9mI/uPeVOCgI/EsdomDiwmr4G1GWHGmVF49O01Yr7
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Mohammad Nassiri <mnassiri@ciena.com>

It's not safe to use '%zu' specifier for printing uint64_t on 32-bit
systems. For uint64_t, we should use the 'PRIu64' macro from
the inttypes.h library. This ensures that the uint64_t is printed
correctly from the selftests regardless of the system architecture.

Signed-off-by: Mohammad Nassiri <mnassiri@ciena.com>
[Added missing spaces in fail/ok messages and uint64_t cast in
 setsockopt-closed, as otherwise it was giving warnings on 64bit.
 And carried it to netdev ml]
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/connect-deny.c      |  4 ++--
 tools/testing/selftests/net/tcp_ao/connect.c           |  4 ++--
 tools/testing/selftests/net/tcp_ao/restore.c           |  8 ++++----
 tools/testing/selftests/net/tcp_ao/self-connect.c      |  4 ++--
 tools/testing/selftests/net/tcp_ao/seq-ext.c           | 12 ++++++------
 tools/testing/selftests/net/tcp_ao/setsockopt-closed.c |  4 ++--
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c      |  4 ++--
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
index 185a2f6e5ff3..5691f3d00603 100644
--- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -84,10 +84,10 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 	after_cnt = netstat_get_one(cnt_name, NULL);
 
 	if (after_cnt <= before_cnt) {
-		test_fail("%s: %s counter did not increase: %zu <= %zu",
+		test_fail("%s: %s counter did not increase: %" PRIu64 " <= %" PRIu64,
 				tst_name, cnt_name, after_cnt, before_cnt);
 	} else {
-		test_ok("%s: counter %s increased %zu => %zu",
+		test_ok("%s: counter %s increased %" PRIu64  " => %" PRIu64,
 			tst_name, cnt_name, before_cnt, after_cnt);
 	}
 
diff --git a/tools/testing/selftests/net/tcp_ao/connect.c b/tools/testing/selftests/net/tcp_ao/connect.c
index 81653b47f303..9eecc4a1072e 100644
--- a/tools/testing/selftests/net/tcp_ao/connect.c
+++ b/tools/testing/selftests/net/tcp_ao/connect.c
@@ -67,14 +67,14 @@ static void *client_fn(void *arg)
 	netstat_free(ns_after);
 
 	if (nr_packets > (after_aogood - before_aogood)) {
-		test_fail("TCPAOGood counter mismatch: %zu > (%zu - %zu)",
+		test_fail("TCPAOGood counter mismatch: %zu > (%" PRIu64 " - %" PRIu64 ")",
 				nr_packets, after_aogood, before_aogood);
 		return NULL;
 	}
 	if (test_tcp_ao_counters_cmp("connect", &ao1, &ao2, TEST_CNT_GOOD))
 		return NULL;
 
-	test_ok("connect TCPAOGood %" PRIu64 "/%" PRIu64 "/%" PRIu64 " => %" PRIu64 "/%" PRIu64 "/%" PRIu64 ", sent %" PRIu64,
+	test_ok("connect TCPAOGood %" PRIu64 "/%" PRIu64 "/%" PRIu64 " => %" PRIu64 "/%" PRIu64 "/%" PRIu64 ", sent %zu",
 			before_aogood, ao1.ao_info_pkt_good,
 			ao1.key_cnts[0].pkt_good,
 			after_aogood, ao2.ao_info_pkt_good,
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
index 8fdc808df325..7b91d7fde2bc 100644
--- a/tools/testing/selftests/net/tcp_ao/restore.c
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -71,10 +71,10 @@ static void try_server_run(const char *tst_name, unsigned int port,
 	test_tcp_ao_counters_cmp(tst_name, &ao1, &ao2, cnt_expected);
 
 	if (after_cnt <= before_cnt) {
-		test_fail("%s: %s counter did not increase: %zu <= %zu",
+		test_fail("%s: %s counter did not increase: %" PRIu64 " <= %" PRIu64,
 				tst_name, cnt_name, after_cnt, before_cnt);
 	} else {
-		test_ok("%s: counter %s increased %zu => %zu",
+		test_ok("%s: counter %s increased %" PRIu64 " => %" PRIu64,
 			tst_name, cnt_name, before_cnt, after_cnt);
 	}
 
@@ -183,10 +183,10 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 	test_tcp_ao_counters_cmp(tst_name, &ao1, &ao2, cnt_expected);
 
 	if (after_cnt <= before_cnt) {
-		test_fail("%s: %s counter did not increase: %zu <= %zu",
+		test_fail("%s: %s counter did not increase: %" PRIu64 " <= %" PRIu64,
 				tst_name, cnt_name, after_cnt, before_cnt);
 	} else {
-		test_ok("%s: counter %s increased %zu => %zu",
+		test_ok("%s: counter %s increased %" PRIu64 " => %" PRIu64,
 			tst_name, cnt_name, before_cnt, after_cnt);
 	}
 	synchronize_threads(); /* 3: verified => closed */
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index a5698b0a3718..e56931d38e06 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -87,7 +87,7 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 	netstat_free(ns_after);
 
 	if (after_aogood <= before_aogood) {
-		test_fail("%s: TCPAOGood counter mismatch: %zu <= %zu",
+		test_fail("%s: TCPAOGood counter mismatch: %" PRIu64 " <= %" PRIu64,
 			  tst, after_aogood, before_aogood);
 		close(sk);
 		return;
@@ -148,7 +148,7 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 	netstat_free(ns_after);
 	close(sk);
 	if (after_aogood <= before_aogood) {
-		test_fail("%s: TCPAOGood counter mismatch: %zu <= %zu",
+		test_fail("%s: TCPAOGood counter mismatch: %" PRIu64 " <= %" PRIu64,
 			  tst, after_aogood, before_aogood);
 		return;
 	}
diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
index ad4e77d6823e..9c7dde7fd776 100644
--- a/tools/testing/selftests/net/tcp_ao/seq-ext.c
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -134,15 +134,15 @@ static void *server_fn(void *arg)
 	test_tcp_ao_counters_cmp(NULL, &ao1, &ao2, TEST_CNT_GOOD);
 
 	if (after_good <= before_good) {
-		test_fail("TCPAOGood counter did not increase: %zu <= %zu",
+		test_fail("TCPAOGood counter did not increase: %" PRIu64 " <= %" PRIu64,
 			  after_good, before_good);
 	} else {
-		test_ok("TCPAOGood counter increased %zu => %zu",
+		test_ok("TCPAOGood counter increased %" PRIu64 " => %" PRIu64,
 			before_good, after_good);
 	}
 	after_bad = netstat_get_one("TCPAOBad", NULL);
 	if (after_bad)
-		test_fail("TCPAOBad counter is non-zero: %zu", after_bad);
+		test_fail("TCPAOBad counter is non-zero: %" PRIu64, after_bad);
 	else
 		test_ok("TCPAOBad counter didn't increase");
 	test_enable_repair(sk);
@@ -219,15 +219,15 @@ static void *client_fn(void *arg)
 	test_tcp_ao_counters_cmp(NULL, &ao1, &ao2, TEST_CNT_GOOD);
 
 	if (after_good <= before_good) {
-		test_fail("TCPAOGood counter did not increase: %zu <= %zu",
+		test_fail("TCPAOGood counter did not increase: %" PRIu64 " <= %" PRIu64,
 			  after_good, before_good);
 	} else {
-		test_ok("TCPAOGood counter increased %zu => %zu",
+		test_ok("TCPAOGood counter increased %" PRIu64 " => %" PRIu64,
 			before_good, after_good);
 	}
 	after_bad = netstat_get_one("TCPAOBad", NULL);
 	if (after_bad)
-		test_fail("TCPAOBad counter is non-zero: %zu", after_bad);
+		test_fail("TCPAOBad counter is non-zero: %" PRIu64, after_bad);
 	else
 		test_ok("TCPAOBad counter didn't increase");
 
diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
index 517930f9721b..5eee826c37aa 100644
--- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -30,8 +30,8 @@ static void test_vefify_ao_info(int sk, struct tcp_ao_info_opt *info,
 #define __cmp_ao(member)							\
 do {										\
 	if (info->member != tmp.member) {					\
-		test_fail("%s: getsockopt(): " __stringify(member) " %zu != %zu",	\
-			  tst, (size_t)info->member, (size_t)tmp.member);	\
+		test_fail("%s: getsockopt(): " __stringify(member) " %" PRIu64 " != %" PRIu64,	\
+			  tst, (uint64_t)info->member, (uint64_t)tmp.member);	\
 		return;								\
 	}									\
 } while(0)
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index 6b59a652159f..ec2848036341 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -100,10 +100,10 @@ static void try_accept(const char *tst_name, unsigned int port,
 	after_cnt = netstat_get_one(cnt_name, NULL);
 
 	if (after_cnt <= before_cnt) {
-		test_fail("%s: %s counter did not increase: %zu <= %zu",
+		test_fail("%s: %s counter did not increase: %" PRIu64 " <= %" PRIu64,
 				tst_name, cnt_name, after_cnt, before_cnt);
 	} else {
-		test_ok("%s: counter %s increased %zu => %zu",
+		test_ok("%s: counter %s increased %" PRIu64 " => %" PRIu64,
 			tst_name, cnt_name, before_cnt, after_cnt);
 	}
 	if (ao_addr)

-- 
2.42.2



