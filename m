Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964334E6B2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Mar 2022 00:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355730AbiCXXUs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Mar 2022 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355674AbiCXXUq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Mar 2022 19:20:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B4353A6C
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 16:19:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m18so1449542plx.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHqHFFpa5oC69fP2FCgHGpOKvKQX1YCTBf3TwuzqoNE=;
        b=fbPYArlQx50iamshoEvn1TUlzgo8nWqHeGT1DZrpWtdbibFNTV6wW8L8MN+mUwu78D
         j7P2ArS6H90s7rwUyr0sxDKM9fsF1WYahCHQ7azDJj9iWysPgN+3SlUgNK5M2AHrc81M
         ttdYc+utjjAxAxTilwOxhrxnbY4W3GIr5grwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHqHFFpa5oC69fP2FCgHGpOKvKQX1YCTBf3TwuzqoNE=;
        b=HCEr3jkdOfXozBxTDNy05uoweRsiXo2KhNsdc9eaI9qD9xyw7cIziMxhCVsFKy13q8
         JjW9meq7Ioe/8uukiu1iurlU5z8Vd/XUuSJKQ10vvX3YYwt28IL/BkfV4k1AbIYZFYDh
         KSBX7gCFNP13vGCPYUdTr9yL7jlJFCVTMgNA3D9Kz8rl9R/GRNn/DKlTfA1E+YmAFky+
         L/Mrcx8BIiHzsuMLgyfeNqdxQoacOpf0W0J3JoEU4VMhp0knee2RV2g493igR22LOVDu
         jospj4D79NPKiBxCl07amqzqM2H3IOJRE8Ey8piMy3WvUF/38/AwgSGpliqromWppBOA
         O+SQ==
X-Gm-Message-State: AOAM531xpbdkIXP7DINw0t42tFhzdSKOA6x3Kt1TFLw2Dq1lsXqdddYr
        G58SM++bDh0iHqkFO5BDrXDjlw==
X-Google-Smtp-Source: ABdhPJyinT6/QqXNhFeVGMB3xAneGt9oNUVvO0KLBd4YjvoKSluJGfVLAlNsGCC57y/VWwRG5TTJ7w==
X-Received: by 2002:a17:90b:4c09:b0:1c7:6c8:43c8 with SMTP id na9-20020a17090b4c0900b001c706c843c8mr9032037pjb.208.1648163952166;
        Thu, 24 Mar 2022 16:19:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f6519ce666sm4532608pfi.170.2022.03.24.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:19:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     shuah@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] selftests/harness: Run TEARDOWN for ASSERT failures
Date:   Thu, 24 Mar 2022 16:19:06 -0700
Message-Id: <20220324231907.1363887-2-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324231907.1363887-1-keescook@chromium.org>
References: <20220324231907.1363887-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4758; h=from:subject; bh=0T38HzU8+bm6Q63KaidvXUMnrp8eZqY57zLg3zH/o/A=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiPPxqSDr1CXvbwH34M5fSblmZaNneFSzMpiTGM0d/ 90+F5zOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYjz8agAKCRCJcvTf3G3AJvTkEA CiPMfWYC5z46AFuK+F0bbhaBC7z8ty/oP2ut2DxuQ9zJF5vCCWzPy8utegmyQzqLf2G0eVtyqOGLA9 z9R9IsyvhdqahTqCs4CnSQM+1ExmovNFrvnxVm2MPTC4Hw4HOrEXQ147p6fAyWRHJXku5oFEicURd8 +Zav83ohj2PSDwsvr/O7zOcbXlCptbA9XeyFUqoFbGRK3knG7QFNXnePKxARzYFkCiwemV+3RnC2eZ r+f8i8t+E1Z74jecj/DYjKuhRsdi7sx7YuwJ6SfmOfSt89ajcL/MDUMfBVday5TkZmsCw74zvi+8pA xSfHgm/rTyrCU68weOtWsZrr9mQ5kI9lFA/aISU/JWE/zf4vJwDwc/8jeU/W/Nf+YFnLo4Q0Su+2LJ MfywZYFxT8F1GLSpi6ncvYYtE4kxAmCztIu1lHc7o7ZKWX6OTj/MwQsHB5JZNw1W0J2HjJHzKzHdUM GwNTfZO9OBUqsk1YcIn/vK/NcjdTLFG5rlOTct+BXr4wH5SKU+vorUrHFUi8Eb8HeoW5ARNLN+4CrH TuXaXLkeDaI3rmiXb3dztoHGv9DQwncJ8OoYZXDdt+8W3BKZq1kHvSptD1ILQDf2LcU8l2eMnsSvqB 2pmEvJ+17rfn/4DFUN/oLJehWqghehI/Pgx8U/7OqYsr3S+7+DdQVs9kj78g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kselftest test harness has traditionally not run the registered
TEARDOWN handler when a test encountered an ASSERT. This creates
unexpected situations and tests need to be very careful about using
ASSERT, which seems a needless hurdle for test writers.

