Return-Path: <linux-kselftest+bounces-17584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14127973985
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A99E1F26BCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F7198A07;
	Tue, 10 Sep 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS2b/pyC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF36188CBB;
	Tue, 10 Sep 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977611; cv=none; b=Gc65cN+VaFMLTpXVhZBsWjtmoqraJ/FrBYNAEpDqJHavqcUXc+uHUA6T20ZY25SlHnaLfC68RCa+Rdd6OaDv+krOCevlxyUkAC9+wFbyOnwpOkhW6Lpu26nJ6VGUaaXm6Kt+fBBI97fKLDm0ynw4qpmWJLShKWnPT9JZnEoiUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977611; c=relaxed/simple;
	bh=Iv5TZEml/H6t7GaDZCEGZTMq7nkqIaIE/iw0KKiXtKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piWq95QVZwdGkHmyUbaiIHgWkTdkxpHeoyKIajrfO/LAjEY7uSAb/g7RO78OMExR4gvjdRYfhVpkANbVbDX3sdCIdS6MaAr2P2lYGEZw3qpLZ+VonC4Ek2L4fP57wUSoez84xyyJA6cqiu7fIXnNpbAbAEE5HrjWNe2vlgyyDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS2b/pyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C9FC4CED2;
	Tue, 10 Sep 2024 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977611;
	bh=Iv5TZEml/H6t7GaDZCEGZTMq7nkqIaIE/iw0KKiXtKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jS2b/pyCzUcgYPyHpg3WdNpOIRrXKr+rtT1OJwtziK8/h68Cg2PQu2NEgF8JNEnY+
	 ++jhom7vQSGIaLiA6EpIqG7tIT1n6hBD4I475KErWBLV39p10M1Lnfq10rkS70+R4m
	 q/UDlRVWUItQeAoCzmvbYZghyFeOxHNmqzkVcRlxt3ckvr24wKOIkPMFZGIRtoI6kp
	 k3EI7UEkGVzpOEGZfvVxEsvw4LGNG5+VmlJ3IHZIRo8S104yIhifqQavKTgoCrzMOn
	 IbJYOU1daXp7ZTYDx2EpEkf4cgQp+8uBfMoCgseg5/ePqnGOrdTwiHEL9WQQfhi29I
	 8xD92KaUQ1iuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 16:13:00 +0200
Subject: [PATCH bpf-next/net v5 2/3] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-upstream-bpf-next-20240506-mptcp-subflow-test-v5-2-2c664a7da47c@kernel.org>
References: <20240910-upstream-bpf-next-20240506-mptcp-subflow-test-v5-0-2c664a7da47c@kernel.org>
In-Reply-To: <20240910-upstream-bpf-next-20240506-mptcp-subflow-test-v5-0-2c664a7da47c@kernel.org>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6005; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FDhxqzjJz67+rEBh+dkc4FV5Kx80WdtuXY//a+1arxA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4FP6PWb5L7K5OOzY7au9d3x/3Hvk2v60gTqqY
 Bv9MPDaWBeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuBT+gAKCRD2t4JPQmmg
 czZVD/9qboRpOedgzfsOTqY1wEOI8cgvLCZiKvxXfdhlDVNstUtgNLU7dXTB7J4g+at6SnS1xGz
 8m36NXSobVs1bQRhlZX6tyWF6ng8x+LQQWvzOzOq9LMY2P7QCny5aTMdJzjdJX3L5aDVSowGe6/
 Lrs8BVyqLX62rkiouMLxCSX3RIkxNykQ0h4y1Rne+RS0JYUuKZl2wnzUi0DxK4KuuNqpkSYYD/S
 OW2rBrvecA85G/yMG2eWlrgGWknze0MlPcbG+WXwmKFBFPIjMdD6PRZ0cWCE6l+97mx6hkjhCfF
 rBU5ZOqNUxs3CJKO+5J7hp1mmScwMnCsnHnbHK7PGBYksfzjS94pszRX6K1U7AlyZDLTUNhpY4v
 B4ovQKcr9zAseXa+lFLLh7peTlfFqbCf+kq6qDUCCKJl8wJWOUlJ28miU6j+iXJCe/bohOTDU7e
 DZk4SbsFS1I4o359JJV3Avz7kj/ziWV/fBdF/M++bxR45auCHDkmAVpl63a/9zCiOKDLN7Ul0Hv
 ZGswauwSTyJaTG7/UJ1pWe4cMVrNXfjiqs89vG3hdwbQpA17MtV8tkmOUKC3rq8Blw9Hs7iWDod
 omawYdkU73hAc64BQ2FlCxvagm8pvpRz+Hd8hq533K1zDBekUxqhLIUEP1bdsCHFCGv6DTUrYvn
 mR2TS+LJkcn9Jrw==
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
list_for_each_entry() uses 'cond_break' to limit the number of
iterations, and ease its use. Because only data need to be read here,
it is enough to use this technique. It is planned to use bpf_iter, when
BPF programs will be used to modify data from the different subflows.
mptcp_subflow_tcp_sock() and mptcp_for_each_stubflow() helpers have also
be imported.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v5: new patch, instead of using 'ss' in the following patch
---
 MAINTAINERS                                       |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h     | 42 ++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 69 +++++++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30a9b9450e11..2674b86209d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16058,7 +16058,7 @@ F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
-F:	tools/testing/selftests/bpf/*/*mptcp*.c
+F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
new file mode 100644
index 000000000000..179b74c1205f
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
+/* small difference: 'cond_break' has been added in the conditions */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	     cond_break, !list_entry_is_head(pos, head, member);	\
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
index 2e28f4a215b5..70302477e326 100644
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


