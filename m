Return-Path: <linux-kselftest+bounces-42114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58096B945A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6C61900061
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90430F800;
	Tue, 23 Sep 2025 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yUBNWNel"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B730E820;
	Tue, 23 Sep 2025 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604611; cv=fail; b=W0667KoGhKmhrXwz+qoSIBx9NVLbMxgkSm7eEZXV/EWAIoHz3DDSJie8U5nkWOUo++GemRTzSLwiAkDzgX2PMTbOYWaJYPJdpbHlWH7Y54hl9NteE4xHNPiLF3vHbXkxfBvNBbWJNnZMKVoJm5WBPLU2BLaR8hZZq11VU0ERCZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604611; c=relaxed/simple;
	bh=0GNKsBw2jMJ+Il7KcQtZLcj6BMf4UVRyjykQi9cp888=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gi1BlrGIApGTpZOeegJ3M7fYXcSAHxs+rEbqkz9Hiu9/5pZirKMib70rkEaTw2M2DmZNc353GjoJ69ek8Rtt7ZrRSnwQPzuOeH73UmP5d3Fpk84IICkloxZkwmP5Yc86B4N01JCaSGR01lv1CeYHRaRcamXsbGR0ph0BFgKpgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yUBNWNel; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikWjD0Cmqu5rFN6kZLIfkaNnVZQXMIpZUEuMVxtMhtr6nQ0iM3yHlqIfJCeKWTYGuEhKxPn9Y8+ofLCrmyNO++6fUwjOEiXt7ScdunsQrEiIO+pGNfXz1gtwunqrmPdQVaLSR1iwTAeQkP8R+4BRg+Kq+OY7n4GOnPtkqu5y1VNLJHmX9rM9QyHWtGba/zDa9lP2hZc6uAdsvSMl1sTqOYQUQ6IVtZLThM3fwxNwgYegiIbug335pXOC++bvCgYNHfzDbL4dPYVZU8MgRmWpZYabGOhBVCJcTAmRi8wKRddwQ5NEiSXvtRCjzgu96abT0Vo7PiIqfqyEdFPYyDsP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25fTTBu+HG56NMeQ8yEb2vfjcwFsA/5AIv+xU4n1xYE=;
 b=vKlCAE/FkSKrNYQYd3QF3OMAqd8fOsTEBQUfy7sA3HAyEf0B3I528YSGnNlEUCZ7/12CxMiInRVjEJK8ggQ9xAnSCW9vYrSpoKQA4II/sKoWaDo/8MtxUzORJ9JTylXr7YjMtz8IXmKqY2K17kZjKvVNNv1PXd8ZWqwN+C0TuFOwY40VCivpNpUB3g3jm288UtFK1K95oUqapDEkIsMxoV/yDjdtBl3DJoLm6tXnSwev9faE4dCBiJ9bkF5JpFcwa8Moy9htCln3NQ1D0hWrC4MT1nequ0tFH0LIsjt5feQGFqkAtjvbZpwkpAZ2n5mGPjguHIhvdkvqgV7jqlr72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25fTTBu+HG56NMeQ8yEb2vfjcwFsA/5AIv+xU4n1xYE=;
 b=yUBNWNelzexXDNsoL0mabLSPG4ZPPokUmEP0JQxrrOHTVjVe8pOyqK3KsBBbJuIb3zTt9PitiVO4LVFyO/K1oKI3Nz4DnQJMPLNvpT982vWf6/bH2RdCwaLJCs2GFEJhETuaJzyoivbW8jj9eWLfvpBwh+5Rn6nOJO7uhjyz+lw=
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:16:44 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::58) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 05:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:16:43 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:16:38 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 23/35] KVM: selftests: Add SEV VM support in xapic_ipi_test
Date: Tue, 23 Sep 2025 10:39:30 +0530
Message-ID: <20250923050942.206116-24-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e17d328-98f9-4626-da24-08ddfa6062f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V1roi9ISw010DgcACoyxDPDMuP2KW9QEMydWKHZ5aHCeiSEUkkAEiRZrFt8p?=
 =?us-ascii?Q?BiqmCI5L6jvRTOUjDhEdoA+q3nTgEx4SF5DFWIOQ8jYmotA7EsFFoJjygO3l?=
 =?us-ascii?Q?dEjo8AalzfMqSfyjZm9Zc2ziP6In/y1hhIdiR2gUCJC4qjKPgaM2kgjL/xUR?=
 =?us-ascii?Q?wy6sXWImyaGf9eflEAs9SrMGBiM2mIMpNAT/r8IN9x8Lrwu0/l3UTkvaRDPS?=
 =?us-ascii?Q?A/sXXPxBQck3MyYjrUopeArJx3aITL1o93yEO5JNy6xA/P5fVoypfrhW1yRx?=
 =?us-ascii?Q?XASP1UGp/+e62Nhv3mQMDrDG1CFydTpU3lvxgRPil1dM6zyar77TpUwRNMTw?=
 =?us-ascii?Q?sw35N92DF84IyoaFuEBY4PKDk7sj9Hk/MNpEM1USBjS9c0uDqFm8q+Tnwsqn?=
 =?us-ascii?Q?VF3SBU39Iq4xlZ1rNNB/NL+LDEQy51YUoZ2UAS0ZeIjnwizQTekT8ujLfwUu?=
 =?us-ascii?Q?N1qbedlTK6y4J/eZ5wK09CnG7nkXqawHn8wMqZc11mlrl/wWDhZ9pyoWww7B?=
 =?us-ascii?Q?eA7+45lT72DPPHpx2pLQnwsxieoWkpur6AlH+Q0FDrqBM70eCDs98IYFn7nW?=
 =?us-ascii?Q?yxQRHpd7ZJJpRkc7cnwmjjS5kzZRhsHXfgN+0ZH71WLLFKFnaeCK52HxzFtq?=
 =?us-ascii?Q?WzKmFQntyI8OM6/VheGLRr6bpAOCwMqpPeWaPY/6NewQxp3hYCgMpiLHGKU/?=
 =?us-ascii?Q?DRFkCk7T6v51OPrJ/1OPVXBD5GflQEruk1qh5QrYMrQ9A+5Sev/xu+U0AyjV?=
 =?us-ascii?Q?h4zZg+DghVW++1B+b2OoiHJMmPUdgehKWubxiGtv7TKZstzB/V6Yjhi2Wds9?=
 =?us-ascii?Q?Gb29hk/devlMHMq6gpLIseh2XJauDRJRf20dfZjn5EyOVto2eLPPdrZzSop3?=
 =?us-ascii?Q?tfjVOY028vNVzVU4ApJmJegGv2VhOBy5OC6s2KgPwxooU8pSzmno8i39Ah8t?=
 =?us-ascii?Q?dMmPqv8tkPwV3cXfDNP1QwMFRYKdzyi4j5XhFX/otBU3QGEwsnjREiDPT7Hz?=
 =?us-ascii?Q?jR2txDBbQfqOk7HF1prLHSxBEOW2PaUEYDUrz121/h6MYFPUQBLVCFHC6Lzs?=
 =?us-ascii?Q?7npP1UnZQRQboQX2H19wo8TW3Ag0v4gmVcoRyQd+pnQXKDUyubVlJSpZWnww?=
 =?us-ascii?Q?gT8VsdrIhLEAlv24qs8fvI8abguWT8g4z1J+WiFPQOo3ELIbEbvKmXjSnONB?=
 =?us-ascii?Q?X5COXj82DXs3slfdr46W7ipRW0kXR4lcHSDd9oVmKFHUNhM6lZmUM5DFqLMQ?=
 =?us-ascii?Q?7XV8kYD4a5v6GWd4+vq5VOnFDkkSXvdCCES7TLnHtfjwAofQfMVwF4MAly7F?=
 =?us-ascii?Q?4UpN4pNVlMP5IP5D5zgvpMthtNFE669Kary5t2bXlSXldloIrkX9KMINZrz4?=
 =?us-ascii?Q?sMpyzgolLmzi9KYdsqvjFP/7Jh2vxEfhiz7VByNVvvxn3uVsZtQ8W7rnp9fc?=
 =?us-ascii?Q?vPeqWEeCdxsDZFl6mVKoCvDx2sR9le4+RDQKD5uupInrD9jhbjU7tlaRQs2V?=
 =?us-ascii?Q?jYwy6mxAT7JjSDah5jvo1CdU8a8wdZIuwwQc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:16:43.9817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e17d328-98f9-4626-da24-08ddfa6062f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

