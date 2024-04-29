Return-Path: <linux-kselftest+bounces-9035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BD8B5D02
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680281F21B9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF99612F59A;
	Mon, 29 Apr 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kC5YAwf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F884D27
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403198; cv=none; b=IKfpOCFWNyu2kpWWBrHPAnBG/WVQwpiy5qHWiFKi7eO+1iV/sTN4rVpWzOjL9VHtGhjXMtlv/w6kvBUbs15/Vti8hnDAGMvRjss7ET3dp52Q3vUiVXGL9ldiBYf5byLPHDY3h2gyfVN9Sl/VpWb2yIe+t4ix4kTLslsEdLe0+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403198; c=relaxed/simple;
	bh=7t7XVebBdPwbf0Z0nE/EeXs2O7yjmWMH5GJlhuM/mGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+SWM5se/nxctLXmomVs+h0PI/YewPH5cMA6c20GN9Jmo3TrjtuYZC84lILPuQIFI7K4ipaQniHCBv/oS2skxqoRog3NCHaOlp2PqqB6rpQn4twP+ri88CjVLXbLWkSrd/54ls0jYe8hYfnJz8k9I/hPoUQCdfHSSe5Icbdmx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kC5YAwf9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dfe5e0c1a6so3935291fa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714403193; x=1715007993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAWGMqETz0T0fwgkfnv1xM4Kqba1hiikMJXRUjnFrJ8=;
        b=kC5YAwf9bR9WEm3qNZs0vDyLG7VGa+pKmYN2M2SyPzdvOGR1EpFRcVWjtgD9Z2yxy8
         M/DQ1JDNIVxt29SW71kD8CUDVwUlt7MIMCwHOHc6SHNwBhTiE8dqX9XabXEc0eflJfR1
         ucOomkvstmWrOtFEeE1uhKBX/E3QLRiPRkpWA8dLcyGVTR+HupBoZHJeaPXWzJ6HEgYt
         V3VPv1mVrSP1ig593kAJaiJInyQHLcGazRJJsm6rQiOWmOol38pNLttxQfsA0autlO1I
         1z23cOH5IDHpiLOnfpInf2Mdacee89MzzzNmVNIStLqp9LuxYUEIFsa+bsU974JjyUCh
         IvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403193; x=1715007993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAWGMqETz0T0fwgkfnv1xM4Kqba1hiikMJXRUjnFrJ8=;
        b=ANQw/sWoGIY/M+EQ11TaBUNoJKnA6dxcVhlBbQ1oONVFO8xeswOpRyLTxh+L9qFLAL
         EfmV8ByndXsSUQzl3ZynmlfJh+vr2s4dNBtP+R7TaXD9VcMO2cVfL6XpI97IuuqNtswX
         du3of42mUqy2JHe0lGvXbFs5NETkfcNtxzCjdNPCk4Oa6l9d+cmSMVTl5OukT98y54iS
         tFjCrSE74K4xldKD8zBvnoM0zn/nta+Jh45IsGppCy3zhhn6E2G6GPv0nHaZLAN5xlMu
         Jqa2QqrJE6/Qah6Z/kLOwh3us8kOsv0YDIJjIrgNW4R3dpUbcKDESLQshyQvuReGvChP
         Y19Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1zMQhZw5yoDnr9PvHEAraCrEsedw27w0kaz03v/coAaqz0LIWoYfiTO7Ox85p3phnnDX7AKAfGHp10+QhPDsg+Ob2bUJ1fqVaIicl0UNj
X-Gm-Message-State: AOJu0Yw+mMVbJ/tEj/rtF51vg/3/k/hat99u0AIClx+ugB/0syvqiuaU
	41DS6s5z//SqNOAAQxeNH0O02Gebqu/k64w6ES/7u4AJgAAMmU2pdx89EvEugaQ=
