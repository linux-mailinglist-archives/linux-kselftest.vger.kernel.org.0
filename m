Return-Path: <linux-kselftest+bounces-42108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC36B9457B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F3F7B23C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1426CE3C;
	Tue, 23 Sep 2025 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="STVluzmq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5130E82A;
	Tue, 23 Sep 2025 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604507; cv=fail; b=SehWOHzf3OIydIkZZm7BlDZPfqKsz6Yt7Qs9vRQmu43Ce8LfE9XART1Njkx9EelGlzJH7F40OGEyNiR+BHl/ICULbcjq8Le3VuYJzwj/2Aj3rE0RYfBaSvr2OokYOBHHjhOvaeJDdCoseY8ouwAZ4mrkozAVefHejqEYyUkcnYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604507; c=relaxed/simple;
	bh=KXDWZNG6Ap/6Gefx7y9IWYh26V454/olqvOMA4i9W2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGge66DUEKUJzev1Bq8u44upPPNsF4UUtLRuZDShgfi8klZ01cjZwNP3Q/fUhllgipDX1VkHrO9GzghoXYUPemOr3nimQ7I1WcttYTDSVO43ru1yKYPpddMYrZgptHooZXjPpLTQ+XEtL78G46rpRa64ZEUt4tJF1Y+79cp+Qxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=STVluzmq; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwwK7UM1nkOoaqrxtp8CtnMLjsdIqjPI1kT2iN8HefcobSnPYdaayWUSCVwHXfpvMAw69q0NIixVWdSMZGZdMitZ0+y9Z0YJYREb8Cgq9HNcciUTSScHNVa98A4Wpemo/YDTqNlCX+kwmAStQ3N/GCEBSB6KPQGEUZTcccynuf/9e467wVN4j6vWH57onbNrf13ElqHBUXGoB0fOL7M0arcCVHFwjFOD+dHpyBBilKT9Q0WV9yDjGWt/QINo/uoOd8iWK6j6/meoWRcNbpnAtD+3s/s2K4S5GnOUOJuMbftKjJXjZ4RrCrRrb/1iFsVTl4as8Vsv2zvqDEj8jAFycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWJMBUpVPhroSV8f77RjqnSwQsLsxGJS7nBtw+5eMCE=;
 b=q6otPQQlsPMLVoKASKI79rmIGww09fUwG128zpXt0lZ1zy2ZrZtgTj4mUZLvC3ktZ7i1qOo6wGQFS51urWx6nPV8bWpaKyPth6ZxVjp/ULY+sqI7/M5hNbA1oXEAa3rTDlamZz28ysK4M3GkVvKcE92AEVInZlOx8lTYdxhfvhTTNMCAjX6yLoyDrAPaAhy7VfBKD5AY6FBPw9TOp9xs9qaiQvNU9IKoShbI+EURgQv/YE8F2/bgzvmdaKt8O1PVTMBbKTPPfvLzsh1tqy7zuGQiyPsn27KfGRVTG8inSs8mC8mh3NFfpZr44q8u4FEoo1iYnxdhbHbekTgUe1E6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWJMBUpVPhroSV8f77RjqnSwQsLsxGJS7nBtw+5eMCE=;
 b=STVluzmq24xgm3+YD9Qs3mbT1LvabLfSCWl/y91tBihW/6+UtHhflEsQDol/FeYKKWExWcLCznKMCP5TLfyy9RRtSlonwsH5bEI8HRHvRcMRt2SR0sRSe8gotxF/bn69DRY8V3BWUhrMmdm8U5gPOET5lgHEyFQ02fDh0L+VHYo=
Received: from CH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:32::22)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Tue, 23 Sep
 2025 05:14:58 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::44) by CH0PR07CA0017.outlook.office365.com
 (2603:10b6:610:32::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:14:57 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:14:52 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 17/35] KVM: selftests: Change pt_regs to ex_regs for selftest use
