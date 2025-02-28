Return-Path: <linux-kselftest+bounces-27860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E7A495F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DCB3AFCAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435E025A2B2;
	Fri, 28 Feb 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F6kRq+lI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64B25A2B3;
	Fri, 28 Feb 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736327; cv=fail; b=tdC/pUJL2QYKnsoQso2bXVFLYk2KKzAaJkZPXyDnm9ZjFxxgg8wmduWxetyaK59onXaNdu76vv7UpkCE+kam4foTFoiOXt9kdcSWqUDkSM/lxzZV4gRifI9oXF1xBHjaoZigQS3AOzTgoJ0FkzvYwehJYVuPvSIvqPizyKCmgVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736327; c=relaxed/simple;
	bh=byXX1hCFSvdZ8+GlqrxiBIpdijbztrBNOf9CgVFjjPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llGBwJPwxqy0Y3m4Eg7GVB86Gw/7g0rvnS0f3OSVqFVt7o4+B4uHlhcD2/nNJV1qxbFx+qDGw2/4Y1HzpnjftS1Dgo/BWlltEnzrWPQqxPhgYxs2hlIyUKA5gJWbJyLH1qZ4D5ctYwy4+fQhIgor0UHido5m5kO1iFGRsbUKXTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F6kRq+lI; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pn3OPr7hZXChLylgFEU77xYBWlyXz3ivCpGnCWHUOqUR9HrEjsMBYAwZu451b034SRDQDqeQp28spmzjA7o93g8Cap/wvrukZrF+z0tai12W4oHsfY7C3+8kQs1CpYAhkkRoJUigdzeClPfGnVj7iA2hZjZeV3BqMxLqf9Wk8BveVQHLttiL+iyd06FDAnrB8g7ch0ghRq5iJb8ZVU3TD7TdyIRcqMwi49pY0Z2VW1lO8E479kkbFoweLc2CAqyoABpafMSUru5uulyXSBjYNPjCTQq8P7nHB4Bc/hEzFVtvQFGCoqTx5ez9CoG8wIP/+ZSOpUo2ywISH0fG18OHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxsUGVbbPU9BDJOQXUr8QwQ4iQLDKX4Op/gU2WbUsHA=;
 b=xq6rFxrhjgVhlst0tTq9ra0+V6wZlEI0zraTXI4viTdZhhZTO/PwzaqUkKyow2YE3S4fxhrq27JRbp1NsVnVyXTcaIpd+EUUAxfz91NKNgCAY0E/uGpKRYK0/UEKgcui77ZR2hL7zIOwbNgjs9bzaL9dHQWFpveLZZIz03iSVuFM4Yb26V8+GCHWO9OUrkBAvktaHTSKsLplYPglwuvB/f+Xr8l4nG5hcvkRJz2hkbZgwc8AWq+0DZsZROJLUcTtkN7gzv6T0wyTzshnuux1lt0cd0e+GWWIKf0UDRG1JFp1cKavhAxaB5xhouJSAqQ5oM5C8Xmxivvxx0XHIEinvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxsUGVbbPU9BDJOQXUr8QwQ4iQLDKX4Op/gU2WbUsHA=;
 b=F6kRq+lIPI675shdK6mTX4nYBO28fpKF0s+CPDJ1eW0DXlGlphzd1FNdWy/zrEejtsrwwR+M1jZ8XGiWprMHT7xxyOw1Cglr34LxBgkkxN0Eb9DSimT7A7atVXl3/mXcmOC4dI3l2PEDt5OuovEnqayKOxQvYi8Fdc15BTdvVEo=
Received: from BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38) by
 LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 09:52:01 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::7c) by BYAPR01CA0061.outlook.office365.com
 (2603:10b6:a03:94::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 09:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:52:00 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:51:27 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 18/31] KVM: selftests: Add SEV VM support in xapic_ipi_test
