Return-Path: <linux-kselftest+bounces-27863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0829EA49607
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F72188A778
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6D2594B7;
	Fri, 28 Feb 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ms3ZsgKy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7D257ACF;
	Fri, 28 Feb 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736530; cv=fail; b=esfb9URdzazCuvny7fxNJM0J6klumyRncVsqvYcMGHPcqdhtZzJJ63S7IFoGXbTK022I5cDYmRwinkst76XoqxPOEFWGiFKFE6w+OHSoHq/tlrTWZeHJQE0UEtfIHrCdPlwuTrwuLi2pKZF5VQ7BUKIvyEcXBVfV5RySxRhyexs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736530; c=relaxed/simple;
	bh=wpHD0Mu4qinyP7AAFWL8aHKoLabBnMlNH71cmU/rRlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0/n1RgujljFAHnEUO4e0Vp8tVj15w5cOlGYPd8NJtNKd82mYOzBZOrZb3V9vRcbScPt91q+XHSuchVUsEDdJs8IZ9taaJ2as++SkKmK/OtuZ9ZyUlouum/S1G0vrQYhRiyApQpKPneHrKlNpZuUu0LEIFKTYApJalc4H88mGp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ms3ZsgKy; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITGtvrkQsaMFr2FkgOuDx0byAQr3ETUqx1by9J5MZfQLVDgiYqmMU46HBfia73uuhD/2VHDM8Tp0i3+BXHFsOTMEs+Yr+i2TzFAKSa0/1HjjCkG2cbCpdNtaWzwGKOTwvvNcvMpVve6HL+XGM6THbPR3VOqmX4NWfgssorfI2KL8ALVQxyZYya+VmrlW9SLFYlOkL4P3le1tEtGlkHdElZ/XDDnipeLdELZugFQmunsw+7S3gCJ9ma2dslvxcjjthPZfE367YqGnl0UQ4vpcnYh4r5iij6Wi3V8jHCy1G7nPDcoGZGf9/AZnxQdJeO8RLwDeE2K/UeRWTG5CNdZLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfJcPmZEJz//PTTP9F2bF9PjNUOFmBWMbhVU9Sal5U8=;
 b=mkMSnXEzJolN1dtf09svQqJXyTnGfTRrocfJPfvH08K6E/WLHdtkG27JbhOadtswt1kHP+Hnf4TwRJjXBHOMSl1vuqYzG1IghiixE0X74TjjTEsfRnblDHE3GJ5u5IImA5X6v4bclRuV0l9APpSVbTR4IVYmGWgeKy6NWyZztfxGMaT38C2TUNh4VW+ouRvI09Ly/cH/Is+D3t8ttZv07AmZhNUOJThNVxAeEuUHRD6e7siDj6aJFt4bijFxypf9oALp7pfXHuxp5Pf3N9AYCXLlygwAusVcmYCSlnX/KAT1x7VphtdQUYbAHHbYY3gZutvWEg2fkaoO2M5SBD4k6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfJcPmZEJz//PTTP9F2bF9PjNUOFmBWMbhVU9Sal5U8=;
 b=Ms3ZsgKy/+gWbRg4R58rU9iBcLfvtYOr7andzO9kBaavU5ab9sXnOPUMiJzbi/oGYabYQXfan6/AL7nSvVV7zloYcSa/IKlQjOxiFZ979MJQSWOdDTOD6iiztrDkAvovSBkxKr7JqORwFliCX6Y7DlaUhnVGqyS57kNTqv63xIM=
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:55:26 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::31) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Fri,
 28 Feb 2025 09:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:55:25 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:53:52 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 21/31] KVM: selftests: Add IPI handling support for Secure AVIC
