Return-Path: <linux-kselftest+bounces-27873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5AA496B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7337E3B6DB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195925D20E;
	Fri, 28 Feb 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yj1dZH6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AE425CC8A;
	Fri, 28 Feb 2025 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737355; cv=fail; b=gOHsU7cepp4BAIA7dcMk4V1w9ZSDg9YGZ1dFz0DPDZ7pQmlqGKP4Pmm8GEyXrIuH0YwUOuLJg9DUhlPPWnUML309q2PXHDpwY9OmLHlFOdlJwSFAe1ljZQz2fS8V+obDoAuX2Gm/SMIpR/kEmCSecTcq6xvHdZhh+OIgvu/QQak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737355; c=relaxed/simple;
	bh=DWGi1BO6ForlXj4A/5BWgACRpoLVHgd/j3syLuJScPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvukDuT9VLFRdGpP0XBooWAOCECfhQofwScabINDQ/JfleHgElhYqDPx0eP5wd9nm/PMU3fs4FpI6lKG7C8OH12kLNw2T4EHRLDOgmSnKTlmaop5OXuXfm8x0EFofr8acLKRouGKEbehq+/vFtd0gfGtmnBnARVnWSLWmzSe8Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yj1dZH6V; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgeNs7M5h22Sf6aoOJHm3vSyT8S8M3FRyoe7Dc2RkIzYGyRPc3YlBRZqC5SpsUi0GkMD7NL7UETrHLsB/vKYL09YGeUMfUrcPI7lYk24QviSOC7i0vfMAsbgyN0TDQSxQD+pMXbMFPpAEkznTYCcRLO+rvZTohzUXI31IP2bNcZe87L9sr2+07qe5qddwPHlxjgGGzu06m5JLIn5XdnOIizhrb4RKYy4CEg7QWS48gRntcgVqSOLF+GGYyLf+Tnh7flOq5S0hDZKUix928n/d7WektumrD2d8QZthY+LpOK0S/QePBbrJF99Oc5inGuvjuY6gRFSFzKCfAFq3R/t0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQlXv1nAtP4EGf9PChKWyAyGqPo/OaHIY5vhj+fK1Zk=;
 b=wI6cxbzf2+Wmz7/zIO5KZmfBtYnLFyNpOejVQ8lhhzFb/NsU+Jmh8/usIeUr5OmEtKZxyk2lQK/uCVCOkwNXFSxbA+M+jAbDQM0KWCr+4Um7PfHJJk6u4i+1mgBFMj+ziaL9s6P6RcIraJ+wn5/8taK1eGJF8Vj7hzGjZg5C4aJqam1+aP70fufO9gMNkgBYDcTAXSsWfB5tuAGwp2dKarEB/GG0s4KiCZNIP5xGHHKIazk3PfXXJdTAYoY20z2iHh2o49IiVxbi0zJkQIiNQ6Le+37s9sRUrDqBZop17TgTPhqBpwS98deeh+Ca1xLf4XZsRwgHgercjDY8UVUuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQlXv1nAtP4EGf9PChKWyAyGqPo/OaHIY5vhj+fK1Zk=;
 b=yj1dZH6VgpmkQoMcbq/GLXvmoW+GwNITV0j+0yG20AMwaZ49Kl5i9hIo7Izdb3IogJ8uUkbaHbr5cDkK8xIgFOPNOPOfJMEazAbscOyjDyuyjO5xhBGkMdZ9Xzbg7pIm9lb04JCJa8DedfUZSPm0EhA1XVZY0+zgZYZLJ8JRFL8=
Received: from DS7PR03CA0156.namprd03.prod.outlook.com (2603:10b6:5:3b2::11)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:09:11 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::d) by DS7PR03CA0156.outlook.office365.com
 (2603:10b6:5:3b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 10:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:09:11 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:09:00 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 31/31] KVM: selftests: Add MSI injection test for SAVIC
