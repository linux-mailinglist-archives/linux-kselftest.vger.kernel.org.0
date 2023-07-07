Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C503874B893
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjGGVKa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjGGVKU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:10:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99712709
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:10:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704970148dso24443997b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764209; x=1691356209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0vdCYMeJDFc0tJZJeG4SrOCjUh3NZwz/CMs94R9KHI=;
        b=aNkEmqlJkObqcMsU36aa2vJb47OZb+709zchT3pXIkQtUH0X8K6r6WfMr6b4SShBKZ
         OJdv+M3Dtiph/CL/f4a0OKWRB1x+A8z3S93LYDlXTAqtK1f5SOlPbu/W0FqSZa5dXLlQ
         GfQ8tPp+6u8UzVILbznww18QNDIwB59tZ/C3E1krhE5UBgCrSbHw59mzRdvfYtqpgdPp
         pnrKKPyQQE60SE5SZlQBZpbf23px4Qa/em0os2EyngzJca4CohLTPQh93AxpWOdotcFZ
         3VoUJrW/VOj7sf/cxtBaRUWhPGYgKJtv8OVW/ahfTEpYKmkwNzlUN7mI5PcwXk3HTfcp
         vs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764209; x=1691356209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0vdCYMeJDFc0tJZJeG4SrOCjUh3NZwz/CMs94R9KHI=;
        b=AXq91gGOtfskd5/FtnnV0R16LJqt3H0V40iR4/srOTXOJhplwU5yzqAGrN/zYGFxqu
         yrmKB85sNY4C6tDf5V6Bvqu7PYZS6BoTVjBUwfOnEfLSHPHpOMifRYdfPUZ6aBkt4SCM
         InTRHY91qjQXt73ffAm4kxVMJmvZDpBdBUih6ZIy0oOpwNBUYCy6EtZcYMQ0fQsk23sy
         Ha3Own51kIqJ7jCQ2F2AIfcFH0QJJY8pqOULkzH8H8xos0kLyMy7cBNVPdwPqg06NCJh
         M+w2WRyBd8CFuc6IRSIDCl3XuNXwc81ZsK0zHwm43+ztGzB3yji5BOYs/Js9+zf5ICKv
         NtKw==
X-Gm-Message-State: ABy/qLbrpY9N1fk2iCuagei5N4mI19VVNZOkZ4W8yLIbZpV+y4dgXQbb
        9tQExr2fAOPp2d3FoA9b4Gut1ThvMg==
X-Google-Smtp-Source: APBJJlFlKKNSjVmNDQSbIuIyk93/Iz8gteRI/xLuLo6T966GvIruEFsCNxx5RQRG10QcjVYtL2BxL7klrg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:bc01:0:b0:562:837:122f with SMTP id
 a1-20020a81bc01000000b005620837122fmr48027ywi.9.1688764209443; Fri, 07 Jul
 2023 14:10:09 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:47 +0000
In-Reply-To: <20230707210947.1208717-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-10-rmoar@google.com>
Subject: [RFC v2 9/9] kunit: Add documentation of KUnit test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add documentation on the use of test attributes under the section "Tips for
Running KUnit Tests" in the KUnit docs.

Documentation includes three sections on how to mark tests with attributes,
how attributes are reported, and how the user can filter tests using test
attributes.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- This is a new patch

 .../dev-tools/kunit/running_tips.rst          | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 8e8c493f17d1..c9bc5a6595d3 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -262,3 +262,166 @@ other code executed during boot, e.g.
 	# Reset coverage counters before running the test.
 	$ echo 0 > /sys/kernel/debug/gcov/reset
 	$ modprobe kunit-example-test
