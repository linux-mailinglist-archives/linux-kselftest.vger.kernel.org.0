Return-Path: <linux-kselftest+bounces-27866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84973A49641
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FD43A3BEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C860625D904;
	Fri, 28 Feb 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C7lFVwm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BEC25D215;
	Fri, 28 Feb 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736837; cv=fail; b=lR7Nlnx9/IgqWtdnRipSpWtBQLLUnRoHLaskhzMVkTRHBHcWBMrXxSp2xV18P5JFuLb3rVXhVRuNRSt6DImugmvaghMPNeu5osdkTDBqrz9EnyTxjeT80wke6AaC4zP0LdIJ/5OHjmpJwfvul2N8Mv4wLrytZr+vmTZ5+KqLntM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736837; c=relaxed/simple;
	bh=acyzADLyafEoCowuHUWwjAtsDLHSL5O46K5bItF/Uqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsuS0Rl6TedQORaFV0Pr+XsMmdSMCUkRryq224bCa1OJ7hOxvZBdDYmldUGPGetmlAKHadodBYxdX0KKRlE/K5/wMBa80jpF9rZB0deW+ef9SRU4FIuuChJMnrG5fYbhtsNhUsvE9+N0KxWOfGAi2DXKmrUPLRKlUFJuerCwuY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C7lFVwm8; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8gsw0iL2/5eYV5IzcCn02tWMkOiTFgkfJ2nzKgxi0kvw/aco3nRO/SLoPp2IpEXikrlH/3x21tgNp5OdNedsif79UKu+zLetpHp/Y1CgJEjNghjYnTD9Ob1VHz98bzwmUpP28MIXKk2cdGYj7X7SJEWY66Ff+sc2AAvSx4p3geb5u4sh99N/YSOUF3vOJEhjneyH/tbXjpaeCuGcGTrGY9Rnq57Kc4TuDYihUvpO/uOty7lVpwWXnxdlGTJm0haUNX+oCHNV2I1B11BSQ142MEpP4i7Y8jaOKZHHk/k77NiPc81+uFtPaFIpiDcZ+aI1PdqDlR2sNFmvuDLj65X4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pKE6RLaAWmEx0PGAQYTAZMsJhn2JgAgPrp4/QEuKMw=;
 b=BqtkcAGNSUQLOd400Qqx5xBGPw8HoKawhIDTk0XiBoMNWqiUYY8B7eBTRXx0mafPHQ7aWJ1ut1coN8QgjM5Q2m4enDSXpn6Bax/07HRG5ZJe1o07RZM2V32MPv7rkoI7WbgpgzuOm2wOQQRtrEnuBHOv55/v2ZLb/cxdC/fPyEU40hEjSMblXqe1/uSYG+Jx4YGgzvyV5v3mBW5uCO++7J9fgT48tzrH3rDvZp9pNN20n0BBdIhecYkb9a2pSruJGLpgEIaSomeLiun5ZG512H7yqu4GFMB+nPpsPRlx7FzwD0b2nCjZyr+lT3o+uTs2wb8QBAk2Pl7SwHxm7x+L4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pKE6RLaAWmEx0PGAQYTAZMsJhn2JgAgPrp4/QEuKMw=;
 b=C7lFVwm8ihlRUYam23v8A2YGtSrG9tivwB1YLa4ijicPXqiyfiTVxp7MRKSaaL3VCHBpyK81nJV6+H/14NXn4KzYh09+5J6ZYgX69+mtucrEn2n9IHlKp8hkLYJlmK8A/lNyEd7n2gaeNr1VyPzxoGMc8iw4Ueue5SNGsorXp3Y=
Received: from SN1PR12CA0069.namprd12.prod.outlook.com (2603:10b6:802:20::40)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 10:00:31 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::7c) by SN1PR12CA0069.outlook.office365.com
 (2603:10b6:802:20::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 10:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:00:30 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:59:26 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 24/31] KVM: selftests: Add Secure AVIC mode to xapic_ipi_test
