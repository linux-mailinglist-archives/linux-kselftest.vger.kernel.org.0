Return-Path: <linux-kselftest+bounces-17795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDFF9760DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 07:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C71C21932
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 05:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBC19C562;
	Thu, 12 Sep 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hyDPEtRC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33518FDD8
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120577; cv=none; b=pMmHUo53+iZQ3mWkO8syAXQuzw5mJYrdjJjSdfaeAeYHMHlXuAdN02YYCBydTKFSv06QnckxF/N0PZjplCnA1dxM85MpStivAF99j+wToXJoZGPrak+JoxIQfk3/y5j6rZgY7fHJFA094YDgIdohHr/+NJgloJHJyRQ8r0Ak6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120577; c=relaxed/simple;
	bh=2MZb8AJQZs0wG05Wps2DKInawqFPfqgCL1L5PflC7B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbZDLmAopPgCveX3+5Yf5eKaHc/c4B2Ns+j8zQGgnOKCyWMXcQ3lMzcflB4eBrYcUzPY/nh1hzI1iccwtXxs3XhKTiP15A77yKmtMURx68QSKbtIkxHXpo0i7/xV7f0yna/IWSbMXLtZy+lzyX7nBtv3l8s0xXnZHWQj5fJfAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hyDPEtRC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-205909af9b5so5983345ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 22:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726120575; x=1726725375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZGiXXErbLpwtJqQgRszC/20gA32B7VjfeYUlTIyz2Y=;
        b=hyDPEtRC1YSt8HY3ToJaylrg4hdczZZ7pciTOXe+yihIExv3zUrO8PnhsYZbWaRyMA
         vHbQFClUH8soXWFxs1mFaHU5YqJ61s+BSVUu84mqvPNaMgeIOUXTbx/W6yQPlvgSU+as
         3KEU2sKqXGjI3HBAHWUmZVOKie3tji/kp3kkK2itynJ9XFrRNWy8Odton1NaE79ODav7
         iUPTYb8YC/THRXe04ylG9vB+MIknaT30hCo0bX5xaeW7D41oBOfZbSn+P4HpTeRTJ0rs
         I3n6S60AuXHDo0CBJ41Xe50BQBzby8JPLIureTLUQWFWKUIF9WXtuLvDMX34OTpppE5S
         XyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726120575; x=1726725375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZGiXXErbLpwtJqQgRszC/20gA32B7VjfeYUlTIyz2Y=;
        b=NxTYa9zAz8mQ4Q3/sshtTXKzwIdQVWpQWi68i1NM7DLp8/VzGVTa7d2nN618fkIFs/
         gdwclwH1ZXKJZwNPDYHbjWbM74zyyRvaROK1GIXLf2J5prQ9Ff35VBQXxPL3rdO2PhfK
         HcgZg5s8Dt3lnKlUCQydLfd42R+0dsRXVlIXgMkFcJLV5PY19TA90UZLnuDTazYENvcf
         Ztb5e9FFsDq06P17DszB+vpjD5Zq+IYmAfQlnt6ysaweI+wioun4Z1J1C1CVgSvKL4i/
         uR7/sRAIDPyDbccS6MGXFCRRH8uS8PuIZkAoFmSzKM2cGV2y6wFor6nlqfDvejksmRZl
         1bvg==
X-Forwarded-Encrypted: i=1; AJvYcCUUXQVi0WMINFJylb76HqXzOsZd/2o2c8+zwD+gzQJGLhRmO5ftMATvL/zK8ccYfKJBmkZYJnKpPdGE97W4pOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpm/dR0v59ArF9aZ0GnVkbvDhvAX4P7uSw5B50LaZ0lilhUhrD
	lgvgceopXpBIcvmKHbRB95COX31yEcTqGiq95pCNUw/Svn/PwSB4qkOUOx88w7M=
X-Google-Smtp-Source: AGHT+IEP6KKwUZUW8OkMBb/fzUUdV4ELJioR4iSAdt1JCFUkRDRHnlZjxlI1+ScQqzaBoVsDlqO0MA==
X-Received: by 2002:a17:902:e852:b0:205:8407:6321 with SMTP id d9443c01a7336-2076e32e467mr26718025ad.9.1726120574663;
        Wed, 11 Sep 2024 22:56:14 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe99b6sm7870465ad.209.2024.09.11.22.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 22:56:13 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 11 Sep 2024 22:55:22 -0700
