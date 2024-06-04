Return-Path: <linux-kselftest+bounces-11191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994D58FB2B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C8F284437
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664111487EF;
	Tue,  4 Jun 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="q7ZAO1cy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF9146D73
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505252; cv=none; b=ZJjXg4CucV1DLVpNMRZoUWUIs2TunCoLBaQU6cf/IaDQFVVJ2QwjTDtJiZKVkaKPbLHo7VBSM8ClYVj3FRmiP2+nurKVaKQHV875Yp+VgNn6lLQ9cxPQ3OMQ7PImPodNaCkMJjtJJRYIJir+jbzHC5yL42EdEPcLw5z4O0gt9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505252; c=relaxed/simple;
	bh=Dz6rVhVKb6YAyj1zk8JN02/3lhxWQ4WyTB/tu2GRhno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTvVgosFSkSENJYkjillRni8ACn1Jj5Eroxx4PsKGIWQsGuALBYMrZjhJhVDc4ZKMeEpb5ecqsWFZxad8I+nS/Kg/lhX2H3aVukNwkbE7UboDBvo9zyHv6foAgZ4x3TnWH2odVng7DUB+aiQuHRv877wOutaopQOuqLqoAz9Scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=q7ZAO1cy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f61392237fso1691195ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2024 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717505250; x=1718110050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+CSuJDThn+PB5fFUO+TXaSj7k0OUg7Xto567Lc3KzY=;
        b=q7ZAO1cy9RbIe2OLX7f1yMF75C7+pcAGKSCsv8iYM3k0E/pheXrNt/NqRdIPcXEVBr
         qXewTI0KaGr0f0iJpCPffFmcq032YX0oGx2QQut/ISKA4cdtYISV2QfrJ5yprKSnKDWl
         YumkPpZBtrBK5DRKr53zLdPB78WtULtuIaP8sOaxtztM2j6saVWG2RpOptNWMSle+A5Y
         pcwoVMa225LeKphjAu75aLcRTMYFubrBrhyyFI72jwMvOhy360/mWFz/WPjTvsv25cD5
         i4RGuO8PMUhsdgfz7/39VBmUfdfjAaa2gcYm72Ef5bZ6qXoe5rmpg3cO8uGuCU4fm4i9
         ECTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505250; x=1718110050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+CSuJDThn+PB5fFUO+TXaSj7k0OUg7Xto567Lc3KzY=;
        b=lewzQouQ84ZyQC3Gt7JEmvw5ta9cGHetLbJ5XI1NZ8X9xxXzr3f5LiJOfplA568LPD
         xAsUQFb9MuddonsNirut3ThD2DDYJQxTMIHQbZqS+NKMfXHmHwLaOZ1ommChynukLskU
         AmnOq+hBlv+VyR0J/E/wqPwIyYDRGofp2eNfR6CxfMGcipiGClICo0uGGSkGrJtVOYqF
         SU+sm11wTS/2/5keRalUWqbTfEm2saxt01i9afExe9cVrjkuiOKv0jZP0YT8vr3nNWmH
         PSj5foV5ZWdrr9d2e4XusyGp6ZmqblVgL10DKAqefyUnXLJlEqq+2vKIc5JekvB5hMNf
         2Ddg==
X-Forwarded-Encrypted: i=1; AJvYcCUoP/m1adQZidlaAA7+SpfiJQnZXQF+JVPf9h8Ke+d3outAudZm23t+7u6yhbqCYq5mZZD9VtsJd66dLoWPS+831PrSNUBHGQWFG6ABgb4A
X-Gm-Message-State: AOJu0YwMXu3JqZZuI/ribzMMdzIoTz0md+eM6B36Esxuepu0ofqLvzuq
	jIzCLl4nnY6Lu8uNSZMt5xvjXoOpktGdZs4eVTePr+X+gSHYHIAQEllsLED8kJE=
X-Google-Smtp-Source: AGHT+IEy/LhwmIRZMH6aWZXrXK2uhRFHFVKmWf3P2U0Efxg286NPvZUcvjcoIBkiD+YHR73bgi+W9w==
X-Received: by 2002:a17:902:f68b:b0:1f6:39cc:46cb with SMTP id d9443c01a7336-1f639cc52ccmr132729485ad.5.1717505249853;
        Tue, 04 Jun 2024 05:47:29 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:327b:5ba3:8154:37ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ebc69sm83042885ad.211.2024.06.04.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:47:29 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 07/16] riscv: add ISA extensions validation callback
