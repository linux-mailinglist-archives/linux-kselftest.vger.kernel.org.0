Return-Path: <linux-kselftest+bounces-42105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE20B9454B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CAA3BEE8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0830E0F7;
	Tue, 23 Sep 2025 05:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z+mdCRme"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB330DEA6;
	Tue, 23 Sep 2025 05:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604454; cv=fail; b=XsQXvU/rfIb0DydOlYVlab1Xa5K9I4M0uOGhspWZiwIyPTJuTgOHodssO+UMLIC6C5IMByuUaWxY7zkq0VHKON1+TJyctK+/LedxERa5BSSM6eDAsUQWUI/ccpEP3y41FbpqWCY7EQhsJUvxmVjw2LMFYHsMx9QJHmZ5qgalQxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604454; c=relaxed/simple;
	bh=dYB7OTHtndsE84RqpgEDqzIjhveRSEgOo5u6rscM0po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwR9iW8wRgSwb7/hIUl3C24qFaCtLGTlVFBJn790dLvF1cNjh8GVE6MGFChNaBJRSNQUDjB6zxxTceAYESNEsfOHOUSumpWhcf9TblVs4ugChZYwv6sV6X/wDkOoqYFOtHwQnK77npWz16sGCjhKmWK8AhIJeSJrZSUteoJp8BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z+mdCRme; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+6tMgwFqcPjjViox21isy+5AAA0dO/s/+dOMW41sRLXbwVjikt70dKW/jt9qvcTdafiHN+W5fRTBI/qtEI49HJx9OBLmnNx/D56K8kTwh+NY3Z7U0Y3xGOS8zVwQg9d/n8KyA8Dl/1XrqlyEmx3EG0lWeUQzBFSECDLcSbjF0teCp2GzyPoNc6L4mBZApCG2eMuFS+/eoyYEZ1QIf+foUFtjBmD3An5WprbUWXvZNx9LLe8X8hTOS6UaYByfN/kR2QTUva89i0EOfmoemX+KmB9t8f5rcbwxVkDRy6kFgpkVFBAsZdUwICK4TazD049ynMhJ4vJau2hEqMIUgCNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwtfR0N/72g2u/+A6NqlDhnhhzAfM4oWCwA2QTxOwRk=;
 b=Krmk1Kpp9HkIC60NKzYxsGCvtF17H441l+GoIxpoXJKogD9WxBwS8x0NkeDtgYF/NDBq82Dac6H4vFtmYssm/HnCmWXi5zxdGD94U9TecdqcVz6M5/+qqRQktP5vdOtO4flVXhjLXsuAqbBzqmOSob4iTxq+/0td+/RyWkjo9L7uAJq67UACV4JpAfJWWslQmRB7BnRKEyNYoaralsgUoQ4GP+ZT263rRtklGs4JDABWwAz2toPG+izSQXu9k/4uJIlMMrdCvZ8hSyNnRPd9BXDYp+cmvnCgeJw2pwNSsdgO+B4hj+bBocKqHPJ+eZC4zul1maJ02+tWzhj8YQDVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwtfR0N/72g2u/+A6NqlDhnhhzAfM4oWCwA2QTxOwRk=;
 b=z+mdCRmeH/X54ExIBQjsn4IOS6wsGWvD9rbMNiKrVD6khYaE1O/90soqAzwaD12s86HTx4QYVbu0DC5kLnXd5cuLANW5Mh2OhCynRru4qyrh7Fqebd2Y/aSZRWgLmORgDbX4qWkrGgiEFPVGEOcmuViiWEOv9HbqXgxWx3ShO6k=
Received: from CH2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:610:50::32)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:14:06 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::4f) by CH2PR16CA0022.outlook.office365.com
 (2603:10b6:610:50::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:14:06 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:13:59 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 14/35] KVM: selftests: Restrict instruction decoder to x86_64 only
