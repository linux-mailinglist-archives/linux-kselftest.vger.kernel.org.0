Return-Path: <linux-kselftest+bounces-1989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1753814002
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B050D1C21EB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68A14F6B;
	Fri, 15 Dec 2023 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="c/y/G3x7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6D111A4
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso2322215e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607856; x=1703212656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSjB1EB5SWfTFjxbNKGGEdmP2s9s8plvjxkaEGvyTqk=;
        b=c/y/G3x7tvrYSqrZEKT/j5ACpvcN7x2/TX3TWzl7TEoRk6lgichWXfligN9ZxsUlE4
         gMQhCi7Fa2aYOLqAfTn06hmaqNBnSY3IgQ46pq1nfBifMReFgIpNpNTrCGf1wWWOIuay
         zGidwxQgONUwAT0/wVoY97Rq5I7lwAEdmclJxk1lpjpklqOwCDO/KE3CoRpwxCpWU9hi
         NWJMiFkY5jT2ARMf1T1s0nfC597PgUJWMbXivhbCgkgeFIBwL2hUVFtwnvO+pm07rpBM
         iF+TQaBgrBDPgZvL40x6VivK7arbYDKnWNVKqOnkCVoIdUadNrejQx3HkFjTBg8Zi65x
         gJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607856; x=1703212656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSjB1EB5SWfTFjxbNKGGEdmP2s9s8plvjxkaEGvyTqk=;
        b=LdYVkwFHfFykxQxsnBRhZ//5qFp7z31Jz+DeBv2ZbkBOwEyYi7LkRKlweMZA7p1zPZ
         FvEG0lk3Uhtvaf9W2PuurAnefR/0qG5r1dDE1YXaae1VOncx8U9aCERe/J/NPOws3G5c
         d4/KVoH95QSijrdCYKW8YYHD46nRbM98Xgz8VPDlIrsYb/q+sViJFTHEJrDnJkYd2hoO
         I/DbunkrH8I1v0Z3+DwWGGp1Acgj5vpn9LLa7kTWUxZzAZJgNk9gL6UAurArQyDnG6U2
         JGt/jbMETZiR/JdvajPASEJ74ATMZfZRKuGdzVngMCzz+rLpqFjbc4vJeDsPwJBQ2F9z
         oQjQ==
X-Gm-Message-State: AOJu0YxbP18jN8mzZt7HxLPrcKqXmUoWAfwsO9wrjHn+YhEe5uM7IgcG
	pIqbTCTxfGTdtA1YwU1Yv/ntYZmymBexYkA4oWA=
X-Google-Smtp-Source: AGHT+IGaVPu6VWdG8ZPfGveRrh3CjuGipaQH75daPcPKXRy/hL3iZAC9PcH28as5Pvt3vFdFFlHwtQ==
X-Received: by 2002:a05:600c:d4:b0:40b:5e4a:405f with SMTP id u20-20020a05600c00d400b0040b5e4a405fmr4571641wmm.127.1702607855788;
        Thu, 14 Dec 2023 18:37:35 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:35 -0800 (PST)
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
Subject: [PATCH 09/12] selftests/net: Add SEQ number extension test
Date: Fri, 15 Dec 2023 02:36:23 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-9-f6c08180b985@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607833; l=9155; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=B7iG09khirCmF9VSsv4r9LOgI8ZVE+bnTGQVQqS3z4U=; b=5w8OCIzHj3CIX5nYlGQ4jpkImbosZSVSrjmCV4WStHSCe70oQodPo0aPEFqGvkYWh1LUvxWlB 80ajEIL/Q5/C/iBDUDFB9QmSyNSeEpp/L5Lt4K+zdUSTISP1LCpGTZt
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Check that on SEQ number wraparound there is no disruption or TCPAOBad
segments produced.

Sample of expected output:
> # ./seq-ext_ipv4
> 1..7
> # 1436[lib/setup.c:254] rand seed 1686611079
> TAP version 13
> ok 1 server alive
> ok 2 post-migrate connection alive
> ok 3 TCPAOGood counter increased 1002 => 3002
> ok 4 TCPAOGood counter increased 1003 => 3003
> ok 5 TCPAOBad counter didn't increase
> ok 6 TCPAOBad counter didn't increase
> ok 7 SEQ extension incremented: 1/1999, 1/998999
> # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile  |   1 +
 tools/testing/selftests/net/tcp_ao/seq-ext.c | 245 +++++++++++++++++++++++++++
 2 files changed, 246 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index aa11a855c3e0..5408c7233460 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -4,6 +4,7 @@ TEST_BOTH_AF += connect
 TEST_BOTH_AF += connect-deny
 TEST_BOTH_AF += icmps-accept icmps-discard
 TEST_BOTH_AF += restore
