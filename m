Return-Path: <linux-kselftest+bounces-1988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836C813FFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA23A284F28
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC0A4A;
	Fri, 15 Dec 2023 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RLFa3Sye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683F10787
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c2308faedso2519255e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607854; x=1703212654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4as2zfmCJXOSeNrVl9Fp96XhQJ1uE4fsn7ilKv305I=;
        b=RLFa3SyeQ253phos+DOOdBYyquo1yny2Sl3FvKR56LeAyYxuYx9wpKSjHfodWlceEp
         e5CQEI11JyY0YWUSVphlMzUtuH5fLNElOYNCogP2SwFf1GYuAsRX3VL2M1+rBSv6obLX
         6e+1TFErIEQhKJRWIgh5dNdx3WgQPHi7/7T/iHprllJdQzktz97BeQYZvpnDWZQ7n0Nk
         Qd113jwg07BuziA+zlOulHDi+xJ+KoBVrFjKXd8X+RzH1fCam9Ejn/uoLEz1uz9N4ffX
         elw0oqz6ToKV7iPM2+o4zN4RTMm9L342bHiH4m2a2d591ULVhD92bc32bVePrz+KdU+a
         h1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607854; x=1703212654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4as2zfmCJXOSeNrVl9Fp96XhQJ1uE4fsn7ilKv305I=;
        b=fSOBWqPRTwldnk1SCIpRMo1O3JiXx7fMU6Svf5pVAlV6u7PlkVS2BIvMNSRRFb8GUA
         FzsEVVJvmQebwAMZ9ifUdVI7chLPTegPQnpvYhS13BiZJpRDD1Ad+I4Vm0Gb2Iw/8i5R
         vwslX7LixBjHcQcUCUKAqUzN3TYDIw2sg1frt1zPfG4P24C5djBD8GRio+meuXqn9rRw
         5+T8BvKeJxxfSjOZS9TykMwvtNz4Xg7VzUqs5+FWHpCVqS3vPoQ+laCKzUJRKoZ3iy7x
         ydZlbVe2VOw86uyHliTWvL4k7kyGa8rAZehPMsbnkKYbp1OFMFmVlEyoleSBl2IWwPug
         25HA==
X-Gm-Message-State: AOJu0Yx3H1qm6B9nzC4UmT/Wd0QdCOUSt6th6T6iM6WoumUemaaOgvQe
	kgubrHQ0tocS9kqOvN4dMIGOMA==
X-Google-Smtp-Source: AGHT+IGYfaDG6ERIH1VAYdt5etED8IviDiWIhK9WRcDLKaGi/d/s9YSdff2mCuxZSJrQd1KDP6I2kw==
X-Received: by 2002:a05:600c:54c7:b0:40c:3f11:e501 with SMTP id iw7-20020a05600c54c700b0040c3f11e501mr5302087wmb.126.1702607854134;
        Thu, 14 Dec 2023 18:37:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:33 -0800 (PST)
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
Subject: [PATCH 08/12] selftests/net: Add TCP_REPAIR TCP-AO tests
Date: Fri, 15 Dec 2023 02:36:22 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-8-f6c08180b985@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607833; l=10712; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=AAqPcuCATGjjUF7Zck4Ev4ez90mEpD3VhNWdezqe8IM=; b=bOxiuikD9+kW0H7d5/yABwfR2xnX5X81VEIeaF5lAYMnqYBr8XsUPpmOX1wiq0HYroHu1saHH 7gnsRO+DUxXAterK73gGdXnXXF5fqeKo1EFTN9cKhDmC5DPDkOvbk2B
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

The test plan is:
1. check that TCP-AO connection may be restored on another socket
2. check restore with wrong send/recv ISN (checking that they are
   part of MAC generation)
3. check restore with wrong SEQ number extension (checking that
   high bytes of it taken into MAC generation)

