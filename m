Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09076113649
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 21:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfLDUSc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 15:18:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38445 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfLDUSb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 15:18:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so1174452wmi.3;
        Wed, 04 Dec 2019 12:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hw/PdgUWT1yCBwttPcwcfDWhnblPCjMbi6dwFPhZ/vw=;
        b=ijj3wqgB7K1jG2Y4fiREEJOSWvp6OwDKzskpqqYtHNU2gx1LyMtqT5jxdJM/7P774s
         Vy2BN3IMV8fQEkvP/8YWIBn27APbNdEyWhNd7uNCmcsGLIB2ga7D8f+WFSBbPVvmxsaJ
         Yy9ggPY2J6bbbDHWQ7zoE2fbTZySoBpvcnbn657bPG9Tdgsu4CbTrvX0eCIOITpDZFTo
         WDG0yFSFux14GhAbrr8iT+FwvVi5NdoPEWvRBK0qLf1EjmKa121hHuG5xtTJQoHHeWu2
         Y0Nga5kPa0KqOaV34RoZRGloJwtmXGc0se/tPnMIfyt4EkjnYHgIBOOjF2dgXAMetnSk
         TI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hw/PdgUWT1yCBwttPcwcfDWhnblPCjMbi6dwFPhZ/vw=;
        b=KwYdqnh0kw76S4r3wx70DiZlxycLfI8cMgIOQVgQrrZwlySEUAL6we40rFgfL21Bpv
         UoqWnUGJmlyGnaZU3r5Q23H3yHZMEuEPcGB4wGCGXlPeTUQReddatT/LIVZEP2IEoEvo
         YYAbkxL6W32Wd/v0Sv/yPbstQp5BJvM5hyb7tca7LuyB/Rd/GTgYhNCDF1wFERtU/x9q
         N94RrH48dvJW7UOvVBIgkhOD174TiAieJBCfgzRkAxuRdX74mwd4HP4wTODFe2O1E3v5
         TeWSE5MroAA/K/q8dwH7LMYmb4k79Oroj8CWck31g03ZIQrDdmE7FmwPukyjkiPbEdyS
         V1UQ==
X-Gm-Message-State: APjAAAWCvs/Qccum9tQq58kPCt0mhlq+XBMBIViSlnEhczM5ajnAGO1v
        uU40rLUw7spGuNm1aegad2I=
X-Google-Smtp-Source: APXvYqzHRDl4P+OhoAK+ERpAAilvme9GlMA/jG3OJi3kJ6AIwEwu4vCxwcNrc3a7WNGKXcSaUQpkOA==
X-Received: by 2002:a05:600c:388:: with SMTP id w8mr1365579wmd.177.1575490708976;
        Wed, 04 Dec 2019 12:18:28 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f2sm7329254wmh.46.2019.12.04.12.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:18:28 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v4 5/5] kunit: Rename 'kunitconfig' to '.kunitconfig'
Date:   Thu,  5 Dec 2019 05:18:03 +0900
Message-Id: <1575490683-13015-6-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
References: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
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
index 78a0aed..faa6fa9 100644
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
index e4250c4..e59eb9e 100755
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
index a10c0c7..cc5d844 100644
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
2.7.4

