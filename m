Return-Path: <linux-kselftest+bounces-8079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01448A6223
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391CEB2393E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF602C19E;
	Tue, 16 Apr 2024 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kV+YHXT7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D850531A76
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240734; cv=none; b=hHnF6l5Vv+TyPHquX2vz8vo91XtqsL5KsQ0Ns/tn9ndI4XD5/q1r6aHndmkbcr33fe+WAsT4hWnrLqr7dBA00g87Yrl2iVGVMlbfsFlDpgsfOLakJhGiuL6n9WFRAK18hgS08YilsJDQqYvj6tSx5tFJxlv+DvyQ/Obe00dnYrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240734; c=relaxed/simple;
	bh=OrJZkCp9eHF1ZxAJ8rMuNC1VGnFAST+dN1PP5sel0qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEoefwJyCHvgvSdFl7ERMZ1JkUj5cmlkkwn0hYgD6KlE7LF/QFES6TV85fU+LtQyzJsKv0rmprSssUqlJd6OdTQXg3S4MxcydvkesqI9ix2NbWoN9IycA8XtpD8dzZNpSQHotlB/CAvwbphIq20uL5jTmJVRw4ukUFYKJgYcq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kV+YHXT7; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22ec890ee96so2512658fac.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240731; x=1713845531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tvr/d8IRX2XgnmTV7aAuFDPQRlgiYIQGREvS8Thb7M4=;
        b=kV+YHXT7jPlUduNrPKM+1lqEy7ATmyY4ea4TfnG5WR6ZXoWv1pauJo9lp460SOR2il
         SCLNEaBvMiLC9EvpVQqbuXMa8Qrsw7EsqSKzbp74hYTVRCt4/97dmSUxdquSPU3wz5GQ
         HKAkytTxvxp0wpCcj43OZvNg4JvnwZ9JOGgI9tjwD6yb1WRjETUMVJCkEYyrG1axYIMy
         aj7s0fXP3TYakzBjgFW8e7DyFFk/f+HQL5v4NXQEKY6ghwJGH25r6WZZo0Frl1wCjJuW
         xlUPdMLdYj6A/vZiY8a497x6q/aeZSqazC9PijRkG5zPx5FNi4OBMATQSBcB1cUFirjc
         Vduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240731; x=1713845531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvr/d8IRX2XgnmTV7aAuFDPQRlgiYIQGREvS8Thb7M4=;
        b=Io0HPS3oQ+VdYHa6VaCmjBOexEGxKTY7DVqguq2B2Z3WiWN9tSFt/wt/kDly3XrnQR
         ZTJrq3QCwFnCzSwbsAetUN8i9GoqXvuEogroRs4FTB2UzbEfviNCYb5Hxnd7jfautJuE
         Y17HoeHgYSQaIpD7qfaDRONsRA5U2UyxkpeJt2u9OuRb4NddAIF+W1Zo0gYmTzXmVRn4
         wQrrO8KZNB7v22SNeY47vuJ1KH/fhMoYDBjPSC1mjD0KLLB89eXB4wzahzKScSijHomS
         +HeZc7+IiqGD9yHu/DRMZYSeVa9hanx83w/sV+Ro3aJhrmhTUfR1cRjuZgGuSGvSU46J
         nRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9X59wVaq9UTQlZs63X/Pzgng1oPB3DI5/gtuu+HLHoxUCyXYyANUBVYiEJw4d0OtdNRn/UUzbHkFzvKLuDiJUHfQ5895QMai0mgfXr0AO
X-Gm-Message-State: AOJu0Yw8wM/NlYJCfhbr1gEzod4GZuBOUOl40E0J/3ONq3YRAHTNCfQg
	l1Qyw4mzCQ4DfAGUsvX2dr49lsIVbOBrOMZyzBYajmOl08cfO58ykMA4aG4lyxQ=
X-Google-Smtp-Source: AGHT+IFq4BNm3mLRC/WM/9QYRuY+sfHR6HrMX1F3oV0LUhNrv3OMPXv9J2yt47Qi/ndOFFkekup97Q==
X-Received: by 2002:a05:6870:e981:b0:22e:f43b:a3c8 with SMTP id r1-20020a056870e98100b0022ef43ba3c8mr14949055oao.0.1713240731048;
        Mon, 15 Apr 2024 21:12:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:10 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 15 Apr 2024 21:12:03 -0700
