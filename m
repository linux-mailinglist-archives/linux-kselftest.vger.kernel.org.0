Return-Path: <linux-kselftest+bounces-40379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40885B3D21C
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 12:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9613A5A25
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8064324DCE9;
	Sun, 31 Aug 2025 10:29:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF942065;
	Sun, 31 Aug 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756636196; cv=none; b=K7Lac2rwOGo3mjvYSTEixmor88imB7lPOmiVFw/haENVUVnIVvhaEqeuCsORhu5AL8ThgDGosXWu/FGVHkwgei+Hg6AymJ3qaHN+URQxRzB4Lhu0fFhQBZd/1NoQJep21B3RIh94koSbxubbFFHXVwn9RUC6D3XOPWYbWYxB76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756636196; c=relaxed/simple;
	bh=2EsMqCtVHrXT7IjY5w8NhPLpj46DcUqkEIp0+bOlwXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UamtXrf0l6IbofjPvaXn3ePpLZByXYOwVIwFNZu3GkwWLKSHaBQSBhF6p8OjQoKvzTwbclpkehErTmM34h34XC1HGN7JxbPRw9MvO4BE/r3v2W35CyyZs/+kAaW/wYwXrdKbDc0EN13PNUE2LF7LbDAPSZDiLcNh7qml/qQ51rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: willemdebruijn.kernel@gmail.com
Cc: bacs@librecast.net,
	davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	willemb@google.com
Subject: [PATCH net-next v2] selftests: net: add test for ipv6 fragmentation
Date: Sun, 31 Aug 2025 10:18:34 +0000
Message-ID: <20250831102908.14655-1-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <willemdebruijn.kernel.143e90d593cff@gmail.com>
References: <willemdebruijn.kernel.143e90d593cff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftest for the IPv6 fragmentation regression which affected
several stable kernels.

Commit a18dfa9925b9 ("ipv6: save dontfrag in cork") was backported to
stable without some prerequisite commits.  This caused a regression when
sending IPv6 UDP packets by preventing fragmentation and instead
returning -1 (EMSGSIZE).

Add selftest to check for this issue by attempting to send a packet
larger than the interface MTU. The packet will be fragmented on a
working kernel, with sendmsg(2) correctly returning the expected number
of bytes sent.  When the regression is present, sendmsg returns -1 and
sets errno to EMSGSIZE.

Link: https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
Willem: Thanks for the suggestion to check /sys/class/net/$DEV/operstate

I did try this but, if I call unshare() and THEN create a TAP interface in the
new namespace, operstate no longer seems to be visible to the process?

The process can still read operstate for interfaces in the shared namespace, but
not ones created in the unshare()d namespace.

I'm sure I'm doing something wrong there, but after trying a few different
things including reading operstate from netlink it suddenly occurred to me that
a simpler and more reliable way to check whether an interface is ready to send
is to, er, send, and then handle the error for the (unlikely) failure case and
retry.

I've incorporated your other review suggestions in this v2. Many thanks.

v2 changes:
 - remove superfluous namespace calls - unshare(2) suffices
 - remove usleep(). Don't wait for the interface to be ready, just send, and
   handle the (less likely) error case by retrying.
 - set destination address only once
 - document our use of the IPv6 link-local source address
 - send to port 9 (DISCARD) instead of 4242 (DONT PANIC)
 - ensure sockets are closed on failure paths
 - use KSFT exit codes for clarity

v1: https://lore.kernel.org/netdev/20250825092548.4436-3-bacs@librecast.net

 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/ipv6_fragmentation.c        | 189 ++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/net/ipv6_fragmentation.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 47c293c2962f..3d4b4a53dfda 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -16,6 +16,7 @@ ip_local_port_range
 ipsec
 ipv6_flowlabel
 ipv6_flowlabel_mgr
+ipv6_fragmentation
 log.txt
 msg_oob
 msg_zerocopy
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index eef0b8f8a7b0..276e0481d996 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -117,6 +117,7 @@ TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
+TEST_GEN_PROGS += ipv6_fragmentation
 TEST_PROGS += route_hint.sh
 
 # YNL files, must be before "include ..lib.mk"