Date: Tue, 23 Sep 2025 10:39:21 +0530
Message-ID: <20250923050942.206116-15-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 1720b982-1e1b-481a-53c8-08ddfa600501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f3rl34KkV0GWNxgFJ/wd17RDebG2ria9uckkBCgnP1JcurLQPchLSRlw6owv?=
 =?us-ascii?Q?UADfVH6MPF09UuVOFqjcu1sLQGiRAY2bM0JL1lPc+7Ml9d1RLf7JJ/oUuRPP?=
 =?us-ascii?Q?GyqBGrhZ8zil8q1VUtbUdxz/D7JLdJF5oBd30YmDEEnt5Rl5cWd3CflCQcuj?=
 =?us-ascii?Q?Me+sj30K3oLpl2fCWdNX8+QpHOe/V2P81hB8I+tJ35b7/PEWyyIddUgkDEPh?=
 =?us-ascii?Q?wFY1rbf9SvEkHOsKzXZoYkvXjsB0s4i+pdPg2NVorjYRxnOQilPwPu5B8na0?=
 =?us-ascii?Q?WAODW2lxpzvDQnx4o014Now3iAVhm3+lSvL72YqZH0+AQkEFKHJJlDUCzxWR?=
 =?us-ascii?Q?mGz6Z/DBtcrHrZmwBIJKSK4b459ZKNa258Z1xsKPg+JMXaBNzDJJenCaPvkh?=
 =?us-ascii?Q?yHaePUtOXlvOhVm5DSlg7NQtTNwU5iN/pxhU1ybyOVE6tFfZSe3Y4ir5dKdA?=
 =?us-ascii?Q?oB6Px8WDbsTtFGi6BIyGYWyR4aTRJEkv2EYnqCZQMGXySMbuv8381b+E1PUy?=
 =?us-ascii?Q?NyBA2aRha/8QYYE3I1JahZyT5Kl9liMDr8ux5WsgRQxm7VTAbJhwS+iK3zj9?=
 =?us-ascii?Q?d5DXU/aXYuwQZ9wou2Wg72ymaK3LvjJNZ/lsHrT7D4EDK/ugZ0pP0oCumrst?=
 =?us-ascii?Q?L8koK6zTmcd3L6IFC4GrjXHeHlpEq5sHDH034qeQ1Eppv3GoZfSvkyJOpmM+?=
 =?us-ascii?Q?YFp9ccmO+XpwhGmgPX6pfDs4zxKTURB41OYWYTDi7gcFzXKItHzshnWFKLGL?=
 =?us-ascii?Q?biAcB9iNaMrfFlggXz1yq5E7jQe6lE9g96278fcMK+lcMIr1p/5HO4pG2Zh8?=
 =?us-ascii?Q?/SEvjpJsonRuEzA/sqSp0bI8VXf1yshw6e7QEeIYSz64/+Q+hfPq0uzkBz7v?=
 =?us-ascii?Q?CCGqMvI9APRpddIZEZOwj1FflCNTHduaR3uA2tU3Kz3PHaU05JhldI0IpKhZ?=
 =?us-ascii?Q?DtIPUrO3hQi6T+XmnwPqQnULBjbToL5wknX65z15Pvx+JqdUShNXPpD/gjK9?=
 =?us-ascii?Q?VVPYkV+EMRO+U57/B8N9cNn3/h01h0EKL54xoQMhzFQByiX7ccT/Jt+8+0Iv?=
 =?us-ascii?Q?6YER1SzsZPk0ZZi/aoyDHhulr4wV56CWtHMgLwJGrBnj6Nvs53S6hhdIUmu0?=
 =?us-ascii?Q?eE6ZGZYFTbiT1qWyWFi789ifp2eFinVi82a7k/NNbs0iMHyFl5ZaKbkD61Ot?=
 =?us-ascii?Q?BuHRmUGBeEWDjoymoUzeI+ADzWqJ0Erk1/GfcA3iCpWR+2qN4A6ox3mqPr7U?=
 =?us-ascii?Q?0H4cIygnkkPJ5NRYO/OJW+XePrx5XpmE0/yRiBGbygi12fdm5iyR8uZ/LuLD?=
 =?us-ascii?Q?/m+u3b7rbWvTvn6EX8gguVgOSL+mE9FignqcpLoqH6EcSuJWXYxTnNwhPbCm?=
 =?us-ascii?Q?t5CHy/M3drc1AY8OdY1SxqkVfe41S4C4q9ohuapcjyrnXlB0ERgLTo39LDxB?=
 =?us-ascii?Q?iNvIb50ZUQruRGn/1th2GLhcMg21cztTdp4FLlZO/DGPQc/TSbYf5z2WYLEH?=
 =?us-ascii?Q?+8U2xmIHh6p+EW9hFmfHb3CXb5Ltd6IlaQ+O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:14:06.3708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1720b982-1e1b-481a-53c8-08ddfa600501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505