Subject: [PATCH v2 06/17] riscv: Extend cpufeature.c to detect vendor
 extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-6-c7d68c603268@rivosinc.com>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=14179;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=OrJZkCp9eHF1ZxAJ8rMuNC1VGnFAST+dN1PP5sel0qA=;
 b=SyHtpAQ/FyYobxHt3dkbniwWmi0wmqcPBfKUkLuVV/IsxJg9ekZGE/9aq+sITCZMNpA1YiWaT
 KV0OflY7qjMCaFRDkv/0sUuGzlETfEmpMfaIBacFU7ZSwr3xiqVX4IR
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Create a private namespace for each vendor above 0x8000. During the
probing of hardware capabilities, the vendorid of each hart is used to
resolve the vendor extension compatibility.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h                |  28 +++++
 arch/riscv/include/asm/hwcap.h                     |  23 ++++
 arch/riscv/include/asm/vendor_extensions.h         |  15 +++
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpufeature.c                     | 136 +++++++++++++++------
 arch/riscv/kernel/vendor_extensions.c              |  32 +++++
 arch/riscv/kernel/vendor_extensions/Makefile       |   3 +
 .../kernel/vendor_extensions/thead_extensions.c    |  13 ++
 8 files changed, 214 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..50fa174cccb9 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -26,13 +26,41 @@ struct riscv_isainfo {
 	DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
 };
 
+struct riscv_isavendorinfo {
+	DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_SIZE);
+};
+
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+/* Per-cpu ISA vendor extensions. */
+extern struct riscv_isainfo hart_isa_vendor[NR_CPUS];
+
+/* Vendor that is associated with hart_isa_vendor */
+extern unsigned long hart_isa_vendorid;
+
 void riscv_user_isa_enable(void);
 
+#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
+	.name = #_name,								\
+	.property = #_name,							\
+	.id = _id,								\
+	.subset_ext_ids = _subset_exts,						\
+	.subset_ext_size = _subset_exts_size					\
+}
+
+#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
+
+/* Used to declare pure "lasso" extension (Zk for instance) */
+#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
+	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
+
+/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
+#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
+	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
+
 #if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
 void unaligned_emulation_finish(void);
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..38157be5becd 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -87,6 +87,29 @@
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
 
+/*
+ * These macros represent the logical IDs of each vendor RISC-V ISA extension
+ * and are used in each vendor ISA bitmap. The logical IDs start from
+ * RISCV_ISA_VENDOR_EXT_BASE, which allows the 0-0x7999 range to be
+ * reserved for non-vendor extensions. The maximum, RISCV_ISA_VENDOR_EXT_MAX,
+ * is defined in order to allocate the bitmap and may be increased when
+ * necessary.
+ *
+ * Values are expected to overlap between vendors.
+ *
+ * New extensions should just be added to the bottom of the respective vendor,
+ * rather than added alphabetically, in order to avoid unnecessary shuffling.
+ *
+ */
+#define RISCV_ISA_VENDOR_EXT_BASE		0x8000
+
+/* THead Vendor Extensions */
+#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR	0x8000
+
+#define RISCV_ISA_VENDOR_EXT_MAX		0x8080
+#define RISCV_ISA_VENDOR_EXT_SIZE		(RISCV_ISA_VENDOR_EXT_MAX - RISCV_ISA_VENDOR_EXT_BASE)
+#define RISCV_ISA_VENDOR_EXT_INVALID		U32_MAX
+
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
 #else
diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
new file mode 100644
index 000000000000..0a1955e1c900
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2024 Rivos, Inc
+ */
+
+#ifndef _ASM_VENDOR_EXTENSIONS_H
+#define _ASM_VENDOR_EXTENSIONS_H
+
+extern const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[];
+extern const size_t riscv_isa_vendor_ext_count_thead;
+
+bool get_isa_vendor_ext(unsigned long vendorid, const struct riscv_isa_ext_data **isa_vendor_ext,
+			size_t *count);
+
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 81d94a8ee10f..53361c50fb46 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -58,6 +58,8 @@ obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
+obj-y	+= vendor_extensions.o
+obj-y	+= vendor_extensions/
 obj-y	+= probes/
 obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 6dff7bb1db3f..d7a33e017a15 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -24,6 +24,7 @@
 #include <asm/processor.h>
 #include <asm/sbi.h>
 #include <asm/vector.h>
