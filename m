Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E84446BCA
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Nov 2021 02:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhKFBeX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 21:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhKFBeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 21:34:07 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DDC061208
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 18:31:27 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id w13-20020a63934d000000b002a2935891daso6578137pgm.15
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 18:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rGcmjA/j5YSiPxOgdFBdWWohlL0jP6/mUsKPVghnr4I=;
        b=MbksyRPwvHzn2D9kEA69RkwJUR10fyJsMat7MWPfaZmtGAXbfISs2IeOPsgI7YLFhf
         +kq1l+d8j6lgZYS+CxAFwNl2L38eeVMAniRZARqN6REk7agTMaNfX5qwJ84Ol7HUdCtl
         kyEQIKsT4PXSk+fNx9JSjRvoYTnhDinsbxLJ+5FXB83/4sZqo6j8cLVJ77aAdiHD7t5B
         h6itlW7EnemDhz1PxnIOVp9FxBagyxLM8kisk3hjUtdRgsMx2Ylm48xDkm+0PEDMLaAd
         O2loDPttEJB1zNEbfp4sxcP5picFkfT1pZakWYKv5n7oMidbNypCcsXdGkXvuUI5K16Y
         M5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rGcmjA/j5YSiPxOgdFBdWWohlL0jP6/mUsKPVghnr4I=;
        b=aGuyKOOqiFIytQh7X+uKoKxvmhgAlcmEgHeH7ciJMzzI1UZNCogK6K6mvQD5gtIzMf
         V2uiiGa/ankFQKileg1eGo9IvR18oiU4XEIRd1rVXn4MBHzMwLiVO+mOM5xJibkRUiJq
         efMVA6KpCvktuIk3AjZjWQXS084jwYwQQ3ATMkyjdct4Xb5BJxxU7ZOw07lxY3KdNqTv
         5fh8Fiwt98M2MBhjLK430Tm0qv1ppznWovATPNxs0tbrSB/QF8/pMv/wgQkfiffjK7u3
         9mDlsAd9uAO/TAiKy/9GD8skV/hvLczxD2Sh7WzWnzsm17f9xsMJnhO4mndPve/urdpS
         XnGA==
X-Gm-Message-State: AOAM533ahxjzCusu7coiuDjS0h4ewPeJr3A0ZPTFO37/faevavdn+lob
        lq0ku5uCqSiJGQG7D//kDBjHyWjF/V1dJw==
X-Google-Smtp-Source: ABdhPJy2lN2qJD/6dXovb3xQuKJWmDNYpbWa20NAbp2Djm83M3BoDvAyNIqKFy8W9YnImFrI5oAVgvTAuJRUZw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:6353:c04e:9de:d603])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:1381:b0:480:fde6:35e4 with SMTP
 id t1-20020a056a00138100b00480fde635e4mr44067369pfg.5.1636162286893; Fri, 05
 Nov 2021 18:31:26 -0700 (PDT)
Date:   Fri,  5 Nov 2021 18:30:58 -0700
In-Reply-To: <20211106013058.2621799-1-dlatypov@google.com>
Message-Id: <20211106013058.2621799-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20211106013058.2621799-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 2/2] kunit: tool: add --kconfig_add to allow easily tweaking kunitconfigs
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

E.g. run tests but with KASAN
$ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y

This also works with --kunitconfig
$ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=fs/ext4 --kconfig_add=CONFIG_KASAN=y

This flag is inspired by TuxMake's --kconfig-add, see
https://gitlab.com/Linaro/tuxmake#examples.

Our version just uses "_" as the delimiter for consistency with
pre-existing flags like --build_dir, --make_options, --kernel_args, etc.

Note: this does make it easier to run into a pre-existing edge case:
$ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kconfig_add=CONFIG_KASAN=y
$ ./tools/testing/kunit/kunit.py run --arch=x86_64
This second invocation ^ still has KASAN enabled!

kunit.py won't call olddefconfig if our current .config is already a
superset of the provided kunitconfig.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           |  8 ++++++++
 tools/testing/kunit/kunit_kernel.py    |  5 +++++
 tools/testing/kunit/kunit_tool_test.py | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 68e6f461c758..be58f4c93806 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -280,6 +280,10 @@ def add_common_opts(parser) -> None:
 			     ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
 			     'will get  automatically appended.',
 			     metavar='kunitconfig')
+	parser.add_argument('--kconfig_add',
+			     help='Additional Kconfig options to append to the '
+			     '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
+			    action='append')
 
 	parser.add_argument('--arch',
 			    help=('Specifies the architecture to run tests under. '
@@ -398,6 +402,7 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
+					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
@@ -423,6 +428,7 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
+					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
@@ -439,6 +445,7 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
+					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
@@ -457,6 +464,7 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
+					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 51ee6e5dae91..7d459d6d6ff2 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -224,6 +224,7 @@ class LinuxSourceTree(object):
 	      build_dir: str,
 	      load_config=True,
 	      kunitconfig_path='',
+	      kconfig_add: Optional[List[str]]=None,
 	      arch=None,
 	      cross_compile=None,
 	      qemu_config_path=None) -> None:
@@ -249,6 +250,10 @@ class LinuxSourceTree(object):
 				shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
 
 		self._kconfig = kunit_config.parse_file(kunitconfig_path)
+		if kconfig_add:
+			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
+			self._kconfig.merge_in_entries(kconfig)
+
 
 	def clean(self) -> bool:
 		try:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 4ec70e41ec5a..7e42a7c27987 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -334,6 +334,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				pass
 			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 
+	def test_kconfig_add(self):
+		tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
+		self.assertIn(kunit_config.KconfigEntry('NOT_REAL', 'y'), tree._kconfig.entries())
+
 	def test_invalid_arch(self):
 		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
 			kunit_kernel.LinuxSourceTree('', arch='invalid')
@@ -540,6 +544,7 @@ class KUnitMainTest(unittest.TestCase):
 		# Just verify that we parsed and initialized it correctly here.
 		mock_linux_init.assert_called_once_with('.kunit',
 							kunitconfig_path='mykunitconfig',
+							kconfig_add=None,
 							arch='um',
 							cross_compile=None,
 							qemu_config_path=None)
@@ -551,6 +556,19 @@ class KUnitMainTest(unittest.TestCase):
 		# Just verify that we parsed and initialized it correctly here.
 		mock_linux_init.assert_called_once_with('.kunit',
 							kunitconfig_path='mykunitconfig',
+							kconfig_add=None,
+							arch='um',
+							cross_compile=None,
+							qemu_config_path=None)
+
+	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
+	def test_run_kconfig_add(self, mock_linux_init):
+		mock_linux_init.return_value = self.linux_source_mock
+		kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
+		# Just verify that we parsed and initialized it correctly here.
+		mock_linux_init.assert_called_once_with('.kunit',
+							kunitconfig_path=None,
+							kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
 							arch='um',
 							cross_compile=None,
 							qemu_config_path=None)
-- 
2.34.0.rc0.344.g81b53c2807-goog

