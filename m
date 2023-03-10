Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E331F6B542D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 23:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCJWVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 17:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCJWVg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 17:21:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EB3B5AAE
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 14:21:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e20-20020a25d314000000b00b33355abd3dso1713768ybf.14
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 14:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678486893;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bNk5WMZuK/TfpBzWcYdw8aTqTSoewqS7vtwhPKDCVOo=;
        b=h3i6N8WZ48i/Qi/G0Ngo3IG/d2/GMJ5LB0xCEcllPPJWPbRwvNzNGAPOv5trMIdEMK
         1yx6i4+ABS+Gg2sUwFytLmkpyDkpgiJ9q0LFkXA8gDJopKigN+APi3Y6K60wkYakRJar
         B8JQQ028OlQD9okMKRTJxtHEYWvE0J6LGp1ivsa2+iPfTbYvpO3qKTfmmz3LcE4dHYRt
         0l//B9Wa1YIvmjF2v2KHJkZOatje3n3IcBb7tKAWXcWLPVBcf3zQPlRAqhEvFTXtrCwK
         1SpfkoPNeVa7A/owbpj5vo7DX+VveSvM6CbseMCCGlfIP4+Qu04eJmnfYdi1MkG0eYzK
         tdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678486893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNk5WMZuK/TfpBzWcYdw8aTqTSoewqS7vtwhPKDCVOo=;
        b=7ipryokKlk+MFrBpiCulzmn5ToKtlS6M9sIESyV1gFx5hQaQnKKT/Ms5h6dt0A2Yhf
         PW8PxwJsvAP4wWqfjBZc5zcLp8dpG+DRqNJ8uwbitM0kMS78jUfoaQS0o9PDb7YY8Q7R
         nOWNLq+rKBQgpwZSIlUqEWUE72pYzGnf9alWwngPRfc43RfvQ3+AspaD7p+/mLpYCsgG
         EYfp1Aeee/kN9HB2tKWq8LgRzoZdgRt10x3y3LAoA5nQetGfhUOYtI3kQRumJ8vFS3ig
         vEbu4Vgq8u7tRZIC+mOS38PwxL3Kb8rz/W6nG/yDNqqz5xnaEMvoRHMN7QmJ5TSzeFOb
         rPHA==
X-Gm-Message-State: AO0yUKW5BHNXYAXTv6pXuO620ZnhKyaqN9syi2W62IRPxi4GdUDNK7Dt
        ASrbfLcJhGOgcLAE43lgRFWOGpAABw==
X-Google-Smtp-Source: AK7set87HeKySNFsMz77J6UOYj/OTfMmt2G7hVuS71znb9YCtL54I8c/2svGFVigy1MCpaZO9jVVQWCCoQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:e92:0:b0:ab8:1ed9:cfc9 with SMTP id
 z18-20020a5b0e92000000b00ab81ed9cfc9mr16429440ybr.6.1678486893605; Fri, 10
 Mar 2023 14:21:33 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:20:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310222002.3633162-1-rmoar@google.com>
Subject: [KTAP V2 PATCH] ktap_v2: add skip test result
From:   Rae Moar <rmoar@google.com>
To:     frowand.list@gmail.com, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the test result "skip" to KTAP version 2 as an alternative way to
indicate a test was skipped.

The current spec uses the "#SKIP" directive to indicate that a test was
skipped. However, the "#SKIP" directive is not always evident when quickly
skimming through KTAP results.

The "skip" result would provide an alternative that could make it clearer
that a test has not successfully passed because it was skipped.

Before:

 KTAP version 1
 1..1
   KTAP version 1
   1..2
   ok 1 case_1
   ok 2 case_2 #SKIP
 ok 1 suite

After:

 KTAP version 2
 1..1
   KTAP version 2
   1..2
   ok 1 case_1
   skip 2 case_2
 ok 1 suite

Here is a link to a version of the KUnit parser that is able to parse
the skip test result for KTAP version 2. Note this parser is still able
to parse the "#SKIP" directive.

Link: https://kunit-review.googlesource.com/c/linux/+/5689

Signed-off-by: Rae Moar <rmoar@google.com>
---

Note: this patch is based on Frank's ktap_spec_version_2 branch.

 Documentation/dev-tools/ktap.rst | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index ff77f4aaa6ef..f48aa00db8f0 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -74,7 +74,8 @@ They are required and must have the format:
 	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
 
 The result can be either "ok", which indicates the test case passed,
-or "not ok", which indicates that the test case failed.
+"not ok", which indicates that the test case failed, or "skip", which indicates
+the test case did not run.
 
 <number> represents the number of the test being performed. The first test must
 have the number 1 and the number then must increase by 1 for each additional
@@ -91,12 +92,13 @@ A directive is a keyword that indicates a different outcome for a test other
 than passed and failed. The directive is optional, and consists of a single
 keyword preceding the diagnostic data. In the event that a parser encounters
 a directive it doesn't support, it should fall back to the "ok" / "not ok"
-result.
+/ "skip" result.
 
 Currently accepted directives are:
 
-- "SKIP", which indicates a test was skipped (note the result of the test case
-  result line can be either "ok" or "not ok" if the SKIP directive is used)
+- "SKIP", which indicates a test was skipped (note this is an alternative to
+  the "skip" result type and if the SKIP directive is used, the
+  result can be any type - "ok", "not ok", or "skip")
 - "TODO", which indicates that a test is not expected to pass at the moment,
   e.g. because the feature it is testing is known to be broken. While this
   directive is inherited from TAP, its use in the kernel is discouraged.
@@ -110,7 +112,7 @@ Currently accepted directives are:
 
 The diagnostic data is a plain-text field which contains any additional details
 about why this result was produced. This is typically an error message for ERROR
-or failed tests, or a description of missing dependencies for a SKIP result.
+or failed tests, or a description of missing dependencies for a skipped test.
 
 The diagnostic data field is optional, and results which have neither a
 directive nor any diagnostic data do not need to include the "#" field
@@ -130,11 +132,18 @@ The test "test_case_name" failed.
 
 ::
 
-	ok 1 test # SKIP necessary dependency unavailable
+	skip 1 test # necessary dependency unavailable
 
-The test "test" was SKIPPED with the diagnostic message "necessary dependency
+The test "test" was skipped with the diagnostic message "necessary dependency
 unavailable".
 
+::
+
+	ok 1 test_2 # SKIP this test should not run
+
+The test "test_2" was skipped with the diagnostic message "this test
+should not run".
+
 ::
 
 	not ok 1 test # TIMEOUT 30 seconds
@@ -225,7 +234,7 @@ An example format with multiple levels of nested testing:
 	    not ok 1 test_1
 	    ok 2 test_2
 	  not ok 1 test_3
-	  ok 2 test_4 # SKIP
+	  skip 2 test_4
 	not ok 1 example_test_1
 	ok 2 example_test_2
 
@@ -262,7 +271,7 @@ Example KTAP output
 	  ok 1 example_test_1
 	    KTAP version 2
 	    1..2
-	    ok 1 test_1 # SKIP test_1 skipped
+	    skip 1 test_1 # test_1 skipped
 	    ok 2 test_2
 	  ok 2 example_test_2
 	    KTAP version 2

base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
-- 
2.40.0.rc1.284.g88254d51c5-goog

