Return-Path: <linux-kselftest+bounces-26934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCF6A3B0D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 06:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FC7A52CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 05:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8211B4153;
	Wed, 19 Feb 2025 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w2E5Dvmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FB1ADC7F
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739942481; cv=none; b=p3dM9X/DRR4kiebFCOKZ0Rtwn9ETv9e0hKLxggWYcN9LAaBIjBPu86P49S3+Rm7Wtfq6u3/6INgJUQ9EHiVBXKq0u9WQux98in1kX8MtjrNekmWteZV+JMVWTxX3V9uSJLNxGBmbB4/yspUFlFzROJxur1r0hhIxxrKxeheULrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739942481; c=relaxed/simple;
	bh=rFlyBFF897GPn6hw313WLphHkT0bNgX3OOhSM/Os4Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeUWOFwn5HQZ+gsSLV3g6S5/ZT2FzuaS90L+ClKnruHH2Xcbyol+/GjB1jlUZGuzGY96RIxhorhV1+G5GEoTXhAoc+EmGqv/NIZf2YDnE553jcnSpc+hD6RExi762+OqtDzUr7JquXUhHfnqu3MaG1ZlV7h34InQjcDB6jDltwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w2E5Dvmd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739942477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWApHiICTlgYzj+/tJ66MHJm2Dsou0Ghrxgtc1RnfGU=;
	b=w2E5DvmdhictxuLgSbHfcXCatScqN2LgiitrPgy7Kj8k+kkY6xo9Fz3Rys7E64audHw1TY
	7hqvRF2f7PJ8PQZP1lkmIzDM2V4tRQY0O+OJM7MU/+FajEJxvVpbpq21w70tRQ7Dq4EeJI
	ZLkrEnK6nEjIzzab5zn7Btl5FGSOhmY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add ktls selftest
Date: Wed, 19 Feb 2025 13:20:15 +0800
Message-ID: <20250219052015.274405-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250219052015.274405-1-jiayuan.chen@linux.dev>
References: <20250219052015.274405-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

add ktls selftest for sockmap

Test results:
sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
sockmap_ktls/tls simple offload:OK
sockmap_ktls/tls tx cork:OK
sockmap_ktls/tls tx cork with push:OK
sockmap_ktls/tls simple offload:OK
sockmap_ktls/tls tx cork:OK
sockmap_ktls/tls tx cork with push:OK
sockmap_ktls:OK

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 174 +++++++++++++++++-
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  26 +++
 2 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..49b85c1c7552 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -3,13 +3,64 @@
 /*
  * Tests for sockmap/sockhash holding kTLS sockets.
  */
-
+#include <error.h>
 #include <netinet/tcp.h>
+#include <linux/tls.h>
 #include "test_progs.h"
+#include "sockmap_helpers.h"
+#include "test_skmsg_load_helpers.skel.h"
+#include "test_sockmap_ktls.skel.h"
 
 #define MAX_TEST_NAME 80
 #define TCP_ULP 31
 
