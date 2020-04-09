Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D9E1A3BE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgDIV16 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Apr 2020 17:27:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40446 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgDIV16 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Apr 2020 17:27:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id s8so13722188wrt.7
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Apr 2020 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7oerwfYi5D6aB3fBRGjdjpq86Nisdn+2mRbfBbXTfU=;
        b=iHX5YPglxpGUsEsUacaDoxCH4nwhX49d/1kOEOn2UhKzUEgYxSAfiPeUKEh3gI7xCm
         0hh+Tw3Rq8UyVpuSSg2MH1r5a4JPkd92GB/K08QVUs7hGbjp4t0lSAqi4ofqvPbMrrY/
         tF1lskRdCqvYmM2n1pu3oppwtySJzbeDeGKReCuAwtRsHXQ6LP76v8pQ/gpp5jGCu0oF
         tGxIs9Z5C6KbWISLPGd2oCwc11rkiRLP3AhyqJBa29ds3Y/B8aWJmChB9QwMtrqZtMYV
         mYAG28aEFPelwh8SD98KzhwpQFm7eOhZZsJ9CQZ524QE+GKVNKD3tbFKH+oduqi2yhip
         KgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7oerwfYi5D6aB3fBRGjdjpq86Nisdn+2mRbfBbXTfU=;
        b=sfrHn82/4DuCToEKzWqlNiKQyVYzxAh2MVp3RQb48E3Izc6XXYar+ftWgS1Nm0yZez
         tnC39fdGRf5SQsuYBF6xcVXNAGP7CDKt5Ms3moodkqGpCSYvD/BdCHT5qs99hHxrxC6q
         q6i3eQ9NVlsZ33Pja/cQlaUkJNcNBVvzsd0LNfJcgse8v2kJ4OyeV3dLiaalAcWFgQx6
         UosuxKXUqcGy+BIgCb7sAfA1JtnEIFmx7uI6QX1IzAqwVPtjEmQXDsf5m3Dqv9PMESCb
         Wt/KKtPU5q1DmMFeKBnF3O7hSz/w+x/y95mcmHXSlQzFEy7QPMQADBACbXdf691UEPrq
         j3nA==
X-Gm-Message-State: AGi0PuZvxSw+PB0uvql2DMQXhjgNWjzpkPctK7i+5dEfHtcMLiWOHm1u
        1R2OxNeutyRRSkUEUDJia7I=
X-Google-Smtp-Source: APiQypLx6tpBwq1ESB5a/v9Jfy67kJSS8eDEfS8yyo1v7N3QPavr4CycWzemkRx3nWFUg0DmIfNoGg==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr1177148wrc.42.1586467677193;
        Thu, 09 Apr 2020 14:27:57 -0700 (PDT)
Received: from 0339e8fc5325.v.cablecom.net ([45.87.212.59])
        by smtp.gmail.com with ESMTPSA id i25sm2122480wml.43.2020.04.09.14.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:27:56 -0700 (PDT)
From:   Lothar Rubusch <l.rubusch@gmail.com>
To:     brendanhiggins@google.com, corbet@lwn.net
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v3] Documentation: test.h - fix warnings
Date:   Thu,  9 Apr 2020 21:27:37 +0000
Message-Id: <20200409212737.1943-1-l.rubusch@gmail.com>
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

v2: Several documentation fixes

v3: Do not touch API documentation index

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 13 ++++++++-----
 Documentation/dev-tools/kunit/usage.rst |  4 ++--
 include/kunit/test.h                    |  7 ++++---
 3 files changed, 14 insertions(+), 10 deletions(-)

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
index 9b0c46a6ca1f..b8a8434443b0 100644
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
@@ -232,12 +232,13 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites: a statically allocated list of &struct kunit_suite.
+ * @...: a statically allocated list of &struct kunit_suite, assigned
+ *           to the pointer @suites.
  *
  * Registers @suites with the test framework. See &struct kunit_suite for
  * more information.
  *
- * When builtin,  KUnit tests are all run as late_initcalls; this means
+ * When builtin, KUnit tests are all run as late_initcalls; this means
  * that they cannot test anything where tests must run at a different init
  * phase. One significant restriction resulting from this is that KUnit
  * cannot reliably test anything that is initialize in the late_init phase;
-- 
2.20.1

