Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8F1AE995
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 05:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDRDS6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 23:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgDRDS5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 23:18:57 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18CC061A0C
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Apr 2020 20:18:56 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i21so528126pgl.19
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Apr 2020 20:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fsQ6zkM7uoUMiPnsVxSRYiwCGVhnWM0mTHH2Nkqj5zo=;
        b=JS/kAYv0bCGD7ghxIICrHhV6O1k6xFCnZ7GMKqlZpjiBgcoJUj3wsm7iUi2Dz7IquY
         hPINCzmhGabkrLB2vUjaGYrSXuOcF5dB0tbFYfzcuw/cFqJmy4Gn8Gs3/+8en/p9cU48
         t4KeDZnK5hx1xWTBtfSfhA+psL+j2PeR1AOUewseCP8baiMhVJBlOPiyKQEa647DtvUf
         BXN46tlEBbV21NLpCt3uVOKX5CMHklh9ZoBvRSApLAyKNcCF8LVRPCGBNsNJpOFn2IEa
         zhWbfUDRaWlAN+zQHMzbokY/Z63QwQ7HBa/TxnB687aWivYgtuwLxORG8rleo8WgA0/m
         0VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fsQ6zkM7uoUMiPnsVxSRYiwCGVhnWM0mTHH2Nkqj5zo=;
        b=mxm2mR+YjqNC/McIrJWobVO0HXbswD2wNs3S5hZ7RrPFQxVPrK1cVFzH72aMpmh/eg
         ztDpoj/RQecUebpkcUTt49dpp2fsjyoP4ppEw0Y6OvaPUZQZwoxOclZ/tW4pTH+r9ZTu
         FewISEawApdMkYUV1/aK6C/Zhwz4TzoWmWITOeZCivdgBuW9dR95hQkjtwaPgHtjIL3f
         ZmjV/ZIfIRKIjbToK6XsWZQsH8lX0Q4AdBnoA1aOUqWkVbtA26pSZlXqquSzhIBhxwlZ
         11LTH0CcyMFohEVYyBSTD1gMYxhO9EFd7cXXa0bj/Udyrym59cL0FUuqUJ4WIDJiYmkA
         vBKA==
X-Gm-Message-State: AGi0PuaP+C98cUN98fXMGg5IkYEjKDxktAOPyb0R+C0BcKEwZuh9Evsf
        mcGHLiM9ZNrbf/2F8gofJw79U/DvbWjMJA==
X-Google-Smtp-Source: APiQypJToXA6KorNY8OJq7EE7Oef49xa3b4K1js/y01Pd5WOz27y7u0RrUrRW2a7LEWiRejVuyuGJCRi5RTAfw==
X-Received: by 2002:a17:90a:7486:: with SMTP id p6mr7991333pjk.62.1587179936368;
 Fri, 17 Apr 2020 20:18:56 -0700 (PDT)
Date:   Fri, 17 Apr 2020 20:18:32 -0700
In-Reply-To: <20200418031833.234942-1-davidgow@google.com>
Message-Id: <20200418031833.234942-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v6 4/5] KASAN: Testing Documentation
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

Include documentation on how to test KASAN using CONFIG_TEST_KASAN and
CONFIG_TEST_KASAN_USER.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..74fa6aa0f0df 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
 
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
+
+CONFIG_TEST_KASAN_KUNIT & CONFIG_TEST_KASAN_MODULE
+--------------------------------------------------
+
+``CONFIG_TEST_KASAN_KUNIT`` utilizes the KUnit Test Framework for testing.
+This means each test focuses on a small unit of functionality and
+there are a few ways these tests can be run.
+
+Each test will print the KASAN report if an error is detected and then
+print the number of the test and the status of the test:
+
+pass::
+
+        ok 28 - kmalloc_double_kzfree
+or, if kmalloc failed::
+
+        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
+        Expected ptr is not null, but is
+        not ok 4 - kmalloc_large_oob_right
+or, if a KASAN report was expected, but not found::
+
+        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
+        Expected kasan_data->report_expected == kasan_data->report_found, but
+        kasan_data->report_expected == 1
+        kasan_data->report_found == 0
+        not ok 28 - kmalloc_double_kzfree
+
+All test statuses are tracked as they run and an overall status will
+be printed at the end::
+
+        ok 1 - kasan_kunit_test
+
+or::
+
+        not ok 1 - kasan_kunit_test
+
+(1) Loadable Module
+~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` enabled, ``CONFIG_TEST_KASAN_KUNIT`` can be built as
+a loadable module and run on any architecture that supports KASAN
+using something like insmod or modprobe.
+
+(2) Built-In
+~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN_KUNIT`` can be built-in
+on any architecure that supports KASAN. These and any other KUnit
+tests enabled will run and print the results at boot as a late-init
+call.
+
+(3) Using kunit_tool
+~~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN`` built-in, we can also
+use kunit_tool to see the results of these along with other KUnit
+tests in a more readable way. This will not print the KASAN reports
+of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
+information on kunit_tool.
+
+.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
+
+``CONFIG_TEST_KASAN_MODULE`` is a set of KASAN tests that could not be
+converted to KUnit. These tests can be run only as a module with
+``CONFIG_TEST_KASAN_MODULE`` built as a loadable module and
+``CONFIG_KASAN`` built-in. The type of error expected and the
+function being run is printed before the expression expected to give
+an error. Then the error is printed, if found, and that test
+should be interpretted to pass only if the error was the one expected
+by the test.
-- 
2.26.1.301.g55bc3eb7cb9-goog

