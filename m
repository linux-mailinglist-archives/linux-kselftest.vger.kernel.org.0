Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708343011C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Jan 2021 01:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAWAn6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jan 2021 19:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbhAWAns (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jan 2021 19:43:48 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36760C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jan 2021 16:43:07 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id w8so8098764oie.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jan 2021 16:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=q2Lm7TZTT02iammLW0fHIpZPPPL6/bHMpEdhCWv77FE=;
        b=esStOpfwNkqZ4fpzusCU7uP9jEbI0l3K0I8e8ZQ+aJK4FqJGgoabk6KKztI+trMJqD
         GbhqUshkmiMBnU4NTA9uH8uzgR0Ldcas/gY5BRuADJrg9FXWd9hzrX61ag7Mx9jofg/j
         xqh5nCCqiR5shhxcvUqx/oWyAAY2sxxji5NKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=q2Lm7TZTT02iammLW0fHIpZPPPL6/bHMpEdhCWv77FE=;
        b=qXpn+PJcjU6s0MtIJIvLU8TMofJSfxKW9HI0mXOpL+0va/vjTWyK3sRK8TQOZYyJGR
         vfb5UBb/1sHVvBWDzxTJU5bRpKXpW9oNg3SFzO02Us1aQ5UQb1dhXhWoRRMKv+GFKwNg
         /nWwHg0txUpj5alNnHqBPuyKHiF5kJPLmgxx8d0XJLarJSlB/7ocnk7IQOZVEMxS+mJT
         /Hc5rruLsVXNcdaKdwlK76QJtvwVPti+au/E2Y9FQIHtKwnd3gYAStHdho6qL+BfZsms
         8ZGsq1yPJp16waENRLKa4nmvBpUZFM0vx95NU6sX4FRsTURMLvXKh6SO3IXqEy06ewjd
         nupg==
X-Gm-Message-State: AOAM532oIF32MEhpLXxdawrjWALUgMhcPaKrvXpoThMxxmam9ik+ZLFY
        uTKHECYChis1LUbDYRx6K8LGuDIZJ4PhYw==
X-Google-Smtp-Source: ABdhPJyRa2q3HdS5hxpZRgR+KiQUvl0ra8DZUrWQLwHMxe9xB5KOSt85k6l9D0FUFxwo7JsV3ls/+w==
X-Received: by 2002:aca:5388:: with SMTP id h130mr5216093oib.110.1611362586627;
        Fri, 22 Jan 2021 16:43:06 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z10sm2013124otk.8.2021.01.22.16.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 16:43:05 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.11-rc5
Message-ID: <137b3eea-4bfe-9026-e647-1861bc62ccf9@linuxfoundation.org>
Date:   Fri, 22 Jan 2021 17:43:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CAAFC25748C28CDDDD15F7FA"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------CAAFC25748C28CDDDD15F7FA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 5.11-rc5.

This KUnit update for Linux 5.11-rc5 consists of 5 fixes to kunit tool
and documentation from Daniel Latypov and David Gow.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 65a4e5299739abe0888cda0938d21f8ea3b5c606:

   kunit: tool: Force the use of the 'tty' console for UML (2021-01-04 
09:18:38 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-fixes-5.11-rc5

for you to fetch changes up to 2b8fdbbf1c616300312f71fe5b21fe8f03129950:

   kunit: tool: move kunitconfig parsing into __init__, make it optional 
(2021-01-15 17:52:12 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.11-rc5

This KUnit update for Linux 5.11-rc5 consist of 5 fixes to kunit tool
and documentation from Daniel Latypov and David Gow.

----------------------------------------------------------------
Daniel Latypov (4):
       Documentation: kunit: include example of a parameterized test
       kunit: tool: surface and address more typing issues
       kunit: tool: fix minor typing issue with None status
       kunit: tool: move kunitconfig parsing into __init__, make it optional

David Gow (1):
       kunit: tool: Fix spelling of "diagnostic" in kunit_parser

  Documentation/dev-tools/kunit/usage.rst | 57 +++++++++++++++++++++++
  tools/testing/kunit/kunit.py            | 34 +++++---------
  tools/testing/kunit/kunit_config.py     |  7 +--
  tools/testing/kunit/kunit_json.py       |  2 +-
  tools/testing/kunit/kunit_kernel.py     | 54 +++++++++++-----------
  tools/testing/kunit/kunit_parser.py     | 81 
++++++++++++++++-----------------
  6 files changed, 141 insertions(+), 94 deletions(-)
----------------------------------------------------------------

--------------CAAFC25748C28CDDDD15F7FA
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.11-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.11-rc5.diff"

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index d9fdc14f0677..650f99590df5 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -522,6 +522,63 @@ There's more boilerplate involved, but it can:
   * E.g. if we wanted to also test ``sha256sum``, we could add a ``sha256``
     field and reuse ``cases``.
 
+* be converted to a "parameterized test", see below.
+
+Parameterized Testing
+~~~~~~~~~~~~~~~~~~~~~
+
+The table-driven testing pattern is common enough that KUnit has special
+support for it.
+
+Reusing the same ``cases`` array from above, we can write the test as a
+"parameterized test" with the following.
+
+.. code-block:: c
+
+	// This is copy-pasted from above.
+	struct sha1_test_case {
+		const char *str;
+		const char *sha1;
+	};
+	struct sha1_test_case cases[] = {
+		{
+			.str = "hello world",
+			.sha1 = "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
+		},
+		{
+			.str = "hello world!",
+			.sha1 = "430ce34d020724ed75a196dfc2ad67c77772d169",
+		},
+	};
+
+	// Need a helper function to generate a name for each test case.
+	static void case_to_desc(const struct sha1_test_case *t, char *desc)
+	{
+		strcpy(desc, t->str);
+	}
+	// Creates `sha1_gen_params()` to iterate over `cases`.
+	KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
+
+	// Looks no different from a normal test.
+	static void sha1_test(struct kunit *test)
+	{
+		// This function can just contain the body of the for-loop.
+		// The former `cases[i]` is accessible under test->param_value.
+		char out[40];
+		struct sha1_test_case *test_param = (struct sha1_test_case *)(test->param_value);
+
+		sha1sum(test_param->str, out);
+		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, test_param->sha1,
+				      "sha1sum(%s)", test_param->str);
+	}
+
+	// Instead of KUNIT_CASE, we use KUNIT_CASE_PARAM and pass in the
+	// function declared by KUNIT_ARRAY_PARAM.
+	static struct kunit_case sha1_test_cases[] = {
+		KUNIT_CASE_PARAM(sha1_test, sha1_gen_params),
+		{}
+	};
+
 .. _kunit-on-non-uml:
 
 KUnit on non-UML architectures
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 21516e293d17..e808a47c839b 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -43,9 +43,9 @@ class KunitStatus(Enum):
 	BUILD_FAILURE = auto()
 	TEST_FAILURE = auto()
 
-def get_kernel_root_path():
-	parts = sys.argv[0] if not __file__ else __file__
-	parts = os.path.realpath(parts).split('tools/testing/kunit')
+def get_kernel_root_path() -> str:
+	path = sys.argv[0] if not __file__ else __file__
+	parts = os.path.realpath(path).split('tools/testing/kunit')
 	if len(parts) != 2:
 		sys.exit(1)
 	return parts[0]
@@ -171,7 +171,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 				exec_result.elapsed_time))
 	return parse_result
 
