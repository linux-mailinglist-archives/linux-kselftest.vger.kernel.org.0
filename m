Return-Path: <linux-kselftest+bounces-24419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54FAA0FEAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 03:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E3E3A1F4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586F230982;
	Tue, 14 Jan 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PHz4bjiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F52230995
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821230; cv=none; b=gCf9/7wpnK075ny5m62x5yZbBvYiHeZtyr17KfCQPL1WZVnAmWCzm4DRTIw8GH4ttOUR3UbI8sNtYmbaD1ZgQ04/AFUFSWejgC3F38k64uI8rDIuP3kT2oN91c7PB+RBR2rc0Wsd1F6VfR3go7+2CEg8lsuCpCu9FgF5CniQqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821230; c=relaxed/simple;
	bh=RG69VaO0q4YKhIgGWtAci4+TZ0O6tJyGpCJxcS2uc9g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KujyyzQ6/QnWKNK+6Kjxehd+1HaQbcxISd6JXh+Ito2+kY7dthRPth20NqeVsq21XMnJFLng6/SllinBsNb6EovuXe/A/4eqO3OWWpSrBMI6h1s/lsIVM0MfaqinyppG6jWuqPNapXga7TaJr6yIqw0fEiJslm5bFpR/xOZJpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PHz4bjiw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216634dd574so57063795ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 18:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736821227; x=1737426027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBNMHaJ4/jliKhn3dX1fpdixipAbOn0nv46ZAdfBeMA=;
        b=PHz4bjiw/VpA5DmTnFuH9pedoUxysgvOTOqbJ8a6TEyHYG4zjvTfFCaCmcOuZraCOB
         3TtN3YJWQEAnkPYag3LaUvt3kcPwhyS9Lk0k0/Ya7zVbMrCgIwbEZQtO425g5E8rSRvb
         C6Z7kP4JEnhngJweTVtX6zwFeNTN8wEcRl3RkEUxI9ZOIsoZJ8YDGGuxEGEwSFCOmcf2
         qxrGxiJgQ+YJsDgwFS0R2cNEySTZgcouYKDi7QCjwB+VzkO4stTuh1mJVILy0Wy0bMq0
         GqIBsU/UK2sUH4pUkvlJko426xJYVToA0gNQWcJsaaIfDFX7zV/IhKwLd/3S5jXifLJb
         3iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821227; x=1737426027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBNMHaJ4/jliKhn3dX1fpdixipAbOn0nv46ZAdfBeMA=;
        b=iUaVkpniKFNar4kdGGfD65cd1jG5DrAvS2wZ7MIp8+wWmX2WE86ZZVacbzy7gUw67k
         gqgQv7a/XLs/1JCrp5Vb7R4hwNX3URIxLREWproJlUNPWqWFli++9EN4g4HtZ5E2WogL
         Z2rq5mZr4CetHMpeqHudhq8SSOegBS4YZR5zvZ+SR2K8GZoYyVkYerno/4/h8yHQG/ID
         zBdv/G5Z6W9+eEhK4nP1vNcTABbqDFWu6EjJfjN//EZGmeDgJY8iXqNqQpMCP4ykip4F
         lKnBcvfIOOXxLLX0UA4F+CLZ+++P8YXxzl3fPaorFvwWCkG5hhggS3EDtI8nmZl4Kn3H
         p7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgIeUwVhXrQZdkYOkVfO5+v/R0GnQZQ62zHa1MqwOw6qVUd1rodBtEdoTr28UDQ2G4KwfDfsR5JILKzLiUrHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2WwlDhRpm6gDh2PU0SYdMBPZCh2YJjcQc9+ifxdyc/FifRSh
	5dd7r8YDBXtC2ZZpcBZxiVqYPQjjqH7TDRR4ufO7864MUk+YYMSft/mSnpNHK4o=
X-Gm-Gg: ASbGncvwWkvQiPSoIUYt+uwLmip4fFMVpD3/fWyf/isCfpIZjUercuyV5QohyfVljOU
	McMD8tQANCLJZ7aJC6UQ6YyDe6nhbC5FZ5E59WuDmYsUSxWlOCqYlSlkMA2y7V9VQNnz7A2frqw
	NlOI48xOiHB47Bp0BgXMbECTYEelpepNy5t9JIAmdUMoekFjlRDy95PajCj3M1fMD3QvyxEmcNV
	Go0+KQzX8+JfmInuOjUz2h/BkrGVWwGnPYRCWt5BnRBG4zdluoLBe2ZfrSPtoRCNFfgWR0XKdHr
	z/39Kfm8qi73T44=
X-Google-Smtp-Source: AGHT+IE8gXNlz9uvRlAxGGGoxzeSxnCrgIxrMIHzdxRxrwL5DTCwEfXr5I7vV5OOSc2ZZIkB+wm2Yw==
X-Received: by 2002:a17:903:124d:b0:20b:7210:5859 with SMTP id d9443c01a7336-21a83fe4982mr290497735ad.38.1736821227154;
        Mon, 13 Jan 2025 18:20:27 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217b38sm58948065ad.145.2025.01.13.18.20.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:20:26 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v4 2/3] RISC-V: hwprobe: Expose Zicbom extension and its block size
Date: Tue, 14 Jan 2025 10:19:35 +0800
Message-Id: <20250114021936.17234-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250114021936.17234-1-cuiyunhui@bytedance.com>
References: <20250114021936.17234-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose Zicbom through hwprobe and also provide a key to extract its
respective block size.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 955fbcd19ce9..0ea7754b2049 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -242,6 +242,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
        defined in version 1.0 of the RISC-V Pointer Masking extensions.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOM`: The Zicbom extension is supported, as
+       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
@@ -281,6 +284,9 @@ The following keys are defined:
 * :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF`: An enum value describing the
      performance of misaligned vector accesses on the selected set of processors.
 
+* :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
+  represents the size of the Zicbom block in bytes.
+
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN`: The performance of misaligned
     vector accesses is unknown.
 
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 1ce1df6d0ff3..89379f9a2e6e 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 10
+#define RISCV_HWPROBE_MAX_KEY 11
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 3af142b99f77..b15c0bd83ef2 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICBOM	(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
@@ -94,6 +95,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW		2
 #define		RISCV_HWPROBE_MISALIGNED_VECTOR_FAST		3
 #define		RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED	4
+#define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE	11
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cb93adfffc48..04150e62f998 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -106,6 +106,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCA);
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
+		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
@@ -278,6 +279,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
 			pair->value = riscv_cboz_block_size;
 		break;
+	case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
+		pair->value = 0;
+		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
+			pair->value = riscv_cbom_block_size;
+		break;
 	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
 		pair->value = user_max_virt_addr();
 		break;
-- 
2.39.2


