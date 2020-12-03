Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BC2CDF1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 20:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgLCTmW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 14:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTmW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 14:42:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12815C061A4E
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 11:41:36 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 1so1770258plb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=QE5/y2hpyMf6Ag8MAbGcz5fyG3ByS5ps2A086XsjmKY=;
        b=rZDRkPZQPdDYbVzcTGAZF5+m+mbqwqNVTacwbjLELHTkjC5H3DwDgrVW7zAbdwMVfu
         9SySXv6zVt/t10aZUoi6MBzLl37xo8HACnlbkwydi431ZOwRmW2vsaZU+7/JygDFtjYu
         jIkqAOGJAS9Lc5KxcQIZ5aY3XNgMl5jv6i9FgmmSx83c9HTRhM/DUFu5F1pMImx4Zi9q
         U+R/08n/lPu+xto1RcmiLHjs12qvxSbwW3+9PrzBEXwcSbQ04YZl3K0iapPsv9OcXx4Y
         xB2sC21BEnZANzEorMbEcFuTjEdHnfZe22MIGZNPzeahfwfofETb76ZO0BWYrHBVPiVi
         61Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=QE5/y2hpyMf6Ag8MAbGcz5fyG3ByS5ps2A086XsjmKY=;
        b=qqJxoNdhhHEO8G9abrrc4zdB2AeGo4VpUM/yL5OtqaETYslESXG3ALMJY/27aIf/QY
         K8SzBwdxsKE8UDLS7/8LcWcslkh8UNTWxF62GVr2bmOp7Qlfuxb9YA8Dyo8ervbPmGof
         K8FFZTlmGNz8MwU8h0hbVZELRoB+qSrZ+PSUno3hOzbwq2VGmB/taU3tK/pDm6zIcaw/
         amL5FrkG0x8j08IlaKh6G6DEWtdLR+Y49vQDTp60o6ZdagI668f5BcXKUm78AAtfZMq6
         vg6EoHQLwmxg+CpL2d4kwf2mI1UeBO/dNFBgvQh19x4zW3NDF+Sxwg24jdYMTKxR2Isc
         74IQ==
X-Gm-Message-State: AOAM531y3oKPNccNXKXEV2YrYKkMk1JxEpvg/uJGJOjcRVah/wzL1VGY
        OnFJqppl7gly3ElWWZaUHZuNTrrd5l2GaQ==
X-Google-Smtp-Source: ABdhPJzeuBikU7VIX/Rre2X7fi9K1keSiCXV59rYAFvw7uSa5fqrR2pmMi/DnrPapAJFZMwz2DClRCejSOMbWg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a62:be13:0:b029:19a:4c0:efe3 with SMTP id
 l19-20020a62be130000b029019a04c0efe3mr289269pff.75.1607024495423; Thu, 03 Dec
 2020 11:41:35 -0800 (PST)
Date:   Thu,  3 Dec 2020 11:41:25 -0800
Message-Id: <20201203194127.1813731-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 1/3] kunit: tool: surface and address more typing issues
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The authors of this tool were more familiar with a different
type-checker, https://github.com/google/pytype.

That's open source, but mypy seems more prevalent (and runs faster).
And unlike pytype, mypy doesn't try to infer types so it doesn't check
unanotated functions.

So annotate ~all functions in kunit tool to increase type-checking
coverage.
Note: per https://www.python.org/dev/peps/pep-0484/, `__init__()` should
be annotated as `-> None`.

Doing so makes mypy discover a number of new violations.
Exclude main() since we reuse `request` for the different types of
requests, which mypy isn't happy about.

This commit fixes all but one error, where `TestSuite.status` might be
None.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py        | 14 ++++-----
 tools/testing/kunit/kunit_config.py |  7 +++--
 tools/testing/kunit/kunit_json.py   |  2 +-
 tools/testing/kunit/kunit_kernel.py | 37 ++++++++++++-----------
 tools/testing/kunit/kunit_parser.py | 46 ++++++++++++++---------------
 5 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index d4f7846d0745..08951a114654 100755
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
index 2e3cc0fac726..bda7c4fd4d3e 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -11,6 +11,7 @@ import subprocess
 import os
 import shutil
 import signal
+from typing import Iterator
 
 from contextlib import ExitStack
 
@@ -34,7 +35,7 @@ class BuildError(Exception):
 class LinuxSourceTreeOperations(object):
 	"""An abstraction over command line operations performed on a source tree."""
 
-	def make_mrproper(self):
+	def make_mrproper(self) -> None:
 		try:
 			subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
 		except OSError as e:
@@ -42,7 +43,7 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_olddefconfig(self, build_dir, make_options):
+	def make_olddefconfig(self, build_dir, make_options) -> None:
 		command = ['make', 'ARCH=um', 'olddefconfig']
 		if make_options:
 			command.extend(make_options)
