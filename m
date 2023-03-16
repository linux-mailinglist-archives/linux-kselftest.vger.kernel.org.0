Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD5E6BDB42
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 23:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCPWHH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 18:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPWHH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 18:07:07 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ED787A2C
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:06:47 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 62-20020a630241000000b004fb3343142dso793256pgc.5
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679004407;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5w/bUTaQvv0dE6Z9kgV2X6M6GsXpoWgjbDaqKfzvjzU=;
        b=rIZGB5soI+YB2bwAFuUr9c+JWOpF0HrtgYe3XbqVePLIx5T7nAyu6sQkhvFb9ikBQo
         uFClwlCH26lx8vZzECJagMZ6U4LSE1qPlJW30AN2ao4CJ1fuFznQS06bR8Bm0RnSqNLs
         wYU7l/meIRfAoJGOe3R6K7zG9/xz+efX5pu0hxL4ei087YNIi/m8pAX03ul+Xt7Q+AjD
         4DyGkhls6+O8D5kD7nRnFqprRdqELs0uJnLd6uV6/H5HUFtZ0tGmwFSeYhbzBPkqU9i/
         mT/xyNImWDH4rmzcoZm942ZfNEU40kmejnt1+Xhh1wVM7wbpKI94Zm/l2SnrGI6R8LPj
         NsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679004407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5w/bUTaQvv0dE6Z9kgV2X6M6GsXpoWgjbDaqKfzvjzU=;
        b=oCHyJef0VlCVzPTH6/bR9ojaNDak/0jEvRcWzuKOGPnsrQ9y9s2DOvIppzu6ZlIaZq
         vf4E79+4VsnNhz7muY1J5akjf/ncvG4xmdqgrANBS7Ln+g+kjr31r60hkGQGtHPcFWH5
         g013VFLqr24iz5lScKYFA9+NHzlBHSXDNx+pAOaLCG0GqLvlQLSlNZGqezkjdH01QNmm
         PXl3Yt2Y/W0xo941Vvr/D9ebCewK1rSWFVX6Z5F7BJVvyf17R+4fjK8B74zuJ9OUrXqe
         q6O1YRzf/iTAD/DSMg3Jq3qZGHXkpPaKM2QUoA8FJADx8xC2piaUFWSfsEr6Gez36DKX
         d1WQ==
X-Gm-Message-State: AO0yUKWrBbRJGJsw297hkylzoMWqLeMt9DkXZyFyug2DqYL9J6v1570x
        ks0aByggIaBliONw93ZrSMqDIi3qfA5VCw==
X-Google-Smtp-Source: AK7set9G6xXgo9CVemOXGZSkb5l3LS0mB5VByXQai+nWomUeRMTKgZEe9bkPqW1cEceZEM3CoC6AxKvIwSYRdg==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:902:d2c7:b0:1a0:4664:319c with SMTP
 id n7-20020a170902d2c700b001a04664319cmr2318672plc.6.1679004406964; Thu, 16
 Mar 2023 15:06:46 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:06:36 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230316220638.983743-1-dlatypov@google.com>
Subject: [PATCH v2 1/3] kunit: tool: add subscripts for type annotations where appropriate
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, johannes@sipsolutions.net,
        Daniel Latypov <dlatypov@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
Note: this is unchanged, just added a 3rd patch to this series.
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