Because of the harness's design for optional failure handlers, the
original implementation of ASSERT used an abort() to immediately
stop execution, but that meant the context for running teardown was
lost. Instead, use setjmp/longjmp so that teardown can be done.

Failed SETUP routines continue to not be followed by TEARDOWN, though.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 49 ++++++++++++++-------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 471eaa7b3a3f..bef08f824eb5 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -64,6 +64,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <setjmp.h>
 
 #include "kselftest.h"
 
@@ -183,7 +184,10 @@
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata *variant) \
 	{ \
-		test_name(_metadata); \
+		_metadata->setup_completed = true; \
+		if (setjmp(_metadata->env) == 0) \
+			test_name(_metadata); \
+		__test_check_assert(_metadata); \
 	} \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = #test_name, \
@@ -356,10 +360,7 @@
  * Defines a test that depends on a fixture (e.g., is part of a test case).
  * Very similar to TEST() except that *self* is the setup instance of fixture's
  * datatype exposed for use by the implementation.
- *
- * Warning: use of ASSERT_* here will skip TEARDOWN.
  */
-/* TODO(wad) register fixtures on dedicated test lists. */
 #define TEST_F(fixture_name, test_name) \
 	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
 
@@ -381,12 +382,17 @@
 		/* fixture data is alloced, setup, and torn down per call. */ \
 		FIXTURE_DATA(fixture_name) self; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
-		fixture_name##_setup(_metadata, &self, variant->data); \
-		/* Let setup failure terminate early. */ \
-		if (!_metadata->passed) \
-			return; \
-		fixture_name##_##test_name(_metadata, &self, variant->data); \
-		fixture_name##_teardown(_metadata, &self); \
+		if (setjmp(_metadata->env) == 0) { \
+			fixture_name##_setup(_metadata, &self, variant->data); \
+			/* Let setup failure terminate early. */ \
+			if (!_metadata->passed) \
+				return; \
+			_metadata->setup_completed = true; \
+			fixture_name##_##test_name(_metadata, &self, variant->data); \
+		} \
+		if (_metadata->setup_completed) \
+			fixture_name##_teardown(_metadata, &self); \
+		__test_check_assert(_metadata); \
 	} \
 	static struct __test_metadata \
 		      _##fixture_name##_##test_name##_object = { \
@@ -683,7 +689,7 @@
  */
 #define OPTIONAL_HANDLER(_assert) \
 	for (; _metadata->trigger; _metadata->trigger = \
-			__bail(_assert, _metadata->no_print, _metadata->step))
+			__bail(_assert, _metadata))
 
 #define __INC_STEP(_metadata) \
 	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
@@ -830,6 +836,9 @@ struct __test_metadata {
 	bool timed_out;	/* did this test timeout instead of exiting? */
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
+	bool aborted;	/* stopped test due to failed ASSERT */
+	bool setup_completed; /* did setup finish? */
+	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
 };
@@ -848,16 +857,26 @@ static inline void __register_test(struct __test_metadata *t)
 	__LIST_APPEND(t->fixture->tests, t);
 }
 
-static inline int __bail(int for_realz, bool no_print, __u8 step)
+static inline int __bail(int for_realz, struct __test_metadata *t)
 {
+	/* if this is ASSERT, return immediately. */
 	if (for_realz) {
-		if (no_print)
-			_exit(step);
-		abort();
+		t->aborted = true;
+		longjmp(t->env, 1);
 	}
+	/* otherwise, end the for loop and continue. */
 	return 0;
 }
 
+static inline void __test_check_assert(struct __test_metadata *t)
+{
+	if (t->aborted) {
+		if (t->no_print)
+			_exit(t->step);
+		abort();
+	}
+}
+
 struct __test_metadata *__active_test;
 static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 {
-- 
2.32.0

