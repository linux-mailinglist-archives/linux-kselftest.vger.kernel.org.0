Return-Path: <linux-kselftest+bounces-37334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F94B05447
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 10:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A648176042
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB0B2749C3;
	Tue, 15 Jul 2025 08:14:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5CB2741CB;
	Tue, 15 Jul 2025 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567268; cv=none; b=II8SwRkeohQZM0dDyczcXeJ7ccA4vOqIFBoJZSGfyZWOKb6bFmbDpCfezU5olai3bJ8HJSrBVdz1eNr0lwg0quGDDr8CH6EnGWN3RPJjtkmqiYa4zNpjShEYhtmTIPqFdo3REcKjPPBpatxLeP4fVThLi6iEFtP8zX+VlNiphN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567268; c=relaxed/simple;
	bh=fg9iV2OiaXXLSKudoHVEBs1iBzPl+YMuZE7+LRvliOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyEJU3POtu/CisZMuHaUNPqfaxtwRoHzasNmJPWZed9okbiiXtNJFGtNG+I8c81QlkHCdVN1std/JrFw5G1Ot/IcxBoC1jOfKmyHPM0cG5CxvV/Ev1sjwWYX+0VQRr43tISBW+0D+2cO+fIX3gEq1yjf6Sea8Oz3BmHvBpwv6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bhBgs5t0KzHrRx;
	Tue, 15 Jul 2025 16:10:17 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9220C1401F4;
	Tue, 15 Jul 2025 16:14:24 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 16:14:24 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 16:14:23 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>,
	<tangchengchang@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v4 5/7] arm64: Add support for FEAT_{LS64, LS64_V}
Date: Tue, 15 Jul 2025 16:13:54 +0800
Message-ID: <20250715081356.12442-6-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250715081356.12442-1-yangyicong@huawei.com>
References: <20250715081356.12442-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemq200018.china.huawei.com (7.202.195.108)

From: Yicong Yang <yangyicong@hisilicon.com>

Armv8.7 introduces single-copy atomic 64-byte loads and stores
instructions and its variants named under FEAT_{LS64, LS64_V}.
These features are identified by ID_AA64ISAR1_EL1.LS64 and the
use of such instructions in userspace (EL0) can be trapped. In
order to support the use of corresponding instructions in userspace:
- Make ID_AA64ISAR1_EL1.LS64 visbile to userspace
- Add identifying and enabling in the cpufeature list
- Expose these support of these features to userspace through HWCAP3
  and cpuinfo

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 Documentation/arch/arm64/booting.rst    | 12 ++++++
 Documentation/arch/arm64/elf_hwcaps.rst |  6 +++
 arch/arm64/include/asm/hwcap.h          |  2 +
 arch/arm64/include/uapi/asm/hwcap.h     |  2 +
 arch/arm64/kernel/cpufeature.c          | 51 +++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c             |  2 +
 arch/arm64/tools/cpucaps                |  2 +
 7 files changed, 77 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index ee9b790c0d72..837823d49212 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -483,6 +483,18 @@ Before jumping into the kernel, the following conditions must be met:
 
    - MDCR_EL3.TPM (bit 6) must be initialized to 0b0
 
+  For CPUs support for 64-byte loads and stores without status (FEAT_LS64):
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - HCRX_EL2.EnALS (bit 1) must be initialised to 0b1.
+
+  For CPUs support for 64-byte loads and stores with status (FEAT_LS64_V):
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - HCRX_EL2.EnASR (bit 2) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 69d7afe56853..9e6db258ff48 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -435,6 +435,12 @@ HWCAP2_SME_SF8DP4
 HWCAP2_POE
     Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
 
+HWCAP3_LS64
+    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0001.
+
+HWCAP3_LS64_V
+    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0010.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 1c3f9617d54f..f45ab66d3466 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -176,6 +176,8 @@
 #define KERNEL_HWCAP_POE		__khwcap2_feature(POE)
 
 #define __khwcap3_feature(x)		(const_ilog2(HWCAP3_ ## x) + 128)
+#define KERNEL_HWCAP_LS64              __khwcap3_feature(LS64)
+#define KERNEL_HWCAP_LS64_V            __khwcap3_feature(LS64_V)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 705a7afa8e58..88579dad778d 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -143,5 +143,7 @@
 /*
  * HWCAP3 flags - for AT_HWCAP3
  */
