Return-Path: <linux-kselftest+bounces-8697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04A8AE690
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9036E1F22327
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9F6130AF9;
	Tue, 23 Apr 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KiYR7gye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5512BF36
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876226; cv=none; b=kYjF6uvMcFkE9J6NC1KgjlMH68GWAQXFneD06wZpguQ0UeH6oJGltbpHfn/wBmDv3sfWQ+RqV+JlhIFRxvKXLh3i9bYmU7zFBLYRiepdJ3VsuwQXT8Ui2WSH4g5MhW9TqXHEPXwpxnZNz5Thk0mKj+Y7TKZO3EUfx7C4bZd4JAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876226; c=relaxed/simple;
	bh=1SG6AbLtwEjs/dzx5DYLZ14d7DYwtBFKaLfXVi54AsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEMgn84s034f2pKozsKe9CLSADtKbaZrQMftPcog2QPG3bIV1kxQyxLtYK000RfoUIclrHErXl3tD/XzNFlD4LHfH4A9y847Ffc8sxitKhzpcaeVWb4boKrGowBjVZ4w9DMBcHEMrx1JBIiYWieR0hph6VxN0SMHJhyEvdjTOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KiYR7gye; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34b39ecbcccso320521f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713876223; x=1714481023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsdoYA/OHWBDv08MRhgCHOKDJWz5fs7YbSsaVblu9P0=;
        b=KiYR7gyexMa9u5F3yDIV4hatgXAaksLhtgSWIFARQzFlT2uolWCji4uD//6Ap5ab5r
         5KKkTUzXXdk/AyK0mNfLB8R0Xan7UZchYoHdh3r2t+lS1ZVFZLs2CPYF2y8oPffc86QJ
         6luA2NQ4+mcu0RIYFepssEFvpqjF0A5ZSg/3wfKjX/cF/MFvnrDOVkw8kZm8E+Ee+ke6
         o5X8Em5rf9wX67yWTILhx5iS0WAJhIyKql604YTkvAVn+y9lbUmFfo8Q1KVvOvQqCTmy
         VLRD/A45nWOpOQXL4W6pzomBCQyQYIza+NOftV3blA9L54g/tO9rr5njiyJbkxuR2mmC
         4ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876223; x=1714481023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsdoYA/OHWBDv08MRhgCHOKDJWz5fs7YbSsaVblu9P0=;
        b=WuHAo3f2XVWQdr7AVSUHPPDFtcCbZNUJAvT9cXlRHdvaV3UwgAelAfUY8xYQJ+3JVs
         7BsTug1VQ/boDD2ejLJm/iMLhdfrnc1DfJpCEb1oaOL4J2zuY5sEFnUoJJ053ceT2LYC
         MY9Jzh2/3ekCoPwuz1KPaIMjYIKK6mXEQPxoZWLmcg1inNbLr3R7xnoN2ZGjc6lugarF
         CakIgspwPDQIxarTh7dU4wgV3NqDWYU5JqTYP6tpEub83gUdCrtX/iTIR3e6r4qjWQ4H
         ELJNJ2So1ollX3DItEqgTCKWJQ1mnFjxffHGlYUul04OYPtSI4kOK9by7uHrdSoDL11m
         rSpg==
X-Forwarded-Encrypted: i=1; AJvYcCXziqyOuDlKeG75I4nV6pvnb2N8PajgJhmaP3pPAO6upV3grmFKp/a7fk8PLDOP74Y4JQcJ7ipUL4L+cyzaaFoR+eX0HY4sVXbedfBrQIKb
X-Gm-Message-State: AOJu0YxqBSwluzxP5UISXZjpWIABBp6wqXkYC6XozXhzowsLsGredfvg
	LaWIIWzMRnfhyKQn1VHCh7JujVAUOS2aYG+yf6pS6uKXF1KZab2QVI7RZpdRxW4=
