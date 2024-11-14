Return-Path: <linux-kselftest+bounces-21992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644039C80B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D58281ABD
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B981F80A3;
	Thu, 14 Nov 2024 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b9C77gCi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613A1F76DD
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550923; cv=none; b=kLq0C1nJOL8rWqNuGAn5CrKlLj8jaf4+O/MOn9DZDjhsZG2aAf2VeJhps+ht7xWsIbJYD4yoO6Jr9jHOnQAAhXvntTNPcgsskyAry/mB4KDAqgPVu4hJijwN7ZiW+0eH7TkuYxVlmS5sNARY0HUXWOkBco0UDOjMwN0w6MrSChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550923; c=relaxed/simple;
	bh=BY2FoLzwMbBSsrfXRPTuTs27Trdz1nuAyU8/yyy3MsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNZVdzYCOq3jUCDcg4LCDb2WBAWmpnN1isz6elv4LLLOlRwwkuVsqpP+gWzQHa4nf1V/6UrWoFjpLZfShqUj3G9L3EwcLtcmRCJY6xiDIj465+oM1lomML+dcH/J80RB9JHERtwfSvZnhpMbvJ5npCKb33DgSBYUdd+oMPWyoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b9C77gCi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c70abba48so798265ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 18:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550920; x=1732155720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMH58FpqyzdhLZILUhxhOSywe1at4r2KNe+4dzmkYAk=;
        b=b9C77gCiIWrn+8oIiwx8ZvRFEUWBumYWMSgwNq3wPHxxKOfIo974WCWPlkrzWpmpUP
         +VVZHzE+LpPIvV+f31aKt9E+xQF+z4MWWweeyZqpxQfStmi/fHnOBYxiKrrEobX+aiyX
         FDk0cf+VQExLzX5O4Eu4CzSQntbF0FipHc9z9MbbKCwOa7sxRFJ1tyCYqcj/7/aiLbw+
         nyGEcvP2uoLbrmb06rHTw4/Wy6ztSxe33LyveJFui4RgV+Xnl7cAXOoIKzbU7PPNJO3N
         D5Vn22F1OC3bOQ57BJ1+ZxFez5n/ShMYqvoc2n9HnOOtGhoumUoHay9LDIeeKBlXNJGq
         Xv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550920; x=1732155720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMH58FpqyzdhLZILUhxhOSywe1at4r2KNe+4dzmkYAk=;
        b=WmTbEiGxpjA1xrM6I0GXCEt/jetYKixjKy5xQzlGjXikVu97Vs5ECMMkBjgZ6aD64J
         xXzN0qUaBxb8jcXWaJUcomvkvm+LgnWdLORJw4DVAX7H9SIGMyn6DMPct2lIZiGuvidA
         N2a+zTGf3UaShjkfwU3ulYPIBwOfZipSpkHaBhsJqIuQJUG7Q62L53JyEnMC5/4USrt8
         0+KvDTx8jjpNFEjepEV+bheL6x3d58o/aHTsEhNJYRHhK60z/FK0L1YLg3hfGo7loHLk
         m46yxWumXKd6KqknIpqpJ57wriMcuuDklbaZK+yDmTEZlb/fW+z8qodnCTnsBLin2mcA
         Ihjw==
X-Forwarded-Encrypted: i=1; AJvYcCWn3UhpFT8mJ0W3rdRD1hm606WsrTIMNCqZaianugOL1NlHGG6xAuNMMWVYyBP3FNKQNDNTpZpc2BR+RxY9BOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNu4PajUSVQqF1cvFKM4WOukQ+k/rdqQvHw5/JrnlNdKBmGCX1
	MYyIWa2/G7bSR7nlSG9GBKA6TJx2cz1oEi11yIW6a4l6cHRgngcv1IJIeDSv1tM=
X-Google-Smtp-Source: AGHT+IEJkRgDEivbHjM/3Y8vGKrIVF1pBxKtVmYVTbNOcQ/ob1JEOiwkSnnJJCbZZKN7IErnqxc12w==
X-Received: by 2002:a17:902:e5c5:b0:208:d856:dbb7 with SMTP id d9443c01a7336-211c50b0c46mr8006185ad.39.1731550920201;
        Wed, 13 Nov 2024 18:22:00 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:59 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 13 Nov 2024 18:21:20 -0800
Subject: [PATCH v11 14/14] riscv: Add ghostwrite vulnerability
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-xtheadvector-v11-14-236c22791ef9@rivosinc.com>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
In-Reply-To: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
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
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Yangyu Chen <cyy@cyyself.name>, Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9693; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=BY2FoLzwMbBSsrfXRPTuTs27Trdz1nuAyU8/yyy3MsA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3OL1Kn+/tTdEtO1gePZT8sqps5/kLy9rs1h1xUq19
 IDFotycjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACbSm8Pwm33H74vHNrxOi5j4
 z6L/yLW9P5n1dSepdB6fUnzkDfN6305GhndHgmonKkY/+Cp/mXPJjD2BMqHuly/dyrkwc4oiY+T
 dAEYA
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
 arch/riscv/Kconfig.errata            | 11 +++++++
 arch/riscv/errata/thead/errata.c     | 28 +++++++++++++++++
 arch/riscv/include/asm/bugs.h        | 22 +++++++++++++
 arch/riscv/include/asm/errata_list.h |  3 +-
 arch/riscv/kernel/Makefile           |  2 ++
 arch/riscv/kernel/bugs.c             | 60 ++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c       | 10 +++++-
 drivers/base/cpu.c                   |  3 ++
 include/linux/cpu.h                  |  1 +
 9 files changed, 138 insertions(+), 2 deletions(-)

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
index 000000000000..17ca0a947730
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
+bool ghostwrite_enable_mitigation(void);
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
index 30db92672ada..d73f04c6c563 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -118,3 +118,5 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
+
+obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
diff --git a/arch/riscv/kernel/bugs.c b/arch/riscv/kernel/bugs.c
new file mode 100644
index 000000000000..3655fe7d678c
--- /dev/null
+++ b/arch/riscv/kernel/bugs.c
@@ -0,0 +1,60 @@
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
+ *
+ * Returns true if mitgated, false otherwise.
+ */
+bool ghostwrite_enable_mitigation(void)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR) &&
+	    ghostwrite_state == VULNERABLE && !cpu_mitigations_off()) {
+		disable_xtheadvector();
+		ghostwrite_state = MITIGATED;
+		return true;
+	}
+
+	return false;
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
index ba6976132638..35670c96b383 100644
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
@@ -824,6 +825,7 @@ static int has_thead_homogeneous_vlenb(void)
 static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 {
 	unsigned int cpu;
+	bool mitigated;
 
 	for_each_possible_cpu(cpu) {
 		unsigned long this_hwcap = 0;
@@ -874,7 +876,13 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		riscv_fill_vendor_ext_list(cpu);
 	}
 
-	if (has_xtheadvector_no_alternatives() && has_thead_homogeneous_vlenb() < 0) {
+	/*
+	 * Execute ghostwrite mitigation immediately after detecting extensions
+	 * to disable xtheadvector if necessary.
+	 */
+	mitigated = ghostwrite_enable_mitigation();
+
+	if (!mitigated && has_xtheadvector_no_alternatives() && has_thead_homogeneous_vlenb() < 0) {
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
2.34.1


