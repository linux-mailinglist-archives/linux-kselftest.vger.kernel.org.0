Return-Path: <linux-kselftest+bounces-48058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C20CEDFB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 08:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EE33017F0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1522424C;
	Fri,  2 Jan 2026 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4VvPvsFU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RxFfoQGu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF025EFB6;
	Fri,  2 Jan 2026 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767338444; cv=none; b=QlZ0BUCxat7HZWXag65OWt7gU/qu/rFjmXSlUOHEev28fagMbg6/HXww+FheDGB5Ip65nC/7zLaCA14cnhAKv2PVyUnmXfLnBrq5ThCAPEMQuckqKGE0rYyDcX/zJGHevjdpdxc2ZpJu18z2LNdhtjhqQgJkuk3H0YYXPLw+Eb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767338444; c=relaxed/simple;
	bh=iz8NAV/ioz4BBaLZQpCEtAtmnWhM8lZ8g+wOMgy4mtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WyYfMxh2kGheaTDXOxEqa2EccqCNKpbpcmZmwNoWGC+USsnRFqSjZl0qH4KgUSSTrwKzGsIvmpD5/yEkJyA3hPr8T82U2hjuTlLsEEBEGUDu1RtOFAFVp+nMs0K22O5Ln18GHTiOOFa7a3a60Tdy9Q3eLCjX19cdjZh5JBfdAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4VvPvsFU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RxFfoQGu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767338441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x7GuFwyVcA1QOqEvz8fb39erJMjUjaH/BU1wqVToOxo=;
	b=4VvPvsFUIPr/0oM/jj8YDkIQUkGbrLBvz5+cXT3bTE8J8H4qo3SKdVwHhlkgu1Jb5dCq0x
	oWCZQdQBxYSYjKndLCbAka+3d1hY/GZLjja6DA7gEp5WKyp2K2ksAHtOGGyjTqjXbYwfh8
	m9D4uAVQc1lGQYsG21JPnOd668Df1BInbnLlotwcbecR98/RRYTbHGi0FMGyBCiBRwQTbi
	fcfIUtBc8YESSKo1e63+pTQ7arvilAbvHHYzrjjBGEv+fp9Ag7MY9/f5RFCd7wKhrjHowg
	hfmrqVRY6EYO34cO5EftwLI6AS9meOyH0PRpIlHE8NEnFwpe4IlDhnqGNTmeUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767338441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x7GuFwyVcA1QOqEvz8fb39erJMjUjaH/BU1wqVToOxo=;
	b=RxFfoQGu3Ehj4HGf/YAtuBJv+R8iveBGdeMjtpaOToZcnQ+v81EeNwLEAXKcpcqGLkfchi
	9tmROVkEsu4pZVCA==
Date: Fri, 02 Jan 2026 08:20:39 +0100
Subject: [PATCH] kunit: qemu_configs: Add 32-bit big endian ARM
 configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260102-kunit-armeb-v1-1-e8e5475d735c@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAMZxV2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI2MD3ezSvMwS3cSi3NQk3SST1OS0NPMU4+SkRCWgjoKi1LTMCrBp0bG
 1tQDkavEzXQAAAA==
X-Change-ID: 20251230-kunit-armeb-b4ecff7d3cba
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767338440; l=1321;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iz8NAV/ioz4BBaLZQpCEtAtmnWhM8lZ8g+wOMgy4mtg=;
 b=yYeWKmBSBBnpDo1aB1hiXn+XVBAhqWOVGoOTz2QnBQ0txhScWRe5mREsbAoKy8j88TEFoeXAB
 p6At2lDhS7rDpxqfHVjEP7QeYbjKTRZ3L9mXaQKp9JF6QJEMJsSMEpW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a basic config to run kunit tests on 32-bit big endian ARM.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
The test string_test_memset64 currently fails. The fix is here:
https://lore.kernel.org/lkml/20260102-armeb-memset64-v1-1-9aa15fb8e820@linutronix.de/
---
 tools/testing/kunit/qemu_configs/armeb.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/armeb.py b/tools/testing/kunit/qemu_configs/armeb.py
new file mode 100644
index 000000000000..86d326651490
--- /dev/null
+++ b/tools/testing/kunit/qemu_configs/armeb.py
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+from ..qemu_config import QemuArchParams
+
+QEMU_ARCH = QemuArchParams(linux_arch='arm',
+			   kconfig='''
+CONFIG_CPU_BIG_ENDIAN=y
+CONFIG_ARCH_VIRT=y
+CONFIG_SERIAL_AMBA_PL010=y
+CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
+			   qemu_arch='arm',
+			   kernel_path='arch/arm/boot/zImage',
+			   kernel_command_line='console=ttyAMA0',
+			   extra_qemu_params=['-machine', 'virt'])

---
base-commit: a77b19b747c8a53ac16289685b0f77085a2ad553
change-id: 20251230-kunit-armeb-b4ecff7d3cba

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


