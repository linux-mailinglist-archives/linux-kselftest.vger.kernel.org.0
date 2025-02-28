Return-Path: <linux-kselftest+bounces-27871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A76A496AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B375175253
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C9261569;
	Fri, 28 Feb 2025 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NTTbYonp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79525C700;
	Fri, 28 Feb 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737209; cv=fail; b=Su2n4Ff/odllntYtlpZzIQamf/69y5UEXOW9mwp/RNIdDfMiL2UoaEEr/acDKPq5FibWmJrWkUyZEMaPHqqvYCNt99sVFgKBzbiyRUYbaBBZZ9QuPz2qUYWfFoiLIzypYCKz6IIHLkdfZ2wy4ID4yfk+GDSEtei4cW0Gs+fJ6eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737209; c=relaxed/simple;
	bh=UaiyzZBb3EFR2uBy6qVkeTjbKbYTndocdiGq4iTXGLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxVOLrSkC7I3BdEr75HL63MKZO66i7IVKjpEcd+MlYu0nFYfbMXnC92t8qPtufOgsF9oN2FkevbS63mCefMKPoAjFWFEb+0mogpuphSXhI9WBpCAfzYvO89H8RCuchtgPsaW0zi+tzI9/hXEkAkGxF9CQVkzP7hA2CrMXCfDRlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NTTbYonp; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJR4AXdhGQEqN7xmqHOU4w8+rNhI2URLmrrSwiJZrEPTvyvnGFCMGO6K9ySSxe7lzRBIkjI7XZuwhHBOr+I/fRWJ8qLbQvRkVSASet+p+NBqwWKGU/HlZtpwTqDWy3Agfvk/+8aVKHs+l/BquZ6kXFj14r9UEbHt5r9zg7oYQSWx5Ekns4uDry5d1iLglMgGAi9syI/E6Nj64oLIT0l6VGKKzYri9AYwLLVTN6inM6T6bdLFXwSryocUT66W6d1mqCVpYQrCLbOPpDw0YVPBFxhsHaaqG0ng4xU+iGPVfvaWV4Cov1aW5W3f8R0kYxMI03OfCAD0gxCy0Vh01BGHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7T6w/6dcQJX5IqNVcO3W2qvajcrgGn5xBJvehCu08A=;
 b=TAV/Qi/k/fVcS/MRtZ+9JveSuukrx97WKMrSLB3e/u5IHlXq6bmIyycHFytk0HinDkQLT+dynZxolhYU73R26RHIPJSCX3d5kEOtOXcdX3dSp9AAa8zg3r5lT03GUCoxJzfjbkVZqQtF2GsUPMH3IxERtnCIF7KyWSr9OtBGnE4qmqgHXICzIKfw6s8fZqRM82Z7CKgVUZjPnJ/YeDRFD8hzyubg2ask22pbeCnvsfD3D/IXnVbxKlvJbUkWhRg+MOUksusF6JSw/BFsvQLBkd/K+kEAvYOIRHeh3gIOf5C612a8OycR80Kh892KN1LTBujvRFvu7QRbpywY3JtTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7T6w/6dcQJX5IqNVcO3W2qvajcrgGn5xBJvehCu08A=;
 b=NTTbYonpqnzsSExH5omrgrRF3OEqgXjjs/VFoWS5hopeOzSicNZrDdPtCI0HSuLgJM3+vG9Tmfmk2YYVNCq8H+Qa7rKWP4dVrpPI7qYhNsRou8LxAGKUYoRDZITTbsvXWSXzAv2ktpJfHzz9FbkwFQokstu2dlm0NN4bV0EUTIA=
Received: from PH7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:510:339::23)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 10:06:42 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:339:cafe::86) by PH7PR03CA0023.outlook.office365.com
 (2603:10b6:510:339::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 10:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Fri, 28 Feb 2025 10:06:42 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:05:47 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 29/31] KVM: selftests: Add cross-vCPU IPI testing for SAVIC guests
