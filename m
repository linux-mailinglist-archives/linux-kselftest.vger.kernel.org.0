Return-Path: <linux-kselftest+bounces-8950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56A8B412C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AB5283502
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82468364DA;
	Fri, 26 Apr 2024 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Lt9glrdf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A993BBD9
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166978; cv=none; b=DeyHWPyb3utKpcGYS5j0wFDgBJx1v08QyAR/1Xj06J2N6JbRvIYYeAbIHefDlCTznTxQYKW14jvPxe/9GwYuJlLnJjA/ddAF3SJdIPazZtYenjAL3HUnGnkvQmI6T1PAOnEMwruyvefW4RvXGSt0bLEZuNqJ7sndici9WujkFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166978; c=relaxed/simple;
	bh=09FoQQvMmYAjMdlIq0r3A74yPdJyvka4ZNaXXN1gwhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMKO/ePN3CKZ3SCxC2u27sJ7bkHjKQqrQ7Gi6z+gABMeZESoPEKAY9DuTz69pkR29PEkmnJPtCYgE/SaSjUslbX23vuoj476FHFNQjFQXDKel0SYsShyHZezo+kbK2yKZ/DUZmqXbG0RzsXANCKkT3WxqHCW86qG41e7QNNQ5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Lt9glrdf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eab16c8d83so20869125ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714166976; x=1714771776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tynn/VhAoLr4352UcdKkqqv3jQuef0XfxIBizQBP2jc=;
        b=Lt9glrdf6lDTT+twk4+NxIi7nkLtpp8WF7LhC5jgxqGacue92QGWMt3H7QVb3B91uW
         gBt8BcbSslEsoLxYnrb2GAoAhmq4R0DIEUHSDAMUc0HPVyvGJWFSjk6ydcmLWvV1WUGC
         WfAF9bYhwlu93mXQmhNJC778UWD6B17T4mLRzXzsTnYUuZc/iGFi66U0NRyd9ynMRro6
         fQQlCGLEthhw1r+YzRgf1meExu28r3W7hkQX0meKctEryE2FJ2Q+uWpMbV5l1kwPq4Hj
         UynsgGbNVfzrv1Et/hcVdqqEWY/pviGLjFbPdR3ww24pL8PyeFuE6eBUimvpFdvxMsan
         xlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166976; x=1714771776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tynn/VhAoLr4352UcdKkqqv3jQuef0XfxIBizQBP2jc=;
        b=inG0oH/vu4Sijj7o9J0/yZ8yTqzZ1huz3d7LPBitI8FlcBNt+EiuaJSPLXZwpFsBWt
         KHagproimJNXXOsNThUHhZAerkp2bxsFUxLR3tjCdZAYUqKBCKmJqRTGee1QOROVLXyb
         OkhL9HmCakddsHGf/fIetGkjSTmopv5cY0gR4vydWqa2/vuPi97vY/lBxWGPJ1xlShat
         uWctehDDpkZIi83Y/73AbxxABteKYldCUw19XsI52tHw9H49VogV7t8kk37O9TvXpdY4
         PNxpMK53nXaBFHYVVgKk0ZJnrX3QnS0oa6690xGDmbc+fBEbz/R+pTCIWOt8H8opwd6A
         86XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVntbMPpsCFcrk192pte8ygTGMGLWK3YDnhx+gK4Jo7raCPLLMyacTS7NXVmLYxPTFTkaQAr7VsCMQ8Ukdv7QmTbkvJyu2TtmvQjX6eYSFO
X-Gm-Message-State: AOJu0YxLP7xvt+Ex6VxKX720l37Y3lZVmO6QZwabpSuTH9SXPJvNEQ5U
	dMpP5CwGw1oqO3BGnrSk4jk3IbNz2/S81CzeXdIi2lfBv2FqoGqMbMfQqAZzShew02Bf7hJ0s3D
	q
