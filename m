Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F6110406
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLCSIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 13:08:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46838 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfLCSIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 13:08:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so4823395wrl.13;
        Tue, 03 Dec 2019 10:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utI8T3ub3njoo3SG3qDSzeTSz7Igjg4spb9ZghayKKs=;
        b=TPAqcrUBFgsNoCNlfTYvD79cGW3We4dCSvEpwKac8sXZjVaROaRAC6byzyAvOp3tD7
         j4aELxcnPwwj/TyFchTPDxOY/IT1ZzWlIrpNYwlJDZoagOeyF23RjmS6iqngebj7d5WC
         i5bjSovI+wJlea+K1Xn1TwkSP3bobu/DtA80K/4w12J8o9uogkRtY44izC6F3D76jXxE
         sXTQuw5adD2ZX6YffnKEnq0K/cU4H5JHWRvB2n/QXFLSSFhHsem+hCWnHOIyZvydVNsY
         MtAH+54bmIFybguY/MT1hXxkn6HK23qiNgcM6I+DM6muMr6e0CYQ7kAER7eLgfdlxQ0r
         sziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utI8T3ub3njoo3SG3qDSzeTSz7Igjg4spb9ZghayKKs=;
        b=Kg05LaULpBfBN+ycZg8xuRytMPUdutXb6T6VjUJSlawUiPHpb0CXPh129e/wv8dfxg
         EIOpYhPDk2lvsMcT6Gd3O/a0Jdfh6XMvk/WSPIbdEgllHb3BE9nWc+dx8DLacJSwxy3b
         EV2hNvrweBSq8ecdeVXNp29iEf9bVdWkGYL4xGhZXmUOOwcThgLchhegBw7/FHT+pGB8
         p42Mcgv7LTjjy/nsLzBQXXhup8562xfmoZvDUXEfx1PMYWqKZEbbXp24JmXx19xCkQkO
         PcCWYWLU8gM0qLet9RqyEi6KE5o+hXefBnqOhO1hI5xPhHxOKhS07I6m9dDaINjOX5Uu
         mOsw==
X-Gm-Message-State: APjAAAXmZ4pG3zdn3GWybS/YaevdySbLUYT0NUEfjWoiCdt3DPS5AJvd
        BEZWyTfVopECrfa72ZjMQCg=
X-Google-Smtp-Source: APXvYqw3TlmYnGRbwHnOsrvUt+RJYDvE7lNoIJCWOMCOhMzR3oNZs3vvtEGjD6vhoYuTqhE9HzsVXw==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr6981474wro.249.1575396525182;
        Tue, 03 Dec 2019 10:08:45 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f11sm3847641wmc.25.2019.12.03.10.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 10:08:44 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v3 3/5] kunit: Create default config in '--build_dir'
Date:   Wed,  4 Dec 2019 03:08:26 +0900
Message-Id: <1575396508-21480-4-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

If both '--build_dir' and '--defconfig' are given, the handling of
'--defconfig' ignores '--build_dir' option.  This commit modifies the
behavior to respect '--build_dir' option.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Suggested-by: Brendan Higgins <brendanhiggins@google.com>
Reported-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 11 +++++++++--
 tools/testing/kunit/kunit_kernel.py |  4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f8f2695..5b22241 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -31,9 +31,9 @@ class KunitStatus(Enum):
 	TEST_FAILURE = auto()
 
 def create_default_kunitconfig():
-	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+	if not os.path.exists(kunit_kernel.kunitconfig_path):
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
-				kunit_kernel.KUNITCONFIG_PATH)
+				kunit_kernel.kunitconfig_path)
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
@@ -114,6 +114,13 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
 		if cli_args.defconfig:
 			create_default_kunitconfig()
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf38768..c04a12e 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,7 +14,7 @@ import os
 import kunit_config
 
 KCONFIG_PATH = '.config'
-KUNITCONFIG_PATH = 'kunitconfig'
+kunitconfig_path = 'kunitconfig'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -82,7 +82,7 @@ class LinuxSourceTree(object):
 
 	def __init__(self):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(KUNITCONFIG_PATH)
+		self._kconfig.read_from_file(kunitconfig_path)
 		self._ops = LinuxSourceTreeOperations()
 
 	def clean(self):
-- 
2.7.4

