Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25F311040C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 19:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfLCSIv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 13:08:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32836 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfLCSIt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 13:08:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so4967972wrq.0;
        Tue, 03 Dec 2019 10:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3nP6VZ8Fjqwgvw9G0ddXuiCEaSnGP/358VA7wzbcUPI=;
        b=TqWyU0JYS/1QxWfJrpgPb0N3WdqRrJMsCIXH26w2dmUVLbCq//aExSX3fVv1Z/XTiy
         /5PtnOUdGo8/wT1ifLbawDVCAseNygP8jl0iVfnDXg9TkSPaRH29AI8dpTbZqR5nxYzO
         19fpDGKUmizGcJAe02oKx8uRBO8e0VB/Y4z1c+kTFHk6IxwYaBwTJNAewyFlHI8RxIwQ
         QGm2JQhy6WJoQnAJ07Q+9C3f6aX1Ltwqq6s5plp0fGCuXT7QmHaT2fbZI/05ujj2omgB
         Lkze9Ppo4CcF5Lt6LvYrYjpuooEFlxhmNf/Hc1UFVKAhX5EJMedLVk0faDRDmHqFYcVt
         RpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3nP6VZ8Fjqwgvw9G0ddXuiCEaSnGP/358VA7wzbcUPI=;
        b=NinNYLuwutl5MLJOn+bZnhUXxKF2V51Ijn1DXSNQ8TzlO66FsuTw3ucwW4+Y4OZHow
         Pxijikit2cKRq2JY+x0lx/bucJTVuirPH0/rgKNt3O6NMWRnbDz4JnXc+SFuPRQjOvuA
         9B+WqYU69XkBUzr8IKGSMsZf0S+9fMhRveqPd6LPxBUdYp/e8i80boVXWbh9RxP3uCf2
         nWDt7L/jXYx2EChuMuJNsUVchMA1BfxMIuPuzdX7rOHPcCXuevC8zIvHa5l+DaLX/vJT
         ZmF23CHmRYj0g5PN28RftjwYl+tXjGO6QkS8hnDcOwCLEcA+pHfe8Q7KoeX821ZKIYvJ
         zk6A==
X-Gm-Message-State: APjAAAUBLWUxhdiz74QgODtw4PhJQVk9YibqJj2pwhqFuHssKF5/DwvO
        HKrroDsyrujy26n6Gm9IBwo=
X-Google-Smtp-Source: APXvYqxunmSS3YEJs+zJB8zE7O7p6NgDz/9D7hcFGKvEsuTvUE5qFlMI3ca8sfDP1HhRV/Fb0t7tgQ==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr6229894wrt.136.1575396527796;
        Tue, 03 Dec 2019 10:08:47 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f11sm3847641wmc.25.2019.12.03.10.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 10:08:47 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v3 5/5] kunit: Rename 'kunitconfig' to '.kunitconfig'
Date:   Wed,  4 Dec 2019 03:08:28 +0900
Message-Id: <1575396508-21480-6-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
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
index 5b22241..257722f 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -108,7 +108,7 @@ def main(argv, linux=None):
 				type=str, default=None, metavar='build_dir')
 
 	run_parser.add_argument('--defconfig',
-				help='Uses a default kunitconfig.',
+				help='Uses a default .kunitconfig.',
 				action='store_true')
 
 	cli_args = parser.parse_args(argv)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 5bec97e..fca1933 100644
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

