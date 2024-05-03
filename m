Return-Path: <linux-kselftest+bounces-9402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056C8BB2C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F641F2124F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF8158DDB;
	Fri,  3 May 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eB/txiW4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802521591E7
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760330; cv=none; b=ObkUZD7PagDUvLxvGOLy2os35bwCPvV3wgwTUWogYuGq5XnSOH9pWa0QfUzXLJFGEDuYCjmLUzOA1ShNO1xFThByC/ptdUstXHmi2kJM3fqoxGs2KPBt8nqFPLFnucgjl1W4tfRF7o3tTam5MXk5zVvUeBqkrNj6HhnBKoiTfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760330; c=relaxed/simple;
	bh=oKiZfXeAlbmWslfugUa98N+u2COwHbBKOONuYtbD/2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBPzupGBCLIgu9zHJOWaxdIMQi3BNwuPNjtV/GtcTFfQcBY0e/YrmN7vDFLnYJEGYhVijFP5tWTDTBy3XCF+UBoinF9gD0G/Mxd2LqxG0tjhA0S3ipSWbtQdIMRsm4ZSUwlQ/pTS+zIPw56L/wbOogbHxOtVx6lFFRtkm4Tza9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eB/txiW4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f4551f2725so9802b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714760328; x=1715365128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UELmH9bdU4ZSPQgKMmBgWTS7NE5GHKJ3ouLiPma73xo=;
        b=eB/txiW4S3UPCFcZJOkMCBJBHhxVtlyawbZXWrCTPwOjmF+I1ZJUqfjTo/JWZSUyx+
         x66mxRZ3+S+2zSdhgvbX/JYG9SoesyAeZ/Iyg5EnDhvZXA1A4PxFGFHL2JVFgU2j7eMj
         fJbGH5x//IqfSd4Xd22Ho2BICUNMKLeq+EnNALtodvmy6N1vsmzCOgqgGxHWpl4drqJw
         qQbaX4q2vGnUMw11gnyxOT75CPW3dM0MX3zoHtcD+t5+xzxVK82rQEBVc50wk/fiqlMM
         /4lLzJ5FqA6ehl5XplGoXSzzt+RR4DqQorPRrV7qV5mPNOlwMhw6upWCnEApOCbPzfxE
         LwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760328; x=1715365128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UELmH9bdU4ZSPQgKMmBgWTS7NE5GHKJ3ouLiPma73xo=;
        b=GHVKqzOWgtIlOeap98hXGL6uFWka9A3pZIltFFTc0zRZFg8PeFHqAxl2yILfL1zdMm
         ZoJe0KFGqorAQtGk2tBIikdZU32utAnc/SGIaW0JKS7d7VAfW0jrJpe4R5lBXf3JDQpX
         o6kUEQgq1svWjj1neDitUyUW8zK1QqIg+wr7nTxpns2TKNtTXvqBJTf0gb8vODn7aCuN
         x1zeibIvzaAZi0y79S8sLmHySK/WMpXMGos7SSBbLnY50xqNp7YuwrsXOaWRohiLm1NV
         W8HbMRGmKUzwC9QZEiNBQmKeSS/Y5LWcizaK1PNPeF+cel3Pkuvz9V7avAgZAqUlwqEt
         uyQA==
X-Forwarded-Encrypted: i=1; AJvYcCV4bnEk50eUZIgyLS85c88WnFlUYlbiKWx3UDqFwhHRNi1p97jNGiEnzNMEIaqWfW1HqOwFxy2IeYPYVj7V7FAM0/fGVl3bERf0t1z78kC+
X-Gm-Message-State: AOJu0YyOEdRMQUcTJ2pWgwXNPDC1Ya/ZRZB5lpkVePpqipGOlxwKEg4S
	HWZ/UhyXQ43Q3izaAlylIxSu3JZ+fAXl9hRtjMgcXxyPJCYssO1TVSKI/tUi2KE=
X-Google-Smtp-Source: AGHT+IHSeSxim8Qie379bt05mqGRZw+x+rJOj0l9EjBmEgtLA/oB2Gus8wU0QZSnJSgImr9jdtGkdQ==
X-Received: by 2002:a05:6a00:1897:b0:6ec:fdcc:40b9 with SMTP id x23-20020a056a00189700b006ecfdcc40b9mr3795178pfh.9.1714760327698;
        Fri, 03 May 2024 11:18:47 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm3355421pfb.80.2024.05.03.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:18:46 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 03 May 2024 11:18:18 -0700
Subject: [PATCH v6 03/17] riscv: vector: Use vlenb from DT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714760318; l=3440;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=oKiZfXeAlbmWslfugUa98N+u2COwHbBKOONuYtbD/2E=;
 b=gfKoxKMSSQz8r6+tcijyhi+4U18/WrrOFL15fJ+mhnQVhKqAancI568aLKq2Is+Du4UAyl3x/
 yVwCsTQhI99DwYhAkoplUp4CczCsAQa6F+e+H8A5ovtuIOa4g2ecIyY
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If vlenb is provided in the device tree, prefer that over reading the
vlenb csr.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 47 +++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vector.c          | 12 +++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..0c4f08577015 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+extern u32 riscv_vlenb_of;
+
 void riscv_user_isa_enable(void);
 
 #if defined(CONFIG_RISCV_MISALIGNED)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..6c143ea9592b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -35,6 +35,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
+u32 riscv_vlenb_of;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -648,6 +650,46 @@ static int __init riscv_isa_fallback_setup(char *__unused)
 early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
 #endif
 
+static int has_riscv_homogeneous_vlenb(void)
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
+		if (of_property_read_u32(cpu_node, "riscv,vlenb", &vlenb)) {
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
+	riscv_vlenb_of = vlenb;
+	return 0;
+}
+
 void __init riscv_fill_hwcap(void)
 {
 	char print_str[NUM_ALPHA_EXTS + 1];
@@ -671,6 +713,11 @@ void __init riscv_fill_hwcap(void)
 			pr_info("Falling back to deprecated \"riscv,isa\"\n");
 			riscv_fill_hwcap_from_isa_string(isa2hwcap);
 		}
+
+		if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_homogeneous_vlenb() < 0) {
+			pr_warn("Unsupported heterogeneous vlen detected, vector extension disabled.\n");
+			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
+		}
 	}
 
 	/*
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 6727d1d3b8f2..e04586cdb7f0 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
 {
 	unsigned long this_vsize;
 
-	/* There are 32 vector registers with vlenb length. */
+	/*
+	 * There are 32 vector registers with vlenb length.
+	 *
+	 * If the riscv,vlenb property was provided by the firmware, use that
+	 * instead of probing the CSRs.
+	 */
+	if (riscv_vlenb_of) {
+		this_vsize = riscv_vlenb_of * 32;
+		return 0;
+	}
+
 	riscv_v_enable();
 	this_vsize = csr_read(CSR_VLENB) * 32;
 	riscv_v_disable();

-- 
2.44.0


