Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD628F5C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 17:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbgJOPX4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 11:23:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:17294 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbgJOPX4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 11:23:56 -0400
IronPort-SDR: 5HwHKjmDIV1xF0KT0FqNqMyi3+FvBFreAueV8a2ZTRS5p7VmYKNWsjZuUa80aAPxdogn9nX29J
 0AOajtjLLq3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="230575478"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="230575478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 08:23:55 -0700
IronPort-SDR: Xy+7z4vQuoVQWTFb/85Av+35tiZa9NEoRvbPgsAsZcmPzT7XXVI3J5pN1mb53PeGdXp6RC+K+F
 VrpNRg/RtqQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; 
   d="scan'208";a="300344886"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Oct 2020 08:23:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31298163; Thu, 15 Oct 2020 18:23:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] kunit: Introduce get_file_path() helper
Date:   Thu, 15 Oct 2020 18:23:48 +0300
Message-Id: <20201015152348.65147-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015152348.65147-1-andriy.shevchenko@linux.intel.com>
References: <20201015152348.65147-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Helper allows to derive file names depending on --build_dir argument.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/testing/kunit/kunit_kernel.py | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 3a68dc51d33d..1f317bd1ec4f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -23,6 +23,11 @@ DEFAULT_KUNITCONFIG_PATH = 'arch/um/configs/kunit_defconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 OUTFILE_PATH = 'test.log'
 
+def get_file_path(build_dir, default):
+	if build_dir:
+		default = os.path.join(build_dir, default)
+	return default
+
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
 
@@ -92,9 +97,7 @@ class LinuxSourceTreeOperations(object):
 
 	def linux_bin(self, params, timeout, build_dir):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
-		linux_bin = './linux'
-		if build_dir:
-			linux_bin = os.path.join(build_dir, 'linux')
+		linux_bin = get_file_path(build_dir, 'linux')
 		outfile = get_outfile_path(build_dir)
 		with open(outfile, 'w') as output:
 			process = subprocess.Popen([linux_bin] + params,
@@ -103,22 +106,13 @@ class LinuxSourceTreeOperations(object):
 			process.wait(timeout)
 
 def get_kconfig_path(build_dir):
-	kconfig_path = KCONFIG_PATH
-	if build_dir:
-		kconfig_path = os.path.join(build_dir, KCONFIG_PATH)
-	return kconfig_path
+	return get_file_path(build_dir, KCONFIG_PATH)
 
 def get_kunitconfig_path(build_dir):
-	kunitconfig_path = KUNITCONFIG_PATH
-	if build_dir:
-		kunitconfig_path = os.path.join(build_dir, KUNITCONFIG_PATH)
-	return kunitconfig_path
+	return get_file_path(build_dir, KUNITCONFIG_PATH)
 
 def get_outfile_path(build_dir):
-	outfile_path = OUTFILE_PATH
-	if build_dir:
-		outfile_path = os.path.join(build_dir, OUTFILE_PATH)
-	return outfile_path
+	return get_file_path(build_dir, OUTFILE_PATH)
 
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
-- 
2.28.0

