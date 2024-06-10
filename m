Return-Path: <linux-kselftest+bounces-11528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEFE9019EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 06:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9C61F2106E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 04:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876AB22625;
	Mon, 10 Jun 2024 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yyOmkZ49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393ED200AE
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994748; cv=none; b=nANeqrNi2PGjcwytMlmURTsaHtSPE+Y6OEEhMLHMS+QQ7z60BGZqp7zkU63bbmVzNR5AZPjHRpMweifNlfNiHL/lX1RK4YQlc+6BDXIlFU0q7isS7N82KxS9AdOdczYXcJftrLPPJ/tOgqg329UEWsiErX7kEImpsf2UIzGrWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994748; c=relaxed/simple;
	bh=4N9WDp7GVC3puitkjGgcI/jJcnDMobkD3Avh+NXutPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AOKz/saZngvnp3ozl6pkn0sc7XfwaC1vqF6lizUSR4o+TqvZb9bL988Txgndx0zwhuo14OSyRSgklillXnnKKrzTeFjJjsyTbufMgk7pEcPgYwL+F6CabJKbvT92OdlU1N0tgYFYPNvPaCRmDaApZNHiip/6YLDeOtTNFOa6vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yyOmkZ49; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f70509b811so5671155ad.1
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 21:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994746; x=1718599546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6wty7/5ckkbIMYQrfSGTFo0XViwtxD1A330OlnyF00=;
        b=yyOmkZ49G4qm/cyYP48nA2h2EsaAXvS6vzbp4V4F6sbFkHnSIG+OUExBc/PeazIDB8
         OFMOrY8mEywhUSMq32FEBiwlpGrFZd/fq+b+mdxZh68BRFk45heNRKLOQytaTrL3OT9o
         oRzlIINSkPVfCCaBuup+ff+mnnMACKwqUxb/AkZQFph8Cr3MMpRt2s2nt7hER06O7/QR
         rN2ViXLxFuQhUhCRkYEcCwDVbsb/iLLVromkBN54Wl6cZdTjS4dkhXNmshwi494N0qVc
         IJNy4I3frCPtOC34+xT33UVP1HYP/ZoJqNnbP2bUM3vmJCBhfSoBkBHgPfZL/YZTuA0n
         n66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994746; x=1718599546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6wty7/5ckkbIMYQrfSGTFo0XViwtxD1A330OlnyF00=;
        b=w4Fn+WWR9aOF4UuWlxQR8+ISXBdTt4WMAT78RKO73S7VljEDzqm030IEEGaX8SAFWt
         mqh1luoToXfLqlnS6rlVZQ/3wKAi+eI6SOy42jXbqLF/dyV2flz8RtWYbQDFr4cxp+Ba
         wt1BfTfUMI2OgzVkU+gqA6NX735tY+2VVbymKgBcwluHPOctEOTIeK9z2aC+oE1Yefa2
         GTAH6I70MUtZw3YTJ74CWjw/ksBzO0bq0+w6ekPNekNxvqTPviWHlTecOQ5CcTrM/Za0
         j38ACGvmmOVz/I/sj2N8JhKTV12svBhU0+fo44M6Q0g0EJIkafa7tPcAxsC/100gy5Xt
         hrTw==
X-Forwarded-Encrypted: i=1; AJvYcCWEV44wzsoiLITCUyZt+qUNeaplTWn3Da4vZFsZgP6e4pqSQZvG3/GYLwhboaaSJvmvudZnFmTxWZHqPH0bCZZxsb9ytmU+hZkWo6hN2Ye/
X-Gm-Message-State: AOJu0Yxc5uvbZkktlOXnvWLZHupFGjiUAUb1ID5eHsLtViN6i3LCNRmN
	ho8e726n6bWAb0XxpZ7CRLxusVn+Iy+jgm19kz8hr8NNZ32ULUv1gmKXO5dTk28=
X-Google-Smtp-Source: AGHT+IFf+1OJg1xK1MiXf0vBcz9BVHeA14Ul2s1z6qYt10MeOW0nvzzXkW/P4XRzr1D4aiRO1tRUzg==
X-Received: by 2002:a17:902:e88d:b0:1f4:a3a1:a7e5 with SMTP id d9443c01a7336-1f6d02bef11mr85103415ad.13.1717994745696;
        Sun, 09 Jun 2024 21:45:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76ce8asm73124095ad.77.2024.06.09.21.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:45:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:45:10 -0700
Subject: [PATCH 05/13] riscv: vector: Use vlenb from DT for thead
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-xtheadvector-v1-5-3fe591d7f109@rivosinc.com>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
In-Reply-To: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994732; l=3511;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=4N9WDp7GVC3puitkjGgcI/jJcnDMobkD3Avh+NXutPg=;
 b=DC7NLCqeukgT5lOVe137EsewYJ9o72ymXSCD9kejmdpQ1Vf7p2mH/l6TTZY1v6PLdnnpuqWvY
 zXH1O/+aMGsDnv7PW52FjUayRa3BK2sWdLtfhwVrfOaa4GCD21J2jf2
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If thead,vlenb is provided in the device tree, prefer that over reading
the vlenb csr.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 48 +++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vector.c          | 12 +++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index b029ca72cebc..e0a3164c7a06 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+extern u32 thead_vlenb_of;
+
 void riscv_user_isa_enable(void);
 
 #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2107c59575dd..0c01f33f2348 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -37,6 +37,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
+u32 thead_vlenb_of;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -625,6 +627,46 @@ static void __init riscv_fill_vendor_ext_list(int cpu)
 	}
 }
 
+static int has_thead_homogeneous_vlenb(void)
+{
+	int cpu;
+	u32 prev_vlenb = 0;
+	u32 vlenb;
+
+	/* Ignore vlenb if vector is not enabled in the kernel */
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		struct device_node *cpu_node;
+
+		cpu_node = of_cpu_device_node_get(cpu);
+		if (!cpu_node) {
+			pr_warn("Unable to find cpu node\n");
+			return -ENOENT;
+		}
+
+		if (of_property_read_u32(cpu_node, "thead,vlenb", &vlenb)) {
+			of_node_put(cpu_node);
+
+			if (prev_vlenb)
+				return -ENOENT;
+			continue;
+		}
+
+		if (prev_vlenb && vlenb != prev_vlenb) {
+			of_node_put(cpu_node);
+			return -ENOENT;
+		}
+
+		prev_vlenb = vlenb;
+		of_node_put(cpu_node);
+	}
+
+	thead_vlenb_of = vlenb;
+	return 0;
+}
+
 static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 {
 	unsigned int cpu;
@@ -689,6 +731,12 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		riscv_fill_vendor_ext_list(cpu);
 	}
 
+	if (riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADVECTOR) &&
+	    has_thead_homogeneous_vlenb() < 0) {
+		pr_warn("Unsupported heterogeneous vlenb detected, vector extension disabled.\n");
+		elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
+	}
+
 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
 		return -ENOENT;
 
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 6727d1d3b8f2..3ba2f2432483 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
 {
 	unsigned long this_vsize;
 
-	/* There are 32 vector registers with vlenb length. */
+	/*
+	 * There are 32 vector registers with vlenb length.
+	 *
+	 * If the thead,vlenb property was provided by the firmware, use that
+	 * instead of probing the CSRs.
+	 */
+	if (thead_vlenb_of) {
+		this_vsize = thead_vlenb_of * 32;
+		return 0;
+	}
+
 	riscv_v_enable();
 	this_vsize = csr_read(CSR_VLENB) * 32;
 	riscv_v_disable();

-- 
2.44.0