Date: Fri, 28 Feb 2025 15:00:22 +0530
Message-ID: <20250228093024.114983-30-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f36e68-284c-4808-2e54-08dd57df99d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/e5z87zF5ta2Ny7Zk3OHR7yWZsCP6A4jWq1/XYwiMJT7GiLR4PrDRDjiAthT?=
 =?us-ascii?Q?xEAT2VuouBMslBDIykGSDmS4p/FCTf1xlmFvN1cnYs7ge6goR63kGUfFqKgw?=
 =?us-ascii?Q?cFYButXQVkYHreu4neHV4RIljJPG18NddB90pMqyZXDvwu/sZTr712E0ESv8?=
 =?us-ascii?Q?xG9Qr8ydN5aDeDleNbvxW+LPA0jW4q2Uf6DVJDaqfxn7Bb990ktWlJ2PU1Iy?=
 =?us-ascii?Q?Xr2H6XLBZw1nfxF25D5z3sTIlOHZdnbJfmvhIp6K/29pSh3wOgli51+COXVP?=
 =?us-ascii?Q?HZsfHYTuvKwGXmaAxzcJQcYisqR65XAxZ0WfHDsz+Ir4RRjXz47mL3+Vi2VR?=
 =?us-ascii?Q?2oE6MoBwjYZSdOQp6pW3QgnyqFbMUqhImBvIqX/25IPWGcfO7+mhNQVEb7FA?=
 =?us-ascii?Q?0tigvONRpoelzvZw+xnO1hP8jNJHdVRiABGCj8jRpjci4snl5Ah2StWz+pFK?=
 =?us-ascii?Q?tEoRwzzJXh+w8MLcrObuYpZzOErim7FydFOZ0KlFYyMQfQ1qL7jALHzLI46s?=
 =?us-ascii?Q?3s6udoJw5iUV7Rga6DoUC7Xl/+CY7A9ruSjuaDQf/0LYBzSN2GwAq2oMQn27?=
 =?us-ascii?Q?hHyG5q4Rl6PdBlW+xMa4XvsggsO1Dh3mh9HUq+qMBK5xEZTj0M32p6s/Dcv1?=
 =?us-ascii?Q?+8BTJkj2mD+xERRoFO4PcEqpIpj0gbsC3pmYU+NofBfx43z8Os5YNXkyV8fn?=
 =?us-ascii?Q?k2wTJcFlJz3ERG7cK4dU14GiZ26VxPl5Dp6vPNInF7heO3FZpar3t4I6sS/G?=
 =?us-ascii?Q?R20UdNyvDwwE0/w+DvfP3d35AVia8z0sfSvCSjG6Z9c69X2FXNZscpOZz7Yg?=
 =?us-ascii?Q?i51Iw1W9KIuBqH5vehYCE3QZoaApuMEKBH3Ua5vQNk5Iqf1QnMFxBvRxBksY?=
 =?us-ascii?Q?sIfd6KqB+trtYB6aDrW09WyMfx99DsMVYiMKlBDVtEwPxiBiRsTfGDs/UUHV?=
 =?us-ascii?Q?HVHXWO5kfiNWCKLo51L9OrYUtZpi/UbP4vNvtXLuorVjKDl+JjVMUvEvoorC?=
 =?us-ascii?Q?ofWHu5XjXpFMgVn9zIHDAAkck40oHYdMCi4mTvjkzegI8FVdvwmPc88DYS0R?=
 =?us-ascii?Q?1sXpoiAyuYnfZBF0DzdJguq90dj0RU2UWEj0kbs6RsB6R+MP6k92JsNgOw2d?=
 =?us-ascii?Q?tKxa62bX07WyATjYMFEI8bq0cbcKx4y7bmgFiJ89dG4+33SWg2jKPa1rnf6Y?=
 =?us-ascii?Q?gltQDX86+rtNGNHe9lq3VNf2YyZ8br7l0JjLSeXaB5Ooql2e4m4s+rJce7nn?=
 =?us-ascii?Q?pzfRGEIU8eOv9RRys4gyTPBXspepmkn+amSUl4zSDLdvgHodbSqmxZQlENHX?=
 =?us-ascii?Q?6xMrGXW/ZQ15RFSNDjnJSf+12t6Dvy5JrtRd9D4Z/o465W4LUvmNodJt6oQU?=
 =?us-ascii?Q?qYUf77e0KGwoVcOdMihsdGyN2w2k/SZNTN7DlxdWV0IfuF9nt/+/TvnBczUL?=
 =?us-ascii?Q?Ru8RPia410SfcfodOXaa4rUdq/bxnmPyjPPtmorNVRx2OeSpNTn390yKXGsN?=
 =?us-ascii?Q?Zx8kqqn2xadrpws=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:06:42.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f36e68-284c-4808-2e54-08dd57df99d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

