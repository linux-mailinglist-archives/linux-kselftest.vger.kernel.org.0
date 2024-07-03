Return-Path: <linux-kselftest+bounces-13140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9A79268B1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 20:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90164B25284
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CCD18FDC8;
	Wed,  3 Jul 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXG8rynO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7C18C334;
	Wed,  3 Jul 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033097; cv=none; b=P0myGThwqGWIVF77l6Rcv5tXdwxol1cYnC4mUuI8I0Db6/ObQnkCtVj4PsTh8c6mBhwCUyrmE1LdVQCvjGCxPl3TshcWlUawbX3672eXbCdFreOSKIwHuBQs01rblY8+uKEbbj8qDvDchPf5keQLS0yRplOsT5Rpa48SMTZOhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033097; c=relaxed/simple;
	bh=/K688bWxCbz/40YsdYV732cI2lnwaSfpa2N/5rT1qss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHCEuH64HCePinFXfTv1iUhVviYUq2I3UnkPoxTRQ9PgW7yydAraSF3hNj1xXfPi6ujD/mc+kUojoMzk6awqhNX0YRczSL/LK515tLtiybxWk8oCNXk7yQeSdMDhNClhV5koYhBXK6S+Em+Kt9wBySN5UpJn5UYBrsxkiuIy1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXG8rynO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A79C32781;
	Wed,  3 Jul 2024 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720033096;
	bh=/K688bWxCbz/40YsdYV732cI2lnwaSfpa2N/5rT1qss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JXG8rynOWSh+DrYqgIWENjw3UZEfFtMR8EF0KAE5ma3DW7YcSecykSJnAgxw3Vy/i
	 Rn5XEigv2uTLLUyoRzMB7F3Ilm7KiwfrB0zfDVlZ7edWdYSLrV3M05577+KlXE3uAq
	 EEyslQxj/cB0w8mDWcWn5J9tmD6u/3ZGhQwKUSxym5D/rpL+Qfp+1MkjAkDBqXiVSp
	 3AlgxS+T6sZKw7nKM5R/WF9GXy0EhWpVzq1NZnen0xwKd1mAtqqf5lYbrmEo4g8HN+
	 4ApDffWR3jjmVhvFjqaeBAm46MrFSjAphT0RVq5sXb8gBACUXN1/7ftVhScN5g/s6X
	 gR6YguqUzWMCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 03 Jul 2024 20:57:32 +0200
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: Add mptcp subflow example
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-1-ebdc2d494049@kernel.org>
References: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
In-Reply-To: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4209; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8LIsOEqtSsrfu9qHTzMNH2/0Gf2ZWWs2EYf0FocaPOw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmhZ89Q6kfMhdSjZgckDauEayNuZlLBUTR5OMKn
 3G41v+djRCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZoWfPQAKCRD2t4JPQmmg
 c6TmEADVpcXozHm0MhH2Hjag6HNPAdCL+QiRGhnemlX29T4SNnopT2kLseEZmJMxq8j00pSNlP6
 SkTUbX/P8Balfkn21N/zieosRK6nAO47MgvO4hFaRHiU+yE+0OCubk1+dH6e5+6K173C02IijIS
 Dfq6HZqdO2X8n+kPftAnvbbDMMYzTcXh384zZ5NATTtcA/Gg/smF1gBf729toROtNGJE5NS15jg
 PgFfck8U7iXVK3TIJhmAoTstB/qefaOeEaHOg5j3cy2qGZlCPffyQhjy3m/OCPFjd8cRWE9/QTU
 8Dhw85n56bIIiWkDrAb6WPCk2uxYvAl3+GHGDVv+iLsotqqt4gLvR7j53Zv8D+6fB4LdU+JURiy
 O8bqXyq8Ws7Xaf2rqZ1n+lHRc2ABP0Pgs5jwBm+gBSAXICoKIPE7DKEXAnQwicI8/byl5xgfZlP
 hib2Cvi7T557mQXZEi8c3o1fiidi2Re/CTPrltfgr+9FoWSquhI+ShCCxOlYDNpU6IoZ1jx6dDU
 Ai2lB4TfMy6W0viXM0gtGphM6RiewFwgUIqjvW7bCpTsJTqDy7h0YaLJyVuoO1fcIbPwtJqiM29
 DzOPu9My74yztw02E9q5OmpqHSnpDl0839LY86ZHr0UINkG2DkJNPEyJeK3gNkaLxYMRDNXpG9m
 Xlxu7HJ7odxkOQQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Nicolas Rybowski <nicolas.rybowski@tessares.net>