Extend the xapic_ipi_test to support SEV, SEV-ES, and SNP guests.
This is important for validating IPI functionality within confidential
computing environments. The test now works in both xAPIC and x2APIC modes
for these encrypted guest types.

The test now uses SEV-specific VM creation and launch helpers when
an encrypted guest is selected. For SEV-ES guests, install the generic
for xAPIC mode to function.

In an encrypted guest, memory is private by default and inaccessible
to the host. To allow the host to monitor guest activity, convert the
page used for statistics (test_data_page) to a shared (unencrypted)
memory region. Add a convenience wrapper, vm_vaddr_alloc_page_shared(),
to simplify the allocation of a single shared page.

With these changes, the IPI selftest can now provide comprehensive
coverage across both standard and confidential VM types.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 19 ++++
 .../selftests/kvm/x86/xapic_ipi_test.c        | 94 ++++++++++++++++---
 3 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2e27682c5077..4a4f9621082d 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -700,6 +700,7 @@ vm_vaddr_t vm_vaddr_alloc_pages_shared(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
+vm_vaddr_t vm_vaddr_alloc_page_shared(struct kvm_vm *vm);
 
 void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	      unsigned int npages);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 00317ce5dbb9..360f262f5f3f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1592,6 +1592,25 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm)
 	return vm_vaddr_alloc_pages(vm, 1);
 }
 
