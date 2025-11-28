Return-Path: <linux-kselftest+bounces-46710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F9C9340B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 23:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF17D3A8262
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291BF2EF66E;
	Fri, 28 Nov 2025 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dYN6m5Oh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161312E8DFE;
	Fri, 28 Nov 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764368859; cv=none; b=oFhhH0BvThm1xLcv6ZkSJ16GFHdl9S8QwakanYDcIS4Y00iZHn5XBF/2NuRe/WRQowQRqOSla8AjEXh5uN4tQ2dUNUmQwMW02aTl1hymdUUixI34uBCY8HZgxzduREnH1LNUZ3VhSXSddTSvGgUy5rd+LuQsbcSuJLuaHrPqS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764368859; c=relaxed/simple;
	bh=iNy3+2BC40xaanFZ33v7Qj0LzuYFlWWryMucOWesFao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JITRIgYv042b2xxv5y1RAQ0BxRn7SRUlAsdI2cvIwEHfCVga2DjMlWnTuUPf35c7UNNk7Ql9lBqw3xrDEf8NzTYmlzX7CQ/uAyVg3fM4/IULIupeRcU2XiGPdbeXwsJ9l8jhv5wm0tE/YHcJZh69d7RljYwnd0NfLL0c1G2vEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYN6m5Oh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 71F2F4E4195A;
	Fri, 28 Nov 2025 22:27:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 486A060706;
	Fri, 28 Nov 2025 22:27:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F88910B02598;
	Fri, 28 Nov 2025 23:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764368854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vpPgdxy49eI4YREjOTkPjJ6SggMZfZ1B/R+/EdiVrT4=;
	b=dYN6m5Oh714oPBDopNueaOHZxK/tlsJCBfs/7f3f1lJ7MO3ChDIk+oduDEI+r39GwwWb6k
	P13yjyHcua6bV4py7OUS1ghfFiaaENXqCevJRwR3BBStcWC+gGRNcbyGNLVkMBeNOdzgOF
	TKHZbOaku/3VLyXHUKhCiRKSzxOvRPKHg1MOjuO1mgkl3YcMquSVvcU1jFpznru+MNI6Wb
	GzMzXplSp+aeYL28rL59VKb3jQXZwNwqFFidzh3msRJOrTPgjMfmwepdvlL3fKiig8p4cW
	KDNt/IJnnKd6lwVq0nz1RK7XdsdxzOkSQQlpK0l8pB4CGN6cVl6Um0LA57mV0A==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 28 Nov 2025 23:27:19 +0100
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: integrate test_tc_edt into
 test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251128-tc_edt-v2-2-26db48373e73@bootlin.com>
References: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
In-Reply-To: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

test_tc_edt.sh uses a pair of veth and a BPF program attached to the TX
veth to shape the traffic to 5MBps. It then checks that the amount of
received bytes (at interface level), compared to the TX duration, indeed
matches 5Mbps.

Convert this test script to the test_progs framework:
- keep the double veth setup, isolated in two veths
- run a small tcp server, and connect client to server
- push a pre-configured amount of bytes, and measure how much time has
  been needed to push those
- ensure that this rate is in a 2% error margin around the target rate

This two percent value, while being tight, is hopefully large enough to
not make the test too flaky in CI, while also turning it into a small
example of BPF-based shaping.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- drop custom server/client management and replace it with
  send_recv_data
- drop bytes reading, as we now base the test duration on number of tx
  bytes
- update bpf program check on source port rather than dest port, as this
  is now the server which sends bytes
---
 .../testing/selftests/bpf/prog_tests/test_tc_edt.c | 144 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_tc_edt.c    |   2 +-
 2 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
