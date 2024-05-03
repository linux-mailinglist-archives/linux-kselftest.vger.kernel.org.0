Return-Path: <linux-kselftest+bounces-9335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4008BA63F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD831F2241E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2413B59C;
	Fri,  3 May 2024 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bUvofN7M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D013B580
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711621; cv=none; b=jH3kAHy6QKK81VbjMqeSEuRsvJOA9CodSOHG9o6dMDpsOj4sm920mufUzl//Ecmwn+Ljv5e6+KIMS24aEzEj7WuX1CRzLvMxBwtYqwCD/+WK2IS8XDE3p710ZrCQ6yxisPAyQoJ49rlZZXQy50Q2nAPl1XI4dJLx1x7ZX6OOaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711621; c=relaxed/simple;
	bh=F9Wkqs8EdJIlMr1PfjBZjPa2RaErD1TYfscUczvzu4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RaKD50A66ztOfFQXYHtyIIjWyBkHuPlkaDKO3V/QkoQlppue/Qp4m3Af3zNjOTfWb+E6juVJzbe23yr0zaDLNgu7beY05jRdHUyuCqysQdS2cUlQzYbp0GxGjjP1ua2Mfxied0hiatGetEQKEiHbMrLmTyNVRRVNBCogyK3Zc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bUvofN7M; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso15583065ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711619; x=1715316419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UykfJiaFBVi2EDAGMBh8NLAZWvMWoUpAgsh1CPEVms4=;
        b=bUvofN7M2L8YcJ5r5PDtBgChRKmTRvaCFUQuJd+Gp6muCM7zmO5HrtXyWHN1g8Idns
         H6EEdasYIlacwNvdD1YXy5o7lY10+SuK4ENQhdYp5EhsAPUuAMnKiWJjFg7hLC4kC7+Y
         LXGH1qURrgeh72h6QSK6PCp+xcRdbOiq10FI8cbq/AVxnYRNazifzYPyzHRXkmFUSLG8
         68VjrV9hIMHK8Ku8wR2YprUtOZyjcDdVJZqQmfDXae9lm8CTbqa+bNgQu/4F03aWfWkF
         jHO+ANnYDSmgVm4ywaGDQpMqGsJ3V8hobVnU4bDV8zKmQSVPHtA+9FTAy6PLNlH2k+Ac
         W9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711619; x=1715316419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UykfJiaFBVi2EDAGMBh8NLAZWvMWoUpAgsh1CPEVms4=;
        b=VJsABJY5h8VMkZRcN4R0BMl0nmw8c30gewKRdWiVhxSYlI8pHEWoP/1iA3luklUqPY
         JI9dObiG5/c57oILbyTkmwPzg61I3m4i5gVWZFuLdV1QWe2SD58pqazNPHOTVYp18Pl3
         Wr4czXNJm2CcXb1h2uuip51j+k+qWn6bdolUVsV7Q6S9IwWOW43tIzHJAJ6sKSJABdAr
         vj0LyPEJJnxwzZIzAbcJGWKyH8xfOpcrVUcTsKZoz2NcdgNHiTQM+2sJLgP+onzAUZok
         ftGHJaV/WXQKRymWkEn0k/hnf5RYTtCkVOJKhqO7EyVdbvAJ2AEphES2be2UOtkUOzmc
         pmxA==
X-Forwarded-Encrypted: i=1; AJvYcCX162nz4nfxX5KPF6LxBXpy6ktJCC1KcrpDYfdlYQJqiFHU8N19QwnKapthseItCnb7PwnYkn09mcKTIWU5t9vnuebGszs8/ZNj3lR6r5jP
X-Gm-Message-State: AOJu0YxHvmYIq+efEheVPuzUIs8bdI8EiSU2xkShhELWTygtgD9GpJac
	l7Uj5Sb+ACpac0FHXb9aJC4PpAxr+PhpFJLd2vjszSyi7JS7XX6Fxet//O2bvJs=
