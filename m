Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48F24160C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 07:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgHKFjq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 01:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgHKFjp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 01:39:45 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0CEC06174A
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 22:39:45 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j8so8899622qvu.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=45vX/OukMjmRJbYoiR0tKiPizR257EeVnpqPnjVNEcE=;
        b=FV8uMO3aqhjqWbi2Tgu6Hf+4cQsDPp+CXiCl3C9oF+52ljsX5mX09Vas3qnKIU8GXK
         Za5pTaNn7UuRaTl83zJJLC3gdnWAcvDb7og/+aXXsugtYaswwIMKVMMU4v75yer9K7Hc
         U3UhMilmfY0yw4B9sm+1SL8QTpVXT+IuuWJFX2XEjGAmRz35A6wGp2CjZrnCxwN1BA/0
         acTIiPOu9EPlnGxJuFa7hvuKdHATL1QCcXC/t41vf5GsUw6ZPMP0bwHXftyoynnUO0Eq
         F1EnwJSRefMzr4xasqLztPF6XK21ka4oP3/bbSYVJpcEEAjpaCWnxEGYDaAP+JF3GIiT
         QL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=45vX/OukMjmRJbYoiR0tKiPizR257EeVnpqPnjVNEcE=;
        b=J7mIRHSJXhhEqxo3NzUu104UWEaGpPlhtuJbzbIZA8eD1MIbRKJU6zbJ4lbtgkkYAL
         G/1caOEZKLSGRpVbw6W6SB2boTmTiHVG8/imBStIQdns5UOVnKJWyyZh1lCnRH3onDwb
         9y1nXTuWmnjCdRQYYRd70RBrwfXLqjWDHLksrPMs/jmN9WsT5KV3utLoWyt1qv1hVADv
         rfo2j3XwUJ9Gld9xQR4sWPlvUX2MtBZ5V+/u4x8zMA3WAjg9d8zlY6jWROYYEDEmSuj7
         tPXtfJtBVRoM50AXwdaxa7uob/wqupDWJU4EAuKVq8jSbbc/t2MVg8HApV23nLpKBCWK
         8d+w==
X-Gm-Message-State: AOAM531yA2FSfyoIviR40xfH/syPZUmUNIi2V3WHxk6yCS+yxCg5QDtm
        I2JTRgMcPOq1884Vp+XS9smUZ+JZpIdXFg==
X-Google-Smtp-Source: ABdhPJyX6cDzJ29PKias/qfWiHzlxz/CIIlnG39utN5Ohs9jzVf+HpAsJZW9sC7eGOZYJzaiFiHffLfuxlk31A==
X-Received: by 2002:a0c:fdeb:: with SMTP id m11mr32366961qvu.103.1597124384218;
 Mon, 10 Aug 2020 22:39:44 -0700 (PDT)
Date:   Mon, 10 Aug 2020 22:39:14 -0700
In-Reply-To: <20200811053914.652710-1-davidgow@google.com>
Message-Id: <20200811053914.652710-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200811053914.652710-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v12 5/6] KASAN: Testing Documentation
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, David Gow <davidgow@google.com>
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
Tested-by: Andrey Konovalov <andreyknvl@google.com>
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
2.28.0.236.gb10cc79966-goog