X-Google-Smtp-Source: AGHT+IGaVFi37a9HsDPwqa4crYCbhAH3fvz6rsUgiDuVts8JZ02NAFNG+goaQwAD9lAA7GW8Y7zYuQ==
X-Received: by 2002:a17:902:9f88:b0:1ea:42d1:1421 with SMTP id g8-20020a1709029f8800b001ea42d11421mr3810323plq.68.1714166976001;
        Fri, 26 Apr 2024 14:29:36 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b001ea2838fa5dsm7226720plk.76.2024.04.26.14.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:29:35 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:29:19 -0700
Subject: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714166962; l=12348;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=09FoQQvMmYAjMdlIq0r3A74yPdJyvka4ZNaXXN1gwhw=;
 b=XuI5S5cFI4j34lwYWezVnMqgKB6A9CKiQH15Gf7BajZ/dI2boXBEUouLhh4VevF9Ho1Tye18h
 8Jj3j5qpqarDMrk2AP2ufLsIZkNTQ+Ewg0a8602yodW2HIkTo7oUjlb
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Separate vendor extensions out into one struct per vendor
instead of adding vendor extensions onto riscv_isa_ext.

Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
code.

The xtheadvector vendor extension is added using these changes.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig                               |  2 +
 arch/riscv/Kconfig.vendor                        | 19 ++++++
 arch/riscv/include/asm/cpufeature.h              | 18 ++++++
 arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
 arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
 arch/riscv/kernel/Makefile                       |  2 +
 arch/riscv/kernel/cpufeature.c                   | 77 ++++++++++++++++++------
 arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
 arch/riscv/kernel/vendor_extensions/thead.c      | 36 +++++++++++
 10 files changed, 200 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..fec86fba3acd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -759,6 +759,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
 
 endchoice
 
+source "arch/riscv/Kconfig.vendor"
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
new file mode 100644
index 000000000000..4fc86810af1d
--- /dev/null
+++ b/arch/riscv/Kconfig.vendor
@@ -0,0 +1,19 @@
+menu "Vendor extensions"
+
+config RISCV_ISA_VENDOR_EXT
+	bool
+
+menu "T-Head"
+config RISCV_ISA_VENDOR_EXT_THEAD
+	bool "T-Head vendor extension support"
+	select RISCV_ISA_VENDOR_EXT
+	default y
+	help
+	  Say N here if you want to disable all T-Head vendor extension
+	  support. This will cause any T-Head vendor extensions that are
+	  requested to be ignored.
+
+	  If you don't know what to do here, say Y.
+endmenu
+
+endmenu
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 0c4f08577015..fedd479ccfd1 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -35,6 +35,24 @@ extern u32 riscv_vlenb_of;
 
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
diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
new file mode 100644
index 000000000000..0af1ddd0af70
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2024 Rivos, Inc
+ */
+
+#ifndef _ASM_VENDOR_EXTENSIONS_H
+#define _ASM_VENDOR_EXTENSIONS_H
+
+#include <asm/cpufeature.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+struct riscv_isa_vendor_ext_data_list {
+	const struct riscv_isa_ext_data *ext_data;
+	struct riscv_isainfo *per_hart_vendor_bitmap;
+	unsigned long *vendor_bitmap;
+	const size_t ext_data_count;
+	const size_t bitmap_size;
+};
+
+extern const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[];
+
+extern const size_t riscv_isa_vendor_ext_list_size;
+
+#endif /* _ASM_VENDOR_EXTENSIONS_H */
diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
new file mode 100644
index 000000000000..92eec729888d
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
+#define _ASM_RISCV_VENDOR_EXTENSIONS_THEAD_H
+
+#include <asm/vendor_extensions.h>
+
+#include <linux/types.h>
+
+#define RISCV_ISA_VENDOR_EXT_XTHEADVECTOR		0
+
+/*
+ * Extension keys should be strictly less than max.
+ * It is safe to increment this when necessary.
+ */
+#define RISCV_ISA_VENDOR_EXT_MAX_THEAD			32
+
+extern const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
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
index 8158f34c3e36..c073494519eb 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -24,6 +24,7 @@
 #include <asm/processor.h>
 #include <asm/sbi.h>
 #include <asm/vector.h>
