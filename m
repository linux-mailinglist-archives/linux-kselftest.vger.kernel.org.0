Return-Path: <linux-kselftest+bounces-48280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD7CF6C46
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 06:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02BAA30DF3FD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 05:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245B2FF147;
	Tue,  6 Jan 2026 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JAwFImgp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386852FD68B
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676565; cv=none; b=i6mQ/cxMmzeYcjFrD9Lng+ad+aii14N11PJE4HPmHYt5peuBmpYpKABOFML66G/Ob9voyTmIWgt0hpKKl8vAnyupiALbVtNfTYGYEDbZWScu/cRBjaMvc8PQA18zKEIhHi4xzP1VxMLDFrnRsnk5g6xXHAplLeV/0lyF2Pwrr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676565; c=relaxed/simple;
	bh=xKObvFRGKEYUrYnJ1OLH67LDan3vy2jvzeNj+IY+nlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTWYaypNjzrFYLrdvaL03fZ/aGLrnKNXUW2J0wSdgEUL4f+NlzHJ4kpCAaoRjH4qana3na7hApLS+WtjojtH3cZdYCDJ49QtbFDDwqLrgl7NTxd3So6t4TZWfxdP39Ygdcm14D/H2K5VHFYJGxOiJKgDgtua6116X1r2EpiWznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JAwFImgp; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767676561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEFMcG+L3uFXxQpXyYX+FcO5FT8RHAGQySVhVBJEZHY=;
	b=JAwFImgpjzjSO7Usbzc5I1tIYZKeH3LAelvVBdH00Xy2PBeWWxKz0sWaaPbIAZnLWiP47q
	7o1wvTMTKIUheH8YlaPQysckE/TlqK/6n5dJnj1svFFyC6GpNzXxeBSz3G+k2C6cKZtliZ
	FSAtcKAiRzUBt2DqeqPpjOv4RMtlA/k=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 3/3] bpf, selftest: Add tests for FIONREAD and copied_seq
Date: Tue,  6 Jan 2026 13:14:29 +0800
Message-ID: <20260106051458.279151-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260106051458.279151-1-jiayuan.chen@linux.dev>
References: <20260106051458.279151-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit adds two new test functions: one to reproduce the bug reported
by syzkaller [1], and another to cover the calculation of copied_seq.

The tests primarily involve installing  and uninstalling sockmap on
sockets, then reading data to verify proper functionality.

Additionally, extend the do_test_sockmap_skb_verdict_fionread() function
to support UDP FIONREAD testing.

[1] https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 202 +++++++++++++++++-
 .../bpf/progs/test_sockmap_pass_prog.c        |  14 ++
 2 files changed, 210 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1e3e4392dcca..f15ccd51a765 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Cloudflare
 #include <error.h>
-#include <netinet/tcp.h>
+#include <linux/tcp.h>
+#include <linux/socket.h>
 #include <sys/epoll.h>
 
 #include "test_progs.h"
@@ -22,6 +23,15 @@
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
 