Date: Fri, 28 Feb 2025 15:00:17 +0530
Message-ID: <20250228093024.114983-25-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 845fbab7-6e5f-44ad-c154-08dd57debbf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9vE/gPOKdFN1aamhz8/D0G+ZvHCRrOy3ChbrIIFzl5qFsQyEKEz+l6IyJDJc?=
 =?us-ascii?Q?OJdhL0DUI8zwWbrKMLsi5nBbJgpnIiTlNx6WMejEEzfbsKoNEoLSSCl3yBr8?=
 =?us-ascii?Q?duLNpFvEJaY5UuA0flvGZz/LwTuPS8lHSRjSwxaBRDsNNWQhYzW/mAO4vQ+R?=
 =?us-ascii?Q?eg3x4jJyQ+A5OrV/YYiZU97vwA0+nvGYGLtG40bXlvjR9eUkg8FqX1mGHlKa?=
 =?us-ascii?Q?vc3Kz/R+2dO2f1e4dDok2upOwFxUN4m89CJ1NawXeG+KYtJz2f4cVnpJt7fa?=
 =?us-ascii?Q?kA4Yl3DXs1SEd9BoUKfjIZvwuPAVtqO0BaCS/cd8ck7V10YPrggNWDFhxm49?=
 =?us-ascii?Q?bWcuQJRv3t+DYRlgPWd1b3wWFBCI88rx0TAxzh2XoEmSxkvwzacVthNliOmr?=
 =?us-ascii?Q?w/ClM0/EFlQtmAla1oWdXPcWQySb3XOkm2VGbhKzI4EVvHnmfVK9qHkWSIvr?=
 =?us-ascii?Q?HrDqoVBBMFdWf8e34KBlUdU5vmFBAkEsVhgxsTXurUXjykA4IefSLUuOrgQs?=
 =?us-ascii?Q?wWmoOspjRzb1uVo01jPcoctQNEBYWzQrB3OvgPaFDJEMP8hAtW/0e9hu+b5d?=
 =?us-ascii?Q?yolYA+NOVRxvpvO2TXk/XzELQ+Wr2nCT/pc/zglTe6I/dIFJjXnv/LKnJ9bb?=
 =?us-ascii?Q?cT4HF1BTxlJT2sLVhtQ3aFsCBlx03EsloOnuCVmb4ZfciI4pfbLpB2rLyoXU?=
 =?us-ascii?Q?uPKqXIfbv6//5wkIPpEorMU7cY9cqskB1UJ7kbsSoS12GV318F4Ow8DEuC2I?=
 =?us-ascii?Q?PYaKEh2XMKVZBk15lVJJdK93WIpNtvR19a9Ed9veVczCmAlIyRHVPLYtkV4A?=
 =?us-ascii?Q?d90zEbp6YwlC3HI9d94li6iYMDN4KNsFSh+sIATh0jTYBE+ylno6Dv3mrKue?=
 =?us-ascii?Q?SufdMgq9mST5aenNmTQ5QTJHHa68qsPJ/FcJnS0d2V0/ioAosmtgRYv+eDSJ?=
 =?us-ascii?Q?diemp5mvUWxTf0jKaZ13jF/La1ZL1UqfIMdiNBedwWc09bQ1mBnY2f7VqU1m?=
 =?us-ascii?Q?tZmqbPxkZtnGzVZNyL7ZsP94quhSmcKDe+LaCIgP0QBWWjMIDVOjziMb6ZrE?=
 =?us-ascii?Q?seCpI9TkGT0k76d9ALTY5lFLDCk8yMGKYk4+4MIhY5e3TPstBt/HhNS3VqmC?=
 =?us-ascii?Q?8ZLVC2nTuv6Xz31xUrP6BHvS5lWSkUfhOkLRAGYSOP7ZW6saQ1S9+gVuvATe?=
 =?us-ascii?Q?e3fIRAFuYTPNNl7GXZx+j7f/2QoEPN2LWCODphFS2rHKq5kxSfc7Ml6FDnWM?=
 =?us-ascii?Q?xszJTKyacK+7YHKmMzxZj3OEB0DMrrLuM/mesI2z7vwFN66jS0rcyoqpTleG?=
 =?us-ascii?Q?M1e1yyAUBibj7HLX7USEQrDN0Mk3bHMg5wGYCd/PpCqBoCrQc1OUsrdeI9ir?=
 =?us-ascii?Q?lANmr5L7CZwqi7BrzlgS4rpgHweLttyV3RtTsxu3F2dgDMiJcqSYfbg4Xhkc?=
 =?us-ascii?Q?bNnSD2wocxAxvx6BzXbkW7k90hdEbUyduKkMSSRYllGw8X1c8MR7cYAA56Jk?=
 =?us-ascii?Q?qJ6is65vrHM+fMs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:00:30.3236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845fbab7-6e5f-44ad-c154-08dd57debbf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529

