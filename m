Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8564E2B71E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgKQW71 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 17:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgKQW71 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 17:59:27 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0741C0613CF
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 14:59:25 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u21so22962545iol.12
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 14:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=ZNZfLdfPg2rhI0kEjpMy1spLtaHaJqqRILZIrFiFIwY=;
        b=YeE77YiYsdAhb4eCb1zdZ4oxFxQ88WXdoD/KFHCCSj+GAXONlVSOWDWk4QuXwgO1U9
         f4G8vvOidOk8hZM+UcB5zHYkHLYsQkM8oN2ZoDzxC29ixc3ImYS9Ay+9T+ChVcOl0lWj
         OwKiH4GpjajEjOAeZnhCrlf93rSd22ssHn4oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=ZNZfLdfPg2rhI0kEjpMy1spLtaHaJqqRILZIrFiFIwY=;
        b=MI70unEFTiTWbc/GfT018GFlihn5o6k7tm1dIZJElXjohFOygUP8Tr132CjLrl0kN1
         Rpf5Nv6eOxPQZJ12vcjFdbxBfwzRkF7Xw6pxCVxifMplK5MayjqGTbjAuTG8l1+GaEGp
         GawWX0crbki6uyJBhqAi8/AiVMStMoho+PCss4AeNZ78mJTNu694PCSGHSZbJPn4G5JC
         hJoH+TJJtAG9x//zPkLe2naXIriyDIQi8MucbztgJZzSD7qrltssfuSSlQQiMezRBI26
         8BBbhhQdZLHpewJZSQBH85Jpb21uA0HnZ7X20AFzjVv5JA/fehu5WVQs5/MKnp/x/4Yg
         uuAA==
X-Gm-Message-State: AOAM533UyI+xSbmPk+5Ehym8yWXI1gF8hQj2v1e53IWbF0d/k/U1Xoec
        j8Y0tOSkKqV3mHok7tUfd+ZM1Db9dk8GDg==
X-Google-Smtp-Source: ABdhPJwSeTmTr4PxTkDn1hrxsvc5p1ZcSGSEzgpzUVEUce3vioHaItEgW09LoacnyVgHhrXpFuAxBA==
X-Received: by 2002:a5e:da0a:: with SMTP id x10mr2551720ioj.86.1605653965201;
        Tue, 17 Nov 2020 14:59:25 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e13sm14446991ili.67.2020.11.17.14.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:59:24 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kunit fixes update for Linux 5.10-rc5
Message-ID: <0edb729f-b8bb-43ef-0d38-03d0f318cf2b@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 15:59:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A5E06606F687EE9ECF6E4BF0"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------A5E06606F687EE9ECF6E4BF0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kunit fixes update for Linux 5.10-rc5.

This Kunit update for Linux 5.10-rc5 consists of several fixes Kunit
documentation, tool, compile time fixes not pollute source directory,
and fix to remove tools/testing/kunit/.gitattributes file.

diff is attached.

