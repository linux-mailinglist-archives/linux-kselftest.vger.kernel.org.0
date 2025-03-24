Return-Path: <linux-kselftest+bounces-29639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A52A6DAC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00FC1896A8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE025F79B;
	Mon, 24 Mar 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEQQFlVV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471725EF81;
	Mon, 24 Mar 2025 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821397; cv=fail; b=KUXG69KU7LZFcGYD6MYRrzxWaf+A/aQaQ9mxpvfaYW1CM+DacYb5tejUCivD/z8lNItf5LGB+aM87nPYEL2DuP3AcxeXcxNnqppHitmrDNJ5lcdLsjSrh6g2R1DM/lnpuXoGiRUxImrJ+Pryftf6jUuEsacEZ/bA4MvlNVr6fjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821397; c=relaxed/simple;
	bh=Nvlf40lsRomEsTbpFDq0h/npw04AyqKKaheQE5t5YWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/Ds8dx7D8zz71vbH56egTtigxEd5Ig4QMmngoXISe3AfRNKmrH6edozN4DeREVJIkTbvz8D22sDkTarbDl8eFrIUx+CERTS6GgiNJTFGfw0sNj+NIo3CoGT4qSIPSxo61LSg3QYYv8OnkNBPrr1VTChdl1gZIAzNksVcUR5goI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEQQFlVV; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFTLttkAK5H7vO3mPkviEW8bYpS7zBL9TA0PpXlw8fve3EkvCHNcGQWnChy6IuBmlS95PEJ+6ITko3hlbeQM0dJdhSYnwjThecHeL2e2+oRy761J4evK1UmATdZtPKJFashqO091MH2rcy8FMo8ZXQKnLKSJsL5nc2ipbUHxWKKOepzUlunxJ8N8kM6eJuNL+GtqB3HE3wYP882SADj1usmLeo5GB4df/a/bHbG8k6hxUMVneMjyH9NZP/bJeLkQRMWqO9+kinxcfcm5yueHnHv6cT20Ds3g/zZ+dT4mN405wRfjmmbxZlgwy+zqwx1RjB7v6M3sKh5vlrLe8UwFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svp+hat4gRn2oJdJoKVMuLjd03Ln8HUu+0DKhOzuEJY=;
 b=rLW8oTAaAj5ot/1nDpK6s2d6agB+4i4ZcRnAZw7xQr+ax/Gr4atpruuJ1EHHTJ5e1gjgTYxnBAxhHBkOzj8/VgzIfzbwGgO0dPhXFjUs9o9+yJtT3OqkuRCgFwFURjAa2HdaE3O7ZUbA5KaiWKzUO4+Hr1DI7NGNuJLBcBMGyFKryl9k0DeUsUCu9BKDI9nYNa1vrQcTcTM2iUEEER+SKSxwv2UnshHGtMEaimlFXNLq7WTySShp2Sx1BL+JxTO9CGs8QIuQvsKnf40orEy+fx6dx4VDF1cvXPqvjGDuo/Pnh/H0EGOpyO51rWwxRE/BSR7aoCkjXkl1JKUIAY1oBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svp+hat4gRn2oJdJoKVMuLjd03Ln8HUu+0DKhOzuEJY=;
 b=PEQQFlVV8D0DA44UGJXk4TExQ+TL0r/8X1efY5bQF0W55PJFbWcb7+7M2j/orFv13IB3Dgx+hgYkceGhSAAgm7kfNoqkjTaJtsu9vYi0OGSN0RcUq7kHx7w1GoqMJkmnZZ7Q7/5jn1IyfYnhoihBRKkcDRohxMMKhSkvA8cOpso=
Received: from BYAPR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:74::33)
 by BN7PPF915F74166.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:03:13 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::cb) by BYAPR05CA0056.outlook.office365.com
 (2603:10b6:a03:74::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 13:03:13 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 08:03:11 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<thomas.lendacky@amd.com>, <manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v4 3/5] KVM: SVM: Enable Bus lock threshold exit
