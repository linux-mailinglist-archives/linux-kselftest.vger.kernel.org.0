Return-Path: <linux-kselftest+bounces-3739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E0841ABC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 04:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF13B284E27
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE538F84;
	Tue, 30 Jan 2024 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DGnvXXRu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FB381C6
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586728; cv=none; b=ZM1TqP9dMnY85iJtc1k7Jj2rKX20ne+eep5uh2Aci5ksUg73COe2OSumtjwmmNPrhF9FeVXaRC8sVvVEu3GHzgxlFHd8ua5/h4Cviu12o4GwSvnMXSOo9ZxkjPzkIe5d3Qfm2DNZfZG2VkLAdULRIuyGPm8ato04fTcuQC6+wiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586728; c=relaxed/simple;
	bh=DuT4NF02kaC5BQypY3Hf8nScd/Iyn4+41SidW6J8xxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2DXBgla8duGYf0eqCj8qNUMlBLUHTKcskq6eKI7anXjsi4CZdQ1JPlJTmJrFWKSc078PfEA1nG/Y3OSGPZd4xrDfWp4Xl4oTxvw8T0Ha9mP2/PEk9E4FqXzYZYdv4Qvh1yB7G6UcsCPmUvfYnPgV/HJ0FyqBFS3tHH8s9pUTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=DGnvXXRu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33929364bdaso2440301f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 19:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706586724; x=1707191524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Gr9RawEoMTLBvWixWLQ9InE8ituKnBm/PO3iDLKMTs=;
        b=DGnvXXRuP7fHeGwlHfotvtB7NDR+lSt0QCfkiQoLqF5RVdEjJdv26339kCqSLbQu1C
         U4ZC/yL7jeEvEfFivqrxG5BE9r6rsQwr4QJ/tlGHXAX6lPZ93LKB0tIQt0bsCRhf1JA9
         JSaQA8zevL3rUMaour/Vft5Sc3UCcpJWexai1T+O0D8VRW+eo6deBOw/h3LxvC0KIGRA
         Z9ID25Xvlzu8vDwp0uTA40vOjBaGeR6tFDubIvEV0wP4EAMd810zlbhDi1VpOvWffO+6
         y0x93kJlUUjgVeaJAlV86Tz6yQ0DY3SxbqrIFE8EfGVD1pQSiU+CtRCG8uyeS+LhaPdb
         PPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706586724; x=1707191524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Gr9RawEoMTLBvWixWLQ9InE8ituKnBm/PO3iDLKMTs=;
        b=h0vGcQv3VpHiPcW5BHqF4DzwcIXgueep7CxtuTj4obTBpZRsfQ8bghJpKkMZfEOy7E
         i1ZGPz7th0e9ZjfIK8QWnLp+Wi9lIC5gWeey14Yj//PGEnYTEgWXpL40pvz8lUs8tWzr
         G37wxKBTp9TOQq68gg6RGOGWYUuxgMWW/JIZkB7NMjAzkONUNCzM9ch5drwtwYKZU3j3
         POYxiGrslc8NkrGuQlfn3PT5IUZ7rK8wKAktRpAFOkOjm+psEa86hIw4EwgcnBvVCACw
         orTw9FpoYX8aI9typnzuWfjNOiqC9DigOuAjDvgDm+FNzP88TeqwH26ktOTHRUORWG1r
         qRfQ==
X-Gm-Message-State: AOJu0Ywwy/R60JVGXcgfCmRw4F7XWri0EOaAIUoHebFEpPka8OSaWRef
	Gptn+EwHAwbDmZq4KaFq7mQgLSF+mYqMnBYrBTJEZ/j+aygWgjyqI4sUHN3Gqg==
X-Google-Smtp-Source: AGHT+IFyQ4LX2Vm/L7+rQkFA1LfPv+lk7PmRWfGl1yd8VKGXI87EoFvDwGgcnYP/KPnoH9kGWbiYcA==
X-Received: by 2002:a5d:6383:0:b0:33a:ed8c:1a6a with SMTP id p3-20020a5d6383000000b0033aed8c1a6amr3210242wru.64.1706586724106;
        Mon, 29 Jan 2024 19:52:04 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay13-20020a5d6f0d000000b00337d6aa3912sm9513207wrb.10.2024.01.29.19.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 19:52:03 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] selftests/net: Repair RST passive reset selftest