-def add_common_opts(parser):
+def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
@@ -183,13 +183,13 @@ def add_common_opts(parser):
 			    help='Run all KUnit tests through allyesconfig',
 			    action='store_true')
 
-def add_build_opts(parser):
+def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
 			    type=int, default=8, metavar='jobs')
 
-def add_exec_opts(parser):
+def add_exec_opts(parser) -> None:
 	parser.add_argument('--timeout',
 			    help='maximum number of seconds to allow for all tests '
 			    'to run. This does not include time taken to build the '
@@ -198,7 +198,7 @@ def add_exec_opts(parser):
 			    default=300,
 			    metavar='timeout')
 
-def add_parse_opts(parser):
+def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='don\'t format output from kernel',
 			    action='store_true')
 	parser.add_argument('--json',
@@ -256,10 +256,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
@@ -277,10 +274,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
@@ -292,10 +286,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
@@ -309,10 +300,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 02ffc3a3e5dc..bdd60230764b 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -8,6 +8,7 @@
 
 import collections
 import re
+from typing import List, Set
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
@@ -30,10 +31,10 @@ class KconfigParseError(Exception):
 class Kconfig(object):
 	"""Represents defconfig or .config specified using the Kconfig language."""
 
-	def __init__(self):
-		self._entries = []
+	def __init__(self) -> None:
+		self._entries = []  # type: List[KconfigEntry]
 
-	def entries(self):
+	def entries(self) -> Set[KconfigEntry]:
 		return set(self._entries)
 
 	def add_entry(self, entry: KconfigEntry) -> None:
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 624b31b2dbd6..f5cca5c38cac 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -13,7 +13,7 @@ import kunit_parser
 
 from kunit_parser import TestStatus
 
-def get_json_result(test_result, def_config, build_dir, json_path):
+def get_json_result(test_result, def_config, build_dir, json_path) -> str:
 	sub_groups = []
 
 	# Each test suite is mapped to a KernelCI sub_group
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 698358c9c0d6..2076a5a2d060 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -11,6 +11,7 @@ import subprocess
 import os
 import shutil
 import signal
+from typing import Iterator
 
 from contextlib import ExitStack
 
@@ -39,7 +40,7 @@ class BuildError(Exception):
 class LinuxSourceTreeOperations(object):
 	"""An abstraction over command line operations performed on a source tree."""
 
-	def make_mrproper(self):
+	def make_mrproper(self) -> None:
 		try:
 			subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
 		except OSError as e:
@@ -47,7 +48,7 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_olddefconfig(self, build_dir, make_options):
+	def make_olddefconfig(self, build_dir, make_options) -> None:
 		command = ['make', 'ARCH=um', 'olddefconfig']
 		if make_options:
 			command.extend(make_options)
@@ -60,7 +61,7 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_allyesconfig(self, build_dir, make_options):
+	def make_allyesconfig(self, build_dir, make_options) -> None:
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
 		command = ['make', 'ARCH=um', 'allyesconfig']
@@ -82,7 +83,7 @@ class LinuxSourceTreeOperations(object):
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
-	def make(self, jobs, build_dir, make_options):
+	def make(self, jobs, build_dir, make_options) -> None:
 		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
@@ -100,7 +101,7 @@ class LinuxSourceTreeOperations(object):
 		if stderr:  # likely only due to build warnings
 			print(stderr.decode())
 
-	def linux_bin(self, params, timeout, build_dir):
+	def linux_bin(self, params, timeout, build_dir) -> None:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = get_file_path(build_dir, 'linux')
 		outfile = get_outfile_path(build_dir)
@@ -110,41 +111,42 @@ class LinuxSourceTreeOperations(object):
 						   stderr=subprocess.STDOUT)
 			process.wait(timeout)
 
