Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C0623C49F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 06:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHEEaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 00:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgHEE36 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 00:29:58 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE09CC06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 21:29:57 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r24so10519209qtu.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 21:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nr8mXyqoppq75z/FRAmv2PARhpMnaUiNjcYddLk+74Y=;
        b=TBGXVFSWKjIeEBqhvRaejVcq72l1gKFOpsaGCkZOAQJpdKTwqMp/DQXge1vJKAeR5/
         ThVPPm/zNb2xLLpfeYEeQKNcqG1kCFRXvJwJiHpulAaJiB4j61TxQCMJFcOkOXgOLQ/Z
         a2+HD8lIq0X8NR4IZH3ThaMkZ5BmfQlKqHdr8xVOPWzrMhVpfzKN2qoCftelTjCce5AI
         cymRYGgP42zU7ZsJC3GMRNkOPIaQt/cJM7bc1TnycBnTatTc0ilWK9Nq2QCTMj/6Bb4/
         FtEHlXvb7Mgo1q8joQCtFHwsHZ1OiGoQ78JdVDGjNgdnJ6t86ULnbwBakvPUfdTbNOMZ
         Ibtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nr8mXyqoppq75z/FRAmv2PARhpMnaUiNjcYddLk+74Y=;
        b=hZ2zR+Ol0cRFMQZw7WKx+XtWQOir+OCEV8Utudnt3bSf7GLUKcD7fyK9nmzQglo7DZ
         /1TCpnpEHMiBpmoMfm4CJhzBr8pvFhy5KXjP0gMSA+h4Ia+zd9pmv1qhauilcbzjHZF7
         j89mvvnnY/IbPsrHpJjHZ4OHC0UDuIGvZYgB7mtMcGbBI7Fv3Av8ap8XNFxkTDtPE7hY
         qwin4cYH9uyVI/hTnBV5ro9Eeuy20D6z2z+OzuTiiqe/Th36VIDBSmr94QjJZz1FVM0E
         HKYmj9CFxIox6DYHin/YejJjxP5hPypytWZBoLsUo1Spl2GLuiH69DYMZF22cI8RBwzd
         /LfQ==
X-Gm-Message-State: AOAM531WhQpvIDbfJ/UZfVwR0vMYxW9ZnqM5VkX7HI5MpcLPM6dFAae/
        mJsDEgbPbLjwW1QwG7m+iHJapwU/HZYzuA==
X-Google-Smtp-Source: ABdhPJyOD1VNp72JmjPWa6NqIFzpjMKCPktNfzHcJvlTS4cUwujsKARM51+jzJ3ICEGDcQvZK6HI7D4IA5H6KQ==
X-Received: by 2002:ad4:4152:: with SMTP id z18mr1839378qvp.42.1596601796941;
 Tue, 04 Aug 2020 21:29:56 -0700 (PDT)
Date:   Tue,  4 Aug 2020 21:29:37 -0700
In-Reply-To: <20200805042938.2961494-1-davidgow@google.com>
Message-Id: <20200805042938.2961494-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200805042938.2961494-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v11 5/6] KASAN: Testing Documentation
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

