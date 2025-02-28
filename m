Return-Path: <linux-kselftest+bounces-27868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95968A49684
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C377AA8A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4786C25DAE0;
	Fri, 28 Feb 2025 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTnbbg7s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7825D910;
	Fri, 28 Feb 2025 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737019; cv=fail; b=prcGbZQuazhitsTeuOk/uoRjLfiBU3HUdp0iTV0adHoUEEz/cpfkr12RrhnUZNoHXC+Y7U6Zu/gsBjYcApHN+23DZehOUkPZc7DGPbRGj9mgcBUsWFUWMIOQF36tZVhc8jd7abvs+HXIlJPqOFEYuKW/HuDCY3cTqIjNfyswt/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737019; c=relaxed/simple;
	bh=l2SdbOLx1UtR+zm0Y8CiXAS/lQGnBOdJx9qxeT7vIUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kzz0IJAZsylc/lzOdJR5J1woWc2SMHsqHANWyn9ug6TJqX32rdALjbT0uzppN5zVcE+BbS08CTvB070PibLH4a3DlQf8KpJ2tn5iiHQdfV4wTfv8Q2rQAGNapt2WD6EGFwoe/ZMc9wXlLS2U8UcvE/2fSHceKLy5wDe6MIkZ4KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTnbbg7s; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlyLkSYe2XAhendbFXve+MENOTJ598sb7PlrEsrdgiaj/HnXx5my8KwqjysORyDAHhTbdiEeJ/RxypCAVTfFQDVCJyAXoT2PZBrZ8jQ28uqou2AIltCuhqd5iNDAa4YmpSmZoOYmpU81dOyJLBrzsbICC57ay1DjAc8+2urDEKu3yiGHQ0TUNk+9gGh/zHpbASwoY8+vjNPrVuWtcyeVnW/9wvRH+uq/yS4RYGebs5RjESB90+L/RPnENE9BxBa6VAYzTm3fCV12WNC/pWaZivCZvUgdu7VOHrKfHlTfSikMaAATWFdpWPdDJEfqdg8g+LU7YiDDAvtYIUkH6gKRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTAPrOe17RYinZ4WPSCZP78vnTnClburp1yunSCm6Wk=;
 b=FDn7BuxYGkOvdG1woLfgtQs0FnSyQDb+C0XSLsptsEQv+FIbDtkzJ6RiIe2Z3e/RuOomwcQF3hfWgQ3eORil1dtNcik78Irv03q5l3e0JJttky2aC63BPqXdMrE7LNxtLetTRXNSERQ23xfv6Di5J30tuYf/9Ke1mTeoZhfjmlHBS/VXEI3BvhOxHkSb/he/dh9U9vydihkHEGEUruCqx+Nlq2kAN8PlmGYe4S81Uxr+EA72qygpeyOYWPETxZ007nlWO10edMeFlP36DPKaIHgEjxHM3MDMNiuXhA2ILPo6KDV6IpFQogoLRXKnZEpRsvogoMnYJTY8MYaXG+pYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTAPrOe17RYinZ4WPSCZP78vnTnClburp1yunSCm6Wk=;
 b=BTnbbg7sQEpNSD+ZOa/aqXJ3wg3MYRgCdsRanQjEAQNI+nO8SIb1aENqXLlA8uEO+MaHKZad4YAj8TfJZl6CPYJ/Ts8Q9gEDHMNSYhj26rDtcN4MUDXs5vwT78PfIgSZILMro6t/2RBFAXTcnsEMqk+5ZiKYd9qJMf692yOqFZs=
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 10:03:33 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::b) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 10:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:03:32 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:02:59 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 26/31] KVM: selftests: Add test to verify APIC MSR accesses for SAVIC guest
Date: Fri, 28 Feb 2025 15:00:19 +0530
Message-ID: <20250228093024.114983-27-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efda854-17bc-4997-3d01-08dd57df28be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aAHUZQ2q46hRoDJECgTH5HrhprTHwqwiFs2fsBiOetQp9gCBK8JQ7YUMJUpQ?=
 =?us-ascii?Q?EUrdqrU4WE1HglHMFyBSejIG4U6RJdNgzdN8jDeUADP0wmyJbcyJbYIXkfJv?=
 =?us-ascii?Q?N3zvkKTO0HmCLo8S0siySmPsXKbDYnnlFt8ah+MTwu34MC+KonOvYG/f0iab?=
 =?us-ascii?Q?bE0ZZfMj8wYfuqaKhVMpTpMGxUm1AvP/3OrY8n32bdRqCd4iudXBsIph9bHK?=
 =?us-ascii?Q?PmAMeQVVGkGFGGbn0k0KkH6kXZykhxjcphQJuE+6r7KkhdXQxDBhvXbkaRX0?=
 =?us-ascii?Q?neV2xu/LclM9BnWNpU+039Tx3e9897Uv9agHvi/7VZRkJ3bfVrvsIjcHHusW?=
 =?us-ascii?Q?8zQ6R9QezQgdWeUtQPDrOHyGjZvHylDNUZc2b91ZGx1/bwk0ylMXu13AlzLi?=
 =?us-ascii?Q?dGz8pTWuHWoSmroru//j3VjEAX0y9H8SiMu+iI6h+90aRw9OoZVUNFKkuBxY?=
 =?us-ascii?Q?ydnP49DKgwDloK8lSWGYf2oVYytdESrt+idhE2sRWNRplVUgN9S+GvsDudoA?=
 =?us-ascii?Q?Y9GdXUMb8uKLD4Do8HFiEIQbWWug5YpRYZ4h8U59GJoCeT/tjhs2Cncx7mSo?=
 =?us-ascii?Q?h+67b2nbCyfEqgMBDGMC3ewBlB8rHF2HZuH5zXU2gyqYuwbKk7ztFpXDHLnC?=
 =?us-ascii?Q?WPwuvm29g/Fd/3LB+xN/KAY/fpU1qW/EbsutTU8vkBKb14tdJGISetkKxI0j?=
 =?us-ascii?Q?VoZckofA59nCeXPqKEUWLVk3PtQG84NO4FbHYpLFrPH/cbc5c2Z4WhYHZltj?=
 =?us-ascii?Q?XrgjBJDEdSpSwwpZ5zbe3dYpwp9FRJ7ek0dKO6lkZ3ICDaHo377Yck35cZ8m?=
 =?us-ascii?Q?uL/IL0D152PCUg8ThlANuAfhCAkW61I6V6cf7JRMI6yak3rcVyeENzxbmiPz?=
 =?us-ascii?Q?gC+JFW0yGovh9myE+bqQaI0QC0JlKz9Ku4rgSWdeItZMv5TnNlKzOZ5Qfa/W?=
 =?us-ascii?Q?cUGGvi0VFz9IE8c4RjABCJ6PaEGoExbM6bPzWl9DRirX2j7kpkyIra4keeBK?=
 =?us-ascii?Q?7NZRT3FbVhbUVhTGpupMrB+uf1e9/f4vYJZrttZvAg1iBHgE9P2m6oNz0nNq?=
 =?us-ascii?Q?A6PXJ0Wnh9L6La55qIETFJgjvm8HedXme49/H1V789U72nBkvXFvpm2/heAw?=
 =?us-ascii?Q?gogWaQScb6kyB6ZZjWiTv2UUyab33dO8JLvihWOhXq/5qtD8Nun+Zvdjm1Nt?=
 =?us-ascii?Q?AZLA5GuY7r4lfwzivVNqVlQDbepuzGuRGBw/S6k+yMHn+DrdNhP0KFbyT4MO?=
 =?us-ascii?Q?wQ19/ieZ8p/CExXyotD5xV9pMBRsB91VzNt4qpwL7IZVn57Xo1mV45wTy8Gy?=
 =?us-ascii?Q?i5lT5rC6O1eeXC/dh5GmUhe4vVFQGE4lCG9tUGb6BUZFe1GPy8eg16LBGXdn?=
 =?us-ascii?Q?q6nNmZLYuMAHMP4Vp2q412wCsyd++CtHhgz42SByWHZUfvdW59nTE0kzf8aW?=
 =?us-ascii?Q?zw080oFNl/B0685PICM9yRIMk2uLXueg4z8EzTUNxqzni/cFTy4vc6CEHX5U?=
 =?us-ascii?Q?6lIdgQEnMNgx9/0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:03:32.7639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efda854-17bc-4997-3d01-08dd57df28be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084

