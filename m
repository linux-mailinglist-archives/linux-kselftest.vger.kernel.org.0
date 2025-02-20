Return-Path: <linux-kselftest+bounces-27080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD558A3DED3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BA218915F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D191D63F8;
	Thu, 20 Feb 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEv+Xhy0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eWTEXZjT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9C5234;
	Thu, 20 Feb 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065920; cv=none; b=lUpJxLTUyN2a9OHKme//cAvnS86Kax3FXwXS3XfioSeoaitTRMQQjrBs3mDMtJjOImR5Y/WLDuABALIGfkGZ5bDO6HxY4xfzxguFZosw5phuoB3kt15rmhf5xTTvdywSaVAKZPZuUJLi/wJwAFDic5S7zvTEnTNJTqxkOhOirxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065920; c=relaxed/simple;
	bh=W0xJ2fNlNVkFLcGpLh+E4eVhmwP7cxluh16zZZ0Z6xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g5cl8jsSPdn8VTpYLesj2App8QA6lNBFwbqSuzo3fH4Ge8cIV5c+IxLgW6JrKNf060QB/uxO6rU2d1N/1ltTmGjLcl9ByHjon3OSuoAkEYCGB6qG/WkGZEE3A5s6CRj390R5LXuU/eS25fiDLeoD8tRGBuFHUdIxAu7cjnfO/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEv+Xhy0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eWTEXZjT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740065916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=79XZZfWENd7BMuAi8YpxWCwNIy5HxTade1ws5Y2S384=;
	b=UEv+Xhy04QsdNk8fFr4bWxX706TJW95KRIU1ImNOYj1BFVoZodKVlW7UFobhdOW/Ny09TO
	cn1ZudR9Y6KZIVWvrtTTa+o12iMkM8rHJIrq5NRJG0yfr27e5tWKBmW1izufpmk4XXmW6Y
	L47W1P8rFC33GR2EB1b+YGO+GvPkx63wt8RtO47qwL2gPKbM0ZJk4DmuLVXyI+m5hFjVIK
	uKmW5MbPRhQrR/r+06+l193AksDaWrvQnY3/DsiVua5Zs+up4Xd7Fq4dsr/2L9ZmxWOHBZ
	4sEWxPQNL7Is2Ovn26eV922Qt6dg9eqef4NsKQEX0WgG2IMU6QIfxUx7OYpr6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740065916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=79XZZfWENd7BMuAi8YpxWCwNIy5HxTade1ws5Y2S384=;
	b=eWTEXZjTBxrCHQXEKEEC/1feYTrdUiCzV5Om/tA3IXC08I7zOSSlrqZtPHKcmEjmu6JR/n
	uWOITZvPhZHQCeDg==
Date: Thu, 20 Feb 2025 16:38:29 +0100
Subject: [PATCH] kunit: qemu_configs: SH: Respect kunit cmdline
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-kunit-sh-v1-1-8b57dd05f55a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHRMt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3ezSvMwS3eIM3TQTo0TjRIvk5FRjUyWg8oKi1LTMCrBR0bG1tQD
 ZaRkjWgAAAA==
X-Change-ID: 20250220-kunit-sh-f42a3a8cce35
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740065916; l=1414;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=W0xJ2fNlNVkFLcGpLh+E4eVhmwP7cxluh16zZZ0Z6xw=;
 b=F2vnJ7iVCM6t4pXlKp2MYuz4B3j2TJEm+iU3Ou/aBKHH9T9WBwd5XQkx1/6iSW0IaqhPOb6v6
 ssSaNl1fsElD43Aqoi063+BGxOJx3h8PgYfF3V7dfuIhxq0n/Pgtomr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The default SH kunit configuration sets CONFIG_CMDLINE_OVERWRITE which
completely disregards the cmdline passed from the bootloader/QEMU in favor
of the builtin CONFIG_CMDLINE.
However the kunit tool needs to pass arguments to the in-kernel kunit core,
for filters and other runtime parameters.

Enable CONFIG_CMDLINE_EXTEND instead, so kunit arguments are respected.

Fixes: 8110a3cab05e ("kunit: tool: Add support for SH under QEMU")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/qemu_configs/sh.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/sh.py b/tools/testing/kunit/qemu_configs/sh.py
index 78a474a5b95f3a7d6064a2d3b728810ced095606..f00cb89fdef6aa1c0abd83ca18e7004a4fdd96e1 100644
--- a/tools/testing/kunit/qemu_configs/sh.py
+++ b/tools/testing/kunit/qemu_configs/sh.py
@@ -7,7 +7,9 @@ CONFIG_CPU_SUBTYPE_SH7751R=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_SH_RTS7751R2D=y
 CONFIG_RTS7751R2D_PLUS=y
-CONFIG_SERIAL_SH_SCI=y''',
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_CMDLINE_EXTEND=y
+''',
 			   qemu_arch='sh4',
 			   kernel_path='arch/sh/boot/zImage',
 			   kernel_command_line='console=ttySC1',

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250220-kunit-sh-f42a3a8cce35

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


