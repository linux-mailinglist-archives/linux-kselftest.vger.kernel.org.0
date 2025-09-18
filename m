Return-Path: <linux-kselftest+bounces-38658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF6B1FFE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C949317638C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 07:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32CC13AC1;
	Mon, 11 Aug 2025 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="phIexr3b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tfhhEQEg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179E2D77EA;
	Mon, 11 Aug 2025 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896061; cv=none; b=Qbo5OJ/0oI8Y86WA5WPV6v8WjdJp2cenBUpdT446Yu10/Hw5cgLtHpaOzFiFaHHPUM6DDxX2ubrS6GklvCob3Q1Sz+AtnfaRRSfnizV/cM6e6x0weS1UNX1y770lI6X/umVisFyf0celgV/rYwMPE1q9ccBb6p6Ba+47tfdCjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896061; c=relaxed/simple;
	bh=UFk6eY7NmTtNPYyzifEy5qe8NnyUJJjl1g05EAwoYEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CfWnXhmJvsUVE/zP99E6nTYXNtw7nEC4DtSY/CageLFWQ1LDilGQNr8b93Ji1zESt4Jbb8ieXZ7UZI0UmBsu6d5OUwsICVMJ+EuzF/uMeX7VjFKF2lK8XyS4adphFN5yO++SkQIdymReJZOqFxq2PYKS/cZejcyIGQC1q0N0rHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=phIexr3b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tfhhEQEg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754896056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XcdAMD005GNLmq3jmckmjGyMYa67BJ2FB1J1jrujtpI=;
	b=phIexr3boFfRBoNkAT0jxayjjpgRxIKrkKQKdDy8OhREellrIERUWv8wiqzDv8Kx2RjmSP
	5ok6Y2v/iVaLIOYMFaTMjEQTwOQ08vhSJQLW1z0VH/io0Rc6ddhS/uvh8uI9O+/4UOHgBQ
	YnCl9cwKhFTjKB2PMfD+PHEmjPopk/amRKaJh3XfJAh914e4gh4v+6KyG3RW0MJDqzlz7e
	FbsK116H//jVaCLuraTw/cGDL1md4/oKWagFCYHkXsw450k7GMXeJ5l5u9CxV1RSuFMDTA
	XtpB6JAS9vLW3uc1Et9U8s4Aje06d63qzybBCbZ8aNZTfWUaWAitRab6s2WwgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754896056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XcdAMD005GNLmq3jmckmjGyMYa67BJ2FB1J1jrujtpI=;
	b=tfhhEQEgNzrrNztTNrf06CUj1xwZtHg4QtytwYR6GkxeUaT5NzVWdKJMmv0BWphlb7KL17
	VXGheuYHVHhumqAg==
Date: Mon, 11 Aug 2025 09:07:35 +0200
Subject: [PATCH v5] kunit: qemu_configs: Add MIPS configurations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-kunit-mips-v5-1-d6b8fcf3f720@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALaWmWgC/23OwU7DMAzG8VeZciYo9pyUcOI9EIc2cZkFpFPSR
 UNT3510l61ox8/S7y9fVOEsXNTr7qIyVykypTbs006FQ58+WUtsW6FBAgOkv05JZv0jx6KZRoa
 AznLsVAPHzKOcr7H3j7YPUuYp/17bFdbrmrEGAe8zFbTRPJAPPnbOgX37lnSa85Tk/BxZramKN
 07bLyo2TmE0wNCjZ/eI7++53fD9yjkgORhs3/EjTjfuADacGof44n03Dtgz/efLsvwBlA14vmU
 BAAA=
X-Change-ID: 20241014-kunit-mips-e4fe1c265ed7
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754896056; l=5190;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UFk6eY7NmTtNPYyzifEy5qe8NnyUJJjl1g05EAwoYEk=;
 b=bX92Pu5JN0j9ekiwx+6UXWRAqxVXqwUi8WkRBYHNSUMisjIwhgrIlz3oSgLw23S4yh+m//WCO
 Qyd9b9dXlgIC7vPQ1Tu1B/DTrRHNS/7IwGlyeEnDOSe/RGulqCnBUG2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add basic support to run various MIPS variants via kunit_tool using the
virtualized malta platform.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
Changes in v5:
- Rebase on v6.17-rc1
- Drop alreayd applied patch to MIPS core code and related CCs
- Link to v4: https://lore.kernel.org/r/20250611-kunit-mips-v4-0-1d8997fb2ae4@linutronix.de

Changes in v4:
- Rebase on v6.16-rc1
- Pick up reviews from David
- Clarify that GIC page is linked to vDSO
- Link to v3: https://lore.kernel.org/r/20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de

Changes in v3:
- Also skip VDSO_RANDOMIZE_SIZE adjustment for kthreads
- Link to v2: https://lore.kernel.org/r/20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de

Changes in v2:
- Fix usercopy kunit test by handling ABI-less tasks in stack_top()
- Drop change to mm initialization.
  The broken test is not built by default anymore.
- Link to v1: https://lore.kernel.org/r/20250212-kunit-mips-v1-0-eb49c9d76615@linutronix.de
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

---
base-commit: 5606dd26f0b0d614e64a51e68c86e5066f9a5b71
change-id: 20241014-kunit-mips-e4fe1c265ed7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


