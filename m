Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2395462A272
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 21:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiKOUEg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 15:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKOUEf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 15:04:35 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0FD46;
        Tue, 15 Nov 2022 12:04:33 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0DBD160005;
        Tue, 15 Nov 2022 20:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668542672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ITlVt/jeGn9VZqjZKhktxtIgQCIHZd/QSYTLufVQDT0=;
        b=QsAi9RGHHVUBbzBfzRQOiMeOlwojujmGBVJFuq3NTuDeg3WVmhvJ8JPW0jbRarKhYvYfkj
        uRFg0PT1dI7k6dRbcZr2koa16fXMaI5OhTYxY/EdaFmeHpZHxM2I3VtU/+Npl4bn/c2ksh
        X+r7zLW6BHvvJHo9b/Argq3LpmOv/2ydUi1GppuJwxJmmIXW13P9QfT8Fac2JL9bliuern
        rdYpcUSa6JCzeQ/s5AOgc589BlWBRvdl1nNaDBbaa5omi3pnffJI8R9sFweXwFTbRLod4x
        Zb4Ki/ogDJu60LjvClXwPtW9cOfYIUtEsx385H44xNfBO9UZPfiPDhdHBup0UA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: rtc: skip when RTC is not present
Date:   Tue, 15 Nov 2022 21:04:22 +0100
Message-Id: <20221115200422.2306194-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

There is not point in failing the tests when there the RTC is not present,
simply skip the test.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Tested-by:  Daniel Diaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/rtc/rtctest.c | 33 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 2b9d929a24ed..63ce02d1d5cc 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -31,7 +31,6 @@ FIXTURE(rtc) {
 
 FIXTURE_SETUP(rtc) {
 	self->fd = open(rtc_file, O_RDONLY);
-	ASSERT_NE(-1, self->fd);
 }
 
 FIXTURE_TEARDOWN(rtc) {
@@ -42,6 +41,10 @@ TEST_F(rtc, date_read) {
 	int rc;
 	struct rtc_time rtc_tm;
 
+	if (self->fd == -1 && errno == ENOENT)
+		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+	ASSERT_NE(-1, self->fd);
+
 	/* Read the RTC time/date */
 	rc = ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
 	ASSERT_NE(-1, rc);
@@ -85,6 +88,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
 	struct rtc_time rtc_tm;
 	time_t start_rtc_read, prev_rtc_read;
 
+	if (self->fd == -1 && errno == ENOENT)
+		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+	ASSERT_NE(-1, self->fd);
+
 	TH_LOG("Continuously reading RTC time for %ds (with %dms breaks after every read).",
 	       READ_LOOP_DURATION_SEC, READ_LOOP_SLEEP_MS);
 
@@ -119,6 +126,10 @@ TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
 	int i, rc, irq = 0;
 	unsigned long data;
 
+	if (self->fd == -1 && errno == ENOENT)
+		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+	ASSERT_NE(-1, self->fd);
+
 	/* Turn on update interrupts */
 	rc = ioctl(self->fd, RTC_UIE_ON, 0);
 	if (rc == -1) {
@@ -144,6 +155,10 @@ TEST_F(rtc, uie_select) {
 	int i, rc, irq = 0;
 	unsigned long data;
 
+	if (self->fd == -1 && errno == ENOENT)
+		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+	ASSERT_NE(-1, self->fd);
+
 	/* Turn on update interrupts */
 	rc = ioctl(self->fd, RTC_UIE_ON, 0);
 	if (rc == -1) {
@@ -183,6 +198,10 @@ TEST_F(rtc, alarm_alm_set) {
 	time_t secs, new;
 	int rc;
 
+	if (self->fd == -1 && errno == ENOENT)
+		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+	ASSERT_NE(-1, self->fd);
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
 
@@ -237,6 +256,10 @@ TEST_F(rtc, alarm_wkalm_set) {
 	time_t secs, new;
 	int rc;
 
+	if (self->fd == -1 && errno == ENOENT)
+		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+	ASSERT_NE(-1, self->fd);
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
 
@@ -285,6 +308,10 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 	time_t secs, new;
 	int rc;
 
+	if (self->fd == -1 && errno == ENOENT)
+		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+	ASSERT_NE(-1, self->fd);
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
 	ASSERT_NE(-1, rc);
 
@@ -339,6 +366,10 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 	time_t secs, new;
 	int rc;
 
+	if (self->fd == -1 && errno == ENOENT)
+		SKIP(return, "Skipping test since %s does not exist", rtc_file);
+	ASSERT_NE(-1, self->fd);
+
 	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
 	ASSERT_NE(-1, rc);
 
-- 
2.38.1

