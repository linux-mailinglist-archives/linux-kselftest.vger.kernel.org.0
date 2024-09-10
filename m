Return-Path: <linux-kselftest+bounces-17585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9959D973989
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD9728382A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C57199945;
	Tue, 10 Sep 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA3pojio"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D91188CBB;
	Tue, 10 Sep 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977616; cv=none; b=fzk17dFYxrWm6aZxBLufJaeU5sSCFLF76dqt405VSWHDLil++rbcq9m6EcBzhyM+HfyDSC7/4Tr2wAZ1dsdMngYi9lvA1vfosEOnfrEGWGBxcgIwcB4VgkVA08pnYEOA5zvalRFxsKHiCht9JxAsrr6Z/vNpBnS8gxW0R4VBZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977616; c=relaxed/simple;
	bh=zQY9ylJsw5DVKosYUHbe+6rAr4wehAk1+o/s2b7Heqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zvnh25J3wNaWNSGq7E4aYIhYHZiMEihPcOxEmIxTlNj4soUIHeXOZYOE1cbbSDqaEbhI+I2v4t4Y22bzct/YFO3UrPVTdj2vWyx9XUkmU3gNTYG00fKHz7fSmV6coIqTEQZ50XlzHfKL/8UH+h1iABx6DjkWaQ4DDzsKeixmYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA3pojio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776F8C4CED0;
	Tue, 10 Sep 2024 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977615;
	bh=zQY9ylJsw5DVKosYUHbe+6rAr4wehAk1+o/s2b7Heqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tA3pojioUVPd7sBSaFU+tYoEOTWRWMUMrb4Qt63RHrqrdHnl7gRBfwl8Do3D1Bjfr
	 W+J6CgEcsnJXUJFpufW9nnQX2A6GtsXYAjAGNbFTg+kSk2cw+lwJPOIjiKIm1tCoN1
	 RSDQVJ/giR255Ta41PSJHMjEu5QNYFxMqI8sObRCrOU4pxdTCiS3mjhlgS19OJgSy4
	 riWWqUlgXw3LXY/KdbbuW7/rhmhKxGGnqKZ2n/ma4Fj4vJmrTgnpWbIIYtn25BuZPz
	 uNuxHdhtVYnUuYX84AOCi/V5e9LzHQR9u3h6KMrep9PhHcDZxx0yUlML2j5jhO2ch5
	 sXtjIWJY5wVSA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 16:13:01 +0200
Subject: [PATCH bpf-next/net v5 3/3] selftests/bpf: Add mptcp subflow
 subtest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-upstream-bpf-next-20240506-mptcp-subflow-test-v5-3-2c664a7da47c@kernel.org>
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
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6158; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bjjivKOUvp0bVG0rbMsxWryHAGBQZQyRzRlpNeCUmXk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4FP6+yFAYgRXp+ZVvgKXqjKPaGUYtTntUQRkz
 OMrVkkpKjaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuBT+gAKCRD2t4JPQmmg
 c1mHEADOQYiUZ3/fpHwHr+LkMlmigNvbCZApf3Tyv1xTgIHRS1MaQU9cvQuugsEEreoWAYarSA0
 /2FVWIEBMkFPnz8538zaEQwe+IfxgnLZ2gJok8d8qlDxCqQWMz7tnLThF0jEIZs6DZtP6We6Y/+
 Bx1IMh9h3yNW7F9qNJdiSO922dgbx0+mrKv377wrkc22p44SwlU99PBFbZUN9cVKYJAIc8Odwxm
 KwtteegAMvNEszQaMAX3mwO3ruoRn05JXrOB1XAqg8eA59CYcZfLxALRaiJyyvICNAIAaHMt8MY
 1wvwJPQTqGlHXZA6jEs99tyYvIPek9nGei9hNjcXDOr+lxQM0Bwa3Y/EF9jk089IIcIqXwqcR5T
 edNfo5Npd5mXXQa8JQ0u2zI/eFN47ivAyRCjtvUsOM6IxgHEtjnKkpcfJAneFx0Coi2j4AD3zTa
 da8tX4arNppdy9ytLQZxI+VA2GRs/sE5jMo6vCMKFcD9Nny1GWxsZSLuhdoIVpx1aowc9k+pVYd
 6i86Dvp5v7W4fhJikFqToSsh+ZndnD4bd6Yrg/uuTa0YGz6geZCVx8NyxtdNsxdwaU1mHNuJMVq
 AEACBysJSfwuAL0TlI5W6j0RWQnK4aPXz6JNWA1tPErtYJnb0Nc7WeAG1mOO6zHXdWzYbi6YCD0
 8pdLmHcIyFoJpVw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_subflow in test_mptcp to load and
verify the newly added MPTCP subflow BPF program. To goal is to make
sure it is possible to set different socket options per subflows, while
the userspace socket interface only lets the application to set the same
socket options for the whole MPTCP connection and its multiple subflows.

To check that, a client and a server are started in a dedicated netns,
with veth interfaces to simulate multiple paths. They will exchange data
to allow the creation of an additional subflow.

When the different subflows are being created, the new MPTCP subflow BPF
program will set some socket options: marks and TCP CC. The validation
is done by the same program, when the userspace checks the value of the
modified socket options. On the userspace side, it will see that the
default values are still being used on the MPTCP connection, while the
BPF program will see different options set per subflow of the same MPTCP
connection.

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
 - v4 -> v5:
   - Note that this new test is no longer skipped on the BPF CI, because
     'ip mptcp' is now supported after the switch from Ubuntu 20.04 to
     22.04.
   - Update the commit message, reflecting the latest version.
   - The validations are no longer done using 'ss', but using the new
     BPF program added in the previous patch, to reduce the use of
     external dependences.
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 126 +++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d2ca32fa3b21..c30f032edaca 100644
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
@@ -335,10 +339,132 @@ static void test_mptcpify(void)
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
+static void wait_for_new_subflows(int fd)
+{
+	socklen_t len;
+	u8 subflows;
+	int err, i;
+
+	len = sizeof(subflows);
+	/* Wait max 1 sec for new subflows to be created */
+	for (i = 0; i < 10; i++) {
+		err = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &subflows, &len);
+		if (!err && subflows > 0)
+			break;
+
+		sleep(0.1);
+	}
+}
+
+static void run_subflow(void)
+{
+	int server_fd, client_fd, err;
+	char new[TCP_CA_NAME_MAX];
+	char cc[TCP_CA_NAME_MAX];
+	unsigned int mark;
+	socklen_t len;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	send_byte(client_fd);
+	wait_for_new_subflows(client_fd);
+
+	len = sizeof(mark);
+	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))
+		ASSERT_EQ(mark, 0, "mark");
+
+	len = sizeof(new);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, new, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)")) {
+		get_msk_ca_name(cc);
+		ASSERT_STREQ(new, cc, "cc");
+	}
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_subflow(void)
+{
+	int cgroup_fd, prog_fd, err;
+	struct mptcp_subflow *skel;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	cgroup_fd = test__join_cgroup("/mptcp_subflow");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_subflow"))
+		return;
+
+	skel = mptcp_subflow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_subflow"))
+		goto close_cgroup;
+
+	skel->bss->pid = getpid();
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
+	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
+					  cgroup_fd);
+	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
+		goto close_netns;
+
+	run_subflow();
+
+	bpf_link__destroy(link);
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


