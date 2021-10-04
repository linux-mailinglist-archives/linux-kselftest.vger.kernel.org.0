Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FAA4214A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Oct 2021 19:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbhJDRDA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Oct 2021 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbhJDRC7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Oct 2021 13:02:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7ADC06174E
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Oct 2021 10:01:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d1-20020a056902060100b005b9c7c04351so6647662ybt.14
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Oct 2021 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Mo3PE3P1ieu1o7ruBSuI9hdnELVPjKYRFQStGRBmn/U=;
        b=UQon0Wfqg4GxMOuasE8AUhiaIFLhfSwmsGpyth6skSfLoFChbF9PG4+f/Wo6S2/70n
         EV/hz2Nmar8O7gfkeM3VAJI1panHn04NElI+ayr6EAAIxHR7u5VQAh9j1aDsTcUynG4D
         qEiSBDrthXmgzSzFZDX3/cWkxHQjmnnycmHUVCTEFCyi2Qw0BfEG9BWgqGUs2C6K3k4v
         k80wwtIioj2XaSKh2mtrZbBtv3i9VEVeFppECgg39MKzdTh+Id3EpoQbkocuZflLCTNP
         qxto98fPR6l3nAakDL3Vk+BcIddP9th+xi3Gv4pIrVJgMK2r7MRmiECSsMDFsEOCYiTf
         uNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Mo3PE3P1ieu1o7ruBSuI9hdnELVPjKYRFQStGRBmn/U=;
        b=tgyHXI+h+IAiICBlY/NbWxVoHCNjbqX8MscrVMSvzu5jVn6p/wiYO9TNGtkg11zv3k
         AOoXpi9cvYSN0w4k5EUH0M41I42Rxk7wjEew3+uSuiWCh2BgnSmUdjsm8HC0sN9zeIRb
         xi+0B2yxDQ0qAfzhs5dtBrXAtvA7FoZHXc4eQWQ0Nn5V+cNl28SejCVF1Df0ona0GiSc
         DlBsBSnnz7wtSeogtgOdLXsUwuSQnB7FjyANhoqr/Nqv0jYYvwzjXQn2UnL/+kL//DM1
         6oc5ZGCovYJ3cgTnuPMKErHbN1QBIuItr7OzeaEJpKuodbVy/IXDWfniUIQ3DzzBXp7O
         sEJw==
X-Gm-Message-State: AOAM530tCnVx9ot0xzIwf5PhZIpx3wVSRgGpSUFtjXAnbnyztxAOSlSB
        ryW74JDBJo4fTMePWCX/plwZ1qO/SVZ02A==
X-Google-Smtp-Source: ABdhPJzkolyH7q9Y8u0KG2zn5wZ7ALjaLNHA/08E9qzmIy3t99h5C4o2EQPfB14uyNNAjLQZcFbWIH3p5VsjAA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:ee03:329e:90be:b395])
 (user=dlatypov job=sendgmr) by 2002:a5b:846:: with SMTP id
 v6mr8164116ybq.457.1633366869207; Mon, 04 Oct 2021 10:01:09 -0700 (PDT)
Date:   Mon,  4 Oct 2021 10:01:02 -0700
Message-Id: <20211004170102.2522514-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] kunit: tool: yield output from run_kernel in real time
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, `run_kernel()` dumps all the kernel output to a file
(.kunit/test.log) and then opens the file and yields it to callers.
This made it easier to respect the requested timeout, if any.

But it means that we can't yield the results in real time, either to the
parser or to stdout (if --raw_output is set).

This change spins up a background thread to enforce the timeout, which
allows us to yield the kernel output in real time, while also copying it
to the .kunit/test.log file.
It's also careful to ensure that the .kunit/test.log file is complete,
even in the kunit_parser throws an exception/otherwise doesn't consume
every line, see the new `finally` block and unit test.

For example:

$ ./tools/testing/kunit/kunit.py run --arch=x86_64 --raw_output
<configure + build steps>
...
<can now see output from QEMU in real time>

This does not currently have a visible effect when --raw_output is not
passed, as kunit_parser.py currently only outputs everything at the end.
But that could change, and this patch is a necessary step towards
showing parsed test results in real time.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py    | 73 +++++++++++++++-----------
 tools/testing/kunit/kunit_tool_test.py | 17 ++++++
 2 files changed, 60 insertions(+), 30 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2c6f916ccbaf..b8cba8123aa3 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -12,7 +12,8 @@ import subprocess
 import os
 import shutil
 import signal
-from typing import Iterator, Optional, Tuple
+import threading
+from typing import Iterator, List, Optional, Tuple
 
 from contextlib import ExitStack
 
@@ -103,8 +104,8 @@ class LinuxSourceTreeOperations(object):
 		if stderr:  # likely only due to build warnings
 			print(stderr.decode())
 
-	def run(self, params, timeout, build_dir, outfile) -> None:
-		pass
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
+		raise RuntimeError('not implemented!')
 
 
 class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
@@ -123,7 +124,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		kconfig.parse_from_string(self._kconfig)
 		base_kunitconfig.merge_in_entries(kconfig)
 
-	def run(self, params, timeout, build_dir, outfile):
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		kernel_path = os.path.join(build_dir, self._kernel_path)
 		qemu_command = ['qemu-system-' + self._qemu_arch,
 				'-nodefaults',
@@ -134,18 +135,10 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
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
+					   stdout=subprocess.PIPE,
+					   stderr=subprocess.STDOUT,
+					   text=True, shell=True)
 
 class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	"""An abstraction over command line operations performed on a source tree."""
@@ -175,17 +168,13 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
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
+					   stdout=subprocess.PIPE,
+					   stderr=subprocess.STDOUT,
+					   text=True)
 
 def get_kconfig_path(build_dir) -> str:
 	return get_file_path(build_dir, KCONFIG_PATH)
@@ -330,12 +319,36 @@ class LinuxSourceTree(object):
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
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 619c4554cbff..f9a7398a9584 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -14,6 +14,7 @@ import tempfile, shutil # Handling test_tmpdir
 import itertools
 import json
 import signal
+import subprocess
 import os
 
 import kunit_config
@@ -291,6 +292,22 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				pass
 			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 
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
+
 	# TODO: add more test cases.
 
 

base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
-- 
2.33.0.800.g4c38ced690-goog

