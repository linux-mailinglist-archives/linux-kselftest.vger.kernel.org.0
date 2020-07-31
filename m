Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352D7233E6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 06:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgGaEnK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 00:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgGaEnI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 00:43:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C21C061575
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jul 2020 21:43:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z5so21107206ybo.9
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jul 2020 21:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BW8tJXunVDhJUT5XRrBOJfZjcR8xNS1VRsDjHnpq2UQ=;
        b=PzMkVTq10D01+nFN0V52eFmLisb/U/VEBWan8hJsJnThbAngryHxl38SbnKMApQ6qW
         PdabAwkR9xbxtvheieCsaIlOzrUP6Teis45mKc7ur9HBY9UaIgwwhiY3GrGX4KG7fRis
         4BdBKiHTuT0clu1HgySJZcRY9XVk2go5BaQ8/0Wa63HGGKk/aXh1bM0uTCKejvlU4SzT
         ohMrA2PNPdWUBDBtLN45Lib/QMo3nKcNY5haiVtlHkBWYFxXGwcG+aJvVIomQKKbTIVv
         nAfJxnc6acozGQ8jdBijukd5XX//IL8LwykdEsbnn522DJOLQ8wphwFxyEz/Qmv+YOPQ
         nSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BW8tJXunVDhJUT5XRrBOJfZjcR8xNS1VRsDjHnpq2UQ=;
        b=g0+mSjnubKqrKsNaSTEhPQtC7ONVlCSOvDkdsseeHc7g/IBF2MgHbUdf1phyenkN7h
         b9JzjqrkbJCZ+XZnG0Y9ovcdQNHtdkgZHjdirYpP7RUdy3NahZmctEiwJNm+WY1DJi6W
         EoFjqIqU182b/T96MMkNa9YdwlCnu4JfhfjPSJ1X0AVXDiTLalFCCn4dq5AAb1InflEB
         DiXVTZnSARNnH8PUPMJCrAKLS4K0vTB7P3zzFEyx131Yf4TmRNEF3xZXinKPa4xCeLja
         O97wXde3GlutmZzzQRZbwspYEe3/Vzhxfur3kryXuVLpp+42dRwHV2foghgTyR1BAxUP
         jmzQ==
X-Gm-Message-State: AOAM531VCt4xhbYj5VoFuqgE0JdVjEwWfkGEKLypXbuKgtOTplwJdn1U
        8gt4BHkFpMuIyXjOSJMjRvy0+cxg0smFHw==
X-Google-Smtp-Source: ABdhPJyYVIzaRc4aBuc+Ee1NuoEmRVl6x9tNw+147D/G2kf68oji9oeoR4JZ1I0m72B9SUwdn0JErt2a5Zxunw==
X-Received: by 2002:a25:aaf3:: with SMTP id t106mr3273322ybi.56.1596170587795;
 Thu, 30 Jul 2020 21:43:07 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:42:41 -0700
In-Reply-To: <20200731044242.1323143-1-davidgow@google.com>
Message-Id: <20200731044242.1323143-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200731044242.1323143-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v9 4/5] KASAN: Testing Documentation
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
index c652d740735d..1f9a75df0fc8 100644
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