+static int init_ktls_pairs(int c, int p)
+{
+	int err;
+	struct tls12_crypto_info_aes_gcm_128 crypto_rx;
+	struct tls12_crypto_info_aes_gcm_128 crypto_tx;
+
+	err = setsockopt(c, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
+		goto out;
+
+	err = setsockopt(p, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
+		goto out;
+
+	memset(&crypto_rx, 0, sizeof(crypto_rx));
+	memset(&crypto_tx, 0, sizeof(crypto_tx));
+	crypto_rx.info.version = TLS_1_2_VERSION;
+	crypto_tx.info.version = TLS_1_2_VERSION;
+	crypto_rx.info.cipher_type = TLS_CIPHER_AES_GCM_128;
+	crypto_tx.info.cipher_type = TLS_CIPHER_AES_GCM_128;
+
+	err = setsockopt(c, SOL_TLS, TLS_TX, &crypto_tx, sizeof(crypto_tx));
+	if (!ASSERT_OK(err, "setsockopt(TLS_TX)"))
+		goto out;
+
+	err = setsockopt(p, SOL_TLS, TLS_RX, &crypto_rx, sizeof(crypto_rx));
+	if (!ASSERT_OK(err, "setsockopt(TLS_RX)"))
+		goto out;
+	return 0;
+out:
+	return -1;
+}
+
+static int create_ktls_pairs(int family, int sotype, int *c, int *p)
+{
+	int err;
+
+	err = create_pair(family, sotype, c, p);
+	if (!ASSERT_OK(err, "create_pair()"))
+		return -1;
+
+	err = init_ktls_pairs(*c, *p);
+	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
+		return -1;
+	return 0;
+}
+
 static int tcp_server(int family)
 {
 	int err, s;
@@ -146,6 +197,115 @@ static const char *fmt_test_name(const char *subtest_name, int family,
 	return test_name;
 }
 
+static void test_sockmap_ktls_offload(int family, int sotype)
+{
+	int err;
+	int c = 0, p = 0, sent, recvd;
+	char msg[12] = "hello world\0";
+	char rcv[13];
+
+	err = create_ktls_pairs(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_ktls_pairs()"))
+		goto out;
+
+	sent = send(c, msg, sizeof(msg), 0);
+	if (!ASSERT_OK(err, "send(msg)"))
+		goto out;
+
+	recvd = recv(p, rcv, sizeof(rcv), 0);
+	if (!ASSERT_OK(err, "recv(msg)") ||
+	    !ASSERT_EQ(recvd, sent, "length mismatch"))
+		goto out;
+
+	ASSERT_OK(memcmp(msg, rcv, sizeof(msg)), "data mismatch");
+
+out:
+	if (c)
+		close(c);
+	if (p)
+		close(p);
+}
+
+static void test_sockmap_ktls_tx_cork(int family, int sotype, bool push)
+{
+	int err, off;
+	int i, j;
+	int start_push = 0, push_len = 0;
+	int c = 0, p = 0, one = 1, sent, recvd;
+	int prog_fd, map_fd;
+	char msg[12] = "hello world\0";
+	char rcv[20] = {0};
+	struct test_sockmap_ktls *skel;
+
+	skel = test_sockmap_ktls__open_and_load();
+	if (!ASSERT_TRUE(skel, "open ktls skel"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy);
+	map_fd = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
+		goto out;
+
+	err = init_ktls_pairs(c, p);
+	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
+		goto out;
+
+	skel->bss->cork_byte = sizeof(msg);
+	if (push) {
+		start_push = 1;
+		push_len = 2;
+	}
+	skel->bss->push_start = start_push;
+	skel->bss->push_end = push_len;
+
+	off = sizeof(msg) / 2;
+	sent = send(c, msg, off, 0);
+	if (!ASSERT_EQ(sent, off, "send(msg)"))
+		goto out;
+
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_EQ(-1, recvd, "expected no data"))
+		goto out;
+
+	/* send remaining msg */
+	sent = send(c, msg + off, sizeof(msg) - off, 0);
+	if (!ASSERT_EQ(sent, sizeof(msg) - off, "send remaining data"))
+		goto out;
+
+	recvd = recv_timeout(p, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_OK(err, "recv(msg)") ||
+	    !ASSERT_EQ(recvd, sizeof(msg) + push_len, "check length mismatch"))
+		goto out;
+
+	for (i = 0, j = 0; i < recvd;) {
+		/* skip checking the data that has been pushed in */
+		if (i >= start_push && i <= start_push + push_len - 1) {
+			i++;
+			continue;
+		}
+		if (!ASSERT_EQ(rcv[i], msg[j], "data mismatch"))
+			goto out;
+		i++;
+		j++;
+	}
+out:
+	if (c)
+		close(c);
+	if (p)
+		close(p);
+	test_sockmap_ktls__destroy(skel);
+}
+
 static void run_tests(int family, enum bpf_map_type map_type)
 {
 	int map;
@@ -162,10 +322,22 @@ static void run_tests(int family, enum bpf_map_type map_type)
 	close(map);
 }
 
+static void run_ktls_test(int family, int sotype)
+{
+	if (test__start_subtest("tls simple offload"))
+		test_sockmap_ktls_offload(family, sotype);
+	if (test__start_subtest("tls tx cork"))
+		test_sockmap_ktls_tx_cork(family, sotype, false);
+	if (test__start_subtest("tls tx cork with push"))
+		test_sockmap_ktls_tx_cork(family, sotype, true);
+}
+
 void test_sockmap_ktls(void)
 {
 	run_tests(AF_INET, BPF_MAP_TYPE_SOCKMAP);
 	run_tests(AF_INET, BPF_MAP_TYPE_SOCKHASH);
 	run_tests(AF_INET6, BPF_MAP_TYPE_SOCKMAP);
 	run_tests(AF_INET6, BPF_MAP_TYPE_SOCKHASH);
+	run_ktls_test(AF_INET, SOCK_STREAM);
+	run_ktls_test(AF_INET6, SOCK_STREAM);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
new file mode 100644
index 000000000000..e0f757929ef4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+int cork_byte;
+int push_start;
+int push_end;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 20);
+	__type(key, int);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+SEC("sk_msg")
+int prog_sk_policy(struct sk_msg_md *msg)
+{
+	if (cork_byte > 0)
+		bpf_msg_cork_bytes(msg, cork_byte);
+	if (push_start > 0 && push_end > 0)
+		bpf_msg_push_data(msg, push_start, push_end, 0);
+
+	return SK_PASS;
+}
-- 
2.47.1


