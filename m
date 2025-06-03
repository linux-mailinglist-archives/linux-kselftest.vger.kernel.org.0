Return-Path: <linux-kselftest+bounces-34240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC1ACCDFC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD0F174F00
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112691DDC1B;
	Tue,  3 Jun 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7w3knaj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92294A23
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748981457; cv=none; b=qPw3a/fZsf8m8BXA0w6R4XqK31TLPGNYWoRCkbD3IMb1l+Jl5E5DChmHNWk+WNvEGAxb0J0Gwq/d9Mu3CdsTSxVETYdMzHxm+aJY1JXqqXDsiCf0xRG/CbZU0pRAtqvlVoaMrhKB0vYHqVbAx3oYcMaBQZsnwVzihTL2BWG8YRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748981457; c=relaxed/simple;
	bh=aN65jyOOlulDGqRV+3dR3KUf2ZNoBiszJnl/rlNQoFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5LaU0wvBVOvXdVbE1UC9W2zAYrEWgNuONBPE3Czjd5uQaR92hbHSByvSMod9dTxuQuyz5pleKue/iD2Vj086N1z4fS1j3xrgrG7Bg0msciOLmmWpXS6RWVkKanZoAUDMIB/IfMv6VaJL5OHIVfA6YwtBUkn+0zNrdHwIodUEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7w3knaj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so8016395e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748981453; x=1749586253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwB24AhjYH1g0oTgqkjrBjkMlDyt0oxM7Ekx/Bvp0/o=;
        b=T7w3knajGs5z7vGsyR6V1C6/0akvwOb80+bruVFmQrP5h8x2PnEM98JjeCxavwNwuR
         hqNQqgqaADL+/wjRl8mEG6S89lyqSIzFkBYEbRp99TdxLlk8RJ6u6iEFH6LjWfAbDxVP
         +K50/hs5Y2djIVEk3dSBeobyhfRmYzcjvMWVfaIcgp3ONIthP9AYlmclxwiGmH/h42cE
         kerUkaoHTRxtw9b9dtMj5nSI2CGyrqbrKP4icRpgPwdZZJ2ANsm8nNY1OB/bX4VnbtWY
         JSZnFyOt/hoP7zjbpHwb96iuBbjnAvkrLvP3chQeFynvAh/ON0ofkoNC8tga3UtY/1Z6
         nlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748981453; x=1749586253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwB24AhjYH1g0oTgqkjrBjkMlDyt0oxM7Ekx/Bvp0/o=;
        b=rNmKhQzKSNPfVU5xhxLGP2z6DL13oijBpJqUvSdaPiANOgWAjL9/IVBQLWSL27n6Kq
         WfZ/RqtwuoAVQ7zHCk+gibK9zeBmwTruVQ156AwOeWSYixATUtwuRavJ8LWVi3dkTsqa
         PewdgMDpGx7AMSQBPstldUdkEfvxQQbCkAlmCuL8IN+Pui039nAgMJ0IPSFqaVxGX6H9
         Xdl3NSRUL+ouREuPzifnLzE2RhMlGq+vxHVP4KJizHPf3EOBjiIkYpGFnwvR+RFxHtrG
         uNZEfVXKym32YfUw7pUuTZhFtzvtLuDnLEexquzv7EjO1o7V6Tcuo1bqhBU9Sklb9LeI
         nDGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQl8kge+C3RMjBda2vibfFeZiRM06/HP+1FXPXqnzJ8k+cM6odwwn9dBX+80jb7PO0N/Cfvj6UGRq0cVogMdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPts71Tl7SoA7Q0zJmD7+iVl6khEv1RwwVeNkhOQYnBWpx+4a
	OoW1E2jgeuC1TUuBpBBehITokd0/USp4D9NJglL1ljz30lkn9P9VV+FWNC+gdivfAdU=
X-Gm-Gg: ASbGncspC6PIQFGhFAIQTzVYwiZRSjjegenMtdMlmTCTKXnaGbhl50Cpdkj1+XZT5+G
	Jtum7QyWJEsH9OSsEar1FSLi/tD08FRpb06sPPnO4+CLbmy0s990mC2axdmc+0sMEOWj60nK5jW
	OJe734AhPCI732WrgO48BHroglUFNmXyddVJ6lzFVmew3W1CwUsGygc0JscL0vtqHgqn0YJItc3
	syU/nmqviZA9de0BnCbH1l3mFoFjvl5KuI4j8fn1kkLXq+XgKXGtl0FD9QM7Ey4dJ9Zan7z7bKT
	8hOKD1uduvyceBMt365cSC4P4mivOLIHPBcC7RWiI3Bl9mm6g9VhWifR89EwQAGPEbshkCW0H7j
	uVAkXj4GMl253gGsg1Je5SQAl2O707ECPWLt3KWDUVxjMTyBrSPvYjCDsm/g5HgTBvGM2j1w=
X-Google-Smtp-Source: AGHT+IGA2ew16lW9hkbjwj2+dxBXTO8ITHoc4YIhf4OdJI3DPA33Hmk3EHAKN/4i7DrRFAalKoK0EQ==
X-Received: by 2002:a05:600c:3542:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-451f0b3938cmr493875e9.30.1748981453165;
        Tue, 03 Jun 2025 13:10:53 -0700 (PDT)