-def get_kconfig_path(build_dir):
+def get_kconfig_path(build_dir) -> str:
 	return get_file_path(build_dir, KCONFIG_PATH)
 
-def get_kunitconfig_path(build_dir):
+def get_kunitconfig_path(build_dir) -> str:
 	return get_file_path(build_dir, KUNITCONFIG_PATH)
 
-def get_outfile_path(build_dir):
+def get_outfile_path(build_dir) -> str:
 	return get_file_path(build_dir, OUTFILE_PATH)
 
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self):
-		self._ops = LinuxSourceTreeOperations()
+	def __init__(self, build_dir: str, load_config=True, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 
-	def clean(self):
-		try:
-			self._ops.make_mrproper()
-		except ConfigError as e:
-			logging.error(e)
-			return False
-		return True
+		self._ops = LinuxSourceTreeOperations()
+
+		if not load_config:
+			return
 
-	def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH):
 		kunitconfig_path = get_kunitconfig_path(build_dir)
 		if not os.path.exists(kunitconfig_path):
 			shutil.copyfile(defconfig, kunitconfig_path)
 
-	def read_kunitconfig(self, build_dir):
-		kunitconfig_path = get_kunitconfig_path(build_dir)
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
 
-	def validate_config(self, build_dir):
+	def clean(self) -> bool:
+		try:
+			self._ops.make_mrproper()
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		return True
+
+	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.Kconfig()
 		validated_kconfig.read_from_file(kconfig_path)