Sample output expected:
> # ./restore_ipv4
> 1..20
> # 1412[lib/setup.c:254] rand seed 1686610825
> TAP version 13
> ok 1 TCP-AO migrate to another socket: server alive
> ok 2 TCP-AO migrate to another socket: post-migrate connection is alive
> ok 3 TCP-AO migrate to another socket: counter TCPAOGood increased 23 => 44
> ok 4 TCP-AO migrate to another socket: counter TCPAOGood increased 22 => 42
> ok 5 TCP-AO with wrong send ISN: server couldn't serve
> ok 6 TCP-AO with wrong send ISN: post-migrate connection is broken
> ok 7 TCP-AO with wrong send ISN: counter TCPAOBad increased 0 => 4
> ok 8 TCP-AO with wrong send ISN: counter TCPAOBad increased 0 => 3
> ok 9 TCP-AO with wrong receive ISN: server couldn't serve
> ok 10 TCP-AO with wrong receive ISN: post-migrate connection is broken
> ok 11 TCP-AO with wrong receive ISN: counter TCPAOBad increased 4 => 8
> ok 12 TCP-AO with wrong receive ISN: counter TCPAOBad increased 5 => 10
> ok 13 TCP-AO with wrong send SEQ ext number: server couldn't serve
> ok 14 TCP-AO with wrong send SEQ ext number: post-migrate connection is broken
> ok 15 TCP-AO with wrong send SEQ ext number: counter TCPAOBad increased 9 => 10
> ok 16 TCP-AO with wrong send SEQ ext number: counter TCPAOBad increased 11 => 19
> ok 17 TCP-AO with wrong receive SEQ ext number: post-migrate connection is broken
> ok 18 TCP-AO with wrong receive SEQ ext number: server couldn't serve
> ok 19 TCP-AO with wrong receive SEQ ext number: counter TCPAOBad increased 10 => 18
> ok 20 TCP-AO with wrong receive SEQ ext number: counter TCPAOBad increased 20 => 23
> # Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile  |   1 +
 tools/testing/selftests/net/tcp_ao/restore.c | 236 +++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index f0b218b99506..aa11a855c3e0 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -3,6 +3,7 @@ TEST_BOTH_AF := bench-lookups
 TEST_BOTH_AF += connect
 TEST_BOTH_AF += connect-deny
 TEST_BOTH_AF += icmps-accept icmps-discard