X-Google-Smtp-Source: AGHT+IFUeoDgjDJHDc4EYaGZSanqOSkHjLKEQHa2LwhjcFRr87Vhjosi10198Njp9xbuVzXNFBCt5A==
X-Received: by 2002:a17:902:cec2:b0:1e4:47bf:6926 with SMTP id d2-20020a170902cec200b001e447bf6926mr2115876plg.4.1714711618828;
        Thu, 02 May 2024 21:46:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:46:58 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:42 -0700
Subject: [PATCH v5 07/17] riscv: Introduce vendor variants of extension
 helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-7-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=9175;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=F9Wkqs8EdJIlMr1PfjBZjPa2RaErD1TYfscUczvzu4w=;
 b=GOOkG8MSptiZOXiwddfHG2IzyWMJxHcCjusg5hDgWdR8SSZ0pP5J6NSgk7U+2Hv4LLsCMQGff
 UaElzoZ1ajbAWGJo9t3g7SzH9oJw1+Nm2KQdX7dC25E7anAgT3bt9QM
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Vendor extensions are maintained in per-vendor structs (separate from
standard extensions which live in riscv_isa). Create vendor variants for
the existing extension helpers to interface with the riscv_isa_vendor
bitmaps.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/errata/sifive/errata.c          |  3 +
 arch/riscv/errata/thead/errata.c           |  3 +
 arch/riscv/include/asm/vendor_extensions.h | 97 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c             | 32 +++++++---
 arch/riscv/kernel/vendor_extensions.c      | 40 ++++++++++++
 5 files changed, 167 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 3d9a32d791f7..b68b023115c2 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -12,6 +12,7 @@
 #include <asm/alternative.h>
 #include <asm/vendorid_list.h>
 #include <asm/errata_list.h>
