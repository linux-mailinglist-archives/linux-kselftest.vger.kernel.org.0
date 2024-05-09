Return-Path: <linux-kselftest+bounces-9792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AE8C1241
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A62B21C16
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BED17082B;
	Thu,  9 May 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGZLxob+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9263BBE3;
	Thu,  9 May 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269790; cv=none; b=MNDoYEvoXTyG5icETN50RpjBQZNi/aKE4C7AeNQ+NlySDiRiJqBdw3Umj03+L58qkxzFZbho+5m8GoaX2rlnPeYwXUmX4T0fuVPQ5z41+Cb/XFm+bj1AuJUYCYYyDaWjt6jCU1uAPXSNiGaRkinsgK0ijAEJMhYgdVxaSVSXuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269790; c=relaxed/simple;
	bh=fwWU1y6Fq/raMfRnXEAPArvOPb7WTnJwfEnbbmHKMMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUoNPF55jlTkfpO0bGIAEyuH/GPBZ9x7MWGNiR4D4/E5wjBZEXcKBE2IzXOFv/nk6Q/vmETvTps/gG782/kND38JdzyCWRRL/UDMrQsWfr4ds+iolOEvBxSH7JGPX83WVCD7MkwpIRx5j59oxZ845Z+n0D3yjn6xHfsXHNo+2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGZLxob+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA9C4AF08;
	Thu,  9 May 2024 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715269789;
	bh=fwWU1y6Fq/raMfRnXEAPArvOPb7WTnJwfEnbbmHKMMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DGZLxob+DWdDmZ5oINztgCw1wZDvVf7ay3e08FbmMxGfabdWnVGjsr/lJ9KG426S7
	 wg+KfoQ4Z/+iqifBNK0JoLlorU5KZOd3cpJyuJVz74UrafrYr4I65+pD0cQYVZaeGN
	 dWUhGRz4ZOMRspdGYR/iXnafviYJTUSE51AkUCP4oV7LN0cEyfT1xD2eYIlSxtaSPE
	 twYlWky0+v6Cg/yahrotiJx2RSOlKVpc+6atB1XCKhquNQ4eRPcrof1fNTrg+eVBzH
	 PTdK7gKRXAde0AD9m4KlGAJYY3iiMpxmiBgvltsSKaRQR+AlaWDbopABONHHbgJgHY
	 fNvr8wHGfrJbg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 May 2024 17:49:12 +0200
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow subtest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-2-4048c2948665@kernel.org>
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
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4451; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LJOvAclIqDeTdcev8kuUSRjihzhLlQDft5mKWsBKgVA=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGY88I6gJC+qoBHY0rayM2/i1+mgE4r9HTrzf1Byy6x2nsshU
 4kCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmPPCOAAoJEPa3gk9CaaBz13YP/RDY
 XXwOC+86HWPGvJ10RvVL4e/1himpNFmzBbou2tqHBkr19qD0Ji2xmqnnI4LsY+QLsxhBEcM+8BZ
 ATdMxxXkhvTHKcyKOaqnpY0mNvZd/4ByQYia0Ykh2nDzsVwRXV3S3z4QEPpG1Qq/3OLBSrd/YJX
 bHU0hGII1occkeYG0LOZU/I0I00Yb5PjqswKtce49ruVgFfpIr+HmVGyvY70dwGY8Q8gMHoWhGq
 Sx1oilBRsglXGT7llNl/YZQ8advZdFmvjRkgyZYaah+2ESHHeXksAFTTlSkaaDFdESc+0iKaxcp
 hUc5buOlJidc0cq6lahyh82cnpNGtEYWd/QvvWe3u50/yFGKSojgP4NQbuWVUVVe7KXIr1WhNDH
 R0hT5CssUmARyzdtDO3Wzq2fbYagkCjPyk59eyCb5pVgWavOfXHCEOGrPdz13+XEObun2h1XZ/W
 3Gw0halfqVsMr+MgL1l/HoTqDz/6wVIf+y6UX386ooBx3xCYt9OScNCYoE+zfOemsc1QPBbc3wj
 hSq+44GN/deXfASymVFiAGxLea0fRceRmWotMTM8/FfIDGflHcnqyjSh4tjMTB45hnnicDgucLw
 ayVYb6vXpR/sxXTdWQE94pDgUUmYnwEKsOP5fAj0x+2m+m9/qEtDYCaqGk8QTza1ytt9TRPEGAg
 Wo0/h
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 109 +++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 274d2e033e39..6039b0ff3801 100644
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
@@ -340,10 +344,115 @@ static void test_mptcpify(void)
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
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("mptcpify"))
 		test_mptcpify();
+	if (test__start_subtest("subflow"))
+		test_subflow();
 }

-- 
2.43.0


