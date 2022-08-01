Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0FB587357
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Aug 2022 23:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiHAV3A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiHAV2r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 17:28:47 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A04D15F
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 14:26:06 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10cf9f5b500so15186676fac.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Aug 2022 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=cb009FMtgd21ebXGDa5GiSqoejUsX9njE9gk75sErPA=;
        b=OfOqPAFQlRC8aCHEbl4SYDcHbIqjEe3F4hBRC9vyimwphhsxWkzutmudVmYqNgsJu3
         d0W5M9osYB5y5M94YEMiTzsB7hkW1ZCotpG4/Y6vO2huGW0XUf92nme+8v2etoCrNOvC
         iX4A6S4IDAV8rJAAX4SinM0xrge1Nn8m6ohs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=cb009FMtgd21ebXGDa5GiSqoejUsX9njE9gk75sErPA=;
        b=bpeMtq/39cOaoFHIPFsdUVmEtPKA9ysxXvVTa1o5xhB8II1BXNXAKnf0iRHZNW9bml
         24lmusiU8VTN210dWnFhjVwfwzPikcOz0X0nFIVw3gd0fhMgrg8QtnX2E2REqlTGoA7p
         cT3wOTHG/fR3rioorzfPqK0/uoHop9vhMZWxWKIDvVJKyZ5fPazWRr/X8DJCHPFtrUYB
         Nihg/cA3hUKrtDChbHBV5BNWilW9Wdu5E40dOStKk8tSfH4P7TU/NFk3xD9KeB4hsU+y
         HimIDT60wHaWa6D/Pke+7mJtUKyRrcXsRF1KiIucP5oS2sYwCxMTMGsqcM/Y68rAJFQB
         lwKw==
X-Gm-Message-State: AJIora+qBhKJXDPeFjzNH/yhjKzAKJ+uG03Hq2UePsSXrW9g+KbS//+8
        l6fhQcwQasqF/HnANKkqNtYpqA==
X-Google-Smtp-Source: AGRyM1sQLWxnENKLU4PU0xhCqktJMeU3/vRXLucQ6g1mJ0WF8omObTKFXLotYVeNP9+YxSppq3xRdQ==
X-Received: by 2002:a05:6870:4284:b0:101:202e:a78d with SMTP id y4-20020a056870428400b00101202ea78dmr8507197oah.37.1659389165216;
        Mon, 01 Aug 2022 14:26:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a9-20020a056830100900b0061c309b1dc2sm3022177otp.39.2022.08.01.14.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 14:26:04 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.20-rc1
Message-ID: <e0b61c0e-3b02-2681-3175-ad17501f3c2a@linuxfoundation.org>
Date:   Mon, 1 Aug 2022 15:26:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------168D46355E674F70E901330E"
Content-Language: en-US
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------168D46355E674F70E901330E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following KUnit update for Linux 5.20-rc1.

This KUnit update for Linux 5.20-rc1 consists of several fixes and an
important feature to discourage running KUnit tests on production
systems. Running tests on a production system could leave the system
in a bad state. This new feature adds:

- adds a new taint type, TAINT_TEST to signal that a test has been run.
   This should discourage people from running these tests on production
   systems, and to make it easier to tell if tests have been run
   accidentally (by loading the wrong configuration, etc.)

- several documentation and tool enhancements and fixes.

Please note that this KUnit update touches drivers, lib, kernel files
for the TAINT_TEST feature.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.20-rc1

for you to fetch changes up to 4c392516accfe51a1aaf80ed163517646f8f0476:

   Documentation: KUnit: Fix example with compilation error (2022-07-28 13:06:35 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.20-rc1

This KUnit update for Linux 5.20-rc1 consists of several fixes and an
important feature to discourage running KUnit tests on production
systems. Running tests on a production system could leave the system
in a bad state. This new feature adds:

- adds a new taint type, TAINT_TEST to signal that a test has been run.
   This should discourage people from running these tests on production
   systems, and to make it easier to tell if tests have been run
   accidentally (by loading the wrong configuration, etc.)

- several documentation and tool enhancements and fixes.

----------------------------------------------------------------
Daniel Latypov (13):
       kunit: use kmemdup in kunit_filter_tests(), take suite as const
       kunit: tool: drop unused load_config argument
       kunit: tool: redo how we construct and mock LinuxSourceTree
       kunit: tool: refactoring printing logic into kunit_printer.py
       kunit: tool: cosmetic: don't specify duplicate kernel cmdline options
       kunit: tool: simplify creating LinuxSourceTreeOperations
       kunit: tool: introduce --qemu_args
       kunit: tool: refactor internal kconfig handling, allow overriding
       kunit: add coverage_uml.config to enable GCOV on UML
       kunit: tool: make --kunitconfig repeatable, blindly concat
       Documentation: kunit: fix example run_kunit func to allow spaces in args
       kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites
       clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig

David Gow (12):
       panic: Taint kernel if tests are run
       kunit: Taint the kernel when KUnit tests are run
       apparmor: test: Remove some casts which are no-longer required
       kunit: tool: Enable virtio/PCI by default on UML
       Documentation: kunit: Cleanup run_wrapper, fix x-ref
       module: panic: Taint the kernel when selftest modules load
       selftest: Taint kernel when test module loaded
       thunderbolt: test: Use kunit_test_suite() macro
       nitro_enclaves: test: Use kunit_test_suite() macro
       mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro
       kunit: executor: Fix a memory leak on failure in kunit_filter_tests
       kcsan: test: Add a .kunitconfig to run KCSAN tests

Jeremy Kerr (1):
       kunit: unify module and builtin suite definitions

Mauro Carvalho Chehab (1):
       kunit: test.h: fix a kernel-doc markup

Maíra Canal (1):
       Documentation: KUnit: Fix example with compilation error

Sadiya Kazi (1):
       Documentation: kunit: Add CLI args for kunit_tool

  Documentation/admin-guide/tainted-kernels.rst   |   1 +
  Documentation/dev-tools/kselftest.rst           |   9 +
  Documentation/dev-tools/kunit/run_wrapper.rst   |  81 ++++++++-
  Documentation/dev-tools/kunit/running_tips.rst  |   5 +-
  Documentation/dev-tools/kunit/usage.rst         |   2 +-
  drivers/clk/.kunitconfig                        |   1 +
  drivers/mmc/host/Kconfig                        |   5 +-
  drivers/mmc/host/sdhci-of-aspeed-test.c         |   8 +-
  drivers/mmc/host/sdhci-of-aspeed.c              |  34 +---
  drivers/thunderbolt/Kconfig                     |   6 +-
  drivers/thunderbolt/domain.c                    |   3 -
  drivers/thunderbolt/tb.h                        |   8 -
  drivers/thunderbolt/test.c                      |  12 +-
  drivers/virt/nitro_enclaves/Kconfig             |   5 +-
  drivers/virt/nitro_enclaves/ne_misc_dev.c       |  27 ---
  drivers/virt/nitro_enclaves/ne_misc_dev_test.c  |   5 +-
  include/kunit/test.h                            |  63 ++-----
  include/linux/module.h                          |   5 +
  include/linux/panic.h                           |   3 +-
  kernel/kcsan/.kunitconfig                       |  24 +++
  kernel/module/main.c                            |  13 ++
  kernel/panic.c                                  |   1 +
  lib/kunit/executor.c                            | 125 ++++----------
  lib/kunit/executor_test.c                       | 144 +++++-----------
  lib/kunit/test.c                                |  58 ++++++-
  scripts/mod/modpost.c                           |   3 +
  security/apparmor/policy_unpack_test.c          |  12 +-
  tools/testing/kunit/configs/arch_uml.config     |   5 +
  tools/testing/kunit/configs/coverage_uml.config |  11 ++
  tools/testing/kunit/kunit.py                    |  83 +++++----
  tools/testing/kunit/kunit_config.py             |  54 +++---
  tools/testing/kunit/kunit_kernel.py             | 104 +++++++-----
  tools/testing/kunit/kunit_parser.py             |  63 +++----
  tools/testing/kunit/kunit_printer.py            |  48 ++++++
  tools/testing/kunit/kunit_tool_test.py          | 214 +++++++++++++++---------
  tools/testing/selftests/kselftest_module.h      |   4 +
  36 files changed, 657 insertions(+), 592 deletions(-)
  create mode 100644 kernel/kcsan/.kunitconfig
  create mode 100644 tools/testing/kunit/configs/arch_uml.config
  create mode 100644 tools/testing/kunit/configs/coverage_uml.config
  create mode 100644 tools/testing/kunit/kunit_printer.py
----------------------------------------------------------------

--------------168D46355E674F70E901330E
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.20-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.20-rc1.diff"

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index ceeed7b0798d..7d80e8c307d1 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
+ 18  _/N  262144  an in-kernel test has been run
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index a833ecf12fbc..1096a9833550 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -250,6 +250,14 @@ assist writing kernel modules that are for use with kselftest:
 - ``tools/testing/selftests/kselftest_module.h``
 - ``tools/testing/selftests/kselftest/module.sh``
 
+Note that test modules should taint the kernel with TAINT_TEST. This will
+happen automatically for modules which are in the ``tools/testing/``
+directory, or for modules which use the ``kselftest_module.h`` header above.
+Otherwise, you'll need to add ``MODULE_INFO(test, "Y")`` to your module
+source. selftests which do not load modules typically should not taint the
+kernel, but in cases where a non-test module is loaded, TEST_TAINT can be
+applied from userspace by writing to ``/proc/sys/kernel/tainted``.
+
 How to use
 ----------
 
@@ -308,6 +316,7 @@ A bare bones test module might look like this:
    KSTM_MODULE_LOADERS(test_foo);
    MODULE_AUTHOR("John Developer <jd@fooman.org>");
    MODULE_LICENSE("GPL");
+   MODULE_INFO(test, "Y");
 
 Example test script
 -------------------
diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 653985ce9cae..cce203138fb7 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -192,6 +192,21 @@ via UML. To run tests on qemu, by default it requires two flags:
     if we have downloaded the microblaze toolchain from the 0-day
     website to a directory in our home directory called toolchains.
 
+This means that for most architectures, running under qemu is as simple as:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --arch=x86_64
+
+When cross-compiling, we'll likely need to specify a different toolchain, for
+example:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run \
+		--arch=s390 \
+		--cross_compile=s390x-linux-gnu-
+
 If we want to run KUnit tests on an architecture not supported by
 the ``--arch`` flag, or want to run KUnit tests on qemu using a
 non-default configuration; then we can write our own``QemuConfig``.
@@ -214,14 +229,11 @@ as
 		--jobs=12 \
 		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
 
-To run existing KUnit tests on non-UML architectures, see:
-Documentation/dev-tools/kunit/non_uml.rst.
-
 Command-Line Arguments
 ======================
 
 kunit_tool has a number of other command-line arguments which can
-be useful for our test environment. Below the most commonly used
+be useful for our test environment. Below are the most commonly used
 command line arguments:
 
 - ``--help``: Lists all available options. To list common options,
@@ -245,3 +257,64 @@ command line arguments:
             added or modified. Instead, enable all tests
             which have satisfied dependencies by adding
             ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
+
+- ``--kunitconfig``: Specifies the path or the directory of the ``.kunitconfig``
+  file. For example:
+
+  - ``lib/kunit/.kunitconfig`` can be the path of the file.
+
+  - ``lib/kunit`` can be the directory in which the file is located.
+
+  This file is used to build and run with a predefined set of tests
+  and their dependencies. For example, to run tests for a given subsystem.
+
+- ``--kconfig_add``: Specifies additional configuration options to be
+  appended to the ``.kunitconfig`` file. For example:
+
+  .. code-block::
+
+	./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
+
+- ``--arch``: Runs tests on the specified architecture. The architecture
+  argument is same as the Kbuild ARCH environment variable.
+  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on qemu.
+  Default is `um`.
+
+- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
+  same argument as passed to the ``CROSS_COMPILE`` variable used by
+  Kbuild. This will be the prefix for the toolchain
+  binaries such as GCC. For example:
+
+  - ``sparc64-linux-gnu-`` if we have the sparc toolchain installed on
+    our system.
+
+  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
+    if we have downloaded the microblaze toolchain from the 0-day
+    website to a specified path in our home directory called toolchains.
+
+- ``--qemu_config``: Specifies the path to a file containing a
+  custom qemu architecture definition. This should be a python file
+  containing a `QemuArchParams` object.
+
+- ``--qemu_args``: Specifies additional qemu arguments, for example, ``-smp 8``.
+
+- ``--jobs``: Specifies the number of jobs (commands) to run simultaneously.
+  By default, this is set to the number of cores on your system.
+
+- ``--timeout``: Specifies the maximum number of seconds allowed for all tests to run.
+  This does not include the time taken to build the tests.
+
+- ``--kernel_args``: Specifies additional kernel command-line arguments. May be repeated.
+
+- ``--run_isolated``: If set, boots the kernel for each individual suite/test.
+  This is useful for debugging a non-hermetic test, one that
+  might pass/fail based on what ran before it.
+
+- ``--raw_output``: If set, generates unformatted output from kernel. Possible options are:
+
+   - ``all``: To view the full kernel output, use ``--raw_output=all``.
+
+   - ``kunit``: This is the default option and filters to KUnit output. Use ``--raw_output`` or ``--raw_output=kunit``.
+
+- ``--json``: If set, stores the test results in a JSON format and prints to `stdout` or
+  saves to a file if a filename is specified.
diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index c36f6760087d..8e8c493f17d1 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -15,7 +15,7 @@ It can be handy to create a bash function like:
 .. code-block:: bash
 
 	function run_kunit() {
-	  ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run $@ )
+	  ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run "$@" )
 	}
 
 .. note::