Date: Mon, 24 Mar 2025 13:02:46 +0000
Message-ID: <20250324130248.126036-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324130248.126036-1-manali.shukla@amd.com>
References: <20250324130248.126036-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: 37110d99-7280-4dd6-8e94-08dd6ad43c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eceg3nB9X5vtACLFBJHPKxjtPn1WYsUrT5+lDEmvPMr5a/9EU4yGat8UTUCp?=
 =?us-ascii?Q?6H7ZHYcrbWcCDU6ZeRuiCOESjWMfF9Gu3yhVg+dEQJKIco4bG3kODBjM7Ulp?=
 =?us-ascii?Q?KkXe9kJTaDRQBJsDMWXEM4afU9SEiMmNlcFVsvgBh+cFiWm5CsDmuVMJ/Ddr?=
 =?us-ascii?Q?9/TsyYvC6NnJ8niYD8C/+S1+DiMlGKwzJf8XfYTyKgX+ucW8KDLkaRyE856D?=
 =?us-ascii?Q?K3g3tbkojHSiOh/bTflsHbb2d/wv5/fu2P/mLfqNdqpZUa/J+2MEGVvdwdRX?=
 =?us-ascii?Q?hwOi8yCjv+BxFGtp3h0LiikKo/SqW+dKyKVaBA4rTjKJ5V5vr2OsUWnYHOyW?=
 =?us-ascii?Q?nCWQqByUqmHJh15VrWoHFhdp3all70pQbDZ6f+MfJ+qoQoEn2oVKe1ZSee6N?=
 =?us-ascii?Q?2ft5OvTa7/ErAtbXdayrXVLclUOlIPaXYu6/ZIGpFiHaGNjHD+KC1eeEsBvx?=
 =?us-ascii?Q?F0ceZ9n4BFMO2vsxo+N0QXHNhOSWYwIfr+o3hkr+cUtUDSUO6V/YE29pMYPa?=
 =?us-ascii?Q?PnuY4UTQIo3cVHIHDuXoub+1RuTbuBrr7GxUw/R2Ish1pYn82D/DiRR3EJgW?=
 =?us-ascii?Q?FfbRITbvAHof+kzJEu0nG2zNiV1mdQjwLwud0GRcmuhtg6Xw61mOTl/v/Cx3?=
 =?us-ascii?Q?bpaznmMa67DMX9ci06F6rvwX4xdycsk4+DsIFZ63MBXlxqisP2YlBNgjMcKw?=
 =?us-ascii?Q?JuALj5jLuQodVRPh8xjiZG0j6tmWHNwhSVPJ7ydyPDpG68nBNRNrP53Ijb7L?=
 =?us-ascii?Q?5B1vPXkOibQiGPkVQ9Lau7iBIGAhcqu4V98ygR75r0L/n6xt+BHFRtGJgxpF?=
 =?us-ascii?Q?JFzzkfIeETf3iXoXBSwdwmDDunuT9+iyUYsVqbcvd+1mFl3MlGtse5vF74YU?=
 =?us-ascii?Q?65sEAU7UioWSmtqNvLemRVZiomssHs9Y5Iymz7qwXtydx0OUnvf4FbjeE+Nr?=
 =?us-ascii?Q?ihsriXZ8ie8MxycUYsXvkArzULPZ80wq0MbKK1iaiZwtR9umum0w3kqm1yw4?=
 =?us-ascii?Q?e5vCipQOHSNXZjHxq1Y5w27VegJ8SAarCRmGmAPgTB7ABx54neBenIleJZt1?=
 =?us-ascii?Q?l5re7NioahE5W2bq9kPPUDKZPycFMGjAXkwN/j5nugNXNUcLnBh8l3rEDCSS?=
 =?us-ascii?Q?wqlBb4+PCY94FFpDs3dQX3aW4L3bzazIe/dRbkdODO87EvBM5IFGIl26/NKs?=
 =?us-ascii?Q?08kTT75pnFTVz4jAfmDHlZiSeJt10W95VV+lK0yqNfWS8iUkxk1KwHlLnXsf?=
 =?us-ascii?Q?ru8VwbK9EHe5BLCHNA9fzVI22NO1FcjvLkJiCQuH3Q+ffAAX2LVrDfyXR5oY?=
 =?us-ascii?Q?JbfqSXbHtDQqPXaMXuQ0oh9cvdLS5Yvc2mOS8gtOjYps9pg2gMjQz75lEdHo?=
 =?us-ascii?Q?qk1VBqOt3yrZVhEgdKEFwZFlQQKf2s0jjAOXwcoB4os1OprlcgW8SzZZ8has?=
 =?us-ascii?Q?6F4iZFkPgeqVylR/hDBR8hP+mYSenCJRW+sQCCnd3BPJBlXSjDE3uHHkgw33?=
 =?us-ascii?Q?N3V9uqXXNWbKIxg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:03:13.1909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37110d99-7280-4dd6-8e94-08dd6ad43c3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166

