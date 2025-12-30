Return-Path: <linux-kselftest+bounces-48013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9637CE9B6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 13:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4E93030FC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D781DDC37;
	Tue, 30 Dec 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wbHe/nwh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMdWFEQt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEF1A9FA0;
	Tue, 30 Dec 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099409; cv=none; b=L9h5bLSrNAkzi06qzoUWtycEReXE5kvoRxV3MGas5hhdE5DSMYhLi0Mycd/T2eVGlL3FTWoAE3ozI4yY7KXrJaWSRvi9g3UHw+gONBZe3znkcvrfaDlbUqQCoCJ9ElJuSNX/8z/KzUCNi9MLg4G2+vPgiBvE9C1lkzQYOy1nezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099409; c=relaxed/simple;
	bh=Giig3OHwXW2aMIFZvh9rP0L5qDGtG0XatO4vAB8tazs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmeVSzlDvr/rc3K1Tc+4j0EBPuAsMv2agxN8AC452KIkKmvFI/f6SDQv9J5EG+omKdfJbFuZzDLCeA9ik50HmzHWobuiGtU6O29JHv39keAAndNNycJU00mSP3wstLsi8dSS2JIzKGncW5RJ/e9ekZrjlbhXYw5lbxBvTVTTg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wbHe/nwh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMdWFEQt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767099405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oN0tu8yRKUnPSbTz4wcXkb24pPTPrrY9IQQPWNTdpKo=;
	b=wbHe/nwhhrWB5uQqL53/hyyEA1Q05VbXtm+xXaTssqW41/cO0Mr3p4EmH7XBZD/dEF+tJE
	jn2Jbdr+gm0xhBWmiVcSNfp5AJZomxZZfDZsrvGhtxUuNzLtjk6hH9aluiKkF4co/3KAxT
	/hWDtxGWs685+FNtZObTH+BrJCilpTA95y/kxBP8kQ7uCkomUUoxvc92x9mrqcHK7wvqaJ
	OAUQErIv7GlSmV/niArZNTi7K1zzqXzLFx5q751HSBWxKsQYx0/RShJaTa0TOTaxSrw0qy
	Y2owM7kCtv8+IkfybDdudNWXSoy+Do4+49asssjgnOd1BZcnqKt6VaDdIJm5bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767099405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oN0tu8yRKUnPSbTz4wcXkb24pPTPrrY9IQQPWNTdpKo=;
	b=fMdWFEQt737FrSu0Vv0QUI5+6ctDFKNf3lAJ7wdexPwjCU0GTq29X8YLWLQQPhLHtTiexM
	HEu7EZ1zEcibv+BQ==
Date: Tue, 30 Dec 2025 13:56:43 +0100
Subject: [PATCH 2/2] kunit: tool: test: Don't rely on implicit working
 directory change
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251230-kunit-pytest-v1-2-e2dae0dae200@linutronix.de>
References: <20251230-kunit-pytest-v1-0-e2dae0dae200@linutronix.de>
In-Reply-To: <20251230-kunit-pytest-v1-0-e2dae0dae200@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767099404; l=1941;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Giig3OHwXW2aMIFZvh9rP0L5qDGtG0XatO4vAB8tazs=;
 b=84cugWk6oLY3xF+RSfe5ulAIR9oiDc7y7y3V+mURfNdL/XSmLy7LZup5m44B6lLZLBFU7l1yQ
 LulbVXlj1oBBufEr9xVs4bLMIQbnxaXKHJOpW1aHs4tEM2YnLjsRRgm
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If no kunitconfig_paths are passed to LinuxSourceTree() it falls back to
DEFAULT_KUNITCONFIG_PATH. This resolution only works when the current
working directory is the root of the source tree. This works by chance
when running the full testsuite through the default unittest runner, as
some tests will change the current working directory as a side-effect of
'kunit.main()'. When running a single testcase or using pytest, which
resets the working directory for each test, this assumption breaks.

Explicitly specify an empty kunitconfig for the affected tests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/kunit_tool_test.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index fd7ca89596c0..584275ce6ba6 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -466,7 +466,8 @@ class LinuxSourceTreeTest(unittest.TestCase):
 		want_kconfig = kunit_config.Kconfig()
 		want_kconfig.add_entry('NOT_REAL', 'y')
 
-		tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
+		tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[os.devnull],
+						    kconfig_add=['CONFIG_NOT_REAL=y'])
 		self.assertTrue(want_kconfig.is_subset_of(tree._kconfig), msg=tree._kconfig)
 
 	def test_invalid_arch(self):
@@ -478,7 +479,7 @@ class LinuxSourceTreeTest(unittest.TestCase):
 			return subprocess.Popen(['echo "hi\nbye"'], shell=True, text=True, stdout=subprocess.PIPE)
 
 		with tempfile.TemporaryDirectory('') as build_dir:
-			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			tree = kunit_kernel.LinuxSourceTree(build_dir, kunitconfig_paths=[os.devnull])
 			mock.patch.object(tree._ops, 'start', side_effect=fake_start).start()
 
 			with self.assertRaises(ValueError):

-- 
2.52.0


