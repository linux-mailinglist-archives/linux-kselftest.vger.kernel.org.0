Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2517928B23D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 12:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbgJLKaD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 06:30:03 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:37041 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbgJLKaD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 06:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602498602; x=1634034602;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=kFB+hAuY3HYTUl9UemGcD/WxoJMOPU0+vmjpowmsqcc=;
  b=DCDeCColJJMzEnmc2sOU/Uy9qTZhaUGRhh/UMNaR3kwOF5tyHTa+rHR6
   yF7V6aukwkaQzo8f6m+slLIWIlbnpEYKxCeuoIuhDUrMUkyZeUfy2tlIv
   iKxpB5tg2TELEia4V4pomxajPxPExUxZEj6x7s8ZSpk7NrEMOITHBn1HH
   4=;
X-IronPort-AV: E=Sophos;i="5.77,366,1596499200"; 
   d="scan'208";a="60718120"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Oct 2020 10:29:55 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 7F357A0298;
        Mon, 12 Oct 2020 10:26:46 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.185) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 12 Oct 2020 10:26:42 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.de>, <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] kunit: tool: Fix LinuxSourceTree's missed handling of 'build_dir'
Date:   Mon, 12 Oct 2020 12:26:20 +0200
Message-ID: <20201012102621.32226-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.185]
X-ClientProxiedBy: EX13D17UWC004.ant.amazon.com (10.43.162.195) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Because commit d43c7fb05765 ("kunit: tool: fix improper treatment of
file location") removed 'kunit_kernel.kunitconfig_path' modification for
the '--builddir' argument, running kunit with '--build_dir' now fails
with below error message:

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

As simply reverting the change now make the 'kunit_tool_test' fails
again, this commit fixes the problem by passing the 'build_dir' argument
to 'LinuxSourceTree' constructor.

Fixes: d43c7fb05765 ("kunit: tool: fix improper treatment of file location")
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit.py        | 8 ++++----
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 425ef40067e7..611c23e178f8 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -242,7 +242,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
@@ -259,7 +259,7 @@ def main(argv, linux=None):
 				os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
@@ -275,7 +275,7 @@ def main(argv, linux=None):
 				os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
@@ -293,7 +293,7 @@ def main(argv, linux=None):
 				os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index e20e2056cb38..16a997504317 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -104,9 +104,9 @@ def get_kconfig_path(build_dir):
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