From: Nikunj A Dadhania <nikunj@amd.com>

Virtual machines can exploit bus locks to degrade the performance of
the system. Bus locks can be caused by Non-WB(Write back) and
misaligned locked RMW (Read-modify-Write) instructions and require
systemwide synchronization among all processors which can result into
significant performance penalties.

To address this issue, the Bus Lock Threshold feature is introduced to
provide ability to hypervisor to restrict guests' capability of
initiating mulitple buslocks, thereby preventing system slowdowns.

Support for the buslock threshold is indicated via CPUID function
0x8000000A_EDX[29].

On the processors that support the Bus Lock Threshold feature, the
VMCB provides a Bus Lock Threshold enable bit and an unsigned 16-bit
Bus Lock threshold count.

VMCB intercept bit
VMCB Offset     Bits    Function
14h             5       Intercept bus lock operations

Bus lock threshold count
VMCB Offset     Bits    Function
120h            15:0    Bus lock counter

When a VMRUN instruction is executed, the bus lock threshold count is
loaded into an internal count register. Before the processor executes
a bus lock in the guest, it checks the value of this register:

 - If the value is greater than '0', the processor successfully
   executes the bus lock and decrements the count.

 - If the value is '0', the bus lock is not executed, and a #VMEXIT to
   the VMM is taken.

The bus lock threshold #VMEXIT is reported to the VMM with the VMEXIT
code A5h, SVM_EXIT_BUS_LOCK.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Co-developed-by: Manali Shukla <manali.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h      | 5 ++++-
 arch/x86/include/uapi/asm/svm.h | 2 ++
 arch/x86/kvm/svm/svm.c          | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 9b7fa99ae951..9dc54da1835a 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -116,6 +116,7 @@ enum {
 	INTERCEPT_INVPCID,
 	INTERCEPT_MCOMMIT,
 	INTERCEPT_TLBSYNC,
+	INTERCEPT_BUSLOCK,
 	INTERCEPT_IDLE_HLT = 166,
 };
 
@@ -159,7 +160,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u64 avic_physical_id;	/* Offset 0xf8 */
 	u8 reserved_7[8];
 	u64 vmsa_pa;		/* Used for an SEV-ES guest */
-	u8 reserved_8[720];
+	u8 reserved_8[16];
+	u16 bus_lock_counter;	/* Offset 0x120 */
+	u8 reserved_9[702];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index ec1321248dac..9c640a521a67 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -95,6 +95,7 @@
 #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
 #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
 #define SVM_EXIT_INVPCID       0x0a2
+#define SVM_EXIT_BUS_LOCK			0x0a5
 #define SVM_EXIT_IDLE_HLT      0x0a6
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
@@ -225,6 +226,7 @@
 	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
 	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
 	{ SVM_EXIT_INVPCID,     "invpcid" }, \
+	{ SVM_EXIT_BUS_LOCK,     "buslock" }, \
 	{ SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
 	{ SVM_EXIT_NPF,         "npf" }, \
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8abeab91d329..244e099e7262 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1375,6 +1375,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
 	}
 
+	if (vcpu->kvm->arch.bus_lock_detection_enabled)
+		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
+
 	if (sev_guest(vcpu->kvm))
 		sev_init_vmcb(svm);
 
@@ -5299,6 +5302,11 @@ static __init void svm_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
 
+	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD)) {
+		pr_info("Bus Lock Threshold supported\n");
+		kvm_caps.has_bus_lock_exit = true;
+	}
+
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
-- 
2.34.1


