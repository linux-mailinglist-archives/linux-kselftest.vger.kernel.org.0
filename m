Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5023A24380
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfETWhy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 18:37:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44540 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfETWhy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 18:37:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id g9so7917623pfo.11
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2019 15:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PGHfQPk6ARuyJdSHgumoenLXTD9+bd//XmOFZUG/zKQ=;
        b=iRpGuMe1abpjA6Cw60u1pUjegk3kfkUpqJo+xktidVsAr7iwh5m1E4QpXRtJyAJR+T
         IbglphRpvG03Gwi2g46RN/2BHEGi6XtShy3RqeQq13tPvcmvOG+iIbeMuTaUjg+MwFhC
         hhuJiO/LwQhFe0TSv6rnKohS5UqbMci74mDDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PGHfQPk6ARuyJdSHgumoenLXTD9+bd//XmOFZUG/zKQ=;
        b=rU4msXtgHrnWkZoTHZELNQ9TY1dfQp5/l5O9/owVUOouxNBNo7LPxT2CrNlTds1y4c
         SL0ssAItsV6RD0tGT7m4Tdvy+p8wBERqbgz2imgJQjEnO9AMGwYvxvOvMAf9i3IF/lYP
         m3XxDvy04ZhKwAV+auZOwdnMJ+dLHPmy9AUU7Bod3PMjPtG8vh2XLYtQQG7RXmFXTGiC
         eYYAlIbT+062JPNrdGEGFa4mP7plAdWUN1ML6LTc6ybG6Sz/WdeGGAOIvvzCy/nS3n5V
         rHoz1ln2LjZQN1C0PiLWQwk+vGRP1VWyhTyRyKhzitI53y8k8SDTPk/U5nTHWmohCVe3
         wAuA==
X-Gm-Message-State: APjAAAWVpvmHlWFRma7T0PYXAH6mS9ORa+4gG1jucBbLBrlDDpjeFQJG
        vn0s3Rv0L8wyf4dx5OJZ+enuWQ==
X-Google-Smtp-Source: APXvYqz8F5NNNY3KU3Sj9FjtNawXQcW/Q3ESwOiOxnoBTGRKwCO44gsJAVIY56Tq+3/G5yD4lEpjhA==
X-Received: by 2002:a63:68e:: with SMTP id 136mr24082570pgg.81.1558391873355;
        Mon, 20 May 2019 15:37:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm31196pfa.66.2019.05.20.15.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 15:37:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/timers: Add missing fflush(stdout) calls
Date:   Mon, 20 May 2019 15:37:49 -0700
Message-Id: <20190520223749.13476-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520223749.13476-1-keescook@chromium.org>
References: <20190520223749.13476-1-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running under a pipe, some timer tests would not report output in
real-time because stdout flushes were missing after printf()s that lacked
a newline. This adds them to restore real-time status output that humans
can enjoy.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/timers/adjtick.c        | 1 +
 tools/testing/selftests/timers/leapcrash.c      | 1 +
 tools/testing/selftests/timers/mqueue-lat.c     | 1 +
 tools/testing/selftests/timers/nanosleep.c      | 1 +
 tools/testing/selftests/timers/nsleep-lat.c     | 1 +
 tools/testing/selftests/timers/raw_skew.c       | 1 +
 tools/testing/selftests/timers/set-tai.c        | 1 +
 tools/testing/selftests/timers/set-tz.c         | 2 ++
 tools/testing/selftests/timers/threadtest.c     | 1 +
 tools/testing/selftests/timers/valid-adjtimex.c | 2 ++
 10 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 0caca3a06bd2..54d8d87f36b3 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -136,6 +136,7 @@ int check_tick_adj(long tickval)
 
 	eppm = get_ppm_drift();
 	printf("%lld usec, %lld ppm", systick + (systick * eppm / MILLION), eppm);
+	fflush(stdout);
 
 	tx1.modes = 0;
 	adjtimex(&tx1);
diff --git a/tools/testing/selftests/timers/leapcrash.c b/tools/testing/selftests/timers/leapcrash.c
index 830c462f605d..dc80728ed191 100644
--- a/tools/testing/selftests/timers/leapcrash.c
+++ b/tools/testing/selftests/timers/leapcrash.c
@@ -101,6 +101,7 @@ int main(void)
 		}
 		clear_time_state();
 		printf(".");