@@ -123,8 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
 .. code-block:: bash
 
 	# Append coverage options to the current config
-	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
-	$ ./tools/testing/kunit/kunit.py run
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=.kunit/ --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
 	# Extract the coverage information from the build dir (.kunit/)
 	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
 
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index d62a04255c2e..44158eecb51e 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -505,7 +505,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
 		const char *str;
 		const char *sha1;
 	};
-	struct sha1_test_case cases[] = {
+	const struct sha1_test_case cases[] = {
 		{
 			.str = "hello world",
 			.sha1 = "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index cdbc7d7deba9..2fbeb71316f8 100644
--- a/drivers/clk/.kunitconfig
+++ b/drivers/clk/.kunitconfig
@@ -2,3 +2,4 @@ CONFIG_KUNIT=y
 CONFIG_COMMON_CLK=y
 CONFIG_CLK_KUNIT_TEST=y
 CONFIG_CLK_GATE_KUNIT_TEST=y
+CONFIG_UML_PCI_OVER_VIRTIO=n
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d6144978e32d..10c563999d3d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -169,8 +169,9 @@ config MMC_SDHCI_OF_ASPEED
 	  If unsure, say N.
 
 config MMC_SDHCI_OF_ASPEED_TEST
-	bool "Tests for the ASPEED SDHCI driver"
-	depends on MMC_SDHCI_OF_ASPEED && KUNIT=y
+	bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
+	depends on MMC_SDHCI_OF_ASPEED && KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
 	  option only if you will boot the kernel for the purpose of running
diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
index 1ed4f86291f2..ecb502606c53 100644
--- a/drivers/mmc/host/sdhci-of-aspeed-test.c
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -96,10 +96,4 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
 	.test_cases = aspeed_sdhci_test_cases,
 };
 
-static struct kunit_suite *aspeed_sdc_test_suite_array[] = {
-	&aspeed_sdhci_test_suite,
-	NULL,
-};
-
-static struct kunit_suite **aspeed_sdc_test_suites
-	__used __section(".kunit_test_suites") = aspeed_sdc_test_suite_array;
+kunit_test_suite(aspeed_sdhci_test_suite);
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 6e4e132903a6..ba6677bf7372 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -606,25 +606,6 @@ static struct platform_driver aspeed_sdc_driver = {
 
 #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
 #include "sdhci-of-aspeed-test.c"
-
-static inline int aspeed_sdc_tests_init(void)
-{
-	return __kunit_test_suites_init(aspeed_sdc_test_suites);
-}
-
-static inline void aspeed_sdc_tests_exit(void)
-{
-	__kunit_test_suites_exit(aspeed_sdc_test_suites);
-}
-#else
-static inline int aspeed_sdc_tests_init(void)
-{
-	return 0;
-}
-
-static inline void aspeed_sdc_tests_exit(void)
-{
-}
 #endif
 
 static int __init aspeed_sdc_init(void)
@@ -637,18 +618,7 @@ static int __init aspeed_sdc_init(void)
 
 	rc = platform_driver_register(&aspeed_sdc_driver);
 	if (rc < 0)
-		goto cleanup_sdhci;
-
-	rc = aspeed_sdc_tests_init();
-	if (rc < 0) {
-		platform_driver_unregister(&aspeed_sdc_driver);
-		goto cleanup_sdhci;
-	}
-
-	return 0;
-
-cleanup_sdhci:
-	platform_driver_unregister(&aspeed_sdhci_driver);
+		platform_driver_unregister(&aspeed_sdhci_driver);
 
 	return rc;
 }
@@ -656,8 +626,6 @@ module_init(aspeed_sdc_init);
 
 static void __exit aspeed_sdc_exit(void)
 {
-	aspeed_sdc_tests_exit();
-
 	platform_driver_unregister(&aspeed_sdc_driver);
 	platform_driver_unregister(&aspeed_sdhci_driver);
 }
diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index 4bfec8a28064..e76a6c173637 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -28,8 +28,10 @@ config USB4_DEBUGFS_WRITE
 	  this for production systems or distro kernels.
 
 config USB4_KUNIT_TEST
-	bool "KUnit tests"
-	depends on KUNIT=y
+	bool "KUnit tests" if !KUNIT_ALL_TESTS
+	depends on (USB4=m || KUNIT=y)
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 
 config USB4_DMA_TEST
 	tristate "DMA traffic test driver"
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 2889a214dadc..99211f35a5cd 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -872,7 +872,6 @@ int tb_domain_init(void)
 {
 	int ret;
 
-	tb_test_init();
 	tb_debugfs_init();
 	tb_acpi_init();
 
@@ -890,7 +889,6 @@ int tb_domain_init(void)
 err_acpi:
 	tb_acpi_exit();
 	tb_debugfs_exit();
-	tb_test_exit();
 
 	return ret;
 }
@@ -903,5 +901,4 @@ void tb_domain_exit(void)
 	tb_xdomain_exit();
 	tb_acpi_exit();
 	tb_debugfs_exit();
-	tb_test_exit();
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 4602c69913fa..a831faa50f65 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1271,12 +1271,4 @@ static inline void tb_service_debugfs_init(struct tb_service *svc) { }
 static inline void tb_service_debugfs_remove(struct tb_service *svc) { }
 #endif
 
-#ifdef CONFIG_USB4_KUNIT_TEST
-int tb_test_init(void);
-void tb_test_exit(void);
-#else
-static inline int tb_test_init(void) { return 0; }
-static inline void tb_test_exit(void) { }
-#endif
-
 #endif
diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index ee37f8b58f50..24c06e7354cd 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -2817,14 +2817,4 @@ static struct kunit_suite tb_test_suite = {
 	.test_cases = tb_test_cases,
 };
 
-static struct kunit_suite *tb_test_suites[] = { &tb_test_suite, NULL };
-
-int tb_test_init(void)
-{
-	return __kunit_test_suites_init(tb_test_suites);
-}
-
-void tb_test_exit(void)
-{
-	return __kunit_test_suites_exit(tb_test_suites);
-}
+kunit_test_suite(tb_test_suite);
diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
index 2d3d98158121..ce91add81401 100644
--- a/drivers/virt/nitro_enclaves/Kconfig
+++ b/drivers/virt/nitro_enclaves/Kconfig
@@ -16,8 +16,9 @@ config NITRO_ENCLAVES
 	  The module will be called nitro_enclaves.
 
 config NITRO_ENCLAVES_MISC_DEV_TEST
-	bool "Tests for the misc device functionality of the Nitro Enclaves"
-	depends on NITRO_ENCLAVES && KUNIT=y
+	bool "Tests for the misc device functionality of the Nitro Enclaves" if !KUNIT_ALL_TESTS
+	depends on NITRO_ENCLAVES && KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the misc device functionality of the Nitro
 	  Enclaves. Select this option only if you will boot the kernel for
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 20c881b6a4b6..241b94f62e56 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1759,35 +1759,10 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 #if defined(CONFIG_NITRO_ENCLAVES_MISC_DEV_TEST)
 #include "ne_misc_dev_test.c"
-
-static inline int ne_misc_dev_test_init(void)
-{
-	return __kunit_test_suites_init(ne_misc_dev_test_suites);
-}
-
-static inline void ne_misc_dev_test_exit(void)
-{
-	__kunit_test_suites_exit(ne_misc_dev_test_suites);
-}
-#else
-static inline int ne_misc_dev_test_init(void)
-{
-	return 0;
-}
-
-static inline void ne_misc_dev_test_exit(void)
-{
-}
 #endif
 
 static int __init ne_init(void)
 {
-	int rc = 0;
-
-	rc = ne_misc_dev_test_init();
-	if (rc < 0)
-		return rc;
-
 	mutex_init(&ne_cpu_pool.mutex);
 
 	return pci_register_driver(&ne_pci_driver);
@@ -1798,8 +1773,6 @@ static void __exit ne_exit(void)
 	pci_unregister_driver(&ne_pci_driver);
 
 	ne_teardown_cpu_pool();
-
-	ne_misc_dev_test_exit();
 }
 
 module_init(ne_init);
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
index 265797bed0ea..74df43b925be 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
@@ -151,7 +151,4 @@ static struct kunit_suite ne_misc_dev_test_suite = {
 	.test_cases = ne_misc_dev_test_cases,
 };
 
-static struct kunit_suite *ne_misc_dev_test_suites[] = {
-	&ne_misc_dev_test_suite,
-	NULL
-};
+kunit_test_suite(ne_misc_dev_test_suite);
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8ffcd7de9607..c958855681cc 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -237,9 +237,9 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
 unsigned int kunit_test_case_num(struct kunit_suite *suite,
 				 struct kunit_case *test_case);
 
-int __kunit_test_suites_init(struct kunit_suite * const * const suites);
+int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
 
-void __kunit_test_suites_exit(struct kunit_suite **suites);
+void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 int kunit_run_all_tests(void);
@@ -250,43 +250,11 @@ static inline int kunit_run_all_tests(void)
 }
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
 
-#ifdef MODULE
-/**
- * kunit_test_suites_for_module() - used to register one or more
- *			 &struct kunit_suite with KUnit.
- *
- * @__suites: a statically allocated list of &struct kunit_suite.
- *
- * Registers @__suites with the test framework. See &struct kunit_suite for
- * more information.
- *
- * If a test suite is built-in, module_init() gets translated into
- * an initcall which we don't want as the idea is that for builtins
- * the executor will manage execution.  So ensure we do not define
- * module_{init|exit} functions for the builtin case when registering
- * suites via kunit_test_suites() below.
- */
-#define kunit_test_suites_for_module(__suites)				\
-	static int __init kunit_test_suites_init(void)			\
-	{								\
-		return __kunit_test_suites_init(__suites);		\
-	}								\
-	module_init(kunit_test_suites_init);				\
-									\
-	static void __exit kunit_test_suites_exit(void)			\
-	{								\
-		return __kunit_test_suites_exit(__suites);		\
-	}								\
-	module_exit(kunit_test_suites_exit)
-#else
-#define kunit_test_suites_for_module(__suites)
-#endif /* MODULE */
-
-#define __kunit_test_suites(unique_array, unique_suites, ...)		       \
-	static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
-	kunit_test_suites_for_module(unique_array);			       \
-	static struct kunit_suite **unique_suites			       \
-	__used __section(".kunit_test_suites") = unique_array
+#define __kunit_test_suites(unique_array, ...)				       \
+	MODULE_INFO(test, "Y");						       \
+	static struct kunit_suite *unique_array[]			       \
+	__aligned(sizeof(struct kunit_suite *))				       \
+	__used __section(".kunit_test_suites") = { __VA_ARGS__ }
 
 /**
  * kunit_test_suites() - used to register one or more &struct kunit_suite
@@ -294,21 +262,16 @@ static inline int kunit_run_all_tests(void)
  *
  * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suites with the test framework. See &struct kunit_suite for
- * more information.
- *
- * When builtin,  KUnit tests are all run via executor; this is done
- * by placing the array of struct kunit_suite * in the .kunit_test_suites
- * ELF section.
+ * Registers @suites with the test framework.
+ * This is done by placing the array of struct kunit_suite * in the
+ * .kunit_test_suites ELF section.
  *
- * An alternative is to build the tests as a module.  Because modules do not
- * support multiple initcall()s, we need to initialize an array of suites for a
- * module.
+ * When builtin, KUnit tests are all run via the executor at boot, and when
+ * built as a module, they run on module load.
  *
  */
 #define kunit_test_suites(__suites...)						\
 	__kunit_test_suites(__UNIQUE_ID(array),				\
-			    __UNIQUE_ID(suites),			\
 			    ##__suites)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
@@ -320,7 +283,7 @@ static inline int kunit_run_all_tests(void)
  *
  * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * This functions identically as &kunit_test_suites() except that it suppresses
+ * This functions identically as kunit_test_suites() except that it suppresses
  * modpost warnings for referencing functions marked __init or data marked
  * __initdata; this is OK because currently KUnit only runs tests upon boot
  * during the init phase or upon loading a module during the init phase.
diff --git a/include/linux/module.h b/include/linux/module.h
index abd9fa916b7d..518296ea7f73 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -505,6 +505,11 @@ struct module {
 	int num_static_call_sites;
 	struct static_call_site *static_call_sites;
 #endif
+#if IS_ENABLED(CONFIG_KUNIT)
+	int num_kunit_suites;
+	struct kunit_suite **kunit_suites;
+#endif
+
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
diff --git a/include/linux/panic.h b/include/linux/panic.h
index e71161da69c4..c7759b3f2045 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -68,7 +68,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
-#define TAINT_FLAGS_COUNT		18
+#define TAINT_TEST			18
+#define TAINT_FLAGS_COUNT		19
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/kcsan/.kunitconfig b/kernel/kcsan/.kunitconfig
new file mode 100644
index 000000000000..e82f0f52ab0a
--- /dev/null
+++ b/kernel/kcsan/.kunitconfig
@@ -0,0 +1,24 @@
+# Note that the KCSAN tests need to run on an SMP setup.
+# Under kunit_tool, this can be done by using the --qemu_args
+# option to configure a machine with several cores. For example:
+# ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan \
+# 				 --arch=x86_64 --qemu_args="-smp 8"
+
+CONFIG_KUNIT=y
+
+CONFIG_DEBUG_KERNEL=y
+
+# Need some level of concurrency to test a concurrency sanitizer.
+CONFIG_SMP=y
+
+CONFIG_KCSAN=y
+CONFIG_KCSAN_KUNIT_TEST=y
+
+# Set these if you want to run test_barrier_nothreads
+#CONFIG_KCSAN_STRICT=y
+#CONFIG_KCSAN_WEAK_MEMORY=y
+
+# This prevents the test from timing out on many setups. Feel free to remove
+# (or alter) this, in conjunction with setting a different test timeout with,
+# for example, the --timeout kunit_tool option.
+CONFIG_KCSAN_REPORT_ONCE_IN_MS=100
diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..324a770f789c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1988,6 +1988,13 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(info, "license"));
 
+	if (get_modinfo(info, "test")) {
+		if (!test_taint(TAINT_TEST))
+			pr_warn("%s: loading test module taints kernel.\n",
+				mod->name);
+		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
+	}
+
 	return 0;
 }
 
@@ -2087,6 +2094,12 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					      sizeof(*mod->static_call_sites),
 					      &mod->num_static_call_sites);
 #endif
