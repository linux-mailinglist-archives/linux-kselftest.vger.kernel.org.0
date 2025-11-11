Return-Path: <linux-kselftest+bounces-45285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A221C4B98E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 07:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0EE3B7AE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 06:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DE92BE636;
	Tue, 11 Nov 2025 06:03:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF629C35A;
	Tue, 11 Nov 2025 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841004; cv=none; b=DCc4vDcK4IjNZOG7dHwAFcYYG78AdmyTpu2gwb1oeTL4h5NJcnqyXl7V8f7PhTmOWVxc1QqRvSn2lfOJqGDCjoVNykVt5XcSpnv6uGV3NZIAspzzGu8aCPs4mlr6fFECeH8Y08uOyT9MAW+WEx86A66eR1ro6VtjjdzczI7Pfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841004; c=relaxed/simple;
	bh=vPHEcWLE1UUmmbuODP6DCPDzUzqHFuJFDlXtOGMvYt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9JQVAFQ2QB91rz00WhcHbqzQ87hKHISao3f4JWxGDa6R8+QUNxIM7Qh/Z6LzMtPGmLe/CiHuO8OoNFeepGCUyvdFcrAoMuAJfqcDT1vd2aVgyWfH4ECsE4Mx7drubwU9aKF2kBBhMxdiIjABU8DJ1UrY5pND56tnCMVXYcuXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 284958B2A0E; Tue, 11 Nov 2025 14:03:21 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Christoph Paasch <cpaasch@apple.com>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v5 3/3] selftests/bpf: Add mptcp test with sockmap
Date: Tue, 11 Nov 2025 14:02:52 +0800
Message-ID: <20251111060307.194196-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111060307.194196-1-jiayuan.chen@linux.dev>
References: <20251111060307.194196-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases to verify that when MPTCP falls back to plain TCP sockets,
they can properly work with sockmap.

Additionally, add test cases to ensure that sockmap correctly rejects
MPTCP sockets as expected.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 141 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_sockmap.c       |  43 ++++++
 2 files changed, 184 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f8eb7f9d4fd2..b976fe626343 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,11 +6,14 @@
 #include <netinet/in.h>
 #include <test_progs.h>
 #include <unistd.h>
