Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435FD2F6F9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbhAOAkG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731365AbhAOAkF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:40:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95452C061757
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:39:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 203so3631876ybz.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=NFlcOEJVzUQ2FtiBXQZmj8qLtEimPxXzEBtaFQ3tt8Q=;
        b=ZseIsp1+icB/elzR9f4DKVNAxsKxMGV4OtjpPWb2yN1suXkZrX4NGCnucl09SSxjGr
         Vffs5s7WT+JEBXzu3YsG3fwHzZFond8PKwUIhjD4mSvrYGiXfeT+BLQ7viqZCzf3RZpm
         9k1hgrifXMvEj2Joy202WEb27iKG6TCGNnTOmfAWQa+9tKUmenTM57Y2qEp8WENNIQvq
         AnpwImUgmJMfPaAZYCXlCbzN2Gea4R+tkEYosUSApyUHmu5n1e4Dkh1SbkKZpHuPCsud
         9SIqnt6tCT6/FvdTnc0gxUzrv1ZJKL2+3I/dcU/fgoUC7rI55Gs8cZLuDRQxpHdDivJ2
         Ze6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=NFlcOEJVzUQ2FtiBXQZmj8qLtEimPxXzEBtaFQ3tt8Q=;
        b=htd6CctRHHbj4udH+eFUqacHSS4tklxNhX/XnTeYDgqqHBwNhFVPwsO22VVRLUHoBr
         yHk6+b1YrHuYF2FY7S3zDL7lxHIbPhavKK85B0ubgJ8rfqIQFjMP78XttyT+vox0Fhl4
         +wPu/LEmVYZBgdawZ57OLPZUlUun6rN/rxkcH0jgWtPPidc+N+4WVwtE1E/ZvhM7WgET
         Y0NqsvRlHjsoHP5lJ3ZZjcXAfDC7cktWCDd26kKGmh6wpxcSWOhiNk2lm96JgYttL71T
         uFNfCJP6KC0WyFaN7yIQu6if8cX8iHWnpLVFzYGa2PLHSSAPaeaypSQK3GBCQ20hW2lY
         E/ZA==
X-Gm-Message-State: AOAM532yDgJd+Lsme/VHXhDwKTLeGBN14E8GW4tBWnI7iBSzSqmFeavW
        9mBjSu1NGP95txAa2b6M1XSrEuvVBnaZow==
X-Google-Smtp-Source: ABdhPJwMt05GsHPqo0gJebc3BLOvKHOe69WZxvX1LZ1rRbeNOUvhz6jsKvYfTwURgnHhkAKPjBHw6VnmQwNdJA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:497:: with SMTP id
 145mr13555273ybe.275.1610671163676; Thu, 14 Jan 2021 16:39:23 -0800 (PST)
Date:   Thu, 14 Jan 2021 16:39:11 -0800
Message-Id: <20210115003913.1406896-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v4 1/3] kunit: tool: surface and address more typing issues
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
Reviewed-by: David Gow <davidgow@google.com>
---

Changes since v1: none here, reworked last patch.
Changes since v2: rebased onto torvalds/master.
Changes since v3: rebased again torvalds/master.
---
 tools/testing/kunit/kunit.py        | 14 ++++-----
 tools/testing/kunit/kunit_config.py |  7 +++--
 tools/testing/kunit/kunit_json.py   |  2 +-
 tools/testing/kunit/kunit_kernel.py | 37 ++++++++++++-----------
 tools/testing/kunit/kunit_parser.py | 46 ++++++++++++++---------------
 5 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 21516e293d17..5521e0a8201e 100755
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
index 698358c9c0d6..e77ee06aa407 100644
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
@@ -110,23 +111,23 @@ class LinuxSourceTreeOperations(object):
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
+	def __init__(self) -> None:
 		self._ops = LinuxSourceTreeOperations()
 		signal.signal(signal.SIGINT, self.signal_handler)
 
-	def clean(self):
+	def clean(self) -> bool:
 		try:
 			self._ops.make_mrproper()
 		except ConfigError as e:
@@ -134,17 +135,17 @@ class LinuxSourceTree(object):
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
@@ -158,7 +159,7 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def build_config(self, build_dir, make_options):
+	def build_config(self, build_dir, make_options) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
@@ -170,7 +171,7 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def build_reconfig(self, build_dir, make_options):
+	def build_reconfig(self, build_dir, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
@@ -186,7 +187,7 @@ class LinuxSourceTree(object):
 			print('Generating .config ...')
 			return self.build_config(build_dir, make_options)
 
-	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
+	def build_um_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
 		try:
 			if alltests:
 				self._ops.make_allyesconfig(build_dir, make_options)
@@ -197,7 +198,7 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', timeout=None):
+	def run_kernel(self, args=[], build_dir='', timeout=None) -> Iterator[str]:
 		args.extend(['mem=1G', 'console=tty'])
 		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
@@ -206,6 +207,6 @@ class LinuxSourceTree(object):
 			for line in file:
 				yield line
 
-	def signal_handler(self, sig, frame):
+	def signal_handler(self, sig, frame) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 6614ec4d0898..8b5eb9507765 100644
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
 

base-commit: 146620506274bd24d52fb1c589110a30eed8240b
-- 
2.30.0.296.g2bfb1c46d8-goog

