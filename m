Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEAC3A3A9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 05:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFKD7k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 23:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFKD7j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 23:59:39 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42531C0617AD
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 20:57:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c15-20020ae9e20f0000b02903aafa8c83e7so6315514qkc.21
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 20:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4GJ6IQLArclcwrRp6TrE2/aP5eBvoi7bbacXvoz3dt8=;
        b=I8xBmcKhwP67CQoV9rW3B7jJIyWVaJ1NyNdUC9QsrlnXdBx+gKJEzXobNOD+Flxinr
         7hUrzlZDRP45ccJtA/djL/cCjb9qs1vUPkhavpe6nY9frEDYw7ce/DBAKjaKItUW0GGj
         4H6vKoQ2VJ7QyGzv2eWNxTjITKzJ2JxojstZWUBm8dsX65zEGCyt19vsy8Bv0Y9vBXuR
         L8RCBHfbHmYHik4xLi44wczupoWToOIBAfXgIssDcrQp/G688LVwaHHYET607PzIxEt+
         Vz/v7FCknOYOAvdwHoI4RYj+ZwpopGmTKUvcYyCfnbj9d+sBLK2iqxSE5OymrQvdgFl6
         niaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4GJ6IQLArclcwrRp6TrE2/aP5eBvoi7bbacXvoz3dt8=;
        b=GK9FegxvI5zXNLovAdig8LADunFk/sR3Sl4m2mHwGJ/EloRqDhVA8OTzbLnu50UeqS
         JZPAbfAaDttU0DXcKQtyPVVBsqp3ZjdWgs0qBCa6bH6KQpsOtjVjstL4AFSTx3BgaDvx
         t462dQm3BBXNBWqtqpJEoOTxxIndFdiDCcSgo93zTDMakj/6rwo+45syjhbWFlJHXPNk
         eW61j0EIA0j5hkJ61wl/Ozfpm/Knjm7kQJDrOXi01L5/x0OPXppt5ISmalSkJnDzJPAK
         gwoTYb/pM22SbOnQHk+qcVm2ImUOCYHgnmaxbRADVt4O/5p+7hfHV+miR0rvFNZHL7uL
         YI1g==
X-Gm-Message-State: AOAM530+WlkmZARHS6yYZpuozWdwIPQHeZY6sZwYXJmyg3GCvhifOahm
        /71hdnKtU20hdrBAJ0RzcWj5bKWKb0ThoQ==
X-Google-Smtp-Source: ABdhPJzdVH92RATcdT7fOiewtiBgUGSJ1fLrTKX68+rIrCDdqAsJLud11BTxpEdnpv78xw7ttXzORFT4sgwYDQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:b697:a576:a25f:5b1e])
 (user=davidgow job=sendgmr) by 2002:a0c:f982:: with SMTP id
 t2mr2921181qvn.28.1623383850258; Thu, 10 Jun 2021 20:57:30 -0700 (PDT)
Date:   Thu, 10 Jun 2021 20:57:25 -0700
Message-Id: <20210611035725.1248874-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] kunit: Fix result propagation for parameterised tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When one parameter of a parameterised test failed, its failure would be
propagated to the overall test, but not to the suite result (unless it
was the last parameter).

This is because test_case->success was being reset to the test->success
result after each parameter was used, so a failing test's result would
be overwritten by a non-failing result. The overall test result was
handled in a third variable, test_result, but this was disacarded after
the status line was printed.

Instead, just propagate the result after each parameter run.

Signed-off-by: David Gow <davidgow@google.com>
Fixes: fadb08e7c750 ("kunit: Support for Parameterized Testing")
---

This is fixing quite a serious bug where some test suites would appear
to succeed even if some of their component tests failed. It'd be nice to
get this into kunit-fixes ASAP.

(This will require a rework of some of the skip tests work, for which
I'll send out a new version soon.)

Cheers,
-- David

 lib/kunit/test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 2f6cc0123232..17973a4a44c2 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -376,7 +376,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
-	test_case->success = test->success;
+	test_case->success &= test->success;
 }
 
 int kunit_run_tests(struct kunit_suite *suite)
@@ -388,7 +388,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
-		bool test_success = true;
+		test_case->success = true;
 
 		if (test_case->generate_params) {
 			/* Get initial param. */
@@ -398,7 +398,6 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		do {
 			kunit_run_case_catch_errors(suite, test_case, &test);
-			test_success &= test_case->success;
 
 			if (test_case->generate_params) {
 				if (param_desc[0] == '\0') {
@@ -420,7 +419,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			}
 		} while (test.param_value);
 
-		kunit_print_ok_not_ok(&test, true, test_success,
+		kunit_print_ok_not_ok(&test, true, test_case->success,
 				      kunit_test_case_num(suite, test_case),
 				      test_case->name);
 	}
-- 
2.32.0.272.g935e593368-goog

