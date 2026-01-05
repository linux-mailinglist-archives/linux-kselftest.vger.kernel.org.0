Return-Path: <linux-kselftest+bounces-48217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B892CF4C5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 17:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 994063009D6E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFDF303A1A;
	Mon,  5 Jan 2026 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHaaXl8F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00B28CF42
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631304; cv=none; b=Qne6GfaQnFzEj0wQ5d1MY6+AIPFtd5zE8buMBGGgZGhncELx1HRHH9rbHlcIfvH5/FysitorODqnCVnv5Pgh5eK6PnCZotwIeiMiNIbIpTWGB6KW43qj1/XMbWeSmrtxcTO95ZfFMpI7wdG60prK4acN+YP1t+x+jjecS39LnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631304; c=relaxed/simple;
	bh=aw7Tb8yi+Z6BHI19zTJMa/P1khL0FVXGCGyzEGNGFwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k3UBrnR4g360h1f8JJlvqS7XO4s/7htoVNxVGZka6hkYMuq6CsTiB5myHZ8wxD39kS8tbpltaglFzH33LozmHIhSNFM5s3JLJA+S02kd6/l+AsiQeuXN8a5Fc6A+0AgFCQUAmdrbl/daLwjorOhW6kBA/YjC/cYeDH69ZuGmdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHaaXl8F; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7e2762ad850so138868b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767631300; x=1768236100; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrT3dLlHGpW5cFPltlRdV3kq8k0TZrruJR65wiYQAOA=;
        b=QHaaXl8F0GEeDjSmvD/bBCgvcebZ/An7gJgLCtBGeTjSD1AlK03Ux6xi17cC+tWqZB
         x3zmLTgziDX6hmLxhmKYYu2EZp9gBKwVm/3YRGJHiV+ILm5pa2Vy8YmCN/DcAO3ZXdAt
         m6ZhaHdKC8XcHaZUyvsBkBvDnxRMaqSeQ4r4+RxPowlHgSoSY+kfcFL8OjQtK9SslLv4
         0RQbYut7uVl1Vt9N3H4Hh5TP9K4aqRfoyZs06+rijk6z83oIMu/Ie6Pb1Dth6vmXTRkX
         Wpx52ohiY4WqM7e7fK71vKSfR5wwcmPjFtTnDmNpZ0ogndjvJ6B2g8A+QV0irQ+js2oY
         3QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631300; x=1768236100;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrT3dLlHGpW5cFPltlRdV3kq8k0TZrruJR65wiYQAOA=;
        b=wBb2c0iBy0mdLHeNjeZiwlsGbJ1e7WlwaJkbEGMr22C3lS7EdN05b+4HsuaG4h2Bh9
         3o0MO1yPCG6uFCGljuM7/t8s2B8CPgSVZNd3djzTRAmD4hr/DrbSQl9bJPBxM21S+9Rv
         nV9rfsgQK23tVTbT0YZQlfowVcvAaHK9Hd2USxo/mOV42bn2GRLtFuySVAQAABFnlt5L
         ODAWBdQUnTAdvQNuqUXjw1z8JKly1lUcB82trm5CJUKtS6tmUPavht7sWdcsT5fEvnwD
         CgAYxGb6CwrFqebLQ0FB82IJZDdLKDcGLG4oY00vFTyKtsoSLVTbXEhWZMTz/ZVNXyfy
         3IVA==
X-Gm-Message-State: AOJu0YyARBBJbNXOG0naoIHuRNZpK71X7FK9xFHudBfy5XnWPfDFMmIN
	SQ+116Tmdd5QKqyaDwJfUss//RfCziXFQoU+mJEi+LUZJyfhbWRQelFT
X-Gm-Gg: AY/fxX5ZHItkhvVKUKwjXqK05AhGQOWZe+RX/z/hjJwWQOJ+ieIiAdE8HfxC9lMQ2LU
	Jh7pZUCwYOZVTJwNIPqLtLPXD0TKy0OsN/v3voQkRDrR54KmmBpj56+u5lQ9a9Kar9r33IXJKOT
	R/wdDlUUAalKeYxtTmuLSQHCZmdDK4qf/XMIycKdwz3NwCWnkTpuQL2l9QVWTk/BZv2fRZJRWT1
	5NMHqAVeWtud3fBymKsvrn6+ZTubG3Ru9Es9GcTkpxFzpbZd6DXRwDU4vULRaY8zFtl/7o4zPM8
	avqM7LCFRrkzlxGNBMv4zZYXDH+YsKAyN/lXgLGwy6mCE/HyXMi22IRLYGGW+1UTp4Nea/6ZMs0
	tJPkVdTJ4vSyLUal/5lEqh0pPvViQv7B7hLJdJRofvdg38eL3oPJxnXZL6TO3qpxMMlFvBXGhq6
	zVreXxfWTfGi4dn8d8gk4=
X-Google-Smtp-Source: AGHT+IHu7uxDkGljRvFuuVm/57Ojr+hrgf41QijJcDTLFzLaZinLHT9wIkGII38E5k8xO0qSgx2AXw==
X-Received: by 2002:a05:6a21:6d9f:b0:366:584c:62fa with SMTP id adf61e73a8af0-376a7af606cmr53814542637.21.1767631299786;
        Mon, 05 Jan 2026 08:41:39 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4bfc97acbasm148016a12.2.2026.01.05.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:41:39 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 06 Jan 2026 01:41:01 +0900
Subject: [PATCH v2] kunit: respect KBUILD_OUTPUT env variable by default
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-kunit-kbuild_output-v2-1-582281797343@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NWwqDMBQFtyL3uylJRLH96j6KlGgSvaiJ5EWLZ
 O9NXUA/Z+DMOcArh8rDvTrAqYQerSnALxWMszCTIigLA6e8YZx3ZIkGA1mGiKt82Rj2GEgjORP
 dTYuW1lCWu1Ma32f12Ree0QfrPudJYj/7v5cYYUQzPdRUK9pS/Zg2get1tBv0Oecv4u67ZLYAA
 AA=
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

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
Changes in v2:
- Add Reviewed-by tag and remove RFC
- Link to v1: https://lore.kernel.org/r/20251228-kunit-kbuild_output-v1-1-f1fb30fe060f@gmail.com
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


