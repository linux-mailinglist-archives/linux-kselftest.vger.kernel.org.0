Return-Path: <linux-kselftest+bounces-23599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0A9F7E7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B613168492
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1322968E;
	Thu, 19 Dec 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1Z3fvyE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFA226878;
	Thu, 19 Dec 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623451; cv=none; b=ZmpD13G7Q99EQiMNOdnKgjixchVqUeUJ9vqvzQkkQOoxTS88yr8PpYgjUj9WQ2n1+I6b2Wwkr4jhoza/6CHptdT9awYo4aDbwgIp0dicKzCCxmLGTlXWGoM1B0t3Q0Hsu/Zr0g75cL/ts+pvljKyFc3PYFRsdD4LzXNF3H5vxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623451; c=relaxed/simple;
	bh=yOr4YVcrLbV+j2DBB+pvmmyHN5Y3wzr/J7XUepFTf/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V54BbqZHHEUmwrU2kyO2/Tc44rb7rwfAXtD19tmMRBUqTbPbTOkd3ZpdllDpJ/HcASi36Axvg1hnnzMGkqN7WFGc4QsHe5tMmNkE3M03IQb0R4fMVLtE7R3eb3u+pqZ/AIStDCF53MCpaSJrcpY904vF0pLcN4vG9Sl/Pz8pVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1Z3fvyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025FC4CED7;
	Thu, 19 Dec 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623451;
	bh=yOr4YVcrLbV+j2DBB+pvmmyHN5Y3wzr/J7XUepFTf/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W1Z3fvyEOnOk96rrWoGzGnO4TNKEJ0JBdXkThEPz2AsVK4XDhoh6PXxtryifjRK31
	 VIQbhnLoErkNMZz3qqg+6Akl2oKdteEc+fm71+/1z7LT0f4hr9C7l1ovemGNvR3Eah
	 f7BuhKGxLg9yLXlIy0qJjw/P/doDoCCFCbeQkjSjfT1stkZSTohMysmiPXZbuuC/R6
	 1/yb4aZXfBQ2OHVsPBaRA4wGR4SBBExQhbm0Ndo806Y6axwSfSA0t8Gf4gt/gIgoWF
	 CE4mIGwjwtEP1Tg6h+vP9UiT0IWESsIP2ocKwVh4S0xRayuOB97RiqZcactwgVxpv5
	 axjwmLXVIBPew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 16:46:46 +0100
Subject: [PATCH bpf-next/net v2 7/7] selftests/bpf: Add mptcp_subflow
 bpf_iter subtest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-7-ae244d3cdbbc@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9284; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bq/oYTxQQ+2A/IA41fcrwu1uM6Uk6qmTeqE376zM200=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZECu1e8GkpdmZGYvyXzQArL8DlgcE6mHZlmKN
 MxIeil0/kqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2RArgAKCRD2t4JPQmmg
 c+pxD/9ny3wXWFBPZiEJWambXs+hb29ypQ+IXpG/grTa8P9tb0zcqmoLG+J7MiQsyKr1keCbF6J
 DW1420z/XcviOZhtdJ0S2qN/pGU5D+4XS0j53v51suQMqt0b2o+uil8EAew6VmapyfPh2lOZCKv
 wmczAakHIzg9N5Wh12UINOCCcmrBdvaVxW0E9kJSQ+f0+7yE86BYSs8nDluDafKUZ0OtXQTUSyn
 O6zYvvEpV9frKPvL0uncm2rzV63C3Ix+YsGCMhGBxF+V3uo5QE7fTCATtIko0ECIql/+yXehE4c
 u0/Jz/iUw3YxRCRm1irHhilZMBAKj9zc4lhd0kmKREuaFhCDISGJvBfVZpqPW20KY63WcbV25vu
 REchtTCbZo1Te57y3JgSYQTWRal/2Jhxmg+y2lqXbzM539nuOxrFlBxOvf61ggqNi35GZ5A77AH
 ysWC7oOiDVyhAVrI9BqCa29l+DbvYhrDUKGlk9Jcs7Pf1TG0ScduX9RWXIXBtCwHEA750ibH2kO
 X7/jycj7u/KertC7E5Vyz5rD69QApSIMAMF41q4XGpfiaVabDKZuJzRMzcLyam4SkhLPtf9SZn9
 FABm+JPXUKDyj1O35rnqG1OI7v2F1g2E8t71fGmF+hwsW/rsAY1gSQbd9iE8qA5jtofZ3OwbiYy
 8FKJS1CTZbpe/2g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "cgroup/getsockopt" program "iters_subflow" to test the
newly added mptcp_subflow bpf_iter.

Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy,
bpf_mptcp_sock_acquire/_release and other helpers into bpf_experimental.h.

Use bpf_mptcp_sock_acquire() to acquire the msk, then use bpf_for_each()
to walk the subflow list of this msk. From there, future MPTCP-specific
kfunc can be called in the loop. Because they are not there yet, this
test doesn't do anything very useful for the moment, but it focuses on
validating the 'bpf_iter' part and the basic MPTCP kfunc. That's why it
simply adds all subflow ids to local variable local_ids to make sure all
subflows have been seen, then invoke mptcp_subflow_tcp_sock() in the
loop to pick the subflow context.

Out of the loop, use bpf_mptcp_subflow_ctx() to get the subflow context
of the picked subflow context and do some verifications. Finally, assign
local_ids to global variable ids so that the application can obtain this
value, and release the msk.

