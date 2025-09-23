Return-Path: <linux-kselftest+bounces-42104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E3EB94542
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E7F18A82E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D130F553;
	Tue, 23 Sep 2025 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gzl5I6PU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0830F538;
	Tue, 23 Sep 2025 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604433; cv=fail; b=bSfJ98PGlDZndwAkQ5kHVZCbCybS4/1hIG9NyKailZV18jGa+dywavKann7bS8KnsjNVP8cRw4PPROtONhcgwuK0v2juzDZK1v/hRWecjT0ayvn4/CwQcWwJAJHazGco/WuP/iXFVNuywzczWn0a5mDDZ7u+ToW5ThHPy+65GMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604433; c=relaxed/simple;
	bh=p8hgBTfoDfrkmfwESqPAax/RVXCd5v7ddkeb/yAgBQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/jtogoB3gnzeARW4Y465q5mAOC7yV8/nm2qronXxpOeSLoXj+kKRHVz01mTjUQL6SAQN3f6E5+TWI8GMbYgu1bdyZ1FS6E8KwRDRdFxRo0FJ8WjZRgoUD9RTABdMGFxdKsCrBgMg5++BNgg9OpGzNsbDhuXoOgfP+2K5BsrUX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gzl5I6PU; arc=fail smtp.client-ip=52.101.46.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN5RoZwQ0U5l5o5whdIWe8VMmiCmFDkVAkQZ0U85isGGPhHq/2pMLWPnWFZvR4mDWmujBWLO8kzWRWVXgQLE/sPmjXjdLd9q01WqUU4ltxf/8sHRZ3CGpwCx8MzWNoK0sI509xPLEtF9X3O0c8TIX8G50be7VmlCI6gHBKJL+2kBwXlSv2FQ6shiNWa3Ih9FuBajhU7eeQx3eRf8QW+/00DwJoaABz4roCW8BCqe1R/pRLIOcEP+Yw3HG0luYg2FV1yJOoA7xKmVFbf81jHK4qA5k65B6RR3+t96mTiAen5sBFKbuiB0mjeu10IsHlYg8STSTVqrIWz/ZgPklg7ZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd4saNNzqUcd8EcyjlWa8wF+1gEk/Y7CgGq/tuJNvXM=;
 b=IbUQPeoQOn2tlsvMTK+7UpFcg8/fylOgQgfAFe+zehH8l+H9Kei7XcBe1zxMq3faxduDzFivmhYxqBMY6W+HFV+2MqGVahexhOJvcguOIVEbIrjpPsu40CZUV+pdq16V7FcauDD+SHNBtiha6yOUWkz2mlBF/vNdT7wI4XU2qvvbEslfo1pQrG5vbjIiqhxc5s9oEf+CGDT9hrZyuNdwFE2JtcoveoRTWXmUWr1/mVCMDXZV3jdQqsVSV3SNZu3W8ABCHNw4lR893UvQ+cK2uW0PMDcbyRDHE4P7jDhtOXGq5StgdHtPqx4opG1z66OH+QLxDeyN8mA9dvKE6t9nXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd4saNNzqUcd8EcyjlWa8wF+1gEk/Y7CgGq/tuJNvXM=;
 b=gzl5I6PUXCqWFqtsc5gwWKKMIQQK/3APl84vxsL9DE+u6vOapoSTVIh1dFbxnBLxZ6+EebIYNtgfhQolqtNM7YnBz5Ol9lXAOPFZ+s5GdGg/ITb6BS4PPJ63/oAQxmebNIzd2B7Aroc+Vwh8FvvHVvBlAp23goOvMogBm5Naqvw=
Received: from CH2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:610:5b::33)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:13:46 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::df) by CH2PR07CA0059.outlook.office365.com
 (2603:10b6:610:5b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 05:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:13:46 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:13:41 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 13/35] KVM: selftests: Adapt instruction decoder library for userspace
