Return-Path: <linux-kselftest+bounces-18408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CB987856
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9203F1C23BCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B5161319;
	Thu, 26 Sep 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENdTaTaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062752914;
	Thu, 26 Sep 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371841; cv=none; b=JQg6D05PJqda9w3uuCIWb/c9F/mD5TnJNl779A9Pl1on45OAgZZs+d3lCqDS2OkIHtBChFvroLFwHwtC+AC1MLvHaesI6ignPbuPAobdcd/VZeH8aXkgr9oFHVJ2J0OQG1FWiacw3I7A/mZnNy4bym5XyAR11/fFV4+7flxpa+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371841; c=relaxed/simple;
	bh=D0SfxUVTuyTnYZC9kSremtU+kFqebil+/+UbQRnwwPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0+OYabpdnlm8qiNfvNLqYSG0v9Hy8oeyRO++2DlUvlRKRKvMZFohll643cdyRTraSpAd8zfzlhfAL0aaUM4YF810rK/kc3Ib63BveDZBUk73rfVgbJUd/UUhla23sgZpTgmmbdvoG77c5oxjG1Nabg6EsQGeO8WeghCvdBVpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENdTaTaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BB6C4CED1;
	Thu, 26 Sep 2024 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371840;
	bh=D0SfxUVTuyTnYZC9kSremtU+kFqebil+/+UbQRnwwPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ENdTaTaYpYfUoh1nCY22Dlg9jxssuLFBmmcTq6CYhQa886ueJQ8tiiTXWi6tGpMTk
	 d3F7R/QhtWW6Ru1fhoVtB69awcUomzaOrUXJ9zAufdclqYV0ISOpjSvZ0aHoQWBHwG
	 LtM6TZ2X74s+rw7FN0CuoRhGuv/xtj9ARwA3YLJWfU40gdV/pnCA6wjly1X67XFi0K
	 +usO86pAlycVQl0N+QMnwV2pN0k77v+DI0bVfFta1/AILrLDJmwYVzrES6MyUsQ7Np
	 9/SHOh2Q6+Tgqe5OikuoS1/xvQPfa33s9duqHTkYDs1qyRfAO2b2oEk9J4swyASkaW
	 WfA4F8qpw/54A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 26 Sep 2024 19:30:22 +0200
Subject: [PATCH bpf-next/net v7 1/3] selftests/bpf: Add mptcp subflow
 example
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-upstream-bpf-next-20240506-mptcp-subflow-test-v7-1-d26029e15cdd@kernel.org>
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
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EMtfZe45Hxqq8vNRVMFtfAoY8a5Xhn5SAcHBEaZLfUs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm9Zo22Nih81yx+/UrbcG5sVeZWMg1i7RIY8Bub
 iMpXaqmHveJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZvWaNgAKCRD2t4JPQmmg
 c7HeD/90DBPh+gzTYSCHAXU/40gke0uvwWDUZDPnF6/Hm40tFltxS+j6EhOR8VJMLo8tZtIGSWh
 OQhPRb02CN3tFehgMKI/reiIKC1VfyT5C7BRADrpClAhpB8s6+IK/47gXbaYgKkZ6z7PMliZ++Y
 73sC5u99m9UWZ14ZGYAhpLxcKFhoeo87q8C1ysSBgKdkVZvq9h2q/YnfJRxM8mUORKyR6GfPqmZ
 XsdtcASlaPFD+KTrbs97u1Q77it08tPQCVW8f3MvdmeUzFJceN8USaRFBxKBgKR1cp6P8BiPBvf
 Li+A2XDz0WkEcKRktSTJhq+mgLsVPurYS/42DU1vFBwGRA7l0Nlxq6Zw+27dcTticMbjh2LH2k0
 G1Ije9DkeW0KDVQUAMK+qG6rBmug9uMc2WqFHH1DtVknAjNzFJEWCBgeJw0Eq0hEthX1JzGCKBZ
 U0IBGXWZW6TY5gtl8r99bBruSE0N+AUdx5xF5k9u5+BCsiY9NSCBCcWoxpqukL5w2xo9CuwJ9sI
 7z7KFbPzwNXcD1YXWT5Ypbf1dTERknJmri6G1x9H6u5PggWIP9kWgKuctZ6u7QBIFPb8EDppu/0
 W1R63azGj6JQknLsAEJe5lGESIiAzhEGYJSs5o1ZUW67wnJN+4S9m1dEWmzq9DQE0ydOWJhHnAy
 L5x0EHcT6hcnX9Q==
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
index 0000000000000000000000000000000000000000..2e28f4a215b5469fcbc31168071887687ca34792
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