+TEST_BOTH_AF += restore
 TEST_BOTH_AF += setsockopt-closed
 TEST_BOTH_AF += unsigned-md5
 
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
new file mode 100644
index 000000000000..8fdc808df325
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+/* This is over-simplified TCP_REPAIR for TCP_ESTABLISHED sockets
+ * It tests that TCP-AO enabled connection can be restored.
+ * For the proper socket repair see:
+ * https://github.com/checkpoint-restore/criu/blob/criu-dev/soccr/soccr.h
+ */
+#include <inttypes.h>
+#include "aolib.h"
+
+const size_t nr_packets = 20;
+const size_t msg_len = 100;
+const size_t quota = nr_packets * msg_len;
+#define fault(type)	(inj == FAULT_ ## type)
+
+static void try_server_run(const char *tst_name, unsigned int port,
+			   fault_t inj, test_cnt cnt_expected)
+{
+	const char *cnt_name = "TCPAOGood";
+	struct tcp_ao_counters ao1, ao2;
+	uint64_t before_cnt, after_cnt;
+	int sk, lsk;
+	time_t timeout;
+	ssize_t bytes;
+
+	if (fault(TIMEOUT))
+		cnt_name = "TCPAOBad";
+	lsk = test_listen_socket(this_ip_addr, port, 1);
+
+	if (test_add_key(lsk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
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
+		test_fail("%s: server served: %zd", tst_name, bytes);
+		goto out;
+	}
+
+	before_cnt = netstat_get_one(cnt_name, NULL);
+	if (test_get_tcp_ao_counters(sk, &ao1))
+		test_error("test_get_tcp_ao_counters()");
+
+	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
+	bytes = test_server_run(sk, quota, timeout);
+	if (fault(TIMEOUT)) {
+		if (bytes > 0)
+			test_fail("%s: server served: %zd", tst_name, bytes);
+		else
+			test_ok("%s: server couldn't serve", tst_name);
+	} else {
+		if (bytes != quota)
+			test_fail("%s: server served: %zd", tst_name, bytes);
+		else
+			test_ok("%s: server alive", tst_name);
+	}
+	if (test_get_tcp_ao_counters(sk, &ao2))
+		test_error("test_get_tcp_ao_counters()");
+	after_cnt = netstat_get_one(cnt_name, NULL);
+
+	test_tcp_ao_counters_cmp(tst_name, &ao1, &ao2, cnt_expected);
+
+	if (after_cnt <= before_cnt) {
+		test_fail("%s: %s counter did not increase: %zu <= %zu",
+				tst_name, cnt_name, after_cnt, before_cnt);
+	} else {
+		test_ok("%s: counter %s increased %zu => %zu",
+			tst_name, cnt_name, before_cnt, after_cnt);
+	}
+
+	/*
+	 * Before close() as that will send FIN and move the peer in TCP_CLOSE
+	 * and that will prevent reading AO counters from the peer's socket.
+	 */
+	synchronize_threads(); /* 3: verified => closed */
+out:
+	close(sk);
+}
+
+static void *server_fn(void *arg)
+{
+	unsigned int port = test_server_port;
+
+	try_server_run("TCP-AO migrate to another socket", port++,
+		       0, TEST_CNT_GOOD);
+	try_server_run("TCP-AO with wrong send ISN", port++,
+		       FAULT_TIMEOUT, TEST_CNT_BAD);
+	try_server_run("TCP-AO with wrong receive ISN", port++,
+		       FAULT_TIMEOUT, TEST_CNT_BAD);
+	try_server_run("TCP-AO with wrong send SEQ ext number", port++,
+		       FAULT_TIMEOUT, TEST_CNT_BAD);
+	try_server_run("TCP-AO with wrong receive SEQ ext number", port++,
+		       FAULT_TIMEOUT, TEST_CNT_NS_BAD | TEST_CNT_GOOD);
+
+	synchronize_threads(); /* don't race to exit: client exits */
+	return NULL;
+}
+
+static void test_get_sk_checkpoint(unsigned int server_port, sockaddr_af *saddr,
+				   struct tcp_sock_state *img,
+				   struct tcp_ao_repair *ao_img)
+{
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
+	if (test_connect_socket(sk, this_ip_dest, server_port) <= 0)
+		test_error("failed to connect()");
+
+	synchronize_threads(); /* 2: accepted => send data */
+	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
+		test_fail("pre-migrate verify failed");
+
+	test_enable_repair(sk);
+	test_sock_checkpoint(sk, img, saddr);
+	test_ao_checkpoint(sk, ao_img);
+	test_kill_sk(sk);
+}
+
+static void test_sk_restore(const char *tst_name, unsigned int server_port,
+			    sockaddr_af *saddr, struct tcp_sock_state *img,
+			    struct tcp_ao_repair *ao_img,
+			    fault_t inj, test_cnt cnt_expected)
+{
+	const char *cnt_name = "TCPAOGood";
+	struct tcp_ao_counters ao1, ao2;
+	uint64_t before_cnt, after_cnt;
+	time_t timeout;
+	int sk;
+
+	if (fault(TIMEOUT))
+		cnt_name = "TCPAOBad";
+
+	before_cnt = netstat_get_one(cnt_name, NULL);
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	test_enable_repair(sk);
+	test_sock_restore(sk, img, saddr, this_ip_dest, server_port);
+	if (test_add_repaired_key(sk, DEFAULT_TEST_PASSWORD, 0, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+	test_ao_restore(sk, ao_img);
+
+	if (test_get_tcp_ao_counters(sk, &ao1))
+		test_error("test_get_tcp_ao_counters()");
+
+	test_disable_repair(sk);
+	test_sock_state_free(img);
+
+	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
+	if (test_client_verify(sk, msg_len, nr_packets, timeout)) {
+		if (fault(TIMEOUT))
+			test_ok("%s: post-migrate connection is broken", tst_name);
+		else
+			test_fail("%s: post-migrate connection is working", tst_name);
+	} else {
+		if (fault(TIMEOUT))
+			test_fail("%s: post-migrate connection still working", tst_name);
+		else
+			test_ok("%s: post-migrate connection is alive", tst_name);
+	}
+	if (test_get_tcp_ao_counters(sk, &ao2))
+		test_error("test_get_tcp_ao_counters()");
+	after_cnt = netstat_get_one(cnt_name, NULL);
+
+	test_tcp_ao_counters_cmp(tst_name, &ao1, &ao2, cnt_expected);
+
+	if (after_cnt <= before_cnt) {
+		test_fail("%s: %s counter did not increase: %zu <= %zu",
+				tst_name, cnt_name, after_cnt, before_cnt);
+	} else {
+		test_ok("%s: counter %s increased %zu => %zu",
+			tst_name, cnt_name, before_cnt, after_cnt);
+	}
+	synchronize_threads(); /* 3: verified => closed */
+	close(sk);
+}
+
+static void *client_fn(void *arg)
+{
+	unsigned int port = test_server_port;
+	struct tcp_sock_state tcp_img;
+	struct tcp_ao_repair ao_img;
+	sockaddr_af saddr;
+
+	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
+	test_sk_restore("TCP-AO migrate to another socket", port++,
+			&saddr, &tcp_img, &ao_img, 0, TEST_CNT_GOOD);
+
+	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
+	ao_img.snt_isn += 1;
+	test_sk_restore("TCP-AO with wrong send ISN", port++,
+			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT, TEST_CNT_BAD);
+
+	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
+	ao_img.rcv_isn += 1;
+	test_sk_restore("TCP-AO with wrong receive ISN", port++,
+			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT, TEST_CNT_BAD);
+
+	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
+	ao_img.snd_sne += 1;
+	test_sk_restore("TCP-AO with wrong send SEQ ext number", port++,
+			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
+			TEST_CNT_NS_BAD | TEST_CNT_GOOD);
+
+	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
+	ao_img.rcv_sne += 1;
+	test_sk_restore("TCP-AO with wrong receive SEQ ext number", port++,
+			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
+			TEST_CNT_NS_GOOD | TEST_CNT_BAD);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(20, server_fn, client_fn);
+	return 0;
+}

-- 
2.43.0


