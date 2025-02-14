Return-Path: <linux-kselftest+bounces-26652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75291A35F36
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 14:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447E83A6683
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B32641F0;
	Fri, 14 Feb 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="st9u7nEo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ta8snyTf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F6263F29;
	Fri, 14 Feb 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539633; cv=none; b=qhlCWiv8il26mVv04shed6GzJ/W/i5xYYG7GPL5AVpZyYGDeEcoBHSVGL85JD+B7a5WjvmHQbXolN6Dwugt4K0m4v+/VCKqeA2hNupI5UVqZcKfkfE/0fTvP7K38QuSv9ZHqDiUjBWTBo1CTe8tIgSXto7QPJeiHqz0vx2dcSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539633; c=relaxed/simple;
	bh=buO8lnZB5RS19yZ3QiNDAI3WoWc4MzzsGjX7y7m4+sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AR2gRaz6Cr03IVzP7RjqL+Mv7fl/On46rm+B0t2Bd5ouAg0PZfI2Hc6Pfk1yifmlcIONHX62fekk7aoQqvH5JZxsd7nlmRywkHPzdXsO53GV3bYwOa8DpBTDVs1v9RflgeeXFw3OevhF1qi740vU/1IzknCAXADuinI5sqXmae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=st9u7nEo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ta8snyTf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739539628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yv777d7cAi3pxmwo5xy/LqTWbb3/Dx76bz53TWLPkS4=;
	b=st9u7nEojJzs+c8TtLH/WmuLSQzQ/FNo8A3hk2AXUBk1JfTEZw9+Uy4qg6WWUqCvLdWzF1
	5qQWsTR/CjZgtOpJxy6RWV95K4lXvX2++jcqC7sd75Pamm3qY1Jhom0mVZOQDd8NHoF9zH
	uSL6zbXILeWGCK6FEOnUwNqm7lPPSU6z5e4mv7TrVlqV6hsjGrvtFqehfyQCdRLTCuzbOr
	hGJuPyyKjvl1T8AjhVyLxb2q1KPCGyTtlYuZGma+ALa5wfz7rB2Fqol8aftL8Eb+OzwpdS
	jTiltO4CsWs+rzTrFsPm4vfmsnxqRn5Hd1bVdE1qegKZwaMkNxwe0b/U5eu98Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739539628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yv777d7cAi3pxmwo5xy/LqTWbb3/Dx76bz53TWLPkS4=;
	b=ta8snyTf/hTfMo7mYLMF3tbyjajsmBpoBH9X35bQRcnaU8LbcC3ePmi5Ha1RQX4Apl5l72
	jRGmzVsaobDq5mDg==
Date: Fri, 14 Feb 2025 14:27:05 +0100
Subject: [PATCH] kunit: qemu_configs: sparc: use Zilog console
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-kunit-qemu-sparc-console-v1-1-ba1dfdf8f0b1@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAKhEr2cC/x3MQQ6CMBBG4auQWTNJGVGIVyEuSPnVidpCRwxJw
 91tWH6L9zIZksLoWmVK+KlpDAVNXZF/juEB1qmYxMnZSdPyaw365QWflW0ek2cfg8U3uDvBQ3q
 Z+ktHJZ8T7rod6+G273/Orfw7agAAAA==
X-Change-ID: 20250214-kunit-qemu-sparc-console-73ece282d867
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739539626; l=1720;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=buO8lnZB5RS19yZ3QiNDAI3WoWc4MzzsGjX7y7m4+sA=;
 b=5ODErY8doHI/e8J6vud19fO6KexdNetfa/1SpPYrbfEC0Uzl7E739hZnvghY8rYKftpewi0bh
 4fGI4uwu+tJBkMl2Y6Kqz7rlaX70zXv/l4vhdUxLoJMDkg0oZ7tscLr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The driver for the 8250 console is not used, as no port is found.
Instead the prom0 bootconsole is used the whole time.
The prom driver translates '\n' to '\r\n' before handing of the message
off to the firmware. The firmware performs the same translation again.
In the final output produced by QEMU each line ends with '\r\r\n'.
This breaks the kunit parser, which can only handle '\r\n' and '\n'.

Use the Zilog console instead. It works correctly, is the one documented
by the QEMU manual and also saves a bit of codesize:
Before=4051011, After=4023326, chg -0.68%

Observed on QEMU 9.2.0.

Fixes: 87c9c1631788 ("kunit: tool: add support for QEMU")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/sparc.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
index e975c4331a7c2a74f8ade61c3f31ff0d37314545..256d9573b44646533d1a6f768976628adc87921e 100644
--- a/tools/testing/kunit/qemu_configs/sparc.py
+++ b/tools/testing/kunit/qemu_configs/sparc.py
@@ -2,8 +2,9 @@ from ..qemu_config import QemuArchParams
 
 QEMU_ARCH = QemuArchParams(linux_arch='sparc',
 			   kconfig='''
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y''',
+CONFIG_SERIAL_SUNZILOG=y
+CONFIG_SERIAL_SUNZILOG_CONSOLE=y
+''',
 			   qemu_arch='sparc',
 			   kernel_path='arch/sparc/boot/zImage',
 			   kernel_command_line='console=ttyS0 mem=256M',

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250214-kunit-qemu-sparc-console-73ece282d867

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


