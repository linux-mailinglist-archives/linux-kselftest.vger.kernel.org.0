Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E009519B526
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Apr 2020 20:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbgDASJT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Apr 2020 14:09:19 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38047 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbgDASJR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Apr 2020 14:09:17 -0400
Received: by mail-pf1-f201.google.com with SMTP id f14so341400pfk.5
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Apr 2020 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sl7H9I59bpRm4U1wnt7pV7FscJTzqhyyGtH4qFo0cnw=;
        b=HYgbJZF8sm1qparMe06AkzEc7qaGGH00lW1rsjBbEkAm8hVh0ErgODtVtBimJrCQKr
         izVCXd27uTvHIiFZcFSolrMk4j9kkkXLAkNIqviK3a9zFOA3obVvQ3//vZSkn5bf4Sc/
         IZmLwScnjwG3ATFT8gU4QZkTkia9hI/c7d+sB1ymo2ZfaiKL6rMoDlC82gdfSATD3X4N
         hcUJltIV1nueLJlGLp6Qm5hGbkI9juzDoI+eSZ7ov5wN/vIsrL7HtZ1DRlx+Rv85RTND
         URHjv7vebuTNo+8QvzCBRYKrDS6G1ve3h4D85/g4u/eY/kmhnWD68UVA7FfPFkjL1cE9
         /W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sl7H9I59bpRm4U1wnt7pV7FscJTzqhyyGtH4qFo0cnw=;
        b=tFuRAnEu2iwCCNYEM7vJMl2pFKdKNSAI2FzdPLKmWQc4GPngSaNepy8floTqdd87Cj
         WC+cxe524c1pX4FaTumnMBWreSd1xFA3LXssXSzYfwyBPqv+OERwjRjVVtg85WVSieOq
         d3UaRvscx3R+mYhcUjORW3LBEfyG7RkNcssGPqnVJjEvyguOh2iHwxBFAJuVdkETHz2l
         rMTwtR4eLCkalaj8znTABEsqiMG6BnLcgBMjdESdhbLiLLUud3yxB9sb2FXET6Fy5OfI
         w2rEYJgiRNt1RvJJSrkDjCyFFVrRGT0mK1UZHxwhf+/fPuZEycPvzmsl3scEwo9RX15+
         MoLA==
X-Gm-Message-State: AGi0PuZnlkugLHuANJPYeJnieA9A60uwh9sYkUZWAEt0yv3LoPhfTIaJ
        xIxWi3M4JRYlBhJkUfFlVH0n3BpOkd9hfrqC2l0=
X-Google-Smtp-Source: APiQypLF1qWNJXD1fT9nzFedbjzAuhNuOmVK3uF6dZCjbiYe/bcZ6RjhyP2JoayHnVPnI8FMUp4QiYMmTB/RaKvdioc=
X-Received: by 2002:a17:90b:3610:: with SMTP id ml16mr6405214pjb.106.1585764555886;
 Wed, 01 Apr 2020 11:09:15 -0700 (PDT)
Date:   Wed,  1 Apr 2020 11:09:05 -0700
In-Reply-To: <20200401180907.202604-1-trishalfonso@google.com>
Message-Id: <20200401180907.202604-3-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 4/4] KASAN: Testing Documentation
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
2.26.0.rc2.310.g2932bb562d-goog