The insn-eval.c library was recently imported from the kernel source
and contains a significant amount of code to support legacy x86
operating modes, such as 32-bit protected mode, 16-bit addressing, and
v8086 mode.

The KVM selftests, particularly for features like SEV-ES, exclusively
target the 64-bit architecture with guest kernel running in kernel
mode.

Simplify the decoder by removing all logic not relevant to 64-bit mode.
This involves:
- Remove all CONFIG_X86_32 and v8086_mode conditional logic.
- Simplify resolve_default_seg to always assume 64-bit
  segmentation rules (i.e., most segments are ignored).
- Rework insn_get_seg_base to only handle the 64-bit model where
  FS/GS bases are read from MSRs.
- Delete support for 16-bit address decoding.
- Remove complex segment descriptor lookups, which are not used in the
  64-bit flat memory model.

This makes the library smaller and easier to maintain for its intended
purpose within the selftests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/lib/x86/insn-eval.c | 254 ++----------------
 1 file changed, 28 insertions(+), 226 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/insn-eval.c b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
index a47c01977e72..cf751e4e36ec 100644
--- a/tools/testing/selftests/kvm/lib/x86/insn-eval.c
+++ b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
@@ -178,52 +178,7 @@ static bool check_seg_overrides(struct insn *insn, int regoff)
  */
 static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
 {
-	if (any_64bit_mode(regs))
-		return INAT_SEG_REG_IGNORE;
-	/*
-	 * Resolve the default segment register as described in Section 3.7.4
-	 * of the Intel Software Development Manual Vol. 1:
-	 *
-	 *  + DS for all references involving r[ABCD]X, and rSI.
-	 *  + If used in a string instruction, ES for rDI. Otherwise, DS.
-	 *  + AX, CX and DX are not valid register operands in 16-bit address
-	 *    encodings but are valid for 32-bit and 64-bit encodings.
-	 *  + -EDOM is reserved to identify for cases in which no register
-	 *    is used (i.e., displacement-only addressing). Use DS.
-	 *  + SS for rSP or rBP.
-	 *  + CS for rIP.
-	 */
-
-	switch (off) {
-	case offsetof(struct pt_regs, ax):
-	case offsetof(struct pt_regs, cx):
-	case offsetof(struct pt_regs, dx):
-		/* Need insn to verify address size. */
-		if (insn->addr_bytes == 2)
-			return -EINVAL;
-
-		fallthrough;
-
-	case -EDOM:
-	case offsetof(struct pt_regs, bx):
-	case offsetof(struct pt_regs, si):
-		return INAT_SEG_REG_DS;
-
-	case offsetof(struct pt_regs, di):
-		if (is_string_insn(insn))
-			return INAT_SEG_REG_ES;
-		return INAT_SEG_REG_DS;
-
-	case offsetof(struct pt_regs, bp):
-	case offsetof(struct pt_regs, sp):
-		return INAT_SEG_REG_SS;
-
-	case offsetof(struct pt_regs, ip):
-		return INAT_SEG_REG_CS;
-
-	default:
-		return -EINVAL;
-	}
+	return INAT_SEG_REG_IGNORE;
 }
 
 /**
@@ -288,12 +243,8 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
 	 * be used. Hence, it is not necessary to inspect the instruction,
 	 * which may be invalid at this point.
 	 */