Date: Fri, 28 Feb 2025 15:00:24 +0530
Message-ID: <20250228093024.114983-32-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: eccdf399-7d80-4313-4aa1-08dd57dff26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+tfFX493r2HFPGmMVvber2G6QqZXrOIz2zrB7eQKfhPniawROpgfWsNf+PLQ?=
 =?us-ascii?Q?NEtW7kKDWAZMuD0A8JaE9YyTQfwI5VPtyi/QUpdhj9G57FfcqQtgITZtT7uU?=
 =?us-ascii?Q?gBkD0NSY80O0d7OJAcXkNDwZYPFYy13r+AD3RWGzXroM3w9oULTR5y/H/U2T?=
 =?us-ascii?Q?LS1r4PJkvD9iqrQA10EWwj6mRvTqjzMnhguP8eDoK+H318XzWVSOUd+kISa+?=
 =?us-ascii?Q?3XKwDpYvZn0lntYrJW9zj11RlG2wfNY4J0kUlijp8t0HCd2lfR/YfJJ+DOzf?=
 =?us-ascii?Q?hChXAzmkFhggamqXHMMxjiIKViGbLWzEja0BWnLxJ2/LdTFetbjsD+zeFrtT?=
 =?us-ascii?Q?xt7kKq6f0iT8in+zz+Sce2G+JREqOgnvTxITPI/iKj53t7yq2k+dOCm7FzUV?=
 =?us-ascii?Q?nT5yxnDZfSu8cbAOnl3INdCCHTcWEmCHcAUsUQBZuNU7OYlFW6lUbE+ftuKs?=
 =?us-ascii?Q?VhJ4Df6Sd5IpVH0fttVOuKkBD4UzxCC27RBDJ3aPC4BBP1ot46hQHZJNJHHN?=
 =?us-ascii?Q?79h2amf14aj7qA5NaTPIOODQn2B4Jcdscx1j4licwHpkqfc6u2sqkeoVgEAe?=
 =?us-ascii?Q?qoTeM2d+CjAUSfg+nvfyNZUWAZFcxmpfUuLwOsyXBYmmEbgPyF9+r0s+Dk3p?=
 =?us-ascii?Q?SNTCIfos6H8+yp9JFzBK6ab9AemkR0qz2k57yKqcI0e75cHHMSBWir5l9uIM?=
 =?us-ascii?Q?QlXaCC8qHQvD0ug1QjEotRWCaMG26C+zpoeOfzBIGlYThJlZhEwpx4COt2gy?=
 =?us-ascii?Q?P0iKCGcf5Nw5mkavjShEfZaCD3hElZuE+ZPaH6pCuh4vMJhATgPXh4bTySus?=
 =?us-ascii?Q?w4zIFK0bH3C9E1tBrZnyMQOeLzRYm29a2Dto5d+vAX5WthBXzukmbKnvkeAk?=
 =?us-ascii?Q?zeLoatH3GbjgdCeql/2WDztAY0HNx1oZJn+c4EUJTii/H3wyVz8N8AZFLV86?=
 =?us-ascii?Q?ogmnMAcw6FONAfYiSd+mhcWLzlsRhgyn49dUOI28LwVvf4VfSIuyv2NBstND?=
 =?us-ascii?Q?uZLwfG6Yz8HAY6Ky75HC2lI9lZkTEnxEEglVT0dyimqhfHcmis04TQN1dooc?=
 =?us-ascii?Q?Tjpvic/pOCMOyratdd61n3FU1uBwNk0yDx9hNPCIYLWpZXGO/n0kvv22xgR2?=
 =?us-ascii?Q?RZXjVwlsmbf7KCUCWrPYyozNd6HMnfBT2OHCgC6TABiBp08nR5ImpJshNzh1?=
 =?us-ascii?Q?xdKqmXzyjxULcEinWy6mhhfg0W+Uv+8fjvqzaVsF21dFKU328YdF4iLNc6Tp?=
 =?us-ascii?Q?19DjJbNvYjzqnrfH5x3uco899oGOXcsrAvNfZIqaDSrXTgHqMkdsDLRZL6Fm?=
 =?us-ascii?Q?8bDctbTh1RbX0tkEwBUzxqMqlFMC5rasZuLvO9C15fplJpFck+i4TYMKoIrM?=
 =?us-ascii?Q?eZN8WpYp3rI2dBa7WnpuJfC79COX3syksmhfQ7x7S7qTNN7parVs6ZDn3hsz?=
 =?us-ascii?Q?REvRkwvWXEWBUSc56kXTZHL7LUlxw9/77MKBfUZ5/CIi2140Q/brESRmOBFd?=
 =?us-ascii?Q?yFpzlpXRpw5QhUA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:09:11.2072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccdf399-7d80-4313-4aa1-08dd57dff26a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

