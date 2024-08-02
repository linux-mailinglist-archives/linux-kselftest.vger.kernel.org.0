Return-Path: <linux-kselftest+bounces-14702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B60945AE4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 11:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94221F21F11
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C51DB43A;
	Fri,  2 Aug 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqUvDWW9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390A1DB420;
	Fri,  2 Aug 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590619; cv=none; b=JTxcy03zZrqVf08VfkiUKw9tLLSNqnuNiVnHQmKWyGRM2j1BM6zeZ0LCrYzB01mIoX1d3uOH+Zwqhlw2Lnb3P3zV3ORlTLafrhAAqT4o7RD72CUKejsZASiT0M3Vhedwgb/HcLohLWs54xVWrkoajbsL6HGJhPqD7kPrjgOpicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590619; c=relaxed/simple;
	bh=qaIxzhJ+auD33h9udz/QNyEoZ851JZn2dE3kSu2mnnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrXcmb4KshSpPjw7rLJZ39iLleshpRXe/IrUgK4qMGc80mQ+xfENSL9d9wl50iFBlQDfED2eFuIvdOYhUoxqRsluujG4u19bUtThr4oZyurhztm2cYKc5gIiPxMDoI5Tn/WlBlCarCYeML/XHPBUchvDaYxw5huva077dtC4ew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqUvDWW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02831C4AF14;
	Fri,  2 Aug 2024 09:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722590619;
	bh=qaIxzhJ+auD33h9udz/QNyEoZ851JZn2dE3kSu2mnnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PqUvDWW9DGcK3QCgSYRuBONR0dWEI5V7h0uqIjmFrsdRnUfm/RlGIFJ4+gbP8HHsl
	 9cDB9km7s+PS3VV+zy17Q1uEae3jtIomdMtKnkckmCLFWhhtJCpI48KKylJZ1Ci6jr
	 92D8CEK+UIHbWidbqI3OtzyJjJ97+bc5HNyxp5MvlTPPGMic4Ldt4r5JvWtrDise92
	 7d4QBkpLmvcyEi71jVjbXx+0sLGjPd25o0dazt7dUocMqtTqNTJgVSySJM9lY00aS6
	 PTHTNcmjc/A3hKPOVgW09TungvlVdAcNXm70bM8juydOtT7tG0vNRtYSGmBK5XzVD6
	 xP0CSsZ+LsiJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2B7C52D54;
	Fri,  2 Aug 2024 09:23:38 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 02 Aug 2024 10:23:29 +0100
Subject: [PATCH net-next v2 5/7] selftests/tcp_ao: Fix printing format for
 uint64_t
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-tcp-ao-selftests-upd-6-12-v2-5-370c99358161@gmail.com>
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
In-Reply-To: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722590616; l=8808;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=YPEKLzEz54yx6GuwPZWnAYt7STgja9OwIZZWpccDw5M=;
 b=gvC1WsI36wPLQJzQc5sbe5wuLW6X72Bv39pctdk5tENnVsHTT4WtQZpdMO6zt+OG7rdL+osIp
 bt61wIrDkjsD5xtd5zWnbosGPT7QALDbNcmd1Xt7FUG7LrQVsFcazfd
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