new file mode 100644
index 000000000000..9ba69398eec4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+/*
+ * BPF-based flow shaping
+ *
+ * The test brings up two veth in two isolated namespaces, attach some flow
+ * shaping program onto it, and ensures that a manual speedtest maximum
+ * value matches the rate set in the BPF shapers.
+ */
+
+#include <asm-generic/socket.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <math.h>
+#include <sys/time.h>
+#include <sys/socket.h>
+#include <bpf/libbpf.h>
+#include <pthread.h>
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "test_tc_edt.skel.h"
+
+#define SERVER_NS "tc-edt-server-ns"
+#define CLIENT_NS "tc-edt-client-ns"
+#define IP4_ADDR_VETH1 "192.168.1.1"
+#define IP4_ADDR_VETH2 "192.168.1.2"
+#define IP4_ADDR_VETH2_HEX 0xC0A80102
+
+#define TIMEOUT_MS		2000
+#define TEST_PORT		9000
+#define TARGET_RATE_MBPS	5.0
+#define TX_BYTES_COUNT		(1 * 1000 * 1000)
+#define RATE_ERROR_PERCENT	2.0
+
+struct connection {
+	int server_listen_fd;
+	int server_conn_fd;
+	int client_conn_fd;
+};
+
+static int setup(struct test_tc_edt *skel)
+{
+	struct nstoken *nstoken_client, *nstoken_server;
+	int ret;
+
+	if (!ASSERT_OK(make_netns(CLIENT_NS), "create client ns"))
+		goto fail;
+	if (!ASSERT_OK(make_netns(SERVER_NS), "create server ns"))
+		goto fail_delete_client_ns;
+
+	nstoken_client = open_netns(CLIENT_NS);
+	if (!ASSERT_OK_PTR(nstoken_client, "open client ns"))
+		goto fail_delete_server_ns;
+	SYS(fail_close_client_ns, "ip link add veth1 type veth peer name %s",
+	    "veth2 netns " SERVER_NS);
+	SYS(fail_close_client_ns, "ip -4 addr add " IP4_ADDR_VETH1 "/24 dev veth1");
+	SYS(fail_close_client_ns, "ip link set veth1 up");
+
+	nstoken_server = open_netns(SERVER_NS);
+	if (!ASSERT_OK_PTR(nstoken_server, "enter server ns"))
+		goto fail_close_client_ns;
+	SYS(fail_close_server_ns, "ip -4 addr add " IP4_ADDR_VETH2 "/24 dev veth2");
+	SYS(fail_close_server_ns, "ip link set veth2 up");
+	SYS(fail_close_server_ns, "tc qdisc add dev veth2 root fq");
+	ret = tc_prog_attach("veth2", -1, bpf_program__fd(skel->progs.tc_prog));
+	if (!ASSERT_OK(ret, "attach bpf prog"))
+		goto fail_close_server_ns;
+	close_netns(nstoken_server);
+	close_netns(nstoken_client);
+
+	return 0;
+
+fail_close_server_ns:
+	close_netns(nstoken_server);
+fail_close_client_ns:
+	close_netns(nstoken_client);
+fail_delete_server_ns:
+	remove_netns(SERVER_NS);
+fail_delete_client_ns:
+	remove_netns(CLIENT_NS);
+fail:
+	return -1;
+}
+
+static void cleanup(void)
+{
+	remove_netns(CLIENT_NS);
+	remove_netns(SERVER_NS);
+}
+
+static void run_test(void)
+{
+	int server_fd, client_fd, err;
+	double rate_mbps, rate_error;
+	struct nstoken *nstoken;
+	__u64 ts_start, ts_end;
+
+	nstoken = open_netns(SERVER_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
+		return;
+	server_fd = start_server(AF_INET, SOCK_STREAM, IP4_ADDR_VETH2,
+			TEST_PORT, TIMEOUT_MS);
+	if (!ASSERT_OK_FD(server_fd, "start server"))
+		return;
+
+	close_netns(nstoken);
+	nstoken = open_netns(CLIENT_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open client ns"))
+		return;
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect client"))
+		return;
+
+	ts_start = get_time_ns();
+	err = send_recv_data(server_fd, client_fd, TX_BYTES_COUNT);
+	ts_end = get_time_ns();
+	close_netns(nstoken);
+	ASSERT_OK(err, "send_recv_data");
+
+	rate_mbps = TX_BYTES_COUNT / ((ts_end - ts_start) / 1000.0);
+	rate_error =
+		fabs((rate_mbps - TARGET_RATE_MBPS) * 100.0 / TARGET_RATE_MBPS);
+
+	ASSERT_LE(rate_error, RATE_ERROR_PERCENT,
+		  "rate error is lower than threshold");
+}
+
+void test_tc_edt(void)
+{
+	struct test_tc_edt *skel;
+
+	skel = test_tc_edt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open and load"))
+		return;
+
+	if (!ASSERT_OK(setup(skel), "global setup"))
+		return;
+
+	run_test();
+
+	cleanup();
+	test_tc_edt__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_edt.c b/tools/testing/selftests/bpf/progs/test_tc_edt.c
index 9b80109d5c3d..d31058cf4eca 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_edt.c
@@ -70,7 +70,7 @@ static inline int handle_tcp(struct __sk_buff *skb, struct tcphdr *tcp)
 	if ((void *)(tcp + 1) > data_end)
 		return TC_ACT_SHOT;
 
-	if (tcp->dest == bpf_htons(9000))
+	if (tcp->source == bpf_htons(9000))
 		return throttle_flow(skb);
 
 	return TC_ACT_OK;

-- 
2.51.2


