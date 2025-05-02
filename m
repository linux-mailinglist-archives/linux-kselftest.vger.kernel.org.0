Return-Path: <linux-kselftest+bounces-32146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78096AA69F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 07:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AA51BA56BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 05:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F61946DA;
	Fri,  2 May 2025 05:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z7E0+sRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F41A0728;
	Fri,  2 May 2025 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746162270; cv=fail; b=bgi5QlYPlhntjSRuMxpQYsNcrfHNfMJhhvUf8fdzvM5nnUt4qjneLab40SjKTd4eocIQffjuvs9CVd4kmO3PAxIYaVh76deuXSByhF88H8Gty1d8HFR07XqBuOEnSN/AuoobRSwYPHVoDkTEoIicRd4rGbJ5VXAqZLawFJ8v6a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746162270; c=relaxed/simple;
	bh=DWy8H5eUCUackiMWuyVNULhxHSKxYsFHOHnBv70ivP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3ApBNJK+aGmHos7oHrKegmdIKYQMtz+K6qhezrniXIJAAAtkI/O29jAWOs5pceZA67M3qAowGXgUCoLn7uJJYwcNKpFOgtBOmoEeoIvCGHvi5svnSBbPBJvOXhXC0D09DmBv6oKbsARApEV6gnA7OZqYyZ/VlJMLptgpL6WwZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z7E0+sRe; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdvRolZ+rhOW/KmZ3RBP4+ZwKkScv5HuhbylSiNHoOwqpw6gBXwDWoBFVK6d0TI1YmR9HAfps/FH2OqN3t51adRIMwM1yKKUBzGYvbhLwa4Qsi2S1C31Dfb0g9t37tZ9Py3scgeaEtivKsH3oSXgO4y+Er+1guLqmXQcgi/V9MuC6zYx9nT/UCLlFyIrOodRwzvdJx7O6KeOGcDOOwQfRO1CHY8KOpnzqaP5sr0WPfT4MPLH1R5Ap1tk1tCNY5kmrhKxPlOHi/yOfMECTe3BCkIs1kTjp9hRbUaYnVfNkbTY4QecKz2PcXIPt2isjvJmRYDzWW0PZdGLfvRWfpy6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW0bvHFcnfHjvnmNW9zxOTnIHM1zKB1QrkOyIQ3kapw=;
 b=HOAiE6Qh6HGCgpm5D+MhtdWUZgv2IjiJ7MuJ9AsYVOdseMGnbH3fYnui/50DfUmSIpNWBOrw0NUtPild7ixtSmjQzCpBXAuDJDaGrOn265ybqqFnBANJFMjPwdkyXndj72cDUAZhLl+RIJpQMdTNwVqApcGegtde6EsjqkmV+pwAzJD2nMO7LinP9ChFtjUh8yynbQYyPpQZyzL1FwQKpaeT6WC9zeyNe/GBu5tfH4JClrjvubBqAb8mRAcjoc8H15GivziM9/AM9Vx1wxAoO6fOpaJ1v+Jkf0a36fpKH4gTLl5R32JFczYoos5B30J8er3DLHBhsZ+krU0BN+PcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW0bvHFcnfHjvnmNW9zxOTnIHM1zKB1QrkOyIQ3kapw=;
 b=z7E0+sRecmJem8bRKp7kw03ibqMmuWfQdyKkAkhUjArE15k9h8kmb3KVV4DLo5q1TuNzjGD3cf1HUUJfQORDALJe/etVct8hWme8kHOEAjIK1g8u87qMa7SEmJrLRWS0uiV43gECrepuZQ9YD59CCyITU8YlMIccu6H2cR66TNA=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Fri, 2 May
 2025 05:04:23 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::49) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 2 May 2025 05:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 05:04:22 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 00:04:19 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v5 3/5] KVM: SVM: Enable Bus lock threshold exit