+/**
+ * SOL_TCP is defined in <netinet/tcp.h> (glibc), but the copybuf_address
+ * field of tcp_zerocopy_receive is not yet included in older versions.
+ * This workaround remains necessary until the glibc update propagates.
+ */
+#ifndef SOL_TCP
+#define SOL_TCP 6
+#endif
+
 static int connected_socket_v4(void)
 {
 	struct sockaddr_in addr = {
@@ -536,13 +546,14 @@ static void test_sockmap_skb_verdict_shutdown(void)
 }
 
 
-static void test_sockmap_skb_verdict_fionread(bool pass_prog)
+static void do_test_sockmap_skb_verdict_fionread(int sotype, bool pass_prog)
 {
 	int err, map, verdict, c0 = -1, c1 = -1, p0 = -1, p1 = -1;
 	int expected, zero = 0, sent, recvd, avail;
 	struct test_sockmap_pass_prog *pass = NULL;
 	struct test_sockmap_drop_prog *drop = NULL;
 	char buf[256] = "0123456789";
+	int split_len = sizeof(buf) / 2;
 
 	if (pass_prog) {
 		pass = test_sockmap_pass_prog__open_and_load();
@@ -550,7 +561,10 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 			return;
 		verdict = bpf_program__fd(pass->progs.prog_skb_verdict);
 		map = bpf_map__fd(pass->maps.sock_map_rx);
-		expected = sizeof(buf);
+		if (sotype == SOCK_DGRAM)
+			expected = split_len; /* FIONREAD for UDP is different from TCP */
+		else
+			expected = sizeof(buf);
 	} else {
 		drop = test_sockmap_drop_prog__open_and_load();
 		if (!ASSERT_OK_PTR(drop, "open_and_load"))
@@ -566,7 +580,7 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
 
-	err = create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
+	err = create_socket_pairs(AF_INET, sotype, &c0, &c1, &p0, &p1);
 	if (!ASSERT_OK(err, "create_socket_pairs()"))
 		goto out;
 
@@ -574,8 +588,9 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
 		goto out_close;
 
-	sent = xsend(p1, &buf, sizeof(buf), 0);
-	ASSERT_EQ(sent, sizeof(buf), "xsend(p0)");
+	sent = xsend(p1, &buf, split_len, 0);
+	sent += xsend(p1, &buf, sizeof(buf) - split_len, 0);
+	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
 	err = ioctl(c1, FIONREAD, &avail);
 	ASSERT_OK(err, "ioctl(FIONREAD) error");
 	ASSERT_EQ(avail, expected, "ioctl(FIONREAD)");
@@ -597,6 +612,12 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
+static void test_sockmap_skb_verdict_fionread(bool pass_prog)
+{
+	do_test_sockmap_skb_verdict_fionread(SOCK_STREAM, pass_prog);
+	do_test_sockmap_skb_verdict_fionread(SOCK_DGRAM, pass_prog);
+}
+
 static void test_sockmap_skb_verdict_change_tail(void)
 {
 	struct test_sockmap_change_tail *skel;
@@ -1042,6 +1063,169 @@ static void test_sockmap_vsock_unconnected(void)
 	xclose(map);
 }
 
+/* it is used to reproduce WARNING */
+static void test_sockmap_zc(void)
+{
+	int map, err, sent, recvd, zero = 0, one = 1, on = 1;
+	char buf[10] = "0123456789", rcv[11], addr[100];
+	struct test_sockmap_pass_prog *skel = NULL;
+	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
+	struct tcp_zerocopy_receive zc;
+	socklen_t zc_len = sizeof(zc);
+	struct bpf_program *prog;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1))
+		goto end;
+
+	prog = skel->progs.prog_skb_verdict_ingress;
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto end;
+
+	err = bpf_map_update_elem(map, &zero, &p0, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto end;
+
+	err = bpf_map_update_elem(map, &one, &p1, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto end;
+
+	sent = xsend(c0, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(sent, sizeof(buf), "xsend"))
+		goto end;
+
+	/* trigger tcp_bpf_recvmsg_parser and inc copied_seq of p1 */
+	recvd = recv_timeout(p1, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_EQ(recvd, sent, "recv_timeout(p1)"))
+		goto end;
+
+	/* uninstall sockmap of p1 */
+	bpf_map_delete_elem(map, &one);
+
+	/* trigger tcp stack and the rcv_nxt of p1 is less than copied_seq */
+	sent = xsend(c1, buf, sizeof(buf) - 1, 0);
+	if (!ASSERT_EQ(sent, sizeof(buf) - 1, "xsend"))
+		goto end;
+
+	err = setsockopt(p1, SOL_SOCKET, SO_ZEROCOPY, &on, sizeof(on));
+	if (!ASSERT_OK(err, "setsockopt"))
+		goto end;
+
+	memset(&zc, 0, sizeof(zc));
+	zc.copybuf_address = (__u64)((unsigned long)addr);
+	zc.copybuf_len = sizeof(addr);
+
+	err = getsockopt(p1, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, &zc, &zc_len);
+	if (!ASSERT_OK(err, "getsockopt"))
+		goto end;
+
+end:
+	if (c0 >= 0)
+		close(c0);
+	if (p0 >= 0)
+		close(p0);
+	if (c1 >= 0)
+		close(c1);
+	if (p1 >= 0)
+		close(p1);
+	test_sockmap_pass_prog__destroy(skel);
+}
+
+/* it is used to check whether copied_seq of sk is correct */
+static void test_sockmap_copied_seq(bool strp)
+{
+	int i, map, err, sent, recvd, zero = 0, one = 1;
+	struct test_sockmap_pass_prog *skel = NULL;
+	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
+	char buf[10] = "0123456789", rcv[11];
+	struct bpf_program *prog;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1))
+		goto end;
+
+	prog = skel->progs.prog_skb_verdict_ingress;
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
+		goto end;
+
+	if (strp) {
+		prog = skel->progs.prog_skb_verdict_ingress_strp;
+		err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_PARSER, 0);
+		if (!ASSERT_OK(err, "bpf_prog_attach parser"))
+			goto end;
+	}
+
+	err = bpf_map_update_elem(map, &zero, &p0, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p0)"))
+		goto end;
+
+	err = bpf_map_update_elem(map, &one, &p1, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(p1)"))
+		goto end;
+
+	/* just trigger sockamp: data sent by c0 will be received by p1 */
+	sent = xsend(c0, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c0), bpf"))
+		goto end;
+
+	recvd = recv_timeout(p1, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
+	if (!ASSERT_EQ(recvd, sent, "recv_timeout(p1), bpf"))
+		goto end;
+
+	/* uninstall sockmap of p1 and p0 */
+	err = bpf_map_delete_elem(map, &one);
+	if (!ASSERT_OK(err, "bpf_map_delete_elem(1)"))
+		goto end;
+
+	err = bpf_map_delete_elem(map, &zero);
+	if (!ASSERT_OK(err, "bpf_map_delete_elem(0)"))
+		goto end;
+
+	/* now all sockets become plain socket, they should still work */
+	for (i = 0; i < 5; i++) {
+		/* test copied_seq of p1 by running tcp native stack */
+		sent = xsend(c1, buf, sizeof(buf), 0);
+		if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c1), native"))
+			goto end;
+
+		recvd = recv(p1, rcv, sizeof(rcv), MSG_DONTWAIT);
+		if (!ASSERT_EQ(recvd, sent, "recv_timeout(p1), native"))
+			goto end;
+
+		/* p0 previously redirected skb to p1, we also check copied_seq of p0 */
+		sent = xsend(c0, buf, sizeof(buf), 0);
+		if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c0), native"))
+			goto end;
+
+		recvd = recv(p0, rcv, sizeof(rcv), MSG_DONTWAIT);
+		if (!ASSERT_EQ(recvd, sent, "recv_timeout(p0), native"))
+			goto end;
+	}
+
+end:
+	if (c0 >= 0)
+		close(c0);
+	if (p0 >= 0)
+		close(p0);
+	if (c1 >= 0)
+		close(c1);
+	if (p1 >= 0)
+		close(p1);
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1108,4 +1292,10 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_vsock_poll();
 	if (test__start_subtest("sockmap vsock unconnected"))
 		test_sockmap_vsock_unconnected();
+	if (test__start_subtest("sockmap with zc"))
+		test_sockmap_zc();
+	if (test__start_subtest("sockmap recover"))
+		test_sockmap_copied_seq(false);
+	if (test__start_subtest("sockmap recover with strp"))
+		test_sockmap_copied_seq(true);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
index 69aacc96db36..ef9edca184ea 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
@@ -44,4 +44,18 @@ int prog_skb_parser(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+SEC("sk_skb/stream_verdict")
+int prog_skb_verdict_ingress(struct __sk_buff *skb)
+{
+	int one = 1;
+
+	return bpf_sk_redirect_map(skb, &sock_map_rx, one, BPF_F_INGRESS);
+}
+
+SEC("sk_skb/stream_parser")
+int prog_skb_verdict_ingress_strp(struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


