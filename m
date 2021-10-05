Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE0A4234AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhJEXsv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:48:51 -0400
Received: from mail-bn8nam11hn2208.outbound.protection.outlook.com ([52.100.171.208]:38080
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237187AbhJEXsc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZtEMTIFP6AFW6OS719nKezOmPM3OcTHwl7qjGD9cVdtGSu+MGVM283LqkMXmu+dfTPVKfPDI68Jn8PGoP6p8Dons+qFlKS3hm+Mj6It4li3V6Ax63En/B9bfM37X+A/2/E+jiCFVkz0iYm/R+pWZiaHMh7szQfajTODe9QMpwFm4zIqyqDmHltpwNbmVLhdAPoHtrnCkonSZMIaO+abCXDX8m+WP8YdmaiR15CekBMPY+mWsRgRSdKh/2/+8lla1DAru8c0RWDEwjRq+FUWwcDwtPnh2LwkUQXyrIiq6hIJDc8xop1SS1qMtYmaQgqsTgFMWzGnY0ThOAunGDfJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZipiri2MgYDAKwE57UEvJmQdGN0o6KhTqw5dHuuDW8=;
 b=cjlqiepablJ9Gv4YiC4GmLSd5yAz5ITT7SPA+DRRIvqr6RE3/FLaaLPBaSgnUJ4cVg6nhWPRhedmo1xh3s6r3fRLbAX55ihq9Tf9XD/bmf1j0ez5pBchBhFVc3LcfQYN/3CvJUdbuPya1eusICC5cjaRX/HEvGtkXsLVEnhCx5RQZAI6SMc+pnSgDlDQF/08oJtggA+Xg00HcPaTyvwPb9E7IIMFdMw2bXg8bsIV9tmgmUQ/IhzSgTAJEwKu9BmUlGbs2zp9k3C8x8P+avxZJNOgmTavH5RsMNWBYQCNtTuCxAwOElOUC8A1zqzvMaLW4k7AcmdHgmjI+yK1bkfxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZipiri2MgYDAKwE57UEvJmQdGN0o6KhTqw5dHuuDW8=;
 b=JnRivwkWy0KMqGAMAO7R2owyETxv12Kj2fmJ3O7VInGL+kok623a7zvPAME8owgBf5knK5VuczvQAxR9jL6mNRG97qTWNSDifsmyk44qFSrHhcIQMa5AtgxRYg66+kgiWXINeXLe/HZAdMHdL2X8iw0br82sr+WOWn+Hf8qli+o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:46:03 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:46:03 +0000
From:   Michael Roth <michael.roth@amd.com>
To:     linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [RFC 03/16] KVM: selftests: handle encryption bits in page tables
Date:   Tue,  5 Oct 2021 18:44:46 -0500
Message-Id: <20211005234459.430873-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::35) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA9P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19 via Frontend Transport; Tue, 5 Oct 2021 23:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8d4cbe1-d2c7-4e4d-ac4d-08d9885a4a7a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB392565EF2CED36049D13A90295AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OjuAKNdO+w0090eH6AcfONyFKJ3BGqNyoktUBrZN3ayrf+y1W5M0qmUFa3mg?=
 =?us-ascii?Q?xOTCQq6vMRATvcR1OcrB9D+GSsJIk6MJcbD2ynxELM3sKCSiqp6UmbO5+tGX?=
 =?us-ascii?Q?VLjIiti+jR6GG/MJTb0Q7atZrTxOJi/VaZ5A8tfpJyhmyQHCp4SQStv4/pi9?=
 =?us-ascii?Q?U2cfk66T65T41uNQypu/P78Mh4We+Ek4NDXNMbaHUVHUtI/suTLll8T4aq59?=
 =?us-ascii?Q?B86t1W7jKFRnnXu/qxnairf/SyCPYU5BgrDldRRZ2kC/haO3U3srRPHgUTCV?=
 =?us-ascii?Q?n0r/RUXYRx6IhNMcyv/dmQj3P/mq4X2yu+Pv7VpxT4OozbSAACDAYCc0VlpP?=
 =?us-ascii?Q?cUtKuKYo0wmEEV/pXRDzplI6gK+gZ7XD0aCjkqquHjo8Y2aIFg4siuKHSXKq?=
 =?us-ascii?Q?EKa1POTByp7rN7gBbXqwKA8/YUlUM9WWFoLwBTPZVkqe5penboKHizIvNYcb?=
 =?us-ascii?Q?1cLAzOzK34rGOc4NVTYKW2lCC+EI2prHNtW5g1hYT0rIR48+w7d1oDYLPcxF?=
 =?us-ascii?Q?Mgkbx5ka1xatLpwAKBY4kIFMvTbzt80q2+a9dnI7wpZSvm5BZrPlY7fMmpS2?=
 =?us-ascii?Q?cJkmvRdDa76SKaEAWB+SUe57em/bMknzdEpnuwE9l8ZJpKogdHyOnLF4C5sM?=
 =?us-ascii?Q?d+MXLc8xyMgEhoy/F0ZPkqf1EblTrpyJaywVkfq8IpM7uoO+MUELSz94ec/E?=
 =?us-ascii?Q?8/wsIQUqlUSbJ6k3L+FTImSETDbfu8REflJ/XczGC0v+RHIxe78MO6OvBeWj?=
 =?us-ascii?Q?UQf1CGYJbKhYo14D3r5PCEDwTe7lNAIpNVsTKQtIj/8jMcNbepJSzJhdtlRK?=
 =?us-ascii?Q?MrzFAMnPEGftO9UqDHr//tbJJrnfz7q8UdLgROaYsiBVp6v5LKmYpFCI+s/G?=
 =?us-ascii?Q?dGzFTi6Nl/RYdX7Qi9fmIojbgTU7+4FIlBkmpWn3BAyZKKvJwkv3Z3kNPFcj?=
 =?us-ascii?Q?pUnp4QF9CeuKgd0bCblbrRWs2PXbOtn5S3fJbtbT+8bgfJ+Z7JqBd92B7B3y?=
 =?us-ascii?Q?3iJ86QD1ojkgGExBdo72Dxya3qmVhYWSy6TH5RXNoC2xfUw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6666004)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmKqrwfkPJILBZU6I57gvz426T6KxV4pVQ9cW9At/USlg9poehb2cINXK1U0?=
 =?us-ascii?Q?kCkWlwX63xR8hN8W1uAUseVFvWvVt5HO4hF0VpuX6a3Djly5hFeG0gjYKTDv?=
 =?us-ascii?Q?fhx2nHtRHog25NH6lLmv+6xekft7822QamfHcAepRdG1iGLDKFCNDTFJUQ+U?=
 =?us-ascii?Q?iwaWTVnnfYDrhMKvm3E07YjWU5J6ALqWJU8b8ur2dgY/7QOPwd6zo/Z5bZuq?=
 =?us-ascii?Q?7vKRUpeHauMuRNzhGpV3xQweXoXB4kSx/Obv7OEnfOrBpsaF3ro+TTEG6GUc?=
 =?us-ascii?Q?vVlbtPgOJJjMTYQi6QZxRIawszFaRf6Nhx8SZiI1Q5k3W/jZCswCFaxhnAeu?=
 =?us-ascii?Q?K/3oZ2ndnj5UGHQG6vitwSj163C2/CW5ii5/dbYYoSqdumo9EPdvZFhiIt6F?=
 =?us-ascii?Q?U/OzlZwkaRQPicP38BEJBTC8cxkEhlbOow8BlVPtwgoUxNQXJZ5S88SRsWBX?=
 =?us-ascii?Q?ouN3TQmtfqkUfSkUnvCbD7ni4U3X8vr0XONcRvmQVLaldS3+z99C43BFxqMp?=
 =?us-ascii?Q?KfU9TeesM7596ynXobOC5/Ak4H8r6CBudqiLvfTnKBrMrX9WPTSfvM8SC6pB?=
 =?us-ascii?Q?05meTtqWar3ue6bPS9uOXkLE9+a+RXguW1Bdx2TZDGKfdB4YTs5Nmr21g0Xm?=
 =?us-ascii?Q?ZwlsqDZ1Yud7WrkbW2Pzsiwv0r1BC60WXkQyn5ZpTNGUCq7E0ePEtAJHCGmk?=
 =?us-ascii?Q?6dnTc24AMdBj+94dfiSthHF4U2Pr996P1FJJizCpD4Ep3YOlW33laaxMBDar?=
 =?us-ascii?Q?7os9kwRro/SI5DvSofzeWvJIsCSQfRtkdAuGwJZEbXrt5yWza3Ux6uicwJUy?=
 =?us-ascii?Q?SYqSXFwLk5XxtNhEJa5zkaJ/1TsUesw8vRi1rhxNrp9B7WNOC+U5HHkTgbZf?=
 =?us-ascii?Q?2ra8WPytmc6wg2bDDLpMJV0Y74c97H6GCUrDHyd6dM9bNHh/AHDL8gMBKalQ?=
 =?us-ascii?Q?7nt2PSCKgir6Jvrqb/fIORxHv7wlB+I95XtbbLgaRMZG2r/KQtVjuYIkShhT?=
 =?us-ascii?Q?2Kq2o17ZOanNCVrVCp1byvxVrAG6deqZYPF2zUlCM7evpKOqNvtjTpduonPO?=
 =?us-ascii?Q?FGBEyoyjLHw6h3g35q3Hir90WG9OuCkDThd1JpViQxZawSDl4+MvgKjlQRBc?=
 =?us-ascii?Q?qaNS+CYDyr2lo7eN0Fj/m18hnQhXJoA9qXdIkZ1FkD/V09Ht+q6w/CMq3/ig?=
 =?us-ascii?Q?f//tPlGbEimi4Y6lwLOJqRnepOVgYevF663VWA0bK8sXnokxzlU+KA2o5u76?=
 =?us-ascii?Q?yWn4qmBdVCLX14Tu6Qaqjz4Ke3/s1mt0HkTRnEWFCVppzkRnI54LWwzNP5es?=
 =?us-ascii?Q?y1ifw+wojVvWAzR7EVhGWMxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d4cbe1-d2c7-4e4d-ac4d-08d9885a4a7a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:46:03.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVq6yU3ZQhPWJ9RAucFzU9qZ1wyFW/C1bWMjuK3FViO1Ko2BHQpGusKbIvKicfpcyd3cxhchMl8TtRLAmxLaFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SEV guests rely on an encyption bit which resides within the range that
