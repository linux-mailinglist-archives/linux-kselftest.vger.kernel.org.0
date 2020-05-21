Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B61DC805
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 09:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEUHxF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgEUHxE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 03:53:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CFC061A0E;
        Thu, 21 May 2020 00:53:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so1425879pll.6;
        Thu, 21 May 2020 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zS/u3KBWVDZ7K8RZ45xzlLdzooHYOS4Uuq0Hq+yQWTI=;
        b=LAqZ7ZClNq1n5qxhST1Kx86KulByiM6S0ZTJHjSzxFMyj7wuSVQX1JIFErVJQLZ0QM
         5x7LfwjB9k+RG/8NPscyITBkctzUJ6Lt8vSpXQwlAS+fZNM/Rv3MpO5gRQujlWb2hhZh
         11TSHe61ntJ7GQ1JdBYREK4suLz+FZdUAlsGcJYAzatuxwEJjWz934Jog5Jq5lWJMKPG
         HJX3fzRk3kWbHgni/LzM5WBHCrhj/nb7oDopTOwPkC/rRfkxst2uGYNWfRuxu0vi6Gbk
         yG2rwYwz2Gt9odxeLrjsOvMAvOP8TFQv4SDGy1pfeEq4MWqwGEWUbPKr8Bh99uPputkF
         z5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zS/u3KBWVDZ7K8RZ45xzlLdzooHYOS4Uuq0Hq+yQWTI=;
        b=tvbwkeRrBTiYbkDb9rfJCAnvvok3+67Y2TP1nQ0NxvYewim2MEhtbEycyEJXPNOdmA
         DSziWUqx3aSiS9qsnCin4mt1g/oST457DnyPfgFykAiNvf5YA40vJlKj06/It4GEG9KE
         w3izj7XkpKDmDCfCEdsZ1lprm6JWYLphGIyp019tcEQExsKeUPyVDpe1EPFsLPqXDJ1K
         maSq+Y6xaPJsVJkGudGbWpheLIeryDJlipgoLVyybWY9vli4y2yNjadDSfQRjvQ2jxgG
         FyYeknXQ1ZElDdba3aBp1BlCe1vGzWWLMeGupq5vWyBki1kzsMsXBLOYU+dsMk779L58
         mlFg==
X-Gm-Message-State: AOAM530CEw5Y+DaukDIhKp3yyn8+XdIEfAylYGlWl6grV52+of/Cbe+w
        eXppSLJw3W/phxwytHaZHs4=
X-Google-Smtp-Source: ABdhPJyaeWwEmW5PwGXsGlIqo9aCk0DuccKvTBdt+z7NuYRYLOB/QthajzBc+0SQ0Nt8F3nzMJEnQQ==
X-Received: by 2002:a17:90a:d598:: with SMTP id v24mr8960146pju.167.1590047582531;
        Thu, 21 May 2020 00:53:02 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id 98sm3827653pjo.12.2020.05.21.00.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:53:01 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v3] selftests/timens: handle a case when alarm clocks are not supported
Date:   Thu, 21 May 2020 00:52:52 -0700
Message-Id: <20200521075252.89475-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This can happen if a testing node doesn't have RTC (real time clock)
hardware or it doesn't support alarms.

Fixes: 61c57676035d ("selftests/timens: Add Time Namespace test for supported clocks")
Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
v2: fix timer.c and timerfd.c too.
v3: add Reported-by and Fixes tags.

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
2.24.1