+#include <asm/vendor_extensions.h>
 
 struct errata_info_t {
 	char name[32];
@@ -91,6 +92,8 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	u32 cpu_apply_errata = 0;
 	u32 tmp;
 
+	BUILD_BUG_ON(ERRATA_SIFIVE_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return;
 
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1ae..6d5d7f8eebbc 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
+#include <asm/vendor_extensions.h>
 
 static bool errata_probe_pbmt(unsigned int stage,
 			      unsigned long arch_id, unsigned long impid)
@@ -160,6 +161,8 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	u32 tmp;
 	void *oldptr, *altptr;
 
+	BUILD_BUG_ON(ERRATA_THEAD_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
 	for (alt = begin; alt < end; alt++) {
 		if (alt->vendor_id != THEAD_VENDOR_ID)
 			continue;
diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
index bf4dac66e6e6..a6959836f895 100644
--- a/arch/riscv/include/asm/vendor_extensions.h
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -31,4 +31,101 @@ extern struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[];
 
 extern const size_t riscv_isa_vendor_ext_list_size;
 
+/*
+ * The alternatives need some way of distinguishing between vendor extensions
+ * and errata. Incrementing all of the vendor extension keys so they are at
+ * least 0x8000 accomplishes that.
+ */
+#define RISCV_VENDOR_EXT_ALTERNATIVES_BASE	0x8000
+
+#define VENDOR_EXT_ALL_CPUS			-1
+
+bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit);
+#define riscv_cpu_isa_vendor_extension_available(cpu, vendor, ext)	\
+	__riscv_isa_vendor_extension_available(cpu, vendor, RISCV_ISA_VENDOR_EXT_##ext)
+#define riscv_isa_vendor_extension_available(vendor, ext)	\
+	__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, \
+					       RISCV_ISA_VENDOR_EXT_##ext)
+
+static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
+							 const unsigned long ext)
+{
+	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_no);
+
+	return true;
+l_no:
+	return false;
+}
+
+static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
+							   const unsigned long ext)
+{
+	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool riscv_has_vendor_extension_likely(const unsigned long vendor,
+							      const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely(vendor,
+						    ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
+	return __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, ext);
+}
+
+static __always_inline bool riscv_has_vendor_extension_unlikely(const unsigned long vendor,
+								const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely(vendor,
+						      ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
+	return __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, ext);
+}
+
+static __always_inline bool riscv_cpu_has_vendor_extension_likely(const unsigned long vendor,
+								  int cpu, const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_likely(vendor, ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
+		return true;
+
+	return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
+}
+
+static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(const unsigned long vendor,
+								    int cpu,
+								    const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_unlikely(vendor, ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
+		return true;
+
+	return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
+}
+
 #endif /* _ASM_VENDOR_EXTENSIONS_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index cc9ec393c8f6..b1f35564a1e0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -860,25 +860,41 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 {
 	struct alt_entry *alt;
 	void *oldptr, *altptr;
-	u16 id, value;
+	u16 id, value, vendor;
 
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return;
 
 	for (alt = begin; alt < end; alt++) {
-		if (alt->vendor_id != 0)
-			continue;
-
 		id = PATCH_ID_CPUFEATURE_ID(alt->patch_id);
+		vendor = PATCH_ID_CPUFEATURE_ID(alt->vendor_id);
 
-		if (id >= RISCV_ISA_EXT_MAX) {
+		/*
+		 * Any alternative with a patch_id that is less than
+		 * RISCV_ISA_EXT_MAX is interpreted as a standard extension.
+		 *
+		 * Any alternative with patch_id that is greater than or equal
+		 * to RISCV_VENDOR_EXT_ALTERNATIVES_BASE is interpreted as a
+		 * vendor extension.
+		 */
+		if (id < RISCV_ISA_EXT_MAX) {
+			/*
+			 * This patch should be treated as errata so skip
+			 * processing here.
+			 */
+			if (alt->vendor_id != 0)
+				continue;
+
+			if (!__riscv_isa_extension_available(NULL, id))
+				continue;
+		} else if (id >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE) {
+			if (!__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, id))
+				continue;
+		} else {
 			WARN(1, "This extension id:%d is not in ISA extension list", id);
 			continue;
 		}
 
-		if (!__riscv_isa_extension_available(NULL, id))
-			continue;
-
 		value = PATCH_ID_CPUFEATURE_VALUE(alt->patch_id);
 		if (!riscv_cpufeature_patch_check(id, value))
 			continue;
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
index 03ba7949a07f..e4ef574b7d08 100644
--- a/arch/riscv/kernel/vendor_extensions.c
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -3,6 +3,7 @@
  * Copyright 2024 Rivos, Inc
  */
 
+#include <asm/vendorid_list.h>
 #include <asm/vendor_extensions.h>
 #include <asm/vendor_extensions/thead.h>
 
@@ -16,3 +17,42 @@ struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
 };
 
 const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
+
+/**
+ * __riscv_isa_vendor_extension_available() - Check whether given vendor
+ * extension is available or not.
+ *
+ * @cpu: check if extension is available on this cpu
+ * @vendor: vendor that the extension is a member of
+ * @bit: bit position of the desired extension
+ * Return: true or false
+ *
+ * NOTE: When cpu is -1, will check if extension is available on all cpus
+ */
+bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit)
+{
+	unsigned long *bmap;
+	struct riscv_isainfo *cpu_bmap;
+	size_t bmap_size;
+
+	switch (vendor) {
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
+	case THEAD_VENDOR_ID:
+		bmap = riscv_isa_vendor_ext_list_thead.vendor_bitmap;
+		cpu_bmap = riscv_isa_vendor_ext_list_thead.per_hart_vendor_bitmap;
+		bmap_size = riscv_isa_vendor_ext_list_thead.bitmap_size;
+		break;
+#endif
+	default:
+		return false;
+	}
+
+	if (cpu != -1)
+		bmap = cpu_bmap[cpu].isa;
+
+	if (bit >= bmap_size)
+		return false;
+
+	return test_bit(bit, bmap) ? true : false;
+}
+EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);

-- 
2.44.0


