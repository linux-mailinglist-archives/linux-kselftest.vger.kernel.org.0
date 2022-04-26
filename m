Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C915B51057A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbiDZRhA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 13:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348801AbiDZRg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 13:36:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6878930
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 10:33:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so16404549ybu.10
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lbSxUEPsGYbNKEJy+sMdn47L3eoN3ThAPUCxaVdqXME=;
        b=qNwnISX0Pemz8rFoen1fpsOmmxqZh40IOeeqGlx2z0S/aVWzCgeDdY/y62SCptGN6d
         qzEsxVdT1KVwUcX5YWiDMLS2Ii/c6kgIMIGvb+evtFxosOJsHZWXqLkm2XXdNSNgE9/2
         TKwxXgnfCk4O1BSsZ6vagSgjw0C/yrIrx5gYF1yuF0zLkz/fnPYlvwhob8dyAG4A83ev
         oVOCb6bnJcd6Ad7qpub4U3wvgsd8gu1tNkI2LLLqOkpPT8pvtYMmvsk1IDgUHwBpElYY
         PgXQz3Do7fSwjt+It6wpVrN5VO5C92KPlcO6WcB4VTOHzH3F03SHTV4Z3W4KK4D1i1Wv
         6/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lbSxUEPsGYbNKEJy+sMdn47L3eoN3ThAPUCxaVdqXME=;
        b=mEEv8cqFUTM0hT1Huuvx/9d8/0uaTjiPGqidlJBBiJrbhGGjetY+ncMszgn76laBwl
         4fGgPgBNr0q8+OejUjV9xwrKKtljtw+fpw/M4TcUc3RTCyaK9ykXRSiiEUqx1V6TyRoF
         GnNOaQZZd4w6UlJv2t5M8dtPm1cxEzh4dWXTnmcacpkw93RJrE1NQQMoG6bBHwgoVAwv
         b4GhQ55q/pfjNcY5fLkvhr43UoXWaMVOTtRUkrf1p3SHGc7WvLylkzDZnDrinskVx18A
         fhK8DPdhDiu4yr8TuRyHe1MYy2N2H3n8S4YpUDXE0EhMy8FmWNni6JFBz1/Icvdyk2VQ
         wrwQ==
X-Gm-Message-State: AOAM533nfXXeijGRa/IOcCQT3WqdAN8psQd75MWdWJcjWCxD4N8phJUw
        +tjGmJ6BxpTM6vJ7GF6o4u6TtQy2TmzAgw==
X-Google-Smtp-Source: ABdhPJwY0mK8MFCa89eU16joYvJWI3IY3QQvJU9OGSeAB+UCKzSdDEUVhaa544glZchvkaOd3u4QALFhx241Dw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:b03d:8d64:4a06:2c5f])
 (user=dlatypov job=sendgmr) by 2002:a25:2a4c:0:b0:648:6a80:9cff with SMTP id
 q73-20020a252a4c000000b006486a809cffmr10741861ybq.507.1650994431115; Tue, 26
 Apr 2022 10:33:51 -0700 (PDT)
Date:   Tue, 26 Apr 2022 10:33:33 -0700
In-Reply-To: <20220426173334.3871399-1-dlatypov@google.com>
Message-Id: <20220426173334.3871399-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 2/3] kunit: tool: make parser stop overwriting status of
 suites w/ no_tests
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
---
 tools/testing/kunit/kunit_parser.py                        | 7 +++++--
 .../test_data/test_is_test_passed-no_tests_no_plan.log     | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 7a0faf527a98..45c2c5837281 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog

