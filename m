Return-Path: <linux-kselftest+bounces-18309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2239848F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F21F23ACD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039F1ABEC9;
	Tue, 24 Sep 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YHcrU7zC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6611ABEA8
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193438; cv=none; b=hiZvcnSNqzYsYwFht+sI0VCHyKISbOgH2pG4kxUa9DetKjosgZ61ioXnkh47bOcSH67oUfyF+m/KaHe8Fe/whkDFXp+yatnkhyRUoDJUG1GL1dRKGOJ/CqajSCpsZKtQBnB5uOK4+UZ5g0YkIikqaRTlHLnJtnMkjNS2Gyx+Uh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193438; c=relaxed/simple;
	bh=/5F68H2WHyHuyiG699Xxk67Rx4hgdRsscfaURuGqd2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJ/vutzLJ3HLO8GI5fQ2F+vGBbqo9oepgV0r7K6A9kmkeONGJVQiiOmIjL+42yKYtWihADMRv/f3i4fDvM28bvPaiCS0yJseDtUW+zeT8iqoRCw5diccDhbrbWvcejsQhe5IxCFOD/3j25ux6nM/YMDyEAM4hM8y7/+UvcbQR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YHcrU7zC; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39f56df0ddbso23254045ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727193436; x=1727798236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53AWYMV3y98vy7YqJ237N2ZTEc/DzjoF7oupBD8L8xA=;
        b=YHcrU7zCEKw5x0uyMgVFsG8i5x53CTM26bmjOkQcgPLwazALxxVMMXDXpPJdqqhB3M
         Saac0iB4+GTf49Lx99yWQoFgg93ryPYX6gPkTnYfk1Y69J38hJn6UR8tavxKFYkELuFM
         c7hDJmzox0hqaPGc5seoz9AsIlqJk5V7Ige4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193436; x=1727798236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53AWYMV3y98vy7YqJ237N2ZTEc/DzjoF7oupBD8L8xA=;
        b=l1a1peOS9KMa9EZPZHg0i7W8KX0uxvGersQZZibNqE0NCkL43ukPUuZ+PfnW6f25US
         w4jcM7SHd72m3W7wATnv7LIqTtcpt3DeTGy1zFyh3VgAAwwRP57JGBUC0lf2kCOcCGo7
         UlBSET7G1lbM/CFnQUgTi50PxyaCbeNwo3oh9O2uxe1R2Yafri86gD6eQ5iEXnbFodv/
         +LTauwwpwbTz61WE/8boKWYUE6bnsi24h0nvsfSWs+GLGhe2U8YypJaIZBuQjW05RABx
         TF8QvtbCTWy4RJek+Rl7rOtPLV6MDO3Or1zy0mvoLR5sycma8VEybY+iFratBWh7uqcb
         bucA==
X-Forwarded-Encrypted: i=1; AJvYcCXR/MOUcNB/ALsDXssj2DJ82UAaxkLpmw6OFQ/Cf3d4tQp6kju7M1WZyicqn7sCNdUnbccd2DEU2i7D+aLvl5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi89CTfFJDmE2AxVDUWw0qRWvXUI6Mukms9w3BrxjmH+uX8Qhb
	YqZpz8GV29SfMbBrSCu61mMZObiDINL9WtkMMKvir8hvPs7MePzPIWS87DXWDuQ=
X-Google-Smtp-Source: AGHT+IEklgHT9dpWQRJxz1ElVFna2TN0was+5e+f5zgBUGOIrvtxsRvWEwABxvdFXIu2DgNklS5fzw==
X-Received: by 2002:a05:6e02:184e:b0:39f:6180:afca with SMTP id e9e14a558f8ab-3a0c8cd7625mr153791675ab.13.1727193435794;
        Tue, 24 Sep 2024 08:57:15 -0700 (PDT)
