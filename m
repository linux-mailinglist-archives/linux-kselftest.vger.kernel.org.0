Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC87B01A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjI0KTP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 06:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjI0KTO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 06:19:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806959DD;
        Wed, 27 Sep 2023 03:19:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97504C433C9;
        Wed, 27 Sep 2023 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695809951;
        bh=iD1Vck+S4QQft7BTkmuK0ma2eIqgxVFnU1MUyNKVw4U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MId2KBAaZTaZ6MGBXjGQG7DIv5i4LhjKxhKNkzWFZAH/bHIHgNLdzzabQNgxbURc3
         YUR3fy9EqY5BI2j9J1EArx+Nz02x+NZbgah0n77TrXnzlp53pVqCnpUeDL0n2aEKVh
         E52i6MWKW33uC51bvhkUVByuYMBeoOCbhNH5M6JcsTBIrolDMcLYUvqwSmnXTljQEV
         kVL2nzfHidbN7dU3GLi2nSq6OlG3eH98W5tr/KYJgQu88iG0bYJohj23TPfsfp1jhk
         YTZeKS1qY5ZnmUB4hCEIvxYTdesNPUrSuKW9XP1sRf8YYv2d1gS2mV95JeT17sktEG
         /B9hqBN6/GMxg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 27 Sep 2023 12:18:58 +0200
Subject: [PATCH 2/3] selftests: timers: Convert posix_timers test to
 generate KTAP output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-ktap-posix-timers-v1-2-399de1cbfbea@kernel.org>
References: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
In-Reply-To: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=6161; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iD1Vck+S4QQft7BTkmuK0ma2eIqgxVFnU1MUyNKVw4U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFAGZZAdKazmdjvuqdjsRoyW6Y2uwOwJX+eXU4
 Ek28g+AxUuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRQBmQAKCRAk1otyXVSH
 0KMNB/0Wzs5srSnzDTwH8Vy5t4CukNA5q4cLL2YheCHtsweN6EqCrtV2bGoVTIY7R2So4Dxx/fc
 LFCMLHfRFLd/ZwWBKPUkzd0iITWX48AMl6IV8FIORikxJdpK8R2beuYX5UHTAdGbHnO8Erf0AN1
 eNT6bodDTAyz7Ksl8y83CTQ/OQnDukiG9F49qGck3qo9gtCTrvTCmEw71jevyyP3HjYT9kBwKs9
 WDiWOmL+RYc4tBwhVh/vXvcP5M7DsyYfbn31kahicnifMfTlffowwARz+rOHDQe2CRYKlJbtYKU
 0I3Z+ko/kW7e+FPhqTM1R46y39PL6gGn49TztSN66s738Voe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the posix_timers test does not produce KTAP output but rather a
custom format. This means that we only get a pass/fail for the suite, not
for each individual test that the suite does. Convert to using the standard
kselftest output functions which result in KTAP output being generated.

As part of this fix the printing of diagnostics in the unlikely event that
the pthread APIs fail, these were using perror() but the API functions
directly return an error code instead of setting errno.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/timers/posix_timers.c | 81 ++++++++++++++-------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 8a17c0e8d82b..d49dd3ffd0d9 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -76,22 +76,21 @@ static int check_diff(struct timeval start, struct timeval end)
 
 static int check_itimer(int which)
 {
+	const char *name;
 	int err;
 	struct timeval start, end;
 	struct itimerval val = {
 		.it_value.tv_sec = DELAY,
 	};
 
-	printf("Check itimer ");
-
 	if (which == ITIMER_VIRTUAL)
-		printf("virtual... ");
+		name = "ITIMER_VIRTUAL";
 	else if (which == ITIMER_PROF)
-		printf("prof... ");
+		name = "ITIMER_PROF";
 	else if (which == ITIMER_REAL)
-		printf("real... ");
-
-	fflush(stdout);
+		name = "ITIMER_REAL";
+	else
+		return -1;
 
 	done = 0;
 
@@ -104,13 +103,13 @@ static int check_itimer(int which)
 
 	err = gettimeofday(&start, NULL);
 	if (err < 0) {
-		perror("Can't call gettimeofday()\n");
+		ksft_perror("Can't call gettimeofday()");
 		return -1;
 	}
 
 	err = setitimer(which, &val, NULL);
 	if (err < 0) {
-		perror("Can't set timer\n");
+		ksft_perror("Can't set timer");
 		return -1;
 	}
 
@@ -123,20 +122,18 @@ static int check_itimer(int which)
 
 	err = gettimeofday(&end, NULL);
 	if (err < 0) {
-		perror("Can't call gettimeofday()\n");
+		ksft_perror("Can't call gettimeofday()");
 		return -1;
 	}
 
-	if (!check_diff(start, end))
-		printf("[OK]\n");
-	else
-		printf("[FAIL]\n");
+	ksft_test_result(check_diff(start, end) == 0, "%s\n", name);
 
 	return 0;
 }
 
 static int check_timer_create(int which)
 {
+	const char *type;
 	int err;
 	timer_t id;
 	struct timeval start, end;
@@ -144,31 +141,32 @@ static int check_timer_create(int which)
 		.it_value.tv_sec = DELAY,
 	};
 