@@ -158,7 +160,7 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def build_config(self, build_dir, make_options):
+	def build_config(self, build_dir, make_options) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
@@ -170,7 +172,7 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def build_reconfig(self, build_dir, make_options):
+	def build_reconfig(self, build_dir, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
@@ -186,7 +188,7 @@ class LinuxSourceTree(object):
 			print('Generating .config ...')
 			return self.build_config(build_dir, make_options)
 
-	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
+	def build_um_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
 		try:
 			if alltests:
 				self._ops.make_allyesconfig(build_dir, make_options)
@@ -197,7 +199,7 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', timeout=None):
+	def run_kernel(self, args=[], build_dir='', timeout=None) -> Iterator[str]:
 		args.extend(['mem=1G', 'console=tty'])
 		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
@@ -206,6 +208,6 @@ class LinuxSourceTree(object):
 			for line in file:
 				yield line
 
-	def signal_handler(self, sig, frame):
+	def signal_handler(self, sig, frame) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 6614ec4d0898..e8bcc139702e 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,32 +12,32 @@ from collections import namedtuple
 from datetime import datetime
 from enum import Enum, auto
 from functools import reduce
-from typing import List, Optional, Tuple
+from typing import Iterable, Iterator, List, Optional, Tuple
 
 TestResult = namedtuple('TestResult', ['status','suites','log'])
 
 class TestSuite(object):
-	def __init__(self):
-		self.status = None
-		self.name = None
-		self.cases = []
+	def __init__(self) -> None:
+		self.status = TestStatus.SUCCESS
+		self.name = ''
+		self.cases = []  # type: List[TestCase]
 
-	def __str__(self):
-		return 'TestSuite(' + self.status + ',' + self.name + ',' + str(self.cases) + ')'
+	def __str__(self) -> str:
+		return 'TestSuite(' + str(self.status) + ',' + self.name + ',' + str(self.cases) + ')'
 
-	def __repr__(self):
+	def __repr__(self) -> str:
 		return str(self)
 
 class TestCase(object):
-	def __init__(self):
-		self.status = None
+	def __init__(self) -> None:
+		self.status = TestStatus.SUCCESS
 		self.name = ''
-		self.log = []
+		self.log = []  # type: List[str]
 
-	def __str__(self):
-		return 'TestCase(' + self.status + ',' + self.name + ',' + str(self.log) + ')'
+	def __str__(self) -> str:
+		return 'TestCase(' + str(self.status) + ',' + self.name + ',' + str(self.log) + ')'
 
-	def __repr__(self):
+	def __repr__(self) -> str:
 		return str(self)
 
 class TestStatus(Enum):
@@ -51,7 +51,7 @@ kunit_start_re = re.compile(r'TAP version [0-9]+$')
 kunit_end_re = re.compile('(List of all partitions:|'
 			  'Kernel panic - not syncing: VFS:)')
 
-def isolate_kunit_output(kernel_output):
+def isolate_kunit_output(kernel_output) -> Iterator[str]:
 	started = False
 	for line in kernel_output:
 		line = line.rstrip()  # line always has a trailing \n
@@ -64,7 +64,7 @@ def isolate_kunit_output(kernel_output):
 		elif started:
 			yield line[prefix_len:] if prefix_len > 0 else line
 
-def raw_output(kernel_output):
+def raw_output(kernel_output) -> None:
 	for line in kernel_output:
 		print(line.rstrip())
 
@@ -72,36 +72,36 @@ DIVIDER = '=' * 60
 
 RESET = '\033[0;0m'
 
-def red(text):
+def red(text) -> str:
 	return '\033[1;31m' + text + RESET
 
-def yellow(text):
+def yellow(text) -> str:
 	return '\033[1;33m' + text + RESET
 
-def green(text):
+def green(text) -> str:
 	return '\033[1;32m' + text + RESET
 
-def print_with_timestamp(message):
+def print_with_timestamp(message) -> None:
 	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
 
-def format_suite_divider(message):
+def format_suite_divider(message) -> str:
 	return '======== ' + message + ' ========'
 
-def print_suite_divider(message):
+def print_suite_divider(message) -> None:
 	print_with_timestamp(DIVIDER)
 	print_with_timestamp(format_suite_divider(message))
 
-def print_log(log):
+def print_log(log) -> None:
 	for m in log:
 		print_with_timestamp(m)
 
 TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
 
-def consume_non_diagnositic(lines: List[str]) -> None:
+def consume_non_diagnostic(lines: List[str]) -> None:
 	while lines and not TAP_ENTRIES.match(lines[0]):
 		lines.pop(0)
 
-def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
+def save_non_diagnostic(lines: List[str], test_case: TestCase) -> None:
 	while lines and not TAP_ENTRIES.match(lines[0]):
 		test_case.log.append(lines[0])
 		lines.pop(0)
@@ -113,7 +113,7 @@ OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
 
 def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
-	save_non_diagnositic(lines, test_case)
+	save_non_diagnostic(lines, test_case)
 	if not lines:
 		test_case.status = TestStatus.TEST_CRASHED
 		return True
@@ -139,7 +139,7 @@ SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
 DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
 
 def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
-	save_non_diagnositic(lines, test_case)
+	save_non_diagnostic(lines, test_case)
 	if not lines:
 		return False
 	line = lines[0]
@@ -155,7 +155,7 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 
 def parse_test_case(lines: List[str]) -> Optional[TestCase]:
 	test_case = TestCase()
-	save_non_diagnositic(lines, test_case)
+	save_non_diagnostic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
 		pass
 	if parse_ok_not_ok_test_case(lines, test_case):
@@ -166,7 +166,7 @@ def parse_test_case(lines: List[str]) -> Optional[TestCase]:
 SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
 
 def parse_subtest_header(lines: List[str]) -> Optional[str]:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	if not lines:
 		return None
 	match = SUBTEST_HEADER.match(lines[0])
@@ -179,7 +179,7 @@ def parse_subtest_header(lines: List[str]) -> Optional[str]:
 SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
 def parse_subtest_plan(lines: List[str]) -> Optional[int]:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	match = SUBTEST_PLAN.match(lines[0])
 	if match:
 		lines.pop(0)
@@ -202,7 +202,7 @@ def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
 def parse_ok_not_ok_test_suite(lines: List[str],
 			       test_suite: TestSuite,
 			       expected_suite_index: int) -> bool:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	if not lines:
 		test_suite.status = TestStatus.TEST_CRASHED
 		return False
@@ -224,18 +224,17 @@ def parse_ok_not_ok_test_suite(lines: List[str],
 	else:
 		return False
 
-def bubble_up_errors(to_status, status_container_list) -> TestStatus:
-	status_list = map(to_status, status_container_list)
-	return reduce(max_status, status_list, TestStatus.SUCCESS)
+def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
+	return reduce(max_status, statuses, TestStatus.SUCCESS)
 
 def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
-	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
+	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
 def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
 	if not lines:
 		return None
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	test_suite = TestSuite()
 	test_suite.status = TestStatus.SUCCESS
 	name = parse_subtest_header(lines)
@@ -264,7 +263,7 @@ def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[Te
 TAP_HEADER = re.compile(r'^TAP version 14$')
 
 def parse_tap_header(lines: List[str]) -> bool:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	if TAP_HEADER.match(lines[0]):
 		lines.pop(0)
 		return True
@@ -274,7 +273,7 @@ def parse_tap_header(lines: List[str]) -> bool:
 TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
 
 def parse_test_plan(lines: List[str]) -> Optional[int]:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	match = TEST_PLAN.match(lines[0])
 	if match:
 		lines.pop(0)
@@ -282,11 +281,11 @@ def parse_test_plan(lines: List[str]) -> Optional[int]:
 	else:
 		return None
 
-def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
-	return bubble_up_errors(lambda x: x.status, test_suite_list)
+def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
+	return bubble_up_errors(x.status for x in test_suites)
 
 def parse_test_result(lines: List[str]) -> TestResult:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	if not lines or not parse_tap_header(lines):
 		return TestResult(TestStatus.NO_TESTS, [], lines)
 	expected_test_suite_num = parse_test_plan(lines)

--------------CAAFC25748C28CDDDD15F7FA--
