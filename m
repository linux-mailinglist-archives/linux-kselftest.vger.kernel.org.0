Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF38752C073
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiERRBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiERRBo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 13:01:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2A9D4C8
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 10:01:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7dbceab08so24083587b3.10
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pKq+ukUxGkB6N6xyDoqejZhxcnXMWWmls9VVeK1R/Co=;
        b=koWCgoV1+MzTaKj/y22npaD+DdjzHh6Dbk7mkNniJz6uKmYvQ9qXIUXqNAzit8kFgu
         m7zqD0ahN9O2rZeJd3P37WQrl4F9/18LjkVzjy2yPb8Z9nq38rVRPpkZ9S55wW2XrqZt
         DeWqVQ56J4Z/f+AftuozcAsFA7KCH79iIEUDMzbUMeQBnSXjiBGTeZcbC10noIXYdN3W
         LJKzsW4QXHOll7EiuoF5BOI9oycp6Twn90IFYWHGxbmqB869wfWN6DyGimoaI8EjvzAj
         gCascF0By6cm3O9mu9P0UKv/W0Qd7DRczimmpmOWkLWNyfUU7HeVjUzdKAyVCdl6cMDW
         7mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pKq+ukUxGkB6N6xyDoqejZhxcnXMWWmls9VVeK1R/Co=;
        b=rpTcbd5mcK6ZgFIkzbuR21s8pzY5IJuApqXjLQ0jzdF9shddxcvY0WNnLBsNJKDEKt
         h7ruP8lRq8XQWumiDGUKcUJTrcqAKFgu15fE7nmiW3rqI9Ct5gWkIhk2+9j5yLou3xDo
         RoWpH1efn5Dxj35N5ekM3Q6KOgJnDSgnE5i5uKVLFuyMLWjxt3DMztbozUHKTD/CAftb
         05IfOjrhmL8nE7Xlu39SaY1X6ECH+H8u7wFd7FH3Qcj8G04/IHndPbTHU51K5Cjhn+w5
         Sld+q/F4t3m8n6L0RoRg7LJHnEnOGExz0rw8SVLWQmx92MSl0cL7qSb6oaNyfmiTUp6w
         btgg==
X-Gm-Message-State: AOAM531THmFtu0A4Sw3sMBR+joNfvkRJLeAXKEg1VPDS68kGtIPh+6ef
        37DI/EqokNQ4UcoIAK33//G8t7JxPVJcHQ==
X-Google-Smtp-Source: ABdhPJyuqW2JlcYLahFvkPX3B0HO+rtDjIyM60zRUbOt0Biapvoofm0Ldrxjk1Y+yn8ZRVVPYC+nLz7dDY8KOw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a94f:2cb3:f298:ec1b])
 (user=dlatypov job=sendgmr) by 2002:a25:186:0:b0:64d:7067:226 with SMTP id
 128-20020a250186000000b0064d70670226mr560357ybb.446.1652893302212; Wed, 18
 May 2022 10:01:42 -0700 (PDT)
Date:   Wed, 18 May 2022 10:01:24 -0700
In-Reply-To: <20220518170124.2849497-1-dlatypov@google.com>
Message-Id: <20220518170124.2849497-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 3/3] kunit: tool: introduce --qemu_args
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Example usage:
$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
  --kconfig_add=CONFIG_SMP=y --qemu_args='-smp 8'

Looking in the test.log, one can see
> smp: Bringing up secondary CPUs ...
> .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
> smp: Brought up 1 node, 8 CPUs

This flag would allow people to make tweaks like this without having to
create custom qemu_config files.

For consistency with --kernel_args, we allow users to repeat this
argument, e.g. you can tack on a --qemu_args='-m 2048', or you could
just append it to the first string ('-smp 8 -m 2048').

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           | 14 +++++++++++++-
 tools/testing/kunit/kunit_kernel.py    | 10 +++++++---
 tools/testing/kunit/kunit_tool_test.py | 20 +++++++++++++++++---
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 8a90d80ee66e..e01c7964f744 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -10,6 +10,7 @@
 import argparse
 import os
 import re
+import shlex
 import sys
 import time
 
@@ -323,6 +324,10 @@ def add_common_opts(parser) -> None:
 				  'a QemuArchParams object.'),
 			    type=str, metavar='FILE')
 
+	parser.add_argument('--qemu_args',
+			    help='Additional QEMU arguments, e.g. "-smp 8"',
+			    action='append', metavar='')
+
 def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