current code treats as address bits. Guest code will expect these bits
to be set appropriately in their page tables, whereas helpers like
addr_gpa2hva() will expect these bits to be masked away prior to
translation. Add proper handling for these cases.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 23 +++++++++++++++-
 .../selftests/kvm/lib/x86_64/processor.c      | 26 +++++++++----------
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index f417de80596c..4bf686d664cc 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -152,6 +152,7 @@ void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
 void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
+vm_paddr_t addr_raw2gpa(struct kvm_vm *vm, vm_vaddr_t gpa_raw);
 
 /*
  * Address Guest Virtual to Guest Physical
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c58f930dedd2..ef88fdc7e46b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1443,6 +1443,26 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
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
 /*
  * Address VM Physical to Host Virtual
  *
@@ -1460,9 +1480,10 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
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
index 28cb881f440d..0bbd88fe1127 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -198,7 +198,7 @@ static void *virt_get_pte(struct kvm_vm *vm, uint64_t pt_pfn, uint64_t vaddr,
 static struct pageUpperEntry *virt_create_upper_pte(struct kvm_vm *vm,
 						    uint64_t pt_pfn,
 						    uint64_t vaddr,
-						    uint64_t paddr,
+						    uint64_t paddr_raw,
 						    int level,
 						    enum x86_page_size page_size)
 {
@@ -208,10 +208,9 @@ static struct pageUpperEntry *virt_create_upper_pte(struct kvm_vm *vm,
 		pte->writable = true;
 		pte->present = true;
 		pte->page_size = (level == page_size);
-		if (pte->page_size)
-			pte->pfn = paddr >> vm->page_shift;
-		else
-			pte->pfn = vm_alloc_page_table(vm) >> vm->page_shift;
+		if (!pte->page_size)
+			paddr_raw = vm_alloc_page_table(vm);
+		pte->pfn = paddr_raw >> vm->page_shift;
 	} else {
 		/*
 		 * Entry already present.  Assert that the caller doesn't want
@@ -228,12 +227,13 @@ static struct pageUpperEntry *virt_create_upper_pte(struct kvm_vm *vm,
 	return pte;
 }
 
-void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr_raw,
 		   enum x86_page_size page_size)
 {
 	const uint64_t pg_size = 1ull << ((page_size * 9) + 12);
 	struct pageUpperEntry *pml4e, *pdpe, *pde;
 	struct pageTableEntry *pte;
+	uint64_t paddr = addr_raw2gpa(vm, paddr_raw);
 
 	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K,
 		    "Unknown or unsupported guest mode, mode: 0x%x", vm->mode);
@@ -256,15 +256,15 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	 * early if a hugepage was created.
 	 */
 	pml4e = virt_create_upper_pte(vm, vm->pgd >> vm->page_shift,
-				      vaddr, paddr, 3, page_size);
+				      vaddr, paddr_raw, 3, page_size);
 	if (pml4e->page_size)
 		return;
 