+#ifdef CONFIG_KUNIT
+	mod->kunit_suites = section_objs(info, ".kunit_test_suites",
+					      sizeof(*mod->kunit_suites),
+					      &mod->num_kunit_suites);
+#endif
+
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 
diff --git a/kernel/panic.c b/kernel/panic.c
index a3c758dba15a..6b3369e21026 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -428,6 +428,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
+	[ TAINT_TEST ]			= { 'N', ' ', true },
 };
 
 /**
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 96f96e42ce06..5e223327196a 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -9,8 +9,8 @@
  * These symbols point to the .kunit_test_suites section and are defined in
  * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
  */
-extern struct kunit_suite * const * const __kunit_suites_start[];
-extern struct kunit_suite * const * const __kunit_suites_end[];
+extern struct kunit_suite * const __kunit_suites_start[];
+extern struct kunit_suite * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
@@ -55,7 +55,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
 
 /* Create a copy of suite with only tests that match test_glob. */
 static struct kunit_suite *
-kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
+kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
 {
 	int n = 0;
 	struct kunit_case *filtered, *test_case;
@@ -69,15 +69,15 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
 	if (n == 0)
 		return NULL;
 
-	/* Use memcpy to workaround copy->name being const. */
-	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
+	copy = kmemdup(suite, sizeof(*copy), GFP_KERNEL);
 	if (!copy)
 		return ERR_PTR(-ENOMEM);
-	memcpy(copy, suite, sizeof(*copy));
 
 	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
-	if (!filtered)
+	if (!filtered) {
+		kfree(copy);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	n = 0;
 	kunit_suite_for_each_test_case(suite, test_case) {
@@ -92,62 +92,18 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
 static char *kunit_shutdown;
 core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
 
-static struct kunit_suite * const *
-kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
-		      struct kunit_test_filter *filter)
-{
-	int i, n = 0;
-	struct kunit_suite **filtered, *filtered_suite;
-
-	n = 0;
-	for (i = 0; subsuite[i]; ++i) {
-		if (glob_match(filter->suite_glob, subsuite[i]->name))
-			++n;
-	}
-
-	if (n == 0)
-		return NULL;
-
-	filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
-	if (!filtered)
-		return ERR_PTR(-ENOMEM);
-
-	n = 0;
-	for (i = 0; subsuite[i] != NULL; ++i) {
-		if (!glob_match(filter->suite_glob, subsuite[i]->name))
-			continue;
-		filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
-		if (IS_ERR(filtered_suite))
-			return ERR_CAST(filtered_suite);
-		else if (filtered_suite)
-			filtered[n++] = filtered_suite;
-	}
-	filtered[n] = NULL;
-
-	return filtered;
-}
-
+/* Stores an array of suites, end points one past the end */
 struct suite_set {
-	struct kunit_suite * const * const *start;
-	struct kunit_suite * const * const *end;
+	struct kunit_suite * const *start;
+	struct kunit_suite * const *end;
 };
 
-static void kunit_free_subsuite(struct kunit_suite * const *subsuite)
-{
-	unsigned int i;
-
-	for (i = 0; subsuite[i]; i++)
-		kfree(subsuite[i]);
-
-	kfree(subsuite);
-}
-
 static void kunit_free_suite_set(struct suite_set suite_set)
 {
-	struct kunit_suite * const * const *suites;
+	struct kunit_suite * const *suites;
 
 	for (suites = suite_set.start; suites < suite_set.end; suites++)
-		kunit_free_subsuite(*suites);
+		kfree(*suites);
 	kfree(suite_set.start);
 }
 
@@ -156,7 +112,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 					    int *err)
 {
 	int i;
-	struct kunit_suite * const **copy, * const *filtered_subsuite;
+	struct kunit_suite **copy, *filtered_suite;
 	struct suite_set filtered;
 	struct kunit_test_filter filter;
 
@@ -171,14 +127,19 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 
 	kunit_parse_filter_glob(&filter, filter_glob);
 
-	for (i = 0; i < max; ++i) {
-		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
-		if (IS_ERR(filtered_subsuite)) {
-			*err = PTR_ERR(filtered_subsuite);
+	for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
+		if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
+			continue;
+
+		filtered_suite = kunit_filter_tests(suite_set->start[i], filter.test_glob);
+		if (IS_ERR(filtered_suite)) {
+			*err = PTR_ERR(filtered_suite);
 			return filtered;
 		}
-		if (filtered_subsuite)
-			*copy++ = filtered_subsuite;
+		if (!filtered_suite)
+			continue;
+
+		*copy++ = filtered_suite;
 	}
 	filtered.end = copy;
 
@@ -201,52 +162,33 @@ static void kunit_handle_shutdown(void)
 
 }
 
-static void kunit_print_tap_header(struct suite_set *suite_set)
-{
-	struct kunit_suite * const * const *suites, * const *subsuite;
-	int num_of_suites = 0;
-
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		for (subsuite = *suites; *subsuite != NULL; subsuite++)
-			num_of_suites++;
-
-	pr_info("TAP version 14\n");
-	pr_info("1..%d\n", num_of_suites);
-}
-
 static void kunit_exec_run_tests(struct suite_set *suite_set)
 {
-	struct kunit_suite * const * const *suites;
+	size_t num_suites = suite_set->end - suite_set->start;
 
-	kunit_print_tap_header(suite_set);
+	pr_info("TAP version 14\n");
+	pr_info("1..%zu\n", num_suites);
 
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		__kunit_test_suites_init(*suites);
+	__kunit_test_suites_init(suite_set->start, num_suites);
 }
 
 static void kunit_exec_list_tests(struct suite_set *suite_set)
 {
-	unsigned int i;
-	struct kunit_suite * const * const *suites;
+	struct kunit_suite * const *suites;
 	struct kunit_case *test_case;
 
 	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
 	pr_info("TAP version 14\n");
 
 	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		for (i = 0; (*suites)[i] != NULL; i++) {
-			kunit_suite_for_each_test_case((*suites)[i], test_case) {
-				pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
-			}
+		kunit_suite_for_each_test_case((*suites), test_case) {
+			pr_info("%s.%s\n", (*suites)->name, test_case->name);
 		}
 }
 
 int kunit_run_all_tests(void)
 {
-	struct suite_set suite_set = {
-		.start = __kunit_suites_start,
-		.end = __kunit_suites_end,
-	};
+	struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
 	int err = 0;
 
 	if (filter_glob_param) {
@@ -264,11 +206,10 @@ int kunit_run_all_tests(void)
 	else
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
-	if (filter_glob_param) { /* a copy was made of each array */
+	if (filter_glob_param) { /* a copy was made of each suite */
 		kunit_free_suite_set(suite_set);
 	}
 
-
 out:
 	kunit_handle_shutdown();
 	return err;
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index eac6ff480273..0cea31c27b23 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -9,8 +9,6 @@
 #include <kunit/test.h>
 
 static void kfree_at_end(struct kunit *test, const void *to_free);
-static void free_subsuite_at_end(struct kunit *test,
-				 struct kunit_suite *const *to_free);
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 					    const char *suite_name,
 					    struct kunit_case *test_cases);
@@ -41,126 +39,80 @@ static void parse_filter_test(struct kunit *test)
 	kfree(filter.test_glob);
 }
 
-static void filter_subsuite_test(struct kunit *test)
+static void filter_suites_test(struct kunit *test)
 {
-	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "suite2",
-		.test_glob = NULL,
-	};
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2, NULL */
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
-	free_subsuite_at_end(test, filtered);
+	got = kunit_filter_suites(&suite_set, "suite2", &err);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start);
 
 	/* Validate we just have suite2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
-	KUNIT_EXPECT_FALSE(test, filtered[1]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
+
+	/* Contains one element (end is 1 past end) */
+	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
 }
 
-static void filter_subsuite_test_glob_test(struct kunit *test)
+static void filter_suites_test_glob_test(struct kunit *test)
 {
-	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "suite2",
-		.test_glob = "test2",
-	};
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
-	free_subsuite_at_end(test, filtered);
+	got = kunit_filter_suites(&suite_set, "suite2.test2", &err);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start);
 
 	/* Validate we just have suite2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
-	KUNIT_EXPECT_FALSE(test, filtered[1]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
+	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
 
 	/* Now validate we just have test2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]->test_cases);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->test_cases[0].name, "test2");
-	KUNIT_EXPECT_FALSE(test, filtered[0]->test_cases[1].name);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
+	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
 }
 
-static void filter_subsuite_to_empty_test(struct kunit *test)
+static void filter_suites_to_empty_test(struct kunit *test)
 {
-	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "not_found",
-		.test_glob = NULL,
-	};
+	struct kunit_suite *subsuite[3] = {NULL, NULL};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
+	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	free_subsuite_at_end(test, filtered); /* just in case */
+	got = kunit_filter_suites(&suite_set, "not_found", &err);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	kfree_at_end(test, got.start); /* just in case */
 
-	KUNIT_EXPECT_FALSE_MSG(test, filtered,
-			       "should be NULL to indicate no match");
-}
-
-static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_set)
-{
-	struct kunit_suite * const * const *suites;
-
-	kfree_at_end(test, suite_set->start);
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		free_subsuite_at_end(test, *suites);
-}
-
-static void filter_suites_test(struct kunit *test)
-{
-	/* Suites per-file are stored as a NULL terminated array */
-	struct kunit_suite *subsuites[2][2] = {
-		{NULL, NULL},
-		{NULL, NULL},
-	};
-	/* Match the memory layout of suite_set */
-	struct kunit_suite * const * const suites[2] = {
-		subsuites[0], subsuites[1],
-	};
-
-	const struct suite_set suite_set = {
-		.start = suites,
-		.end = suites + 2,
-	};
-	struct suite_set filtered = {.start = NULL, .end = NULL};
-	int err = 0;
-
-	/* Emulate two files, each having one suite */
-	subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
-	subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
-
-	/* Filter out suite1 */
-	filtered = kunit_filter_suites(&suite_set, "suite0", &err);
-	kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */
-	KUNIT_EXPECT_EQ(test, err, 0);
-	KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t)1);
-
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0][0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
+	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
+				"should be empty to indicate no match");
 }
 
 static struct kunit_case executor_test_cases[] = {
 	KUNIT_CASE(parse_filter_test),
-	KUNIT_CASE(filter_subsuite_test),
-	KUNIT_CASE(filter_subsuite_test_glob_test),
-	KUNIT_CASE(filter_subsuite_to_empty_test),
 	KUNIT_CASE(filter_suites_test),
+	KUNIT_CASE(filter_suites_test_glob_test),
+	KUNIT_CASE(filter_suites_to_empty_test),
 	{}
 };
 
