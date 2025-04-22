Return-Path: <linux-kselftest+bounces-31296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F77BA9687C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 14:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE3417C54B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CDF27CB30;
	Tue, 22 Apr 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAHUeYZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147F202F7B
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323407; cv=none; b=NE3CSLhxaVdwETdYFEpMCHFzvJG6PT4ZhbqZRqy2zEWER7+wV+VFUVHPU38vMArSbyXXWUhUfYbFRIWl05PbKBtxi0lB48AwiW+U0bAg8ijHp1NZ9xDbOjEEBrvMPoZLVMSwcFS8eYszQSjRxF0te+25+FQWM2MZ7a51FcBID6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323407; c=relaxed/simple;
	bh=3xeiMrfUMumlBjOXRB1EDU2Wq96MO/i8krXiujM7u3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2LyzF+Rb8DbYT/J9diXo0IOWDeOLsBugQ40rjdByoq4V9jOj8IsFwk6I5iGETvsJHfCsb5djZI13lw2+4F7unr3p9PagJpJ7hsRFefqg0JEhWzJpTAlUypX1vgZYtM6ZO5/UII7KAWM6eLOH18t1b7Lpi/QIh+0esglfSBTvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAHUeYZP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745323404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b69Z+2j5OxxllIcto/9tmcI5LzjXFbIUfbjFUn1kZA=;
	b=MAHUeYZPIkYu5PkXOYHn8/XjYqyO7x/lLpW6bitld9WtUuyrwqsjTAFpTATsNRBt9YhUR9
	uMYC4sXxM45hve/ji+PmbXb+F23zQtGLR/i8LXnEwX8VENB+CPghhh7RGVRepR0a5WSqFf
	kISxvBKZOIsdvgT4C5j1lP3kxGwbxrc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-YH-ukvg8Pv6sbQgGWFEsaA-1; Tue,
 22 Apr 2025 08:03:23 -0400
X-MC-Unique: YH-ukvg8Pv6sbQgGWFEsaA-1
X-Mimecast-MFC-AGG-ID: YH-ukvg8Pv6sbQgGWFEsaA_1745323401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C439C1956095;
	Tue, 22 Apr 2025 12:03:21 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23138180045C;
	Tue, 22 Apr 2025 12:03:17 +0000 (UTC)
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
Subject: [PATCH 3/4] selftests: can: Use fixtures in test_raw_filter
Date: Tue, 22 Apr 2025 14:02:36 +0200
Message-ID: <8b0e7642b63dfe9de85e3fe65f806843b42d3754.1745323279.git.fmaurer@redhat.com>
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

Use fixtures in test_raw_filter instead of generating the test inputs
during execution. This should make tests easier to follow and extend.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 .../selftests/net/can/test_raw_filter.c       | 311 ++++++++++++------
 1 file changed, 211 insertions(+), 100 deletions(-)

diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
index 7414b9aef823..7fe11e020a1c 100644
--- a/tools/testing/selftests/net/can/test_raw_filter.c
+++ b/tools/testing/selftests/net/can/test_raw_filter.c
@@ -18,43 +18,13 @@
 #include <linux/can.h>
 #include <linux/can/raw.h>
 
+#define TH_LOG_ENABLED 0
 #include "../../kselftest_harness.h"
 
 #define ID 0x123
-#define TC 18 /* # of testcases */
-
-const int rx_res[TC] = {4, 4, 4, 4, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1};
-const int rxbits_res[TC] = {4369, 4369, 4369, 4369, 17, 4352, 17, 4352, 257, 257, 4112, 4112, 1, 256, 16, 4096, 1, 256};
 
 #define VCANIF "vcan0"
 
-canid_t calc_id(int testcase)
-{
-	canid_t id = ID;
-
-	if (testcase & 1)
-		id |= CAN_EFF_FLAG;
-	if (testcase & 2)
-		id |= CAN_RTR_FLAG;
-
-	return id;
-}
-
-canid_t calc_mask(int testcase)
-{
-	canid_t mask = CAN_SFF_MASK;
-
-	if (testcase > 15)
-		return (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG);
-
-	if (testcase & 4)
-		mask |= CAN_EFF_FLAG;
-	if (testcase & 8)
-		mask |= CAN_RTR_FLAG;
-
-	return mask;
-}
-
 int send_can_frames(int sock, int testcase)
 {
 	struct can_frame frame;
@@ -86,21 +56,16 @@ int send_can_frames(int sock, int testcase)
 	return 0;
 }
 
