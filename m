Return-Path: <linux-kselftest+bounces-41525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB33B58537
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 21:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8010F7A3EA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 19:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025E827A900;
	Mon, 15 Sep 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlUgY25b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F92777FE
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963993; cv=none; b=FQ1UFqtrtPNbeR7BH5ytB8ntIQOuNj7cU2D2rvff+YnW68UL/A6xoieVG+U9x/tn04WPRx+QSMTKT1njUhqk8uSBLnue1tCyW99B7pp5CWXjbP5JotsmuURlwABMwvKnOj7LhIlF33GN9ICLytitwts+5OaVddxFykMGIbwm3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963993; c=relaxed/simple;
	bh=go8QQIZyPGUp4PkxMDF6s9CZk99i9v2/qqZF6ke4mtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GOsMXwbhHmRvKZw3uxAFpRzPgqBhlGS1WELnXKyigC5IeDRzsrQOHy6lVrJd/UEHD8sqk+C7kpnMf+Sgns2AVV1AXpwPN8NWaaOE10dBj8M57gcWzI9xpVwHt8/T0luoNc6dNwhoopA0loSz3CpjSI483P1OH/5XaZQblFJCYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlUgY25b; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7724ff1200eso3527019b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757963992; x=1758568792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWO+pKXM4jrMlLY6TR5WyVhXPvUt8x12rN7+iA06M7s=;
        b=IlUgY25bSXYl0TmXg3EslR3D/UJirm/WceA/vm24nBsNDy3BZKeX8VZi//H7uhtoCn
         220UeDlpPnofUHTx3gqQf3qZPKnM9MLlwl/+P9qUyJK4wivVT+AlnIjbJvXpsLqfU0Ce
         BqJ2Dk0sNUx7eVYCwg3VJd0EOrKQjtPDsMv6GvjPGud8pYxkiQ+4/B5r5e13C4wGzEb1
         Ipdohf6+rmHAOu32eaYRpNvZJtXHQesrSrBBrgZsbj2x6aBWXhuE0lCxiZsKs0KLKnk/
         pvurYLVtGfaRUHCdfhw95HW4SfPlysUi8uw1Iwdl1J9nA8KnXuwoUHv+QAq5rP9+0YpP
         F+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963992; x=1758568792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWO+pKXM4jrMlLY6TR5WyVhXPvUt8x12rN7+iA06M7s=;
        b=nvcoC8kaJ1jCby5osZwl1CUVHxFbWj7FbnwNGu6XRNRKuHYBFSrtKLWCbYDk9UMxgB
         vDZAejDPm16zvLazSUFpArylbA1794oqMc1L76K2gLJveYBSqlunEP08VtJYi3dJenOm
         xTwGFB5lhgUQU+ROPe90WFjsy/uE+TvADJq3gfp/YrNdv560CdMqxnyV5QHL7RLcUt3j
         32fd1zpSU4YzKGjCejh3NPVvSRedSsMEA6lTaJeKmv4VzvL+x8ihk7xNYpvTsCgh8Wmq
         +0QhiKaNnHNiJnyPodTZnXoKKj8DQYhVzULcZjQM4+Gfr+FmZ5+XeXO9EUZhCkxcRhqy
         cvcw==
X-Forwarded-Encrypted: i=1; AJvYcCXoOT8yLPcL9S5qqI7L3aiGBbnct/7uMym1cBdEpAxTjku4TZqtxtFHlRrWOR4sbPZkl0aT0320olNDrTZ8YfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFMU5HPnNLAA3AasThUNvwtDmSCZRd6xTQJo4jyy9zPM6tRYK9
	OeqxRc7cmwH5Fp1wWCSWZ+F6hCfB+/hl3B1IeIG9xGHn4GxaxdzqcXJX7X2MJ7MfXxkfHNctCOe
	Stg==
