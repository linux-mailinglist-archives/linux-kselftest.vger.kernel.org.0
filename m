Return-Path: <linux-kselftest+bounces-42126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A0B94642
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEEB3B4A75
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD8730F95E;
	Tue, 23 Sep 2025 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cN4XfVLh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100626738C;
	Tue, 23 Sep 2025 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604827; cv=fail; b=eeMsEujbDL9FgdTbRWgVyEcm9iQV/pUQhq3zCMcWHH82ciVsqnBTzwsduengadg1FzlgVRYFww/XxGqliob00tfmbG66oK0n24yLk3laaQxaVdIWQHxLmEQSYyqZjYjQ6GFHrxWmBYzDUycxaVrqTsBZJJteCFKEOvDf74DgqAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604827; c=relaxed/simple;
	bh=Nu+PwHxneVCgCYF3rgY4QV5waxKBWzc4M7v5zFQ+Foo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIqZIu7TXLffr4pazkF3XTDzsTDKecLrE/cG63zq9S1RF/olwdeVOlXffycjlQ0GDRxe0/x1MwJzU//coKUSrwvnS0NSglMlVUl8FXfE4we5LWB0bb5GxDT9KYKCVk+KNG7M7B/frKRvbmM/SUWnFWlX0Y3ln8TPVcnDFQLHVJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cN4XfVLh; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkOuInvuiBdlF9x6A7o7fUhqPMKPN4tBMV7SmG0I+vSLOOKfPliblbLwfBvGOrtye+mfvzPh09twm9LMvwg0Xa84HVsyqvqnmxpIZYQiNHq/UigpEromvH7vLNQpnOKNGQTIEgu56cVt3ob3ugc95jlVgTy+GQ2XLLdu0q4I9Hy/ayyV9G9icWaL8B9lMV8zYgH/tmF0J5fpEILUnP9u16G0kFWA/+quFXh94tSxC23Df4vdiN6So9Lu5DxY2uMkVeaevN0iNAAPi8pqj9cpek6XsmTxtDabVxxiTTf+geTKsDLlrLsQsNul9G0m1PNpCnZZ6L97MJEXH16qmdvrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sSXaeNCv+iNNfdL5HfwJPrH00Cylwf3+emacxDv1EA=;
 b=oJySRaWM+DJKi66RydncfHwS/3Uflr7PlQ94zIA382TZjqRKizcuMJoj07br11geooJFkvcU6l97DduCDm0q7EBY9twq3ZcZYBdUoMhPmz+7HQAwI7hx0pDmw2Nh2qcmR6iWHBDXEU1bfGbX5m6p2ETCMbkEBknI7rnelAiCmIQVLFiWXSnrwKdqUATKTU0DLag39pcIVxLhDRTEytoyUbuw1WThExwK7HegKrOuE50fHFUnWCgpLp5I+tU6gvYjIp160uvNcJemzvNa228mrjzB6IPzipjXr/+rDQOdN5KXaOxLsz+k40tScXGf/0OeqIcqmkwyx0mR7f5oyPxOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sSXaeNCv+iNNfdL5HfwJPrH00Cylwf3+emacxDv1EA=;
 b=cN4XfVLhA8SqioTy2p7f5Tk+c05JsZC0Kuil3orLtZTQiSsQdmD5QafMTpf1SAL/HP3A9aimre7ODJcDWUjykHFUXnQbo92OI8nLZMxVrupCMUzYUo9jApYU5/yaqDiQrGeQQxhc2zMNefSrWDmkPuTCjCh1iCNoDcA0P/y0sJc=
Received: from SJ0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:2c0::9)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Tue, 23 Sep
 2025 05:20:20 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::58) by SJ0PR13CA0004.outlook.office365.com
 (2603:10b6:a03:2c0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Tue,
 23 Sep 2025 05:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:20:20 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:20:11 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 35/35] KVM: selftests: Add MSI injection test for SAVIC
