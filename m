Return-Path: <linux-kselftest+bounces-17583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C11B973981
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF42281284
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91769195FE8;
	Tue, 10 Sep 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgBirhhN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBEC188CBB;
	Tue, 10 Sep 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977606; cv=none; b=I4th1KCfX1HRVs5fxZXI6qlOa3A468ELfuBYQDCSgiQrA9OAM/+O3EoSK14KN4VEsiQo3qKCvkXyz1CSb/j1/viEzStNkFw6GYP5/hTogsjcpGWfXQsimjBHcEH0d00YeybCcQ03EENhuL4zh/YkfonzeUzG/SChlQyED4v8eKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977606; c=relaxed/simple;
	bh=hWl57FHY2fOdoggMMQbYWWGMnt4b33OvRJbD5uuAWPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUiXSMUPt8XidyV3mn+ZAdRdRwTbI0s3fPhjgzDhA16monBb3Nb2ccvtxijPwxaeg5lmI7pAQjadW2D2SAh2/HTE99KQfby8hqCWT1muLTNjGy9f26RVXafFkPnBjtVAhXY/KrD/8ctFyMMyts7Ph9ihfaldI4d8oif/Dgjy6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgBirhhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDB9C4CED1;
	Tue, 10 Sep 2024 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977606;
	bh=hWl57FHY2fOdoggMMQbYWWGMnt4b33OvRJbD5uuAWPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IgBirhhNDnr0wa9pmkekuaGVxwMzodpWsGehEC9qffQv+Ps/3zJJlN40itLpzyDLb
	 p1JTUlbNtPqYCi+I82F6fty5FKOihR0LuBCdcgdNuJFKJYDQguUnN8RzxR3PpSEIGH
	 JT9VAQuYmDQbxHOLLA8HArKaJ77fIIG2WIq7IUgrZhbXyVBwkhIpKfJ0k8qjY5iXtJ
	 4tmaVXOtEcMRXuy2ZlAjlRz3NkQHE6is5INMjgLFEGSAxepoHAP7MFaNM1+zf82Bat
	 lFA8m7lBSHU0ULoK8OvmXHUHHhJGJlqWLv4iHLSAYjy1iNGk10gRRMmkfYAMn/2UOo
	 zTAVDFKyv7jBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 16:12:59 +0200
Subject: [PATCH bpf-next/net v5 1/3] selftests/bpf: Add mptcp subflow
 example
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-upstream-bpf-next-20240506-mptcp-subflow-test-v5-1-2c664a7da47c@kernel.org>
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
 Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4445; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=98MxbfTkgjSKHUOjjCbtRcgcjpjaNf9HbvOObpvAYhI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4FP6OAgCr/76qaOirF0W9fH+xWuZwyjL1P1Di
 kaSlJekI1mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuBT+gAKCRD2t4JPQmmg
 c/YyEAC4I+ya+HE9RLuO9qLM8XrXnxmGObKEYeJJdZXW7utQnr784IXI//tGO6gyOXEBUfAcmOa
 bkohR1J7mrIMLfiAG30A4ZV0tQSFWXV3ruHZInBxkKula3Vm3wuRvIoqr2UZufVBBKBuBtEvTrR
 XAmvPRZiML4/zPg45m2P0DfAuHKKEwxd3hLoqTu9ahzYAQEqDsPvVdFCwjAxZTum1060WnhpGzf
 hjEJvK/1xI0iyvkf54OUQc8O2sHfXkSYrU8zNYBx+UhyTj3/c6wdkZevkeFGi02dvJdYQ5J+Km8
 MPar6jDk+Hz1Z56Ggz8gHuDelQQ0BWmm6XJP9zgj6B0zl8DZZqVNjGrMvH2Xflw8XrRXo2a+P5u
 sNZKxK43Y5nw7vQmHzJ5ehcRA5pfbKV84MH9wVddgzUaLYYS0sE9KD5pmjdYRHDpX9J+oZCiLYh
 03uD0h0PIOiBrX9YO0oVRxC7Dr2IxbSz+N5Vs0C652f8ya23LUfxbYvWzagxdios7bg+i7nEcT4
 +qtu0Utwq2Ns/ccOakO087fUYvOjkdc+foCBbsQR0YBa8/F5BEeXZE9oVO2n9axEFDo5CCQsFfK
 Wf4Vt4862yfZ1u1rmLDf8yOHTyi4T1fjuSr/ihqgbttlj/fwW/j64ZKp/jjB+fjN22a53r7OjhJ
 ZnF1I0cLKPYRi+A==
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
 - v4 -> v5:
   - Set reno as TCP cc on the second subflow, not to influence the
     getsockopt() done from the userspace, which will return the one
     from the first subflow, the default TCP cc then, not the modified
     one.
---
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 59 +++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
new file mode 100644
index 000000000000..2e28f4a215b5
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
+	if (mark == 2)
+		err = bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
+
+	return 1;
+}

-- 
2.45.2


