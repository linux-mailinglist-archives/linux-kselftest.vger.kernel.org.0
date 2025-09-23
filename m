Return-Path: <linux-kselftest+bounces-42107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B4B94566
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752E71898F23
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E057730EF9E;
	Tue, 23 Sep 2025 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4JCbMrKg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01230DED5;
	Tue, 23 Sep 2025 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604485; cv=fail; b=MFLsa46STz4GOTiUkgb7ltYGeucbRvbZM8N2aiE4zxO/92bNjS/WHfpPU5gmhQ1H0Ida+Uq/Qu7Zh6VWaAZCtE+Lhza81BMzK/d5ZlRbF6ZqnNdAgoHHm+FN5W2nrVCz762iKW9VoZHHxI6pCcI5tdLJf+9sUKwKNpMU6twojBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604485; c=relaxed/simple;
	bh=EbBnoGfT4A+ZFrqRrHxBh6EnYpSdJwQzA4xUra9+3cU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIMjkqkiumlE2rL8wWx/1B3Y0KjzOuJwhTcGXj49ObS3BMjaJX+6QvXg6ol6JFe6I9cHHkwoUQi6n7+BsYXq9akH2UvWaRbLbXzfT77h9QSZwvbwSjCKmJcETLIfAH5xnx/+ZmsgfZ27nCWIag9frUMPvKRwt4qcNX+Jd2whwQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4JCbMrKg; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8lP65gkTyAINo2vGqxWA+IdIhtxzROq6aC5cGpGfeUlUVafJu+i5j0b8vDVYHdL96L+/mNYn4O3KObLEZfdRTMnt5OIdPQgTHFHWXUs2oVNieaEIiaoRlk/Ou+WyCzrHThUIW/kwgWRU5KpBIx2qXbL6rwsXwlZeTL4m5lBepTygmRtrzE6vfR6ZYY6U/WKkM/Azv95Gcjoe1aD59fEGGV8ZAzS5gS59kM3LhSvFVudVnY02Grd8i+AZWO4Ga8bN78P7ib5zzdoSlQ0+jYLfNSKENHqNNTjxjQPRbm1Dn8WwYXJ0X4LA/kUgMFKCBVyYgxhAH5DNXgLlokVCbs8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqFuot1mkSbkCTrID+FJNynNOrSt8B64kmVv0cYS3cM=;
 b=VxWtBOZnY1wRpCyTfhrwd9en8LY+fwueIuZtac7Ef5lUBxfNfIWoqLa29mBQVJ5ihnL+MopvSyPn85Rw2wbPEt1TeW6jqm1JnzBpW1Cp+UykiwYjxDSGOsx0pr1n8RUQlqgnFMQUM4tfyUHfwF92c3HITRN9qT/D/LxyfSAUPl3fswiD+ZJG2QMBQxlAKXKCp6hXUjjwXNZZlXuaThfDmJ2oMasjkqgCoQxk90ose1+RzMiIt849BHXBLxZu8HLEuUywiuCjZg6sb7JGyzThRBgiaFxARojceldESyVqzc1jqDnPU5SG+NewliLdADZPoXX6BEyMkigb5sdfg0lKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqFuot1mkSbkCTrID+FJNynNOrSt8B64kmVv0cYS3cM=;
 b=4JCbMrKgFAKs4zD3mmlDw7RVJ4IR89vO6Eh9BbRgtFtndcWfCH8ef8dZj+je7U21if9CNQhvJcGVi1RYatOdT2KwKldqnQjJaUcB1YwV86x7IfJVeHaBqlPhj5M9xNOlQfgbPWXtFCbdqpkNn6mR2xX5Fad/P60bd20PCpnk67Q=
Received: from CH0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:610:32::26)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:14:40 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::6f) by CH0PR07CA0021.outlook.office365.com
 (2603:10b6:610:32::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:14:40 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:14:35 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 16/35] KVM: selftests: Fix missing definitions in x86 instruction decoder
