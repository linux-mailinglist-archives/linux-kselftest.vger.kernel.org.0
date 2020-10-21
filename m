Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221A8294C63
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 14:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442295AbgJUMRo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 08:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411507AbgJUMRb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 08:17:31 -0400
Received: from mail.kernel.org (ip5f5ad5a8.dynamic.kabel-deutschland.de [95.90.213.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF48522251;
        Wed, 21 Oct 2020 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603282650;
        bh=dmJkmJBcCTH8GQ8WjHvHEWXJM/ASTtmhRipKi5gCybE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAHQKVtVvpBxSSPuCJWb2kzJD5mZIGGBvzCpGt5Pxmrwo/CAn5XYUb3HEtNdgHxDj
         NvoVSSSDrJ756Rn8g0bzP0gFk0O/0vp2QVO9QAR70TSF0EdIy9KM1uxoIN+pvRNpyE
         StBqKWkw6x49EQ32ppzb86n+KhIFEfWsE3DTXR3U=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kVD3Y-001U2h-GC; Wed, 21 Oct 2020 14:17:28 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/6] kunit: test: fix remaining kernel-doc warnings
Date:   Wed, 21 Oct 2020 14:17:26 +0200
Message-Id: <1c36d295423c5c20c21a7edede0eb29e338dd62a.1603282193.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603282193.git.mchehab+huawei@kernel.org>
References: <cover.1603282193.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

test.h still produce three warnings:

	include/kunit/test.h:282: warning: Function parameter or member '__suites' not described in 'kunit_test_suites_for_module'
	include/kunit/test.h:282: warning: Excess function parameter 'suites_list' description in 'kunit_test_suites_for_module'
	include/kunit/test.h:314: warning: Excess function parameter 'suites' description in 'kunit_test_suites'

They're all due to errors at kernel-doc markups. Update them.

It should be noticed that this patch moved a kernel-doc
markup that were located at the wrong place, and using a wrong
name. Kernel-doc only supports kaving the markup just before the
function/macro declaration. Placing it elsewhere will make it do
wrong assumptions.

Fixes: aac35468ca20 ("kunit: test: create a single centralized executor for all tests")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/kunit/test.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index a423fffefea0..14224baca3be 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -252,13 +252,14 @@ static inline int kunit_run_all_tests(void)
 }
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
 
+#ifdef MODULE
 /**
- * kunit_test_suites() - used to register one or more &struct kunit_suite
- *			 with KUnit.
+ * kunit_test_suites_for_module() - used to register one or more
+ * 			 &struct kunit_suite with KUnit.
  *
- * @suites_list...: a statically allocated list of &struct kunit_suite.
+ * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suites_list with the test framework. See &struct kunit_suite for
+ * Registers @__suites with the test framework. See &struct kunit_suite for
  * more information.
  *
  * If a test suite is built-in, module_init() gets translated into
@@ -267,7 +268,6 @@ static inline int kunit_run_all_tests(void)
  * module_{init|exit} functions for the builtin case when registering
  * suites via kunit_test_suites() below.
  */
-#ifdef MODULE
 #define kunit_test_suites_for_module(__suites)				\
 	static int __init kunit_test_suites_init(void)			\
 	{								\
@@ -294,7 +294,7 @@ static inline int kunit_run_all_tests(void)
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites: a statically allocated list of &struct kunit_suite.
+ * @__suites: a statically allocated list of &struct kunit_suite.
  *
  * Registers @suites with the test framework. See &struct kunit_suite for
  * more information.
@@ -308,10 +308,10 @@ static inline int kunit_run_all_tests(void)
  * module.
  *
  */
-#define kunit_test_suites(...)						\
+#define kunit_test_suites(__suites...)						\
 	__kunit_test_suites(__UNIQUE_ID(array),				\
 			    __UNIQUE_ID(suites),			\
-			    __VA_ARGS__)
+			    ##__suites)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
-- 
2.26.2

