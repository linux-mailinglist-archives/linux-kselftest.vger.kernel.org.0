Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFABF11364F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 21:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfLDUSl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 15:18:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36968 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfLDUS3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 15:18:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so1183195wmf.2;
        Wed, 04 Dec 2019 12:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utI8T3ub3njoo3SG3qDSzeTSz7Igjg4spb9ZghayKKs=;
        b=Gda1EXMI623emlm6+fK5zgPSd31v9U7EssM926uXVQx+hwosvwmGnLx3hgeBOudkzT
         IAhIP1//jwbUBKKBVqQwqgwSMvx2Yqj1JpscetLUBIE0ac21M3eQP5ouGMZvEvdLepKn
         13kWfDPvfy3ZXNshH/p18k5vySt9LW4p7j7TK1qyasVJHs1/8ub4tKBP7MJ3pYs3j63b
         17X+gcJScIftOQtkIpBrLq+o3p90XYC/6CzLjkHH48hPo2YAHWtW/MeITP2f2+Gt3AU/
         ecDrP1U9P3YfqH1Yk4kz8H89eQ+UINRTtSkkGN1zeduxOLgLrjqDn3d3Hq/Bl1Pm7dE5
         bjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utI8T3ub3njoo3SG3qDSzeTSz7Igjg4spb9ZghayKKs=;
        b=r/bR2HKrk5DFUZOWrHI/zrjoLY2qncC+vZuPF6rITvMFFu9hLjuSPpXzbCrfaGlUyW
         kox6i8Y4Mq9n5dSGPCLnBe7POPhBWB6JluhU3DSnDw0u2f7cHBjDSDr4RdRLW7VPftGH
         qwcopyYyZPf0jtNMQcvy8vviYqCi/6vp6Wmh0+RaRytwgWMzrx463p+Ghirz+zBCrhLn
         yFPUk/qfdQsHxGP/6+884f/QIayxv5dr/CNNJqPMa0t3h1L09FYT6cyRbr5sTY0iNrDo
         Wm5E37sQ57hZrPQGqvsT1qUTcHNdgizKXIcY+cQepSC3YC3Mo0wM/xPZUEwLk1FloxE+
         KBVQ==
X-Gm-Message-State: APjAAAXXUfgq7n9vxt4SajwRXhqayWsig/XiDebka4U6R3Gy1+p4nBn2
        jVbwW6qyeBLlfYlGdt1318Y=
X-Google-Smtp-Source: APXvYqxXPZre4z2bywzFVr6zdgbmpu8XL1cgTlsJhkpoWd2uLbZ6NhNzJzyrABqEaK5M8U+F0YyUuw==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr1380257wmc.81.1575490706500;
        Wed, 04 Dec 2019 12:18:26 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f2sm7329254wmh.46.2019.12.04.12.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:18:25 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v4 3/5] kunit: Create default config in '--build_dir'
Date:   Thu,  5 Dec 2019 05:18:01 +0900
Message-Id: <1575490683-13015-4-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
References: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
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

