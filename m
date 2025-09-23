Return-Path: <linux-kselftest+bounces-42116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9866B945E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48427B2107
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE5830F95E;
	Tue, 23 Sep 2025 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hvufsxrs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EADF30DD29;
	Tue, 23 Sep 2025 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604661; cv=fail; b=enOvme9zY0D40WKHb90OrLvNeD8TcymILLPWWd8+NXXNqeTnjlgmaK/4gWxnzZyf0ijvWsvbrfxBNAblOpZsHXZHfZuycfgsyT9LXqXbwCDXqWUmKAoE22O4UwZabNRGBn1+QWWbGpqQRzyqneepKLkEKpB1T7RodVXHQl88lGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604661; c=relaxed/simple;
	bh=zrXyPWBUFrjrbghIthUK6XLiXBfcujFIdzK1rOIW73Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLZs8f0EBJRTGZAPzPOeeTEXVBg7OIxCHSs6LxSQm0CBSdc1uE70+yCze0zDrNcxJs58S+8mJ8CzbQ3o3ibIngo6mCcUEqEoS3+myxedu4NzTJBvsn5SCNTA9Jh9tP+xVUozW0rtapX4tqUnu4DRapsa+06sJbtg7/HjCGqWTKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hvufsxrs; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsZA0i5REaQgYsbZtlXe+svvIvpwH98RwQOr4PRLEso0w3nGjaDFccX5FBNf/GRcD++ROKCIKKskkn/q+8vDgyfm21kd+ArWuEjtwW61ZLpMl4gqRT9klKBS+tO6f/3lste0FXeZNASunh0aUcmHdrnHwZmAelh01CZMI+qUH4hnBvG5qTz/pyuWktunmmXBMmVBGHb/bVmYn1ySU79O1KkzZQ99f9DSGCgLZNGBq0xdWE0PDcdpkgUdeCwtLU7JdkU/Ohl2UmMzog8v1st7UroO1ZYCOu5mrNd5fbTJGVr/ZdSzh/v3Sn5rhwPxFSORh5LGPKHDMAhU3i0L/9Zjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWKiSKcGqO9bHqfapJCMvbRpFALtusXfkepJeqAelCA=;
 b=amHJ1kOBKqk7bC3RWDvfE5ahVn4b/RwllWP5MYiRSg1vQV/CzQOWNWxMedosYeLFD8hkFZ/vX/N99CA8Gx7nw04SSPI7n4BQbbvmNmTUEnLi6fCi9khqZ4NgY3O46Fi/ghnXDzu3sGmqPinsAUSREIs0h8bCwr/mqC8b0aRORoDzy/ACTGeKHAW+yPKoH5/eeNFFKgwn7aZqC/P0h+BOb3v6EiN7VYXQcc2YXDrtwFIzBT3o12BZ/P395IgSstGi8lFN3wQ3EXbv0L/mEysIe/EsDbksNm8pRv4Nyu/iV4NtJvuHft78upXw8fC6RjW7KiPHN3ckbkxL4ib0o1CRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWKiSKcGqO9bHqfapJCMvbRpFALtusXfkepJeqAelCA=;
 b=hvufsxrsW83T1qeKeN8jLivoVXF+8BbU9NL2biL9BtWJmfIW+nfpZPwqFsVTL8QY5XRDVGUfuDPZJkKOQe066AioyHO0qXUSs6R8Sz3mgyPjzdgymcayO3LZ4frcmR6/7rjrvP5lEktpgz3mqMDgEJ1/BKt8cea66D6A1Kjz068=
Received: from CH2PR15CA0010.namprd15.prod.outlook.com (2603:10b6:610:51::20)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:17:34 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::c3) by CH2PR15CA0010.outlook.office365.com
 (2603:10b6:610:51::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 05:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:17:33 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:17:14 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 25/35] KVM: selftests: Add #VC handler for unaccelerated Secure AVIC MSRs