Date: Tue, 23 Sep 2025 10:39:23 +0530
Message-ID: <20250923050942.206116-17-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3c1816-ddfd-4eee-97c9-08ddfa601911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1J9J6tSvA6rUxd5ljIqP5OwyTu3fc8hVrp132cKMNpq34znCuvbzsVYiH/Y?=
 =?us-ascii?Q?xZBNgBlP8EGYJQCWT23JA2mtkjz1z4YY+3FiXjjr/t6AREiV5OeOhbaBSahP?=
 =?us-ascii?Q?vTklNiNVY5Fx8PCi9LUF0rSWnaBwRr4OOKbB2rTFPT9KnwozA4F8H4JJBFB3?=
 =?us-ascii?Q?HG2GAmk4UE5mOaMfdykoSHggN6w5s3/xsB3QqrdNbujRrI7ofRobJgynTA9T?=
 =?us-ascii?Q?JV49Ij0OX76B6acC7vSEmeK33jzPmK11OompZwIAPAbW7IDJfBZ+4N3C5fK1?=
 =?us-ascii?Q?orOWmENGlww6dagHTQxOHsZQGwUqq96/+VLGYUq6PlobiH14YAo41I1DnGY6?=
 =?us-ascii?Q?bdrKZnZz8ouW2kev/KHm5BxEDhNtDE9140WL6wQu11m+4IIqfPQyOngH7YwY?=
 =?us-ascii?Q?Fp61UuaYxl7sSRD/qagA9pShBSaOqHnJBBsz4KM1d61Cj6F+FwwUP8Nw2d7Z?=
 =?us-ascii?Q?7uefd03n3P3DTKMz9ZNjtrncjnYYFwgjZxTqkIidhs1QU/EHpsTAQ4uEj9lO?=
 =?us-ascii?Q?vHZhTYNeA2USWDpHNqDiZlrtFo6QXq8GSbPAH0HdL+e24lMwN5d+RqJus4ul?=
 =?us-ascii?Q?w1XztiR/gCHGk4+jw5TePkYYzaowWcbSoyKHqoH9sI3tsoCyT3O7axp7A0vC?=
 =?us-ascii?Q?SnS4Ni2QKEpBy77KXNvxM+U0D7KZ9krUfqtQ8d9gLFxdFOi0n7dkoDAdE900?=
 =?us-ascii?Q?UUjLoA4ls6RHtEEF/GClQ+VpV1lVRxb2PZ5UsSGatUPteRXCJJ8whwVqe3GG?=
 =?us-ascii?Q?O/zuSYvLhNQ+3XDMhRw2VE7a2dnFNJ9/Km1O+sg1R9I5FA+6SJqntapMAD5i?=
 =?us-ascii?Q?V58KBODrBBJcWQb6HTR+6P6LRNfY1QmCCnMpUPHGsDjSHydifHJ7D9B5ee4o?=
 =?us-ascii?Q?z+9iqrm4y8Lpbyi5H5k1wpbYTT4XCz3JrggS94OEW7Enn2wyt3F8nzEMkwZU?=
 =?us-ascii?Q?q4veOaPrqJatPg8Px4t4jkmn2WjG0H6KDG9u2oSBixrtrKt+jSgZN8SwoLtw?=
 =?us-ascii?Q?Zljgjqs6b+CNS8Y5Yq2TSliNSifiDP6HujouI/Iw6L95AX/TEfmR+2WYP035?=
 =?us-ascii?Q?OAd/gHxBhzEFzU30hg22clIWjiJqrgHo0Rwz7hrwm6N+yli0WNnNI7RjMTT2?=
 =?us-ascii?Q?vEttrzgURsFPlgrobd2ImGDbKunUqo4zL01vwWPZGuTVgEwHkFZ36zZtMccE?=
 =?us-ascii?Q?choVEL1mF+VcEefbhUFET8uVQ7U7IlvLbc0NsssbAWCKsh3uGh63F5M4ECF2?=
 =?us-ascii?Q?pJ4ihYU/RLXLwOeZ4n6cxOalsVunfwdxz8mdwx6YQIKl8fSTRHaY1+x1OY6Z?=
 =?us-ascii?Q?Tkmrj53CYG21gmD/Y57IWTiH3R0wZ40MmpuDwQg6oYwyBOcCVPD3+I/z9lB/?=
 =?us-ascii?Q?rInsLsKpZtBvXZdXjTX3NmHob/H6MiS6JNeU0QP0yXiE6PDmXfMBD7LN1mQU?=
 =?us-ascii?Q?I1dBxORLJo3+D33wsOk+KV7UJxLU2/L3LmiCiW53qyM6jl87NArePHGpSffJ?=
 =?us-ascii?Q?6IdbkSZAWT2fdS6RAlnOUV109BMFF3//MvlR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:14:40.0321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3c1816-ddfd-4eee-97c9-08ddfa601911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

The insn-eval x86 selftest lib uses kernel-internal macros savesegment and
rdmsrq, which are typically defined in kernel headers like <asm/segment.h>
and <asm/msr.h>. These headers are not available in the userspace build
environment for selftests, leading to build failures.

Fix this by providing local definitions for the missing symbols and
replacing with the functional equivalent definitions available to the
selftest.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/insn-eval.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/insn-eval.c b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
index bb7845500f3c..fb393aaf9f7f 100644
--- a/tools/testing/selftests/kvm/lib/x86/insn-eval.c
+++ b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
@@ -18,6 +18,9 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "insn: " fmt
 
+#define savesegment(seg, value)				\
+	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
+
 enum reg_type {
 	REG_TYPE_RM = 0,
 	REG_TYPE_REG,
@@ -25,6 +28,11 @@ enum reg_type {
 	REG_TYPE_BASE,
 };
 
+static __always_inline int user_mode(struct pt_regs *regs)
+{
+	return !!(regs->cs & 3);
+}
+
 /*
  * is_string_insn() - Determine if instruction is a string instruction
  * @insn:	Instruction containing the opcode to inspect
@@ -528,16 +536,16 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 	 */
 
 	if (seg_reg_idx == INAT_SEG_REG_FS) {
-		rdmsrq(MSR_FS_BASE, base);
+		base = rdmsr(MSR_FS_BASE);
 	} else if (seg_reg_idx == INAT_SEG_REG_GS) {
 		/*
 		 * swapgs was called at the kernel entry point. Thus,
 		 * MSR_KERNEL_GS_BASE will have the user-space GS base.
 		 */
 		if (user_mode(regs))
-			rdmsrq(MSR_KERNEL_GS_BASE, base);
+			base = rdmsr(MSR_KERNEL_GS_BASE);
 		else
-			rdmsrq(MSR_GS_BASE, base);
+			base = rdmsr(MSR_GS_BASE);
 	} else {
 		base = 0;
 	}
-- 
2.34.1


