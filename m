Return-Path: <linux-kselftest+bounces-34692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F66FAD53E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 13:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B28188426D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D98B26AA91;
	Wed, 11 Jun 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1iGUX13";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="drWr+xb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CC2609C7;
	Wed, 11 Jun 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641324; cv=none; b=d8QCyt9Q1jVjd/xqwba/mnmOOpqVzByDagQzyP6YBVPQAwLhSyzthxNUebzuhh/IBuBw9WpN9N0F4R8EViyXkmaKPEeW8997L+mpI1ZX1v4msoyXqqjAm/801SUQ+Qz0NNgp5JHFxy8erktuXDLbE0o247t1hDbs9Fm/BE6Gk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641324; c=relaxed/simple;
	bh=viIorSaJJPgs+NDzJ8EdjNfVLhfYMDHCVwxLX34JTvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEJbWyzgebLd2VnPSLdiONJUbx6uQ1gzxkEYo6OlwDgpi/cYjsCgpixx+lVm/8/Ysyvq4WtfrkLg6GoGycaYXqcVavNqMt+UXHk5iW75w6P2icIbZ5bStgDPAocGT4Exm4F1Y9fTl5Odut3HC6hfeYx5LiCyN8+Zy7ZReh7W7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U1iGUX13; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=drWr+xb4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749641314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2ROgs5PeJeUCZVBna+9TCUSWt8qvswhzd0dmf697KM=;
	b=U1iGUX13cpj5rb4tZHtxwQIdKrPToCglmHji/2BCvOU9820+/uXZD4RZJ7cOUtqKNxeCr2
	U3I6K31iK8cAj87thYRkhgHefg6hDDyTk47xDkOLFKe/E7LXpjNepjssgP7Y1ufOQpFZw+
	d1FUFOMAikdZu9A7Ee9nEUKFybM5knN+NtkzNVlhQgw2ChwgFuAvDJJT7TmjP4hsCgWuwL
	iC2UwwCR9aUgVF5lR077sIOXvZYHlgBTkJFEKzMEmAzKDdzCEMk2ialIosDKks+agYGzyv
	a63oqfwO/NrFYN3WUr4bxlZoYLC3b+wyPKAZ8gTABQ7lIcTr1OJzdd+N0EG/dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749641314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2ROgs5PeJeUCZVBna+9TCUSWt8qvswhzd0dmf697KM=;
	b=drWr+xb44jo1z7KwPDF+VUamXpkpOr6tOb4+QqsDyn+YuT3w1vA+UHSO1DcKo2yrYtcG87
	A4OVXPB1wT3DjLAw==
Date: Wed, 11 Jun 2025 13:28:27 +0200
Subject: [PATCH v4 2/2] kunit: qemu_configs: Add MIPS configurations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-mips-v4-2-1d8997fb2ae4@linutronix.de>
References: <20250611-kunit-mips-v4-0-1d8997fb2ae4@linutronix.de>
In-Reply-To: <20250611-kunit-mips-v4-0-1d8997fb2ae4@linutronix.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749641311; l=4178;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=viIorSaJJPgs+NDzJ8EdjNfVLhfYMDHCVwxLX34JTvA=;
 b=CyWZQdegRaeKI/KmyBSeKdZ6JBHl/BV57XwyX3h4qiz8VOrqVu1kWG6eKMlwqCWTA6fX4XTZW
 z/gydFTkODcCToYiF8lxfkGjJG/DKYQckJA0ndGE5PKKT9yuLcMKQ1f
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic support to run various MIPS variants via kunit_tool using the
virtualized malta platform.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
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


