Return-Path: <linux-kselftest+bounces-27595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E052AA45D7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9C218917AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7F21C194;
	Wed, 26 Feb 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CGbWN4J9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhuZL5sz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98421A438;
	Wed, 26 Feb 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570318; cv=none; b=s5Gdmxl46hQ1E+KZwuTS2o/kJ3Iyjy23ikFfogiwOOWFT01Da4XWrs2sSFnSRiUBkRD9flvXtySmgsHX7oh3ZR9/tm8eIsLmYQnaZpB/UtiX8nT2hmP8Po3a/nUFH5GU8gdNfUKKQS/ETKLuuYZdeOR5nWFhbdKyyOJPTdQaa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570318; c=relaxed/simple;
	bh=2r9nJga0gN/RLQi1JecZ+vj+TP6CqTjTd0CFYa5Ukqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svr0RSh5BMEGWQlyOgoPmh0oqx+ptbGEIehJqXEi0Z/R/XBqN6pXQN5CbI4FDofOaGp57hjHZRN9W18dhl1YWD372UuPXmvql9qYbaRGD4nT2agOEd5JJbiVyWbfv6aH5DMvOXWag9jedScIhCK47DFvmUoV57aeMH1L65HLE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CGbWN4J9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhuZL5sz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tIB/mKrbgkR1FZXRW2I7qFNU+LB59/l0MfkLrZgBDg=;
	b=CGbWN4J9YC9gQ8VFg1RJ3j0QwS6+MDp5+Vg1d0K6/xdUSk8P/5jVl4lkjzjYeg21Ln2oPc
	NRXcQIZIMdiVDpEafvYjyLG/0FbBTHyR1Qywp0XTlu4TgIjzJGBdWCJy+q6e2qR03dLHR2
	qIVm5mobIHK3AuxVd0RGLCSqqxuHy9Mnu79eP5TkQ3YjiSLl7t8S/PONktXMtxRh8Sxjy4
	utFqh7lW66yJAWy5kT/08Uq0PEAehK4rl7s+1HipYyU47H8CdJNCIxFU2HVBlzXmioHPea
	kyNhxm7uOrHkd4OwbXT85jkwWFGGEi8MpL9R7AszlAK6DEhg3uqwUIOsRZXHqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tIB/mKrbgkR1FZXRW2I7qFNU+LB59/l0MfkLrZgBDg=;
	b=bhuZL5sznPwFLNCRTYT+wLH304bB/beR5NLTZXOoHPC1GpGXUdMA3ElesLimSaaplKYvoh
	/8ilpqRBW8p6ieCA==
Date: Wed, 26 Feb 2025 12:44:48 +0100
Subject: [PATCH v2 09/16] tools/nolibc: add limits.h shim header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-parse_vdso-nolibc-v2-9-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=1273;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2r9nJga0gN/RLQi1JecZ+vj+TP6CqTjTd0CFYa5Ukqk=;
 b=UR2y1fGcblPNg0O5kcvnoNHTSKtyj3XWN7IytHuyCM71JEFzSt2H5e99rPFC0rsb8HCCsc+cq
 XvTFkUQ6lAbASxWR1nevyAGKs9n+hfYs1eH3HfjincxtnoNj0Zj8bNC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

limits.h is a widely used standard header.
Missing it from nolibc requires adoption effort to port applications.

Add a shim header which includes the global nolibc.h header.
It makes all nolibc symbols available.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/Makefile | 1 +
 tools/include/nolibc/limits.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index a1f55fb24bb38c1f49c653af5825e8bcc569a56d..c1299a053145786da89001a5f95f5527ffbe2fa4 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -30,6 +30,7 @@ all_files := \
 		crt.h \
 		ctype.h \
 		errno.h \
+		limits.h \
 		nolibc.h \
 		signal.h \
 		stackprotector.h \
diff --git a/tools/include/nolibc/limits.h b/tools/include/nolibc/limits.h
new file mode 100644
index 0000000000000000000000000000000000000000..306d4141f4d245ca3f801f451745540b0f7294cd
--- /dev/null
+++ b/tools/include/nolibc/limits.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Shim limits.h header for NOLIBC.
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#include "nolibc.h"

-- 
2.48.1