Date: Tue, 23 Sep 2025 10:39:20 +0530
Message-ID: <20250923050942.206116-14-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 56bef6c2-f2c6-4b9a-5f15-08ddfa5ff945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SKnlOPcF/0r6/3Q/evNDbP1NEFFj8QmcvklvfXk+yasnfSK8iTS8pK7lHnrV?=
 =?us-ascii?Q?2LD7Qxtfr6RBOUiJMOi+FpeoVzw26OvrfO1WBhAXzHmQBtyuGoGkR6aDuUx0?=
 =?us-ascii?Q?miJJB9SmsU81pndv0Ga9f+iXjzWRiRlENETQUw+8LX+c5fsIXyFRLurOpJ4U?=
 =?us-ascii?Q?aLOxZBrWegdAyzNbFFoKPwCCUJoKnpttGdA7CDKtmilqfRJe5WU8jZbJ6C+Z?=
 =?us-ascii?Q?CzwevbWxOpNhSC0daH07Mgt5MCsSC2R5GaMUOI+Atovj5RCY9PeYGWkgw/ls?=
 =?us-ascii?Q?8N9Z/2x5biRjQiwwwyTnPTe2th6w90g3kUxHeO7v+mbYqw1+gey0fC8BDPSM?=
 =?us-ascii?Q?sRt2Fj1xtrZLrODerFiwXmrEQPRtNqVfmzhJhOUqbI1caJP+qrYl66IJOrB0?=
 =?us-ascii?Q?vTcxdGms2684eahv4cXq6HDywuHZsx1A/O2ZD6mUU9Vd5pL8XopEIzgV+P+B?=
 =?us-ascii?Q?kUxnDGMGPNOTEINi8cP6tIh9NFhDZ7InoWsXHpy6ZJnLIssxnVZBWxPZg18d?=
 =?us-ascii?Q?z/rlZ1dPipBmQoBhJDBzQ3PMHHK4rZlASSKr1sXyyyIX6e1kY0yfWuXoJR6q?=
 =?us-ascii?Q?W77eOXrIqxOtaCbAtC5hAvbmKP1dTWQSp0Sc+bnhSjAB/4asJUXtjnL9dl+/?=
 =?us-ascii?Q?K9Bnq5uHSvsNB0rBqvTUP0Fp5NGxdKbp/EkkeMqTV//YYWMFrno/9fzjV9fA?=
 =?us-ascii?Q?Z5XrQzCOsK0gLsFLbDHV6pAO8qhCCT/81u6qiOxR3ePRRz5admdaWsLYtB2U?=
 =?us-ascii?Q?8Vt+rHgaOn/nKR+hK21EDtqtyUvew/fLg95/67ZPZyk5qvvAyfLrZLL50eOd?=
 =?us-ascii?Q?hD8xZO6HFZ4+MFhXUOmTZoyBBh+6bd975OB2wxsDOCLbeIj4qTxxmfVHEvrk?=
 =?us-ascii?Q?lZP8w1Otzh5R5n+NmBczWzsj21hdeevnfRkvFp9hsvdmTdv3mx717vt7gXuN?=
 =?us-ascii?Q?TZJXj646wut9SNXKh4x44zK+Ezxf8feypdYviJYcFnvN1MFc3UVwawq8Esst?=
 =?us-ascii?Q?bOm6j9sI7tFIG31I+ydQnfiyah2FCQraTlsnKNEEGrZA2nf87bswJYc7aFhm?=
 =?us-ascii?Q?JvjC4oHm01eqViZe0CojX1PksSZ+bQL5zLPXSZxgwaV0xa77Dp0ijKOacZnh?=
 =?us-ascii?Q?Nai0np2uDBTGXc3qcHLJ2ucEM+msIlygAbIawawQymLJVGmomGMq72cTQrYl?=
 =?us-ascii?Q?c8pP2Q901owKeZdKQKuBRKMFUd1n4cQrqz4wvyY4HOrNqnIhvzw3Wr6HmQkA?=
 =?us-ascii?Q?k7HkdkdHZo/woCFJD/CPGDQ/PhPwBTHyfkUf+f0ahSaLU3TVeV3Hj4k1U0SN?=
 =?us-ascii?Q?pa7hRNVOcHlafOVkTPUZpjXsBuDr4imurteaY0tKJTiXFfRqG563QvWdvZNC?=
 =?us-ascii?Q?6mnpPhRRTaZnU/HE4y7oT+kFCo8o8P1IRxwC1TsrPZKtadGNdYLxW/pNDeS8?=
 =?us-ascii?Q?IPcW929oOgSVLH5MmJTiqG+wZ+/3U4gq9MAF1WHu4M6SwpX/NIBT6UxkvsU9?=
 =?us-ascii?Q?CTVRhtny6Se8zq/EXmUocqh2s2ynzC1ZkZwe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:13:46.6852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bef6c2-f2c6-4b9a-5f15-08ddfa5ff945
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

The insn-eval.c library, recently added for SEV-ES #VC emulation, is
from arch/x86/lib/ and contains dependencies on kernel-specific headers
and macros (e.g., <linux/kernel.h>, pr_err_ratelimited). These
dependencies prevent it from being compiled directly within the userspace
selftest framework.

