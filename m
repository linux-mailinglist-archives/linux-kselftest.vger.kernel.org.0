Return-Path: <linux-kselftest+bounces-18409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F698785A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D02C28A8AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B92E170A07;
	Thu, 26 Sep 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB+cVKTw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9F2914;
	Thu, 26 Sep 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371845; cv=none; b=Vy7qWkqONYY4cvKrihoJXkRn1DZ0+vsfJG/bpjKuT1kaYCA2zeBcV2dbcdcy/yJV5KjEkHbBrSl+t0pxHvSY80g2AKJwsPaFpaQmlenNjJTP93/0Ixkz0onbTNPdF7xHPRW1MQRm6uCkpHLs0rhaG2vqXSjYjRtY5OfjJPVFDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371845; c=relaxed/simple;
	bh=lRLfi2UxFsB0Wd5r8DgWeVoWLcwTpOqLJtw/uZ5JA2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXUqHTjSW4T/l2JwYFMWzVwflGRqR/n4Ep4WPrYp8LNx8Ng/n9aOZ7X+NijVZhWiV2fzbeKFCiRVvNSx4GQNp5SNqDNWfpXlmiA3ywC27Len5tfih+s6SwHgUCzWiReMHIqRrqzV4N/bn7zpyOQVA9ZNxn3ndSduAiFbmt7kB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB+cVKTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6015C4CEC7;
	Thu, 26 Sep 2024 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371845;
	bh=lRLfi2UxFsB0Wd5r8DgWeVoWLcwTpOqLJtw/uZ5JA2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GB+cVKTw0N5j32bSDpHVsPy1HWvIht/1acmycM1/2g6KqPboNzMsqKLZYaukJxMqC
	 p3IkkQze6iR9sLJTIIK92ln4lj0hr50sF+plVdr5agFGX0c6KTFxZKsB3wrNJZ4A0n
	 l6rIFbbO76SnkGu2YFLr2Q3sLEhik5Xi+arGRvISSD9ZPkIw8iLOotrolhWZyfSExF
	 qd7dhdh9HE5dQLi2J0UugqDOUUuZUPHWL3+Rl4y/mGFigGWlplR6SIoYNOCRhHmk2E
	 /LdeBUu+f1P3ZV1k9jevCRCBd8NkCfbmGGLrVW6DPAQhfA//rkwIZaOMunwNSSPDGH
	 GHc8L+g4qA7lw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 26 Sep 2024 19:30:23 +0200
Subject: [PATCH bpf-next/net v7 2/3] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-upstream-bpf-next-20240506-mptcp-subflow-test-v7-2-d26029e15cdd@kernel.org>
References: <20240926-upstream-bpf-next-20240506-mptcp-subflow-test-v7-0-d26029e15cdd@kernel.org>
In-Reply-To: <20240926-upstream-bpf-next-20240506-mptcp-subflow-test-v7-0-d26029e15cdd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6227; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Fv2w/TMtWqopJGbiMvr/rlywhKanG9Xb8OKXkobTytI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm9Zo2Iexf+V1fyQg7RvHtHdg61oFl/N02hef32
 UGNDI7dG16JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZvWaNgAKCRD2t4JPQmmg
 c1csEAC+W1TMx8o2k8XGnBaFVSLQo/hIdOkOw699bXzt+iCwnK7vbUT8nhXks/VA0hJ48f1tKgr
 D25ETN1kJbQIbZYaEmY0Mk4Kwlbao/2vhbpMU2X13nCAuwe1PijRSN7E+rznJCpjK4QdsRG5V3j
 Z6wHvunIKNYD3D41GQuGP8dpmEfIXvOF8e2vyn+PUrLuEkb1O8qvSnE1HNgjjLZILDy2hWO1eO5
 Jv0N17EPndiVYm5Ow+jJgmISyLcMLDMWu8QwNLc9iKI9pTP23VSyqfXrUNoJYmOMb7uT04FvLrb
 r5mGBI+RWO4QURJPAujZRaJ7lU36hqn6Qp9xUsdXiiUWoeR6ARGhDqBFNXMAJVh1+XzB2IFGXPl
 ogzI/h2Iw2bUOx3IBYVTCjo2Z0MWxdXnbWTW5bDZNdz9xTkljCK4c8rETRl3Q+xnjs32MlZPce7
 0IY2DhUiXQmSaNSYJ3gvOtlfd1FBMncUYeWsxrlP80D8GAqComYL94JtiCFytH0vwih75p/rDhb
 4gCbXHWpEXli1Y//eJdY2P3UNMBQ+O3/NvDVG4vltOxeGXFNcwukGILwuAhzBD+G+vXwEzcY/lF
 KIhRCXhrEWUpsg1VcmGNvrJ/ctiXBfw66fpdmYaL/OPAEgxmbH8JQMJlkJ7sIBsB9cKGvJa3BdI
 PGNgZ1AQ/VxmBkw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "cgroup/getsockopt" way to inspect the subflows of an
