Return-Path: <linux-kselftest+bounces-7748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1978A24CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EDA282F68
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F541C79;
	Fri, 12 Apr 2024 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aN6xvGJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E333EA97
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895108; cv=none; b=QIRK64VT29uL79tB3eOjuYomySWZEvU0CpcvRqAMGQnNatzUtCHWABSawvo0r+hyyI4bMj3k6gJkLwaxeGNJNimCtdEv3qUcCSFGAQ87uvA5fcL4t9CADMpSmV9Kh41mhIi2RW11M5Xo9hMcDInynrsZnSXqcA+PQO+fynAMBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895108; c=relaxed/simple;
	bh=LVM8BJWp4kbtWbvJ+cWTI1XMl2uLMPRDAqqRFNldaz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYJAax0Ueu6Y068qmqpjQeEU20dBle66rwvkKh8lX9jqGl5q+tSO8TPViHXDqjEYXCtO0lcvL6huAgrhbhI9fJ1cyBltNCFs3ssi6fqieI3+KOOERAi1jg4fl2R4/WApowI0d1Bg00EnvioMSznht1LenrjvEwbH2QHOGgKajhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aN6xvGJF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so518738b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895104; x=1713499904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGTZACnSZ1i+Ykv0YjfdUR0BG6DW+Ly+zfwM213E+Q4=;
        b=aN6xvGJFRzICFxuGY24K3lwECST00Ssxah861VAO/AIDIVDvsiSFRlt6Hvr8iGOI9d
         5cnVWyFwCiU4XvU3tuGNsG5EhugS3+tQjQXOGBcAGJB8fVwBGxnlPTYjoOBVyzLw5jp/
         AnUXwxohl59XyDU/UtNazwpWu/FTiJTX9pOPvcFewBTr8S0ruFJRJKzxOAcSEa2tJvrX
         Q3CFnmTjJGnZc3jBR2juP6FK9Qv6IGBN+OkFzbYs4u3ozxQm2M2GimZwFRScBRx+WHCl
         LAssNQctQPuu7Df9nd4Zr1R4Tz7MvOBzSRbeTgO7tI/2s3jvkoBGXDv4u+PtG5NBYpf6
         YfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895104; x=1713499904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGTZACnSZ1i+Ykv0YjfdUR0BG6DW+Ly+zfwM213E+Q4=;
        b=sp6auhsc3cFtUpbbIqAQTLHOuh+siquwEfNShfvD1GI5iDAjgZ+0OjmThKS6Vd97Pt
         Q6gKpomEalf+AS6nONvDjhkrPQAyB8z3z1FoOSPFG8N/uV6N/BBFsQQdi8FVWp9UTDNo
         ZF8D/p9px/bb5xur2muJYzATORU6mYbKfDy4+E2xggLCqp940te6jj4eX3dripzn7Pgi
         dDbLP5/dJn16+s9ATMXfV5chlTv59+DkW7TEiyr15Zvo87IGozqKL7UV+MoTSuM/avq1
         DXW+63XFJjSUBq2945yd8F+YRvT1tSjdPiCzWTek22DdcV7MkOCm8W+gGaeDVxk3GWAh
         QDPg==
X-Forwarded-Encrypted: i=1; AJvYcCXaumfV4kT0knzr7S8CJpFMHbINiGPeUvgCBuAu6syqx+MFmFf4lHBXq7R7bJVAGTuX2y6SNYKV3Dbg/7a1dI/VDjGqKqEVbrwNR4rl02wY
X-Gm-Message-State: AOJu0YyYmkFBXuR8VERz0ptFaKsKOqFNJgjv8wfBV24TvkWRudsfwY4H
	HX0J2gSJuyzs6/vYJYIc2igpg3qyzVIT4Lkl95zkMrW6eBuBksNXNVkHg/AzR5o=
X-Google-Smtp-Source: AGHT+IGU+S8iI/pDcLQfIj7LWyb8QcgBd7lfBNpDephhIHxV77vyM05ignCXGTTjQao5UW1Z6PanJA==
X-Received: by 2002:a05:6a00:22c2:b0:6ed:1c7:8c5d with SMTP id f2-20020a056a0022c200b006ed01c78c5dmr2037623pfj.12.1712895104295;
        Thu, 11 Apr 2024 21:11:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:43 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:12 -0700
