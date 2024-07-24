Return-Path: <linux-kselftest+bounces-14175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683093B76B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9371F21915
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB66171E69;
	Wed, 24 Jul 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="n51v74Wm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF465171E45
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848464; cv=none; b=bw46zxjkJljlme30ed7eHhi5m+ysxinnZ2xwYPmy1OLlnYI91NmYYI7ECJsn46MfAlVvLP0uBFObkV/vRWuyr6aZaAhxE1tniMh3JnNpcd+Kv81KzLL2xvEpEkrA68aI15GYtcCm6SvWMZyPAGA9oR7v+vsh7K5cr+IrVQylOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848464; c=relaxed/simple;
	bh=Q43N1SzZuoUs9V4odMuGerUQldvvnFwkFkU8sDA49Kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHN/FO0FVLVJqYXlFL9qZEIqS4RUP76ktQGu0Fny3tbx9SpbXCjgiDN3ftH+glQ6hfL7zbHrNq76UIhlX+uj8nkkxMMdqdMAZ39N9DeEnjt5HkYtN9MQJIJEUuHjrV8uHMHJUKzKYH2r5MDjk6rd3ZMjnIM3fyCjTmRNsz2eXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=n51v74Wm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso101954a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848462; x=1722453262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiHGX7WHPh3w54Ho6DWi1K3xQlJp39Igxk9RjCMoL4E=;
        b=n51v74WmRfarwHBF+2aK1udmAApuvyBE6xH7a8op2R3B/i9xQmUv6yCzYm3g1EAFRR
         9w/1vZA14TTDhGHumBC5W91M/EZ1+Q9JJhIXwmqTBXzhHwkGONaNj8IDkQZXHBD6XiZf
         V1NVvOfENJ6/bClSqzrtZPQ1+svlNWpSHu3XtU2Eo7fF1y45nExnmlc7M96bOzHa/Xkh
         u4uEi5ewfRGEO6x80rfn7DN1/rHhHgXpIIiR7DuhnXzRIsdsSNZBzBadhUZNj7FTyg/t
         WEH9SSTzsDTQnq3yGtRvxQs3dCYw1v9/ppOfGua+J0UzhdJFkF74M9x/ICRkgpe60Lh0
         rS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848462; x=1722453262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiHGX7WHPh3w54Ho6DWi1K3xQlJp39Igxk9RjCMoL4E=;
        b=b9D0QQH6N29cPtYrvFW17vKMHLFYLTV8f+7HHIVvRahqnw6Lxqx3RXzht2OdH43uyI
         2uGAUNsfnd5h7jD6SBWtPpy6v3FNU6Z2XfzvUw6LLM69hxGA8GYh40IzYN/77jKbr4Xq
         jF4MQGOyf2c/gKRZJWu90DcXJrr9nWNzbwUP33F85kz0PhUQ9MGVR+5OjX4FYhthRAXd
         yHS6gEU9eFz6Ic9+8bSMMZXyb9FI0OV0NZLj5FnTderbDVd/dMpBQFYsoc3P9/Glz3Zn
         jGOL0YQBbdc/5lSeFF9uYm50jQCVJirBUhlnplGDC3JkDou8Os9LbRIZmhG2RhiqawO0
         5QEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVianM8cZgNFEeIuXlqiSCmwKJxePhj+yGX/QLqLtqrgzewhqilqDyJaQPWO4UHzLmDsjiKQzA+PBreuXM+VxdyPRy5/l0YoxveX6VowyhP
X-Gm-Message-State: AOJu0YzbWjOg4zjDASD1ZZwapFUpwq1H7abmXM4RS+U6f3ZxzsULIaaj
	S9rBA2rSKf+2FATWtYnOSfgZqMcGXhLehEAzqYk41TLasgwUKVx/qrTnbD9VwRU=
X-Google-Smtp-Source: AGHT+IG955xnQ++cycOGy/4lGCtVi1mHpHdoZXI9DWK2KiUNx5Swc6Lx/8OFrC5thyzFSQE6If8Cag==
X-Received: by 2002:a17:90b:1d88:b0:2c9:63e9:845b with SMTP id 98e67ed59e1d1-2cf237727a6mr530036a91.9.1721848462382;
        Wed, 24 Jul 2024 12:14:22 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:14:21 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 12:14:01 -0700
Subject: [PATCH v7 10/13] riscv: hwprobe: Add thead vendor extension
 probing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v7-10-b741910ada3e@rivosinc.com>
References: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=7556;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Q43N1SzZuoUs9V4odMuGerUQldvvnFwkFkU8sDA49Kg=;
 b=kDDf9EyNTG8LGK6m32O8+yYGquBqGSEnrr1we1fCWYFKsds4YnaaNqNgtbgIvigH26qVT+73t
 aV2sIfMjRfGBj9fOgSTg/hn36rkhDM72oUAxh93LNBzEk+BJklFRbXH
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0" which
allows userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR
vendor extension.