Extend SAVIC test to include various cross-vCPU IPI modes -
fixed dest, fixed-logical, broadcast-all, broadcast excluding
self.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/x86/savic_test.c | 305 ++++++++++++++++++-
 1 file changed, 299 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index 3399ccefc37d..d677b68aa6c6 100644
--- a/tools/testing/selftests/kvm/x86/savic_test.c
+++ b/tools/testing/selftests/kvm/x86/savic_test.c
@@ -13,7 +13,7 @@
 #include "test_util.h"
 #include "savic.h"
 
-#define NR_SAVIC_VCPUS	1
+#define NR_SAVIC_VCPUS	2
 #define NUM_ITERATIONS 2000
 
 #define IDLE_HLT_INTR_VECTOR     0x30
@@ -22,6 +22,10 @@
 #define IOAPIC_NUM_LEVEL_VECTORS 2
 #define RTC_GSI	8
 #define RTC_GSI_IRQ 0x85
+#define FIXED_IPI_VEC     0x31
+#define FIXED_LOGICAL_IPI_VEC     0x32
+#define BROADCAST_ALL_IPI_VEC     0x33
+#define BROADCAST_NOSELF_IPI_VEC     0x34
 
 static bool irq_received;
 static struct kvm_vcpu *vcpus[NR_SAVIC_VCPUS];
@@ -42,6 +46,7 @@ enum savic_test_state {
 	SAVIC_TEST_STATE(SAVIC_IDLE_HALT),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC2),
+	SAVIC_TEST_STATE(SAVIC_IPI),
 };
 
 /* APIC reg values written by host. */
@@ -123,6 +128,18 @@ struct test_data_page {
 	uint64_t ioapic_lirq1_count;
 	uint64_t ioapic_lirq2_count;
 	uint64_t ioapic_rtc_gsi_irq_count;
+	uint64_t fixed_ipi_wake_count;
+	uint64_t fixed_ipi_hlt_count;
+	uint64_t fixed_logical_ipi_hlt_count;
+	uint64_t fixed_logical_ipi_wake_count;
+	uint64_t broadcast_ipi_hlt_count;
+	uint64_t broadcast_ipi_wake_count;
+	uint64_t broadcast_noself_ipi_hlt_count;
+	uint64_t broadcast_noself_ipi_wake_count;
+	uint64_t fixed_ipi_count;
+	uint64_t fixed_logical_ipi_count;
+	uint64_t broadcast_ipi_count;
+	uint64_t broadcast_noself_ipi_count;
 };
 
 static struct test_data_page *test_data[NR_SAVIC_VCPUS];
@@ -709,6 +726,247 @@ static void guest_setup_ioapic(int id)
 	savic_allow_vector(vec);
 }
 
