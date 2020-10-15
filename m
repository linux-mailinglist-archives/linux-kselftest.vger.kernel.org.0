Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4C28F5C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgJOPXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 11:23:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:60954 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbgJOPXx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 11:23:53 -0400
IronPort-SDR: 3rnWB048ssD9z0MNQ9d3q5FjTqgdlMfQitMEp0MASb+38NH05dRIIPyBRbWzWjeM/OT96LGL8d
 0cAvCh9WBGWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="154198754"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="154198754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 08:23:51 -0700
IronPort-SDR: D5HjTOQQ8XUTAZ5KqwkIZI2+Sl6lCiqo10yvKGicvldCXYqO+0DvOCbf2sKId9hni+b5uaieZq
 9tJ36pTC17lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="319067022"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2020 08:23:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1CD4DFC; Thu, 15 Oct 2020 18:23:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] kunit: Do not pollute source directory with generated files (.kunitconfig)
Date:   Thu, 15 Oct 2020 18:23:46 +0300
Message-Id: <20201015152348.65147-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When --build_dir is provided use it and do not pollute source directory
which even can be mounted over network or read-only.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/testing/kunit/kunit.py        | 25 ++++++++++++-------------
 tools/testing/kunit/kunit_kernel.py | 24 +++++++++++++++++++-----
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index ebf5f5763dee..1907bf9aacac 100755
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
 
+		linux.create_unitconfig(cli_args.build_dir)
+		linux.read_unitconfig(cli_args.build_dir)
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
 
+		linux.create_unitconfig(cli_args.build_dir)
+		linux.read_unitconfig(cli_args.build_dir)
+
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
 		result = config_tests(linux, request)
@@ -301,6 +294,9 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
+		linux.create_unitconfig(cli_args.build_dir)
+		linux.read_unitconfig(cli_args.build_dir)
+
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
 					    cli_args.alltests,
@@ -315,6 +311,9 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
+		linux.create_unitconfig(cli_args.build_dir)
+		linux.read_unitconfig(cli_args.build_dir)
+
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
 						cli_args.alltests)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index b557b1e93f98..412dc5e3102b 100644
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
@@ -18,7 +18,8 @@ import kunit_config
 import kunit_parser
 
 KCONFIG_PATH = '.config'
-kunitconfig_path = '.kunitconfig'
+KUNITCONFIG_PATH = '.kunitconfig'
+DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 
 class ConfigError(Exception):
@@ -99,19 +100,22 @@ class LinuxSourceTreeOperations(object):
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
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
 	def __init__(self):
-		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(kunitconfig_path)
 		self._ops = LinuxSourceTreeOperations()
 		signal.signal(signal.SIGINT, self.signal_handler)
 
@@ -123,6 +127,16 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
+	def create_unitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH):
+		kunitconfig_path = get_kunitconfig_path(build_dir)
+		if not os.path.exists(kunitconfig_path):
+			shutil.copyfile(defconfig, kunitconfig_path)
+
+	def read_unitconfig(self, build_dir):
+		kunitconfig_path = get_kunitconfig_path(build_dir)
+		self._kconfig = kunit_config.Kconfig()
+		self._kconfig.read_from_file(kunitconfig_path)
+
 	def validate_config(self, build_dir):
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.Kconfig()
-- 
2.28.0