+#include <asm/vendor_extensions.h>
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
@@ -102,24 +103,6 @@ static bool riscv_isa_extension_check(int id)
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
@@ -353,6 +336,10 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 		bool ext_long = false, ext_err = false;
 
 		switch (*ext) {
+		case 'x':
+		case 'X':
+			pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
+			continue;
 		case 's':
 			/*
 			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
@@ -368,8 +355,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 			}
 			fallthrough;
 		case 'S':
-		case 'x':
-		case 'X':
 		case 'z':
 		case 'Z':
 			/*
@@ -572,6 +557,54 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		acpi_put_table((struct acpi_table_header *)rhct);
 }
 
+static void __init riscv_fill_cpu_vendor_ext(struct device_node *cpu_node, int cpu)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return;
+
+	for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
+		const struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
+
+		for (int j = 0; j < ext_list->ext_data_count; j++) {
+			const struct riscv_isa_ext_data ext = ext_list->ext_data[j];
+			struct riscv_isainfo *isavendorinfo = &ext_list->per_hart_vendor_bitmap[cpu];
+
+			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
+						     ext.property) < 0)
+				continue;
+
+			/*
+			 * Assume that subset extensions are all members of the
+			 * same vendor.
+			 */
+			if (ext.subset_ext_size)
+				for (int k = 0; k < ext.subset_ext_size; k++)
+					set_bit(ext.subset_ext_ids[k], isavendorinfo->isa);
+
+			set_bit(ext.id, isavendorinfo->isa);
+		}
+	}
+}
+
+static void __init riscv_fill_vendor_ext_list(int cpu)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return;
+
+	for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
+		const struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
+
+		if (bitmap_empty(ext_list->vendor_bitmap, ext_list->bitmap_size))
+			bitmap_copy(ext_list->vendor_bitmap,
+				    ext_list->per_hart_vendor_bitmap[cpu].isa,
+				    ext_list->bitmap_size);
+		else
+			bitmap_and(ext_list->vendor_bitmap, ext_list->vendor_bitmap,
+				   ext_list->per_hart_vendor_bitmap[cpu].isa,
+				   ext_list->bitmap_size);
+	}
+}
+
 static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 {
 	unsigned int cpu;
@@ -615,6 +648,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 			}
 		}
 
+		riscv_fill_cpu_vendor_ext(cpu_node, cpu);
+
 		of_node_put(cpu_node);
 
 		/*
@@ -630,6 +665,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
 		else
 			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
+
+		riscv_fill_vendor_ext_list(cpu);
 	}
 
 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
new file mode 100644
index 000000000000..f76cb3013c2d
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos, Inc
+ */
+
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/thead.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+const struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
+	&riscv_isa_vendor_ext_list_thead,
+#endif
+};
+
+const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
new file mode 100644
index 000000000000..3383066baaab
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead.o
diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/kernel/vendor_extensions/thead.c
new file mode 100644
index 000000000000..edb20b928c0c
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/thead.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/cpufeature.h>
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/thead.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+/* All T-Head vendor extensions supported in Linux */
+const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[] = {
+	__RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR),
+};
+
+/*
+ * The first member of this struct must be a bitmap named isa so it can be
+ * compatible with riscv_isainfo even though the sizes of the bitmaps may be
+ * different.
+ */
+struct riscv_isavendorinfo_thead {
+	DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
+};
+
+/* Hart specific T-Head vendor extension support */
+static struct riscv_isavendorinfo_thead hart_vendorinfo_thead[NR_CPUS];
+
+/* Set of T-Head vendor extensions supported on all harts */
+DECLARE_BITMAP(vendorinfo_thead, RISCV_ISA_VENDOR_EXT_MAX_THEAD);
+
+const struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead = {
+	.ext_data = riscv_isa_vendor_ext_thead,
+	.per_hart_vendor_bitmap = (struct riscv_isainfo *)hart_vendorinfo_thead,
+	.vendor_bitmap = vendorinfo_thead,
+	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_thead),
+	.bitmap_size = RISCV_ISA_VENDOR_EXT_MAX_THEAD
+};

-- 
2.44.0