X-Google-Smtp-Source: AGHT+IGFB23sRUNbye0X+w1SWPXym1/kF/MR46maclAGdW8ndAuXPYIIGn9rsEBZcFOpIbfIEMjHmA==
X-Received: by 2002:a05:600c:1c27:b0:41a:c4fe:b0a6 with SMTP id j39-20020a05600c1c2700b0041ac4feb0a6mr1112231wms.4.1713876222917;
        Tue, 23 Apr 2024 05:43:42 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:71cb:1f75:7053:849c])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00418a386c059sm19975709wmo.42.2024.04.23.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:43:42 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 02/11] riscv: add ISA extensions validation
Date: Tue, 23 Apr 2024 14:43:16 +0200
Message-ID: <20240423124326.2532796-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423124326.2532796-1-cleger@rivosinc.com>
References: <20240423124326.2532796-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since a few extensions (Zicbom/Zicboz) already needs validation and
future ones will need it as well (Zc*) add a validate() callback to
struct riscv_isa_ext_data. This require to rework the way extensions are
parsed and split it in two phases. First phase is isa string or isa
extension list parsing and consists in enabling all the extensions in a
temporary bitmask without any validation. The second step "resolves" the
final isa bitmap, handling potential missing dependencies. The mechanism
is quite simple and simply validate each extension described in the
temporary bitmap before enabling it in the final isa bitmap. This
process takes place until the final isa bitmap reaches a stable state.
In order to avoid any potential infinite looping, allow looping a
maximum of the number of extension we handle. Zicboz and Zicbom
extensions are modified to use this validation mechanism.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |   1 +
 arch/riscv/kernel/cpufeature.c      | 201 ++++++++++++++++------------
 2 files changed, 118 insertions(+), 84 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..328f895f6b8f 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -70,6 +70,7 @@ struct riscv_isa_ext_data {
 	const char *property;
 	const unsigned int *subset_ext_ids;
 	const unsigned int subset_ext_size;
+	bool (*validate)(const struct riscv_isa_ext_data *data, const unsigned long *isa_bitmap);
 };
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 115ba001f1bc..6d238c8dbccf 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -72,51 +72,62 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
-static bool riscv_isa_extension_check(int id)
+static bool riscv_isa_extension_valid(int id)
 {
-	switch (id) {
-	case RISCV_ISA_EXT_ZICBOM:
-		if (!riscv_cbom_block_size) {
-			pr_err("Zicbom detected in ISA string, disabling as no cbom-block-size found\n");
-			return false;
-		} else if (!is_power_of_2(riscv_cbom_block_size)) {
-			pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
-			return false;
-		}
-		return true;
-	case RISCV_ISA_EXT_ZICBOZ:
-		if (!riscv_cboz_block_size) {
-			pr_err("Zicboz detected in ISA string, disabling as no cboz-block-size found\n");
-			return false;
-		} else if (!is_power_of_2(riscv_cboz_block_size)) {
-			pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
-			return false;
-		}
-		return true;
-	case RISCV_ISA_EXT_INVALID:
+	return id != RISCV_ISA_EXT_INVALID;
+}
+
+static bool riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
+				      const unsigned long *isa_bitmap)
+{
+	if (!riscv_cbom_block_size) {
+		pr_err_once("Zicbom detected in ISA string,"
+			    "disabling as no cbom-block-size found\n");
+		return false;
+	} else if (!is_power_of_2(riscv_cbom_block_size)) {
+		pr_err_once("Zicbom disabled as cbom-block-size present,"
+			    "but is not a power-of-2\n");
 		return false;
 	}
+	return true;
+}
 
+static bool riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
+				      const unsigned long *isa_bitmap)
+{
+	if (!riscv_cboz_block_size) {
+		pr_err_once("Zicboz detected in ISA string,"
+			    "disabling as no cboz-block-size found\n");
+		return false;
+	} else if (!is_power_of_2(riscv_cboz_block_size)) {
+		pr_err_once("Zicboz disabled as cboz-block-size present,"
+			    "but is not a power-of-2\n");
+		return false;
+	}
 	return true;
 }
 
-#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
-	.name = #_name,								\
-	.property = #_name,							\
-	.id = _id,								\
-	.subset_ext_ids = _subset_exts,						\
-	.subset_ext_size = _subset_exts_size					\
+#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
+	.name = #_name,									\
+	.property = #_name,								\
+	.id = _id,									\
+	.subset_ext_ids = _subset_exts,							\
+	.subset_ext_size = _subset_exts_size,						\
+	.validate = _validate								\
 }
 
