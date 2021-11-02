Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1A44360A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 19:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhKBSyv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKBSyv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 14:54:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391AC061203
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 11:52:15 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so219196ott.4
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=J5WnZ8PIubr4lSEk9D9fN/49daktrQzkMNKNj/cFXkY=;
        b=TwwhJ9JvAxR+bNH7VryHlNiAbOkZfsKtI/UHgFlTceaIztfCcBCzDZVh9Wzeu3LLW4
         psY65DafY+DRdO3s2ylnDok2HJoO40Bj/8mk82PPJpXpBZTtxYq9sP8NsPuXhlZr3eLn
         id/fsjfCFYnNMFAUWNohg7e+EJqoSVjXr7WFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=J5WnZ8PIubr4lSEk9D9fN/49daktrQzkMNKNj/cFXkY=;
        b=sz11AVaa7MVDniH3EchrdMWfQS+Tg9Rf5fTNan2ChdYCtI/Ta7B0x5PHakTubERe28
         6ZlSRxZZd+KfdI1u1FNbkJchP8wzg6lXmc3AjL2I0Vp0tMywicfeH959s5lobxEyN1Ab
         pL6CGzkHlBnnpNRSYYzL+A0UNfQQUDZfXQYMur5znVS5d6FnbPhipbxq7jUmb4by1R72
         CLbhZPXTGn/rAMGqMx/BEINSNCxbxD20qEUR7+yg7h5wYJf+u8IRxOx5mM24KIW9B5vU
         wk9TUrsGeJm8Sfchm0DFWVnLMqYCOoRwTRkZO+mPjezS2A7qw2h0F2hoVPS0dtq6Zf7l
         +UiQ==
X-Gm-Message-State: AOAM530gKwE45lG1/vQtIJpolFv3guOwp2cfMWH2QUJ84ocdrdHCCwMD
        1BHpoko9azgRwcPVe8esARcq/m8Msp6huA==
X-Google-Smtp-Source: ABdhPJzChBif/ZZxUQLhgMEDj6EE8R+KVLEIGfx3u/uDA0LcVAwHSEFinZHsvfFUlbL1CIGj8JNQCA==
X-Received: by 2002:a05:6830:1244:: with SMTP id s4mr27628075otp.161.1635879134881;
        Tue, 02 Nov 2021 11:52:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i11sm3449784oof.36.2021.11.02.11.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 11:52:14 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.16-rc1
Message-ID: <2838f567-ad44-ec1e-dc26-6205d78b0feb@linuxfoundation.org>
Date:   Tue, 2 Nov 2021 12:52:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------216E70BCB2E0C4E6463366A8"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------216E70BCB2E0C4E6463366A8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit update for Linux 5.16-rc1.

This KUnit update for Linux 5.16-rc1 consist of several enhancements
and fixes:

- ability to run each test suite and test separately
- support for timing test run
- several fixes and improvements

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

   Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.16-rc1

for you to fetch changes up to 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a:

   kunit: tool: fix typecheck errors about loading qemu configs (2021-10-29 13:05:47 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.16-rc1

This KUnit update for Linux 5.16-rc1 consist of several enhancements
and fixes:

- ability to run each test suite and test separately
- support for timing test run
- several fixes and improvements

----------------------------------------------------------------
Daniel Latypov (12):
       kunit: drop assumption in kunit-log-test about current suite
       kunit: tool: allow filtering test cases via glob
       kunit: fix too small allocation when using suite-only kunit.filter_glob
       kunit: tool: misc fixes (unused vars, imports, leaked files)
       kunit: tool: show list of valid --arch options when invalid
       kunit: add 'kunit.action' param to allow listing out tests
       kunit: tool: factor exec + parse steps into a function
       kunit: tool: actually track how long it took to run tests
       kunit: tool: support running each suite/test separately
       kunit: tool: yield output from run_kernel in real time
       kunit: tool: continue past invalid utf-8 output
       kunit: tool: fix typecheck errors about loading qemu configs

David Gow (1):
       kunit: Reset suite count after running tests

Rae Moar (1):
       kunit: tool: improve compatibility of kunit_parser with KTAP specification

  Documentation/dev-tools/kunit/running_tips.rst     |   11 +-
  lib/kunit/executor.c                               |  152 ++-
  lib/kunit/executor_test.c                          |  110 ++-
  lib/kunit/kunit-test.c                             |   14 +-
  lib/kunit/test.c                                   |    6 +-
  tools/testing/kunit/kunit.py                       |  154 ++-
  tools/testing/kunit/kunit_json.py                  |   56 +-
  tools/testing/kunit/kunit_kernel.py                |  107 ++-
  tools/testing/kunit/kunit_parser.py                | 1015 ++++++++++++++------
  tools/testing/kunit/kunit_tool_test.py             |  211 +++-
  .../test_is_test_passed-all_passed_nested.log      |   34 +
  .../test_data/test_is_test_passed-kselftest.log    |   14 +
  .../test_data/test_is_test_passed-missing_plan.log |   31 +
  .../testing/kunit/test_data/test_strip_hyphen.log  |   16 +
  14 files changed, 1413 insertions(+), 518 deletions(-)
create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
  create mode 100644 tools/testing/kunit/test_data/test_strip_hyphen.log
----------------------------------------------------------------

--------------216E70BCB2E0C4E6463366A8
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.16-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.16-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 30d2147eb5b5..7b6d26a25959 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -25,8 +25,8 @@ It can be handy to create a bash function like:
 Running a subset of tests
 -------------------------
 
-``kunit.py run`` accepts an optional glob argument to filter tests. Currently
-this only matches against suite names, but this may change in the future.
+``kunit.py run`` accepts an optional glob argument to filter tests. The format
+is ``"<suite_glob>[.test_glob]"``.
 
 Say that we wanted to run the sysctl tests, we could do so via:
 
@@ -35,6 +35,13 @@ Say that we wanted to run the sysctl tests, we could do so via:
 	$ echo -e 'CONFIG_KUNIT=y\nCONFIG_KUNIT_ALL_TESTS=y' > .kunit/.kunitconfig
 	$ ./tools/testing/kunit/kunit.py run 'sysctl*'
 
+We can filter down to just the "write" tests via:
+
+.. code-block:: bash
+
+	$ echo -e 'CONFIG_KUNIT=y\nCONFIG_KUNIT_ALL_TESTS=y' > .kunit/.kunitconfig
+	$ ./tools/testing/kunit/kunit.py run 'sysctl*.*write*'
+
 We're paying the cost of building more tests than we need this way, but it's
 easier than fiddling with ``.kunitconfig`` files or commenting out
 ``kunit_suite``'s.
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index acd1de436f59..22640c9ee819 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -15,23 +15,89 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 #if IS_BUILTIN(CONFIG_KUNIT)
 
 static char *filter_glob_param;
+static char *action_param;
+
 module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
-		"Filter which KUnit test suites run at boot-time, e.g. list*");
+		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
+module_param_named(action, action_param, charp, 0);
+MODULE_PARM_DESC(action,
+		 "Changes KUnit executor behavior, valid values are:\n"
+		 "<none>: run the tests like normal\n"
+		 "'list' to list test names instead of running them.\n");
+
+/* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
+struct kunit_test_filter {
+	char *suite_glob;
+	char *test_glob;
+};
+
+/* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty. */
+static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
+				    const char *filter_glob)
+{
+	const int len = strlen(filter_glob);
+	const char *period = strchr(filter_glob, '.');
+
+	if (!period) {
+		parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
+		parsed->test_glob = NULL;
+		strcpy(parsed->suite_glob, filter_glob);
+		return;
+	}
+
+	parsed->suite_glob = kzalloc(period - filter_glob + 1, GFP_KERNEL);
+	parsed->test_glob = kzalloc(len - (period - filter_glob) + 1, GFP_KERNEL);
+
+	strncpy(parsed->suite_glob, filter_glob, period - filter_glob);
+	strncpy(parsed->test_glob, period + 1, len - (period - filter_glob));
+}
+
+/* Create a copy of suite with only tests that match test_glob. */
+static struct kunit_suite *
+kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
+{
+	int n = 0;
+	struct kunit_case *filtered, *test_case;
+	struct kunit_suite *copy;
+
+	kunit_suite_for_each_test_case(suite, test_case) {
+		if (!test_glob || glob_match(test_glob, test_case->name))
+			++n;
+	}
+
+	if (n == 0)
+		return NULL;
+
+	/* Use memcpy to workaround copy->name being const. */
+	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
+	memcpy(copy, suite, sizeof(*copy));
+
+	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
+
+	n = 0;
+	kunit_suite_for_each_test_case(suite, test_case) {
+		if (!test_glob || glob_match(test_glob, test_case->name))
+			filtered[n++] = *test_case;
+	}
+
+	copy->test_cases = filtered;
+	return copy;
+}
 
 static char *kunit_shutdown;
 core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
 
 static struct kunit_suite * const *
 kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
-			const char *filter_glob)
+		      struct kunit_test_filter *filter)
 {
 	int i, n = 0;
-	struct kunit_suite **filtered;
+	struct kunit_suite **filtered, *filtered_suite;
 
 	n = 0;
-	for (i = 0; subsuite[i] != NULL; ++i) {
-		if (glob_match(filter_glob, subsuite[i]->name))
+	for (i = 0; subsuite[i]; ++i) {
+		if (glob_match(filter->suite_glob, subsuite[i]->name))
 			++n;
 	}
 
@@ -44,8 +110,11 @@ kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
 
 	n = 0;
 	for (i = 0; subsuite[i] != NULL; ++i) {
-		if (glob_match(filter_glob, subsuite[i]->name))
-			filtered[n++] = subsuite[i];
+		if (!glob_match(filter->suite_glob, subsuite[i]->name))
+			continue;
+		filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
+		if (filtered_suite)
+			filtered[n++] = filtered_suite;
 	}
 	filtered[n] = NULL;
 
@@ -57,12 +126,32 @@ struct suite_set {
 	struct kunit_suite * const * const *end;
 };
 
+static void kunit_free_subsuite(struct kunit_suite * const *subsuite)
+{
+	unsigned int i;
+
+	for (i = 0; subsuite[i]; i++)
+		kfree(subsuite[i]);
+
+	kfree(subsuite);
+}
+
+static void kunit_free_suite_set(struct suite_set suite_set)
+{
+	struct kunit_suite * const * const *suites;
+
+	for (suites = suite_set.start; suites < suite_set.end; suites++)
+		kunit_free_subsuite(*suites);
+	kfree(suite_set.start);
+}
+
 static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 					    const char *filter_glob)
 {
 	int i;
 	struct kunit_suite * const **copy, * const *filtered_subsuite;
 	struct suite_set filtered;
+	struct kunit_test_filter filter;
 
 	const size_t max = suite_set->end - suite_set->start;
 
@@ -73,12 +162,17 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 		return filtered;
 	}
 
+	kunit_parse_filter_glob(&filter, filter_glob);
+
 	for (i = 0; i < max; ++i) {
-		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], filter_glob);
+		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
 		if (filtered_subsuite)
 			*copy++ = filtered_subsuite;
 	}
 	filtered.end = copy;