+/*
+ * VM Virtual Address Allocate shared Page
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Starting guest virtual address
+ *
+ * Allocates at least one system page (in shared state) worth of bytes within the
+ * virtual address space of the vm.
+ */
+vm_vaddr_t vm_vaddr_alloc_page_shared(struct kvm_vm *vm)
+{
+	return vm_vaddr_alloc_pages_shared(vm, 1);
+}
+
 /*
  * Map a range of VM virtual address to the VM's physical address
  *
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index e7dcf4bc0350..3d49f7798dcc 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -30,6 +30,7 @@
 #include "processor.h"
 #include "test_util.h"
 #include "vmx.h"
+#include "sev.h"
 
 /* Default running time for the test */
 #define DEFAULT_RUN_SECS 3
@@ -48,7 +49,7 @@
  * Incremented in the IPI handler. Provides evidence to the sender that the IPI
  * arrived at the destination
  */
-static volatile uint64_t ipis_rcvd;
+static volatile uint64_t *ipis_rcvd;
 
 static bool x2apic;
 
@@ -93,6 +94,7 @@ struct test_data_page {
 	 *  to determine whether APIC access exits are working.
 	 */
 	uint32_t halter_lvr;
+	uint64_t ipis_rcvd;
 };
 
 struct thread_params {
@@ -142,7 +144,7 @@ static void halter_guest_code(struct test_data_page *data)
  */
 static void guest_ipi_handler(struct ex_regs *regs)
 {
-	ipis_rcvd++;
+	(*ipis_rcvd)++;
 	apic_write_reg(APIC_EOI, 77);
 }
 
@@ -176,7 +178,7 @@ static void sender_guest_code(struct test_data_page *data)
 
 	last_wake_count = data->wake_count;
 	last_hlt_count = data->hlt_count;
-	last_ipis_rcvd_count = ipis_rcvd;
+	last_ipis_rcvd_count = *ipis_rcvd;
 	for (;;) {
 		/*
 		 * Send IPI to halter vCPU.
@@ -201,19 +203,19 @@ static void sender_guest_code(struct test_data_page *data)
 		 */
 		tsc_start = rdtsc();
 		while (rdtsc() - tsc_start < 2000000000) {
-			if ((ipis_rcvd != last_ipis_rcvd_count) &&
+			if ((*ipis_rcvd != last_ipis_rcvd_count) &&
 			    (data->wake_count != last_wake_count) &&
 			    (data->hlt_count != last_hlt_count))
 				break;
 		}
 
-		GUEST_ASSERT((ipis_rcvd != last_ipis_rcvd_count) &&
+		GUEST_ASSERT((*ipis_rcvd != last_ipis_rcvd_count) &&
 			     (data->wake_count != last_wake_count) &&
 			     (data->hlt_count != last_hlt_count));
 
 		last_wake_count = data->wake_count;
 		last_hlt_count = data->hlt_count;
-		last_ipis_rcvd_count = ipis_rcvd;
+		last_ipis_rcvd_count = *ipis_rcvd;
 	}
 }
 
@@ -384,10 +386,10 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 }
 
 void get_cmdline_args(int argc, char *argv[], int *run_secs,
-		      bool *migrate, int *delay_usecs, bool *x2apic)
+		      bool *migrate, int *delay_usecs, bool *x2apic, int *vm_type)
 {
 	for (;;) {
-		int opt = getopt(argc, argv, "s:d:v:me:");
+		int opt = getopt(argc, argv, "s:d:v:me:t:");
 
 		if (opt == -1)
 			break;
@@ -404,6 +406,25 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 		case 'e':
 			*x2apic = parse_size(optarg) == 1;
 			break;
+		case 't':
+			*vm_type = parse_size(optarg);
+			switch (*vm_type) {
+			case KVM_X86_DEFAULT_VM:
+				break;
+			case KVM_X86_SEV_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
+				break;
+			case KVM_X86_SEV_ES_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV_ES));
+				break;
+			case KVM_X86_SNP_VM:
+				TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SNP));
+				break;
+			default:
+				TEST_ASSERT(false, "Unsupported VM type :%d",
+					    *vm_type);
+			}
+			break;
 		default:
 			TEST_ASSERT(false,
 				    "Usage: -s <runtime seconds>. Default is %d seconds.\n"
@@ -412,12 +433,39 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 				    "-d <delay microseconds> - delay between migrate_pages() calls."
 				    " Default is %d microseconds.\n"
 				    "-e <apic mode> - APIC mode 0 - xapic , 1 - x2apic"
-				    " Default is xAPIC.\n",
-				    DEFAULT_RUN_SECS, DEFAULT_DELAY_USECS);
+				    " Default is xAPIC.\n"
+				    "-t <vm type>. Default is %d.\n"
+				    "Supported values:\n"
+				    "0 - default\n"
+				    "2 - SEV\n"
+				    "3 - SEV-ES\n"
+				    "4 - SNP",
+				    DEFAULT_RUN_SECS, DEFAULT_DELAY_USECS, KVM_X86_DEFAULT_VM);
 		}
 	}
 }
 