+#include <asm/vendor_extensions.h>
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
@@ -32,9 +33,18 @@ unsigned long elf_hwcap __read_mostly;
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
+/* Host ISA vendor bitmap */
+static DECLARE_BITMAP(riscv_isa_vendor, RISCV_ISA_VENDOR_EXT_SIZE) __read_mostly;
+
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
+/* Per-cpu ISA vendor extensions. */
+struct riscv_isainfo hart_isa_vendor[NR_CPUS];
+
+/* Vendor that is associated with hart_isa_vendor */
+unsigned long hart_isa_vendorid;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -100,24 +110,6 @@ static bool riscv_isa_extension_check(int id)
 	return true;
 }
 
-#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
-	.name = #_name,								\
-	.property = #_name,							\
-	.id = _id,								\
-	.subset_ext_ids = _subset_exts,						\
-	.subset_ext_size = _subset_exts_size					\
-}
-
-#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
-
-/* Used to declare pure "lasso" extension (Zk for instance) */
-#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
-	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
-
-/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
-#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
-	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
-
 static const unsigned int riscv_zk_bundled_exts[] = {
 	RISCV_ISA_EXT_ZBKB,
 	RISCV_ISA_EXT_ZBKC,
@@ -351,6 +343,14 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 		bool ext_long = false, ext_err = false;
 
 		switch (*ext) {
+		case 'x':
+		case 'X':
+			pr_warn("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
+			/*
+			 * In canonical order, the remaining extensions in the
+			 * isa string will be vendor extensions so exit.
+			 */
+			break;
 		case 's':
 			/*
 			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
@@ -366,8 +366,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 			}
 			fallthrough;
 		case 'S':
-		case 'x':
-		case 'X':
 		case 'z':
 		case 'Z':
 			/*
@@ -578,15 +576,54 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		acpi_put_table((struct acpi_table_header *)rhct);
 }
 
+static void __init riscv_add_cpu_ext(struct device_node *cpu_node,
+				     unsigned long *this_hwcap,
+				     unsigned long *isa2hwcap,
+				     const struct riscv_isa_ext_data *riscv_isa_ext_data,
+				     struct riscv_isainfo *isainfo,
+				     unsigned int id_offset,
+				     size_t riscv_isa_ext_count)
+{
+	for (int i = 0; i < riscv_isa_ext_count; i++) {
+		const struct riscv_isa_ext_data ext = riscv_isa_ext_data[i];
+
+		if (of_property_match_string(cpu_node, "riscv,isa-extensions",
+					     ext.property) < 0)
+			continue;
+
+		if (ext.subset_ext_size) {
+			for (int j = 0; j < ext.subset_ext_size; j++) {
+				if (riscv_isa_extension_check(ext.subset_ext_ids[j]))
+					set_bit(ext.subset_ext_ids[j] - id_offset, isainfo->isa);
+			}
+		}
+
+		if (riscv_isa_extension_check(ext.id)) {
+			set_bit(ext.id - id_offset, isainfo->isa);
+
+			/* Only single letter extensions get set in hwcap */
+			if (strnlen(ext.name, 2) == 1)
+				*this_hwcap |= isa2hwcap[ext.id];
+		}
+	}
+}
+
 static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 {
 	unsigned int cpu;
+	u64 boot_vendorid, vendorid;
 
 	for_each_possible_cpu(cpu) {
 		unsigned long this_hwcap = 0;
 		struct device_node *cpu_node;
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 
+		struct riscv_isainfo *isavendorinfo = &hart_isa_vendor[cpu];
+		size_t riscv_isa_vendor_ext_count;
+		const struct riscv_isa_ext_data *riscv_isa_vendor_ext;
+		u64 this_vendorid;
+		bool found_vendor;
+
 		cpu_node = of_cpu_device_node_get(cpu);
 		if (!cpu_node) {
 			pr_warn("Unable to find cpu node\n");
@@ -598,28 +635,32 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 			continue;
 		}
 
-		for (int i = 0; i < riscv_isa_ext_count; i++) {
-			const struct riscv_isa_ext_data *ext = &riscv_isa_ext[i];
+		riscv_add_cpu_ext(cpu_node, &this_hwcap, isa2hwcap,
+				  riscv_isa_ext, isainfo, 0,
+				  riscv_isa_ext_count);
 
-			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
-						     ext->property) < 0)
-				continue;
+		if (of_property_read_u64(cpu_node, "riscv,vendorid", &this_vendorid) < 0) {
+			pr_warn("Unable to find \"riscv,vendorid\" devicetree entry, using boot hart mvendorid instead\n");
+			if (boot_vendorid == -1)
+				boot_vendorid = riscv_get_mvendorid();
+			this_vendorid = boot_vendorid;
+		} else {
+			struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu);
 
-			if (ext->subset_ext_size) {
-				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
-						set_bit(ext->subset_ext_ids[j], isainfo->isa);
-				}
-			}
+			ci->mvendorid = this_vendorid;
+		}
 