Date: Tue, 23 Sep 2025 10:39:32 +0530
Message-ID: <20250923050942.206116-26-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 93956914-316d-4821-28a8-08ddfa60807c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBBq2gB2boBS6kRDvpQ3WtUZx/HrkSPBkahiAYd7KYMFTgTQRLUb8N31YQ99?=
 =?us-ascii?Q?PtEbSE56UhoV0sGEO9SSRw+GaoOThtiaHLX7MROeSlaSc3zhidvd/9OTEaSq?=
 =?us-ascii?Q?xPVfZgac+Ut9M6wksqpSdtacyYgE95IA/vQsuQyotN94Gq3YUEyfiILbaVV+?=
 =?us-ascii?Q?6k3b5NQrxaMVsKjTjSBb4kfniJGULoEUabcexefb2yXjF99s/O6oSg/M9K3v?=
 =?us-ascii?Q?L/2hb5HE12qrL0OIXOp8yL1DOXXMINuwOWpRWNdXT5p4qAgiofp8iqv31CGT?=
 =?us-ascii?Q?bKYVAR4TYRdLEFNpRVxxvb9qP432W//KpKQ7NBWb12B4JZWkSc1JDB5mRKzz?=
 =?us-ascii?Q?aYpS6rvfKSO/6scs2ifNIJZ9q5wHMvrVw09p9Q1XhttYsyKQLEuZaeWxxQ1Z?=
 =?us-ascii?Q?xAoK/P1tP71Vch2wjsOc8a6pJZ1Wa+1osiPyD/TPBrAW5XGl6NNofhz3zqd/?=
 =?us-ascii?Q?soh8P5IGO8n1cx9bAkUA8SA70e71HVTrv/a4zVXtQtAuFbAzOKxwAUnwQ6hh?=
 =?us-ascii?Q?iuwyXq1lM65i7EYgmuXrdTxP+4F+qKhwLxiPHrXM6yqooUAzKNb8iCYrDmGU?=
 =?us-ascii?Q?Th50e3I8yH9o5z+CFH4uevHe2nWtJbeNLX236AZUaUWNKZfmTjU++1bN4coX?=
 =?us-ascii?Q?+5/D19ziknCErce35MAWWGZBJRUZVlb5cKbPkWfvTyqf4IZvL4alZmLop9Qt?=
 =?us-ascii?Q?MxBoU/m3eH9AJ3Ne9XfrleP/PiX7WF0Lk9YGl1oGEoCh63I6A8f/E8c3iVy2?=
 =?us-ascii?Q?SP6+TpNFYi/t1zALz08u3pgatN/vslTIphmMspvx4d/4icZ6nYrGAS9deFyA?=
 =?us-ascii?Q?i+wyed9aGxz8+MlS2gxMoV0/XcAd73tURskUZavgWOT3D4Wny5Vf6OMNX/jv?=
 =?us-ascii?Q?g9x05uX9buMspPPHVJRma5TK/21V2cfl4BrdFQorrcnFy9vHD8klOgPk0bvw?=
 =?us-ascii?Q?M9PfiQ8nKCYfwBgVHpL6JzY/T3bk8Y0FRjxDHyZw8UMpB1HQI9iW06aKgjjd?=
 =?us-ascii?Q?f5r1WPTTlqSgTQpa5jheMFjfzf1vKO/Cz4M8e2FXZD7keY5daJsrEAuzwfq8?=
 =?us-ascii?Q?Y7ojLGhBIlJT5RxzZ5VpsTOMbTML/obkBHweg+BycIHeK58APUDNh4fFI+iL?=
 =?us-ascii?Q?3mRS9P1Ax65/8c3gx8ZUo9g7CeR0TBN4YE1PEU5LSEGvO8bnX7SU9kMAdY5r?=
 =?us-ascii?Q?yMfKBnC5Vla5A+HNE+zLP3YysCzY3gHTrsNPQ92Dnn1saJy3+iTiB3mADb0n?=
 =?us-ascii?Q?hP4ucwqizjV9Jp0CIFuJm9RbL79/M8MIk0MRnL/WxPx3uMxHw/W6cZLoYKCq?=
 =?us-ascii?Q?cUVT8oHOaBpaQR8WUMTIzjUG0uR0/mD0Lu79xi7QmTvBJuaviuddQPQgCCMy?=
 =?us-ascii?Q?pFJ+dYwvwy/kmbdycfYZYLviJ4I8R484zDvF8KAVyJ6h66/OYEgNit47/uM/?=
 =?us-ascii?Q?2svVhBF871+sSiA0neG2Vfhchw16/VZ5TtT9H6dIEYeD/tWSS9z9f2rZMr52?=
 =?us-ascii?Q?BolzOeqGEZe+VF/tlXJwmIPJfmXvU5kTtSog?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:17:33.5311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93956914-316d-4821-28a8-08ddfa60807c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471