+
+	kfree(filter.suite_glob);
+	kfree(filter.test_glob);
 	return filtered;
 }
 
@@ -109,9 +203,35 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
 	pr_info("1..%d\n", num_of_suites);
 }
 
-int kunit_run_all_tests(void)
+static void kunit_exec_run_tests(struct suite_set *suite_set)
+{
+	struct kunit_suite * const * const *suites;
+
+	kunit_print_tap_header(suite_set);
+
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		__kunit_test_suites_init(*suites);
+}
+
+static void kunit_exec_list_tests(struct suite_set *suite_set)
 {
+	unsigned int i;
 	struct kunit_suite * const * const *suites;
+	struct kunit_case *test_case;
+
+	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
+	pr_info("TAP version 14\n");
+
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		for (i = 0; (*suites)[i] != NULL; i++) {
+			kunit_suite_for_each_test_case((*suites)[i], test_case) {
+				pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
+			}
+		}
+}
+
+int kunit_run_all_tests(void)
+{
 	struct suite_set suite_set = {
 		.start = __kunit_suites_start,
 		.end = __kunit_suites_end,
@@ -120,15 +240,15 @@ int kunit_run_all_tests(void)
 	if (filter_glob_param)
 		suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
 
-	kunit_print_tap_header(&suite_set);
-
-	for (suites = suite_set.start; suites < suite_set.end; suites++)
-		__kunit_test_suites_init(*suites);
+	if (!action_param)
+		kunit_exec_run_tests(&suite_set);
+	else if (strcmp(action_param, "list") == 0)
+		kunit_exec_list_tests(&suite_set);
+	else
+		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
 	if (filter_glob_param) { /* a copy was made of each array */
-		for (suites = suite_set.start; suites < suite_set.end; suites++)
-			kfree(*suites);
-		kfree(suite_set.start);
+		kunit_free_suite_set(suite_set);
 	}
 
 	kunit_handle_shutdown();
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index e14a18af573d..4ed57fd94e42 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -9,38 +9,103 @@
 #include <kunit/test.h>
 
 static void kfree_at_end(struct kunit *test, const void *to_free);
+static void free_subsuite_at_end(struct kunit *test,
+				 struct kunit_suite *const *to_free);
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
-					    const char *suite_name);
+					    const char *suite_name,
+					    struct kunit_case *test_cases);
+
+static void dummy_test(struct kunit *test) {}
+
+static struct kunit_case dummy_test_cases[] = {
+	/* .run_case is not important, just needs to be non-NULL */
+	{ .name = "test1", .run_case = dummy_test },
+	{ .name = "test2", .run_case = dummy_test },
+	{},
+};
+
+static void parse_filter_test(struct kunit *test)
+{
+	struct kunit_test_filter filter = {NULL, NULL};
+
+	kunit_parse_filter_glob(&filter, "suite");
+	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
+	KUNIT_EXPECT_FALSE(test, filter.test_glob);
+	kfree(filter.suite_glob);
+	kfree(filter.test_glob);
+
+	kunit_parse_filter_glob(&filter, "suite.test");
+	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
+	KUNIT_EXPECT_STREQ(test, filter.test_glob, "test");
+	kfree(filter.suite_glob);
+	kfree(filter.test_glob);
+}
 
 static void filter_subsuite_test(struct kunit *test)
 {
 	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
 	struct kunit_suite * const *filtered;
+	struct kunit_test_filter filter = {
+		.suite_glob = "suite2",
+		.test_glob = NULL,
+	};
 
-	subsuite[0] = alloc_fake_suite(test, "suite1");
-	subsuite[1] = alloc_fake_suite(test, "suite2");
+	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
+	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2, NULL */
-	filtered = kunit_filter_subsuite(subsuite, "suite2*");
+	filtered = kunit_filter_subsuite(subsuite, &filter);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
-	kfree_at_end(test, filtered);
+	free_subsuite_at_end(test, filtered);
 
+	/* Validate we just have suite2 */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
 	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
+	KUNIT_EXPECT_FALSE(test, filtered[1]);
+}
+
+static void filter_subsuite_test_glob_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
+	struct kunit_suite * const *filtered;
+	struct kunit_test_filter filter = {
+		.suite_glob = "suite2",
+		.test_glob = "test2",
+	};
+
+	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
+	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
+	/* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
+	filtered = kunit_filter_subsuite(subsuite, &filter);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
+	free_subsuite_at_end(test, filtered);
+
+	/* Validate we just have suite2 */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
 	KUNIT_EXPECT_FALSE(test, filtered[1]);
+
+	/* Now validate we just have test2 */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]->test_cases);
+	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->test_cases[0].name, "test2");
+	KUNIT_EXPECT_FALSE(test, filtered[0]->test_cases[1].name);
 }
 
 static void filter_subsuite_to_empty_test(struct kunit *test)
 {
 	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
 	struct kunit_suite * const *filtered;
+	struct kunit_test_filter filter = {
+		.suite_glob = "not_found",
+		.test_glob = NULL,
+	};
 
-	subsuite[0] = alloc_fake_suite(test, "suite1");
-	subsuite[1] = alloc_fake_suite(test, "suite2");
+	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
+	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
-	filtered = kunit_filter_subsuite(subsuite, "not_found");
-	kfree_at_end(test, filtered); /* just in case */
+	filtered = kunit_filter_subsuite(subsuite, &filter);
+	free_subsuite_at_end(test, filtered); /* just in case */
 
 	KUNIT_EXPECT_FALSE_MSG(test, filtered,
 			       "should be NULL to indicate no match");
@@ -52,7 +117,7 @@ static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_s
 
 	kfree_at_end(test, suite_set->start);
 	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		kfree_at_end(test, *suites);
+		free_subsuite_at_end(test, *suites);
 }
 
 static void filter_suites_test(struct kunit *test)
@@ -74,8 +139,8 @@ static void filter_suites_test(struct kunit *test)
 	struct suite_set filtered = {.start = NULL, .end = NULL};
 
 	/* Emulate two files, each having one suite */
-	subsuites[0][0] = alloc_fake_suite(test, "suite0");
-	subsuites[1][0] = alloc_fake_suite(test, "suite1");
+	subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
+	subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 
 	/* Filter out suite1 */
 	filtered = kunit_filter_suites(&suite_set, "suite0");
@@ -84,11 +149,14 @@ static void filter_suites_test(struct kunit *test)
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0][0]);
 	KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
 }
 
 static struct kunit_case executor_test_cases[] = {
+	KUNIT_CASE(parse_filter_test),
 	KUNIT_CASE(filter_subsuite_test),
+	KUNIT_CASE(filter_subsuite_test_glob_test),
 	KUNIT_CASE(filter_subsuite_to_empty_test),
 	KUNIT_CASE(filter_suites_test),
 	{}
@@ -120,14 +188,30 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 			     (void *)to_free);
 }
 
+static void free_subsuite_res_free(struct kunit_resource *res)
+{
+	kunit_free_subsuite(res->data);
+}
+
+static void free_subsuite_at_end(struct kunit *test,
+				 struct kunit_suite *const *to_free)
+{
+	if (IS_ERR_OR_NULL(to_free))
+		return;
+	kunit_alloc_resource(test, NULL, free_subsuite_res_free,
+			     GFP_KERNEL, (void *)to_free);
+}
+
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
-					    const char *suite_name)
+					    const char *suite_name,
+					    struct kunit_case *test_cases)
 {
 	struct kunit_suite *suite;
 
 	/* We normally never expect to allocate suites, hence the non-const cast. */
 	suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
 	strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
+	suite->test_cases = test_cases;
 
 	return suite;
 }
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index d69efcbed624..555601d17f79 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -415,12 +415,15 @@ static struct kunit_suite kunit_log_test_suite = {
 
 static void kunit_log_test(struct kunit *test)
 {
-	struct kunit_suite *suite = &kunit_log_test_suite;
+	struct kunit_suite suite;
+
+	suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
 
 	kunit_log(KERN_INFO, test, "put this in log.");
 	kunit_log(KERN_INFO, test, "this too.");
-	kunit_log(KERN_INFO, suite, "add to suite log.");
-	kunit_log(KERN_INFO, suite, "along with this.");
+	kunit_log(KERN_INFO, &suite, "add to suite log.");
+	kunit_log(KERN_INFO, &suite, "along with this.");
 
 #ifdef CONFIG_KUNIT_DEBUGFS
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
@@ -428,12 +431,11 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(test->log, "this too."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite->log, "add to suite log."));
+				     strstr(suite.log, "add to suite log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite->log, "along with this."));
+				     strstr(suite.log, "along with this."));
 #else
 	KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
-	KUNIT_EXPECT_PTR_EQ(test, suite->log, (char *)NULL);
 #endif
 }
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f246b847024e..3bd741e50a2d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -190,10 +190,10 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
 }
 EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
 
+static size_t kunit_suite_counter = 1;
+
 static void kunit_print_subtest_end(struct kunit_suite *suite)
 {
-	static size_t kunit_suite_counter = 1;
-
 	kunit_print_ok_not_ok((void *)suite, false,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
@@ -583,6 +583,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 
 	for (i = 0; suites[i] != NULL; i++)
 		kunit_exit_suite(suites[i]);
+
+	kunit_suite_counter = 1;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index ac35c61f65f5..68e6f461c758 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -8,17 +8,17 @@
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
 import argparse
-import sys
 import os
+import re
+import sys
 import time
 
 assert sys.version_info >= (3, 7), "Python version is too old"
 
 from collections import namedtuple
 from enum import Enum, auto
-from typing import Iterable, Sequence
+from typing import Iterable, Sequence, List
 
-import kunit_config
 import kunit_json
 import kunit_kernel
 import kunit_parser
@@ -31,13 +31,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-                              ['timeout', 'build_dir', 'alltests',
-                               'filter_glob', 'kernel_args'])
+			      ['timeout', 'build_dir', 'alltests',
+			       'filter_glob', 'kernel_args', 'run_isolated'])
 KunitParseRequest = namedtuple('KunitParseRequest',
-			       ['raw_output', 'input_data', 'build_dir', 'json'])
+			       ['raw_output', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'alltests', 'filter_glob',
-					   'kernel_args', 'json', 'make_options'])
+					   'kernel_args', 'run_isolated', 'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -91,31 +91,93 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 			   'built kernel successfully',
 			   build_end - build_start)
 
