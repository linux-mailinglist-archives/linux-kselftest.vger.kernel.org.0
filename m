Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A57B01A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjI0KTQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjI0KTQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 06:19:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644959E2;
        Wed, 27 Sep 2023 03:19:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBB9C433CB;
        Wed, 27 Sep 2023 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695809953;
        bh=63LUFA7Rl18RX8Q038A1fYQa94hjblSR5oEGq9wpy9M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CNDXL9gSoveVjidsqC1k/2LIN1hh2S5fELc/bM0aWxDbf1F1qTGT9JIWuq2p0kQWA
         VbtWjdUnvqynQGHunCxKKylvq/NEZ1GSzE7rFQg8K07TL4SnRrT5f2dy5cLX4xDcZ6
         LGQyYSHUnh/VwrflPTQctGMdSMONlN0f7SlEiRpxEH8mkXl4eSeBgGrvfYca7TZXsd
         Wlu8nVJTI5cwgq+OR8tRZeJPosKMA980CHmOfzZ14ZkSvPzc3d5x85SDZH531THDv+
         388gPs30MGiK33PYkApvKP5l18NAC2UH/Bxp7eTiDKZJ4gkAXIyGiche7bKDvA3OVY
         cAI6vClWcFuuQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 27 Sep 2023 12:18:59 +0200
Subject: [PATCH 3/3] selftests: timers: Convert nsleep-lat test to generate
 KTAP output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-ktap-posix-timers-v1-3-399de1cbfbea@kernel.org>
References: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
In-Reply-To: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526; i=broonie@kernel.org;
 h=from:subject:message-id; bh=63LUFA7Rl18RX8Q038A1fYQa94hjblSR5oEGq9wpy9M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFAGahoQsX/geKms8lLTrIjGh9lXenG7MMNoBY
 V2BUzIxQuCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRQBmgAKCRAk1otyXVSH
 0E3kCACDFYKSRI/bju7XA5tvQmMIDmo50WpFrllXyh1+Edx6XHx4SPX2EOIgZimzb8zIOngirha
 O14Jd8sJ3wTPgNhiEn5rjZPKHLKeBPZSiKBB18oG3hppYlH5QzQLGbTh4iMcLGHsdsjx/i11YD/
 pVcILKC2dPQ1TpQdnX3kxiPHnDCBg6sKjDGC+OavOx7AppQ87LiegTclLRVI+F222rcyZZwLr7o
 v565/QixdxM6qouc/icy+c5Z/mWk2sTZIVPXzOtbEqMviIntLkZpLd/bAQ7kOIb3q7XJ/NCmb/R
 PNIvJ06W+xnJA2ShnhXIqi4XIWP3L73qFrPqE2nmFxh4PZIu
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

Currently the nsleep-lat test does not produce KTAP output but rather a
custom format. This means that we only get a pass/fail for the suite, not
for each individual test that the suite does. Convert to using the standard
kselftest output functions which result in KTAP output being generated.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/timers/nsleep-lat.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index eb3e79ed7b4a..edb5acacf214 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -118,7 +118,7 @@ int nanosleep_lat_test(int clockid, long long ns)
 	clock_gettime(clockid, &end);
 
 	if (((timespec_sub(start, end)/count)-ns) > UNRESONABLE_LATENCY) {
-		printf("Large rel latency: %lld ns :", (timespec_sub(start, end)/count)-ns);
+		ksft_print_msg("Large rel latency: %lld ns :", (timespec_sub(start, end)/count)-ns);
 		return -1;
 	}
 
@@ -132,20 +132,23 @@ int nanosleep_lat_test(int clockid, long long ns)
 	}
 
 	if (latency/count > UNRESONABLE_LATENCY) {
-		printf("Large abs latency: %lld ns :", latency/count);
+		ksft_print_msg("Large abs latency: %lld ns :", latency/count);
 		return -1;
 	}
 
 	return 0;
 }
 
-
+#define SKIPPED_CLOCK_COUNT 3
 
 int main(int argc, char **argv)
 {
 	long long length;
 	int clockid, ret;
 
+	ksft_print_header();
+	ksft_set_plan(NR_CLOCKIDS - CLOCK_REALTIME - SKIPPED_CLOCK_COUNT);
+
 	for (clockid = CLOCK_REALTIME; clockid < NR_CLOCKIDS; clockid++) {
 
 		/* Skip cputime clockids since nanosleep won't increment cputime */
@@ -154,9 +157,6 @@ int main(int argc, char **argv)
 				clockid == CLOCK_HWSPECIFIC)
 			continue;
 
-		printf("nsleep latency %-26s ", clockstring(clockid));
-		fflush(stdout);
-
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
 			ret = nanosleep_lat_test(clockid, length);
@@ -167,14 +167,12 @@ int main(int argc, char **argv)
 		}
 
 		if (ret == UNSUPPORTED) {
-			printf("[UNSUPPORTED]\n");
-			continue;
-		}
-		if (ret < 0) {
-			printf("[FAILED]\n");
-			return ksft_exit_fail();
+			ksft_test_result_skip("%s\n", clockstring(clockid));
+		} else {
+			ksft_test_result(ret >= 0, "%s\n",
+					 clockstring(clockid));
 		}
-		printf("[OK]\n");
 	}
-	return ksft_exit_pass();
+
+	ksft_finished();
 }

-- 
2.39.2

