Return-Path: <linux-kselftest+bounces-1990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFB814006
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB93B21DBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75C11196;
	Fri, 15 Dec 2023 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FZl/+qBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2C134CD
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so2051425e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607857; x=1703212657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hio2weC8azPqk3OZigdG2eecdJHHwMIYBB19zU/Gvn0=;
        b=FZl/+qBhjteVDnK2z7E3k0B4JFnUTDQxpS4EwutNUvz3U7x99McC5SaMa8utun7bui
         GyZx5WN0s1dLL3fT726bBvZSRFFHF+aIQs0qO++d/xC629+n9v3DJUBoFabbcVwKxg8M
         VXuDwHJF7vvgewrJ3Q+j7fF+X5+Zeuhi1XWRHyz9q79avZ2Ncsslgjf6l7ymKF6BLLi7
         Ow99Szx/RqmzzpAGiepHkiMkii75U9CJuS/SoAeS4bRxHZoDgJa5jN7nbFry/r4uH+iB
         Xl3/Ebiqv2BP4NqErT6EX2yGlbf65q6a7RyLFXdx8KAFnS0mccg8nqcYqRxYM+0VAoon
         Z/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607857; x=1703212657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hio2weC8azPqk3OZigdG2eecdJHHwMIYBB19zU/Gvn0=;
        b=GpqjtmADIOLg4dLnjmYXiWa9Hj8zSiDXZq8JXRukzXLOfawUL2DDF8Kpxj66ttr8kh
         yGQDFO7dZl452WaHdX/18fuOKrClT8oZMCIHf1zkkmGRegOpYdMMgz745vt7YYCnxezu
         QzfNlorfmgduYnsWIMMAhAqI3fou2Lc04gaGK9LlFs7O/p26vAcLuh+FE07HTeH5njbp
         JxUzCVooXO+NyIevOeQtmrGGxpq9To7iyHlf4tO/ED9O7+Q4yezFYO1WCAMRsJEMfYbr
         R0vn2PPcJ9and9vnCIRRB+mUv00lbc2PI1FZTOxCU4OGCT5cCKcsOkdQc2KgxuIQyBHb
         D5fA==
X-Gm-Message-State: AOJu0YzHG7RLI2nrhKAAYDs2AM2fdfjgtole4Leut79A6qNE8Dbnj/Oo
	zY9kJhtVOMjYuKuyJRqVB6LVyQ==
X-Google-Smtp-Source: AGHT+IHeZEhv8GPxbGsZJX1zWqTRDFcMTO80Mz0Z2FuCJz6cscBpfZK0gNStHYy+FqCfQjH2JvXtBw==
X-Received: by 2002:a7b:c857:0:b0:40b:5e21:ec22 with SMTP id c23-20020a7bc857000000b0040b5e21ec22mr5471168wml.84.1702607857229;
        Thu, 14 Dec 2023 18:37:37 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:36 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH 10/12] selftests/net: Add TCP-AO RST test
Date: Fri, 15 Dec 2023 02:36:24 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-10-f6c08180b985@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607833; l=15162; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=NMxxoFQcGlH9CnVDSafyvguFJCNDpo5gkrEyLMhH3F8=; b=7GZIxk3k4pMSQopQZu7oQP06WU/X/oByYdA9/GJXpk61J3Xjt0D0bW2OLmIdOiLjZ5ZihO4UX 6MkOnTjdyJgBTW9F6vqea2HgdAvf6cQgBsO9y9VTVWXUjnpPPlUgeEz
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Check that both active and passive reset works and correctly sign
segments with TCP-AO or don't send RSTs if not possible to sign.
A listening socket with backlog = 0 gets one connection in accept
queue, another in syn queue. Once the server/listener socket is
forcibly closed, client sockets aren't connected to anything.
In regular situation they would receive RST on any segment, but
with TCP-AO as there's no listener, no AO-key and unknown ISNs,
no RST should be sent.

And "passive" reset, where RST is sent on reply for some segment
(tcp_v{4,6}_send_reset()) - there use TCP_REPAIR to corrupt SEQ numbers,
which later results in TCP-AO signed RST, which will be verified and
client socket will get EPIPE.