This new key will allow userspace code to probe for which thead vendor
extensions are supported. This API is modeled to be consistent with
RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
corresponding to a supported thead vendor extension of the cpumask set.
Just like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program
to determine all of the supported thead vendor extensions in one call.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/hwprobe.h                   |  5 +--
 .../include/asm/vendor_extensions/thead_hwprobe.h  | 18 +++++++++++
 .../include/asm/vendor_extensions/vendor_hwprobe.h | 37 ++++++++++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
 arch/riscv/kernel/sys_hwprobe.c                    |  5 +++
 arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
 .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 19 +++++++++++
 8 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 150a9877b0af..6148e1eab64c 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * Copyright 2023 Rivos, Inc
+ * Copyright 2023-2024 Rivos, Inc
  */
 
 #ifndef _ASM_HWPROBE_H
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 7
+#define RISCV_HWPROBE_MAX_KEY 8
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
@@ -21,6 +21,7 @@ static inline bool hwprobe_key_is_bitmask(__s64 key)
 	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
 	case RISCV_HWPROBE_KEY_IMA_EXT_0:
 	case RISCV_HWPROBE_KEY_CPUPERF_0:
+	case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
 		return true;
 	}
 
diff --git a/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h b/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h
new file mode 100644
index 000000000000..925fef39a2c0
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions/thead_hwprobe.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_HWPROBE_H
+#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_HWPROBE_H
+
+#include <linux/cpumask.h>
+
+#include <uapi/asm/hwprobe.h>
+
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
+void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const struct cpumask *cpus);
+#else
+static inline void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const struct cpumask *cpus)
+{
+	pair->value = 0;
+}
+#endif
+
+#endif
diff --git a/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h b/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
new file mode 100644
index 000000000000..f28f31e19cda
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2024 Rivos, Inc
+ */
+
+#ifndef _ASM_RISCV_SYS_HWPROBE_H
+#define _ASM_RISCV_SYS_HWPROBE_H
+
+#include <asm/cpufeature.h>
+
+#define VENDOR_EXT_KEY(ext)									\
+	do {										\
+		if (__riscv_isa_extension_available(isainfo->isa, RISCV_ISA_VENDOR_EXT_##ext)) \
+			pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;			\
+		else									\
+			missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;			\
+	} while (false)
+
+/*
+ * Loop through and record extensions that 1) anyone has, and 2) anyone
+ * doesn't have.
+ *
+ * _extension_checks is an arbitrary C block to set the values of pair->value
+ * and missing. It should be filled with VENDOR_EXT_KEY expressions.
+ */
+#define VENDOR_EXTENSION_SUPPORTED(pair, cpus, per_hart_vendor_bitmap, _extension_checks)	\
+	do {											\
+		int cpu;									\
+		u64 missing;									\
+		for_each_cpu(cpu, (cpus)) {							\
+			struct riscv_isavendorinfo *isainfo = &(per_hart_vendor_bitmap)[cpu];	\
+			_extension_checks							\
+		}										\
+		(pair)->value &= ~missing;							\
+	} while (false)										\
+
+#endif /* _ASM_RISCV_SYS_HWPROBE_H */
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 8b8f6ac0eae2..73ab65ac8c55 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * Copyright 2023 Rivos, Inc
+ * Copyright 2023-2024 Rivos, Inc
  */
 
 #ifndef _UAPI_ASM_HWPROBE_H
@@ -81,6 +81,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
 #define RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS	7
+#define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0	8
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/include/uapi/asm/vendor/thead.h b/arch/riscv/include/uapi/asm/vendor/thead.h
new file mode 100644
index 000000000000..43790ebe5faf
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/vendor/thead.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#define		RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 685594769535..4cecdb0249a2 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -14,6 +14,7 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/vector.h>
+#include <asm/vendor_extensions/thead_hwprobe.h>
 #include <vdso/vsyscall.h>
 
 
@@ -237,6 +238,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		pair->value = user_max_virt_addr();
 		break;
 
+	case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
+		hwprobe_isa_vendor_ext_thead_0(pair, cpus);
+		break;
+
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
 	 * call, but get their element key set to -1 and value set to 0
diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
index 353522cb3bf0..866414c81a9f 100644
--- a/arch/riscv/kernel/vendor_extensions/Makefile
+++ b/arch/riscv/kernel/vendor_extensions/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)	+= andes.o
 obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead.o
+obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead_hwprobe.o
diff --git a/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c b/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c
new file mode 100644
index 000000000000..2eba34011786
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/thead_hwprobe.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/vendor_extensions/thead.h>
+#include <asm/vendor_extensions/thead_hwprobe.h>
+#include <asm/vendor_extensions/vendor_hwprobe.h>
+
+#include <linux/cpumask.h>
+#include <linux/types.h>
+
+#include <uapi/asm/hwprobe.h>
+#include <uapi/asm/vendor/thead.h>
+
+void hwprobe_isa_vendor_ext_thead_0(struct riscv_hwprobe *pair, const struct cpumask *cpus)
+{
+	VENDOR_EXTENSION_SUPPORTED(pair, cpus,
+				   riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap, {
+		VENDOR_EXT_KEY(XTHEADVECTOR);
+	});
+}

-- 
2.44.0