-def exec_tests(linux: kunit_kernel.LinuxSourceTree,
-	       request: KunitExecRequest) -> KunitResult:
-	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
-	test_start = time.time()
-	result = linux.run_kernel(
-		args=request.kernel_args,
-		timeout=None if request.alltests else request.timeout,
-                filter_glob=request.filter_glob,
-		build_dir=request.build_dir)
-
-	test_end = time.time()
-
-	return KunitResult(KunitStatus.SUCCESS,
-			   result,
-			   test_end - test_start)
+def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
+	args = ['kunit.action=list']
+	if request.kernel_args:
+		args.extend(request.kernel_args)
+
+	output = linux.run_kernel(args=args,
+			   timeout=None if request.alltests else request.timeout,
+			   filter_glob=request.filter_glob,
+			   build_dir=request.build_dir)
+	lines = kunit_parser.extract_tap_lines(output)
+	# Hack! Drop the dummy TAP version header that the executor prints out.
+	lines.pop()
+
+	# Filter out any extraneous non-test output that might have gotten mixed in.
+	return [l for l in lines if re.match('^[^\s.]+\.[^\s.]+$', l)]
+
+def _suites_from_test_list(tests: List[str]) -> List[str]:
+	"""Extracts all the suites from an ordered list of tests."""
+	suites = []  # type: List[str]
+	for t in tests:
+		parts = t.split('.', maxsplit=2)
+		if len(parts) != 2:
+			raise ValueError(f'internal KUnit error, test name should be of the form "<suite>.<test>", got "{t}"')
+		suite, case = parts
+		if not suites or suites[-1] != suite:
+			suites.append(suite)
+	return suites
+
+
+
+def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
+	       parse_request: KunitParseRequest) -> KunitResult:
+	filter_globs = [request.filter_glob]
+	if request.run_isolated:
+		tests = _list_tests(linux, request)
+		if request.run_isolated == 'test':
+			filter_globs = tests
+		if request.run_isolated == 'suite':
+			filter_globs = _suites_from_test_list(tests)
+			# Apply the test-part of the user's glob, if present.
+			if '.' in request.filter_glob:
+				test_glob = request.filter_glob.split('.', maxsplit=2)[1]
+				filter_globs = [g + '.'+ test_glob for g in filter_globs]
+
+	test_counts = kunit_parser.TestCounts()
+	exec_time = 0.0
+	for i, filter_glob in enumerate(filter_globs):
+		kunit_parser.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
+
+		test_start = time.time()
+		run_result = linux.run_kernel(
+			args=request.kernel_args,
+			timeout=None if request.alltests else request.timeout,
+			filter_glob=filter_glob,
+			build_dir=request.build_dir)
+
+		result = parse_tests(parse_request, run_result)
+		# run_kernel() doesn't block on the kernel exiting.
+		# That only happens after we get the last line of output from `run_result`.
+		# So exec_time here actually contains parsing + execution time, which is fine.
+		test_end = time.time()
+		exec_time += test_end - test_start
+
+		test_counts.add_subtest_counts(result.result.test.counts)
+
+	kunit_status = _map_to_overall_status(test_counts.get_status())
+	return KunitResult(status=kunit_status, result=result.result, elapsed_time=exec_time)
+
+def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
+	if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
+		return KunitStatus.SUCCESS
+	else:
+		return KunitStatus.TEST_FAILURE
 
-def parse_tests(request: KunitParseRequest) -> KunitResult:
+def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
 	parse_start = time.time()
 
 	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
-					      [],
+					      kunit_parser.Test(),
 					      'Tests not Parsed.')
 
 	if request.raw_output:
-		output: Iterable[str] = request.input_data
+		# Treat unparsed results as one passing test.
+		test_result.test.status = kunit_parser.TestStatus.SUCCESS
+		test_result.test.counts.passed = 1
+
+		output: Iterable[str] = input_data
 		if request.raw_output == 'all':
 			pass
 		elif request.raw_output == 'kunit':
@@ -126,7 +188,7 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 			print(line.rstrip())
 
 	else:
-		test_result = kunit_parser.parse_run_tests(request.input_data)
+		test_result = kunit_parser.parse_run_tests(input_data)
 	parse_end = time.time()
 
 	if request.json:
@@ -164,16 +226,12 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
 				 request.alltests, request.filter_glob,
-				 request.kernel_args)
-	exec_result = exec_tests(linux, exec_request)
-	if exec_result.status != KunitStatus.SUCCESS:
-		return exec_result
-
+				 request.kernel_args, request.run_isolated)
 	parse_request = KunitParseRequest(request.raw_output,
-					  exec_result.result,
 					  request.build_dir,
 					  request.json)
-	parse_result = parse_tests(parse_request)
+
+	exec_result = exec_tests(linux, exec_request, parse_request)
 
 	run_end = time.time()
 
@@ -184,7 +242,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 				config_result.elapsed_time,
 				build_result.elapsed_time,
 				exec_result.elapsed_time))
-	return parse_result
+	return exec_result
 
 # Problem:
 # $ kunit.py run --json
@@ -263,9 +321,8 @@ def add_exec_opts(parser) -> None:
 			    default=300,
 			    metavar='timeout')
 	parser.add_argument('filter_glob',
-			    help='maximum number of seconds to allow for all tests '
-			    'to run. This does not include time taken to build the '
-			    'tests.',
+			    help='Filter which KUnit test suites/tests run at '
+			    'boot-time, e.g. list* or list*.*del_test',
 			    type=str,
 			    nargs='?',
 			    default='',
@@ -273,6 +330,12 @@ def add_exec_opts(parser) -> None:
 	parser.add_argument('--kernel_args',
 			    help='Kernel command-line parameters. Maybe be repeated',
 			     action='append')
+	parser.add_argument('--run_isolated', help='If set, boot the kernel for each '
+			    'individual suite/test. This is can be useful for debugging '
+			    'a non-hermetic test, one that might pass/fail based on '
+			    'what ran before it.',
+			    type=str,
+			    choices=['suite', 'test']),
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
@@ -346,6 +409,7 @@ def main(argv, linux=None):
 				       cli_args.alltests,
 				       cli_args.filter_glob,
 				       cli_args.kernel_args,
+				       cli_args.run_isolated,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -401,29 +465,27 @@ def main(argv, linux=None):
 						cli_args.build_dir,
 						cli_args.alltests,
 						cli_args.filter_glob,
-						cli_args.kernel_args)
-		exec_result = exec_tests(linux, exec_request)
+						cli_args.kernel_args,
+						cli_args.run_isolated)
 		parse_request = KunitParseRequest(cli_args.raw_output,
-						  exec_result.result,
 						  cli_args.build_dir,
 						  cli_args.json)
