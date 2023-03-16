Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4706BD713
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 18:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCPR3l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCPR3c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 13:29:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DF211FA
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:29:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a25dad4000000b0091231592671so2536314ybf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678987754;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uq7nE/DzfEkIETd0TF3h83fIBuNZuqidPfixIYK7CAQ=;
        b=czBNpX06izp1eLfvOstpmYwsBSgbtD3M+wd9P3LoNRWtG9xn8E0dAswbfRLY36v+x4
         7W0h4LdvAhJtzF4vVnjUWoQupVUqjP+Atu7xuHS3hLIczVKyfbrjzaGFmVkTw6pe/iIK
         Z0YsUig0v3lTXCDyw8J0CrMsVVW0P0SBWMVaNzAV30VI3HcDcyJ4wRMX9qdDkvMVvL5l
         IG8vfZJTuuORFgge4J1HK1ry3F4ttiG97z9asETUt93Fg5+hWJlxGoJFrEccR6nt25On
         n7JEpL7mkeHCUONlAl4nFeVqq3nRZtTb3LJhBBZ5vGP042gLpztn1LowpNTXKvjf+5VJ
         AAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987754;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uq7nE/DzfEkIETd0TF3h83fIBuNZuqidPfixIYK7CAQ=;
        b=ncBte4bNpSpWwnjSGUKZC290oAyHD9Ex1pt/FPJvBqP5up+p7oQeYvvx4AdQDaV3iS
         9uGjTDtBYQHoi08zkgEumWR2GNxqOCNf+Nzj5gt2ItEbMSc5IXJIPgwiCDkKmNKBkRL+
         X+joFUhl+CBCYRwZlyDBRkdreduYrEhH7B6loRfSRKzbUsANdR7+R+z3l9CBNC46k0Hz
         VXTqN7w0LwtTWxp76i0Ds7neDQz6YEgErbU8aeIuxJpO4SEdPisZqgm6c51yNMFzzSLG
         bCgb3fOT89fSeZDTUQYWhQ/TumKDEOfjF0j4N+/M1/FLWF+Bp/L21MOh0CVY2MotbmmQ
         hUgg==
X-Gm-Message-State: AO0yUKUE8erFWdNrTi0utG3mV11P+0ZgLAK0S6Zj0fOBSiah9LHrzI+o
        ohtJe1OoyzfFoa6HMAN+mfU9yKbJaa8d1Q==
X-Google-Smtp-Source: AK7set84MdG0TuJ2MrWwGLi0I46LN6Rd4Pu4yM++fxEoMwv+wzeTCkuqCWuG7lNq3aUZpdgi3jPWdInkSHT0WA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:2c5:b0:b45:5cbe:48b3 with SMTP
 id w5-20020a05690202c500b00b455cbe48b3mr6311269ybh.0.1678987754589; Thu, 16
 Mar 2023 10:29:14 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:28:59 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316172900.755430-1-dlatypov@google.com>
Subject: [PATCH 1/2] kunit: tool: add subscripts for type annotations where appropriate
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

E.g. for subprocess.Popen, it can be opened in `text=True` mode where it
returns strings, or `text=False` where it returns bytes.
To differentiate, you can annotate types as `Popen[str]` or
`Popen[bytes]`.

This patch should add subscripts in all the places we were missing them.

Reported-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/linux-kselftest/20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid/
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py  | 6 +++---
 tools/testing/kunit/kunit_printer.py | 2 +-
 tools/testing/kunit/run_checks.py    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 53e90c335834..e6fc8fcb071a 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -92,7 +92,7 @@ class LinuxSourceTreeOperations:
 		if stderr:  # likely only due to build warnings
 			print(stderr.decode())
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
 		raise RuntimeError('not implemented!')
 
 
@@ -112,7 +112,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		kconfig.merge_in_entries(base_kunitconfig)
 		return kconfig
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
 		kernel_path = os.path.join(build_dir, self._kernel_path)
 		qemu_command = ['qemu-system-' + self._qemu_arch,
 				'-nodefaults',
@@ -141,7 +141,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 		kconfig.merge_in_entries(base_kunitconfig)
 		return kconfig
 
-	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
+	def start(self, params: List[str], build_dir: str) -> subprocess.Popen[str]:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = os.path.join(build_dir, 'linux')
 		params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
index 5f1cc55ecdf5..015adf87dc2c 100644
--- a/tools/testing/kunit/kunit_printer.py
+++ b/tools/testing/kunit/kunit_printer.py
@@ -15,7 +15,7 @@ _RESET = '\033[0;0m'
 class Printer:
 	"""Wraps a file object, providing utilities for coloring output, etc."""
 
-	def __init__(self, output: typing.IO):
+	def __init__(self, output: typing.IO[str]):
 		self._output = output
 		self._use_color = output.isatty()
 
diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 066e6f938f6d..61cece1684df 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -37,7 +37,7 @@ def main(argv: Sequence[str]) -> None:
 	if argv:
 		raise RuntimeError('This script takes no arguments')
 
-	future_to_name: Dict[futures.Future, str] = {}
+	future_to_name: Dict[futures.Future[None], str] = {}
 	executor = futures.ThreadPoolExecutor(max_workers=len(commands))
 	for name, argv in commands.items():
 		if name in necessary_deps and shutil.which(necessary_deps[name]) is None:

base-commit: 2c6a96dad5797e57b4cf04101d6c8d5c7a571603
-- 
2.40.0.rc1.284.g88254d51c5-goog

