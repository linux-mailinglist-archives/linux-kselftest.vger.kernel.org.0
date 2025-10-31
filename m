Return-Path: <linux-kselftest+bounces-44530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E01C25ED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EF41A6121D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593EB2F1FF3;
	Fri, 31 Oct 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0ZA7ywlZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B42EC55C
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926132; cv=none; b=klEtFI/lWX3AkyHoTiVu8bkaGVWnvwwKTBoqxhBamjFslBQzsHqYRU2SUEk8NvNqo0DuXe1VRqxFwsgdSfhMowILQYayszjgcGc2Lu+LzbIy3+0r3vQ01JP9/5Jee7+LteOijivFxqBnBk6GFtdQANwp7nxhFGTdo9xzaHBQ0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926132; c=relaxed/simple;
	bh=Rjz9f+zKWciMlcVM4p3FuUpxQ8Eh8F7OuM38t7syijM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcCgiKS2Y6x9JznauK26AfdjwPIVI6yQLDzZzB74rlKiqoOf7+GdWwNKqWdaO4pTNfm9hDijF+SoleQ8BmQarVSjQ02h7hR4ddB1EWqK6oopWGUJ643GPE+489nA2biylooI03AiRvuNjE/4klkYXxQAY4rflb9a6Dq50oVDKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0ZA7ywlZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B5577C0E959;
	Fri, 31 Oct 2025 15:55:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4398160704;
	Fri, 31 Oct 2025 15:55:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C5C811818065;
	Fri, 31 Oct 2025 16:55:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761926127; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ww1SYMReWRHpDPvJMI1j1ibpe2gLb3Y94LUqpUX4nY8=;
	b=0ZA7ywlZdnnl673iMMOsnrHxSlQOgwX7N44ScitXm7xgrsu0arA6BMdwbDV42UnrHsEpHB
	RecfOAZfoOb2Yr4RgpT4hMj+JB0JGA+jvxPXgpcHImUZK0GDC1oal+hFrSTQTKPhvx4c5F
	Goz6V7IsUt05Q1hbbwZ8qE2kypkVV5EhTP1YxtUO+kM657ZZ2OLViLETlUj0rlhWZCuqN0
	nBQCOzzEYILqpesCklkIYUmh4sA3lWO63KeMTCdy+EjxUpk8d646fLpxD4Oooh+z4NlK2x
	CvhhydVpX60NjZlKll36LxwxVqgvJNwFawR7kgGtRvi2oep9c4qmHT/GacQLLA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 31 Oct 2025 16:55:14 +0100
Subject: [PATCH bpf-next 2/4] selftests/bpf: integrate test_tc_edt into
 test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-tc_edt-v1-2-5d34a5823144@bootlin.com>
References: <20251031-tc_edt-v1-0-5d34a5823144@bootlin.com>
In-Reply-To: <20251031-tc_edt-v1-0-5d34a5823144@bootlin.com>
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
veth to shape the traffic to 5Mbps. It then checks that the amount of
received bytes (at interface level), compared to the TX duration, indeed
matches 5Mbps.

Convert this test script to the test_progs framework:
- keep the double veth setup, isolated in two veths
- run a small tcp server, and connect client to server
- start pushing bytes continuously, but for a shorter period of time
  than the original test (to keep CI run duration tolerable)
- measure the number or received bytes through /proc/net/dev, compute
  the resulting rate
- ensure that this rate is in a 2% error margin around the target rate

This two percent value, while being tight, is hopefully large enough to
not make the test too flaky in CI, while also turning it into a small
example of BPF-based shaping.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tc_edt.c | 273 +++++++++++++++++++++
 1 file changed, 273 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