Date: Tue,  4 Jun 2024 14:45:39 +0200
Message-ID: <20240604124550.3214710-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604124550.3214710-1-cleger@rivosinc.com>
References: <20240604124550.3214710-1-cleger@rivosinc.com>
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
temporary bitmask (source isa) without any validation. The second step
"resolves" the final isa bitmap, handling potential missing dependencies.
The mechanism is quite simple and simply validate each extension
described in the source bitmap before enabling it in the resolved isa
bitmap. validate() callbacks can return either 0 for success,
-EPROBEDEFER if extension needs to be validated again at next loop. A
previous ISA bitmap is kept to avoid looping multiple times if an
extension dependencies are never satisfied until we reach a stable
state. In order to avoid any potential infinite looping, allow looping
a maximum of the number of extension we handle. Zicboz and Zicbom
extensions are modified to use this validation mechanism.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/cpufeature.h |   1 +
 arch/riscv/kernel/cpufeature.c      | 221 +++++++++++++++++-----------
 2 files changed, 136 insertions(+), 86 deletions(-)

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
index bd1597578fbc..d20e236cec8b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -72,51 +72,55 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
-static bool riscv_isa_extension_check(int id)
+static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
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
+	if (!riscv_cbom_block_size) {
+		pr_err("Zicbom detected in ISA string, disabling as no cbom-block-size found\n");
+		return -EINVAL;
 	}
+	if (!is_power_of_2(riscv_cbom_block_size)) {
+		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
+		return -EINVAL;
+	}
+	return 0;
+}
 