+TEST_BOTH_AF += seq-ext
 TEST_BOTH_AF += setsockopt-closed
 TEST_BOTH_AF += unsigned-md5
 
diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
new file mode 100644
index 000000000000..ad4e77d6823e
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Check that after SEQ number wrap-around:
+ * 1. SEQ-extension has upper bytes set
+ * 2. TCP conneciton is alive and no TCPAOBad segments
+ * In order to test (2), the test doesn't just adjust seq number for a queue
+ * on a connected socket, but migrates it to another sk+port number, so
+ * that there won't be any delayed packets that will fail to verify
+ * with the new SEQ numbers.
+ */
+#include <inttypes.h>
+#include "aolib.h"
+
+const unsigned int nr_packets = 1000;
+const unsigned int msg_len = 1000;
+const unsigned int quota = nr_packets * msg_len;
+unsigned int client_new_port;
+
+/* Move them closer to roll-over */
+static void test_adjust_seqs(struct tcp_sock_state *img,
+			     struct tcp_ao_repair *ao_img,
+			     bool server)
+{
+	uint32_t new_seq1, new_seq2;
+
+	/* make them roll-over during quota, but on different segments */
+	if (server) {
+		new_seq1 = ((uint32_t)-1) - msg_len;
+		new_seq2 = ((uint32_t)-1) - (quota - 2 * msg_len);
+	} else {
+		new_seq1 = ((uint32_t)-1) - (quota - 2 * msg_len);
+		new_seq2 = ((uint32_t)-1) - msg_len;
+	}
+
+	img->in.seq = new_seq1;
+	img->trw.snd_wl1 = img->in.seq - msg_len;
+	img->out.seq = new_seq2;
+	img->trw.rcv_wup = img->in.seq;
+}
+
+static int test_sk_restore(struct tcp_sock_state *img,
+			   struct tcp_ao_repair *ao_img, sockaddr_af *saddr,
+			   const union tcp_addr daddr, unsigned int dport,
+			   struct tcp_ao_counters *cnt)
+{
+	int sk;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	test_enable_repair(sk);
+	test_sock_restore(sk, img, saddr, daddr, dport);
+	if (test_add_repaired_key(sk, DEFAULT_TEST_PASSWORD, 0, daddr, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+	test_ao_restore(sk, ao_img);
+
+	if (test_get_tcp_ao_counters(sk, cnt))
+		test_error("test_get_tcp_ao_counters()");
+
+	test_disable_repair(sk);
+	test_sock_state_free(img);
+	return sk;
+}
+
+static void *server_fn(void *arg)
+{
+	uint64_t before_good, after_good, after_bad;
+	struct tcp_ao_counters ao1, ao2;
+	struct tcp_sock_state img;
+	struct tcp_ao_repair ao_img;
+	sockaddr_af saddr;
+	ssize_t bytes;
+	int sk, lsk;
+
+	lsk = test_listen_socket(this_ip_addr, test_server_port, 1);
+
+	if (test_add_key(lsk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	synchronize_threads(); /* 1: MKT added => connect() */
+
+	if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
+		test_error("test_wait_fd()");
+
+	sk = accept(lsk, NULL, NULL);
+	if (sk < 0)
+		test_error("accept()");
+
+	synchronize_threads(); /* 2: accepted => send data */
+	close(lsk);
+
+	bytes = test_server_run(sk, quota, TEST_TIMEOUT_SEC);
+	if (bytes != quota) {
+		if (bytes > 0)
+			test_fail("server served: %zd", bytes);
+		else
+			test_fail("server returned: %zd", bytes);
+		goto out;
+	}
+
+	before_good = netstat_get_one("TCPAOGood", NULL);
+
+	synchronize_threads(); /* 3: restore the connection on another port */
+
+	test_enable_repair(sk);
+	test_sock_checkpoint(sk, &img, &saddr);
+	test_ao_checkpoint(sk, &ao_img);
+	test_kill_sk(sk);
+#ifdef IPV6_TEST
+	saddr.sin6_port = htons(ntohs(saddr.sin6_port) + 1);
+#else
+	saddr.sin_port = htons(ntohs(saddr.sin_port) + 1);
+#endif
+	test_adjust_seqs(&img, &ao_img, true);
+	synchronize_threads(); /* 4: dump finished */
+	sk = test_sk_restore(&img, &ao_img, &saddr, this_ip_dest,
+			     client_new_port, &ao1);
+
+	synchronize_threads(); /* 5: verify counters during SEQ-number rollover */
+	bytes = test_server_run(sk, quota, TEST_TIMEOUT_SEC);
+	if (bytes != quota) {
+		if (bytes > 0)
+			test_fail("server served: %zd", bytes);
+		else
+			test_fail("server returned: %zd", bytes);
+	} else {
+		test_ok("server alive");
+	}
+
+	if (test_get_tcp_ao_counters(sk, &ao2))
+		test_error("test_get_tcp_ao_counters()");
+	after_good = netstat_get_one("TCPAOGood", NULL);
+
+	test_tcp_ao_counters_cmp(NULL, &ao1, &ao2, TEST_CNT_GOOD);
+
+	if (after_good <= before_good) {
+		test_fail("TCPAOGood counter did not increase: %zu <= %zu",
+			  after_good, before_good);
+	} else {
+		test_ok("TCPAOGood counter increased %zu => %zu",
+			before_good, after_good);
+	}
+	after_bad = netstat_get_one("TCPAOBad", NULL);
+	if (after_bad)
+		test_fail("TCPAOBad counter is non-zero: %zu", after_bad);
+	else
+		test_ok("TCPAOBad counter didn't increase");
+	test_enable_repair(sk);
+	test_ao_checkpoint(sk, &ao_img);
+	if (ao_img.snd_sne && ao_img.rcv_sne) {
+		test_ok("SEQ extension incremented: %u/%u",
+			ao_img.snd_sne, ao_img.rcv_sne);
+	} else {
+		test_fail("SEQ extension was not incremented: %u/%u",
+			  ao_img.snd_sne, ao_img.rcv_sne);
+	}
+
+	synchronize_threads(); /* 6: verified => closed */
+out:
+	close(sk);
+	return NULL;
+}
+
+static void *client_fn(void *arg)
+{
+	uint64_t before_good, after_good, after_bad;
+	struct tcp_ao_counters ao1, ao2;
+	struct tcp_sock_state img;
+	struct tcp_ao_repair ao_img;
+	sockaddr_af saddr;
+	int sk;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	synchronize_threads(); /* 1: MKT added => connect() */
+	if (test_connect_socket(sk, this_ip_dest, test_server_port) <= 0)
+		test_error("failed to connect()");
+
+	synchronize_threads(); /* 2: accepted => send data */
+	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC)) {
+		test_fail("pre-migrate verify failed");
+		return NULL;
+	}
+
+	before_good = netstat_get_one("TCPAOGood", NULL);
+
+	synchronize_threads(); /* 3: restore the connection on another port */
+	test_enable_repair(sk);
+	test_sock_checkpoint(sk, &img, &saddr);
+	test_ao_checkpoint(sk, &ao_img);
+	test_kill_sk(sk);
+#ifdef IPV6_TEST
+	client_new_port = ntohs(saddr.sin6_port) + 1;
+	saddr.sin6_port = htons(ntohs(saddr.sin6_port) + 1);
+#else
+	client_new_port = ntohs(saddr.sin_port) + 1;
+	saddr.sin_port = htons(ntohs(saddr.sin_port) + 1);
+#endif
+	test_adjust_seqs(&img, &ao_img, false);
+	synchronize_threads(); /* 4: dump finished */
+	sk = test_sk_restore(&img, &ao_img, &saddr, this_ip_dest,
+			     test_server_port + 1, &ao1);
+
+	synchronize_threads(); /* 5: verify counters during SEQ-number rollover */
+	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
+		test_fail("post-migrate verify failed");
+	else
+		test_ok("post-migrate connection alive");
+
+	if (test_get_tcp_ao_counters(sk, &ao2))
+		test_error("test_get_tcp_ao_counters()");
+	after_good = netstat_get_one("TCPAOGood", NULL);
+
+	test_tcp_ao_counters_cmp(NULL, &ao1, &ao2, TEST_CNT_GOOD);
+
+	if (after_good <= before_good) {
+		test_fail("TCPAOGood counter did not increase: %zu <= %zu",
+			  after_good, before_good);
+	} else {
+		test_ok("TCPAOGood counter increased %zu => %zu",
+			before_good, after_good);
+	}
+	after_bad = netstat_get_one("TCPAOBad", NULL);
+	if (after_bad)
+		test_fail("TCPAOBad counter is non-zero: %zu", after_bad);
+	else
+		test_ok("TCPAOBad counter didn't increase");
+
+	synchronize_threads(); /* 6: verified => closed */
+	close(sk);
+
+	synchronize_threads(); /* don't race to exit: let server exit() */
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(7, server_fn, client_fn);
+	return 0;
+}

-- 
2.43.0