new file mode 100644
index 000000000000..a77e48fdf4e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
@@ -0,0 +1,273 @@
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
+#define BUFFER_LEN		500
+#define TIMEOUT_MS		2000
+#define TEST_PORT		9000
+#define TARGET_RATE_MBPS	5.0
+#define RATE_ERROR_PERCENT	2.0
+
+struct connection {
+	int server_listen_fd;
+	int server_conn_fd;
+	int client_conn_fd;
+};
+
+static char tx_buffer[BUFFER_LEN], rx_buffer[BUFFER_LEN];
+static bool tx_timeout;
+
+static int start_server_listen(void)
+{
+	struct nstoken *nstoken = open_netns(SERVER_NS);
+	int server_fd;
+
+	if (!ASSERT_OK_PTR(nstoken, "enter server ns"))
+		return -1;
+
+	server_fd = start_server_str(AF_INET, SOCK_STREAM, IP4_ADDR_VETH2,
+				     TEST_PORT, NULL);
+	close_netns(nstoken);
+	return server_fd;
+}
+
+static struct connection *setup_connection(void)
+{
+	int server_listen_fd, server_conn_fd, client_conn_fd;
+	struct nstoken *nstoken;
+	struct connection *conn;
+
+	conn = malloc(sizeof(struct connection));
+	if (!ASSERT_OK_PTR(conn, "allocate connection"))
+		goto fail;
+	server_listen_fd = start_server_listen();
+	if (!ASSERT_OK_FD(server_listen_fd, "start server"))
+		goto fail_free_conn;
+
+	nstoken = open_netns(CLIENT_NS);
+	if (!ASSERT_OK_PTR(nstoken, "enter client ns"))
+		goto fail_close_server;
+
+	client_conn_fd = connect_to_addr_str(AF_INET, SOCK_STREAM,
+					     IP4_ADDR_VETH2, TEST_PORT, NULL);
+	close_netns(nstoken);
+	if (!ASSERT_OK_FD(client_conn_fd, "connect client"))
+		goto fail_close_server;
+
+	server_conn_fd = accept(server_listen_fd, NULL, NULL);
+	if (!ASSERT_OK_FD(server_conn_fd, "accept client connection"))
+		goto fail_close_client;
+
+	conn->server_listen_fd = server_listen_fd;
+	conn->server_conn_fd = server_conn_fd;
+	conn->client_conn_fd = client_conn_fd;
+	return conn;
+
+fail_close_client:
+	close(client_conn_fd);
+fail_close_server:
+	close(server_listen_fd);
+fail_free_conn:
+	free(conn);
+fail:
+	return NULL;
+}
+
+static void cleanup_connection(struct connection *conn)
+{
+	if (!conn)
+		return;
+	close(conn->client_conn_fd);
+	close(conn->server_conn_fd);
+	close(conn->server_listen_fd);
+	free(conn);
+}
+
+static void *run_server(void *arg)
+{
+	int *fd = (int *)arg;
+	int ret;
+
+	while (!tx_timeout)
+		ret = recv(*fd, rx_buffer, BUFFER_LEN, 0);
+
+	return NULL;
+}
+
+static int read_rx_bytes(__u64 *result)
+{
+	struct nstoken *nstoken = open_netns(SERVER_NS);
+	char line[512];
+	FILE *fp;
+
+	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
+		return -1;
+
+	fp = fopen("/proc/net/dev", "r");
+	if (!ASSERT_OK_PTR(fp, "open /proc/net/dev")) {
+		close_netns(nstoken);
+		return -1;
+	}
+
+	/* Skip the first two header lines */
+	fgets(line, sizeof(line), fp);
+	fgets(line, sizeof(line), fp);
+
+	while (fgets(line, sizeof(line), fp)) {
+		char name[32];
+		__u64 rx_bytes = 0;
+
+		if (sscanf(line, " %31[^:]: %llu", name, &rx_bytes) != 2)
+			continue;
+
+		if (strcmp(name, "veth2") == 0) {
+			fclose(fp);
+			close_netns(nstoken);
+			*result = rx_bytes;
+			return 0;
+		}
+	}
+
+	fclose(fp);
+	close_netns(nstoken);
+	return -1;
+}
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
+	SYS(fail_close_client_ns, "tc qdisc add dev veth1 root fq");
+	ret = tc_prog_attach("veth1", -1, bpf_program__fd(skel->progs.tc_prog));
+	if (!ASSERT_OK(ret, "attach bpf prog"))
+		goto fail_close_client_ns;
+
+	nstoken_server = open_netns(SERVER_NS);
+	if (!ASSERT_OK_PTR(nstoken_server, "enter server ns"))
+		goto fail_close_client_ns;
+	SYS(fail_close_server_ns, "ip -4 addr add " IP4_ADDR_VETH2 "/24 dev veth2");
+	SYS(fail_close_server_ns, "ip link set veth2 up");
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
+	__u64 rx_bytes_start, rx_bytes_end;
+	double rate_mbps, rate_error;
+	pthread_t server_thread = 0;
+	struct connection *conn;
+	__u64 ts_start, ts_end;
+	int ret;
+
+
+	conn = setup_connection();
+	if (!ASSERT_OK_PTR(conn, "setup client and server connection"))
+		return;
+
+	ret = pthread_create(&server_thread, NULL, run_server,
+			     (void *)(&conn->server_conn_fd));
+	if (!ASSERT_OK(ret, "start server rx thread"))
+		goto end_cleanup_conn;
+	if (!ASSERT_OK(read_rx_bytes(&rx_bytes_start), "read rx_bytes"))
+		goto end_kill_thread;
+	ts_start = get_time_ns();
+	while (true) {
+		send(conn->client_conn_fd, (void *)tx_buffer, BUFFER_LEN, 0);
+		ts_end = get_time_ns();
+		if ((ts_end - ts_start)/100000 >= TIMEOUT_MS) {
+			tx_timeout = true;
+			ret = read_rx_bytes(&rx_bytes_end);
+			if (!ASSERT_OK(ret, "read_rx_bytes"))
+				goto end_cleanup_conn;
+			break;
+		}
+	}
+
+	rate_mbps = (rx_bytes_end - rx_bytes_start) /
+		    ((ts_end - ts_start) / 1000.0);
+	rate_error =
+		fabs((rate_mbps - TARGET_RATE_MBPS) * 100.0 / TARGET_RATE_MBPS);
+	fprintf(stderr, "Rate:\t%f\nError:\t%f\n", rate_mbps, rate_error);
+
+	ASSERT_LE(rate_error, RATE_ERROR_PERCENT,
+		  "rate error is lower than threshold");
+
+end_kill_thread:
+	tx_timeout = true;
+end_cleanup_conn:
+	cleanup_connection(conn);
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

-- 
2.51.1.dirty