-	if (regoff == offsetof(struct pt_regs, ip)) {
-		if (any_64bit_mode(regs))
-			return INAT_SEG_REG_IGNORE;
-		else
-			return INAT_SEG_REG_CS;
-	}
+	if (regoff == offsetof(struct pt_regs, ip))
+		return INAT_SEG_REG_IGNORE;
 
 	if (!insn)
 		return -EINVAL;
@@ -312,11 +263,8 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
 	 * In long mode, segment override prefixes are ignored, except for
 	 * overrides for FS and GS.
 	 */
-	if (any_64bit_mode(regs)) {
-		if (idx != INAT_SEG_REG_FS &&
-		    idx != INAT_SEG_REG_GS)
-			idx = INAT_SEG_REG_IGNORE;
-	}
+	if (idx != INAT_SEG_REG_FS && idx != INAT_SEG_REG_GS)
+		idx = INAT_SEG_REG_IGNORE;
 
 	return idx;
 }
@@ -327,11 +275,9 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
  * @seg_reg_idx:	Segment register index to use
  *
  * Obtain the segment selector from any of the CS, SS, DS, ES, FS, GS segment
- * registers. In CONFIG_X86_32, the segment is obtained from either pt_regs or
- * kernel_vm86_regs as applicable. In CONFIG_X86_64, CS and SS are obtained
- * from pt_regs. DS, ES, FS and GS are obtained by reading the actual CPU
- * registers. This done for only for completeness as in CONFIG_X86_64 segment
- * registers are ignored.
+ * registers. CS and SS are obtained from pt_regs. DS, ES, FS and GS are
+ * obtained by reading the actual CPU registers. This done for only for
+ * completeness as in X86_64 segment registers are ignored.
  *
  * Returns:
  *
