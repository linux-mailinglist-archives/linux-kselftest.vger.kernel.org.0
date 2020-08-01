Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0476E2350F2
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Aug 2020 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgHAHKM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Aug 2020 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgHAHKL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Aug 2020 03:10:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731DFC06174A
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Aug 2020 00:10:11 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i10so12209495pfq.14
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Aug 2020 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nr8mXyqoppq75z/FRAmv2PARhpMnaUiNjcYddLk+74Y=;
        b=V/FGzNDH1HyCN1W6kElyhtadQ6A+MtQC8xQRsXAojy1kJ+4SGGsGioxFgHdBC8BwIn
         bmwpTZu76qzDIqqA9GCSmuk8AIHj3qBoj22GHOEEOfiM30n4hgdRpGsrx/e2w9sSTs0B
         ndWDl0S5DFrJu3l3nmvl4KA/S+Q2160TQQnSFG8uQFGB/134aEhMaoJH9UHLpXJUQK+B
         Fi/eZRbNndwo0y63l/VQclN4SgXhWf8Y/p3XoMrHIh/0anPpLmVsY/TGiGmiudcmPlpT
         QOLhdtEqvT3Il5hRCo+nAOJrplqDzp1SotpDemeuesHPqU2qEmpb/iYFDHMyvGqUaQHf
         BvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nr8mXyqoppq75z/FRAmv2PARhpMnaUiNjcYddLk+74Y=;
        b=MJPavz/UpqRh5SL9LU6gkXqHP1/bSKkn85Rvsq29KSRMhiH5x1TpyTqF1R9gtgqJSA
         HW+mc++cEHDAYrdxiauITfAGYEDKA+/p/rVB/jwBlA/5GHaZ+16gLBZRCfkv/o54kuMe
         oj3D+c63ndHssla7k6tLe8XXzLzAVxPW6OO+q3+PWX5msF66QrW/9xD040OBFzowo4Je
         9d2vhe2JhiQSv9pUSHGfeUrEhPzjmkntEqtm5NGgsJsFqZV+/yu5EN/K5WvRz5MBb9UA
         EeMZB9xRmOVAAhZeGiLa5pBTtUcS0cJJ1usQil16FKrdPwiYISzrU+KBmJdheAEtRktU
         bzyQ==
X-Gm-Message-State: AOAM533X91+R6hSrJlJQQCFjADleMwFq5iYa3OuUTWcHzP7fQCLyzN8w
        Ayv2RFV55t8+Y18vVYv/PW7JU82ZPqjHNw==
X-Google-Smtp-Source: ABdhPJx1uAppsHiAehWmWHrRKCD0S5OQD+wqsPPKuddfn7VpxPRJVpzO7tIM6rSQ4fXbGOeWZIPITdAyuknL+g==
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr1131477pjz.1.1596265810438;
 Sat, 01 Aug 2020 00:10:10 -0700 (PDT)
Date:   Sat,  1 Aug 2020 00:09:23 -0700
In-Reply-To: <20200801070924.1786166-1-davidgow@google.com>
Message-Id: <20200801070924.1786166-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200801070924.1786166-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v10 4/5] KASAN: Testing Documentation
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
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 38fd5681fade..42991e40cbe1 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
 
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
+
+CONFIG_KASAN_KUNIT_TEST & CONFIG_TEST_KASAN_MODULE
+--------------------------------------------------
+
+``CONFIG_KASAN_KUNIT_TEST`` utilizes the KUnit Test Framework for testing.
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
+With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
+a loadable module and run on any architecture that supports KASAN
+using something like insmod or modprobe.
+
+(2) Built-In
+~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_KASAN_KUNIT_TEST`` can be built-in
+on any architecure that supports KASAN. These and any other KUnit
+tests enabled will run and print the results at boot as a late-init
+call.
+
+(3) Using kunit_tool
+~~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, we can also
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
2.28.0.163.g6104cc2f0b6-goog

