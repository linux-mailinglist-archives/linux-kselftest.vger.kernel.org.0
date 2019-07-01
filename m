Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEEA353AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2019 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfFDXZ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jun 2019 19:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfFDXZ0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jun 2019 19:25:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF1620862;
        Tue,  4 Jun 2019 23:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690724;
        bh=flzEsamEXrboVbANmgqeCb6TBlCF6DYo+S4SOr0GrkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8XBoer9DLSRiDco8RfhDYLd98DCMBTtq9iLd48g3pjDoPG/5APMePSudPAYSNURi
         ZgKQzLkZZy6XcVxHzTHX7MrGHsUD1h4AsMX+kAAZAGkANrKUo6nlOBwy8JJZM8oqRw
         Wv/VEgV6UydEV5oGMYn/xZp0AemKuNFTFIGZ3cTE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 13/17] selftests/timers: Add missing fflush(stdout) calls
Date:   Tue,  4 Jun 2019 19:24:54 -0400
Message-Id: <20190604232459.7745-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232459.7745-1-sashal@kernel.org>
References: <20190604232459.7745-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit fe48319243a626c860fd666ca032daacc2ba84a5 ]

When running under a pipe, some timer tests would not report output in
real-time because stdout flushes were missing after printf()s that lacked
a newline. This adds them to restore real-time status output that humans
can enjoy.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 9887fd538fec..91316ab4b041 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -147,6 +147,7 @@ int check_tick_adj(long tickval)
 
 	eppm = get_ppm_drift();
 	printf("%lld usec, %lld ppm", systick + (systick * eppm / MILLION), eppm);
+	fflush(stdout);
 
 	tx1.modes = 0;
 	adjtimex(&tx1);
diff --git a/tools/testing/selftests/timers/leapcrash.c b/tools/testing/selftests/timers/leapcrash.c
index a1071bdbdeb7..a77c70b47495 100644
--- a/tools/testing/selftests/timers/leapcrash.c
+++ b/tools/testing/selftests/timers/leapcrash.c
@@ -114,6 +114,7 @@ int main(void)
 		}
 		clear_time_state();
 		printf(".");
+		fflush(stdout);
 	}
 	printf("[OK]\n");
 	return ksft_exit_pass();
diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
index a2a3924d0b41..efdb62470052 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -113,6 +113,7 @@ int main(int argc, char **argv)
 	int ret;
 
 	printf("Mqueue latency :                          ");
+	fflush(stdout);
 
 	ret = mqueue_lat_test();
 	if (ret < 0) {
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index ff942ff7c9b3..2e6e94c02a33 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -153,6 +153,7 @@ int main(int argc, char **argv)
 			continue;
 
 		printf("Nanosleep %-31s ", clockstring(clockid));
+		fflush(stdout);
 
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index 2d7898fda0f1..ac06cf10a5c2 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -166,6 +166,7 @@ int main(int argc, char **argv)
 			continue;
 
 		printf("nsleep latency %-26s ", clockstring(clockid));
+		fflush(stdout);
 
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index 0ab937a17ebb..4e631da7f956 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -124,6 +124,7 @@ int main(int argv, char **argc)
 		printf("WARNING: ADJ_OFFSET in progress, this will cause inaccurate results\n");
 
 	printf("Estimating clock drift: ");
+	fflush(stdout);
 	sleep(120);
 
 	get_monotonic_and_raw(&mon, &raw);
diff --git a/tools/testing/selftests/timers/set-tai.c b/tools/testing/selftests/timers/set-tai.c
index dc88dbc8831f..3ae76ab483de 100644
--- a/tools/testing/selftests/timers/set-tai.c
+++ b/tools/testing/selftests/timers/set-tai.c
@@ -66,6 +66,7 @@ int main(int argc, char **argv)
 	printf("tai offset started at %i\n", ret);
 
 	printf("Checking tai offsets can be properly set: ");
+	fflush(stdout);
 	for (i = 1; i <= 60; i++) {
 		ret = set_tai(i);
 		ret = get_tai();
diff --git a/tools/testing/selftests/timers/set-tz.c b/tools/testing/selftests/timers/set-tz.c
index f4184928b16b..b038131c9682 100644
--- a/tools/testing/selftests/timers/set-tz.c
+++ b/tools/testing/selftests/timers/set-tz.c
@@ -76,6 +76,7 @@ int main(int argc, char **argv)
 	printf("tz_minuteswest started at %i, dst at %i\n", min, dst);
 
 	printf("Checking tz_minuteswest can be properly set: ");
+	fflush(stdout);
 	for (i = -15*60; i < 15*60; i += 30) {
 		ret = set_tz(i, dst);
 		ret = get_tz_min();
@@ -87,6 +88,7 @@ int main(int argc, char **argv)
 	printf("[OK]\n");
 
 	printf("Checking invalid tz_minuteswest values are caught: ");
+	fflush(stdout);
 
 	if (!set_tz(-15*60-1, dst)) {
 		printf("[FAILED] %i didn't return failure!\n", -15*60-1);
diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/selftests/timers/threadtest.c
index e632e116f05e..a4bf736dd842 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -175,6 +175,7 @@ int main(int argc, char **argv)
 	strftime(buf, 255, "%a, %d %b %Y %T %z", localtime(&start));
 	printf("%s\n", buf);
 	printf("Testing consistency with %i threads for %ld seconds: ", thread_count, runtime);
+	fflush(stdout);
 
 	/* spawn */
 	for (i = 0; i < thread_count; i++)
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 60fe3c569bd9..a747645d79f4 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -134,6 +134,7 @@ int validate_freq(void)
 	/* Set the leap second insert flag */
 
 	printf("Testing ADJ_FREQ... ");
+	fflush(stdout);
 	for (i = 0; i < NUM_FREQ_VALID; i++) {
 		tx.modes = ADJ_FREQUENCY;
 		tx.freq = valid_freq[i];
@@ -261,6 +262,7 @@ int set_bad_offset(long sec, long usec, int use_nano)
 int validate_set_offset(void)
 {
 	printf("Testing ADJ_SETOFFSET... ");
+	fflush(stdout);
 
 	/* Test valid values */
 	if (set_offset(NSEC_PER_SEC - 1, 1))
-- 
2.20.1

