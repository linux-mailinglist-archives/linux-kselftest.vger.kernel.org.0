Return-Path: <linux-kselftest+bounces-30837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18AAA897CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8302C3A9E2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4476284697;
	Tue, 15 Apr 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozvz6VnM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h3+Y3th3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1683FC2;
	Tue, 15 Apr 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708995; cv=none; b=KfulOqXzkalOaEd8nggDEtP89RfZvdIVRPpagwVqAxLds1a/zjHEH06dO2zUoU5aQACYNMjTM4o5e4Px4jDJ+yqwQu1V+mktHQGNjpZQqIna1khKIt1zyIaSMjlJS/n60sbLXDe1Joq1K2P4SEwGUyKmhkma7x3fA7CHHNCmiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708995; c=relaxed/simple;
	bh=4aC1Pyte1Rv/Mka8VUKuKsc79GjXNlw1fN0ewAuZsso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYzLzFMtsdjF+mSYL8i94aR59oXAfAS44dAJmOBhAkMIAXFtCU3owdSFC8jPwgLX8wn1YUtvvbJfy4rTyfADx7cQXoM6eeIQG8qt6lmq9DsHLilmv5sWICHwWgI5hPiXOJJ2UqCb9ap1/DuM/EEcZt71sgGT3dsuJ4x7WHus4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozvz6VnM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h3+Y3th3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744708992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZYOIhuYP9OBOOMYZoYkgulvB082QhWoFAeS1pDc9mk=;
	b=ozvz6VnM+Xa/S10lYxAgVrjVH/F1WNpgS6SjExg3O4ruLVykX5PYrhvwx4w/SrJj2cFiJr
	AU5/N085VV0mrpWB9iKcCqytPwWXLWpJaC/9z2vX49fanewEsgWusfj72uASGmsUMxhvHQ
	Cw0AM4DGlz9VKtj9dDhJweX5YXsyFMQjeYkS9NalarMYhDtIxDaf/LmL50yqVbti/xdGfq
	xul5Ba229jc0wAbpUV+UncfqWMKjw7q4/hWIBF8Z8EVXaBD2yCFsASYCm/yU0jbREMreWY
	MZ+gBA1STTMQD1LqMBCO0DrUJJz62XNvxwp84JEd2CxtnOR2K+ZWQSUhgcH1nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744708992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZYOIhuYP9OBOOMYZoYkgulvB082QhWoFAeS1pDc9mk=;
	b=h3+Y3th32Ep37OUmhcXGoqc4c3JNYrMci8mZG/VX1qsAZkd63v4v/z8Fxya7yLk3oK2mzx
	er+n5/rd7xuG76BA==
Date: Tue, 15 Apr 2025 11:23:06 +0200
Subject: [PATCH 2/2] kunit: qemu_configs: Add PowerPC 32-bit BE and 64-bit
 LE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-kunit-ppc-v1-2-f5a170264147@linutronix.de>
References: <20250415-kunit-ppc-v1-0-f5a170264147@linutronix.de>
In-Reply-To: <20250415-kunit-ppc-v1-0-f5a170264147@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744708989; l=1832;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4aC1Pyte1Rv/Mka8VUKuKsc79GjXNlw1fN0ewAuZsso=;
 b=6BJc5klRz+kpxXZz/hlLuwRrylCSjOaX/Do6DUZiPljrXPnseQ7OpojXnKI83gF20y8iSCP+1
 I1T1JjX6Dm8DYWY1Z+vBn7sBElXvKUPlBPZYrRmenC5x57EGKz+4NNU
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic configs to run kunit tests on some more PowerPC variants.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/powerpc32.py | 17 +++++++++++++++++
 tools/testing/kunit/qemu_configs/powerpcle.py | 14 ++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/powerpc32.py b/tools/testing/kunit/qemu_configs/powerpc32.py
new file mode 100644
index 0000000000000000000000000000000000000000..88bd60dbb9483af244d42d3d36c769ce2effe2b4
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/powerpc32.py
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='powerpc',
+			   kconfig='''
+CONFIG_PPC32=y
+CONFIG_CPU_BIG_ENDIAN=y
+CONFIG_ADB_CUDA=y
+CONFIG_SERIAL_PMACZILOG=y
+CONFIG_SERIAL_PMACZILOG_TTYS=y
+CONFIG_SERIAL_PMACZILOG_CONSOLE=y
+''',
+			   qemu_arch='ppc',
+			   kernel_path='vmlinux',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=['-M', 'g3beige', '-cpu', 'max'])
diff --git a/tools/testing/kunit/qemu_configs/powerpcle.py b/tools/testing/kunit/qemu_configs/powerpcle.py
new file mode 100644
index 0000000000000000000000000000000000000000..7ddee8af4bd79a85a1dbbbd0446d3ea47c5947d8
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/powerpcle.py
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='powerpc',
+			   kconfig='''
+CONFIG_PPC64=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_HVC_CONSOLE=y
+''',
+			   qemu_arch='ppc64',
+			   kernel_path='vmlinux',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=['-M', 'pseries', '-cpu', 'power8'])

-- 
2.49.0