@@ -55,7 +56,7 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_allyesconfig(self, build_dir, make_options):
+	def make_allyesconfig(self, build_dir, make_options) -> None:
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
 		command = ['make', 'ARCH=um', 'allyesconfig']
@@ -77,7 +78,7 @@ class LinuxSourceTreeOperations(object):
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
-	def make(self, jobs, build_dir, make_options):
+	def make(self, jobs, build_dir, make_options) -> None:
 		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
@@ -95,7 +96,7 @@ class LinuxSourceTreeOperations(object):
 		if stderr:  # likely only due to build warnings
 			print(stderr.decode())
 
-	def linux_bin(self, params, timeout, build_dir):
+	def linux_bin(self, params, timeout, build_dir) -> None:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = './linux'
 		if build_dir:
@@ -107,19 +108,19 @@ class LinuxSourceTreeOperations(object):
 						   stderr=subprocess.STDOUT)
 			process.wait(timeout)
 
-def get_kconfig_path(build_dir):
+def get_kconfig_path(build_dir) -> str:
 	kconfig_path = KCONFIG_PATH
 	if build_dir:
 		kconfig_path = os.path.join(build_dir, KCONFIG_PATH)
 	return kconfig_path
 
-def get_kunitconfig_path(build_dir):
+def get_kunitconfig_path(build_dir) -> str:
 	kunitconfig_path = KUNITCONFIG_PATH
 	if build_dir:
 		kunitconfig_path = os.path.join(build_dir, KUNITCONFIG_PATH)
 	return kunitconfig_path
 
-def get_outfile_path(build_dir):
+def get_outfile_path(build_dir) -> str:
 	outfile_path = OUTFILE_PATH
 	if build_dir:
 		outfile_path = os.path.join(build_dir, OUTFILE_PATH)
@@ -128,11 +129,11 @@ def get_outfile_path(build_dir):
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self):
+	def __init__(self) -> None:
 		self._ops = LinuxSourceTreeOperations()
 		signal.signal(signal.SIGINT, self.signal_handler)
 
-	def clean(self):
+	def clean(self) -> bool:
 		try:
 			self._ops.make_mrproper()
 		except ConfigError as e:
@@ -140,17 +141,17 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH):
+	def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
 		kunitconfig_path = get_kunitconfig_path(build_dir)
 		if not os.path.exists(kunitconfig_path):
 			shutil.copyfile(defconfig, kunitconfig_path)
 
-	def read_kunitconfig(self, build_dir):
+	def read_kunitconfig(self, build_dir) -> None:
 		kunitconfig_path = get_kunitconfig_path(build_dir)
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
 
-	def validate_config(self, build_dir):
+	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.Kconfig()
 		validated_kconfig.read_from_file(kconfig_path)
@@ -164,7 +165,7 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def build_config(self, build_dir, make_options):
+	def build_config(self, build_dir, make_options) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
@@ -176,7 +177,7 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def build_reconfig(self, build_dir, make_options):
+	def build_reconfig(self, build_dir, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
@@ -192,7 +193,7 @@ class LinuxSourceTree(object):
 			print('Generating .config ...')
 			return self.build_config(build_dir, make_options)
 
-	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
+	def build_um_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
 		try:
 			if alltests:
 				self._ops.make_allyesconfig(build_dir, make_options)
@@ -203,7 +204,7 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', timeout=None):
+	def run_kernel(self, args=[], build_dir='', timeout=None) -> Iterator[str]:
 		args.extend(['mem=1G'])
 		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
@@ -212,6 +213,6 @@ class LinuxSourceTree(object):
 			for line in file:
 				yield line
 
-	def signal_handler(self, sig, frame):
+	def signal_handler(self, sig, frame) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index bbfe1b4e4c1c..24954bbc9baf 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,32 +12,32 @@ from collections import namedtuple
 from datetime import datetime
 from enum import Enum, auto
 from functools import reduce
-from typing import List, Optional, Tuple
+from typing import Iterator, List, Optional, Tuple
 
 TestResult = namedtuple('TestResult', ['status','suites','log'])
 
 class TestSuite(object):
-	def __init__(self):
-		self.status = None
-		self.name = None
-		self.cases = []
+	def __init__(self) -> None:
+		self.status = None  # type: Optional[TestStatus]
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
+		self.status = None  # type: Optional[TestStatus]
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
 
@@ -72,26 +72,26 @@ DIVIDER = '=' * 60
 
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
 

base-commit: 34816d20f173a90389c8a7e641166d8ea9dce70a
-- 
2.29.2.576.ga3fc446d84-goog

