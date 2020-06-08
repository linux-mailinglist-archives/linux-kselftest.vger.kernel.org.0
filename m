Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC61F21CC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 00:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgFHWXz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Jun 2020 18:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgFHWXy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Jun 2020 18:23:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F3C08C5C3
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Jun 2020 15:23:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so15028017otv.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jun 2020 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=6LuEExTNhqxw8wg5CEugQdz+Z5sLjz6eamDC5Zo8FUU=;
        b=IKXJD0NdTGoCyp6iPtI+/xkYlFLJEspjlcjSgiBcIY/NXtEWTnW0Ti+fh3CFfHaAfA
         BzncEF4pPSxAPfBHJzhZat2I7An86pPhVWdO64oMrwEGU2Ahv/K/lhJL2CQ7N2TgtJuw
         9s7tiKz0LXc5Y+0Ql2kO32/ZYEI5AkZoee0AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=6LuEExTNhqxw8wg5CEugQdz+Z5sLjz6eamDC5Zo8FUU=;
        b=Q4x1IVIu9H3gqaqYB4V+d5WFaJwbw7pJM5/Yme7DvkeQJdRgImPC1sbmdSfyviuoIk
         tyq3AQRozimmmU80nx9qNcqxxH4dDkl873cNl+IS+ftVo0tn36J4cc4qfGVFCu/qKvlb
         bzOSXwsALplc6UGLbeVOt2XnOWJNT0/skU6XIN+2+tadThnTeT8Os9QuyGMM6fuQfHq6
         Rz3TFAGUD/qqgSSYgfB6Tgh3EKDxPDrZT27N5ds1qaVMRfuRg5CbIaQrNzNViZUceqcZ
         mIcb8gxMAx9xzk88Yng7u/IZJZOwNXdGDrCbDBM8OgESthNutfCJjCdd1+V7PY4kzncU
         bSdw==
X-Gm-Message-State: AOAM531cxaHCbGRXQmyblAxy/ykHQacwQIaCKeiJUqycVNWCDhW0Lb/g
        uFxGa2yUFOj6VJeLEtBdEdJ/wQ==
X-Google-Smtp-Source: ABdhPJwnTTTANxH1/tKeNhQvHYbEgkefuB71aKQcEYA+W1CqAGFyr4uvOJBrk0AyfBfmhj5zi6psuw==
X-Received: by 2002:a9d:7458:: with SMTP id p24mr17339798otk.330.1591655033885;
        Mon, 08 Jun 2020 15:23:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i2sm1792302ota.66.2020.06.08.15.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 15:23:53 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kunit update for Linux 5.8-rc1
Message-ID: <a975bc3c-a101-fe24-a2e3-1ae70ad7b181@linuxfoundation.org>
Date:   Mon, 8 Jun 2020 16:23:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------11E968490F92724A739CD02E"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------11E968490F92724A739CD02E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the Kunit update for Linux 5.8-rc1.

This Kunit update for Linux 5.8-rc1 consists of:

- Several config fragment fixes from Anders Roxell to improve
   test coverage.
- Improvements to kunit run script to use defconfig as default and
   restructure the code for config/build/exec/parse from Vitor Massaru Iha
   and David Gow.
- Miscellaneous documentation warn fix.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

   Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.8-rc1

for you to fetch changes up to 6d6861d45e38d42a7df9db244c871ee3856acf57:

   security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS 
