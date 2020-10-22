Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE380295966
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506839AbgJVHky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 03:40:54 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:51047 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506829AbgJVHkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 03:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603352454; x=1634888454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jdm1g2KQwup+Vn0X8CptXTW5WmBvujuwa0Pm6SY2KNg=;
  b=CsdXlhlvZp+H1e57XZWVK06wk4XonwUbmhJ64GYnsj1WEPU/0oxekdj2
   zneGj7FW5EUIZF1I73K0S2dOIw+uBX8XmRcMj0j3foIAaKv/Y1lRsPF7B
   tnBgvwBNSbZIMK86C8kgzXE3OJSvCCBZ9Et13Yxl+XlWcy90CHTEIYL8p
   w=;
X-IronPort-AV: E=Sophos;i="5.77,404,1596499200"; 
   d="scan'208";a="87309345"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Oct 2020 07:40:46 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id B4282C07B0;
        Thu, 22 Oct 2020 07:40:42 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 22 Oct 2020 07:40:39 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.de>, <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] kunit: tool: Mark 'kunittest_config' as constant again
Date:   Thu, 22 Oct 2020 09:40:11 +0200
Message-ID: <20201022074011.1990-3-sjpark@amazon.com>
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

'kunit_kernel.kunittest_config' was constant at first, and therefore it
used UPPER_SNAKE_CASE naming convention that usually means it is
constant in Python world.  But, commit e3212513a8f0 ("kunit: Create
default config in '--build_dir'") made it modifiable to fix a use case
of the tool and thus the naming also changed to lower_snake_case.
However, this resulted in a confusion.  As a result, some successing
changes made the tool unittest fail, and a fix[1] of it again incurred
the '--build_dir' use case failure.

As the previous commit fixed the '--build_dir' use case without
modifying the variable again, this commit marks the variable as constant
again with UPPER_SNAKE_CASE, to reduce future confusions.

[1] Commit d43c7fb05765 ("kunit: tool: fix improper treatment of file location")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 6 +++---
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 8bee2a5fee27..26046875adb2 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -45,7 +45,7 @@ class KunitStatus(Enum):
 	TEST_FAILURE = auto()
 
 def create_default_kunitconfig(build_dir=''):
-	kunitconfig = os.path.join(build_dir, kunit_kernel.kunitconfig_path)
+	kunitconfig = os.path.join(build_dir, kunit_kernel.KUNITCONFIG_PATH)
 	if not os.path.exists(kunitconfig):
 		shutil.copyfile('arch/um/configs/kunit_defconfig', kunitconfig)
 
@@ -259,7 +259,7 @@ def main(argv, linux=None):
 		os.chdir(get_kernel_root_path())
 
 	kunitconfig_path = os.path.join(cli_args.build_dir,
-			kunit_kernel.kunitconfig_path)
+			kunit_kernel.KUNITCONFIG_PATH)
 	if cli_args.subcommand == 'run':
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
@@ -285,7 +285,7 @@ def main(argv, linux=None):
 				not os.path.exists(cli_args.build_dir)):
 			os.mkdir(cli_args.build_dir)
 
-		if not os.path.exists(kunit_kernel.kunitconfig_path):
+		if not os.path.exists(kunitconfig_path):
 			create_default_kunitconfig(cli_args.build_dir)
 
 		if not linux:
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 7dd4268665a8..f4bc9568bbce 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -18,7 +18,7 @@ import kunit_config
 import kunit_parser
 
 KCONFIG_PATH = '.config'
-kunitconfig_path = '.kunitconfig'
+KUNITCONFIG_PATH = '.kunitconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 
 class ConfigError(Exception):
@@ -111,7 +111,7 @@ class LinuxSourceTree(object):
 
 	def __init__(self, build_dir):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(os.path.join(build_dir, kunitconfig_path))
+		self._kconfig.read_from_file(os.path.join(build_dir, KUNITCONFIG_PATH))
 		self._ops = LinuxSourceTreeOperations()
 		signal.signal(signal.SIGINT, self.signal_handler)
 
-- 
2.17.1