Date: Fri, 28 Feb 2025 15:00:14 +0530
Message-ID: <20250228093024.114983-22-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dad154-6b2a-4239-ae3e-08dd57de066e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qs/rcV0w1xkf5HTl8qyAslTBFDvfT3030Tw7RWlGcy30Uwm6sbNuah0O4vt7?=
 =?us-ascii?Q?fwoLKXXYCaWQ1i6IdlhMe7yGVrJ9RX3KI05AmZe5UejnoedHN9vzJDpqTGSp?=
 =?us-ascii?Q?kOlBmz9k5dhpbLtX87WZ+xnLdc7sziLk1zB0rWD+i2sy+AdlaljTf9ln+tyV?=
 =?us-ascii?Q?1sNzrkSpkN9nBJEB4PFJRMU6jIzMkGw0R4dJX8kI8QjWdyA5Ot+xqTUx31hM?=
 =?us-ascii?Q?CRWY00ZvlYc+SmbXyKgUba2H2aMxkL4L6R7b2osCN3EeePUfJWaRACqnZ8uo?=
 =?us-ascii?Q?JyTXAb8B7Y5q6QjuiezBZTeESBh66GWl6DUYqx1zk6uAfxCPJrw3xpGXOry7?=
 =?us-ascii?Q?qb7I+rK74XmJ7Bdz4wxPMdvKP/4Lv7KlZYcQ1ksKUktQ/cB0YepET87vUb28?=
 =?us-ascii?Q?3oRXj6aAh0UR44y8PF1oqPT2bi9UPC77/KK1U3aobNlXqLLc/PQFfL5iwDc+?=
 =?us-ascii?Q?m7Ev7WLT2aWQqkq9t0y8IfwFFG87E85NNuobJKPPoMLxABtr2hcsaEbczWxq?=
 =?us-ascii?Q?IcH5hVzFBZnL46B0bfre0JZtX4UoEFXglreGUiID43UKj72SyARF5rXJ8hQC?=
 =?us-ascii?Q?W6QrxGABq2NwBtxa5PFZsbwQxA2Z66sJRQ/d20W5Box8gwsngOJR/GjkHmxy?=
 =?us-ascii?Q?Qz9hOOm15BqQsMxmdt3ZrAV+Cc32RF7DcGzAeGUlTuFef8ZEigfccU9y6h30?=
 =?us-ascii?Q?laqSkmAO0C7MIyzqiO69K/VGOCytj1A7utPk9ekLwRKLkFVBol4veiZOGDkJ?=
 =?us-ascii?Q?tUCxfTHEmC5wA66ieT+mx8Z8CCVRiNhFUfEYb/Yu7OgHktKA3wMnUi+citBy?=
 =?us-ascii?Q?hl6Jm6gfZZpmPQeMUwl9pxueOlO6Z8j9fwF6pg9FQr+OAqFjn8Eow/v7fiJf?=
 =?us-ascii?Q?QNIwOXpnaT0wcecFO6YjLzJeVcM8OFJv/0m4/rhKiv+bj4NefruKYLnwKMht?=
 =?us-ascii?Q?qW45B6jue0Nw0g+d5CXejSZu2KVFDdx8mSxaxKnDtm9tdrST+s2KmaA9467R?=
 =?us-ascii?Q?raxE6024Q8kYFzaqwDlEgPLpfbnvmMavvy1vrASjkpOGatK7mtE6VvTwOzhZ?=
 =?us-ascii?Q?Qty7L2Kcge55MKEzsnWaoRbn3l6hjf9hJCwO1z2L6ZUOrDK9F0SZwZOlJrL5?=
 =?us-ascii?Q?j+BZIMWaHHUvG8LiTOkN3Xi+Xtsl9/Ei1sXsA8sYkrAK7zcks2WLAboPcN0H?=
 =?us-ascii?Q?xjuo0vpGxM769H1X9kBLMi9BM99semximPD67UPsvoS0kWXXXkQGurCTU9iI?=
 =?us-ascii?Q?mmMEJPS+tMEwodmaIu9sIheTzxvqstvRmkWb3Mv239cIY2iHwjwQMdjMNfWu?=
 =?us-ascii?Q?hpQnLKzCTRcmCBfClAC77+bar92PJPHvexX9Yh9WIWEv0ekGHR2CjUShKBsZ?=
 =?us-ascii?Q?BTrfgnhXTq7x4WlTb+jazlxgJx+zWYrop4oAT2KOfcWL90caQYXfnYnc6p1J?=
 =?us-ascii?Q?S7rggSdFBIjp4SX/s8tssVnNkec5rYFwAgj9mPGhMdS23ycvXFnUfPXn2I5C?=
 =?us-ascii?Q?zvX+4Lyxddk50gE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:55:25.7189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dad154-6b2a-4239-ae3e-08dd57de066e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432

