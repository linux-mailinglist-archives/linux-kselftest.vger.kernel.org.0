Return-Path: <linux-kselftest+bounces-48397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A296CFDCAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 14:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE6D430019FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB163254BD;
	Wed,  7 Jan 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A67zMz0Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ee0gPw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535031ED7F;
	Wed,  7 Jan 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790322; cv=none; b=INk4aC619es+UnN7PodS9sKOI3zFBB+4tEgCBnuGK7BXZLNXtDnhAOMXV7/lFeE7MqvChzvdcdyDQSQDRoGR4N7OeFw+RX0DBMFmvTJGl3GV8vq2/DiIfZjrCV9xWJDeug1RCWel5bwxt8bAOKwrn4RDibmlqWE/0yjiBNeAUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790322; c=relaxed/simple;
	bh=WzuiM6KA5R1CN2zyTp2/rdHAa7xwIEWPjnDn7qzxi8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKbgSNNT8AVKJQRW1wVp0+gmx3Gy3jmEXTec416AtE8Y7FWtAkjLffc2Zs0xtDCHpIaZ5lO3vO59rSqa9nmxe1NzLt7sLUleR+15BoxsM9KJo1x+SuBEpWFydWJNUyC1bjBf+/OQbiLaT0x3eXudR6ZiZSttd3JwMpPI/DciyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A67zMz0Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7ee0gPw6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767790319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAuyZC2JdSpV/R2gVpOwxIWPkjpQHPypMLtLq66NxxQ=;
	b=A67zMz0Q3KjmTFAboSIiUrjeZEddeNJn78TpLLHngrEy8nFRzQrp7NkkVEEk4Zm2UaGHMs
	C3zPbX+oVi3Fc60/JzkTvwH6W990eAbiJ90dEv9Wu0qjQxckGOaJfGaVRDyicXgYcoYvZb
	I1X1JillhoUwd10M6w6NuOsVAEbRc7djGqICg/2qVKOQ5gf7OAgrwMr98nIrIABa7/YimQ
	aLHuOHXzRWdKF/6acGk8MfSRPDZubWAC/FelxCpm/3d2Dy+mO9ScgDIqhKgm6DBViqdPyA
	okz/F9KgEORk8aqgQwAjl2/U4qF2iSOlNkrQS83xgMUjCXrhNCThNB0C27aMow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767790319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAuyZC2JdSpV/R2gVpOwxIWPkjpQHPypMLtLq66NxxQ=;
	b=7ee0gPw60/6XaVmSaxpvIn1q5+kDdOZ91rGq6+uweupegCIJDyACnrvbpjuT9YBixM/xev
	WYELHvoYWZsVjSDg==
Date: Wed, 07 Jan 2026 13:51:52 +0100
Subject: [PATCH v2 2/2] kunit: tool: test: Don't rely on implicit working
 directory change
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260107-kunit-pytest-v2-2-7d1f8d9a5ffa@linutronix.de>
References: <20260107-kunit-pytest-v2-0-7d1f8d9a5ffa@linutronix.de>
In-Reply-To: <20260107-kunit-pytest-v2-0-7d1f8d9a5ffa@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767790313; l=1987;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WzuiM6KA5R1CN2zyTp2/rdHAa7xwIEWPjnDn7qzxi8g=;
 b=sSqK0SLNCUIAsshludouWK3xKzmOIZ5x8+/9DEQQIr56PHqUh4qHVwlNvOkIcJcVeVZs5Cw7J
 E2CNJGJqxzYD5tlisOo6rn511IGyBngFi6yeYnK/xazO0T6NsyouPhf
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
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 30ac1cb6c8ed..238a31a5cc29 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -477,7 +477,8 @@ class LinuxSourceTreeTest(unittest.TestCase):
 		want_kconfig = kunit_config.Kconfig()
 		want_kconfig.add_entry('NOT_REAL', 'y')
 
-		tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
+		tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[os.devnull],
+						    kconfig_add=['CONFIG_NOT_REAL=y'])
 		self.assertTrue(want_kconfig.is_subset_of(tree._kconfig), msg=tree._kconfig)
 
 	def test_invalid_arch(self):
@@ -489,7 +490,7 @@ class LinuxSourceTreeTest(unittest.TestCase):
 			return subprocess.Popen(['echo "hi\nbye"'], shell=True, text=True, stdout=subprocess.PIPE)
 
 		with tempfile.TemporaryDirectory('') as build_dir:
-			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			tree = kunit_kernel.LinuxSourceTree(build_dir, kunitconfig_paths=[os.devnull])
 			mock.patch.object(tree._ops, 'start', side_effect=fake_start).start()
 
 			with self.assertRaises(ValueError):

-- 
2.52.0