A related subtest called test_iters_subflow is added to load and verify
the newly added mptcp_subflow type bpf_iter example in test_mptcp. The
endpoint_init() helper is used to add 3 new subflow endpoints. Then one
byte of message is sent to trigger the creation of new subflows.
getsockopt() is invoked once the subflows have been created to trigger
the "cgroup/getsockopt" test program "iters_subflow". skel->bss->ids is
then checked to make sure it equals 10, the sum of each subflow ID: we
should have 4 subflows: 1 + 2 + 3 + 4 = 10. If that's the case, the
bpf_iter loop did the job as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2:
   - explicit sk protocol checks are no longer needed, implicitly done
     in bpf_skc_to_mptcp_sock().
   - use bpf_skc_to_mptcp_sock() instead of bpf_mptcp_sk(), and
     mptcp_subflow_tcp_sock() instead of bpf_mptcp_subflow_tcp_sock().
   - bpf_mptcp_subflow_ctx() can now return NULL.
---
 tools/testing/selftests/bpf/bpf_experimental.h     |  8 +++
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 73 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h      |  9 +++
 .../testing/selftests/bpf/progs/mptcp_bpf_iters.c  | 63 +++++++++++++++++++
 4 files changed, 153 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index cd8ecd39c3f3c68d40c6e3e1465b42ed66537027..2ab3f0063c0fd6091ee19da4787671b89b5661f0 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -575,6 +575,14 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+struct bpf_iter_mptcp_subflow;
+extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+				      struct mptcp_sock *msk) __weak __ksym;
+extern struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
+extern void
+bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
+
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 85f3d4119802a85c86cde7b74a0b857252bad8b8..f37574b5ef68d8f32f8002df317869dfdf1d4b2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_iters.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -33,6 +34,9 @@
 #ifndef MPTCP_INFO
 #define MPTCP_INFO		1
 #endif
+#ifndef TCP_IS_MPTCP
+#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+#endif
 #ifndef MPTCP_INFO_FLAG_FALLBACK
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #endif
@@ -480,6 +484,73 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+static void run_iters_subflow(void)
+{
+	int server_fd, client_fd;
+	int is_mptcp, err;
+	socklen_t len;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	send_byte(client_fd);
+	wait_for_new_subflows(client_fd);
+
+	len = sizeof(is_mptcp);
+	/* mainly to trigger the BPF program */
+	err = getsockopt(client_fd, SOL_TCP, TCP_IS_MPTCP, &is_mptcp, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_IS_MPTCP)"))
+		ASSERT_EQ(is_mptcp, 1, "is_mptcp");
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_iters_subflow(void)
+{
+	struct mptcp_bpf_iters *skel;
+	struct netns_obj *netns;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/iters_subflow");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_subflow"))
+		return;
+
+	skel = mptcp_bpf_iters__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_subflow"))
+		goto close_cgroup;
+
+	skel->links.iters_subflow = bpf_program__attach_cgroup(skel->progs.iters_subflow,
+							       cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.iters_subflow, "attach getsockopt"))
+		goto skel_destroy;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new: iters_subflow"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow", 4) < 0)
+		goto close_netns;
+
+	run_iters_subflow();
+
+	/* 1 + 2 + 3 + 4 = 10 */
+	ASSERT_EQ(skel->bss->ids, 10, "subflow ids");
+
+close_netns:
+	netns_free(netns);
+skel_destroy:
+	mptcp_bpf_iters__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -488,4 +559,6 @@ void test_mptcp(void)
 		test_mptcpify();
 	if (test__start_subtest("subflow"))
 		test_subflow();
+	if (test__start_subtest("iters_subflow"))
+		test_iters_subflow();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 3b188ccdcc4041acb4f7ed38ae8ddf5a7305466a..31d7ecdc4c0489c63d28a25778f91093a6a093a5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -39,4 +39,13 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 	return subflow->tcp_sock;
 }
 
+/* ksym */
+extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
+
+extern struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
+extern struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
new file mode 100644
index 0000000000000000000000000000000000000000..fd5691a4073b22c24d3fa6f7ed6edb32d366492c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+int ids;
+
+#ifndef TCP_IS_MPTCP
+#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+#endif
+
+SEC("cgroup/getsockopt")
+int iters_subflow(struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	struct bpf_sock *sk = ctx->sk;
+	struct sock *ssk = NULL;
+	struct mptcp_sock *msk;
+	int local_ids = 0;
+
+	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
+		return 1;
+
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (!msk || msk->pm.server_side || !msk->pm.subflows)
+		return 1;
+
+	msk = bpf_mptcp_sock_acquire(msk);
+	if (!msk)
+		return 1;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		/* Here MPTCP-specific packet scheduler kfunc can be called:
+		 * this test is not doing anything really useful, only to
+		 * verify the iteration works.
+		 */
+
+		local_ids += subflow->subflow_id;
+
+		/* only to check the following kfunc works */
+		ssk = mptcp_subflow_tcp_sock(subflow);
+	}
+
+	if (!ssk)
+		goto out;
+
+	/* assert: if not OK, something wrong on the kernel side */
+	if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
+		goto out;
+
+	/* only to check the following kfunc works */
+	subflow = bpf_mptcp_subflow_ctx(ssk);
+	if (!subflow || subflow->token != msk->token)
+		goto out;
+
+	ids = local_ids;
+
+out:
+	bpf_mptcp_sock_release(msk);
+	return 1;
+}

-- 
2.47.1


