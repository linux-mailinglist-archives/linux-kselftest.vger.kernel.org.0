Return-Path: <linux-kselftest+bounces-29636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E30A6DABE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947393B33F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6441ADC86;
	Mon, 24 Mar 2025 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5NOHTgwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD096200CB;
	Mon, 24 Mar 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821395; cv=fail; b=WMw0VeBisa2BtXIrBIOfv2qycwDCuQBGZIBH2Flj4kQM7A3lOzocmYo6v/vMrd0l5BFHU7Ciu7VvUFMGvT0jecLAE0FasmWI07HG4q1ct2WtVEqUx7kqzCRTbWYNmi5B7nydm5DKSGvSNf6QkW/Ec/JO7B5SY/26xM7hVB4h8rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821395; c=relaxed/simple;
	bh=CNJPbtzph0aKEFLduNoLhAhPJAJAKoXYBbBwKDgqu3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+GNK8nbdMA2JzDkon/+mkEJ0r8vqC49Ai3JgoeOAOvg/cDYaQf7HP9S3FUyabqmyJSyrikWJKh711RU0XY0SZX2s+Uu4wKyvNcERSOjmVodqjW6DRmOPVvwdaAhK4jQeO+Mk71eI+zZ+bJrSmavUzXlY9+PH1ajoY5BC0HnKLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5NOHTgwH; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbPth/INHpR8swiSu/YrI73WlG+nWK74rq2WkAwEhY9IQfp+OBO3neOrXTQQ45faHE2+/FiRG4eOnSY5KYKvrjNPEDysE6YAKaaMk53DHgRiMcBQzE/IJjh1VwRhu71LrNzhjEN90/EOq9Wxu6ovg4TbZpA4MB2wlcYCZEpoLieesNvzZ7bIP+de4oxEARgE5QQkgHt+dYPOMlL2jHp7VVsMk+q7QwUp1NKjbmiDKpfYZyXAuj/5XLVnoLw8va7RswLI4Ao1g4bOujyENTxWtr/9BPc/mc7ZChxhcnesTWrAKQ2VYrCpGMjq7jw+ZCoVvYW3He2m7aO6jxKOD4hiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEYo4QKmQK4kOdiFQoLuAIl624Dljd56uc2HwPB0e+s=;
 b=RoglkIhwsQvpHrRJ6ko6BhKOqwi38z/LLUxQ6t8/bfywi8yXI+fSfLXLF0wKJaHMtvsLt2X9ntuKFw8xjpVwN9+nHpHfgz49ihBeoCiIACYqT/sFJk2oYyGy5DeVjbOLNoGbfdoD8rhHccxwG8Mu2sJRfvz+Tpa/fxmafT2JSlQIFgMBhKL5oWkPGAXIqqnSf1q2q6AaCB3FdhCvN2VwfoE6nzFb/sAtCTgzNAd1nPzqqW4ozWCpNNoY7a0+cuUeXJY/4qC1pztVJyUhQPYiwuvg5WGV+D/Ux/ZdB7waOzCWS/eqC5xUT27dt2UquunQo7tpvRTja4i6vdIvEiyyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEYo4QKmQK4kOdiFQoLuAIl624Dljd56uc2HwPB0e+s=;
 b=5NOHTgwHC+QrPXVyxeMkFNGKXPyKt8eCFXLlpE/dc+YFuHSGqpJ1UOOniLg4dM4y0pHCju9VasvTJoqCRcDdpd7dbKA/vp6noUU0aq8TKPXJ+ys5+YguYzll0WlELxzedIdAem4vuQKcsZz0UB6mUUqx7u6MGy+ZDHjKGwKrMLg=
Received: from BYAPR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:74::14)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:03:11 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::4a) by BYAPR05CA0037.outlook.office365.com
 (2603:10b6:a03:74::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 13:03:10 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 08:03:09 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<thomas.lendacky@amd.com>, <manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v4 1/5] KVM: x86: Preparatory patch to move linear_rip out of kvm_pio_request