+		fflush(stdout);
 	}
 	printf("[OK]\n");
 	return ksft_exit_pass();
diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
index 1867db5d6f5e..7916cf5cc6ff 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -102,6 +102,7 @@ int main(int argc, char **argv)
 	int ret;
 
 	printf("Mqueue latency :                          ");
+	fflush(stdout);
 
 	ret = mqueue_lat_test();
 	if (ret < 0) {
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 8adb0bb51d4d..71b5441c2fd9 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -142,6 +142,7 @@ int main(int argc, char **argv)
 			continue;
 
 		printf("Nanosleep %-31s ", clockstring(clockid));
+		fflush(stdout);
 
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index c3c3dc10db17..eb3e79ed7b4a 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -155,6 +155,7 @@ int main(int argc, char **argv)
 			continue;
 
 		printf("nsleep latency %-26s ", clockstring(clockid));
+		fflush(stdout);
 
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index dcf73c5dab6e..b41d8dd0c40c 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -112,6 +112,7 @@ int main(int argv, char **argc)
 		printf("WARNING: ADJ_OFFSET in progress, this will cause inaccurate results\n");
 
 	printf("Estimating clock drift: ");
+	fflush(stdout);
 	sleep(120);
 
 	get_monotonic_and_raw(&mon, &raw);
diff --git a/tools/testing/selftests/timers/set-tai.c b/tools/testing/selftests/timers/set-tai.c
index 70fed27d8fd3..8c4179ee2ca2 100644
--- a/tools/testing/selftests/timers/set-tai.c
+++ b/tools/testing/selftests/timers/set-tai.c
@@ -55,6 +55,7 @@ int main(int argc, char **argv)
 	printf("tai offset started at %i\n", ret);
 
 	printf("Checking tai offsets can be properly set: ");
+	fflush(stdout);
 	for (i = 1; i <= 60; i++) {
 		ret = set_tai(i);
 		ret = get_tai();
diff --git a/tools/testing/selftests/timers/set-tz.c b/tools/testing/selftests/timers/set-tz.c
index 877fd5532fee..62bd33eb16f0 100644
--- a/tools/testing/selftests/timers/set-tz.c
+++ b/tools/testing/selftests/timers/set-tz.c
@@ -65,6 +65,7 @@ int main(int argc, char **argv)
 	printf("tz_minuteswest started at %i, dst at %i\n", min, dst);
 
 	printf("Checking tz_minuteswest can be properly set: ");
+	fflush(stdout);
 	for (i = -15*60; i < 15*60; i += 30) {
 		ret = set_tz(i, dst);
 		ret = get_tz_min();
@@ -76,6 +77,7 @@ int main(int argc, char **argv)
 	printf("[OK]\n");
 
 	printf("Checking invalid tz_minuteswest values are caught: ");
+	fflush(stdout);
 
 	if (!set_tz(-15*60-1, dst)) {
 		printf("[FAILED] %i didn't return failure!\n", -15*60-1);
diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/selftests/timers/threadtest.c
index 759c9c06f1a0..cf3e48919874 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -163,6 +163,7 @@ int main(int argc, char **argv)
 	strftime(buf, 255, "%a, %d %b %Y %T %z", localtime(&start));
 	printf("%s\n", buf);
 	printf("Testing consistency with %i threads for %ld seconds: ", thread_count, runtime);
+	fflush(stdout);
 
 	/* spawn */
 	for (i = 0; i < thread_count; i++)
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index d9d3ab93b31a..5397de708d3c 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -123,6 +123,7 @@ int validate_freq(void)
 	/* Set the leap second insert flag */
 
 	printf("Testing ADJ_FREQ... ");
+	fflush(stdout);
 	for (i = 0; i < NUM_FREQ_VALID; i++) {
 		tx.modes = ADJ_FREQUENCY;
 		tx.freq = valid_freq[i];
@@ -250,6 +251,7 @@ int set_bad_offset(long sec, long usec, int use_nano)
 int validate_set_offset(void)
 {
 	printf("Testing ADJ_SETOFFSET... ");
+	fflush(stdout);
 
 	/* Test valid values */
 	if (set_offset(NSEC_PER_SEC - 1, 1))
-- 
2.17.1

