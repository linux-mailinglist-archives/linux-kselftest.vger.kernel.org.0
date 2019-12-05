Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D34113E41
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfLEJi2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 04:38:28 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55620 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbfLEJi1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 04:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575538707; x=1607074707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fr4yypOIlHXyvtCM/n2iJREFkZT+H434dWtQtuRZ8lE=;
  b=iBRom0py9Lxpg4ZtPGriSpwAeLyTC/Npt7y1eC/ll90ISL0jPt1i0SGS
   DDLupUloKohD26Si8bdYACYzyHjsCIi0XQuAXivAvjKVRf1gznWj7yBvZ
   exHKx6/V+HwHS+nggtYt28RmMil5ceKFUlFucBi6TFxng8heYI5ePYixl
   U=;
IronPort-SDR: vwKxWpcdIIVEqDKGrA9mACVxdY61nw41IgJp6+LUNLcbBhGIGYI+f9MOgu0jtgicNJAkwvIVne
 47fkuN3rxT7Q==
X-IronPort-AV: E=Sophos;i="5.69,280,1571702400"; 
   d="scan'208";a="7181764"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Dec 2019 09:38:26 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 527B7A065C;
        Thu,  5 Dec 2019 09:38:24 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:38:23 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.249) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:38:19 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <sj38.park@gmail.com>, <corbet@lwn.net>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <sjpark@amazon.de>
Subject: [PATCH v5 5/6] kunit: Rename 'kunitconfig' to '.kunitconfig'
Date:   Thu, 5 Dec 2019 10:38:04 +0100
Message-ID: <20191205093804.22802-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205093440.21824-1-sjpark@amazon.com>
References: <20191205093440.21824-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.249]
X-ClientProxiedBy: EX13D35UWC002.ant.amazon.com (10.43.162.218) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit renames 'kunitconfig' to '.kunitconfig' so that it can be
automatically ignored by git and do not disturb people who want to type
'kernel/' by pressing only the 'k' and then 'tab' key.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 12 +++++-------
 tools/testing/kunit/kunit.py            |  2 +-
 tools/testing/kunit/kunit_kernel.py     |  4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 78a0aed4931d..faa6fa99f903 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -21,18 +21,16 @@ The wrapper can be run with:
 
    ./tools/testing/kunit/kunit.py run
 
-Creating a kunitconfig
-======================
+Creating a .kunitconfig
+=======================
 The Python script is a thin wrapper around Kbuild as such, it needs to be
-configured with a ``kunitconfig`` file. This file essentially contains the
+configured with a ``.kunitconfig`` file. This file essentially contains the
 regular Kernel config, with the specific test targets as well.
 
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
-	cp arch/um/configs/kunit_defconfig kunitconfig
-
-You may want to add kunitconfig to your local gitignore.
+	cp arch/um/configs/kunit_defconfig .kunitconfig
 
 Verifying KUnit Works
 ---------------------
@@ -147,7 +145,7 @@ and the following to ``drivers/misc/Makefile``:
 
 	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
 
-Now add it to your ``kunitconfig``:
+Now add it to your ``.kunitconfig``:
 
 .. code-block:: none
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e4250c4b06fb..e59eb9e7f923 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -108,7 +108,7 @@ def main(argv, linux=None):
 				type=str, default='', metavar='build_dir')
 
 	run_parser.add_argument('--defconfig',
-				help='Uses a default kunitconfig.',
+				help='Uses a default .kunitconfig.',
 				action='store_true')
 
 	cli_args = parser.parse_args(argv)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index a10c0c787bc1..cc5d844ecca1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,7 +14,7 @@ import os
 import kunit_config
 
 KCONFIG_PATH = '.config'
-kunitconfig_path = 'kunitconfig'
+kunitconfig_path = '.kunitconfig'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -111,7 +111,7 @@ class LinuxSourceTree(object):
 		return True
 
 	def build_reconfig(self, build_dir):
-		"""Creates a new .config if it is not a subset of the kunitconfig."""
+		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
 			existing_kconfig = kunit_config.Kconfig()
-- 
2.17.1