Date: Mon, 24 Mar 2025 13:02:44 +0000
Message-ID: <20250324130248.126036-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324130248.126036-1-manali.shukla@amd.com>
References: <20250324130248.126036-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e75fab-fbab-4012-dc25-08dd6ad43aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OubhptYA2JoEb1pmR4nNwsBbv4SqniNmFY7I+M+4orhF6Uxz89qaViAhgiFV?=
 =?us-ascii?Q?d1VDBVkMTrcgWxUHMZN+PbSGHcH0aoM/pH5OAEPfiF50e3YfVt5qvO1GHPRB?=
 =?us-ascii?Q?mnKAQe3R7QKdp2DOAN6h1oWlN/1vBxPIT5VswZK14Jw73K8M0UW1ydNrr3ok?=
 =?us-ascii?Q?67hfeM8B+x/Pvf78JD+YZDCTLHQogRaEsWhPhcE7YisZ6GoVqRJr+4R3tHbU?=
 =?us-ascii?Q?5VXVcge51cLF7oJkDe5LbsatlMyf39XkfBK5P1QDB3QpWx4twaE+VBsaQoU6?=
 =?us-ascii?Q?nt3AHGxrl9IEiORmKnAGx04VKiLIAIVi9BmcFwf8u8uarf2J50hQk2J8qd8c?=
 =?us-ascii?Q?X45QLXGeb3Tj0m8e306zcPXORUVGLTumWDY3423vxOLZcM03j/Ox3TOY+rCU?=
 =?us-ascii?Q?WfZK7QvXVMG/pppfOAc68YM7jolzRDpxjhezRpBsur4UXeMzgRvcr79Zr3OZ?=
 =?us-ascii?Q?JZT4QVal0XRXnRWl+++9m2+/6j0AgQ6VjL6JivPRzeYFE68pkQbHriMfSdDT?=
 =?us-ascii?Q?PCMBXxWvliFL1yIpmg/uUzXkF3PX9obzbHbmKiT7vW1B7VQONcvXPGVyOMj4?=
 =?us-ascii?Q?xr6XH1XUPm84o5q7+dkkxNfMKFJj8KiKGtLt50fk8HIQ9nAvQEVwaiBtFWft?=
 =?us-ascii?Q?hxz6GfJ4M0OweZ/uJtgNIIzjPzfb06YGILIkbecIEXQVMa/Tas3tUJxRs5/7?=
 =?us-ascii?Q?g/QB0NiP0CgRipmdIcd0Dt/3hbAcI7M30S/HSYgj8j+O6R56veuoRXgwI50m?=
 =?us-ascii?Q?s2NIJ/89m8611J1zYeh/BPOOxPhY5LemlDiLz/8z3omyWHofhAhiZuURQdLs?=
 =?us-ascii?Q?lUhCV2kfV5OPDe9k63c0niyyhNdfA1k/AMwkYq0SfRMKZfo2MhhbzLqYzXXj?=
 =?us-ascii?Q?uIV9vM2lnk0Z8VY/xbJsaHQCMArTKwY3YTQ2BfRG+jUknbdqLq3nmTQuQlH/?=
 =?us-ascii?Q?DOOxbXu6gS8NrNsWrf+Lv9CYlTSaZpHw9LWidbIi1UFkY7xrsdJp33yv+Njz?=
 =?us-ascii?Q?obW40b4S/2lP+MOOMUZ5KaImdm38OpkQ5zvJ/3BrY0qU0yuBVwANB7zSIZYg?=
 =?us-ascii?Q?eIhGXuW62TZ/UfWWWrEudCa9Fud+hF+nDaEMoX4YMswwlvBntQnyJs1qbx5l?=
 =?us-ascii?Q?3KqxiCJBNQ6/ARVWFotk/xo2oEIlmhWyobJxIwG76bSOYYC2XrFuQmLAMc7L?=
 =?us-ascii?Q?bW4XOWXiHXjS//1usZ5kTZhUzgjSE5kT7/VM3g2hu5aF0dG+uZ1yxn91jj/D?=
 =?us-ascii?Q?f2Pn7JM454/aI2VnR2HEpsbs2WvftUACeIkthPwo8LgZWVapZmoacc44Y1kc?=
 =?us-ascii?Q?NcG8Kjt2BRfYahA2cuUN3suJcZL4yALfFBsEhDdVtENlBdT2wojrFP1kz2me?=
 =?us-ascii?Q?CDbv6pKJc2Zyf/rhQ/9stS6vGCQz2t//jgsK87378G5k7UIuEwF7E6MdAoFX?=
 =?us-ascii?Q?v/OvFQB1uCXYE7xiKQOrrmK6XQ90ozxDERx7hHBNv55m1VUV08eJGm2QrhkI?=
 =?us-ascii?Q?Kp+cOLSkKlCjWE0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:03:10.5347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e75fab-fbab-4012-dc25-08dd6ad43aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916

Add a refactoring prep patch to move linear_rip out of kvm_pio_request
and place it next to complete_userspace_io.  There's nothing port I/O
specific about linear_rip field, it just so happens to that port I/O is the
only case where KVM's ABI is to let userspace stuff state (to emulate
RESET) without first completing the I/O instruction.

No functional changes intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/x86.c              | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d881e7d276b1..f8a564dd5422 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -410,7 +410,6 @@ struct kvm_rmap_head {
 };
 
 struct kvm_pio_request {
-	unsigned long linear_rip;
 	unsigned long count;
 	int in;
 	int port;
@@ -909,6 +908,7 @@ struct kvm_vcpu_arch {
 	bool emulate_regs_need_sync_to_vcpu;
 	bool emulate_regs_need_sync_from_vcpu;
 	int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
+	unsigned long cui_linear_rip;
 
 	gpa_t time;
 	s8  pvclock_tsc_shift;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69c20a68a3f0..8282ae350eec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9324,7 +9324,7 @@ static int complete_fast_pio_out(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.pio.count = 0;
 
-	if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.pio.linear_rip)))
+	if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip)))
 		return 1;
 
 	return kvm_skip_emulated_instruction(vcpu);
@@ -9349,7 +9349,7 @@ static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
 			complete_fast_pio_out_port_0x7e;
 		kvm_skip_emulated_instruction(vcpu);
 	} else {
-		vcpu->arch.pio.linear_rip = kvm_get_linear_rip(vcpu);
+		vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
 		vcpu->arch.complete_userspace_io = complete_fast_pio_out;
 	}
 	return 0;
@@ -9362,7 +9362,7 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
 	/* We should only ever be called with arch.pio.count equal to 1 */
 	BUG_ON(vcpu->arch.pio.count != 1);
 
-	if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.pio.linear_rip))) {
+	if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip))) {
 		vcpu->arch.pio.count = 0;
 		return 1;
 	}
@@ -9391,7 +9391,7 @@ static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
 		return ret;
 	}
 
-	vcpu->arch.pio.linear_rip = kvm_get_linear_rip(vcpu);
+	vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
 	vcpu->arch.complete_userspace_io = complete_fast_pio_in;
 
 	return 0;

base-commit: c9ea48bb6ee6b28bbc956c1e8af98044618fed5e
-- 
2.34.1


