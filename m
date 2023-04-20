Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DA6E9D81
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjDTU5u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjDTU5s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 16:57:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6347423C
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 13:57:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8bf9f09340so1371384276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682024265; x=1684616265;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5yzTg1HjZXhyiiyjfkjQABzGLu2Q1ap1FIlFZzPamAM=;
        b=CBi4oyy3PbOkEIks6OuRCzZBUXoTmT1Azzv/BL5OSDeard16zpdwuFwJlGAzZec/8h
         urN1PYynIvVibXD5+uQTxPJZ0cHysiFJa4tRbnEz0v8IfgMv5+0XJV+boTC4GkmIwGcC
         Ni/qexVXdD3RGT3PUthBE2VL1J4jTWfz+gg0nHT5u6hKz/W4PBqDIVhbcDqQHSMI4YsC
         RbczTQAMKtIdf5OBPXhrTP1oKGPq8t84NaI1mHdTi3Wz5Sxo9nCiFFi0vnfPkXHaBbMv
         c0gZvLkSkOMzvqSdvbNFL93bnyzHiQNR0SP1hunSJYMKsYebdnbKlOnh7GHLvHm7fOhY
         f4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682024265; x=1684616265;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yzTg1HjZXhyiiyjfkjQABzGLu2Q1ap1FIlFZzPamAM=;
        b=jzk1Z/5KontRtFyfEDoq8ZzFdujUTu/F8NaeHluu9Dxy9PWteeONgPtwWkCufyqMvL
         ZriVe7l4ZaMD1YHhhrhVWALnaCPkz6Hy5NJhWY00FtzhV06qIYiprU2YpexrU5h3QAv9
         Aw5UgMFbyrGkxn9hP6FSAgW2L7zmMKrOIts/XzlDuHGXt2AZfRujyhBerLQDhigk7G7e
         Iw/nT7uDMiE85Y6227U3BWnT8k0weLjmTLP3RLU+jKieiMzzZvgEWYn4pJrHTSG5Olzg
         Bbdfd7U/q/uKjK9576L8fRE2QjX+S3nnYEMmiRUK/v4lSyleQD2Fyc03m0wuff0NI5wf
         i8JQ==
X-Gm-Message-State: AAQBX9dPhtTUrxwHI+gleZPo7c9oTiQBsfhzoYsxPgapvvVsFudGdBES
        zdvex4fPYL9tZAz7TdR8hD9kfpAMmg==
X-Google-Smtp-Source: AKy350biCQsQsBH/ynN5GE4QuylXbnxvdaHRCye7LUQ+dAisidmDp5bnNQq+MYru8DJv003y3BvdLq6ovg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:cc0c:0:b0:b8b:f584:6b73 with SMTP id
 l12-20020a25cc0c000000b00b8bf5846b73mr162050ybf.10.1682024265828; Thu, 20 Apr
 2023 13:57:45 -0700 (PDT)
Date:   Thu, 20 Apr 2023 20:57:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420205734.1288498-1-rmoar@google.com>
Subject: [KTAP V2 PATCH] ktap_v2: add test metadata
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add specification for declaring test metadata to the KTAP v2 spec.

The purpose of test metadata is to allow for the declaration of essential
testing information in KTAP output. This information includes test
names, test configuration info, test attributes, and test files.

There have been similar ideas around the idea of test metadata such as test
prefixes and test name lines. However, I propose this specification as an
overall fix for these issues.

These test metadata lines are a form of diagnostic lines with the
format: "# <metadata_type>: <data>". As a type of diagnostic line, test
metadata lines are compliant with KTAP v1, which will help to not
interfere too much with current parsers.

Specifically the "# Subtest:" line is derived from the TAP 14 spec:
https://testanything.org/tap-version-14-specification.html.

The proposed location for test metadata is in the test header, between the
version line and the test plan line. Note including diagnostic lines in
the test header is a depature from KTAP v1.

This location provides two main benefits:

First, metadata will be printed prior to when subtests are run. Then if a
test fails, test metadata can help discern which test is causing the issue
and potentially why.

Second, this location ensures that the lines will not be accidentally
parsed as a subtest's diagnostic lines because the lines are bordered by
the version line and plan line.

Here is an example of test metadata:

 KTAP version 2
 # Config: CONFIG_TEST=y
 1..1
     KTAP version 2
     # Subtest: test_suite
     # File: /sys/kernel/...
     # Attributes: slow
     # Other: example_test
     1..2
     ok 1 test_1
     ok 2 test_2
 ok 1 test_suite

Here is a link to a version of the KUnit parser that is able to parse test
metadata lines for KTAP version 2. Note this includes test metadata
lines for the main level of KTAP.