@@ -190,20 +142,6 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 			     (void *)to_free);
 }
 
-static void free_subsuite_res_free(struct kunit_resource *res)
-{
-	kunit_free_subsuite(res->data);
-}
-
-static void free_subsuite_at_end(struct kunit *test,
-				 struct kunit_suite *const *to_free)
-{
-	if (IS_ERR_OR_NULL(to_free))
-		return;
-	kunit_alloc_resource(test, NULL, free_subsuite_res_free,
-			     GFP_KERNEL, (void *)to_free);
-}
-
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 					    const char *suite_name,
 					    struct kunit_case *test_cases)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index a5053a07409f..b73d5bb5c473 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,7 +10,9 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -501,6 +503,9 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
+	/* Taint the kernel so we know we've run tests. */
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
+
 	if (suite->suite_init) {
 		suite->suite_init_err = suite->suite_init(suite);
 		if (suite->suite_init_err) {
@@ -581,11 +586,11 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	suite->suite_init_err = 0;
 }
 
-int __kunit_test_suites_init(struct kunit_suite * const * const suites)
+int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
 {
 	unsigned int i;
 
-	for (i = 0; suites[i] != NULL; i++) {
+	for (i = 0; i < num_suites; i++) {
 		kunit_init_suite(suites[i]);
 		kunit_run_tests(suites[i]);
 	}
@@ -598,17 +603,54 @@ static void kunit_exit_suite(struct kunit_suite *suite)
 	kunit_debugfs_destroy_suite(suite);
 }
 
-void __kunit_test_suites_exit(struct kunit_suite **suites)
+void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
 {
 	unsigned int i;
 
-	for (i = 0; suites[i] != NULL; i++)
+	for (i = 0; i < num_suites; i++)
 		kunit_exit_suite(suites[i]);
 
 	kunit_suite_counter = 1;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
+#ifdef CONFIG_MODULES
+static void kunit_module_init(struct module *mod)
+{
+	__kunit_test_suites_init(mod->kunit_suites, mod->num_kunit_suites);
+}
+
+static void kunit_module_exit(struct module *mod)
+{
+	__kunit_test_suites_exit(mod->kunit_suites, mod->num_kunit_suites);
+}
+
+static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
+			       void *data)
+{
+	struct module *mod = data;
+
+	switch (val) {
+	case MODULE_STATE_LIVE:
+		kunit_module_init(mod);
+		break;
+	case MODULE_STATE_GOING:
+		kunit_module_exit(mod);
+		break;
+	case MODULE_STATE_COMING:
+	case MODULE_STATE_UNFORMED:
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block kunit_mod_nb = {
+	.notifier_call = kunit_module_notify,
+	.priority = 0,
+};
+#endif
+
 struct kunit_kmalloc_array_params {
 	size_t n;
 	size_t size;
@@ -703,13 +745,19 @@ EXPORT_SYMBOL_GPL(kunit_cleanup);
 static int __init kunit_init(void)
 {
 	kunit_debugfs_init();
-
+#ifdef CONFIG_MODULES
+	return register_module_notifier(&kunit_mod_nb);
+#else
 	return 0;
+#endif
 }
 late_initcall(kunit_init);
 
 static void __exit kunit_exit(void)
 {
+#ifdef CONFIG_MODULES
+	unregister_module_notifier(&kunit_mod_nb);
+#endif
 	kunit_debugfs_cleanup();
 }
 module_exit(kunit_exit);
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29d5a841e215..5937212b4433 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2191,6 +2191,9 @@ static void add_header(struct buffer *b, struct module *mod)
 
 	if (strstarts(mod->name, "drivers/staging"))
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
+
+	if (strstarts(mod->name, "tools/testing"))
+		buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
 }
 
 static void add_exported_symbols(struct buffer *buf, struct module *mod)
diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 5c18d2f19862..7954cb23d5f2 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -177,7 +177,7 @@ static void policy_unpack_test_unpack_array_out_of_bounds(struct kunit *test)
 
 	array_size = unpack_array(puf->e, name);
 
-	KUNIT_EXPECT_EQ(test, array_size, (u16)0);
+	KUNIT_EXPECT_EQ(test, array_size, 0);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
 		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
 }
@@ -391,10 +391,10 @@ static void policy_unpack_test_unpack_u16_chunk_basic(struct kunit *test)
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_PTR_EQ(test, (void *)chunk,
+	KUNIT_EXPECT_PTR_EQ(test, chunk,
 			    puf->e->start + TEST_U16_OFFSET + 2);
-	KUNIT_EXPECT_EQ(test, size, (size_t)TEST_U16_DATA);
-	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (void *)(chunk + TEST_U16_DATA));
+	KUNIT_EXPECT_EQ(test, size, TEST_U16_DATA);
+	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (chunk + TEST_U16_DATA));
 }
 
 static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
@@ -408,7 +408,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_EQ(test, size, (size_t)0);
+	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
 }