+static inline bool is_sev_vm_type(int type)
+{
+	return type == KVM_X86_SEV_VM ||
+		type == KVM_X86_SEV_ES_VM ||
+		type == KVM_X86_SNP_VM;
+}
+
+static inline uint64_t get_sev_policy(int vm_type)
+{
+	switch (vm_type) {
+	case KVM_X86_SEV_VM:
+		return SEV_POLICY_NO_DBG;
+	case KVM_X86_SEV_ES_VM:
+		return SEV_POLICY_ES;
+	case KVM_X86_SNP_VM:
+		return snp_default_policy();
+	default:
+		return 0;
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	int r;
@@ -432,8 +480,13 @@ int main(int argc, char *argv[])
 	struct thread_params params[2];
 	struct kvm_vm *vm;
 	uint64_t *pipis_rcvd;
+	int vm_type = KVM_X86_DEFAULT_VM;
+	bool is_sev;
+
+	get_cmdline_args(argc, argv, &run_secs, &migrate, &delay_usecs,
+			 &x2apic, &vm_type);
+	is_sev = is_sev_vm_type(vm_type);
 
-	get_cmdline_args(argc, argv, &run_secs, &migrate, &delay_usecs, &x2apic);
 	if (x2apic)
 		migrate = 0;
 
@@ -442,9 +495,15 @@ int main(int argc, char *argv[])
 	if (delay_usecs <= 0)
 		delay_usecs = DEFAULT_DELAY_USECS;
 
-	vm = vm_create_with_one_vcpu(&params[0].vcpu, halter_guest_code);
+	if (is_sev)
+		vm = vm_sev_create_with_one_vcpu(vm_type, halter_guest_code,
+				&params[0].vcpu);
+	else
+		vm = vm_create_with_one_vcpu(&params[0].vcpu, halter_guest_code);
 
 	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
+	if (is_sev_es_vm(vm))
+		vm_install_exception_handler(vm, 29, sev_es_vc_handler);
 
 	sync_global_to_guest(vm, x2apic);
 	if (!x2apic)
@@ -452,8 +511,10 @@ int main(int argc, char *argv[])
 
 	params[1].vcpu = vm_vcpu_add(vm, 1, sender_guest_code);
 
-	test_data_page_vaddr = vm_vaddr_alloc_page(vm);
+	test_data_page_vaddr = vm_vaddr_alloc_page_shared(vm);
 	data = addr_gva2hva(vm, test_data_page_vaddr);
+	if (is_sev_snp_vm(vm))
+		vm_mem_set_shared(vm, addr_hva2gpa(vm, data), getpagesize());
 	memset(data, 0, sizeof(*data));
 	params[0].data = data;
 	params[1].data = data;
@@ -461,10 +522,15 @@ int main(int argc, char *argv[])
 	vcpu_args_set(params[0].vcpu, 1, test_data_page_vaddr);
 	vcpu_args_set(params[1].vcpu, 1, test_data_page_vaddr);
 
-	pipis_rcvd = (uint64_t *)addr_gva2hva(vm, (uint64_t)&ipis_rcvd);
+	ipis_rcvd = &((struct test_data_page *)test_data_page_vaddr)->ipis_rcvd;
+	sync_global_to_guest(vm, ipis_rcvd);
+	pipis_rcvd = (uint64_t *)addr_gva2hva(vm, (uint64_t)ipis_rcvd);
 	params[0].pipis_rcvd = pipis_rcvd;
 	params[1].pipis_rcvd = pipis_rcvd;
 
+	if (is_sev)
+		vm_sev_launch(vm, get_sev_policy(vm_type), NULL);
+
 	/* Start halter vCPU thread and wait for it to execute first HLT. */
 	r = pthread_create(&threads[0], NULL, vcpu_thread, &params[0]);
 	TEST_ASSERT(r == 0,
-- 
2.34.1


