Return-Path: <linux-kselftest+bounces-14789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3B9478BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 11:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B181C20DD0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CE01547F1;
	Mon,  5 Aug 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRBDtTKL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9310953;
	Mon,  5 Aug 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851614; cv=none; b=siH9HmTlUik4K+uQWCygXnoEE53EmvM+EPCC5tPODTwr5lsi4xWIP7nSKp3Qm8Nuqq1zZkdaE0lzNjnSIrMs0/K4CC8gFDH6IjF9z57z5FsZ1D8iBSuvgfHFV1xRlJ9uu7qG2kMqXu6GmnecQJBnzwrK31jmJkoVbIs3Q+wxK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851614; c=relaxed/simple;
	bh=/K688bWxCbz/40YsdYV732cI2lnwaSfpa2N/5rT1qss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Thz3jKah83cFBqwT8NBqyoX8OoS8qS+f16jqNGZkb1vxLlJ2JBVRMgJXlfzzF39yWilGU50bQ/TjjIwBuFv69pRPE6LlR04b50Bxe++I9JjBfOjsP4FRo+cNnMoqFZs/rnlidUTZvn+L7xJPE0MqQSfJpZQo7cI4fyDxmk6iHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRBDtTKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBE5C4AF0F;
	Mon,  5 Aug 2024 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722851613;
	bh=/K688bWxCbz/40YsdYV732cI2lnwaSfpa2N/5rT1qss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eRBDtTKLG82p49x4r3rED3SMVZtc7UiqMQe5Z44HhWdodZz0eA+OEK9nEzkpgpf0z
	 YQnH7vs0vj/ch1ozFg9SRm0E2RfrZvdRXXlDY/y96tgEVQeC7feK9VOmdlPTGEU8tr
	 AKijqVjhyCanf7mQAj3XJnG8opE6V/XJyi5fJqBcRbkw/C6KxNJMUXcFYPPPA8aV8N
	 hEVuELZvMUBLw/U69mhWp3ZHwaBjL4eDdjGhLuXtK/W/rkFJoB5CtRsVxLSKnmuXEL
	 RUPZor+rBOwnK2x259C6Hj/k76PsHWO04g1n/uQcDNmGNNM+ckiOY57axKIqn/+Us8
	 Ful83wKq0X+vA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 05 Aug 2024 11:52:56 +0200
Subject: [PATCH bpf-next v4 1/2] selftests/bpf: Add mptcp subflow example
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-1-2b4ca6994993@kernel.org>
References: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
In-Reply-To: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
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
 Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4209; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8LIsOEqtSsrfu9qHTzMNH2/0Gf2ZWWs2EYf0FocaPOw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsKETYnbtnagggycrBRFfUzpqkuYKa2v26Lq5b
 uqgkE4ywpqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrChEwAKCRD2t4JPQmmg
 cyzHD/9YnNPETh1sMJ+T4Wo5R3EiEKdjsr9vv3vffuSN8zU07ShtuaWwFxWCpRzQ+h0ZJ/XyWKg
 omz5eGlqL/HXFbQX23/31RwHouZXCaarWK+JMaeTBXU7HuW96mI7yavRni4c2Kz73RvLD7+YRA+
 r8rdpRzL7w/JNWWtayRalp9/xAsTL52sTnvm+KPWS1Sw7c/2dzW7KyebOTanOy99xsnILidVBBp
 Da8v5Xdb8218qf8OfDJZrb1GQYYefFpK1pP1KkBnXYkwN7J5rZddr2LanZrxD02hm7awMVJnrrR
 P33y4JxHs5Q5qtQp06WdagHnU7OsN/bhjniD77FGccS1kYWz1F+FxmrLPkFK4zGKN+KdzJeqlov
 RN7vL4Q7Ix6OBU+tlTrkAuh1lEKJt4SujsJeIn7Xma4tZ2G729TOqGbmCGOEb/JvZlNSEIyCirS
 ao6kgtewVC0NE4myPQeOU031SjRz9OZkmfVDwdXpmkaDihGqrWXqjTfI8EgcWfkc6P4ySvK1wRA
 LVosVdhhZFltvoZs9ggFcYd/ziwL+/0jOJxLR7tr00AIHKEytzQyj9SldhJ1yrfy+zRTV55r7Qf
 FewFtrWM+qxD8vZ5K7FpmuEOOI44YJxBQWeqO6IIgIX9ElbGoBGTAY2cAyZOesEBZg4B0dMS1Lm
 PFhAxTUplZw2fCw==
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


