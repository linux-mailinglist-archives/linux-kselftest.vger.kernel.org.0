Return-Path: <linux-kselftest+bounces-42124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D500B94630
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55147A9857
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BD3115AB;
	Tue, 23 Sep 2025 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rFiTE+bo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32A27511F;
	Tue, 23 Sep 2025 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604790; cv=fail; b=pyiXgFml3GCGKfQU+iKGZ6yzS0tchHGdziWkiRUpv/dqyHN+/W2uBW2W6t/L72glnRSG5+fuGTwT3Y4DBhp4C+hOjP8AHMxpnwf6d6gWrCk/mNtcOcQddXvj3sBjv6vYd6+xt+pejXis3UiDV/TgE4D3I04O+20SNPzdtMr4a38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604790; c=relaxed/simple;
	bh=C53+Ci0hQrsTfdRIHMjM9/b+JLo2q1cuhrW6wyYeylM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeBDqLp37UP+3aZ7Q98Rx/RsOcLxo4bIWCpBitZNlZcAz0QhQkj8yjbRq+pjEdR/zphLZDfp40L36QwQ1MsSuu2mYw+/mY1KvgLn5vBciEkDA6R/aSoowqsHrTs4eifjdDBxdABzSiDiUyVjT1aeld94AeMFQMgEhhb7DN7+xVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rFiTE+bo; arc=fail smtp.client-ip=40.107.200.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nufn0iUELMRMwviiUBKLUrnmiTdCTGeL1AF8PPDE03DrP7ALHn97NYlo04W6stOqZeWlrEkaSKycYOCtKWVYzHp5MO/WMZjGM9htlKUoYUxeXFHAlmOPtb3NzaHn1bkO8DsYNYPKzFneJal0D3oYcy3Ca4Rk9jmFPMcQpUdIShPH83aSYjkxoaBRX6nBTskNLtsodZz0JQD2JHmW2mDFqt0Oo6r4frnhNwSx0RVHkNeALD03012Sfna9I0/efrw6vdwF1wWcWc/B/fbYReVp9HJ6QGCVI+g0vFgf+thh9INCH8XxHpokehM6/VL6/V9b+uE+0ckcvsNKvcbH2sVxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qskP59LqFMsYmg73iE0T4FLX7RtlfTRagDa03N0oAg=;
 b=q69Owa/1H1il3XpTSSHJw4jUprS9qNfbZhW4LsLK7tIhGB9AXdMceDlLXjUCsFMgsAQXV1yySqCswPoi3EW79IA8reSr/QDl8ALMqeYARt7nGMqz4B0IeLwREY3aALScq2mV1nOVJ78ZmgI+EdLAouZmPjapSGH5uSSb9//z0MlgG/qk1MHwpphojKXIoyDTqBEP7YY2QvrDknVUWraOWX+VkO3fb4HY6H+fLbThwR/vC4odSBxzMJmrQowdkoG2PVHJK6CmpKAV8w6NbRqAnXUUb8xG/vMCPk75PcZdq3r/QAu1YONpnMNMv7HAXe0ghvvMA6jOxgXYWIR3sjEtpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qskP59LqFMsYmg73iE0T4FLX7RtlfTRagDa03N0oAg=;
 b=rFiTE+boetpHYBawx/nCzwgAQZ3Rw+b2rKuC6059pWAt/vt9w5zyOS+N0+NUgdLKNhy3fadPY5FEOBx0rmEO4hA4Hsh4BD9ojgGL/jD7viYoc5SKe4rlI1Wwc6dYtqhcZaNzy1kmzRKQO5dUz9E0HwAUlrJWTG1reqwivItYQjA=
Received: from BY3PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:39b::13)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:19:42 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::d9) by BY3PR05CA0038.outlook.office365.com
 (2603:10b6:a03:39b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Tue,
 23 Sep 2025 05:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:19:41 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:19:35 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 33/35] KVM: selftests: Add cross-vCPU IPI testing for SAVIC guests
