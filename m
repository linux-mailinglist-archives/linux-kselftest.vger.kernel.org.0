Return-Path: <linux-kselftest+bounces-30237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E01A7D8D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675903B5CBE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CC522A4FA;
	Mon,  7 Apr 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeR3JcY5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uz6DDcsS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F022A1ED;
	Mon,  7 Apr 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016288; cv=none; b=Vc7889jrsuOEe1azpzI1GvW0X6I7gdL8iepvk8kEHLuy56ELTo5kYxZ9wlTvj7g73WCU94fG7G4cuFEe5EVfQaxOMNILKbRjEpqdM1hD0vZOs0yh0uqNzetaqSt4vC1lMyBRGI0wQlB4d1P/wCiucS/+xSvbpSsjsMmsgXz1/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016288; c=relaxed/simple;
	bh=W0xJ2fNlNVkFLcGpLh+E4eVhmwP7cxluh16zZZ0Z6xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CFPheaPlRIMTh54vsm16AOKLB4Zc1AaZG9ztOECdSsGWMnG2wEiq3xMmWF1yKghvnH1Y7yh9XYfDAeehKgm3PWqP0JqNSq07pSqGcT+sFBeqeLz2EOhzz7HsXxlVH7De3MA0vZSoOGC0CXw4Kh1VGZ1kI9VLJshBzx6lY2C6urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeR3JcY5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uz6DDcsS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744016284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=79XZZfWENd7BMuAi8YpxWCwNIy5HxTade1ws5Y2S384=;
	b=YeR3JcY5w9Dxy4XioO6gnoUuJezM4dYLizyyWsy3F8xFlvfsA6k3mxAhXZBN2eFszCEI1A
	dQWbzO50HPAzKqGcFyWsBsAWzCKRuaUY3RXY9ayEPsl/LolQIxLYTFMYPgcNKEFmhMvYYZ
	CNTUGBengi0gAIZIzz4V8hJlVXyMgShVGRu8d2AHZcVhhqvj376TceWahNya8B/cc0vgtC
	GwdMPLvpREXr0mFXhP/VdjHjEgzqou2/A/z2AMdgEjg6jX9xSnIvZr3hv8/kL+vDuv5vgJ
	PrxUmBaZfneHezJSfjB2EnypR7lflQ/IragM3AuxSh2+xP3BnhephTXp/bFExg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744016284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=79XZZfWENd7BMuAi8YpxWCwNIy5HxTade1ws5Y2S384=;
	b=Uz6DDcsSAFOFL3oKmJwVb4iWxk7YPqrNxqhwco9/R0rXvv/kNYgr838JQxWg847QNPcT9w
	d5+2qTIkwQU+0KCA==
Date: Mon, 07 Apr 2025 10:58:03 +0200
Subject: [PATCH RESEND] kunit: qemu_configs: SH: Respect kunit cmdline
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-sh-v1-1-f5432a54cf2f@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744016284; l=1414;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=W0xJ2fNlNVkFLcGpLh+E4eVhmwP7cxluh16zZZ0Z6xw=;
 b=mbwbfTDwcATHjPaRfrjlyDUkTSunUTdkDL2Mu57L/eBuIHeaXiRt01WHN3O9m4W5LeigST1VW
 YTh6rZ4e/+PAsng1mueB3TmVtIfeMdYtkawj8AbNnofr02h1rsfcnrU
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


