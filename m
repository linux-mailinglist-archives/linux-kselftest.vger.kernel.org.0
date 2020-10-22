Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16B6295964
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 09:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508737AbgJVHkt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 03:40:49 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:39523 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405591AbgJVHks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 03:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603352448; x=1634888448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pe60QBoA9/7IxUUHzwkd3gPr0aS5qB0KQdtpaHuG4TQ=;
  b=djHRKz2bA/stT5mhn5zowA6MItplhQa0xJl6n/LVA6PlF4HahhuI5hHM
   i9E4UBQqK3a5Ei2IlpOBpE3v/AUfR7DAF8XyGfXHeDl4rqZ0l0ohlk8aS
   cNPOiEmKTbrCrReLyYR77uuNe7g+9kOo5ds65QHk1iBj/JiXEwmPc8RBa
   g=;
X-IronPort-AV: E=Sophos;i="5.77,404,1596499200"; 
   d="scan'208";a="86057367"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Oct 2020 07:40:41 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 3531FC0866;
        Thu, 22 Oct 2020 07:40:38 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 22 Oct 2020 07:40:34 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.de>, <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] kunit: tool: Respect '.kunitconfig' in 'build_dir'
Date:   Thu, 22 Oct 2020 09:40:10 +0200
Message-ID: <20201022074011.1990-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022074011.1990-1-sjpark@amazon.com>
References: <20201022074011.1990-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D38UWB003.ant.amazon.com (10.43.161.178) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit d43c7fb05765 ("kunit: tool: fix improper treatment of file
location") removed 'kunit_kernel.kunitconfig_path' modification for the
'--build_dir' argument.  As a result, running kunit with '--build_dir'
failed with below error message:

    Traceback (most recent call last):
      File "./tools/testing/kunit/kunit.py", line 325, in <module>
        main(sys.argv[1:])
      File "./tools/testing/kunit/kunit.py", line 245, in main
        linux = kunit_kernel.LinuxSourceTree()
      File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 109, in __init__
        self._kconfig.read_from_file(kunitconfig_path)
      File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 88, in read_from_file
        with open(path, 'r') as f:
    FileNotFoundError: [Errno 2] No such file or directory: '.kunitconfig'

The error removed after commit 82206a0c06cc ("kunit: tool: handle when
.kunit exists but .kunitconfig does not").  However, it was not the
intention of the commit.  It hides the error by ignoring the
'.kunitconfig' in the '--build_dir'.

This commit makes the tool to respect '.kunitconfig' in '--build_dir'
again, while respecting the constantness of
'kunit_kernel.kunitconfig_path', as modifying the variable makes the
'kunit_tool_test.py' fails

Fixes: d43c7fb05765 ("kunit: tool: fix improper treatment of file location")
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit.py        | 26 ++++++++++++++------------
 tools/testing/kunit/kunit_kernel.py |  4 ++--
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index ebf5f5763dee..8bee2a5fee27 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -44,10 +44,10 @@ class KunitStatus(Enum):
 	BUILD_FAILURE = auto()
 	TEST_FAILURE = auto()
 
-def create_default_kunitconfig():
-	if not os.path.exists(kunit_kernel.kunitconfig_path):
-		shutil.copyfile('arch/um/configs/kunit_defconfig',
-				kunit_kernel.kunitconfig_path)
+def create_default_kunitconfig(build_dir=''):
+	kunitconfig = os.path.join(build_dir, kunit_kernel.kunitconfig_path)
+	if not os.path.exists(kunitconfig):
+		shutil.copyfile('arch/um/configs/kunit_defconfig', kunitconfig)
 
 def get_kernel_root_path():
 	parts = sys.argv[0] if not __file__ else __file__
@@ -61,7 +61,7 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
 
 	config_start = time.time()
-	create_default_kunitconfig()
+	create_default_kunitconfig(request.build_dir)
 	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
@@ -258,15 +258,17 @@ def main(argv, linux=None):
 	if get_kernel_root_path():
 		os.chdir(get_kernel_root_path())
 
+	kunitconfig_path = os.path.join(cli_args.build_dir,
+			kunit_kernel.kunitconfig_path)
 	if cli_args.subcommand == 'run':
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
 
-		if not os.path.exists(kunit_kernel.kunitconfig_path):
-			create_default_kunitconfig()
+		if not os.path.exists(kunitconfig_path):
+			create_default_kunitconfig(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
@@ -284,10 +286,10 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not os.path.exists(kunit_kernel.kunitconfig_path):
-			create_default_kunitconfig()
+			create_default_kunitconfig(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
@@ -299,7 +301,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
@@ -313,7 +315,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index b557b1e93f98..7dd4268665a8 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -109,9 +109,9 @@ def get_kconfig_path(build_dir):
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self):
+	def __init__(self, build_dir):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(kunitconfig_path)
+		self._kconfig.read_from_file(os.path.join(build_dir, kunitconfig_path))
 		self._ops = LinuxSourceTreeOperations()
 		signal.signal(signal.SIGINT, self.signal_handler)
 
-- 
2.17.1