When Secure AVIC (SAVIC) is enabled for an SEV-SNP guest, most APIC
register accesses are accelerated via a guest-visible backing page.
However, not all APIC registers are handled this way. Accesses to
certain "unaccelerated" registers via RDMSR or WRMSR are designed
to trigger a #VC (Virtualization Exception) with the new exit code
SVM_EXIT_AVIC_UNACCELERATED_ACCESS.

Without a handler for this exit code, any guest attempt to access
these MSRs would result in an unhandled fault, crashing the guest.
Implement the necessary #VC handler to emulate these accesses.

The new handler (handle_savic_unaccel_access) emulates the MSR operation.
For MSR reads/writes, it applies different strategies based on the
register:

- Read/Write APIC timer, APIC Spurious Interrupt Vector and LVT registers'
  from the hypervisor using the existing paravirtual MSR interface as LVT
  and APIC timers are emulated by the hypervisor.

- Propagate EOI write to the hypervisor. This is required for
  acknowledging emulated IOAPIC interrupts.

- Keep APIC_ID in-sync between the guest and the hypervisor.

- For rest of the valid APIC register writes, write the value only in the
  APIC backing page of the guest vCPU.

This emulation provides the necessary glue to allow guest code to run
seamlessly when SAVIC is active, enabling comprehensive testing of
APIC functionality in this mode.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/include/x86/apic.h  |   1 +
 .../testing/selftests/kvm/include/x86/savic.h |   1 +
 tools/testing/selftests/kvm/lib/x86/savic.c   | 145 ++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index 6ba5d0545bf8..aa3a5d54c404 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -33,6 +33,7 @@
 #define	APIC_SPIV	0xF0
 #define		APIC_SPIV_FOCUS_DISABLED	(1 << 9)
 #define		APIC_SPIV_APIC_ENABLED		(1 << 8)
+#define APIC_TMR        0x180
 #define APIC_IRR	0x200
 #define	APIC_ICR	0x300
 #define	APIC_LVTCMCI	0x2f0
diff --git a/tools/testing/selftests/kvm/include/x86/savic.h b/tools/testing/selftests/kvm/include/x86/savic.h
index 1ab92dad00c1..238d7450ab6e 100644
--- a/tools/testing/selftests/kvm/include/x86/savic.h
+++ b/tools/testing/selftests/kvm/include/x86/savic.h
@@ -16,4 +16,5 @@ void savic_hv_write_reg(uint32_t reg, uint64_t val);
 uint64_t savic_hv_read_reg(uint32_t reg);
 void savic_enable(void);
 int savic_nr_pages_required(uint64_t page_size);
+void savic_vc_handler(struct ex_regs *regs);
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index 72ad43d4797e..9b1ea5d15338 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -41,6 +41,8 @@ enum lapic_lvt_entry {
 #define MSR_AMD64_SECURE_AVIC_EN_BIT       0
 #define MSR_AMD64_SECURE_AVIC_ALLOWED_NMI_BIT       1
 
+#define SVM_EXIT_AVIC_UNACCELERATED_ACCESS      0x402
+
 /*
  * Initial pool of guest apic backing page.
  */
@@ -203,3 +205,146 @@ void savic_enable(void)
 			"SAVIC Control msr unexpected val : 0x%lx, expected : 0x%lx",
 			savic_ctrl_msr_val, exp_msr_val);
 }
