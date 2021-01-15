Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC342F6F9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbhAOAkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731393AbhAOAkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:40:08 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F449C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:39:28 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s17so4845234pgv.14
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ei/JpQ2zh7azRbnOU06fASsUDF2UTmFQdjcoGaU2sMU=;
        b=eVJcbOigJD+rGFjpOYc53RnYI+X0F7Sn49pZkSmU+vhDXgcXc1Lc4Wt0HEvS1IHkim
         VZAB1nQQnLfxcPW+vjvSfRw5QPvPJQ0gHD03KD7uGtuE+mbtKXw/BAxhgFT5ftcMTlSH
         4jxmhVUYzEO5B3KrxIy+zuW3XCtoSfJsstukj0+w8CkAR4HUuGAIhiQAXON8PCd6gjio
         LM+HUm4qAyiIbHZ9bAjVrezaRWBf/YUzX38Tfj5C8LCz06/Sl/ynCbd1RpCVgGBQ1pQz
         0Fenp07OHLQ7MbziJ4At4CZCMMpLi3JNAheosQkIOFXDmC564ZNCho8/71yHm4+pBZT6
         /83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ei/JpQ2zh7azRbnOU06fASsUDF2UTmFQdjcoGaU2sMU=;
        b=RzpfV1eu5Cp/99JUQ/SUma+GqmsPjPhdH6pqL0XTL44XO0gXQiXgvup1Fyf1mEGnXf
         9hvGgdREboy1t8mqKFah4hk/RpjiKImPuWKkdmdxhqpXfGBdfBqq5e/QrlscdFRoKS3f
         N7TrKwW6fv0zxMH1yMRkZk41Hnl+swULtHec5QR8SHvF0rN1uf4LO3FSF9HKwhcyQaTk
         MZ6tcCV8HAi1XrxaiYQ3WSCoLxulvRmcAtIm5tYPfCuhZxFINpD0BBPExfw015IMGZv+
         sVFZ2H5lSrChL8he8Kw51YEl0kRWJRqguF6kJY3WjMGPdeOTBU2p51/YZCGaVEUlK01W
         g+ZA==
X-Gm-Message-State: AOAM532AOP4jYz0Wx1ofVgnKavxc/sUwHCFFRb+yvBXv4pSscMM+4R82
        Zd+NVaE3GP3tGMSAPaujF0tCYnWUE40+3Q==
X-Google-Smtp-Source: ABdhPJyKAPeJNwHwCIaZjEX01z06pnDoIG5NqptvlHtSzZdmEi395hDFVQpBZEL98PCLjKzqhCCVKcgmOJq0sA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:902:242:b029:dc:3baf:2033 with SMTP
 id 60-20020a1709020242b02900dc3baf2033mr10009811plc.36.1610671167710; Thu, 14
 Jan 2021 16:39:27 -0800 (PST)
Date:   Thu, 14 Jan 2021 16:39:13 -0800
In-Reply-To: <20210115003913.1406896-1-dlatypov@google.com>
Message-Id: <20210115003913.1406896-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20210115003913.1406896-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v4 3/3] kunit: tool: move kunitconfig parsing into __init__,
 make it optional
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
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
index e77ee06aa407..2076a5a2d060 100644
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
2.30.0.296.g2bfb1c46d8-goog