diff --git a/tools/testing/selftests/net/ipv6_fragmentation.c b/tools/testing/selftests/net/ipv6_fragmentation.c
new file mode 100644
index 000000000000..4ba16bf56a32
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_fragmentation.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Brett A C Sheffield <bacs@librecast.net>
+ *
+ * Kernel selftest for the IPv6 fragmentation regression which affected stable
+ * kernels:
+ *
+ *   https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
+ *
+ * Commit: a18dfa9925b9 ("ipv6: save dontfrag in cork") was backported to stable
+ * without some prerequisite commits.
+ *
+ * This caused a regression when sending IPv6 UDP packets by preventing
+ * fragmentation and instead returning -1 (EMSGSIZE).
+ *
+ * This selftest demonstrates the issue by sending an IPv6 UDP packet from
+ * the autoconfigured link-local address to an arbritrary multicast group.
+ *
+ * sendmsg(2) returns bytes sent correctly on a working kernel, and returns -1
+ * (EMSGSIZE) when the regression is present.
+ *
+ * The regression was not present in the mainline kernel, but add this test to
+ * catch similar breakage in future.
+ */
+
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <linux/if_tun.h>
+#include <net/if.h>
+#include <netinet/in.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <unistd.h>
+#include "../kselftest.h"
+
+#define MTU 1500
+#define LARGER_THAN_MTU 8192
+
+/* ensure MTU is smaller than what we plan to send */
+static int set_mtu(int ctl, struct ifreq *ifr)
+{
+	ifr->ifr_mtu = MTU;
+	return ioctl(ctl, SIOCSIFMTU, ifr);
+}
+
+/* bring up interface */
+static int interface_up(int ctl, struct ifreq *ifr)
+{
+	if (ioctl(ctl, SIOCGIFFLAGS, ifr) == -1) {
+		perror("ioctl SIOCGIFFLAGS");
+		return -1;
+	}
+	ifr->ifr_flags = ifr->ifr_flags | IFF_UP;
+	return ioctl(ctl, SIOCSIFFLAGS, ifr);
+}
+
+/* no need to wait for DAD in our namespace */
+static int disable_dad(char *ifname)
+{
+	char sysvar[] = "/proc/sys/net/ipv6/conf/%s/accept_dad";
+	char fname[IFNAMSIZ + sizeof(sysvar)];
+	int fd;
+
+	snprintf(fname, sizeof(fname), sysvar, ifname);
+	fd = open(fname, O_WRONLY);
+	if (fd == -1) {
+		perror("open accept_dad");
+		return -1;
+	}
+	if (write(fd, "0", 1) != 1) {
+		perror("write");
+		return -1;
+	}
+	return close(fd);
+}
+
+/* create TAP interface that will be deleted when this process exits */
+static int create_interface(char *ifname, struct ifreq *ifr)
+{
+	int fd;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd == -1) {
+		perror("open tun");
+		return -1;
+	}
+
+	ifr->ifr_flags = IFF_TAP | IFF_NO_PI;
+	if (ioctl(fd, TUNSETIFF, (void *)ifr) == -1) {
+		close(fd);
+		perror("ioctl: TUNSETIFF");
+		return -1;
+	}
+	strcpy(ifname, ifr->ifr_name);
+
+	return fd;
+}
+
+static int setup(void)
+{
+	struct ifreq ifr = {0};
+	char ifname[IFNAMSIZ];
+	int fd = -1;
+	int ctl;
+
+	/* we need to set MTU, so do this in a namespace to play nicely */
+	if (unshare(CLONE_NEWNET) == -1)
+		return -1;
+
+	ctl = socket(AF_LOCAL, SOCK_STREAM, 0);
+	if (ctl == -1)
+		return -1;
+
+	memset(ifname, 0, sizeof(ifname));
+	fd = create_interface(ifname, &ifr);
+	if (fd == -1)
+		goto err_close_ctl;
+	if (disable_dad(ifname) == -1)
+		goto err_close_fd;
+	if (interface_up(ctl, &ifr) == -1)
+		goto err_close_fd;
+	if (set_mtu(ctl, &ifr) == -1)
+		goto err_close_fd;
+	goto err_close_ctl;
+err_close_fd:
+	close(fd);
+	fd = -1;
+err_close_ctl:
+	close(ctl);
+	return fd;
+}
+
+int main(void)
+{
+	/* destination doesn't matter, use an IPv6 link-local multicast group */
+	struct in6_addr addr = {
+		.s6_addr[0] = 0xff, /* multicast */
+		.s6_addr[1] = 0x12, /* set flags (T, link-local) */
+	};
+	struct sockaddr_in6 sa = {
+		.sin6_family = AF_INET6,
+		.sin6_addr = addr,
+		.sin6_port = 9      /* port 9/udp (DISCARD) */
+	};
+	char buf[LARGER_THAN_MTU] = {0};
+	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf)};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_name = (struct sockaddr *)&sa,
+		.msg_namelen = sizeof(sa),
+	};
+	ssize_t rc;
+	int ns_fd;
+	int err = KSFT_FAIL;
+	int s;
+
+	printf("Testing IPv6 fragmentation\n");
+	ns_fd = setup();
+	if (ns_fd == -1) {
+		printf("[FAIL] test setup failed\n");
+		return KSFT_FAIL;
+	}
+	s = socket(AF_INET6, SOCK_DGRAM, 0);
+send_again:
+	rc = sendmsg(s, &msg, 0);
+	if (rc == -1) {
+		/* if interface wasn't ready, try again */
+		if (errno == EADDRNOTAVAIL)
+			goto send_again;
+		printf("[FAIL] sendmsg: %s\n", strerror(errno));
+		goto err_close_socket;
+	} else if (rc != LARGER_THAN_MTU) {
+		printf("[FAIL] sendmsg() returned %zi\n", rc);
+		goto err_close_socket;
+	}
+	printf("[PASS] sendmsg() returned %zi\n", rc);
+	err = KSFT_PASS;
+
+err_close_socket:
+	close(s);
+	close(ns_fd);
+	return err;
+}
-- 
2.49.1


