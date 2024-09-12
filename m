Return-Path: <linux-kselftest+bounces-17786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B29760B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 07:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B091C20B89
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6F718CC0F;
	Thu, 12 Sep 2024 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pgKVFKzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5E18BC37
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120559; cv=none; b=Yp31lefX1aXTB/fDFX3+tFOroOTERLpJijX8NuIgD1urfxNsc1p/r6TtmmbCWiVW7ly62DCpoESOV1qSHMjgXocbLQrIR2m7gs6YfREZ6XDQnoW7wim/ni7iaKXJ44bPgBnpKKVZ1cPHUDCCSgPSuFAdoH0JlF7PI+FqlbawUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120559; c=relaxed/simple;
	bh=Si8s9Nyy7nI3HfPFfu+caaKSxmtxlVlOGIUcFmHJG5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJm6PA3nAWTDWBHFFdrg+dwVkWbigvRtFsP8ygMRLHSoX0J0/tcrR5JNpTM74nT62zsS708s9Ks6TKOzosSoY8QnecQCvipP4D5r82c3K5h91/VotuPqgW7/SZmZmtVQOC9drCdsquSMDSyIFEDJuK0HdzLg/a7CaI+MtjpmRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pgKVFKzu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20551e2f1f8so6097655ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 22:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726120556; x=1726725356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3U6ebKIucceyY9AucAMv99ftPt4/S1Gk1T6FLUdGq4U=;
        b=pgKVFKzu1Y13pP0wWJbHZU+Sw9WqyLYkVFNrxLjmgL0D2/7vPlaSD0OVVkiqIChMQw
         6AZZxmWx8Jawktuq+42x05fScvuf8iO812Y/xIXIex484wETOff3W3ob9K+tOiHDfWnS
         j/1nvlOs8BpcQ8NpxSj3M2uGvGxiTxFFamrnxII3/Mzn3fIQNcPkWCKiG4WKVCOHTDsh
         2+UdbrhSCGCJuDTOnAkJsZsm7Rr/RM1N9clrl+8HdjvTCC2THNYU9tGLoHsMvi/+b0VG
         CUliE3fk/HBMd5WxCqyNAvM5g7QoAAKNUnGvpy8nRXzsHKZKrPHHzq1vDAfdVKyCdEyv
         bKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726120556; x=1726725356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3U6ebKIucceyY9AucAMv99ftPt4/S1Gk1T6FLUdGq4U=;
        b=sTQzhpPdCeLDEoH0hTGf9GZUNQ87p+DBGjh+p5LmDOo9j38LsRh/YPMakZxHFQDf9m
         SYhZTX1NfC05un2EDmbWKn+W6/w/YhrrSa9Pa/6/TA7hyQXeRMqD6pHEOO/7N6GMp9Bw
         5nhO9aY4pKzZBgA8TwH7I5nVU1FmhCa5miXocr+1iE7awNvAOyvVsOAl03Bm6MzqVlIn
         +5vIamLbhOzEMU69+OGm6tJVyAK70mqN+RILq+2FzXJ5BJPuFoC4j45HnSNcf51QavaK
         Gq7YayYGKwsU5TaBb2vEqrzGSwuxv9SBeVqy1fTV3DvYX2Gf5fEoOWbtEc382jZ3x3XF
         4tfg==
X-Forwarded-Encrypted: i=1; AJvYcCUaQLAFp1257VGBLspzcriaxPx5Rx57g9daGgovEVvW7pusSClgUGEZRm6BawNpPpej7HHwFQeEimMNmWGOZeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedDUn7BEiRxkPCC4Vu1AJWrmNUEtrEJB5Gh7vhMiPFz575V4i
	tZEp/wNQsJxDzafHKaeXM9UrpCc1gJi0JDPeqvMC3Juet/TjQs+7OlbibqQm6NI=
X-Google-Smtp-Source: AGHT+IFRxeLD4QYAfUciKWeOBA1Y00HNRbIfhwiZjz8ibwyk3mpAks+EyiDAbMA0V3a6X7tOGGPqzw==
X-Received: by 2002:a17:902:da8a:b0:205:68a4:b2d9 with SMTP id d9443c01a7336-2076e4150famr25676065ad.48.1726120555786;
        Wed, 11 Sep 2024 22:55:55 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe99b6sm7870465ad.209.2024.09.11.22.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 22:55:54 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 11 Sep 2024 22:55:13 -0700
