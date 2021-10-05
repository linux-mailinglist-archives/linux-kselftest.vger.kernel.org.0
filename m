Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF46B4234A2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhJEXsI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:48:08 -0400
Received: from mail-bn8nam11hn2208.outbound.protection.outlook.com ([52.100.171.208]:38080
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236966AbhJEXr6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:47:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBQR4frYlhS46ZJDTL2VnZcXiLM5LplQjUoTfQN3CZu0EY7CE0FtkguYfB99iuL0k/43owEmvmkjbw4NzuLvaefM/1H3NFjr4tkyNYNb1GUxil9JSMiawI5bf1fda35FGrAxbO5JQjtcDa03Y9jYJuN/lXX3B8/keXmu4fzSx2EoJCNAJfGBs0L/pegwqySjmIFGQuE9Jug7NQAbtcxbz7IftuxsQJsYhdbmQl8Z6KUAdOlcBD/khDWLrrmLVumPqw9jBQoFvngCuP2BDBPPMnVcxY2Z4/qUfnRiBG0MBAYKpaUcm5HkrDvnMBKmXpifWgZUCPxJyna9LWiDa7ANHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ukg735LtZUz8u/3Gx7DRtsq8S0qw8QEJzUvZN9TkjK0=;
 b=IUh3NjwdvKG92+/BMjhpO2neLRZQS3//L00Hb/ELoMmNTZSq8SQwFidpKQQzcjU980s7VDOxnvMtVmicVS8nrcXO5HSWt66P8tNjpY2db1bJxLybzJXFOLJ6TG7RpE/yLOYFr8xQlQOd6FREyIAfXCaAyPP/nravwlZpzPjckW8QUojp5TzV1NOaPbNcqdHF097fnhcRvct6kouAlAeN9DeB7xM6rUQr2YKImLJesSYJPxvt31KvHNVzwQK6X+s4SUUuSzDdiI7OsX+eysJ15dkg5Yy9zvRKXMN/kJ1ljwi1eJZI2V17XYAvs2kNWh+hgJshEa6DWoUBqFtXACQLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ukg735LtZUz8u/3Gx7DRtsq8S0qw8QEJzUvZN9TkjK0=;
 b=VWI4oGUmuES5HqHuzeTfMPxRiDrQ+Q4MC3gjOh3NTMT4UgkFsYdPi0I3BrGsDzREI+v2s6zXodkqYZ6fVraAf1/lbmI/gmkgrKQzuH1MxFn1aPx7YZNSpuAPtG96sNv6sQ6sB2EtH84Bqcux0NG7cOw403jDexlHH5LjIUHLgzc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:56 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:56 +0000
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
Subject: [RFC 15/16] KVM: selftests: add SEV-SNP boot tests
Date:   Tue,  5 Oct 2021 18:44:58 -0500
Message-Id: <20211005234459.430873-16-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:806:6f::12) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA0PR12CA0007.namprd12.prod.outlook.com (2603:10b6:806:6f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 5 Oct 2021 23:45:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a4d8f8-0054-4700-f5b9-08d9885a468c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39252E0185D235BD3F5ACBDD95AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vJSeYd6diUa6l/HwGkYfefmAbaDQuSfpSnCr+lCwRodQQIa4nCOBN0ANKR8P?=
 =?us-ascii?Q?an0j+LYdP1eEpQ5/vPqfOxAEsf4mgImUMvjYcn31a3YtPl24Q8/3Rf2RYoOw?=
 =?us-ascii?Q?xZHA7i7L6nS8TPPHEAeBaxULogl0pX7nI7ZojLiOQfYuKWkHaMpIhedtCRRu?=
 =?us-ascii?Q?Bei2VHDQ4ReTTxX+fyMovjkIDzilCkfgiXi0/D/J4d9wZUcnuvGXILpuXr22?=
 =?us-ascii?Q?cBfQQtGm8PqLhx4giUA8KUq3j4ol5lBKjrppagaUFlQOj/dZX39i1hJvjOdD?=
 =?us-ascii?Q?gVY+O3Gv8ZFjSlFLVMpAYAI/TKbVlordsc24UTdZ4CDu5f9nNw2c6HCn8CWw?=
 =?us-ascii?Q?3PCdggKR3nQeTJUMVWd9xsg/GF1h//lEQfuLRLwKhVFBQnJNtbdZp/k8GAY8?=
 =?us-ascii?Q?AtVQ88WrLyOLEIWvZ1I0qOuwSicMQ6DY/RkLU6I70thAtQXhL4bxX31Nbad4?=
 =?us-ascii?Q?Y+6S6gCIF2FRSYhJQ95ZYEUOeyPyRL8A/+1MpSMCzw/QYR2LUmLR74ivBWnY?=
 =?us-ascii?Q?0V9u/peIzhZOf4nC88mT7aocDC+qUAUbkUQFlyWEZxW3I+8n0awSOmmWo2Tj?=
 =?us-ascii?Q?3Fl344K1pCz+KsqNV26GuugapCwg22VCmaZ10QFDGjD8Pe9Apg6jdrWzLO9K?=
 =?us-ascii?Q?vxYohIF03g2RKA7Wx74Wq5asecFk0tgenGTm8TRzCJV0N8ifMfzpnZOC1Zsg?=
 =?us-ascii?Q?tlkxbJeEOqNo+31AYO+CfVTAHcML9Tr2d7P0bRKNa4Fa+bsvHJYvFcpFfhaB?=
 =?us-ascii?Q?Gt3IHQ61TfK41tZ3WcPsWNebXy9mNn4hHrUWTBFlpOAw/RizIJ94VZBoUEnJ?=
 =?us-ascii?Q?S2HUF6eItcxUI0cOQTMhmDuEMkGm1Hb4joowlFfynk13u7S5E917dhoNBkHH?=
 =?us-ascii?Q?3YTzsb7Z6K2xo8a14PA0fhsGnb4X7rRHYC2kHPh3gsjdBlkf+JWdEDOkrvrA?=
 =?us-ascii?Q?wr6vj7IdZnbtkn/auaASWM34uuxSeA+l/GsvDKAtx5AeL4uxgnN4v77HJGLx?=
 =?us-ascii?Q?kUSLEJXOHGInpq57PgKnOXjIuEtatZMHAkJem0woZRR0zL8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5Ga/gLQn6uwcs4dPCYBl3aCrCImjYnHbb4+xdDXhkeAB3gMb183jOfF0ptO?=
 =?us-ascii?Q?+QStMY0TVpwc8Wo4uikH9GOiciMd73Sc1nUZFiHFhpemakCT9sNjWnS11A2p?=
 =?us-ascii?Q?05C/MjecqHXoIZ8SQLQiYE1+dvLYpaNFamezHPCNxZcyu3zlItdKRTnHFN6y?=
 =?us-ascii?Q?FAhHN+hUMU/PSeSeVm4Hz2f+J2oVMSugNf+C4cQo70FulQweVDT+tdUAZFVs?=
 =?us-ascii?Q?fkxssN6lYhYE3g6joMqKjDoeqKXBmx09K+WieERaaq5VW5gr70bJ8amD7vY/?=
 =?us-ascii?Q?b51LzIWN+eaVAQ8e1uYaDswuXAP/58ohcDWbScjO/5a1t97nm9cxMyj2kkpA?=
 =?us-ascii?Q?p038+RxjLXRakx/2bnr0BnLZnYZdHov3ns+3uDX5XeuB79xH6ApUgORvterp?=
 =?us-ascii?Q?wPkp+WrtAQ6cKlLOWv68wBdoV18rdLuZrmIS38jd3DUQoXWuo5dCYfm1lChW?=
 =?us-ascii?Q?QlkIxVuJsq6mrq8khGgN4zMRMgmZTkEy4MILlq0lAAbg8LxJFym4/TlxhkZX?=
 =?us-ascii?Q?wWmRqn8rnJ599zr6FdxenJ/2l/8NP+6t9zb2wvDJ+XQqkPbz6QLu6hyy0ezX?=
 =?us-ascii?Q?hG3t/eLLPrmU1yUWs7txGXXixHabXLk/RNjmGANVVPGMUrMH8EonSlVoh8I8?=
 =?us-ascii?Q?WejrBX4o/mSeFJBRRbWTH0JyqlbbxnriY8wzBmZWg1jE2BFUzbcFoJ2F/t6/?=
 =?us-ascii?Q?8a+IVIvZLp70gXtVZt4ytRqcj4JGI53oQ6HTOJdZeH/G2ATfrTZRQDa0LEEv?=
 =?us-ascii?Q?2MBQSBQJ9aB+6HGk//cXx2Gl3cBUPZ3RF/QQdFCsGuYf5Y3YtoAczJTeY6d5?=
 =?us-ascii?Q?a7aJJU1WjSDnugF4O2ISotlUbbd30jm4vKsp3e5nL23PVeuX+ulx+ijeD0+i?=
 =?us-ascii?Q?vHQnSvEtx86O0s/8uyGkF9bQA2vs+RNLcImKpN2HTo31OHVe7w6Qbb6PdBPs?=
 =?us-ascii?Q?vqGctkZkrgvvOOhrhLiUTPQz3vU/NS9UaTDNDaZnzMTs49Y+4M7GpkG4l/SG?=
 =?us-ascii?Q?feqBtc4WZb8RdmB9CO78f+DfrPWck4SVHcVUwg34l3uj/Foc6sicgCbjS1cl?=
 =?us-ascii?Q?SXxtTWpNlFheqtjLRfTY8kzXY/NxvJ2Mo/PtTZm5Lkxv5SgGBTWgQ+v+wo9o?=
 =?us-ascii?Q?/EQ0FwLX1ir5oyfgqEIXwcovwVkdDDOyFwWxcO2n+m2g0xcucRjBZNuQc+ke?=
 =?us-ascii?Q?JthIqluOH623VIaP9MbMDtQ2CAVNdKqBEOxv2Qp+oV73GPNshUFiRuf3RadE?=
 =?us-ascii?Q?3bvL3dnXqwXEBvtgHM97QLTYr9jZxUQXtGw/p2GRL2AHW0cRPGhJjDw39V7x?=
 =?us-ascii?Q?eLabJar8vNVkjH83hrZCVs0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a4d8f8-0054-4700-f5b9-08d9885a468c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:56.6422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jyd/GhVc6hYbUuVsG+tfzM6UhLxhWzfVWRte60h3RlDw6f5GALaXPolZ8Mnqql0loNkkLLBXls70zYw81kINYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the existing SEV/SEV-ES boot tests to also cover SEV-SNP guests.
Also add a basic test to check validation state of initial guest memory.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/include/x86_64/svm_util.h   |  1 +
 .../selftests/kvm/x86_64/sev_all_boot_test.c  | 86 +++++++++++++++----
 2 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm_util.h b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
index 4319bb6f4691..6c51fc304ce9 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
@@ -18,6 +18,7 @@
 
 #define SVM_EXIT_CPUID		0x072
 #define SVM_EXIT_VMMCALL	0x081
+#define SVM_EXIT_NOT_VALIDATED	0x404
 
 struct svm_test_data {
 	/* VMCB */
diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
index 58c57c4c0ec1..3d8048efa25f 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
@@ -217,6 +217,48 @@ guest_sev_es_code(struct sev_sync_data *sync, uint8_t *shared_buf,
 	guest_test_done(sync);
 }
 
+static void __attribute__((__flatten__))
+guest_sev_snp_code(struct sev_sync_data *sync, uint8_t *shared_buf,
+		   uint8_t *private_buf, uint64_t ghcb_gpa, void *ghcb_gva)
+{
+	uint32_t eax, ebx, ecx, edx, token = 1;
+	uint64_t sev_status;
+	int ret;
+
+	guest_test_start(sync);
+
+again:
+	/* Check CPUID values via GHCB MSR protocol. */
+	eax = 0x8000001f;
+	ecx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* Check SEV bit. */
+	SEV_GUEST_ASSERT(sync, token++, eax & (1 << 1));
+	/* Check SEV-ES bit. */
+	SEV_GUEST_ASSERT(sync, token++, eax & (1 << 3));
+
+	if (!ghcb0_gva) {
+		ghcb0_gva = ghcb_gva;
+		ghcb0_gpa = ghcb_gpa;
+		snp_register_ghcb(ghcb0_gpa);
+		/* Check CPUID bits again using GHCB-based protocol. */
+		goto again;
+	}
+
+	/* Check SEV/SEV-ES/SEV-SNP enabled bits (bits 0, 1, and 3, respectively). */
+	sev_status = rdmsr(MSR_AMD64_SEV);
+	SEV_GUEST_ASSERT(sync, token++, (sev_status & 0x7) == 7);
+
+	/* Confirm private data was validated by FW prior to boot. */
+	ret = snp_pvalidate(private_buf, 0, true);
+	SEV_GUEST_ASSERT(sync, token++, ret == PVALIDATE_NO_UPDATE);
+
+	guest_test_common(sync, shared_buf, private_buf);
+
+	guest_test_done(sync);
+}
+
 static void
 setup_test_common(struct sev_vm *sev, void *guest_code, vm_vaddr_t *sync_vaddr,
 		  vm_vaddr_t *shared_vaddr, vm_vaddr_t *private_vaddr)
@@ -244,7 +286,7 @@ setup_test_common(struct sev_vm *sev, void *guest_code, vm_vaddr_t *sync_vaddr,
 	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
 }
 
-static void test_sev(void *guest_code, uint64_t policy)
+static void test_sev(void *guest_code, bool snp, uint64_t policy)
 {
 	vm_vaddr_t sync_vaddr, shared_vaddr, private_vaddr;
 	uint8_t *shared_buf, *private_buf;
@@ -254,7 +296,8 @@ static void test_sev(void *guest_code, uint64_t policy)
 	struct kvm_vm *vm;
 	int i;
 
-	sev = sev_vm_create(policy, TOTAL_PAGES);
+	sev = snp ? sev_snp_vm_create(policy, TOTAL_PAGES)
+		  : sev_vm_create(policy, TOTAL_PAGES);
 	if (!sev)
 		return;
 	vm = sev_get_vm(sev);
@@ -262,7 +305,7 @@ static void test_sev(void *guest_code, uint64_t policy)
 	setup_test_common(sev, guest_code, &sync_vaddr, &shared_vaddr, &private_vaddr);
 
 	/* Set up guest params. */
-	if (policy & SEV_POLICY_ES) {
+	if (snp || (policy & SEV_POLICY_ES)) {
 		vm_vaddr_t ghcb_vaddr = vm_vaddr_alloc_shared(vm, PAGE_SIZE, 0);
 
 		vcpu_args_set(vm, VCPU_ID, 6, sync_vaddr, shared_vaddr, private_vaddr,
@@ -280,34 +323,45 @@ static void test_sev(void *guest_code, uint64_t policy)
 	private_buf = addr_gva2hva(vm, private_vaddr);
 
 	/* Allocations/setup done. Encrypt initial guest payload. */
-	sev_vm_launch(sev);
+	if (snp) {
+		sev_snp_vm_launch(sev);
+	} else {
+		sev_vm_launch(sev);
 
-	/* Dump the initial measurement. A test to actually verify it would be nice. */
-	sev_vm_measure(sev, measurement);
-	pr_info("guest measurement: ");
-	for (i = 0; i < 32; ++i)
-		pr_info("%02x", measurement[i]);
-	pr_info("\n");
+		/* Dump the initial measurement. A test to actually verify it would be nice. */
+		sev_vm_measure(sev, measurement);
+		pr_info("guest measurement: ");
+		for (i = 0; i < 32; ++i)
+			pr_info("%02x", measurement[i]);
+		pr_info("\n");
 
-	sev_vm_launch_finish(sev);
+		sev_vm_launch_finish(sev);
+	}
 
 	/* Guest is ready to run. Do the tests. */
 	check_test_start(vm, sync);
 	check_test_common(vm, sync, shared_buf, private_buf);
 	check_test_done(vm, sync);
 
-	sev_vm_free(sev);
+	if (snp)
+		sev_snp_vm_free(sev);
+	else
+		sev_vm_free(sev);
 }
 
 int main(int argc, char *argv[])
 {
 	/* SEV tests */
-	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
-	test_sev(guest_sev_code, 0);
+	test_sev(guest_sev_code, false, SEV_POLICY_NO_DBG);
+	test_sev(guest_sev_code, false, 0);
 
 	/* SEV-ES tests */
-	test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
-	test_sev(guest_sev_es_code, SEV_POLICY_ES);
+	test_sev(guest_sev_es_code, false, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
+	test_sev(guest_sev_es_code, false, SEV_POLICY_ES);
+
+	/* SEV-SNP tests */
+	test_sev(guest_sev_snp_code, true, SNP_POLICY_SMT);
+	test_sev(guest_sev_snp_code, true, SNP_POLICY_SMT | SNP_POLICY_DBG);
 
 	return 0;
 }
-- 
2.25.1