Test cross-vCPU IPI for Secure AVIC guests using xapic_ipi_test.
Add new "SAVIC" apic mode to the test for this.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/arch/x86/include/asm/msr-index.h        |  4 +-
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../selftests/kvm/x86/xapic_ipi_test.c        | 70 ++++++++++++++-----
 3 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..93f3ff9991cc 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -680,7 +680,9 @@
 #define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
 #define MSR_AMD64_SNP_SMT_PROT_BIT	17
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
-#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
+#define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		19
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 3f9369644962..f09b18944c47 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -201,6 +201,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 #define X86_FEATURE_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
+#define X86_FEATURE_SECURE_AVIC         KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 26)
 
 /*
  * KVM defined paravirt features.
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 3a54d828dc69..e11c7ded8b8a 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -31,6 +31,7 @@
 #include "test_util.h"
 #include "vmx.h"
 #include "sev.h"
+#include "savic.h"
 
 /* Default running time for the test */
 #define DEFAULT_RUN_SECS 3
@@ -45,30 +46,44 @@
  */
 #define IPI_VECTOR	 0xa5
 
+enum apic_mode {
+	XAPIC,
+	X2APIC,
+	SAVIC,
+};
+
 /*
  * Incremented in the IPI handler. Provides evidence to the sender that the IPI
  * arrived at the destination
  */
 static volatile uint64_t *ipis_rcvd;
 
