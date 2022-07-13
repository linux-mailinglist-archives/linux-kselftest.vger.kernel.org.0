Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF35573E03
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiGMUqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiGMUqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:38 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FCC31381
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=3DHgH0YDdgidkq
        pYHCfoQogXzuM602W5w4oRJJj7FIQ=; b=Fxtv1zI9ggX3Jea90viReeoWIciXaN
        tzftQcURhg6LxwDEnIaH4YVfkaz+/dcv5ji4ttjSQByT1R+0JrjAZ3K/oGLvnN/N
        g4MApO0px6158gfan+h/F03sJZ9Rh2asMDK6KdVEzOJX9eQH3T+40D8q0DMV1vHJ
        vO6tbNdou2DJ4=
Received: (qmail 305684 invoked from network); 13 Jul 2022 22:46:35 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:35 +0200
X-UD-Smtp-Session: l3s3148p1@Z+p14bXjmKYgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/9] selftests: timers: nanosleep: adapt to kselftest framework
Date:   Wed, 13 Jul 2022 22:46:15 +0200
Message-Id: <20220713204623.5443-4-wsa+renesas@sang-engineering.com>
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
  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:8 error:0

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/testing/selftests/timers/nanosleep.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 71b5441c2fd9..df1d03516e7b 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -133,33 +133,37 @@ int main(int argc, char **argv)
 	long long length;
 	int clockid, ret;
 
+	ksft_print_header();
+	ksft_set_plan(NR_CLOCKIDS);
+
 	for (clockid = CLOCK_REALTIME; clockid < NR_CLOCKIDS; clockid++) {
 
 		/* Skip cputime clockids since nanosleep won't increment cputime */
 		if (clockid == CLOCK_PROCESS_CPUTIME_ID ||
 				clockid == CLOCK_THREAD_CPUTIME_ID ||
-				clockid == CLOCK_HWSPECIFIC)
+				clockid == CLOCK_HWSPECIFIC) {
+			ksft_test_result_skip("%-31s\n", clockstring(clockid));
 			continue;
+		}
 
-		printf("Nanosleep %-31s ", clockstring(clockid));
 		fflush(stdout);
 
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
 			ret = nanosleep_test(clockid, length);
 			if (ret == UNSUPPORTED) {
-				printf("[UNSUPPORTED]\n");
+				ksft_test_result_skip("%-31s\n", clockstring(clockid));
 				goto next;
 			}
 			if (ret < 0) {
-				printf("[FAILED]\n");
-				return ksft_exit_fail();
+				ksft_test_result_fail("%-31s\n", clockstring(clockid));
+				ksft_exit_fail();
 			}
 			length *= 100;
 		}
-		printf("[OK]\n");
+		ksft_test_result_pass("%-31s\n", clockstring(clockid));
 next:
 		ret = 0;
 	}
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
-- 
2.35.1

