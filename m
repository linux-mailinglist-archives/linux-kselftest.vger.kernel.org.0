Return-Path: <linux-kselftest+bounces-17751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 903269756C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EDEB290D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D01AD3E3;
	Wed, 11 Sep 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfXzu1kT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A241AB531;
	Wed, 11 Sep 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067821; cv=none; b=VoqZKP0ZXhXOp6ZZMqZ/JQhu7PYh8kcJW1CoaIm8+Wfl3sKiYgCfG8onrITF/RATJK63sfHECFcPyywgTiRlgojEx0WxidNodzWsMmlAcYp7R0sJf/j+kDOgE2rRno1xnBKLyirgp5rCyUCxtCEwNeWaXbsdKCbLbs/iwuZoEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067821; c=relaxed/simple;
	bh=rvyB/8VmwsZWv2v7ySK7UI/1A/6GmFKbw04BuegBh08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXMGqmmdhbYplSy5tQFSEkRWsINNsY3Jbb2dBFRipfEOoKCIevvml/TOnTRykRzMcdMqwhEIBCXuCJWgRFSTp+sQxKebYqXnoz5Q1JYCGs+7RFKPpL4T0itiwvsgljXP1tMf2RSujt56yGQ1VLfIxPKJyEk1BPBrmqDhn0CYnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfXzu1kT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6385AC4CEC0;
	Wed, 11 Sep 2024 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726067820;
	bh=rvyB/8VmwsZWv2v7ySK7UI/1A/6GmFKbw04BuegBh08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jfXzu1kTnOh0ndVtWIz3OPxKqWdxWX87OKoCoF1n04Ulp6P5gdkKIj5REKOvrEgR6
	 yRdjlU+W5r1KtxE0vNUMqJ5I3GcWO3v3shGUKTPfmCd6lATdiBSLeZnaPXgqaXfUMf
	 WeZ2FNepwVYiiQeqnqwNgNudpM2qR6DUD8fT6/J0pIVCsZQzVPW779j6VYDDat3Ub+
	 qj0y1LI+sjtnSWcLyaV6XcJOc/zJpRkHCLKFJL7sjlOMZVUUQkVoMf8T0Ne1zCUBKO
	 l94Xjg35yUZls65OlDC8zzMrrIdi4BKKaDatxaqjbwLab/Gz+45BdriSs7+/kTBg/j
	 OSaOhfceOGzFA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 11 Sep 2024 17:16:18 +0200
Subject: [PATCH bpf-next/net v6 3/3] selftests/bpf: Add mptcp subflow
 subtest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-upstream-bpf-next-20240506-mptcp-subflow-test-v6-3-7872294c466b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6367; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jl0fkReOPsHzDsa1dsyKuB9rta8BrobgXpXnIKQtdD8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4bRYeiAzV9g4F+34V6euaZ0+AU0EvStXMJeI9
 5KzTNZrs6SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuG0WAAKCRD2t4JPQmmg
 c7V2D/9TWXLNLbSixXiR1q79qX535CSD/cj9KCmk8nvWCY2a4ruQ3GawiDg6oNIVQ+MRj2aqZmX
 yW04e/Pb44t+1vTIik4ToE07aSHqTBcAHuPA5oQbbCvy4FfIEZyNMoBKt/L2PPO1BqbedOej7PF
 A0RSdpxGxIiCt5EZxkkZoUgiELIkdfdDPhl1ayvjeicPmhdWzP2sKtrY82pjPcHSEZ8zNVmqH3o
 ww9Lz6Fk8jc/VGutLx9zGQaTALGNi9uFWCS9UCrIHdb9FYvXcf3nGYfu8/At2NEF2HMgRWBEVlt
 n8gLaLJt13mpBOVkB7T9y9NwEKw5NMMGdGd9yx6DjxN8C0QFDvXPMm6ne52D8dQcoHgFGP3o8LX
 mtYjPuXA0NRuSW3M1XdlG7X+Tyu5ljxM5CMvQrPmdE4grqm5xLad9XIT+DpDWX+6nLGxalLAA7l
 TPx21Rer8Q1JmG0xAaz11/ylsTr+/aTHbsy4YKY8iuDG6rxl+jJIoIpdJz4OqfSf3sq3AzaRebd
 1GnR39zp1fBbu8JhTtJYdO18QCvoLmimjXsXaQqzOAs7C5FCB0dWenTLGjQVsV05P0+hFyd8tGG
 0ok1uPl51DuAwXMwk9g1iViCO6NL5gBkJJ1W68ERpLTv4Z2ytJH4xDCPo1LtRpcX72uOURjdvyN
 grvPyEeSAXS1DaQ==
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
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 127 +++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d2ca32fa3b21..c76a0d8c8f93 100644
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
@@ -335,10 +340,132 @@ static void test_mptcpify(void)
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


