Return-Path: <linux-kselftest+bounces-30233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32083A7D78A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 10:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A087A29D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6422A808;
	Mon,  7 Apr 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m3Z5iJpu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u5AOf/1Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759722A7F0;
	Mon,  7 Apr 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013842; cv=none; b=GJAinXLkdRuuilLUzHVR4nKQZhIusnNCvlufEG1oDksjQlWawOCgy/CQ6hcu0Q5Y0qRRSJu/OL4kZhN9OOz54QZ/4kMq4NWEEY8b7c0RyW1MlLWOVREo4e+bzU9QKSWtYZn1MkYGvcgVIR/m3XC6d/J5kBybOGyGdEIx7Vofnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013842; c=relaxed/simple;
	bh=gbysyKBOdCV3nUg/YKqG1+5R+VB32jV/H2TWXw3+gcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Wkh3JVcN0SBbV2tO3x5uFjzdzKdI2xX61yhNRtxmdHvJSIeUXF76ckrR9cKzkf2oeoly3yzwEelpgPYPwgEwcWdzJ+fyp9UWg04pYTCoC8R1c8QvlTC9b6EF9DTMRTQ3I5f/bn+Z3e5XiYg8LWLdnclr6TPLo1MBGLrxp0krfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m3Z5iJpu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u5AOf/1Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744013837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LRRqqDf5eRm9UY2ySLl8NfedyATgHvg1H7iEDSJ0ycc=;
	b=m3Z5iJpuYrynycuOdwMwtdchgKooRgmFeylRNRU50v7DHDcBglteB2O1iSiQxDmdOzlzXf
	oorE5onEm8UB/tZdsnIfytqhsT3D0toVuljkKrG/UAks9qcX2LI/fe4uENhsT2HpSjkmJ7
	lYXik/Wbot1yR966QQL+EZw6mGoKGmPUEWlv2FkuRz/RjyPwANwqjfx4Yhb078jFEtYMId
	+vrImlp1KjZq9KdO/iY1E2E4Ha5rVfsMyRz0XpFYZdlx1XFPmJElpAw6CqbywUekzFbXhY
	KOxzseuL0giHjFqiWyaiw5VLKHKQP/FWi72rBTtaG86uMAUEUDVRfaGXEiWVkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744013837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LRRqqDf5eRm9UY2ySLl8NfedyATgHvg1H7iEDSJ0ycc=;
	b=u5AOf/1QrA+oawC9BV7QfV3Ys7W08xlt78f8xugqAcNvnzIwtCnSU2cTkAwAtIqZx+dwJr
	bRTgP+jeMHY1nKAA==
Date: Mon, 07 Apr 2025 10:17:12 +0200
Subject: [PATCH] kunit: qemu_configs: Add riscv32 config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-qemu-riscv32-v1-1-7b9800034a35@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAeK82cC/x3MTQ5AMBBA4avIrE1Cq/6uIhbUYCKKFpFI766x/
 BbvveDIMjmooxcs3ex4MwFpHIGeOzMR8hAMIhEqEWmGy2X4xIPWCy07fUuBYy/LIVeVloWEEO6
 WRn7+adN6/wH6hbAmZAAAAA==
X-Change-ID: 20250214-kunit-qemu-riscv32-fb38d659c373
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-riscv@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744013835; l=1201;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gbysyKBOdCV3nUg/YKqG1+5R+VB32jV/H2TWXw3+gcs=;
 b=ivXyuLLqrfsTSNfdX6xuJhHok80gVC77JW5uLTwal3CM0fd6qLJ9nNBFcuesNNTqV2fLmQ4jl
 xBFGtgjwJvmA/NwLeevEIdZSzL/vJPUNKK/5rdMl84CPaRA3WHGC8Y+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a basic config to run kunit tests on riscv32.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/riscv32.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/riscv32.py b/tools/testing/kunit/qemu_configs/riscv32.py
new file mode 100644
index 0000000000000000000000000000000000000000..b79ba0ae30f8573035b3401be337b379eba97e26
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/riscv32.py
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='riscv',
+			   kconfig='''
+CONFIG_NONPORTABLE=y
+CONFIG_ARCH_RV32I=y
+CONFIG_ARCH_VIRT=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+''',
+			   qemu_arch='riscv32',
+			   kernel_path='arch/riscv/boot/Image',
+			   kernel_command_line='console=ttyS0',
+			   extra_qemu_params=['-machine', 'virt'])

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250214-kunit-qemu-riscv32-fb38d659c373

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