-TEST(can_filter)
+FIXTURE(can_filters) {
+	int sock;
+};
+
+FIXTURE_SETUP(can_filters)
 {
-	fd_set rdfs;
-	struct timeval tv;
-	int s;
 	struct sockaddr_can addr;
-	struct can_filter rfilter;
-	struct can_frame frame;
-	int testcase;
-	int have_rx;
-	int rx;
-	int rxbits, rxbitval;
-	int ret;
-	int recv_own_msgs = 1;
 	struct ifreq ifr;
+	int recv_own_msgs = 1;
+	int s, ret;
 
 	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
 	ASSERT_LT(0, s)
@@ -121,74 +86,220 @@ TEST(can_filter)
 	ASSERT_EQ(0, ret)
 		TH_LOG("failed bind socket (%d)", errno);
 
-	for (testcase = 0; testcase < TC; testcase++) {
+	self->sock = s;
+}
+
+FIXTURE_TEARDOWN(can_filters)
+{
+	close(self->sock);
+}
 
-		rfilter.can_id   = calc_id(testcase);
-		rfilter.can_mask = calc_mask(testcase);
-		setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER,
-			   &rfilter, sizeof(rfilter));
+FIXTURE_VARIANT(can_filters) {
+	int testcase;
+	canid_t id;
+	canid_t mask;
+	int exp_num_rx;
+	int exp_rxbits;
+};
+
+FIXTURE_VARIANT_ADD(can_filters, base) {
+	.testcase = 1,
+	.id = ID,
+	.mask = CAN_SFF_MASK,
+	.exp_num_rx = 4,
+	.exp_rxbits = 4369,
+};
+FIXTURE_VARIANT_ADD(can_filters, base_eff) {
+	.testcase = 2,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_SFF_MASK,
+	.exp_num_rx = 4,
+	.exp_rxbits = 4369,
+};
+FIXTURE_VARIANT_ADD(can_filters, base_rtr) {
+	.testcase = 3,
+	.id = ID | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK,
+	.exp_num_rx = 4,
+	.exp_rxbits = 4369,
+};
+FIXTURE_VARIANT_ADD(can_filters, base_effrtr) {
+	.testcase = 4,
+	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK,
+	.exp_num_rx = 4,
+	.exp_rxbits = 4369,
+};
+
+FIXTURE_VARIANT_ADD(can_filters, filter_eff) {
+	.testcase = 5,
+	.id = ID,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
+	.exp_num_rx = 2,
+	.exp_rxbits = 17,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_eff_eff) {
+	.testcase = 6,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
+	.exp_num_rx = 2,
+	.exp_rxbits = 4352,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_eff_rtr) {
+	.testcase = 7,
+	.id = ID | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
+	.exp_num_rx = 2,
+	.exp_rxbits = 17,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_eff_effrtr) {
+	.testcase = 8,
+	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG,
+	.exp_num_rx = 2,
+	.exp_rxbits = 4352,
+};
+
+FIXTURE_VARIANT_ADD(can_filters, filter_rtr) {
+	.testcase = 9,
+	.id = ID,
+	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
+	.exp_num_rx = 2,
+	.exp_rxbits = 257,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_rtr_eff) {
+	.testcase = 10,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
+	.exp_num_rx = 2,
+	.exp_rxbits = 257,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_rtr_rtr) {
+	.testcase = 11,
+	.id = ID | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
+	.exp_num_rx = 2,
+	.exp_rxbits = 4112,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_rtr_effrtr) {
+	.testcase = 12,
+	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_RTR_FLAG,
+	.exp_num_rx = 2,
+	.exp_rxbits = 4112,
+};
+
+FIXTURE_VARIANT_ADD(can_filters, filter_effrtr) {
+	.testcase = 13,
+	.id = ID,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_rxbits = 1,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_eff) {
+	.testcase = 14,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_rxbits = 256,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_rtr) {
+	.testcase = 15,
+	.id = ID | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_rxbits = 16,
+};
+FIXTURE_VARIANT_ADD(can_filters, filter_effrtr_effrtr) {
+	.testcase = 16,
+	.id = ID | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.mask = CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_rxbits = 4096,
+};
+
+FIXTURE_VARIANT_ADD(can_filters, eff) {
+	.testcase = 17,
+	.id = ID,
+	.mask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_rxbits = 1,
+};
+FIXTURE_VARIANT_ADD(can_filters, eff_eff) {
+	.testcase = 18,
+	.id = ID | CAN_EFF_FLAG,
+	.mask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG,
+	.exp_num_rx = 1,
+	.exp_rxbits = 256,
+};
+
+TEST_F(can_filters, test_filter)
+{
+	fd_set rdfs;
+	struct timeval tv;
+	struct can_filter rfilter;
+	struct can_frame frame;
+	int have_rx;
+	int rx;
+	int rxbits, rxbitval;
+	int ret;
 
-		TH_LOG("testcase %2d filters : can_id = 0x%08X can_mask = 0x%08X",
-		       testcase, rfilter.can_id, rfilter.can_mask);
+	rfilter.can_id = variant->id;
+	rfilter.can_mask = variant->mask;
+	setsockopt(self->sock, SOL_CAN_RAW, CAN_RAW_FILTER,
+		   &rfilter, sizeof(rfilter));
 
-		TH_LOG("testcase %2d sending patterns...", testcase);
+	TH_LOG("filters: can_id = 0x%08X can_mask = 0x%08X",
+		rfilter.can_id, rfilter.can_mask);
 
-		ret = send_can_frames(s, testcase);
-		ASSERT_EQ(0, ret)
-			TH_LOG("failed to send CAN frames");
+	ret = send_can_frames(self->sock, variant->testcase);
+	ASSERT_EQ(0, ret)
+		TH_LOG("failed to send CAN frames");
 
-		have_rx = 1;
-		rx = 0;
-		rxbits = 0;
+	rx = 0;
+	rxbits = 0;
 
-		while (have_rx) {
+	do {
+		have_rx = 0;
+		FD_ZERO(&rdfs);
+		FD_SET(self->sock, &rdfs);
+		tv.tv_sec = 0;
+		tv.tv_usec = 50000; /* 50ms timeout */
 
-			have_rx = 0;
-			FD_ZERO(&rdfs);
-			FD_SET(s, &rdfs);
-			tv.tv_sec = 0;
-			tv.tv_usec = 50000; /* 50ms timeout */
+		ret = select(self->sock + 1, &rdfs, NULL, NULL, &tv);
+		ASSERT_LE(0, ret)
+			TH_LOG("failed select for frame %d (%d)", rx, errno);
 
-			ret = select(s+1, &rdfs, NULL, NULL, &tv);
+		if (FD_ISSET(self->sock, &rdfs)) {
+			have_rx = 1;
+			ret = read(self->sock, &frame, sizeof(struct can_frame));
 			ASSERT_LE(0, ret)
-				TH_LOG("failed select for frame %d (%d)", rx, errno);
-
-			if (FD_ISSET(s, &rdfs)) {
-				have_rx = 1;
-				ret = read(s, &frame, sizeof(struct can_frame));
-				ASSERT_LE(0, ret)
-					TH_LOG("failed to read frame %d (%d)", rx, errno);
-
-				ASSERT_EQ(ID, frame.can_id & CAN_SFF_MASK)
-					TH_LOG("received wrong can_id");
-				ASSERT_EQ(testcase, frame.data[0])
-					TH_LOG("received wrong test case");
-
-				/* test & calc rxbits */
-				rxbitval = 1 << ((frame.can_id & (CAN_EFF_FLAG|CAN_RTR_FLAG|CAN_ERR_FLAG)) >> 28);
-
-				/* only receive a rxbitval once */
-				ASSERT_NE(rxbitval, rxbits & rxbitval)
-					TH_LOG("received rxbitval %d twice", rxbitval);
-				rxbits |= rxbitval;
-				rx++;
-
-				TH_LOG("testcase %2d rx : can_id = 0x%08X rx = %d rxbits = %d",
-				       testcase, frame.can_id, rx, rxbits);
-			}
+				TH_LOG("failed to read frame %d (%d)", rx, errno);
+
+			ASSERT_EQ(ID, frame.can_id & CAN_SFF_MASK)
+				TH_LOG("received wrong can_id");
+			ASSERT_EQ(variant->testcase, frame.data[0])
+				TH_LOG("received wrong test case");
+
+			/* test & calc rxbits */
+			rxbitval = 1 << ((frame.can_id & (CAN_EFF_FLAG|CAN_RTR_FLAG|CAN_ERR_FLAG)) >> 28);
+
+			/* only receive a rxbitval once */
+			ASSERT_NE(rxbitval, rxbits & rxbitval)
+				TH_LOG("received rxbitval %d twice", rxbitval);
+			rxbits |= rxbitval;
+			rx++;
+
+			TH_LOG("rx: can_id = 0x%08X rx = %d rxbits = %d",
+			       frame.can_id, rx, rxbits);
 		}
-		/* rx timed out -> check the received results */
-		ASSERT_EQ(rx_res[testcase], rx)
-			TH_LOG("wrong number of received frames %d", testcase);
-		ASSERT_EQ(rxbits_res[testcase], rxbits)
-			TH_LOG("wrong rxbits value in testcase %d", testcase);
-
-		TH_LOG("testcase %2d ok", testcase);
-		TH_LOG("---");
-	}
+	} while (have_rx);
 
-	close(s);
-	return;
+	/* rx timed out -> check the received results */
+	ASSERT_EQ(variant->exp_num_rx, rx)
+		TH_LOG("wrong number of received frames");
+	ASSERT_EQ(variant->exp_rxbits, rxbits)
+		TH_LOG("wrong rxbits value");
 }
 
 TEST_HARNESS_MAIN
-- 
2.49.0