(2020-06-01 14:25:15 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.8-rc1

This Kunit update for Linux 5.8-rc1 consists of:

- Several config fragment fixes from Anders Roxell to improve
   test coverage.
- Improvements to kunit run script to use defconfig as default and
   restructure the code for config/build/exec/parse from Vitor Massaru Iha
   and David Gow.
- Miscellaneous documentation warn fix.

----------------------------------------------------------------
Anders Roxell (6):
       kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
       kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
       lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
       drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
       fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
       security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS

David Gow (1):
       kunit: kunit_tool: Separate out config/build/exec/parse

Lothar Rubusch (1):
       Documentation: test.h - fix warnings

Vitor Massaru Iha (3):
       kunit: use --build_dir=.kunit as default
       kunit: use KUnit defconfig by default
       kunit: Fix TabError, remove defconfig code and handle when there 
is no kunitconfig

  Documentation/dev-tools/kunit/start.rst |  13 +-
  Documentation/dev-tools/kunit/usage.rst |   4 +-
  drivers/base/Kconfig                    |   3 +-
  drivers/base/test/Kconfig               |   3 +-
  fs/ext4/Kconfig                         |   3 +-
  include/kunit/test.h                    |  12 +-
  lib/Kconfig.debug                       |   6 +-
  lib/kunit/Kconfig                       |  23 ++-
  security/apparmor/Kconfig               |   3 +-
  tools/testing/kunit/kunit.py            | 307 
+++++++++++++++++++++++++-------
  tools/testing/kunit/kunit_tool_test.py  |  63 ++++++-
  11 files changed, 351 insertions(+), 89 deletions(-)

----------------------------------------------------------------

--------------11E968490F92724A739CD02E
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.8-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.8-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index e1c5ce80ce12..bb112cf70624 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -32,15 +32,17 @@ test targets as well. The ``.kunitconfig`` should also contain any other config
 options required by the tests.
 
 A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
+
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
 	cp arch/um/configs/kunit_defconfig .kunitconfig
 
 You can then add any other Kconfig options you wish, e.g.:
+
 .. code-block:: none
 
-        CONFIG_LIST_KUNIT_TEST=y
+	CONFIG_LIST_KUNIT_TEST=y
 
 :doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
 ``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
@@ -54,8 +56,8 @@ using.
    other tools (such as make menuconfig) to adjust other config options.
 
 
-Running the tests
------------------
+Running the tests (KUnit Wrapper)
+---------------------------------
 
 To make sure that everything is set up correctly, simply invoke the Python
 wrapper from your kernel repo:
@@ -105,8 +107,9 @@ have config options ending in ``_KUNIT_TEST``.
 KUnit and KUnit tests can be compiled as modules: in this case the tests in a
 module will be run when the module is loaded.
 
-Running the tests
------------------
+
+Running the tests (w/o KUnit Wrapper)
+-------------------------------------
 
 Build and run your kernel as usual. Test output will be written to the kernel
 log in `TAP <https://testanything.org/>`_ format.
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 473a2361ec37..3c3fe8b5fecc 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -595,7 +595,7 @@ able to run one test case per invocation.
 KUnit debugfs representation
 ============================
 When kunit test suites are initialized, they create an associated directory
-in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
+in ``/sys/kernel/debug/kunit/<test-suite>``.  The directory contains one file
 
 - results: "cat results" displays results of each test case and the results
   of the entire suite for the last test run.
@@ -604,4 +604,4 @@ The debugfs representation is primarily of use when kunit test suites are
 run in a native environment, either as modules or builtin.  Having a way
 to display results like this is valuable as otherwise results can be
 intermixed with other events in dmesg output.  The maximum size of each
-results file is KUNIT_LOG_SIZE bytes (defined in include/kunit/test.h).
+results file is KUNIT_LOG_SIZE bytes (defined in ``include/kunit/test.h``).
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 5f0bc74d2409..8d7001712062 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -149,8 +149,9 @@ config DEBUG_TEST_DRIVER_REMOVE
 	  test this functionality.
 
 config PM_QOS_KUNIT_TEST
-	bool "KUnit Test for PM QoS features"
+	bool "KUnit Test for PM QoS features" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
 
 config HMEM_REPORTING
 	bool
diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 305c7751184a..ba225eb1b761 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -9,5 +9,6 @@ config TEST_ASYNC_DRIVER_PROBE
 
 	  If unsure say N.
 config KUNIT_DRIVER_PE_TEST
-	bool "KUnit Tests for property entry API"
+	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 2a592e38cdfe..bc7815158503 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -103,9 +103,10 @@ config EXT4_DEBUG
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
 
 config EXT4_KUNIT_TESTS
-	tristate "KUnit tests for ext4"
+	tristate "KUnit tests for ext4" if !KUNIT_ALL_TESTS
 	select EXT4_FS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the ext4 KUnit tests.
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9b0c46a6ca1f..47e61e1d5337 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -175,7 +175,7 @@ struct kunit_suite {
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
 
-	/* private - internal use only */
+	/* private: internal use only */
 	struct dentry *debugfs;
 	char *log;
 };
@@ -232,12 +232,12 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites: a statically allocated list of &struct kunit_suite.
+ * @suites_list...: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suites with the test framework. See &struct kunit_suite for
+ * Registers @suites_list with the test framework. See &struct kunit_suite for
  * more information.
  *
- * When builtin,  KUnit tests are all run as late_initcalls; this means
+ * When builtin, KUnit tests are all run as late_initcalls; this means
  * that they cannot test anything where tests must run at a different init
  * phase. One significant restriction resulting from this is that KUnit
  * cannot reliably test anything that is initialize in the late_init phase;
@@ -253,8 +253,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * tests from the same place, and at the very least to do so after
  * everything else is definitely initialized.
  */
-#define kunit_test_suites(...)						\
-	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
+#define kunit_test_suites(suites_list...)				\
+	static struct kunit_suite *suites[] = {suites_list, NULL};	\
 	static int kunit_test_suites_init(void)				\
 	{								\
 		return __kunit_test_suites_init(suites);		\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..1f4ab7a2bdee 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2064,8 +2064,9 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	tristate "KUnit test for sysctl"
+	tristate "KUnit test for sysctl" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
 	  Tests the API contract and implementation correctness of sysctl.
@@ -2075,8 +2076,9 @@ config SYSCTL_KUNIT_TEST
 	  If unsure, say N.
 
 config LIST_KUNIT_TEST
-	tristate "KUnit Test for Kernel Linked-list structures"
+	tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the linked list KUnit test suite.
 	  It tests that the API and basic functionality of the list_head type
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 95d12e3d6d95..00909e6a2443 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -15,7 +15,8 @@ menuconfig KUNIT
 if KUNIT
 
 config KUNIT_DEBUGFS
-	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
+	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
 	help
 	  Enable debugfs representation for kunit.  Currently this consists
 	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
@@ -23,7 +24,8 @@ config KUNIT_DEBUGFS
 	  run that occurred.
 
 config KUNIT_TEST
-	tristate "KUnit test for KUnit"
+	tristate "KUnit test for KUnit" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
 	help
 	  Enables the unit tests for the KUnit test framework. These tests test
 	  the KUnit test framework itself; the tests are both written using
@@ -32,7 +34,8 @@ config KUNIT_TEST
 	  expected.
 
 config KUNIT_EXAMPLE_TEST
-	tristate "Example test for KUnit"
+	tristate "Example test for KUnit" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
 	help
 	  Enables an example unit test that illustrates some of the basic
 	  features of KUnit. This test only exists to help new users understand
@@ -41,4 +44,18 @@ config KUNIT_EXAMPLE_TEST
 	  is intended for curious hackers who would like to understand how to
 	  use KUnit for kernel development.
 
+config KUNIT_ALL_TESTS
+	tristate "All KUnit tests with satisfied dependencies"
+	help
+	  Enables all KUnit tests, if they can be enabled.
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 endif # KUNIT
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 0fe336860773..03fae1bd48a6 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -70,8 +70,9 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
 	  the kernel message buffer.
 
 config SECURITY_APPARMOR_KUNIT_TEST
-	bool "Build KUnit tests for policy_unpack.c"
+	bool "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y && SECURITY_APPARMOR
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the AppArmor KUnit tests.
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dca74774dd2..787b6d4ad716 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -20,11 +20,20 @@ import kunit_config
 import kunit_kernel
 import kunit_parser
 
-KunitResult = namedtuple('KunitResult', ['status','result'])
+KunitResult = namedtuple('KunitResult', ['status','result','elapsed_time'])
 
+KunitConfigRequest = namedtuple('KunitConfigRequest',
+				['build_dir', 'make_options'])
+KunitBuildRequest = namedtuple('KunitBuildRequest',
+			       ['jobs', 'build_dir', 'alltests',
+				'make_options'])
+KunitExecRequest = namedtuple('KunitExecRequest',
+			      ['timeout', 'build_dir', 'alltests'])
+KunitParseRequest = namedtuple('KunitParseRequest',
+			       ['raw_output', 'input_data'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'defconfig',
-					   'alltests', 'make_options'])
+					   'build_dir', 'alltests',
+					   'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -46,14 +55,24 @@ def get_kernel_root_path():
 		sys.exit(1)
 	return parts[0]
 
-def run_tests(linux: kunit_kernel.LinuxSourceTree,
-	      request: KunitRequest) -> KunitResult:
+def config_tests(linux: kunit_kernel.LinuxSourceTree,
+		 request: KunitConfigRequest) -> KunitResult:
+	kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
+
 	config_start = time.time()
+	create_default_kunitconfig()
 	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
-		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
+		return KunitResult(KunitStatus.CONFIG_FAILURE,
+				   'could not configure kernel',
+				   config_end - config_start)
+	return KunitResult(KunitStatus.SUCCESS,
+			   'configured kernel successfully',
+			   config_end - config_start)
 
+def build_tests(linux: kunit_kernel.LinuxSourceTree,
+		request: KunitBuildRequest) -> KunitResult:
 	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
@@ -64,86 +83,166 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
+	if not success:
+		return KunitResult(KunitStatus.BUILD_FAILURE,
+				   'could not build kernel',
+				   build_end - build_start)
+	return KunitResult(KunitStatus.SUCCESS,
+			   'built kernel successfully',
+			   build_end - build_start)
 
+def exec_tests(linux: kunit_kernel.LinuxSourceTree,
+	       request: KunitExecRequest) -> KunitResult:
 	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
 	test_start = time.time()
-	kunit_output = linux.run_kernel(
+	result = linux.run_kernel(
 		timeout=None if request.alltests else request.timeout,
 		build_dir=request.build_dir)
+
+	test_end = time.time()
+
+	return KunitResult(KunitStatus.SUCCESS,
+			   result,
+			   test_end - test_start)
+
+def parse_tests(request: KunitParseRequest) -> KunitResult:
+	parse_start = time.time()
+
+	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
+					      [],
+					      'Tests not Parsed.')
 	if request.raw_output:
-		raw_output = kunit_parser.raw_output(kunit_output)
-		isolated = list(kunit_parser.isolate_kunit_output(raw_output))
-		test_result = kunit_parser.parse_test_result(isolated)
+		kunit_parser.raw_output(request.input_data)
 	else:
-		test_result = kunit_parser.parse_run_tests(kunit_output)
-	test_end = time.time()
+		test_result = kunit_parser.parse_run_tests(request.input_data)
+	parse_end = time.time()
+
+	if test_result.status != kunit_parser.TestStatus.SUCCESS:
+		return KunitResult(KunitStatus.TEST_FAILURE, test_result,
+				   parse_end - parse_start)
+
+	return KunitResult(KunitStatus.SUCCESS, test_result,
+				parse_end - parse_start)
+
+
+def run_tests(linux: kunit_kernel.LinuxSourceTree,
+	      request: KunitRequest) -> KunitResult:
+	run_start = time.time()
+
+	config_request = KunitConfigRequest(request.build_dir,
+					    request.make_options)
+	config_result = config_tests(linux, config_request)
+	if config_result.status != KunitStatus.SUCCESS:
+		return config_result
+
+	build_request = KunitBuildRequest(request.jobs, request.build_dir,
+					  request.alltests,
+					  request.make_options)
+	build_result = build_tests(linux, build_request)
+	if build_result.status != KunitStatus.SUCCESS:
+		return build_result
+
+	exec_request = KunitExecRequest(request.timeout, request.build_dir,
+					request.alltests)
+	exec_result = exec_tests(linux, exec_request)
+	if exec_result.status != KunitStatus.SUCCESS:
+		return exec_result
+
+	parse_request = KunitParseRequest(request.raw_output,
+					  exec_result.result)
+	parse_result = parse_tests(parse_request)
+
+	run_end = time.time()
 
 	kunit_parser.print_with_timestamp((
 		'Elapsed time: %.3fs total, %.3fs configuring, %.3fs ' +
 		'building, %.3fs running\n') % (
-				test_end - config_start,
-				config_end - config_start,
-				build_end - build_start,
-				test_end - test_start))
+				run_end - run_start,
+				config_result.elapsed_time,
+				build_result.elapsed_time,
+				exec_result.elapsed_time))
+	return parse_result
+
+def add_common_opts(parser):
+	parser.add_argument('--build_dir',
+			    help='As in the make command, it specifies the build '
+			    'directory.',
+                            type=str, default='.kunit', metavar='build_dir')
+	parser.add_argument('--make_options',
+			    help='X=Y make option, can be repeated.',
+			    action='append')
+	parser.add_argument('--alltests',
+			    help='Run all KUnit tests through allyesconfig',
+			    action='store_true')
+
+def add_build_opts(parser):
+	parser.add_argument('--jobs',
+			    help='As in the make command, "Specifies  the number of '
+			    'jobs (commands) to run simultaneously."',
+			    type=int, default=8, metavar='jobs')
+
+def add_exec_opts(parser):
+	parser.add_argument('--timeout',
+			    help='maximum number of seconds to allow for all tests '
+			    'to run. This does not include time taken to build the '
+			    'tests.',
+			    type=int,
+			    default=300,
+			    metavar='timeout')
+
+def add_parse_opts(parser):
+	parser.add_argument('--raw_output', help='don\'t format output from kernel',
+			    action='store_true')
 