Subject: [PATCH v10 14/14] riscv: Add ghostwrite vulnerability
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-xtheadvector-v10-14-8d3930091246@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9377; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=2MZb8AJQZs0wG05Wps2DKInawqFPfqgCL1L5PflC7B4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qjptiFMw5nP9trcGhyZOLbtRZvpOqP7b6X2+nx55Y4v
 1rzq847HaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEzkRikjw8kZu9hvVjGoXk3b
 vvRgabHQ1BfzTnhorbhbdZajvjUkTp7hf/4B+f1yv02/VcdquBxsSyl53Xbll6Ms+zxRa+/jDSu
 DWAE=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Follow the patterns of the other architectures that use
GENERIC_CPU_VULNERABILITIES for riscv to introduce the ghostwrite
vulnerability and mitigation. The mitigation is to disable all vector
which is accomplished by clearing the bit from the cpufeature field.

Ghostwrite only affects thead c9xx CPUs that impelment xtheadvector, so
the vulerability will only be mitigated on these CPUs.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig.errata            | 11 ++++++++
 arch/riscv/errata/thead/errata.c     | 28 ++++++++++++++++++
 arch/riscv/include/asm/bugs.h        | 22 +++++++++++++++
 arch/riscv/include/asm/errata_list.h |  3 +-
 arch/riscv/kernel/Makefile           |  2 ++
 arch/riscv/kernel/bugs.c             | 55 ++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c       |  9 +++++-
 drivers/base/cpu.c                   |  3 ++
 include/linux/cpu.h                  |  1 +
 9 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 2acc7d876e1f..e318119d570d 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -119,4 +119,15 @@ config ERRATA_THEAD_PMU
 
 	  If you don't know what to do here, say "Y".
 
+config ERRATA_THEAD_GHOSTWRITE
+	bool "Apply T-Head Ghostwrite errata"
+	depends on ERRATA_THEAD && RISCV_ISA_XTHEADVECTOR
+	default y
+	help
+	  The T-Head C9xx cores have a vulnerability in the xtheadvector
+	  instruction set. When this errata is enabled, the CPUs will be probed
+	  to determine if they are vulnerable and disable xtheadvector.
+
+	  If you don't know what to do here, say "Y".
+
 endmenu # "CPU errata selection"
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index f5120e07c318..5cc008ab41a8 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <asm/alternative.h>
+#include <asm/bugs.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/dma-noncoherent.h>
@@ -142,6 +143,31 @@ static bool errata_probe_pmu(unsigned int stage,
 	return true;
 }
 