+#define HWCAP3_LS64		(1UL << 0)
+#define HWCAP3_LS64_V		(1UL << 1)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e151585c6cca..095f78d95507 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -238,6 +238,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_EL1_LS64_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_EL1_XS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_EL1_I8MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_EL1_DGH_SHIFT, 4, 0),
@@ -2291,6 +2292,38 @@ static void cpu_enable_e0pd(struct arm64_cpu_capabilities const *cap)
 }
 #endif /* CONFIG_ARM64_E0PD */
 
+static bool has_ls64(const struct arm64_cpu_capabilities *entry, int __unused)
+{
+	u64 ls64;
+
+	ls64 = cpuid_feature_extract_field(__read_sysreg_by_encoding(entry->sys_reg),
+					   entry->field_pos, entry->sign);
+
+	if (ls64 == ID_AA64ISAR1_EL1_LS64_NI ||
+	    ls64 > ID_AA64ISAR1_EL1_LS64_LS64_ACCDATA)
+		return false;
+
+	if (entry->capability == ARM64_HAS_LS64 &&
+	    ls64 >= ID_AA64ISAR1_EL1_LS64_LS64)
+		return true;
+
+	if (entry->capability == ARM64_HAS_LS64_V &&
+	    ls64 >= ID_AA64ISAR1_EL1_LS64_LS64_V)
+		return true;
+
+	return false;
+}
+
+static void cpu_enable_ls64(struct arm64_cpu_capabilities const *cap)
+{
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_EnALS, SCTLR_EL1_EnALS);
+}
+
+static void cpu_enable_ls64_v(struct arm64_cpu_capabilities const *cap)
+{
+	sysreg_clear_set(sctlr_el1, SCTLR_EL1_EnASR, SCTLR_EL1_EnASR);
+}
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 				   int scope)
@@ -3061,6 +3094,22 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_pmuv3,
 	},
 #endif
+	{
+		.desc = "LS64",
+		.capability = ARM64_HAS_LS64,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_ls64,
+		.cpu_enable = cpu_enable_ls64,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, LS64, LS64)
+	},
+	{
+		.desc = "LS64_V",
+		.capability = ARM64_HAS_LS64_V,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_ls64,
+		.cpu_enable = cpu_enable_ls64_v,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, LS64, LS64_V)
+	},
 	{},
 };
 
@@ -3180,6 +3229,8 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR1_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_EBF16),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, DGH, IMP, CAP_HWCAP, KERNEL_HWCAP_DGH),
 	HWCAP_CAP(ID_AA64ISAR1_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_I8MM),
+	HWCAP_CAP(ID_AA64ISAR1_EL1, LS64, LS64, CAP_HWCAP, KERNEL_HWCAP_LS64),
+	HWCAP_CAP(ID_AA64ISAR1_EL1, LS64, LS64_V, CAP_HWCAP, KERNEL_HWCAP_LS64_V),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, LUT, IMP, CAP_HWCAP, KERNEL_HWCAP_LUT),
 	HWCAP_CAP(ID_AA64ISAR3_EL1, FAMINMAX, IMP, CAP_HWCAP, KERNEL_HWCAP_FAMINMAX),
 	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index c1f2b6b04b41..3cca8d0a36f1 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -81,6 +81,8 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_PACA]		= "paca",
 	[KERNEL_HWCAP_PACG]		= "pacg",
 	[KERNEL_HWCAP_GCS]		= "gcs",
+	[KERNEL_HWCAP_LS64]		= "ls64",
+	[KERNEL_HWCAP_LS64_V]		= "ls64_v",
 	[KERNEL_HWCAP_DCPODP]		= "dcpodp",
 	[KERNEL_HWCAP_SVE2]		= "sve2",
 	[KERNEL_HWCAP_SVEAES]		= "sveaes",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 10effd4cff6b..8930208a1b07 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -43,6 +43,8 @@ HAS_HCX
 HAS_LDAPR
 HAS_LPA2
 HAS_LSE_ATOMICS
+HAS_LS64
+HAS_LS64_V
 HAS_MOPS
 HAS_NESTED_VIRT
 HAS_PAN
-- 
2.24.0