+#include <error.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "socket_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_sockmap.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -436,6 +439,142 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+/* Test sockmap on MPTCP server handling non-mp-capable clients. */
+static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
+{
+	int listen_fd = -1, client_fd1 = -1, client_fd2 = -1;
+	int server_fd1 = -1, server_fd2 = -1, sent, recvd;
+	char snd[9] = "123456789";
+	char rcv[10];
+
+	/* start server with MPTCP enabled */
+	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
+	if (!ASSERT_OK_FD(listen_fd, "sockmap-fb:start_mptcp_server"))
+		return;
+
+	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
+	skel->bss->sk_index = 0;
+	/* create client without MPTCP enabled */
+	client_fd1 = connect_to_fd_opts(listen_fd, NULL);
+	if (!ASSERT_OK_FD(client_fd1, "sockmap-fb:connect_to_fd"))
+		goto end;
+
+	server_fd1 = xaccept_nonblock(listen_fd, NULL, NULL);
+	skel->bss->sk_index = 1;
+	client_fd2 = connect_to_fd_opts(listen_fd, NULL);
+	if (!ASSERT_OK_FD(client_fd2, "sockmap-fb:connect_to_fd"))
+		goto end;
+
+	server_fd2 = xaccept_nonblock(listen_fd, NULL, NULL);
+	/* test normal redirect behavior: data sent by client_fd1 can be
+	 * received by client_fd2
+	 */
+	skel->bss->redirect_idx = 1;
+	sent = xsend(client_fd1, snd, sizeof(snd), 0);
+	if (!ASSERT_EQ(sent, sizeof(snd), "sockmap-fb:xsend(client_fd1)"))
+		goto end;
+
+	/* try to recv more bytes to avoid truncation check */
+	recvd = recv_timeout(client_fd2, rcv, sizeof(rcv), MSG_DONTWAIT, 2);
+	if (!ASSERT_EQ(recvd, sizeof(snd), "sockmap-fb:recv(client_fd2)"))
+		goto end;
+
+end:
+	if (client_fd1 >= 0)
+		close(client_fd1);
+	if (client_fd2 >= 0)
+		close(client_fd2);
+	if (server_fd1 >= 0)
+		close(server_fd1);
+	if (server_fd2 >= 0)
+		close(server_fd2);
+	close(listen_fd);
+}
+
+/* Test sockmap rejection of MPTCP sockets - both server and client sides. */
+static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
+{
+	int listen_fd = -1, server_fd = -1, client_fd1 = -1;
+	int err, zero = 0;
+
+	/* start server with MPTCP enabled */
+	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
+	if (!ASSERT_OK_FD(listen_fd, "start_mptcp_server"))
+		return;
+
+	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
+	skel->bss->sk_index = 0;
+	/* create client with MPTCP enabled */
+	client_fd1 = connect_to_fd(listen_fd, 0);
+	if (!ASSERT_OK_FD(client_fd1, "connect_to_fd client_fd1"))
+		goto end;
+
+	/* bpf_sock_map_update() called from sockops should reject MPTCP sk */
+	if (!ASSERT_EQ(skel->bss->helper_ret, -EOPNOTSUPP, "should reject"))
+		goto end;
+
+	server_fd = xaccept_nonblock(listen_fd, NULL, NULL);
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
+				  &zero, &server_fd, BPF_NOEXIST);
+	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
+		goto end;
+
+	/* MPTCP client should also be disallowed */
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
+				  &zero, &client_fd1, BPF_NOEXIST);
+	if (!ASSERT_EQ(err, -EOPNOTSUPP, "client should be disallowed"))
+		goto end;
+end:
+	if (client_fd1 >= 0)
+		close(client_fd1);
+	if (server_fd >= 0)
+		close(server_fd);
+	close(listen_fd);
+}
+
+static void test_mptcp_sockmap(void)
+{
+	struct mptcp_sockmap *skel;
+	struct netns_obj *netns;
+	int cgroup_fd, err;
+
+	cgroup_fd = test__join_cgroup("/mptcp_sockmap");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_sockmap"))
+		return;
+
+	skel = mptcp_sockmap__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_sockmap"))
+		goto close_cgroup;
+
+	skel->links.mptcp_sockmap_inject =
+		bpf_program__attach_cgroup(skel->progs.mptcp_sockmap_inject, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.mptcp_sockmap_inject, "attach sockmap"))
+		goto skel_destroy;
+
+	err = bpf_prog_attach(bpf_program__fd(skel->progs.mptcp_sockmap_redirect),
+			      bpf_map__fd(skel->maps.sock_map),
+			      BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
+		goto skel_destroy;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new: mptcp_sockmap"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow") < 0)
+		goto close_netns;
+
+	test_sockmap_with_mptcp_fallback(skel);
+	test_sockmap_reject_mptcp(skel);
+
+close_netns:
+	netns_free(netns);
+skel_destroy:
+	mptcp_sockmap__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -444,4 +583,6 @@ void test_mptcp(void)
 		test_mptcpify();
 	if (test__start_subtest("subflow"))
 		test_subflow();
+	if (test__start_subtest("sockmap"))
+		test_mptcp_sockmap();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sockmap.c b/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
new file mode 100644
index 000000000000..d4eef0cbadb9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bpf_tracing_net.h"
+
+char _license[] SEC("license") = "GPL";
+
+int sk_index;
+int redirect_idx;
+int trace_port;
+int helper_ret;
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 100);
+} sock_map SEC(".maps");
+
+SEC("sockops")
+int mptcp_sockmap_inject(struct bpf_sock_ops *skops)
+{
+	struct bpf_sock *sk;
+
+	/* only accept specified connection */
+	if (skops->local_port != trace_port ||
+	    skops->op != BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
+		return 1;
+
+	sk = skops->sk;
+	if (!sk)
+		return 1;
+
+	/* update sk handler */
+	helper_ret = bpf_sock_map_update(skops, &sock_map, &sk_index, BPF_NOEXIST);
+
+	return 1;
+}
+
+SEC("sk_skb/stream_verdict")
+int mptcp_sockmap_redirect(struct __sk_buff *skb)
+{
+	/* redirect skb to the sk under sock_map[redirect_idx] */
+	return bpf_sk_redirect_map(skb, &sock_map, redirect_idx, 0);
+}
-- 
2.43.0


