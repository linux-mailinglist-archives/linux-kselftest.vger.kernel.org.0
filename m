Return-Path: <linux-kselftest+bounces-47980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EBBCE4A13
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 08:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84BA03004F6F
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F228CF77;
	Sun, 28 Dec 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csITLKjq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547927A91D
	for <linux-kselftest@vger.kernel.org>; Sun, 28 Dec 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766908645; cv=none; b=ZLNPYYkvffvEsF/Dt+xw1MeIld4yJ377jylq9cHmXB6lVgFeblyNL3hsVlc/T4JHz7VE1eNVENP/5AlANZ+0/FXl5s4vVhvx2q7m52qRu6cWqusiy5PAnCqEMZhuD54O6YNhuf5Wpej0t8gLYOPzWz6IqkwHRNtzIAUKP7wpaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766908645; c=relaxed/simple;
	bh=29CsS8jUPXfxnqDG52zqX8oAaxTCHMIVUG84xalQVuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YT2cBDexRyCK0aLCggeiP8VhOlfagdi8fjnF9/26YvfLJnEc00d1iVvqi/NSjhw67QFAwhSySyOdcwSivkpmx7LfEP8d6RAeoicjuoo8iFvrfWqGDHqVxDQERpDLGyejOg0SH93PaQVp0nDqykba3y8BPu86BBjKRl3E57UBkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csITLKjq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so9251787b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Dec 2025 23:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766908643; x=1767513443; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sH/mQxpGQvHgNSDd7bXpPUMJDojJ2SOxK5UAXsSsuAA=;
        b=csITLKjqEMk5tPgwRoOIgzRywYFe3xEKpLvnza+NXjd+7bwMkeFTGM9lu5BbRv3gD6
         ZShv3VsbFYWwrRYScvvvgvNSRae4C7p1NoByBld/sgPTYaaDDInoh+CY19GZ3rAZfSyd
         fDlJTVehQfqcW5doCAA8uk26NChAHeoTlhLAcbkOjSq9NoIYryy9sRXOy2ULeNtJmP7k
         A+x/DIPjdvbQNC8v7W5YyF9iT1HSQ9kfaGXZatt96YuTx7AiIURu7xMWjj2/atB1+qb1
         pcsxf3wonjrxwLTkt4XmeQIPbxEcjw7pjoUZs5k7+9rs1StGEm9iU5Dcns6D8INg7iiX
         7huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766908643; x=1767513443;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH/mQxpGQvHgNSDd7bXpPUMJDojJ2SOxK5UAXsSsuAA=;
        b=oVpHBL1Rc8ZX7El5JO9QJzkzzUrLM+ool9X1t4puD0n9sEmW0oamrGFrz1HFJibIYb
         C5tnnzznYsIZcz7ezaSbTGWkaW0i0j8iTvwabeRZw57n+YU0QXMWErqOaT3bnJjfU5Ce
         1+zpVzTtmwpprXDVzkET18szO/muSDXf/k2DteUEw9Po0HYgEm/95q+/D3CYoB+r+K/m
         q8Q5n4zkm6m8jI0ki+stnFCtAaySJT7uwm80xF7Dx+H2lFlL9pO3yAT2U5HT98X5OmTA
         aFWItNOpng5Xm8ANqnVw/5O0AvafEguHA7WOkKg92LSJkIZ4ZptBe7ZZqM7UShQwdxj4
         9F/w==
X-Gm-Message-State: AOJu0Yx7+eDHaZy7oTgPQuoErZpAqsPZPiJjpl5+HV7m66fFaWllbF64
	g+A4unhmyYm96wjKbqKtnvknHRs4f7uuRJcljylJEHwsxc0Tj/AVEeiJxJJ4urca
X-Gm-Gg: AY/fxX6Y0fsRPBJrDbf5jJSe/fzx0vTwLRRRlLBxTs0AtODbu+a91Fee7b7tdhcPZtq
	ymoswo/c1s+WSasshoJMaxabCd9SYjBZJJQgUvY3GWtumXlTenhaX7cyFoNyftLpd8e/tShKztV
	Ch19usOlUCHmkezG/tvf1NtSPVkEwatTza4qCM2g7lLkZWL4cF0OpLfwYn5H6lTuiAAeKWwEDcs
	AI2Yte1YMesE3FHWiwulEEBjN42CxDDsWtQgsHwJVG66KhZwgfhp1+Q340leNP5horwsqCGg33L
	av7h0t/F8jDqKTdufgxiYRkkWeyo6Ii1BWvX8GaUT24JbQMQqQsx9v2kAYYagBFZiemdC5VI8aI
	MlAFtHEkGE2COQTCJFj44DaId3SIIaQlpy79MPCB2tzWgE7lZOHjb2SDvkSfs0eEqEWTf1MSoK8
	ItYPOY8rFGVH7qh8qHEpc=
