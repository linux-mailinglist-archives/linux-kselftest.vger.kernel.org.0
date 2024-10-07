Return-Path: <linux-kselftest+bounces-19142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98A9926B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 10:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B43B242F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B881885AF;
	Mon,  7 Oct 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qSbQ8grX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C96HFozS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C6187332;
	Mon,  7 Oct 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288666; cv=none; b=BGkesCJ2p4qbF6iPrA7cyjh5Z0acJfakU8wPhSX/xj5ybW7SXgk4P0Rd1lhADIuBg0lAWtdFI2e1L5YzzwK7zvQH+HcuWKCY/MNlqfinvmxur+u9zRTgPvgawfNTg2Qf+Zra7GXZxQ1X0C+ZgE7ib98HqDvCVN2yIRBFie/jv5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288666; c=relaxed/simple;
	bh=lispu6tim7ilYKQupOCja5YSio/uDDN1rKjKcuVDCGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rLQWGVtSINp5JO1+wbFiBSjHx4/2UM8h5gwUeHilhCQSGYvN8SvisNu7l2QaNiZUsbNEK9rd3GAjpvmgiNlr108jIgC3HKtmqewtcjtY8eOeN7vGLGg0VTqXdfUiAaxiI8fkPhrPWOu7AYYAqg3jBl4D2FpVmtYnX8P+xNLLth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qSbQ8grX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C96HFozS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728288658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rc2WRBa9nsOxlON/kWst27eS+j+Ou1jn3dp+OeGc1c4=;
	b=qSbQ8grXfMsH7c6tRz45ejhi3TWlBwAXSY+LiotmkzilEuiTM9N7ajuHyxP57KYFsNR2Lk
	TKeGipwNt/+Jk5dJYPamYwDNKbc0gOlYVHhg5YBO5Ptwl1cZOND4l5+kSTuo6Gti0ecPfF
	SAgyu541WeKsfqfRmvdZe2vcxb6jDrGcr52EjmDGOf5spSjUm0viOTljqCropoCTA1s20B
	AcJbwmd2mGvzczpMzHXh+2fRuRdbhwwUiTJL0AKiwXoIGJI76bffKGWAlT2F4lMxW4rDsA
	BtIto1efZbH94gtyIe5TgfNN0EeL/gdaLHt7a+graO0k71yt54YG+WYb/5M67g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728288658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rc2WRBa9nsOxlON/kWst27eS+j+Ou1jn3dp+OeGc1c4=;
	b=C96HFozSVO1mVAgksYL9+flj8sN1PaCmK4hdeo9ASZIgfDpL7AjSASC4q6dO+EY/7+wqir
	mwVvmC97bSsV//DA==
Date: Mon, 07 Oct 2024 10:10:55 +0200
Subject: [PATCH] selftests/nolibc: start qemu with 1 GiB of memory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241007-nolibc-qemu-mem-v1-1-c1c2f9acd0f8@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAI6XA2cC/x3MTQqAIBBA4avErBuYRBO6SrToZ6qBtFKKQLp70
 vJbvJcgchCO0BQJAt8SZfcZVVnAuPZ+YZQpGxQpXRFZ9Psmw4gnuwsdOzQ81WSMIm0V5OoIPMv
 zH9vufT/9JtAPYQAAAA==
X-Change-ID: 20241007-nolibc-qemu-mem-5ed605520472
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728288656; l=1917;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lispu6tim7ilYKQupOCja5YSio/uDDN1rKjKcuVDCGg=;
 b=m1wJs6YqqjNyJ0GFI8DMGeCXkglP3nCk9iqtHJKO+yLtBnKPpIqckdd3JUfMaz3UjsKBZaoKW
 twesCn2gwBqANMBouMrkZF34QiStoI5SYSTyaQkNoPMVlWoE+kgGauq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Recently the loongarch defconfig stopped working with the default 128 MiB
of memory. The VM just spins infinitively.
Increasing the available memory to 1 GiB, similar to s390, fixes the
issue. To avoid having to do this for each architecture on its own,
proactively apply to all architectures.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8de98ea7af8071caa0597aa7b86d91a2d1d50e68..e92e0b88586111072a0e043cb15f3b59cf42c3a6 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -130,9 +130,9 @@ QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIB
 QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
+QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241007-nolibc-qemu-mem-5ed605520472

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


