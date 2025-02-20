Return-Path: <linux-kselftest+bounces-27081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F5A3DF39
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5D07A91E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BFA1FDA8E;
	Thu, 20 Feb 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aoz/HXuK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9ZwgEiOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68F14A82;
	Thu, 20 Feb 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066258; cv=none; b=j13d3QmZRtDntcHGe7ritx1aJY3nszj6XVbPKP/0ftCOsE2k6bxNqhmAitDv7xuFGJ3smssexkpQqhVv/Lc6TLC7CBHWLyJRyBGEf4vbPqq/3ZwMxSU+LjIvzJCmpeuVeDB/7cFfKcML0j/SSZ6FT5sv7X0fA70vov5/F4FkBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066258; c=relaxed/simple;
	bh=vixLLi9/2+puAuThU6rLYYKbOilkcMeTe2mtRtu1ry0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BW60Pla/nSbScETmM70sj98eURxqgMBifhh8Gu5EBeLpaP/k5s9qBckOZtz/j2pdVc/kvvd0rHGvG54YmljDaEPF3NVh+PWfBeDIGM078gcXFVGULiqowrqb1LUrxR31a4sE71XPBcmszjZRYOHnAevhgr2EHBGJc3biescbLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aoz/HXuK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9ZwgEiOj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740066255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OHflafuFF2Pw7sS+fLkXEz/wfs4sGDW5pqwQpGcmZvk=;
	b=Aoz/HXuKARD+BSUAkVRzBBuwn0VC36Uwr4MY7dRAP5Cdkd18jyso/mOxNxzCGtk8pVcMQd
	p1tHmmKpTB6gpwIn0OOHqbBOgsGnLfGE8UKHAlmd9IJLIgLvYump5xTHKdata51aLD08Zc
	cqontCvWedLVqSGcOQhE3GT45NzOLy+iACLU+Cf44OUBXpH9QvJPLfYaEp1degZsuvIYv0
	5EcdubQAVTEsLPMBdyqRpn7RBeWZyvHaLXIsjav2iryghqJUVyNwm+G2aNtmKrNhXv/APm
	IMpALywQCtZcOBkhoRwdo9gAzmEXFQRfL7egNaHkO6xJxaxHZv1c0sOzlAlulQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740066255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OHflafuFF2Pw7sS+fLkXEz/wfs4sGDW5pqwQpGcmZvk=;
	b=9ZwgEiOjXJyYuSoCDdOXInelSIoDz6uuSh93n06oiFdmwF3oBJeWewP8zMSmezPuReqKyf
	QP/8TVF43JrsATCA==
Date: Thu, 20 Feb 2025 16:44:01 +0100
Subject: [PATCH] kunit: tool: Implement listing of available architectures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-kunit-list-v1-1-40b9d56417ee@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAMBNt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3ezSvMwS3ZzM4hJdU1OjRIvklGQDQ8NUJaCGgqLUtMwKsGHRsbW
 1AHF4kspcAAAA
X-Change-ID: 20250220-kunit-list-552a8cdc011e
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740066254; l=2540;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vixLLi9/2+puAuThU6rLYYKbOilkcMeTe2mtRtu1ry0=;
 b=vVUhFFM57xUFzYiiVYock3MuTo5MshhsELAJxfl7/MKPQIhRDbL+qYmDqYDUtGr2o07/50sQ0
 oYpG7/lqXvrDlgydmgcjWLOJ8PIB0LXHFtVXeOH48/8aqpBSLchE2nb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To implement custom scripting around kunit.py it is useful to get a list of
available architectures. While it is possible to manually inspect
tools/testing/kunit/qemu_configs/, this is annoying to implement and
introduces a dependency on a kunit.py implementation detail.

Introduce 'kunit.py run --arch help' which lists all known architectures
in an easy to parse list. This is equivalent on how QEMU implements
listing of possible argument values.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 2 ++
 tools/testing/kunit/kunit_kernel.py           | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 19ddf5e07013314c608b570e297a8ff79a8efe7f..6697c71ee8ca020b8ac7e91b46e29ab082d9dea0 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -182,6 +182,8 @@ via UML. To run tests on qemu, by default it requires two flags:
   is ignored), the tests will run via UML. Non-UML architectures,
   for example: i386, x86_64, arm and so on; run on qemu.
 
+  ``--arch help`` lists all valid ``--arch`` values.
+
 - ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
   same argument as passed to the ``CROSS_COMPILE`` variable used by
   Kbuild. As a reminder, this will be the prefix for the toolchain
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index d30f90eae9a4237e85910fd36f7f1c731d952319..e04195b135edc8f1aabe21d094b276e47c4f6848 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,6 +14,7 @@ import os
 import shlex
 import shutil
 import signal
+import sys
 import threading
 from typing import Iterator, List, Optional, Tuple
 from types import FrameType
@@ -201,6 +202,13 @@ def _default_qemu_config_path(arch: str) -> str:
 		return config_path
 
 	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
+
+	if arch == 'help':
+		print('um')
+		for option in options:
+			print(option)
+		sys.exit()
+
 	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
 def _get_qemu_ops(config_path: str,

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250220-kunit-list-552a8cdc011e

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