Date: Fri, 28 Feb 2025 15:00:11 +0530
Message-ID: <20250228093024.114983-19-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8e252d-abc8-47c7-eeb6-08dd57dd8c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3e+XUTutKhT/0JtTVX9hjZsaKyUJtEE5ySLr0EGOQjAyG/lxY5EzgRpnUWsK?=
 =?us-ascii?Q?579E5+j9iV3E51w3XtjFZkOvmgo0deZJiPqzIPuiJfx6JY/5tewkXVjIMhFp?=
 =?us-ascii?Q?IwxPYid4SmNjtuW7tLsVPMYyfIerJjWad4kWHiKqN3JND6cOJVX0mZ3yMMC6?=
 =?us-ascii?Q?Vobk6hxADcfPKFhvxLVuUKjUUTxooTDNY3jFZAVAGSiLYJsuAraqvRJ8TChp?=
 =?us-ascii?Q?jW1+bZIXTMY9rAxs9bk+eB/zcMvxmGJdoJNrcgYQ7bXjpG8su61Cr+clOQbk?=
 =?us-ascii?Q?p925qrgkhD2L6Df/YhUTJ7LVFNEHWcrA3CL0btWzHIwZ88BLbMVeqzp9Tme9?=
 =?us-ascii?Q?+R6CWfqZQJVL+/0nQGubAHkrvDbkCw8z0A9zZP/6mDYZLUj3fdD4W2iZZAOB?=
 =?us-ascii?Q?SnO1Gz2pTN4hFHxxgjwdiVt+A6T4Fc7hbUcCs2n1WnMqG/WbDuwMZprZudDu?=
 =?us-ascii?Q?98KC+sywVa9IqIVmRHkDnNoKtrNaZvDU03aJ1/VbGAnw3EVaUpzCjjQnMg0m?=
 =?us-ascii?Q?L8W3jsfHSJvw8N0LZ7rj8WLcdyUhtZKzSH0q5ok1gKsLLxztEw2q8voozobm?=
 =?us-ascii?Q?6V1s+OzqYp42pve2Ob5+YLGtlx2LqVlMOYjuPb1GC60ECqMuJaAEgQwoFd0c?=
 =?us-ascii?Q?Bbe+Umg3NzklGsyysuHQOo82Vp2KOXp0dPIZIeUJqdSieWa7xMpqMsSKKUIa?=
 =?us-ascii?Q?4eIenlb4LpXxbuZeDuqLUPMUnIIQxf6Zyr4uF0J9eG7UK/uyhVnpIrmn3rTM?=
 =?us-ascii?Q?pJqaabwICTKkg6IUtxSdLm/keZr6ZAGFGT+K+MUzMrZCa+JMZqMNdBFL22mU?=
 =?us-ascii?Q?pW2Fb45d9rx0e7eUG/M7ja6l0x9O8rFwDZJwqrQq3MTCbIMz1uYUjtXruQlQ?=
 =?us-ascii?Q?qVQMfvzwmBLXkll/KovPFzVI7S8/cCZaVbvA7emgMTSwK9ql//mZfLNPVpXp?=
 =?us-ascii?Q?0LhlElvpvXf2yO3zve4vf8hNL4eGBh08rZd4Ta5A0BFhFD4jjA5O3D5UkqIR?=
 =?us-ascii?Q?iJeNPeYnbIR1ppohKzt2zOF9GIPwTNDLh6tgsfHOCPeOBck9PEPxNComjYHZ?=
 =?us-ascii?Q?6qUYCXLSsbpc6b8X0vj+geJJf06UK85sw2y67ssn7i4Gjpkeyzq3Tp6v1oYq?=
 =?us-ascii?Q?QBC3ifo/UDUQptxgxsqfss2YX+58fyqZ0RTTTsCzPMq+OD3U+IJvKffBoPJG?=
 =?us-ascii?Q?/MugqWmMI/z4/QAgEy9pFB39FMmgY4ZDERBh3AU7UH8deFFNaoMHumsfHIrp?=
 =?us-ascii?Q?2OsAMnbtEYCFpVqj56y14TgKMfpU4AtEh4RsuV7kBKbVys+O6SyND8+QXnn2?=
 =?us-ascii?Q?yiwxEhIa+oVpeDe99+oYaf1EXDOy+3uwdzqW3IuW/ahh1Hm7FKZxGCNxKI6U?=
 =?us-ascii?Q?BH+771nRmPW3N1xKbxk1GTq3FTTWuRYf1OvPRwaEvraTDhDjNjAygWU0Nei4?=
 =?us-ascii?Q?/2BXa06et0jvOAk0FjEyMNC0b9UojvN6BbSvTjhhOjLGcmzut5qc1C9yZWhY?=
 =?us-ascii?Q?zyLsCwme5wQD8i8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:52:00.6780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8e252d-abc8-47c7-eeb6-08dd57dd8c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

Add support to test SEV VMs - SEV, SEV-ES, SEV-SNP
in both xapic and x2apic modes. Convert the stats page
to a shared page so that it is accesible from host.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 19 ++++
 .../selftests/kvm/x86/xapic_ipi_test.c        | 94 ++++++++++++++++---
 3 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index bd963ff49bf0..a160e1ac7cbc 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -609,6 +609,7 @@ vm_vaddr_t vm_vaddr_alloc_pages_shared(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
+vm_vaddr_t vm_vaddr_alloc_page_shared(struct kvm_vm *vm);
 
 void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	      unsigned int npages);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 4f3240976f6c..34e586d4fec4 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1500,6 +1500,25 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm)
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
index 024514089766..3a54d828dc69 100644
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
@@ -141,7 +143,7 @@ static void halter_guest_code(struct test_data_page *data)
  */
 static void guest_ipi_handler(struct ex_regs *regs)
 {
-	ipis_rcvd++;
+	(*ipis_rcvd)++;
 	apic_write_reg(APIC_EOI, 77);
 }
 
@@ -175,7 +177,7 @@ static void sender_guest_code(struct test_data_page *data)
 
 	last_wake_count = data->wake_count;
 	last_hlt_count = data->hlt_count;
-	last_ipis_rcvd_count = ipis_rcvd;
+	last_ipis_rcvd_count = *ipis_rcvd;
 	for (;;) {
 		/*
 		 * Send IPI to halter vCPU.
@@ -200,19 +202,19 @@ static void sender_guest_code(struct test_data_page *data)
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
 
@@ -383,10 +385,10 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
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
@@ -403,6 +405,25 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
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
@@ -411,12 +432,39 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
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
@@ -431,8 +479,13 @@ int main(int argc, char *argv[])
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
 
@@ -441,9 +494,15 @@ int main(int argc, char *argv[])
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
@@ -451,8 +510,10 @@ int main(int argc, char *argv[])
 
 	params[1].vcpu = vm_vcpu_add(vm, 1, sender_guest_code);
 
-	test_data_page_vaddr = vm_vaddr_alloc_page(vm);
+	test_data_page_vaddr = vm_vaddr_alloc_page_shared(vm);
 	data = addr_gva2hva(vm, test_data_page_vaddr);
+	if (is_sev_snp_vm(vm))
+		vm_mem_set_shared(vm, addr_hva2gpa(vm, data), getpagesize());
 	memset(data, 0, sizeof(*data));
 	params[0].data = data;
 	params[1].data = data;
@@ -460,10 +521,15 @@ int main(int argc, char *argv[])
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


