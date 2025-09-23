Return-Path: <linux-kselftest+bounces-42117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52883B945FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7953A1900CEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D229309DB5;
	Tue, 23 Sep 2025 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l1wKSR9Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9726CE15;
	Tue, 23 Sep 2025 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604676; cv=fail; b=LO8hBdACXkI4w9kQJ5vq3Nck9T/abOHXKLFYs4Z+H/GYGIxNQWLFj2iMdfNQcxsau6EGgtNqLVLi2HI/+tpmtfB/FmZ62Xdnxwt26EpZ5zMno2izH3LvKZoFmOeq4UqTMrdVfUAWw0+Ul5PIoI6tZ0hQFsFj2E92INfiAnP0fc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604676; c=relaxed/simple;
	bh=HKNm0TiNb1X7rsoPzdVc1YxSCnKQ3CHO0HO+wigMUh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pR2qmHXeu3joDpeDbjQU2mr2bwbR0Qu0EpYOcGiJuF2ZTVIkx7qDpK4bgvhjjTH6DSeAXzIGxapuHTKmefRJlLiO8vyFQAYeEdoNd2bO8m++0hJyRUUi/L8emw2kLGfXLUoH5ax24jsaW1LoQV4cTUOKMbmzZhE8Xl30S+0mqW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l1wKSR9Z; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8NQCuANWkoSUyalbjLjeBKVzKVyobue79VeX1nwllk74rEbpyJswKkmM3f55I6iD8v8hqsxgUCxqCJeSCq54aIxG0QPmZJp6FuYVmy1OOYgOLvtI6coGsuw+u0u7R/f5vIzKC7Lu9Z0vr10L+Jeull1ezy7WA7VMVnrX0+FArFD+Dm5XZHOTvhg8evheJ8Dt8qCkzviYvIEMZWKEyU4R4rSl/QwiZky6OAVO+IlKcm6q+oCdpfHNMpb9GyUxvRODGdhTZaUXWKz4X/YlPrZrlWcy67yLhqy2E1xBg3w6mUMGYw+mpvbmyWs1ZjgVe16hp+zO6HrCAfM9zhn0AUHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL1CJFgDZtAXdEDSYTRIiluubSH8WJxzxWUCw7ofpSk=;
 b=v30FpDYFP2zSqIzFP0R2XDG3UAVEan/wOONvYOe/KRr8j7mPs7Wp9aB9BrbFC8rnjVMKbr+8Xq02rKOgyflNva+j32xTJVt6a/KDuzMszQ4hi9CXAi7c0AHdBkmRoppVKw4YFkBZw9oNqU5x5x+Q1ni2WwyFH3WdEUvq0KrAqesy7laDdSC4jNWCgipoqVjxTTo6fIVkVONIqEzGgALeIhRsB7dHJpNoxKnPSXUvIZfr7GBdOKBJb63Jke216vV44xGcl2OwWc6bDxuHQHe3If4ijdnf6gzRiCaVwmSZX6+9YUwe/6o4CCEqFUZM1SqzJvzZCjqVWmQcENCsK0dHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL1CJFgDZtAXdEDSYTRIiluubSH8WJxzxWUCw7ofpSk=;
 b=l1wKSR9ZCr+UkYpMKfp6ZIIub/vsooG4qojQepCXR7lI3PKowxLxJnXTPrTQs/2OvZ6zXTWTuaOc7s6Dzc6zY+hnmXM5Ar1YzuZ4OAtGJ53W0tfjt2CIlK9ZDPO+gMkqRvmY465glbevD9apWked+mWWTTovGS0uytmPcxyY7ww=
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:17:38 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::64) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:17:38 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:17:32 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 26/35] KVM: selftests: Add IPI handling support for Secure AVIC
Date: Tue, 23 Sep 2025 10:39:33 +0530
Message-ID: <20250923050942.206116-27-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6441bf-2366-47c8-4c60-08ddfa608389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gnWAPkkkmj96XxX3KyfL1qYK4Sb8GfwsGL/tt26wlWeNERWAoVj7hPwCyTc?=
 =?us-ascii?Q?4btNhrj4eedSzWAiswv1xtcg+Y/NqXppfTosyvvGmeQXlLoK9nHazCkt82ck?=
 =?us-ascii?Q?NdRcQsWOYGQyFhoRImQuMMmLc7mab7P2V6IM5PswJh3KMpztbryReHgcwQQ5?=
 =?us-ascii?Q?pYKpUtr92B1qA4D49x9k19T8AQUS83uHLcN1uE6lQ/Ch732BuVkH+YHqgUcX?=
 =?us-ascii?Q?C9fJeZ3dU5aPy+bcIx73GVc2aeBqXU2xa3i4tvjud7kIcnqUBvvxscZ/lyI7?=
 =?us-ascii?Q?R6HuDbBl0HOZN9lgXYPkqgz4/efQVXbwNZK5j/InHrXdYTBXEExgv+KGCztr?=
 =?us-ascii?Q?4RkZFi70SNH8V44QSnBr73etqvW0emdlRcbwGUBjCwk6zQf3npd0yT9mbsEO?=
 =?us-ascii?Q?3M65jZJxmRryjd8hpgomaOEcZnSw9q/qChxozEDoywltGQY8dvtadk+OGu6J?=
 =?us-ascii?Q?V1nQDlOhnWINUnZ5aSQARdeH9AI50dTv54uskLS4esedVjWYqyx4DG9dZFfH?=
 =?us-ascii?Q?YJkyqZpY83vDbhXDeZ5rs9Ds55h4a5MQ3vUL/ZFolt7Md2d88A7FdHd6pXWS?=
 =?us-ascii?Q?ZsScrPoYEeyLwnCLonLlx7rfiwk4x8h+5i2l/KOqiRU0ucUGF0PZo4Ilo/1R?=
 =?us-ascii?Q?OGYQP3yBiIMp9S+O1Ya+JM1zLyMzh85jnmZ+yJTWekZoRv45xiwwDUk5Loh3?=
 =?us-ascii?Q?UfLGAHVeOJmMNCg7VAt4d43h26Hv1SGNV5vFHk/CiOeJHl3Qy6iE+HFtuMDM?=
 =?us-ascii?Q?0b9y8Bt53k5TdnTFfiyHjAzzofmun4YObn4PkgB2OkrffMDJxzQnXqUK5XC9?=
 =?us-ascii?Q?Efeu4+SKtZKSdqwwTwUhOdy0HKuPO3HA7TR+D5LGgJlzQb3D5SW0I78GGkTg?=
 =?us-ascii?Q?M+O+1b1kp68jpCCqzBacWXKuLhYz1D6JrfTFgSNDFIoFCr94bxIWnNxXJS//?=
 =?us-ascii?Q?MrjfqUlN6DysTf9MhVhJhtXUXMRKFC4t2uZ2uJ0R8xAJmXv+3txD7nTyB1U0?=
 =?us-ascii?Q?vEneS4bSI/rTB6+aB/ll/WhzaGyxr1qRN9xYwwVpdd4cfifBQAAIXmddq+VF?=
 =?us-ascii?Q?JINFay6jeRmJWqZO+koVODJ1QPLOjdbyLdGQnuKjRr1fyLBssflIzBBTHzaA?=
 =?us-ascii?Q?AofOxH9siPkwFfLz2kVxDDhzRBHinEtY22R+DxaNyzEj4Hi5ZmOi48446+jM?=
 =?us-ascii?Q?gibZYDXbjP8jjWv+5C1DNc4Jh9Deq5D5PyzEdgjif9tcwzkP/k2F3pKovmaQ?=
 =?us-ascii?Q?xNnG5gLEEMezXz0zVDNQKrMwVpf0NTjYmB2lafqZR/xQaGi4pQS8RTLjtOP6?=
 =?us-ascii?Q?iyC8K2i8PaygrC51ZnEgfedQelR2mafy4Unfg2Sn2Emiyx8n1Etbr0qFqi6d?=
 =?us-ascii?Q?Hct+FNB9eweYpql+gBATzbXC/uPDVq1uTQJrjioolnfdi4iI0X/leswsLiUv?=
 =?us-ascii?Q?aOtBB9jb+rs+ICfpnzOngu/NFFj2JfeJTcS2DsZ5R24YHVcPfIPlFVmKJO3e?=
 =?us-ascii?Q?9JMiX3PaSd8MQv+2PzDZzVsnL98WLvaK7Zrt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:17:38.6532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6441bf-2366-47c8-4c60-08ddfa608389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

