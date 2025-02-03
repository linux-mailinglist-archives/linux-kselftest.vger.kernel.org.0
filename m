Return-Path: <linux-kselftest+bounces-25546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3801CA25563
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971D83A04AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC8200B95;
	Mon,  3 Feb 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QKMTSHwC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANpDWJuI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085831FFC4A;
	Mon,  3 Feb 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573528; cv=none; b=Stdz6w+/4z7YGuCwZFPO3I4+dBAvGZTNHoSnQo3SlPzFE2uBWCN+OzvDON93fA6e8IJ45X/zQZbYY8i7Z/cNCdkltbK0eyu2XX0J6t6HFCl982mdMp3kgARlD+4j/q9epBfxruGX5UnAHK+nrnbKbEp1jtC56Gb/jpV/FtgMspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573528; c=relaxed/simple;
	bh=NpOQuxLd7KblcjFPnaDO5YLxwLL0GxVqW0hZLzvIMGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cb4EKfCTw+HyzJVWgIxCd0/Cta500iJrcgNBwXSYdxgUTxH53ftZXENdfalQE0DIfV7f8PaQCRyW0jP3JCph1mvLvGQjwbXQv88aKGzcMX0bNiPqCw9kBr75EXBR7KXNkMgWBRmgjnRGSnnm3PC15CuGFyeS6drcRuYsN0jooTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKMTSHwC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANpDWJuI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOyFPIEiH7gm2OvTiVE+dNl/7Ao4pkwSxETN6MXhZOM=;
	b=QKMTSHwCQSP1GFrALXRUd1pr+I0o1ken7IFPwr5hwCqzVi5W6OAH6JEzSoS++jlQNCQqtQ
	00KSRzsq/zQbFz9eJiGM3N3QvBCwPu9xXoRt28OcagWfzRCpaeaFZ3lgKiQlXeFj/fbf1V
	DPF7gANzIcMfKhFc2IHT7o0pWk+tdhx0OvkmPAAajMUw7iyIP9rD491lyrpvnpz12e2kNo
	mrEdWAM30mWVtaHFrSFuuYdSsHHzA0+kM1USqBmE0DX7S5NbFBX1eZFxGsJZSTaefZfjfx
	OfXPqMO4W6RgERpxeK/11QmwDNm6Drfs2txWKiz7gd/vZ4KAtd64gHVgVl9GPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOyFPIEiH7gm2OvTiVE+dNl/7Ao4pkwSxETN6MXhZOM=;
	b=ANpDWJuIpNr8cNesKHQJBMRYvjmuj39qzxjgbY6Dw12se5Zf4/l2uhcKpcUNWox9CHNc4z
	qdBmoii2TPSVlHAw==
Date: Mon, 03 Feb 2025 10:05:12 +0100
Subject: [PATCH 11/16] selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-11-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=1432;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NpOQuxLd7KblcjFPnaDO5YLxwLL0GxVqW0hZLzvIMGU=;
 b=EVrIy1GANEM6B5AcEyRo8lV/ac+2X2NNYAMOZ2NnAil0mfCdvESkLcjnYXyGzAHMomYPMYrjZ
 9nl+mXfJMzCCzL46iUgHOKGLJ7oGfv2ZDai+6a470OId6MfhWN/AzaG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To allow the usage of parse_vdso.c together with a limited libc like
nolibc, use the kernels own elf.h and auxvec.h headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile     | 3 +++
 tools/testing/selftests/vDSO/parse_vdso.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 1cf14a8da43803249f72fe1b09689c8834806986..bc8ca186fb877dc11740c37f1e07e45e84c2ae92 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -19,6 +19,9 @@ LDLIBS += -lgcc_s
 endif
 
 include ../lib.mk
+
+CFLAGS += $(TOOLS_INCLUDES)
+
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 3638fe605e80ca41b29d43c6ac452964eef35d56..200c534cc70e2c2381fce3be5c0ebe4cb5675e84 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -19,7 +19,8 @@
 #include <stdint.h>
 #include <string.h>
 #include <limits.h>
-#include <elf.h>
+#include <linux/auxvec.h>
+#include <linux/elf.h>
 
 #include "parse_vdso.h"
 

-- 
2.48.1