Subject: [PATCH 06/19] riscv: Extend cpufeature.c to detect vendor
 extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-6-4af9815ec746@rivosinc.com>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=14249;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=LVM8BJWp4kbtWbvJ+cWTI1XMl2uLMPRDAqqRFNldaz8=;
 b=p49MC26GV0FFzVF5MCrSvWc+cGk7wgiomLct9rxdYClZkAcRcN4/5BFfvq9M8GAdtl8kZoCBC
 byReys5oJ9dAYJVviyKuiMNY67D9HiIXMbo4MROmox7gevX9Zwrqo4p
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Create a private namespace for each vendor above 0x8000. During the
probing of hardware capabilities, the vendorid of each hart is used to
resolve the vendor extension compatibility.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |   7 ++
 arch/riscv/include/asm/hwcap.h      |  23 ++++
 arch/riscv/kernel/cpufeature.c      | 203 ++++++++++++++++++++++++++++++------
 3 files changed, 200 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..b5f4eedcfa86 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -26,11 +26,18 @@ struct riscv_isainfo {
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
 void riscv_user_isa_enable(void);
 
 #if defined(CONFIG_RISCV_MISALIGNED)
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
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5eb52d270a9a..f72fbdd0d7f5 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -32,9 +32,15 @@ unsigned long elf_hwcap __read_mostly;
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
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -309,8 +315,15 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
 
+const struct riscv_isa_ext_data riscv_isa_vendor_ext_thead[] = {
+	__RISCV_ISA_EXT_DATA(xtheadvector, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR),
+};
+
+const size_t riscv_isa_vendor_ext_count_thead = ARRAY_SIZE(riscv_isa_vendor_ext_thead);
+
 static void __init match_isa_ext(const struct riscv_isa_ext_data *ext, const char *name,
-				 const char *name_end, struct riscv_isainfo *isainfo)
+				 const char *name_end, struct riscv_isainfo *isainfo,
+				 unsigned int id_offset)
 {
 	if ((name_end - name == strlen(ext->name)) &&
 	     !strncasecmp(name, ext->name, name_end - name)) {
@@ -321,7 +334,7 @@ static void __init match_isa_ext(const struct riscv_isa_ext_data *ext, const cha
 		if (ext->subset_ext_size) {
 			for (int i = 0; i < ext->subset_ext_size; i++) {
 				if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
-					set_bit(ext->subset_ext_ids[i], isainfo->isa);
+					set_bit(ext->subset_ext_ids[i] - id_offset, isainfo->isa);
 			}
 		}
 
@@ -330,12 +343,34 @@ static void __init match_isa_ext(const struct riscv_isa_ext_data *ext, const cha
 		 * (rejected by riscv_isa_extension_check()).
 		 */
 		if (riscv_isa_extension_check(ext->id))
-			set_bit(ext->id, isainfo->isa);
+			set_bit(ext->id - id_offset, isainfo->isa);
+	}
+}
+
+static bool __init get_isa_vendor_ext(unsigned long vendorid,
+				      const struct riscv_isa_ext_data **isa_vendor_ext,
+				      size_t *count)
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
 	}
+
+	return found_vendor;
 }
 
 static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct riscv_isainfo *isainfo,