Date: Tue, 23 Sep 2025 10:39:42 +0530
Message-ID: <20250923050942.206116-36-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: ca93a262-2a2a-4bd7-39ca-08ddfa60e3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ajMPlGaGkPvBKgQYoPWDjJmE6zTGlBbHHZ9LkXWkBe89LBnwAsvVPJkvNY4N?=
 =?us-ascii?Q?amf/cFZvaNZYJIyWWnNv4sOajGnG7P0XInYKONP2T9FoCEfKPXvXMqGOSjac?=
 =?us-ascii?Q?KBOXrpi1drmI0WuE/nUsp2LvPXxfZRCmbaD7ZJ+lhFUl4FiwE85rysb0P3iF?=
 =?us-ascii?Q?bfTgC5tZZvocfccfhRacQ0LbG2qP5sD2rfFu+XmDakdruPmx7MV8vp/BM19S?=
 =?us-ascii?Q?pFOXoUG4wDS9SQN4+cVkm54zu/xtjF8LxcT0Wss0yZ2XtUR/JZKCzmc69hA8?=
 =?us-ascii?Q?VDEcgVRB9M5jgSSzeJ/yMXAxFwNp7kV7u32htFJK1vuFqVMcX5R396Vbc/Dn?=
 =?us-ascii?Q?BpfIL0rWgiw15bTMn+MnwrGfAjcg4gBaeZ+KG1JDGOufMhhmBGIYGTCegcGV?=
 =?us-ascii?Q?D228m1MOQQBjBXdGWh2xBR56za0pBCQ1lAsaC0hbEmC4CvatKa5SwVPDa+Hp?=
 =?us-ascii?Q?3adzIb7s5Aq4kJewp9qKTPI+1LzUQaXzUWFmYfEErZ7Mbn+F+3VKJa2jFPTy?=
 =?us-ascii?Q?VoKP0Ci5lT0enxlrNNR9uFRFLitHkE9AenAjs3gwUxMXCoBB7JRL+2Z4BqgC?=
 =?us-ascii?Q?9CFMKKC2pQWum/oGctxFL+0n/tuxV+5W379EU/zX3Ee4nSiX69J/GfI7ez/6?=
 =?us-ascii?Q?GcC/nZ+zvVmWbp25GVrCmRjrN+8wNQNhzltjO6rOsln+isRzKyZkJkFJTwqo?=
 =?us-ascii?Q?9dEl/lWgWDAbJ9Z8qUnWAySf01K8IdoyTUHcj5lDijbRQV38d8975q/RQaIR?=
 =?us-ascii?Q?6RkC2AJndGbkqRK4Ti1aDARvPKcjrWvyi9S6mGM3z2rPdqv95FPTAo0xtCVE?=
 =?us-ascii?Q?N3ozMPBJmBpjGw9DZax0LXzvG1niTSbc4lTZOIkUMJXHKL4J0tHxFgq4VNgx?=
 =?us-ascii?Q?sz5rcONr+oKfysOYFbYqnn47xkFCLg+yftoWzQSnQuu40u6pOjSpiUlHKd/L?=
 =?us-ascii?Q?i5+ShelvSFmQ8GAzSgz3VvK8hzcs1+p8eA2ua2XDoTYs60lgVr/JXsl8gr1g?=
 =?us-ascii?Q?lINxrV3WZFevab0JutRapAL6AuBdJSTvm6vWdNmwejN3ntVal0oHQf+WFOAu?=
 =?us-ascii?Q?D4lkqoIb/QAtMZMseQtUIy1wvJwhZez6ghqdN21VU3XA1nYkKcZhoaJcNUMc?=
 =?us-ascii?Q?Gjbs9JPKaFJRoucnn34/Ui/lgKKEKAGjOEYE3rOXDeRa7oTNeE23uhIP5Xa5?=
 =?us-ascii?Q?wu7xxJKXvjj0uMaHbuqd1Tj4/44ZeclCP2rmulDWEIsN8pj+yZQ+iPnWC6GS?=
 =?us-ascii?Q?RRbUJ6g9olWuFDSxTdwHD+L3MOAC2ORklD+ewnc7mKvz6yZ+isGlQAE6sGR4?=
 =?us-ascii?Q?dAvUSXdLahnY41vBdcBdf3jE+NHviEvl9eIrvBzu/fjFyId3n8Hnnjbtjto5?=
 =?us-ascii?Q?8PyFJ7+7sKYuxRU4xye1WfgYe0mwCkOpbK/UNk2s4WjZp+r13jyQCiTywmhg?=
 =?us-ascii?Q?57oldRufqcDL8PIA+1r4e5pGhKarUXTu4FW6I1T0lK/f05bthgU+SX2fcSeH?=
 =?us-ascii?Q?zwLcgatDXlHiBDX/E1US7a+oF/dOigEH+R9O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:20:20.4684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca93a262-2a2a-4bd7-39ca-08ddfa60e3ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

Extend the Secure AVIC (SAVIC) selftest to validate the injection of
Message-Signaled Interrupts (MSIs) from the host.

In SAVIC mode, the delivery of external interrupts, including MSIs,
requires explicit cooperation from the guest. For an interrupt to be
successfully injected by the hardware, the guest must first grant
permission by setting the corresponding vector bit in the 'ALLOWED IRR'
region of its private APIC backing page. If the vector is not explicitly
allowed, the hardware will drop the interrupt.

Add a new test case to Secure AVIC selftest that verifies this permission
model for MSIs. Verify that:

1.  If the host injects an MSI while the guest has not yet allowed the
    vector, the interrupt is correctly dropped and not received.
2.  The guest then updates the ALLOWED_IRR to permit the MSI vector. When
    the host injects the same MSI again, the interrupt is successfully
    delivered and handled.