Received: from localhost.localdomain ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5713b64sm4492035ab.58.2024.09.24.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:57:15 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	shuah@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: timers: Remove local NSEC_PER_SEC and USEC_PER_SEC defines
Date: Tue, 24 Sep 2024 09:56:47 -0600
Message-Id: <f797bc704d8eb03234a3447c77fa7b704339f89a.1727191485.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727191485.git.skhan@linuxfoundation.org>
References: <cover.1727191485.git.skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove local NSEC_PER_SEC and USEC_PER_SEC defines. Pick them up from
include/vdso/time64.h. This requires -I $(top_srcdir) to the timers
Makefile to include the include/vdso/time64.h.

posix_timers test names the defines NSECS_PER_SEC and USECS_PER_SEC.
Include the include/vdso/time64.h and change NSECS_PER_SEC and
USECS_PER_SEC references to NSEC_PER_SEC and USEC_PER_SEC respectively.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/timers/Makefile           |  2 +-
 tools/testing/selftests/timers/adjtick.c          |  4 +---
 .../testing/selftests/timers/alarmtimer-suspend.c |  2 +-
 .../selftests/timers/inconsistency-check.c        |  2 +-
 tools/testing/selftests/timers/leap-a-day.c       |  2 +-
 tools/testing/selftests/timers/mqueue-lat.c       |  2 +-
 tools/testing/selftests/timers/nanosleep.c        |  3 +--
 tools/testing/selftests/timers/posix_timers.c     | 15 +++++++--------
 tools/testing/selftests/timers/raw_skew.c         |  2 +-
 tools/testing/selftests/timers/set-2038.c         |  3 +--
 tools/testing/selftests/timers/set-timer-lat.c    |  3 +--
 tools/testing/selftests/timers/valid-adjtimex.c   |  4 +---
 12 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 0e73a16874c4..32203593c62e 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
 LDLIBS += -lrt -lpthread -lm
 
 # these are all "safe" tests that don't modify
diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 205b76a4abb4..cb9a30f54662 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -22,14 +22,12 @@
 #include <sys/time.h>
 #include <sys/timex.h>
 #include <time.h>
+#include <include/vdso/time64.h>
 
 #include "../kselftest.h"
 
 #define CLOCK_MONOTONIC_RAW	4
 
-#define NSEC_PER_SEC		1000000000LL
-#define USEC_PER_SEC		1000000
-
 #define MILLION			1000000
 
 long systick;
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index ad52e608b88e..62da2a3f949e 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -28,6 +28,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <pthread.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
 #define CLOCK_REALTIME			0
@@ -45,7 +46,6 @@
 #define NR_CLOCKIDS			12
 
 
-#define NSEC_PER_SEC 1000000000ULL
 #define UNREASONABLE_LAT (NSEC_PER_SEC * 5) /* hopefully we resume in 5 secs */
 
 #define SUSPEND_SECS 15
diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index 36a49fba6c9b..75650cf0503f 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -28,10 +28,10 @@
 #include <sys/timex.h>
 #include <string.h>
 #include <signal.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
 #define CALLS_PER_LOOP 64
-#define NSEC_PER_SEC 1000000000ULL
 
 #define CLOCK_REALTIME			0
 #define CLOCK_MONOTONIC			1
diff --git a/tools/testing/selftests/timers/leap-a-day.c b/tools/testing/selftests/timers/leap-a-day.c
index 986abbdb1521..04004a7c0934 100644
--- a/tools/testing/selftests/timers/leap-a-day.c
+++ b/tools/testing/selftests/timers/leap-a-day.c
@@ -48,9 +48,9 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define NSEC_PER_SEC 1000000000ULL
 #define CLOCK_TAI 11
 
 time_t next_leap;
diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
index f3179a605bba..63de2334a291 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -29,9 +29,9 @@
 #include <signal.h>
 #include <errno.h>
 #include <mqueue.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define NSEC_PER_SEC 1000000000ULL
 
 #define TARGET_TIMEOUT		100000000	/* 100ms in nanoseconds */
 #define UNRESONABLE_LATENCY	40000000	/* 40ms in nanosecs */
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index df1d03516e7b..9a354e38a569 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -27,10 +27,9 @@
 #include <sys/timex.h>
 #include <string.h>
 #include <signal.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define NSEC_PER_SEC 1000000000ULL