-#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
+#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, NULL)
 
 /* Used to declare pure "lasso" extension (Zk for instance) */
 #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
-	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
+	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
+			    ARRAY_SIZE(_bundled_exts), NULL)
 
 /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
 #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
-	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
+	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), NULL)
+#define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
+	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
 
 static const unsigned int riscv_zk_bundled_exts[] = {
 	RISCV_ISA_EXT_ZBKB,
@@ -247,8 +258,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
 	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
-	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
-	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts,
+					  riscv_ext_zicbom_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
+					  riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
@@ -310,33 +323,70 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
 
-static void __init match_isa_ext(const struct riscv_isa_ext_data *ext, const char *name,
-				 const char *name_end, struct riscv_isainfo *isainfo)
+static void riscv_isa_set_ext(const struct riscv_isa_ext_data *ext, unsigned long *bitmap)
 {
-	if ((name_end - name == strlen(ext->name)) &&
-	     !strncasecmp(name, ext->name, name_end - name)) {
-		/*
-		 * If this is a bundle, enable all the ISA extensions that
-		 * comprise the bundle.
-		 */
-		if (ext->subset_ext_size) {
-			for (int i = 0; i < ext->subset_ext_size; i++) {
-				if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
-					set_bit(ext->subset_ext_ids[i], isainfo->isa);
-			}
+	/*
+	 * This is valid even for bundle extensions which uses the RISCV_ISA_EXT_INVALID id
+	 * (rejected by riscv_isa_extension_valid()).
+	 */
+	if (riscv_isa_extension_valid(ext->id))
+		set_bit(ext->id, bitmap);
+
+	for (int i = 0; i < ext->subset_ext_size; i++) {
+		if (riscv_isa_extension_valid(ext->subset_ext_ids[i]))
+			set_bit(ext->subset_ext_ids[i], bitmap);
+	}
+}
+
+static void __init riscv_resolve_isa(const unsigned long *isa_bitmap, struct riscv_isainfo *isainfo,
+				     unsigned long *this_hwcap, unsigned long *isa2hwcap)
+{
+	const struct riscv_isa_ext_data *ext;
+	DECLARE_BITMAP(prev_bitmap, RISCV_ISA_EXT_MAX);
+	int max_loop_count = riscv_isa_ext_count + 1;
+
+	do {
+		if (max_loop_count-- < 0) {
+			pr_err("Failed to reach a stable ISA state\n");
+			return;
 		}
+		memcpy(prev_bitmap, isainfo->isa, sizeof(prev_bitmap));
+		for (int i = 0; i < riscv_isa_ext_count; i++) {
+			ext = &riscv_isa_ext[i];
+
+			/* Bundle extensions ids are invalid*/
+			if (!riscv_isa_extension_valid(ext->id))
+				continue;
+
+			if (!test_bit(ext->id, isa_bitmap) || test_bit(ext->id, isainfo->isa))
+				continue;
+
+			if (ext->validate && !ext->validate(ext, isainfo->isa))
+				continue;
 
-		/*
-		 * This is valid even for bundle extensions which uses the RISCV_ISA_EXT_INVALID id
-		 * (rejected by riscv_isa_extension_check()).
-		 */
-		if (riscv_isa_extension_check(ext->id))
 			set_bit(ext->id, isainfo->isa);
+
+			/* Only single letter extensions get set in hwcap */
+			if (ext->id < RISCV_ISA_EXT_BASE)
+				*this_hwcap |= isa2hwcap[ext->id];
+		}
+	} while (memcmp(prev_bitmap, isainfo->isa, sizeof(prev_bitmap)));
+}
+
+static void __init match_isa_ext(const char *name, const char *name_end, unsigned long *bitmap)
+{
+	for (int i = 0; i < riscv_isa_ext_count; i++) {
+		const struct riscv_isa_ext_data *ext = &riscv_isa_ext[i];
+
+		if ((name_end - name == strlen(ext->name)) &&
+		    !strncasecmp(name, ext->name, name_end - name)) {
+			riscv_isa_set_ext(ext, bitmap);
+			break;
+		}
 	}
 }
 
-static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct riscv_isainfo *isainfo,
-					  unsigned long *isa2hwcap, const char *isa)
+static void __init riscv_resolve_isa_string(const char *isa, unsigned long *bitmap)
 {
 	/*
 	 * For all possible cpus, we have already validated in
@@ -349,7 +399,7 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 	while (*isa) {
 		const char *ext = isa++;
 		const char *ext_end = isa;
-		bool ext_long = false, ext_err = false;
+		bool ext_err = false;
 
 		switch (*ext) {
 		case 's':
@@ -389,7 +439,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 			 * character itself while eliminating the extensions version number.
 			 * A simple re-increment solves this problem.
 			 */
-			ext_long = true;
 			for (; *isa && *isa != '_'; ++isa)
 				if (unlikely(!isalnum(*isa)))
 					ext_err = true;
@@ -469,17 +518,8 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 
 		if (unlikely(ext_err))
 			continue;
-		if (!ext_long) {
-			int nr = tolower(*ext) - 'a';
 
-			if (riscv_isa_extension_check(nr)) {
-				*this_hwcap |= isa2hwcap[nr];
-				set_bit(nr, isainfo->isa);
-			}
-		} else {
-			for (int i = 0; i < riscv_isa_ext_count; i++)
-				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
-		}
+		match_isa_ext(ext, ext_end, bitmap);
 	}
 }
 
@@ -501,6 +541,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 		unsigned long this_hwcap = 0;
+		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) = { 0 };
 
 		if (acpi_disabled) {
 			node = of_cpu_device_node_get(cpu);
@@ -523,7 +564,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			}
 		}
 
