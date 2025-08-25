Return-Path: <linux-kselftest+bounces-39870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA9B349B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654DD200911
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6652309DA1;
	Mon, 25 Aug 2025 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRDN4405"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7723093C1;
	Mon, 25 Aug 2025 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145097; cv=none; b=HgFEXlm1Xme4L1J4PlTsJMPW4kO4P4cvNRCV6W1wgZmLJqoI4D0K22G8J8zZXE23WapQuCU5Xgs/MFhXPDcFv0KMonjYWP4EAKP/ui+bYxyJ0xDo0OmFupLPsDhncnYA4POJwrxTmaqrA6M8faphUAgCVWmptWjiyX+Ts74m5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145097; c=relaxed/simple;
	bh=Bv8gnM+R6JTfnpLq796Z4/48i+RSYsv8B4KH8gaK1IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgVmBWKGlI+VPHtYekBAWPBzqLrERWf5+nXU7fhjifTWTJlIFdBJyZvujH0kTY5KmHSC3dXJSeegE9NFnfyjPBKGa9yfg26VSz/dQG3RzLthVIG4itf6x0q3R1Og07mdgibassiR3ODvDqc3yCd1gGzSOCGQuqcb12YK9NibdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRDN4405; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F6CC116C6;
	Mon, 25 Aug 2025 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145097;
	bh=Bv8gnM+R6JTfnpLq796Z4/48i+RSYsv8B4KH8gaK1IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jRDN4405LyJxIKWVgpqdN1MI3PtXF992wKIhuBGlccljNaPaUnKHhWCIfPmusJK0/
	 3v43YFcuzE9DpRchb6mA6wcooFOmZEbSgMOmxVV8DCbaFvxXfonQ/XmZltND1abfFy
	 zbQsfYAilpTzdMbYDeTD+KRoABDzRqnxso6v/w4ZqWWMqjUWUWLusLoYDbtORma7ft
	 EpRLTmFSb5zZu99lsEoSND35JwFo3VEViK/r4JRFJ0mlZfua1R1tcjOh49AQTfVtoB
	 oLu7GvVhvW9EIStgnjXWo2Su0pLwIlCIda7HCcrOtQ+XemQqmxPerxzekOmZ8hcit+
	 48VMA+e6/ZXRw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/5] selftests: drv-net: ncdevmem: save IDs of flow rules we added
Date: Mon, 25 Aug 2025 11:04:44 -0700
Message-ID: <20250825180447.2252977-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825180447.2252977-1-kuba@kernel.org>
References: <20250825180447.2252977-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prep for more selective resetting of ntuple filters
try to save the rule IDs to a table.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 141 +++++++++++++-----
 1 file changed, 106 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index e75adfed33ac..8d9d579834b1 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -39,6 +39,7 @@
 #define __EXPORTED_HEADERS__
 
 #include <linux/uio.h>
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -97,6 +98,10 @@ static unsigned int dmabuf_id;
 static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
 
+/* System state loaded by current_config_load() */
+#define MAX_FLOWS	8
+static int ntuple_ids[MAX_FLOWS] = { -1, -1, -1, -1, -1, -1, -1, -1, };
+
 struct memory_buffer {
 	int fd;
 	size_t size;
@@ -281,6 +286,85 @@ int validate_buffer(void *line, size_t size)
 	return 0;
 }
 
