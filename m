Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81641B6DE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 08:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDXGOH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 02:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725889AbgDXGOG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 02:14:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12BEC09B045
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:14:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m138so2435862ybf.12
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5epptiP6vyK9ksah1mqKRXgiRHBz5N7tvZFE7or+VcA=;
        b=ulwvVvdqEW+IJ4ZDJ8/ufTJ/zOyYKVP39a143BYyHnkike1p3jMupT4mYRbcDXGObR
         kt/ycV+2w4PE+xLdGnOd72QOFvCtb/zTp89MZBAKxwolAEK+nUufeHi1AZWm29hq6ZLE
         /JML3lImDzCGevk5SkhdI9IFNaCtuGfbobXCQdycrnVlghyg7LW9hskkiNHXoEiv4Q0x
         rmlxt8TuRi6I3Xvy2IO/59Thimn5irJyuGxgPvcAWQlnZx4fGRXe7BUbboXF7AhNN9A8
         foEVvkDb5g9p+3H2LXbAwJxzam5E5LlTyqgw7/J3v5JKu+oeY0LSoSUKznBIdMx96hNW
         //gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5epptiP6vyK9ksah1mqKRXgiRHBz5N7tvZFE7or+VcA=;
        b=k71iB0z94S0HEUZao8iQZlql6QXe3v9Zi3JjbHb8s/whtBSRyRy2sd96D5UAp4WZLL
         3mX6DNQbhlOdfohlt987Mryt/M7uByg7ABieehamk7reSB4616p6mlOIu2NOxEh5JzGh
         84WR0hYHDz8o2FIFXdjjkwVQnDiEwjbnFlf/HIPGyC1c61scQb88bJZWjNK1VXIN4/TO
         BNTPace37MMXQP+vOW7AilnXDRHuSyLxI8PdA2pVoquVtoLzckiYJwRX+kgFQFlxU+kd
         JNNBSOZhKZdZ2/Reuo9C2cRIdQ7Ogc23bzuCFhmk2Gcv2F0qUDO0bpIuZg0ZNnRMsfPC
         a6wg==
X-Gm-Message-State: AGi0PuahUEc6Zej/adv8QsQPezoJr3VBUm6XLGxusG12Kii/kMuriT1+
        cwyQt/KczfqB6Yly6I0lNlfKVk/qs2eqFA==
X-Google-Smtp-Source: APiQypJovP6+qI5o42bhNd8V9jsDjBcJywaFZ16qLB01QR5bZhAswW3ktdSN1KWfx+4lWLLGUYKhYpLKpM5S/w==
X-Received: by 2002:a25:bd4c:: with SMTP id p12mr13287597ybm.140.1587708844982;
 Thu, 23 Apr 2020 23:14:04 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:13:41 -0700
In-Reply-To: <20200424061342.212535-1-davidgow@google.com>
Message-Id: <20200424061342.212535-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v7 4/5] KASAN: Testing Documentation
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

Include documentation on how to test KASAN using CONFIG_TEST_KASAN_KUNIT
and CONFIG_TEST_KASAN_MODULE.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
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
2.26.2.303.gf8c07b1a785-goog

