Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399801A8E68
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgDNWNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387583AbgDNWNO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 18:13:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B9FC061A0C
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 15:13:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so16441326wrs.9
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fuTlpZJ7QCGlTqlTiboY62m91l/83kjd7tQumwkWsQY=;
        b=Pl04Re6EEQh98Y8JzVxxUcy0V63lYZO0pV1BlpN/gnYDDW2ZIN9DyrQHHi5f6tAHK5
         eiPbSDT/8NS+UXFnXJn2De5W8MstifOtJOfS/DOfMktQSx5IeA7GZJdNLAaDctMQCWKw
         M3lbDzxymgEegOS7jGcr4oS+qbopY9UJxMXwfWTFBU2W8qHSPvjj7T9rq0P693bnk1zb
         YROnWC8dL6i908m6TYfNBz5o7o/FVDZSSshxBXyqk6eF635jd0MBjuwsFLEmAiL0gJEq
         UqLUYFYZ9z/kM7kJIE0/PbkW6sU8Mcb4IdypqoWUyKDihAjAYDAyZaJTb5vmzJorDOg4
         ZaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fuTlpZJ7QCGlTqlTiboY62m91l/83kjd7tQumwkWsQY=;
        b=dGHRO3BBEZqmDxr4ez4aUrryN3gbN3TLTnSv1nnDZqkBRsQJ5lSBs+yj9Y9xLDB93x
         HIzACV0E7v8O+MUR/E73vvUtsl5mgRfK2a+QwH+QV40aaJz2K5usrh+5LM8GswYd9loo
         zIGW4JsfqcjS10/MgVF3wwq3Dhhuu3kDXILiKz/aFPl8tHWgIwrTn4iog6aImk92xJ5z
         dKJalyWA4T43wg9fvlB05CSTRLk14bDhgS6BIgZCZAE+f12UpWIAUQVdz1GBWdSFDw2i
         i63896GMYuzLjbiN/ihIrNUan5fRanLddwkHL0wNdR3bAD9I5g5z+4q99evcDpHcIS2h
         IJxA==
X-Gm-Message-State: AGi0PuZK+d2kzqQKAFzBxFtJTON07TI6ztSxDj8+mvHzsqs6EFOagl7K
        4oBx4R0pr0cDr870KgSHSrM=
X-Google-Smtp-Source: APiQypI081ojJ3sjneG6+04ZKir4wRiJqB6ZoRqVfYPA5CwvPZv62c73gN0FMDqK0wJNolahreyYYw==
X-Received: by 2002:adf:e611:: with SMTP id p17mr25501880wrm.384.1586902390471;
        Tue, 14 Apr 2020 15:13:10 -0700 (PDT)
Received: from fbf78926346c.v.cablecom.net ([195.181.170.91])
        by smtp.gmail.com with ESMTPSA id a10sm20695939wrm.87.2020.04.14.15.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:13:09 -0700 (PDT)
From:   Lothar Rubusch <l.rubusch@gmail.com>
To:     brendanhiggins@google.com, corbet@lwn.net
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v4] Documentation: test.h - fix warnings
Date:   Tue, 14 Apr 2020 22:12:50 +0000
Message-Id: <20200414221250.18726-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix warnings at 'make htmldocs', and formatting issues in the resulting
documentation.

- test.h: Fix annotation in kernel-doc parameter description.

- Documentation/*.rst: Fixing formatting issues, and a duplicate label
  issue due to usage of sphinx.ext.autosectionlabel and identical labels
  within one document (sphinx warning)

NB: checkpatch.pl will complain about flow control statements (i.e. usage
    of "return") within the macro kunit_test_suites(suites_list...).

v2: Several documentation fixes

v3: Do not touch API documentation index

v4: Replace macro argument in test.h by named variadic argument

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 13 ++++++++-----
 Documentation/dev-tools/kunit/usage.rst |  4 ++--
 include/kunit/test.h                    | 12 ++++++------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index e1c5ce80ce12..bb112cf70624 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -32,15 +32,17 @@ test targets as well. The ``.kunitconfig`` should also contain any other config
 options required by the tests.
 
 A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
+
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
 	cp arch/um/configs/kunit_defconfig .kunitconfig
 
 You can then add any other Kconfig options you wish, e.g.:
+
 .. code-block:: none
 
-        CONFIG_LIST_KUNIT_TEST=y
+	CONFIG_LIST_KUNIT_TEST=y
 
 :doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
 ``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
@@ -54,8 +56,8 @@ using.
    other tools (such as make menuconfig) to adjust other config options.
 
 
-Running the tests
------------------
+Running the tests (KUnit Wrapper)
+---------------------------------
 
 To make sure that everything is set up correctly, simply invoke the Python
 wrapper from your kernel repo:
@@ -105,8 +107,9 @@ have config options ending in ``_KUNIT_TEST``.
 KUnit and KUnit tests can be compiled as modules: in this case the tests in a
 module will be run when the module is loaded.
 
-Running the tests
------------------
+
+Running the tests (w/o KUnit Wrapper)
+-------------------------------------
 
 Build and run your kernel as usual. Test output will be written to the kernel
 log in `TAP <https://testanything.org/>`_ format.
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 473a2361ec37..3c3fe8b5fecc 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -595,7 +595,7 @@ able to run one test case per invocation.
 KUnit debugfs representation
 ============================
 When kunit test suites are initialized, they create an associated directory
-in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
+in ``/sys/kernel/debug/kunit/<test-suite>``.  The directory contains one file
 
 - results: "cat results" displays results of each test case and the results
   of the entire suite for the last test run.
@@ -604,4 +604,4 @@ The debugfs representation is primarily of use when kunit test suites are
 run in a native environment, either as modules or builtin.  Having a way
 to display results like this is valuable as otherwise results can be
 intermixed with other events in dmesg output.  The maximum size of each
-results file is KUNIT_LOG_SIZE bytes (defined in include/kunit/test.h).
+results file is KUNIT_LOG_SIZE bytes (defined in ``include/kunit/test.h``).
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9b0c46a6ca1f..47e61e1d5337 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -175,7 +175,7 @@ struct kunit_suite {
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
 
-	/* private - internal use only */
+	/* private: internal use only */
 	struct dentry *debugfs;
 	char *log;
 };
@@ -232,12 +232,12 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites: a statically allocated list of &struct kunit_suite.
+ * @suites_list...: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suites with the test framework. See &struct kunit_suite for
+ * Registers @suites_list with the test framework. See &struct kunit_suite for
  * more information.
  *
- * When builtin,  KUnit tests are all run as late_initcalls; this means
+ * When builtin, KUnit tests are all run as late_initcalls; this means
  * that they cannot test anything where tests must run at a different init
  * phase. One significant restriction resulting from this is that KUnit
  * cannot reliably test anything that is initialize in the late_init phase;
@@ -253,8 +253,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * tests from the same place, and at the very least to do so after
  * everything else is definitely initialized.
  */
-#define kunit_test_suites(...)						\
-	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
+#define kunit_test_suites(suites_list...)				\
+	static struct kunit_suite *suites[] = {suites_list, NULL};	\
 	static int kunit_test_suites_init(void)				\
 	{								\
 		return __kunit_test_suites_init(suites);		\
-- 
2.20.1

