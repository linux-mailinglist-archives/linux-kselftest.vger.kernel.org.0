Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70322573E08
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiGMUql (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbiGMUqk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:40 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D882B1BE
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=qVz6u1/TIUyHL0
        YN1TPZEXt419yarlt7ZwURc+28Rfk=; b=HXJQsnsHOo7XsoS9orbeMVtmBEReJ+
        AG87Vmi7VRukZqRUr/p6ebKyQ4JLidhgT831nibraDov1CUJH3H+b1fTpxoXNKPl
        jXVRFzzlXGm8R45ct7w7L8ITnkVKfg5jKSx+a2G9ULyyI3r8Wlu4wGJWTqW6KcOg
        CKnR/fMbO3orY=
Received: (qmail 305728 invoked from network); 13 Jul 2022 22:46:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:36 +0200
X-UD-Smtp-Session: l3s3148p1@bYaE4bXjpKYgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 4/9] selftests: timers: inconsistency-check: adapt to kselftest framework
Date:   Wed, 13 Jul 2022 22:46:16 +0200
Message-Id: <20220713204623.5443-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

So we have proper counters at the end of a test, e.g.:
  # Totals: pass:11 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../selftests/timers/inconsistency-check.c    | 32 +++++++++++--------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index e6756d9c60a7..36a49fba6c9b 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -122,30 +122,28 @@ int consistency_test(int clock_type, unsigned long seconds)
 		if (inconsistent >= 0) {
 			unsigned long long delta;
 
-			printf("\%s\n", start_str);
+			ksft_print_msg("\%s\n", start_str);
 			for (i = 0; i < CALLS_PER_LOOP; i++) {
 				if (i == inconsistent)
-					printf("--------------------\n");
-				printf("%lu:%lu\n", list[i].tv_sec,
+					ksft_print_msg("--------------------\n");
+				ksft_print_msg("%lu:%lu\n", list[i].tv_sec,
 							list[i].tv_nsec);
 				if (i == inconsistent + 1)
-					printf("--------------------\n");
+					ksft_print_msg("--------------------\n");
 			}
 			delta = list[inconsistent].tv_sec * NSEC_PER_SEC;
 			delta += list[inconsistent].tv_nsec;
 			delta -= list[inconsistent+1].tv_sec * NSEC_PER_SEC;
 			delta -= list[inconsistent+1].tv_nsec;
-			printf("Delta: %llu ns\n", delta);
+			ksft_print_msg("Delta: %llu ns\n", delta);
 			fflush(0);
 			/* timestamp inconsistency*/
 			t = time(0);
-			printf("%s\n", ctime(&t));
-			printf("[FAILED]\n");
+			ksft_print_msg("%s\n", ctime(&t));
 			return -1;
 		}
 		now = list[0].tv_sec;
 	}
-	printf("[OK]\n");
 	return 0;
 }
 
@@ -178,16 +176,22 @@ int main(int argc, char *argv[])
 
 	setbuf(stdout, NULL);
 
+	ksft_print_header();
+	ksft_set_plan(maxclocks - userclock);
+
 	for (clockid = userclock; clockid < maxclocks; clockid++) {
 
-		if (clockid == CLOCK_HWSPECIFIC)
+		if (clockid == CLOCK_HWSPECIFIC || clock_gettime(clockid, &ts)) {
+			ksft_test_result_skip("%-31s\n", clockstring(clockid));
 			continue;
+		}
 
-		if (!clock_gettime(clockid, &ts)) {
-			printf("Consistent %-30s ", clockstring(clockid));
-			if (consistency_test(clockid, runtime))
-				return ksft_exit_fail();
+		if (consistency_test(clockid, runtime)) {
+			ksft_test_result_fail("%-31s\n", clockstring(clockid));
+			ksft_exit_fail();
+		} else {
+			ksft_test_result_pass("%-31s\n", clockstring(clockid));
 		}
 	}
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
-- 
2.35.1