-static bool x2apic;
+static int apic_mode;
 
 static void apic_enable(void)
 {
-	if (x2apic)
-		x2apic_enable();
-	else
+	switch (apic_mode) {
+	case XAPIC:
 		xapic_enable();
+		break;
+	case X2APIC:
+		x2apic_enable();
+		break;
+	case SAVIC:
+		x2apic_enable();
+		savic_enable();
+		break;
+	}
 }
 
 static uint32_t apic_read_reg(unsigned int reg)
 {
-	return x2apic ? x2apic_read_reg(reg) : xapic_read_reg(reg);
+	return apic_mode != XAPIC ? x2apic_read_reg(reg) : xapic_read_reg(reg);
 }
 
 static void apic_write_reg(unsigned int reg, uint64_t val)
 {
-	if (x2apic)
+	if (apic_mode != XAPIC)
 		x2apic_write_reg(reg, val);
 	else
 		xapic_write_reg(reg, (uint32_t)val);
@@ -144,7 +159,7 @@ static void halter_guest_code(struct test_data_page *data)
 static void guest_ipi_handler(struct ex_regs *regs)
 {
 	(*ipis_rcvd)++;
-	apic_write_reg(APIC_EOI, 77);
+	apic_write_reg(APIC_EOI, 0);
 }
 
 static void sender_guest_code(struct test_data_page *data)
@@ -184,7 +199,7 @@ static void sender_guest_code(struct test_data_page *data)
 		 * First IPI can be sent unconditionally because halter vCPU
 		 * starts earlier.
 		 */
-		if (!x2apic) {
+		if (apic_mode == XAPIC) {
 			apic_write_reg(APIC_ICR2, icr2_val);
 			apic_write_reg(APIC_ICR, icr_val);
 		} else {
@@ -385,10 +400,10 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 }
 
 void get_cmdline_args(int argc, char *argv[], int *run_secs,
-		      bool *migrate, int *delay_usecs, bool *x2apic, int *vm_type)
+		      bool *migrate, int *delay_usecs, int *apic_mode, int *vm_type)
 {
 	for (;;) {
-		int opt = getopt(argc, argv, "s:d:v:me:t:");
+		int opt = getopt(argc, argv, "s:d:v:me:t:g");
 
 		if (opt == -1)
 			break;
@@ -403,7 +418,7 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 			*delay_usecs = parse_size(optarg);
 			break;
 		case 'e':
-			*x2apic = parse_size(optarg) == 1;
+			*apic_mode = parse_size(optarg);
 			break;
 		case 't':
 			*vm_type = parse_size(optarg);
@@ -431,7 +446,7 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 				    " Default is no migrations.\n"
 				    "-d <delay microseconds> - delay between migrate_pages() calls."
 				    " Default is %d microseconds.\n"
-				    "-e <apic mode> - APIC mode 0 - xapic , 1 - x2apic"
+				    "-e <apic mode> - APIC mode 0 - xapic , 1 - x2apic, 3 - Secure AVIC"
 				    " Default is xAPIC.\n"
 				    "-t <vm type>. Default is %d.\n"
 				    "Supported values:\n"
@@ -483,10 +498,17 @@ int main(int argc, char *argv[])
 	bool is_sev;
 
 	get_cmdline_args(argc, argv, &run_secs, &migrate, &delay_usecs,
-			 &x2apic, &vm_type);
+			 &apic_mode, &vm_type);
+	if (apic_mode == SAVIC) {
+		vm_type = KVM_X86_SNP_VM;
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SNP));
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_IDLE_HLT));
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SECURE_AVIC));
+	}
+
 	is_sev = is_sev_vm_type(vm_type);
 
-	if (x2apic)
+	if (apic_mode != XAPIC)
 		migrate = 0;
 
 	if (run_secs <= 0)
@@ -494,18 +516,28 @@ int main(int argc, char *argv[])
 	if (delay_usecs <= 0)
 		delay_usecs = DEFAULT_DELAY_USECS;
 
-	if (is_sev)
+	if (apic_mode == SAVIC) {
+		struct kvm_sev_init args = { .vmsa_features = BIT_ULL(SVM_FEAT_SECURE_AVIC) |
+						BIT_ULL(SVM_FEAT_ALLOWED_SEV_FEATURES_VALID)
+					   };
+
+		vm = _vm_sev_create_with_one_vcpu(vm_type, halter_guest_code,
+				&params[0].vcpu, &args);
+	} else if (is_sev) {
 		vm = vm_sev_create_with_one_vcpu(vm_type, halter_guest_code,
 				&params[0].vcpu);
-	else
+	} else {
 		vm = vm_create_with_one_vcpu(&params[0].vcpu, halter_guest_code);
+	}
 
 	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
-	if (is_sev_es_vm(vm))
+	if (apic_mode == SAVIC)
+		vm_install_exception_handler(vm, 29, savic_vc_handler);
+	else if (is_sev_es_vm(vm))
 		vm_install_exception_handler(vm, 29, sev_es_vc_handler);
 
-	sync_global_to_guest(vm, x2apic);
-	if (!x2apic)
+	sync_global_to_guest(vm, apic_mode);
+	if (apic_mode == XAPIC)
 		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
 	params[1].vcpu = vm_vcpu_add(vm, 1, sender_guest_code);
-- 
2.34.1


