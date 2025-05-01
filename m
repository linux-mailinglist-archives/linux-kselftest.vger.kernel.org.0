Return-Path: <linux-kselftest+bounces-32061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15112AA5A13
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 05:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3553BE149
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 03:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DDB22F749;
	Thu,  1 May 2025 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOBStwYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A111EA7FF
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746071544; cv=none; b=LDYyIaG62Vq7ZhiJga1v0TYuDUSUti5GdybWtJ5thqEaMkZqiGEZrg/KGNCJ3U+ehS91sxDKn4Z4NnzactT08c/kjlX/RsNEdokvJ+D2WmNAIIleQuDmkVeJoxVqAs4TZfY28udJHLfcdCoIiJBr6GDIdpyZI6xqdcAx8fAGw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746071544; c=relaxed/simple;
	bh=yu3/t0almTXlu0Yz+bohcL+A6kJ6q3fVIK5xnrhJnoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4MnEIAd/X9V0PeKRd4Cu/wZ0W5TuUxN+mlbU/sQR9sG3S3y9tnuSO4MqvMg0mPf8isIXTGLDa0Sx87mOqfE8pfAPLztKTcbGPFHsPKj7MRXoJWUaHK64tU0gYDqdYd211+mZVYpRTahXOs7ZdZvsonlP+7fMKZtF7xOrUh4ZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOBStwYO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746071539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JaneLhUG43644tH2A68YKURNnioeB+AURvStonWWXGQ=;
	b=EOBStwYOkXni5eXcZKSv9z2ZVkQxLhKx0vDs4kokvUa/htrnvwpHfamABq0Nq6ow4Jgmi1
	N/1XSr8T2Q+HCGYjKcv7L+7/zx1eTRMRIFiztdl8aK7hNoi8osIFqC2wuUdsmfAt+ZVdHr
	0KLuuo9ZooHtE+MbB30+5rdeHhsQ34E=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC net-next v1 2/2] selftests/net: Add udp UDP_STOP_RCV selftest
Date: Thu,  1 May 2025 11:51:09 +0800
Message-ID: <20250501035116.69391-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250501035116.69391-1-jiayuan.chen@linux.dev>
References: <20250501035116.69391-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a new selftest, which uses UDP_STOP_RCV to make UDP simulate TCP's
listen and accept.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/test_udp_stop_rcv.c | 275 ++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 tools/testing/selftests/net/test_udp_stop_rcv.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 532bb732bc6d..293f7cd27e5e 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -61,3 +61,4 @@ udpgso
 udpgso_bench_rx
 udpgso_bench_tx
 unix_connect
+test_udp_stop_rcv
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 124078b56fa4..0e8fcca9f133 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -108,6 +108,7 @@ TEST_GEN_PROGS += proc_net_pktgen
 TEST_PROGS += lwt_dst_cache_ref_loop.sh
 TEST_PROGS += skf_net_off.sh
 TEST_GEN_FILES += skf_net_off