@@ -344,7 +290,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 {
 	unsigned short sel;
 
-#ifdef CONFIG_X86_64
 	switch (seg_reg_idx) {
 	case INAT_SEG_REG_IGNORE:
 		return 0;
@@ -367,48 +312,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 	default:
 		return -EINVAL;
 	}
-#else /* CONFIG_X86_32 */
-	struct kernel_vm86_regs *vm86regs = (struct kernel_vm86_regs *)regs;
-
-	if (v8086_mode(regs)) {
-		switch (seg_reg_idx) {
-		case INAT_SEG_REG_CS:
-			return (unsigned short)(regs->cs & 0xffff);
-		case INAT_SEG_REG_SS:
-			return (unsigned short)(regs->ss & 0xffff);
-		case INAT_SEG_REG_DS:
-			return vm86regs->ds;
-		case INAT_SEG_REG_ES:
-			return vm86regs->es;
-		case INAT_SEG_REG_FS:
-			return vm86regs->fs;
-		case INAT_SEG_REG_GS:
-			return vm86regs->gs;
-		case INAT_SEG_REG_IGNORE:
-		default:
-			return -EINVAL;
-		}
-	}
-
-	switch (seg_reg_idx) {
-	case INAT_SEG_REG_CS:
-		return (unsigned short)(regs->cs & 0xffff);
-	case INAT_SEG_REG_SS:
-		return (unsigned short)(regs->ss & 0xffff);
-	case INAT_SEG_REG_DS:
-		return (unsigned short)(regs->ds & 0xffff);
-	case INAT_SEG_REG_ES:
-		return (unsigned short)(regs->es & 0xffff);
-	case INAT_SEG_REG_FS:
-		return (unsigned short)(regs->fs & 0xffff);
-	case INAT_SEG_REG_GS:
-		savesegment(gs, sel);
-		return sel;
-	case INAT_SEG_REG_IGNORE:
-	default:
-		return -EINVAL;
-	}
-#endif /* CONFIG_X86_64 */
 }
 
 static const int pt_regoff[] = {
@@ -420,7 +323,6 @@ static const int pt_regoff[] = {
 	offsetof(struct pt_regs, bp),
 	offsetof(struct pt_regs, si),
 	offsetof(struct pt_regs, di),
-#ifdef CONFIG_X86_64
 	offsetof(struct pt_regs, r8),
 	offsetof(struct pt_regs, r9),
 	offsetof(struct pt_regs, r10),
@@ -429,12 +331,6 @@ static const int pt_regoff[] = {
 	offsetof(struct pt_regs, r13),
 	offsetof(struct pt_regs, r14),
 	offsetof(struct pt_regs, r15),
-#else
-	offsetof(struct pt_regs, ds),
-	offsetof(struct pt_regs, es),
-	offsetof(struct pt_regs, fs),
-	offsetof(struct pt_regs, gs),
-#endif
 };
 
 int pt_regs_offset(struct pt_regs *regs, int regno)
@@ -453,9 +349,6 @@ static int get_regno(struct insn *insn, enum reg_type type)
 	 * Don't possibly decode a 32-bit instructions as
 	 * reading a 64-bit-only register.
 	 */
-	if (IS_ENABLED(CONFIG_X86_64) && !insn->x86_64)
-		nr_registers -= 8;
-
 	switch (type) {
 	case REG_TYPE_RM:
 		regno = X86_MODRM_RM(insn->modrm.value);
@@ -687,52 +580,33 @@ static bool get_desc(struct desc_struct *out, unsigned short sel)
  */
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 {
-	struct desc_struct desc;
+	unsigned long base;
 	short sel;
 
 	sel = get_segment_selector(regs, seg_reg_idx);
 	if (sel < 0)
 		return -1L;
 
-	if (v8086_mode(regs))
-		/*
-		 * Base is simply the segment selector shifted 4
-		 * bits to the right.
-		 */
-		return (unsigned long)(sel << 4);
+	/*
+	 * Only FS or GS will have a base address, the rest of
+	 * the segments' bases are forced to 0.
+	 */
 
-	if (any_64bit_mode(regs)) {
+	if (seg_reg_idx == INAT_SEG_REG_FS) {
+		rdmsrq(MSR_FS_BASE, base);
+	} else if (seg_reg_idx == INAT_SEG_REG_GS) {
 		/*
-		 * Only FS or GS will have a base address, the rest of
-		 * the segments' bases are forced to 0.
+		 * swapgs was called at the kernel entry point. Thus,
+		 * MSR_KERNEL_GS_BASE will have the user-space GS base.
 		 */
-		unsigned long base;
-
-		if (seg_reg_idx == INAT_SEG_REG_FS) {
-			rdmsrq(MSR_FS_BASE, base);
-		} else if (seg_reg_idx == INAT_SEG_REG_GS) {
-			/*
-			 * swapgs was called at the kernel entry point. Thus,
-			 * MSR_KERNEL_GS_BASE will have the user-space GS base.
-			 */
-			if (user_mode(regs))
-				rdmsrq(MSR_KERNEL_GS_BASE, base);
-			else
-				rdmsrq(MSR_GS_BASE, base);
-		} else {
-			base = 0;
-		}
-		return base;
+		if (user_mode(regs))
+			rdmsrq(MSR_KERNEL_GS_BASE, base);
+		else
+			rdmsrq(MSR_GS_BASE, base);
+	} else {
+		base = 0;
 	}
-
-	/* In protected mode the segment selector cannot be null. */
-	if (!sel)
-		return -1L;
-
-	if (!get_desc(&desc, sel))
-		return -1L;
-
-	return get_desc_base(&desc);
+	return base;
 }
 
 /**
@@ -762,26 +636,7 @@ static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
 	if (sel < 0)
 		return 0;
 
-	if (any_64bit_mode(regs) || v8086_mode(regs))
-		return -1L;
-
-	if (!sel)
-		return 0;
-
-	if (!get_desc(&desc, sel))
-		return 0;
-
-	/*
-	 * If the granularity bit is set, the limit is given in multiples
-	 * of 4096. This also means that the 12 least significant bits are
-	 * not tested when checking the segment limits. In practice,
-	 * this means that the segment ends in (limit << 12) + 0xfff.
-	 */
-	limit = get_desc_limit(&desc);
-	if (desc.g)
-		limit = (limit << 12) + 0xfff;
-
-	return limit;
+	return -1L;
 }
 
 /**
@@ -805,10 +660,6 @@ int insn_get_code_seg_params(struct pt_regs *regs)
 	struct desc_struct desc;
 	short sel;
 
-	if (v8086_mode(regs))
-		/* Address and operand size are both 16-bit. */
-		return INSN_CODE_SEG_PARAMS(2, 2);
-
 	sel = get_segment_selector(regs, INAT_SEG_REG_CS);
 	if (sel < 0)
 		return sel;
@@ -1042,10 +893,7 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
 	 * following instruction.
 	 */
 	if (*regoff == -EDOM) {
-		if (any_64bit_mode(regs))
-			tmp = regs->ip + insn->length;
-		else
-			tmp = 0;
+		tmp = regs->ip + insn->length;
 	} else if (*regoff < 0) {
 		return -EINVAL;
 	} else {
@@ -1277,9 +1125,6 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
 
 	linear_addr = (unsigned long)(eff_addr & 0xffff) + seg_base;
 
-	/* Limit linear address to 20 bits */
-	if (v8086_mode(regs))
-		linear_addr &= 0xfffff;
 
 out:
 	return (void __user *)linear_addr;
@@ -1338,27 +1183,6 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
 	if (ret)
 		goto out;
 
-	/*
-	 * In protected mode, before computing the linear address, make sure
-	 * the effective address is within the limits of the segment.
-	 * 32-bit addresses can be used in long and virtual-8086 modes if an
-	 * address override prefix is used. In such cases, segment limits are
-	 * not enforced. When in virtual-8086 mode, the segment limit is -1L
-	 * to reflect this situation.
-	 *
-	 * After computed, the effective address is treated as an unsigned
-	 * quantity.
-	 */
-	if (!any_64bit_mode(regs) && ((unsigned int)eff_addr > seg_limit))
-		goto out;
-
-	/*
-	 * Even though 32-bit address encodings are allowed in virtual-8086
-	 * mode, the address range is still limited to [0x-0xffff].
-	 */
-	if (v8086_mode(regs) && (eff_addr & ~0xffff))
-		goto out;
-
 	/*
 	 * Data type long could be 64 bits in size. Ensure that our 32-bit
 	 * effective address is not sign-extended when computing the linear
@@ -1366,9 +1190,6 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
 	 */
 	linear_addr = (unsigned long)(eff_addr & 0xffffffff) + seg_base;
 
-	/* Limit linear address to 20 bits */
-	if (v8086_mode(regs))
-		linear_addr &= 0xfffff;
 
 out:
 	return (void __user *)linear_addr;
@@ -1389,12 +1210,6 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
  *
  * -1L on error.
  */
-#ifndef CONFIG_X86_64
-static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
-{
-	return (void __user *)-1L;
-}
-#else
 static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
 {
 	unsigned long linear_addr = -1L, seg_base;
@@ -1431,7 +1246,6 @@ static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
 out:
 	return (void __user *)linear_addr;
 }
-#endif /* CONFIG_X86_64 */
 
 /**
  * insn_get_addr_ref() - Obtain the linear address referred by instruction
@@ -1472,18 +1286,6 @@ int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
 {
 	unsigned long seg_base = 0;
 
-	/*
-	 * If not in user-space long mode, a custom code segment could be in
-	 * use. This is true in protected mode (if the process defined a local
-	 * descriptor table), or virtual-8086 mode. In most of the cases
-	 * seg_base will be zero as in USER_CS.
-	 */
-	if (!user_64bit_mode(regs)) {
-		seg_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
-		if (seg_base == -1L)
-			return -EINVAL;
-	}
-
 	*ip = seg_base + regs->ip;
 
 	return 0;
@@ -1563,7 +1365,7 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 {
 	int seg_defs;
 
-	insn_init(insn, buf, buf_size, user_64bit_mode(regs));
+	insn_init(insn, buf, buf_size, true);
 
 	/*
 	 * Override the default operand and address sizes with what is specified
-- 
2.34.1