Date: Fri, 2 May 2025 05:03:44 +0000
Message-ID: <20250502050346.14274-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502050346.14274-1-manali.shukla@amd.com>
References: <20250502050346.14274-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee7c296-fc13-4523-ade8-08dd8936cdbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+DvTP65dvxHgrESlw2wT/Nz/+jpIxAvCkTWDWwpiFZOxwb12oWpl93DQ1D+N?=
 =?us-ascii?Q?aK4F6uAA0GDOxhQoxtdib8Aoukp0mcki0cJcXltC2gkV1HNw+uqWIBcIRdXq?=
 =?us-ascii?Q?/5YPiRGTlu2WUeEBVbijGVUKSYalueizz/4yF2lxsWISsm65857NtDxMFySB?=
 =?us-ascii?Q?ZptvZX+iiY4afrW2AF7p1etl7AsoovJTqOQgOgbc2X3e5XCBtR6mSHj/6dLY?=
 =?us-ascii?Q?fOwH4+QL/W5kK/54IoLvJIWiea3IgBKp+NRxWtxZs+iI/zZSqZHnTQ6cY0FX?=
 =?us-ascii?Q?Kvy49lqs3g70/RG09hwrJSkgid21Ul70Xa7lV2UEMtIJJ/XGZ4sw7/Ee1ulS?=
 =?us-ascii?Q?Qijl669jMdxeG4ZqmTNkssSJ14W4EZMa8s20IuxkdA3piPyfBCPr9VNSQBt6?=
 =?us-ascii?Q?vIP29336jvd+Acy5SAtgOuZxVAmV2iKZPyS3qn+Y5Xowz/fekeUshe/KK+Xl?=
 =?us-ascii?Q?i6l3tny83x1PXqwaO9LtiTN8ai84OYIfyvxoo0u+ZtRl0g/sJj8gA1ApSeRk?=
 =?us-ascii?Q?6bFEvG06/dS+oPzbVrSdVe/gTdd4BXzL0+Kga73Ike2BWRS1yFE+d2USnmGA?=
 =?us-ascii?Q?BomnAzZh/a7Cf9836qwEa1AyWNfRAiofzVE9mAoEI3P/8eBaEmZ8Shx5Kpuw?=
 =?us-ascii?Q?9PYF8K7vex1O7ywI8WY/O6SPjTIE+qC4ZJjAdzGD9AScskn/yO8zZeKFfoTk?=
 =?us-ascii?Q?v4oPix87Q4RI89CddwP9fDXzZhQkM3LAdKo4OUQ+2JO2nZUGe6ZS5uz11Ht6?=
 =?us-ascii?Q?Wsdw+g5XnfPUkG48B145Ax1sGdquXPoD2purmXABPvaLmst0qMDcpf+L7rve?=
 =?us-ascii?Q?NDffJnpaeX4JJmKd00HlCxR7W5npk2TR0li6Z7v+kaGKwfc1/XBjgndkJ8zd?=
 =?us-ascii?Q?X3RnpAki9TwIRmXrCI0IYrl6rHi+5TAj+gj6txFHkTXqiUZEpWxTTjsl+nDh?=
 =?us-ascii?Q?Ef+ADi1YtAmKPwNYrFc1IxG2WbWVxklT8PEO4mGGoOZ4L/keLuz7ku3ITunE?=
 =?us-ascii?Q?payCSO7WQIK5Aj8gBknPaDxpOAzNmiW0OsvPEChqd4pmn2IVboCdziNlXom5?=
 =?us-ascii?Q?s8sbe8UDep9+HlZsLRiqms8/6b2ZjnKvkt5d/UrbEy8zSx5MotA+ni176YhG?=
 =?us-ascii?Q?5PAhGSIzpjmcfIrc+DjGf+JlHPvozFfxiahe6wWZLPTP3QiBKYlEhpylb26y?=
 =?us-ascii?Q?tdRBubPWMVxTkMUWdjSfjAnN9Tebg7EuIiHhtY59I8z2sWvN/5CZZdvzhEvO?=
 =?us-ascii?Q?x6i+muRAyJjoZwH09BbTovfZSVnlLBHnjs7Fk/NSZLBGvbH1qB/w8TA2mLDf?=
 =?us-ascii?Q?CkJ7p3QYdcfvNEiPxBQWAe/aU+wYFeyji/TPDFeDNfSzpTmq8SeKAZJy5ACt?=
 =?us-ascii?Q?+235MHEHG0YFEOlV3meWA8QPME5wGXoPl3vpjDXjPjDOYlM6gNyrng86RhI8?=
 =?us-ascii?Q?J3UDI8rhD5lkrblAB1EE2YaRthOt2nKJfTlOy7lXnm8xzD7KwUJgWZuA3N58?=
 =?us-ascii?Q?XIcY1VnDCRacH+PvJikOtuGvHaKhCtdwvEiT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 05:04:22.9108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee7c296-fc13-4523-ade8-08dd8936cdbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099

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
 arch/x86/include/asm/svm.h      | 7 +++++--
 arch/x86/include/uapi/asm/svm.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index b382fd251e5b..ad954a1a6656 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -116,6 +116,7 @@ enum {
 	INTERCEPT_INVPCID,
 	INTERCEPT_MCOMMIT,
 	INTERCEPT_TLBSYNC,
+	INTERCEPT_BUSLOCK,
 	INTERCEPT_IDLE_HLT = 166,
 };
 
@@ -159,10 +160,12 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u64 avic_physical_id;	/* Offset 0xf8 */
 	u8 reserved_7[8];
 	u64 vmsa_pa;		/* Used for an SEV-ES guest */
-	u8 reserved_8[40];
+	u8 reserved_8[16];
+	u16 bus_lock_counter;		/* Offset 0x120 */
+	u8 reserved_9[22];
 	u64 allowed_sev_features;	/* Offset 0x138 */
 	u64 guest_sev_features;		/* Offset 0x140 */
-	u8 reserved_9[664];
+	u8 reserved_10[664];
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
-- 
2.34.1


