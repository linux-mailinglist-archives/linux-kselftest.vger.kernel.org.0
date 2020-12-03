Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A62CDF20
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 20:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgLCTnC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 14:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgLCTnC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 14:43:02 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC0C061A54
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 11:41:50 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i2so2565624qvb.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=H/fZbmoWqzYc8jvqwlQOthSJhqMeLZZmIovfXBc346E=;
        b=DxXIGzRzJ66lZ8y3ytRkn5BwpOmx0Iy21DjMCL/KRcB9mxGmSFs69nX65JyP8tkl3M
         +hpIP2/ATqLhjh1D5w3Y6G2o1/CCCh6OwxEQ127c07n3/6Ffp6VDuqikJwd2tqzkzknv
         ZD8GeCp6xFeRt9xk3m3Zkz5o2aSHHG7CYi+KTflw5a7XnVYQSfGP8vMV9gL5X7ggbpn6
         oTE/KNgrAKB76jbtvL8ovGbYcPQDYJh6FGlQQiGmlPVD7Hf4M3JWpZ4NC+uR9MEvmdTn
         VqnnfW8QZucqsGj1ez7thkJaTbTCwzQC3hbHuTJxb95qNDm6PwPT6cqldF8WARgvbjpV
         641A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H/fZbmoWqzYc8jvqwlQOthSJhqMeLZZmIovfXBc346E=;
        b=bqpHhCOqE4Lvesk0cjt0dVTxw1cYWERlNXY79r0eN5XjHqruY+GDKk9pNUytLVGT4I
         wLcZsST/nhAMourjK4NQ4iibYVqHUW0cwBaKcWrjl5GyqGQ7ymyVwhc896I2WPUivWxc
         8aLpxIuzUBkKd+GQ9y4BAvvYxtO21ALUDcWFOQx4q2xVUgwyjTsNdkVlUUDg7+FRh66A
         ZoYhIJ/sqVMJ7rS6+NtlRs/z0rlvSr0wPs1J+g3BKKqRTk5OsAd1CRzuK7ZNMGy741XE
         Qa272d1gFxfpPSDE5Esk14HgNb2X8ridS7Fp0A6m2b9OqPgaZ2KmPVYL9kdlHMFNe6+L
         2lEQ==
X-Gm-Message-State: AOAM533u8wMWkLn81qKhah0plL/t4veOkHdUtBH45X9cBKLZaX/aOqW/
        HMrx30pgmaBvkyyQvz1gP8E+T5QRqBlbrQ==
X-Google-Smtp-Source: ABdhPJxyK3Ngmh86N0HpsyCHlvDgpTeocfbYMkCHwJBQUJHIlMTFs90y06oa609PBCBzd0nbhtMiw5TB+2L4Fw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:ad4:43ca:: with SMTP id
 o10mr716235qvs.25.1607024509585; Thu, 03 Dec 2020 11:41:49 -0800 (PST)
Date:   Thu,  3 Dec 2020 11:41:27 -0800
In-Reply-To: <20201203194127.1813731-1-dlatypov@google.com>
Message-Id: <20201203194127.1813731-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 3/3] kunit: tool: move kunitconfig parsing into __init__
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

LinuxSourceTree will unceremoniously crash if the user doesn't call
read_kunitconfig() first in a number of functions.

Adn currently every place we create an instance, the caller also calls
create_kunitconfig() and read_kunitconfig().

Move these instead into __init__() so they can't be forgotten and to
reduce copy-paste.

The https://github.com/google/pytype type-checker complained that
_config wasn't initialized. With this, kunit_tool now type checks
under both pytype and mypy.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py        | 20 ++++----------------
 tools/testing/kunit/kunit_kernel.py | 19 +++++++------------
 2 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 08951a114654..b58fb3733cfa 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -256,10 +256,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
@@ -277,10 +274,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
@@ -292,10 +286,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
@@ -309,10 +300,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bda7c4fd4d3e..79793031d2c4 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -129,10 +129,15 @@ def get_outfile_path(build_dir) -> str:
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self) -> None:
-		self._ops = LinuxSourceTreeOperations()
+	def __init__(self, build_dir: str, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 
+		self._ops = LinuxSourceTreeOperations()
+
+		kunitconfig_path = get_kunitconfig_path(build_dir)
+		self._kconfig = kunit_config.Kconfig()
+		self._kconfig.read_from_file(kunitconfig_path)
+
 	def clean(self) -> bool:
 		try:
 			self._ops.make_mrproper()
@@ -141,16 +146,6 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
-		kunitconfig_path = get_kunitconfig_path(build_dir)
-		if not os.path.exists(kunitconfig_path):
-			shutil.copyfile(defconfig, kunitconfig_path)
-
-	def read_kunitconfig(self, build_dir) -> None:
-		kunitconfig_path = get_kunitconfig_path(build_dir)
-		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(kunitconfig_path)
-
 	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.Kconfig()
-- 
2.29.2.576.ga3fc446d84-goog