@@ -368,12 +373,19 @@ def add_parse_opts(parser) -> None:
 
 def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
 	"""Returns a LinuxSourceTree based on the user's arguments."""
+	# Allow users to specify multiple arguments in one string, e.g. '-smp 8'
+	qemu_args: List[str] = []
+	if cli_args.qemu_args:
+		for arg in cli_args.qemu_args:
+			qemu_args.extend(shlex.split(arg))
+
 	return kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 			kunitconfig_path=cli_args.kunitconfig,
 			kconfig_add=cli_args.kconfig_add,
 			arch=cli_args.arch,
 			cross_compile=cli_args.cross_compile,
-			qemu_config_path=cli_args.qemu_config)
+			qemu_config_path=cli_args.qemu_config,
+			extra_qemu_args=qemu_args)
 
 
 def main(argv):
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index e93f07ac0af1..a791073d25f9 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -187,6 +187,7 @@ def _default_qemu_config_path(arch: str) -> str:
 	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
 def _get_qemu_ops(config_path: str,
+		  extra_qemu_args: Optional[List[str]],
 		  cross_compile: Optional[str]) -> Tuple[str, LinuxSourceTreeOperations]:
 	# The module name/path has very little to do with where the actual file
 	# exists (I learned this through experimentation and could not find it
@@ -207,6 +208,8 @@ def _get_qemu_ops(config_path: str,
 	if not hasattr(config, 'QEMU_ARCH'):
 		raise ValueError('qemu_config module missing "QEMU_ARCH": ' + config_path)
 	params: qemu_config.QemuArchParams = config.QEMU_ARCH  # type: ignore
+	if extra_qemu_args:
+		params.extra_qemu_params.extend(extra_qemu_args)
 	return params.linux_arch, LinuxSourceTreeOperationsQemu(
 			params, cross_compile=cross_compile)
 
@@ -220,17 +223,18 @@ class LinuxSourceTree:
 	      kconfig_add: Optional[List[str]]=None,
 	      arch=None,
 	      cross_compile=None,
-	      qemu_config_path=None) -> None:
+	      qemu_config_path=None,
+	      extra_qemu_args=None) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 		if qemu_config_path:
-			self._arch, self._ops = _get_qemu_ops(qemu_config_path, cross_compile)
+			self._arch, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
 		else:
 			self._arch = 'um' if arch is None else arch
 			if self._arch == 'um':
 				self._ops = LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
 			else:
 				qemu_config_path = _default_qemu_config_path(self._arch)
-				_, self._ops = _get_qemu_ops(qemu_config_path, cross_compile)
+				_, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
 
 		if kunitconfig_path:
 			if os.path.isdir(kunitconfig_path):
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index baee11d96474..7fe5c8b0fb57 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -649,7 +649,8 @@ class KUnitMainTest(unittest.TestCase):
 						kconfig_add=None,
 						arch='um',
 						cross_compile=None,
-						qemu_config_path=None)
+						qemu_config_path=None,
+						extra_qemu_args=[])
 
 	def test_config_kunitconfig(self):
 		kunit.main(['config', '--kunitconfig=mykunitconfig'])
@@ -659,7 +660,8 @@ class KUnitMainTest(unittest.TestCase):
 						kconfig_add=None,
 						arch='um',
 						cross_compile=None,
-						qemu_config_path=None)
+						qemu_config_path=None,
+						extra_qemu_args=[])
 
 	def test_run_kconfig_add(self):
 		kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
@@ -669,7 +671,19 @@ class KUnitMainTest(unittest.TestCase):
 						kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
 						arch='um',
 						cross_compile=None,
-						qemu_config_path=None)
+						qemu_config_path=None,
+						extra_qemu_args=[])
+
+	def test_run_qemu_args(self):
+		kunit.main(['run', '--arch=x86_64', '--qemu_args', '-m 2048'])
+		# Just verify that we parsed and initialized it correctly here.
+		self.mock_linux_init.assert_called_once_with('.kunit',
+						kunitconfig_path=None,
+						kconfig_add=None,
+						arch='x86_64',
+						cross_compile=None,
+						qemu_config_path=None,
+						extra_qemu_args=['-m', '2048'])
 
 	def test_run_kernel_args(self):
 		kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'])
-- 
2.36.1.124.g0e6072fb45-goog