Date: Tue, 30 Jan 2024 03:51:54 +0000
Message-ID: <20240130-tcp-ao-test-key-mgmt-v2-3-d190430a6c60@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706586712; l=10409; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=DuT4NF02kaC5BQypY3Hf8nScd/Iyn4+41SidW6J8xxQ=; b=hVifgR7SD4AW3xgOjLDaRTI8uyXtdFHKystQvRiDYKg0wi1PLgz3Z0GbL21ICkratszmwTvRa Zp+6bx35hcFA7KVhrfFGvinbcdzCGuxxOKAOBIEy/o2UH2NILXl9eNo
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Currently, the test is racy and seems to not pass anymore.

In order to rectify it, aim on TCP_TW_RST.
Doesn't seem way too good with this sleep() part, but it seems as
a reasonable compromise for the test. There is a plan in-line comment on
how-to improve it, going to do it on the top, at this moment I want it
to run on netdev/patchwork selftests dashboard.

It also slightly changes tcp_ao-lib in order to get SO_ERROR propagated
to test_client_verify() return value.

Fixes: c6df7b2361d7 ("selftests/net: Add TCP-AO RST test")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/sock.c |  12 ++-
 tools/testing/selftests/net/tcp_ao/rst.c      | 138 +++++++++++++++++---------
 2 files changed, 98 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index c75d82885a2e..15aeb0963058 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -62,7 +62,9 @@ int test_wait_fd(int sk, time_t sec, bool write)
 		return -ETIMEDOUT;
 	}
 
-	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &ret, &slen) || ret)
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &ret, &slen))
+		return -errno;
+	if (ret)
 		return -ret;
 	return 0;
 }