X-Google-Smtp-Source: AGHT+IHrAcKdifdBfvzg9iFv/i/1R3Icgb5FYVy4tL4b6A+2MkyfkLlRYL5Zu2ouqTtRPch9AwbMRhNFkQ==
X-Received: from pffn25.prod.google.com ([2002:a62:e519:0:b0:772:5ec0:9124])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2383:b0:772:4d52:ce5a
 with SMTP id d2e1a72fcca58-7761219409cmr15606700b3a.26.1757963991502; Mon, 15
 Sep 2025 12:19:51 -0700 (PDT)
Date: Tue, 16 Sep 2025 03:19:44 +0800
In-Reply-To: <fbb55063-ab03-40a9-80f4-4315d12239ba@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <fbb55063-ab03-40a9-80f4-4315d12239ba@t-8ch.de>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915191944.9779-1-wakel@google.com>
Subject: [PATCH v2] selftests/timers: Consolidate and fix 32-bit overflow in timespec_sub
From: Wake Liu <wakel@google.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The timespec_sub function, as implemented in several timer
selftests, is prone to integer overflow on 32-bit systems.

The calculation `NSEC_PER_SEC * b.tv_sec` is performed using
32-bit arithmetic, and the result overflows before being
stored in the 64-bit `ret` variable. This leads to incorrect
time delta calculations and test failures.

As suggested by tglx, this patch fixes the issue by:

1. Creating a new `static inline` helper function,
   `timespec_to_ns`, which safely converts a `timespec` to
   nanoseconds by casting `tv_sec` to `long long` before
   multiplying with `NSEC_PER_SEC`.

2. Placing the new helper and a rewritten `timespec_sub` into
   a common header: tools/testing/selftests/timers/helpers.h.

3. Removing the duplicated, buggy implementations from all
   timer selftests and replacing them with an #include of the
   new header.

This consolidates the code and ensures the calculation is
correctly performed using 64-bit arithmetic across all tests.

Changes in v2:
  - Per tglx's feedback, instead of changing NSEC_PER_SEC globally,
    this version consolidates the buggy timespec_sub() implementations
    into a new 32-bit safe inline function in a shared header.
  - Amended the commit message to be more descriptive.
---
 .../selftests/timers/alarmtimer-suspend.c     | 15 +++------
 tools/testing/selftests/timers/helpers.h      | 31 +++++++++++++++++++
 tools/testing/selftests/timers/nanosleep.c    |  2 +-
 tools/testing/selftests/timers/nsleep-lat.c   | 12 ++-----
 .../testing/selftests/timers/valid-adjtimex.c |  8 ++---
 5 files changed, 43 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/timers/helpers.h

diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index a9ef76ea6051..e85ab182abe5 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -31,8 +31,9 @@
 #include <include/vdso/time64.h>
 #include <errno.h>
 #include "../kselftest.h"
+#include "helpers.h"
 
-#define UNREASONABLE_LAT (NSEC_PER_SEC * 5) /* hopefully we resume in 5 secs */
+#define UNREASONABLE_LAT (NSEC_PER_SEC * 5LL) /* hopefully we resume in 5 secs */
 
 #define SUSPEND_SECS 15
 int alarmcount;
@@ -70,14 +71,6 @@ char *clockstring(int clockid)
 }
 
 
-long long timespec_sub(struct timespec a, struct timespec b)
-{
-	long long ret = NSEC_PER_SEC * b.tv_sec + b.tv_nsec;
-
-	ret -= NSEC_PER_SEC * a.tv_sec + a.tv_nsec;
-	return ret;
-}
-
 int final_ret;
 
 void sigalarm(int signo)
@@ -88,8 +81,8 @@ void sigalarm(int signo)
 	clock_gettime(alarm_clock_id, &ts);
 	alarmcount++;
 
-	delta_ns = timespec_sub(start_time, ts);
-	delta_ns -= NSEC_PER_SEC * SUSPEND_SECS * alarmcount;
+	delta_ns = timespec_sub(ts, start_time);
+	delta_ns -= (long long)NSEC_PER_SEC * SUSPEND_SECS * alarmcount;
 
 	printf("ALARM(%i): %ld:%ld latency: %lld ns ", alarmcount, ts.tv_sec,
 							ts.tv_nsec, delta_ns);
