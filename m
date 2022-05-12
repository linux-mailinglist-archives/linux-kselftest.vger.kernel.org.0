Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7702D5254F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357718AbiELSfx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 14:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357715AbiELSfv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 14:35:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933615FCD
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:35:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so5279937ybp.19
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JGiQqPbzZI43Exh1pGQSCZMsidLcFHDmUJ9SQCHRjpQ=;
        b=TOEnTKWHTsN8Xkd5ifzGE7jvO9Btwk9Kqsf5YLpMp4cgR8zpxKNk7j0GOVKsVualvK
         NA/kXhsrvncY07DiA5K9adK63sAElgwgamxWTD9qN2h1qLP3KAo6Avu/qTQBDqQBlceD
         u9aVk3JdE5bmHPjFh18f9NFUSXN4QqZCeqm+RvVa0BiPfYefXWuqlspXCFPWUfltZpUq
         xW9hfEIEo9XsINrjhhkOjk0aCJsvA32euf1X6xY6mJrNtNzJbJ3P7Tghuw1bSmWvYASE
         ZKtoMRlKmMAtBTI9+i/yplwCpoipHZqYFYxON8axNP+b06Ow/dxvz2bXzKAz6bE858YM
         nYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JGiQqPbzZI43Exh1pGQSCZMsidLcFHDmUJ9SQCHRjpQ=;
        b=Py2NtBZ4bjumnJZjjO4wlmwmduYIb1cMNf+cVqSojia/Tqe7lnB9gChwasarXXHPtM
         CB+e/PEDsr9IA5ut1TWFDiUVV+JiBb6FfDMtsTJmijOabAhJt3hdSE7yNybUc+UiEZ4b
         wzSNg3DywTSq3DCkkIpGsbvSKPkLjM+FXu92CXyDUPF4cqeoGonWT5/aDcwzi9c4uLOy
         O+DMJenuBhD/S0o4HHmgmSyAtewj0wF1q66K/0vAy9bhLpON0upKHYuzKQK2nJo/Ggyn
         ZgbZWXx1s54U4HCE4dCr425qb5F0aKBWCsI2i9xM69ER0X0KjE3CR5ObegsYivsZ0ysD
         ujFQ==
X-Gm-Message-State: AOAM530+4JzEHhEB/J1Yhe1vIptYw9sFoRMrAHLWc1ccDGl6cn2MSWhY
        KhJzMEmbdNDxYksQeRTfZ6+ZIrfeaSGpBQ==
X-Google-Smtp-Source: ABdhPJyRK46hxvfj/rDOehwb6CSzdEFN91lo67wAnd2VOsNNdFm5yiKXWO5EPr5DQWn3fiOfQNuD0//5cicCtg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:648d:cdc5:d51:4873])
 (user=dlatypov job=sendgmr) by 2002:a25:4094:0:b0:64a:86ea:ff02 with SMTP id
 n142-20020a254094000000b0064a86eaff02mr1228468yba.592.1652380549482; Thu, 12
 May 2022 11:35:49 -0700 (PDT)
Date:   Thu, 12 May 2022 11:35:37 -0700
In-Reply-To: <20220512183538.3787321-1-dlatypov@google.com>
Message-Id: <20220512183538.3787321-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220512183538.3787321-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 2/3] kunit: tool: make parser stop overwriting status of
 suites w/ no_tests
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

Consider this invocation
$ ./tools/testing/kunit/kunit.py parse <<EOF
  TAP version 14
  1..2
  ok 1 - suite
    # Subtest: no_tests_suite
    # catastrophic error!
  not ok 1 - no_tests_suite
EOF

It will have a 0 exit code even though there's a "not ok".

Consider this one:
$ ./tools/testing/kunit/kunit.py parse <<EOF
  TAP version 14
  1..2
  ok 1 - suite
  not ok 1 - no_tests_suite
EOF

It will a non-zero exit code.

Why?
We have this line in the kunit_parser.py
> parent_test = parse_test_header(lines, test)
where we have special handling when we see "# Subtest" and we ignore the
explicit reported "not ok 1" status!

Also, NO_TESTS at a suite-level only results in a non-zero status code
where then there's only one suite atm.

This change is the minimal one to make sure we don't overwrite it.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: rebase onto -kselftest/kunit branch, no changes
---
 tools/testing/kunit/kunit_parser.py                        | 7 +++++--
 .../test_data/test_is_test_passed-no_tests_no_plan.log     | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index c8c0df56cc51..9f5a73f36c2d 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -775,8 +775,11 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 
 	# Check for there being no tests
 	if parent_test and len(subtests) == 0:
-		test.status = TestStatus.NO_TESTS
-		test.add_error('0 tests run!')
+		# Don't override a bad status if this test had one reported.
+		# Assumption: no subtests means CRASHED is from Test.__init__()
+		if test.status in (TestStatus.TEST_CRASHED, TestStatus.SUCCESS):
+			test.status = TestStatus.NO_TESTS
+			test.add_error('0 tests run!')
 
 	# Add statuses to TestCounts attribute in Test object
 	bubble_up_test_results(test)
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
index dd873c981108..4f81876ee6f1 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
@@ -3,5 +3,5 @@ TAP version 14
   # Subtest: suite
   1..1
     # Subtest: case
-  ok 1 - case # SKIP
+  ok 1 - case
 ok 1 - suite
-- 
2.36.0.550.gb090851708-goog

