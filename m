Return-Path: <linux-kselftest+bounces-42120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F177B9461B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3801900F04
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CB30FC2B;
	Tue, 23 Sep 2025 05:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KGa+tBLx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CF30FC13;
	Tue, 23 Sep 2025 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604724; cv=fail; b=Li5XXhs/gVhjV18E5h8dhKte+k6p6cN8v4B513itbWM8H0xDGv+YU2wF96eN35Pd5atgfJpniOp3GaPA2bZ8vW6OdWPzpAyIf1r+duDKDVqhivbiDQakpoxi2PCIPOjqr+P990VYpNKKFjMBwFOs0DfzkkX14URVJDKljG+xC/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604724; c=relaxed/simple;
	bh=8aeSaXjA7w2hJ8CewSYwVfgXYxrdeKNO3qTwFnxc7hg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPpbeSjaGK6j/lHxHlpxlXL3122pun5UB4fHJIvoH8WTcPWzw8MytPw94OF28KgqSY0E9NZ9eStvNC2KUJ/Wmq0kLsCO17terIZfp+X5mTT5SP6oD62GwZCDkoGFUIE20P+7NPuoI/3DdeDRWzLPQr1TGkP6Esh1Z9lBOdtROak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KGa+tBLx; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4St8gWEgecFKOlEQrgsClsceD18AnQbA/tVC9qpU14CTxh43gPkeW37dd8MPzidzBN25YxUL/7shqxdSndZXb0NQ36uzKBSPryEa+owzkT5hFowyhOwLMr3TCcm7F5FNzomOfHOcD0fBuFjDvwero0VGlL8rIKTz6PrxlYoxNm5m14VtRPyDdnBlpFuMHNdE099y122H+PCOKHUB9zx5JCHotV+z8FlWev61TY3oY/dwcFDjDZb5nNgt/G5uJjkmT2q4hG8nCI+RTD8NyGNxqkpQ+h7iockY/odQvVU0Wa8EoknvKjAvBbebQtUjtNYScedQr1E/4Xv1iniCBbIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZbSeaR51/RW7ouBNdCjbWSjtP35StoQOAF915Wr8lM=;
 b=Xy7V+m65gDpnw87eTBEbuJqFPdKpjta3Fyj+uHNgikCbwnPZ74jdELcqcsuvg7+/2NmdhkyaUNSgmoZ7D6sDbxiyiful9FosaG28Y2BQMeZZi5sKCcbFra5KMZOzbaAZoC7LGb7CTXxVB0RuaMDrwkpVcKvsTRSFu9StFpTx6QfyhFOu+ukmXGhHyotMF5ci0Ni15OZVZEZRwk270NkTc0HbdwSVMUBAZWL9rwd33rj587y+QqZ82O5mL94/aIaXxYQlE6dq4Nt42KLToYnf0OOpfZ5vL7o+aAzpi3DmO4+jSanZIqlcJkNIssiI42ffnL75mZUDpDHh1CD/qpOzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZbSeaR51/RW7ouBNdCjbWSjtP35StoQOAF915Wr8lM=;
 b=KGa+tBLxWWgQWyhOBTM9ZULkM7u1GcBoo0DSfv+nwa/5M+3D258I+rZ4KmsKetwUCG0fHRYZKJ4dyFdVgx/qqdGF4hPSHS8pcq8eG8HX9bUqTv2EFWvbPN1dbQIUFJb3THZmQ6Dc07rgeDwZVIZ9o8MV7Vvu6sEFxjKHLV5kpDo=
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:18:40 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::dd) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:18:39 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:18:24 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 29/35] KVM: selftests: Add Secure AVIC mode to xapic_ipi_test
Date: Tue, 23 Sep 2025 10:39:36 +0530
Message-ID: <20250923050942.206116-30-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 550fed45-9566-48e7-95a6-08ddfa60a820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G3iGp+s8+qoIdAYjuXGm8drd1sM9J0dBUqvSkNP6GL2is0aKT2RkHEozx4wF?=
 =?us-ascii?Q?6yPvAmIJv1I7UWYc2S9yRFsXgUdkkkD5y/i2ARugxFxUfxAFwk5pyhN/3zKE?=
 =?us-ascii?Q?3CCfw1gXHws7/gbALskt0U23fuAKHq4D/5ia4Kd4rgTs8ZrB5jlBmBG2lFKk?=
 =?us-ascii?Q?mWWKj5i0v/buofUMu1shZpSaRyTVNU8hwrXhY2/PJiI97xu7dTRFcpJOlWO7?=
 =?us-ascii?Q?iQMw9olbdf8ZT/vwYjAbeLq7zulXmVnas4chtVzv1vY8IuAfLQD9EmBz/FAf?=
 =?us-ascii?Q?6mUiiIpMgN4pXrqPnjYPtcfFc1+FR0q8JHa6ZUP7k78/4LiNyAQhpEOgLP/i?=
 =?us-ascii?Q?NRMQjmPp4Uylho8mjyDfCUxaiewFnHyZmXKo+gXpwjKVR7yCF6Sy5U7xTk4j?=
 =?us-ascii?Q?typK0pwA7/VyclZQfWpxHO5uYOHnYzEuTr6kVawRuKsvjmO5ufeflx3CtzFV?=
 =?us-ascii?Q?1Or2qRpRrdHD8W9pcXbyDoIQ7ua1mTjX3M0SkdrGK6DS0LqKZVmmEbYhd84K?=
 =?us-ascii?Q?NQIAGJYbr6Yqyg9k+XNUGA8UsMJcjPrJhx3RC1knhSyqXmWH6aUJRftRV1jn?=
 =?us-ascii?Q?tfTDpYABuVacf8z8LWR74MJexKOwWbDoOIIAGViCM0iIsq6vI9AY9oG9tJgc?=
 =?us-ascii?Q?iy+dJdE7c9Fd3whNC27VjSs1YkaXY+ivNKQ01WRMV6QvFp4IVAEV2FrB7nUl?=
 =?us-ascii?Q?ouKF49eE3845nVao5DNwlxDt9eX83qVkB2CI0jp+zOQ0sxuSsbeJDwoftEMl?=
 =?us-ascii?Q?kG9ix0v97kkEURbnaoTCrTfcrVR74gQ31ympGM4lKMUf/MvgoNhB1GpHHVnZ?=
 =?us-ascii?Q?l0Aaqg7/9Irk+2uJSbKbXL6pQnKRTceneRk/txRb8RlW/LCUhs9FfsJxzyzh?=
 =?us-ascii?Q?Fl3LkQ8lZ8dTnuJ8ud0adq3gU0N2bygZQfV/cfZr74t8AhePSgYmj8HrsjnG?=
 =?us-ascii?Q?sRR87HjKLY1WulZr2O43pk7inKmaHyXUMTV1sJEJnsnJFjDXoV0JsO7bjeHh?=
 =?us-ascii?Q?F73RFyijGhHoxyYW4sjt4RgFw2Y/cotS8NOYNhCAqn3i1aq43xZ8jzVGpDlR?=
 =?us-ascii?Q?DeV/SSFnxrE+5L5xAiHTj46Im4AYDRYeSKHBJPlQk1kq/u/4dz0koyUsuK1U?=
 =?us-ascii?Q?8qxu1uwxES5D5VHLC9dfWQmwJ7NE+tx7GVkHSYVl58EUnr2DP6OOBs+t8vSy?=
 =?us-ascii?Q?h5284sAozMno/VVURRqlxDxk+XXBGUrd9pOrcAkFGvY6NJSBASrDYWG7Fb5E?=
 =?us-ascii?Q?5B7M7MGGUbdjUNQ+o1kKEgZonmmLmYj3dV7P9EmxEg/lNzC7mCKlC2Vuh8iZ?=
 =?us-ascii?Q?Eno20sN1t5gRhTBexlYa7oLinZm05/XRR8F1Q46vG6yxSe/gtBuFMq1rQvVG?=
 =?us-ascii?Q?PjVbKkUdjFEoo4ewBaUgV0HsxUt7fdQJKzDpJ8DBt7ZXMrvXbPSqWF6VGyOc?=
 =?us-ascii?Q?hZDwQxO9ivW+bhmVds6/Xsr6hAtKJCYJkDgg/5UHO01/36OAsFjJSMIldUim?=
 =?us-ascii?Q?FpTEF1NqWJbHbt+GBUZ9DEZJj1FRaR0s7BXh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:18:39.9653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550fed45-9566-48e7-95a6-08ddfa60a820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556