Received: from green.cable.virginm.net (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm180719895e9.29.2025.06.03.13.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:10:52 -0700 (PDT)
From: Terry Tritton <terry.tritton@linaro.org>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: ttritton@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH] selftests/timers: Fix integer overlow errors on 32 bit systems
Date: Tue,  3 Jun 2025 21:10:36 +0100
Message-Id: <20250603201036.44504-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of NSEC_PER_SEC (1000000000L) as defined in include/vdso/time64.h
causes several integer overflow warnings and test errors on 32 bit 
architectures.

Use a long long instead of long to prevent integer overflow when 
converting seconds to nanoseconds.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 tools/testing/selftests/timers/adjtick.c             | 5 ++++-
 tools/testing/selftests/timers/alarmtimer-suspend.c  | 4 +++-
 tools/testing/selftests/timers/inconsistency-check.c | 4 +++-
 tools/testing/selftests/timers/leap-a-day.c          | 4 +++-
 tools/testing/selftests/timers/mqueue-lat.c          | 3 ++-
 tools/testing/selftests/timers/nanosleep.c           | 4 +++-
 tools/testing/selftests/timers/nsleep-lat.c          | 4 +++-
 tools/testing/selftests/timers/posix_timers.c        | 5 ++++-
 tools/testing/selftests/timers/raw_skew.c            | 4 +++-
 tools/testing/selftests/timers/set-2038.c            | 4 +++-
 tools/testing/selftests/timers/set-timer-lat.c       | 4 +++-
 tools/testing/selftests/timers/valid-adjtimex.c      | 5 ++++-
 12 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 777d9494b683..b5929c33b632 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -22,10 +22,13 @@
 #include <sys/time.h>
 #include <sys/timex.h>
 #include <time.h>
-#include <include/vdso/time64.h>
 
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+#define USEC_PER_SEC   1000000LL
+
 #define MILLION			1000000
 
 long systick;
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index a9ef76ea6051..b5799df271ae 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -28,10 +28,12 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <pthread.h>
-#include <include/vdso/time64.h>
 #include <errno.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+
 #define UNREASONABLE_LAT (NSEC_PER_SEC * 5) /* hopefully we resume in 5 secs */
 
 #define SUSPEND_SECS 15
diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index 9d1573769d55..2b2d7293b313 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -28,9 +28,11 @@
 #include <sys/timex.h>
 #include <string.h>
 #include <signal.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+
 /* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
 
diff --git a/tools/testing/selftests/timers/leap-a-day.c b/tools/testing/selftests/timers/leap-a-day.c
index 04004a7c0934..008c38ce4b2f 100644
--- a/tools/testing/selftests/timers/leap-a-day.c
+++ b/tools/testing/selftests/timers/leap-a-day.c
@@ -48,9 +48,11 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+
 #define CLOCK_TAI 11
 
 time_t next_leap;
diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
index 63de2334a291..1a6d26f86137 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -29,9 +29,10 @@
 #include <signal.h>
 #include <errno.h>
 #include <mqueue.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
 
 #define TARGET_TIMEOUT		100000000	/* 100ms in nanoseconds */
 #define UNRESONABLE_LATENCY	40000000	/* 40ms in nanosecs */
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 252c6308c569..55ea67478fdd 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -27,9 +27,11 @@
 #include <sys/timex.h>
 #include <string.h>
 #include <signal.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+
 /* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
 
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index de23dc0c9f97..347d622987c8 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -24,9 +24,11 @@
 #include <sys/timex.h>
 #include <string.h>
 #include <signal.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+
 #define UNRESONABLE_LATENCY 40000000 /* 40ms in nanosecs */
 
 /* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index f0eceb0faf34..555bf161f420 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -16,11 +16,14 @@
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
-#include <include/vdso/time64.h>
 #include <pthread.h>
 
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+#define USEC_PER_SEC   1000000LL
+
 #define DELAY 2
 
 static void __fatal_error(const char *test, const char *name, const char *what)
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index 957f7cd29cb1..ff7675d98560 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -25,9 +25,11 @@
 #include <sys/time.h>
 #include <sys/timex.h>
 #include <time.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+
 #define shift_right(x, s) ({		\
 	__typeof__(x) __x = (x);	\
 	__typeof__(s) __s = (s);	\
diff --git a/tools/testing/selftests/timers/set-2038.c b/tools/testing/selftests/timers/set-2038.c
index ed244315e11c..8130d551a11c 100644
--- a/tools/testing/selftests/timers/set-2038.c
+++ b/tools/testing/selftests/timers/set-2038.c
@@ -27,9 +27,11 @@
 #include <unistd.h>
 #include <time.h>
 #include <sys/time.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+
 #define KTIME_MAX	((long long)~((unsigned long long)1 << 63))
 #define KTIME_SEC_MAX	(KTIME_MAX / NSEC_PER_SEC)
 
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 9d8437c13929..79a6a6cba186 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -28,9 +28,11 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <pthread.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+
 /* CLOCK_HWSPECIFIC == CLOCK_SGI_CYCLE (Deprecated) */
 #define CLOCK_HWSPECIFIC		10
 
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 6b7801055ad1..e4f31e678630 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -29,9 +29,12 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
-#include <include/vdso/time64.h>
 #include "../kselftest.h"
 
+/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architectures*/
+#define NSEC_PER_SEC   1000000000LL
+#define USEC_PER_SEC   1000000LL
+
 #define ADJ_SETOFFSET 0x0100
 
 #include <sys/syscall.h>
-- 
2.39.5