Add support for handling INCOMPLET_IPI #VC exception
handling for Secure AVIC guests. This allows sending
cross-vCPU IPI, using all destination shorthands (broadcast,
fixed) and destination modes (logical/physical) between
Secure AVIC enabled vCPUs. In addition, cross-vCPU NMI
using APIC_ICR writes are supported.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/savic.c | 112 ++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index 141d31637e51..8259f7521e73 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -43,6 +43,12 @@ enum lapic_lvt_entry {
 #define MSR_AMD64_SECURE_AVIC_ALLOWED_NMI_BIT       1
 
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS      0x402
+#define SVM_EXIT_AVIC_INCOMPLETE_IPI            0x401
+
+#define REG_OFF(VEC)		(VEC / 32 * 16)
+#define VEC_POS(VEC)		(VEC % 32)
+
+#define SAVIC_NMI_REQ_OFFSET            0x278
 
 /*
  * Initial pool of guest apic backing page.
@@ -336,6 +342,105 @@ static void handle_savic_unaccel_access(struct ex_regs *regs)
 	}
 }
 
+static void send_ipi(int cpu, int vector, bool nmi)
+{
+	struct guest_apic_page *apic_page;
+
+	apic_page = &apic_page_pool->guest_apic_page[cpu];
+
+	if (nmi)
+		savic_write_reg(apic_page, SAVIC_NMI_REQ_OFFSET, 1);
+	else
+		savic_write_reg(apic_page, APIC_IRR + REG_OFF(vector), BIT(VEC_POS(vector)));
+}
+
+static bool is_cpu_present(int cpu)
+{
+	struct guest_apic_page *apic_page;
+
+	if (cpu >= KVM_MAX_VCPUS)
+		return false;
+
+	apic_page = &apic_page_pool->guest_apic_page[cpu];
+
+	return savic_read_reg(apic_page, APIC_ID) != 0;
+}
+
+static void savic_send_ipi_all_but(int vector, bool nmi)
+{
+	int cpu;
+	int mycpu = x2apic_read_reg(APIC_ID);
+
+	for (cpu = 0; cpu < KVM_MAX_VCPUS; cpu++) {
+		if (cpu == mycpu)
+			continue;
+		if (!(cpu == 0 || is_cpu_present(cpu)))
+			break;
+		send_ipi(cpu, vector, nmi);
+	}
+}
+
+static bool ipi_match_dest(uint32_t dest, bool logical, int dest_cpu)
+{
+	struct guest_apic_page *apic_page;
+
+	apic_page = &apic_page_pool->guest_apic_page[dest_cpu];
+	uint32_t ldr;
+
+	if (logical) {
+		ldr = savic_read_reg(apic_page, APIC_LDR);
+		return ((ldr >> 16) == (dest >> 16)) &&
+			(ldr & dest & 0xffff) != 0;
+	} else {
+		return dest == savic_read_reg(apic_page, APIC_ID);
+	}
+}
+
+static void savic_send_ipi_target(uint32_t dest, int vector, bool logical,
+				  bool nmi)
+{
+	int cpu;
+	int mycpu = x2apic_read_reg(APIC_ID);
+
+	for (cpu = 0; cpu < KVM_MAX_VCPUS; cpu++) {
+		if (cpu == mycpu) {
+			continue;
+		}
+		if (!(cpu == 0 || is_cpu_present(cpu)))
+			break;
+		if (ipi_match_dest(dest, logical, cpu))
+			send_ipi(cpu, vector, nmi);
+	}
+}
+
+static void savic_handle_icr_write(uint64_t icr_data)
+{
+	int dsh                = icr_data & APIC_DEST_ALLBUT;
+	int vector             = icr_data & APIC_VECTOR_MASK;
+	bool logical           = icr_data & APIC_DEST_LOGICAL;
+	bool nmi               = (icr_data & APIC_DM_FIXED_MASK) == APIC_DM_NMI;
+	uint64_t self_icr_data = APIC_DEST_SELF | APIC_INT_ASSERT | vector;
+
+	if (nmi)
+		self_icr_data |= APIC_DM_NMI;
+
+	switch (dsh) {
+	case APIC_DEST_ALLINC:
+		savic_send_ipi_all_but(vector, nmi);
+		savic_hv_write_reg(APIC_ICR, icr_data);
+		x2apic_write_reg(APIC_ICR, self_icr_data);
+		break;
+	case APIC_DEST_ALLBUT:
+		savic_send_ipi_all_but(vector, nmi);
+		savic_hv_write_reg(APIC_ICR, icr_data);
+		break;
+	default:
+		savic_send_ipi_target(icr_data >> 32, vector, logical, nmi);
+		savic_hv_write_reg(APIC_ICR, icr_data);
+		break;
+	}
+}
+
 void savic_vc_handler(struct ex_regs *regs)
 {
 	uint64_t exit_code = regs->error_code;
@@ -344,6 +449,13 @@ void savic_vc_handler(struct ex_regs *regs)
 	case SVM_EXIT_AVIC_UNACCELERATED_ACCESS:
 		handle_savic_unaccel_access(regs);
 		break;
+	case SVM_EXIT_AVIC_INCOMPLETE_IPI:
+		uint64_t icr_data = regs->rax | (regs->rdx << 32);
+		uint32_t reg = (regs->rcx - APIC_BASE_MSR) << 4;
+
+		GUEST_ASSERT(reg == APIC_ICR);
+		savic_handle_icr_write(icr_data);
+		break;
 	default:
 		sev_es_vc_handler(regs);
 		break;
-- 
2.34.1


