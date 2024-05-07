Return-Path: <linux-kselftest+bounces-9589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 431AA8BE04B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64984B26326
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39515B992;
	Tue,  7 May 2024 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVqsxteN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090DA14EC4D;
	Tue,  7 May 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079243; cv=none; b=obrmUqT8vg3aoEaXoqceKhG2FjdH+1Sp1w5XLBb3XWew4MNGfZZqpJtGGD25/9jgmh7yWYHxwr7ontDL0dZozsiA2BIZK0cO0gWjOG1Cygh7TIXX96PyHRwOoj56SVxwNZ/U/4GxyYb9czqGJW5uRvrd6RH7bIGEsT/YGTaR0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079243; c=relaxed/simple;
	bh=fyRycR9/L+qh3CJ6pIxN0skKoQZC9oBAv+ztBt5UGzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AiW+5xrgiPEHC9Wox+iDMGqj9+rBnMQRVGoESyB1Cen3x5bvOvGIuwn6slSu71LF+5fy2W3rqps709CwS7xudDxpnDeiT1kOxlgrMrtnRBIQSGwgSKCqgXOHFeAldfI6v6agoMGlmRO2lGlkNBGXE+nTq0cq8bIi6w8tOntJQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVqsxteN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9716AC4DDF0;
	Tue,  7 May 2024 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715079242;
	bh=fyRycR9/L+qh3CJ6pIxN0skKoQZC9oBAv+ztBt5UGzg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YVqsxteNtzE4S8exHApU/2njm3ygd9CpTi1TDM5H0/OP24rlJh8uvz38v+hVWmxze
	 A9do2IjGGYXPPMb6WjGy7HZpfqJhz4A81LwfflTnp6RsjOXEqVdIbvDwJhZiur/e98
	 dXkNvHxGROHR6LL8d9iNUyH75RuqJHlvHsTSN0FmfCEqoxgu09LHXtn0RDR4f+6XJV
	 qamYMh+A1PcuBs7s68dvaCNqSEuUa/1TB+1k8ffynFBWWafZDRumSz7CxI1xV8TBHA
	 PPyCXtfYoYCIheVjQx9F1Jo4+YnAbRqhlqQhzOtOr/tbbRjMbTGlMdiwFR9g4OIb0Q
	 SjWqMq8UsipKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 May 2024 12:53:34 +0200
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add mptcp subflow subtest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-4-e2bcbdf49857@kernel.org>
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
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QeuP1pMc/k96+AiijABtrDomlFWQNDkZyAl1mjsJHSA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmOgguuQJyqIBiUOXpxcvyUyTh/u9QRs36zlLNG
 kJj1KXPxsaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjoILgAKCRD2t4JPQmmg
 c/mYD/9W/Xm0YcLRjcCEdydksviMvjwjFXItUHpjmNxvluDyfxbakZfpDYsxJjS3rIdNzjfYK03
 en4bT/fZh8xRQiKg1UVCPwh+MlxIenzovEMNZdAtRTPoW9pWNG3HR6bqGqtZ//3084bTpg/b4eE
 8JO3ifXOQiyp3f5902sEq+jTLaUzp2pW3k2c7IboooXf3bnYqT9cH/R5J4d/UMErsf0A1L8OCV9
 kcxHe1PizEQ0blKkpBKxBmX9/FcQbl8T9f9+TxDs1oDO4Xy+a2ZaMse1IrVRIAxfo3ILmyb4reo
 mGPP7ZSq5n3poQSndzN/UNJlPZtYHlazS+06JZn0J3Ft7UuO1Mh8j6Feo5gQ1u70r1LTsGd7yVu
 hON+J+xMscJuoFlTx2aOBE1nNxFFeVyQ30fSJy4whxp0Mx7HrCavBoHa9QGeNJ4k/qivxl3TMh9
 6WNxaI4QajQVGpeXeMTBD7sUETWJt7WvM6mb3lVlNvWtlyRbdyPypW87u1XVb8CZO9JNTF0j/oO
 LZ9ctbjCOn7GEOkS+nT38Pjxw+sC3To92UYYUjbOuEECOFGZksr79JuS9iRkGUpyGQUeuQ642XS
 y6pj7xWa15Dx9yYvW14CgSJ5g+nesidxrWW/5rM4M9d+WThDBRP2ddSwyviNxBgJphuCdTeOQkT
 GE36SAyPy7nVIug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_subflow to load and verify the newly
added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
to add a new subflow endpoint. Add another helper ss_search() to verify the
fwmark and congestion values set by mptcp_subflow prog using setsockopts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 108 +++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 9d1b255bb654..b1f4b74efd2b 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,8 +9,12 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
+#include "mptcp_subflow.skel.h"
 
 #define NS_TEST "mptcp_ns"
+#define ADDR_1	"10.0.1.1"
+#define ADDR_2	"10.0.1.2"
+#define PORT_1	10001
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -347,6 +351,109 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
+static int endpoint_init(char *flags)
+{
+	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
+	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int _ss_search(char *src, char *dst, char *port, char *keyword)
+{
+	char cmd[128];
+	int n;
+
+	n = snprintf(cmd, sizeof(cmd),
+		     "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
+		     NS_TEST, src, dst, port, PORT_1, keyword);
+	if (n < 0 || n >= sizeof(cmd))
+		return -1;
+
+	return system(cmd);
+}
+
+static int ss_search(char *src, char *keyword)
+{
+	return _ss_search(src, ADDR_1, "dport", keyword);
+}
+
+static void run_subflow(char *new)
+{
+	int server_fd, client_fd, err;
+	char cc[TCP_CA_NAME_MAX];
+	socklen_t len = sizeof(cc);
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+		goto fail;
+
+	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
+		goto fail;
+
+	send_byte(client_fd);
+
+	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
+	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
+	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
+	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
+
+	close(client_fd);
+fail:
+	close(server_fd);
+}
+
+static void test_subflow(void)
+{
+	int cgroup_fd, prog_fd, err;
+	struct mptcp_subflow *skel;
+	struct nstoken *nstoken;
+
+	cgroup_fd = test__join_cgroup("/mptcp_subflow");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
+		return;
+
+	skel = mptcp_subflow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_subflow"))
+		goto close_cgroup;
+
+	err = mptcp_subflow__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach: mptcp_subflow"))
+		goto skel_destroy;
+
+	prog_fd = bpf_program__fd(skel->progs.mptcp_subflow);
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "prog_attach"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+		goto close_netns;
+
+	run_subflow(skel->data->cc);
+
+close_netns:
+	cleanup_netns(nstoken);
+skel_destroy:
+	mptcp_subflow__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
 #define RUN_MPTCP_TEST(suffix)					\
 do {								\
 	if (test__start_subtest(#suffix))			\
@@ -357,4 +464,5 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
+	RUN_MPTCP_TEST(subflow);
 }

-- 
2.43.0