-	if test_result.status != kunit_parser.TestStatus.SUCCESS:
-		return KunitResult(KunitStatus.TEST_FAILURE, test_result)
-	else:
-		return KunitResult(KunitStatus.SUCCESS, test_result)
 
 def main(argv, linux=None):
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
 
+	# The 'run' command will config, build, exec, and parse in one go.
 	run_parser = subparser.add_parser('run', help='Runs KUnit tests.')
-	run_parser.add_argument('--raw_output', help='don\'t format output from kernel',
-				action='store_true')
-
-	run_parser.add_argument('--timeout',
-				help='maximum number of seconds to allow for all tests '
-				'to run. This does not include time taken to build the '
-				'tests.',
-				type=int,
-				default=300,
-				metavar='timeout')
-
-	run_parser.add_argument('--jobs',
-				help='As in the make command, "Specifies  the number of '
-				'jobs (commands) to run simultaneously."',
-				type=int, default=8, metavar='jobs')
-
-	run_parser.add_argument('--build_dir',
-				help='As in the make command, it specifies the build '
-				'directory.',
-				type=str, default='', metavar='build_dir')
-
-	run_parser.add_argument('--defconfig',
-				help='Uses a default .kunitconfig.',
-				action='store_true')
-
-	run_parser.add_argument('--alltests',
-				help='Run all KUnit tests through allyesconfig',
-				action='store_true')
-
-	run_parser.add_argument('--make_options',
-				help='X=Y make option, can be repeated.',
-				action='append')
+	add_common_opts(run_parser)
+	add_build_opts(run_parser)
+	add_exec_opts(run_parser)
+	add_parse_opts(run_parser)
+
+	config_parser = subparser.add_parser('config',
+						help='Ensures that .config contains all of '
+						'the options in .kunitconfig')
+	add_common_opts(config_parser)
+
+	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
+	add_common_opts(build_parser)
+	add_build_opts(build_parser)
+
+	exec_parser = subparser.add_parser('exec', help='Run a kernel with KUnit tests')
+	add_common_opts(exec_parser)
+	add_exec_opts(exec_parser)
+	add_parse_opts(exec_parser)
+
+	# The 'parse' option is special, as it doesn't need the kernel source
+	# (therefore there is no need for a build_dir, hence no add_common_opts)
+	# and the '--file' argument is not relevant to 'run', so isn't in
+	# add_parse_opts()
+	parse_parser = subparser.add_parser('parse',
+					    help='Parses KUnit results from a file, '
+					    'and parses formatted results.')
+	add_parse_opts(parse_parser)
+	parse_parser.add_argument('file',
+				  help='Specifies the file to read results from.',
+				  type=str, nargs='?', metavar='input_file')
 
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
-		if get_kernel_root_path():
-			os.chdir(get_kernel_root_path())
+		if not os.path.exists(cli_args.build_dir):
+			os.mkdir(cli_args.build_dir)
+		kunit_kernel.kunitconfig_path = os.path.join(
+			cli_args.build_dir,
+			kunit_kernel.kunitconfig_path)
 
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
-				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
-
-		if cli_args.defconfig:
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
 			create_default_kunitconfig()
 
 		if not linux:
