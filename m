Return-Path: <linux-kselftest+bounces-12231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36BB90E9AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 13:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743F31F21B21
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08214C5BE;
	Wed, 19 Jun 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iFmdbzR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5C147C71
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796948; cv=none; b=tIrbdpwwfja2/1jN5jVYkESh298fyU6OYas3wfy093dY5X/i3QES8C3tJaxxGNku3hfUHz5FR7zgjtNsm6T4nc8vd21wbx4QGbWIEQ95Ri6EXUXiZuTMGyQAC9fla4RONg1g7cAFJmHqNy2i7pqj0G3JBCH/r2j5p5089YQiL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796948; c=relaxed/simple;
	bh=zzyhwnB2Y9AtTLf2/DPB+ILw9nooLAjSElFgZaKhN58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiHu9tQVaSvOozK+IAZqzFYUTQFyTof4tq9K5CZ1hKDGDaq8Jyq9BHP5Kjguoq1nE9Rrq7b7IGXBHNOUVFpuBHplbUzqQOHD+o0WpBOw3sb0fhfHCQT/NLcIUUqdQFJvxd1v2fRul8Ex67g2MbCUTlOU6MmX53KAQtHc0iapLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iFmdbzR+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36353a5d2ceso23892f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718796944; x=1719401744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnGfGukO8mRkvoU5UzJqQ+YrlyhRuMD5WxDieDf30Jk=;
        b=iFmdbzR+v0DVfpbF0kOY/RCt231YgSt+1bOD7sT617OEIN8oawpgNR/UCGKRn9JiHj
         Yax5+qdn7OSdQ7Ue/+4dnUDnucqY5BzZ+B3Z018/LBTx2lT+gVyTmjHHkee0HyykvT0J
         ojVc1O4O9uVquVCCkaAJNsJ3RWmfdtimxFHu3TlD0hFSxJo88rOOofVXZEi1yqqdcykD
         NxAOFk8lX0xW8n9Py+N5NZBGRWrLpyP4pe009IyceF/mpLthf/Z20GYIUybtU1Gi4hSN
         L7kg/NS/cxgAh4F9IQlrQkPXyyI61pIeRQ2yIXqmX5FSos9LaSKZrX1/QCBVy0mz/OZo
         OAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796944; x=1719401744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnGfGukO8mRkvoU5UzJqQ+YrlyhRuMD5WxDieDf30Jk=;
        b=DT4Zu0Q2y963rZm8J664pmSYgFC9zwkr7SF1OQp8vDjbUUHwSqmWBzwKIQU4D/Ou6m
         5tQ2RBzCSQ+3uP636jjbMkaUs/qdLIXW8XB8LGCpIwTvlA5xgQSdq3/BX0zh5p88gFUp
         9rygIuVxjEKMMnZ7sT22QzVdwRYfycX2gyaUy3fzJ+0Sl/LT43hM30fsvLa9r+AhxtwU
         OrtY8SHHzWtpHlZAaOu+mAWy5OF/Mf/uLE656/jUlaTpvUrswOIc/WsnRa+KoCHeWopj
         JlkAJhMyp4N9tcRIi9TV/vpqfwks09W5j8lA12gcfXrFaCNn2aD1s6X45J8VXmBxvjJ2
         xEow==
X-Forwarded-Encrypted: i=1; AJvYcCW7yk4olv4C+dJWxu+PILk/8fOY0VUF4C8dv5ILRIFKF6LiZXn3xQATBCNH05aU9ECbbMG3JPyPhrv+KZ8jSo1HbBAQtQGr0OBf+HfRvPYt
X-Gm-Message-State: AOJu0YxCnKexOXFaieYbgi5O154b9YjnF7+hRC/wWW87x8rlNyrT7m86
	PPYjcCJQxSawdKWgYhy2tLsNbSm4aCLKeNK1c8gHetFgh4+LGHCoH1zIj1uWc/A=
X-Google-Smtp-Source: AGHT+IGeDTIGhvMHXpR5f7z1r6wfKzzl0pgZUz+m4jQqMBktnIFO8WlFWqYusw9+HCL/qqCt7LQwnA==
X-Received: by 2002:a05:600c:511d:b0:423:445:4aad with SMTP id 5b1f17b1804b1-42475016e88mr16019345e9.0.1718796944315;
        Wed, 19 Jun 2024 04:35:44 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:e67b:7ea9:5658:701a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9681sm266192075e9.28.2024.06.19.04.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:35:43 -0700 (PDT)
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
Subject: [PATCH v7 07/16] riscv: add ISA extensions validation callback
Date: Wed, 19 Jun 2024 13:35:17 +0200
Message-ID: <20240619113529.676940-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619113529.676940-1-cleger@rivosinc.com>
References: <20240619113529.676940-1-cleger@rivosinc.com>
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
 arch/riscv/kernel/cpufeature.c      | 220 +++++++++++++++++-----------
 2 files changed, 136 insertions(+), 85 deletions(-)

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
index e5516ba14440..a3af976f36c9 100644
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
@@ -281,8 +285,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
 	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_v_exts),
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
@@ -349,33 +355,93 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 
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
@@ -388,7 +454,7 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 	while (*isa) {
 		const char *ext = isa++;
 		const char *ext_end = isa;
-		bool ext_long = false, ext_err = false;
+		bool ext_err = false;
 
 		switch (*ext) {
 		case 's':
@@ -428,7 +494,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 			 * character itself while eliminating the extensions version number.
 			 * A simple re-increment solves this problem.
 			 */
-			ext_long = true;
 			for (; *isa && *isa != '_'; ++isa)
 				if (unlikely(!isalnum(*isa)))
 					ext_err = true;
@@ -509,15 +574,7 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
 		if (unlikely(ext_err))
 			continue;
 
-		for (int i = 0; i < riscv_isa_ext_count; i++)
-			match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
-
-		if (!ext_long) {
-			int nr = tolower(*ext) - 'a';
-
-			if (riscv_isa_extension_check(nr))
-				*this_hwcap |= isa2hwcap[nr];
-		}
+		match_isa_ext(ext, ext_end, bitmap);
 	}
 }
 
@@ -544,6 +601,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 		unsigned long this_hwcap = 0;
+		DECLARE_BITMAP(source_isa, RISCV_ISA_EXT_MAX) = { 0 };
 
 		if (acpi_disabled) {
 			node = of_cpu_device_node_get(cpu);
@@ -566,7 +624,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			}
 		}
 
-		riscv_parse_isa_string(&this_hwcap, isainfo, isa2hwcap, isa);
+		riscv_parse_isa_string(isa, source_isa);
 
 		/*
 		 * These ones were as they were part of the base ISA when the
@@ -574,10 +632,10 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
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
@@ -590,9 +648,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
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
@@ -621,6 +681,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		unsigned long this_hwcap = 0;
 		struct device_node *cpu_node;
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
+		DECLARE_BITMAP(source_isa, RISCV_ISA_EXT_MAX) = { 0 };
 
 		cpu_node = of_cpu_device_node_get(cpu);
 		if (!cpu_node) {
@@ -640,22 +701,11 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
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
2.45.2


