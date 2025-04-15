Return-Path: <linux-kselftest+bounces-30876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC1A89FA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0826444D0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F81189903;
	Tue, 15 Apr 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W3Bkeu7C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydmg8Rwh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB115183CA6;
	Tue, 15 Apr 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724297; cv=none; b=qYJBFv0mhxDC5PpgcJ6xUEIjdRPUtOJ5NuLObANzL8Fg7Veo4opQwGHRYIKIViHn0/pjea5rLqI8742IotLXuy9E7a07ioUyEIfAufD/iEVdeiCZ+6Ssy4arLPkolSzLth1fndv3SN+H1OqgudwCMIGVIam8PU4PyEPwiWEL9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724297; c=relaxed/simple;
	bh=8Nw99pvz6dERF5uadTuhGHfV7Lz+32HtJ8fnKFGggWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8FHjc/dug2DD23KwxPcXILamgGdlD4VSOpjypJe8IZyhofDlDa1yU+leZTQ5XRqkpllbUVykIAGgUnaLk/2hpLGcAM1xls5N0gpGed9wRm41W3iYFcfapKYMIeZxEsmcZMTYC9Tj/uwfyVpo/Hsn5RqcLSN871RxrHklGzp+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W3Bkeu7C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydmg8Rwh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744724293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hRFvNpWqj6nUWyPtn59a6PmgMLEAD4yPt5akiJAYv4=;
	b=W3Bkeu7C8jnqYzH5wztyfFHaxHYzsvzSg1rXASH2O/HST1FfG4R9IsjmAr4LdHvt6aHxDJ
	U5H7CymmktdA8nF5CmqZ/LQ6ya6jStpyejQinZW8SEXpWOHWnmmBxx8XBIEJ/mI6LD+5Fj
	ANtK0EqXgsOltY+g7+lJIgqpoiHy7xMuHTmaYT027T05slABLeaGRojB+oWm1cXsxUcddj
	DW5qBtnRxD1hj0rMB4ACU+u3vMX9BOVD1/2KPsipw+iSipHjKgRApsFF/qd3FFGMWu7ynf
	mPNUalyY3LQELiR5Kxz0VwsT0ZQyY2K9u3pNpivQQKcmO2BDMvxpfJYlItt4RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744724293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hRFvNpWqj6nUWyPtn59a6PmgMLEAD4yPt5akiJAYv4=;
	b=ydmg8RwhjpVq2QumLUSU74RYASJBEaDAvDv2b4lhRV28Ipn00FFKg0DCDANwiLI7EOHMYG
	76dH2KYQj0eYuBBQ==
Date: Tue, 15 Apr 2025 15:38:06 +0200
Subject: [PATCH 2/2] kunit: qemu_configs: Add 64-bit SPARC configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-kunit-qemu-sparc64-v1-2-253906f61102@linutronix.de>
References: <20250415-kunit-qemu-sparc64-v1-0-253906f61102@linutronix.de>
In-Reply-To: <20250415-kunit-qemu-sparc64-v1-0-253906f61102@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744724292; l=993;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8Nw99pvz6dERF5uadTuhGHfV7Lz+32HtJ8fnKFGggWg=;
 b=ngS5iuZKYGbLgqNtluVDdtx3AmNvrU1EG1qP/kp1BcI+UtybHHGHsysDVPaKyn59BiCrIiXZa
 Doi6Mf7FHeIDAvKWmiTbt0z120P1qzbnsF7e6x2U8GfLudCT1ecK7WS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a basic config to run kunit tests on 64-bit SPARC.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/sparc64.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/sparc64.py b/tools/testing/kunit/qemu_configs/sparc64.py
new file mode 100644
index 0000000000000000000000000000000000000000..53d4e5a8c972b96efc72f6b69fe83463499ef847
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/sparc64.py
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='sparc',
+			   kconfig='''
+CONFIG_64BIT=y
+CONFIG_SPARC64=y
+CONFIG_PCI=y
+CONFIG_SERIAL_SUNSU=y
+CONFIG_SERIAL_SUNSU_CONSOLE=y
+''',
+			   qemu_arch='sparc64',
+			   kernel_path='arch/sparc/boot/image',
+			   kernel_command_line='console=ttyS0 kunit_shutdown=poweroff',
+			   extra_qemu_params=[])

-- 
2.49.0