@@ -153,12 +252,94 @@ def main(argv, linux=None):
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
-				       cli_args.defconfig,
 				       cli_args.alltests,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
+	elif cli_args.subcommand == 'config':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
+		request = KunitConfigRequest(cli_args.build_dir,
+					     cli_args.make_options)
+		result = config_tests(linux, request)
+		kunit_parser.print_with_timestamp((
+			'Elapsed time: %.3fs\n') % (
+				result.elapsed_time))
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	elif cli_args.subcommand == 'build':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
+		request = KunitBuildRequest(cli_args.jobs,
+					    cli_args.build_dir,
+					    cli_args.alltests,
+					    cli_args.make_options)
+		result = build_tests(linux, request)
+		kunit_parser.print_with_timestamp((
+			'Elapsed time: %.3fs\n') % (
+				result.elapsed_time))
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	elif cli_args.subcommand == 'exec':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
+		exec_request = KunitExecRequest(cli_args.timeout,
+						cli_args.build_dir,
+						cli_args.alltests)
+		exec_result = exec_tests(linux, exec_request)
+		parse_request = KunitParseRequest(cli_args.raw_output,
+						  exec_result.result)
+		result = parse_tests(parse_request)
+		kunit_parser.print_with_timestamp((
+			'Elapsed time: %.3fs\n') % (
+				exec_result.elapsed_time))
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	elif cli_args.subcommand == 'parse':
+		if cli_args.file == None:
+			kunit_output = sys.stdin
+		else:
+			with open(cli_args.file, 'r') as f:
+				kunit_output = f.read().splitlines()
+		request = KunitParseRequest(cli_args.raw_output,
+					    kunit_output)
+		result = parse_tests(request)
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
 	else:
 		parser.print_help()
 
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 984588d6ba95..5bb7b118ebd9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -239,6 +239,24 @@ class KUnitMainTest(unittest.TestCase):
 		self.print_patch.stop()
 		pass
 
