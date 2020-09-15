Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B642A269CBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 05:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIOD6z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 23:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgIOD6r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 23:58:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E0C061797
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Sep 2020 20:58:46 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 139so2002417qkl.11
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Sep 2020 20:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uCglP5LX985FGF4m2PQOWOUblsVZfIf8g+EYcPDK67c=;
        b=HPKahaLV0BRynEGp6ZaODFkiwQm1KiRc4qKnG7F0a72KRtJLIW+kK9HpYePY+PelRW
         kqfvCu5DTIS8RLAsyz6LsWwQgIXFxbSIfKdVQqZBtt/kzQAuUjER20J4MM1AeRBjbe9N
         1sjCzqqF0ugnAnz2WCZfARgqOotVf2e9fB6j9OicYUNrSV035CoRTjhwoJ48YTLd8nC6
         taGtf0mqTakdfcWbUXx+q4JRFdl/cRzBjusPvSdNxI4i8lKIiyWedjAjB6NjVl/1MuEl
         ai4RGLJ46opkRsumeRA6bG1+fRtGQoHJ7G0N/G7QdhixURMVxgOl8tC2v9Be21dh8p/U
         Qs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uCglP5LX985FGF4m2PQOWOUblsVZfIf8g+EYcPDK67c=;
        b=NiwRe2RiNjEgjgenZzO8OgEyWAe6YHVHlYRGB59iBXHbeTB4kDgUjkqe2mHYjLvM0y
         DFqXvi3uzzeulkqmmdEC/PF2y/3dptiIK6g4KFHCI21QLyYvwxxte470w+vREAiWqKZR
         uKD79Rq45t+2MAX4Gxe/xCQW+6Tv9UPvuwQwkuz/huRsmgU5ZuDR7wyTEauGtt68kINv
         2Mlb8B7PBTlUGr+CF4Qw1ZogL7MO7erEnWIVmCI6OPZDrCLhw4qSjTl0VwOVNj6VFl9E
         g8DyB85ocx+1u9FsY8WC8YmrrGXJwEFBCQWPRtP2ZMZzE/c+ZH8U+V888mH6AZ04TP+j
         WC8g==
X-Gm-Message-State: AOAM531vVIqIJtZMwkPYVN5aVUAEpkWX2i0GoN9Ldi8qDFcCxVJ9RPgP
        LbAKipEZuME23osuj28GfuJQ/L/vfRbeXg==
X-Google-Smtp-Source: ABdhPJzwoiMnTkw6yQ4Uu2gGaOfIAl6aoYI/Wx2A+phY8mopGuZDP+JJBXzJsVOGJLcvnpOIpt/sx8ONxdq62Q==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a0c:f48e:: with SMTP id
 i14mr16532536qvm.9.1600142325247; Mon, 14 Sep 2020 20:58:45 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:58:27 -0700
In-Reply-To: <20200915035828.570483-1-davidgow@google.com>
Message-Id: <20200915035828.570483-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200915035828.570483-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v14 4/5] KASAN: Testing Documentation
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
index 38fd5681fade..072ecdadba07 100644
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
+        ok 1 - kasan
+
+or::
+
+        not ok 1 - kasan
+
+(1) Loadable Module
+~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
+a loadable module and run on any architecture that supports KASAN
+using something like insmod or modprobe. The module is called ``test_kasan``.
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
2.28.0.618.gf4bc123cb7-goog