Date: Tue, 23 Sep 2025 10:39:24 +0530
Message-ID: <20250923050942.206116-18-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c4b7e4-603f-4f82-d267-08ddfa6023ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O2klLh43wDCpw2WFnIIvK1jV2Yd21wSBAdupa6h4BoAtTVVQMnmP4VIqLVQV?=
 =?us-ascii?Q?O/I10vV357qTLrd3XTgebk2vsYtN+PrlpwERgyYrObEP0vUKGcMusL7r2CUH?=
 =?us-ascii?Q?lcjyfdYSJ/I2ih9QRkfbwXKQLqM6tmqU4UXbbb6tFz5O/8MoRBfohYqzfOTv?=
 =?us-ascii?Q?S+q3/K4iw2ABnRhE3knvr7oUM0WFDcl9ETk7UGYQBsNRkxnCSkC2f8t1MqVL?=
 =?us-ascii?Q?DAusZ1NhzejMe2Wmsf87Jyy8UyoFENTummSvKl20R12OvbYhKpDQ8TBL3Vo3?=
 =?us-ascii?Q?FDv5F7Rz70RTB+ZhSOIyDGhTY/LIwh7arhWuaLiM+jIG8aLJf1blDBjY3LRk?=
 =?us-ascii?Q?YUB7eN6rPRZSqKToQMEwZ+b2KpEd85GYQVYOOyy2uKEPMMU6EZkPGFkKNBYM?=
 =?us-ascii?Q?u2iNM8WYBCkolH5MhrTHHXI8F7RldQZDc1Wni5p4Rd7AkbZUYq885yCDUfZ5?=
 =?us-ascii?Q?FipI0IgRFtUWYoYsaBRoun5MmpOA84pPCQUQLAeYjLqEppa2rnH9e7rFe5te?=
 =?us-ascii?Q?kcyw9KfZBxTIRSEQiuUddPcEckV/8kogTRfL+/hr3rtzj7oI5nDBD7C6fSSz?=
 =?us-ascii?Q?bbSWm5IX6AyAE4e922c3otnJo5ggLlQLPzdnbzq56NgA6E1CDfHWozIXmVnp?=
 =?us-ascii?Q?u+V2xfH5Jd/1fR64QyZ55Qesrh3vbJSs4mM9tvU6SoOVkSnRllLy/ArKmmeb?=
 =?us-ascii?Q?Ys2wTH/xewTLNkYF/86CqZgYJWyA9oQ+MCCcSfdxQEbP3MBvF0kh3Bd1WnBF?=
 =?us-ascii?Q?/l3t5TISsxTqrAHi84jamsqoWmv4M2VL3THGyFQlSZUO/KqvmgjjjyMULOi6?=
 =?us-ascii?Q?8ABxN+r3toqdoR64JA6OqdH52amfhoVtCa3oKohuArPd9NJWv15Kfds7wRjZ?=
 =?us-ascii?Q?6CwvD+TXnaVBPuPNUtDpENj0uPB4uNKkWWQywU6C42gGaGTF6f06GI39af45?=
 =?us-ascii?Q?UFYPMM4gGIj9n08rD81PAHnjxD2N5VrnFt1/mwwcx0qRz3/8m0ec95KXNVjQ?=
 =?us-ascii?Q?J+/uHFGFzCjmEVdUHEDAO4rSVDr1y9r8q0SpaEOZgdRcGGi83c14bhiaRY7O?=
 =?us-ascii?Q?WXnqUUyqUGrYS/92o3QfXJSWGbJzCxKtteCwHSed7bv9dKXvXwgYCG6HIpb1?=
 =?us-ascii?Q?HmPOEDDuV1YEGqo98G/2alT+9Yoin8lS9+QSwWYyPUbhgDeo/y6PJdvusq4Z?=
 =?us-ascii?Q?kmNOktjjSxKf/nrnd6eEkl89JQCxzG+hFmfC7Kf7TIGd1FtFmnAKSpX0VEGQ?=
 =?us-ascii?Q?XJ34xtiekb9IvbXUI1TEK/YC9hgyJQj82nxA51wppEqAQfreXs8kcbcGxhIG?=
 =?us-ascii?Q?Mno1HLXCW51o47cgn2/AQhLyP5p/Z/JVYAs2f/NSBwUZOT6Ebv58VCr4X8GW?=
 =?us-ascii?Q?VxIIn5fZ1P6OiJsmqfvWSk/UIO4dF772/6n9qbQnR9MR1Fy8TaqJBupvR/bI?=
 =?us-ascii?Q?twaDOOR1PuyQwH3kYip0EHx+PONV/XKpfOGZ2oXrXIMXwgV4FlOqn/3HR2TF?=
 =?us-ascii?Q?/hO5PaTghPig7lHj3zJB4iYyYStfDGcB+li6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:14:57.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c4b7e4-603f-4f82-d267-08ddfa6023ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/include/x86/insn-eval.h     |  24 +--
 .../selftests/kvm/include/x86/processor.h     |   2 +
 .../testing/selftests/kvm/lib/x86/insn-eval.c | 159 +++++++++---------
 3 files changed, 96 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/insn-eval.h b/tools/testing/selftests/kvm/include/x86/insn-eval.h