-	printf("Check timer_create() ");
 	if (which == CLOCK_THREAD_CPUTIME_ID) {
-		printf("per thread... ");
+		type = "thread";
 	} else if (which == CLOCK_PROCESS_CPUTIME_ID) {
-		printf("per process... ");
+		type = "process";
+	} else {
+		ksft_print_msg("Unknown timer_create() type %d\n", which);
+		return -1;
 	}
-	fflush(stdout);
 
 	done = 0;
 	err = timer_create(which, NULL, &id);
 	if (err < 0) {
-		perror("Can't create timer\n");
+		ksft_perror("Can't create timer");
 		return -1;
 	}
 	signal(SIGALRM, sig_handler);
 
 	err = gettimeofday(&start, NULL);
 	if (err < 0) {
-		perror("Can't call gettimeofday()\n");
+		ksft_perror("Can't call gettimeofday()");
 		return -1;
 	}
 
 	err = timer_settime(id, 0, &val, NULL);
 	if (err < 0) {
-		perror("Can't set timer\n");
+		ksft_perror("Can't set timer");
 		return -1;
 	}
 
@@ -176,14 +174,12 @@ static int check_timer_create(int which)
 
 	err = gettimeofday(&end, NULL);
 	if (err < 0) {
-		perror("Can't call gettimeofday()\n");
+		ksft_perror("Can't call gettimeofday()");
 		return -1;
 	}
 
-	if (!check_diff(start, end))
-		printf("[OK]\n");
-	else
-		printf("[FAIL]\n");
+	ksft_test_result(check_diff(start, end) == 0,
+			 "timer_create() per %s\n", type);
 
 	return 0;
 }
@@ -220,25 +216,25 @@ static int check_timer_distribution(void)
 		.it_interval.tv_nsec = 1000 * 1000,
 	};
 
-	printf("Check timer_create() per process signal distribution... ");
-	fflush(stdout);
-
 	remain = nthreads + 1;  /* worker threads + this thread */
 	signal(SIGALRM, distribution_handler);
 	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
 	if (err < 0) {
-		perror("Can't create timer\n");
+		ksft_perror("Can't create timer");
 		return -1;
 	}
 	err = timer_settime(id, 0, &val, NULL);
 	if (err < 0) {
-		perror("Can't set timer\n");
+		ksft_perror("Can't set timer");
 		return -1;
 	}
 
 	for (i = 0; i < nthreads; i++) {
-		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
-			perror("Can't create thread\n");
+		err = pthread_create(&threads[i], NULL, distribution_thread,
+				     NULL);
+		if (err) {
+			ksft_print_msg("Can't create thread: %s (%d)\n",
+				       strerror(errno), errno);
 			return -1;
 		}
 	}
@@ -247,25 +243,30 @@ static int check_timer_distribution(void)
 	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
 
 	for (i = 0; i < nthreads; i++) {
-		if (pthread_join(threads[i], NULL)) {
-			perror("Can't join thread\n");
+		err = pthread_join(threads[i], NULL);
+		if (err) {
+			ksft_print_msg("Can't join thread: %s (%d)\n",
+				       strerror(errno), errno);
 			return -1;
 		}
 	}
 
 	if (timer_delete(id)) {
-		perror("Can't delete timer\n");
+		ksft_perror("Can't delete timer");
 		return -1;
 	}
 
-	printf("[OK]\n");
+	ksft_test_result_pass("check_timer_distribution\n");
 	return 0;
 }
 
 int main(int argc, char **argv)
 {
-	printf("Testing posix timers. False negative may happen on CPU execution \n");
-	printf("based timers if other threads run on the CPU...\n");
+	ksft_print_header();
+	ksft_set_plan(6);
+
+	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
+	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
 	if (check_itimer(ITIMER_VIRTUAL) < 0)
 		return ksft_exit_fail();
@@ -294,5 +295,5 @@ int main(int argc, char **argv)
 	if (check_timer_distribution() < 0)
 		return ksft_exit_fail();
 
-	return ksft_exit_pass();
+	ksft_finished();
 }

-- 
2.39.2

