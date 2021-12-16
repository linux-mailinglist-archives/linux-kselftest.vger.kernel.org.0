Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68725477A61
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhLPRSI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:18:08 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:17817
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233283AbhLPRSI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:18:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es871+NXjExz9qEbTEJvBgq0HqJaiut/yooKT4I2otrsbgHS2MaY5hy8ugZZoSdkGuFiwMCmFS0F8qw56Mbd+U+ajU3yeVMtZRJccy4/RIZZnScAnS8jNp5z589/uuhOiqtPQDNmAM+KgilI13xK9t6G1VSHXP6AdN9NmqkaKrk1LoBigtWLw2EvUE/lE4lkDqqeEdPQpf/2iNK4LRzOzeXV0y5lPg6G6qmebb8mtwjrd72htQRjQnoGRaFs3zrLqkeTCSBCL8+aMOc1usZcHhM/fiqrEOeAypbcq61S8lzcpWX7zP1mp9sLS91e6w1f7Bx7a2WKNSQQ6/fWbGLOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eAwBIM9aPTvor/bdrrE3GAZvyZexW6t9WtVEZavh8k=;
 b=Rlrg+2EMD2MINjxREmFiPXN9fla/T0yuBBBNAexjT8CDU/IDziPxrfS4ZON2xWKV/4HVQGEwyxxD6BGvyVNQY/6fjdQJOBRyA/bDhdQi2vGy3gZiKijmrP7wzLPW/1VChmmMQankgimEX4GPniVV+XLmrZKGKoeg3DQHAFy6nH8icFeAwr2z1pPsnplz9VwxF2YYsuYSUDvtVhtV+Aqtbuy7XNwJNo3oV9BLd1maYgqefskPEzgNn2jjmw8TlCEkRX6vVzj4EJKEXB1EDdAKJKddsWFhc5TAIjbaW7J80JDxhS/CPRQzJl/lrJiso90Z9aGOJ7oxf8oPO6wqKojh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eAwBIM9aPTvor/bdrrE3GAZvyZexW6t9WtVEZavh8k=;
 b=Y5EeDJj2N9L7Pr/MHTjuIRgDDXmLeJGVo15Tf2jDkHJpBknUcAtHIbLPUEDuWEBfbgXS4Mnb4n11iF+Ce67vI3njOXtoKbrzcrG917CFmGyqce7L943o3Uc2t0LucDR5qIWUmJbast5bJlD04nCgAzR8BAy8gKWWoJOfGVx1CNo=
Received: from MWHPR19CA0008.namprd19.prod.outlook.com (2603:10b6:300:d4::18)
 by SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 17:18:05 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::42) by MWHPR19CA0008.outlook.office365.com
 (2603:10b6:300:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 17:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:18:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:18:02 -0600
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
Subject: [PATCH v2 05/13] KVM: selftests: add support for encrypted vm_vaddr_* allocations
Date:   Thu, 16 Dec 2021 11:13:50 -0600
Message-ID: <20211216171358.61140-6-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c18e7c3b-dc85-486d-aad2-08d9c0b80592
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2767AC5E2C007730C121F21095779@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UAYG9lh6uQtlMmrWvGkzMU/KnGS1E3ybPBsdwBq8BMOAgUpp5eXrvI/t7YJmfhmW/L5UHbkfxbCfMfK7s1IArC2fW+3mx3GBQQEbtG+BcG0PZJI5bpi+RbwHRpHGRtxCa2aQu6/4xhxMirOgTNlruOVN9Pnm74JcEPN2bVTwyw8wccAzZQnKIwtB9MmFacUHXcChSZ//9w/Qef1KGLeew+jk3aO+LEVZEmd8sDmsiqpI73T97dCaYwy9gB1Cf4rs14QWt/JGSU/FM9ACXUQx5NHtHtyUcwupQvup8D4V0Qbb20ya6biNtL8dnWajd2hsdo6d0e/Qz3p13+1uTja1BBqbZnXbfM09hbTJSLyTq+xzW6UYrFVYazrcoi3WdOt3Nh5WhWPVMcssAT0wwiw7pBwpPm6zqgnSpY06qQlivuh4+gM39BeBYIuysitJO6sLCERb86+0yGohjuVUpz15Gs5dg5jZpbCRs6ewae9tzupLxYeL2W0lw6ZYgmKtEZ/iUoleXuVuLoNsUeGL29azeHAosr6t4zsqOE95gFpOuLeFixZewJcEwGuCz0C8hhdSfp9aMqg4DKjQE2ihestFz2bxSbD1UHBv7CRnrlrCbmI49LqK74s7ZVYZECxdQX9ilLwhLEusdoxBPZpbHHxSad+h6tEzB2xeVvv/knA24RowqrRe7Tu+sVcUbsODdYtnzzktHl9kgPYxM9xV1ID3InqlBDZtRn6GdY2xJzVKqG7hBqx9TUAZHQ62MbWGiLDDELNOBJDXNzP0IWbtHKZIwTXeVwSBHp2do7WifEquHs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(336012)(2616005)(54906003)(7416002)(6666004)(6916009)(16526019)(186003)(2906002)(356005)(4326008)(40460700001)(44832011)(81166007)(8936002)(426003)(36756003)(36860700001)(82310400004)(83380400001)(47076005)(86362001)(8676002)(1076003)(316002)(70586007)(70206006)(5660300002)(26005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:18:04.8042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18e7c3b-dc85-486d-aad2-08d9c0b80592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default policy for whether to handle allocations as encrypted or
shared pages is currently determined by vm_phy_pages_alloc(), which in
turn uses the policy defined by vm->memcrypt.enc_by_default.

Test programs may wish to allocate shared vaddrs for things like
sharing memory with the guest. Since enc_by_default will be true in the
case of SEV guests (since it's required in order to have the initial
ELF binary and page table become part of the initial guest payload), an
interface is needed to explicitly request shared pages.

Implement this by splitting the common code out from vm_vaddr_alloc()
and introducing a new vm_vaddr_alloc_shared().

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 23 ++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 005755837aa2..0e3ded265a31 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -146,6 +146,7 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 5dd36cc15420..c387f709b6a6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1327,14 +1327,13 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 }
 
 /*
- * VM Virtual Address Allocate
+ * VM Virtual Address Allocate Shared/Encrypted
  *
  * Input Args:
  *   vm - Virtual Machine
  *   sz - Size in bytes
  *   vaddr_min - Minimum starting virtual address
- *   data_memslot - Memory region slot for data pages
- *   pgd_memslot - Memory region slot for new virtual translation tables
+ *   encrypt - Whether the region should be handled as encrypted
  *
  * Output Args: None
  *
@@ -1347,13 +1346,15 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  * a unique set of pages, with the minimum real allocation being at least
  * a page.
  */
-vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+static vm_vaddr_t
+_vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min, bool encrypt)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	vm_paddr_t paddr = vm_phy_pages_alloc(vm, pages,
-					      KVM_UTIL_MIN_PFN * vm->page_size, 0);
+	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
+					       KVM_UTIL_MIN_PFN * vm->page_size,
+					       0, encrypt);
 
 	/*
 	 * Find an unused range of virtual page addresses of at least
@@ -1374,6 +1375,16 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 	return vaddr_start;
 }
 
+vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+{
+	return _vm_vaddr_alloc(vm, sz, vaddr_min, vm->memcrypt.enc_by_default);
+}
+
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+{
+	return _vm_vaddr_alloc(vm, sz, vaddr_min, false);
+}
+
 /*
  * VM Virtual Address Allocate Pages
  *
-- 
2.25.1

