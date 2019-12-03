Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D36E810F9AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLCIT0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:19:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50560 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfLCITW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:19:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so1997839wmg.0;
        Tue, 03 Dec 2019 00:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hrxYiLpa3QTymxbUAIdHVm+JWAvpyOBH5sypJmOwe7c=;
        b=HEB7pHIFMe8tGDiqif9q6gOd0S0IlCgYJebKo6KUjXI6/jQuLq8MBWNpVIZpwI2tFE
         Kor7si9mr1kcjzjkw/89qU+Pw3StyZYreX+j+U5tChsCh0J6AOPBLubUoszpR0ApZbYP
         vKsZTfSFixVG95knJ3gpy+cjiTIsjB4CYeD+hxP37hsab3ZIP5/napk6ZciZyuHig9rW
         DbOMndMJHLUHFVbalFRn255Y7NEDyiBtNpnQPzPtQPItMcYDiIE/1n78v7MEd9RkjEU0
         jAFg6ua4DqsRaWtcFE97RWJ8OodPfLfd79MNh9vc3KsonphCBgmkj+QaeegbyYZnx7We
         wJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hrxYiLpa3QTymxbUAIdHVm+JWAvpyOBH5sypJmOwe7c=;
        b=n0jdN4MOFoUip/9eOgFQ1ZLOU8/IavC3uLf4Fj+q4j56lvN4em3N0T4zJKV/guNB0z
         UBXwWhxANUFm1/zqdxLNjChFUmbgQ+BcXtzavdFqrzNWMJ2x8Ow5FMTYeLSEn2GNnTd3
         3cPXgrkXL7wB+6U7vDfa/2FK4CSxMeO66N1Diwmga7O0jdCqZRJBNiMCpe30bmyddrjU
         BOKSDpwKf/ucguribH+GxjzltpTDC9jOFIE2Lh7c+veIEVugEyx1k4krZk/06xGTT1bL
         y7G1tHLAeLIiWKsV/M4CsXj6NQR1oyjq7YEH7heU5Au4ezEIjN+wzM5wkbJqpUf2RCZg
         SgxA==
X-Gm-Message-State: APjAAAWjztiDcbzqeAt1j8c5ArOUNomS+O/mqBbZkLl5N+j9LopZbVPk
        6/BRUETQpZ7dcxwLVvuGYH4=
X-Google-Smtp-Source: APXvYqxOfbxqVAk5joKQvTT+mo/q8KQ2fLmYjsAmLWIaeBZW9B+YiUDwVNl8ONBIKD3hkuRHy2tkIg==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr30595682wmd.80.1575361159979;
        Tue, 03 Dec 2019 00:19:19 -0800 (PST)
Received: from localhost.localdomain (p50991abe.dip0.t-ipconnect.de. [80.153.26.190])
        by smtp.gmail.com with ESMTPSA id 188sm2048197wmz.13.2019.12.03.00.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 00:19:19 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjpark@amazon.de
Subject: [PATCH v2 5/5] kunit: Rename 'kunitconfig' to '.kunitconfig'
Date:   Tue,  3 Dec 2019 17:19:01 +0900
Message-Id: <1575361141-6806-6-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
References: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
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
index 02a54d8..8c0b2c4 100755
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

