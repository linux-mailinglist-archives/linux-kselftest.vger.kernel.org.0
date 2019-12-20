Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22566127508
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 06:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLTFOl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 00:14:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36936 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTFOW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 00:14:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so7877238wmf.2;
        Thu, 19 Dec 2019 21:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yEihcqRjJqHrf9Dkz24+7uPB1xqJDuWaD0UNYMAzXH4=;
        b=Oey+1Lh1vua7bwuLqvnioSrUimFGSdjDvUm++wJZMdPMXLEFIb0HagR7AZ3NA7fmPV
         xA1hQH2L45QcmZOWSYJTcObaT4lLyLyqKN7YGRDluiqgm/ctu+5nZfD59tdB0SH/GZuZ
         m1iYChIarzCu99KU3wmasSMH4Q+AYmDYPZXK3EAiBd6KClkzu9Dy3LGlSOsAwlI6IVO5
         0hAQx4On0+YPHrlOyaz3IoH1wTgMhzyNoHYsrTxkgfv2PsOeMh9+Oypwk/KSMwFzAjwz
         OIVtC+KRIKkDJnXweOZ0AaCsuf9/PtyLXlqsxC6crx8fODrTCR43uNt2b07nsmSgEF2F
         4Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yEihcqRjJqHrf9Dkz24+7uPB1xqJDuWaD0UNYMAzXH4=;
        b=YjJ5+22AWCNBpa9BmClDHdbCEOd5rvSE2AhfaZsvIeuv2O2+rivUetTcC975ITS4Vm
         UzuO+w+l/C5hnEVGlC5RVkxX13uDrrPxMeWUsKeLA+eUttDiaBBRJ8nqDsJbCKCsv/Fz
         Rcg9G2Ng2FbfX4MiX2HYh8WEh6r5sCHHGnWnx1/zBwu2vkZigYxBXhJAiIo5VRdnL6OK
         /D5or8ueM2zOXY2WpKo8C35XrXFk9FXHaofJHT2+S8J4OOgt8zVTx3CtSnYcot8x91Pg
         VLFqCsg4OHm4Ae4Q0HslennsEwohpoU5zW/z08EC3pUTLgJoeBNdBhyIQq0LAqAeKz9a
         Gt8w==
X-Gm-Message-State: APjAAAVluo1UcMUlb8sNSef3nDqHKaonYlIblE2rZwPfuoHY8oYStadV
        x2xVUzXMoziOlt/wkXdn4vM=
X-Google-Smtp-Source: APXvYqygnBhWMk6eRkP7fEJeqrMQVSoKmmWXhGHJpnJdKEGFIcuWLPUEVGU0DCoNEjmFkykgGkUSFQ==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr14256880wmi.107.1576818861122;
        Thu, 19 Dec 2019 21:14:21 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id j12sm8703863wrt.55.2019.12.19.21.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:14:20 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     shuah@kernel.org
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sj38.park@gmail.com, sjpark@amazon.com, sjpark@amazon.de
Subject: [PATCH v7 3/6] kunit: Create default config in '--build_dir'
Date:   Fri, 20 Dec 2019 05:14:05 +0000
Message-Id: <20191220051408.3591-4-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220051408.3591-1-sjpark@amazon.de>
References: <20191220051408.3591-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

If both '--build_dir' and '--defconfig' are given, the handling of
'--defconfig' ignores '--build_dir' option.  This commit modifies the
behavior to respect '--build_dir' option.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Suggested-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 11 +++++++++--
 tools/testing/kunit/kunit_kernel.py |  4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f8f26951cd1b..5b222418eacd 100755
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
index bf3876835331..c04a12e2f711 100644
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
2.17.1