No TCPAORequired/TCPAOBad segments are expected during these tests.

Sample of the output:
> # ./rst_ipv4
> 1..15
> # 1462[lib/setup.c:254] rand seed 1686611171
> TAP version 13
> ok 1 servered 1000 bytes
> ok 2 Verified established tcp connection
> ok 3 sk[0] = 7, connection was reset
> ok 4 sk[1] = 8, connection was reset
> ok 5 sk[2] = 9
> ok 6 MKT counters are good on server
> ok 7 Verified established tcp connection
> ok 8 client connection broken post-seq-adjust
> ok 9 client connection was reset
> ok 10 No segments without AO sign (server)
> ok 11 Signed AO segments (server): 0 => 30
> ok 12 No segments with bad AO sign (server)
> ok 13 No segments without AO sign (client)
> ok 14 Signed AO segments (client): 0 => 30
> ok 15 No segments with bad AO sign (client)
> # Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile   |   1 +
 tools/testing/selftests/net/tcp_ao/lib/sock.c |   2 +-
 tools/testing/selftests/net/tcp_ao/rst.c      | 415 ++++++++++++++++++++++++++
 3 files changed, 417 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 5408c7233460..1d4f7576d774 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -4,6 +4,7 @@ TEST_BOTH_AF += connect
 TEST_BOTH_AF += connect-deny
 TEST_BOTH_AF += icmps-accept icmps-discard
 TEST_BOTH_AF += restore
+TEST_BOTH_AF += rst
 TEST_BOTH_AF += seq-ext
 TEST_BOTH_AF += setsockopt-closed
 TEST_BOTH_AF += unsigned-md5
diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 7f3c31b7d997..c75d82885a2e 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -566,7 +566,7 @@ ssize_t test_client_loop(int sk, char *buf, size_t buf_sz,
 
 			got = recv(sk, msg + bytes, sizeof(msg) - bytes, 0);
 			if (got <= 0)
-				test_error("recv(): %zd", got);
+				return i;
 			bytes += got;
 		} while (bytes < sent);
 		if (bytes > sent)
diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
new file mode 100644
index 000000000000..ac06009a7f5f
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+#include <inttypes.h>
+#include "../../../../include/linux/kernel.h"
+#include "aolib.h"
+
+const size_t quota = 1000;
+/*
+ * Backlog == 0 means 1 connection in queue, see:
+ * commit 64a146513f8f ("[NET]: Revert incorrect accept queue...")
+ */
+const unsigned int backlog;
+
+static void netstats_check(struct netstat *before, struct netstat *after,
+			   char *msg)
+{
+	uint64_t before_cnt, after_cnt;
+
+	before_cnt = netstat_get(before, "TCPAORequired", NULL);
+	after_cnt = netstat_get(after, "TCPAORequired", NULL);
+	if (after_cnt > before_cnt)
+		test_fail("Segments without AO sign (%s): %" PRIu64 " => %" PRIu64,
+			  msg, before_cnt, after_cnt);
+	else
+		test_ok("No segments without AO sign (%s)", msg);
+
+	before_cnt = netstat_get(before, "TCPAOGood", NULL);
+	after_cnt = netstat_get(after, "TCPAOGood", NULL);
+	if (after_cnt <= before_cnt)
+		test_fail("Signed AO segments (%s): %" PRIu64 " => %" PRIu64,
+			  msg, before_cnt, after_cnt);
+	else
+		test_ok("Signed AO segments (%s): %" PRIu64 " => %" PRIu64,
+			  msg, before_cnt, after_cnt);
+
+	before_cnt = netstat_get(before, "TCPAOBad", NULL);
+	after_cnt = netstat_get(after, "TCPAOBad", NULL);
+	if (after_cnt > before_cnt)
+		test_fail("Segments with bad AO sign (%s): %" PRIu64 " => %" PRIu64,
+			  msg, before_cnt, after_cnt);
+	else
+		test_ok("No segments with bad AO sign (%s)", msg);
+}
+
+/*
+ * Another way to send RST, but not through tcp_v{4,6}_send_reset()
+ * is tcp_send_active_reset(), that is not in reply to inbound segment,
+ * but rather active send. It uses tcp_transmit_skb(), so that should
+ * work, but as it also sends RST - nice that it can be covered as well.
+ */
+static void close_forced(int sk)
+{
+	struct linger sl;
+
+	sl.l_onoff = 1;
+	sl.l_linger = 0;
+	if (setsockopt(sk, SOL_SOCKET, SO_LINGER, &sl, sizeof(sl)))
+		test_error("setsockopt(SO_LINGER)");
+	close(sk);
+}
+
+static int test_wait_for_exception(int sk, time_t sec)
+{
+	struct timeval tv = { .tv_sec = sec };
+	struct timeval *ptv = NULL;
+	fd_set efds;
+	int ret;
+
+	FD_ZERO(&efds);
+	FD_SET(sk, &efds);
+
+	if (sec)
+		ptv = &tv;
+
+	errno = 0;
+	ret = select(sk + 1, NULL, NULL, &efds, ptv);
+	if (ret < 0)
+		return -errno;
+	return ret ? sk : 0;
+}
+
+static void test_server_active_rst(unsigned int port)
+{
+	struct tcp_ao_counters cnt1, cnt2;
+	ssize_t bytes;
+	int sk, lsk;
+
+	lsk = test_listen_socket(this_ip_addr, port, backlog);
+	if (test_add_key(lsk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+	if (test_get_tcp_ao_counters(lsk, &cnt1))
+		test_error("test_get_tcp_ao_counters()");
+
+	synchronize_threads(); /* 1: MKT added */
+	if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
+		test_error("test_wait_fd()");
+
+	sk = accept(lsk, NULL, NULL);
+	if (sk < 0)
+		test_error("accept()");
+
+	synchronize_threads(); /* 2: connection accept()ed, another queued */
+	if (test_get_tcp_ao_counters(lsk, &cnt2))
+		test_error("test_get_tcp_ao_counters()");
+
+	synchronize_threads(); /* 3: close listen socket */
+	close(lsk);
+	bytes = test_server_run(sk, quota, 0);
+	if (bytes != quota)
+		test_error("servered only %zd bytes", bytes);
+	else
+		test_ok("servered %zd bytes", bytes);
+
+	synchronize_threads(); /* 4: finishing up */
+	close_forced(sk);
+
+	synchronize_threads(); /* 5: closed active sk */
+
+	synchronize_threads(); /* 6: counters checks */
+	if (test_tcp_ao_counters_cmp("active RST server", &cnt1, &cnt2, TEST_CNT_GOOD))
+		test_fail("MKT counters (server) have not only good packets");
+	else
+		test_ok("MKT counters are good on server");
+}
+
+static void test_server_passive_rst(unsigned int port)
+{
+	struct tcp_ao_counters ao1, ao2;
+	int sk, lsk;
+	ssize_t bytes;
+
+	lsk = test_listen_socket(this_ip_addr, port, 1);
+
+	if (test_add_key(lsk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	synchronize_threads(); /* 1: MKT added => connect() */
+	if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
+		test_error("test_wait_fd()");
+
+	sk = accept(lsk, NULL, NULL);
+	if (sk < 0)
+		test_error("accept()");
+
+	synchronize_threads(); /* 2: accepted => send data */
+	close(lsk);
+	if (test_get_tcp_ao_counters(sk, &ao1))
+		test_error("test_get_tcp_ao_counters()");
+
+	bytes = test_server_run(sk, quota, TEST_TIMEOUT_SEC);
+	if (bytes != quota) {
+		if (bytes > 0)
+			test_fail("server served: %zd", bytes);
+		else
+			test_fail("server returned %zd", bytes);
+	}
+
+	synchronize_threads(); /* 3: chekpoint/restore the connection */
+	if (test_get_tcp_ao_counters(sk, &ao2))
+		test_error("test_get_tcp_ao_counters()");
+
+	synchronize_threads(); /* 4: terminate server + send more on client */
+	bytes = test_server_run(sk, quota, TEST_RETRANSMIT_SEC);
+	close(sk);
+	test_tcp_ao_counters_cmp("passive RST server", &ao1, &ao2, TEST_CNT_GOOD);
+
+	synchronize_threads(); /* 5: verified => closed */
+	close(sk);
+}
+
+static void *server_fn(void *arg)
+{
+	struct netstat *ns_before, *ns_after;
+	unsigned int port = test_server_port;
+
+	ns_before = netstat_read();
+
+	test_server_active_rst(port++);
+	test_server_passive_rst(port++);
+
+	ns_after = netstat_read();
+	netstats_check(ns_before, ns_after, "server");
+	netstat_free(ns_after);
+	netstat_free(ns_before);
+	synchronize_threads(); /* exit */
+
+	synchronize_threads(); /* don't race to exit() - client exits */
+	return NULL;
+}
+
+static int test_wait_fds(int sk[], size_t nr, bool is_writable[],
+			 ssize_t wait_for, time_t sec)
+{
+	struct timeval tv = { .tv_sec = sec };
+	struct timeval *ptv = NULL;
+	fd_set left;
+	size_t i;
+	int ret;
+
+	FD_ZERO(&left);
+	for (i = 0; i < nr; i++) {
+		FD_SET(sk[i], &left);
+		if (is_writable)
+			is_writable[i] = false;
+	}
+
+	if (sec)
+		ptv = &tv;
+
+	do {
+		bool is_empty = true;
+		fd_set fds, efds;
+		int nfd = 0;
+
+		FD_ZERO(&fds);
+		FD_ZERO(&efds);
+		for (i = 0; i < nr; i++) {
+			if (!FD_ISSET(sk[i], &left))
+				continue;
+
+			if (sk[i] > nfd)
+				nfd = sk[i];
+
+			FD_SET(sk[i], &fds);
+			FD_SET(sk[i], &efds);
+			is_empty = false;
+		}
+		if (is_empty)
+			return -ENOENT;
+
+		errno = 0;
+		ret = select(nfd + 1, NULL, &fds, &efds, ptv);
+		if (ret < 0)
+			return -errno;
+		if (!ret)
+			return -ETIMEDOUT;
+		for (i = 0; i < nr; i++) {
+			if (FD_ISSET(sk[i], &fds)) {
+				if (is_writable)
+					is_writable[i] = true;
+				FD_CLR(sk[i], &left);
+				wait_for--;
+				continue;
+			}
+			if (FD_ISSET(sk[i], &efds)) {
+				FD_CLR(sk[i], &left);
+				wait_for--;
+			}
+		}
+	} while (wait_for > 0);
+
+	return 0;
+}
+
+static void test_client_active_rst(unsigned int port)
+{
+	/* one in queue, another accept()ed */
+	unsigned int wait_for = backlog + 2;
+	int i, sk[3], err;
+	bool is_writable[ARRAY_SIZE(sk)] = {false};
+	unsigned int last = ARRAY_SIZE(sk) - 1;
+
+	for (i = 0; i < ARRAY_SIZE(sk); i++) {
+		sk[i] = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+		if (sk[i] < 0)
+			test_error("socket()");
+		if (test_add_key(sk[i], DEFAULT_TEST_PASSWORD,
+				 this_ip_dest, -1, 100, 100))
+			test_error("setsockopt(TCP_AO_ADD_KEY)");
+	}
+
+	synchronize_threads(); /* 1: MKT added */
+	for (i = 0; i < last; i++) {
+		err = _test_connect_socket(sk[i], this_ip_dest, port,
+					       (i == 0) ? TEST_TIMEOUT_SEC : -1);
+
+		if (err < 0)
+			test_error("failed to connect()");
+	}
+
+	synchronize_threads(); /* 2: connection accept()ed, another queued */
+	err = test_wait_fds(sk, last, is_writable, wait_for, TEST_TIMEOUT_SEC);
+	if (err < 0)
+		test_error("test_wait_fds(): %d", err);
+
+	synchronize_threads(); /* 3: close listen socket */
+	if (test_client_verify(sk[0], 100, quota / 100, TEST_TIMEOUT_SEC))
+		test_fail("Failed to send data on connected socket");
+	else
+		test_ok("Verified established tcp connection");
+
+	synchronize_threads(); /* 4: finishing up */
+	err = _test_connect_socket(sk[last], this_ip_dest, port, -1);
+	if (err < 0)
+		test_error("failed to connect()");
+
+	synchronize_threads(); /* 5: closed active sk */
+	err = test_wait_fds(sk, ARRAY_SIZE(sk), NULL,
+			    wait_for, TEST_TIMEOUT_SEC);
+	if (err < 0)
+		test_error("select(): %d", err);
+
+	for (i = 0; i < ARRAY_SIZE(sk); i++) {
+		socklen_t slen = sizeof(err);
+
+		if (getsockopt(sk[i], SOL_SOCKET, SO_ERROR, &err, &slen))
+			test_error("getsockopt()");
+		if (is_writable[i] && err != ECONNRESET) {
+			test_fail("sk[%d] = %d, err = %d, connection wasn't reset",
+				  i, sk[i], err);
+		} else {
+			test_ok("sk[%d] = %d%s", i, sk[i],
+				is_writable[i] ? ", connection was reset" : "");
+		}
+	}
+	synchronize_threads(); /* 6: counters checks */
+}
+
+static void test_client_passive_rst(unsigned int port)
+{
+	struct tcp_ao_counters ao1, ao2;
+	struct tcp_ao_repair ao_img;
+	struct tcp_sock_state img;
+	sockaddr_af saddr;
+	int sk, err;
+	socklen_t slen = sizeof(err);
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	synchronize_threads(); /* 1: MKT added => connect() */
+	if (test_connect_socket(sk, this_ip_dest, port) <= 0)
+		test_error("failed to connect()");
+
+	synchronize_threads(); /* 2: accepted => send data */
+	if (test_client_verify(sk, 100, quota / 100, TEST_TIMEOUT_SEC))
+		test_fail("Failed to send data on connected socket");
+	else
+		test_ok("Verified established tcp connection");
+
+	synchronize_threads(); /* 3: chekpoint/restore the connection */
+	test_enable_repair(sk);
+	test_sock_checkpoint(sk, &img, &saddr);
+	test_ao_checkpoint(sk, &ao_img);
+	test_kill_sk(sk);
+
+	img.out.seq += quota;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	test_enable_repair(sk);
+	test_sock_restore(sk, &img, &saddr, this_ip_dest, port);
+	if (test_add_repaired_key(sk, DEFAULT_TEST_PASSWORD, 0, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+	test_ao_restore(sk, &ao_img);
+
+	if (test_get_tcp_ao_counters(sk, &ao1))
+		test_error("test_get_tcp_ao_counters()");
+
+	test_disable_repair(sk);
+	test_sock_state_free(&img);
+
+	synchronize_threads(); /* 4: terminate server + send more on client */
+	if (test_client_verify(sk, 100, quota / 100, 2 * TEST_TIMEOUT_SEC))
+		test_ok("client connection broken post-seq-adjust");
+	else
+		test_fail("client connection still works post-seq-adjust");
+
+	test_wait_for_exception(sk, TEST_TIMEOUT_SEC);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &err, &slen))
+		test_error("getsockopt()");
+	if (err != ECONNRESET && err != EPIPE)
+		test_fail("client connection was not reset: %d", err);
+	else
+		test_ok("client connection was reset");
+
+	if (test_get_tcp_ao_counters(sk, &ao2))
+		test_error("test_get_tcp_ao_counters()");
+
+	synchronize_threads(); /* 5: verified => closed */
+	close(sk);
+	test_tcp_ao_counters_cmp("client passive RST", &ao1, &ao2, TEST_CNT_GOOD);
+}
+
+static void *client_fn(void *arg)
+{
+	struct netstat *ns_before, *ns_after;
+	unsigned int port = test_server_port;
+
+	ns_before = netstat_read();
+
+	test_client_active_rst(port++);
+	test_client_passive_rst(port++);
+
+	ns_after = netstat_read();
+	netstats_check(ns_before, ns_after, "client");
+	netstat_free(ns_after);
+	netstat_free(ns_before);
+
+	synchronize_threads(); /* exit */
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(15, server_fn, client_fn);
+	return 0;
+}

-- 
2.43.0


