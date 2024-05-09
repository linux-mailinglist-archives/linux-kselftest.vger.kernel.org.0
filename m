Return-Path: <linux-kselftest+bounces-9791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE98C123C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912ED1F21BD2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7F16F8F3;
	Thu,  9 May 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNOXsy4N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BE3BBE3;
	Thu,  9 May 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269785; cv=none; b=Cq6qX4VkWOurigYSm87cmVBG0zS2t13kAtE0C5B5QhWw1YBG6Jy/EAA0kegdlrOTctCR0Ho2l3V1hGxBAb30tkwswMb/rOPyBLrMr8SO1RXU/bnYB1YVld/VkBy2VAWSU8GNLxqJeZgZFKaP518aD4Eo7Sa9RPZ9/8xH3myflic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269785; c=relaxed/simple;
	bh=aBZwDb+Zg5BqvF/86zIslJHhnpqdqLhKSQhEm5hsQhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqVfm/ECVi+FFv+2bHbw6eq/ZXt0JmrTBnr/nfE1Tkyu5GDbls/RJf26zPN5svWuIUXjhltue7L5X01ePh5wEdyHFlB1YiZ1EuXYYdlZVJ6NDJvAyV9qCDv6ap+w5kdJbb42lahd99T7ozbXTnafUzRS21I4F6WkDJMiZC8FvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNOXsy4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0474CC32781;
	Thu,  9 May 2024 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715269784;
	bh=aBZwDb+Zg5BqvF/86zIslJHhnpqdqLhKSQhEm5hsQhA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CNOXsy4NSI7SFKgDsgrzigjPBQbQduMdXLBoa2xASiTX+RtLMSnySCEph2WtQTxbb
	 Ck7NHszkOXqNylKBSLgI+dqZ5KSASgyUPYmEC6H6bJCIZz6qP6LMdkVkWPXsQfEYNi
	 jrbfS5STswKahUrbX+PStblPtAFftt6bwCgIeQD60h0mdC2q51YYaFR3N0occGzFmM
	 ZqLv04SxDoR0NqY9uV2c+0qZyFt50sZGT8J2NEEI67ITSoc8sxh6wk5RuGufXIl0Qy
	 driukg+cRZP6pztwbcMmfQCZT/K8HaACLdngtOxcHoSuUBmmO1JQhWor7PeGYO26ZX
	 70E4ywPe/RnGA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 May 2024 17:49:11 +0200
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Add mptcp subflow example
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-1-4048c2948665@kernel.org>
References: <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org>
In-Reply-To: <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4287; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Wp/wcV4mGM06ft4X8e14lXn7YUnldR2CxDh3hdNKAEM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPPCOwVvg/x4jF7OA+J3Jk/KXMeOctkCAHdA74
 gTUdw3sGjSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjzwjgAKCRD2t4JPQmmg
 c6SkD/0ShGdZ61JjqIV00c5XurF6y8jTtqIX3ZpUuQKQr4zLjdgvitz0KSkWkf+jE1jNqqcVoz7
 fMNhvAN0lawYuO6cqrIraGKlrRrqD0m5LH2rsB64dYL3yuUxWhU89g043Xc+R90lGo2eWQI8cZG
 16PQDo5ucIqgcFFuYD/zK2tVAbiRPBPcoepvLrKhY4T/nCY6jHgKj9xtaBuvc15BYZQVZVsBcnC
 YQb5UseDK5Y3b0iUHC91sOaQKdY+crdQHaMSdT6Zctqgab9vblwBG/rqZ3u/+C8t4WlmSY496Dp
 dOLEBERinviHAncSjDwaMBO2AsCU4C0oooGJZ/ZOEkdK2gNAMZudOi0FEXbVngGirVFmuTKsKqH
 02unBEv0/YSxnQ/4c159DwBaqNTWflFli2WmvvDhpcW/c47YwCqpakV+1BeUm20HGWhiMYT4LHR
 JZ63wwts6445kUzLAH93rmYuPtyuMpXh08wbh4VmvCQzKH+Uvo96I9bFDcCShLb7d+LGnAXidQl
 BQoe0gtO4DmQ0xz2xgWIg4LzZk+r6ZSMHFWXTzy7UIq84Kw7PUSQdhi1LwqjCe3dXA1nbbTsr3f
 UtTqY6uFh4F5EwefNFM+Q/W4H1Xbns0ZoB3DdTB2FzCJ4E3DyeaN/4URLBlQIdeg4R4wuw7ohhs
 HyhL8n8hK12PLMA==
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
     options, why reno, the verification is done in the next patch
     (different author). (Alexei)
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


