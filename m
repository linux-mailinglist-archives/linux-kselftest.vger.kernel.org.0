Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914E1113E14
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 10:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfLEJfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 04:35:25 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:58899 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfLEJfY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 04:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575538524; x=1607074524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=izpxlTvHNZyly8edWZMrhdJhAamFfzshXPvgfM3Kj4U=;
  b=TkpWvto5hXIllKVe1lT6m2ZdvIaH4W0DxLvWHZscB+0ixMhOg1PZPC+1
   dqcRbe3qGcbnpBi2PH3nkClwissPIqcZBRWlU+WETGcLGMbjvTBqsGs6m
   +jpdaAQ4EudJTEDucOYHWSnJopHcpQU5FjNGrjbpw6tA44W61jmdzSoQN
   o=;
IronPort-SDR: v85zXu7SLzuj5MP+YdOZ2wfxFbQJ83KysH1M59YDzp63PhEEj3RSG2TjYbwoZYMlruGPmJovGR
 PEOoxtGjd4bw==
X-IronPort-AV: E=Sophos;i="5.69,280,1571702400"; 
   d="scan'208";a="13144399"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Dec 2019 09:35:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 5F253A21C5;
        Thu,  5 Dec 2019 09:35:11 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:35:10 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.180) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:35:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <sj38.park@gmail.com>, <corbet@lwn.net>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <sjpark@amazon.de>
Subject: [PATCH v5 3/6] kunit: Create default config in '--build_dir'
Date:   Thu, 5 Dec 2019 10:34:37 +0100
Message-ID: <20191205093440.21824-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205093440.21824-1-sjpark@amazon.com>
References: <20191205093440.21824-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
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

