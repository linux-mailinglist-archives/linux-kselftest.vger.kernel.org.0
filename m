Return-Path: <linux-kselftest+bounces-30825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A64A89477
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205EA173D6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7BC2797B9;
	Tue, 15 Apr 2025 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I01Q0y3E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NobIsHEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1553194C86;
	Tue, 15 Apr 2025 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701023; cv=none; b=J+bZwAVJ0WJ1UBNqNj5QxZUfzef5YwValADtadX8k3CfTvKRR5FeKAzzVuYj24KR7g9NHWVQcgwx0+PhvTgwrCIxIjxUcdE5fGYvqx+Jq6q+3sFzRaHuRU3VUryYpQDr1NGkNbeEFIyr4yCYhGv2I4eN3d5AvK8FGS/LjVA1AWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701023; c=relaxed/simple;
	bh=xOZ0p2CUeWSfBf8GwfXNZH/GcKScQzSTLiG6gz0ey8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZfn73RnJmxkUQrGRh5DomvPDSNbl7DIUGNjnRDNAhDZ/Cy9M0h3U8KEqzSu4WBFJ1CwWC42bZikU88jEtPAyO09TxUuQDzeP+rzAx94b3eAUZuqOWsO/AvN12+S5UeUtMDUoKDCXLJRVqr/wQo4ayCxkeFeqA9uB9k8LrC47tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I01Q0y3E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NobIsHEm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744701020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o60EM5//gG+xcS+6Ra9+Xd3X2itCl9vIft8DhAGysU=;
	b=I01Q0y3EP+H9jkUbhr9XhvTjphzd7XMnUWYnw8PgIZjnt9KK9gRg8fjsBcHEyBNU5Mv3qL
	AZ1z8blZ3/sjaS5KVQpl5V6VDd84hv6ugvjMvub6IILge9CFhHK05rILmL4WS9sq3gFYpT
	r4ZhX6JIRRpGVH8Jd7CINX0xo6Dyvb27cEdeQmUb0qOACHmTDCqjEnp9l3Gf2/a6epT3E+
	ky38J/u6GwJzFxB/5KPdKT3TngYBYGWJFWOUp68cVujmAVZAgjsibLlDhNwOKKf9gZOwPu
	Ghna5avC0dL4+PHoyJjFyTT2+uHMNFI3+S8bkWl0IZf9tG4/E9iOnEkc/WPKjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744701020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o60EM5//gG+xcS+6Ra9+Xd3X2itCl9vIft8DhAGysU=;
	b=NobIsHEmij+jwXJpd553X2TCbMtl6PeTgOjmb917kYWuRu0RynQmMkg8FL8Vw9vqTLCizA
	r7XK24E+BRt3qZCg==
Date: Tue, 15 Apr 2025 09:10:07 +0200
Subject: [PATCH v3 2/2] kunit: qemu_configs: Add MIPS configurations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-kunit-mips-v3-2-4ec2461b5a7e@linutronix.de>
References: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de>
In-Reply-To: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744701019; l=4132;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xOZ0p2CUeWSfBf8GwfXNZH/GcKScQzSTLiG6gz0ey8E=;
 b=IWzqENMU2NJdiCi+5hy18vN9+QtlejpYUb2BGXwOVMahHXFFMfv8tF1VssQ1e7aZUHEAA0rZ/
 sFwEvoJLvIWBECA8MjQqYg9zSBDMMh8irkEuuwmO/DafUugYrYoLU52
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


