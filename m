Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019FC6BDB44
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 23:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCPWHL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPWHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 18:07:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E77D55F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:06:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544b71b3114so17712677b3.13
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679004410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2h1nWW+Tx2qkQciskmHzf90FfoypHRB1YvIyPPSqDIg=;
        b=F17vTJwKW0LALuQ1LC/PSKl27Mv2IL7HV/6lO6Mdg4HwdTbjb/jX+HgWcnKAZXcwl3
         A6Q6rtWbIgTXqAlgO0ASIynbjWyDoa25FT/LgOIUGQRnbwpuL8VcD1Mexz0XmDTWc/LJ
         kxQ3NCmuSwJLidyc1HkPwWIxVH3yYy815xFCNcOEV3+M64ZoQ0VywsgXuMsVdoncWo4w
         runTZCnEH/g+UVbq73zl6sYPsabp4U7Xrpw4ArgCvLv83qu5KO7kKhx9R/IJFPxMfHZL
         OwovGKq1VldQGDZZ3OvtAtyMcFgKiZ6z6fwMfBzxpW0UWmN+n8vSzbxR2ucRYpkatn3R
         PVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679004410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2h1nWW+Tx2qkQciskmHzf90FfoypHRB1YvIyPPSqDIg=;
        b=hD/kjN/wwAYoPS0L3ZaAg8Sbrs7kHqY56pqZ+f8d8Rk2D4on23r9BD+aadCwHwix3A
         wnGcDnvh0JUvma8YCszjOcfkDPE+4LXLB9PLEntvVaW0QTHY3Zvk7CCS5SS55vepkGA9
         Ew2dZxXL7zTo5ZaV1YABomn23m/5n0G5ECqs2f6/pWBLzF3X5+pjcOg8IPKiUx6DTB4Y
         xrTAWZZS6BAB/Dg7P/gEY6krrwir1HrBzVozGfvF3TA37CCbWIIL+dUcUF3RD7NwOs6R
         WrSQUCnNwFZLRVT3PTA8Y7cGDJzP/YmBMmSe7VuUvXAvno3XYmlUaQEdXSIWuAzFllRR
         sVFg==
X-Gm-Message-State: AO0yUKWj4imA/kinlGMO48zfk1MvTV0Ta/u8Cgcp62//D0dnaYlyj/4q
        nOkVcTa/eE6n5/dkolFaHP6y0/W0YnuytQ==
X-Google-Smtp-Source: AK7set8278OSQmWB+I9xtX515VUEDokB2uaE3xiyFmMBsZEYqLi8a1ugfDIHo0XJETwhiY0qp4pbGyALWhstQA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:1101:b0:b26:d140:5f74 with SMTP
 id o1-20020a056902110100b00b26d1405f74mr1008741ybu.1.1679004410486; Thu, 16
 Mar 2023 15:06:50 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:06:38 -0700
In-Reply-To: <20230316220638.983743-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20230316220638.983743-1-dlatypov@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316220638.983743-3-dlatypov@google.com>
Subject: [PATCH v2 3/3] kunit: tool: fix pre-existing `mypy --strict` errors
 and update run_checks.py
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, johannes@sipsolutions.net,
        Daniel Latypov <dlatypov@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Basically, get this command to be happy and make run_checks.py happy
 $ mypy --strict --exclude '_test.py$' --exclude qemu_configs/ ./tools/testing/kunit/

Primarily the changes are
* add `-> None` return type annotations
* add all the missing argument type annotations

Previously, we had false positives from mypy in `main()`, see commit
09641f7c7d8f ("kunit: tool: surface and address more typing issues").
But after commit 2dc9d6ca52a4 ("kunit: kunit.py extract handlers")
refactored things, the variable name reuse mypy hated is gone.

Note: mypy complains we don't annotate the types the unused args in our
signal handler. That's silly.
But to make it happy, I've copy-pasted an appropriate annotation from
https://github.com/python/typing/discussions/1042#discussioncomment-2013595.

Reported-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/linux-kselftest/9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net/
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py        | 24 ++++++++++++------------
 tools/testing/kunit/kunit_config.py |  4 ++--
 tools/testing/kunit/kunit_kernel.py | 29 +++++++++++++++--------------
 tools/testing/kunit/run_checks.py   |  4 ++--
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 52853634ba23..3905c43369c3 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -269,7 +269,7 @@ def massage_argv(argv: Sequence[str]) -> Sequence[str]:
 def get_default_jobs() -> int:
 	return len(os.sched_getaffinity(0))
 