Extend the xapic_ipi_test to validate Inter-Processor Interrupt (IPI)
functionality in SEV-SNP guests with Secure AVIC (SAVIC) enabled.

Secure AVIC alters how IPIs are handled. Instead of relying solely on
KVM's APIC emulation/AVIC hardware, an attempt to send an IPI triggers
a #VC(INCOMPLETE_IPI) exception, delegating the IPI delivery logic
to the guest's #VC handler. This new execution model requires
dedicated test coverage.

With these changes, the existing IPI test framework can now run on
SAVIC-enabled vCPUs, verifying that the guest-side emulation correctly
delivers interrupts between cores and providing critical test coverage
for this SEV-SNP feature.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/arch/x86/include/asm/msr-index.h        |  4 +-
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../selftests/kvm/x86/xapic_ipi_test.c        | 72 +++++++++++++------
 3 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 5cfb5d74dd5f..be08f4aca4ad 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -698,7 +698,9 @@
 #define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
 #define MSR_AMD64_SNP_SMT_PROT_BIT	17
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
-#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
+#define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		19
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 035ced9130c2..769c6be41f1b 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -204,6 +204,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 #define X86_FEATURE_SEV_SNP		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
+#define X86_FEATURE_SECURE_AVIC         KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 26)
 #define	X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
 #define	X86_FEATURE_LBR_PMC_FREEZE	KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)
 
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 3d49f7798dcc..4fde0f4efb41 100644
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
@@ -145,7 +160,7 @@ static void halter_guest_code(struct test_data_page *data)
 static void guest_ipi_handler(struct ex_regs *regs)
 {
 	(*ipis_rcvd)++;
-	apic_write_reg(APIC_EOI, 77);
+	apic_write_reg(APIC_EOI, 0);
 }
 
 static void sender_guest_code(struct test_data_page *data)