When a guest vCPU has Secure AVIC (SAVIC) enabled, an attempt to send an
Inter-Processor Interrupt (IPI) by writing to the Interrupt Command
Register (APIC_ICR) does not complete in hardware. Instead, it triggers
a #VC exception with the exit code SVM_EXIT_AVIC_INCOMPLETE_IPI. This
design delegates the responsibility of IPI delivery to the guest's #VC
handler.

Implement the necessary #VC handler to process these IPI requests,
enabling multi-vCPU IPI communication for SAVIC guests.

Add support for all IPI modes: physical and logical destination modes,
as well as "broadcast" and "broadcast-but-self" destination shorthands.
Inject the IPI into each target vCPU by directly setting the appropriate
bit in the Interrupt Request Register (IRR) of its backing page. In
addition, propagate the ICR write to the hypervisor via a VMGEXIT. This
is crucial for KVM to perform actions like waking up a halted vCPU.

APIC_ICR based NMI delivery is also supported via a the NMIReq field in
the backing page.

This functionality is a prerequisite for testing IPIs in SAVIC guests.
It allows selftests like xapic_ipi_test to correctly validate IPI delivery
for SAVIC enabled guests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/savic.c | 111 ++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index 9b1ea5d15338..016e5e9e43f6 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -42,6 +42,12 @@ enum lapic_lvt_entry {
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
@@ -335,6 +341,104 @@ static void handle_savic_unaccel_access(struct ex_regs *regs)
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
+		if (cpu == mycpu)
+			continue;
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
@@ -343,6 +447,13 @@ void savic_vc_handler(struct ex_regs *regs)
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


