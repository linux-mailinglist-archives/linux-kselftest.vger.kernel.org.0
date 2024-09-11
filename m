Return-Path: <linux-kselftest+bounces-17749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2E9756B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389B11F23BD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 15:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA91AC426;
	Wed, 11 Sep 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeO/H1yh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF032AE90;
	Wed, 11 Sep 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067811; cv=none; b=tLInG5TOy5SYgOh5oFoDgkJwKIP8zKZUykIzcMHjva3H+2vTalDk8eKOdcaxonMzqQzhEg6XwtkX27vVtTfhGZ+BYwnXFxGxrxAXCz7QdETOZqOgkaM2JsHMUGQIV5B4P6nE6ZQfWTPcmKZExnbidQooqBsVsjWAen54vMu8U7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067811; c=relaxed/simple;
	bh=hWl57FHY2fOdoggMMQbYWWGMnt4b33OvRJbD5uuAWPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5MljMgs6lXkK58/sT6lnE/4fxRHQPFhb7f/0Efo8iZA/fkWnvz17QFT05WAztdUSRQilO0XNg/blU+vnBhksnKGjnBaKwUWfS/jIQVFQzG2IjzAoo6nYeAkJxDNRiVsSFdTkTr8Fs+/xCoNfhpVDeBUjFr884SgO5kdNOMVS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeO/H1yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8940DC4CEC7;
	Wed, 11 Sep 2024 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726067810;
	bh=hWl57FHY2fOdoggMMQbYWWGMnt4b33OvRJbD5uuAWPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KeO/H1yhXoFNLGKqS2Fey5BPCVHnunpJSt7RywiV6zy6Cn/d6Z/y0tG6Sjz7JtOfq
	 aTIl5YQuOVewZ4LQbZNAE0L8qUh7pej7Y//asubN60DE6q+8R5UVbddiW6O6qd+Ddi
	 dEDPme98ZTeH0GVfuCiqdczhZOQp0rYkTSpvFePRbCKCqNEhYti8nsRDaNlKtJ5yR9
	 HlAjH5taGbu6RfzFwDt0Ja1YvJOyy/AaRE4Wy0MgPRuxnhYIp+ICKY8FgyS5ZJ7nwO
	 kIn0t1uWkmJcnDnnYvG6W+08vaD2XRvdUBn3h0p+k7FVOyhHRQ/tgYqu7uVUDGMsD9
	 dXiaep/tYIOMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 11 Sep 2024 17:16:16 +0200
Subject: [PATCH bpf-next/net v6 1/3] selftests/bpf: Add mptcp subflow
 example
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-1-7872294c466b@kernel.org>
References: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-0-7872294c466b@kernel.org>
In-Reply-To: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-0-7872294c466b@kernel.org>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4445; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=98MxbfTkgjSKHUOjjCbtRcgcjpjaNf9HbvOObpvAYhI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4bRYm/byHoWpCpDaSOzmJBazO0Iys7FQLlexB
 6xx63zQEcyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuG0WAAKCRD2t4JPQmmg
 c0pLD/9HPEgsxSLF+u9DTiFbFxMhG0FyplMcL3cUbB7I9wyWLVvn4LtU+cRMnX0dUKHDqxTbvPH
 Lke4rvvK9esxVRuRtCHvx9HrtsAKDN1tf9PAgebKsq1hZlLODVlXfMOrtHbisWuOng1sujJvvO9
 zmKCFs2Ahw3uJYwXq3Ce+ciJwlF1n821VmSk50c3FhaX3Hcl3vdMc1rJBP9/n9/ZjS8I3Egsjj1
 gAHyKaw5SsPgp9Qbjo6d9POxi1LkUOysSZ8y4+8Rurgo0WKZS8thbr1iQ8vMNCWjTXExu00y9QL
 ja8raimL5QgjgTN+614NkCXyF7lLEoU8qsYtMsIvPQP/Nvqa5fwxDqLEqVWUhuWzFLqvKDk4cYU
 fMhZfkCJ7PQz2TWrFrHF8nWURDQXNp5OqtyV6TWEQfrkD+urmFNUIwu7DOCGNsvuFi5K3KdsNFF
 qIqBWF8+rNJt/Tq7hM3cBIZin49cxcDW/AIMBZnYE1MC0rYeKMiVlUYUh8daJ80euzSQ8nKccJw
 2jeLAANR9vDip4A3L5ENb6rPj/zqVPG7dmWyHcduCfiaOaUo+m+QslKftoSBIm/HSir4wOAaqKS
 HcxVDWIwlGdI9KbvEQm4l9WzY0DwIVoU34wYd9MxCICAY9T6B2IuORbkY3P5p9JiUh4C/8fGtdQ
 vWdmfyVRBi+Lheg==
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


