Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874D128B232
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgJLK1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 06:27:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:33902 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387463AbgJLK1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 06:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602498420; x=1634034420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Vis5a8KRuMJ/9yIC3aGTX8Ith/0AYp1GJQc5VjFEZAY=;
  b=QuARfvkv5tSy6Gm1LPjCm/NPgBkdHVcrfVCfY/LPJ0T5pFMjVx5fI3US
   /yvwcO7znK3KVKBc2APG/JC/QtuZpzxRP3m7FrXkISUF7JjnYZ6QT3A9a
   PfQe5YkOtRmdcmuZg85PzIMGTFnCGrL9bii4lef316UUo9ddxgY3bMtTL
   Q=;
X-IronPort-AV: E=Sophos;i="5.77,366,1596499200"; 
   d="scan'208";a="82427578"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Oct 2020 10:26:53 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com (Postfix) with ESMTPS id C30C5A8440;
        Mon, 12 Oct 2020 10:26:52 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.185) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 12 Oct 2020 10:26:47 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.de>, <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] kunit: tool: Mark 'kunittest_config' as constant again
Date:   Mon, 12 Oct 2020 12:26:21 +0200
Message-ID: <20201012102621.32226-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201012102621.32226-1-sjpark@amazon.com>
References: <20201012102621.32226-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.185]
X-ClientProxiedBy: EX13D17UWC004.ant.amazon.com (10.43.162.195) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
---
 tools/testing/kunit/kunit.py        | 4 ++--
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 611c23e178f8..0a58c1fb87d9 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -44,9 +44,9 @@ class KunitStatus(Enum):
 	TEST_FAILURE = auto()
 
 def create_default_kunitconfig():
-	if not os.path.exists(kunit_kernel.kunitconfig_path):
+	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
-				kunit_kernel.kunitconfig_path)
+				kunit_kernel.KUNITCONFIG_PATH)
 
 def get_kernel_root_path():
 	parts = sys.argv[0] if not __file__ else __file__
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 16a997504317..42dca0163479 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -18,7 +18,7 @@ import kunit_config
 import kunit_parser
 
 KCONFIG_PATH = '.config'
-kunitconfig_path = '.kunitconfig'
+KUNITCONFIG_PATH = '.kunitconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 
 class ConfigError(Exception):
@@ -106,7 +106,7 @@ class LinuxSourceTree(object):
 
 	def __init__(self, build_dir):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(os.path.join(build_dir, kunitconfig_path))
+		self._kconfig.read_from_file(os.path.join(build_dir, KUNITCONFIG_PATH))
 		self._ops = LinuxSourceTreeOperations()
 		signal.signal(signal.SIGINT, self.signal_handler)
 
-- 
2.17.1

