Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D530029933A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 18:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775084AbgJZRA6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 13:00:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:47764 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1775119AbgJZQ7f (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 12:59:35 -0400
IronPort-SDR: RV5cc06c4FYeSrFaWBVCKn286eFe11KvbVMG6QPzZAx6EHSgKIwF2Wa7T+cFdWHibVe+ly0NbF
 8yG7uUbV1g4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168077924"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168077924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 09:59:32 -0700
IronPort-SDR: gQqa/wCLlj462fRNL76nSH9vYqOxgVpTeg9OpJypn24Xp8iMf0aW/1Fe2jK8c/xSnKMxWRdYO2
 xYP48bFP0RYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="303472428"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2020 09:59:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75072176; Mon, 26 Oct 2020 18:59:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, SeongJae Park <sjpark@amazon.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v2 3/3] kunit: Introduce get_file_path() helper
Date:   Mon, 26 Oct 2020 18:59:27 +0200
Message-Id: <20201026165927.19020-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026165927.19020-1-andriy.shevchenko@linux.intel.com>
References: <20201026165927.19020-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Helper allows to derive file names depending on --build_dir argument.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
v2: added tags (Brendan)

 tools/testing/kunit/kunit_kernel.py | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index b4768fa03ce0..7e3f7f9aac96 100644
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

