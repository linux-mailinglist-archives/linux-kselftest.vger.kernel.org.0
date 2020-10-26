Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699E729933C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 18:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775119AbgJZRA7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 13:00:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:9892 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1775081AbgJZQ7d (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 12:59:33 -0400
IronPort-SDR: NObXdMyr5XzqEMHqo6KJ29Rfpbgcu7sWxw3NTItE1D4xqgYxzLlD/ixYi1PaQYCBKWIypMACaZ
 ReY5MZUnW1AA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="164456421"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="164456421"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 09:59:32 -0700
IronPort-SDR: a6v+H8tRC+zm9Qlv7JC484VEUsgznHq4O2LR/QqL2MNaPnTX24PKUyTmpFDiD6UJs4bEz+hHFt
 /qR5k4mUK9rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="349967791"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2020 09:59:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6FD2173; Mon, 26 Oct 2020 18:59:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, SeongJae Park <sjpark@amazon.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v2 2/3] kunit: Do not pollute source directory with generated files (test.log)
Date:   Mon, 26 Oct 2020 18:59:26 +0200
Message-Id: <20201026165927.19020-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026165927.19020-1-andriy.shevchenko@linux.intel.com>
References: <20201026165927.19020-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When --build_dir is provided use it and do not pollute source directory
which even can be mounted over network or read-only.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
v2: added tags (Brendan)

 tools/testing/kunit/kunit_kernel.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 633a2efcfdbd..b4768fa03ce0 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -21,6 +21,7 @@ KCONFIG_PATH = '.config'
 KUNITCONFIG_PATH = '.kunitconfig'
 DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
+OUTFILE_PATH = 'test.log'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -89,11 +90,12 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise BuildError(e.output.decode())
 
-	def linux_bin(self, params, timeout, build_dir, outfile):
+	def linux_bin(self, params, timeout, build_dir):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = './linux'
 		if build_dir:
 			linux_bin = os.path.join(build_dir, 'linux')
+		outfile = get_outfile_path(build_dir)
 		with open(outfile, 'w') as output:
 			process = subprocess.Popen([linux_bin] + params,
 						   stdout=output,
@@ -112,6 +114,12 @@ def get_kunitconfig_path(build_dir):
 		kunitconfig_path = os.path.join(build_dir, KUNITCONFIG_PATH)
 	return kunitconfig_path
 
+def get_outfile_path(build_dir):
+	outfile_path = OUTFILE_PATH
+	if build_dir:
+		outfile_path = os.path.join(build_dir, OUTFILE_PATH)
+	return outfile_path
+
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
@@ -192,8 +200,8 @@ class LinuxSourceTree(object):
 
 	def run_kernel(self, args=[], build_dir='', timeout=None):
 		args.extend(['mem=1G'])
-		outfile = 'test.log'
-		self._ops.linux_bin(args, timeout, build_dir, outfile)
+		self._ops.linux_bin(args, timeout, build_dir)
+		outfile = get_outfile_path(build_dir)
 		subprocess.call(['stty', 'sane'])
 		with open(outfile, 'r') as file:
 			for line in file:
-- 
2.28.0

