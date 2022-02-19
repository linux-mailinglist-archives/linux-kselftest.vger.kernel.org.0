Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316204BC6C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Feb 2022 08:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiBSHee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Feb 2022 02:34:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiBSHee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Feb 2022 02:34:34 -0500
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Feb 2022 23:34:15 PST
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4C4EA33
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 23:34:15 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 447 invoked from network); 19 Feb 2022 08:27:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1645255653; bh=iIEKFg4/9zvOOQA7hbIFGUfZTscRhdZoSb+uYnI8SNI=;
          h=From:To:Cc:Subject;
          b=LDHvWM6Plr7cyIB9wnE3nWrAf0Jx3NrA0XJDZ6od0Pf2pkZrxdvliopv0CqbJSvSX
           /B3KjmfYX7x/WqHQx+zem8sYAPYfI49WbpYUO5zPQO8Kuey3I9jS7XbtwptPOLWNsE
           QtbQ44uYavEOkmfs/bXRoKYrdkpBhMXn1ZpmnhKE=
Received: from aaew227.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.126.227])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 19 Feb 2022 08:27:32 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests/rtc: continuously read RTC in a loop for 30s
Date:   Sat, 19 Feb 2022 08:27:13 +0100
Message-Id: <20220219072713.5280-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: a13651b5016d766a77b643366e2ab4a2
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [oaM0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some problems with reading the RTC time may happen rarely, for example
while the RTC is updating. So read the RTC many times to catch these
problems. For example, a previous attempt for my
commit ea6fa4961aab ("rtc: mc146818-lib: fix RTC presence check")
was incorrect and would have triggered this selftest.

To avoid the risk of damaging the hardware, wait 11ms before consecutive
reads.

In rtc_time_to_timestamp I copied values manually instead of casting -
just to be on the safe side. The 11ms wait period was chosen so that it is
not a divisor of 1000ms.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Shuah Khan <shuah@kernel.org>
---

Also, before
commit cdedc45c579f ("rtc: cmos: avoid UIP when reading alarm time")
reading the RTC alarm time during RTC update produced incorrect results
on many Intel platforms. Preparing a similar selftest for this case
would be more difficult, though, because the RTC alarm time is cached by
the kernel. Direct access would have to be exposed somehow, for example
in debugfs. I may prepare a patch for it in the future.
---
 tools/testing/selftests/rtc/rtctest.c | 66 +++++++++++++++++++++++++++
 tools/testing/selftests/rtc/settings  |  2 +-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 66af608fb4c6..2b9d929a24ed 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -20,6 +20,8 @@
 
 #define NUM_UIE 3
 #define ALARM_DELTA 3
+#define READ_LOOP_DURATION_SEC 30
+#define READ_LOOP_SLEEP_MS 11
 
 static char *rtc_file = "/dev/rtc0";
 
@@ -49,6 +51,70 @@ TEST_F(rtc, date_read) {
 	       rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
 }
 
+static time_t rtc_time_to_timestamp(struct rtc_time *rtc_time)
+{
+	struct tm tm_time = {
+	       .tm_sec = rtc_time->tm_sec,
+	       .tm_min = rtc_time->tm_min,
+	       .tm_hour = rtc_time->tm_hour,
+	       .tm_mday = rtc_time->tm_mday,
+	       .tm_mon = rtc_time->tm_mon,
+	       .tm_year = rtc_time->tm_year,
+	};
+
+	return mktime(&tm_time);
+}
+
+static void nanosleep_with_retries(long ns)
+{
+	struct timespec req = {
+		.tv_sec = 0,
+		.tv_nsec = ns,
+	};
+	struct timespec rem;
+
+	while (nanosleep(&req, &rem) != 0) {
+		req.tv_sec = rem.tv_sec;
+		req.tv_nsec = rem.tv_nsec;
+	}
+}
+
+TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
+	int rc;
+	long iter_count = 0;
+	struct rtc_time rtc_tm;
+	time_t start_rtc_read, prev_rtc_read;
+
+	TH_LOG("Continuously reading RTC time for %ds (with %dms breaks after every read).",
+	       READ_LOOP_DURATION_SEC, READ_LOOP_SLEEP_MS);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
+	ASSERT_NE(-1, rc);
+	start_rtc_read = rtc_time_to_timestamp(&rtc_tm);
+	prev_rtc_read = start_rtc_read;
+
+	do  {
+		time_t rtc_read;
+
+		rc = ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
+		ASSERT_NE(-1, rc);
+
+		rtc_read = rtc_time_to_timestamp(&rtc_tm);
+		/* Time should not go backwards */
+		ASSERT_LE(prev_rtc_read, rtc_read);
+		/* Time should not increase more then 1s at a time */
+		ASSERT_GE(prev_rtc_read + 1, rtc_read);
+
+		/* Sleep 11ms to avoid killing / overheating the RTC */
+		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
+
+		prev_rtc_read = rtc_read;
+		iter_count++;
+	} while (prev_rtc_read <= start_rtc_read + READ_LOOP_DURATION_SEC);
+
+	TH_LOG("Performed %ld RTC time reads.", iter_count);
+}
+
 TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
 	int i, rc, irq = 0;
 	unsigned long data;
diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
index a953c96aa16e..0c1a2075d5f3 100644
--- a/tools/testing/selftests/rtc/settings
+++ b/tools/testing/selftests/rtc/settings
@@ -1 +1 @@
-timeout=180
+timeout=210
-- 
2.25.1