+static void savic_fixed_ipi(bool logical)
+{
+	uint64_t last_wake_cnt, last_hlt_cnt;
+	uint64_t last_fixed_ipi_cnt;
+	uint64_t tsc_start;
+	uint64_t *fixed_ipi_p;
+	uint64_t *fixed_ipi_hlt_cnt_p;
+	uint64_t *fixed_ipi_wake_cnt_p;
+	int vec;
+	int i, j;
+
+	for (i = 1; i < NR_SAVIC_VCPUS; i++) {
+		struct test_data_page *data = test_data[i];
+		uint64_t dst_apic_id = i;
+
+		if (logical) {
+			fixed_ipi_p = &data->fixed_logical_ipi_count;
+			fixed_ipi_hlt_cnt_p = &data->fixed_logical_ipi_hlt_count;
+			fixed_ipi_wake_cnt_p = &data->fixed_logical_ipi_wake_count;
+			vec = FIXED_LOGICAL_IPI_VEC | APIC_DEST_LOGICAL;
+			dst_apic_id = 1 << i;
+		} else {
+			fixed_ipi_p = &data->fixed_ipi_count;
+			fixed_ipi_hlt_cnt_p = &data->fixed_ipi_hlt_count;
+			fixed_ipi_wake_cnt_p = &data->fixed_ipi_wake_count;
+			vec = FIXED_IPI_VEC;
+			dst_apic_id = i;
+		}
+
+		last_wake_cnt = READ_ONCE(*fixed_ipi_wake_cnt_p);
+		while (!READ_ONCE(*fixed_ipi_hlt_cnt_p))
+			;
+
+		last_hlt_cnt = READ_ONCE(*fixed_ipi_hlt_cnt_p);
+		last_fixed_ipi_cnt = READ_ONCE(*fixed_ipi_p);
+
+		for (j = 0; j < NUM_ITERATIONS; j++) {
+			tsc_start = rdtsc();
+			x2apic_write_reg(APIC_ICR, dst_apic_id << 32 |
+					APIC_INT_ASSERT | vec);
+			while (rdtsc() - tsc_start < 1000000000) {
+				if (READ_ONCE(*fixed_ipi_wake_cnt_p) != last_wake_cnt &&
+				    READ_ONCE(*fixed_ipi_hlt_cnt_p) != last_hlt_cnt &&
+				    READ_ONCE(*fixed_ipi_p) != last_fixed_ipi_cnt)
+					break;
+			}
+
+			__GUEST_ASSERT(READ_ONCE(*fixed_ipi_wake_cnt_p) != last_wake_cnt &&
+				       READ_ONCE(*fixed_ipi_hlt_cnt_p) != last_hlt_cnt &&
+				       READ_ONCE(*fixed_ipi_p) != last_fixed_ipi_cnt,
+				       "wakeup_cnt: %ld last_wake_cnt: %ld hlt_count: %ld last_hlt_cnt: %ld d_ipi_count: %ld last_d_ipi_count: %ld",
+				       READ_ONCE(*fixed_ipi_wake_cnt_p), last_wake_cnt,
+				       READ_ONCE(*fixed_ipi_hlt_cnt_p), last_hlt_cnt,
+				       READ_ONCE(*fixed_ipi_p), last_fixed_ipi_cnt);
+
+			last_wake_cnt = READ_ONCE(*fixed_ipi_wake_cnt_p);
+			last_hlt_cnt = READ_ONCE(*fixed_ipi_hlt_cnt_p);
+			last_fixed_ipi_cnt = READ_ONCE(*fixed_ipi_p);
+		}
+	}
+}
+
+static void savic_send_broadcast(int dsh)
+{
+	uint64_t last_wake_cnt[NR_SAVIC_VCPUS], last_hlt_cnt[NR_SAVIC_VCPUS];
+	uint64_t last_ipi_cnt[NR_SAVIC_VCPUS];
+	uint64_t tsc_start;
+	uint64_t *broadcast_ipi_p;
+	uint64_t *broadcast_ipi_hlt_cnt_p;
+	uint64_t *broadcast_ipi_wake_cnt_p;
+	struct test_data_page *data;
+	int i, j;
+	int vec;
+
+	if (dsh == APIC_DEST_ALLINC)
+		vec = BROADCAST_ALL_IPI_VEC;
+	else
+		vec = BROADCAST_NOSELF_IPI_VEC;
+
+	for (i = 1; i < NR_SAVIC_VCPUS; i++) {
+		data = test_data[i];
+
+		if (dsh == APIC_DEST_ALLINC)
+			broadcast_ipi_hlt_cnt_p = &data->broadcast_ipi_hlt_count;
+		else
+			broadcast_ipi_hlt_cnt_p = &data->broadcast_noself_ipi_hlt_count;
+
+		while (!READ_ONCE(*broadcast_ipi_hlt_cnt_p))
+			;
+	}
+
+	for (j = 0; j < NUM_ITERATIONS; j++) {
+		for (i = 1; i < NR_SAVIC_VCPUS; i++) {
+			data = test_data[i];
+
+			if (dsh == APIC_DEST_ALLINC) {
+				last_hlt_cnt[i] = READ_ONCE(data->broadcast_ipi_hlt_count);
+				last_ipi_cnt[i] = READ_ONCE(data->broadcast_ipi_count);
+				last_wake_cnt[i] = READ_ONCE(data->broadcast_ipi_wake_count);
+			} else {
+				last_hlt_cnt[i] = READ_ONCE(data->broadcast_noself_ipi_hlt_count);
+				last_ipi_cnt[i] = READ_ONCE(data->broadcast_noself_ipi_count);
+				last_wake_cnt[i] = READ_ONCE(data->broadcast_noself_ipi_wake_count);
+			}
+		}
+
+		x2apic_write_reg(APIC_ICR, APIC_INT_ASSERT | dsh | vec);
+
+		tsc_start = rdtsc();
+
+		for (i = 1; i < NR_SAVIC_VCPUS; i++) {
+			data = test_data[i];
+
+			if (dsh == APIC_DEST_ALLINC) {
+				broadcast_ipi_p = &data->broadcast_ipi_count;
+				broadcast_ipi_hlt_cnt_p = &data->broadcast_ipi_hlt_count;
+				broadcast_ipi_wake_cnt_p = &data->broadcast_ipi_wake_count;
+			} else {
+				broadcast_ipi_p = &data->broadcast_noself_ipi_count;
+				broadcast_ipi_hlt_cnt_p = &data->broadcast_noself_ipi_hlt_count;
+				broadcast_ipi_wake_cnt_p = &data->broadcast_noself_ipi_wake_count;
+			}
+
+			while (rdtsc() - tsc_start < 1000000000) {
+				if (READ_ONCE(*broadcast_ipi_wake_cnt_p) != last_wake_cnt[i] &&
+				    READ_ONCE(*broadcast_ipi_hlt_cnt_p) != last_hlt_cnt[i] &&
+				    READ_ONCE(*broadcast_ipi_p) != last_ipi_cnt[i])
+					break;
+			}
+
+			__GUEST_ASSERT(READ_ONCE(*broadcast_ipi_wake_cnt_p) != last_wake_cnt[i] &&
+				       READ_ONCE(*broadcast_ipi_hlt_cnt_p) != last_hlt_cnt[i] &&
+				       READ_ONCE(*broadcast_ipi_p) != last_ipi_cnt[i],
+				       "wakeup_cnt: %ld last_wake_cnt: %ld hlt_count: %ld last_hlt_cnt: %ld b_ipi_count: %ld last_b_ipi_count: %ld",
+				       READ_ONCE(*broadcast_ipi_wake_cnt_p), last_wake_cnt[i],
+				       READ_ONCE(*broadcast_ipi_hlt_cnt_p), last_hlt_cnt[i],
+				       READ_ONCE(*broadcast_ipi_p), last_ipi_cnt[i]);
+
+			last_wake_cnt[i] = READ_ONCE(*broadcast_ipi_wake_cnt_p);
+			last_hlt_cnt[i] = READ_ONCE(*broadcast_ipi_hlt_cnt_p);
+			last_ipi_cnt[i] = READ_ONCE(*broadcast_ipi_p);
+		}
+	}
+}
+
+void savic_ipi(int id)
+{
+	savic_fixed_ipi(false);
+	savic_fixed_ipi(true);
+
+	asm volatile("sti;":::"memory");
+	x2apic_write_reg(APIC_TASKPRI, 0);
+	savic_send_broadcast(APIC_DEST_ALLINC);
+	savic_send_broadcast(APIC_DEST_ALLBUT);
+}
+
+void guest_fixed_ipi_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+
+	WRITE_ONCE(data->fixed_ipi_count, data->fixed_ipi_count + 1);
+	x2apic_write_reg(APIC_EOI, 0x00);
+}
+
+void guest_fixed_logical_ipi_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+
+	WRITE_ONCE(data->fixed_logical_ipi_count, data->fixed_logical_ipi_count + 1);
+	x2apic_write_reg(APIC_EOI, 0x00);
+}
+
+void guest_broadcast_ipi_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+
+	WRITE_ONCE(data->broadcast_ipi_count, data->broadcast_ipi_count + 1);
+	x2apic_write_reg(APIC_EOI, 0x00);
+}
+
+void guest_broadcast_noself_ipi_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = test_data[x2apic_read_reg(APIC_ID)];
+
+	WRITE_ONCE(data->broadcast_noself_ipi_count, data->broadcast_noself_ipi_count + 1);
+	x2apic_write_reg(APIC_EOI, 0x00);
+}
+
+static void ipi_guest_code(int id, unsigned long secondary_entry)
+{
+	struct test_data_page *data;
+	uint64_t *ipi_count_p, *hlt_count_p, *wake_count_p;
+	int i;
+
+	x2apic_enable();
+	id = x2apic_read_reg(APIC_ID);
+	data = test_data[id];
+	savic_enable();
+	x2apic_write_reg(APIC_TASKPRI, 0);
+
+	uint64_t *ipi_count_types[][3] = {
+		{
+			&data->fixed_ipi_hlt_count,
+			&data->fixed_ipi_count,
+			&data->fixed_ipi_wake_count
+		},
+		{
+			&data->fixed_logical_ipi_hlt_count,
+			&data->fixed_logical_ipi_count,
+			&data->fixed_logical_ipi_wake_count
+		},
+		{
+			&data->broadcast_ipi_hlt_count,
+			&data->broadcast_ipi_count,
+			&data->broadcast_ipi_wake_count
+		},
+		{
+			&data->broadcast_noself_ipi_hlt_count,
+			&data->broadcast_noself_ipi_count,
+			&data->broadcast_noself_ipi_wake_count
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(ipi_count_types); i++) {
+		hlt_count_p = ipi_count_types[i][0];
+		ipi_count_p = ipi_count_types[i][1];
+		wake_count_p = ipi_count_types[i][2];
+
+		while (READ_ONCE(*ipi_count_p) != NUM_ITERATIONS) {
+			asm volatile("cli");
+			WRITE_ONCE(*hlt_count_p, *hlt_count_p + 1);
+			asm volatile("sti; hlt" : : : "memory");
+			WRITE_ONCE(*wake_count_p, *wake_count_p + 1);
+		}
+
+		WRITE_ONCE(*hlt_count_p, *hlt_count_p + 1);
+	}
+
+	GUEST_DONE();
+}
+
 static void guest_code(int id)
 {
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SNP_SECURE_AVIC);
@@ -731,6 +989,8 @@ static void guest_code(int id)
 	SAVIC_GUEST_SYNC(SAVIC_IOAPIC, savic_ioapic);
 	SAVIC_GUEST_SYNC(SAVIC_IOAPIC2, savic_ioapic2);
 
+	SAVIC_GUEST_SYNC(SAVIC_IPI, savic_ipi);
+
 	GUEST_DONE();
 }
 
