Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB810F9B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLCITb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:19:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfLCITU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:19:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so2445325wrf.9;
        Tue, 03 Dec 2019 00:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sxVxvQmhg7LzrPKzHlacPLZnPKCitY+jA/j0y588woI=;
        b=iZdF/isVr0+lhgJgHIclUn/T/ujKA4Ofwgus5QlQk3IvcTdRfl3bCp1ulO0smK0p7O
         MCRzRo2HjT3ERIOlrUUhHZU8R4OTtA9ZVAKQXxwWOzUt0kQx+tjL6InrWBM6VvL3xXYW
         R8EqrWfveut5XteLUdD5i8yPABV7Ich0HlZIzDQu19im2jejkl1rParrYMBj97UTqwSE
         KP/NyGYLul6bUsXv/q+QTnEEXWZw/3ZqanVBvmeOdZUVdiPLI/zh22d5BjPtt4mLdPdt
         pqFuNvR6hXD8YEBChrh9D/JWhjgzUMpPkbKQrnmZd+MnoV94KDVw5lDSWYhBLy6B63Kj
         khEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sxVxvQmhg7LzrPKzHlacPLZnPKCitY+jA/j0y588woI=;
        b=G/JJ9xtxqNTvTTJsiDDsmunDkpdnhSUsgzeA/TgGoOKMG4HUNbw0KAyQBjHQeCBviy
         YfdPaur3TPh07Ddupe4TKltUxZtqOw7fA0XAXZoOZ7BtDiCy9zCZ5/IaQbZdC8OS9dZJ
         7yGrTMg1tk/HXf0efwV0adpDXd50E0ayD/2xgyu5UmVQLb9eEHdLVQ/mRpxCRlBW+2eH
         JNjByofMxN9NsjL+ssoCtujwy2w4g/xpMfIOTG9GW0IpCs74NbAUhI0uYflaV2MuTD41
         n3UBrE97AdBBdr9OfUeKCwL/rdYxYDTcxqOtq59jYvUdske/oc0MqYDiEYIdnlyA/J+/
         WtWQ==
X-Gm-Message-State: APjAAAVTr5ojumtV2c6pjYTewKYkxnKxgtBXiSSH8DNSEV37fNs5/Ima
        ifNaVY3eQOO3h1OCcNJA8W8=
X-Google-Smtp-Source: APXvYqzPduh/ecAUf0bT8pY0t3aKgtKtdT/tClgE3f3TBy8UaMBUnUBYheqOUSJSVq7uBOZMuXrIfQ==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr3608473wrf.174.1575361157508;
        Tue, 03 Dec 2019 00:19:17 -0800 (PST)
Received: from localhost.localdomain (p50991abe.dip0.t-ipconnect.de. [80.153.26.190])
        by smtp.gmail.com with ESMTPSA id 188sm2048197wmz.13.2019.12.03.00.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 00:19:17 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjpark@amazon.de
Subject: [PATCH v2 3/5] kunit: Create default config in '--build_dir'
Date:   Tue,  3 Dec 2019 17:18:59 +0900
Message-Id: <1575361141-6806-4-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
References: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
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
 tools/testing/kunit/kunit.py        | 9 +++++++--
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f8f2695..02a54d8 100755
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
@@ -114,6 +114,11 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if cli_args.build_dir:
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

