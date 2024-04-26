Return-Path: <linux-kselftest+bounces-8948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF58B4125
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EDCB21F59
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045C39AF9;
	Fri, 26 Apr 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GeZZj4G2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072338DEC
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166973; cv=none; b=Nr50bIQKLxknCCvmaVwjgWAo3zxaG7/SV3cejJjw1a8MEkVVwYvTVJ/een7esY07tQcYF108dbBbCrzsRPt8Xp+CeSCpMly5EMVrQSlJWmeyNrcGUSM1SH8gHI78YNb1/JsI2yzpIrNLDMmXS0PQ1m/2Es6DtaK2Dxkf+5/e0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166973; c=relaxed/simple;
	bh=TMZGPAigRUlnddtyOxdX28W8hFoUd2ldYAJcckC4XNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGY5uvcRTyqX2WcorsuRIU6hJgsLTO4WNnc2pqbFyCUCKkoTt1yyNpPwfJfWPo2xkpbavqgbx7j0X8SfWveb9xh2AgqhlKQl+gpQPF96v+17a7xOZULxR9fVx4pOqBEWFasPuOtTfUA0Is0zA9TPvMhvJxz0/PvafaFG4ZD5V8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GeZZj4G2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3ca546d40so22261645ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714166971; x=1714771771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epQYh2eYy4HhqqXFO0t2DHAzvNVz9k3o87eDn/hGHY8=;
        b=GeZZj4G2ikgUSZWIFV1/ETq9O9qRIFHAuQc+ExMOcw0bEoa/8v/70GaEgsQM3QNl/R
         6qCOa8x9DpdrvVHo8C6QRpruBeg1kGb+tDmXD3bfnVsEskWTSwqKtHmYgDmVbwOLbki8
         1eQm2YGnf5WPNFZLioS/KVIzvd12Gtb7r8BCo1HsrobGx/7wQ0AUb63SfkeHCLlztGNU
         ZMKgCVfL2t5oG0rFP4pISAod2jCxt/UrrRtTgifN2fF1ZPudkBLrcDzCpCut4SZCiDRJ
         sqF7zJES18R89PAEig84Pknr5meU2ory3SbVNYB6B0Fe57Nu66ypl0HEkeVxwWNrT4aT
         S0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166971; x=1714771771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epQYh2eYy4HhqqXFO0t2DHAzvNVz9k3o87eDn/hGHY8=;
        b=aJDChlvilB0bDO3lGkZEEGvb/EfHxNPcHWA2qAY6Uy+7CCEuSMkf24p/blsFPqxiMD
         1ubPPYCJeOhiGIQ0jZY5rc8AJLi3nmpLGuS7tDtQA6PrvMj8Uoius5mxX/dSMKTO5cFz
         g8wN30zp1gXz1LhJIA9KYV16zkX+/osvgb0Uj0S3VAJ8Y6SoDrpjQeMm80ULKhFysK5k
         DnRt8oktYywR5yo9/wtsp6JhZT3yMQEwj7L4clZzqGgwcUmo64OOQ1VTrKsbn2wtvPjx
         3dmd1I5IVolVoCpd+Efs/fcGxZpIdGMZquJPQHmuXx5bmfgL/vw8GbKf20wnDfX8hj3y
         RTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe5JumIsYNqUhhaxmgZSaLub3ZsHz25sM4wZMXij1tc0A2qCWSQOtKxFpn6WrAg1nsZdAuMvxeAsrUPepI7FYMKQxJCewpqSyo3xj8Xwz/
X-Gm-Message-State: AOJu0YwmHrlJhVle3t7y+ZujngffY/zHJq9WYkdSjNqpxlYNENGzZgiw
	1EkC0zuH4UqQC9v+P1kwUPXUqFmTUW7chBrEqO95555RyLSybotmYKTg5g/Tz8M=
X-Google-Smtp-Source: AGHT+IFDdWTRYVcgW9qDFh5H5WCJcnb34hUrziiEttp/aNO3ZqSkuqgK9qnNIcUJgRrMqeA168Gjwg==
X-Received: by 2002:a17:902:d2d2:b0:1eb:144f:63b7 with SMTP id n18-20020a170902d2d200b001eb144f63b7mr3362816plc.56.1714166971409;
        Fri, 26 Apr 2024 14:29:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b001ea2838fa5dsm7226720plk.76.2024.04.26.14.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:29:30 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:29:17 -0700
Subject: [PATCH v4 03/16] riscv: vector: Use vlenb from DT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-3-b692f3c516ec@rivosinc.com>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714166962; l=3503;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=TMZGPAigRUlnddtyOxdX28W8hFoUd2ldYAJcckC4XNo=;
 b=voxH8bczevqJuWsa7XFbvY9OOL8pV13Qpe0a6DJPgY+bzFW02nxmGbjhOM58C+T7gFvqpoMhf
 1Bk7VHjcOmKC45lYQRmhaE8i0oGl6cJy2OFEN3ko9rPsO0a7Logzma5
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If vlenb is provided in the device tree, prefer that over reading the
vlenb csr.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 43 +++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vector.c          | 12 ++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

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
index 3ed2359eae35..8158f34c3e36 100644
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
@@ -648,6 +650,42 @@ static int __init riscv_isa_fallback_setup(char *__unused)
 early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
 #endif
 
+static int riscv_homogeneous_vlenb(void)
+{
+	int cpu;
+	u32 prev_vlenb = 0;
+	u32 vlenb;
+
+	for_each_possible_cpu(cpu) {
+		struct device_node *cpu_node;
+
+		cpu_node = of_cpu_device_node_get(cpu);
+		if (!cpu_node) {
+			pr_warn("Unable to find cpu node\n");
+			continue;
+		}
+
+		if (of_property_read_u32(cpu_node, "riscv,vlenb", &vlenb)) {
+			of_node_put(cpu_node);
+
+			if (prev_vlenb)
+				return -1;
+			continue;
+		}
+
+		if (prev_vlenb && vlenb != prev_vlenb) {
+			of_node_put(cpu_node);
+			return -1;
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
@@ -671,6 +709,11 @@ void __init riscv_fill_hwcap(void)
 			pr_info("Falling back to deprecated \"riscv,isa\"\n");
 			riscv_fill_hwcap_from_isa_string(isa2hwcap);
 		}
+
+		if (riscv_homogeneous_vlenb() < 0) {
+			pr_warn("RISCV_ISA_V only supports one vlenb on SMP systems. Please ensure that the riscv,vlenb devicetree property is the same across all CPUs. Either all CPUs must have the riscv,vlenb property, or none. If no CPUs in the devicetree use riscv,vlenb then vlenb will be probed from the vlenb CSR. Disabling vector.\n");
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


