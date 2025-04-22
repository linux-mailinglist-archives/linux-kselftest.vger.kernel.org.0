Return-Path: <linux-kselftest+bounces-31295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11466A9687A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 14:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811CB3B09E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870127CCC2;
	Tue, 22 Apr 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aqz9QVPA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC945945
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323401; cv=none; b=bN24cnicYo+OzhhnQCDCFNYxPC68mCWjINeaedQHlylAsRyWVEClBtVr96wrDPhbFLEEy+HqrMswCe0Now/R7MJHgOSdRbKwfnB1J92hFZ5ZCtcQGwA5PL2fYn33sTaoL77JT9cf7Gzmm1iNKI8p2umZ4OerGJP63L84kpNrdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323401; c=relaxed/simple;
	bh=cZQXrgP4FmJ3WBlfULIwtCjeg6BCXlWTkTibPinDvLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+37/MXJ3nAu7+7ez4zClgH1tFNbmTTyPcZnL4qdUxFHV/O19UysPSnIkVXwet8ffZaDDE3C155o4l8Ti7ZAEIeHC+pDBKSHLKHah9DYqIOMUnWZL4pbaVEwS9QLbxBl7SZOEaPL+IDrqH5Woa/cY+tbokm3NbI4c5IQr6P3Ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aqz9QVPA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745323399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHlGenlGka2U4/yr1075aVuZFUv2FXBgYYpwHAw6/Z0=;
	b=Aqz9QVPAVMZ8ihTvQwX6jezsQFwfgW4hxdND6AfZeaI5cZP0WfLUSzsJsLfjUlKsRpaijf
	udQhYf/15c3j2nctbzr7gFw1MfWubyFZshnrmMDnrAp6BRMVLIjBb0fjjm7E1XRnL67ASk
	nXYMJNM3oq+W2MRbX4KjYzheA6vPc4Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-DIMvJ2mGPAaddB2qwcC-Kg-1; Tue,
 22 Apr 2025 08:03:15 -0400
X-MC-Unique: DIMvJ2mGPAaddB2qwcC-Kg-1
X-Mimecast-MFC-AGG-ID: DIMvJ2mGPAaddB2qwcC-Kg_1745323394
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9069819560A5;
	Tue, 22 Apr 2025 12:03:13 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3D431800361;
	Tue, 22 Apr 2025 12:03:09 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: socketcan@hartkopp.net,
	mkl@pengutronix.de
Cc: shuah@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dcaratti@redhat.com,
	fstornio@redhat.com
Subject: [PATCH 1/4] selftests: can: Import tst-filter from can-tests
Date: Tue, 22 Apr 2025 14:02:34 +0200
Message-ID: <a4468403cc51ea6c0e8495d7d095befb37aa5aaf.1745323279.git.fmaurer@redhat.com>
In-Reply-To: <cover.1745323279.git.fmaurer@redhat.com>
References: <cover.1745323279.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Tests for the can subsytem have been in the can-tests repository[1] so far.
Start moving the tests to kernel selftests by importing the current
tst-filter test. Subsequent patches will update the test to be more aligned
with the kernel selftests and follow the coding style.

The imported test verifies that the single filters on raw CAN sockets work
as expected.

[1]: https://github.com/linux-can/can-tests

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---

Notes:
    I have removed the long form of the licenses in the beginning of the
    file during the import, as that is covered by the SPDX line anyways. The
    copyright is left as it was originally.

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/net/can/.gitignore    |   2 +
 tools/testing/selftests/net/can/Makefile      |   9 +
 .../selftests/net/can/test_raw_filter.c       | 204 ++++++++++++++++++
 .../selftests/net/can/test_raw_filter.sh      |  37 ++++
 6 files changed, 255 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/.gitignore
 create mode 100644 tools/testing/selftests/net/can/Makefile
 create mode 100644 tools/testing/selftests/net/can/test_raw_filter.c
 create mode 100755 tools/testing/selftests/net/can/test_raw_filter.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 241ca9e260a2..55749b492ebb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5155,6 +5155,7 @@ F:	include/uapi/linux/can/isotp.h
 F:	include/uapi/linux/can/raw.h
 F:	net/can/
 F:	net/sched/em_canid.c