@@ -914,6 +1174,11 @@ static void install_exception_handlers(struct kvm_vm *vm)
 	vm_install_exception_handler(vm, IOAPIC_VECTOR_START + 2, ioapic_level_irq1_intr_handler);
 	vm_install_exception_handler(vm, IOAPIC_VECTOR_START + 3, ioapic_level_irq2_intr_handler);
 	vm_install_exception_handler(vm, RTC_GSI_IRQ, ioapic_rtc_gsi_intr_handler);
+	vm_install_exception_handler(vm, FIXED_IPI_VEC, guest_fixed_ipi_handler);
+	vm_install_exception_handler(vm, FIXED_LOGICAL_IPI_VEC, guest_fixed_logical_ipi_handler);
+	vm_install_exception_handler(vm, BROADCAST_ALL_IPI_VEC, guest_broadcast_ipi_handler);
+	vm_install_exception_handler(vm, BROADCAST_NOSELF_IPI_VEC,
+			guest_broadcast_noself_ipi_handler);
 }
 
 int main(int argc, char *argv[])
@@ -925,19 +1190,28 @@ int main(int argc, char *argv[])
 	vm_vaddr_t test_data_page_vaddr;
 	struct kvm_vm *vm;
 	int i, r;
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SNP_VM,
+	};
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SNP));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SECURE_AVIC));
 	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));
 