diff --git a/tools/testing/selftests/timers/helpers.h b/tools/testing/selftests/timers/helpers.h
new file mode 100644
index 000000000000..652f20247091
--- /dev/null
+++ b/tools/testing/selftests/timers/helpers.h
@@ -0,0 +1,31 @@
+#ifndef SELFTESTS_TIMERS_HELPERS_H
+#define SELFTESTS_TIMERS_HELPERS_H
+
+#include <time.h>
+
+#ifndef NSEC_PER_SEC
+#define NSEC_PER_SEC 1000000000L
+#endif
+
+/*
+ * timespec_to_ns - Convert timespec to nanoseconds
+ */
+static inline long long timespec_to_ns(const struct timespec *ts)
+{
+	return ((long long) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
+}
+
+/*
+ * timespec_sub - Subtract two timespec values
+ *
+ * @a: first timespec
+ * @b: second timespec
+ *
+ * Returns a - b in nanoseconds.
+ */
+static inline long long timespec_sub(struct timespec a, struct timespec b)
+{
+	return timespec_to_ns(&a) - timespec_to_ns(&b);
+}
+
+#endif /* SELFTESTS_TIMERS_HELPERS_H */
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 252c6308c569..41c33629d5f0 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -138,7 +138,7 @@ int main(int argc, char **argv)
 		fflush(stdout);
 
 		length = 10;
-		while (length <= (NSEC_PER_SEC * 10)) {
+		while (length <= (NSEC_PER_SEC * 10LL)) {
 			ret = nanosleep_test(clockid, length);
 			if (ret == UNSUPPORTED) {
 				ksft_test_result_skip("%-31s\n", clockstring(clockid));
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index de23dc0c9f97..c888a77aab7a 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -26,6 +26,7 @@
 #include <signal.h>
 #include <include/vdso/time64.h>
 #include "../kselftest.h"
+#include "helpers.h"
 
 #define UNRESONABLE_LATENCY 40000000 /* 40ms in nanosecs */
 
@@ -74,14 +75,6 @@ struct timespec timespec_add(struct timespec ts, unsigned long long ns)
 }
 
 
-long long timespec_sub(struct timespec a, struct timespec b)
-{
-	long long ret = NSEC_PER_SEC * b.tv_sec + b.tv_nsec;
-
-	ret -= NSEC_PER_SEC * a.tv_sec + a.tv_nsec;
-	return ret;
-}
-
 int nanosleep_lat_test(int clockid, long long ns)
 {
 	struct timespec start, end, target;
@@ -146,7 +139,7 @@ int main(int argc, char **argv)
 			continue;
 
 		length = 10;
-		while (length <= (NSEC_PER_SEC * 10)) {
+		while (length <= (NSEC_PER_SEC * 10LL)) {
 			ret = nanosleep_lat_test(clockid, length);
 			if (ret)
 				break;
@@ -164,3 +157,4 @@ int main(int argc, char **argv)
 
 	ksft_finished();
 }
+
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 6b7801055ad1..a61d4b4739a2 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -260,16 +260,16 @@ int validate_set_offset(void)
 	if (set_offset(-NSEC_PER_SEC - 1, 1))
 		return -1;
 
-	if (set_offset(5 * NSEC_PER_SEC, 1))
+	if (set_offset(5LL * NSEC_PER_SEC, 1))
 		return -1;
 
-	if (set_offset(-5 * NSEC_PER_SEC, 1))
+	if (set_offset(-5LL * NSEC_PER_SEC, 1))
 		return -1;
 
-	if (set_offset(5 * NSEC_PER_SEC + NSEC_PER_SEC / 2, 1))
+	if (set_offset(5LL * NSEC_PER_SEC + NSEC_PER_SEC / 2, 1))
 		return -1;
 
-	if (set_offset(-5 * NSEC_PER_SEC - NSEC_PER_SEC / 2, 1))
+	if (set_offset(-5LL * NSEC_PER_SEC - NSEC_PER_SEC / 2, 1))
 		return -1;
 
 	if (set_offset(USEC_PER_SEC - 1, 0))
-- 
2.51.0.384.g4c02a37b29-goog


