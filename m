Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2838A11C335
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfLLC1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:27:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35676 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfLLC13 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:27:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so295660pfo.2;
        Wed, 11 Dec 2019 18:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4gqvXa2BLZ9bvD5JyWPHEMSVSMpI1RHvNW+8EqyY50g=;
        b=V4FaCyAthEFgo31Ece9xJ8AvbqOnekpPHgQsN0IdDkZW9vve3CUcgJ+TeQegF9iXzX
         ta6V9aAPXxnGUz3mhmGXDjtveMsir9EhReVrLiXfwi2iqDtGesxYrGFfQpErfeTGnYbh
         +RARMa9IgZiN7hfKpn3zUWGrn8gdFCHT+hqx78hF0sswkuGuvcUmLVn388SP3po9JEIg
         KRUlx0pCEHPrPsEgqZZd6omBi412tWMcpGDDv82Ya4vcVi8sHjPB/wd4KzS1xY3QhhsA
         JMx8fRIv80BcdWROpTA4poKbIJu7nAuyDgyfw3sdWbf/69MU5VeGjILv4iX10hqbWH0e
         YM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4gqvXa2BLZ9bvD5JyWPHEMSVSMpI1RHvNW+8EqyY50g=;
        b=cmwHxCRIf/YnqphNctfEi2Jk3CNNy2Bu28YFSnMNiC0Oe1Jhksi8mLbHlKAWGLqeqy
         RNYt3um63TQpMznS4u6MrfdKMuvKJPGt4FlCubBHBKkLDLZsNFFTVNsZkJ1tqPxuPz+l
         7rFHj8fwDrJI107QQr0UoQn0eKXIi7EntO/IdTIzBtVxySX3sCwlYoQFZIUnp7Lti2gQ
         EDj0JWeBzY7YdFkGipsSGaoQzB7qd68bm6+GafimXUo7KDW/nYnizEaksISVDKB9IoTk
         X1p5aLvyNw2LpVdnyR8Hx/+z+JPf9m8K3XwoLCw2nwVM8242yrUi1IwsQWq01b5XtmV5
         VgtQ==
X-Gm-Message-State: APjAAAVovOzEBd50mmeYtCMToR+pDGKwZTC8Tw2hx9J1KR3/qRFy6b/C
        GjXJDUUDrtMv1FIruNrbUPI=
X-Google-Smtp-Source: APXvYqw4GnTOvZB0ywYS9j3IZ2Et1I8n8/EDMGqwD17xKwhUzSk6mgFviVenbWI9Hv4xR93yWt7dyA==
X-Received: by 2002:a63:8eca:: with SMTP id k193mr7748242pge.293.1576117648823;
        Wed, 11 Dec 2019 18:27:28 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id d22sm4245173pgg.52.2019.12.11.18.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 18:27:28 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sj38.park@gmail.com,
        sjpark@amazon.de
Subject: [PATCH v6 5/6] kunit: Rename 'kunitconfig' to '.kunitconfig'
Date:   Thu, 12 Dec 2019 02:27:10 +0000
Message-Id: <20191212022711.10062-6-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212022711.10062-1-sjpark@amazon.de>
References: <20191212022711.10062-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit renames 'kunitconfig' to '.kunitconfig' so that it can be
automatically ignored by git and do not disturb people who want to type
'kernel/' by pressing only the 'k' and then 'tab' key.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 12 +++++-------
 tools/testing/kunit/kunit.py            |  2 +-
 tools/testing/kunit/kunit_kernel.py     |  4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index d5197f1a45cb..4e1d24db6b13 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -24,18 +24,16 @@ The wrapper can be run with:
 For more information on this wrapper (also called kunit_tool) checkout the
 :doc:`kunit-tool` page.
 
-Creating a kunitconfig
-======================
+Creating a .kunitconfig
+=======================
 The Python script is a thin wrapper around Kbuild. As such, it needs to be
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
@@ -150,7 +148,7 @@ and the following to ``drivers/misc/Makefile``:
 
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