-	vm = _vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_code, &vcpus[0], &args);
+	vm = __vm_create_with_args(shape, NR_SAVIC_VCPUS, 0, &args);
+
+	vcpus[0] = vm_vcpu_add(vm, 0, guest_code);
+	for (i = 1; i < NR_SAVIC_VCPUS; ++i)
+		vcpus[i] = vm_vcpu_add(vm, i, ipi_guest_code);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 	virt_pg_map(vm, IOAPIC_DEFAULT_GPA, IOAPIC_DEFAULT_GPA);
 
 	install_exception_handlers(vm);
 
-	vcpu_args_set(vcpus[0], 1, vcpus[0]->id);
+	for (i = 0; i < NR_SAVIC_VCPUS; i++)
+		vcpu_args_set(vcpus[i], 1, vcpus[i]->id);
 
 	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
 		test_data_page_vaddr = vm_vaddr_alloc_page_shared(vm);
@@ -950,10 +1224,13 @@ int main(int argc, char *argv[])
 
 	vm_sev_launch(vm, snp_default_policy(), NULL);
 
-	r = pthread_create(&threads[0], NULL, vcpu_thread, vcpus[0]);
-	TEST_ASSERT(r == 0, "pthread_create failed errno=%d", errno);
+	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
+		r = pthread_create(&threads[i], NULL, vcpu_thread, vcpus[i]);
+		TEST_ASSERT(r == 0, "pthread_create failed errno=%d", errno);
+	}
 