Extend SAVIC test to verify APIC MSR accesses in SAVIC enabled
mode. Verify the behavior of reads and writes using rdmsr/wrmsr
for various APIC registers. In addition, test whether wrmsr
based writes are propagated to guest backing page.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/include/x86/apic.h  |   1 +
 .../testing/selftests/kvm/include/x86/savic.h |   3 +
 tools/testing/selftests/kvm/lib/x86/savic.c   |   7 +-
 tools/testing/selftests/kvm/x86/savic_test.c  | 192 +++++++++++++++++-
 4 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index aa3a5d54c404..af555638086f 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -33,6 +33,7 @@
 #define	APIC_SPIV	0xF0
 #define		APIC_SPIV_FOCUS_DISABLED	(1 << 9)
 #define		APIC_SPIV_APIC_ENABLED		(1 << 8)
+#define APIC_ISR	0x100
 #define APIC_TMR        0x180
 #define APIC_IRR	0x200
 #define	APIC_ICR	0x300
diff --git a/tools/testing/selftests/kvm/include/x86/savic.h b/tools/testing/selftests/kvm/include/x86/savic.h
index cb432eb527b3..33f19f5e39b3 100644
--- a/tools/testing/selftests/kvm/include/x86/savic.h
+++ b/tools/testing/selftests/kvm/include/x86/savic.h
@@ -6,6 +6,9 @@
 #ifndef SELFTEST_KVM_SAVIC_H
 #define SELFTEST_KVM_SAVIC_H
 