+
+static bool savic_reg_access_is_trapped(uint32_t reg)
+{
+	switch (reg) {
+	case APIC_ID:
+	case APIC_TASKPRI:
+	case APIC_EOI:
+	case APIC_LDR:
+	case APIC_SPIV:
+	case APIC_ICR:
+	case APIC_ICR2:
+	case APIC_LVTT:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+	case APIC_TMICT:
+	case APIC_TDCR:
+		return true;
+	case APIC_LVR:
+	case APIC_PROCPRI:
+	case APIC_TMR:
+	case APIC_IRR ... APIC_IRR + 0x70:
+	case APIC_TMCCT:
+		return false;
+	default:
+		return false;
+	}
+}
+
+static void savic_unaccel_apic_msrs_read(struct guest_apic_page *apic_page,
+		uint32_t reg, uint64_t *val)
+{
+	switch (reg) {
+	case APIC_TMICT:
+	case APIC_TMCCT:
+	case APIC_TDCR:
+	case APIC_LVTT:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+		*val = savic_hv_read_reg(reg);
+		break;
+	default:
+		__GUEST_ASSERT(0, "Unexpected unaccelerated read trap for reg: %x\n", reg);
+	}
+}
+
+static void savic_unaccel_apic_msrs_write(struct guest_apic_page *apic_page,
+		uint32_t reg, uint64_t val)
+{
+	switch (reg) {
+	/*
+	 * APIC_ID value is in sync between guest apic backing page and
+	 * hv.
+	 * LVT* registers and APIC timer register updates are propagated to hv.
+	 */
+	case APIC_ID:
+	case APIC_LVTT:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+	case APIC_SPIV:
+	case APIC_TMICT:
+	case APIC_TMCCT:
+	case APIC_TDCR:
+		savic_write_reg(apic_page, reg, val);
+		savic_hv_write_reg(reg, val);
+		break;
+	/*
+	 * LDR is derived in hv from APIC_ID.
+	 * TPR, IRR information is not propagated to hv.
+	 */
+	case APIC_LDR:
+	case APIC_TASKPRI:
+	case APIC_IRR:
+		savic_write_reg(apic_page, reg, val);
+		break;
+	/*
+	 * EOI write need to be propagated to hv for level-triggered
+	 * interrupts.
+	 */
+	case APIC_EOI:
+		savic_hv_write_reg(reg, val);
+		break;
+	default:
+		__GUEST_ASSERT(0, "Write not permitted for reg: %x\n", reg);
+	}
+}
+
+static void handle_savic_unaccel_access(struct ex_regs *regs)
+{
+	bool write;;
+	uint64_t msr = regs->rcx;
+	uint32_t reg = (msr - APIC_BASE_MSR) << 4;
+	struct guest_apic_page *apic_page;
+	uint64_t low = regs->rax;
+	uint64_t high = regs->rdx;
+	uint64_t val = 0;
+
+	apic_page = &apic_page_pool->guest_apic_page[x2apic_read_reg(APIC_ID)];
+
+	switch (msr) {
+	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
+		if (savic_reg_access_is_trapped(reg))
+			write = *((uint8_t *)regs->rip - 1) == 0x30;
+		else
+			write = *((uint8_t *)regs->rip + 1) == 0x30;
+		if (write) {
+			savic_unaccel_apic_msrs_write(apic_page, reg,
+						      high << 32 | low);
+		} else {
+			savic_unaccel_apic_msrs_read(apic_page, reg, &val);
+			regs->rax = val & ((1ULL << 32) - 1);
+			regs->rdx = val >> 32;
+		}
+		if (!savic_reg_access_is_trapped(reg))
+			regs->rip += 2;
+		break;
+	default:
+		__GUEST_ASSERT(0, "Unknown unaccelerated msr: %lx\n", msr);
+		break;
+	}
+}
+
+void savic_vc_handler(struct ex_regs *regs)
+{
+	uint64_t exit_code = regs->error_code;
+
+	switch (exit_code) {
+	case SVM_EXIT_AVIC_UNACCELERATED_ACCESS:
+		handle_savic_unaccel_access(regs);
+		break;
+	default:
+		sev_es_vc_handler(regs);
+		break;
+	}
+}
-- 
2.34.1


