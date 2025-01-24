Return-Path: <linux-kselftest+bounces-25068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44035A1AF42
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 05:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C52188EF08
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 04:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9651A1D7998;
	Fri, 24 Jan 2025 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V4a7qL/C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039581D86ED
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691272; cv=none; b=NXhhaHo/NMJDMH1bz/8LiTHhOsy3Hjfnxq8r0M+iF2TF2iwCxR/cVT1hj/LeC3/pysIofhtt86ejMXd8eLRlb8DTLl0Icg1636uu7R1YSR7sI6r6vDiVgUMlIkpL3W/Yew+VfUeiL/yv7avxfkYatrTFwNXslnzYFlVm80kvOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691272; c=relaxed/simple;
	bh=c9cRr3mQ6E+Sm3MLQkn4R9H1H/29MlPqeqytx1/YJ6o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3jPuzK0m4TS1aiLrfUiMqHvm5TSYbsry0n/lfZE7qEbVbpHEqVmRHZg18YQKWOqApuczduITXFylEepN3WgodZopYa0qSS0XAJcRV+YFK4v0iENS4BKJD0S5NPHn7KEAGKdPLSoLtkplr4F5blqq9ClRIr7iK8185oO4Gp53ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V4a7qL/C; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21634338cfdso37017875ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 20:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737691270; x=1738296070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhogcwNy3A24ar7Arj4nwWwwc1NEi0tTGPamBbIerrs=;
        b=V4a7qL/CZs9+Osc/GlPovuNHPwpgPacFo3vDmMzv0W6ccftR7VLJsWJ2u0gMmB733v
         A73td9H0BY2g28Abfz2hlNA/iMHGE4S0usnl8NAtDBTA/Xtm8WiCLl2b7eoDiWu+aEJ+
         4UMMjOlDArU1zVZcr/V61rgQ5Dq/Omv4Csd4+GAI0y/PQlA+7+pvRAth4ZIXMCNdwNwi
         OHCQvIJP29jaPIioe/X3yfo9nUuaW228/ZKTtlyqG20hp3/TQHZTh6vnW5fY0B0VlyOj
         zPtr6eB1nleVWM/w56MmFg0cgga+WhP4uohGyaerY4wjYbP/fnQYrejouAeNupW0UMb0
         6vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691270; x=1738296070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhogcwNy3A24ar7Arj4nwWwwc1NEi0tTGPamBbIerrs=;
        b=FSiSsaO11ZrY3/B7+6wFaKpNPIo95/hTY582W+GWBNvGoADtSIW4Nzvn5gBNdJGZPB
         fghDGUkJqEp6CiPSfnuRaOvJAZIkwQZPU3+wbIPsifLgJ5b1m/usfw+Lxj/IU2k2ahNC
         ua3S6TONdjoO5tn9OOQH5wb/FJAImPb/HEl6iZN4xp7gmq6hsrc24tciCjni7K3CQvGp
         CKTPdUER9NRhQ5YCEnGGSP1l40JXX1tRhQgMlsYwu5g2JABHAvDMyXK4LcYc18S0+tdM
         GMJQa7PCbb8YveGD1ON2t00zIWgTVA4JD5tKkxWzharn7bZ4zoy15TR25InO/Du/iH4p
         VtTg==
X-Forwarded-Encrypted: i=1; AJvYcCV0KqXFFN3GqvEfgELXcW4a8/XTp1XU2P5VACSRnCMLMQkcf2Mip0SuYat8ngA34qDcVPhJX+zJwJLDFV1gmwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydocACx61crxmvdbMCSNVZZP/u1pZymXVUE5NiC7vBLCJjcoeB
	f5ient9lesGCkK5g0WAMqljn8cxtRdV2k2qOgO8VFsIJ7ThIWjEMjNoHZH0D1bw=
X-Gm-Gg: ASbGncvOx5zd3g0mm0qCX5veajRU1FAQZMz8i0+70mdLBudMhLkHBlrIiUJcGLOsP5p
	u5ZTLA9eeNsvyEqCisRQqgz4HQZDOW06lMD7KvgUFWYSZKaBVysWVHTLGARjO4iOK8BjDAF36DE
	+/0xs+z+NmYGRQ2LhqXRNuzz6lfFISPhpJQwtbgR6MnzfpWnLoU+uLTtg+/Hoa6qDR2R20OD3Pl
	ABJkRiQRmhhIXpox2TqH+tHT8ArDVHwBAoTkvu+pHqZbFIO3s9YrMenX9ArpdnWRTMn+odFpCgk
	FJ/xlnA8HaabZfIrW6Uq5/IflINp8fk2u+L/WIdtbxQVjtddQw==
X-Google-Smtp-Source: AGHT+IHypLNaXsQx1FvJy6sHsbSOt7rVRjml9Nk+TXnCiyBsirRqofRzqo0H1bHoO0B4nLDc9UgDlQ==
X-Received: by 2002:a17:903:1381:b0:216:361a:783d with SMTP id d9443c01a7336-21c3562097amr473816585ad.28.1737691270197;
        Thu, 23 Jan 2025 20:01:10 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([2408:8406:78d1:bf49:24c4:f518:9b3b:36de])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141d67sm6758915ad.153.2025.01.23.20.01.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 20:01:09 -0800 (PST)
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
Subject: [PATCH v6 2/3] RISC-V: hwprobe: Expose Zicbom extension and its block size
Date: Fri, 24 Jan 2025 11:59:58 +0800
Message-Id: <20250124035959.45499-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250124035959.45499-1-cuiyunhui@bytedance.com>
References: <20250124035959.45499-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose Zicbom through hwprobe and also provide a key to extract its
respective block size.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
 arch/riscv/include/asm/hwprobe.h      | 2 +-
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 8 +++++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 955fbcd19ce9..21323811a206 100644
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
@@ -293,3 +296,6 @@ The following keys are defined:
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED`: Misaligned vector accesses are
     not supported at all and will generate a misaligned address fault.
+
+* :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
+  represents the size of the Zicbom block in bytes.
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
index cb93adfffc48..b47939f5ffee 100644
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
@@ -160,7 +161,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	pair->value &= ~missing;
 }
 
-static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
+static bool hwprobe_ext0_has(const struct cpumask *cpus, u64 ext)
 {
 	struct riscv_hwprobe pair;
 
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