-	pthread_join(threads[0], NULL);
+	for (i = 0; i < NR_SAVIC_VCPUS; i++)
+		pthread_join(threads[i], NULL);
 
 	for (i = 0; i < NR_SAVIC_VCPUS; i++) {
 		struct test_data_page *shared_state = shared_data[i];
@@ -961,6 +1238,22 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "VCPU %d ioapic edge irq1 count: %ld edge irq2 count: %ld\n", i, shared_state->ioapic_eirq1_count, shared_state->ioapic_eirq2_count);
 		fprintf(stderr, "VCPU %d ioapic level irq1 count: %ld level irq2 count: %ld\n", i, shared_state->ioapic_lirq1_count, shared_state->ioapic_lirq2_count);
 		fprintf(stderr, "VCPU %d ioapic RTC GSI irq1 count: %ld\n", i, shared_state->ioapic_rtc_gsi_irq_count);
+		fprintf(stderr, "vCPU %d fixed IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+			i, shared_state->fixed_ipi_wake_count,
+			shared_state->fixed_ipi_hlt_count,
+			shared_state->fixed_ipi_count);
+		fprintf(stderr, "vCPU %d fixed-logical IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+			i, shared_state->fixed_logical_ipi_wake_count,
+			shared_state->fixed_logical_ipi_hlt_count,
+			shared_state->fixed_logical_ipi_count);
+		fprintf(stderr, "vCPU %d broadcast IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+			i, shared_state->broadcast_ipi_wake_count,
+			shared_state->broadcast_ipi_hlt_count,
+			shared_state->broadcast_ipi_count);
+		fprintf(stderr, "vCPU %d broadcast exluding self IPI counts wake: %ld hlt: %ld num-IPI: %ld\n",
+			i, shared_state->broadcast_noself_ipi_wake_count,
+			shared_state->broadcast_noself_ipi_hlt_count,
+			shared_state->broadcast_noself_ipi_count);
 	}
 
 	kvm_vm_free(vm);
-- 
2.34.1