MPTCP socket, and verify the modifications done by the same BPF program
in the previous commit: a different mark per subflow, and a different
TCP CC set on the second one. This new hook will be used by the next
commit to verify the socket options set on each subflow.

This extra "cgroup/getsockopt" prog walks the msk->conn_list and use
bpf_core_cast to cast a pointer for readonly. It allows to inspect all
the fields of a structure.

Note that on the kernel side, the MPTCP socket stores a list of subflows
under 'msk->conn_list'. They can be iterated using the generic 'list'
helpers. They have been imported here, with a small difference:
list_for_each_entry() uses 'can_loop' to limit the number of iterations,
and ease its use. Because only data need to be read here, it is enough
to use this technique. It is planned to use bpf_iter, when BPF programs
will be used to modify data from the different subflows.
mptcp_subflow_tcp_sock() and mptcp_for_each_stubflow() helpers have also
be imported.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v5: new patch, instead of using 'ss' in the following patch
  - v7: use 'can_loop' instead of 'cond_break'. (Martin)
---
 MAINTAINERS                                       |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h     | 42 ++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 69 +++++++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bce6cc05553dad53db5f06d36e6957061886dd0..8817aa26b2fc0ba3581576d040f5093124cc60a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16097,7 +16097,7 @@ F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
-F:	tools/testing/selftests/bpf/*/*mptcp*.c
+F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
new file mode 100644
index 0000000000000000000000000000000000000000..3b188ccdcc4041acb4f7ed38ae8ddf5a7305466a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __MPTCP_BPF_H__
+#define __MPTCP_BPF_H__
+
+#include "bpf_experimental.h"
+
+/* list helpers from include/linux/list.h */
+static inline int list_is_head(const struct list_head *list,
+			       const struct list_head *head)
+{
+	return list == head;
+}
+
+#define list_entry(ptr, type, member)					\
+	container_of(ptr, type, member)
+
+#define list_first_entry(ptr, type, member)				\
+	list_entry((ptr)->next, type, member)
+
+#define list_next_entry(pos, member)					\
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+
+#define list_entry_is_head(pos, head, member)				\
+	list_is_head(&pos->member, (head))
+
+/* small difference: 'can_loop' has been added in the conditions */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	     !list_entry_is_head(pos, head, member) && can_loop;	\
+	     pos = list_next_entry(pos, member))
+
+/* mptcp helpers from protocol.h */
+#define mptcp_for_each_subflow(__msk, __subflow)			\
+	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
+
+static __always_inline struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->tcp_sock;
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index 2e28f4a215b5469fcbc31168071887687ca34792..70302477e326eecaef6aad4ecf899aa3d6606f23 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -4,10 +4,12 @@
 
 /* vmlinux.h, bpf_helpers.h and other 'define' */
 #include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
 char cc[TCP_CA_NAME_MAX] = "reno";
+int pid;
 
 /* Associate a subflow counter to each token */
 struct {
@@ -57,3 +59,70 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 
 	return 1;
 }
+
+static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+
+		if (ssk->sk_mark != ++i) {
+			ctx->retval = -2;
+			break;
+		}
+	}
+
+	return 1;
+}
+
+static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct inet_connection_sock *icsk;
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
+
+		if (ssk->sk_mark == 2 &&
+		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX)) {
+			ctx->retval = -2;
+			break;
+		}
+	}
+
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int _getsockopt_subflow(struct bpf_sockopt *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	struct mptcp_sock *msk;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP ||
+	    (!(ctx->level == SOL_SOCKET && ctx->optname == SO_MARK) &&
+	     !(ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)))
+		return 1;
+
+	msk = bpf_core_cast(sk, struct mptcp_sock);
+	if (msk->pm.subflows != 1) {
+		ctx->retval = -1;
+		return 1;
+	}
+
+	if (ctx->optname == SO_MARK)
+		return _check_getsockopt_subflow_mark(msk, ctx);
+	return _check_getsockopt_subflow_cc(msk, ctx);
+}

-- 
2.45.2