-	return true;
+static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
+{
+	if (!riscv_cboz_block_size) {
+		pr_err("Zicboz detected in ISA string, disabling as no cboz-block-size found\n");
+		return -EINVAL;
+	}
+	if (!is_power_of_2(riscv_cboz_block_size)) {
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
@@ -247,8 +251,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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
@@ -310,33 +316,93 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 
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
+	if (ext->id != RISCV_ISA_EXT_INVALID)
+		set_bit(ext->id, bitmap);
+
+	for (int i = 0; i < ext->subset_ext_size; i++) {
+		if (ext->subset_ext_ids[i] != RISCV_ISA_EXT_INVALID)
+			set_bit(ext->subset_ext_ids[i], bitmap);
+	}
+}
+
+static const struct riscv_isa_ext_data *riscv_get_isa_ext_data(unsigned int ext_id)
+{
+	for (int i = 0; i < riscv_isa_ext_count; i++) {
+		if (riscv_isa_ext[i].id == ext_id)
+			return &riscv_isa_ext[i];
+	}
+
+	return NULL;
+}
+
+/*
+ * "Resolve" a source ISA bitmap into one that matches kernel configuration as
+ * well as correct extension dependencies. Some extensions depends on specific
+ * kernel configuration to be usable (V needs CONFIG_RISCV_ISA_V for instance)
+ * and this function will actually validate all the extensions provided in
+ * source_isa into the resolved_isa based on extensions validate() callbacks.
+ */
+static void __init riscv_resolve_isa(unsigned long *source_isa,
+				     unsigned long *resolved_isa, unsigned long *this_hwcap,
+				     unsigned long *isa2hwcap)
+{
+	bool loop;
+	const struct riscv_isa_ext_data *ext;
+	DECLARE_BITMAP(prev_resolved_isa, RISCV_ISA_EXT_MAX);
+	int max_loop_count = riscv_isa_ext_count, ret;
+	unsigned int bit;
+
+	do {
+		loop = false;
+		if (max_loop_count-- < 0) {
+			pr_err("Failed to reach a stable ISA state\n");
+			return;
+		}
+		bitmap_copy(prev_resolved_isa, resolved_isa, RISCV_ISA_EXT_MAX);
+		for_each_set_bit(bit, source_isa, RISCV_ISA_EXT_MAX) {
+			ext = riscv_get_isa_ext_data(bit);
+			if (!ext)
+				continue;
+
+			if (ext->validate) {
+				ret = ext->validate(ext, resolved_isa);
+				if (ret == -EPROBE_DEFER) {
+					loop = true;
+					continue;
+				} else if (ret) {
+					/* Disable the extension entirely */
+					clear_bit(ext->id, source_isa);
+					continue;
+				}
 			}
+
+			set_bit(ext->id, resolved_isa);
+			/* No need to keep it in source isa now that it is enabled */
+			clear_bit(ext->id, source_isa);
+
+			/* Single letter extensions get set in hwcap */
+			if (ext->id < RISCV_ISA_EXT_BASE)
+				*this_hwcap |= isa2hwcap[ext->id];
 		}
+	} while (loop && memcmp(prev_resolved_isa, resolved_isa, sizeof(prev_resolved_isa)));
+}
 
-		/*
-		 * This is valid even for bundle extensions which uses the RISCV_ISA_EXT_INVALID id
-		 * (rejected by riscv_isa_extension_check()).
-		 */
-		if (riscv_isa_extension_check(ext->id))
-			set_bit(ext->id, isainfo->isa);
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
+static void __init riscv_parse_isa_string(const char *isa, unsigned long *bitmap)
 {
 	/*
 	 * For all possible cpus, we have already validated in
@@ -349,7 +415,7 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 	while (*isa) {
 		const char *ext = isa++;
 		const char *ext_end = isa;
-		bool ext_long = false, ext_err = false;
+		bool ext_err = false;
 
 		switch (*ext) {
 		case 's':
@@ -389,7 +455,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 			 * character itself while eliminating the extensions version number.
 			 * A simple re-increment solves this problem.
 			 */
-			ext_long = true;
 			for (; *isa && *isa != '_'; ++isa)
 				if (unlikely(!isalnum(*isa)))
 					ext_err = true;
@@ -469,17 +534,8 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 
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
 
@@ -506,6 +562,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 		unsigned long this_hwcap = 0;
+		DECLARE_BITMAP(source_isa, RISCV_ISA_EXT_MAX) = { 0 };
 
 		if (acpi_disabled) {
 			node = of_cpu_device_node_get(cpu);
@@ -528,7 +585,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			}
 		}
 
-		riscv_parse_isa_string(&this_hwcap, isainfo, isa2hwcap, isa);
+		riscv_parse_isa_string(isa, source_isa);
 
 		/*
 		 * These ones were as they were part of the base ISA when the
@@ -536,10 +593,10 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 * unconditionally where `i` is in riscv,isa on DT systems.
 		 */
 		if (acpi_disabled) {
-			set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
-			set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
-			set_bit(RISCV_ISA_EXT_ZICNTR, isainfo->isa);
-			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
+			set_bit(RISCV_ISA_EXT_ZICSR, source_isa);
+			set_bit(RISCV_ISA_EXT_ZIFENCEI, source_isa);
+			set_bit(RISCV_ISA_EXT_ZICNTR, source_isa);
+			set_bit(RISCV_ISA_EXT_ZIHPM, source_isa);
 		}
 
 		/*
@@ -552,9 +609,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 */
 		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
 			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
-			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
+			clear_bit(RISCV_ISA_EXT_v, source_isa);
 		}
 
+		riscv_resolve_isa(source_isa, isainfo->isa, &this_hwcap, isa2hwcap);
+
 		/*
 		 * All "okay" hart should have same isa. Set HWCAP based on
 		 * common capabilities of every "okay" hart, in case they don't
@@ -583,6 +642,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		unsigned long this_hwcap = 0;
 		struct device_node *cpu_node;
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
+		DECLARE_BITMAP(source_isa, RISCV_ISA_EXT_MAX) = { 0 };
 
 		cpu_node = of_cpu_device_node_get(cpu);
 		if (!cpu_node) {
@@ -602,22 +662,11 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 						     ext->property) < 0)
 				continue;
 
-			if (ext->subset_ext_size) {
-				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
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
+			riscv_isa_set_ext(ext, source_isa);
 		}
 
+		riscv_resolve_isa(source_isa, isainfo->isa, &this_hwcap, isa2hwcap);
+
 		of_node_put(cpu_node);
 
 		/*
-- 
2.45.1


