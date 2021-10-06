Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC6424823
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJFUnH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 16:43:07 -0400
Received: from mail-dm6nam12hn2200.outbound.protection.outlook.com ([52.100.166.200]:25953
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239459AbhJFUnF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 16:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6lofKYuOSMYRopNZfWjgN7kEt+uKCRFRWeOh1cBm347Rq62QVGkV0H8hILogZUb4ZTPxL0129OXfrCMZJx92pr3058f58JyhFYIOiKQmQWsjeHEIw0sljZPFOF1Iyjdb1+etIVdF+rfm9+p+3Ym4uj48CpV3ehUh426JqKyWo7HecdrOfmGWe8TESfosis/+1hNnZ7wPsv2ei7lTzF2lKJLMJN83NFUD207s/2EmImRGT5XmBrCk+bq5fCAmCHDkBYLXNwTtfFrYoNpqoutShKM/Cl3kCkoP1zT64qLEnth2j1sQDiI/ucvjOlT9+c3Cn/dzx+ancr/4zYv6p/72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VmEaJ67SCgXSyjII3nYUTpUaMj1K2bDVqvE+h3bBbA=;
 b=MXfuHg/gkvUNn19KZvU4bcQNOx7yQw5wq8iRo2ONTpWrVlgdp+xT3zJdcLax1Me4jFoAO+qPyz8kxKPjdrxaxnFwhyxW4HjxdVPPsng4qyvl0VQeL/B2oBRAvycmUnMiUiTG2PkCtIUHRd3w3LtShHb04nmlHdmnIHtEqRKHYBp8Bbh9qAPMujWPMLfNVUh3Cmss64NMzKt9SgFRPO6HKHUy0W+hmSlI8WqsBDNrbJoSQ75r0wlWS5C4xBo6NbELaCbftFm04+yOnILwZE7RUWgcr7JeasunH/OIRtlDc3bCEbBA7wYMCV8y8Lq/AGPy/Y4j7AhZ1ff/Hu1eaedW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VmEaJ67SCgXSyjII3nYUTpUaMj1K2bDVqvE+h3bBbA=;
 b=3QDv/kMmkFvPr+nZoaxb50YehjNzNDgxg2pOdq284Hoi96/ObzAAtUf5OXxw9kKw5gd0ZQEr3uXhp2O6FWGin72mA9Z/V6dvXXGs5JOgcRp1AZbuACfLY8nByJPbtv1X9p029gEELTHq08+y2dLxg1NP4H5zvY8k39KgYh1Vwxc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 20:41:10 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 20:41:10 +0000
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
Subject: [RFC 08/16] KVM: SVM: include CR3 in initial VMSA state for SEV-ES guests
Date:   Wed,  6 Oct 2021 15:37:47 -0500
Message-Id: <20211006203747.13479-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:806:27::15) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA9PR13CA0130.namprd13.prod.outlook.com (2603:10b6:806:27::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Wed, 6 Oct 2021 20:41:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a502c8eb-262a-46ea-c10c-08d98909a14f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB38482A699D0C0582125E286A95B09@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HtRChKGEkty3a3eSG4eiiUyvgIHeiiJPia5bhqEnxSpwU1SfMjvXZqFiWNZ+?=
 =?us-ascii?Q?7WIh26L+3QIvEYYNwSb1n2dS+ZPjuS/sOL2iOOiUPPs9+UJatCWfyP0qhNZQ?=
 =?us-ascii?Q?YBztv1uN1ON2GzAL7o6Sl+13GytTiBCEsHgqz/duZc+nBW3ggC7l+kk1aCOu?=
 =?us-ascii?Q?MZ8h14FOL3HWGa4a9U8Yx5azsFCEjI91RxBUg8SVH/+Q/eyl6Y/vPW7/wpU5?=
 =?us-ascii?Q?GtErcADa5XkPlzEUudh2sUXOW09HFFn/0pbV7jszcVqWFdwL1KuR7/HhXE4c?=
 =?us-ascii?Q?K9thUkfNBqscp7iJxntTOqhxidQqSNjRaz+XD05dO0FS3+21kegxoCXMlleX?=
 =?us-ascii?Q?Ecn/+fBb14tgboUM/4fdEwfeFxhfXL87BxbXQbtd3GDeP8T6stqSNDcUjru1?=
 =?us-ascii?Q?RAHAWqfyQWDz5VedOSX7Qnj0iyMfj9F6kcfKFuS8DmtrUzoWwP55fWTngVTq?=
 =?us-ascii?Q?CY8sQ43SLMM/h9+JtDLP5h1hJ2pEH9V5mHiP2nTpNJ005C+4gNWRqcvdBoiI?=
 =?us-ascii?Q?96f9DK3BLw2u0+an0yu4lBf3ql22+eAtem8S4kGC8z64SG/BHJhlWfpXvdg1?=
 =?us-ascii?Q?Z1bEGFrlpaxS7kSNbnsBsQpCQiowo/jxmRduXFX6rihsbe0WBx5ztY9Jd1e3?=
 =?us-ascii?Q?1b7co5LWBR2+V3M5vopBaPl1NG6K+ZLJjx16QqJRc9hAYV2N72yl0PoS5JS9?=
 =?us-ascii?Q?IySQ3OFuMnQdCjh6/2zsxNnM4dRYva+i01WnnpYUZVIsMzYyJGTYA6dObq+K?=
 =?us-ascii?Q?GbV/7oJ5N1coOtQ9nNR4zB0Os/CVCmwJCghY4i2gtreHAUhxiHsRT81kwQth?=
 =?us-ascii?Q?1+w9dfwSMDAZbpnqMINcxM/iedGTRFtUMQUPLaZR1jzi8f9RNgmavPGMUB5p?=
 =?us-ascii?Q?pPuO3aCWT7TPz+CflOtqPFCnnew33XQPftJF7vtQ7rXUP/z/BXqVs3ElbQx9?=
 =?us-ascii?Q?aP7jUIHKMzD9Y1PR2IAhKdtYggbyyZ57d7T+H9cuDv0CQgVFy3BAI5Q/hU5Y?=
 =?us-ascii?Q?vCxdXqNq6/yVB3ZsBkJ03AkNpeq2Gzt4NaRWTxUDJZWkq+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(38100700002)(38350700002)(44832011)(2616005)(956004)(508600001)(5660300002)(6916009)(186003)(36756003)(26005)(7416002)(2906002)(4326008)(8936002)(316002)(52116002)(66946007)(66556008)(6666004)(8676002)(54906003)(6486002)(83380400001)(86362001)(6496006)(66476007)(1076003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YR7xR3MPRuqeVSJVOhMN0kgesPr6ON1EnW+LrqbVQ6Kp8X17gXPh2/6hAxfl?=
 =?us-ascii?Q?YkByo0ufBFmKEJlC4hPnMc/RasywTLquZYAoedNbzPZeuPoBinMOsMMHl2xp?=
 =?us-ascii?Q?FeiIslJoYnHDmtRjNMlfyZE8LUR7YB+TmJYpy85Q8Q3R9zir7nFJj7vcxr6G?=
 =?us-ascii?Q?OTIUg9SL0Z7nQEtHnBiT/65SdP3WWCVvqW8JwQgViESWMs+ZiSqy9NUeAjMe?=
 =?us-ascii?Q?XEfZIJ8D2bvafn8EB4qqn+VrCir/FhlbWz61T9CkG9hXPeQkoikkVkx641aE?=
 =?us-ascii?Q?92bJtKFBKU40DNCq0IHa/Y+bsekOp4ERDjvdef41JnfwZAn1hKCHqTT7acxd?=
 =?us-ascii?Q?jcQwK3T26EX1eJqb+qfJxmgvxRutgKNFKXsZWiBuXLIAi/1t722zsokH4yhD?=
 =?us-ascii?Q?AeZBrbYm5U6EdeB0CveIV1QF69KXx75lRz4XsbUfFOjsWaiVDggWiFhhf7+y?=
 =?us-ascii?Q?ARaAv9M1eQu8FckNMuk7jDh+2NZj/ge6cdSxjR/Cz0KgAkU5S3EEbBfpp4ab?=
 =?us-ascii?Q?vsQhVHyY97YGPs52lGTA1oeFgA4OH6e2EIAjB5CzYKZP2c3pSTgsBWWJfGp/?=
 =?us-ascii?Q?6v0BT0czc/IVc7PCWkpqNd99uj3AP7ZNn26NI+OiVgU4gPUOIKmXwR1W3HE7?=
 =?us-ascii?Q?4NX2WfYa443lPGW/uUb+Lvw0OEKCukY2G0gPhboeHoR9Ofp8qtdu70AG0sv5?=
 =?us-ascii?Q?o4DfpABlca20ba8r+ILpc1Q8yfCFoCxTtWvI7G0FlnWIHxPwTD7gl2gxij8G?=
 =?us-ascii?Q?FFHDpnjww3rCQM6uI0n2HsCBrwblIJQGeH8xviNDLEq2gCtGxhRFW6yCxHwu?=
 =?us-ascii?Q?v9/xbbcEdjAZmsFwCqnp1tgikY1165h7syMvpoYI6DAHTGs9BTG6r0i93thT?=
 =?us-ascii?Q?NeQcKiBPhXZbRMc3Shs/s7ZDYLDWhssd6vaSo9oW0mkZhj+whKxEexOa/n8/?=
 =?us-ascii?Q?GO39GcshzvA74xHuaQHCXxpkdgp2JuwBcEVNSqZWyBIUD3DpeMxT9v+Re40U?=
 =?us-ascii?Q?xOAgbrjU3eZ99wqH4wm+ala4gHJ/72iHvWn0IL75RwzwR+8q9msEOse5ysY8?=
 =?us-ascii?Q?f2vzIjl5PmkmEzn5u0xeYAcQ4l/G76ql2oKJKgiXpbwG93gqffLcnYR2ujpI?=
 =?us-ascii?Q?AZytyvqhUW1geOiApZvkO/p7laFWR2U11enU+yowlFf0Pwjgr8qd9BnT9M+F?=
 =?us-ascii?Q?JZR8vG0KuprF7cYRUiBJhmlEZDCCxpCO7opSDgqvSYp14RpGgcoQ3FtLP/5u?=
 =?us-ascii?Q?Lx2gevVEVqwUk8E4ZQmBk6jMwFgP/PqXZ8CDpc657sAt3w42iAjPlJ3WSuja?=
 =?us-ascii?Q?HjzvPKwhNcR4VM9RczWrXRl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a502c8eb-262a-46ea-c10c-08d98909a14f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 20:41:10.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsAFRGK1ZfAlXM5s2PgrwxMjQOGRRlNFyN9tVTOqULPYR6ZIN7prNEsmkAV+trzkXjdcNBsP/r8a5O/coMnrPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Normally guests will set up CR3 themselves, but some guests, such as
kselftests, and potentially CONFIG_PVH guests, rely on being booted
with paging enabled and CR3 initialized to a pre-allocated page table.

Currently CR3 updates via KVM_SET_SREGS* are not loaded into the guest
VMCB until just prior to entering the guest. For SEV-ES/SEV-SNP, this
is too late, since it will have switched over to using the VMSA page
prior to that point, with the VMSA CR3 copied from the VMCB initial
CR3 value: 0.

Address this by sync'ing the CR3 value into the VMCB save area
immediately when KVM_SET_SREGS* is issued so it will find it's way into
the initial VMSA.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/svm/svm.c             | 22 ++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c             |  8 ++++++++
 arch/x86/kvm/x86.c                 |  3 +--
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 3d25a86840db..653659e20614 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -35,6 +35,7 @@ KVM_X86_OP(get_cpl)
 KVM_X86_OP(set_segment)
 KVM_X86_OP_NULL(get_cs_db_l_bits)
 KVM_X86_OP(set_cr0)
+KVM_X86_OP(set_cr3)
 KVM_X86_OP(is_valid_cr4)
 KVM_X86_OP(set_cr4)
 KVM_X86_OP(set_efer)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 09ec1ff5bd83..232e997acae6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1324,6 +1324,7 @@ struct kvm_x86_ops {
 			    struct kvm_segment *var, int seg);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	void (*set_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
 	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	int (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7e19f5f6d0d8..2c3bc7a667c8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1716,6 +1716,27 @@ static void svm_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	vmcb_mark_dirty(svm->vmcb, VMCB_DT);
 }
 
+static void svm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	vcpu->arch.cr3 = cr3;
+	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
+
+	/*
+	 * For guests that don't set guest_state_protected, the cr3 update is
+	 * handled via kvm_mmu_load() while entering the guest. For guests
+	 * that do (SEV-ES/SEV-SNP), the cr3 update needs to be written to
+	 * VMCB save area now, since the save area will become the initial
+	 * contents of the VMSA, and future VMCB save area updates won't be
+	 * seen.
+	 */
+	if (sev_es_guest(vcpu->kvm)) {
+		svm->vmcb->save.cr3 = cr3;
+		vmcb_mark_dirty(svm->vmcb, VMCB_CR);
+	}
+}
+
 void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4564,6 +4585,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.get_cpl = svm_get_cpl,
 	.get_cs_db_l_bits = kvm_get_cs_db_l_bits,
 	.set_cr0 = svm_set_cr0,
+	.set_cr3 = svm_set_cr3,
 	.is_valid_cr4 = svm_is_valid_cr4,
 	.set_cr4 = svm_set_cr4,
 	.set_efer = svm_set_efer,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fada1055f325..4f233d0b05bf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3130,6 +3130,13 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		vmcs_writel(GUEST_CR3, guest_cr3);
 }
 
+
+void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+{
+	vcpu->arch.cr3 = cr3;
+	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
+}
+
 static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	/*
@@ -7578,6 +7585,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.get_cpl = vmx_get_cpl,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
 	.set_cr0 = vmx_set_cr0,
+	.set_cr3 = vmx_set_cr3,
 	.is_valid_cr4 = vmx_is_valid_cr4,
 	.set_cr4 = vmx_set_cr4,
 	.set_efer = vmx_set_efer,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c1a2dd0024b2..d724fa185bef 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10400,8 +10400,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 
 	vcpu->arch.cr2 = sregs->cr2;
 	*mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
-	vcpu->arch.cr3 = sregs->cr3;
-	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
+	static_call(kvm_x86_set_cr3)(vcpu, sregs->cr3);
 
 	kvm_set_cr8(vcpu, sregs->cr8);
 
-- 
2.25.1

