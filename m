Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00D775A1D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 00:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGSWYx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 18:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGSWYq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 18:24:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3822113
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:24:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942667393so1657827b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805449; x=1692397449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHegRKijxtllrUHzL1SgBpkoHu+y+n5qaq++K8WyWmA=;
        b=fdqBQx83SLumVnseBEBGY8wv1JHLRmHCegfbTKpsqZwmsnq3Dm9xmh64SvghtVFTxA
         wHDeybiDWo9RRB9Btl/nyr8aI0jF8V56ADHIVUGP4UOVNQE9HEwaH62CkVlLzWsWdEY7
         /ipNN+nLRrWA38Ov0mBVaaORiD0LU/oRw+o2FOjrIvwYfaqhXiiv35+isDfRE0vqyxJg
         xyLpa4ck/n4pl9RupD+kPhZ8ot8uhEK30tTJALzry75zdcVvQiiEIgtm3DvteNF/roGS
         ZnV9KjTtZFooTBiwo8z8fEbjtp9qYRnkT6YWvzto1xA/uyuQzoedsmwY2VUORG84r/ya
         XX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805449; x=1692397449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHegRKijxtllrUHzL1SgBpkoHu+y+n5qaq++K8WyWmA=;
        b=kvBdZ5UPHOUWllZMAyf0ekvG/KIt6nJ3A5zMF+ruBGC1l+3IDAmanOOi/HbRBdpGQv
         iynLmQc+xqpTe2HomTwJQGh8SyviIzLwTKa9O38bJIokP5edKQ6zaYn5y+n6mJ1Ty3+N
         w6i8HgX6zCShH6kjtTSVfD9JHcVEhQcn45J45YqdpyH1nP+mUcH1trcVLkOh+Y9ABxIw
         GZUUxxSLDmlito6E5ZFJawRVftxBTtrySkcuI7mrnYNhcKF7uyBtqE4jaXrDnJpQdAi4
         2k+EZNsvvQpPItuHglXjF6H8laehx5iJKpOBTXmHsSK3VxnemOdTcqCEJvD10F9vGYwr
         T6Gg==
X-Gm-Message-State: ABy/qLZ646o81K8D7x2tHgay8Malpltv7EE8b+A/Btw9QSyyfdItTTI7
        CecKHpON4oZGXY2pjiatefJYEhIWSA==
X-Google-Smtp-Source: APBJJlE8YL/XYJLuvTEOkCulIsrvD7y2CHXTDLudsi1AezvQ7W5NJYo+J0HPPSfJWCFexPio++2FX+ebfg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:ab0e:0:b0:cc5:c7d6:ae13 with SMTP id
 u14-20020a25ab0e000000b00cc5c7d6ae13mr31839ybi.5.1689805449595; Wed, 19 Jul
 2023 15:24:09 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:23:36 +0000
In-Reply-To: <20230719222338.259684-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230719222338.259684-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719222338.259684-10-rmoar@google.com>
Subject: [PATCH v1 9/9] kunit: Add documentation of KUnit test attributes
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

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since RFC v2:
- Add comment on KUNIT_CASE_SLOW() to documentation.
- Add comment on how to expose raw kernel output.
- Remove an extra line at the end of file.

Changes since RFC v1:
- This is a new patch

 .../dev-tools/kunit/running_tips.rst          | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)

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
2.41.0.255.g8b1d071c50-goog

