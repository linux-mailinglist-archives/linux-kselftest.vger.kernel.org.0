Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBBD6BDC2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 23:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCPW7W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 18:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCPW7V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 18:59:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC50C19C6A
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:59:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p79-20020a25d852000000b00b32573a21a3so3347060ybg.18
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679007558;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qWalks976lIx9gM0rZXHprcJNgdQ23aAcuCS3sG+Yi4=;
        b=tDU9PX7ro8icNVMA9iC29WCiEBLRgkY0S5CrNun6+PTEQjClU+V/wUZBzQmNmt9QGN
         ZQ9+GGEvDNsPKndiypt2UPENk8mNhhdNmP2+9GEa0ZUW17xvaKykg31zO4XL4x1oaI0Q
         ixPa21LWXdKiTjny36mrwUEooyVC4aHmFHcaf4x0NjEFWR9Dh0vmLebfU8TUvXqeoFro
         eW/bznvVTNANsTwoFJGt48pZHVRk4wkC6kgvBIZFQv0qX98yqiSoyOxeQ5JgLJ6+NOAK
         cSLNSeerYOozMDwjYy1GXPqPmXr7vqUcsveEynMzK6lpUDyAeBm6UkoIFzfeGkyGXJ++
         hwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWalks976lIx9gM0rZXHprcJNgdQ23aAcuCS3sG+Yi4=;
        b=rGMjBp/RFWpdU/e+cKyRw20WiaxIApnZn/fxSztlPdJ05vu49Ss9QN+AFiuOxX/ZfR
         uMKUD5dlNzczC8riUNBbTj32VEL+JPOuwX6i95R5AHSr1F60xyReJoS2ibg6wCGKoOrT
         ofT1Z35wymyxHG4K7MN6XulkZNwRtbSTnM15OyS327AAeA234AlXfUPkcvLjnRpD+yHr
         kyAUPl79CWicGyFS4VYOCgACfJGR9yu8iSKKWXTlW2EYpCKy9ZHCiH4dJev3DYkORxOl
         R1wu0owZxd2rgv0l7JyrcXGe8f3SkDzK6IG+paerYLcTn4+45rz9RF05nV6KPVwhQKPe
         g7XA==
X-Gm-Message-State: AO0yUKViJIu+YOE3USFTC+RDWTgj8knuC1xxOEzTc3EW7eCfdSsDjtIS
        8hecxTXGZB++Xubtl1j3FicP6VEV7A==
X-Google-Smtp-Source: AK7set+PsgVedABxdiCxAyh7j6bk5z0QFl1X1enf7V6rXMj1w7qnkz2nRGM1IaA5IByx14VygSQhFDWWGQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:b284:0:b0:533:99bb:c296 with SMTP id
 q126-20020a81b284000000b0053399bbc296mr3151151ywh.5.1679007558179; Thu, 16
 Mar 2023 15:59:18 -0700 (PDT)
Date:   Thu, 16 Mar 2023 22:59:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316225915.494688-1-rmoar@google.com>
Subject: [KTAP V2 PATCH] ktap_v2: add recognized test name line
From:   Rae Moar <rmoar@google.com>
To:     frowand.list@gmail.com, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@lists.linux.dev,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>
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

Add recognition of the test name line ("# Subtest: <name>") to the KTAP v2
spec.

The purpose of this line is to declare the name of a test before its
results. This functionality is especially useful when trying to parse test
results incrementally and when interpretting results after a crash.

This line is already compliant with KTAP v1 as it is interpretted as a
diagnostic line by parsers. Additionally, the line is currently used by
KUnit tests and was derived from the TAP 14 spec:
https://testanything.org/tap-version-14-specification.html.

Recognition of this line would create an accepted way for different test
frameworks to declare the name of a test before its results.

The proposed location for this line is between the version line and the
test plan line. This location ensures that the line would not be
accidentally parsed as a subtest's diagnostic lines. Note this proposed
location would be a slight differentiation from KTAP v1.

Example of test name line:

 KTAP version 2
 # Subtest: main_test
 1..1
   KTAP version 2
   # Subtest: sub_test
   1..2
   ok 1 test_1
   ok 2 test_2
 ok 1 sub_test

Here is a link to a version of the KUnit parser that is able to parse the
test name line for KTAP version 2. Note this includes a test name line for
the main level of KTAP.

Link: https://kunit-review.googlesource.com/c/linux/+/5709

Signed-off-by: Rae Moar <rmoar@google.com>
---

This is a RFC. I would like to know what people think and use this as a
platform for discussion on KTAP v2.

Note: this patch is based on Frank's ktap_spec_version_2 branch.

 Documentation/dev-tools/ktap.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index ff77f4aaa6ef..9c7ed66d9f77 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -28,8 +28,7 @@ KTAP output is built from four different types of lines:
 In general, valid KTAP output should also form valid TAP output, but some
 information, in particular nested test results, may be lost. Also note that
 there is a stagnant draft specification for TAP14, KTAP diverges from this in
-a couple of places (notably the "Subtest" header), which are described where
-relevant later in this document.
+a couple of places, which are described where relevant later in this document.
 
 Version lines
 -------------
@@ -44,8 +43,8 @@ For example:
 - "TAP version 14"
 
 Note that, in KTAP, subtests also begin with a version line, which denotes the
-start of the nested test results. This differs from TAP14, which uses a
-separate "Subtest" line.
+start of the nested test results. This differs from TAP14, which uses only a
+"Subtest" line.
 
 While, going forward, "KTAP version 2" should be used by compliant tests, it
 is expected that most parsers and other tooling will accept the other versions
@@ -166,6 +165,12 @@ even if they do not start with a "#": this is to capture any other useful
 kernel output which may help debug the test. It is nevertheless recommended
 that tests always prefix any diagnostic output they have with a "#" character.
 
+One recognized diagnostic line is the "# Subtest: <name>" line. This line
+is used to declare the name of a test before subtest results are printed. This
+is helpful for parsing and for providing context during crashes. As a rule,
+this line is placed after the version line and before the plan line. Note
+this line can be used for the main test, as well as subtests.
+
 Unknown lines
 -------------
 
@@ -206,6 +211,7 @@ An example of a test with two nested subtests:
 	KTAP version 2
 	1..1
 	  KTAP version 2
+	  # Subtest: example
 	  1..2
 	  ok 1 test_1
 	  not ok 2 test_2
@@ -219,6 +225,7 @@ An example format with multiple levels of nested testing:
 	KTAP version 2
 	1..2
 	  KTAP version 2
+	  # Subtest: example_test_1
 	  1..2
 	    KTAP version 2
 	    1..2
@@ -245,7 +252,7 @@ allows an arbitrary number of tests to be nested     no         yes
 
 The TAP14 specification does permit nested tests, but instead of using another
 nested version line, uses a line of the form
-"Subtest: <name>" where <name> is the name of the parent test.
+"Subtest: <name>" where <name> is the name of the parent test as discussed above.
 
 Example KTAP output
 --------------------
@@ -254,6 +261,7 @@ Example KTAP output
 	KTAP version 2
 	1..1
 	  KTAP version 2
+	  # Subtest: main_test
 	  1..3
 	    KTAP version 2
 	    1..1
@@ -266,6 +274,7 @@ Example KTAP output
 	    ok 2 test_2
 	  ok 2 example_test_2
 	    KTAP version 2
+		# Subtest: example_test_3
 	    1..3
 	    ok 1 test_1
 	    # test_2: FAIL

base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
-- 
2.40.0.rc1.284.g88254d51c5-goog

