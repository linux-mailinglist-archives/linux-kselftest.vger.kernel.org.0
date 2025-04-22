Return-Path: <linux-kselftest+bounces-31297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8DA9687D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F821888AC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDCC27CCCC;
	Tue, 22 Apr 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIIFjY7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87427C87D
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323407; cv=none; b=BI7jdcHVIUX5D9tWTD8qr1kVgnKPew3DwdSRJ2uV3c+rk863mnYSW55Rt0b8cTGw+R5FdKXmvzzH6g+W1GYzHSxY7LBKLIpg6jBmSbS0mQIaO9n3FxWpg8p6POcx+mFvV9PxHnfnPllNjOZOpdgml60Z47dbtYRoHR8D+ygP3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323407; c=relaxed/simple;
	bh=hwEoChX1L2vzwWlrmGh2NcDQEWmmf7M1+3jSEfNS6Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZP+sBVkwIpypvs9swSVqBqpIOzUo9BXTFq4cmBP73OLps2oV8lkCgXeST7BptydxhIPm2rn2CriYR47Qqgpbk/QavFGjx40z8mZELPNt00bpxMWsRv6A5TPu/4j++Ar9k5CmZJ+jDTcNTgIde/sFCE7MarlJBjv/7eMYKAbKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIIFjY7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745323404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJnRXzOQCaJKXi2NHYDYlt05TT7J+no58sDMHevlL7s=;
	b=iIIFjY7Q2GqJyROpWoTgBEgXYEk8L3JnoAjK4Mdw5MgEYfBj2LTk8gGPH54zssBFolOxQ+
	23mLNO0Xy0tW+xz0bS+t0ZzqyFHtroqrtfMMxU3ynfIQpbNhWrnx/jngY+E/Utspep6+sj
	NIa/y0VkTOisUOJsYk+TQidUvxDQ3tI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-NXoZzSYqMsahSkmBZr1qDg-1; Tue,
 22 Apr 2025 08:03:20 -0400
X-MC-Unique: NXoZzSYqMsahSkmBZr1qDg-1
X-Mimecast-MFC-AGG-ID: NXoZzSYqMsahSkmBZr1qDg_1745323398
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADAE1180087B;
	Tue, 22 Apr 2025 12:03:17 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBF1D1800361;
	Tue, 22 Apr 2025 12:03:13 +0000 (UTC)
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
Subject: [PATCH 2/4] selftests: can: use kselftest harness in test_raw_filter
Date: Tue, 22 Apr 2025 14:02:35 +0200
Message-ID: <881e71d14711e1e16d74d26fe381fca240163cc5.1745323279.git.fmaurer@redhat.com>
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

Update test_raw_filter to use the kselftest harness to make the test output
conform with TAP. Use the logging and assertations from the harness.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 tools/testing/selftests/net/can/Makefile      |   2 +
 .../selftests/net/can/test_raw_filter.c       | 152 ++++++++----------
 2 files changed, 73 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 44ef37f064ad..5b82e60a03e7 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -2,6 +2,8 @@
 
 top_srcdir = ../../../../..
 
+CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+
 TEST_PROGS := test_raw_filter.sh
 
 TEST_GEN_FILES := test_raw_filter
diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
index c84260f36565..7414b9aef823 100644
--- a/tools/testing/selftests/net/can/test_raw_filter.c
+++ b/tools/testing/selftests/net/can/test_raw_filter.c
@@ -18,6 +18,8 @@
 #include <linux/can.h>
 #include <linux/can/raw.h>
 
+#include "../../kselftest_harness.h"
+
 #define ID 0x123
 #define TC 18 /* # of testcases */
 
@@ -53,7 +55,38 @@ canid_t calc_mask(int testcase)
 	return mask;
 }
 
-int main(int argc, char **argv)
+int send_can_frames(int sock, int testcase)
+{
+	struct can_frame frame;
+
+	frame.can_dlc = 1;
+	frame.data[0] = testcase;
+
+	frame.can_id = ID;
+	if (write(sock, &frame, sizeof(frame)) < 0) {
+		perror("write");
+		return 1;
+	}
+	frame.can_id = (ID | CAN_RTR_FLAG);
+	if (write(sock, &frame, sizeof(frame)) < 0) {
+		perror("write");
+		return 1;
+	}
+	frame.can_id = (ID | CAN_EFF_FLAG);
+	if (write(sock, &frame, sizeof(frame)) < 0) {
+		perror("write");
+		return 1;
+	}
+	frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
+	if (write(sock, &frame, sizeof(frame)) < 0) {
+		perror("write");
+		return 1;
+	}
+
+	return 0;
+}
+
+TEST(can_filter)
 {
 	fd_set rdfs;
 	struct timeval tv;
@@ -67,34 +100,26 @@ int main(int argc, char **argv)
 	int rxbits, rxbitval;
 	int ret;
 	int recv_own_msgs = 1;
-	int err = 0;
 	struct ifreq ifr;
 
-	if ((s = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
-		perror("socket");
-		err = 1;
-		goto out;
-	}
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	ASSERT_LT(0, s)
+		TH_LOG("failed to create CAN_RAW socket (%d)", errno);
 
 	strcpy(ifr.ifr_name, VCANIF);
-	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
-		perror("SIOCGIFINDEX");
-		err = 1;
-		goto out_socket;
-	}
+	ret = ioctl(s, SIOCGIFINDEX, &ifr);
+	ASSERT_LE(0, ret)
+		TH_LOG("failed SIOCGIFINDEX (%d)", errno);
+
 	addr.can_family = AF_CAN;
 	addr.can_ifindex = ifr.ifr_ifindex;
 
 	setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS,
 		   &recv_own_msgs, sizeof(recv_own_msgs));
 
