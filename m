Return-Path: <linux-kselftest+bounces-8087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206FF8A6240
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABAD282143
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81615A492;
	Tue, 16 Apr 2024 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jv1UtkgB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E5159907
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240746; cv=none; b=EDAi3wLy8/rr99PjfGCmMVoKEtgc/L6JqtfPqpNOOEb+ivN+SRPXBmjzd6yYezo75zphcUXessTIs/1HhZyviqy8qj7m9Iyyt72p++A4/DYMvFglwnmo5SlBp8hPjqhnABAl/rdoisS8MD3Kdba8sWEGRmxZefnbwGQiUdUaxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240746; c=relaxed/simple;
	bh=xqkFWr+oImyzQ0JDwVIFghGiFX1OGy/hCRBHcZtb9a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ERUKIOuW9MuwOtcl+uibwsvJd0/NhYIGmlUP/ptErVdAtcYEkrIgM0EY5qml7DeOWrsMl/4TX+Ure+oD5qrRYMi6SD2mrOkYuGiYca19K2jsExfg+PTHvgkBGxCGEieaPZNmkwkWN4frpqhw2e8bU/McSkF1ly7yyZJsXUWIt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jv1UtkgB; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa1b7a37b5so2745659eaf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240744; x=1713845544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOetgtyntPM1sQ5OeR35sjTF274eZVTe4hY2Mr7WVUk=;
        b=jv1UtkgBlD5I8jgZNWJgz+q+QchK+8kW/ApEQ1UjzrDv7qhnhUuBDQ5TnS/aifiu4n
         xELrCel0QQPFyUT1KeAVIfKSDqiUt+xOxf841Ps+/m4YDIhWyPsVkoQYGYvNbCPFq7X6
         XdhP4V5EkMo/IlAS5G8SqDu8vCjDpjbSkwOiMZDTS9O2njXMr71UpbyWg+ZJF6rFiSXy
         34NMr2nRam9qGoMazcm08jIkoxrkjw3Z6A+GQO+1CHd+GuvH8fkL/08cz09fRdT5zfGR
         e8KooNFD12lVS00OiqLkmSZKrLVtEVHzkYxKeYP4s1L9phPxLJxgu3pQOdsd2HE6L61A
         WhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240744; x=1713845544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOetgtyntPM1sQ5OeR35sjTF274eZVTe4hY2Mr7WVUk=;
        b=QhR8607Bhi35CTJQeShnp8dUR1hEz5yu5UUnyWx5SD4wyYg4lXTJ5WLmTQHRwdSJ19
         M1saulldX0CmwKOiAW0veG5WqkG4yWHskcoU75vTezRa/Dx12D0n5k/NpDLQ0rOOdibt
         t/TNYigqPaWdC+efz9hTsUSc85B6B/L3TiZ8QsUzMKo0GUa+K5hZqXeqv6VppnAh8t7I
         XR/8W0nqRW4nMhwTOD7hq2B08XCfUakWSN3EUSYWyulT5YmrLQ+RxFjGJ3+1mqwIn+fG
         MTuqhLXqWvOa2X4rGC1W7X0sRFw1YyoCBL9Dr9UkI1BEVegOURS94PsRuJEHipaxqyfu
         RFow==
X-Forwarded-Encrypted: i=1; AJvYcCWiMs1QUAIAFh1iQ6VkuOQh2mzaraWFdXAEUIHhJwNiJpA02kLf9ZQscp2zh4USQ65zpQxqtqSwYzNzX0elHzY6kK6LjEWrKtrp2/7Ne9fV
X-Gm-Message-State: AOJu0Yx8x2wGJxIlRs3KTUogtAb4zrFvo5Q2VMdKKDS1N0lUm53dM9dM
	20KG/Z2B257i+OG6OSfgmduFE/g4XUXytgyT+nuDueJxzofJ0Ngv7pGZWBqJD8k=
X-Google-Smtp-Source: AGHT+IERQO5n2Vb9B9QZDYR+KRQH6Iyecu+hDVCp8hPPx8PhhyKH4HSl99iHFZWCmmlfxJDCqqIcFA==
X-Received: by 2002:a05:6870:f10c:b0:22e:bd35:d3fb with SMTP id k12-20020a056870f10c00b0022ebd35d3fbmr12554232oac.22.1713240744106;
        Mon, 15 Apr 2024 21:12:24 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:23 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 15 Apr 2024 21:12:11 -0700
