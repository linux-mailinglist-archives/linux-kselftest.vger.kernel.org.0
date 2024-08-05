Return-Path: <linux-kselftest+bounces-14790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EBB9478BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E016C280E73
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B51553BD;
	Mon,  5 Aug 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewYqvmRB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB135155353;
	Mon,  5 Aug 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851618; cv=none; b=JPXGxo8VLjeGaGfoRCTP0fvIv0QqrV2/9JWVnQ1XGhFOuTD7cmDNKy+OawxY85+OGIa7D7PfEW9ScCwZUfNfyVwFcn5SLts6MSmfLVoWO5DeyxpOyJzBy1hGTFbmG5KsdXE1woXLGVAwrBNOdqkw+Vz2mnibQ26vZiLfGn7EPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851618; c=relaxed/simple;
	bh=v8V8NsYqx5U0o5pTyv3XffdmocZLP0sMUWIWr5UKJPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1QvQ/H9qV/G++o4v0inG5/RgvnRKnMaeev7dBiHRlo5/zSi2QV08jneLzJb3nGDOxFplt70N6c3b/BjnY2mqEcBFP1a93TWF1qCt36TBzdt2zSoOCzrjc+HJs1EZTgKZrHAxNSozEhxA1f5ouZtk/cxdGhTv0JiWHWi+e7QQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewYqvmRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08298C4AF0D;
	Mon,  5 Aug 2024 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722851618;
	bh=v8V8NsYqx5U0o5pTyv3XffdmocZLP0sMUWIWr5UKJPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ewYqvmRB8ArH3+CYzIX1ly4M/jHVUnS9iqEZWQTA8/aqTs0HbxAFJXKrrvGIlUDje
	 ohOXVKUrdaB2jbMivPbEySD7/xMyQb6zJI1jsr/7S4zCuzMOdKCAW4KNmFOoHDZdSt
	 VMGCIyWPd6bToOEOsDiG43nX+QU9Im4PisnNq9YTQS35p3Rn1rbYWgJ+oGT+VDU2Ct
	 PYfd+fJfah5Lw5O9QunNRApweoiOLVHRoPuKwiaLAanMM6TpRngmX/KwPi5hLYaG8k
	 /tHZ/D6kYX/BatgY5q2vt9I2NsxLm6wsg+0c2iOa6VHXMauXGnAKMw7HnBweThtyHR
	 84SGvFOLEsa2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 05 Aug 2024 11:52:57 +0200
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
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
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4710; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2hmbi+FkyvyFNw1rfk0tf+u5UMK3sb/cD/zwQAToiXI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsKETTOzGznQXdDJm+VGh6aU5ocfU8uVAzVdjG
 O9BUcf6rfaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrChEwAKCRD2t4JPQmmg
 c2ZCEADKCMA3p85IK3NP7i/Nay+1tjmxstFtFsczsMZDfXfhDd2Ox7ZuElX3q86F0tppDUs0tHK
 ce7lb2GfpHbiD+lzkdDHSCDWM82M+UzLx4L8rQTc+RW5qhPTYrraGXikEfjxdGhH4SOZmg1aVyj
 EIcVDbVFW+sWN2LdbSPRYVpxxWbMnE7pKeAir2YjhoMzTdpVLQsVMKmStUZoVC5u4cOY55F5EED
 M3c1B1zfhWb98xHiJFN/j8oJPzt7yW5E36d1xtgTpP7BKtoT6n7y2mQ2ianymOAzo6ZxoQ7NTjj
 uyleEmKblp0MY7tSncNhhIoJELfvAh97mYGUJmvvzaM2vMIaX1YmkVwaXDcWB9g/WfwXxxP49Ub
 HhLfPvraLKUcivtz0JQrZ2yu9puNCEp70u87Qaxw2HQb8C3EB/MAwyYHkMqWvTVyeBaoFEDdwzU
 U6iYglj8Ao5piBYRBQVcEhHKPBC+wNcFV7bB/IsnX06XhUc7+GKEQWTCtcwJGWJrBskhEDiKrJx
 ZnpnUP8Arupu6hApglxxG3CiC4ZJ/maheZi+o58RP04spfg01Wn8T5AFyvldK6kgCQmnnqYEja1
 wuOf+ZzryHq2cYWjVSXWYfTG2W1PnfnW1punVdmuXrdNlTB1g/O9xUDhUmWBUmOMvTwq3lDq5Iw
 WdPPWJCO9O8e4bw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang@kernel.org>

This patch adds a subtest named test_subflow to load and verify the newly
added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
to add a new subflow endpoint. Add another helper ss_search() to verify the
fwmark and congestion values set by mptcp_subflow prog using setsockopts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2 -> v3:
   - Use './mptcp_pm_nl_ctl' instead of 'ip mptcp', not supported by the
     BPF CI running IPRoute 5.5.0.
   - Use SYS_NOFAIL() in _ss_search() instead of calling system()
 - v3 -> v4:
   - Drop './mptcp_pm_nl_ctl', but skip this new test if 'ip mptcp' is
     not supported.
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 105 +++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d2ca32fa3b21..d06be03cc0f0 100644
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
@@ -335,10 +339,111 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
+static int endpoint_init(char *flags)
+{
+	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
+	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
+		printf("'ip mptcp' not supported, skip this test.\n");
+		test__skip();
+		goto fail;
+	}
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int _ss_search(char *src, char *dst, char *port, char *keyword)
+{
+	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
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
+	if (endpoint_init("subflow") < 0)
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
2.45.2


