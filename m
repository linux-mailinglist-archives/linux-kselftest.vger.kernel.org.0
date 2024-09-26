Return-Path: <linux-kselftest+bounces-18410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC9A98785E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D65828A8C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730AF17A5AA;
	Thu, 26 Sep 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuCF6/8c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8E166F06;
	Thu, 26 Sep 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371850; cv=none; b=EK3SvyA8lDE5PejNifoZlwcPhXw951EAghdJrHp2w9RacpXGjl8qgmvlmuarCdXxWNYgStphc8Is5IxGP8dC6O7JjZmU7+5WbCXBKO2L3Qj4rDaIFo250y524JBpPUvA2usMEZpDS4Q0acvvsgtrQrpH+efxc93keLSf3mWmu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371850; c=relaxed/simple;
	bh=xuqwGLHjdr30dQ1lPi12br1Zy+HpIC4MWNhfUuOvRbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ft3HiNCcVBZQw8wmG1smQX9MSeCd6jHtig5df8oPZKxvdwSca8+k0tKANtlQilkfU3Nfv3ttBmyzKilCZlBPOCPTTL45m17fqj2wzmFhnmn9fF7YkymLJ31TeFkwlAnXeleSurJ4qk2YOO6lyW3M4N9SvtgJLi05R6DycBNDbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuCF6/8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ED4C4CECF;
	Thu, 26 Sep 2024 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371850;
	bh=xuqwGLHjdr30dQ1lPi12br1Zy+HpIC4MWNhfUuOvRbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XuCF6/8csFYR+p4s+T13eTD0qj7XcQO3vN0Q7Pb0m7ggcUPa3/q93o63VTnceYYFx
	 jT/Rej/SAbHsnlAx2ROmTo/7kdmf7JALbsuPlDJ8gzdBtU5EfpgG6FG2Nglo+L5dbj
	 2pMT+NrFyFr/QU5pZcNrRc+Zr04mYT11KFNCpLt+wEWql//bOLRCgbkif1IiDRQ1NS
	 h7hzTYMcTcEqh9ZMoYk6vDsLw0ZZtcq85KXDHO/lEngIXEZJ9fI+pLfpOKLtyYAONS
	 0jXDD0BqtgSjDOKNDhp/HgKkEx/51c/R4bET+8CMnw+jVvHvGpmXt7eVz7LkEe2rew
	 9paTmqoJl61Ow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 26 Sep 2024 19:30:24 +0200
Subject: [PATCH bpf-next/net v7 3/3] selftests/bpf: Add mptcp subflow
 subtest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-upstream-bpf-next-20240506-mptcp-subflow-test-v7-3-d26029e15cdd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6499; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=amjFCzfj2zTqypTjATD/9IUdR8Z/IjIKIf9BGZz5Jbw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm9Zo260GeawutDlv38rtlu+FTaCTBSDzsrUF4C
 egYQLmfs3CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZvWaNgAKCRD2t4JPQmmg
 c8GWD/9jS3jl5phtJkZQFpEA4U0Cox68GLXuqP5WEHmhngkXVMG2eThOdx9RosWAaAp2mIqZihT
 0M4I9909JHgumQDTCI3vAWcmXQmP1nYIEG9KiHDdKmwfJrR8HldEJ9G1TSUTyHwc8Fo+mnM2zx2
 kaeS9MTqzLDetFTNyACCS/3XmZTbZQXr8fx1TaOzfXMiB4mmVG9dCqdbvPovGavdbFSvLpe5PXv
 aJ2yNASSEwGa9zrUevHTdDcc5JIf++AokonAGeZX5i1medODIc1GuNnmbAdSqTZwf6WEoNEJNTM
 40Qghw9cEZrlK+1081c8X/9z7wRBEjEQpurIPdvA/VrsEJ8LZZiQSojd1PXtdVRO+ZS5EWHV5Mx
 o0asTgEG7UNNvy2DGOSt39InE/pf7duZ6kYS9OORKSSv2N70z80t/Na6zkiuwdW3FTckPc4CNRV
 Zal9TQ1i+L0B8QFke6fdks1qXNUrHGxoe4sfBJihBnSb9F+fzipljDysVr1cpznE2raFbBp+r1O
 QlUPcIplnkFjbDmbJYJL0eOhNB1YBw0g4bVW5TL0if1WqrGb9WmpGZ1zIs/4wf3AMEkmYECWgJb
 16AjgMAoQkYAFbeWU1qzMYgZULMvzk+/sL6InO5f28JVHbz/cvw1y0FTlrkKtW9DrNF06HlRS0/
 NtCktoFWGIQvD0A==
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
     external dependences. (Martin)
 - v5 -> v6:
   - Use usleep() instead of sleep().
 - v6 -> v7:
   - Drop mptcp_subflow__attach(), use bpf_program__attach_cgroup()
     instead of bpf_prog_attach(), plus assign the returned value to
     skel->links.* directly. (Martin)
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 121 +++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d2ca32fa3b21e686d6ef2673b5953d5417edfedb..b61f26b8cdf2540a34e28ddb8a5f1f2378cf8c06 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,12 +5,17 @@
 #include <linux/const.h>
 #include <netinet/in.h>
 #include <test_progs.h>
+#include <unistd.h>
 #include "cgroup_helpers.h"
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
@@ -335,10 +340,126 @@ static void test_mptcpify(void)
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
+		usleep(100000); /* 0.1s */
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
+	struct mptcp_subflow *skel;
+	struct nstoken *nstoken;
+	int cgroup_fd;
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
+	skel->links.mptcp_subflow =
+		bpf_program__attach_cgroup(skel->progs.mptcp_subflow, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.mptcp_subflow, "attach mptcp_subflow"))
+		goto skel_destroy;
+
+	skel->links._getsockopt_subflow =
+		bpf_program__attach_cgroup(skel->progs._getsockopt_subflow, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._getsockopt_subflow, "attach _getsockopt_subflow"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow") < 0)
+		goto close_netns;
+
+	run_subflow();
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