+static int
+__run_command(char *out, size_t outlen, const char *cmd, va_list args)
+{
+	char command[256];
+	FILE *fp;
+
+	vsnprintf(command, sizeof(command), cmd, args);
+
+	fprintf(stderr, "Running: %s\n", command);
+	fp = popen(command, "r");
+	if (!fp)
+		return -1;
+	if (out) {
+		size_t len;
+
+		if (!fgets(out, outlen, fp))
+			return -1;
+
+		/* Remove trailing newline if present */
+		len = strlen(out);
+		if (len && out[len - 1] == '\n')
+			out[len - 1] = '\0';
+	}
+	return pclose(fp);
+}
+
+static int run_command(const char *cmd, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, cmd);
+	ret = __run_command(NULL, 0, cmd, args);
+	va_end(args);
+
+	return ret;
+}
+
+static int ethtool_add_flow(const char *format, ...)
+{
+	char local_output[256], cmd[256];
+	const char *id_start;
+	int flow_idx, ret;
+	char *endptr;
+	long flow_id;
+	va_list args;
+
+	for (flow_idx = 0; flow_idx < MAX_FLOWS; flow_idx++)
+		if (ntuple_ids[flow_idx] == -1)
+			break;
+	if (flow_idx == MAX_FLOWS) {
+		fprintf(stderr, "Error: too many flows\n");
+		return -1;
+	}
+
+	snprintf(cmd, sizeof(cmd), "ethtool -N %s %s", ifname, format);
+
+	va_start(args, format);
+	ret = __run_command(local_output, sizeof(local_output), cmd, args);
+	va_end(args);
+
+	if (ret != 0)
+		return ret;
+
+	/* Extract the ID from the output */
+	id_start = strstr(local_output, "Added rule with ID ");
+	if (!id_start)
+		return -1;
+	id_start += strlen("Added rule with ID ");
+
+	flow_id = strtol(id_start, &endptr, 10);
+	if (endptr == id_start || flow_id < 0 || flow_id > INT_MAX)
+		return -1;
+
+	fprintf(stderr, "Added flow rule with ID %ld\n", flow_id);
+	ntuple_ids[flow_idx] = flow_id;
+	return flow_id;
+}
+
 static int rxq_num(int ifindex)
 {
 	struct ethtool_channels_get_req *req;
@@ -308,28 +392,17 @@ static int rxq_num(int ifindex)
 	return num;
 }
 
-#define run_command(cmd, ...)                                           \
-	({                                                              \
-		char command[256];                                      \
-		memset(command, 0, sizeof(command));                    \
-		snprintf(command, sizeof(command), cmd, ##__VA_ARGS__); \
-		fprintf(stderr, "Running: %s\n", command);                       \
-		system(command);                                        \
-	})
-
 static void reset_flow_steering(void)
 {
-	/* Depending on the NIC, toggling ntuple off and on might not
-	 * be allowed. Additionally, attempting to delete existing filters
-	 * will fail if no filters are present. Therefore, do not enforce
-	 * the exit status.
-	 */
+	int i;
 
-	run_command("ethtool -K %s ntuple off >&2", ifname);
-	run_command("ethtool -K %s ntuple on >&2", ifname);
-	run_command(
-		"ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
-		ifname, ifname);
+	for (i = 0; i < MAX_FLOWS; i++) {
+		if (ntuple_ids[i] == -1)
+			continue;
+		run_command("ethtool -N %s delete %d",
+			    ifname, ntuple_ids[i]);
+		ntuple_ids[i] = -1;
+	}
 }
 
 static const char *tcp_data_split_str(int val)
@@ -480,6 +553,7 @@ static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 	const char *type = "tcp6";
 	const char *server_addr;
 	char buf[40];
+	int flow_id;
 
 	inet_ntop(AF_INET6, &server_sin->sin6_addr, buf, sizeof(buf));
 	server_addr = buf;
@@ -490,23 +564,22 @@ static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 	}
 
 	/* Try configure 5-tuple */
-	if (run_command("ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
-			   ifname,
-			   type,
-			   client_ip ? "src-ip" : "",
-			   client_ip ?: "",
-			   server_addr,
-			   client_ip ? "src-port" : "",
-			   client_ip ? port : "",
-			   port, start_queue))
+	flow_id = ethtool_add_flow("flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d",
+				   type,
+				   client_ip ? "src-ip" : "",
+				   client_ip ?: "",
+				   server_addr,
+				   client_ip ? "src-port" : "",
+				   client_ip ? port : "",
+				   port, start_queue);
+	if (flow_id < 0) {
 		/* If that fails, try configure 3-tuple */
-		if (run_command("ethtool -N %s flow-type %s dst-ip %s dst-port %s queue %d >&2",
-				ifname,
-				type,
-				server_addr,
-				port, start_queue))
+		flow_id = ethtool_add_flow("flow-type %s dst-ip %s dst-port %s queue %d",
+					   type, server_addr, port, start_queue);
+		if (flow_id < 0)
 			/* If that fails, return error */
 			return -1;
+	}
 
 	return 0;
 }
@@ -682,8 +755,6 @@ static int do_server(struct memory_buffer *mem)
 		return -1;
 	}
 
-	reset_flow_steering();
-
 	if (configure_headersplit(1)) {
 		pr_err("Failed to enable TCP header split");
 		return -1;
-- 
2.51.0