@@ -584,9 +586,11 @@ int test_client_verify(int sk, const size_t msg_len, const size_t nr,
 {
 	size_t buf_sz = msg_len * nr;
 	char *buf = alloca(buf_sz);
+	ssize_t ret;
 
 	randomize_buffer(buf, buf_sz);
-	if (test_client_loop(sk, buf, buf_sz, msg_len, timeout_sec) != buf_sz)
-		return -1;
-	return 0;
+	ret = test_client_loop(sk, buf, buf_sz, msg_len, timeout_sec);
+	if (ret < 0)
+		return (int)ret;
+	return ret != buf_sz ? -1 : 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
index ac06009a7f5f..7df8b8700e39 100644
--- a/tools/testing/selftests/net/tcp_ao/rst.c
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -1,10 +1,33 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Author: Dmitry Safonov <dima@arista.com> */
+/*
+ * The test checks that both active and passive reset have correct TCP-AO
+ * signature. An "active" reset (abort) here is procured from closing
+ * listen() socket with non-accepted connections in the queue:
+ * inet_csk_listen_stop() => inet_child_forget() =>
+ *                        => tcp_disconnect() => tcp_send_active_reset()
+ *
+ * The passive reset is quite hard to get on established TCP connections.
+ * It could be procured from non-established states, but the synchronization
+ * part from userspace in order to reliably get RST seems uneasy.
+ * So, instead it's procured by corrupting SEQ number on TIMED-WAIT state.
+ *
+ * It's important to test both passive and active RST as they go through
+ * different code-paths:
+ * - tcp_send_active_reset() makes no-data skb, sends it with tcp_transmit_skb()
+ * - tcp_v*_send_reset() create their reply skbs and send them with
+ *   ip_send_unicast_reply()
+ *
+ * In both cases TCP-AO signatures have to be correct, which is verified by
+ * (1) checking that the TCP-AO connection was reset and (2) TCP-AO counters.
+ *
+ * Author: Dmitry Safonov <dima@arista.com>
+ */
 #include <inttypes.h>
 #include "../../../../include/linux/kernel.h"
 #include "aolib.h"
 
 const size_t quota = 1000;
+const size_t packet_sz = 100;
 /*
  * Backlog == 0 means 1 connection in queue, see:
  * commit 64a146513f8f ("[NET]: Revert incorrect accept queue...")
@@ -59,26 +82,6 @@ static void close_forced(int sk)
 	close(sk);
 }
 
-static int test_wait_for_exception(int sk, time_t sec)
-{
-	struct timeval tv = { .tv_sec = sec };
-	struct timeval *ptv = NULL;
-	fd_set efds;
-	int ret;
-
-	FD_ZERO(&efds);
-	FD_SET(sk, &efds);
-
-	if (sec)
-		ptv = &tv;
-
-	errno = 0;
-	ret = select(sk + 1, NULL, NULL, &efds, ptv);
-	if (ret < 0)
-		return -errno;
-	return ret ? sk : 0;
-}
-
 static void test_server_active_rst(unsigned int port)
 {
 	struct tcp_ao_counters cnt1, cnt2;
@@ -155,17 +158,16 @@ static void test_server_passive_rst(unsigned int port)
 			test_fail("server returned %zd", bytes);
 	}
 
-	synchronize_threads(); /* 3: chekpoint/restore the connection */
+	synchronize_threads(); /* 3: checkpoint the client */
+	synchronize_threads(); /* 4: close the server, creating twsk */
 	if (test_get_tcp_ao_counters(sk, &ao2))
 		test_error("test_get_tcp_ao_counters()");
-
-	synchronize_threads(); /* 4: terminate server + send more on client */
-	bytes = test_server_run(sk, quota, TEST_RETRANSMIT_SEC);
 	close(sk);
+
+	synchronize_threads(); /* 5: restore the socket, send more data */
 	test_tcp_ao_counters_cmp("passive RST server", &ao1, &ao2, TEST_CNT_GOOD);
 
-	synchronize_threads(); /* 5: verified => closed */
-	close(sk);
+	synchronize_threads(); /* 6: server exits */
 }
 
 static void *server_fn(void *arg)
@@ -284,7 +286,7 @@ static void test_client_active_rst(unsigned int port)
 		test_error("test_wait_fds(): %d", err);
 
 	synchronize_threads(); /* 3: close listen socket */
-	if (test_client_verify(sk[0], 100, quota / 100, TEST_TIMEOUT_SEC))
+	if (test_client_verify(sk[0], packet_sz, quota / packet_sz, TEST_TIMEOUT_SEC))
 		test_fail("Failed to send data on connected socket");
 	else
 		test_ok("Verified established tcp connection");
@@ -323,7 +325,6 @@ static void test_client_passive_rst(unsigned int port)
 	struct tcp_sock_state img;
 	sockaddr_af saddr;
 	int sk, err;
-	socklen_t slen = sizeof(err);
 
 	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
 	if (sk < 0)
@@ -337,18 +338,51 @@ static void test_client_passive_rst(unsigned int port)
 		test_error("failed to connect()");
 
 	synchronize_threads(); /* 2: accepted => send data */
-	if (test_client_verify(sk, 100, quota / 100, TEST_TIMEOUT_SEC))
+	if (test_client_verify(sk, packet_sz, quota / packet_sz, TEST_TIMEOUT_SEC))
 		test_fail("Failed to send data on connected socket");
 	else
 		test_ok("Verified established tcp connection");
 
-	synchronize_threads(); /* 3: chekpoint/restore the connection */
+	synchronize_threads(); /* 3: checkpoint the client */
 	test_enable_repair(sk);
 	test_sock_checkpoint(sk, &img, &saddr);
 	test_ao_checkpoint(sk, &ao_img);
-	test_kill_sk(sk);
+	test_disable_repair(sk);
 
-	img.out.seq += quota;
+	synchronize_threads(); /* 4: close the server, creating twsk */
+
+	/*
+	 * The "corruption" in SEQ has to be small enough to fit into TCP
+	 * window, see tcp_timewait_state_process() for out-of-window
+	 * segments.
+	 */
+	img.out.seq += 5; /* 5 is more noticeable in tcpdump than 1 */
+
+	/*
+	 * FIXME: This is kind-of ugly and dirty, but it works.
+	 *
+	 * At this moment, the server has close'ed(sk).
+	 * The passive RST that is being targeted here is new data after
+	 * half-duplex close, see tcp_timewait_state_process() => TCP_TW_RST
+	 *
+	 * What is needed here is:
+	 * (1) wait for FIN from the server
+	 * (2) make sure that the ACK from the client went out
+	 * (3) make sure that the ACK was received and processed by the server
+	 *
+	 * Otherwise, the data that will be sent from "repaired" socket
+	 * post SEQ corruption may get to the server before it's in
+	 * TCP_FIN_WAIT2.
+	 *
+	 * (1) is easy with select()/poll()
+	 * (2) is possible by polling tcpi_state from TCP_INFO
+	 * (3) is quite complex: as server's socket was already closed,
+	 *     probably the way to do it would be tcp-diag.
+	 */
+	sleep(TEST_RETRANSMIT_SEC);
+
+	synchronize_threads(); /* 5: restore the socket, send more data */
+	test_kill_sk(sk);
 
 	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
 	if (sk < 0)
@@ -366,25 +400,33 @@ static void test_client_passive_rst(unsigned int port)
 	test_disable_repair(sk);
 	test_sock_state_free(&img);
 
-	synchronize_threads(); /* 4: terminate server + send more on client */
-	if (test_client_verify(sk, 100, quota / 100, 2 * TEST_TIMEOUT_SEC))
-		test_ok("client connection broken post-seq-adjust");
+	/*
+	 * This is how "passive reset" is acquired in this test from TCP_TW_RST:
+	 *
+	 * IP 10.0.254.1.7011 > 10.0.1.1.59772: Flags [P.], seq 901:1001, ack 1001, win 249,
+	 *    options [tcp-ao keyid 100 rnextkeyid 100 mac 0x10217d6c36a22379086ef3b1], length 100
+	 * IP 10.0.254.1.7011 > 10.0.1.1.59772: Flags [F.], seq 1001, ack 1001, win 249,
+	 *    options [tcp-ao keyid 100 rnextkeyid 100 mac 0x104ffc99b98c10a5298cc268], length 0
+	 * IP 10.0.1.1.59772 > 10.0.254.1.7011: Flags [.], ack 1002, win 251,
+	 *    options [tcp-ao keyid 100 rnextkeyid 100 mac 0xe496dd4f7f5a8a66873c6f93,nop,nop,sack 1 {1001:1002}], length 0
+	 * IP 10.0.1.1.59772 > 10.0.254.1.7011: Flags [P.], seq 1006:1106, ack 1001, win 251,
+	 *    options [tcp-ao keyid 100 rnextkeyid 100 mac 0x1b5f3330fb23fbcd0c77d0ca], length 100
+	 * IP 10.0.254.1.7011 > 10.0.1.1.59772: Flags [R], seq 3215596252, win 0,
+	 *    options [tcp-ao keyid 100 rnextkeyid 100 mac 0x0bcfbbf497bce844312304b2], length 0
+	 */
+	err = test_client_verify(sk, packet_sz, quota / packet_sz, 2 * TEST_TIMEOUT_SEC);
+	/* Make sure that the connection was reset, not timeouted */
+	if (err && err == -ECONNRESET)
+		test_ok("client sock was passively reset post-seq-adjust");
+	else if (err)
+		test_fail("client sock was not reset post-seq-adjust: %d", err);
 	else
-		test_fail("client connection still works post-seq-adjust");
-
-	test_wait_for_exception(sk, TEST_TIMEOUT_SEC);
-
-	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &err, &slen))
-		test_error("getsockopt()");
-	if (err != ECONNRESET && err != EPIPE)
-		test_fail("client connection was not reset: %d", err);
-	else
-		test_ok("client connection was reset");
+		test_fail("client sock is yet connected post-seq-adjust");
 
 	if (test_get_tcp_ao_counters(sk, &ao2))
 		test_error("test_get_tcp_ao_counters()");
 
-	synchronize_threads(); /* 5: verified => closed */
+	synchronize_threads(); /* 6: server exits */
 	close(sk);
 	test_tcp_ao_counters_cmp("client passive RST", &ao1, &ao2, TEST_CNT_GOOD);
 }
@@ -410,6 +452,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(15, server_fn, client_fn);
+	test_init(14, server_fn, client_fn);
 	return 0;
 }

-- 
2.43.0