@@ -430,7 +430,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
 
 	size = unpack_u16_chunk(puf->e, &chunk);
 
-	KUNIT_EXPECT_EQ(test, size, (size_t)0);
+	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
 }
diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
new file mode 100644
index 000000000000..e824ce43b05a
--- /dev/null
+++ b/tools/testing/kunit/configs/arch_uml.config
@@ -0,0 +1,5 @@
+# Config options which are added to UML builds by default
+
+# Enable virtio/pci, as a lot of tests require it.
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
diff --git a/tools/testing/kunit/configs/coverage_uml.config b/tools/testing/kunit/configs/coverage_uml.config
new file mode 100644
index 000000000000..bacb77664fa8
--- /dev/null
+++ b/tools/testing/kunit/configs/coverage_uml.config
@@ -0,0 +1,11 @@
+# This config fragment enables coverage on UML, which is different from the
+# normal gcov used in other arches (no debugfs).
+# Example usage:
+# ./tools/testing/kunit/kunit.py run \
+#   --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
+#   --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
+
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_GCOV=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 13bd72e47da8..e132b0654029 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -10,6 +10,7 @@
 import argparse
 import os
 import re
+import shlex
 import sys
 import time
 
@@ -22,6 +23,7 @@ from typing import Iterable, List, Optional, Sequence, Tuple
 import kunit_json
 import kunit_kernel
 import kunit_parser
+from kunit_printer import stdout
 
 class KunitStatus(Enum):
 	SUCCESS = auto()
@@ -72,7 +74,7 @@ def get_kernel_root_path() -> str:
 
 def config_tests(linux: kunit_kernel.LinuxSourceTree,
 		 request: KunitConfigRequest) -> KunitResult:
-	kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
+	stdout.print_with_timestamp('Configuring KUnit Kernel ...')
 
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir, request.make_options)
@@ -85,7 +87,7 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 
 def build_tests(linux: kunit_kernel.LinuxSourceTree,
 		request: KunitBuildRequest) -> KunitResult:
