Return-Path: <linux-kselftest+bounces-9588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D08BE046
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 12:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B585E2867DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607E158DD4;
	Tue,  7 May 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfuF2Tdn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B11509B4;
	Tue,  7 May 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079237; cv=none; b=RBxshMcBtUTq46AgiFbVe9H5u3eSNBDcAHRr7ecGL+UC3KBWSt2vymv5EGDgUcLUILTOkMGZ2wG63g7gqpF+gyrFQWEmolcpnN4rAxLieXRQyfLqgImRA9PGHo2y53HxWvLvRBKySDTfz8+//sLgzN4AYiZUhi09toyfgEJ2qZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079237; c=relaxed/simple;
	bh=VFKyTxMNnjtTnAGapwEqo0y+Wl3eNywA8QPOjetFwbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAZUF2zaoh3SdhMtjkVOM2vPF3uZDymqUbGzoWBIm9b9v56Y8KiPlyp9WEGYD7l6qHFzGKTFmhP4pEAPzq73qMbgHPw7k15wQ6C7u11/JldZCmr5QJ1XJYo4RvF6+OoU7dR/A8oBp1qGY1aahBW9Bp6Ypxi3TYDA98kng80s+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfuF2Tdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F2DC3277B;
	Tue,  7 May 2024 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079237;
	bh=VFKyTxMNnjtTnAGapwEqo0y+Wl3eNywA8QPOjetFwbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QfuF2TdnxdGRGi4LcpbRaW7FyT2AqrnNLOss5JrPM2uZJhXox8R38GANJZUNA9Zfx
	 PWufTSqrVKm3gmXIyHT8pbymWFOck4emf9Bz4IljrXF8VJRH+w6hSedyZONnClK+iE
	 WWFXhsnvZk4Lall5KUOBmJULg+9e0FJSMwdgaQSgU9pNtnAQDE0fDc2T5T7/VZKF1R
	 VHzlMNggpKHsJWg14DydAkfYySztncyyCzHTSvXC4INxRcjYcouRYwvJIEnjNOtmxm
	 9DZg++mNJZp7UyHiMVgdtHsETG0o30UqhpzdCsIWFECgS95u0QAzZ2nmmUrcmUhLG6
	 FqLmV29QA7A1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 May 2024 12:53:33 +0200
Subject: [PATCH bpf-next 3/4] selftests/bpf: Add mptcp subflow example
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3387; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9yBRlvcB78kseSfkWuFKFSLv7Nh7bJtbBJ9j/JCwOfc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmOggueCE7DHl2/0U2kOTU6h1W2xplY9qsqP5kw
 sph3IgS5NCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjoILgAKCRD2t4JPQmmg
 c1awEACUa0bjOdrYDibYKxuW27ayQDefRp0gFGZROprmFgXaqrVf5FzjrsIk7gdgOe7bkPA4i9x
 pB6swZyvDFXILuFgix661/g1+P0MNAiYnch3YuMcCFvXpsQBQlmzGGLl4bqL5+P/knnRca9K7Zl
 BCSwKzNRv23u6sERo0mjMGfZrPVpiEuaYf7a1y4Gl3IfOmjL/ZbiPlU2pDCiyWdMkXaFnYhysOC
 g1LQ44vg947h9v3cJeDLWr9kgRYLU/Lx24RbctunZQp69GWvsI0OVcK344gWpj8hLXANyxNm/h/
 rHUEK470BgzDG2NsaEA69DM8CFKskTidPYV3L/Q3TKnbpf8LufMYPT3g5td77xFu1wvD/urN6P4
 Ts6k7NS0xcYuFho3XUrxoHbIcqkBOxGBoR4gvh4wq+z2s0eB2gGjs9J+MuPi2UeIjHR8ahRZY5l
 vLxyP9/nwH7Nw0OPnK1BK6yU2725UvgRbHSEbDBUSgU6aNAKPSIFNO+UAMGyy8J2EWxblslaqyp
 6ZS34aVk2EpluwlE8zZ38oUqxGGDchR+HKOPOKARo7goYKPhHahhdmU1xK8TQi8gYYqdFkNcvcV
 qoKnrOhoP4jjG9ib3JX/xFmsGlbIRJAG9ExtywZnt4Lfx9DxEQD522vx2bRfUPtxkydfvAadu0x
 ivB4sffwHEeSlUQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Nicolas Rybowski <nicolas.rybowski@tessares.net>

Move Nicolas's patch into bpf selftests directory. This example added a
test that was adding a different mark (SO_MARK) on each subflow, and
changing the TCP CC only on the first subflow.

This example shows how it is possible to:

    Identify the parent msk of an MPTCP subflow.
    Put different sockopt for each subflow of a same MPTCP connection.

Here especially, we implemented two different behaviours:

    A socket mark (SOL_SOCKET SO_MARK) is put on each subflow of a same
    MPTCP connection. The order of creation of the current subflow defines
    its mark. The TCP CC algorithm of the very first subflow of an MPTCP
    connection is set to "reno".

The code comes from

    commit 4d120186e4d6 ("bpf:examples: update mptcp_set_mark_kern.c")

in MPTCP repo https://github.com/multipath-tcp/mptcp_net-next (the
"scripts" branch).

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/progs/mptcp_subflow.c | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
new file mode 100644
index 000000000000..de9dbba37133
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2024, Kylin Software */
+
+#include <sys/socket.h> // SOL_SOCKET, SO_MARK, ...
+#include <linux/tcp.h>  // TCP_CONGESTION
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+#ifndef SOL_TCP
+#define SOL_TCP 6
+#endif
+
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX 16
+#endif
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
2.43.0


