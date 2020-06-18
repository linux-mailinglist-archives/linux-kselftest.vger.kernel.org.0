Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8511FE6D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 04:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgFRBNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 21:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbgFRBNr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 21:13:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E223820EDD;
        Thu, 18 Jun 2020 01:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442826;
        bh=1L1IL2y01Qzhmft+H/AeRDpC/FR4sANsggs28guR4Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4Rzd+wBXlq2u+gD9Fl96r0RpiMMX4XYtwRmM13AVZN6XfnwIw9VVsf32+mxMgyzo
         /WWHwyJ3iSI6Fi4kvYkEmXpL9vuxNRFhbnOcGlLnATByI8XCvBCa/fyKGhT5wOYSFz
         5tRyUAVJioBU7Fd3gK1dIaPKa5T6oeV9ZWJsnkbU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 262/388] selftests/timens: handle a case when alarm clocks are not supported
Date:   Wed, 17 Jun 2020 21:05:59 -0400
Message-Id: <20200618010805.600873-262-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

[ Upstream commit 558ae0355a91c7d28fdf4c0011bee6ebb5118632 ]

This can happen if a testing node doesn't have RTC (real time clock)
hardware or it doesn't support alarms.

Fixes: 61c57676035d ("selftests/timens: Add Time Namespace test for supported clocks")
Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/timens/clock_nanosleep.c |  2 +-
 tools/testing/selftests/timens/timens.c          |  2 +-
 tools/testing/selftests/timens/timens.h          | 13 ++++++++++++-
 tools/testing/selftests/timens/timer.c           |  5 +++++
 tools/testing/selftests/timens/timerfd.c         |  5 +++++
 5 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 8e7b7c72ef65..72d41b955fb2 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -119,7 +119,7 @@ int main(int argc, char *argv[])
 
 	ksft_set_plan(4);
 
-	check_config_posix_timers();
+	check_supported_timers();
 
 	if (unshare_timens())
 		return 1;
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 098be7c83be3..52b6a1185f52 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -155,7 +155,7 @@ int main(int argc, char *argv[])
 
 	nscheck();
 
-	check_config_posix_timers();
+	check_supported_timers();
 
 	ksft_set_plan(ARRAY_SIZE(clocks) * 2);
 
diff --git a/tools/testing/selftests/timens/timens.h b/tools/testing/selftests/timens/timens.h
index e09e7e39bc52..d4fc52d47146 100644
--- a/tools/testing/selftests/timens/timens.h
+++ b/tools/testing/selftests/timens/timens.h
@@ -14,15 +14,26 @@
 #endif
 
 static int config_posix_timers = true;
+static int config_alarm_timers = true;
 
-static inline void check_config_posix_timers(void)
+static inline void check_supported_timers(void)
 {
+	struct timespec ts;
+
 	if (timer_create(-1, 0, 0) == -1 && errno == ENOSYS)
 		config_posix_timers = false;
+
+	if (clock_gettime(CLOCK_BOOTTIME_ALARM, &ts) == -1 && errno == EINVAL)
+		config_alarm_timers = false;
 }
 
 static inline bool check_skip(int clockid)
 {
+	if (!config_alarm_timers && clockid == CLOCK_BOOTTIME_ALARM) {
+		ksft_test_result_skip("CLOCK_BOOTTIME_ALARM isn't supported\n");
+		return true;
+	}
+
 	if (config_posix_timers)
 		return false;
 
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 96dba11ebe44..5e7f0051bd7b 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -22,6 +22,9 @@ int run_test(int clockid, struct timespec now)
 	timer_t fd;
 	int i;
 
+	if (check_skip(clockid))
+		return 0;
+
 	for (i = 0; i < 2; i++) {
 		struct sigevent sevp = {.sigev_notify = SIGEV_NONE};
 		int flags = 0;
@@ -74,6 +77,8 @@ int main(int argc, char *argv[])
 
 	nscheck();
 
+	check_supported_timers();
+
 	ksft_set_plan(3);
 
 	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index eff1ec5ff215..9edd43d6b2c1 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -28,6 +28,9 @@ int run_test(int clockid, struct timespec now)
 	long long elapsed;
 	int fd, i;
 
+	if (check_skip(clockid))
+		return 0;
+
 	if (tclock_gettime(clockid, &now))
 		return pr_perror("clock_gettime(%d)", clockid);
 
@@ -81,6 +84,8 @@ int main(int argc, char *argv[])
 
 	nscheck();
 
+	check_supported_timers();
+
 	ksft_set_plan(3);
 
 	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
-- 
2.25.1

