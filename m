Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6D632C4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 19:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiKUSss (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 13:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiKUSs3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 13:48:29 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91070C9AAA
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 10:48:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349423f04dbso120913857b3.13
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 10:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQcwB4vN/QPlHNzIeMIdeVxHrWjoYtLVSwX3XdqNUTk=;
        b=ku2ue9y1mdoW8zdPD9kQYrtqkg33ektbEwOoHHSQag6bzrTtNPLAUsCBaUc5+0nf+2
         SNosJeorNGuwPC1A7ZYERV5egi/7X7+RSWzN+XvTcGtky/eS2TEIsnD089ckE/XINOQb
         U/xkvoEZmNVvePV1MCgiOY5Eh7jgXefg2ZfPzk3YW/Oi9Njw3WQdssi+P4IaavtZt/ce
         Dr98V+qBqqKH9PC7LIGREwmH8OlQ70ZfSraJG3FyjABtoGcvtCj9YUUGdka5NMu8RnnF
         8lwFVQPjzltvMYGaxx7GUS2kJMncAZepn/Q7a6eHzqkwm8Jkt8bPGuRcsZwr/i6fZ4R3
         0sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bQcwB4vN/QPlHNzIeMIdeVxHrWjoYtLVSwX3XdqNUTk=;
        b=sJFjIAmkQKY16ekEX2luxKd1Il21XoSxinAaYuzBI+zbiELWityrDnBa8IYnqaiLE7
         kUE5x4YOhvO8RiZMKEP6FZfSBoDBscWlSYsjNjlPeospg5uCFCUrI3Uwk6XLl9X6g4le
         fjs63Qq7yZnN1RWlrBfMrErXKrN59Hx0D4BCZGmsCF5sKW6qA3qE3Egf5LQZlpEFjWfv
         1cQsW7FVyP/zhV4yP93e9NyoWraCmQmWib1O71q9NI0rvjpCFk0mRLEeauRFDYjwSdMm
         dLkxIGpKRbTrxNbn7AcG5ppcLas1QtJUQVpCBIIgDQ94lLMZQ8cX0/N0a6Hng2zoOA7r
         xMoA==
X-Gm-Message-State: ANoB5pknwxo9lrm3Wer16yNyW9wbl1hNlLL6ZIx+mJ8TvCZxZJ72qDC1
        EH1PvgvaAxkI5gGJ5JVfrmKdx53cTA==
X-Google-Smtp-Source: AA0mqf6Co1YRdEByM59iafzE+5AAhs6woXpbARjutNx88t6VyNc4Ej7uv4drL/NFwbh438j8XETdSxYDXg==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a81:ec0b:0:b0:3a7:c4eb:4955 with SMTP id
 j11-20020a81ec0b000000b003a7c4eb4955mr0ywm.126.1669056506889; Mon, 21 Nov
 2022 10:48:26 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:47:43 +0000
In-Reply-To: <20221121184743.1123556-1-rmoar@google.com>
Mime-Version: 1.0
References: <20221121184743.1123556-1-rmoar@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121184743.1123556-2-rmoar@google.com>
Subject: [PATCH v2 2/2] kunit: improve KTAP compliance of KUnit test output
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, isabbasso@riseup.net,
        anders.roxell@linaro.org, Rae Moar <rmoar@google.com>
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

Change KUnit test output to better comply with KTAP v1 specifications
found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
1) Use "KTAP version 1" instead of "TAP version 14" as test output header
2) Remove '-' between test number and test name on test result lines
2) Add KTAP version lines to each subtest header as well

Note that the new KUnit output still includes the =E2=80=9C# Subtest=E2=80=
=9D line now
located after the KTAP version line. This does not completely match the
KTAP v1 spec but since it is classified as a diagnostic line, it is not
expected to be disruptive or break any existing parsers. This
=E2=80=9C# Subtest=E2=80=9D line comes from the TAP 14 spec
(https://testanything.org/tap-version-14-specification.html)
and it is used to define the test name before the results.

Original output:

 TAP version 14
 1..1
   # Subtest: kunit-test-suite
   1..3
   ok 1 - kunit_test_1
   ok 2 - kunit_test_2
   ok 3 - kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 - kunit-test-suite

New output:

 KTAP version 1
 1..1
   KTAP version 1
   # Subtest: kunit-test-suite
   1..3
   ok 1 kunit_test_1
   ok 2 kunit_test_2
   ok 3 kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 kunit-test-suite

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/all/20221104194705.3245738-1-rmoar@google.com/
- Switch order of patches to make changes to the parser before making
  changes to the test output
- Change location of the new KTAP version line in subtest header to be
  before the subtest header line

 lib/kunit/executor.c | 6 +++---
 lib/kunit/test.c     | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 9bbc422c284b..74982b83707c 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *suit=
e_set)
 {
 	size_t num_suites =3D suite_set->end - suite_set->start;
=20
-	pr_info("TAP version 14\n");
+	pr_info("KTAP version 1\n");
 	pr_info("1..%zu\n", num_suites);
=20
 	__kunit_test_suites_init(suite_set->start, num_suites);
@@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *sui=
te_set)
 	struct kunit_suite * const *suites;
 	struct kunit_case *test_case;
=20
-	/* Hack: print a tap header so kunit.py can find the start of KUnit outpu=
t. */
-	pr_info("TAP version 14\n");
+	/* Hack: print a ktap header so kunit.py can find the start of KUnit outp=
ut. */
+	pr_info("KTAP version 1\n");
=20
 	for (suites =3D suite_set->start; suites < suite_set->end; suites++)
 		kunit_suite_for_each_test_case((*suites), test_case) {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 90640a43cf62..19344cb501c5 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -149,6 +149,7 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
=20
 static void kunit_print_suite_start(struct kunit_suite *suite)
 {
+	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
 		  suite->name);
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
@@ -175,13 +176,13 @@ static void kunit_print_ok_not_ok(void *test_or_suite=
,
 	 * representation.
 	 */
 	if (suite)
-		pr_info("%s %zd - %s%s%s\n",
+		pr_info("%s %zd %s%s%s\n",
 			kunit_status_to_ok_not_ok(status),
 			test_number, description, directive_header,
 			(status =3D=3D KUNIT_SKIPPED) ? directive : "");
 	else
 		kunit_log(KERN_INFO, test,
-			  KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
+			  KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
 			  kunit_status_to_ok_not_ok(status),
 			  test_number, description, directive_header,
 			  (status =3D=3D KUNIT_SKIPPED) ? directive : "");
--=20
2.38.1.584.g0f3c55d4c2-goog