-def add_common_opts(parser) -> None:
+def add_common_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
@@ -320,13 +320,13 @@ def add_common_opts(parser) -> None:
 			    help='Additional QEMU arguments, e.g. "-smp 8"',
 			    action='append', metavar='')
 
-def add_build_opts(parser) -> None:
+def add_build_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
 			    type=int, default=get_default_jobs(), metavar='N')
 
-def add_exec_opts(parser) -> None:
+def add_exec_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--timeout',
 			    help='maximum number of seconds to allow for all tests '
 			    'to run. This does not include time taken to build the '
@@ -351,7 +351,7 @@ def add_exec_opts(parser) -> None:
 			    type=str,
 			    choices=['suite', 'test'])
 
-def add_parse_opts(parser) -> None:
+def add_parse_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t parse output from kernel. '
 			    'By default, filters to just KUnit output. Use '
 			    '--raw_output=all to show everything',
@@ -386,7 +386,7 @@ def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree
 			extra_qemu_args=qemu_args)
 
 
-def run_handler(cli_args):
+def run_handler(cli_args: argparse.Namespace) -> None:
 	if not os.path.exists(cli_args.build_dir):
 		os.mkdir(cli_args.build_dir)
 
@@ -405,7 +405,7 @@ def run_handler(cli_args):
 		sys.exit(1)
 
 
-def config_handler(cli_args):
+def config_handler(cli_args: argparse.Namespace) -> None:
 	if cli_args.build_dir and (
 			not os.path.exists(cli_args.build_dir)):
 		os.mkdir(cli_args.build_dir)
@@ -421,7 +421,7 @@ def config_handler(cli_args):
 		sys.exit(1)
 
 
-def build_handler(cli_args):
+def build_handler(cli_args: argparse.Namespace) -> None:
 	linux = tree_from_args(cli_args)
 	request = KunitBuildRequest(build_dir=cli_args.build_dir,
 					make_options=cli_args.make_options,
@@ -434,7 +434,7 @@ def build_handler(cli_args):
 		sys.exit(1)
 
 
-def exec_handler(cli_args):
+def exec_handler(cli_args: argparse.Namespace) -> None:
 	linux = tree_from_args(cli_args)
 	exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
 					build_dir=cli_args.build_dir,
@@ -450,10 +450,10 @@ def exec_handler(cli_args):
 		sys.exit(1)
 
 
-def parse_handler(cli_args):
+def parse_handler(cli_args: argparse.Namespace) -> None:
 	if cli_args.file is None:
-		sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
-		kunit_output = sys.stdin
+		sys.stdin.reconfigure(errors='backslashreplace')  # type: ignore
+		kunit_output = sys.stdin  # type: Iterable[str]
 	else:
 		with open(cli_args.file, 'r', errors='backslashreplace') as f:
 			kunit_output = f.read().splitlines()
@@ -475,7 +475,7 @@ subcommand_handlers_map = {
 }
 
 
-def main(argv):
+def main(argv: Sequence[str]) -> None:
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 9f76d7b89617..eb5dd01210b1 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -8,7 +8,7 @@
 
 from dataclasses import dataclass
 import re
-from typing import Dict, Iterable, List, Tuple
+from typing import Any, Dict, Iterable, List, Tuple
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
@@ -34,7 +34,7 @@ class Kconfig:
 	def __init__(self) -> None:
 		self._entries = {}  # type: Dict[str, str]
 
-	def __eq__(self, other) -> bool:
+	def __eq__(self, other: Any) -> bool:
 		if not isinstance(other, self.__class__):
 			return False
 		return self._entries == other._entries
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 775842b912d8..a3321a991f11 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -16,6 +16,7 @@ import shutil
 import signal
 import threading
 from typing import Iterator, List, Optional, Tuple
+from types import FrameType
 
 import kunit_config
 import qemu_config
@@ -56,7 +57,7 @@ class LinuxSourceTreeOperations:
 	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
 		return base_kunitconfig
 
-	def make_olddefconfig(self, build_dir: str, make_options) -> None:
+	def make_olddefconfig(self, build_dir: str, make_options: Optional[List[str]]) -> None:
 		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, 'olddefconfig']
 		if self._cross_compile:
 			command += ['CROSS_COMPILE=' + self._cross_compile]
