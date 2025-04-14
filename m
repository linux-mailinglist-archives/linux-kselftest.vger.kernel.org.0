Return-Path: <linux-kselftest+bounces-30659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA086A87A65
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 10:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBC91893204
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1E269D1A;
	Mon, 14 Apr 2025 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWCHeLnK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mCYor8kj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B2481C4;
	Mon, 14 Apr 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619199; cv=none; b=YP+KgXkVVkUWlrXLTf0oSFygcN27OqKx+PwFWjWe7sHXDd1u9MlKJydiqQmd3XNun9rQAktDzVeTbTAQeDETMAHOfBYjaCcCc7L9IKNwdJtQDubeVRzmPqNfxF58PWq+wHVIVazS2+L2Lh+C5irHAP8JBOaxjEwVpbmMK7LZ1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619199; c=relaxed/simple;
	bh=xOZ0p2CUeWSfBf8GwfXNZH/GcKScQzSTLiG6gz0ey8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNNGKy1WsruqaUYW5/hvqVZe2dAaxxL0nM9+HHJfNBDL8M4UnOu0+ec7ERBCSmsVO5QPL28PlKp1Q7siTi13ErAL+wyCglVnnZVRVk/PuZJEg13AId+4ZKOmPYy/uAkxz9IxuaeOMEZyFNdt4Eg8Dg3vQaQ7Z2H29gRuXcn2hoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWCHeLnK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mCYor8kj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o60EM5//gG+xcS+6Ra9+Xd3X2itCl9vIft8DhAGysU=;
	b=jWCHeLnKsc7ZPbXMDBEd1b1eFTZqJeSgE+FM0le2TSfm/ZoARKzq6xC9O/agFCEtsG1JE3
	+nxlh5ICekYgTqpHvksOCrlUPaYO1Ca7eER0MN+XwB1wdzBWOMoff1DMovwAk1LhqTStq/
	LeubQ355UjZ5ChxYFTcF+jSYYLy1IZpZ+k683SOvQBSOrmixTlSInm/CjeL/2ldA2QxE4p
	ov0jtI+oyNINUd+dUTb0Ag53WF+f2/MgJnAJ9LNlYIiOHwpt+EX815p1HbIRSYcJ52n0dG
	qCJKLBWWJ6TZ9fzOxtgnbOEhQJQuqqHbplxibWLcKD/PHvvJoyaP1JttcL1cSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o60EM5//gG+xcS+6Ra9+Xd3X2itCl9vIft8DhAGysU=;
	b=mCYor8kj3Se8cUDCYI6eccCyxZdqPnaImx1hv6QSXF5POsdF6owsu+MGuIAt0SyUVRuxH8
	p5LxAxF7QrQZlXCg==
Date: Mon, 14 Apr 2025 10:26:22 +0200
Subject: [PATCH v2 2/2] kunit: qemu_configs: Add MIPS configurations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-kunit-mips-v2-2-4cf01e1a29e6@linutronix.de>
References: <20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de>
In-Reply-To: <20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619194; l=4132;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xOZ0p2CUeWSfBf8GwfXNZH/GcKScQzSTLiG6gz0ey8E=;
 b=6MArL1Pme5j96Z3PT+Uc3FqhKPvqPD+N5kRKQ+BHejj8arkJBTTECOYhiq1oUX6BoKYse0Rjv
 L/A5YqCRTvRAum88ylOMmONCUeK6WpH0m+Fym0Ibe/WKRI5GwHya0QH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic support to run various MIPS variants via kunit_tool using the
virtualized malta platform.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/mips.py     | 18 ++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64.py   | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mips64el.py | 19 +++++++++++++++++++
 tools/testing/kunit/qemu_configs/mipsel.py   | 18 ++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/mips.py b/tools/testing/kunit/qemu_configs/mips.py
new file mode 100644
index 0000000000000000000000000000000000000000..8899ac157b30bd2ee847eacd5b90fe6ad4e5fb04
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/mips.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='mips',
+                           kconfig='''
+CONFIG_32BIT=y
+CONFIG_CPU_BIG_ENDIAN=y
+CONFIG_MIPS_MALTA=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+''',
+                           qemu_arch='mips',
+                           kernel_path='vmlinuz',
+                           kernel_command_line='console=ttyS0',
+                           extra_qemu_params=['-M', 'malta'])
diff --git a/tools/testing/kunit/qemu_configs/mips64.py b/tools/testing/kunit/qemu_configs/mips64.py
new file mode 100644
index 0000000000000000000000000000000000000000..1478aed05b94da4914f34c6a8affdcfe34eb88ea
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/mips64.py
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='mips',
+                           kconfig='''
+CONFIG_CPU_MIPS64_R2=y
+CONFIG_64BIT=y
+CONFIG_CPU_BIG_ENDIAN=y
+CONFIG_MIPS_MALTA=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+''',
+                           qemu_arch='mips64',
+                           kernel_path='vmlinuz',
+                           kernel_command_line='console=ttyS0',
+                           extra_qemu_params=['-M', 'malta', '-cpu', '5KEc'])
diff --git a/tools/testing/kunit/qemu_configs/mips64el.py b/tools/testing/kunit/qemu_configs/mips64el.py
new file mode 100644
index 0000000000000000000000000000000000000000..300c711d7a82500b2ebcb4cf1467b6f72b5c17aa
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/mips64el.py
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='mips',
+                           kconfig='''
+CONFIG_CPU_MIPS64_R2=y
+CONFIG_64BIT=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_MIPS_MALTA=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+''',
+                           qemu_arch='mips64el',
+                           kernel_path='vmlinuz',
+                           kernel_command_line='console=ttyS0',
+                           extra_qemu_params=['-M', 'malta', '-cpu', '5KEc'])
diff --git a/tools/testing/kunit/qemu_configs/mipsel.py b/tools/testing/kunit/qemu_configs/mipsel.py
new file mode 100644
index 0000000000000000000000000000000000000000..3d3543315b45776d0e77fb5c00c8c0a89eafdffd
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/mipsel.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='mips',
+                           kconfig='''
+CONFIG_32BIT=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_MIPS_MALTA=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+''',
+                           qemu_arch='mipsel',
+                           kernel_path='vmlinuz',
+                           kernel_command_line='console=ttyS0',
+                           extra_qemu_params=['-M', 'malta'])

-- 
2.49.0


