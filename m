Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FFB76245E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjGYV02 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjGYVZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:25:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B5269E
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1851c52f3dso1290230276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320344; x=1690925144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7K0SwNjZ7cDQq8m8sEtyq9n1FsAQbDDAlgc1iAoacs=;
        b=iJrFDpYz4pwDiFgDJo+9rsVRNzdUOrxcF1CqXyiEoiOKzdBrkEa5Gq/0vWr+2ylO1N
         esp5RTVx824mkg6IEdpt1TcZraHPjGrN9UyUwuOzp/pv5Z4DAj/2+pJPhRwUDPqsLfQ+
         RJp1LEvUt7z0GPxhHLlaq0I1yHGCZ98bwRyR6Y0KlJLSR+hW5f5zJ8pHjx5rjn6812ER
         AIl2PdRWbba+31bCD5VvcI/bTtC+QQJscdZT14xFKv8LbZEcw5WXL+7QnsNu5GJLaREN
         rLwcPYufJ98JEQyxwW3o7Kxo42nDCdY3OHlBwNT4kbVjiH95rHSYu/1UdBx+WQBrvQPq
         K52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320344; x=1690925144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7K0SwNjZ7cDQq8m8sEtyq9n1FsAQbDDAlgc1iAoacs=;
        b=YLTjqD32z8NEwvIWgbjKl8Kmyt4nAeBilV+4ARQVe9nC344IduRNd/0P6a7mSsiGNo
         HuwtWR+T6QYLxw3F2x2k+U8n/g8M2zuTfuvNSFrnLLuvMoEoHLU3nxkhIHymsTEKkSlJ
         ZmsBgAtqUuBiJBzyB2TuunTt6maz8Rit/tlTzT/myoihGtpLIgidhjDrQ5x8Xx4otLm6
         5j1LxrGsuwiTsacHI3QvfGTy/ywx0YhvmOALkvYN/Lt88TjhmMT6tL8NxEe+atjDS7uP
         U9JEB8FiBa3ErkB9+yu0aTO8IrYxbE3Mc3qr+B0874EM8Y5nwqpvaES/fnL7OH8hdGrD
         Fm8g==
X-Gm-Message-State: ABy/qLYICAvMxn4isYGggp/sRVKOs2leB/CEGc7tycSsVG1GHdrm4yB1
        SfURv+7aVqsjGUzD8wg+lCeVHvKQgA==
X-Google-Smtp-Source: APBJJlF7vOYdQoZqQUtjSKqvLzB5C1brzb7bzbe9ArLJuVqGxMMjibdGEneFOuoF5O434q4d6+UtTgRMew==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:abd2:0:b0:d05:e080:63c6 with SMTP id
 v76-20020a25abd2000000b00d05e08063c6mr1313ybi.9.1690320344550; Tue, 25 Jul
 2023 14:25:44 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:25:20 +0000
In-Reply-To: <20230725212522.1622716-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230725212522.1622716-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725212522.1622716-10-rmoar@google.com>
Subject: [PATCH v3 9/9] kunit: Add documentation of KUnit test attributes
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Add descriptions of new flags to list of command-line arguments.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v2:
- Add to list of command-line arguments in run_wrapper.rst.
Changes since v1:
- No changes.
Changes since RFC v2:
- Add comment on KUNIT_CASE_SLOW() to documentation.
- Add comment on how to expose raw kernel output.
- Remove an extra line at the end of file.
Changes since RFC v1:
- This is a new patch

 Documentation/dev-tools/kunit/run_wrapper.rst |  12 ++
 .../dev-tools/kunit/running_tips.rst          | 166 ++++++++++++++++++
 2 files changed, 178 insertions(+)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index dafe8eb28d30..19ddf5e07013 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -321,3 +321,15 @@ command line arguments:
 
 - ``--json``: If set, stores the test results in a JSON format and prints to `stdout` or
   saves to a file if a filename is specified.
+
+- ``--filter``: Specifies filters on test attributes, for example, ``speed!=slow``.
+  Multiple filters can be used by wrapping input in quotes and separating filters
+  by commas. Example: ``--filter "speed>slow, module=example"``.
+
+- ``--filter_action``: If set to ``skip``, filtered tests will be shown as skipped
+  in the output rather than showing no output.
+
+- ``--list_tests``: If set, lists all tests that will be run.
+
+- ``--list_tests_attr``: If set, lists all tests that will be run and all of their
+  attributes.
diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 8e8c493f17d1..766f9cdea0fa 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -262,3 +262,169 @@ other code executed during boot, e.g.
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
+When a user runs tests, attributes will be present in the raw kernel output (in
+KTAP format). Note that attributes will be hidden by default in kunit.py output
+for all passing tests but the raw kernel output can be accessed using the
+``--raw_output`` flag. This is an example of how test attributes for test cases
+will be formatted in kernel output:
+
+.. code-block:: none
+
+	# example_test.speed: slow
+	ok 1 example_test
+
+This is an example of how test attributes for test suites will be formatted in
+kernel output:
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
+``--filter_action=skip`` flag to skip filtered tests instead. These tests will be
+shown in the test output in the test but will not run. To use this feature when
+running KUnit manually, use the module param ``kunit.filter_action=skip``.
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
+The macro ``KUNIT_CASE_SLOW(test_name)`` can be easily used to set the speed
+of a test case to "slow".
+
+``module``
+
+This attribute indicates the name of the module associated with the test.
+
+This attribute is automatically saved as a string and is printed for each suite.
+Tests can also be filtered using this attribute.
-- 
2.41.0.487.g6d72f3e995-goog

