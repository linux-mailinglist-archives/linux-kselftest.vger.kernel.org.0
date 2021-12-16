Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6229C477A2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhLPROe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:14:34 -0500
Received: from mail-sn1anam02on2062.outbound.protection.outlook.com ([40.107.96.62]:11649
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235503AbhLPROc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:14:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxYnu5v+TUo9N+9ZMkqh4ugm4kWMv66TkrUmxudUHWM8dJFNCg9ZLBVumRLvLy0O+EY8CAnoMS1jOQLNwtC+cxkxIBiEo1OKesjoupjgyVNX1eVc0bGE+XmrQkldOVrFBGGSkjkJgheffXLF51hh7SlAnPHKenjEc3F/KH02gGg/xPnPAv3vAy5gXHxbYBfju2yactjQQiL/pZqI/d5Uf0HxjroNJdSBWQIx/V+VNYN0LE4fpkihorLzi2tfpJuXjgfX4yhkATWWgVtOvbvIco2MJT5Euf2gSWjVtuKQhgMltx2R+Dp8R382M7iU6IRAO/kj6zBzBkxu0Ak4hM1/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN113x5UlCSYnOdhMTV0BYu1NhwIpLHyGzI3j+MAErA=;
 b=F+HuKD9LSrWKfKD+hr7MHU5/hGNsgm5zvHUIvnl2tFkcsqYbW8CrZDX8/hKwBUVp2Z4T/lZ0T5GI/1PPt8CzHV172MmlZ/sYJPNY6K/zYcdhoTdKeco/KuVe7XeeFnFPHjgs8XofHqzq9rhLwVsMvUfkoD5+vMcVTnKPANtCpu5LQ+itlrDIL/Q/NO3QbtjbSpadMbav4Mbt/iTQkzPCqP87v+LypxQBkXg30DdZ9f1gYE2uq9aeaw0W9SAfRb8ykbShrk7ovcVy8Nizie1g0FXhahP6Y7bALICGGhqJsPSY2ON5BI99VXegWUlrg5IDo22kmHHWLDMvFxyEq5oP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN113x5UlCSYnOdhMTV0BYu1NhwIpLHyGzI3j+MAErA=;
 b=Ks9fhENm5ADLlKGy8iaq9bcWSIczpyo7fZc7FqsolpfwpLDOci0ecn/u0+rKo1KYC3lSQYX2pHQ8R57z/n0uHEowxnsyHkPAHoX2YHXY1IePDjR1ksOzfrKk9gtdkZ7IutzoWpF9fb0I1P2BaekThaikCbTCScOTIpK/T2cyz8A=
Received: from DM5PR20CA0015.namprd20.prod.outlook.com (2603:10b6:3:93::25) by
 CH2PR12MB3813.namprd12.prod.outlook.com (2603:10b6:610:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 17:14:29 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::d5) by DM5PR20CA0015.outlook.office365.com
 (2603:10b6:3:93::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Thu, 16 Dec 2021 17:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:14:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:14:28 -0600
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
Subject: [PATCH v2 09/13] KVM: SVM: include CR3 in initial VMSA state for SEV-ES guests
Date:   Thu, 16 Dec 2021 11:13:54 -0600
Message-ID: <20211216171358.61140-10-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d040d2e-840d-4752-12c7-08d9c0b7853b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3813:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3813DA729C6FA19C80B2737595779@CH2PR12MB3813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKkTYg9HzcnhxhPeLnXWwpAvLLiebeOX1TD6aXvfkO9Vpqzv6sR9RSncO4i6Q8+Ff9Y6I+Qhp4vNza1KjtBzjTIwsl+vXTgNKskcW6vWXO6f5+ERfEI43gw37asNkRX+z+J4fyukxejy5Zf5H8PsD3rPUmWTB8N8j2mE40ICSrZwJLRU0V5JI5PyqFNYfW6bAoAPmqQMn+s8cGHGJQghsO8TJQ3t5RgED/+EnoePYNjS+F7W1VLPcFFPRfd3BM5n/PoSUMMfrSs5ROsDlLA3oO3SoDuC6RtFwbzI7BHrBdSLT4KSce01O1YW+b0OWc4GXg8+SFVQZ7Gmrq3+oH5nko3qOApGRR46V0Uj8vqHtRxq+4e3KQfnXb4yz7kPJ1Uc/pX6HdKHs9/AHlL+PGDc1b7tkW0H9OwolaBnEeKHGD+9zHzL6VfK6xBemLI/+a1l9iP+1IMXsgEo27T6FbbDINDNvQj15u++/4j5YLGQIYzVJVm5mEdB+XWw3NevM1eNYWo8q2y9GTY6r73tMqFgMtWLaZo6Ad0pb0bXgfNym/hI9ecM7b9vsE9ad2hy9fojTtmm2UQVLz8IKkLTxPkIuRyh1lfnISVFei/M0PXVHmWh69WdGW/NpWNE9KxnvZ4pkCNwSJjSA6HrzD4oUhW6mEk9V8ZXmjY0dTDAVAiRPzS90jVYBP1rTcNyaz2b347S4QOx1yDb3VyXOfAy9fe5Nc/KjdMF+k6gFu3jffuLi9E3J7Uxq8yzv5iZ/1cUDpb0W/dx6NyGR1WFTcph5soLEWTwjpZms8AgCr7k60WnG7w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(356005)(6916009)(426003)(336012)(82310400004)(83380400001)(40460700001)(8936002)(36860700001)(70206006)(6666004)(4326008)(81166007)(186003)(16526019)(508600001)(7416002)(8676002)(2616005)(47076005)(86362001)(2906002)(70586007)(26005)(1076003)(54906003)(44832011)(316002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:14:29.5643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d040d2e-840d-4752-12c7-08d9c0b7853b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3813
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
 arch/x86/kvm/svm/svm.c             | 19 +++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c             |  6 ++++++
 arch/x86/kvm/x86.c                 |  1 +
 5 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index cefe1d81e2e8..a3172bd59690 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -35,6 +35,7 @@ KVM_X86_OP(get_cpl)
 KVM_X86_OP(set_segment)
 KVM_X86_OP_NULL(get_cs_db_l_bits)
 KVM_X86_OP(set_cr0)
+KVM_X86_OP(post_set_cr3)
 KVM_X86_OP(is_valid_cr4)
 KVM_X86_OP(set_cr4)
 KVM_X86_OP(set_efer)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d5fede05eb5f..22f384320ed1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1342,6 +1342,7 @@ struct kvm_x86_ops {
 			    struct kvm_segment *var, int seg);
 	void (*get_cs_db_l_bits)(struct kvm_vcpu *vcpu, int *db, int *l);
 	void (*set_cr0)(struct kvm_vcpu *vcpu, unsigned long cr0);
+	void (*post_set_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
 	bool (*is_valid_cr4)(struct kvm_vcpu *vcpu, unsigned long cr0);
 	void (*set_cr4)(struct kvm_vcpu *vcpu, unsigned long cr4);
 	int (*set_efer)(struct kvm_vcpu *vcpu, u64 efer);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 208566f63bce..76e906d83a84 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1792,6 +1792,24 @@ static void svm_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
 	vmcb_mark_dirty(svm->vmcb, VMCB_DT);
 }
 
+static void svm_post_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
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
@@ -4622,6 +4640,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.get_cpl = svm_get_cpl,
 	.get_cs_db_l_bits = kvm_get_cs_db_l_bits,
 	.set_cr0 = svm_set_cr0,
+	.post_set_cr3 = svm_post_set_cr3,
 	.is_valid_cr4 = svm_is_valid_cr4,
 	.set_cr4 = svm_set_cr4,
 	.set_efer = svm_set_efer,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 63615d242bdf..075107c1b3f5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3124,6 +3124,11 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		vmcs_writel(GUEST_CR3, guest_cr3);
 }
 
+
+void vmx_post_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+{
+}
+
 static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	/*
@@ -7597,6 +7602,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.get_cpl = vmx_get_cpl,
 	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
 	.set_cr0 = vmx_set_cr0,
+	.post_set_cr3 = vmx_post_set_cr3,
 	.is_valid_cr4 = vmx_is_valid_cr4,
 	.set_cr4 = vmx_set_cr4,
 	.set_efer = vmx_set_efer,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26cb3a4cd0e9..c0d84a4c8049 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10609,6 +10609,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	*mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
 	vcpu->arch.cr3 = sregs->cr3;
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+	static_call(kvm_x86_post_set_cr3)(vcpu, sregs->cr3);
 
 	kvm_set_cr8(vcpu, sregs->cr8);
 
-- 
2.25.1