+static bool errata_probe_ghostwrite(unsigned int stage,
+				    unsigned long arch_id, unsigned long impid)
+{
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_GHOSTWRITE))
+		return false;
+
+	/*
+	 * target-c9xx cores report arch_id and impid as 0
+	 *
+	 * While ghostwrite may not affect all c9xx cores that implement
+	 * xtheadvector, there is no futher granularity than c9xx. Assume
+	 * vulnerable for this entire class of processors when xtheadvector is
+	 * enabled.
+	 */
+	if (arch_id != 0 || impid != 0)
+		return false;
+
+	if (stage != RISCV_ALTERNATIVES_EARLY_BOOT)
+		return false;
+
+	ghostwrite_set_vulnerable();
+
+	return true;
+}
+
 static u32 thead_errata_probe(unsigned int stage,
 			      unsigned long archid, unsigned long impid)
 {
@@ -155,6 +181,8 @@ static u32 thead_errata_probe(unsigned int stage,
 	if (errata_probe_pmu(stage, archid, impid))
 		cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
 
+	errata_probe_ghostwrite(stage, archid, impid);
+
 	return cpu_req_errata;
 }
 
diff --git a/arch/riscv/include/asm/bugs.h b/arch/riscv/include/asm/bugs.h
new file mode 100644
index 000000000000..e294b15bf78e
--- /dev/null
+++ b/arch/riscv/include/asm/bugs.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Interface for managing mitigations for riscv vulnerabilities.
+ *
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef __ASM_BUGS_H
+#define __ASM_BUGS_H
+
+/* Watch out, ordering is important here. */
+enum mitigation_state {
+	UNAFFECTED,
+	MITIGATED,
+	VULNERABLE,
+};
+
+void ghostwrite_set_vulnerable(void);
+void ghostwrite_enable_mitigation(void);
+enum mitigation_state ghostwrite_get_state(void);
+
+#endif /* __ASM_BUGS_H */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 7c8a71a526a3..6e426ed7919a 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -25,7 +25,8 @@
 #ifdef CONFIG_ERRATA_THEAD
 #define	ERRATA_THEAD_MAE 0
 #define	ERRATA_THEAD_PMU 1
-#define	ERRATA_THEAD_NUMBER 2
+#define	ERRATA_THEAD_GHOSTWRITE 2
+#define	ERRATA_THEAD_NUMBER 3
 #endif
 
 #ifdef __ASSEMBLY__
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 06d407f1b30b..d7a54e34178e 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -113,3 +113,5 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
+
+obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
diff --git a/arch/riscv/kernel/bugs.c b/arch/riscv/kernel/bugs.c
new file mode 100644
index 000000000000..0c19691b4cd5
--- /dev/null
+++ b/arch/riscv/kernel/bugs.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/sprintf.h>
+
+#include <asm/bugs.h>
+#include <asm/vendor_extensions/thead.h>
+
+static enum mitigation_state ghostwrite_state;
+
+void ghostwrite_set_vulnerable(void)
+{
+	ghostwrite_state = VULNERABLE;
+}
+
+/*
+ * Vendor extension alternatives will use the value set at the time of boot
+ * alternative patching, thus this must be called before boot alternatives are
+ * patched (and after extension probing) to be effective.
+ */
+void ghostwrite_enable_mitigation(void)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR) &&
+	    ghostwrite_state == VULNERABLE && !cpu_mitigations_off()) {
+		disable_xtheadvector();
+		ghostwrite_state = MITIGATED;
+	}
+}
+
+enum mitigation_state ghostwrite_get_state(void)
+{
+	return ghostwrite_state;
+}
+
+ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR)) {
+		switch (ghostwrite_state) {
+		case UNAFFECTED:
+			return sprintf(buf, "Not affected\n");
+		case MITIGATED:
+			return sprintf(buf, "Mitigation: xtheadvector disabled\n");
+		case VULNERABLE:
+			fallthrough;
+		default:
+			return sprintf(buf, "Vulnerable\n");
+		}
+	} else {
+		return sprintf(buf, "Not affected\n");
+	}
+}
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 56b5054b8f86..1f4329bb8a9d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <asm/acpi.h>
 #include <asm/alternative.h>
+#include <asm/bugs.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwcap.h>
@@ -867,7 +868,13 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		riscv_fill_vendor_ext_list(cpu);
 	}
 
-	if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_vlenb() < 0) {
+	/*
+	 * Execute ghostwrite mitigation immediately after detecting extensions
+	 * to disable xtheadvector if necessary.
+	 */
+	if (ghostwrite_get_state() == VULNERABLE) {
+		ghostwrite_enable_mitigation();
+	} else if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_vlenb() < 0) {
 		pr_warn("Unsupported heterogeneous vlenb detected, vector extension disabled.\n");
 		disable_xtheadvector();
 	}
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fdaa24bb641a..a7e511849875 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -599,6 +599,7 @@ CPU_SHOW_VULN_FALLBACK(retbleed);
 CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
 CPU_SHOW_VULN_FALLBACK(gds);
 CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
+CPU_SHOW_VULN_FALLBACK(ghostwrite);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -614,6 +615,7 @@ static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
+static DEVICE_ATTR(ghostwrite, 0444, cpu_show_ghostwrite, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -630,6 +632,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_spec_rstack_overflow.attr,
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_reg_file_data_sampling.attr,
+	&dev_attr_ghostwrite.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index bdcec1732445..6a0a8f1c7c90 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -77,6 +77,7 @@ extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 					       struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,

-- 
2.45.0


