Return-Path: <linux-kselftest+bounces-35826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A642AE95E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19934A653E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354C72609DC;
	Thu, 26 Jun 2025 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NwnELFMT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NljzIya3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F325E461;
	Thu, 26 Jun 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918229; cv=none; b=Eh043zChRNXgufBZatWMlhW5m5GbG2yUsJKoPNDNn7gFEmxIqQ0cDzNWxVfyr5eC5OTpi/pKNKC6RZWzuYqQij5/GixLWyYVP+R6FqWDy6PG3cID8w6lypFVkUDOSMQVRW6QyBPeYGE5a5rI2/KgwfYRw+ZBTHjDNC+0QB4MhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918229; c=relaxed/simple;
	bh=zShZPUvddV04nP7ePLLt+JfO552xNTacDebxpq2ayPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sd6KTCHAwrz44OXfaKL92K1UcTWpFgmsNnaqGAsLer8txbeRfqw5eFL4AgyUQFDOnWtI+bX9shA1jxEoRYp0m7aQX8y/jDksAIdlQeMdkqS6UtswvcawbiFaAOqJNrLH9l6kc4CpaXD0lXDVg+XJXjv3hFb0nwLMUcxi9wNH17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NwnELFMT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NljzIya3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqEciMN5D1yrpF8pzbxqPFErBTdvvekVDOGyFqtNWdk=;
	b=NwnELFMTLd09ua8co1MShJVkTu7deYuOOcKmawcoBjF4BDE64CWixas+6ZQnMfn5EnOCmg
	e0WvA4OM+pQ1RNp35Ug2TZrO88/Gpm1m1QVu/0FcjUWx95k3XPyJilAis2f6Iok7EDcelu
	Yll5CxqBorEuMI6dT5/BbLFO7V+eEU+MTye/eTng4rfKNzVWZoAfV4rOvf6z+65ZCmw18L
	5mkIABq2sjRD8fs//QfeK9kLltiK3qCqt/DtdMxd3ENTk/Dm2PIedkYUKL1p5C2/Lfnz6O
	vGtpjy12pSNVIgO3WqB2Hvz8WCARiP/mKSJcuXWAkudZxxl1Ldky/ItJtAB/uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqEciMN5D1yrpF8pzbxqPFErBTdvvekVDOGyFqtNWdk=;
	b=NljzIya3lvX5KxYMIRyiveDbqLyuMTkYirHvFIt5ODhCM541bWLQl/twTpO34OyPn5gIel
	sYRtqNAIr1YwcjAA==
Date: Thu, 26 Jun 2025 08:10:19 +0200
Subject: [PATCH v4 11/15] kunit: qemu_configs: loongarch: Enable LSX/LSAX
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-11-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=994;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zShZPUvddV04nP7ePLLt+JfO552xNTacDebxpq2ayPk=;
 b=zy7JI9OBbmKHVmTKVnWN5D+eAwUIwzJMor3MP3kYnjtE9qfoeMBVikE1fsvrO0omyL5AihCmI
 2U1jHW7CtA6Cx+nlT8XSDuZVmFViFDA/S/1DkcNGAg+mbXNp+1HLSxo
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The upcoming kunit UAPI framework will run userspace executables as part of
kunit. These may use the LSX or LASX instructions.

Make sure the kunit kernel can handle these instructions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/qemu_configs/loongarch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
index a92422967d1da9f1658ef1e80d0d7365ddbae307..1dba755284f11ffc94d8946105b0cfa49cb6f604 100644
--- a/tools/testing/kunit/qemu_configs/loongarch.py
+++ b/tools/testing/kunit/qemu_configs/loongarch.py
@@ -11,6 +11,8 @@ CONFIG_PVPANIC_PCI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_CPU_HAS_LSX=y
+CONFIG_CPU_HAS_LASX=y
 ''',
 			   qemu_arch='loongarch64',
 			   kernel_path='arch/loongarch/boot/vmlinux.elf',

-- 
2.50.0


