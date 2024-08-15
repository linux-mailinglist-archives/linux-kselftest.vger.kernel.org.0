Return-Path: <linux-kselftest+bounces-15460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E3953CAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D0F1C24104
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76377154BE9;
	Thu, 15 Aug 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1nw0ja4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946C1547D2;
	Thu, 15 Aug 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757570; cv=none; b=O9Hn+r6N5QJa5IAe8RR10ct/mMHydvTyfdjq/WU1+i/AwcWlZr6uTCF9EbQdndsuXUz4GY0Z70PQ46zx8sIWSRQf9Got9nAuPsOK5mt/okZWBcIqhRVNDoRyY3BErAteouo2c4GRuhduJPPLYokRZHMOdvm8Mzh0RFP5/0iwdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757570; c=relaxed/simple;
	bh=cXcR0zvXW7/nnmOm/6+n3P/mk7iJt/w5bvYw8TBix4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJIQtnyQb4ZpW4OBy/SKrX642o7n8rdx0jV7IoYtqtakadIHPU2rXeBdoDQ5uroBF7KtQwoN7O++cE+8GwqwNIwXc/EvWSrIgXL+KHn7ld7oRacCPNJDDuz+xXLrsb8lXXMFjRnjSD97wM7QBeh1ktnK7beISqq0O4dl16UBw2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1nw0ja4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB233C4AF1C;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723757569;
	bh=cXcR0zvXW7/nnmOm/6+n3P/mk7iJt/w5bvYw8TBix4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X1nw0ja4++gIYkoK7JKbIKzvoGXbxrB/rW7jnF4vab5jCbZu3lr5u+3XMqBBDREPE
	 uOY7NcgfBss3rK+nFuErMFX/Ur1WHKQV5jSH8k6vb/SI+mJDj7MgJLfTbV0FfgTowb
	 YJiHG+u8BQf6Mc9yY9XPXx5ChzS8jZLZLIMdBFiCVjfJmBpvBTxe0qxjGq7FQNL7Fe
	 acPtSP39lvuWcs+GhZGR7j1aETVuA4Kt57VNVYnY13ibjxjsKou3XdxwddJSObqKiC
	 jVBQOkIDmAz36i+l2i6SfzaHYa2r8Ma4xcngBwFAPNeCiJL1COqh1lg1muo4gTgVbs
	 rHtel4r4VULIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF33C531DE;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 15 Aug 2024 22:32:32 +0100
Subject: [PATCH net-next v3 7/8] selftests/net: Synchronize client/server
 before counters checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-tcp-ao-selftests-upd-6-12-v3-7-7bd2e22bb81c@gmail.com>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723757567; l=7675;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=ankNPOlIRhBq+DJVzPHQSd6nakZUp4Z55CCoLLWqbTY=;
 b=LhRYrvlCvonKDFRVVisih+fNW8SCIQQxMnTLuFc5rUHjD1j7t+v1qT17clsc18Lse3LBRuutV
 gDFP5OtqxvnAfhVmG1ZSyD1X6bhZxpkhQTTvkpOg+nmPq8Gux/KDyfb
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

On tests that are expecting failure the timeout value is
TEST_RETRANSMIT_SEC == 1 second. Which is big enough for most of devices
under tests. But on a particularly slow machine/VM, 1 second might be
not enough for another thread to be scheduled and attempt to connect().
It is not a problem for tests that expect connect() to succeed as
the timeout value for them (TEST_TIMEOUT_SEC) is intentionally bigger.

One obvious way to solve this would be to increase TEST_RETRANSMIT_SEC.
But as all tests would increase the timeouts, that's going to sum up.

But here is less obvious way that keeps timeouts for expected connect()
failures low: just synchronize the two threads, which will assure that
before counter checks the other thread got a chance to run and timeout
on connect(). The expected increase of the related counter for listen()
socket will yet test the expected failure.

Never happens on my machine, but I suppose the majority of netdev's
connect-deny-* flakes [1] are caused by this.

Fixes:
> # selftests: net/tcp_ao: connect-deny_ipv6
> # 1..21
> # # 462[lib/setup.c:243] rand seed 1720905426
> # TAP version 13
> # ok 1 Non-AO server + AO client
> # not ok 2 Non-AO server + AO client: TCPAOKeyNotFound counter did not increase: 0 <= 0
> # ok 3 AO server + Non-AO client
> # ok 4 AO server + Non-AO client: counter TCPAORequired increased 0 => 1
...

[1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao/results/681741/6-connect-deny-ipv6/stdout
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/connect-deny.c | 3 +++
 tools/testing/selftests/net/tcp_ao/restore.c      | 6 ++++--
 tools/testing/selftests/net/tcp_ao/seq-ext.c      | 6 ++++--
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c | 3 +++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
index 5691f3d00603..166ad4549ef2 100644
--- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -71,10 +71,12 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
 		}
 	}
 
+	synchronize_threads(); /* before counter checks */
 	if (pwd && test_get_tcp_ao_counters(lsk, &ao_cnt2))
 		test_error("test_get_tcp_ao_counters()");
 
 	close(lsk);
