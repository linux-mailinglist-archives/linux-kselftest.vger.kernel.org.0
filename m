Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C148621E9B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 22:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKHVfd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 16:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiKHVf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 16:35:28 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9F209A6;
        Tue,  8 Nov 2022 13:35:25 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AAA201BF205;
        Tue,  8 Nov 2022 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667943324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCLyGwO1Xxk3zWiEn/dL2L73JGzyw9SmIaEKSzws54s=;
        b=hdUWf66MQzclRACZNucO0q0zdoDiIl6fyhz5kph6YAxzgm8zFimRMA/WLkC4XqEPsaf52p
        fupqFb5U4ViGXboPpm5eF/69Q/mRcf2xPN/sfiEPAKMvQLXlODY6jCHKJzGpUZyGdO3qaf
        5jI6b1Kr8FS3/CAHkEG0HUvUd1DY103L3k5ahE7F+mwrnYTA23CMyLC+kMBPom31BU30BG
        t9v2ekXwuqlgSCtiISFyGBszAvcgS2qLADT+bcGPuRQDYEN+Y60RKOfsHLw9lqDd70d16+
        1xI0IFL9MqvEszxyWGHtbZ7WnS/M+pPzUU2/5Rnonr+SG2dhk67j6KiGn8ocNQ==
Date:   Tue, 8 Nov 2022 22:35:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: kselftest rtctests failed on arm64 Raspberry Pi 4 -
 rtctest.c:34:date_read:Expected -1 (-1) != self->fd (-1)
Message-ID: <Y2rLm3O2mrG7PcZN@mail.local>
References: <CA+G9fYvBtwi8jmQZNvYwjR425BXGgCG2ej3iE6gtgfRzZmQnOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvBtwi8jmQZNvYwjR425BXGgCG2ej3iE6gtgfRzZmQnOw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On 08/11/2022 15:17:04+0530, Naresh Kamboju wrote:
> kselftest rtctests failed on arm64 Raspberry Pi 4 Model B device and
> passed on other devices and qemu emulators. Please refer to the
> full logs and test comparison results links.
> 

It seems your board doesn't have an rtc at all, the tests will not run
unless you add one.

You can try the following patch:

From e93ddc7046aba97b39b0ceffc53ebf1f10ad9868 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 8 Nov 2022 22:18:55 +0100
Subject: [PATCH] selftests: rtc: skip when RTC is not present

There is not point in failing the tests when there the RTC is not present,
simply skip the test.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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

> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test run log:
> -------------
> 
> [  248.627989] kselftest: Running tests in rtc
> TAP version 13
> 1..1
> # selftests: rtc: rtctest
> [  249.116824] audit: type=1701 audit(1651167970.071:12):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2818 comm=\"rtctest\"
> exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
> [  249.133837] audit: type=1701 audit(1651167970.079:13):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2819 comm=\"rtctest\"
> exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
> [  249.151179] audit: type=1701 audit(1651167970.083:14):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2820 comm=\"rtctest\"
> exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
> [  249.168401] audit: type=1701 audit(1651167970.091:15):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2821 comm=\"rtctest\"
> exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
> [  249.185406] audit: type=1701 audit(1651167970.095:16):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2822 comm=\"rtctest\"
> exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
> [  249.202343] audit: type=1701 audit(1651167970.103:17):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2823 comm=\"rtctest\"
> exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
> #[  249.219262] audit: type=1701 audit(1651167970.111:18):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2824 comm=\"rtctest\"
> exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
>  [  249.236233] audit: type=1701 audit(1651167970.115:19):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2825 comm=\"rtctest\"
> exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
> TAP version 13
> # 1..8
> # # Starting 8 tests from 2 test cases.
> # #  RUN           rtc.date_read ...
> # # rtctest.c:34:date_read:Expected -1 (-1) != self->fd (-1)
> # # date_read: Test terminated by assertion
> # #          FAIL  rtc.date_read
> # not ok 1 rtc.date_read
> # #  RUN           rtc.date_read_loop ...
> # # rtctest.c:34:date_read_loop:Expected -1 (-1) != self->fd (-1)
> # # date_read_loop: Test terminated by assertion
> # #          FAIL  rtc.date_read_loop
> # not ok 2 rtc.date_read_loop
> # #  RUN           rtc.uie_read ...
> # # rtctest.c:34:uie_read:Expected -1 (-1) != self->fd (-1)
> # # uie_read: Test terminated by assertion
> # #          FAIL  rtc.uie_read
> # not ok 3 rtc.uie_read
> # #  RUN           rtc.uie_select ...
> # # rtctest.c:34:uie_select:Expected -1 (-1) != self->fd (-1)
> # # uie_select: Test terminated by assertion
> # #          FAIL  rtc.uie_select
> # not ok 4 rtc.uie_select
> # #  RUN           rtc.alarm_alm_set ...
> # # rtctest.c:34:alarm_alm_set:Expected -1 (-1) != self->fd (-1)
> # # alarm_alm_set: Test terminated by assertion
> # #          FAIL  rtc.alarm_alm_set
> # not ok 5 rtc.alarm_alm_set
> # #  RUN           rtc.alarm_wkalm_set ...
> # # rtctest.c:34:alarm_wkalm_set:Expected -1 (-1) != self->fd (-1)
> # # alarm_wkalm_set: Test terminated by assertion
> # #          FAIL  rtc.alarm_wkalm_set
> # not ok 6 rtc.alarm_wkalm_set
> # #  RUN           rtc.alarm_alm_set_minute ...
> # # rtctest.c:34:alarm_alm_set_minute:Expected -1 (-1) != self->fd (-1)
> # # alarm_alm_set_minute: Test terminated by assertion
> # #          FAIL  rtc.alarm_alm_set_minute
> # not ok 7 rtc.alarm_alm_set_minute
> # #  RUN           rtc.alarm_wkalm_set_minute ...
> # # rtctest.c:34:alarm_wkalm_set_minute:Expected -1 (-1) != self->fd (-1)
> # # alarm_wkalm_set_minute: Test terminated by assertion
> # #          FAIL  rtc.alarm_wkalm_set_minute
> # not ok 8 rtc.alarm_wkalm_set_minute
> # # FAILED: 0 / 8 tests passed.
> # # Totals: pass:0 fail:8 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: rtc: rtctest # exit=1
> 
> Test results details,
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848560/suite/kselftest-rtc/tests/
> 
> Test results compare,
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848560/suite/kselftest-rtc/test/rtc.rtctest/history/
> 
> Test detailed log,
> https://lkft.validation.linaro.org/scheduler/job/5812742#L1759
> 
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: d8e87774068af213ab5b058b1b114dc397b577aa
>   git_describe: next-20221107
>   kernel_version: 6.1.0-rc3
>   kernel-config: https://builds.tuxbuild.com/2HChVOSNxUpvfAfLTnaK7zyTdUi/config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/687092361
>   artifact-location: https://builds.tuxbuild.com/2HChVOSNxUpvfAfLTnaK7zyTdUi
>   toolchain: gcc-11
> 
> 
> --
> Linaro QA
> https://qa-reports.linaro.org

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