index 68d49199f991..0547b622295a 100644
--- a/tools/testing/selftests/kvm/include/x86/insn-eval.h
+++ b/tools/testing/selftests/kvm/include/x86/insn-eval.h
@@ -8,25 +8,27 @@
 
 #include <stdbool.h>
 
+#include "processor.h"
+
 #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
 #define INSN_CODE_SEG_OPND_SZ(params) (params & 0xf)
 #define INSN_CODE_SEG_PARAMS(oper_sz, addr_sz) (oper_sz | (addr_sz << 4))
 
-int pt_regs_offset(struct pt_regs *regs, int regno);
+int ex_regs_offset(struct ex_regs *regs, int regno);
 
 bool insn_has_rep_prefix(struct insn *insn);
-void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
-int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
-int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
-unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs);
-unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
-int insn_get_code_seg_params(struct pt_regs *regs);
-int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip);
-int insn_fetch_from_user(struct pt_regs *regs,
+void __user *insn_get_addr_ref(struct insn *insn, struct ex_regs *regs);
+int insn_get_modrm_rm_off(struct insn *insn, struct ex_regs *regs);
+int insn_get_modrm_reg_off(struct insn *insn, struct ex_regs *regs);
+unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct ex_regs *regs);
+unsigned long insn_get_seg_base(struct ex_regs *regs, int seg_reg_idx);
+int insn_get_code_seg_params(struct ex_regs *regs);
+int insn_get_effective_ip(struct ex_regs *regs, unsigned long *ip);
+int insn_fetch_from_user(struct ex_regs *regs,
 			 unsigned char buf[MAX_INSN_SIZE]);