Subject: [PATCH v10 05/14] riscv: vector: Use vlenb from DT for thead
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-xtheadvector-v10-5-8d3930091246@rivosinc.com>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6175; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=Si8s9Nyy7nI3HfPFfu+caaKSxmtxlVlOGIUcFmHJG5o=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qjpmgZ0Z2rbxyvu7rkDsM2FrYDZc/3XNtW/bIzkXXxa
 YOd4p/aO0pZGMQ4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZjIvmOMDC9OvLild+OW2g9d
 M4nfd1qZpn63td5cv3l5dvkRrXtsAkoM/4MOf938qyOCZ8ekFMEiyw8LJfkLX6/ctS1g5a1cxdh
 id04A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

If thead,vlenb is provided in the device tree, prefer that over reading
the vlenb csr.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.vendor                        | 13 +++++++
 arch/riscv/include/asm/cpufeature.h              |  2 +
 arch/riscv/include/asm/vendor_extensions/thead.h |  6 +++
 arch/riscv/kernel/cpufeature.c                   | 48 ++++++++++++++++++++++++
 arch/riscv/kernel/vector.c                       | 12 +++++-
 arch/riscv/kernel/vendor_extensions/thead.c      | 11 ++++++
 6 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
index 9897442bd44f..b096548fe0ff 100644
--- a/arch/riscv/Kconfig.vendor
+++ b/arch/riscv/Kconfig.vendor
@@ -26,6 +26,19 @@ config RISCV_ISA_VENDOR_EXT_THEAD
 	  extensions. Without this option enabled, T-Head vendor extensions will
 	  not be detected at boot and their presence not reported to userspace.
 
+	  If you don't know what to do here, say Y.
+
+config RISCV_ISA_XTHEADVECTOR
+	bool "xtheadvector extension support"
+	depends on RISCV_ISA_VENDOR_EXT_THEAD
+	depends on RISCV_ISA_V
+	depends on FPU
+	default y
+	help
+	  Say N here if you want to disable all xtheadvector related procedures
+	  in the kernel. This will disable vector for any T-Head board that
+	  contains xtheadvector rather than the standard vector.
+
 	  If you don't know what to do here, say Y.
 endmenu
 
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 45f9c1171a48..28bdeb1005e0 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+extern u32 thead_vlenb_of;
+
 void riscv_user_isa_enable(void);
 
 #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
index 48421d1553ad..190c91e37e95 100644
--- a/arch/riscv/include/asm/vendor_extensions/thead.h
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -13,4 +13,10 @@
 
 extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
 
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
+void disable_xtheadvector(void);
+#else
+void disable_xtheadvector(void) { }
+#endif
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 46e69b9d66a7..9340efd79af9 100644
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
@@ -772,6 +774,46 @@ static void __init riscv_fill_vendor_ext_list(int cpu)
 	}
 }
 
+static int has_thead_homogeneous_vlenb(void)
+{
+	int cpu;
+	u32 prev_vlenb = 0;
+	u32 vlenb;
+
+	/* Ignore thead,vlenb property if xtheavector is not enabled in the kernel */
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
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
@@ -825,6 +867,12 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		riscv_fill_vendor_ext_list(cpu);
 	}
 
+	if (riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADVECTOR) &&
+	    has_thead_homogeneous_vlenb() < 0) {
+		pr_warn("Unsupported heterogeneous vlenb detected, vector extension disabled.\n");
+		disable_xtheadvector();
+	}
+
 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
 		return -ENOENT;
 
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 682b3feee451..9775d6a9c8ee 100644
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
diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/kernel/vendor_extensions/thead.c
index 0f27baf8d245..519dbf70710a 100644
--- a/arch/riscv/kernel/vendor_extensions/thead.c
+++ b/arch/riscv/kernel/vendor_extensions/thead.c
@@ -5,6 +5,7 @@
 #include <asm/vendor_extensions/thead.h>
 
 #include <linux/array_size.h>
+#include <linux/cpumask.h>
 #include <linux/types.h>
 
 /* All T-Head vendor extensions supported in Linux */
@@ -16,3 +17,13 @@ struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead = {
 	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_thead),
 	.ext_data = riscv_isa_vendor_ext_thead,
 };
+
+void disable_xtheadvector(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap[cpu].isa);
+
+	clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext_list_thead.all_harts_isa_bitmap.isa);
+}

-- 
2.45.0