Subject: [PATCH v2 14/17] riscv: hwprobe: Add vendor extension probing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-14-c7d68c603268@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=5374;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=xqkFWr+oImyzQ0JDwVIFghGiFX1OGy/hCRBHcZtb9a4=;
 b=T7sIxScpT71u4soPN2p/gqkV3qOsg1bk7KkRmGenJjz3ue3nUXSxfY3aZtpys+w4N1hEdTuZ7
 MQrs3G2aalXBXQf7VoQ3FVs9LQKs+dIv7K4wL5F2lCovv+sfsaDuefC
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which allows
userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR vendor
extension.

This new key will allow userspace code to probe for which vendor
extensions are supported. This API is modeled to be consistent with
RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
corresponding to a supported vendor extension of the cpumask set. Just
like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program to
determine all of the supported vendor extensions in one call.

The vendor extensions are namespaced per vendor. For example, if the all
of the cpus in the cpumask have an mvendorid of THEAD_VENDOR_ID, bit
0 being set means that RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR is
  supported. If the mvendorid is instead VENDOR2, bit 0 being set will
imply a different available extension. This allows for a single hwprobe
call that can be applicable to any vendor.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/hwprobe.h           |  4 +--
 arch/riscv/include/uapi/asm/hwprobe.h      | 11 ++++++-
 arch/riscv/include/uapi/asm/vendor/thead.h |  3 ++
 arch/riscv/kernel/sys_hwprobe.c            | 50 ++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 1378c3c9401a..3bcb291eb386 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * Copyright 2023 Rivos, Inc
+ * Copyright 2023-2024 Rivos, Inc
  */
 
 #ifndef _ASM_HWPROBE_H
@@ -9,7 +9,7 @@
 #include <linux/cpumask.h>
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 6
+#define RISCV_HWPROBE_MAX_KEY 7
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..142b5c37730b 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * Copyright 2023 Rivos, Inc
+ * Copyright 2023-2024 Rivos, Inc
  */
 
 #ifndef _UAPI_ASM_HWPROBE_H
@@ -67,6 +67,15 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+/*
+ * It is not possible for one CPU to have multiple vendor ids, so each vendor
+ * has its own vendor extension "namespace". The keys for each vendor starts
+ * at zero.
+ *
+ * All vendor extension keys live in a vendor-specific header under
+ * arch/riscv/include/uapi/asm/vendor
+ */
+#define RISCV_HWPROBE_KEY_VENDOR_EXT_0	7
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
index 394f1343490c..15ce916a7321 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -139,6 +139,52 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	pair->value &= ~missing;
 }
 
+static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pair,
+				    const struct cpumask *cpus)
+{
+	int cpu;
+	u64 missing = 0;
+
+	pair->value = 0;
+
+	struct riscv_hwprobe mvendorid = {
+		.key = RISCV_HWPROBE_KEY_MVENDORID,
+		.value = 0
+	};
+
+	hwprobe_arch_id(&mvendorid, cpus);
+
+	/* Set value to zero if CPUs in the set do not have the same vendor. */
+	if (mvendorid.value == -1ULL)
+		return;
+
+	/*
+	 * Loop through and record vendor extensions that 1) anyone has, and
+	 * 2) anyone doesn't have.
+	 */
+	for_each_cpu(cpu, cpus) {
+		struct riscv_isainfo *isavendorinfo = &hart_isa_vendor[cpu];
+
+#define VENDOR_EXT_KEY(vendor, ext)							\
+	do {										\
+		if (mvendorid.value == (vendor) &&					\
+		    __riscv_isa_vendor_extension_available(isavendorinfo->isa,		\
+							   RISCV_ISA_VENDOR_EXT_##ext))	\
+			pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;			\
+		else									\
+			missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;			\
+	} while (false)
+
+		/* T-Head extensions */
+		VENDOR_EXT_KEY(THEAD_VENDOR_ID, XTHEADVECTOR);
+
+#undef VENDOR_EXT_KEY
+	}
+
+	/* Now turn off reporting features if any CPU is missing it. */
+	pair->value &= ~missing;
+}
+
 static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
 {
 	struct riscv_hwprobe pair;
@@ -216,6 +262,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			pair->value = riscv_cboz_block_size;
 		break;
 
+	case RISCV_HWPROBE_KEY_VENDOR_EXT_0:
+		hwprobe_isa_vendor_ext0(pair, cpus);
+		break;
+
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
 	 * call, but get their element key set to -1 and value set to 0

-- 
2.44.0


