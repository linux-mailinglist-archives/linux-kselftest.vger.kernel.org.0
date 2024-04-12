Return-Path: <linux-kselftest+bounces-7758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3546F8A24F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF0AB21F3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609C551C33;
	Fri, 12 Apr 2024 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XtjcSK5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD6502AC
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895125; cv=none; b=ps7OQVUqHS4Hex1a6cbH0UlYROeEQKPnxM3L8Kx2x89GrLHZfreOOwKs/41FEco4CqnK/wcRNPkQh6AzxO6FgS1ym0NimvDdX93igyCW4f9ANPvIMAqcFy8yCE4xYsI1KPR4GEE6xqoM/tsDcVo7K4DqB3BxppJGLSWDzLhY4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895125; c=relaxed/simple;
	bh=22c5/aVaNWuzr+hY+XBBKO5QM19i5NRomlGB0sHVgMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RngWx0wL9P6bh2VJJXSVaAu+JDdI722pPRgTuvJ0SCVLhOCf/z/dzZiWVm5jUJsb2qs+6IcQJ/F5U2woeqHbM4Y0oDR7W/nObV41Eo5SngqyZjLM5vC2wWcq+vUFJr+YJUvPgoYH9+ut629cuy4eDvnjAxLTdmr40UwjRJBhFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XtjcSK5L; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22ed72b0082so338276fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895121; x=1713499921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKwobcWgI8wbYxTmFBJi5ZSioPCQHdxuKYdZlkTVr/4=;
        b=XtjcSK5L9jhGHbzxsnYxlczialDfEOvNwR4/d+XN3TW9mWpHLtg1ToCtQZ0K7v0QKb
         hTmC+1IGCAiihKIOH7CQ5zsIyadGLwZ+DaqsWeNscTrJ8ni2g57j7FrJFVJVl9svC0mK
         2VD2UQirBUmKjgb90Fj6ltyBqu2tf+epmXIu9hZLe9gmzqbAmu2XTXRF++XkOPcM9GEq
         jr+ZVt+zwx9Su64A+poqc+an3PYYFogzCWIq6AXwrRgCJ7UfVWKJ7Mr66PwgZrOmF9dq
         Ro8bSBZIqpoqhVQS7F7hMrKnv1RsBI+wtoUoeTj1Zb4LxzgwvUCkj6h5ji3wN6vf3YQT
         VnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895121; x=1713499921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKwobcWgI8wbYxTmFBJi5ZSioPCQHdxuKYdZlkTVr/4=;
        b=ol5oQlRcCqUw4CGAJHWb3h+swLHYuVEmPuPOgLFCwnNbNTfwGeLjaqWvZ6gQBunxJH
         zdj6kER/eo3JUaYHTGMVyzcOg6uRfK9wFbrvK3sySV6pLBTUl9iEMiHwWS/h/JEo0zKW
         qIa098sZdJzkUPJ47femKLVpDpQ58eqPRk5bz8xS85Tl57TQMN0Za+gYlds1wWeCFkY3
         Pc6z2qoXjOLh3FyruRLPZn56UHADCm8dfJ7HekOttwsUZ7ouAROEiDgsgNj+9q0Oiekn
         Tgq88tT5wcs7k2h5zD255r5D6MhGFI/7HQN1MCGKmjC0/08+b48BBYtv95J/Jumm5/6D
         Qr7w==
X-Forwarded-Encrypted: i=1; AJvYcCUrCIgYUzevGEq475Fd/NdiV2yJhEau1gbLGB7gfJqdRAMWx9RlAs/DxNhB5RswlCYJfeK7B+4M38lS9hBsCc6mehNUxs+RVjqj94fFaQQq
X-Gm-Message-State: AOJu0Yy4IodejViTJkiKHNW2y97m+jwdkp6WdnGvb/WtlxrJt2jIf+Nq
	X4ZMBjq3KbcDmJQVXY8W3gyKE7hUW17S6mVRKOIbDigK2uoQwl/Qcco8opjAWQg=
X-Google-Smtp-Source: AGHT+IH/B2/q4/6s1iCXztXFmKC8ZMz57okvrKhf61ydgsJdbMqDfSUZTC+42ieBTBDQk8F0BlEoIg==
X-Received: by 2002:a05:6871:b216:b0:233:1027:af37 with SMTP id bb22-20020a056871b21600b002331027af37mr1371136oac.45.1712895121654;
        Thu, 11 Apr 2024 21:12:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:12:00 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:22 -0700
Subject: [PATCH 16/19] riscv: hwprobe: Add vendor extension probing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=5003;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=22c5/aVaNWuzr+hY+XBBKO5QM19i5NRomlGB0sHVgMA=;
 b=pSFVAl7ovaKyV4/QquVHHir19tkGWmouC1DS4HubxRE92K7fLdvS806y8SJCtr97rk2lVaa9+
 t6sWoWrVE9wDPWmXRGpxtPXEu9YureRbs6cYbraan8GObD8mTcJj6Qp
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which allows
userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR vendor
extension.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/hwprobe.h      |  4 +--
 arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++-
 arch/riscv/kernel/sys_hwprobe.c       | 59 +++++++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 630507dff5ea..e68496b4f8de 100644
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
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..6614d3adfc75 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * Copyright 2023 Rivos, Inc
+ * Copyright 2023-2024 Rivos, Inc
  */
 
 #ifndef _UAPI_ASM_HWPROBE_H
@@ -67,6 +67,14 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
+/*
+ * It is not possible for one CPU to have multiple vendor ids, so each vendor
+ * has its own vendor extension "namespace". The keys for each vendor starts
+ * at zero.
+ */
+#define RISCV_HWPROBE_KEY_VENDOR_EXT_0	7
+ /* T-Head */
+#define		RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR	(1 << 0)
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index e0a42c851511..365ce7380443 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -69,7 +69,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	if (riscv_isa_extension_available(NULL, c))
 		pair->value |= RISCV_HWPROBE_IMA_C;
 
-	if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
+	if (has_vector() &&
+	    !__riscv_isa_vendor_extension_available(NULL, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
 		pair->value |= RISCV_HWPROBE_IMA_V;
 
 	/*
@@ -112,7 +113,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZACAS);
 		EXT_KEY(ZICOND);
 
-		if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
+		if (has_vector() &&
+		    !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
 			EXT_KEY(ZVBB);
 			EXT_KEY(ZVBC);
 			EXT_KEY(ZVKB);
@@ -139,6 +141,55 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
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
+#define VENDOR_EXT_KEY(ext)								\
+	do {										\
+		if (__riscv_isa_vendor_extension_available(isavendorinfo->isa,		\
+							 RISCV_ISA_VENDOR_EXT_##ext))	\
+			pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;			\
+		else									\
+			missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;			\
+	} while (false)
+
+	/*
+	 * Only use VENDOR_EXT_KEY() for extensions which can be exposed to userspace,
+	 * regardless of the kernel's configuration, as no other checks, besides
+	 * presence in the hart_vendor_isa bitmap, are made.
+	 */
+	VENDOR_EXT_KEY(XTHEADVECTOR);
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
@@ -216,6 +267,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
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