@@ -185,7 +200,7 @@ static void sender_guest_code(struct test_data_page *data)
 		 * First IPI can be sent unconditionally because halter vCPU
 		 * starts earlier.
 		 */
-		if (!x2apic) {
+		if (apic_mode == XAPIC) {
 			apic_write_reg(APIC_ICR2, icr2_val);
 			apic_write_reg(APIC_ICR, icr_val);
 		} else {
@@ -386,10 +401,10 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
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
@@ -404,7 +419,7 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 			*delay_usecs = parse_size(optarg);
 			break;
 		case 'e':
-			*x2apic = parse_size(optarg) == 1;
+			*apic_mode = parse_size(optarg);
 			break;
 		case 't':
 			*vm_type = parse_size(optarg);
@@ -418,7 +433,7 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_ES));
 				break;
 			case KVM_X86_SNP_VM:
-				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SNP));
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_SNP));
 				break;
 			default:
 				TEST_ASSERT(false, "Unsupported VM type :%d",
@@ -432,7 +447,7 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 				    " Default is no migrations.\n"
 				    "-d <delay microseconds> - delay between migrate_pages() calls."
 				    " Default is %d microseconds.\n"
-				    "-e <apic mode> - APIC mode 0 - xapic , 1 - x2apic"
+				    "-e <apic mode> - APIC mode 0 - xapic , 1 - x2apic, 3 - Secure AVIC"
 				    " Default is xAPIC.\n"
 				    "-t <vm type>. Default is %d.\n"
 				    "Supported values:\n"
@@ -484,10 +499,17 @@ int main(int argc, char *argv[])
 	bool is_sev;
 
 	get_cmdline_args(argc, argv, &run_secs, &migrate, &delay_usecs,
-			 &x2apic, &vm_type);
+			 &apic_mode, &vm_type);
+	if (apic_mode == SAVIC) {
+		vm_type = KVM_X86_SNP_VM;
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_SNP));
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_IDLE_HLT));
+		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SECURE_AVIC));
+	}
+
 	is_sev = is_sev_vm_type(vm_type);
 
-	if (x2apic)
+	if (apic_mode != XAPIC)
 		migrate = 0;
 
 	if (run_secs <= 0)
@@ -495,18 +517,28 @@ int main(int argc, char *argv[])
 	if (delay_usecs <= 0)
 		delay_usecs = DEFAULT_DELAY_USECS;
 
-	if (is_sev)
+	if (apic_mode == SAVIC) {
+		struct kvm_sev_init args = {
+			.vmsa_features = BIT_ULL(SVM_FEAT_SECURE_AVIC)
+		};
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


