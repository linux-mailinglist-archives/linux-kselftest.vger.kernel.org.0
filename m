Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED0C19CBDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 22:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbgDBUqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 16:46:50 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35640 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgDBUqu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 16:46:50 -0400
Received: by mail-pl1-f201.google.com with SMTP id a8so3614278plm.2
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Apr 2020 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u9tYGbzZUoeKacfHKj+okUgzHoM8x17MGKsRKBVzF6I=;
        b=uQMfb0xxAIExjb63NAfWbxNzX58IUh4kx7YoqwNgrBWsfj/lhHMrIdkYIx2al0nsxy
         UfqRTHYpcFcUV6WBrfwFPIEe+gJwjPlDCB3FPhqVw72U09ICHXpJxPv5jaaTW1L2PpKI
         X0G1XL7JYM+UcxPWcjBFn/2eVGMHfwjdjTCjip/S1RIaycD23/Gax6iURzYDzAgLWPzk
         saCWrOIIbKhsXSlG1gus8JbBGskce9oOFzvRPtS6bVs7vSd+LVY9Mszb5Y7jVfkRpMGj
         b0H1AyBceSSYEILo57evwEUZ011Z/GKyREZAbPrWgrldD31hVWpN560HYE1wCITA6FvP
         wv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u9tYGbzZUoeKacfHKj+okUgzHoM8x17MGKsRKBVzF6I=;
        b=eq7zIiP9E7powHK8LDljtc44DZwn8pRr5/l0PyuOONNn89ZDliwsuBLwSQ4aGU/vvk
         xoxl1mhsEZBaj+NSgwVGztjzUDu0K9Vam7UT8FJOEu2vmOsmHsbhc/S1C0YZMXRhcUbQ
         aoMCz7XWCIrjtoTX56ZfAHHQTmfV6/JmvI7OrURhEGjcs7CMn/75bj/iXDIrhj/FtuLt
         tR6IZ5G+8ngw+qO2/VoxD5CS0luPJDG0HI1ra0qf731rzdhuLQNcsWHAK0e0tSD/RBit
         sgGDpv0+vB5P6wPOe/HdXQLOo7/pVOEkMUijRr8BhG133zN7ju7iDrHULSeHhcEnAMq4
         9XEw==
X-Gm-Message-State: AGi0PuaVLsOLEDS5/27YOtfr0dhRLBY+uSdxPSSiMhh+zkjxtcupX8mQ
        kYOoODHhVf6AzHyNvGpFHbkchOHDoeP6uJEuP5Q=
X-Google-Smtp-Source: APiQypLt8J4TrsEIIQmwcI8PNHLIDMU2NUDRIAyuTZFgrBUPPoV3kJF3jVa/J06xQbLRVn+3EFvxF8aGXrT1NlncZ0Y=
X-Received: by 2002:a17:90a:2663:: with SMTP id l90mr5314572pje.188.1585860408019;
 Thu, 02 Apr 2020 13:46:48 -0700 (PDT)
Date:   Thu,  2 Apr 2020 13:46:37 -0700
In-Reply-To: <20200402204639.161637-1-trishalfonso@google.com>
Message-Id: <20200402204639.161637-3-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v4 4/4] KASAN: Testing Documentation
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Include documentation on how to test KASAN using CONFIG_TEST_KASAN and
CONFIG_TEST_KASAN_USER.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
 Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..287ba063d9f6 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
 
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
+
+CONFIG_TEST_KASAN & CONFIG_TEST_KASAN_USER
+-------------------------------------------
+
+``CONFIG_TEST_KASAN`` utilizes the KUnit Test Framework for testing.
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
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built as
+a loadable module and run on any architecture that supports KASAN
+using something like insmod or modprobe.
+
+(2) Built-In
+~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built-in
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
+``CONFIG_TEST_KASAN_USER`` is a set of KASAN tests that could not be
+converted to KUnit. These tests can be run only as a module with
+``CONFIG_TEST_KASAN_USER`` built as a loadable module and
+``CONFIG_KASAN`` built-in. The type of error expected and the
+function being run is printed before the expression expected to give
+an error. Then the error is printed, if found, and that test
+should be interpretted to pass only if the error was the one expected
+by the test.
-- 
2.26.0.292.g33ef6b2f38-goog