-	pdpe = virt_create_upper_pte(vm, pml4e->pfn, vaddr, paddr, 2, page_size);
+	pdpe = virt_create_upper_pte(vm, pml4e->pfn, vaddr, paddr_raw, 2, page_size);
 	if (pdpe->page_size)
 		return;
 
-	pde = virt_create_upper_pte(vm, pdpe->pfn, vaddr, paddr, 1, page_size);
+	pde = virt_create_upper_pte(vm, pdpe->pfn, vaddr, paddr_raw, 1, page_size);
 	if (pde->page_size)
 		return;
 
@@ -272,14 +272,14 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	pte = virt_get_pte(vm, pde->pfn, vaddr, 0);
 	TEST_ASSERT(!pte->present,
 		    "PTE already present for 4k page at vaddr: 0x%lx\n", vaddr);
-	pte->pfn = paddr >> vm->page_shift;
+	pte->pfn = paddr_raw >> vm->page_shift;
 	pte->writable = true;
 	pte->present = 1;
 }
 
-void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
+void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr_raw)
 {
-	__virt_pg_map(vm, vaddr, paddr, X86_PAGE_SIZE_4K);
+	__virt_pg_map(vm, vaddr, paddr_raw, X86_PAGE_SIZE_4K);
 }
 
 static struct pageTableEntry *_vm_get_page_table_entry(struct kvm_vm *vm, int vcpuid,
@@ -587,7 +587,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 	if (!pte[index[0]].present)
 		goto unmapped_gva;
 
-	return (pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
+	return addr_raw2gpa(vm, ((uint64_t)pte[index[0]].pfn * vm->page_size)) + (gva & 0xfffu);
 
 unmapped_gva:
 	TEST_FAIL("No mapping for vm virtual address, gva: 0x%lx", gva);
-- 
2.25.1