+#define APIC_REG_OFF(VEC)		(VEC / 32 * 16)
+#define APIC_VEC_POS(VEC)		(VEC % 32)
+
 struct guest_apic_page;
 
 void guest_apic_pages_init(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index d4c9fcf835ad..c637e486b6e8 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -9,6 +9,7 @@
 #include "kvm_util.h"
 #include "sev.h"
 #include "ex_regs.h"
+#include "savic.h"
 
 struct apic_page {
 	u8 apic_regs[PAGE_SIZE];
@@ -45,9 +46,6 @@ enum lapic_lvt_entry {
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS      0x402
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI            0x401
 
-#define REG_OFF(VEC)		(VEC / 32 * 16)
-#define VEC_POS(VEC)		(VEC % 32)
-
 #define SAVIC_NMI_REQ_OFFSET            0x278
 
 /*
@@ -363,7 +361,8 @@ static void send_ipi(int cpu, int vector, bool nmi)
 	if (nmi)
 		savic_write_reg(apic_page, SAVIC_NMI_REQ_OFFSET, 1);
 	else
-		savic_write_reg(apic_page, APIC_IRR + REG_OFF(vector), BIT(VEC_POS(vector)));
+		savic_write_reg(apic_page, APIC_IRR + APIC_REG_OFF(vector),
+				BIT(APIC_VEC_POS(vector)));
 }
 
 static bool is_cpu_present(int cpu)
diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index ca1d7352bc3e..8cba7a81bce2 100644
--- a/tools/testing/selftests/kvm/x86/savic_test.c
+++ b/tools/testing/selftests/kvm/x86/savic_test.c
@@ -29,6 +29,7 @@ enum savic_test_state {
 	SAVIC_TEST_STATE(X2APIC_ENABLE),
 	/* APIC regs state on Secure AVIC enablement */
 	SAVIC_TEST_STATE(SAVIC_EN),
+	SAVIC_TEST_STATE(SAVIC_APIC_MSR_ACCESSES),
 };
 
 /* APIC reg values written by host. */
@@ -288,6 +289,193 @@ static void guest_savic_enabled(int id)
 	savic_write_apic_regs(apage);
 }
 
+static int savic_wrmsr(uint32_t reg, uint64_t val)
+{
+	switch (reg) {
+	case APIC_LVR:
+	case APIC_LDR:
+	case APIC_ISR:
+	case APIC_TMR:
+	case APIC_IRR:
+	case APIC_TMCCT:
+		x2apic_write_reg_fault(reg, val);
+		return -1;
+	default:
+		x2apic_write_reg(reg, val);
+		break;
+	}
+
+	return 0;
+}
+
+static uint64_t savic_rdmsr(uint32_t reg)
+{
+	uint64_t val;
+	uint32_t msr = APIC_BASE_MSR + (reg >> 4);
+
+	switch (reg) {
+	case APIC_EOI:
+		uint8_t fault = rdmsr_safe(msr, &val);
+
+		__GUEST_ASSERT(fault == GP_VECTOR,
+				"Wanted #GP on RDMSR(%x) = %x, got 0x%x\n",
+				msr, GP_VECTOR, fault);
+		return val;
+	default:
+		return x2apic_read_reg(reg);
+	}
+}
+
+static void guest_verify_host_guest_reg(struct guest_apic_page *apage, uint32_t reg,
+		uint64_t val, char *regname)
+{
+	uint64_t hval, gval, gval2;
+
+	if (savic_wrmsr(reg, val) == -1) {
+		savic_write_reg(apage, reg, val);
+		/*
+		 * Write using PV interface if wrmsr fails. Skip for
+		 * regs which trigger GP
+		 */
+		if (reg != APIC_LVR && reg != APIC_TMR && reg != APIC_IRR)
+			savic_hv_write_reg(reg, val);
+	}
+
+	gval = savic_read_reg(apage, reg);
+	gval2 = savic_rdmsr(reg);
+	hval = savic_hv_read_reg(reg);
+	__GUEST_ASSERT(gval == val, "Unexpected Guest %s 0x%lx, expected val:0x%lx\n",
+			regname, gval, val);
+	__GUEST_ASSERT(gval == gval2, "Unexpected Guest %s backing page value : 0x%lx, msr read val:0x%lx\n",
+			regname, gval, gval2);
+
+	switch (reg) {
+	case APIC_LVR:
+	case APIC_LDR:
+	case APIC_ISR:
+	case APIC_TMICT:
+	case APIC_TDCR:
+	case APIC_LVTT:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+		__GUEST_ASSERT(hval == gval, "Guest 0x%lx host 0x%lx %s mismatch\n",
+			gval, hval, regname);
+		break;
+	case APIC_TASKPRI:
+	case APIC_SPIV:
+	case APIC_ICR:
+	case APIC_TMR:
+	case APIC_IRR:
+		__GUEST_ASSERT(hval != gval, "Guest 0x%lx host 0x%lx reg: %x %s must not match\n",
+			gval, hval, reg, regname);
+		break;
+	default:
+		break;
+	}
+}
+
+static inline uint32_t x2apic_ldr(uint32_t id)
+{
+	return ((id >> 4) << 16) | (1 << (id & 0xf));
+}
+
+static void guest_savic_apic_msr_accesses(int id)
+{
+	struct guest_apic_page *apage = get_guest_apic_page();
+	uint64_t val, hval;
+	uint32_t reg;
+	int vec;
+	int i;
+	uint32_t lvt_regs[] = {
+		APIC_LVTT, APIC_LVTTHMR, APIC_LVTPC,
+		APIC_LVT0, APIC_LVT1, APIC_LVTERR
+	};
+
+	reg = APIC_LVR;
+	val = savic_hv_read_reg(reg);
+	/* APIC_LVR state is in sync between host and guest. */
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_LVR");
+
+	reg = APIC_TASKPRI;
+	val = 0x30;
+	/* Write new TASKPRI to host using PV interface. */
+	savic_hv_write_reg(reg, val);
+	val = 0x40;
+	/* TASKPRI is accelerated and state is not up-to-date in host. */
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_TASKPRI");
+
+	reg = APIC_PROCPRI;
+	val = x2apic_read_reg(reg);
+	/* APIC_PROCPRI is updated with the APIC_TASKPRI update above. */
+	GUEST_ASSERT((val & 0xf0) == (x2apic_read_reg(APIC_TASKPRI) & 0xf0));
+	GUEST_ASSERT((val & 0xf0) == 0x40);
+	vec = 0x20;
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | vec);
+	/* Interrupt remains pending in APIC_IRR. */
+	val = savic_read_reg(apage, APIC_IRR + APIC_REG_OFF(vec));
+	GUEST_ASSERT((val & BIT_ULL(APIC_VEC_POS(vec))) == BIT_ULL(APIC_VEC_POS(vec)));
+	savic_wrmsr(APIC_TASKPRI, 0x0);
+
+	/* Triggers GP fault */
+	savic_rdmsr(APIC_EOI);
+
+	reg = APIC_LDR;
+	val = x2apic_ldr(savic_rdmsr(APIC_ID));
+	hval = savic_hv_read_reg(APIC_LDR);
+	__GUEST_ASSERT(val == hval, "APIC_LDR mismatch between host %lx and guest %lx",
+			hval, val);
+
+	/* APIC_SPIV state is not visible to host. */
+	reg = APIC_SPIV;
+	val = savic_rdmsr(APIC_SPIV) & ~APIC_SPIV_APIC_ENABLED;
+	savic_hv_write_reg(reg, val);
+	val = savic_rdmsr(APIC_SPIV) | APIC_SPIV_APIC_ENABLED;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_SPIV");
+
+	reg = APIC_ISR;
+	(void) savic_rdmsr(reg);
+	/* Triggers GP fault */
+	savic_wrmsr(reg, 0x10);
+
+	/* APIC_TMR is not synced to host. */
+	reg = APIC_TMR;
+	val = 0x10000;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_TMR");
+	vec = 0x20;
+	savic_write_reg(apage, reg + APIC_REG_OFF(vec),  BIT_ULL(APIC_VEC_POS(vec)));
+	GUEST_ASSERT(x2apic_read_reg(reg + APIC_REG_OFF(vec)) & BIT_ULL(APIC_VEC_POS(vec)));
+
+	reg = APIC_IRR;
+	val = 0x10000;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_IRR");
+	savic_write_reg(apage, reg, 0x0);
+
+	reg = APIC_TMICT;
+	val = 0x555;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_TMICT");
+
+	reg = APIC_TMCCT;
+	savic_rdmsr(reg);
+	savic_wrmsr(reg, 0xf);
+
+	reg = APIC_TDCR;
+	val = 0x1;
+	savic_hv_write_reg(reg, val);
+	val = 0x3;
+	guest_verify_host_guest_reg(apage, reg, val, "APIC_TDCR");
+
+	for (i = 0; i < ARRAY_SIZE(lvt_regs); i++) {
+		reg = lvt_regs[i];
+		val = 0x41;
+		savic_hv_write_reg(reg, val);
+		val = 0x42;
+		guest_verify_host_guest_reg(apage, reg, val, "APIC_LVTx");
+	}
+}
+
 static void guest_code(int id)
 {
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SNP_SECURE_AVIC);
@@ -302,6 +490,8 @@ static void guest_code(int id)
 
 	SAVIC_GUEST_SYNC(SAVIC_EN, guest_savic_enabled);
 
+	SAVIC_GUEST_SYNC(SAVIC_APIC_MSR_ACCESSES, guest_savic_apic_msr_accesses);
+
 	GUEST_DONE();
 }
 
@@ -448,7 +638,7 @@ int main(int argc, char *argv[])
 
 	vcpu_args_set(vcpus[0], 1, vcpus[0]->id);
 
-	vm_install_exception_handler(vm, 29, sev_es_vc_handler);
+	vm_install_exception_handler(vm, 29, savic_vc_handler);
 	vm_sev_launch(vm, snp_default_policy(), NULL);
 
 	r = pthread_create(&threads[0], NULL, vcpu_thread, vcpus[0]);
-- 
2.34.1