-int insn_fetch_from_user_inatomic(struct pt_regs *regs,
+int insn_fetch_from_user_inatomic(struct ex_regs *regs,
 				  unsigned char buf[MAX_INSN_SIZE]);
-bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
+bool insn_decode_from_regs(struct insn *insn, struct ex_regs *regs,
 			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
 enum insn_mmio_type {
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 2efb05c2f2fb..035ced9130c2 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1161,6 +1161,8 @@ struct ex_regs {
 	uint64_t rip;
 	uint64_t cs;
 	uint64_t rflags;
+	uint64_t rsp;
+	uint64_t ss;
 };
 
 struct idt_entry {
diff --git a/tools/testing/selftests/kvm/lib/x86/insn-eval.c b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
index fb393aaf9f7f..369530badba9 100644
--- a/tools/testing/selftests/kvm/lib/x86/insn-eval.c
+++ b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
@@ -21,6 +21,12 @@
 #define savesegment(seg, value)				\
 	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
 
+static inline unsigned long regs_get_register(struct ex_regs *regs,
+					      unsigned int offset)
+{
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
+
 enum reg_type {
 	REG_TYPE_RM = 0,
 	REG_TYPE_REG,
@@ -28,7 +34,7 @@ enum reg_type {
 	REG_TYPE_BASE,
 };
 
-static __always_inline int user_mode(struct pt_regs *regs)
+static __always_inline int user_mode(struct ex_regs *regs)
 {
 	return !!(regs->cs & 3);
 }
@@ -148,7 +154,7 @@ static int get_seg_reg_override_idx(struct insn *insn)
 /*
  * check_seg_overrides() - check if segment override prefixes are allowed
  * @insn:	Valid instruction with segment override prefixes
- * @regoff:	Operand offset, in pt_regs, for which the check is performed
+ * @regoff:	Operand offset, in ex_regs, for which the check is performed
  *
  * For a particular register used in register-indirect addressing, determine if
  * segment override prefixes can be used. Specifically, no overrides are allowed
@@ -161,7 +167,7 @@ static int get_seg_reg_override_idx(struct insn *insn)
  */
 static bool check_seg_overrides(struct insn *insn, int regoff)
 {
-	if (regoff == offsetof(struct pt_regs, di) && is_string_insn(insn))
+	if (regoff == offsetof(struct ex_regs, rdi) && is_string_insn(insn))
 		return false;
 
 	return true;
@@ -171,7 +177,7 @@ static bool check_seg_overrides(struct insn *insn, int regoff)
  * resolve_default_seg() - resolve default segment register index for an operand
  * @insn:	Instruction with opcode and address size. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @off:	Operand offset, in pt_regs, for which resolution is needed
+ * @off:	Operand offset, in ex_regs, for which resolution is needed
  *
  * Resolve the default segment register index associated with the instruction
  * operand register indicated by @off. Such index is resolved based on defaults
@@ -184,7 +190,7 @@ static bool check_seg_overrides(struct insn *insn, int regoff)
  *
  * -EINVAL in case of error.
  */
-static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
+static int resolve_default_seg(struct insn *insn, struct ex_regs *regs, int off)
 {
 	return INAT_SEG_REG_IGNORE;
 }
@@ -193,7 +199,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
  * resolve_seg_reg() - obtain segment register index
  * @insn:	Instruction with operands
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Operand offset, in pt_regs, used to determine segment register
+ * @regoff:	Operand offset, in ex_regs, used to determine segment register
  *
  * Determine the segment register associated with the operands and, if
  * applicable, prefixes and the instruction pointed by @insn.
@@ -221,7 +227,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
  * are done using helper functions.
  *
  * The operand register, @regoff, is represented as the offset from the base of
- * pt_regs.
+ * ex_regs.
  *
  * As stated, the main use of this function is to determine the segment register
  * index based on the instruction, its operands and prefixes. Hence, @insn
@@ -241,7 +247,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
  *
  * -EINVAL in case of error.
  */
-static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
+static int resolve_seg_reg(struct insn *insn, struct ex_regs *regs, int regoff)
 {
 	int idx;
 
@@ -251,7 +257,7 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
 	 * be used. Hence, it is not necessary to inspect the instruction,
 	 * which may be invalid at this point.
 	 */
-	if (regoff == offsetof(struct pt_regs, ip))
+	if (regoff == offsetof(struct ex_regs, rip))
 		return INAT_SEG_REG_IGNORE;
 
 	if (!insn)
@@ -282,7 +288,7 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
  * @seg_reg_idx:	Segment register index to use
  *
  * Obtain the segment selector from any of the CS, SS, DS, ES, FS, GS segment
- * registers. CS and SS are obtained from pt_regs. DS, ES, FS and GS are
+ * registers. CS and SS are obtained from ex_regs. DS, ES, FS and GS are
  * obtained by reading the actual CPU registers. This done for only for
  * completeness as in X86_64 segment registers are ignored.
  *
@@ -293,7 +299,7 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
  *
  * -EINVAL on error.
  */
-static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
+static short get_segment_selector(struct ex_regs *regs, int seg_reg_idx)
 {
 	unsigned short sel;
 
@@ -321,35 +327,35 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 	}
 }
 
-static const int pt_regoff[] = {
-	offsetof(struct pt_regs, ax),
-	offsetof(struct pt_regs, cx),
-	offsetof(struct pt_regs, dx),
-	offsetof(struct pt_regs, bx),
-	offsetof(struct pt_regs, sp),
-	offsetof(struct pt_regs, bp),
-	offsetof(struct pt_regs, si),
-	offsetof(struct pt_regs, di),
-	offsetof(struct pt_regs, r8),
-	offsetof(struct pt_regs, r9),
-	offsetof(struct pt_regs, r10),
-	offsetof(struct pt_regs, r11),
-	offsetof(struct pt_regs, r12),
-	offsetof(struct pt_regs, r13),
-	offsetof(struct pt_regs, r14),
-	offsetof(struct pt_regs, r15),
+static const int ex_regoff[] = {
+	offsetof(struct ex_regs, rax),
+	offsetof(struct ex_regs, rcx),
+	offsetof(struct ex_regs, rdx),
+	offsetof(struct ex_regs, rbx),
+	offsetof(struct ex_regs, rsp),
+	offsetof(struct ex_regs, rbp),
+	offsetof(struct ex_regs, rsi),
+	offsetof(struct ex_regs, rdi),
+	offsetof(struct ex_regs, r8),
+	offsetof(struct ex_regs, r9),
+	offsetof(struct ex_regs, r10),
+	offsetof(struct ex_regs, r11),
+	offsetof(struct ex_regs, r12),
+	offsetof(struct ex_regs, r13),
+	offsetof(struct ex_regs, r14),
+	offsetof(struct ex_regs, r15),
 };
 
-int pt_regs_offset(struct pt_regs *regs, int regno)
+int ex_regs_offset(struct ex_regs *regs, int regno)
 {
-	if ((unsigned)regno < ARRAY_SIZE(pt_regoff))
-		return pt_regoff[regno];
+	if ((unsigned)regno < ARRAY_SIZE(ex_regoff))
+		return ex_regoff[regno];
 	return -EDOM;
 }
 
 static int get_regno(struct insn *insn, enum reg_type type)
 {
-	int nr_registers = ARRAY_SIZE(pt_regoff);
+	int nr_registers = ARRAY_SIZE(ex_regoff);
 	int regno = 0;
 
 	/*
@@ -419,7 +425,7 @@ static int get_regno(struct insn *insn, enum reg_type type)
 	return regno;
 }
 
-static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
+static int get_reg_offset(struct insn *insn, struct ex_regs *regs,
 			  enum reg_type type)
 {
 	int regno = get_regno(insn, type);
@@ -427,7 +433,7 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
 	if (regno < 0)
 		return regno;
 
-	return pt_regs_offset(regs, regno);
+	return ex_regs_offset(regs, regno);
 }
 
 /*
@@ -437,7 +443,7 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
  * @offs1:	Offset of the first operand register
  * @offs2:	Offset of the second operand register, if applicable
  *
- * Obtain the offset, in pt_regs, of the registers indicated by the ModRM byte
+ * Obtain the offset, in ex_regs, of the registers indicated by the ModRM byte
  * in @insn. This function is to be used with 16-bit address encodings. The
  * @offs1 and @offs2 will be written with the offset of the two registers
  * indicated by the instruction. In cases where any of the registers is not
@@ -447,7 +453,7 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
  *
  * 0 on success, -EINVAL on error.
  */
-static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
+static int get_reg_offset_16(struct insn *insn, struct ex_regs *regs,
 			     int *offs1, int *offs2)
 {
 	/*
@@ -456,21 +462,21 @@ static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
 	 * ModR/M Byte" of the Intel Software Development Manual.
 	 */
 	static const int regoff1[] = {
-		offsetof(struct pt_regs, bx),
-		offsetof(struct pt_regs, bx),
-		offsetof(struct pt_regs, bp),
-		offsetof(struct pt_regs, bp),
-		offsetof(struct pt_regs, si),
-		offsetof(struct pt_regs, di),
-		offsetof(struct pt_regs, bp),
-		offsetof(struct pt_regs, bx),
+		offsetof(struct ex_regs, rbx),
+		offsetof(struct ex_regs, rbx),
+		offsetof(struct ex_regs, rbp),
+		offsetof(struct ex_regs, rbp),
+		offsetof(struct ex_regs, rsi),
+		offsetof(struct ex_regs, rdi),
+		offsetof(struct ex_regs, rbp),
+		offsetof(struct ex_regs, rbx),
 	};
 
 	static const int regoff2[] = {
-		offsetof(struct pt_regs, si),
-		offsetof(struct pt_regs, di),
-		offsetof(struct pt_regs, si),
-		offsetof(struct pt_regs, di),
+		offsetof(struct ex_regs, rsi),
+		offsetof(struct ex_regs, rdi),
+		offsetof(struct ex_regs, rsi),
+		offsetof(struct ex_regs, rdi),
 		-EDOM,
 		-EDOM,
 		-EDOM,
@@ -521,7 +527,7 @@ static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
  *
  * -1L in case of error.
  */
-unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
+unsigned long insn_get_seg_base(struct ex_regs *regs, int seg_reg_idx)
 {
 	unsigned long base;
 	short sel;
@@ -542,10 +548,7 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 		 * swapgs was called at the kernel entry point. Thus,
 		 * MSR_KERNEL_GS_BASE will have the user-space GS base.
 		 */
-		if (user_mode(regs))
-			base = rdmsr(MSR_KERNEL_GS_BASE);
-		else
-			base = rdmsr(MSR_GS_BASE);
+		base = rdmsr(MSR_GS_BASE);
 	} else {
 		base = 0;
 	}
@@ -569,7 +572,7 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
  *
  * Zero is returned on error.
  */
-static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
+static unsigned long get_seg_limit(struct ex_regs *regs, int seg_reg_idx)
 {
 	short sel;
 
@@ -588,9 +591,9 @@ static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
  * Returns:
  *
  * The register indicated by the reg part of the ModRM byte. The
- * register is obtained as an offset from the base of pt_regs.
+ * register is obtained as an offset from the base of ex_regs.
  */
-int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
+int insn_get_modrm_reg_off(struct insn *insn, struct ex_regs *regs)
 {
 	return get_reg_offset(insn, regs, REG_TYPE_REG);
 }
@@ -603,9 +606,9 @@ int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
  * Returns:
  *
  * The register indicated by the reg part of the ModRM byte.
- * The register is obtained as a pointer within pt_regs.
+ * The register is obtained as a pointer within ex_regs.
  */
-unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
+unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct ex_regs *regs)
 {
 	int offset;
 
@@ -619,7 +622,7 @@ unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
  * get_seg_base_limit() - obtain base address and limit of a segment
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Operand offset, in pt_regs, used to resolve segment descriptor
+ * @regoff:	Operand offset, in ex_regs, used to resolve segment descriptor
  * @base:	Obtained segment base
  * @limit:	Obtained segment limit
  *
@@ -636,7 +639,7 @@ unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
  *
  * -EINVAL on error.
  */
-static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
+static int get_seg_base_limit(struct insn *insn, struct ex_regs *regs,
 			      int regoff, unsigned long *base,
 			      unsigned long *limit)
 {
@@ -667,13 +670,13 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_reg() - Obtain effective address from register operand
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, with the effective address
+ * @regoff:	Obtained operand offset, in ex_regs, with the effective address
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address stored in the register operand as indicated by
  * the ModRM byte. This function is to be used only with register addressing
  * (i.e.,  ModRM.mod is 3). The effective address is saved in @eff_addr. The
- * register operand, as an offset from the base of pt_regs, is saved in @regoff;
+ * register operand, as an offset from the base of ex_regs, is saved in @regoff;
  * such offset can then be used to resolve the segment associated with the
  * operand. This function can be used with any of the supported address sizes
  * in x86.
@@ -682,11 +685,11 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
  *
  * 0 on success. @eff_addr will have the effective address stored in the
  * operand indicated by ModRM. @regoff will have such operand as an offset from
- * the base of pt_regs.
+ * the base of ex_regs.
  *
  * -EINVAL on error.
  */
-static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
+static int get_eff_addr_reg(struct insn *insn, struct ex_regs *regs,
 			    int *regoff, long *eff_addr)
 {
 	int ret;
@@ -717,7 +720,7 @@ static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_modrm() - Obtain referenced effective address via ModRM
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, associated with segment
+ * @regoff:	Obtained operand offset, in ex_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address referenced by the ModRM byte of @insn. After
@@ -730,12 +733,12 @@ static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
  * Returns:
  *
  * 0 on success. @eff_addr will have the referenced effective address. @regoff
- * will have a register, as an offset from the base of pt_regs, that can be used
+ * will have a register, as an offset from the base of ex_regs, that can be used
  * to resolve the associated segment.
  *
  * -EINVAL on error.
  */
-static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
+static int get_eff_addr_modrm(struct insn *insn, struct ex_regs *regs,
 			      int *regoff, long *eff_addr)
 {
 	long tmp;
@@ -759,7 +762,7 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
 	 * following instruction.
 	 */
 	if (*regoff == -EDOM) {
-		tmp = regs->ip + insn->length;
+		tmp = regs->rip + insn->length;
 	} else if (*regoff < 0) {
 		return -EINVAL;
 	} else {
@@ -781,7 +784,7 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_modrm_16() - Obtain referenced effective address via ModRM
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, associated with segment
+ * @regoff:	Obtained operand offset, in ex_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the 16-bit effective address referenced by the ModRM byte of @insn.
@@ -794,12 +797,12 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
  * Returns:
  *
  * 0 on success. @eff_addr will have the referenced effective address. @regoff
- * will have a register, as an offset from the base of pt_regs, that can be used
+ * will have a register, as an offset from the base of ex_regs, that can be used
  * to resolve the associated segment.
  *
  * -EINVAL on error.
  */
-static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
+static int get_eff_addr_modrm_16(struct insn *insn, struct ex_regs *regs,
 				 int *regoff, short *eff_addr)
 {
 	int addr_offset1, addr_offset2, ret;
@@ -849,7 +852,7 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_sib() - Obtain referenced effective address via SIB
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @base_offset: Obtained operand offset, in pt_regs, associated with segment
+ * @base_offset: Obtained operand offset, in ex_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address referenced by the SIB byte of @insn. After
@@ -862,12 +865,12 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
  * Returns:
  *
  * 0 on success. @eff_addr will have the referenced effective address.
- * @base_offset will have a register, as an offset from the base of pt_regs,
+ * @base_offset will have a register, as an offset from the base of ex_regs,
  * that can be used to resolve the associated segment.
  *
  * Negative value on error.
  */
-static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
+static int get_eff_addr_sib(struct insn *insn, struct ex_regs *regs,
 			    int *base_offset, long *eff_addr)
 {
 	long base, indx;
@@ -951,7 +954,7 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
  *
  * -1L on error.
  */
-static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
+static void __user *get_addr_ref_16(struct insn *insn, struct ex_regs *regs)
 {
 	unsigned long linear_addr = -1L, seg_base, seg_limit;
 	int ret, regoff;
@@ -1012,7 +1015,7 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
  *
  * -1L on error.
  */
-static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
+static void __user *get_addr_ref_32(struct insn *insn, struct ex_regs *regs)
 {
 	unsigned long linear_addr = -1L, seg_base, seg_limit;
 	int eff_addr, regoff;
@@ -1076,7 +1079,7 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
  *
  * -1L on error.
  */
-static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
+static void __user *get_addr_ref_64(struct insn *insn, struct ex_regs *regs)
 {
 	unsigned long linear_addr = -1L, seg_base;
 	int regoff, ret;
@@ -1128,7 +1131,7 @@ static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
  *
  * -1L on error.
  */
-void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
+void __user *insn_get_addr_ref(struct insn *insn, struct ex_regs *regs)
 {
 	if (!insn || !regs)
 		return (void __user *)-1L;
-- 
2.34.1