+F:	tools/testing/selftests/net/can/
 
 CAN-J1939 NETWORK LAYER
 M:	Robin van der Gracht <robin@protonic.nl>
@@ -16577,6 +16578,7 @@ X:	net/ceph/
 X:	net/mac80211/
 X:	net/rfkill/
 X:	net/wireless/
+X:	tools/testing/selftests/net/can/
 
 NETWORKING [IPSEC]
 M:	Steffen Klassert <steffen.klassert@secunet.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8daac70c2f9d..e5c9ecd52b73 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -64,6 +64,7 @@ TARGETS += mqueue
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix
+TARGETS += net/can
 TARGETS += net/forwarding
 TARGETS += net/hsr
 TARGETS += net/mptcp
diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
new file mode 100644
index 000000000000..764a53fc837f
--- /dev/null
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
new file mode 100644
index 000000000000..44ef37f064ad
--- /dev/null
+++ b/tools/testing/selftests/net/can/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+top_srcdir = ../../../../..
+
+TEST_PROGS := test_raw_filter.sh
+
+TEST_GEN_FILES := test_raw_filter
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
new file mode 100644
index 000000000000..c84260f36565
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_raw_filter.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright (c) 2011 Volkswagen Group Electronic Research
+ * All rights reserved.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <net/if.h>
+
+#include <linux/can.h>
+#include <linux/can/raw.h>
+
+#define ID 0x123
+#define TC 18 /* # of testcases */
+
+const int rx_res[TC] = {4, 4, 4, 4, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1};
+const int rxbits_res[TC] = {4369, 4369, 4369, 4369, 17, 4352, 17, 4352, 257, 257, 4112, 4112, 1, 256, 16, 4096, 1, 256};
+
+#define VCANIF "vcan0"
+
+canid_t calc_id(int testcase)
+{
+	canid_t id = ID;
+
+	if (testcase & 1)
+		id |= CAN_EFF_FLAG;
+	if (testcase & 2)
+		id |= CAN_RTR_FLAG;
+
+	return id;
+}
+
+canid_t calc_mask(int testcase)
+{
+	canid_t mask = CAN_SFF_MASK;
+
+	if (testcase > 15)
+		return (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG);
+
+	if (testcase & 4)
+		mask |= CAN_EFF_FLAG;
+	if (testcase & 8)
+		mask |= CAN_RTR_FLAG;
+
+	return mask;
+}
+
+int main(int argc, char **argv)
+{
+	fd_set rdfs;
+	struct timeval tv;
+	int s;
+	struct sockaddr_can addr;
+	struct can_filter rfilter;
+	struct can_frame frame;
+	int testcase;
+	int have_rx;
+	int rx;
+	int rxbits, rxbitval;
+	int ret;
+	int recv_own_msgs = 1;
+	int err = 0;
+	struct ifreq ifr;
+
+	if ((s = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
+		perror("socket");
+		err = 1;
+		goto out;
+	}
+
+	strcpy(ifr.ifr_name, VCANIF);
+	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
+		perror("SIOCGIFINDEX");
+		err = 1;
+		goto out_socket;
+	}
+	addr.can_family = AF_CAN;
+	addr.can_ifindex = ifr.ifr_ifindex;
+
+	setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
+		   &recv_own_msgs, sizeof(recv_own_msgs));
+
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("bind");
+		err = 1;
+		goto out_socket;
+	}
+
+	printf("---\n");
+
+	for (testcase = 0; testcase < TC; testcase++) {
+
+		rfilter.can_id   = calc_id(testcase);
+		rfilter.can_mask = calc_mask(testcase);
+		setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER,
+			   &rfilter, sizeof(rfilter));
+
+		printf("testcase %2d filters : can_id = 0x%08X can_mask = 0x%08X\n",
+		       testcase, rfilter.can_id, rfilter.can_mask);
+
+		printf("testcase %2d sending patterns ... ", testcase);
+
+		frame.can_dlc = 1;
+		frame.data[0] = testcase;
+
+		frame.can_id = ID;
+		if (write(s, &frame, sizeof(frame)) < 0) {
+			perror("write");
+			exit(1);
+		}
+		frame.can_id = (ID | CAN_RTR_FLAG);
+		if (write(s, &frame, sizeof(frame)) < 0) {
+			perror("write");
+			exit(1);
+		}
+		frame.can_id = (ID | CAN_EFF_FLAG);
+		if (write(s, &frame, sizeof(frame)) < 0) {
+			perror("write");
+			exit(1);
+		}
+		frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
+		if (write(s, &frame, sizeof(frame)) < 0) {
+			perror("write");
+			exit(1);
+		}
+
+		printf("ok\n");
+
+		have_rx = 1;
+		rx = 0;
+		rxbits = 0;
+
+		while (have_rx) {
+
+			have_rx = 0;
+			FD_ZERO(&rdfs);
+			FD_SET(s, &rdfs);
+			tv.tv_sec = 0;
+			tv.tv_usec = 50000; /* 50ms timeout */
+
+			ret = select(s+1, &rdfs, NULL, NULL, &tv);
+			if (ret < 0) {
+				perror("select");
+				exit(1);
+			}
+
+			if (FD_ISSET(s, &rdfs)) {
+				have_rx = 1;
+				ret = read(s, &frame, sizeof(struct can_frame));
+				if (ret < 0) {
+					perror("read");
+					exit(1);
+				}
+				if ((frame.can_id & CAN_SFF_MASK) != ID) {
+					fprintf(stderr, "received wrong can_id!\n");
+					exit(1);
+				}
+				if (frame.data[0] != testcase) {
+					fprintf(stderr, "received wrong testcase!\n");
+					exit(1);
+				}
+
+				/* test & calc rxbits */
+				rxbitval = 1 << ((frame.can_id & (CAN_EFF_FLAG|CAN_RTR_FLAG|CAN_ERR_FLAG)) >> 28);
+
+				/* only receive a rxbitval once */
+				if ((rxbits & rxbitval) == rxbitval) {
+					fprintf(stderr, "received rxbitval %d twice!\n", rxbitval);
+					exit(1);
+				}
+				rxbits |= rxbitval;
+				rx++;
+
+				printf("testcase %2d rx : can_id = 0x%08X rx = %d rxbits = %d\n",
+				       testcase, frame.can_id, rx, rxbits);
+			}
+		}
+		/* rx timed out -> check the received results */
+		if (rx_res[testcase] != rx) {
+			fprintf(stderr, "wrong rx value in testcase %d : %d (expected %d)\n",
+				testcase, rx, rx_res[testcase]);
+			exit(1);
+		}
+		if (rxbits_res[testcase] != rxbits) {
+			fprintf(stderr, "wrong rxbits value in testcase %d : %d (expected %d)\n",
+				testcase, rxbits, rxbits_res[testcase]);
+			exit(1);
+		}
+		printf("testcase %2d ok\n---\n", testcase);
+	}
+
+out_socket:
+	close(s);
+out:
+	return err;
+}
diff --git a/tools/testing/selftests/net/can/test_raw_filter.sh b/tools/testing/selftests/net/can/test_raw_filter.sh
new file mode 100755
index 000000000000..e5f175c8b27b
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_raw_filter.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+#set -x
+
+ALL_TESTS="
+	test_raw_filter
+"
+
+net_dir=$(dirname $0)/..
+source $net_dir/lib.sh
+
+VCANIF="vcan0"
+
+setup()
+{
+	ip link add name $VCANIF type vcan || exit $ksft_skip
+	ip link set dev $VCANIF up
+	pwd
+}
+
+cleanup()
+{
+	ip link delete $VCANIF
+}
+
+test_raw_filter()
+{
+	./test_raw_filter
+}
+
+trap cleanup EXIT
+setup
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.49.0