Extend SAVIC test include MSI injection from host.
Test scenarios where MSI vector is not allowed by
guest in ALLOWED_IRR and when it is allowed.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/x86/savic_test.c | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/savic_test.c b/tools/testing/selftests/kvm/x86/savic_test.c
index 277ee18a0cbd..edb355e9df42 100644
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
@@ -46,6 +47,7 @@ enum savic_test_state {
 	SAVIC_TEST_STATE(SAVIC_IDLE_HALT),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC),
 	SAVIC_TEST_STATE(SAVIC_IOAPIC2),
+	SAVIC_TEST_STATE(SAVIC_MSI),
 	SAVIC_TEST_STATE(SAVIC_IPI),
 	SAVIC_TEST_STATE(SAVIC_NMI),
 	SAVIC_TEST_STATE(SAVIC_NMI2),
@@ -135,6 +137,7 @@ struct test_data_page {
 	uint64_t ioapic_lirq1_count;
 	uint64_t ioapic_lirq2_count;
 	uint64_t ioapic_rtc_gsi_irq_count;
+	uint64_t msi_irq_count;
 	uint64_t fixed_phys_ipi_wake_count;
 	uint64_t fixed_phys_ipi_hlt_count;
 	uint64_t fixed_logical_ipi_hlt_count;
@@ -1064,6 +1067,34 @@ static void guest_nmi_handler(struct ex_regs *regs)
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
@@ -1164,6 +1195,9 @@ static void guest_code(int id)
 	SAVIC_GUEST_SYNC(SAVIC_IOAPIC, savic_ioapic);
 	SAVIC_GUEST_SYNC(SAVIC_IOAPIC2, savic_ioapic2);
 
+	SAVIC_GUEST_SYNC(SAVIC_MSI, savic_msi_not_allowed);
+	SAVIC_GUEST_SYNC(SAVIC_MSI, savic_msi_allowed);
+
 	SAVIC_GUEST_SYNC(SAVIC_IPI, savic_ipi);
 
 	/* Disable host NMI injection in control MSR. */
@@ -1313,6 +1347,17 @@ static void host_send_ioapic_irq(struct kvm_vm *vm, int id)
 	}
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
@@ -1346,6 +1391,9 @@ static void host_test_savic(struct kvm_vm *vm, int id, enum savic_test_state tes
 	case SAVIC_IOAPIC2_START:
 		host_send_ioapic_irq(vm, id);
 		break;
+	case SAVIC_MSI_START:
+		host_send_msi(vm);
+		break;
 	case SAVIC_NMI_START:
 	case SAVIC_NMI2_START:
 	case SAVIC_NMI3_START:
@@ -1399,6 +1447,7 @@ static void install_exception_handlers(struct kvm_vm *vm)
 	vm_install_exception_handler(vm, BROADCAST_NOSELF_IPI_VEC,
 			guest_broadcast_noself_ipi_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
+	vm_install_exception_handler(vm, MSI_VECTOR, msi_intr_handler);
 }
 
 int main(int argc, char *argv[])
-- 
2.34.1