Move Nicolas' patch into bpf selftests directory. This example adds a
different mark (SO_MARK) on each subflow, and changes the TCP CC only on
the first subflow.

From the userspace, an application can do a setsockopt() on an MPTCP
socket, and typically the same value will be propagated to all subflows
(paths). If someone wants to have different values per subflow, the
recommended way is to use BPF. So it is good to add such example here,
and make sure there is no regressions.

This example shows how it is possible to:

    Identify the parent msk of an MPTCP subflow.
    Put different sockopt for each subflow of a same MPTCP connection.

Here especially, two different behaviours are implemented:

    A socket mark (SOL_SOCKET SO_MARK) is put on each subflow of a same
    MPTCP connection. The order of creation of the current subflow defines
    its mark. The TCP CC algorithm of the very first subflow of an MPTCP
    connection is set to "reno".

This is just to show it is possible to identify an MPTCP connection, and
set socket options, from different SOL levels, per subflow. "reno" has
been picked because it is built-in and usually not set as default one.
It is easy to verify with 'ss' that these modifications have been
applied correctly. That's what the next patch is going to do.

Nicolas' code comes from:

    commit 4d120186e4d6 ("bpf:examples: update mptcp_set_mark_kern.c")

from the MPTCP repo https://github.com/multipath-tcp/mptcp_net-next (the
"scripts" branch), and it has been adapted by Geliang.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v1 -> v2:
   - The commit message has been updated: why setting multiple socket
     options, why reno, the verification is done in a later patch
     (different author). (Alexei)
 - v2 -> v3:
   - Only #include "bpf_tracing_net.h", linked to:
     https://lore.kernel.org/20240509175026.3423614-1-martin.lau@linux.dev
---
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 59 +++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
new file mode 100644
index 000000000000..bc572e1d6df8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+
+char _license[] SEC("license") = "GPL";
+
+char cc[TCP_CA_NAME_MAX] = "reno";
+
+/* Associate a subflow counter to each token */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 100);
+} mptcp_sf SEC(".maps");
+
+SEC("sockops")
+int mptcp_subflow(struct bpf_sock_ops *skops)
+{
+	__u32 init = 1, key, mark, *cnt;
+	struct mptcp_sock *msk;
+	struct bpf_sock *sk;
+	int err;
+
+	if (skops->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return 1;
+
+	sk = skops->sk;
+	if (!sk)
+		return 1;
+
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (!msk)
+		return 1;
+
+	key = msk->token;
+	cnt = bpf_map_lookup_elem(&mptcp_sf, &key);
+	if (cnt) {
+		/* A new subflow is added to an existing MPTCP connection */
+		__sync_fetch_and_add(cnt, 1);
+		mark = *cnt;
+	} else {
+		/* A new MPTCP connection is just initiated and this is its primary subflow */
+		bpf_map_update_elem(&mptcp_sf, &key, &init, BPF_ANY);
+		mark = init;
+	}
+
+	/* Set the mark of the subflow's socket based on appearance order */
+	err = bpf_setsockopt(skops, SOL_SOCKET, SO_MARK, &mark, sizeof(mark));
+	if (err < 0)
+		return 1;
+	if (mark == 1)
+		err = bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
+
+	return 1;
+}

-- 
2.45.2


