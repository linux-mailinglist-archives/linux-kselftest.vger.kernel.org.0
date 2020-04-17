Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC321AD9DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Apr 2020 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgDQJ2T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbgDQJ2S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 05:28:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33841C061A0C;
        Fri, 17 Apr 2020 02:28:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ng8so856815pjb.2;
        Fri, 17 Apr 2020 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mud2l24rltk7uz7NfJ1c85N1cu3yPrMi7djTErSnOqU=;
        b=vc5DC1093lQFHdM1jrQJQNYSV1EiEy/xW07n2puLWpbVi5RlxW7/bLGEqOI8i/DESw
         5FZkNogpz5zp99WdsrpAcLE5OptYNIPvJ+hvX//QVnzTpqs+71Qyn+zX9xMaJ9csGLg+
         U+n3CV9kdkeBXU/W7b93UeVoyHgFUnA2CgbZS4RCECgmBEIf4Ir8eoqVfjB4OF3+UWZk
         QAip2WgLhpUE8N0kQBInvlsbRyzH6oSPSo8+6DoAQTeUIjA+Ml4lGKInErz7si+mhNdL
         egyR/BmHbb91Dy1ZPP6QV98pNdNjlqgg20vfiI+k6plnDx0rkElsRQVLIP1xxVo0x/5N
         pR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mud2l24rltk7uz7NfJ1c85N1cu3yPrMi7djTErSnOqU=;
        b=ql/2GL/ANsFMtT05lPBK3iQ7Fj3FsTTaHW2bysz0A+tEDOZYXOl/GZL9Go5DUDRVRD
         oBM1eHoOXcx9P5TzucltAswIT/fs2DkHJfsqbX21xlnthaJx4BBaWL+hM0ymmf1YlEvy
         uKyzCOs/kAVnEaXasrLjZ3ToZpxx1paMjSr/V9YuvmfVxZPVa2aANxkd95YIW0ByX2c+
         LajrcrkoF9t18mdNHfK0Jyo2a329XcPzYzHCNOGzGC8svBQ5Nx3zSYlFhSFh5o2tqijl
         /m8nwKFHRtOqJ50goUEvUT8eHWDNvo9EtuCyNEZk4MGeC3G+CO1VGWwTI7WpRIe1s1Vj
         5lzQ==
X-Gm-Message-State: AGi0PuaEFk1+/muJnu0qf0Gl/kP1kBpUpIINh0eVxxGICCmY2jehhbvF
        hvCraJfWeHXV7OGEMYDTqvA=
X-Google-Smtp-Source: APiQypI44w7N7kV7q0nuZjqIxe3+gPqLsO8N+HYL1hgQ4UomT+clbnmIwUTS7Z0xUC8jJ5bvQchmFw==
X-Received: by 2002:a17:90a:be12:: with SMTP id a18mr3156831pjs.162.1587115697547;
        Fri, 17 Apr 2020 02:28:17 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id 132sm19347742pfc.183.2020.04.17.02.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:28:16 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2] selftests/timens: handle a case when alarm clocks are not supported
Date:   Fri, 17 Apr 2020 02:28:10 -0700
Message-Id: <20200417092810.872455-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200415061802.722485-1-avagin@gmail.com>
References: <20200415061802.722485-1-avagin@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This can happen if a testing node doesn't have RTC (real time clock)
hardware or it doesn't support alarms.

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
v2: fix timer.c and timerfd.c too.

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