-	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
+	stdout.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
 	success = linux.build_kernel(request.alltests,
@@ -158,7 +160,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 	test_counts = kunit_parser.TestCounts()
 	exec_time = 0.0
 	for i, filter_glob in enumerate(filter_globs):
-		kunit_parser.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
+		stdout.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
 
 		test_start = time.time()
 		run_result = linux.run_kernel(
@@ -221,7 +223,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 		else:
 			with open(request.json, 'w') as f:
 				f.write(json_str)
-			kunit_parser.print_with_timestamp("Test results stored in %s" %
+			stdout.print_with_timestamp("Test results stored in %s" %
 				os.path.abspath(request.json))
 
 	if test_result.status != kunit_parser.TestStatus.SUCCESS:
@@ -245,7 +247,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 
 	run_end = time.time()
 
-	kunit_parser.print_with_timestamp((
+	stdout.print_with_timestamp((
 		'Elapsed time: %.3fs total, %.3fs configuring, %.3fs ' +
 		'building, %.3fs running\n') % (
 				run_end - run_start,
@@ -291,8 +293,9 @@ def add_common_opts(parser) -> None:
 	parser.add_argument('--kunitconfig',
 			     help='Path to Kconfig fragment that enables KUnit tests.'
 			     ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
-			     'will get  automatically appended.',
-			     metavar='PATH')
+			     'will get  automatically appended. If repeated, the files '
+			     'blindly concatenated, which might not work in all cases.',
+			     action='append', metavar='PATHS')
 	parser.add_argument('--kconfig_add',
 			     help='Additional Kconfig options to append to the '
 			     '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
@@ -323,6 +326,10 @@ def add_common_opts(parser) -> None:
 				  'a QemuArchParams object.'),
 			    type=str, metavar='FILE')
 
+	parser.add_argument('--qemu_args',
+			    help='Additional QEMU arguments, e.g. "-smp 8"',
+			    action='append', metavar='')
+
 def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
@@ -365,7 +372,25 @@ def add_parse_opts(parser) -> None:
 			    'filename is specified',
 			    type=str, const='stdout', default=None, metavar='FILE')
 
-def main(argv, linux=None):
+
+def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
+	"""Returns a LinuxSourceTree based on the user's arguments."""
+	# Allow users to specify multiple arguments in one string, e.g. '-smp 8'
+	qemu_args: List[str] = []
+	if cli_args.qemu_args:
+		for arg in cli_args.qemu_args:
+			qemu_args.extend(shlex.split(arg))
+
+	return kunit_kernel.LinuxSourceTree(cli_args.build_dir,
+			kunitconfig_paths=cli_args.kunitconfig,
+			kconfig_add=cli_args.kconfig_add,
+			arch=cli_args.arch,
+			cross_compile=cli_args.cross_compile,
+			qemu_config_path=cli_args.qemu_config,
+			extra_qemu_args=qemu_args)
+
+
+def main(argv):
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
@@ -412,14 +437,7 @@ def main(argv, linux=None):
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
 
-		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
-					kconfig_add=cli_args.kconfig_add,
-					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile,
-					qemu_config_path=cli_args.qemu_config)
-
+		linux = tree_from_args(cli_args)
 		request = KunitRequest(build_dir=cli_args.build_dir,
 				       make_options=cli_args.make_options,
 				       jobs=cli_args.jobs,
@@ -438,50 +456,29 @@ def main(argv, linux=None):
 				not os.path.exists(cli_args.build_dir)):
 			os.mkdir(cli_args.build_dir)
 
-		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
-					kconfig_add=cli_args.kconfig_add,
-					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile,
-					qemu_config_path=cli_args.qemu_config)
-
+		linux = tree_from_args(cli_args)
 		request = KunitConfigRequest(build_dir=cli_args.build_dir,
 					     make_options=cli_args.make_options)
 		result = config_tests(linux, request)
-		kunit_parser.print_with_timestamp((
+		stdout.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
 				result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
-		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
-					kconfig_add=cli_args.kconfig_add,
-					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile,
-					qemu_config_path=cli_args.qemu_config)
-
+		linux = tree_from_args(cli_args)
 		request = KunitBuildRequest(build_dir=cli_args.build_dir,
 					    make_options=cli_args.make_options,
 					    jobs=cli_args.jobs,
 					    alltests=cli_args.alltests)
 		result = config_and_build_tests(linux, request)
-		kunit_parser.print_with_timestamp((
+		stdout.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
 				result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
-		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
-					kconfig_add=cli_args.kconfig_add,
-					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile,
-					qemu_config_path=cli_args.qemu_config)
-
+		linux = tree_from_args(cli_args)
 		exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
 						build_dir=cli_args.build_dir,
 						json=cli_args.json,
@@ -491,7 +488,7 @@ def main(argv, linux=None):
 						kernel_args=cli_args.kernel_args,
 						run_isolated=cli_args.run_isolated)
 		result = exec_tests(linux, exec_request)
-		kunit_parser.print_with_timestamp((
+		stdout.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 75a8dc1683d4..48b5f34b2e5d 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -8,7 +8,7 @@
 
 from dataclasses import dataclass
 import re
-from typing import List, Set
+from typing import Dict, Iterable, List, Set, Tuple
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
@@ -32,35 +32,51 @@ class Kconfig:
 	"""Represents defconfig or .config specified using the Kconfig language."""
 
 	def __init__(self) -> None:
-		self._entries = []  # type: List[KconfigEntry]
+		self._entries = {}  # type: Dict[str, str]
 
-	def entries(self) -> Set[KconfigEntry]:
-		return set(self._entries)
+	def __eq__(self, other) -> bool:
+		if not isinstance(other, self.__class__):
+			return False
+		return self._entries == other._entries
 
-	def add_entry(self, entry: KconfigEntry) -> None:
-		self._entries.append(entry)
+	def __repr__(self) -> str:
+		return ','.join(str(e) for e in self.as_entries())
+
+	def as_entries(self) -> Iterable[KconfigEntry]:
+		for name, value in self._entries.items():
+			yield KconfigEntry(name, value)
+
+	def add_entry(self, name: str, value: str) -> None:
+		self._entries[name] = value
 
 	def is_subset_of(self, other: 'Kconfig') -> bool:
-		other_dict = {e.name: e.value for e in other.entries()}
-		for a in self.entries():
-			b = other_dict.get(a.name)
+		for name, value in self._entries.items():
+			b = other._entries.get(name)
 			if b is None:
-				if a.value == 'n':
+				if value == 'n':
 					continue
 				return False
-			if a.value != b:
+			if value != b:
 				return False
 		return True
 
+	def conflicting_options(self, other: 'Kconfig') -> List[Tuple[KconfigEntry, KconfigEntry]]:
+		diff = []  # type: List[Tuple[KconfigEntry, KconfigEntry]]
+		for name, value in self._entries.items():
+			b = other._entries.get(name)
+			if b and value != b:
+				pair = (KconfigEntry(name, value), KconfigEntry(name, b))
+				diff.append(pair)
+		return diff
+
 	def merge_in_entries(self, other: 'Kconfig') -> None:
-		if other.is_subset_of(self):
-			return
-		self._entries = list(self.entries().union(other.entries()))
+		for name, value in other._entries.items():
+			self._entries[name] = value
 
 	def write_to_file(self, path: str) -> None:
 		with open(path, 'a+') as f:
-			for entry in self.entries():
-				f.write(str(entry) + '\n')
+			for e in self.as_entries():
+				f.write(str(e) + '\n')
 
 def parse_file(path: str) -> Kconfig:
 	with open(path, 'r') as f:
@@ -78,14 +94,12 @@ def parse_from_string(blob: str) -> Kconfig:
 
 		match = config_matcher.match(line)
 		if match:
-			entry = KconfigEntry(match.group(1), match.group(2))
-			kconfig.add_entry(entry)
+			kconfig.add_entry(match.group(1), match.group(2))
 			continue
 
 		empty_match = is_not_set_matcher.match(line)
 		if empty_match:
-			entry = KconfigEntry(empty_match.group(1), 'n')
-			kconfig.add_entry(entry)
+			kconfig.add_entry(empty_match.group(1), 'n')
 			continue
 
 		if line[0] == '#':
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 3539efaf99ba..f5c26ea89714 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -18,7 +18,7 @@ import threading
 from typing import Iterator, List, Optional, Tuple
 
 import kunit_config
-import kunit_parser
+from kunit_printer import stdout
 import qemu_config
 
 KCONFIG_PATH = '.config'
@@ -26,6 +26,7 @@ KUNITCONFIG_PATH = '.kunitconfig'
 OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
 DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
+UML_KCONFIG_PATH = 'tools/testing/kunit/configs/arch_uml.config'
 OUTFILE_PATH = 'test.log'
 ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
 QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
@@ -53,8 +54,8 @@ class LinuxSourceTreeOperations:
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
-		pass
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
+		return base_kunitconfig
 
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
 		raise ConfigError('Only the "um" arch is supported for alltests')
@@ -109,9 +110,10 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
 
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
 		kconfig = kunit_config.parse_from_string(self._kconfig)
-		base_kunitconfig.merge_in_entries(kconfig)
+		kconfig.merge_in_entries(base_kunitconfig)
+		return kconfig
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		kernel_path = os.path.join(build_dir, self._kernel_path)
@@ -137,8 +139,13 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	def __init__(self, cross_compile=None):
 		super().__init__(linux_arch='um', cross_compile=cross_compile)
 
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
+		kconfig = kunit_config.parse_file(UML_KCONFIG_PATH)
+		kconfig.merge_in_entries(base_kunitconfig)
+		return kconfig
+
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
-		kunit_parser.print_with_timestamp(
+		stdout.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
 		command = ['make', 'ARCH=um', 'O=' + build_dir, 'allyesconfig']
 		if make_options:
@@ -148,18 +155,19 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 			stdout=subprocess.DEVNULL,
 			stderr=subprocess.STDOUT)
 		process.wait()
-		kunit_parser.print_with_timestamp(
+		stdout.print_with_timestamp(
 			'Disabling broken configs to run KUnit tests...')
 
 		with open(get_kconfig_path(build_dir), 'a') as config:
 			with open(BROKEN_ALLCONFIG_PATH, 'r') as disable:
 				config.write(disable.read())
-		kunit_parser.print_with_timestamp(
+		stdout.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = os.path.join(build_dir, 'linux')
+		params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
 		return subprocess.Popen([linux_bin] + params,
 					   stdin=subprocess.PIPE,
 					   stdout=subprocess.PIPE,
@@ -175,22 +183,44 @@ def get_kunitconfig_path(build_dir: str) -> str:
 def get_old_kunitconfig_path(build_dir: str) -> str:
 	return os.path.join(build_dir, OLD_KUNITCONFIG_PATH)
 
+def get_parsed_kunitconfig(build_dir: str,
+			   kunitconfig_paths: Optional[List[str]]=None) -> kunit_config.Kconfig:
+	if not kunitconfig_paths:
+		path = get_kunitconfig_path(build_dir)
+		if not os.path.exists(path):
+			shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, path)
+		return kunit_config.parse_file(path)
+
+	merged = kunit_config.Kconfig()
+
+	for path in kunitconfig_paths:
+		if os.path.isdir(path):
+			path = os.path.join(path, KUNITCONFIG_PATH)
+		if not os.path.exists(path):
+			raise ConfigError(f'Specified kunitconfig ({path}) does not exist')
+
+		partial = kunit_config.parse_file(path)
+		diff = merged.conflicting_options(partial)
+		if diff:
+			diff_str = '\n\n'.join(f'{a}\n  vs from {path}\n{b}' for a, b in diff)
+			raise ConfigError(f'Multiple values specified for {len(diff)} options in kunitconfig:\n{diff_str}')
+		merged.merge_in_entries(partial)
+	return merged
+
 def get_outfile_path(build_dir: str) -> str:
 	return os.path.join(build_dir, OUTFILE_PATH)
 
-def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
+def _default_qemu_config_path(arch: str) -> str:
 	config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
-	if arch == 'um':
-		return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
 	if os.path.isfile(config_path):
-		return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
+		return config_path
 
 	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
 	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
-def get_source_tree_ops_from_qemu_config(config_path: str,
-					 cross_compile: Optional[str]) -> Tuple[
-							 str, LinuxSourceTreeOperations]:
+def _get_qemu_ops(config_path: str,
+		  extra_qemu_args: Optional[List[str]],
+		  cross_compile: Optional[str]) -> Tuple[str, LinuxSourceTreeOperations]:
 	# The module name/path has very little to do with where the actual file
 	# exists (I learned this through experimentation and could not find it
 	# anywhere in the Python documentation).
@@ -210,6 +240,8 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
 	if not hasattr(config, 'QEMU_ARCH'):
 		raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
 	params: qemu_config.QemuArchParams = config.QEMU_ARCH  # type: ignore
+	if extra_qemu_args:
+		params.extra_qemu_params.extend(extra_qemu_args)
 	return params.linux_arch, LinuxSourceTreeOperationsQemu(
 			params, cross_compile=cross_compile)
 
@@ -219,34 +251,24 @@ class LinuxSourceTree:
 	def __init__(
 	      self,
 	      build_dir: str,
-	      load_config=True,
-	      kunitconfig_path='',
+	      kunitconfig_paths: Optional[List[str]]=None,
 	      kconfig_add: Optional[List[str]]=None,
 	      arch=None,
 	      cross_compile=None,
-	      qemu_config_path=None) -> None:
+	      qemu_config_path=None,
+	      extra_qemu_args=None) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 		if qemu_config_path:
-			self._arch, self._ops = get_source_tree_ops_from_qemu_config(
-					qemu_config_path, cross_compile)
+			self._arch, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
 		else:
 			self._arch = 'um' if arch is None else arch
-			self._ops = get_source_tree_ops(self._arch, cross_compile)
-
-		if not load_config:
-			return
+			if self._arch == 'um':
+				self._ops = LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
+			else:
+				qemu_config_path = _default_qemu_config_path(self._arch)
+				_, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
 
-		if kunitconfig_path:
-			if os.path.isdir(kunitconfig_path):
-				kunitconfig_path = os.path.join(kunitconfig_path, KUNITCONFIG_PATH)
-			if not os.path.exists(kunitconfig_path):
-				raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
-		else:
-			kunitconfig_path = get_kunitconfig_path(build_dir)
-			if not os.path.exists(kunitconfig_path):
-				shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
-
-		self._kconfig = kunit_config.parse_file(kunitconfig_path)
+		self._kconfig = get_parsed_kunitconfig(build_dir, kunitconfig_paths)
 		if kconfig_add:
 			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
 			self._kconfig.merge_in_entries(kconfig)
@@ -267,10 +289,10 @@ class LinuxSourceTree:
 		validated_kconfig = kunit_config.parse_file(kconfig_path)
 		if self._kconfig.is_subset_of(validated_kconfig):
 			return True
-		invalid = self._kconfig.entries() - validated_kconfig.entries()
+		missing = set(self._kconfig.as_entries()) - set(validated_kconfig.as_entries())
 		message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
 			  'This is probably due to unsatisfied dependencies.\n' \
-			  'Missing: ' + ', '.join([str(e) for e in invalid])
+			  'Missing: ' + ', '.join(str(e) for e in missing)
 		if self._arch == 'um':
 			message += '\nNote: many Kconfig options aren\'t available on UML. You can try running ' \
 				   'on a different architecture with something like "--arch=x86_64".'
@@ -282,7 +304,7 @@ class LinuxSourceTree:
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		try:
-			self._ops.make_arch_qemuconfig(self._kconfig)
+			self._kconfig = self._ops.make_arch_config(self._kconfig)
 			self._kconfig.write_to_file(kconfig_path)
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
@@ -303,7 +325,7 @@ class LinuxSourceTree:
 			return True
 
 		old_kconfig = kunit_config.parse_file(old_path)
-		return old_kconfig.entries() != self._kconfig.entries()
+		return old_kconfig != self._kconfig
 
 	def build_reconfig(self, build_dir: str, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
@@ -313,7 +335,8 @@ class LinuxSourceTree:
 			return self.build_config(build_dir, make_options)
 
 		existing_kconfig = kunit_config.parse_file(kconfig_path)
-		self._ops.make_arch_qemuconfig(self._kconfig)
+		self._kconfig = self._ops.make_arch_config(self._kconfig)
+
 		if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
 			return True
 		print('Regenerating .config ...')
@@ -334,7 +357,6 @@ class LinuxSourceTree:
 	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		if not args:
 			args = []
-		args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
 
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index c5569b367c69..12d3ec77f427 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -13,10 +13,11 @@ from __future__ import annotations
 import re
 import sys
 
-import datetime
 from enum import Enum, auto
 from typing import Iterable, Iterator, List, Optional, Tuple
 
+from kunit_printer import stdout
+
 class Test:
 	"""
 	A class to represent a test parsed from KTAP results. All KTAP
@@ -55,7 +56,7 @@ class Test:
 	def add_error(self, error_message: str) -> None:
 		"""Records an error that occurred while parsing this test."""
 		self.counts.errors += 1
-		print_with_timestamp(red('[ERROR]') + f' Test: {self.name}: {error_message}')
+		stdout.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
 
 class TestStatus(Enum):
 	"""An enumeration class to represent the status of a test."""
@@ -461,32 +462,6 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 
 DIVIDER = '=' * 60
 
-RESET = '\033[0;0m'
-
-def red(text: str) -> str:
-	"""Returns inputted string with red color code."""
-	if not sys.stdout.isatty():
-		return text
-	return '\033[1;31m' + text + RESET
-
-def yellow(text: str) -> str:
-	"""Returns inputted string with yellow color code."""
-	if not sys.stdout.isatty():
-		return text
-	return '\033[1;33m' + text + RESET
-
-def green(text: str) -> str:
-	"""Returns inputted string with green color code."""
-	if not sys.stdout.isatty():
-		return text
-	return '\033[1;32m' + text + RESET
-
-ANSI_LEN = len(red(''))
-
-def print_with_timestamp(message: str) -> None:
-	"""Prints message with timestamp at beginning."""
-	print('[%s] %s' % (datetime.datetime.now().strftime('%H:%M:%S'), message))
-
 def format_test_divider(message: str, len_message: int) -> str:
 	"""
 	Returns string with message centered in fixed width divider.
@@ -529,12 +504,12 @@ def print_test_header(test: Test) -> None:
 			message += ' (1 subtest)'
 		else:
 			message += f' ({test.expected_count} subtests)'
-	print_with_timestamp(format_test_divider(message, len(message)))
+	stdout.print_with_timestamp(format_test_divider(message, len(message)))
 
 def print_log(log: Iterable[str]) -> None:
 	"""Prints all strings in saved log for test in yellow."""
 	for m in log:
-		print_with_timestamp(yellow(m))
+		stdout.print_with_timestamp(stdout.yellow(m))
 
 def format_test_result(test: Test) -> str:
 	"""
@@ -551,16 +526,16 @@ def format_test_result(test: Test) -> str:
 	String containing formatted test result
 	"""
 	if test.status == TestStatus.SUCCESS:
-		return green('[PASSED] ') + test.name
+		return stdout.green('[PASSED] ') + test.name
 	if test.status == TestStatus.SKIPPED:
-		return yellow('[SKIPPED] ') + test.name
+		return stdout.yellow('[SKIPPED] ') + test.name
 	if test.status == TestStatus.NO_TESTS:
-		return yellow('[NO TESTS RUN] ') + test.name
+		return stdout.yellow('[NO TESTS RUN] ') + test.name
 	if test.status == TestStatus.TEST_CRASHED:
 		print_log(test.log)
-		return red('[CRASHED] ') + test.name
+		return stdout.red('[CRASHED] ') + test.name
 	print_log(test.log)
-	return red('[FAILED] ') + test.name
+	return stdout.red('[FAILED] ') + test.name
 
 def print_test_result(test: Test) -> None:
 	"""
@@ -572,7 +547,7 @@ def print_test_result(test: Test) -> None:
 	Parameters:
 	test - Test object representing current test being printed
 	"""
-	print_with_timestamp(format_test_result(test))
+	stdout.print_with_timestamp(format_test_result(test))
 
 def print_test_footer(test: Test) -> None:
 	"""
@@ -585,8 +560,8 @@ def print_test_footer(test: Test) -> None:
 	test - Test object representing current test being printed
 	"""
 	message = format_test_result(test)
-	print_with_timestamp(format_test_divider(message,
-		len(message) - ANSI_LEN))
+	stdout.print_with_timestamp(format_test_divider(message,
+		len(message) - stdout.color_len()))
 
 def print_summary_line(test: Test) -> None:
 	"""
@@ -603,12 +578,12 @@ def print_summary_line(test: Test) -> None:
 	test - Test object representing current test being printed
 	"""
 	if test.status == TestStatus.SUCCESS:
-		color = green
+		color = stdout.green
 	elif test.status in (TestStatus.SKIPPED, TestStatus.NO_TESTS):
-		color = yellow
+		color = stdout.yellow
 	else:
-		color = red
-	print_with_timestamp(color(f'Testing complete. {test.counts}'))
+		color = stdout.red
+	stdout.print_with_timestamp(color(f'Testing complete. {test.counts}'))
 
 # Other methods:
 
@@ -762,7 +737,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	Return:
 	Test - the main test object with all subtests.
 	"""
-	print_with_timestamp(DIVIDER)
+	stdout.print_with_timestamp(DIVIDER)
 	lines = extract_tap_lines(kernel_output)
 	test = Test()
 	if not lines:
@@ -773,6 +748,6 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 		test = parse_test(lines, 0, [])
 		if test.status != TestStatus.NO_TESTS:
 			test.status = test.counts.get_status()
-	print_with_timestamp(DIVIDER)
+	stdout.print_with_timestamp(DIVIDER)
 	print_summary_line(test)
 	return test
diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
new file mode 100644
index 000000000000..5f1cc55ecdf5
--- /dev/null
+++ b/tools/testing/kunit/kunit_printer.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Utilities for printing and coloring output.
+#
+# Copyright (C) 2022, Google LLC.
+# Author: Daniel Latypov <dlatypov@google.com>
+
+import datetime
+import sys
+import typing
+
+_RESET = '\033[0;0m'
+
+class Printer:
+	"""Wraps a file object, providing utilities for coloring output, etc."""
+
+	def __init__(self, output: typing.IO):
+		self._output = output
+		self._use_color = output.isatty()
+
+	def print(self, message: str) -> None:
+		print(message, file=self._output)
+
+	def print_with_timestamp(self, message: str) -> None:
+		ts = datetime.datetime.now().strftime('%H:%M:%S')
+		self.print(f'[{ts}] {message}')
+
+	def _color(self, code: str, text: str) -> str:
+		if not self._use_color:
+			return text
+		return code + text + _RESET
+
+	def red(self, text: str) -> str:
+		return self._color('\033[1;31m', text)
+
+	def yellow(self, text: str) -> str:
+		return self._color('\033[1;33m', text)
+
+	def green(self, text: str) -> str:
+		return self._color('\033[1;32m', text)
+
+	def color_len(self) -> int:
+		"""Returns the length of the color escape codes."""
+		return len(self.red(''))
+
+# Provides a default instance that prints to stdout
+stdout = Printer(sys.stdout)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 25a2eb3bf114..446ac432d9a4 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -45,7 +45,7 @@ class KconfigTest(unittest.TestCase):
 		self.assertTrue(kconfig0.is_subset_of(kconfig0))
 
 		kconfig1 = kunit_config.Kconfig()
-		kconfig1.add_entry(kunit_config.KconfigEntry('TEST', 'y'))
+		kconfig1.add_entry('TEST', 'y')
 		self.assertTrue(kconfig1.is_subset_of(kconfig1))
 		self.assertTrue(kconfig0.is_subset_of(kconfig1))
 		self.assertFalse(kconfig1.is_subset_of(kconfig0))
@@ -56,40 +56,28 @@ class KconfigTest(unittest.TestCase):
 		kconfig = kunit_config.parse_file(kconfig_path)
 
 		expected_kconfig = kunit_config.Kconfig()
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('UML', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('MMU', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('TEST', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('MK8', 'n'))
-
-		self.assertEqual(kconfig.entries(), expected_kconfig.entries())
+		expected_kconfig.add_entry('UML', 'y')
+		expected_kconfig.add_entry('MMU', 'y')
+		expected_kconfig.add_entry('TEST', 'y')
+		expected_kconfig.add_entry('EXAMPLE_TEST', 'y')
+		expected_kconfig.add_entry('MK8', 'n')
+
+		self.assertEqual(kconfig, expected_kconfig)
 
 	def test_write_to_file(self):
 		kconfig_path = os.path.join(test_tmpdir, '.config')
 
 		expected_kconfig = kunit_config.Kconfig()
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('UML', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('MMU', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('TEST', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('MK8', 'n'))
+		expected_kconfig.add_entry('UML', 'y')
+		expected_kconfig.add_entry('MMU', 'y')
+		expected_kconfig.add_entry('TEST', 'y')
+		expected_kconfig.add_entry('EXAMPLE_TEST', 'y')
+		expected_kconfig.add_entry('MK8', 'n')
 
 		expected_kconfig.write_to_file(kconfig_path)
 
 		actual_kconfig = kunit_config.parse_file(kconfig_path)
-
-		self.assertEqual(actual_kconfig.entries(),
-				 expected_kconfig.entries())
+		self.assertEqual(actual_kconfig, expected_kconfig)
 
 class KUnitParserTest(unittest.TestCase):
 
@@ -222,7 +210,7 @@ class KUnitParserTest(unittest.TestCase):
 
 	def test_no_kunit_output(self):
 		crash_log = test_data_path('test_insufficient_memory.log')
-		print_mock = mock.patch('builtins.print').start()
+		print_mock = mock.patch('kunit_printer.Printer.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
@@ -368,21 +356,53 @@ class LinuxSourceTreeTest(unittest.TestCase):
 
 	def test_invalid_kunitconfig(self):
 		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'nonexistent.* does not exist'):
-			kunit_kernel.LinuxSourceTree('', kunitconfig_path='/nonexistent_file')
+			kunit_kernel.LinuxSourceTree('', kunitconfig_paths=['/nonexistent_file'])
 
 	def test_valid_kunitconfig(self):
 		with tempfile.NamedTemporaryFile('wt') as kunitconfig:
-			kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
+			kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[kunitconfig.name])
 
 	def test_dir_kunitconfig(self):
 		with tempfile.TemporaryDirectory('') as dir:
 			with open(os.path.join(dir, '.kunitconfig'), 'w'):
 				pass
-			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
+			kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir])
+
+	def test_multiple_kunitconfig(self):
+		want_kconfig = kunit_config.Kconfig()
+		want_kconfig.add_entry('KUNIT', 'y')
+		want_kconfig.add_entry('KUNIT_TEST', 'm')
+
+		with tempfile.TemporaryDirectory('') as dir:
+			other = os.path.join(dir, 'otherkunitconfig')
+			with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(other, 'w') as f:
+				f.write('CONFIG_KUNIT_TEST=m')
+				pass
+
+			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir, other])
+			self.assertTrue(want_kconfig.is_subset_of(tree._kconfig), msg=tree._kconfig)
+
+
+	def test_multiple_kunitconfig_invalid(self):
+		with tempfile.TemporaryDirectory('') as dir:
+			other = os.path.join(dir, 'otherkunitconfig')
+			with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(other, 'w') as f:
+				f.write('CONFIG_KUNIT=m')
+
+			with self.assertRaisesRegex(kunit_kernel.ConfigError, '(?s)Multiple values.*CONFIG_KUNIT'):
+				kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir, other])
+
 
 	def test_kconfig_add(self):
+		want_kconfig = kunit_config.Kconfig()
+		want_kconfig.add_entry('NOT_REAL', 'y')
+
 		tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
-		self.assertIn(kunit_config.KconfigEntry('NOT_REAL', 'y'), tree._kconfig.entries())
+		self.assertTrue(want_kconfig.is_subset_of(tree._kconfig), msg=tree._kconfig)
 
 	def test_invalid_arch(self):
 		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
@@ -393,7 +413,7 @@ class LinuxSourceTreeTest(unittest.TestCase):
 			return subprocess.Popen(['echo "hi\nbye"'], shell=True, text=True, stdout=subprocess.PIPE)
 
 		with tempfile.TemporaryDirectory('') as build_dir:
-			tree = kunit_kernel.LinuxSourceTree(build_dir, load_config=False)
+			tree = kunit_kernel.LinuxSourceTree(build_dir)
 			mock.patch.object(tree._ops, 'start', side_effect=fake_start).start()
 
 			with self.assertRaises(ValueError):
@@ -410,6 +430,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=y')
 
 			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops = kunit_kernel.LinuxSourceTreeOperations('none', None)
 			mock_build_config = mock.patch.object(tree, 'build_config').start()
 
 			# Should generate the .config
@@ -427,6 +451,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
 
 			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops = kunit_kernel.LinuxSourceTreeOperations('none', None)
 			mock_build_config = mock.patch.object(tree, 'build_config').start()
 
 			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
@@ -443,6 +471,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
 
 			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops = kunit_kernel.LinuxSourceTreeOperations('none', None)
 			mock_build_config = mock.patch.object(tree, 'build_config').start()
 
 			# ... so we should trigger a call to build_config()
@@ -500,27 +532,28 @@ class KUnitMainTest(unittest.TestCase):
 		with open(path) as file:
 			all_passed_log = file.readlines()
 
-		self.print_mock = mock.patch('builtins.print').start()
+		self.print_mock = mock.patch('kunit_printer.Printer.print').start()
 		self.addCleanup(mock.patch.stopall)
 
-		self.linux_source_mock = mock.Mock()
-		self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
-		self.linux_source_mock.build_kernel = mock.Mock(return_value=True)
-		self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
+		self.mock_linux_init = mock.patch.object(kunit_kernel, 'LinuxSourceTree').start()
+		self.linux_source_mock = self.mock_linux_init.return_value
+		self.linux_source_mock.build_reconfig.return_value = True
+		self.linux_source_mock.build_kernel.return_value = True
+		self.linux_source_mock.run_kernel.return_value = all_passed_log
 
 	def test_config_passes_args_pass(self):
-		kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
+		kunit.main(['config', '--build_dir=.kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_build_passes_args_pass(self):
-		kunit.main(['build'], self.linux_source_mock)
+		kunit.main(['build'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.build_kernel.assert_called_once_with(False, kunit.get_default_jobs(), '.kunit', None)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
-		kunit.main(['exec'], self.linux_source_mock)
+		kunit.main(['exec'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
@@ -528,7 +561,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
-		kunit.main(['run'], self.linux_source_mock)
+		kunit.main(['run'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
@@ -538,13 +571,13 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
-			kunit.main(['exec'], self.linux_source_mock)
+			kunit.main(['exec'])
 		self.assertEqual(e.exception.code, 1)
 
 	def test_run_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run'], self.linux_source_mock)
+			kunit.main(['run'])
 		self.assertEqual(e.exception.code, 1)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
@@ -553,7 +586,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_no_tests(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
 		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run'], self.linux_source_mock)
+			kunit.main(['run'])
 		self.assertEqual(e.exception.code, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=300)
@@ -561,7 +594,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_exec_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['exec', '--raw_output'], self.linux_source_mock)
+		kunit.main(['exec', '--raw_output'])
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
@@ -569,7 +602,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output'], self.linux_source_mock)
+		kunit.main(['run', '--raw_output'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
@@ -578,7 +611,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_raw_output_kunit(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output=kunit'], self.linux_source_mock)
+		kunit.main(['run', '--raw_output=kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
@@ -588,27 +621,27 @@ class KUnitMainTest(unittest.TestCase):
 	def test_run_raw_output_invalid(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run', '--raw_output=invalid'], self.linux_source_mock)
+			kunit.main(['run', '--raw_output=invalid'])
 		self.assertNotEqual(e.exception.code, 0)
 
 	def test_run_raw_output_does_not_take_positional_args(self):
 		# --raw_output is a string flag, but we don't want it to consume
 		# any positional arguments, only ones after an '='
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output', 'filter_glob'], self.linux_source_mock)
+		kunit.main(['run', '--raw_output', 'filter_glob'])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
 
 	def test_exec_timeout(self):
 		timeout = 3453
-		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
+		kunit.main(['exec', '--timeout', str(timeout)])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
 		timeout = 3453
-		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
+		kunit.main(['run', '--timeout', str(timeout)])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
@@ -616,7 +649,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_builddir(self):
 		build_dir = '.kunit'
-		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
+		kunit.main(['run', '--build_dir=.kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir=build_dir, filter_glob='', timeout=300)
@@ -624,60 +657,81 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_config_builddir(self):
 		build_dir = '.kunit'
-		kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
+		kunit.main(['config', '--build_dir', build_dir])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 
 	def test_build_builddir(self):
 		build_dir = '.kunit'
 		jobs = kunit.get_default_jobs()
-		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
+		kunit.main(['build', '--build_dir', build_dir])
 		self.linux_source_mock.build_kernel.assert_called_once_with(False, jobs, build_dir, None)
 
 	def test_exec_builddir(self):
 		build_dir = '.kunit'
-		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
+		kunit.main(['exec', '--build_dir', build_dir])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
-	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
-	def test_run_kunitconfig(self, mock_linux_init):
-		mock_linux_init.return_value = self.linux_source_mock
+	def test_run_kunitconfig(self):
 		kunit.main(['run', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
-		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path='mykunitconfig',
-							kconfig_add=None,
-							arch='um',
-							cross_compile=None,
-							qemu_config_path=None)
+		self.mock_linux_init.assert_called_once_with('.kunit',
+						kunitconfig_paths=['mykunitconfig'],
+						kconfig_add=None,
+						arch='um',
+						cross_compile=None,
+						qemu_config_path=None,
+						extra_qemu_args=[])
+
+	def test_config_kunitconfig(self):
+		kunit.main(['config', '--kunitconfig=mykunitconfig'])
+		# Just verify that we parsed and initialized it correctly here.
+		self.mock_linux_init.assert_called_once_with('.kunit',
+						kunitconfig_paths=['mykunitconfig'],
+						kconfig_add=None,
+						arch='um',
+						cross_compile=None,
+						qemu_config_path=None,
+						extra_qemu_args=[])
 
 	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
-	def test_config_kunitconfig(self, mock_linux_init):
+	def test_run_multiple_kunitconfig(self, mock_linux_init):
 		mock_linux_init.return_value = self.linux_source_mock
-		kunit.main(['config', '--kunitconfig=mykunitconfig'])
+		kunit.main(['run', '--kunitconfig=mykunitconfig', '--kunitconfig=other'])
 		# Just verify that we parsed and initialized it correctly here.
 		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path='mykunitconfig',
+							kunitconfig_paths=['mykunitconfig', 'other'],
 							kconfig_add=None,
 							arch='um',
 							cross_compile=None,
-							qemu_config_path=None)
+							qemu_config_path=None,
+							extra_qemu_args=[])
 
-	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
-	def test_run_kconfig_add(self, mock_linux_init):
-		mock_linux_init.return_value = self.linux_source_mock
+	def test_run_kconfig_add(self):
 		kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
 		# Just verify that we parsed and initialized it correctly here.
-		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path=None,
-							kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
-							arch='um',
-							cross_compile=None,
-							qemu_config_path=None)
+		self.mock_linux_init.assert_called_once_with('.kunit',
+						kunitconfig_paths=None,
+						kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
+						arch='um',
+						cross_compile=None,
+						qemu_config_path=None,
+						extra_qemu_args=[])
+
+	def test_run_qemu_args(self):
+		kunit.main(['run', '--arch=x86_64', '--qemu_args', '-m 2048'])
+		# Just verify that we parsed and initialized it correctly here.
+		self.mock_linux_init.assert_called_once_with('.kunit',
+						kunitconfig_paths=None,
+						kconfig_add=None,
+						arch='x86_64',
+						cross_compile=None,
+						qemu_config_path=None,
+						extra_qemu_args=['-m', '2048'])
 
 	def test_run_kernel_args(self):
-		kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'], self.linux_source_mock)
+		kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
@@ -699,7 +753,7 @@ class KUnitMainTest(unittest.TestCase):
 	@mock.patch.object(kunit, '_list_tests')
 	def test_run_isolated_by_suite(self, mock_tests):
 		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
-		kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'], self.linux_source_mock)
+		kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'])
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
@@ -712,7 +766,7 @@ class KUnitMainTest(unittest.TestCase):
 	@mock.patch.object(kunit, '_list_tests')
 	def test_run_isolated_by_test(self, mock_tests):
 		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
-		kunit.main(['exec', '--run_isolated=test', 'suite*'], self.linux_source_mock)
+		kunit.main(['exec', '--run_isolated=test', 'suite*'])
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
index e2ea41de3f35..63cd7487373f 100644
--- a/tools/testing/selftests/kselftest_module.h
+++ b/tools/testing/selftests/kselftest_module.h
@@ -3,6 +3,7 @@
 #define __KSELFTEST_MODULE_H
 
 #include <linux/module.h>
+#include <linux/panic.h>
 
 /*
  * Test framework for writing test modules to be loaded by kselftest.
@@ -41,6 +42,7 @@ static inline int kstm_report(unsigned int total_tests, unsigned int failed_test
 static int __init __module##_init(void)			\
 {							\
 	pr_info("loaded.\n");				\
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);	\
 	selftest();					\
 	return kstm_report(total_tests, failed_tests, skipped_tests);	\
 }							\
@@ -51,4 +53,6 @@ static void __exit __module##_exit(void)		\
 module_init(__module##_init);				\
 module_exit(__module##_exit)
 
+MODULE_INFO(test, "Y");
+
 #endif	/* __KSELFTEST_MODULE_H */

--------------168D46355E674F70E901330E--