-		riscv_parse_isa_string(&this_hwcap, isainfo, isa2hwcap, isa);
+		riscv_resolve_isa_string(isa, isa_bitmap);
 
 		/*
 		 * These ones were as they were part of the base ISA when the
@@ -531,10 +572,10 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 * unconditionally where `i` is in riscv,isa on DT systems.
 		 */
 		if (acpi_disabled) {
-			set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
-			set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
-			set_bit(RISCV_ISA_EXT_ZICNTR, isainfo->isa);
-			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
+			set_bit(RISCV_ISA_EXT_ZICSR, isa_bitmap);
+			set_bit(RISCV_ISA_EXT_ZIFENCEI, isa_bitmap);
+			set_bit(RISCV_ISA_EXT_ZICNTR, isa_bitmap);
+			set_bit(RISCV_ISA_EXT_ZIHPM, isa_bitmap);
 		}
 
 		/*
@@ -548,9 +589,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
 		    riscv_cached_marchid(cpu) == 0x0) {
 			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
-			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
+			clear_bit(RISCV_ISA_EXT_v, isa_bitmap);
 		}
 
+		riscv_resolve_isa(isa_bitmap, isainfo, &this_hwcap, isa2hwcap);
+
 		/*
 		 * All "okay" hart should have same isa. Set HWCAP based on
 		 * common capabilities of every "okay" hart, in case they don't
@@ -579,6 +622,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		unsigned long this_hwcap = 0;
 		struct device_node *cpu_node;
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
+		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) = { 0 };
 
 		cpu_node = of_cpu_device_node_get(cpu);
 		if (!cpu_node) {
@@ -598,22 +642,11 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 						     ext->property) < 0)
 				continue;
 
-			if (ext->subset_ext_size) {
-				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
-						set_bit(ext->subset_ext_ids[j], isainfo->isa);
-				}
-			}
-
-			if (riscv_isa_extension_check(ext->id)) {
-				set_bit(ext->id, isainfo->isa);
-
-				/* Only single letter extensions get set in hwcap */
-				if (strnlen(riscv_isa_ext[i].name, 2) == 1)
-					this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
-			}
+			riscv_isa_set_ext(ext, isa_bitmap);
 		}
 
+		riscv_resolve_isa(isa_bitmap, isainfo, &this_hwcap, isa2hwcap);
+
 		of_node_put(cpu_node);
 
 		/*
-- 
2.43.0