+TEST_GEN_FILES += test_udp_stop_rcv
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/test_udp_stop_rcv.c b/tools/testing/selftests/net/test_udp_stop_rcv.c
new file mode 100644
index 000000000000..e01d097a93be
--- /dev/null
+++ b/tools/testing/selftests/net/test_udp_stop_rcv.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <stddef.h>
+#include <arpa/inet.h>
+#include <error.h>
+#include <errno.h>
+#include <net/if.h>
+#include <linux/in.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <netinet/if_ether.h>
+#include <netinet/ip.h>
+#include <netinet/ip6.h>
+#include <netinet/udp.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#ifndef UDP_STOP_RCV
+#define UDP_STOP_RCV	105
+#endif
+
+static bool			cfg_do_ipv4;
+static bool			cfg_do_ipv6;
+
+static char			buf[1024];
+static const char *syn		= "client request";
+static const char *synack	= "server accepted";
+static const char *ack		= "established";
+
+const struct in6_addr addr6 = {
+	{ { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } }, /* 0::1 */
+};
+
+const struct in_addr addr4 = {
+	__constant_htonl(0x7f000001), /* 127.0.0.1 */
+};
+
+static int __send_one(const struct sockaddr *srv, const socklen_t srv_len)
+{
+	int cli_fd = -1, ret = 0;
+
+	cli_fd = socket(srv->sa_family, SOCK_DGRAM, 0);
+	if (cli_fd <= 0)
+		goto err;
+
+	ret = connect(cli_fd, srv, srv_len);
+	if (ret < 0)
+		goto err;
+
+	ret = send(cli_fd, syn, strlen(syn), 0);
+	if (ret != strlen(syn)) {
+		ret = -1;
+		goto err;
+	}
+
+	return cli_fd;
+err:
+	if (cli_fd > 0)
+		close(cli_fd);
+	return -1;
+}
+
+static int send_one(const struct sockaddr *srv, const socklen_t srv_len)
+{
+	int cli_fd;
+
+	cli_fd = __send_one(srv, srv_len);
+	if (cli_fd <= 0)
+		return -1;
+
+	close(cli_fd);
+	return 0;
+}
+
+static int send_many(const struct sockaddr *addr, const socklen_t alen)
+{
+	int i = 0, err;
+
+	for (i = 0; i < 100; i++) {
+		err = send_one(addr, alen);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/*	client			server
+ *	"client request"->
+ *			<-	"server accepted"
+ *	"established"	->
+ */
+static void run_test(struct sockaddr *srv, socklen_t srv_len,
+		     struct sockaddr *cli, socklen_t cli_len)
+{
+	socklen_t size;
+	struct timeval tv = { .tv_sec = 1, .tv_usec = 0 };
+	int one = 1, srv_fd = -1, ret;
+	int session_fd = -1;
+	int cli_fd;
+
+	srv_fd = socket(srv->sa_family, SOCK_DGRAM, 0);
+	if (srv_fd == -1)
+		error(1, errno, "socket srv_fd");
+
+	if (setsockopt(srv_fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)))
+		error(1, errno, "SO_REUSEPORT");
+
+	if (bind(srv_fd, srv, srv_len))
+		error(1, errno, "bind srv_fd");
+
+	if (getsockname(srv_fd, srv, &srv_len))
+		error(1, errno, "getsockname()");
+
+	/* send syn to server */
+	cli_fd = __send_one(srv, srv_len);
+	if (cli_fd < 0)
+		error(1, errno, "new_client_req()");
+
+	ret = recvfrom(srv_fd, (char *)buf, sizeof(buf), MSG_WAITALL, cli, &cli_len);
+	if (ret < 0)
+		error(1, errno, "recvfrom()");
+
+	/* create session for this request */
+	session_fd = socket(srv->sa_family, SOCK_DGRAM, 0);
+	if (session_fd == -1)
+		error(1, errno, "socket session_fd");
+
+	if (setsockopt(session_fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)))
+		error(1, errno, "SO_REUSEPORT");
+
+	/* we ready to bind the server address and do not want to receive any packets */
+	if (setsockopt(session_fd, SOL_UDP, UDP_STOP_RCV, &one, sizeof(one)))
+		error(1, errno, "setsockopt WAIT_CONNECT");
+
+	if (setsockopt(session_fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
+		error(1, errno, "setsockopt SO_RCVTIMEO");
+
+	one = 0;
+	size = sizeof(one);
+	if (getsockopt(session_fd, SOL_UDP, UDP_STOP_RCV, &one, &size) ||
+	    one != 1)
+		error(1, errno, "getsockopt UDP_STOP_RCV");
+
+	/* bind the same address as srv_fd */
+	if (bind(session_fd, srv, srv_len))
+		error(1, errno, "bind srv_fd");
+
+	/* simulate many other requests */
+	if (send_many(srv, srv_len))
+		error(1, errno, "send_many()");
+
+	/* should no data assigned to session_fd
+	 * as we set UDP_STOP_RCV before
+	 */
+	ret = read(session_fd, (char *)buf, sizeof(buf));
+	if (ret > 0)
+		error(1, errno, "session_fd should no data received");
+
+	/* build 4-tuple */
+	ret = connect(session_fd, cli, cli_len);
+	if (ret < 0)
+		error(1, errno, "connect(cli)");
+
+	/* now we are ready to communicate with specified client */
+	one = 0;
+	if (setsockopt(session_fd, SOL_UDP, UDP_STOP_RCV, &one, sizeof(one)))
+		error(1, errno, "setsockopt WAIT_CONNECT");
+
+	/* server sends synack to the client */
+	ret = send(session_fd, synack, strlen(synack), 0);
+	if (ret != strlen(synack))
+		error(1, errno, "send(synack)");
+
+	/* client receives the synack */
+	ret = read(cli_fd, (char *)buf, sizeof(buf));
+	if (ret != strlen(synack))
+		error(1, errno, "read(synack)");
+
+	/* client sends the ack to server */
+	ret = send(cli_fd, ack, strlen(ack), 0);
+	if (ret != strlen(ack))
+		error(1, errno, "send(ack)");
+
+	/* the server should receive the ack */
+	ret = read(session_fd, (char *)buf, sizeof(buf));
+	if (ret != strlen(ack))
+		error(1, errno, "read(ack)");
+
+	/* send many requests that not belongs to the session */
+	if (send_many(srv, srv_len))
+		error(1, errno, "send_many()");
+
+	ret = read(session_fd, (char *)buf, sizeof(buf));
+	if (ret > 0)
+		error(1, errno, "session_fd should no data received");
+
+	if (cli_fd != -1)
+		close(cli_fd);
+	if (srv_fd != -1)
+		close(srv_fd);
+	if (session_fd != -1)
+		close(session_fd);
+}
+
+static void run_test_v4(void)
+{
+	struct sockaddr_in addr = {0};
+	struct sockaddr_in cli = {0};
+
+	addr.sin_family = AF_INET;
+	addr.sin_port = 0;
+	addr.sin_addr = addr4;
+
+	run_test((void *)&addr, sizeof(addr), (void *)&cli, sizeof(cli));
+	fprintf(stderr, "v4 OK\n");
+}
+
+static void run_test_v6(void)
+{
+	struct sockaddr_in6 addr = {0};
+	struct sockaddr_in6 cli = {0};
+
+	addr.sin6_family = AF_INET6;
+	addr.sin6_port = 0;
+	addr.sin6_addr = addr6;
+
+	run_test((void *)&addr, sizeof(addr), (void *)&cli, sizeof(cli));
+	fprintf(stderr, "v6 OK\n");
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "46")) != -1) {
+		switch (c) {
+		case '4':
+			cfg_do_ipv4 = true;
+			break;
+		case '6':
+			cfg_do_ipv6 = true;
+			break;
+		default:
+			error(1, 0, "%s: parse error", argv[0]);
+		}
+	}
+
+	if (!cfg_do_ipv4 && !cfg_do_ipv6) {
+		cfg_do_ipv4 = 1;
+		cfg_do_ipv6 = 1;
+	}
+}
+
+int main(int argc, char **argv)
+{
+	parse_opts(argc, argv);
+
+	if (cfg_do_ipv4)
+		run_test_v4();
+	if (cfg_do_ipv6)
+		run_test_v6();
+
+	fprintf(stderr, "test OK\n");
+	return 0;
+}
-- 
2.47.1


