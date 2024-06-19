Return-Path: <linux-kselftest+bounces-12285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3068C90FA0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 02:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDDD286C7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E916B3A8;
	Wed, 19 Jun 2024 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Dzt8S+DY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3716631C
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841471; cv=none; b=W3x/Tk/WqP5jpGRfXnfzkY877uF1eMrK/VrBVh0uMO/3vGeTxHENE37PBhkURb4iDzNG0KcMd0/GdxjFbCnbbdL2pyoKOnXtY5ocPo88W6hjya+G7WG2deYDopMdTgyH3RjR7GH2qxREuimusjEGbDcVqfs+XD9KgS8q+a6Oo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841471; c=relaxed/simple;
	bh=MJcuPu1Xrk59xmba9dYaXFtOSeLiBjz09hSPCDmyv0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1MBMx79UOyy/lDuhjHRqemqVy14GlszDXukPVlaKIJ8kIV6WhOAzZl9AZQjse+mkYWr7M3mXWM6VfOSzrVtwo9/Ep7TI0C7Od5yndLZNnTV4PyHhFBGpm5ebfbo7PyuHPCRHiWeT8DHmfeOLkaHO0ppS7PmlWs9T8qPXNFyxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Dzt8S+DY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f717ee193fso2334555ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718841468; x=1719446268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI35anZnoFlIbEmDoRLqvd6PHCWTxcZGYEGh3FOCrX8=;
        b=Dzt8S+DYlsha7pihkUn8A659fc9ZaydqVqDS0+tFkwNa6lR765QE8CraFpd5JWlIVC
         U9uf/n6W7XUrshIcFtuYc70essqokWwqE2+0VVgI1MOMNIQafncImcp2D2lqGkpC3bjW
         nXeNxTNtFNH88sStBNsACZdMZkuNSV7K928daYq519aXWDcMbM4DM+K4hv4sN2w7JoGb
         Wd51KzA3s3P0uSStRVWylf8PYvGL03/xKSEtZF5aanxF+KaRFNAAHi+qHjfI6/u1fxsH
         l/grtnfSroqmMZIwP4sozQWwAHxDz+XgFIi870DzioH+OQUgggPiKCeZNmn1+i2ToWTI
         ZGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841468; x=1719446268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI35anZnoFlIbEmDoRLqvd6PHCWTxcZGYEGh3FOCrX8=;
        b=qtmSIR99H1n081q1UJDAnhlrO3YjNsr/2kW8FyacPR8RTIPUxQjrA8XsPtPmvirqur
         V385HoeXXKkavJ7GURXCs5btcAThsJjaHpln56qESgpdEkdwtfflMI+93IRe/xInQ5Kz
         53oBZQb8lviZnRH90fRk1D1HMXgwzLDEz9Nm4sLxFNW4xZQEnNr65z16R2VsFFBxsF7o
         P+Zon6LSRE3GdHQpvkm91Vx6SXIM7TQDhYKtls5gohMQQb2SOC2Ft3Y2dqZZeuyBMlD5
         vjcvmPToW7sOqDApiRdExIlH5lxN43x7tx6xe00N0JsbqTeXbpJbacQFeg2QcuV/fHxt
         9q2A==
X-Forwarded-Encrypted: i=1; AJvYcCWTsWvKpy5/VHm179CdXWFtQiIJpuEhRc/suDKF2jq30kuSvNM7wvf9MzFJfRJJLad44weSCExDnXbjbMfO0nq5oVDpHJwivZsLB0qQ6F4O
X-Gm-Message-State: AOJu0YwZNY5PIgHsq23tvCkYEQqt7H4ItDc/oagoX+8apNWOWGeY9Mgs
	7mvog7XjBYndxigfFidmClUF3yRa/6XATwkR0uMajHsgFwsDbuqDxGlSs1ZQKDQ=
X-Google-Smtp-Source: AGHT+IG3HhUlmHko1j4MHN+jlG1e5VcHzEwdt4tue/YDx3t4OiXOKWkvLGqP+ihvhx4vq1g/Zuq1rA==
X-Received: by 2002:a17:903:120d:b0:1f6:e4ab:a1f4 with SMTP id d9443c01a7336-1f9aa3b12d4mr47451475ad.12.1718841468298;
        Wed, 19 Jun 2024 16:57:48 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e70ae6sm123620745ad.71.2024.06.19.16.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:57:47 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 19 Jun 2024 16:57:23 -0700
Subject: [PATCH v3 10/13] riscv: hwprobe: Add thead vendor extension
 probing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-xtheadvector-v3-10-bff39eb9668e@rivosinc.com>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
In-Reply-To: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718841444; l=7564;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=MJcuPu1Xrk59xmba9dYaXFtOSeLiBjz09hSPCDmyv0k=;
 b=mwil4Vts99hbPmemrcr+zZd+TDF00PXyOELcJ/8fLW4UHfi6pc/665f1/4Tq28mCvchBwcTmb
 o4e6lwcYwriA5LLj9IYobRjdyzHm2ZP68HdL7UDNSuGVOOkaxOUri+C
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
index 630507dff5ea..de9fe279f02e 100644
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
 
-#define RISCV_HWPROBE_MAX_KEY 6
+#define RISCV_HWPROBE_MAX_KEY 7
 
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
index dda76a05420b..155a83dd1cdf 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * Copyright 2023 Rivos, Inc
+ * Copyright 2023-2024 Rivos, Inc
  */
 
 #ifndef _UAPI_ASM_HWPROBE_H
@@ -68,6 +68,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+#define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0	7
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
index 969ef3d59dbe..e39fa70083d3 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -13,6 +13,7 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/vector.h>
+#include <asm/vendor_extensions/thead_hwprobe.h>
 #include <vdso/vsyscall.h>
 
 
@@ -217,6 +218,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			pair->value = riscv_cboz_block_size;
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
2.34.1


