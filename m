Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011BB717611
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 07:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjEaFWH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 01:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjEaFWG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 01:22:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64AF107
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 22:22:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568960f4596so50882757b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685510524; x=1688102524;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yMwJqP/yLHHYBIBhaUkVMxdorPRgqyyar3B+yEvQ2G4=;
        b=WERDRhkD4T+RpXH4rKUj0OePrVzWrhHl78GQI+EtD7Rj2lsnAskWZ4+lvI2Wk24nsI
         C8DIiyuN5KE+/CSFkEvtlRhxsBxQFYx8jGfYB4/cKrGL7zjsow6KXnvW9Gxx+VJ4mBA3
         OFI0CvgVnpqpRWzR2dW3Sk6Yu24dl5wT62/PcPHtCmBs5UUc2XiSHOIggiZnYJkcCRV1
         vxaPnBzAsqiSDM07QaLJ28ZBIwtB10te9t3yaCdPC2/ZEr3yMdYGaTuh7StNlBq0Kzyi
         8pQ0TTK/xpe6o/oONx8zvzlud5G9mEtjQyHHEXNxsFqNDI7VDoY0Des1jBIlFChuqmGy
         uknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685510524; x=1688102524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMwJqP/yLHHYBIBhaUkVMxdorPRgqyyar3B+yEvQ2G4=;
        b=Ebn/3siceUISk8mmk4zBLIHptrGMOXv0SW6wENJu7zXXtQ7hwRkoJlNOfeSElPH1Qf
         ccw/KPLwDx3nz8bb4kDUXJXVekQ4s4HS+8Qqg0rQ7mykJQ/4cwqM5WzMRduBK/Jvb1r1
         CTmWjgeP1dA+Sk2NYYfSH5p0IhnlSJiiuXxfX8vJbd/7HIIrLAkglRMYkXiORSPF/mc9
         y9hkwA1CfgqlwxPjrkUJBibSNRJqyaGDkqnzLazCs44QPir8+sFynrco7x1HKgvtWXKA
         Da11wsYWmHL7s80/UfNqBeQ1rwmrX6wZxokqf7WHNNdUdkwbtFCMVi3UubWvvV4W76UT
         kcFQ==
X-Gm-Message-State: AC+VfDye+gAdlZvBnEJS7FXPsNOR2lY6RvsCQOGiqXfW2sBsWDhKGQgu
        tdl9CSl50FACeUQKVur51sXGtMaAKsZ+sw==
X-Google-Smtp-Source: ACHHUZ7qIkK7YE+tXzOFppJHuykAH285q/FknCtTxYJgVn3ls3yM6tLCT8TU0G0Vb3d0H8s6eWH8bjzY84rAGg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:8d0f:0:b0:565:c0e3:d2d7 with SMTP id
 d15-20020a818d0f000000b00565c0e3d2d7mr2687655ywg.1.1685510524079; Tue, 30 May
 2023 22:22:04 -0700 (PDT)
Date:   Wed, 31 May 2023 13:21:57 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531052158.1788232-1-davidgow@google.com>
Subject: [PATCH] kunit: Move kunit_abort() call out of kunit_do_failed_assertion()
From:   David Gow <davidgow@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit aborts the current thread when an assertion fails. Currently, this
is done conditionally as part of the kunit_do_failed_assertion()
function, but this hides the kunit_abort() call from the compiler
(particularly if it's in another module). This, in turn, can lead to
both suboptimal code generation (the compiler can't know if
kunit_do_failed_assertion() will return), and to static analysis tools
like smatch giving false positives.

Moving the kunit_abort() call into the macro should give the compiler
and tools a better chance at understanding what's going on. Doing so
requires exporting kunit_abort(), though it's recommended to continue to
use assertions in lieu of aborting directly.

In addition, kunit_abort() and kunit_do_failed_assertion() are renamed
to make it clear they they're intended for internal KUnit use, to:
__kunit_do_failed_assertion() and __kunit_abort()

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since RFCv1:
https://lore.kernel.org/linux-kselftest/20230526075355.586335-1-davidgow@google.com/
- Add missing MODULE_EXPORT_GPL() (Thanks kernel test robot)
- Rename kunit_abort() and kunit_do_failed_assertion() to make it clear
  they're intended for internal use.
  - Thanks Daniel Latypov!

---
 include/kunit/test.h | 20 ++++++++++++--------
 lib/kunit/test.c     | 10 ++++------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 2f23d6efa505..f40e65adfb1f 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -481,7 +481,9 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
  */
 #define KUNIT_SUCCEED(test) do {} while (0)
 
-void kunit_do_failed_assertion(struct kunit *test,
+void __noreturn __kunit_abort(struct kunit *test);
+
+void __kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
 			       const struct kunit_assert *assert,
@@ -491,13 +493,15 @@ void kunit_do_failed_assertion(struct kunit *test,
 #define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
 	static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;	       \
 	const struct assert_class __assertion = INITIALIZER;		       \
-	kunit_do_failed_assertion(test,					       \
-				  &__loc,				       \
-				  assert_type,				       \
-				  &__assertion.assert,			       \
-				  assert_format,			       \
-				  fmt,					       \
-				  ##__VA_ARGS__);			       \
+	__kunit_do_failed_assertion(test,				       \
+				    &__loc,				       \
+				    assert_type,			       \
+				    &__assertion.assert,		       \
+				    assert_format,			       \
+				    fmt,				       \
+				    ##__VA_ARGS__);			       \
+	if (assert_type == KUNIT_ASSERTION)				       \
+		__kunit_abort(test);					       \
 } while (0)
 
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d3fb93a23ccc..e652ab0d9996 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -310,7 +310,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 	string_stream_destroy(stream);
 }
 
-static void __noreturn kunit_abort(struct kunit *test)
+void __noreturn __kunit_abort(struct kunit *test)
 {
 	kunit_try_catch_throw(&test->try_catch); /* Does not return. */
 
@@ -322,8 +322,9 @@ static void __noreturn kunit_abort(struct kunit *test)
 	 */
 	WARN_ONCE(true, "Throw could not abort from test!\n");
 }
+EXPORT_SYMBOL_GPL(__kunit_abort);
 
-void kunit_do_failed_assertion(struct kunit *test,
+void __kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
 			       const struct kunit_assert *assert,
@@ -340,11 +341,8 @@ void kunit_do_failed_assertion(struct kunit *test,
 	kunit_fail(test, loc, type, assert, assert_format, &message);
 
 	va_end(args);
-
-	if (type == KUNIT_ASSERTION)
-		kunit_abort(test);
 }
-EXPORT_SYMBOL_GPL(kunit_do_failed_assertion);
+EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
 
 void kunit_init_test(struct kunit *test, const char *name, char *log)
 {
-- 
2.41.0.rc0.172.g3f132b7071-goog