-		result = parse_tests(parse_request)
+		result = exec_tests(linux, exec_request, parse_request)
 		kunit_parser.print_with_timestamp((
-			'Elapsed time: %.3fs\n') % (
-				exec_result.elapsed_time))
+			'Elapsed time: %.3fs\n') % (result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'parse':
 		if cli_args.file == None:
+			sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
 			kunit_output = sys.stdin
 		else:
-			with open(cli_args.file, 'r') as f:
+			with open(cli_args.file, 'r', errors='backslashreplace') as f:
 				kunit_output = f.read().splitlines()
 		request = KunitParseRequest(cli_args.raw_output,
-					    kunit_output,
 					    None,
 					    cli_args.json)
-		result = parse_tests(request)
+		result = parse_tests(request, kunit_output)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	else:
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index f5cca5c38cac..746bec72b9ac 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -11,47 +11,47 @@ import os
 
 import kunit_parser
 
-from kunit_parser import TestStatus
-
-def get_json_result(test_result, def_config, build_dir, json_path) -> str:
-	sub_groups = []
-
-	# Each test suite is mapped to a KernelCI sub_group
-	for test_suite in test_result.suites:
-		sub_group = {
-			"name": test_suite.name,
-			"arch": "UM",
-			"defconfig": def_config,
-			"build_environment": build_dir,
-			"test_cases": [],
-			"lab_name": None,
-			"kernel": None,
-			"job": None,
-			"git_branch": "kselftest",
-		}
-		test_cases = []
-		# TODO: Add attachments attribute in test_case with detailed
-		#  failure message, see https://api.kernelci.org/schema-test-case.html#get
-		for case in test_suite.cases:
-			test_case = {"name": case.name, "status": "FAIL"}
-			if case.status == TestStatus.SUCCESS:
+from kunit_parser import Test, TestResult, TestStatus
+from typing import Any, Dict, Optional
+
+JsonObj = Dict[str, Any]
+
+def _get_group_json(test: Test, def_config: str,
+		build_dir: Optional[str]) -> JsonObj:
+	sub_groups = []  # List[JsonObj]
+	test_cases = []  # List[JsonObj]
+
+	for subtest in test.subtests:
+		if len(subtest.subtests):
+			sub_group = _get_group_json(subtest, def_config,
+				build_dir)
+			sub_groups.append(sub_group)
+		else:
+			test_case = {"name": subtest.name, "status": "FAIL"}
+			if subtest.status == TestStatus.SUCCESS:
 				test_case["status"] = "PASS"
-			elif case.status == TestStatus.TEST_CRASHED:
+			elif subtest.status == TestStatus.TEST_CRASHED:
 				test_case["status"] = "ERROR"
 			test_cases.append(test_case)
-		sub_group["test_cases"] = test_cases
-		sub_groups.append(sub_group)
+
 	test_group = {
-		"name": "KUnit Test Group",
+		"name": test.name,
 		"arch": "UM",
 		"defconfig": def_config,
 		"build_environment": build_dir,
 		"sub_groups": sub_groups,
+		"test_cases": test_cases,
 		"lab_name": None,
 		"kernel": None,
 		"job": None,
 		"git_branch": "kselftest",
 	}
+	return test_group
+
+def get_json_result(test_result: TestResult, def_config: str,
+		build_dir: Optional[str], json_path: str) -> str:
+	test_group = _get_group_json(test_result.test, def_config, build_dir)
+	test_group["name"] = "KUnit Test Group"
 	json_obj = json.dumps(test_group, indent=4)
 	if json_path != 'stdout':
 		with open(json_path, 'w') as result_path:
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2c6f916ccbaf..66095568bf32 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -12,11 +12,8 @@ import subprocess
 import os
 import shutil
 import signal
-from typing import Iterator, Optional, Tuple
-
-from contextlib import ExitStack
-
-from collections import namedtuple
+import threading
+from typing import Iterator, List, Optional, Tuple
 
 import kunit_config
 import kunit_parser
@@ -103,8 +100,8 @@ class LinuxSourceTreeOperations(object):
 		if stderr:  # likely only due to build warnings
 			print(stderr.decode())
 
-	def run(self, params, timeout, build_dir, outfile) -> None:
-		pass
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
+		raise RuntimeError('not implemented!')
 
 
 class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
@@ -123,7 +120,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		kconfig.parse_from_string(self._kconfig)
 		base_kunitconfig.merge_in_entries(kconfig)
 
-	def run(self, params, timeout, build_dir, outfile):
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		kernel_path = os.path.join(build_dir, self._kernel_path)
 		qemu_command = ['qemu-system-' + self._qemu_arch,
 				'-nodefaults',
@@ -134,18 +131,11 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 				'-nographic',
 				'-serial stdio'] + self._extra_qemu_params
 		print('Running tests with:\n$', ' '.join(qemu_command))
-		with open(outfile, 'w') as output:
-			process = subprocess.Popen(' '.join(qemu_command),
-						   stdin=subprocess.PIPE,
-						   stdout=output,
-						   stderr=subprocess.STDOUT,
-						   text=True, shell=True)
-		try:
-			process.wait(timeout=timeout)
-		except Exception as e:
-			print(e)
-			process.terminate()
-		return process
+		return subprocess.Popen(' '.join(qemu_command),
+					   stdin=subprocess.PIPE,
+					   stdout=subprocess.PIPE,
+					   stderr=subprocess.STDOUT,
+					   text=True, shell=True, errors='backslashreplace')
 
 class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	"""An abstraction over command line operations performed on a source tree."""
@@ -168,24 +158,21 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 		process.wait()
 		kunit_parser.print_with_timestamp(
 			'Disabling broken configs to run KUnit tests...')
-		with ExitStack() as es:
-			config = open(get_kconfig_path(build_dir), 'a')
-			disable = open(BROKEN_ALLCONFIG_PATH, 'r').read()
-			config.write(disable)
+
+		with open(get_kconfig_path(build_dir), 'a') as config:
+			with open(BROKEN_ALLCONFIG_PATH, 'r') as disable:
+				config.write(disable.read())
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
-	def run(self, params, timeout, build_dir, outfile):
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = get_file_path(build_dir, 'linux')
-		outfile = get_outfile_path(build_dir)
-		with open(outfile, 'w') as output:
-			process = subprocess.Popen([linux_bin] + params,
-						   stdin=subprocess.PIPE,
-						   stdout=output,
-						   stderr=subprocess.STDOUT,
-						   text=True)
-			process.wait(timeout)
+		return subprocess.Popen([linux_bin] + params,
+					   stdin=subprocess.PIPE,
+					   stdout=subprocess.PIPE,
+					   stderr=subprocess.STDOUT,
+					   text=True, errors='backslashreplace')
 
 def get_kconfig_path(build_dir) -> str:
 	return get_file_path(build_dir, KCONFIG_PATH)
@@ -202,8 +189,9 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
 		return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
 	elif os.path.isfile(config_path):
 		return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
-	else:
-		raise ConfigError(arch + ' is not a valid arch')
+
+	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
+	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
 def get_source_tree_ops_from_qemu_config(config_path: str,
 					 cross_compile: Optional[str]) -> Tuple[
@@ -219,12 +207,15 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
 	module_path = '.' + os.path.join(os.path.basename(QEMU_CONFIGS_DIR), os.path.basename(config_path))
 	spec = importlib.util.spec_from_file_location(module_path, config_path)
 	config = importlib.util.module_from_spec(spec)
-	# TODO(brendanhiggins@google.com): I looked this up and apparently other
-	# Python projects have noted that pytype complains that "No attribute
-	# 'exec_module' on _importlib_modulespec._Loader". Disabling for now.
-	spec.loader.exec_module(config) # pytype: disable=attribute-error
-	return config.QEMU_ARCH.linux_arch, LinuxSourceTreeOperationsQemu(
-			config.QEMU_ARCH, cross_compile=cross_compile)
+	# See https://github.com/python/typeshed/pull/2626 for context.
+	assert isinstance(spec.loader, importlib.abc.Loader)
+	spec.loader.exec_module(config)
+
+	if not hasattr(config, 'QEMU_ARCH'):
+		raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
+	params: qemu_config.QemuArchParams = config.QEMU_ARCH  # type: ignore
+	return params.linux_arch, LinuxSourceTreeOperationsQemu(
+			params, cross_compile=cross_compile)
 
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
@@ -330,12 +321,36 @@ class LinuxSourceTree(object):
 		args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
-		outfile = get_outfile_path(build_dir)
-		self._ops.run(args, timeout, build_dir, outfile)
-		subprocess.call(['stty', 'sane'])
-		with open(outfile, 'r') as file:
-			for line in file:
+
+		process = self._ops.start(args, build_dir)
+		assert process.stdout is not None  # tell mypy it's set
+
+		# Enforce the timeout in a background thread.
+		def _wait_proc():
+			try:
+				process.wait(timeout=timeout)
+			except Exception as e:
+				print(e)
+				process.terminate()
+				process.wait()
+		waiter = threading.Thread(target=_wait_proc)
+		waiter.start()
+
+		output = open(get_outfile_path(build_dir), 'w')
+		try:
+			# Tee the output to the file and to our caller in real time.
+			for line in process.stdout:
+				output.write(line)
 				yield line
+		# This runs even if our caller doesn't consume every line.
+		finally:
+			# Flush any leftover output to the file
+			output.write(process.stdout.read())
+			output.close()
+			process.stdout.close()
+
+			waiter.join()
+			subprocess.call(['stty', 'sane'])
 
 	def signal_handler(self, sig, frame) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 6310a641b151..3355196d0515 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -1,11 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Parses test results from a kernel dmesg log.
+# Parses KTAP test results from a kernel dmesg log and incrementally prints
+# results with reader-friendly format. Stores and returns test results in a
+# Test object.
 #
 # Copyright (C) 2019, Google LLC.
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
+# Author: Rae Moar <rmoar@google.com>
 
+from __future__ import annotations
 import re
 
 from collections import namedtuple
@@ -14,33 +18,52 @@ from enum import Enum, auto
 from functools import reduce
 from typing import Iterable, Iterator, List, Optional, Tuple
 
-TestResult = namedtuple('TestResult', ['status','suites','log'])
-
-class TestSuite(object):
+TestResult = namedtuple('TestResult', ['status','test','log'])
+
+class Test(object):
+	"""
+	A class to represent a test parsed from KTAP results. All KTAP
+	results within a test log are stored in a main Test object as
+	subtests.
+
+	Attributes:
+	status : TestStatus - status of the test
+	name : str - name of the test
+	expected_count : int - expected number of subtests (0 if single
+		test case and None if unknown expected number of subtests)
+	subtests : List[Test] - list of subtests
+	log : List[str] - log of KTAP lines that correspond to the test
+	counts : TestCounts - counts of the test statuses and errors of
+		subtests or of the test itself if the test is a single
+		test case.
+	"""
 	def __init__(self) -> None:
-		self.status = TestStatus.SUCCESS
-		self.name = ''
-		self.cases = []  # type: List[TestCase]
-
-	def __str__(self) -> str:
-		return 'TestSuite(' + str(self.status) + ',' + self.name + ',' + str(self.cases) + ')'
-
-	def __repr__(self) -> str:
-		return str(self)
-
-class TestCase(object):
-	def __init__(self) -> None:
-		self.status = TestStatus.SUCCESS
+		"""Creates Test object with default attributes."""
+		self.status = TestStatus.TEST_CRASHED
 		self.name = ''
+		self.expected_count = 0  # type: Optional[int]
+		self.subtests = []  # type: List[Test]
 		self.log = []  # type: List[str]
+		self.counts = TestCounts()
 
 	def __str__(self) -> str:
-		return 'TestCase(' + str(self.status) + ',' + self.name + ',' + str(self.log) + ')'
+		"""Returns string representation of a Test class object."""
+		return ('Test(' + str(self.status) + ', ' + self.name +
+			', ' + str(self.expected_count) + ', ' +
+			str(self.subtests) + ', ' + str(self.log) + ', ' +
+			str(self.counts) + ')')
 
 	def __repr__(self) -> str:
+		"""Returns string representation of a Test class object."""
 		return str(self)
 
+	def add_error(self, error_message: str) -> None:
+		"""Records an error that occurred while parsing this test."""
+		self.counts.errors += 1
+		print_error('Test ' + self.name + ': ' + error_message)
+
 class TestStatus(Enum):
+	"""An enumeration class to represent the status of a test."""
 	SUCCESS = auto()
 	FAILURE = auto()
 	SKIPPED = auto()
@@ -48,381 +71,747 @@ class TestStatus(Enum):
 	NO_TESTS = auto()
 	FAILURE_TO_PARSE_TESTS = auto()
 
+class TestCounts:
+	"""
+	Tracks the counts of statuses of all test cases and any errors within
+	a Test.
+
+	Attributes:
+	passed : int - the number of tests that have passed
+	failed : int - the number of tests that have failed
+	crashed : int - the number of tests that have crashed
+	skipped : int - the number of tests that have skipped
+	errors : int - the number of errors in the test and subtests
+	"""
+	def __init__(self):
+		"""Creates TestCounts object with counts of all test
+		statuses and test errors set to 0.
+		"""
+		self.passed = 0
+		self.failed = 0
+		self.crashed = 0
+		self.skipped = 0
+		self.errors = 0
+
+	def __str__(self) -> str:
+		"""Returns the string representation of a TestCounts object.
+		"""
+		return ('Passed: ' + str(self.passed) +
+			', Failed: ' + str(self.failed) +
+			', Crashed: ' + str(self.crashed) +
+			', Skipped: ' + str(self.skipped) +
+			', Errors: ' + str(self.errors))
+
+	def total(self) -> int:
+		"""Returns the total number of test cases within a test
+		object, where a test case is a test with no subtests.
+		"""
+		return (self.passed + self.failed + self.crashed +
+			self.skipped)
+
+	def add_subtest_counts(self, counts: TestCounts) -> None:
+		"""
+		Adds the counts of another TestCounts object to the current
+		TestCounts object. Used to add the counts of a subtest to the
+		parent test.
+
+		Parameters:
+		counts - a different TestCounts object whose counts
+			will be added to the counts of the TestCounts object
+		"""
+		self.passed += counts.passed
+		self.failed += counts.failed
+		self.crashed += counts.crashed
+		self.skipped += counts.skipped
+		self.errors += counts.errors
+
+	def get_status(self) -> TestStatus:
+		"""Returns the aggregated status of a Test using test
+		counts.
+		"""
+		if self.total() == 0:
+			return TestStatus.NO_TESTS
+		elif self.crashed:
+			# If one of the subtests crash, the expected status
+			# of the Test is crashed.
+			return TestStatus.TEST_CRASHED
+		elif self.failed:
+			# Otherwise if one of the subtests fail, the
+			# expected status of the Test is failed.
+			return TestStatus.FAILURE
+		elif self.passed:
+			# Otherwise if one of the subtests pass, the
+			# expected status of the Test is passed.
+			return TestStatus.SUCCESS
+		else:
+			# Finally, if none of the subtests have failed,
+			# crashed, or passed, the expected status of the
+			# Test is skipped.
+			return TestStatus.SKIPPED
+
+	def add_status(self, status: TestStatus) -> None:
+		"""
+		Increments count of inputted status.
+
+		Parameters:
+		status - status to be added to the TestCounts object
+		"""
+		if status == TestStatus.SUCCESS:
+			self.passed += 1
+		elif status == TestStatus.FAILURE:
+			self.failed += 1
+		elif status == TestStatus.SKIPPED:
+			self.skipped += 1
+		elif status != TestStatus.NO_TESTS:
+			self.crashed += 1
+
 class LineStream:
-	"""Provides a peek()/pop() interface over an iterator of (line#, text)."""
+	"""
+	A class to represent the lines of kernel output.
+	Provides a peek()/pop() interface over an iterator of
+	(line#, text).
+	"""
 	_lines: Iterator[Tuple[int, str]]
 	_next: Tuple[int, str]
 	_done: bool
 
 	def __init__(self, lines: Iterator[Tuple[int, str]]):
+		"""Creates a new LineStream that wraps the given iterator."""
 		self._lines = lines
 		self._done = False
 		self._next = (0, '')
 		self._get_next()
 
 	def _get_next(self) -> None:
+		"""Advances the LineSteam to the next line."""
 		try:
 			self._next = next(self._lines)
 		except StopIteration:
 			self._done = True
 
 	def peek(self) -> str:
+		"""Returns the current line, without advancing the LineStream.
+		"""
 		return self._next[1]
 
 	def pop(self) -> str:
+		"""Returns the current line and advances the LineStream to
+		the next line.
+		"""
 		n = self._next
 		self._get_next()
 		return n[1]
 
 	def __bool__(self) -> bool:
+		"""Returns True if stream has more lines."""
 		return not self._done
 
 	# Only used by kunit_tool_test.py.
 	def __iter__(self) -> Iterator[str]:
+		"""Empties all lines stored in LineStream object into
+		Iterator object and returns the Iterator object.
+		"""
 		while bool(self):
 			yield self.pop()
 
 	def line_number(self) -> int:
+		"""Returns the line number of the current line."""
 		return self._next[0]
 
-kunit_start_re = re.compile(r'TAP version [0-9]+$')
-kunit_end_re = re.compile('(List of all partitions:|'
-			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
+# Parsing helper methods:
+
+KTAP_START = re.compile(r'KTAP version ([0-9]+)$')
+TAP_START = re.compile(r'TAP version ([0-9]+)$')
+KTAP_END = re.compile('(List of all partitions:|'
+	'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
 def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
-	def isolate_kunit_output(kernel_output: Iterable[str]) -> Iterator[Tuple[int, str]]:
+	"""Extracts KTAP lines from the kernel output."""
+	def isolate_ktap_output(kernel_output: Iterable[str]) \
+			-> Iterator[Tuple[int, str]]:
 		line_num = 0
 		started = False
 		for line in kernel_output:
 			line_num += 1
-			line = line.rstrip()  # line always has a trailing \n
-			if kunit_start_re.search(line):
+			line = line.rstrip()  # remove trailing \n
+			if not started and KTAP_START.search(line):
+				# start extracting KTAP lines and set prefix
+				# to number of characters before version line
+				prefix_len = len(
+					line.split('KTAP version')[0])
+				started = True
+				yield line_num, line[prefix_len:]
+			elif not started and TAP_START.search(line):
+				# start extracting KTAP lines and set prefix
+				# to number of characters before version line
 				prefix_len = len(line.split('TAP version')[0])
 				started = True
 				yield line_num, line[prefix_len:]
-			elif kunit_end_re.search(line):
+			elif started and KTAP_END.search(line):
+				# stop extracting KTAP lines
 				break
 			elif started:
-				yield line_num, line[prefix_len:]
-	return LineStream(lines=isolate_kunit_output(kernel_output))
-
-DIVIDER = '=' * 60
-
-RESET = '\033[0;0m'
-
-def red(text) -> str:
-	return '\033[1;31m' + text + RESET
-
-def yellow(text) -> str:
-	return '\033[1;33m' + text + RESET
-
-def green(text) -> str:
-	return '\033[1;32m' + text + RESET
-
-def print_with_timestamp(message) -> None:
-	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
-
-def format_suite_divider(message) -> str:
-	return '======== ' + message + ' ========'
+				# remove prefix and any indention and yield
+				# line with line number
+				line = line[prefix_len:].lstrip()
+				yield line_num, line
+	return LineStream(lines=isolate_ktap_output(kernel_output))
+
+KTAP_VERSIONS = [1]
+TAP_VERSIONS = [13, 14]
+
+def check_version(version_num: int, accepted_versions: List[int],
+			version_type: str, test: Test) -> None:
+	"""
+	Adds error to test object if version number is too high or too
+	low.
+
+	Parameters:
+	version_num - The inputted version number from the parsed KTAP or TAP
+		header line
+	accepted_version - List of accepted KTAP or TAP versions
+	version_type - 'KTAP' or 'TAP' depending on the type of
+		version line.
+	test - Test object for current test being parsed
+	"""
+	if version_num < min(accepted_versions):
+		test.add_error(version_type +
+			' version lower than expected!')
+	elif version_num > max(accepted_versions):
+		test.add_error(
+			version_type + ' version higher than expected!')
+
+def parse_ktap_header(lines: LineStream, test: Test) -> bool:
+	"""
+	Parses KTAP/TAP header line and checks version number.
+	Returns False if fails to parse KTAP/TAP header line.
+
+	Accepted formats:
+	- 'KTAP version [version number]'
+	- 'TAP version [version number]'
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
+
+	Return:
+	True if successfully parsed KTAP/TAP header line
+	"""
+	ktap_match = KTAP_START.match(lines.peek())
+	tap_match = TAP_START.match(lines.peek())
+	if ktap_match:
+		version_num = int(ktap_match.group(1))
+		check_version(version_num, KTAP_VERSIONS, 'KTAP', test)
+	elif tap_match:
+		version_num = int(tap_match.group(1))
+		check_version(version_num, TAP_VERSIONS, 'TAP', test)
+	else:
+		return False
+	test.log.append(lines.pop())
+	return True
 
-def print_suite_divider(message) -> None:
-	print_with_timestamp(DIVIDER)
-	print_with_timestamp(format_suite_divider(message))
+TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
 
-def print_log(log) -> None:
-	for m in log:
-		print_with_timestamp(m)
+def parse_test_header(lines: LineStream, test: Test) -> bool:
+	"""
+	Parses test header and stores test name in test object.
+	Returns False if fails to parse test header line.
 
-TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*# (Subtest:|.*: kunit test case crashed!)).*$')
+	Accepted format:
+	- '# Subtest: [test name]'
 
-def consume_non_diagnostic(lines: LineStream) -> None:
-	while lines and not TAP_ENTRIES.match(lines.peek()):
-		lines.pop()
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
 
-def save_non_diagnostic(lines: LineStream, test_case: TestCase) -> None:
-	while lines and not TAP_ENTRIES.match(lines.peek()):
-		test_case.log.append(lines.peek())
-		lines.pop()
+	Return:
+	True if successfully parsed test header line
+	"""
+	match = TEST_HEADER.match(lines.peek())
+	if not match:
+		return False
+	test.log.append(lines.pop())
+	test.name = match.group(1)
+	return True
 
-OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
+TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
 
-OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
+def parse_test_plan(lines: LineStream, test: Test) -> bool:
+	"""
+	Parses test plan line and stores the expected number of subtests in
+	test object. Reports an error if expected count is 0.
+	Returns False and reports missing test plan error if fails to parse
+	test plan.
 
-OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
+	Accepted format:
+	- '1..[number of subtests]'
 
-OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
 
-def parse_ok_not_ok_test_case(lines: LineStream, test_case: TestCase) -> bool:
-	save_non_diagnostic(lines, test_case)
-	if not lines:
-		test_case.status = TestStatus.TEST_CRASHED
-		return True
-	line = lines.peek()
-	match = OK_NOT_OK_SUBTEST.match(line)
-	while not match and lines:
-		line = lines.pop()
-		match = OK_NOT_OK_SUBTEST.match(line)
-	if match:
-		test_case.log.append(lines.pop())
-		test_case.name = match.group(2)
-		skip_match = OK_NOT_OK_SKIP.match(line)
-		if skip_match:
-			test_case.status = TestStatus.SKIPPED
-			return True
-		if test_case.status == TestStatus.TEST_CRASHED:
-			return True
-		if match.group(1) == 'ok':
-			test_case.status = TestStatus.SUCCESS
-		else:
-			test_case.status = TestStatus.FAILURE
-		return True
-	else:
+	Return:
+	True if successfully parsed test plan line
+	"""
+	match = TEST_PLAN.match(lines.peek())
+	if not match:
+		test.expected_count = None
+		test.add_error('missing plan line!')
 		return False
-
-SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
-DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
-
-def parse_diagnostic(lines: LineStream, test_case: TestCase) -> bool:
-	save_non_diagnostic(lines, test_case)
-	if not lines:
+	test.log.append(lines.pop())
+	expected_count = int(match.group(1))
+	test.expected_count = expected_count
+	if expected_count == 0:
+		test.status = TestStatus.NO_TESTS
+		test.add_error('0 tests run!')
+	return True
+
+TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
+
+TEST_RESULT_SKIP = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
+
+def peek_test_name_match(lines: LineStream, test: Test) -> bool:
+	"""
+	Matches current line with the format of a test result line and checks
+	if the name matches the name of the current test.
+	Returns False if fails to match format or name.
+
+	Accepted format:
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
+
+	Return:
+	True if matched a test result line and the name matching the
+		expected test name
+	"""
+	line = lines.peek()
+	match = TEST_RESULT.match(line)
+	if not match:
 		return False
+	name = match.group(4)
+	return (name == test.name)
+
+def parse_test_result(lines: LineStream, test: Test,
+			expected_num: int) -> bool:
+	"""
+	Parses test result line and stores the status and name in the test
+	object. Reports an error if the test number does not match expected
+	test number.
+	Returns False if fails to parse test result line.
+
+	Note that the SKIP directive is the only direction that causes a
+	change in status.
+
+	Accepted format:
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
+	expected_num - expected test number for current test
+
+	Return:
+	True if successfully parsed a test result line.
+	"""
 	line = lines.peek()
-	match = SUBTEST_DIAGNOSTIC.match(line)
-	if match:
-		test_case.log.append(lines.pop())
-		crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
-		if crash_match:
-			test_case.status = TestStatus.TEST_CRASHED
-		return True
-	else:
+	match = TEST_RESULT.match(line)
+	skip_match = TEST_RESULT_SKIP.match(line)
+
+	# Check if line matches test result line format
+	if not match:
 		return False
+	test.log.append(lines.pop())
 
-def parse_test_case(lines: LineStream) -> Optional[TestCase]:
-	test_case = TestCase()
-	save_non_diagnostic(lines, test_case)
-	while parse_diagnostic(lines, test_case):
-		pass
-	if parse_ok_not_ok_test_case(lines, test_case):
-		return test_case
+	# Set name of test object
+	if skip_match:
+		test.name = skip_match.group(4)
 	else:
-		return None
-
-SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
-
-def parse_subtest_header(lines: LineStream) -> Optional[str]:
-	consume_non_diagnostic(lines)
-	if not lines:
-		return None
-	match = SUBTEST_HEADER.match(lines.peek())
-	if match:
-		lines.pop()
-		return match.group(1)
+		test.name = match.group(4)
+
+	# Check test num
+	num = int(match.group(2))
+	if num != expected_num:
+		test.add_error('Expected test number ' +
+			str(expected_num) + ' but found ' + str(num))
+
+	# Set status of test object
+	status = match.group(1)
+	if skip_match:
+		test.status = TestStatus.SKIPPED
+	elif status == 'ok':
+		test.status = TestStatus.SUCCESS
 	else:
-		return None
+		test.status = TestStatus.FAILURE
+	return True
+
+def parse_diagnostic(lines: LineStream) -> List[str]:
+	"""
+	Parse lines that do not match the format of a test result line or
+	test header line and returns them in list.
+
+	Line formats that are not parsed:
+	- '# Subtest: [test name]'
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+
+	Return:
+	Log of diagnostic lines
+	"""
+	log = []  # type: List[str]
+	while lines and not TEST_RESULT.match(lines.peek()) and not \
+			TEST_HEADER.match(lines.peek()):
+		log.append(lines.pop())
+	return log
+
+DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^# .*?: kunit test case crashed!$')
+
+def parse_crash_in_log(test: Test) -> bool:
+	"""
+	Iterate through the lines of the log to parse for crash message.
+	If crash message found, set status to crashed and return True.
+	Otherwise return False.
+
+	Parameters:
+	test - Test object for current test being parsed
+
+	Return:
+	True if crash message found in log
+	"""
+	for line in test.log:
+		if DIAGNOSTIC_CRASH_MESSAGE.match(line):
+			test.status = TestStatus.TEST_CRASHED
+			return True
+	return False
 
-SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
-def parse_subtest_plan(lines: LineStream) -> Optional[int]:
-	consume_non_diagnostic(lines)
-	match = SUBTEST_PLAN.match(lines.peek())
-	if match:
-		lines.pop()
-		return int(match.group(1))
-	else:
-		return None
-
-def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
-	if left == right:
-		return left
-	elif left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
-		return TestStatus.TEST_CRASHED
-	elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
-		return TestStatus.FAILURE
-	elif left == TestStatus.SKIPPED:
-		return right
-	else:
-		return left
+# Printing helper methods:
 
-def parse_ok_not_ok_test_suite(lines: LineStream,
-			       test_suite: TestSuite,
-			       expected_suite_index: int) -> bool:
-	consume_non_diagnostic(lines)
-	if not lines:
-		test_suite.status = TestStatus.TEST_CRASHED
-		return False
-	line = lines.peek()
-	match = OK_NOT_OK_MODULE.match(line)
-	if match:
-		lines.pop()
-		if match.group(1) == 'ok':
-			test_suite.status = TestStatus.SUCCESS
-		else:
-			test_suite.status = TestStatus.FAILURE
-		skip_match = OK_NOT_OK_SKIP.match(line)
-		if skip_match:
-			test_suite.status = TestStatus.SKIPPED
-		suite_index = int(match.group(2))
-		if suite_index != expected_suite_index:
-			print_with_timestamp(
-				red('[ERROR] ') + 'expected_suite_index ' +
-				str(expected_suite_index) + ', but got ' +
-				str(suite_index))
-		return True
-	else:
-		return False
+DIVIDER = '=' * 60
 
-def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
-	return reduce(max_status, status_list, TestStatus.SKIPPED)
+RESET = '\033[0;0m'
 
-def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
-	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
-	return max_status(max_test_case_status, test_suite.status)
+def red(text: str) -> str:
+	"""Returns inputted string with red color code."""
+	return '\033[1;31m' + text + RESET
 
-def parse_test_suite(lines: LineStream, expected_suite_index: int) -> Optional[TestSuite]:
-	if not lines:
-		return None
-	consume_non_diagnostic(lines)
-	test_suite = TestSuite()
-	test_suite.status = TestStatus.SUCCESS
-	name = parse_subtest_header(lines)
-	if not name:
-		return None
-	test_suite.name = name
-	expected_test_case_num = parse_subtest_plan(lines)
-	if expected_test_case_num is None:
-		return None
-	while expected_test_case_num > 0:
-		test_case = parse_test_case(lines)
-		if not test_case:
-			break
-		test_suite.cases.append(test_case)
-		expected_test_case_num -= 1
-	if parse_ok_not_ok_test_suite(lines, test_suite, expected_suite_index):
-		test_suite.status = bubble_up_test_case_errors(test_suite)
-		return test_suite
-	elif not lines:
-		print_with_timestamp(red('[ERROR] ') + 'ran out of lines before end token')
-		return test_suite
-	else:
-		print(f'failed to parse end of suite "{name}", at line {lines.line_number()}: {lines.peek()}')
-		return None
+def yellow(text: str) -> str:
+	"""Returns inputted string with yellow color code."""
+	return '\033[1;33m' + text + RESET
 
-TAP_HEADER = re.compile(r'^TAP version 14$')
+def green(text: str) -> str:
+	"""Returns inputted string with green color code."""
+	return '\033[1;32m' + text + RESET
 
-def parse_tap_header(lines: LineStream) -> bool:
-	consume_non_diagnostic(lines)
-	if TAP_HEADER.match(lines.peek()):
-		lines.pop()
-		return True
-	else:
-		return False
+ANSI_LEN = len(red(''))
 
-TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
+def print_with_timestamp(message: str) -> None:
+	"""Prints message with timestamp at beginning."""
+	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
 
-def parse_test_plan(lines: LineStream) -> Optional[int]:
-	consume_non_diagnostic(lines)
-	match = TEST_PLAN.match(lines.peek())
-	if match:
-		lines.pop()
-		return int(match.group(1))
-	else:
-		return None
-
-def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
-	return bubble_up_errors(x.status for x in test_suites)
-
-def parse_test_result(lines: LineStream) -> TestResult:
-	consume_non_diagnostic(lines)
-	if not lines or not parse_tap_header(lines):
-		return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
-	expected_test_suite_num = parse_test_plan(lines)
-	if expected_test_suite_num == 0:
-		return TestResult(TestStatus.NO_TESTS, [], lines)
-	elif expected_test_suite_num is None:
-		return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
-	test_suites = []
-	for i in range(1, expected_test_suite_num + 1):
-		test_suite = parse_test_suite(lines, i)
-		if test_suite:
-			test_suites.append(test_suite)
+def format_test_divider(message: str, len_message: int) -> str:
+	"""
+	Returns string with message centered in fixed width divider.
+
+	Example:
+	'===================== message example ====================='
+
+	Parameters:
+	message - message to be centered in divider line
+	len_message - length of the message to be printed such that
+		any characters of the color codes are not counted
+
+	Return:
+	String containing message centered in fixed width divider
+	"""
+	default_count = 3  # default number of dashes
+	len_1 = default_count
+	len_2 = default_count
+	difference = len(DIVIDER) - len_message - 2  # 2 spaces added
+	if difference > 0:
+		# calculate number of dashes for each side of the divider
+		len_1 = int(difference / 2)
+		len_2 = difference - len_1
+	return ('=' * len_1) + ' ' + message + ' ' + ('=' * len_2)
+
+def print_test_header(test: Test) -> None:
+	"""
+	Prints test header with test name and optionally the expected number
+	of subtests.
+
+	Example:
+	'=================== example (2 subtests) ==================='
+
+	Parameters:
+	test - Test object representing current test being printed
+	"""
+	message = test.name
+	if test.expected_count:
+		if test.expected_count == 1:
+			message += (' (' + str(test.expected_count) +
+				' subtest)')
 		else:
-			print_with_timestamp(
-				red('[ERROR] ') + ' expected ' +
-				str(expected_test_suite_num) +
-				' test suites, but got ' + str(i - 2))
-			break
-	test_suite = parse_test_suite(lines, -1)
-	if test_suite:
-		print_with_timestamp(red('[ERROR] ') +
-			'got unexpected test suite: ' + test_suite.name)
-	if test_suites:
-		return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
-	else:
-		return TestResult(TestStatus.NO_TESTS, [], lines)
+			message += (' (' + str(test.expected_count) +
+				' subtests)')
+	print_with_timestamp(format_test_divider(message, len(message)))
 
-class TestCounts:
-	passed: int
-	failed: int
-	crashed: int
-	skipped: int
+def print_log(log: Iterable[str]) -> None:
+	"""
+	Prints all strings in saved log for test in yellow.
 
-	def __init__(self):
-		self.passed = 0
-		self.failed = 0
-		self.crashed = 0
-		self.skipped = 0
-
-	def total(self) -> int:
-		return self.passed + self.failed + self.crashed + self.skipped
-
-def print_and_count_results(test_result: TestResult) -> TestCounts:
-	counts = TestCounts()
-	for test_suite in test_result.suites:
-		if test_suite.status == TestStatus.SUCCESS:
-			print_suite_divider(green('[PASSED] ') + test_suite.name)
-		elif test_suite.status == TestStatus.SKIPPED:
-			print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
-		elif test_suite.status == TestStatus.TEST_CRASHED:
-			print_suite_divider(red('[CRASHED] ' + test_suite.name))
-		else:
-			print_suite_divider(red('[FAILED] ') + test_suite.name)
-		for test_case in test_suite.cases:
-			if test_case.status == TestStatus.SUCCESS:
-				counts.passed += 1
-				print_with_timestamp(green('[PASSED] ') + test_case.name)
-			elif test_case.status == TestStatus.SKIPPED:
-				counts.skipped += 1
-				print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
-			elif test_case.status == TestStatus.TEST_CRASHED:
-				counts.crashed += 1
-				print_with_timestamp(red('[CRASHED] ' + test_case.name))
-				print_log(map(yellow, test_case.log))
-				print_with_timestamp('')
+	Parameters:
+	log - Iterable object with all strings saved in log for test
+	"""
+	for m in log:
+		print_with_timestamp(yellow(m))
+
+def format_test_result(test: Test) -> str:
+	"""
+	Returns string with formatted test result with colored status and test
+	name.
+
+	Example:
+	'[PASSED] example'
+
+	Parameters:
+	test - Test object representing current test being printed
+
+	Return:
+	String containing formatted test result
+	"""
+	if test.status == TestStatus.SUCCESS:
+		return (green('[PASSED] ') + test.name)
+	elif test.status == TestStatus.SKIPPED:
+		return (yellow('[SKIPPED] ') + test.name)
+	elif test.status == TestStatus.TEST_CRASHED:
+		print_log(test.log)
+		return (red('[CRASHED] ') + test.name)
+	else:
+		print_log(test.log)
+		return (red('[FAILED] ') + test.name)
+
+def print_test_result(test: Test) -> None:
+	"""
+	Prints result line with status of test.
+
+	Example:
+	'[PASSED] example'
+
+	Parameters:
+	test - Test object representing current test being printed
+	"""
+	print_with_timestamp(format_test_result(test))
+
+def print_test_footer(test: Test) -> None:
+	"""
+	Prints test footer with status of test.
+
+	Example:
+	'===================== [PASSED] example ====================='
+
+	Parameters:
+	test - Test object representing current test being printed
+	"""
+	message = format_test_result(test)
+	print_with_timestamp(format_test_divider(message,
+		len(message) - ANSI_LEN))
+
+def print_summary_line(test: Test) -> None:
+	"""
+	Prints summary line of test object. Color of line is dependent on
+	status of test. Color is green if test passes, yellow if test is
+	skipped, and red if the test fails or crashes. Summary line contains
+	counts of the statuses of the tests subtests or the test itself if it
+	has no subtests.
+
+	Example:
+	"Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0,
+	Errors: 0"
+
+	test - Test object representing current test being printed
+	"""
+	if test.status == TestStatus.SUCCESS:
+		color = green
+	elif test.status == TestStatus.SKIPPED or test.status == TestStatus.NO_TESTS:
+		color = yellow
+	else:
+		color = red
+	counts = test.counts
+	print_with_timestamp(color('Testing complete. ' + str(counts)))
+
+def print_error(error_message: str) -> None:
+	"""
+	Prints error message with error format.
+
+	Example:
+	"[ERROR] Test example: missing test plan!"
+
+	Parameters:
+	error_message - message describing error
+	"""
+	print_with_timestamp(red('[ERROR] ') + error_message)
+
+# Other methods:
+
+def bubble_up_test_results(test: Test) -> None:
+	"""
+	If the test has subtests, add the test counts of the subtests to the
+	test and check if any of the tests crashed and if so set the test
+	status to crashed. Otherwise if the test has no subtests add the
+	status of the test to the test counts.
+
+	Parameters:
+	test - Test object for current test being parsed
+	"""
+	parse_crash_in_log(test)
+	subtests = test.subtests
+	counts = test.counts
+	status = test.status
+	for t in subtests:
+		counts.add_subtest_counts(t.counts)
+	if counts.total() == 0:
+		counts.add_status(status)
+	elif test.counts.get_status() == TestStatus.TEST_CRASHED:
+		test.status = TestStatus.TEST_CRASHED
+
+def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
+	"""
+	Finds next test to parse in LineStream, creates new Test object,
+	parses any subtests of the test, populates Test object with all
+	information (status, name) about the test and the Test objects for
+	any subtests, and then returns the Test object. The method accepts
+	three formats of tests:
+
+	Accepted test formats:
+
+	- Main KTAP/TAP header
+
+	Example:
+
+	KTAP version 1
+	1..4
+	[subtests]
+
+	- Subtest header line
+
+	Example:
+
+	# Subtest: name
+	1..3
+	[subtests]
+	ok 1 name
+
+	- Test result line
+
+	Example:
+
+	ok 1 - test
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	expected_num - expected test number for test to be parsed
+	log - list of strings containing any preceding diagnostic lines
+		corresponding to the current test
+
+	Return:
+	Test object populated with characteristics and any subtests
+	"""
+	test = Test()
+	test.log.extend(log)
+	parent_test = False
+	main = parse_ktap_header(lines, test)
+	if main:
+		# If KTAP/TAP header is found, attempt to parse
+		# test plan
+		test.name = "main"
+		parse_test_plan(lines, test)
+	else:
+		# If KTAP/TAP header is not found, test must be subtest
+		# header or test result line so parse attempt to parser
+		# subtest header
+		parent_test = parse_test_header(lines, test)
+		if parent_test:
+			# If subtest header is found, attempt to parse
+			# test plan and print header
+			parse_test_plan(lines, test)
+			print_test_header(test)
+	expected_count = test.expected_count
+	subtests = []
+	test_num = 1
+	while expected_count is None or test_num <= expected_count:
+		# Loop to parse any subtests.
+		# Break after parsing expected number of tests or
+		# if expected number of tests is unknown break when test
+		# result line with matching name to subtest header is found
+		# or no more lines in stream.
+		sub_log = parse_diagnostic(lines)
+		sub_test = Test()
+		if not lines or (peek_test_name_match(lines, test) and
+				not main):
+			if expected_count and test_num <= expected_count:
+				# If parser reaches end of test before
+				# parsing expected number of subtests, print
+				# crashed subtest and record error
+				test.add_error('missing expected subtest!')
+				sub_test.log.extend(sub_log)
+				test.counts.add_status(
+					TestStatus.TEST_CRASHED)
+				print_test_result(sub_test)
 			else:
-				counts.failed += 1
-				print_with_timestamp(red('[FAILED] ') + test_case.name)
-				print_log(map(yellow, test_case.log))
-				print_with_timestamp('')
-	return counts
+				test.log.extend(sub_log)
+				break
+		else:
+			sub_test = parse_test(lines, test_num, sub_log)
+		subtests.append(sub_test)
+		test_num += 1
+	test.subtests = subtests
+	if not main:
+		# If not main test, look for test result line
+		test.log.extend(parse_diagnostic(lines))
+		if (parent_test and peek_test_name_match(lines, test)) or \
+				not parent_test:
+			parse_test_result(lines, test, expected_num)
+		else:
+			test.add_error('missing subtest result line!')
+	# Add statuses to TestCounts attribute in Test object
+	bubble_up_test_results(test)
+	if parent_test:
+		# If test has subtests and is not the main test object, print
+		# footer.
+		print_test_footer(test)
+	elif not main:
+		print_test_result(test)
+	return test
 
 def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
-	counts = TestCounts()
+	"""
+	Using kernel output, extract KTAP lines, parse the lines for test
+	results and print condensed test results and summary line .
+
+	Parameters:
+	kernel_output - Iterable object contains lines of kernel output
+
+	Return:
+	TestResult - Tuple containg status of main test object, main test
+		object with all subtests, and log of all KTAP lines.
+	"""
+	print_with_timestamp(DIVIDER)
 	lines = extract_tap_lines(kernel_output)
-	test_result = parse_test_result(lines)
-	if test_result.status == TestStatus.NO_TESTS:
-		print(red('[ERROR] ') + yellow('no tests run!'))
-	elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
-		print(red('[ERROR] ') + yellow('could not parse test results!'))
+	test = Test()
+	if not lines:
+		test.add_error('invalid KTAP input!')
+		test.status = TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
-		counts = print_and_count_results(test_result)
+		test = parse_test(lines, 0, [])
+		if test.status != TestStatus.NO_TESTS:
+			test.status = test.counts.get_status()
 	print_with_timestamp(DIVIDER)
-	if test_result.status == TestStatus.SUCCESS:
-		fmt = green
-	elif test_result.status == TestStatus.SKIPPED:
-		fmt = yellow
-	else:
-		fmt =red
-	print_with_timestamp(
-		fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
-		    (counts.total(), counts.failed, counts.crashed, counts.skipped)))
-	return test_result
+	print_summary_line(test)
+	return TestResult(test.status, test, lines)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 1edcc8373b4e..9c4126731457 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -14,6 +14,7 @@ import tempfile, shutil # Handling test_tmpdir
 import itertools
 import json
 import signal
+import subprocess
 import os
 
 import kunit_config
@@ -106,10 +107,10 @@ class KUnitParserTest(unittest.TestCase):
 		with open(log_path) as file:
 			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
-		self.assertContains('	# Subtest: example', result)
-		self.assertContains('	1..2', result)
-		self.assertContains('	ok 1 - example_simple_test', result)
-		self.assertContains('	ok 2 - example_mock_test', result)
+		self.assertContains('# Subtest: example', result)
+		self.assertContains('1..2', result)
+		self.assertContains('ok 1 - example_simple_test', result)
+		self.assertContains('ok 2 - example_mock_test', result)
 		self.assertContains('ok 1 - example', result)
 
 	def test_output_with_prefix_isolated_correctly(self):
@@ -117,28 +118,28 @@ class KUnitParserTest(unittest.TestCase):
 		with open(log_path) as file:
 			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
-		self.assertContains('	# Subtest: kunit-resource-test', result)
-		self.assertContains('	1..5', result)
-		self.assertContains('	ok 1 - kunit_resource_test_init_resources', result)
-		self.assertContains('	ok 2 - kunit_resource_test_alloc_resource', result)
-		self.assertContains('	ok 3 - kunit_resource_test_destroy_resource', result)
-		self.assertContains(' foo bar 	#', result)
-		self.assertContains('	ok 4 - kunit_resource_test_cleanup_resources', result)
-		self.assertContains('	ok 5 - kunit_resource_test_proper_free_ordering', result)
+		self.assertContains('# Subtest: kunit-resource-test', result)
+		self.assertContains('1..5', result)
+		self.assertContains('ok 1 - kunit_resource_test_init_resources', result)
+		self.assertContains('ok 2 - kunit_resource_test_alloc_resource', result)
+		self.assertContains('ok 3 - kunit_resource_test_destroy_resource', result)
+		self.assertContains('foo bar 	#', result)
+		self.assertContains('ok 4 - kunit_resource_test_cleanup_resources', result)
+		self.assertContains('ok 5 - kunit_resource_test_proper_free_ordering', result)
 		self.assertContains('ok 1 - kunit-resource-test', result)
-		self.assertContains(' foo bar 	# non-kunit output', result)
-		self.assertContains('	# Subtest: kunit-try-catch-test', result)
-		self.assertContains('	1..2', result)
-		self.assertContains('	ok 1 - kunit_test_try_catch_successful_try_no_catch',
+		self.assertContains('foo bar 	# non-kunit output', result)
+		self.assertContains('# Subtest: kunit-try-catch-test', result)
+		self.assertContains('1..2', result)
+		self.assertContains('ok 1 - kunit_test_try_catch_successful_try_no_catch',
 				    result)
-		self.assertContains('	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
+		self.assertContains('ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
 				    result)
 		self.assertContains('ok 2 - kunit-try-catch-test', result)
-		self.assertContains('	# Subtest: string-stream-test', result)
-		self.assertContains('	1..3', result)
-		self.assertContains('	ok 1 - string_stream_test_empty_on_creation', result)
-		self.assertContains('	ok 2 - string_stream_test_not_empty_after_add', result)
-		self.assertContains('	ok 3 - string_stream_test_get_string', result)
+		self.assertContains('# Subtest: string-stream-test', result)
+		self.assertContains('1..3', result)
+		self.assertContains('ok 1 - string_stream_test_empty_on_creation', result)
+		self.assertContains('ok 2 - string_stream_test_not_empty_after_add', result)
+		self.assertContains('ok 3 - string_stream_test_get_string', result)
 		self.assertContains('ok 3 - string-stream-test', result)
 
 	def test_parse_successful_test_log(self):
@@ -149,6 +150,22 @@ class KUnitParserTest(unittest.TestCase):
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
 
+	def test_parse_successful_nested_tests_log(self):
+		all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
+		with open(all_passed_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+
+	def test_kselftest_nested(self):
+		kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
+		with open(kselftest_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+
 	def test_parse_failed_test_log(self):
 		failed_log = test_data_path('test_is_test_passed-failure.log')
 		with open(failed_log) as file:
@@ -162,17 +179,29 @@ class KUnitParserTest(unittest.TestCase):
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.suites))
+		self.assertEqual(0, len(result.test.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
 			result.status)
 
+	def test_missing_test_plan(self):
+		missing_plan_log = test_data_path('test_is_test_passed-'
+			'missing_plan.log')
+		with open(missing_plan_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.extract_tap_lines(
+				file.readlines()))
+		self.assertEqual(2, result.test.counts.errors)
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+
 	def test_no_tests(self):
-		empty_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
-		with open(empty_log) as file:
+		header_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
+		with open(header_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.suites))
+		self.assertEqual(0, len(result.test.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
@@ -183,37 +212,53 @@ class KUnitParserTest(unittest.TestCase):
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		print_mock.assert_any_call(StrContains('could not parse test results!'))
+		print_mock.assert_any_call(StrContains('invalid KTAP input!'))
 		print_mock.stop()
-		file.close()
+		self.assertEqual(0, len(result.test.subtests))
 
 	def test_crashed_test(self):
 		crashed_log = test_data_path('test_is_test_passed-crash.log')
 		with open(crashed_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(
+				file.readlines())
 		self.assertEqual(
 			kunit_parser.TestStatus.TEST_CRASHED,
 			result.status)
 
 	def test_skipped_test(self):
 		skipped_log = test_data_path('test_skip_tests.log')
-		file = open(skipped_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(skipped_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 
 		# A skipped test does not fail the whole suite.
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
-		file.close()
 
 	def test_skipped_all_tests(self):
 		skipped_log = test_data_path('test_skip_all_tests.log')
-		file = open(skipped_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(skipped_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 
 		self.assertEqual(
 			kunit_parser.TestStatus.SKIPPED,
 			result.status)
+
+	def test_ignores_hyphen(self):
+		hyphen_log = test_data_path('test_strip_hyphen.log')
+		file = open(hyphen_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+
+		# A skipped test does not fail the whole suite.
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+		self.assertEqual(
+			"sysctl_test",
+			result.test.subtests[0].name)
+		self.assertEqual(
+			"example",
+			result.test.subtests[1].name)
 		file.close()
 
 
@@ -224,7 +269,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
@@ -233,7 +278,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
@@ -242,7 +287,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
@@ -251,7 +296,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
@@ -260,7 +305,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.TEST_CRASHED,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
@@ -269,7 +314,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 class LinuxSourceTreeTest(unittest.TestCase):
 
@@ -283,13 +328,33 @@ class LinuxSourceTreeTest(unittest.TestCase):
 
 	def test_valid_kunitconfig(self):
 		with tempfile.NamedTemporaryFile('wt') as kunitconfig:
-			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
+			kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
 
 	def test_dir_kunitconfig(self):
 		with tempfile.TemporaryDirectory('') as dir:
-			with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
+			with open(os.path.join(dir, '.kunitconfig'), 'w'):
 				pass
-			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
+			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
+
+	def test_invalid_arch(self):
+		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
+			kunit_kernel.LinuxSourceTree('', arch='invalid')
+
+	def test_run_kernel_hits_exception(self):
+		def fake_start(unused_args, unused_build_dir):
+			return subprocess.Popen(['echo "hi\nbye"'], shell=True, text=True, stdout=subprocess.PIPE)
+
+		with tempfile.TemporaryDirectory('') as build_dir:
+			tree = kunit_kernel.LinuxSourceTree(build_dir, load_config=False)
+			mock.patch.object(tree._ops, 'start', side_effect=fake_start).start()
+
+			with self.assertRaises(ValueError):
+				for line in tree.run_kernel(build_dir=build_dir):
+					self.assertEqual(line, 'hi\n')
+					raise ValueError('uh oh, did not read all output')
+
+			with open(kunit_kernel.get_outfile_path(build_dir), 'rt') as outfile:
+				self.assertEqual(outfile.read(), 'hi\nbye\n', msg='Missing some output')
 
 	# TODO: add more test cases.
 
@@ -322,6 +387,12 @@ class KUnitJsonTest(unittest.TestCase):
 		result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
 		self.assertEqual(0, len(result['sub_groups']))
 
+	def test_nested_json(self):
+		result = self._json_for('test_is_test_passed-all_passed_nested.log')
+		self.assertEqual(
+			{'name': 'example_simple_test', 'status': 'PASS'},
+			result["sub_groups"][0]["sub_groups"][0]["test_cases"][0])
+
 class StrContains(str):
 	def __eq__(self, other):
 		return self in other
@@ -380,7 +451,15 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(e.exception.code, 1)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
-		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
+		self.print_mock.assert_any_call(StrContains('invalid KTAP input!'))
+
+	def test_exec_no_tests(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
+		with self.assertRaises(SystemExit) as e:
+                  kunit.main(['run'], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=None, build_dir='.kunit', filter_glob='', timeout=300)
+		self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
 
 	def test_exec_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
@@ -388,7 +467,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
-			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run!')))
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
@@ -397,7 +476,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
-			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run!')))
 
 	def test_run_raw_output_kunit(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
@@ -485,6 +564,46 @@ class KUnitMainTest(unittest.TestCase):
 		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_list_tests(self):
+		want = ['suite.test1', 'suite.test2', 'suite2.test1']
+		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
+
+		got = kunit._list_tests(self.linux_source_mock,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'suite'))
+
+		self.assertEqual(got, want)
+		# Should respect the user's filter glob when listing tests.
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', timeout=300)
+
+
+	@mock.patch.object(kunit, '_list_tests')
+	def test_run_isolated_by_suite(self, mock_tests):
+		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
+		kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'], self.linux_source_mock)
+
+		# Should respect the user's filter glob when listing tests.
+		mock_tests.assert_called_once_with(mock.ANY,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*.test*', None, 'suite'))
+		self.linux_source_mock.run_kernel.assert_has_calls([
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
+		])
+
+	@mock.patch.object(kunit, '_list_tests')
+	def test_run_isolated_by_test(self, mock_tests):
+		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
+		kunit.main(['exec', '--run_isolated=test', 'suite*'], self.linux_source_mock)
+
+		# Should respect the user's filter glob when listing tests.
+		mock_tests.assert_called_once_with(mock.ANY,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'test'))
+		self.linux_source_mock.run_kernel.assert_has_calls([
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', timeout=300),
+		])
+
 
 if __name__ == '__main__':
 	unittest.main()
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
new file mode 100644
index 000000000000..9d5b04fe43a6
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
@@ -0,0 +1,34 @@
+TAP version 14
+1..2
+	# Subtest: sysctl_test
+	1..4
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+		# Subtest: example
+		1..2
+	init_suite
+		# example_simple_test: initializing
+		# example_simple_test: example_simple_test passed
+		ok 1 - example_simple_test
+		# example_mock_test: initializing
+		# example_mock_test: example_mock_test passed
+		ok 2 - example_mock_test
+	kunit example: all tests passed
+	ok 2 - example
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: all tests passed
+ok 2 - example
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
new file mode 100644
index 000000000000..65d3f27feaf2
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
@@ -0,0 +1,14 @@
+TAP version 13
+1..2
+# selftests: membarrier: membarrier_test_single_thread
+# TAP version 13
+# 1..2
+# ok 1 sys_membarrier available
+# ok 2 sys membarrier invalid command test: command = -1, flags = 0, errno = 22. Failed as expected
+ok 1 selftests: membarrier: membarrier_test_single_thread
+# selftests: membarrier: membarrier_test_multi_thread
+# TAP version 13
+# 1..2
+# ok 1 sys_membarrier available
+# ok 2 sys membarrier invalid command test: command = -1, flags = 0, errno = 22. Failed as expected
+ok 2 selftests: membarrier: membarrier_test_multi_thread
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
new file mode 100644
index 000000000000..5cd17b7f818a
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
@@ -0,0 +1,31 @@
+KTAP version 1
+	# Subtest: sysctl_test
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
+	ok 2 - sysctl_test_dointvec_table_maxlen_unset
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
+	ok 5 - sysctl_test_dointvec_happy_single_positive
+	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
+	ok 6 - sysctl_test_dointvec_happy_single_negative
+	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
+	ok 7 - sysctl_test_dointvec_single_less_int_min
+	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
+	ok 8 - sysctl_test_dointvec_single_greater_int_max
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: all tests passed
+ok 2 - example
diff --git a/tools/testing/kunit/test_data/test_strip_hyphen.log b/tools/testing/kunit/test_data/test_strip_hyphen.log
new file mode 100644
index 000000000000..92ac7c24b374
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_strip_hyphen.log
@@ -0,0 +1,16 @@
+KTAP version 1
+1..2
+	# Subtest: sysctl_test
+	1..1
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..1
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 example_simple_test
+kunit example: all tests passed
+ok 2 example

--------------216E70BCB2E0C4E6463366A8--