Adapt the library to be buildable in a userspace environment for selftests:

 - Replace kernel headers with standard C library and selftest-specific
   headers.

 - Translate a kernel-level warning or error into a selftest failure.

 - Remove kernel-specfic annotations.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/include/x86/insn-eval.h     |  5 +---
 .../testing/selftests/kvm/lib/x86/insn-eval.c | 30 +++++++------------
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/insn-eval.h b/tools/testing/selftests/kvm/include/x86/insn-eval.h
index 54368a43abf6..68d49199f991 100644
--- a/tools/testing/selftests/kvm/include/x86/insn-eval.h
+++ b/tools/testing/selftests/kvm/include/x86/insn-eval.h
@@ -6,10 +6,7 @@
  * of the registers indicated by operands.
  */
 
-#include <linux/compiler.h>
-#include <linux/bug.h>
-#include <linux/err.h>
-#include <asm/ptrace.h>
+#include <stdbool.h>
 
 #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
 #define INSN_CODE_SEG_OPND_SZ(params) (params & 0xf)
diff --git a/tools/testing/selftests/kvm/lib/x86/insn-eval.c b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
index 4e385cbfd444..a47c01977e72 100644
--- a/tools/testing/selftests/kvm/lib/x86/insn-eval.c
+++ b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
@@ -3,18 +3,17 @@
  *
  * Copyright (C) Intel Corporation 2017
  */
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/ratelimit.h>
-#include <linux/mmu_context.h>
-#include <asm/desc_defs.h>
-#include <asm/desc.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <errno.h>
+
 #include <asm/inat.h>
 #include <asm/insn.h>
-#include <asm/insn-eval.h>
-#include <asm/ldt.h>
-#include <asm/msr.h>
-#include <asm/vm86.h>
+
+#include "insn-eval.h"
+#include "kselftest.h"
+#include "ucall_common.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "insn: " fmt
@@ -509,12 +508,12 @@ static int get_regno(struct insn *insn, enum reg_type type)
 		break;
 
 	default:
-		pr_err_ratelimited("invalid register type: %d\n", type);
+		__GUEST_ASSERT(false, "invalid register type: %d\n", type);
 		return -EINVAL;
 	}
 
 	if (regno >= nr_registers) {
-		WARN_ONCE(1, "decoded an instruction with an invalid register");
+		__GUEST_ASSERT(false, "decoded an instruction with an invalid register");
 		return -EINVAL;
 	}
 	return regno;
@@ -842,7 +841,6 @@ int insn_get_code_seg_params(struct pt_regs *regs)
 		 */
 		return INSN_CODE_SEG_PARAMS(4, 8);
 	case 3: /* Invalid setting. CS.L=1, CS.D=1 */
-		fallthrough;
 	default:
 		return -EINVAL;
 	}
@@ -1617,7 +1615,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 	switch (insn->opcode.bytes[0]) {
 	case 0x88: /* MOV m8,r8 */
 		*bytes = 1;
-		fallthrough;
 	case 0x89: /* MOV m16/m32/m64, r16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
@@ -1626,7 +1623,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 	case 0xc6: /* MOV m8, imm8 */
 		*bytes = 1;
-		fallthrough;
 	case 0xc7: /* MOV m16/m32/m64, imm16/imm32/imm64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
@@ -1635,7 +1631,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 	case 0x8a: /* MOV r8, m8 */
 		*bytes = 1;
-		fallthrough;
 	case 0x8b: /* MOV r16/r32/r64, m16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
@@ -1644,7 +1639,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 	case 0xa4: /* MOVS m8, m8 */
 		*bytes = 1;
-		fallthrough;
 	case 0xa5: /* MOVS m16/m32/m64, m16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
@@ -1655,7 +1649,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 		switch (insn->opcode.bytes[1]) {
 		case 0xb6: /* MOVZX r16/r32/r64, m8 */
 			*bytes = 1;
-			fallthrough;
 		case 0xb7: /* MOVZX r32/r64, m16 */
 			if (!*bytes)
 				*bytes = 2;
@@ -1664,7 +1657,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 		case 0xbe: /* MOVSX r16/r32/r64, m8 */
 			*bytes = 1;
-			fallthrough;
 		case 0xbf: /* MOVSX r32/r64, m16 */
 			if (!*bytes)
 				*bytes = 2;
-- 
2.34.1