-					  unsigned long *isa2hwcap, const char *isa)
+					struct riscv_isainfo *isavendorinfo, unsigned long vendorid,
+					unsigned long *isa2hwcap, const char *isa)
 {
 	/*
 	 * For all possible cpus, we have already validated in
@@ -349,8 +384,30 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 		const char *ext = isa++;
 		const char *ext_end = isa;
 		bool ext_long = false, ext_err = false;
+		struct riscv_isainfo *selected_isainfo = isainfo;
+		const struct riscv_isa_ext_data *selected_riscv_isa_ext = riscv_isa_ext;
+		size_t selected_riscv_isa_ext_count = riscv_isa_ext_count;
+		unsigned int id_offset = 0;
 
 		switch (*ext) {
+		case 'x':
+		case 'X':
+			bool found;
+
+			found = get_isa_vendor_ext(vendorid,
+						   &selected_riscv_isa_ext,
+						   &selected_riscv_isa_ext_count);
+			selected_isainfo = isavendorinfo;
+			id_offset = RISCV_ISA_VENDOR_EXT_BASE;
+			if (!found) {
+				pr_warn("No associated vendor extensions with vendor id: %lx\n",
+					vendorid);
+				for (; *isa && *isa != '_'; ++isa)
+					;
+				ext_err = true;
+				break;
+			}
+			fallthrough;
 		case 's':
 			/*
 			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
@@ -366,8 +423,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 			}
 			fallthrough;
 		case 'S':
-		case 'x':
-		case 'X':
 		case 'z':
 		case 'Z':
 			/*
@@ -476,8 +531,10 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 				set_bit(nr, isainfo->isa);
 			}
 		} else {
-			for (int i = 0; i < riscv_isa_ext_count; i++)
-				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
+			for (int i = 0; i < selected_riscv_isa_ext_count; i++)
+				match_isa_ext(&selected_riscv_isa_ext[i], ext,
+					      ext_end, selected_isainfo,
+					      id_offset);
 		}
 	}
 }
@@ -490,8 +547,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 	struct acpi_table_header *rhct;
 	acpi_status status;
 	unsigned int cpu;
-	u64 boot_vendorid;
-	u64 boot_archid;
+	u64 boot_vendorid = ULL(-1), vendorid;
+	u64 boot_archid = ULL(-1);
 
 	if (!acpi_disabled) {
 		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
@@ -499,11 +556,9 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			return;
 	}
 
-	boot_vendorid = riscv_get_mvendorid();
-	boot_archid = riscv_get_marchid();
-
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
+		struct riscv_isainfo *isavendorinfo = &hart_isa_vendor[cpu];
 		unsigned long this_hwcap = 0;
 		u64 this_vendorid;
 		u64 this_archid;
@@ -523,11 +578,19 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			}
 			if (of_property_read_u64(node, "riscv,vendorid", &this_vendorid) < 0) {
 				pr_warn("Unable to find \"riscv,vendorid\" devicetree entry, using boot hart mvendorid instead\n");
+
+				if (boot_vendorid == -1)
+					this_vendorid = riscv_get_mvendorid();
+
 				this_vendorid = boot_vendorid;
 			}
 
 			if (of_property_read_u64(node, "riscv,archid", &this_archid) < 0) {
 				pr_warn("Unable to find \"riscv,vendorid\" devicetree entry, using boot hart marchid instead\n");
+
+				if (boot_archid == -1)
+					boot_archid = riscv_get_marchid();
+
 				this_archid = boot_archid;
 			}
 		} else {
@@ -540,7 +603,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			this_archid = boot_archid;
 		}
 
-		riscv_parse_isa_string(&this_hwcap, isainfo, isa2hwcap, isa);
+		riscv_parse_isa_string(&this_hwcap, isainfo, isavendorinfo,
+				       this_vendorid, isa2hwcap, isa);
 
 		/*
 		 * These ones were as they were part of the base ISA when the
@@ -582,21 +646,77 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
 		else
 			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
+
+		/*
+		 * All harts must have the same vendor to have compatible
+		 * vendor extensions.
+		 */
+		if (bitmap_empty(riscv_isa_vendor, RISCV_ISA_VENDOR_EXT_SIZE)) {
+			vendorid = this_vendorid;
+			bitmap_copy(riscv_isa_vendor, isavendorinfo->isa,
+				    RISCV_ISA_VENDOR_EXT_SIZE);
+		} else if (vendorid != this_vendorid) {
+			vendorid = -1ULL;
+			bitmap_clear(riscv_isa_vendor, 0, RISCV_ISA_VENDOR_EXT_SIZE);
+		} else {
+			bitmap_and(riscv_isa_vendor, riscv_isa_vendor,
+				   isavendorinfo->isa,
+				   RISCV_ISA_VENDOR_EXT_SIZE);
+		}
 	}
 
 	if (!acpi_disabled && rhct)
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
@@ -608,28 +728,28 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
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
-
-			if (ext->subset_ext_size) {
-				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
-						set_bit(ext->subset_ext_ids[j], isainfo->isa);
-				}
-			}
+		if (of_property_read_u64(cpu_node, "riscv,vendorid", &this_vendorid) < 0) {
+			pr_warn("Unable to find \"riscv,vendorid\" devicetree entry, using boot hart mvendorid instead\n");
+			if (boot_vendorid == -1)
+				boot_vendorid = riscv_get_mvendorid();
+			this_vendorid = boot_vendorid;
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
 
@@ -646,6 +766,23 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
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
 
 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))

-- 
2.44.0


