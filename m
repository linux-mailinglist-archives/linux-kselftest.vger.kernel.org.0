Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CADA2EE9F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jan 2021 00:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbhAGXtk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Jan 2021 18:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbhAGXtk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Jan 2021 18:49:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025B3C0612FA
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Jan 2021 15:48:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g67so13250432ybb.9
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Jan 2021 15:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C2n9JJbC3ufm/Maczydpg97ffZDIcqZmHWyAwbR/1R0=;
        b=RZeR3IfgJjKaONVYgI0IjUEmCZBHCDg3yn2grnOvoSINeJwCSZ1V4YI086yiuhVCwm
         cEE3eeXyVDvy+ndldMdYRlnyeg9QrRLI0YEXpDHBC4Pik0hE62Z8tPVB7VPrz0AQjzQh
         sLc1zfW4oetGssNI2PloZytlnTh7q9JFBcg2BCAjh5c8NxlJq7M4pJm/z8rzYK5JXP4L
         h0GUUJ1VSSfSR/iiaDUsTsPa8u4K9dl5coHavWvUlBjyEV4TqVGGx8w2hG8Sy1Z3BPcM
         U9V1oQ3VP3vADaPrjEgX1YzUCe6K+VyrwPrY/bCXQsrIUYe1wNqnFg7O+VS3kmYg94OI
         ii7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C2n9JJbC3ufm/Maczydpg97ffZDIcqZmHWyAwbR/1R0=;
        b=uiWpGM6mOy6qBhuvCRwLqHfhP85QHVeOAO9KOuzK5HmeaAEqK3wyyIU7jJqXDwfX3t
         4mVnLJgc6/kY0s3Ik3P4W7zW+MaFxCWyKu8BNwhbhn1uHfvQR4KSQARY8YXT0YoP5/Rs
         lHCfhIZxg1kdx3jIn4nJ3+CNxW9BsU3oKm/+Hbm5ZpTSq1CghzW0dhbkRmSKxhGJNKe0
         n76he3Vd0vnbyya14Afj2ppeiZOGuF73kZ3BNzm3soGlUYqmgf0ojSairH1lc+DLs4+x
         mPHAorxoOfkgDKewZQK4JHjVjohSKBwmJ9YViT2lLCtGo0AFyWb4cqgiWFVMd1jp595v
         +E+w==
X-Gm-Message-State: AOAM532Vq/JYQQLO5KEmcjRiCaDMMYnJD4LQhNxFRHi/879LFe7CR9PN
        1TZLP8GUEqFL+f3wE2t9tW7U5uPxDHlmnQ==
X-Google-Smtp-Source: ABdhPJxAe06FdGKBQJYCE0aATr6itl5DGHJVjYzxHWKk4vt6l4bhR2DvTfw9qFdIEu49BlNy40Hcrljv/mgBNQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a5b:990:: with SMTP id
 c16mr1756491ybq.381.1610063311223; Thu, 07 Jan 2021 15:48:31 -0800 (PST)
Date:   Thu,  7 Jan 2021 15:48:03 -0800
In-Reply-To: <20210107234803.1096592-1-dlatypov@google.com>
Message-Id: <20210107234803.1096592-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210107234803.1096592-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 3/3] kunit: tool: move kunitconfig parsing into __init__,
 make it optional
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com, brendanhiggins@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

LinuxSourceTree will unceremoniously crash if the user doesn't call
read_kunitconfig() first in a number of functions.

And currently every place we create an instance, the caller also calls
create_kunitconfig() and read_kunitconfig().
Move these instead into __init__() so they can't be forgotten and to
reduce copy-paste.

The https://github.com/google/pytype type-checker complained that
_config wasn't initialized. With this, kunit_tool now type checks
under both pytype and mypy.

Add an optional boolean that can be used to disable this for use cases
in the future where we might not need/want to load the config.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py        | 20 ++++----------------
 tools/testing/kunit/kunit_kernel.py | 25 +++++++++++++------------
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5521e0a8201e..e808a47c839b 100755
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
index db7ed84ea410..bf7a784ac6eb 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -123,28 +123,29 @@ def get_outfile_path(build_dir) -> str:
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self) -> None:
-		self._ops = LinuxSourceTreeOperations()
+	def __init__(self, build_dir: str, load_config=True, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 
-	def clean(self) -> bool:
-		try:
-			self._ops.make_mrproper()
-		except ConfigError as e:
-			logging.error(e)
-			return False
-		return True
+		self._ops = LinuxSourceTreeOperations()
+
+		if not load_config:
+			return
 
-	def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
 		kunitconfig_path = get_kunitconfig_path(build_dir)
 		if not os.path.exists(kunitconfig_path):
 			shutil.copyfile(defconfig, kunitconfig_path)
 
-	def read_kunitconfig(self, build_dir) -> None:
-		kunitconfig_path = get_kunitconfig_path(build_dir)
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
 
+	def clean(self) -> bool:
+		try:
+			self._ops.make_mrproper()
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		return True
+
 	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.Kconfig()
-- 
2.29.2.729.g45daf8777d-goog

