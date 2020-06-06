Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22ED1F0495
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jun 2020 06:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgFFEEE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Jun 2020 00:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFFEED (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Jun 2020 00:04:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E7C08C5C3
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Jun 2020 21:04:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u6so14313463ybo.18
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 21:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LRVbJ2IzntUJ3rFAogfVmsjnLs4DtIrCaWey4mp2L10=;
        b=SeSUTQIoS5KBxUNns3vhXOLxzCuHPitMl0Aw8ZqFbQxtsIZgPssjlMMQr6EhJg6or0
         5CYrWi61PMDIKkTSNqDGSDtpUo7fr71ykQhgZJya/77gBGAF4aEZM2/KBfXmIz8dBf5t
         0SbgOBzAN8G8jpjzEnC6lhPyCmTWXdfOOSbIsu9lBqeSlY5+Ipqvt8IQk/fhIJlpofGj
         h/3PpS0tHl4+QQpfkozW9Ud+wRnFLtmfl6xu5FYANVXHQP61TIKgKcvSsoqNtgVPi48O
         j4oXqSIPmjUmi7PboCDnYtDpxEBMx6tT/hoEVmFcFve9PZXby44sts3x9G8512DsVZcp
         6oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LRVbJ2IzntUJ3rFAogfVmsjnLs4DtIrCaWey4mp2L10=;
        b=HO4n8OY6KP7StM4GlRnfm03H0Xm8OjTRxsfuGcYBy1aonORoKNll/zSrAd7JSSR6Iu
         hmmnp0n+vA31xEEvA5OfT/8GnSqWaUYXmWLbwVnwlXdZUnduKw9gXEzF3AEuTF9JPzBt
         pWLqNqdVIZeBNj6QmSsBh3uCiDpj+I8fYFYilq4kNHPQ3lh0FrAydWykrYZjRufosKZK
         M+7KscO/xXWhQq1pYRCSo3Xk8QexP1aQ86g1yk93jakOnjZ41EDi+Fl7a46gH2NMBiUg
         tw5/lF+eEPYXtcjo421CKkW/c1HwZqan/bGqvmO79dhQCTCK1oGQikPe9v9U0qVzl90n
         WFbQ==
X-Gm-Message-State: AOAM5313to3obeUrbz9R3mYf4c2jjl98I7lWSTWqBYfeEdSJBfLAnWZ7
        /w+kulqk1E4efAQnDIz//i9IUGtj6nzHAg==
X-Google-Smtp-Source: ABdhPJzMRf6MxnJE7ZzaLIOPvUIqU9bM0F72J+tmpYHrGd1C9wffpnYL+0o+BdYK1pKGlwnPK9f4EyEHq0ocGQ==
X-Received: by 2002:a25:b5c2:: with SMTP id d2mr22710530ybg.9.1591416242137;
 Fri, 05 Jun 2020 21:04:02 -0700 (PDT)
Date:   Fri,  5 Jun 2020 21:03:48 -0700
In-Reply-To: <20200606040349.246780-1-davidgow@google.com>
Message-Id: <20200606040349.246780-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v8 4/5] KASAN: Testing Documentation
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

Include documentation on how to test KASAN using CONFIG_TEST_KASAN_KUNIT
and CONFIG_TEST_KASAN_MODULE.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

---
 Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..b4b109d88f9e 100644
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
+With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN_KUNIT`` built-in, we can also
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
2.27.0.278.ge193c7cf3a9-goog