Brendan fixed the weirdness with tools/testing/kunit/.gitattributes
file. Thanks for noticing it.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0d0d245104a42e593adcf11396017a6420c08ba8:

   kunit: tools: fix kunit_tool tests for parsing test plans (2020-10-26 
13:25:40 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-fixes-5.10-rc5

for you to fetch changes up to 3084db0e0d5076cd48408274ab0911cd3ccdae88:

   kunit: fix display of failed expectations for strings (2020-11-10 
13:45:15 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.10-rc5

This Kunit update for Linux 5.10-rc5 consists of several fixes Kunit
documentation, tool, compile time fixes not pollute source directory,
and fix to remove tools/testing/kunit/.gitattributes file.

----------------------------------------------------------------
Andy Shevchenko (2):
       kunit: Do not pollute source directory with generated files 
(.kunitconfig)
       kunit: Do not pollute source directory with generated files 
(test.log)

Brendan Higgins (1):
       kunit: tool: unmark test_data as binary blobs

Daniel Latypov (4):
       kunit: tool: fix pre-existing python type annotation errors
       kunit: tool: print out stderr from make (like build warnings)
       kunit: tool: fix extra trailing \n in raw + parsed test output
       kunit: fix display of failed expectations for strings

David Gow (1):
       kunit: Fix kunit.py parse subcommand (use null build_dir)

Randy Dunlap (3):
       KUnit: Docs: fix a wording typo
       KUnit: Docs: style: fix some Kconfig example issues
       KUnit: Docs: usage: wording fixes

  Documentation/dev-tools/kunit/faq.rst   |  2 +-
  Documentation/dev-tools/kunit/style.rst | 18 +++++------
  Documentation/dev-tools/kunit/usage.rst | 10 +++----
  include/kunit/test.h                    |  2 +-
  tools/testing/kunit/.gitattributes      |  1 -
  tools/testing/kunit/kunit.py            | 27 ++++++++---------
  tools/testing/kunit/kunit_kernel.py     | 53 
+++++++++++++++++++++++++--------
  tools/testing/kunit/kunit_parser.py     | 17 ++++++-----
  tools/testing/kunit/kunit_tool_test.py  |  4 +--
  9 files changed, 80 insertions(+), 54 deletions(-)
  delete mode 100644 tools/testing/kunit/.gitattributes

----------------------------------------------------------------


--------------A5E06606F687EE9ECF6E4BF0
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.10-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.10-rc5.diff"

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index 1628862e7024..8d5029ad210a 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -90,7 +90,7 @@ things to try.
    re-run kunit_tool.
 5. Try to run ``make ARCH=um defconfig`` before running ``kunit.py run``. This
    may help clean up any residual config items which could be causing problems.
-6. Finally, try running KUnit outside UML. KUnit and KUnit tests can run be
+6. Finally, try running KUnit outside UML. KUnit and KUnit tests can be
    built into any kernel, or can be built as a module and loaded at runtime.
    Doing so should allow you to determine if UML is causing the issue you're
    seeing. When tests are built-in, they will execute when the kernel boots, and
diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
index da1d6f0ed6bc..8dbcdc552606 100644
--- a/Documentation/dev-tools/kunit/style.rst
+++ b/Documentation/dev-tools/kunit/style.rst
@@ -175,17 +175,17 @@ An example Kconfig entry:
 
 .. code-block:: none
 
-        config FOO_KUNIT_TEST
-                tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
-                depends on KUNIT
-                default KUNIT_ALL_TESTS
-                help
-                    This builds unit tests for foo.
+	config FOO_KUNIT_TEST
+		tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
+		depends on KUNIT
+		default KUNIT_ALL_TESTS
+		help
+		  This builds unit tests for foo.
 
-                    For more information on KUnit and unit tests in general, please refer
-                    to the KUnit documentation in Documentation/dev-tools/kunit
+		  For more information on KUnit and unit tests in general, please refer
+		  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
-                    If unsure, say N
+		  If unsure, say N.
 
 
 Test File and Module Names
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 62142a47488c..9c28c518e6a3 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -92,7 +92,7 @@ behavior of a function called ``add``; the first parameter is always of type
 the second parameter, in this case, is what the value is expected to be; the
 last value is what the value actually is. If ``add`` passes all of these
 expectations, the test case, ``add_test_basic`` will pass; if any one of these
-expectations fail, the test case will fail.
+expectations fails, the test case will fail.
 
 It is important to understand that a test case *fails* when any expectation is
 violated; however, the test will continue running, potentially trying other
@@ -202,7 +202,7 @@ Example:
 	kunit_test_suite(example_test_suite);
 
 In the above example the test suite, ``example_test_suite``, would run the test
-cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``,
+cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``;
 each would have ``example_test_init`` called immediately before it and would
 have ``example_test_exit`` called immediately after it.
 ``kunit_test_suite(example_test_suite)`` registers the test suite with the
@@ -229,7 +229,7 @@ through some sort of indirection where a function is exposed as part of an API
 such that the definition of that function can be changed without affecting the
 rest of the code base. In the kernel this primarily comes from two constructs,
 classes, structs that contain function pointers that are provided by the
-implementer, and architecture specific functions which have definitions selected
+implementer, and architecture-specific functions which have definitions selected
 at compile time.
 
 Classes
@@ -459,7 +459,7 @@ KUnit on non-UML architectures
 By default KUnit uses UML as a way to provide dependencies for code under test.
 Under most circumstances KUnit's usage of UML should be treated as an
 implementation detail of how KUnit works under the hood. Nevertheless, there
-are instances where being able to run architecture specific code or test
+are instances where being able to run architecture-specific code or test
 against real hardware is desirable. For these reasons KUnit supports running on
 other architectures.
 
@@ -599,7 +599,7 @@ writing normal KUnit tests. One special caveat is that you have to reset
 hardware state in between test cases; if this is not possible, you may only be
 able to run one test case per invocation.
 
-.. TODO(brendanhiggins@google.com): Add an actual example of an architecture
+.. TODO(brendanhiggins@google.com): Add an actual example of an architecture-
    dependent KUnit test.
 
 KUnit debugfs representation
diff --git a/include/kunit/test.h b/include/kunit/test.h
index db1b0ae666c4..df60be7e22ca 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1105,7 +1105,7 @@ do {									       \
 	KUNIT_ASSERTION(test,						       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
-			KUNIT_INIT_BINARY_ASSERT_STRUCT(test,		       \
+			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,	       \
 							assert_type,	       \
 							#op,		       \
 							#left,		       \
diff --git a/tools/testing/kunit/.gitattributes b/tools/testing/kunit/.gitattributes
deleted file mode 100644
index 5b7da1fc3b8f..000000000000
--- a/tools/testing/kunit/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-test_data/* binary
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index ebf5f5763dee..d4f7846d0745 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -11,7 +11,6 @@ import argparse
 import sys
 import os
 import time
-import shutil
 
 from collections import namedtuple
 from enum import Enum, auto
@@ -44,11 +43,6 @@ class KunitStatus(Enum):
 	BUILD_FAILURE = auto()
 	TEST_FAILURE = auto()
 
-def create_default_kunitconfig():
-	if not os.path.exists(kunit_kernel.kunitconfig_path):
-		shutil.copyfile('arch/um/configs/kunit_defconfig',
-				kunit_kernel.kunitconfig_path)
-
 def get_kernel_root_path():
 	parts = sys.argv[0] if not __file__ else __file__
 	parts = os.path.realpath(parts).split('tools/testing/kunit')
@@ -61,7 +55,6 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
 
 	config_start = time.time()
-	create_default_kunitconfig()
 	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
@@ -262,12 +255,12 @@ def main(argv, linux=None):
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
 
-		if not os.path.exists(kunit_kernel.kunitconfig_path):
-			create_default_kunitconfig()
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
+		linux.create_kunitconfig(cli_args.build_dir)
+		linux.read_kunitconfig(cli_args.build_dir)
+
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
 				       cli_args.jobs,
@@ -283,12 +276,12 @@ def main(argv, linux=None):
 				not os.path.exists(cli_args.build_dir)):
 			os.mkdir(cli_args.build_dir)
 
-		if not os.path.exists(kunit_kernel.kunitconfig_path):
-			create_default_kunitconfig()
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
+		linux.create_kunitconfig(cli_args.build_dir)
+		linux.read_kunitconfig(cli_args.build_dir)
+
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
 		result = config_tests(linux, request)
@@ -301,6 +294,9 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
+		linux.create_kunitconfig(cli_args.build_dir)
+		linux.read_kunitconfig(cli_args.build_dir)
+
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
 					    cli_args.alltests,
@@ -315,6 +311,9 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
+		linux.create_kunitconfig(cli_args.build_dir)
+		linux.read_kunitconfig(cli_args.build_dir)
+
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
 						cli_args.alltests)
@@ -337,7 +336,7 @@ def main(argv, linux=None):
 				kunit_output = f.read().splitlines()
 		request = KunitParseRequest(cli_args.raw_output,
 					    kunit_output,
-					    cli_args.build_dir,
+					    None,
 					    cli_args.json)
 		result = parse_tests(request)
 		if result.status != KunitStatus.SUCCESS:
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index b557b1e93f98..2e3cc0fac726 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,10 +6,10 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
-
 import logging
 import subprocess
 import os
+import shutil
 import signal
 
 from contextlib import ExitStack
@@ -18,8 +18,10 @@ import kunit_config
 import kunit_parser
 
 KCONFIG_PATH = '.config'
-kunitconfig_path = '.kunitconfig'
+KUNITCONFIG_PATH = '.kunitconfig'
+DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
+OUTFILE_PATH = 'test.log'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -82,36 +84,51 @@ class LinuxSourceTreeOperations(object):
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command, stderr=subprocess.STDOUT)
+			proc = subprocess.Popen(command,
+						stderr=subprocess.PIPE,
+						stdout=subprocess.DEVNULL)
 		except OSError as e:
-			raise BuildError('Could not call execute make: ' + str(e))
-		except subprocess.CalledProcessError as e:
-			raise BuildError(e.output.decode())
-
-	def linux_bin(self, params, timeout, build_dir, outfile):
+			raise BuildError('Could not call make command: ' + str(e))
+		_, stderr = proc.communicate()
+		if proc.returncode != 0:
+			raise BuildError(stderr.decode())
+		if stderr:  # likely only due to build warnings
+			print(stderr.decode())
+
+	def linux_bin(self, params, timeout, build_dir):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = './linux'
 		if build_dir:
 			linux_bin = os.path.join(build_dir, 'linux')
+		outfile = get_outfile_path(build_dir)
 		with open(outfile, 'w') as output:
 			process = subprocess.Popen([linux_bin] + params,
 						   stdout=output,
 						   stderr=subprocess.STDOUT)
 			process.wait(timeout)
 
-
 def get_kconfig_path(build_dir):
 	kconfig_path = KCONFIG_PATH
 	if build_dir:
 		kconfig_path = os.path.join(build_dir, KCONFIG_PATH)
 	return kconfig_path
 
+def get_kunitconfig_path(build_dir):
+	kunitconfig_path = KUNITCONFIG_PATH
+	if build_dir:
+		kunitconfig_path = os.path.join(build_dir, KUNITCONFIG_PATH)
+	return kunitconfig_path
+
+def get_outfile_path(build_dir):
+	outfile_path = OUTFILE_PATH
+	if build_dir:
+		outfile_path = os.path.join(build_dir, OUTFILE_PATH)
+	return outfile_path
+
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
 	def __init__(self):
-		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(kunitconfig_path)
 		self._ops = LinuxSourceTreeOperations()
 		signal.signal(signal.SIGINT, self.signal_handler)
 
@@ -123,6 +140,16 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
+	def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH):
+		kunitconfig_path = get_kunitconfig_path(build_dir)
+		if not os.path.exists(kunitconfig_path):
+			shutil.copyfile(defconfig, kunitconfig_path)
+
+	def read_kunitconfig(self, build_dir):
+		kunitconfig_path = get_kunitconfig_path(build_dir)
+		self._kconfig = kunit_config.Kconfig()
+		self._kconfig.read_from_file(kunitconfig_path)
+
 	def validate_config(self, build_dir):
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.Kconfig()
@@ -178,8 +205,8 @@ class LinuxSourceTree(object):
 
 	def run_kernel(self, args=[], build_dir='', timeout=None):
 		args.extend(['mem=1G'])
-		outfile = 'test.log'
-		self._ops.linux_bin(args, timeout, build_dir, outfile)
+		self._ops.linux_bin(args, timeout, build_dir)
+		outfile = get_outfile_path(build_dir)
 		subprocess.call(['stty', 'sane'])
 		with open(outfile, 'r') as file:
 			for line in file:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 84a1af2581f5..bbfe1b4e4c1c 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,7 +12,7 @@ from collections import namedtuple
 from datetime import datetime
 from enum import Enum, auto
 from functools import reduce
-from typing import List
+from typing import List, Optional, Tuple
 
 TestResult = namedtuple('TestResult', ['status','suites','log'])
 
@@ -54,6 +54,7 @@ kunit_end_re = re.compile('(List of all partitions:|'
 def isolate_kunit_output(kernel_output):
 	started = False
 	for line in kernel_output:
+		line = line.rstrip()  # line always has a trailing \n
 		if kunit_start_re.search(line):
 			prefix_len = len(line.split('TAP version')[0])
 			started = True
@@ -65,7 +66,7 @@ def isolate_kunit_output(kernel_output):
 
 def raw_output(kernel_output):
 	for line in kernel_output:
-		print(line)
+		print(line.rstrip())
 
 DIVIDER = '=' * 60
 
@@ -151,7 +152,7 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-def parse_test_case(lines: List[str]) -> TestCase:
+def parse_test_case(lines: List[str]) -> Optional[TestCase]:
 	test_case = TestCase()
 	save_non_diagnositic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
@@ -163,7 +164,7 @@ def parse_test_case(lines: List[str]) -> TestCase:
 
 SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
 
-def parse_subtest_header(lines: List[str]) -> str:
+def parse_subtest_header(lines: List[str]) -> Optional[str]:
 	consume_non_diagnositic(lines)
 	if not lines:
 		return None
@@ -176,7 +177,7 @@ def parse_subtest_header(lines: List[str]) -> str:
 
 SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
-def parse_subtest_plan(lines: List[str]) -> int:
+def parse_subtest_plan(lines: List[str]) -> Optional[int]:
 	consume_non_diagnositic(lines)
 	match = SUBTEST_PLAN.match(lines[0])
 	if match:
@@ -230,7 +231,7 @@ def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
-def parse_test_suite(lines: List[str], expected_suite_index: int) -> TestSuite:
+def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
 	if not lines:
 		return None
 	consume_non_diagnositic(lines)
@@ -271,7 +272,7 @@ def parse_tap_header(lines: List[str]) -> bool:
 
 TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
 
-def parse_test_plan(lines: List[str]) -> int:
+def parse_test_plan(lines: List[str]) -> Optional[int]:
 	consume_non_diagnositic(lines)
 	match = TEST_PLAN.match(lines[0])
 	if match:
@@ -310,7 +311,7 @@ def parse_test_result(lines: List[str]) -> TestResult:
 	else:
 		return TestResult(TestStatus.NO_TESTS, [], lines)
 
-def print_and_count_results(test_result: TestResult) -> None:
+def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
 	total_tests = 0
 	failed_tests = 0
 	crashed_tests = 0
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0b60855fb819..497ab51bc170 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -102,7 +102,7 @@ class KUnitParserTest(unittest.TestCase):
 			'test_data/test_output_isolated_correctly.log')
 		file = open(log_path)
 		result = kunit_parser.isolate_kunit_output(file.readlines())
-		self.assertContains('TAP version 14\n', result)
+		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: example', result)
 		self.assertContains('	1..2', result)
 		self.assertContains('	ok 1 - example_simple_test', result)
@@ -115,7 +115,7 @@ class KUnitParserTest(unittest.TestCase):
 			'test_data/test_pound_sign.log')
 		with open(log_path) as file:
 			result = kunit_parser.isolate_kunit_output(file.readlines())
-		self.assertContains('TAP version 14\n', result)
+		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: kunit-resource-test', result)
 		self.assertContains('	1..5', result)
 		self.assertContains('	ok 1 - kunit_resource_test_init_resources', result)

--------------A5E06606F687EE9ECF6E4BF0--