This two-stage approach provides robust validation of the SAVIC MSI
delivery mechanism, ensuring both the blocking and permissive paths
work as expected.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/x86/savic_test.c | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index 3efefc1e69f5..1d9861949a28 100644
--- a/tools/testing/selftests/kvm/x86/savic_test.c
+++ b/tools/testing/selftests/kvm/x86/savic_test.c
@@ -22,6 +22,7 @@
 #define IOAPIC_NUM_LEVEL_VECTORS 2
 #define RTC_GSI	8
 #define RTC_GSI_IRQ 0x85
+#define MSI_VECTOR 0x40
 #define FIXED_IPI_VEC     0x31
 #define FIXED_LOGICAL_IPI_VEC     0x32
 #define BROADCAST_ALL_IPI_VEC     0x33
@@ -40,6 +41,7 @@ enum savic_test_state {
 	SAVIC_TEST_STATE(SAVIC_IDLE_HALT),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC2),
+	SAVIC_TEST_STATE(SAVIC_MSI),
 	SAVIC_TEST_STATE(SAVIC_IPI),
 	SAVIC_TEST_STATE(SAVIC_NMI),
 	SAVIC_TEST_STATE(SAVIC_NMI2),
@@ -57,6 +59,7 @@ struct test_data_page {
 	uint64_t ioapic_lirq1_count;
 	uint64_t ioapic_lirq2_count;
 	uint64_t ioapic_rtc_gsi_irq_count;
+	uint64_t msi_irq_count;
 	uint64_t fixed_phys_ipi_wake_count;
 	uint64_t fixed_phys_ipi_hlt_count;
 	uint64_t fixed_logical_ipi_hlt_count;
@@ -807,6 +810,34 @@ static void guest_nmi_handler(struct ex_regs *regs)
 		sev_es_nmi_complete();
 }
 
+static void savic_msi_not_allowed(int id)
+{
+	struct test_data_page *data = get_test_data();
+
+	savic_allow_vector(MSI_VECTOR);
+
+	__GUEST_ASSERT(READ_ONCE(data->msi_irq_count) == 0,
+			"Invalid MSI IRQ count: %ld, should be 0",
+			READ_ONCE(data->msi_irq_count));
+}
+
+static void savic_msi_allowed(int id)
+{
+	struct test_data_page *data = get_test_data();
+
+	__GUEST_ASSERT(READ_ONCE(data->msi_irq_count) == 1,
+			"Invalid MSI IRQ count: %ld",
+			READ_ONCE(data->msi_irq_count));
+}
+
+static void msi_intr_handler(struct ex_regs *regs)
+{
+	struct test_data_page *data = get_test_data();
+
+	 WRITE_ONCE(data->msi_irq_count, data->msi_irq_count + 1);
+	 x2apic_write_reg(APIC_EOI, 0x00);
+}
+
 static void ipi_guest_code(int id)
 {
 	struct test_data_page *data;
@@ -901,6 +932,9 @@ static void guest_code(int id)
 	SAVIC_GUEST_SYNC(SAVIC_IOAPIC, savic_ioapic);
 	SAVIC_GUEST_SYNC(SAVIC_IOAPIC2, savic_ioapic2);
 
+	SAVIC_GUEST_SYNC(SAVIC_MSI, savic_msi_not_allowed);
+	SAVIC_GUEST_SYNC(SAVIC_MSI, savic_msi_allowed);
+
 	SAVIC_GUEST_SYNC(SAVIC_IPI, savic_ipi);
 
 	/* Disable host NMI injection in control MSR. */
@@ -953,6 +987,17 @@ static void host_send_ioapic_irq(struct kvm_vm *vm, int id)
 	kvm_irq_line_status(vm, RTC_GSI, 0);
 }
 
+static void host_send_msi(struct kvm_vm *vm)
+{
+	struct kvm_msi msi = {
+		.address_lo = 0,
+		.address_hi = 0,
+		.data = MSI_VECTOR,
+	};
+
+	__vm_ioctl(vm, KVM_SIGNAL_MSI, &msi);
+}
+
 static void host_send_nmi(int id)
 {
 	vcpu_nmi(vcpus[id]);
@@ -968,6 +1013,9 @@ static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state tes
 	case SAVIC_IOAPIC2_START:
 		host_send_ioapic_irq(vm, id);
 		break;
+	case SAVIC_MSI_START:
+		host_send_msi(vm);
+		break;
 	case SAVIC_NMI_START:
 	case SAVIC_NMI2_START:
 	case SAVIC_NMI3_START:
@@ -1021,6 +1069,7 @@ static void install_exception_handlers(struct kvm_vm *vm)
 	vm_install_exception_handler(vm, BROADCAST_NOSELF_IPI_VEC,
 			guest_broadcast_noself_ipi_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
+	vm_install_exception_handler(vm, MSI_VECTOR, msi_intr_handler);
 }
 
 int main(int argc, char *argv[])
-- 
2.34.1