Date: Tue, 23 Sep 2025 10:39:40 +0530
Message-ID: <20250923050942.206116-34-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 607b8bfa-c744-4c95-4ba5-08ddfa60ccdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NnxLBPqaHdz2GxIzWpmtfyJkHYLQyUWHckxTWOUbMKtg5yVd/lfoNFT8MP3L?=
 =?us-ascii?Q?6cAiF/zj4sD4ylM4yoV5sRPgslFR6Pk7xBfDUzmBzqjMC46hqMgORKtpBVbY?=
 =?us-ascii?Q?J+BR9JNybKWNDsQ5P7v3l+s0wdWlQ0dkzlRENYpoWDtTaJus9GymsMp4xdu1?=
 =?us-ascii?Q?FqjUC6L06qq+cxiz3qm5G841Bf0JdYCMrtLxayLF+DoqFprVW3e/F5LS5YFk?=
 =?us-ascii?Q?jUUkTy7ajh3Q2v5Znxrj2cmyA/D8PRfQ8RQmEndLgYYWKw6RIt5HoQRpo367?=
 =?us-ascii?Q?5LFyeitALnn/ZUu8/ad7yEyLyCSHt6ZV/ZeCyAYVMe/x9d9w2K9c6kvGOw0W?=
 =?us-ascii?Q?97lrvxzRuWgAfuJZiLLyjXlP0FU71030zyJIT266RWg3x59DGQIlrBD/1B5I?=
 =?us-ascii?Q?2de5D+xorulrlwE61Sq/KYYvXnoNfekY4hoRp/AltOY45PLho1RHXyYkZvoG?=
 =?us-ascii?Q?FlAFQiUb9LULOrFnPu85tNiAH+bKSN28AV1Mx9Vb7UAep3MWw2kobLpUKJ50?=
 =?us-ascii?Q?BJfuapbjZK2V7czF/PPbtz4PuTnjKWuZZDuO9fXSnsctRwnk4gu06DFAseAJ?=
 =?us-ascii?Q?Kn/CPVNMr3Q2bRuTK84esVu4LHEC19oZ3uXOOHwAHHSdJWqqbn3WC4MEEt78?=
 =?us-ascii?Q?mzHG0Co6hqK3ketvd5K5FkpMyBhamM3vFhLuwm95nOHgJ0OlvbO+uqCXyurD?=
 =?us-ascii?Q?B88BGviwGbIjwRJHZTZjqrHlIioP+wo2p1TtNbGyCA/11Cck0+ybbtLgX7Mu?=
 =?us-ascii?Q?a4TKA4YDeDg3W0q6/WxlGNG314SmcQBWh0TJKa+yadHeu0ZEezcFQUPtxWmH?=
 =?us-ascii?Q?RAK6f8vfJkTsgDbKncTW+Pz2yatu4m1N3HrsorvCmTv0ymp356N3Oc+5ZCAn?=
 =?us-ascii?Q?f1G6Dqf10Om3t/WkhOHVVyOORbLQtPQ4nytgEGrT+TWL5ECz+0MhiZMpwJ/d?=
 =?us-ascii?Q?ryjKopJDV0+CssJYCWF0BilmN8D8DvpuKcSQDtdFS/gqmm1e1oY0kTry+Lg2?=
 =?us-ascii?Q?UUfOkKdTfb6/WRMmFWC3u8nvN5WBheYlupU9ON3Oqziai6C+v0HTOo64EZHU?=
 =?us-ascii?Q?ott9VmlS+MNcE5VYtEMGc+cZJDtEUqxMN+kem1MnHisoqO4zBvIbSFA8P2iD?=
 =?us-ascii?Q?MSUDhY2j2tpuUxdKFOKLRsnz3zL+u30JqexmBE9uazv8G71jjvS5FLEcNarg?=
 =?us-ascii?Q?O+YxNynkmoCmkSFGb/i6mgHt6/Isol1Qx1A2xQm7I4nGIUjibMzzDFBupF9Q?=
 =?us-ascii?Q?zTN2aDCFZNCHAE/gSgFhqx9Qu3uf/u/fR8B3v4YKTav34CWsldAk44ndiUxR?=
 =?us-ascii?Q?f4oViZHjHglVPecx4qWWrxl+ZaqCDWU5jwk2uMJ6OsPM7LCJZDgFIkmsdz4u?=
 =?us-ascii?Q?J5fHMQawxgeSMCznalU+ypJccXuWD2RCHIJ+Qo8Tdjtw+p1pptkt1bh126Bq?=
 =?us-ascii?Q?hHm6IfXKhkOeT+5sb8O7AoKgBVE61KoW8WMr5x5u7sLoU8AjRNKAMSWCyzr7?=
 =?us-ascii?Q?r9w6Oz8efKjmWw9RmArgtGOPGM01Glns+ZL2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:19:41.5932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 607b8bfa-c744-4c95-4ba5-08ddfa60ccdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391

Extend the savic_test to validate Inter-Processor Interrupt (IPI) delivery
between vCPUs in a Secure AVIC (SAVIC) enabled guest.

When a vCPU in SAVIC mode sends an IPI, the hardware triggers
a #VC(INCOMPLETE_IPI) exception. The responsibility of routing and
delivering the IPI to the target vCPU(s) falls to the guest's #VC
handler. Exercise this guest-side emulation logic thoroughly.

Extend the test to use multiple vCPUsand verify IPIs using various
destination modes and shorthands, including:

    Fixed (physical) destination
    Fixed-logical destination
    Broadcast to all vCPUs (including self)
    Broadcast to all vCPUs (excluding self)

This provides essential test coverage, ensuring that the SAVIC IPI
emulation mechanism is robust and correct across all standard addressing
modes.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/x86/savic_test.c | 305 ++++++++++++++++++-
 1 file changed, 299 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index aa8a7244aa55..4251f3427a32 100644
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
@@ -36,6 +40,7 @@ enum savic_test_state {
 	SAVIC_TEST_STATE(SAVIC_IDLE_HALT),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC2),
+	SAVIC_TEST_STATE(SAVIC_IPI),
 };
 
 /* Data struct shared between host main thread and vCPUs */
@@ -45,6 +50,18 @@ struct test_data_page {
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
@@ -452,6 +469,247 @@ static void guest_setup_ioapic(int id)
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
@@ -468,6 +726,8 @@ static void guest_code(int id)
 	SAVIC_GUEST_SYNC(SAVIC_IOAPIC, savic_ioapic);
 	SAVIC_GUEST_SYNC(SAVIC_IOAPIC2, savic_ioapic2);
 
+	SAVIC_GUEST_SYNC(SAVIC_IPI, savic_ipi);
+
 	GUEST_DONE();
 }
 
@@ -536,6 +796,11 @@ static void install_exception_handlers(struct kvm_vm *vm)
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
@@ -547,19 +812,28 @@ int main(int argc, char *argv[])
 	vm_vaddr_t test_data_page_vaddr;
 	struct kvm_vm *vm;
 	int i, r;
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SNP_VM,
+	};
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_SNP));
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
@@ -572,10 +846,13 @@ int main(int argc, char *argv[])
 
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
@@ -583,6 +860,22 @@ int main(int argc, char *argv[])
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