+
 	if (pwd)
 		test_tcp_ao_counters_cmp(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
 
@@ -180,6 +182,7 @@ static void try_connect(const char *tst_name, unsigned int port,
 	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
 	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
 
+	synchronize_threads(); /* before counter checks */
 	if (ret < 0) {
 		if (fault(KEYREJECT) && ret == -EKEYREJECTED) {
 			test_ok("%s: connect() was prevented", tst_name);
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
index 7b91d7fde2bc..f6ea2190f43d 100644
--- a/tools/testing/selftests/net/tcp_ao/restore.c
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -64,6 +64,7 @@ static void try_server_run(const char *tst_name, unsigned int port,
 		else
 			test_ok("%s: server alive", tst_name);
 	}
+	synchronize_threads(); /* 3: counters checks */
 	if (test_get_tcp_ao_counters(sk, &ao2))
 		test_error("test_get_tcp_ao_counters()");
 	after_cnt = netstat_get_one(cnt_name, NULL);
@@ -82,7 +83,7 @@ static void try_server_run(const char *tst_name, unsigned int port,
 	 * Before close() as that will send FIN and move the peer in TCP_CLOSE
 	 * and that will prevent reading AO counters from the peer's socket.
 	 */
-	synchronize_threads(); /* 3: verified => closed */
+	synchronize_threads(); /* 4: verified => closed */
 out:
 	close(sk);
 }
@@ -176,6 +177,7 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 		else
 			test_ok("%s: post-migrate connection is alive", tst_name);
 	}
+	synchronize_threads(); /* 3: counters checks */
 	if (test_get_tcp_ao_counters(sk, &ao2))
 		test_error("test_get_tcp_ao_counters()");
 	after_cnt = netstat_get_one(cnt_name, NULL);
@@ -189,7 +191,7 @@ static void test_sk_restore(const char *tst_name, unsigned int server_port,
 		test_ok("%s: counter %s increased %" PRIu64 " => %" PRIu64,
 			tst_name, cnt_name, before_cnt, after_cnt);
 	}
-	synchronize_threads(); /* 3: verified => closed */
+	synchronize_threads(); /* 4: verified => closed */
 	close(sk);
 }
 
diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
index 9c7dde7fd776..885866cc193c 100644
--- a/tools/testing/selftests/net/tcp_ao/seq-ext.c
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -116,7 +116,7 @@ static void *server_fn(void *arg)
 	sk = test_sk_restore(&img, &ao_img, &saddr, this_ip_dest,
 			     client_new_port, &ao1);
 
-	synchronize_threads(); /* 5: verify counters during SEQ-number rollover */
+	synchronize_threads(); /* 5: verify the connection during SEQ-number rollover */
 	bytes = test_server_run(sk, quota, TEST_TIMEOUT_SEC);
 	if (bytes != quota) {
 		if (bytes > 0)
@@ -127,6 +127,7 @@ static void *server_fn(void *arg)
 		test_ok("server alive");
 	}
 
+	synchronize_threads(); /* 6: verify counters after SEQ-number rollover */
 	if (test_get_tcp_ao_counters(sk, &ao2))
 		test_error("test_get_tcp_ao_counters()");
 	after_good = netstat_get_one("TCPAOGood", NULL);
@@ -206,12 +207,13 @@ static void *client_fn(void *arg)
 	sk = test_sk_restore(&img, &ao_img, &saddr, this_ip_dest,
 			     test_server_port + 1, &ao1);
 
-	synchronize_threads(); /* 5: verify counters during SEQ-number rollover */
+	synchronize_threads(); /* 5: verify the connection during SEQ-number rollover */
 	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
 		test_fail("post-migrate verify failed");
 	else
 		test_ok("post-migrate connection alive");
 
+	synchronize_threads(); /* 5: verify counters after SEQ-number rollover */
 	if (test_get_tcp_ao_counters(sk, &ao2))
 		test_error("test_get_tcp_ao_counters()");
 	after_good = netstat_get_one("TCPAOGood", NULL);
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index ec2848036341..02346b58efbd 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -70,6 +70,7 @@ static void try_accept(const char *tst_name, unsigned int port,
 
 	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
 	err = test_wait_fd(lsk, timeout, 0);
+	synchronize_threads(); /* connect()/accept() timeouts */
 	if (err == -ETIMEDOUT) {
 		if (!fault(TIMEOUT))
 			test_fail("timed out for accept()");
@@ -283,6 +284,7 @@ static void try_connect(const char *tst_name, unsigned int port,
 	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
 	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
 
+	synchronize_threads(); /* connect()/accept() timeouts */
 	if (ret < 0) {
 		if (fault(KEYREJECT) && ret == -EKEYREJECTED)
 			test_ok("%s: connect() was prevented", tst_name);
@@ -451,6 +453,7 @@ static void try_to_add(const char *tst_name, unsigned int port,
 	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
 	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
 
+	synchronize_threads(); /* connect()/accept() timeouts */
 	if (ret <= 0) {
 		test_error("%s: connect() returned %d", tst_name, ret);
 		goto out;

-- 
2.42.2



