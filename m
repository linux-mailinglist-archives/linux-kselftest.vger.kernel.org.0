Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B21274FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 06:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfLTFO1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 00:14:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34844 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfLTFOZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 00:14:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so8154899wro.2;
        Thu, 19 Dec 2019 21:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=inbP6pGKtJxItdKOeeuDolxjjunfcHjYuKaxBqpxDrE=;
        b=IVWfBjRJRqaIGCacBEb+txUGuYGchEc3SzdoOwUuW4r4HzAzPgRYpIzG7vjyVGxLwK
         wwTH0nM3J2KCGbCnpq0+nBO0xNfwjK/yDSBETHIs40P6rK5vkDaC/NLojfesofJTL/lS
         WjL2w3AttGgKAFRIDP8VbkpDZwWBHgSFVQHIo3jKmFhe/cXj4tUvfRPTurZt5oY+sQqU
         8bBkodbhLWPNPykLOi3v10kjkoFe37f35Gf3NGHFJ+8oL3zck7DV3VnY01ppqhVT+B45
         iXVKzMSGdGgyZem3A/6FwuCk2ddb70RJgRgO6mop9CETKXkwApPXcwMZXZyt8PbGvOe1
         WsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=inbP6pGKtJxItdKOeeuDolxjjunfcHjYuKaxBqpxDrE=;
        b=t1xaIBGyA6Z17ElKBKavr+4iPGmYgDECDIQL6rL+uapi3LXDVWciqKP3DWfOakwnov
         hJg3RcNedmEWF/rDQLR5Kdb0Xi79ycGDqsAsVso3siLOHFh1JOAWlxbh0ZkITIhb+FXI
         h44eLtJ56yJacqHEmOyxcmOsZtx4Pa8sxIMxk+xOC+Wl4G3hfCF+QJD+mwSJsMs+o4pL
         6JlnTUBfnCNMq2TbVSetrGsPIMO4uCUiqRTQmeT23QuPZmRcO9nxNgakP1dXPB+adBtI
         WUHbwd+FTOhy8NRAaJ6OqexZScixilT+7Jug9LEhE4jWyPBidFwhvH/Ki/eC2rKFq2wU
         8vPg==
X-Gm-Message-State: APjAAAXuJA8QRSfrjTE8c995dSluFsIOB4SZC9e5CN0bOW8HNaBytqAV
        4TCfk8hjFdaAf+rpWAY8byk=
X-Google-Smtp-Source: APXvYqxfFKBom/UlscLNj/eyveSar2ly0Z+JmQKMrrOd6TKgCR6aBNnyx3dPWgaNrdfsG6pVoEgW0A==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr13025748wrr.211.1576818863463;
        Thu, 19 Dec 2019 21:14:23 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id j12sm8703863wrt.55.2019.12.19.21.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:14:22 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     shuah@kernel.org
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sj38.park@gmail.com, sjpark@amazon.com, sjpark@amazon.de
Subject: [PATCH v7 5/6] kunit: Rename 'kunitconfig' to '.kunitconfig'
Date:   Fri, 20 Dec 2019 05:14:07 +0000
Message-Id: <20191220051408.3591-6-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220051408.3591-1-sjpark@amazon.de>
References: <20191220051408.3591-1-sjpark@amazon.de>
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

