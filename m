Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9870477A5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhLPRRz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:17:55 -0500
Received: from mail-mw2nam08on2077.outbound.protection.outlook.com ([40.107.101.77]:20673
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233283AbhLPRRz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:17:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi3HsjOjolUKsJTDZgYBXUc1YOhDX0wTsnQLvDCVV3R27tFrCG8UDhVOsH7JC0frD1BIsRHWP+xe7XyEy6TIDUVSevMHLXJXou0yy7eEgHW6V8SGJcMoZrQ2ZNPblT94oH2UiAzm6e3mZb2SZL2WZnp1CqK3wUOZWuFlBNtwEVerwz+zY7ErSN1QQS4pQfBux6gclFrAXl1uC3stJghr49JCYcNqwJgcCNEKZIv5kRFKxeS4tQUQuN8uioRDWQ2NMmgVjaow6WAVTEAgzAJO48ILx/vsV+8iBJF39tZhn+pR+hGkN8BPv0WyOG6Jak9a8EPD5j4iOdX1YAID4Zd0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwkCJV5Xk6eoK4V21lSuyxRo+ySGxbX5zj3DamCXA2k=;
 b=ftPf+vK2glsQBXjsBvf1H4ObZ5ZUgzuWZ/FCSeLK4Y/3koQlF7eK0FwjTknNPzoFlrRQUBK3wlD17QT6irsqONYZzYjSFThUxDVy29HxgCr5lT7cfPEAjTlumJPctRy1pXbhD9QFzT/6mWh+QIT8CHwidiGrvBYarBPmIWXlCKYZqXfSILPtDJXDREIpoFLWzQnmJi+yWuF0fNkRSAnGs0LIerPHMrY2b24c5Twwk1DkMUj+taF6RtFWKQs4O/ZsAVy4L67SFYpI9hJq1Rxo0F0mw68l71HtyCIvxn9lMiAi6TdR3U9Y7doWEfhrOsitl/lDxtvaT2XomIUfsysg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwkCJV5Xk6eoK4V21lSuyxRo+ySGxbX5zj3DamCXA2k=;
 b=gS37Tc64PqVF1ZCyLEi5Tj3zgtFpWYT+coiRxj06pgRqIRgx9wjm4S4gaWDlo2JmSySl3uLG2lx8GpIaZF5iUKgX7CTNt5SW9Bpbm3RY+CGG/5kKXmBXHmfZ7Id+EPlVxhKA134AS+Epx07tilr6rvJgOrVbwoVRKMSJYX2MwzY=
Received: from CO2PR04CA0125.namprd04.prod.outlook.com (2603:10b6:104:7::27)
 by SN1PR12MB2462.namprd12.prod.outlook.com (2603:10b6:802:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 17:17:43 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::db) by CO2PR04CA0125.outlook.office365.com
 (2603:10b6:104:7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 17:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:17:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:17:41 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        "Steve Rutherford" <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: [PATCH v2 04/13] KVM: selftests: handle encryption bits in page tables
Date:   Thu, 16 Dec 2021 11:13:49 -0600
Message-ID: <20211216171358.61140-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216171358.61140-1-michael.roth@amd.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb94c27c-c8c9-45f5-aec3-08d9c0b7f85d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2462:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2462664FC1F83D5A6746104095779@SN1PR12MB2462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4R4H31goaCIb3lcy0VlgXIvio60qbLab7LIujHW9/Hgiaf1ecyB96ptHVCDJO9tR70JbM2Ew3utvbLewwCqnJqFJX50cIsoga7M0JTGMeh5oTxTwJkoKYtXYITWCv9AQc0X8LeJnvNd/AfrqNrbGT3rARsYRjAspuFrWLO471/dZK6qGLc98DH+WSGZ3uc8xd0mI4wM/WH5vrkX+5A7yt5PAk5IRmQ/YNpeN8G5lIgWyKNHeE0RPfKTr+DJnJqg4pmMaqXs6Qrt7C9egK2pK/MPM+QtEssbzrCP+aZFJiEVUvtzqq7EIQJQXyW4Ixopn+HNOL6SaBWi8ucgwh8aymFBzZikUIcEP7oMt8UO+m/fAhKisxxeSehxZO/kgpCEMtWNIngf/h5YQ/BbBi5p7qHyUs4MGaQzxMxb0Ors4t+hifrM886Qadnu2t2HX7lbcWspxcqR+vXc2TTmTLqbTsLd7tNtKfFpOU0LxYt/jFut2OyczylkaVq2bEau5kebnhFz/4gwmWhuUnrdyd5savJRAoDCuCCuvViEGWihubEMBwKTFNffQIkYxp3Etz0wegimsKUqLXpoybEZ7VWgMAZ4TYYFESw8NoELYeHI1VUluJvezyfDEFo5cJJp7YwvmJRBaR1eQxQVcvo1apP9aMxIo8Lqj8ysy9w+O8wjFeY29cXBWJVSKSVQA9JR4s9BJ7yIrBdBLDRRxW9X6zmJ36P/lVkdUAEtb7OifJXRkd2OYfNMX0df/6nG4atELt8WPzYGB6SORgxEPQAaIKgzzBuqV2+ifs9sHPn46wd0U5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(81166007)(1076003)(8676002)(7416002)(26005)(40460700001)(82310400004)(54906003)(4326008)(36860700001)(186003)(47076005)(5660300002)(2906002)(70206006)(16526019)(36756003)(8936002)(336012)(356005)(508600001)(83380400001)(70586007)(426003)(6916009)(86362001)(316002)(44832011)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:17:42.6510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb94c27c-c8c9-45f5-aec3-08d9c0b7f85d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2462
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SEV guests rely on an encyption bit which resides within the range that
current code treats as address bits. Guest code will expect these bits
to be set appropriately in their page tables, whereas the rest of the
kvm_util functions will generally expect these bits to not be present.
Introduce addr_gpa2raw()/addr_raw2gpa() to add/remove these bits, then
use them where appropriate.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 55 ++++++++++++++++++-
 .../selftests/kvm/lib/x86_64/processor.c      | 16 +++---
 3 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 58856339210a..005755837aa2 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -155,6 +155,8 @@ void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
 void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
+vm_paddr_t addr_raw2gpa(struct kvm_vm *vm, vm_vaddr_t gpa_raw);
+vm_paddr_t addr_gpa2raw(struct kvm_vm *vm, vm_vaddr_t gpa);
 
 /*
  * Address Guest Virtual to Guest Physical
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index dfedf82207e1..5dd36cc15420 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1445,6 +1445,58 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	}
 }
 
+/*
+ * Mask off any special bits from raw GPA
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gpa_raw - Raw VM physical address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   GPA with special bits (e.g. shared/encrypted) masked off.
+ */
+vm_paddr_t addr_raw2gpa(struct kvm_vm *vm, vm_paddr_t gpa_raw)
+{
+	if (!vm->memcrypt.has_enc_bit)
+		return gpa_raw;
+
+	return gpa_raw & ~(1ULL << vm->memcrypt.enc_bit);
+}
+
+/*
+ * Add special/encryption bits to a GPA based on encryption bitmap.
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gpa - VM physical address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   GPA with special bits (e.g. shared/encrypted) added in.
+ */
+vm_paddr_t addr_gpa2raw(struct kvm_vm *vm, vm_paddr_t gpa)
+{
+	struct userspace_mem_region *region;
+	sparsebit_idx_t pg;
+	vm_paddr_t gpa_raw = gpa;
+
+	TEST_ASSERT(addr_raw2gpa(vm, gpa) == gpa, "Unexpected bits in GPA: %lx",
+		    gpa);
+
+	if (!vm->memcrypt.has_enc_bit)
+		return gpa;
+
+	region = userspace_mem_region_find(vm, gpa, gpa);
+	pg = gpa >> vm->page_shift;
+	if (sparsebit_is_set(region->encrypted_phy_pages, pg))
+		gpa_raw |= (1ULL << vm->memcrypt.enc_bit);
+
+	return gpa_raw;
+}
+
 /*
  * Address VM Physical to Host Virtual
  *
@@ -1462,9 +1514,10 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
  * address providing the memory to the vm physical address is returned.
  * A TEST_ASSERT failure occurs if no region containing gpa exists.
  */
-void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa)
+void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa_raw)
 {
 	struct userspace_mem_region *region;
+	vm_paddr_t gpa = addr_raw2gpa(vm, gpa_raw);
 
 	region = userspace_mem_region_find(vm, gpa, gpa);
 	if (!region) {
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 82c39db91369..41aeb34c6d5d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -181,7 +181,7 @@ void virt_pgd_alloc(struct kvm_vm *vm)
 
 	/* If needed, create page map l4 table. */
 	if (!vm->pgd_created) {
-		vm->pgd = vm_alloc_page_table(vm);
+		vm->pgd = addr_gpa2raw(vm, vm_alloc_page_table(vm));
 		vm->pgd_created = true;
 	}
 }
@@ -203,15 +203,15 @@ static struct pageUpperEntry *virt_create_upper_pte(struct kvm_vm *vm,
 						    enum x86_page_size page_size)
 {
 	struct pageUpperEntry *pte = virt_get_pte(vm, pt_pfn, vaddr, level);
+	uint64_t paddr_raw = addr_gpa2raw(vm, paddr);
 
 	if (!pte->present) {
 		pte->writable = true;
 		pte->present = true;
 		pte->page_size = (level == page_size);
-		if (pte->page_size)
-			pte->pfn = paddr >> vm->page_shift;
-		else
-			pte->pfn = vm_alloc_page_table(vm) >> vm->page_shift;
+		if (!pte->page_size)
+			paddr_raw = addr_gpa2raw(vm, vm_alloc_page_table(vm));
+		pte->pfn = paddr_raw >> vm->page_shift;
 	} else {
 		/*
 		 * Entry already present.  Assert that the caller doesn't want
@@ -250,6 +250,8 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 		    "Physical address beyond maximum supported,\n"
 		    "  paddr: 0x%lx vm->max_gfn: 0x%lx vm->page_size: 0x%x",
 		    paddr, vm->max_gfn, vm->page_size);
+	TEST_ASSERT(addr_raw2gpa(vm, paddr) == paddr,
+		    "Unexpected bits in paddr: %lx", paddr);
 
 	/*
 	 * Allocate upper level page tables, if not already present.  Return
@@ -272,7 +274,7 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	pte = virt_get_pte(vm, pde->pfn, vaddr, 0);
 	TEST_ASSERT(!pte->present,
 		    "PTE already present for 4k page at vaddr: 0x%lx\n", vaddr);
-	pte->pfn = paddr >> vm->page_shift;
+	pte->pfn = addr_gpa2raw(vm, paddr) >> vm->page_shift;
 	pte->writable = true;
 	pte->present = 1;
 }
@@ -587,7 +589,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 	if (!pte[index[0]].present)
 		goto unmapped_gva;
 
-	return (pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
+	return addr_raw2gpa(vm, ((uint64_t)pte[index[0]].pfn * vm->page_size)) + (gva & 0xfffu);
 
 unmapped_gva:
 	TEST_FAIL("No mapping for vm virtual address, gva: 0x%lx", gva);
-- 
2.25.1

