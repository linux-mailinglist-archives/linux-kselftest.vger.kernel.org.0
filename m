Return-Path: <linux-kselftest+bounces-40606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB86B406A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F264D3B1B02
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD46309DBD;
	Tue,  2 Sep 2025 14:25:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD712DF6F4;
	Tue,  2 Sep 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823127; cv=none; b=ZQrAf0J3Oa0LbSRF/vYAGOEt/dqhw6sYjt8NjlK1THVC+nrReqOJ+NJeju4N8by+2JoFajUBuP74cJe4+n7qUrqi+L8arLbzukdhWX57XSzoeNKE74kTCkaprydTDleiM7bgW8ntcO18Q+daAVmfAijUUWP9iRaGFN/Z6AVA3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823127; c=relaxed/simple;
	bh=OziDEvgjS0+NyGCv1K9BX3KL8IQA3n6i6cgi4MKVVDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kdr6oTwVA01tJrKQ/iLeHPc6vnavQtFzFrtms2/1lsEac8H+PsgObgif7CdG3guX7vDKKvARSO7yI7KM/GQjl50yNZpOHPOZ7dbizt/79IB4lVfmQoK1Bhb/5Ku82wKtLUhfYi/7Vmu54x++KMeS/oWbeJSWUriCOg0/FTNlU7k=
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
Subject: [PATCH net-next v5] selftests: net: add test for ipv6 fragmentation
Date: Tue,  2 Sep 2025 14:23:06 +0000
Message-ID: <20250902142502.27278-1-bacs@librecast.net>
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

Link: https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Thanks for the reviews Willem and Jakub.

On 2025-09-01 09:45, Willem de Bruijn wrote:

> > +int main(void)
> > +{
> > +   struct in6_addr addr = {
> > +           .s6_addr[15] = 0x01, /* ::1 */
> > +   };
> > +   struct sockaddr_in6 sa = {
> > +           .sin6_family = AF_INET6,
> > +           .sin6_addr = addr,
> > +           .sin6_port = 9      /* port 9/udp (DISCARD) */
>
> htons

addr is already initialized in network byte order (BE) here.

Verified with:

        char ip6[INET6_ADDRSTRLEN];
        inet_ntop(AF_INET6, &(sa.sin6_addr), ip6, INET6_ADDRSTRLEN);
        printf("The address is %s\n", ip6);

which prints "The address is ::1"

All other suggestions adopted in v5.


v5 changes:
 - disable_dad: delete - not needed for lo
 - main: simplify failure paths
 - main: char -> static char buf
 - setup: remove pointless return value
 - setup: remove unused variable fd
 - setup: merge with interface_up() to simplify
 - setup: check all system call return values
 - remove no longer used headers

v4 changes:
 - fix "else should follow close brace" (checkpatch ERROR)

v3 changes:
 - add usleep instead of busy polling on sendmsg
 - simplify error handling by using error() and leaving cleanup to O/S
 - use loopback interface - don't bother creating TAP
 - send to localhost (::1)

v2 changes:
 - remove superfluous namespace calls - unshare(2) suffices
 - remove usleep(). Don't wait for the interface to be ready, just send, and
   handle the (less likely) error case by retrying.
 - set destination address only once
 - document our use of the IPv6 link-local source address
 - send to port 9 (DISCARD) instead of 4242 (DONT PANIC)
 - ensure sockets are closed on failure paths
 - use KSFT exit codes for clarity

v4: https://lore.kernel.org/netdev/20250901123757.13112-1-bacs@librecast.net
v3: https://lore.kernel.org/netdev/20250901112248.5218-1-bacs@librecast.net
v2: https://lore.kernel.org/netdev/20250831102908.14655-1-bacs@librecast.net
v1: https://lore.kernel.org/netdev/20250825092548.4436-3-bacs@librecast.net

 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/ipv6_fragmentation.c        | 115 ++++++++++++++++++
 3 files changed, 117 insertions(+)
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
index 000000000000..b76ce7b713fc
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_fragmentation.c
@@ -0,0 +1,115 @@
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
+ * This selftest demonstrates the issue by sending an IPv6 UDP packet to
+ * localhost (::1) on the loopback interface from the autoconfigured link-local
+ * address.
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
+#include <error.h>
+#include <net/if.h>
+#include <netinet/in.h>
+#include <sched.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <unistd.h>
+#include "../kselftest.h"
+
+#define MTU 1500
+#define LARGER_THAN_MTU 8192
+
+static void setup(void)
+{
+	struct ifreq ifr = {
+		.ifr_name = "lo"
+	};
+	int ctl;
+
+	/* we need to set MTU, so do this in a namespace to play nicely */
+	if (unshare(CLONE_NEWNET) == -1)
+		error(KSFT_FAIL, errno, "unshare");
+
+	ctl = socket(AF_LOCAL, SOCK_STREAM, 0);
+	if (ctl == -1)
+		error(KSFT_FAIL, errno, "socket");
+
+	/* ensure MTU is smaller than what we plan to send */
+	ifr.ifr_mtu = MTU;
+	if (ioctl(ctl, SIOCSIFMTU, &ifr) == -1)
+		error(KSFT_FAIL, errno, "ioctl: set MTU");
+
+	/* bring up interface */
+	if (ioctl(ctl, SIOCGIFFLAGS, &ifr) == -1)
+		error(KSFT_FAIL, errno, "ioctl SIOCGIFFLAGS");
+	ifr.ifr_flags = ifr.ifr_flags | IFF_UP;
+	if (ioctl(ctl, SIOCSIFFLAGS, &ifr) == -1)
+		error(KSFT_FAIL, errno, "ioctl: bring interface up");
+
+	if (close(ctl) == -1)
+		error(KSFT_FAIL, errno, "close");
+}
+
+int main(void)
+{
+	struct in6_addr addr = {
+		.s6_addr[15] = 0x01, /* ::1 */
+	};
+	struct sockaddr_in6 sa = {
+		.sin6_family = AF_INET6,
+		.sin6_addr = addr,
+		.sin6_port = 9      /* port 9/udp (DISCARD) */
+	};
+	static char buf[LARGER_THAN_MTU] = {0};
+	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_name = (struct sockaddr *)&sa,
+		.msg_namelen = sizeof(sa),
+	};
+	ssize_t rc;
+	int err = KSFT_FAIL;
+	int s;
+
+	printf("Testing IPv6 fragmentation\n");
+	setup();
+	s = socket(AF_INET6, SOCK_DGRAM, 0);
+send_again:
+	rc = sendmsg(s, &msg, 0);
+	if (rc == -1) {
+		/* if interface wasn't ready, try again */
+		if (errno == EADDRNOTAVAIL) {
+			usleep(1000);
+			goto send_again;
+		}
+		error(KSFT_FAIL, errno, "sendmsg");
+	} else if (rc != LARGER_THAN_MTU) {
+		error(KSFT_FAIL, errno, "sendmsg returned %zi, expected %i",
+				rc, LARGER_THAN_MTU);
+	}
+	printf("[PASS] sendmsg() returned %zi\n", rc);
+	err = KSFT_PASS;
+	close(s);
+	return err;
+}

base-commit: cd8a4cfa6bb43a441901e82f5c222dddc75a18a3
-- 
2.49.1


