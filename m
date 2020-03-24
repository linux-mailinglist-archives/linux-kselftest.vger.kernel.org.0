Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D591903AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 03:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCXCnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 22:43:49 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51336 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgCXCnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 22:43:49 -0400
Received: by mail-pg1-f201.google.com with SMTP id p13so12454616pgk.18
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 19:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eTp3N4nkJswEWjLmdzIEUcgYFIv4LHoTCMr5UceTnC0=;
        b=duVXYmX1NIIhw9J6zn+cg9qSXCmyMi++byRbDpCbRpCiD7ti/c9Rm5CPc2jadCXJhJ
         p7g3A2EShDMEmIpClNeZBQitbAuTGQdsOx+ksZtiWw1G/ADsMhGbAqqq545Wdv7CuJF3
         om7nCpo03Tj0o09fBw8KJiPR7y0pys2siPB9pTGq37c7LO7SI40I6OKKYJKEYFa+KyTJ
         1MlTRzQhvkOffhzNPMZOk17N/73BHNJ9iyKT0jXO5duJ12pu+buFVW4NDhWMyOnxWF5o
         8ZTY3rjyua8C/WxifHo2GWcOlHMYVAKGjnboQMEF1wRg2PbXwuaKK9D5jIES9aEUALb0
         KOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eTp3N4nkJswEWjLmdzIEUcgYFIv4LHoTCMr5UceTnC0=;
        b=jquRY2JSfCt7Yg+KOUVbIsk4cs9eeQeHyKFdoiBdGsauqR42CUs0/JBIIhvk0f0a0B
         XMIG2wWerfJoToDDWYK+zdDUoqjgtybPMkbQ6MSdqAYvvIbwLeQNiTTf5RayfV2K13PE
         uj5gI9V/TGaVnvYdcpRz8nZLIWIqbFmjUaTEhjhHrFje+FFZ0Qc/rsB43Aso0Q1A07IC
         7C4nVYnVLVgvXqieWyDRpDU8RgCZlszx6LAYBhHrvs1Hs8olhBluDPMIu8v9QEhbm6mW
         Ljol56WTrf+6i32jaekl39CmHrlullv4G3+UC0qEszZwJzHPy5qlnuALjmftO2VxIo/y
         ItDA==
X-Gm-Message-State: ANhLgQ1lpgAN/mczZZSDkqdf90Ea/r3goON50Iw2bC+gzxqg3QDAPf2c
        GtAPK8jqgV9H4jOa2cxz6HategMH22wjtg==
X-Google-Smtp-Source: ADFU+vuGHAbgKtD4x8SeIZ/cQnb7NuSwVwUtwDW7rT5zLneRNs95ax3biU44QI00wuwqkQPz4oK2sbVyP3HYXQ==
X-Received: by 2002:a17:90a:8087:: with SMTP id c7mr2633130pjn.148.1585017828493;
 Mon, 23 Mar 2020 19:43:48 -0700 (PDT)
Date:   Mon, 23 Mar 2020 19:43:33 -0700
Message-Id: <20200324024333.41663-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH kunit-next] kunit: kunit_tool: Allow .kunitconfig to disable
 config items
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rework kunit_tool in order to allow .kunitconfig files to better enforce
that disabled items in .kunitconfig are disabled in the generated
.config.

Previously, kunit_tool simply enforced that any line present in
.kunitconfig was also present in .config, but this could cause problems
if a config option was disabled in .kunitconfig, but not listed in .config
due to (for example) having disabled dependencies.

To fix this, re-work the parser to track config names and values, and
require values to match unless they are explicitly disabled with the
"CONFIG_x is not set" comment (or by setting its value to 'n'). Those
"disabled" values will pass validation if omitted from the .config, but
not if they have a different value.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_config.py    | 41 ++++++++++++++++++++------
 tools/testing/kunit/kunit_tool_test.py | 22 +++++++-------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index ebf3942b23f5..e75063d603b5 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -9,16 +9,18 @@
 import collections
 import re
 
-CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_\w+ is not set$'
-CONFIG_PATTERN = r'^CONFIG_\w+=\S+$'
-
-KconfigEntryBase = collections.namedtuple('KconfigEntry', ['raw_entry'])
+CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
+CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+)$'
 
+KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
 
 class KconfigEntry(KconfigEntryBase):
 
 	def __str__(self) -> str:
-		return self.raw_entry
+		if self.value == 'n':
+			return r'# CONFIG_%s is not set' % (self.name)
+		else:
+			return r'CONFIG_%s=%s' % (self.name, self.value)
 
 
 class KconfigParseError(Exception):
@@ -38,7 +40,17 @@ class Kconfig(object):
 		self._entries.append(entry)
 
 	def is_subset_of(self, other: 'Kconfig') -> bool:
-		return self.entries().issubset(other.entries())
+		for a in self.entries():
+			found = False
+			for b in other.entries():
+				if a.name != b.name:
+					continue
+				if a.value != b.value:
+					return False
+				found = True
+			if a.value != 'n' and found == False:
+				return False
+		return True
 
 	def write_to_file(self, path: str) -> None:
 		with open(path, 'w') as f:
@@ -54,9 +66,20 @@ class Kconfig(object):
 			line = line.strip()
 			if not line:
 				continue
-			elif config_matcher.match(line) or is_not_set_matcher.match(line):
-				self._entries.append(KconfigEntry(line))
-			elif line[0] == '#':
+
+			match = config_matcher.match(line)
+			if match:
+				entry = KconfigEntry(match.group(1), match.group(2))
+				self.add_entry(entry)
+				continue
+
+			empty_match = is_not_set_matcher.match(line)
+			if empty_match:
+				entry = KconfigEntry(empty_match.group(1), 'n')
+				self.add_entry(entry)
+				continue
+
+			if line[0] == '#':
 				continue
 			else:
 				raise KconfigParseError('Failed to parse: ' + line)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index ce47e87b633a..984588d6ba95 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -37,7 +37,7 @@ class KconfigTest(unittest.TestCase):
 		self.assertTrue(kconfig0.is_subset_of(kconfig0))
 
 		kconfig1 = kunit_config.Kconfig()
-		kconfig1.add_entry(kunit_config.KconfigEntry('CONFIG_TEST=y'))
+		kconfig1.add_entry(kunit_config.KconfigEntry('TEST', 'y'))
 		self.assertTrue(kconfig1.is_subset_of(kconfig1))
 		self.assertTrue(kconfig0.is_subset_of(kconfig1))
 		self.assertFalse(kconfig1.is_subset_of(kconfig0))
@@ -51,15 +51,15 @@ class KconfigTest(unittest.TestCase):
 
 		expected_kconfig = kunit_config.Kconfig()
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_UML=y'))
+			kunit_config.KconfigEntry('UML', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_MMU=y'))
+			kunit_config.KconfigEntry('MMU', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_TEST=y'))
+			kunit_config.KconfigEntry('TEST', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_EXAMPLE_TEST=y'))
+			kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('# CONFIG_MK8 is not set'))
+			kunit_config.KconfigEntry('MK8', 'n'))
 
 		self.assertEqual(kconfig.entries(), expected_kconfig.entries())
 
@@ -68,15 +68,15 @@ class KconfigTest(unittest.TestCase):
 
 		expected_kconfig = kunit_config.Kconfig()
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_UML=y'))
+			kunit_config.KconfigEntry('UML', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_MMU=y'))
+			kunit_config.KconfigEntry('MMU', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_TEST=y'))
+			kunit_config.KconfigEntry('TEST', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('CONFIG_EXAMPLE_TEST=y'))
+			kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
 		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('# CONFIG_MK8 is not set'))
+			kunit_config.KconfigEntry('MK8', 'n'))
 
 		expected_kconfig.write_to_file(kconfig_path)
 
-- 
2.25.1.696.g5e7596f4ac-goog