+
+
+Test Attributes and Filtering
+=============================
+
+Test suites and cases can be marked with test attributes, such as speed of
+test. These attributes will later be printed in test output and can be used to
+filter test execution.
+
+Marking Test Attributes
+-----------------------
+
+Tests are marked with an attribute by including a ``kunit_attributes`` object
+in the test definition.
+
+Test cases can be marked using the ``KUNIT_CASE_ATTR(test_name, attributes)``
+macro to define the test case instead of ``KUNIT_CASE(test_name)``.
+
+.. code-block:: c
+
+	static const struct kunit_attributes example_attr = {
+		.speed = KUNIT_VERY_SLOW,
+	};
+
+	static struct kunit_case example_test_cases[] = {
+		KUNIT_CASE_ATTR(example_test, example_attr),
+	};
+
+.. note::
+	To mark a test case as slow, you can also use ``KUNIT_CASE_SLOW(test_name)``.
+	This is a helpful macro as the slow attribute is the most commonly used.
+
+Test suites can be marked with an attribute by setting the "attr" field in the
+suite definition.
+
+.. code-block:: c
+
+	static const struct kunit_attributes example_attr = {
+		.speed = KUNIT_VERY_SLOW,
+	};
+
+	static struct kunit_suite example_test_suite = {
+		...,
+		.attr = example_attr,
+	};
+
+.. note::
+	Not all attributes need to be set in a ``kunit_attributes`` object. Unset
+	attributes will remain uninitialized and act as though the attribute is set
+	to 0 or NULL. Thus, if an attribute is set to 0, it is treated as unset.
+	These unset attributes will not be reported and may act as a default value
+	for filtering purposes.
+
+Reporting Attributes
+--------------------
+
+When a user runs tests, attributes will be present in kernel output (in KTAP
+format). This is an example of how test attributes for test cases will be formatted
+in Kernel output:
+
+.. code-block:: none
+
+	# example_test.speed: slow
+	ok 1 example_test
+
+This is an example of how test attributes for test suites will be formatted in
+Kernel output:
+
+.. code-block:: none
+
+	  KTAP version 2
+	  # Subtest: example_suite
+	  # module: kunit_example_test
+	  1..3
+	  ...
+	ok 1 example_suite
+
+Additionally, users can output a full attribute report of tests with their
+attributes, using the command line flag ``--list_tests_attr``:
+
+.. code-block:: bash
+
+	kunit.py run "example" --list_tests_attr
+
+.. note::
+	This report can be accessed when running KUnit manually by passing in the
+	module_param ``kunit.action=list_attr``.
+
+Filtering
+---------
+
+Users can filter tests using the ``--filter`` command line flag when running
+tests. As an example:
+
+.. code-block:: bash
+
+	kunit.py run --filter speed=slow
+
+
+You can also use the following operations on filters: "<", ">", "<=", ">=",
+"!=", and "=". Example:
+
+.. code-block:: bash
+
+	kunit.py run --filter "speed>slow"
+
+This example will run all tests with speeds faster than slow. Note that the
+characters < and > are often interpreted by the shell, so they may need to be
+quoted or escaped, as above.
+
+Additionally, you can use multiple filters at once. Simply separate filters
+using commas. Example:
+
+.. code-block:: bash
+
+	kunit.py run --filter "speed>slow, module=kunit_example_test"
+
+.. note::
+	You can use this filtering feature when running KUnit manually by passing
+	the filter as a module param: ``kunit.filter="speed>slow, speed<=normal"``.
+
+Filtered tests will not run or show up in the test output. You can use the
+``--filter_skip`` flag to skip filtered tests instead. These tests will be
+shown in the test output in the test but will not run. To use this feature when
+running KUnit manually, use the ``kunit.filter`` module param with
+``kunit.filter_action=skip``.
+
+Rules of Filtering Procedure
+----------------------------
+
+Since both suites and test cases can have attributes, there may be conflicts
+between attributes during filtering. The process of filtering follows these
+rules:
+
+- Filtering always operates at a per-test level.
+
+- If a test has an attribute set, then the test's value is filtered on.
+
+- Otherwise, the value falls back to the suite's value.
+
+- If neither are set, the attribute has a global "default" value, which is used.
+
+List of Current Attributes
+--------------------------
+
+``speed``
+
+This attribute indicates the speed of a test's execution (how slow or fast the
+test is).
+
+This attribute is saved as an enum with the following categories: "normal",
+"slow", or "very_slow". The assumed default speed for tests is "normal". This
+indicates that the test takes a relatively trivial amount of time (less than
+1 second), regardless of the machine it is running on. Any test slower than
+this could be marked as "slow" or "very_slow".
+
+``module``
+
+This attribute indicates the name of the module associated with the test.
+
+This attribute is automatically saved as a string and is printed for each suite.
+Tests can also be filtered using this attribute.
+
-- 
2.41.0.255.g8b1d071c50-goog