@@ -70,7 +71,7 @@ class LinuxSourceTreeOperations:
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make(self, jobs, build_dir: str, make_options) -> None:
+	def make(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> None:
 		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
@@ -132,7 +133,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	"""An abstraction over command line operations performed on a source tree."""
 
-	def __init__(self, cross_compile=None):
+	def __init__(self, cross_compile: Optional[str]=None):
 		super().__init__(linux_arch='um', cross_compile=cross_compile)
 
 	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
@@ -215,7 +216,7 @@ def _get_qemu_ops(config_path: str,
 
 	if not hasattr(config, 'QEMU_ARCH'):
 		raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
-	params: qemu_config.QemuArchParams = config.QEMU_ARCH  # type: ignore
+	params: qemu_config.QemuArchParams = config.QEMU_ARCH
 	if extra_qemu_args:
 		params.extra_qemu_params.extend(extra_qemu_args)
 	return params.linux_arch, LinuxSourceTreeOperationsQemu(
@@ -229,10 +230,10 @@ class LinuxSourceTree:
 	      build_dir: str,
 	      kunitconfig_paths: Optional[List[str]]=None,
 	      kconfig_add: Optional[List[str]]=None,
-	      arch=None,
-	      cross_compile=None,
-	      qemu_config_path=None,
-	      extra_qemu_args=None) -> None:
+	      arch: Optional[str]=None,
+	      cross_compile: Optional[str]=None,
+	      qemu_config_path: Optional[str]=None,
+	      extra_qemu_args: Optional[List[str]]=None) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 		if qemu_config_path:
 			self._arch, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
@@ -275,7 +276,7 @@ class LinuxSourceTree:
 		logging.error(message)
 		return False
 
-	def build_config(self, build_dir: str, make_options) -> bool:
+	def build_config(self, build_dir: str, make_options: Optional[List[str]]) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
@@ -303,7 +304,7 @@ class LinuxSourceTree:
 		old_kconfig = kunit_config.parse_file(old_path)
 		return old_kconfig != self._kconfig
 
-	def build_reconfig(self, build_dir: str, make_options) -> bool:
+	def build_reconfig(self, build_dir: str, make_options: Optional[List[str]]) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if not os.path.exists(kconfig_path):
@@ -319,7 +320,7 @@ class LinuxSourceTree:
 		os.remove(kconfig_path)
 		return self.build_config(build_dir, make_options)
 
-	def build_kernel(self, jobs, build_dir: str, make_options) -> bool:
+	def build_kernel(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> bool:
 		try:
 			self._ops.make_olddefconfig(build_dir, make_options)
 			self._ops.make(jobs, build_dir, make_options)
@@ -328,7 +329,7 @@ class LinuxSourceTree:
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
+	def run_kernel(self, args: Optional[List[str]]=None, build_dir: str='', filter_glob: str='', timeout: Optional[int]=None) -> Iterator[str]:
 		if not args:
 			args = []
 		if filter_glob:
@@ -339,7 +340,7 @@ class LinuxSourceTree:
 		assert process.stdout is not None  # tell mypy it's set
 
 		# Enforce the timeout in a background thread.
-		def _wait_proc():
+		def _wait_proc() -> None:
 			try:
 				process.wait(timeout=timeout)
 			except Exception as e:
@@ -365,6 +366,6 @@ class LinuxSourceTree:
 			waiter.join()
 			subprocess.call(['stty', 'sane'])
 
-	def signal_handler(self, unused_sig, unused_frame) -> None:
+	def signal_handler(self, unused_sig: int, unused_frame: Optional[FrameType]) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 61cece1684df..8208c3b3135e 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -23,7 +23,7 @@ commands: Dict[str, Sequence[str]] = {
 	'kunit_tool_test.py': ['./kunit_tool_test.py'],
 	'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
 	'pytype': ['/bin/sh', '-c', 'pytype *.py'],
-	'mypy': ['/bin/sh', '-c', 'mypy *.py'],
+	'mypy': ['mypy', '--strict', '--exclude', '_test.py$', '--exclude', 'qemu_configs/', '.'],
 }
 
 # The user might not have mypy or pytype installed, skip them if so.
@@ -73,7 +73,7 @@ def main(argv: Sequence[str]) -> None:
 		sys.exit(1)
 
 
-def run_cmd(argv: Sequence[str]):
+def run_cmd(argv: Sequence[str]) -> None:
 	subprocess.check_output(argv, stderr=subprocess.STDOUT, cwd=ABS_TOOL_PATH, timeout=TIMEOUT)
 
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

