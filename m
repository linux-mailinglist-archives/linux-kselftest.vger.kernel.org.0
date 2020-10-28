Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2352229D619
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 23:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgJ1WLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbgJ1WLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F99C0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TYXwyDweTdlROEn0LKotPPCUWy/YdCFJnxIV8tWbKOY=; b=fyot2M6wdT1GjHX/vIjWe7CRgG
        n+NLQZc8OREKTSLmSisX4TYSLXTFjZ2polVVRdNnyTWHXhbIwrdL1r2rRrWp30y0mApO5UKkRmqPq
        W3PsVn77EJXak6Wmh4jfgTg5bdGxmzwzD0Xn8Fj8GLkACz9Us6l2FY7xAd17BPF46GysGRLvyCfYi
        vOXt9zNX+yWy+AFbI6SepEUiro0ZOqUeQ+5bP+/B202KhmGVw+SsjWUc4sLu3DCQST1w6rHOCCN6n
        dtBWOJF8h9fu8/CKM6/4ow1W0j3imQ+GUC3EY+XL6U+yuNIRLUkFcfSGpB044Xp0IYKYBwobJXYNt
        DSOvT0Fg==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXpTn-0007Sv-E4; Wed, 28 Oct 2020 17:43:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH] KUnit: Docs: usage: wording fixes
Date:   Wed, 28 Oct 2020 10:43:19 -0700
Message-Id: <20201028174319.11817-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix minor grammar and punctutation glitches.
Hyphenate "architecture-specific" instances.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20201027.orig/Documentation/dev-tools/kunit/usage.rst
+++ linux-next-20201027/Documentation/dev-tools/kunit/usage.rst
@@ -92,7 +92,7 @@ behavior of a function called ``add``; t
 the second parameter, in this case, is what the value is expected to be; the
 last value is what the value actually is. If ``add`` passes all of these
 expectations, the test case, ``add_test_basic`` will pass; if any one of these
-expectations fail, the test case will fail.
+expectations fails, the test case will fail.
 
 It is important to understand that a test case *fails* when any expectation is
 violated; however, the test will continue running, potentially trying other
@@ -202,7 +202,7 @@ Example:
 	kunit_test_suite(example_test_suite);
 
 In the above example the test suite, ``example_test_suite``, would run the test
-cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``,
+cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``;
 each would have ``example_test_init`` called immediately before it and would
 have ``example_test_exit`` called immediately after it.
 ``kunit_test_suite(example_test_suite)`` registers the test suite with the
@@ -229,7 +229,7 @@ through some sort of indirection where a
 such that the definition of that function can be changed without affecting the
 rest of the code base. In the kernel this primarily comes from two constructs,
 classes, structs that contain function pointers that are provided by the
-implementer, and architecture specific functions which have definitions selected
+implementer, and architecture-specific functions which have definitions selected
 at compile time.
 
 Classes
@@ -459,7 +459,7 @@ KUnit on non-UML architectures
 By default KUnit uses UML as a way to provide dependencies for code under test.
 Under most circumstances KUnit's usage of UML should be treated as an
 implementation detail of how KUnit works under the hood. Nevertheless, there
-are instances where being able to run architecture specific code or test
+are instances where being able to run architecture-specific code or test
 against real hardware is desirable. For these reasons KUnit supports running on
 other architectures.
 
@@ -599,7 +599,7 @@ writing normal KUnit tests. One special
 hardware state in between test cases; if this is not possible, you may only be
 able to run one test case per invocation.
 
-.. TODO(brendanhiggins@google.com): Add an actual example of an architecture
+.. TODO(brendanhiggins@google.com): Add an actual example of an architecture-
    dependent KUnit test.
 
 KUnit debugfs representation