-			if (riscv_isa_extension_check(ext->id)) {
-				set_bit(ext->id, isainfo->isa);
+		found_vendor = get_isa_vendor_ext(this_vendorid,
+						  &riscv_isa_vendor_ext,
+						  &riscv_isa_vendor_ext_count);
 
-				/* Only single letter extensions get set in hwcap */
-				if (strnlen(riscv_isa_ext[i].name, 2) == 1)
-					this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
-			}
-		}
+		if (found_vendor)
+			riscv_add_cpu_ext(cpu_node, &this_hwcap, isa2hwcap,
+					  riscv_isa_vendor_ext, isavendorinfo,
+					  RISCV_ISA_VENDOR_EXT_BASE, riscv_isa_vendor_ext_count);
+		else
+			pr_warn("No associated vendor extensions with vendor id: %llx\n",
+				vendorid);
 
 		of_node_put(cpu_node);
 
@@ -636,8 +677,27 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
 		else
 			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
+
+		/*
+		 * All harts must have the same vendorid to have compatible
+		 * vendor extensions.
+		 */
+		if (bitmap_empty(riscv_isa_vendor, RISCV_ISA_VENDOR_EXT_SIZE)) {
+			vendorid = this_vendorid;
+			bitmap_copy(riscv_isa_vendor, isavendorinfo->isa,
+				    RISCV_ISA_VENDOR_EXT_SIZE);
+		} else if (vendorid != this_vendorid) {
+			vendorid = -1ULL;
+			bitmap_clear(riscv_isa_vendor, 0,
+				     RISCV_ISA_VENDOR_EXT_SIZE);
+		} else {
+			bitmap_and(riscv_isa_vendor, riscv_isa_vendor,
+				   isavendorinfo->isa, RISCV_ISA_VENDOR_EXT_SIZE);
+		}
 	}
 
+	hart_isa_vendorid = vendorid;
+
 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
 		return -ENOENT;
 
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
new file mode 100644
index 000000000000..3a8a6c6dd34e
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos, Inc
+ */
+
+#include <asm/cpufeature.h>
+#include <asm/vendorid_list.h>
+#include <asm/vendor_extensions.h>
+
+#include <linux/init.h>
+#include <linux/types.h>
+
+bool __init get_isa_vendor_ext(unsigned long vendorid,
+			       const struct riscv_isa_ext_data **isa_vendor_ext,
+			       size_t *count)
+{
+	bool found_vendor = true;
+
+	switch (vendorid) {
+	case THEAD_VENDOR_ID:
+		*isa_vendor_ext = riscv_isa_vendor_ext_thead;
+		*count = riscv_isa_vendor_ext_count_thead;
+		break;
+	default:
+		*isa_vendor_ext = NULL;
+		*count = 0;
+		found_vendor = false;
+		break;
+	}
+
+	return found_vendor;
+}
diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
new file mode 100644
index 000000000000..dcf3de8d4658
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y	+= thead_extensions.o
diff --git a/arch/riscv/kernel/vendor_extensions/thead_extensions.c b/arch/riscv/kernel/vendor_extensions/thead_extensions.c
new file mode 100644
index 000000000000..7ac934b1f54c
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/thead_extensions.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/cpufeature.h>
+#include <asm/hwcap.h>
+#include <asm/vendor_extensions.h>
+
+#include <linux/array_size.h>
+
+const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[] = {
+	__RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR),
+};
+
+const size_t riscv_isa_vendor_ext_count_thead = ARRAY_SIZE(riscv_isa_vendor_ext_thead);

-- 
2.44.0


