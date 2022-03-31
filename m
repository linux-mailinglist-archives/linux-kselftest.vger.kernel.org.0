Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061694EE17A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbiCaTPI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiCaTPG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 15:15:06 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874D23C0EB
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Mar 2022 12:13:12 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 14437 invoked from network); 31 Mar 2022 21:06:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1648753590; bh=8gd/34zfJ5U82zEaxAl8m9q+P0p7nBbi0dKh2gtx344=;
          h=From:To:Cc:Subject;
          b=fXgSZIqaSNsYEzNdIwhYkWtbjnDzH/vS2JWvQoeJ+23gGBc/2ffwo9YdlpU3zXpVB
           VFLzFDD5+g02xbGlF8+jv/vh/Yb2TnRea30ssykBkKoGsw2JtXkwtOswF9B7uWJT4u
           EFKmc6I5Q3YDenVuyEoSaHu3WVlvglPMOSJ0V/kk=
Received: from aaew62.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.126.62])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 31 Mar 2022 21:06:30 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 2/2] [RFC] selftests/rtc: read RTC alarm time many times in a row
Date:   Thu, 31 Mar 2022 21:06:12 +0200
Message-Id: <20220331190612.22162-2-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331190612.22162-1-mat.jonczyk@o2.pl>
References: <20220331190612.22162-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: f8495556d919ce4d1335d5cdb7666e94
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [QcO0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is the userspace part of the test unit.

This patch depends on
commit 2aaa36e95ea5 ("selftests/rtc: continuously read RTC in a loop for 30s")

Existing code casts "struct rtc_time *" to "struct tm *", like so:

	gmtime_r(&secs, (struct tm *)&tm);

This is incorrect, because sizeof(struct tm) > sizeof(struct rtc_time)
(on Ubuntu 20.04 at least) and gmtime_r overwrites part of the stack.
I'll submit a fix for this in mainline soon, but for now I'm defining
timestamp_to_rtc_time() here.

TODO:
- some logic improvements, without much impact on the core algorithm.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/rtc/rtctest.c | 81 ++++++++++++++++++++++++++-
 tools/testing/selftests/rtc/settings  |  2 +-
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 2b9d929a24ed..7e5f2f1c00ef 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -62,7 +62,21 @@ static time_t rtc_time_to_timestamp(struct rtc_time *rtc_time)
 	       .tm_year = rtc_time->tm_year,
 	};
 
-	return mktime(&tm_time);
+	return timegm(&tm_time);
+}
+
+static void timestamp_to_rtc_time(time_t timestamp, struct rtc_time *rtc_time)
+{
+	struct tm tm_time;
+
+	gmtime_r(&timestamp, &tm_time);
+
+	rtc_time->tm_sec = tm_time.tm_sec;
+	rtc_time->tm_min = tm_time.tm_min;
+	rtc_time->tm_hour = tm_time.tm_hour;
+	rtc_time->tm_mday = tm_time.tm_mday;
+	rtc_time->tm_mon = tm_time.tm_mon;
+	rtc_time->tm_year = tm_time.tm_year;
 }
 
 static void nanosleep_with_retries(long ns)
@@ -228,6 +242,71 @@ TEST_F(rtc, alarm_alm_set) {
 	ASSERT_EQ(new, secs);
 }
 
+TEST_F_TIMEOUT(rtc, alarm_read_loop, READ_LOOP_DURATION_SEC + 2) {
+	int rc;
+	long iter_count = 0;
+	struct rtc_time tm;
+	struct timeval start, curr;
+	time_t secs;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	// 60s is for clocks that only support minute resolution of RTC alarm
+	secs = rtc_time_to_timestamp(&tm) + READ_LOOP_DURATION_SEC + 60 + 2;
+	timestamp_to_rtc_time(secs, &tm);
+
+	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_AIE_ON, NULL);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Continuously reading RTC alarm time for %ds (with %dms breaks after every read).",
+	       READ_LOOP_DURATION_SEC, READ_LOOP_SLEEP_MS);
+
+	gettimeofday(&start, NULL);
+
+	secs = 0;
+
+	do {
+		// TODO: use appropriate directory
+		// TODO: fail gracefully if the kernel support does not exist
+		FILE *wkalarm_file = fopen("/sys/kernel/debug/rtc/rtc0/wakealarm_raw", "r");
+		long long wkalarm_time;
+
+		ASSERT_NE(wkalarm_file, NULL);
+
+		rc = fscanf(wkalarm_file, "%lld", &wkalarm_time);
+		fclose(wkalarm_file);
+
+		ASSERT_EQ(rc, 1);
+		ASSERT_NE(secs, -1);
+		// TODO: use another value as placeholder,
+		// TODO: check if wkalarm_time matches alarm time we set
+		// previously
+		if (secs == 0)
+			secs = wkalarm_time;
+
+		ASSERT_EQ(wkalarm_time, secs);
+
+		// Sleep 11ms to avoid killing / overheating the RTC
+		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
+
+		gettimeofday(&curr, NULL);
+		iter_count++;
+	} while (curr.tv_sec <= start.tv_sec + READ_LOOP_DURATION_SEC);
+
+	TH_LOG("Performed %ld RTC alarm time reads.", iter_count);
+
+	rc = ioctl(self->fd, RTC_AIE_OFF, NULL);
+	ASSERT_NE(-1, rc);
+}
+
 TEST_F(rtc, alarm_wkalm_set) {
 	struct timeval tv = { .tv_sec = ALARM_DELTA + 2 };
 	struct rtc_wkalrm alarm = { 0 };
diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
index 0c1a2075d5f3..b478e684846a 100644
--- a/tools/testing/selftests/rtc/settings
+++ b/tools/testing/selftests/rtc/settings
@@ -1 +1 @@
-timeout=210
+timeout=240
-- 
2.25.1

