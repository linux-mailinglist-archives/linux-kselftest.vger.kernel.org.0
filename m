Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4669FAF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBVS1q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 13:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBVS1p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 13:27:45 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BCE3A878
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 10:27:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536eace862cso46903977b3.16
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 10:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677090463;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ECEz/+b65D8RZ8bM86UASeK3RrWrrS5RnSaZwV8Aew=;
        b=AgmMM7BMAyeEwaW+48Be0D9gac3TMDOHMWcDO7+zLMtyHX+7Z8Yb6rX84Pi+cPiqCu
         lKIxHDjW1G+WYvGjGXRW3+0sxcv/zNlwv5sEmnWGfmldfdjgdi8VyPt3nzEttNWezEXR
         HHpIJ3Wy4IxLt73ooZXxZ/B4PRBVonGngSvSdlATbnurVb8TiMdXKOhi7ZnQy0KBsUgk
         QJLH6fB0QbGO9Zthqj6Maj17PQWrTUnXTjJXamvaWCWcXDuH0LCHFkwiPgHSQISMABMo
         0dngXcIs/cvOK+y771eChnh7LvBbgnWrScY6YKlN8okHBvvx2/GnnPCl6xZrLbSB5NUI
         XgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677090463;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ECEz/+b65D8RZ8bM86UASeK3RrWrrS5RnSaZwV8Aew=;
        b=7z10p/+lTqTKM66djRw8QJKHrOUewMb0IT8hAmOahrwWyX/7CKu5Q+OheOcnqlAB2U
         LK07N9hsKN9J+/c2VZx/C++2iD2DDtwpIlmUwT/1XcrWsWXKYUmZ9ngdbD1d9pdbXLM7
         dQWRnV38tqq/0XB1dwIL/JCaNx3mbL5JMESqsfttujqEukIUJNRLc+kk4hnrBKzHwwOI
         huu4Z0TlGEtIVe+h3ENiV4h0OpvDQ0O0i54k2w/+6EeRWV2QtGY/pP1j+JA+8SUW8Uko
         g5R4VLwurtCzvXjCDNDhiqGy0jEf7UObX0sbfy/Ifx571x6rEiDTChhL15VP34Je2+Rt
         WAfQ==
X-Gm-Message-State: AO0yUKW3BohoTRiueT33lc32gG5gRtzdyOamXvVB1kMcxMHIiCv8T74W
        tnIvnDz7mYAbWA3qEAzLJNtFMuyzDg==
X-Google-Smtp-Source: AK7set9UWQHkv2LUpJiGAJqnpUB7r7YUh6QfonRA2PX1lLmv/mNzzbBMhmVyDmX1AVnwi44AAtHI4ePG3g==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:61d4:0:b0:52e:e6ed:30ac with SMTP id
 v203-20020a8161d4000000b0052ee6ed30acmr519461ywb.556.1677090463033; Wed, 22
 Feb 2023 10:27:43 -0800 (PST)
Date:   Wed, 22 Feb 2023 18:27:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230222182740.254087-1-rmoar@google.com>
Subject: [PATCH v2 1/3] kunit: fix bug in debugfs logs of parameterized tests
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix bug in debugfs logs that causes individual parameterized results to not
appear because the log is reinitialized (cleared) when each parameter is
run.

Ensure these results appear in the debugfs logs and increase log size to
allow for the size of parameterized results. As a result, append lines to
the log directly rather than using an intermediate variable that can cause
stack size warnings due to the increased log size.

Here is the debugfs log of ext4_inode_test which uses parameterized tests
before the fix:

     KTAP version 1

     # Subtest: ext4_inode_test
     1..1
 # Totals: pass:16 fail:0 skip:0 total:16
 ok 1 ext4_inode_test

As you can see, this log does not include any of the individual
parametrized results.

After (in combination with the next two fixes to remove extra empty line
and ensure KTAP valid format):

 KTAP version 1
 1..1
     KTAP version 1
     # Subtest: ext4_inode_test
     1..1
        KTAP version 1
         # Subtest: inode_test_xtimestamp_decoding
	 ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
	 =E2=80=A6 (the rest of the individual parameterized tests)
         ok 16 2446-05-10 Upper bound of 32bit >=3D0 timestamp. All extra
     # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
     ok 1 inode_test_xtimestamp_decoding
 # Totals: pass:16 fail:0 skip:0 total:16
 ok 1 ext4_inode_test

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes from v1 -> v2:
- Remove the use of the line variable in kunit_log_append that was causing
  stack size warnings.
- Add before and after to the commit message.

 include/kunit/test.h |  2 +-
 lib/kunit/test.c     | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 08d3559dd703..0668d29f3453 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 struct kunit;
=20
 /* Size of log associated with test. */
-#define KUNIT_LOG_SIZE	512
+#define KUNIT_LOG_SIZE 1500
=20
 /* Maximum size of parameter description string. */
 #define KUNIT_PARAM_DESC_SIZE 128
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9e15bb60058..c406aa07d875 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -114,22 +114,26 @@ static void kunit_print_test_stats(struct kunit *test=
,
  */
 void kunit_log_append(char *log, const char *fmt, ...)
 {
-	char line[KUNIT_LOG_SIZE];
 	va_list args;
-	int len_left;
+	int len, log_len, len_left;
=20
 	if (!log)
 		return;
=20
-	len_left =3D KUNIT_LOG_SIZE - strlen(log) - 1;
+	log_len =3D strlen(log);
+	len_left =3D KUNIT_LOG_SIZE - log_len - 1;
 	if (len_left <=3D 0)
 		return;
=20
+	/* Evaluate length of line to add to log */
 	va_start(args, fmt);
-	vsnprintf(line, sizeof(line), fmt, args);
+	len =3D vsnprintf(NULL, 0, fmt, args);
 	va_end(args);
=20
-	strncat(log, line, len_left);
+	/* Print formatted line to the log */
+	va_start(args, fmt);
+	vsnprintf(log + log_len, min(len, len_left), fmt, args);
+	va_end(args);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
=20
@@ -437,7 +441,6 @@ static void kunit_run_case_catch_errors(struct kunit_su=
ite *suite,
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
=20
-	kunit_init_test(test, test_case->name, test_case->log);
 	try_catch =3D &test->try_catch;
=20
 	kunit_try_catch_init(try_catch,
@@ -533,6 +536,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 		struct kunit_result_stats param_stats =3D { 0 };
 		test_case->status =3D KUNIT_SKIPPED;
=20
+		kunit_init_test(&test, test_case->name, test_case->log);
+
 		if (!test_case->generate_params) {
 			/* Non-parameterised test. */
 			kunit_run_case_catch_errors(suite, test_case, &test);

base-commit: 82649c7c0da431d147a75c6ae768ee42c1053f53
--=20
2.39.2.637.g21b0678d19-goog