X-Google-Smtp-Source: AGHT+IEG1fi8JdvUOklOm4ZBYm40p24T/KBfn4xEROwDBzEt48vaxSZxhJoFgs/MPre7m5jHI6WlxA==
X-Received: by 2002:a05:6a00:4c0e:b0:7e8:450c:61bb with SMTP id d2e1a72fcca58-7ff6607e24amr22824991b3a.43.1766908643406;
        Sat, 27 Dec 2025 23:57:23 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-80d8d93f7f0sm140936b3a.22.2025.12.27.23.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 23:57:22 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Sun, 28 Dec 2025 16:55:19 +0900
Subject: [PATCH RFC] kunit: respect KBUILD_OUTPUT env variable by default
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-kunit-kbuild_output-v1-1-f1fb30fe060f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyML3ezSvMwS3eyk0syclPj80pKC0hJd0xQjw0QLy7REMwNjJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAa9bXlmoAAAA=
X-Change-ID: 20251228-kunit-kbuild_output-5d21a89fa603
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2

Currently, kunit.py ignores the KBUILD_OUTPUT env variable and always
defaults to .kunit in the working directory. This behavior is inconsistent
with standard Kbuild behavior, where KBUILD_OUTPUT defines the build
artifact location.

This patch modifies kunit.py to respect KBUILD_OUTPUT if set.  A .kunit
subdirectory is created inside KBUILD_OUTPUT to avoid polluting the build
directory.

Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 tools/testing/kunit/kunit.py           |  7 ++++++-
 tools/testing/kunit/kunit_tool_test.py | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index cd99c1956331dbbfb06cf4ddf130db3dcf2a7c31..e3d82a038f93df0e86952da92461bc2e02f69ed1 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -323,11 +323,16 @@ def get_default_jobs() -> int:
 		return ncpu
 	raise RuntimeError("os.cpu_count() returned None")
 
+def get_default_build_dir() -> str:
+	if 'KBUILD_OUTPUT' in os.environ:
+		return os.path.join(os.environ['KBUILD_OUTPUT'], '.kunit')
+	return '.kunit'
+
 def add_common_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
-			    type=str, default='.kunit', metavar='DIR')
+			    type=str, default=get_default_build_dir(), metavar='DIR')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
 			    action='append', metavar='X=Y')
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bbba921e0eacb18663abfcabb2bccf330d8666f5..a55b5085310d1bc54a549d3f36a83f7697fb8881 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -601,6 +601,7 @@ class KUnitMainTest(unittest.TestCase):
 			all_passed_log = file.readlines()
 
 		self.print_mock = mock.patch('kunit_printer.Printer.print').start()
+		mock.patch.dict(os.environ, clear=True).start()
 		self.addCleanup(mock.patch.stopall)
 
 		self.mock_linux_init = mock.patch.object(kunit_kernel, 'LinuxSourceTree').start()
@@ -723,6 +724,24 @@ class KUnitMainTest(unittest.TestCase):
 			args=None, build_dir=build_dir, filter_glob='', filter='', filter_action=None, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	@mock.patch.dict(os.environ, {'KBUILD_OUTPUT': '/tmp'})
+	def test_run_builddir_from_env(self):
+		build_dir = '/tmp/.kunit'
+		kunit.main(['run'])
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=None, build_dir=build_dir, filter_glob='', filter='', filter_action=None, timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
+	@mock.patch.dict(os.environ, {'KBUILD_OUTPUT': '/tmp'})
+	def test_run_builddir_override(self):
+		build_dir = '.kunit'
+		kunit.main(['run', '--build_dir=.kunit'])
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=None, build_dir=build_dir, filter_glob='', filter='', filter_action=None, timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
 	def test_config_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['config', '--build_dir', build_dir])

---
base-commit: ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1
change-id: 20251228-kunit-kbuild_output-5d21a89fa603

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