-	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		perror("bind");
-		err = 1;
-		goto out_socket;
-	}
-
-	printf("---\n");
+	ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(0, ret)
+		TH_LOG("failed bind socket (%d)", errno);
 
 	for (testcase = 0; testcase < TC; testcase++) {
 
@@ -103,36 +128,14 @@ int main(int argc, char **argv)
 		setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER,
 			   &rfilter, sizeof(rfilter));
 
-		printf("testcase %2d filters : can_id = 0x%08X can_mask = 0x%08X\n",
+		TH_LOG("testcase %2d filters : can_id = 0x%08X can_mask = 0x%08X",
 		       testcase, rfilter.can_id, rfilter.can_mask);
 
-		printf("testcase %2d sending patterns ... ", testcase);
-
-		frame.can_dlc = 1;
-		frame.data[0] = testcase;
-
-		frame.can_id = ID;
-		if (write(s, &frame, sizeof(frame)) < 0) {
-			perror("write");
-			exit(1);
-		}
-		frame.can_id = (ID | CAN_RTR_FLAG);
-		if (write(s, &frame, sizeof(frame)) < 0) {
-			perror("write");
-			exit(1);
-		}
-		frame.can_id = (ID | CAN_EFF_FLAG);
-		if (write(s, &frame, sizeof(frame)) < 0) {
-			perror("write");
-			exit(1);
-		}
-		frame.can_id = (ID | CAN_EFF_FLAG | CAN_RTR_FLAG);
-		if (write(s, &frame, sizeof(frame)) < 0) {
-			perror("write");
-			exit(1);
-		}
+		TH_LOG("testcase %2d sending patterns...", testcase);
 
-		printf("ok\n");
+		ret = send_can_frames(s, testcase);
+		ASSERT_EQ(0, ret)
+			TH_LOG("failed to send CAN frames");
 
 		have_rx = 1;
 		rx = 0;
@@ -147,58 +150,45 @@ int main(int argc, char **argv)
 			tv.tv_usec = 50000; /* 50ms timeout */
 
 			ret = select(s+1, &rdfs, NULL, NULL, &tv);
-			if (ret < 0) {
-				perror("select");
-				exit(1);
-			}
+			ASSERT_LE(0, ret)
+				TH_LOG("failed select for frame %d (%d)", rx, errno);
 
 			if (FD_ISSET(s, &rdfs)) {
 				have_rx = 1;
 				ret = read(s, &frame, sizeof(struct can_frame));
-				if (ret < 0) {
-					perror("read");
-					exit(1);
-				}
-				if ((frame.can_id & CAN_SFF_MASK) != ID) {
-					fprintf(stderr, "received wrong can_id!\n");
-					exit(1);
-				}
-				if (frame.data[0] != testcase) {
-					fprintf(stderr, "received wrong testcase!\n");
-					exit(1);
-				}
+				ASSERT_LE(0, ret)
+					TH_LOG("failed to read frame %d (%d)", rx, errno);
+
+				ASSERT_EQ(ID, frame.can_id & CAN_SFF_MASK)
+					TH_LOG("received wrong can_id");
+				ASSERT_EQ(testcase, frame.data[0])
+					TH_LOG("received wrong test case");
 
 				/* test & calc rxbits */
 				rxbitval = 1 << ((frame.can_id & (CAN_EFF_FLAG|CAN_RTR_FLAG|CAN_ERR_FLAG)) >> 28);
 
 				/* only receive a rxbitval once */
-				if ((rxbits & rxbitval) == rxbitval) {
-					fprintf(stderr, "received rxbitval %d twice!\n", rxbitval);
-					exit(1);
-				}
+				ASSERT_NE(rxbitval, rxbits & rxbitval)
+					TH_LOG("received rxbitval %d twice", rxbitval);
 				rxbits |= rxbitval;
 				rx++;
 
-				printf("testcase %2d rx : can_id = 0x%08X rx = %d rxbits = %d\n",
+				TH_LOG("testcase %2d rx : can_id = 0x%08X rx = %d rxbits = %d",
 				       testcase, frame.can_id, rx, rxbits);
 			}
 		}
 		/* rx timed out -> check the received results */
-		if (rx_res[testcase] != rx) {
-			fprintf(stderr, "wrong rx value in testcase %d : %d (expected %d)\n",
-				testcase, rx, rx_res[testcase]);
-			exit(1);
-		}
-		if (rxbits_res[testcase] != rxbits) {
-			fprintf(stderr, "wrong rxbits value in testcase %d : %d (expected %d)\n",
-				testcase, rxbits, rxbits_res[testcase]);
-			exit(1);
-		}
-		printf("testcase %2d ok\n---\n", testcase);
+		ASSERT_EQ(rx_res[testcase], rx)
+			TH_LOG("wrong number of received frames %d", testcase);
+		ASSERT_EQ(rxbits_res[testcase], rxbits)
+			TH_LOG("wrong rxbits value in testcase %d", testcase);
+
+		TH_LOG("testcase %2d ok", testcase);
+		TH_LOG("---");
 	}
 
-out_socket:
 	close(s);
-out:
-	return err;
+	return;
 }
+
+TEST_HARNESS_MAIN
-- 
2.49.0


