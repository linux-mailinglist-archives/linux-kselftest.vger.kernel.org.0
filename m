Return-Path: <linux-kselftest+bounces-39827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF90BB33B19
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 11:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E7116E5B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C792BE7DD;
	Mon, 25 Aug 2025 09:28:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57834189F43;
	Mon, 25 Aug 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114130; cv=none; b=Pt85NGpoPrTe832cr7XFhH0VdmRN2RH9k7oI/C6C91ruBkO3hpRXut2a22IDHvcX/4R2beF5lLMwVUiVcOwp+XeDwNQXlIS05NlHyGfv2yMG5m1Irc5+zj3LKd73/bxPkjxpqEzfThmkK+R1xcL2rzvaiZP73N7yUckm/AdxuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114130; c=relaxed/simple;
	bh=d5jzDFQ22q5o3bHdowsl+6quFXOdNry3c0jWYQH8vMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAHH4S6nXpckwe+gajJzQIXc7JcSRpkEAFDHf4MdmoQfDJkq7ZlQg3N6MaJLk3Ivw9ZaU5CfVQFXNpqo3KMsRFrC2aBr2w4c9wBqHLwNHyAal0gO5S2kIohU4N7wIMAHz9znFFbVZqElW0zNxEVk2bJLx3VG7mRABxTxqD4UYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests: net: add test for ipv6 fragmentation
Date: Mon, 25 Aug 2025 09:25:32 +0000
Message-ID: <20250825092548.4436-3-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
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

Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
Link: https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/ipv6_fragmentation.c        | 204 ++++++++++++++++++
 3 files changed, 206 insertions(+)
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
index b31a71f2b372..f83f91b758ae 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -117,6 +117,7 @@ TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
+TEST_GEN_PROGS += ipv6_fragmentation
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/ipv6_fragmentation.c b/tools/testing/selftests/net/ipv6_fragmentation.c
new file mode 100644
index 000000000000..21e1a3cdc63d
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_fragmentation.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Brett A C Sheffield <bacs@librecast.net>
+ *
+ * Kernel selftest for the IPv6 fragmentation regression which affected
+ * stable kernels:
+ *
+ *   https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
+ *
+ * Commit:
+ *   a18dfa9925b9 ("ipv6: save dontfrag in cork")
+ * was backported to stable without some prerequisite commits.
+ *
+ * This caused a regression when sending IPv6 UDP packets by preventing
+ * fragmentation and instead returning -1 (EMSGSIZE).
+ *
+ * This selftest demonstrates the issue. sendmsg returns correctly (8192)
+ * on a working kernel, and returns -1 (EMSGSIZE) when the regression is
+ * present.
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
+
+#define MTU 1500
+#define LARGER_THAN_MTU 8192
+
+/* ensure MTU is smaller than what we plan to send */
+static int set_mtu(int ctl, char *ifname, struct ifreq *ifr)
+{
+	ifr->ifr_mtu = MTU;
+	return ioctl(ctl, SIOCSIFMTU, ifr);
+}
+
+/* bring up interface */
+static int interface_up(int ctl, char *ifname, struct ifreq *ifr)
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
+static int create_interface(int ctl, char *ifname, struct ifreq *ifr)
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
+/* we need to set MTU, so do this in a namespace to play nicely */
+static int create_namespace(void)
+{
+	const char *netns_path = "/proc/self/ns/net";
+	int fd;
+
+	if (unshare(CLONE_NEWNET) != 0) {
+		perror("unshare");
+		return -1;
+	}
+
+	fd = open(netns_path, O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return -1;
+	}
+
+	if (setns(fd, CLONE_NEWNET)) {
+		perror("setns");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int setup(void)
+{
+	struct ifreq ifr = {0};
+	char ifname[IFNAMSIZ];
+	int fd = -1;
+	int ctl;
+
+	if (create_namespace() == -1)
+		return -1;
+
+	ctl = socket(AF_LOCAL, SOCK_STREAM, 0);
+	if (ctl == -1)
+		return -1;
+
+	memset(ifname, 0, sizeof(ifname));
+	fd = create_interface(ctl, ifname, &ifr);
+	if (fd == -1)
+		goto err_close_ctl;
+	if (disable_dad(ifname) == -1)
+		goto err_close_fd;
+	if (interface_up(ctl, ifname, &ifr) == -1)
+		goto err_close_fd;
+	if (set_mtu(ctl, ifname, &ifr) == -1)
+		goto err_close_fd;
+	usleep(10000); /* give interface a moment to wake up */
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
+	/* address doesn't matter, use an IPv6 multicast address for simplicity */
+	struct in6_addr addr = {
+		.s6_addr[0] = 0xff, /* multicast */
+		.s6_addr[1] = 0x12, /* set flags (T, link-local) */
+	};
+	struct sockaddr_in6 sa = {
+		.sin6_family = AF_INET6,
+		.sin6_addr = addr,
+		.sin6_port = 4242
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
+	int s;
+
+	printf("Testing IPv6 fragmentation\n");
+	ns_fd = setup();
+	if (ns_fd == -1)
+		return 1;
+	s = socket(AF_INET6, SOCK_DGRAM, 0);
+	msg.msg_name = (struct sockaddr *)&sa;
+	msg.msg_namelen = sizeof(sa);
+	rc = sendmsg(s, &msg, 0);
+	if (rc == -1) {
+		perror("send");
+		return 1;
+	} else if (rc != LARGER_THAN_MTU) {
+		fprintf(stderr, "send() returned %zi\n", rc);
+		return 1;
+	}
+	close(s);
+	close(ns_fd);
+
+	return 0;
+}
-- 
2.49.1