X-Google-Smtp-Source: AGHT+IFkatZ4wwupzmAn8lx3iUcH4IllYVahxeNpS0mhut67Vq4+WTiNb3F+8vfRLcnn2NPZ8stdHQ==
X-Received: by 2002:a2e:9891:0:b0:2df:907e:6da2 with SMTP id b17-20020a2e9891000000b002df907e6da2mr5258082ljj.1.1714403192800;
        Mon, 29 Apr 2024 08:06:32 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2fec:d20:2b60:e334])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm39646638wms.32.2024.04.29.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:06:31 -0700 (PDT)
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
Subject: [PATCH v4 02/11] riscv: add ISA extensions validation
Date: Mon, 29 Apr 2024 17:04:55 +0200
Message-ID: <20240429150553.625165-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429150553.625165-1-cleger@rivosinc.com>
References: <20240429150553.625165-1-cleger@rivosinc.com>
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
temporary bitmap before enabling it in the final isa bitmap. validate()
callbacks can return either 0 for success, -EPROBEDEFER if extension
needs to be validated again at next loop. A previous ISA bitmap is kept
to avoid looping mutliple times if an extension dependencies are never
satisfied until we reach a stable state. In order to avoid any potential
infinite looping, allow looping a maximum of the number of extension we
handle. Zicboz and Zicbom extensions are modified to use this validation
mechanism.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |   1 +
 arch/riscv/kernel/cpufeature.c      | 211 ++++++++++++++++------------
 2 files changed, 126 insertions(+), 86 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..000796c2d0b1 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -70,6 +70,7 @@ struct riscv_isa_ext_data {
 	const char *property;
 	const unsigned int *subset_ext_ids;
 	const unsigned int subset_ext_size;
+	int (*validate)(const struct riscv_isa_ext_data *data, const unsigned long *isa_bitmap);
 };
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 115ba001f1bc..cb2ffa6c8c33 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -72,51 +72,58 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
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
-		return false;
+	return id != RISCV_ISA_EXT_INVALID;
+}
+
+static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
+{
+	if (!riscv_cbom_block_size) {
+		pr_err("Zicbom detected in ISA string, disabling as no cbom-block-size found\n");
+		return -EINVAL;
+	} else if (!is_power_of_2(riscv_cbom_block_size)) {
+		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
+		return -EINVAL;
 	}
+	return 0;
+}
 
-	return true;
+static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
+{
+	if (!riscv_cboz_block_size) {
+		pr_err("Zicboz detected in ISA string, disabling as no cboz-block-size found\n");
+		return -EINVAL;
+	} else if (!is_power_of_2(riscv_cboz_block_size)) {
+		pr_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
+		return -EINVAL;
+	}
+	return 0;
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
@@ -247,8 +254,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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
@@ -310,33 +319,80 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 
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
+static void __init riscv_resolve_isa(unsigned long *isa_bitmap, struct riscv_isainfo *isainfo,
+				     unsigned long *this_hwcap, unsigned long *isa2hwcap)
+{
+	bool loop;
+	const struct riscv_isa_ext_data *ext;
+	DECLARE_BITMAP(prev_bitmap, RISCV_ISA_EXT_MAX);
+	int max_loop_count = riscv_isa_ext_count, ret;
+
+	do {
+		loop = false;
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
+			if (ext->validate) {
+				ret = ext->validate(ext, isainfo->isa);
+				if (ret) {
+					if (ret == -EPROBE_DEFER)
+						loop = true;
+					else
+						clear_bit(ext->id, isa_bitmap);
+					continue;
+				}
+			}
 
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
+	} while (loop && memcmp(prev_bitmap, isainfo->isa, sizeof(prev_bitmap)));
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
@@ -349,7 +405,7 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 	while (*isa) {
 		const char *ext = isa++;
 		const char *ext_end = isa;
-		bool ext_long = false, ext_err = false;
+		bool ext_err = false;
 
 		switch (*ext) {
 		case 's':
@@ -389,7 +445,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 			 * character itself while eliminating the extensions version number.
 			 * A simple re-increment solves this problem.
 			 */
-			ext_long = true;
 			for (; *isa && *isa != '_'; ++isa)
 				if (unlikely(!isalnum(*isa)))
 					ext_err = true;
@@ -469,17 +524,8 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 
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
 
@@ -501,6 +547,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 		unsigned long this_hwcap = 0;
+		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) = { 0 };
 
 		if (acpi_disabled) {
 			node = of_cpu_device_node_get(cpu);
@@ -523,7 +570,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			}
 		}
 
-		riscv_parse_isa_string(&this_hwcap, isainfo, isa2hwcap, isa);
+		riscv_resolve_isa_string(isa, isa_bitmap);
 
 		/*
 		 * These ones were as they were part of the base ISA when the
@@ -531,10 +578,10 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
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
@@ -548,9 +595,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
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
@@ -579,6 +628,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		unsigned long this_hwcap = 0;
 		struct device_node *cpu_node;
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
+		DECLARE_BITMAP(isa_bitmap, RISCV_ISA_EXT_MAX) = { 0 };
 
 		cpu_node = of_cpu_device_node_get(cpu);
 		if (!cpu_node) {
@@ -598,22 +648,11 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
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


