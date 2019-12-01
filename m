Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54B10E3DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 00:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfLAXZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 18:25:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35664 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfLAXZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 18:25:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so9888754wro.2;
        Sun, 01 Dec 2019 15:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fWlVQQ7BGjjRSAk/bgCXHsVzfE8yYuX6nxPeJuLphn8=;
        b=Mp6PBDwok9zKHQgQwFIqsk8Kp13EuqwQgDStOdtp+jslRIbHY+t8AK1gLB3dgxw38i
         nmeKUiA+Le18w85SifDtKTcp8iDoQHbJjj46dUpMKHu81+z79UApQwecxqo8/EA9TE8b
         KmfXPa0Ib+SsF+e8rJEhfzdSQMR8w18Cixxn0VoSA+RJCpdQZPDREbHtklOiEEa/AlVE
         GqmWPwOcLfwiPTAWT1IXXuUlCbX7KDh2BWFZuQspi8fFe7wXxPfHPWBeaKIOXdHSIdtl
         36YQNx5tiSYurc8WxjJvi48yeyYTfIPdi1so4DPMlmbsLw86YETOD205NyLJdT+06H7G
         Y8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fWlVQQ7BGjjRSAk/bgCXHsVzfE8yYuX6nxPeJuLphn8=;
        b=A3a+CpgTncmypnuBtT6FxDr+a//ejGVHNF3oXm8BMr76MR2b+4zWA1mKeQKv2UKsoU
         bBYBSkXt04P2t76B7TX2IGiIDzYZF/tY36gQFMIJv35xHPqPUmq883W2fWnfzPedDhgu
         Ikte8cagU3FKI/m/v5fWsqfiJUDHdUUWvfmv/M3+uel08wZAv6YexAgvaJ/D8mQ49KYK
         iaOeuqUZA3xXH4rK76QEPc0xGOnytW+OlY91p5ynlV+9UuKLub2bHBscl9zWyjfScEdH
         cTx0mBxGr2eEbEGj80S4Z5XZlXmDXvujim1Zv6sMnMKjUmABOJSgj5dcpD6P+sXwNC/n
         wxuQ==
X-Gm-Message-State: APjAAAU4q1eQv4+MxVPhwVmL+4t+E6Cd37mQ7Y6M0G51Lxq1xuEvvL8u
        iWVKIZrHs9SrIFu6Yol2yrk=
X-Google-Smtp-Source: APXvYqzn/ztyle4DWAe6RVHE5z16tim7uASA6oB6ZOky9JKO0016DSgwVvnTw5//h32ruU28bIH4gA==
X-Received: by 2002:a05:6000:1044:: with SMTP id c4mr46983995wrx.204.1575242748425;
        Sun, 01 Dec 2019 15:25:48 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id y6sm37450454wrl.17.2019.12.01.15.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Dec 2019 15:25:47 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 6/6] kunit: Rename 'kunitconfig' to '.kunitconfig'
Date:   Mon,  2 Dec 2019 08:25:24 +0900
Message-Id: <1575242724-4937-7-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit renames 'kunitconfig' to '.kunitconfig' so that it can be
automatically ignored by git and do not disturb people who want to type
'kernel/' by pressing only the 'k' and then 'tab' key.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/dev-tools/kunit/start.rst | 12 +++++-------
 tools/testing/kunit/kunit.py            |  2 +-
 tools/testing/kunit/kunit_kernel.py     |  4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index e25978d..f2e585e 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -15,18 +15,16 @@ Included with KUnit is a simple Python wrapper that helps format the output to
 easily use and read KUnit output. It handles building and running the kernel, as
 well as formatting the output.
 
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
@@ -141,7 +139,7 @@ and the following to ``drivers/misc/Makefile``:
 
 	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
 
-Now add it to your ``kunitconfig``:
+Now add it to your ``.kunitconfig``:
 
 .. code-block:: none
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 1746330..309d6e3 100755
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
index b640939..507364d 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,7 +14,7 @@ import os
 import kunit_config
 
 KCONFIG_PATH = '.config'
-KUNITCONFIG_PATH = 'kunitconfig'
+KUNITCONFIG_PATH = '.kunitconfig'
 
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