+	def test_config_passes_args_pass(self):
+		kunit.main(['config'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		assert self.linux_source_mock.run_kernel.call_count == 0
+
+	def test_build_passes_args_pass(self):
+		kunit.main(['build'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 0
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '', None)
+		assert self.linux_source_mock.run_kernel.call_count == 0
+
+	def test_exec_passes_args_pass(self):
+		kunit.main(['exec'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 0
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
 	def test_run_passes_args_pass(self):
 		kunit.main(['run'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
@@ -247,6 +265,13 @@ class KUnitMainTest(unittest.TestCase):
 			build_dir='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_exec_passes_args_fail(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		with self.assertRaises(SystemExit) as e:
+			kunit.main(['exec'], self.linux_source_mock)
+		assert type(e.exception) == SystemExit
+		assert e.exception.code == 1
+
 	def test_run_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
@@ -257,14 +282,28 @@ class KUnitMainTest(unittest.TestCase):
 		assert self.linux_source_mock.run_kernel.call_count == 1
 		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
 
+	def test_exec_raw_output(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		kunit.main(['exec', '--raw_output'], self.linux_source_mock)
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		for kall in self.print_mock.call_args_list:
+			assert kall != mock.call(StrContains('Testing complete.'))
+			assert kall != mock.call(StrContains(' 0 tests run'))
+
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run', '--raw_output'], self.linux_source_mock)
-		assert type(e.exception) == SystemExit
-		assert e.exception.code == 1
+		kunit.main(['run', '--raw_output'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
+		for kall in self.print_mock.call_args_list:
+			assert kall != mock.call(StrContains('Testing complete.'))
+			assert kall != mock.call(StrContains(' 0 tests run'))
+
+	def test_exec_timeout(self):
+		timeout = 3453
+		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
 		timeout = 3453
@@ -282,5 +321,21 @@ class KUnitMainTest(unittest.TestCase):
 			build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_config_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+
+	def test_build_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, build_dir, None)
+
+	def test_exec_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
 if __name__ == '__main__':
 	unittest.main()

--------------11E968490F92724A739CD02E--