-
 #define CLOCK_REALTIME			0
 #define CLOCK_MONOTONIC			1
 #define CLOCK_PROCESS_CPUTIME_ID	2
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index ddb1cebc844e..9814b3a1c77d 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -15,13 +15,12 @@
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
+#include <include/vdso/time64.h>
 #include <pthread.h>
 
 #include "../kselftest.h"
 
 #define DELAY 2
-#define USECS_PER_SEC 1000000
-#define NSECS_PER_SEC 1000000000
 
 static void __fatal_error(const char *test, const char *name, const char *what)
 {
@@ -86,9 +85,9 @@ static int check_diff(struct timeval start, struct timeval end)
 	long long diff;
 
 	diff = end.tv_usec - start.tv_usec;
-	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
+	diff += (end.tv_sec - start.tv_sec) * USEC_PER_SEC;
 
-	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+	if (llabs(diff - DELAY * USEC_PER_SEC) > USEC_PER_SEC / 2) {
 		printf("Diff too high: %lld..", diff);
 		return -1;
 	}
@@ -448,7 +447,7 @@ static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
 {
 	int64_t diff;
 
-	diff = NSECS_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
+	diff = NSEC_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
 	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
 	return diff;
 }
@@ -479,7 +478,7 @@ static void check_sigev_none(int which, const char *name)
 	do {
 		if (clock_gettime(which, &now))
 			fatal_error(name, "clock_gettime()");
-	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+	} while (calcdiff_ns(now, start) < NSEC_PER_SEC);
 
 	if (timer_gettime(timerid, &its))
 		fatal_error(name, "timer_gettime()");
@@ -536,7 +535,7 @@ static void check_gettime(int which, const char *name)
 			wraps++;
 		prev = its;
 
-	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+	} while (calcdiff_ns(now, start) < NSEC_PER_SEC);
 
 	if (timer_delete(timerid))
 		fatal_error(name, "timer_delete()");
@@ -587,7 +586,7 @@ static void check_overrun(int which, const char *name)
 	do {
 		if (clock_gettime(which, &now))
 			fatal_error(name, "clock_gettime()");
-	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+	} while (calcdiff_ns(now, start) < NSEC_PER_SEC);
 
 	/* Unblock it, which should deliver a signal */
 	if (sigprocmask(SIG_UNBLOCK, &set, NULL))
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index 030143eb09b4..ea50e4efc422 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -25,10 +25,10 @@
 #include <sys/time.h>
 #include <sys/timex.h>
 #include <time.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
 #define CLOCK_MONOTONIC_RAW		4
-#define NSEC_PER_SEC 1000000000LL
 
 #define shift_right(x, s) ({		\
 	__typeof__(x) __x = (x);	\
diff --git a/tools/testing/selftests/timers/set-2038.c b/tools/testing/selftests/timers/set-2038.c
index f7d978721b9e..ed244315e11c 100644
--- a/tools/testing/selftests/timers/set-2038.c
+++ b/tools/testing/selftests/timers/set-2038.c
@@ -27,10 +27,9 @@
 #include <unistd.h>
 #include <time.h>
 #include <sys/time.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define NSEC_PER_SEC 1000000000LL
-
 #define KTIME_MAX	((long long)~((unsigned long long)1 << 63))
 #define KTIME_SEC_MAX	(KTIME_MAX / NSEC_PER_SEC)
 
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 7ce240c89b21..5365e9ae61c3 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -28,6 +28,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <pthread.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
 #define CLOCK_REALTIME			0
@@ -44,8 +45,6 @@
 #define CLOCK_TAI			11
 #define NR_CLOCKIDS			12
 
-
-#define NSEC_PER_SEC 1000000000ULL
 #define UNRESONABLE_LATENCY 40000000 /* 40ms in nanosecs */
 
 #define TIMER_SECS 1
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index d500884801d8..6b7801055ad1 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -29,11 +29,9 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
+#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
-#define NSEC_PER_SEC 1000000000LL
-#define USEC_PER_SEC 1000000LL
-
 #define ADJ_SETOFFSET 0x0100
 
 #include <sys/syscall.h>
-- 
2.40.1


