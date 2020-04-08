Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBE1A2AA8
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 22:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgDHUuq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 16:50:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40237 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgDHUuq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 16:50:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so1260578wmf.5
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Apr 2020 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlyJ37tcJkkTLgH/A9kkfeRTL81jeV+ZDmmAhSUu6ZQ=;
        b=hjJXcXYVdPoVoJ6au8ruHGm/xdHbmmbg+ERnkpyV/X3irt9mnXw6ZMRCSKX2O5V/R9
         zDprwrGFX3XcXf0Q8TUxH8xRE5Pzu6JzxmE7/v53Y/vrCpLzfLbVM/YGDX7k+rZh9kft
         CphY1PbYfPvpIYSeWgs5jHYYSEm9XnM4bTK0eab8CB5XaOiNLlT6JrvGt1+o0QvfGQ6R
         8gZybNbs4tUb4qf/8rrpEOtMrETzasspXJUZWN5Oh0baNPuOAdEdZkrr5ae89Vl7kfnC
         emLanecbLNQNoFdedmlMd1Gh/dBkLrmNxXsIZ1qt6KBiSSlgggWC6OguV5A+KtX0pcZM
         ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlyJ37tcJkkTLgH/A9kkfeRTL81jeV+ZDmmAhSUu6ZQ=;
        b=FsKfhOiiMQ05nv+G8AQdSrtKLw2D6uqaTFRNPZlwtYs6QxyqkTUW1Zv6JW3BhKEVb4
         R5SPtprY0OKRw0nmlEy63KXv+Ij7YRt1psxr5fC2G9rue/6vHZqyqW90aIOYAFk2/Zyd
         lnAQYvheDPJYgafDd+k6rqVtgC439WztISrZKYm+csDXX0zmDdRbuJkfenPzKX/inxbz
         NQVUyjaFHy+nQPgoBcuDlrKSTh/oCe0ZhIogkrGbkINQtL1+i9LKnaWn7wuib2MJBxSi
         0JDJFNcZCbl3p4aOCkkYBI/w+XUj/U8hJBIbiR+Q4nI74kbLMGX9Lo9hFSth25A2dNd4
         T34g==
X-Gm-Message-State: AGi0PuaGQTiLkwSnRrA0cGinanEYm7xqO0iv2Ay676knnU00Z1xXjQaE
        YToAdqS4EMK8CKsV91F8R+w=
X-Google-Smtp-Source: APiQypIdk+Uz0ZzBfQWEV9QovxaWM2y/x/tDCPJDz6Y2LS6gv+98Fwm2XwhfIL5fNwjg6yK/HWLkKQ==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr9952987wrw.385.1586379043771;
        Wed, 08 Apr 2020 13:50:43 -0700 (PDT)
Received: from de0709bef958.v.cablecom.net ([45.87.212.59])
        by smtp.gmail.com with ESMTPSA id p10sm36580738wrm.6.2020.04.08.13.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:50:43 -0700 (PDT)
From:   Lothar Rubusch <l.rubusch@gmail.com>
To:     brendanhiggins@google.com, corbet@lwn.net
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v2] Documentation: test.h - fix warnings
Date:   Wed,  8 Apr 2020 20:50:24 +0000
Message-Id: <20200408205024.22119-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix warnings at 'make htmldocs', and formatting issues in the resulting
documentation.

- test.h: Fix some typos in kernel-doc parameter description.

- Documentation/*.rst: Fixing formatting issues, and a duplicate label
  issue, since using sphinx.ext.autosectionlabel in conf.py, referes to
  headers are generated automatically and sphinx will not complain about
  identical headers among documents anymore.

  The downside is, automatically generated header labels within one
  document now cannot be overwritten manually anymore. Thus duplicate
  headers within one document have to have different wording, i.e. this
  patch modifies some headers.

- Documentation/api/*: Flipping over to a page "API" containing a single
  link to another page "API" seems like a formatting issue. The patch
  removes one level of indirection.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/dev-tools/kunit/api/index.rst | 16 ----------------
 Documentation/dev-tools/kunit/index.rst     |  4 ++--
 Documentation/dev-tools/kunit/start.rst     | 13 ++++++++-----
 Documentation/dev-tools/kunit/usage.rst     |  4 ++--
 include/kunit/test.h                        |  5 +++--
 5 files changed, 15 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/dev-tools/kunit/api/index.rst

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
deleted file mode 100644
index 9b9bffe5d41a..000000000000
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ /dev/null
@@ -1,16 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=============
-API Reference
-=============
-.. toctree::
-
-	test
-
-This section documents the KUnit kernel testing API. It is divided into the
-following sections:
-
-================================= ==============================================
-:doc:`test`                       documents all of the standard testing API
-                                  excluding mocking or mocking related features.
-================================= ==============================================
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index e93606ecfb01..640bba1f4896 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -10,7 +10,7 @@ KUnit - Unit Testing for the Linux Kernel
 	start
 	usage
 	kunit-tool
-	api/index
+	api/test
 	faq
 
 What is KUnit?
@@ -88,6 +88,6 @@ How do I use it?
 
 *   :doc:`start` - for new users of KUnit
 *   :doc:`usage` - for a more detailed explanation of KUnit features
-*   :doc:`api/index` - for the list of KUnit APIs used for testing
+*   :doc:`api/test` - for the list of KUnit APIs used for testing
 *   :doc:`kunit-tool` - for more information on the kunit_tool helper script
 *   :doc:`faq` - for answers to some common questions about KUnit
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
index 9b0c46a6ca1f..16d548b795b5 100644
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
@@ -232,7 +232,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites: a statically allocated list of &struct kunit_suite.
+ * @...: a statically allocated list of &struct kunit_suite, assigned
+ *           to the pointer @suites.
  *
  * Registers @suites with the test framework. See &struct kunit_suite for
  * more information.
-- 
2.20.1