Link: https://kunit-review.googlesource.com/c/linux/+/5809

Signed-off-by: Rae Moar <rmoar@google.com>
---

Hi everyone,

I would like to use this proposal similar to an RFC to gather ideas on the
topic of test metadata. Let me know what you think.

I am also interested in brainstorming a list of recognized metadata types.
Providing recognized metadata types would be helpful in parsing and
displaying test metadata in a useful way.

Current ideas:
- "# Subtest: <test_name>" to indicate test name (name must match
  corresponding result line)
- "# Attributes: <attributes list>" to indicate test attributes (list
  separated by commas)
- "# File: <file_path>" to indicate file used in testing

Any other ideas?

Note this proposal replaces two of my previous proposals: "ktap_v2: add
recognized test name line" and "ktap_v2: allow prefix to KTAP lines."

Thanks!
-Rae

Note: this patch is based on Frank's ktap_spec_version_2 branch.

 Documentation/dev-tools/ktap.rst | 51 ++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index ff77f4aaa6ef..a2d0a196c115 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -17,7 +17,9 @@ KTAP test results describe a series of tests (which may be nested: i.e., test
 can have subtests), each of which can contain both diagnostic data -- e.g., log
 lines -- and a final result. The test structure and results are
 machine-readable, whereas the diagnostic data is unstructured and is there to
-aid human debugging.
+aid human debugging. One exception to this is test metadata lines - a type
+of diagnostic lines. Test metadata is located between the version line and
+plan line of a test and can be machine-readable.
 
 KTAP output is built from four different types of lines:
 - Version lines
@@ -28,8 +30,7 @@ KTAP output is built from four different types of lines:
 In general, valid KTAP output should also form valid TAP output, but some
 information, in particular nested test results, may be lost. Also note that
 there is a stagnant draft specification for TAP14, KTAP diverges from this in
-a couple of places (notably the "Subtest" header), which are described where
-relevant later in this document.
+a couple of places, which are described where relevant later in this document.
 
 Version lines
 -------------
@@ -166,6 +167,45 @@ even if they do not start with a "#": this is to capture any other useful
 kernel output which may help debug the test. It is nevertheless recommended
 that tests always prefix any diagnostic output they have with a "#" character.
 
+Test metadata lines
+-------------------
+
+Test metadata lines are a type of diagnostic lines used to the declare the
+name of a test and other helpful testing information in the test header.
+These lines are often helpful for parsing and for providing context during
+crashes.
+
+Test metadata lines must follow the format: "# <metadata_type>: <data>".
+These lines must be located between the version line and the plan line
+within a test header.
+
+There are a few currently recognized metadata types:
+- "# Subtest: <test_name>" to indicate test name (name must match
+  corresponding result line)
+- "# Attributes: <attributes list>" to indicate test attributes (list
+  separated by commas)
+- "# File: <file_path>" to indicate file used in testing
+
+As a rule, the "# Subtest:" line is generally first to declare the test
+name. Note that metadata lines do not necessarily need to use a
+recognized metadata type.
+
+An example of using metadata lines:
+
+::
+
+        KTAP version 2
+        1..1
+        # File: /sys/kernel/...
+          KTAP version 2
+          # Subtest: example
+          # Attributes: slow, example_test
+          1..1
+          ok 1 test_1
+        # example passed
+        ok 1 example
+
+
 Unknown lines
 -------------
 
@@ -206,6 +246,7 @@ An example of a test with two nested subtests:
 	KTAP version 2
 	1..1
 	  KTAP version 2
+	  # Subtest: example
 	  1..2
 	  ok 1 test_1
 	  not ok 2 test_2
@@ -219,6 +260,7 @@ An example format with multiple levels of nested testing:
 	KTAP version 2
 	1..2
 	  KTAP version 2
+	  # Subtest: example_test_1
 	  1..2
 	    KTAP version 2
 	    1..2
@@ -254,6 +296,7 @@ Example KTAP output
 	KTAP version 2
 	1..1
 	  KTAP version 2
+	  # Subtest: main_test
 	  1..3
 	    KTAP version 2
 	    1..1
@@ -261,11 +304,13 @@ Example KTAP output
 	    ok 1 test_1
 	  ok 1 example_test_1
 	    KTAP version 2
+            # Attributes: slow
 	    1..2
 	    ok 1 test_1 # SKIP test_1 skipped
 	    ok 2 test_2
 	  ok 2 example_test_2
 	    KTAP version 2
+	    # Subtest: example_test_3
 	    1..3
 	    ok 1 test_1
 	    # test_2: FAIL

base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
-- 
2.40.0.396.gfff15efe05-goog

