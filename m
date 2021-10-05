Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBF423498
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhJEXrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:47:52 -0400
Received: from mail-bn8nam11hn2217.outbound.protection.outlook.com ([52.100.171.217]:8641
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237047AbhJEXrq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:47:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFZ+AGoea3Sxt5AR1JWVs8N20PWbn1sv9pktxTKTwrwr81edozS8KnwWRgW5qkCAmn6GX3fK4As+7ryEDLmRfjjbcRFDU4iqquZkYOr5ZtfDUv8Zzrz12k7fXk81LnMUb/XAUnOgbj+JjmWLk0SDgqKpkk1m21tisVCZhuXcMuiAvqVopLDoyAWbjOzifwxbCTXn0lrE4CgMRZg7Iz6BDtfTzXt9WMzsL+haMQI7cCfnK/r85pArSFvJ4B48Hfde5GgHgj/OnxolaRUdIKHKvfNhKRP8s7Zee4TgGA+MLVglnci/JM84+pphkEMmhboOlT4E8Zl4vAtok0lrnKeHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeB6FnD9KJxn+Wn2IDh5RFP6Ze4RfCvcJDiUDf/SMk0=;
 b=LfBwSsbAnVN10/qe+NXs9NHUo/DR9EQE8XwW9M8Ancl5Eeyxjnj0vwtUPZIl305nD7HR5aBgEq8nO4qUQ1iTSI/ORLvfkycLbPFMJEAi8GsPJvuM7Up5otAs9sHJxSU1LJL/xfl9Z34rHJnMGAdn9+rHeLNEmvTBOmGDtIxdRKeFGMiJoq5ZMuoEZ+1vB994pBhXvmMad0jlHZZLqAzj7z4GepBHBFkIxrjQHLHfDsMzkhPcmrOfGOFhOkO41ChPiexuzDFXK6VrWvu7i3AhEay04zs8Ol8B3tilruSAEVC/6To7uZsazLLgO2lyNs2xQB3cjfYtqElMXhTzI5BAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeB6FnD9KJxn+Wn2IDh5RFP6Ze4RfCvcJDiUDf/SMk0=;
 b=hSAVsrAAKhHKUDC4T7NMrReGIVgm5PuUtK0lwQ3rriSo+WmI2dSL8tCHJha+UX2SiSS3XO8b0yLihTuHUSGyb6B6Z+RzQsYF6/zBsCO6AF1kfbKIJQLj5ib5+Uni0GPY67yAPmeVcW8zxHKKAnhsLikbTPHbU0GJ/FELa9Wq+qE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:51 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:51 +0000
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
Subject: [RFC 12/16] KVM: selftests: add SEV-ES boot tests
Date:   Tue,  5 Oct 2021 18:44:55 -0500
Message-Id: <20211005234459.430873-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:806:22::22) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA9PR13CA0047.namprd13.prod.outlook.com (2603:10b6:806:22::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.11 via Frontend Transport; Tue, 5 Oct 2021 23:45:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 960770bf-ac7c-450d-2406-08d9885a4388
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB392500DADBF370E86008595595AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Equ47obkOKM6Hygz+JBgaZvPIzEyqyW5l3rpJhEDGbYjpzNSeGfFkqVPm6NN?=
 =?us-ascii?Q?QEHFw66l70Q69dsfpVUOHRaRjTIyEo2U7RgO8Wgj83iaD3ZUO+maOLS+Cw5X?=
 =?us-ascii?Q?7nRlxNtQIS6cQO6vzfDm7EnDXuhsLYZOQg1yq1K77Sn8NkqBrQFUFfAry1PF?=
 =?us-ascii?Q?39DOYqGAp1OBvphguQWWWAf8BAq3T8r6MUeiHL5Z/8uAh0LkjHDM9XGsBr8/?=
 =?us-ascii?Q?L0oLlQ0LLN7shBpS6EXadsQ5Ry5guB3B2d6NWBaSQZbqLDZVkNjEJSB/vWvC?=
 =?us-ascii?Q?5QPD6893XyN6nbytUMUm8ivcteJuGyw/odvVwPeQ+OyUnUjSJ/yHKJPVk8fJ?=
 =?us-ascii?Q?uFOdIqfywQvVr36icHXzEHWH9vzE+3ri/P/I93AKkAaFzdNIDYHo+xUHf2+2?=
 =?us-ascii?Q?OX+0FV3FtWRg46SGnJO2jckLcIMdoKOdJhA1s53HvkbN+avBO8IprJ7d4vrf?=
 =?us-ascii?Q?dOGKSdHWsTzMzuXIn4baP/9JFnysrnyS4hrhN9dZRqeZ9vMsaFCmpMpWVMqX?=
 =?us-ascii?Q?kSDYA+clSRLPjJYMknhpEHnsVstCp8ln1XQFfDhngiXp+4J04XqpSrp743bw?=
 =?us-ascii?Q?uW4yyMRcwnVbY18Yq44Wrc0LNU1foXMVC5eG1WCxle/Se9LsLjXlhUVCvDI6?=
 =?us-ascii?Q?xiSqmAMd8zv2+UXSBeRwCz6V+sqdUb71V+Hd0oKtGTEz7kqd1CWz1555FSHQ?=
 =?us-ascii?Q?PbolVwkloACZuD+8K4JnDr8zGk+0+Z+dJ9Mq8OlP+g/BVpndYjMIuOcEYhyW?=
 =?us-ascii?Q?oxs85E4pLLa2bLPfOgOdKv67Zkdle0PMhWnsEtLX6ZWc7QYnWxQZgRjEAL6T?=
 =?us-ascii?Q?jge09aQJNkYtBReJ2H+FtZezd+zfzj087bOeEX/lBnkOcaAI1q4NW0oWi9FU?=
 =?us-ascii?Q?jEGGCJPzdnA9A0IQdck5y4RkBySgFtniXYX56HQ8sGNstwadfmBQwcXnfxb0?=
 =?us-ascii?Q?T+QFNj9nR56sB9HIRNMr4fAtdfSsNfCPTyuB3ICIKyj9I7egcve4PMdEyMyl?=
 =?us-ascii?Q?ZFRRGwviwZAxMrTj1AS4HYqvJuZwVWchN8vEH+o80GoPw+8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aeU0Ri7a/BUUq9bVn4w/xrvMGCgaHAPr/YfHDkJel84DgPMldegn58CzNJzA?=
 =?us-ascii?Q?Pguck3fS228Hje/TZsuhgYDT94jChfYjzU0lc0YjnGMVxEJVJy2hHxpyq6Kk?=
 =?us-ascii?Q?kx5Ny7LPbrp4O0+C7OQi8jlrbhbIAdKr8fYxmpu8UO+nV/fDfahwj76yQmyu?=
 =?us-ascii?Q?28v4ffeFDzsXeCDkPdlOYWbovO3ZiGzGwkrAxvIsPocQv9Buu/cu/fPQpFav?=
 =?us-ascii?Q?p7xKLNf5gsAEfXXOxXUOfV0N/X+Gz1qusntkS3hBNK3dmh6ncBOesmezLEfE?=
 =?us-ascii?Q?W7gVDhqOuPIccKBdOLFu0ZHLFkGTVsKldongEEVfoh4nRwDZeMpP8CHJAd8x?=
 =?us-ascii?Q?Jq0HPJ6/RD3oxazfmvDN/UoJW/4m8htY20RVKAzBPLTHl+2X+Lk/8Qr/zCGa?=
 =?us-ascii?Q?TjzA+JB4TuuGyIcNy+mEK+I6BqROobVlsr1KaIYOnQoOwloaPnS0WtFU0q94?=
 =?us-ascii?Q?MTh/4bObKIMtINEL+KeUL4gMx8nCCiRmNfcy7unuj1r5qeeV7FMwdwAPuxGt?=
 =?us-ascii?Q?nBUX4VQb+mQnVYdv1uhBGOqLeGaI5U7WgxdVSIi1giJks7WVSm2o9/jcEThD?=
 =?us-ascii?Q?qOx95BLXJOizkgW3GG+4xaHinW9ioFLmTbvnE2nz5rboTcEPv2Q5Z7RXF9lw?=
 =?us-ascii?Q?Uy3D3D1LYLnZ1JwJ2JVP5Q3qi24njgl072KZ/g8qEHd0eqnN4eUjIN9e0Ymm?=
 =?us-ascii?Q?f84gmkAjxUNCPAe2C7Bx4YbW1yTUht5ZqqojpnTKUVjQyJPLoOkO4nH5yuyu?=
 =?us-ascii?Q?R8ghOIcUhQ1oJ57EJ+ggg0v+CIS6vEqfRLbN9IKQockPN2IH/CjaCc6x4NOU?=
 =?us-ascii?Q?ul1V66ora63NqEvomWtEZWF1gfZdY2HCjzZqgCUn+pYezk2juPASRDvcsnyK?=
 =?us-ascii?Q?rghPBs332s1Zt3TUOFhIQ1b61ZijvI9meTwQYTnl8KnmIVzJyu5GAwnwfY7y?=
 =?us-ascii?Q?5Q4stqZny3Ok1mBtrMpDEx9xivyz3jOYJauSUYZXvZV67/ViolADDQEksXwQ?=
 =?us-ascii?Q?WZFra39DuEURpk9IazUJa+bETjdz5cZfmehnrDwva6bD4q3Yyud4Ko/9YNKz?=
 =?us-ascii?Q?eRgH5aTsoyxoRS1beQ40rK4gdXpbkdG/Xh3dltz2JKK5/1XBLWf7vTA1h3EU?=
 =?us-ascii?Q?+2SexpSIkSmxUJGAIfuMFczOnR7CJnZ6yF9o3fIGIRi0I5uV2E24tZ/rP9kQ?=
 =?us-ascii?Q?uQc5W2hkQCjHF/DcRQYt73ADqC0lGZ9m4mXKk4RnUX3WHjuE8aqtM0QOZcZ2?=
 =?us-ascii?Q?vkbMokwgrnBC4jS/d+xJd7Jssn8Pb+vdCvqgRF+TkWqE4tzyM/I6cof8mI2y?=
 =?us-ascii?Q?Iv/acvWTGKrDj0ktJSQONvmE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960770bf-ac7c-450d-2406-08d9885a4388
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:51.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP+YS58aqD3mD5iMPrveRLp0ajj8BzwUGL5oT+Or8lULRElVUWoH2NMfzOBGZdeU4xSY7dLKhWTOSpdtLKMyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the existing SEV boot tests to also cover SEV-ES guests. Also
add some tests for handling #VC exceptions for cpuid instructions using
both MSR-based and GHCB-based vmgexits.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/x86_64/sev_all_boot_test.c  | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
index 8df7143ac17d..58c57c4c0ec1 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
@@ -18,6 +18,7 @@
 #include "svm_util.h"
 #include "linux/psp-sev.h"
 #include "sev.h"
+#include "sev_exitlib.h"
 
 #define VCPU_ID			2
 #define PAGE_SIZE		4096
@@ -31,6 +32,10 @@
 
 #define TOTAL_PAGES		(512 + SHARED_PAGES + PRIVATE_PAGES)
 
+/* Globals for use by #VC handler. */
+static void *ghcb0_gva;
+static vm_paddr_t ghcb0_gpa;
+
 static void fill_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
 {
 	int i, j;
@@ -171,6 +176,47 @@ guest_sev_code(struct sev_sync_data *sync, uint8_t *shared_buf, uint8_t *private
 	guest_test_done(sync);
 }
 
+static void vc_handler(struct ex_regs *regs)
+{
+	sev_es_handle_vc(ghcb0_gva, ghcb0_gpa, regs);
+}
+
+static void __attribute__((__flatten__))
+guest_sev_es_code(struct sev_sync_data *sync, uint8_t *shared_buf,
+		  uint8_t *private_buf, uint64_t ghcb_gpa, void *ghcb_gva)
+{
+	uint32_t eax, ebx, ecx, edx, token = 1;
+	uint64_t sev_status;
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
+		/* Check CPUID bits again using GHCB-based protocol. */
+		goto again;
+	}
+
+	/* Check SEV and SEV-ES enabled bits (bits 0 and 1, respectively). */
+	sev_status = rdmsr(MSR_AMD64_SEV);
+	SEV_GUEST_ASSERT(sync, token++, (sev_status & 0x3) == 3);
+
+	guest_test_common(sync, shared_buf, private_buf);
+
+	guest_test_done(sync);
+}
+
 static void
 setup_test_common(struct sev_vm *sev, void *guest_code, vm_vaddr_t *sync_vaddr,
 		  vm_vaddr_t *shared_vaddr, vm_vaddr_t *private_vaddr)
@@ -216,7 +262,18 @@ static void test_sev(void *guest_code, uint64_t policy)
 	setup_test_common(sev, guest_code, &sync_vaddr, &shared_vaddr, &private_vaddr);
 
 	/* Set up guest params. */
-	vcpu_args_set(vm, VCPU_ID, 4, sync_vaddr, shared_vaddr, private_vaddr);
+	if (policy & SEV_POLICY_ES) {
+		vm_vaddr_t ghcb_vaddr = vm_vaddr_alloc_shared(vm, PAGE_SIZE, 0);
+
+		vcpu_args_set(vm, VCPU_ID, 6, sync_vaddr, shared_vaddr, private_vaddr,
+			      addr_gva2gpa(vm, ghcb_vaddr), ghcb_vaddr);
+		/* Set up VC handler. */
+		vm_init_descriptor_tables(vm);
+		vm_install_exception_handler(vm, 29, vc_handler);
+		vcpu_init_descriptor_tables(vm, VCPU_ID);
+	} else {
+		vcpu_args_set(vm, VCPU_ID, 4, sync_vaddr, shared_vaddr, private_vaddr);
+	}
 
 	sync = addr_gva2hva(vm, sync_vaddr);
 	shared_buf = addr_gva2hva(vm, shared_vaddr);
@@ -248,5 +305,9 @@ int main(int argc, char *argv[])
 	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
 	test_sev(guest_sev_code, 0);
 
+	/* SEV-ES tests */
+	test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
+	test_sev(guest_sev_es_code, SEV_POLICY_ES);
+
 	return 0;
 }
-- 
2.25.1

