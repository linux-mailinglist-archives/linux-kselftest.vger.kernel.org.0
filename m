Return-Path: <linux-kselftest+bounces-42106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB284B9455A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AF32E2C17
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28DE30DEA6;
	Tue, 23 Sep 2025 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2MjuEjaj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB730CDAF;
	Tue, 23 Sep 2025 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604469; cv=fail; b=kaYNWhyUmkIU4z65Pd337awZqNAL8r2ujaH4nsF7e362Zqfz87HPp/lisKsYhKzCcTWALfmHZJU4PSnPAt0LH4hcLGbkpwHZkAdm9ynI8oLTfKJ1GGEiwNhsEeSRVDxVZF+1HoBlfTCEUoq3NX7nldUYhzLwtoQB7Fyjsiki+a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604469; c=relaxed/simple;
	bh=OkXjb5H/WvS3pQh17h5aC8N7YiPGNO6vOgjFGuBQoUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVvsASh/2/puNcPS/f5aRwm9J7lzzgMsMlRxuXID80b0Rr6ZMwPYxQ/3qI669RLoBcqReg2gM2L8sRG+3AaPsQtTjediYqPU/qEJnfBo+jUicWBy8dvI5VRzMSzsx3j+9rNY5nOEeA0IWWhnUEKb43KTaJxhxMoEQwP1Gtre1Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2MjuEjaj; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYuf+Il3HdpIFB1dWtueRCSZ7RwWjw+CNhy/FTk0cLzZMGTMv0tS3Tzjp/SE1oCbtwQsoT8MZ0oR0h8kqzJcUvrsh3difJPshXyjLU2W3Hm0zhHTNT6A4Y2gLOjqzw0qqQDNwKVT3itL5z8Kcz2tKrv4Le+vul6fQ03aPl8SUc5umYb4O+HkrxTvCRN/r9GWfJSjiIgA6Ry+QqlKRBn2j/5xTHp/JqC7mFyy9n76QFloAJJIndpSAz/ZtKfy9CogLf+S7ZtKMS73MqHrGCZUDy21ZnxGFQQ4Nq8DTBTdP4ZTBwk/mNlMp1sULE43Ziupl3Zxd7BJBl1SnMYzHKghZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1eCsN1nJcf0JXsIzwAG7fjbPWHVVklu4f8DcQj4uCs=;
 b=NKKUa6yqF/6LKJRKPJ0MJd02Jil1TNkroLGPac8buJgPIu/l4OW6zVBNp53LEvI2BPcCemDgwCACJjLcWoPTCue8aVXE0Egz/Av6rG4ANbijRBQrbP825dRKpgwTmiCPSXhu0maoss1gUMMVyeqUxbrLHHjsFUleR+N6MrxZBnaW/d/EOVOknmB5ER3uwg7JrIIbjaJWJQAbKylhV60UzwLCnkQ3Vn1LQULUsJBgNpr7q+yljArRYacMze4tfxoHQUJHEJhGA2fgWO7vlcCMVPNeiHCQM29/uZyvSji/OqXsdPKsM4uJHyhmGoJVsxcaptcvf7e0O8F8Q3wx+Ja1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1eCsN1nJcf0JXsIzwAG7fjbPWHVVklu4f8DcQj4uCs=;
 b=2MjuEjajrIul2G+UQnt8QfWpFYQAje3yQAJ9ocRss/v9MBxw3PNieNC4aOQJKjGmKhnFDR7RLzJd+9FKcC8Yn/ZfVQsbn/7NeU6pO6W2tBd8GtKERjUF++KEUdDg/9ls4CYFhX7Fo3Pj5Byjyptm8IGEiuyxDY39+fsuctjZXs0=
Received: from CH2PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:52::31)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Tue, 23 Sep 2025 05:14:22 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::bb) by CH2PR04CA0021.outlook.office365.com
 (2603:10b6:610:52::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:14:22 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:14:17 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 15/35] KVM: selftests: Remove unneeded functions from instruction decoder
Date: Tue, 23 Sep 2025 10:39:22 +0530
Message-ID: <20250923050942.206116-16-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: fdea0a07-af08-479a-012e-08ddfa600e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?idnt3zxLSQTOZSLbu4I3MnUeO7Y7eJLB1CaHMyVMi3jUXeqMa2nzMTadmJ1V?=
 =?us-ascii?Q?ZAbSpHg3jcwHVn9Ek9xzOrlSgSVIE5PDhW2LVwdR/kQnzinjvhI0gbb01ryJ?=
 =?us-ascii?Q?Mn7HUQCxzOGxve0O801LH2EmCIYH+tDY0j8BW6aNz0pchHFTLso/4ohxwarp?=
 =?us-ascii?Q?uAnhyWIiDsO4K2jB3i6yP69HBI8B8hWWdCIwxpH5jIZBHHi/U9aoYi3JFMGc?=
 =?us-ascii?Q?GIlGPThLCLjZWnIUmL+tNOiecWBtJpvfcdpK8XpwHwRfrlU+ZF8HTqWAUqoo?=
 =?us-ascii?Q?S/k2Jo9+1b1q+Jd2F1pGg99nuaOs3u9VyOywJXT3hTWneKfxK5oYbf5huMkV?=
 =?us-ascii?Q?KUozX7xVNJtqwwAJPLknjGIFRACH+/i3tjOgtrHJ0yAVMFCd/WS4yZQZLwUK?=
 =?us-ascii?Q?eoRa5alDOQRu05b8+srd+CvnUcqlnxXlb2/CZRyAHJjpV88tPNNVfvLX9YR2?=
 =?us-ascii?Q?7jbZgIYL64nCTvfQL4jld6HZ1iB463EfRkAjxwJPYwi1mEUylBO5BwB+12Pf?=
 =?us-ascii?Q?Ph7vVl4Wc865cKmmM4jusimr2P7ZlU6FLm2j/2x60BouDzaTXt0lI909SX8a?=
 =?us-ascii?Q?0YahT84HEKTwC7LcE3N238k/m13gkUX2JNQAMAwEdZHjIkseqgNtEciThTr7?=
 =?us-ascii?Q?LsgGGLJ1hgvDgckvJiWwPiwbfXyUUCYI7q1/S8JqB+2yw42Gf3teuDhTWx6I?=
 =?us-ascii?Q?oTE4THgCf2OCamO0p/VdON3vM/UvMhdHEC+p72gnRA6VRxkJq/EV4fnYWVHk?=
 =?us-ascii?Q?35mh4vAnFWqGZJdRCJOaNSDWZjsSVMw0wBUeDAo21NAc0PfxU9PZIlPB1g88?=
 =?us-ascii?Q?ziKBi8DwruIrQH0K4qVqiT6/4MyQ7BYtU3mY8xRpnSVNAu1zVPRYu46Ii+T+?=
 =?us-ascii?Q?8B9Cr3rvHjxqXUTgVgnttTcs7qevIxsgZeHMUR2asEzB1X+jXOcahAiAaCyo?=
 =?us-ascii?Q?pe6AwOw5G53wziTWP+YlNc3qZFpFx7xKTp00nZwa9LRJIoxvrUGMvUE86NOJ?=
 =?us-ascii?Q?tGaA1QItPqRDj4vnZrrcPOZTQcpeEIrT5TzTGmTq3nvkOL+1TCPIxGymz5XS?=
 =?us-ascii?Q?BfGtY+VWCVvgSm94b9bMPls+6TS61K3f66T8nCqUl43QKK5NjJX7nIdsnFLf?=
 =?us-ascii?Q?J+rM53haZYr9VotpS1ggs5KwHHZsttzcZFFYqKXh1niCLQqrTBR6bbuPfyaB?=
 =?us-ascii?Q?P1/l6mi9WaRyo2iVBsSG7eg26jfqCSixK5GAf8FHyWSP3ZJ32JA+F1uJLjIp?=
 =?us-ascii?Q?WtJjK5HlK3z7nAL6VYD6OSt4VixbkLmRfK7C0D3DD3x3BvC7MStfHJia734I?=
 =?us-ascii?Q?4KQ32x54SAPnC8ZIvpHfqQ/f+418Ov541m5trJ31NKe79bq1tbxcWi/Tg+OG?=
 =?us-ascii?Q?WsN7YRm+XVnJW5JxeTU7gend5W7XbkjvjPdGCTWAqOhtdRbJ75lmR/DTpv/K?=
 =?us-ascii?Q?aAc1XOTtSi/OoPOWDFOElNaq8AmKd8b2FNOsqvEyx55MQAoYiz3O20kmJb/S?=
 =?us-ascii?Q?y7vK5sQxGNA1Dkh/fncMqREiYvg34t7eoLH+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:14:22.3584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdea0a07-af08-479a-012e-08ddfa600e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

The instruction decoder library was added to support SEV-ES #VC exception
handling, where its only required function is to decode MMIO instructions.
The library, as imported from the kernel, contains several high-level
helper functions that are not needed for this purpose.

Remove this unneeded code to strip the library down to the minimum
required for its purpose within the selftests, reducing its size and
maintenance complexity.

While at it, convert the function header comments to not be part of
kernel documentation.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/lib/x86/insn-eval.c | 297 ++----------------
 1 file changed, 22 insertions(+), 275 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/insn-eval.c b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
index cf751e4e36ec..bb7845500f3c 100644
--- a/tools/testing/selftests/kvm/lib/x86/insn-eval.c
+++ b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
@@ -25,7 +25,7 @@ enum reg_type {
 	REG_TYPE_BASE,
 };
 
-/**
+/*
  * is_string_insn() - Determine if instruction is a string instruction
  * @insn:	Instruction containing the opcode to inspect
  *
@@ -51,7 +51,7 @@ static bool is_string_insn(struct insn *insn)
 	}
 }
 
-/**
+/*
  * insn_has_rep_prefix() - Determine if instruction has a REP prefix
  * @insn:	Instruction containing the prefix to inspect
  *
@@ -74,7 +74,7 @@ bool insn_has_rep_prefix(struct insn *insn)
 	return false;
 }
 
-/**
+/*
  * get_seg_reg_override_idx() - obtain segment register override index
  * @insn:	Valid instruction with segment override prefixes
  *
@@ -137,7 +137,7 @@ static int get_seg_reg_override_idx(struct insn *insn)
 	return idx;
 }
 
-/**
+/*
  * check_seg_overrides() - check if segment override prefixes are allowed
  * @insn:	Valid instruction with segment override prefixes
  * @regoff:	Operand offset, in pt_regs, for which the check is performed
@@ -159,7 +159,7 @@ static bool check_seg_overrides(struct insn *insn, int regoff)
 	return true;
 }
 
-/**
+/*
  * resolve_default_seg() - resolve default segment register index for an operand
  * @insn:	Instruction with opcode and address size. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
@@ -181,7 +181,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
 	return INAT_SEG_REG_IGNORE;
 }
 
-/**
+/*
  * resolve_seg_reg() - obtain segment register index
  * @insn:	Instruction with operands
  * @regs:	Register values as seen when entering kernel mode
@@ -268,8 +268,7 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
 
 	return idx;
 }
-
-/**
+/*
  * get_segment_selector() - obtain segment selector
  * @regs:		Register values as seen when entering kernel mode
  * @seg_reg_idx:	Segment register index to use
@@ -423,7 +422,7 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
 	return pt_regs_offset(regs, regno);
 }
 
-/**
+/*
  * get_reg_offset_16() - Obtain offset of register indicated by instruction
  * @insn:	Instruction containing ModRM byte
  * @regs:	Register values as seen when entering kernel mode
@@ -497,71 +496,7 @@ static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
 	return 0;
 }
 
-/**
- * get_desc() - Obtain contents of a segment descriptor
- * @out:	Segment descriptor contents on success
- * @sel:	Segment selector
- *
- * Given a segment selector, obtain a pointer to the segment descriptor.
- * Both global and local descriptor tables are supported.
- *
- * Returns:
- *
- * True on success, false on failure.
- *
- * NULL on error.
- */
-static bool get_desc(struct desc_struct *out, unsigned short sel)
-{
-	struct desc_ptr gdt_desc = {0, 0};
-	unsigned long desc_base;
-
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-	if ((sel & SEGMENT_TI_MASK) == SEGMENT_LDT) {
-		bool success = false;
-		struct ldt_struct *ldt;
-
-		/* Bits [15:3] contain the index of the desired entry. */
-		sel >>= 3;
-
-		/*
-		 * If we're not in a valid context with a real (not just lazy)
-		 * user mm, then don't even try.
-		 */
-		if (!nmi_uaccess_okay())
-			return false;
-
-		mutex_lock(&current->mm->context.lock);
-		ldt = current->mm->context.ldt;
-		if (ldt && sel < ldt->nr_entries) {
-			*out = ldt->entries[sel];
-			success = true;
-		}
-
-		mutex_unlock(&current->mm->context.lock);
-
-		return success;
-	}
-#endif
-	native_store_gdt(&gdt_desc);
-
-	/*
-	 * Segment descriptors have a size of 8 bytes. Thus, the index is
-	 * multiplied by 8 to obtain the memory offset of the desired descriptor
-	 * from the base of the GDT. As bits [15:3] of the segment selector
-	 * contain the index, it can be regarded as multiplied by 8 already.
-	 * All that remains is to clear bits [2:0].
-	 */
-	desc_base = sel & ~(SEGMENT_RPL_MASK | SEGMENT_TI_MASK);
-
-	if (desc_base > gdt_desc.size)
-		return false;
-
-	*out = *(struct desc_struct *)(gdt_desc.address + desc_base);
-	return true;
-}
-
-/**
+/*
  * insn_get_seg_base() - Obtain base address of segment descriptor.
  * @regs:		Register values as seen when entering kernel mode
  * @seg_reg_idx:	Index of the segment register pointing to seg descriptor
@@ -609,7 +544,7 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 	return base;
 }
 
-/**
+/*
  * get_seg_limit() - Obtain the limit of a segment descriptor
  * @regs:		Register values as seen when entering kernel mode
  * @seg_reg_idx:	Index of the segment register pointing to seg descriptor
@@ -628,8 +563,6 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
  */
 static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
 {
-	struct desc_struct desc;
-	unsigned long limit;
 	short sel;
 
 	sel = get_segment_selector(regs, seg_reg_idx);
@@ -639,82 +572,7 @@ static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
 	return -1L;
 }
 
-/**
- * insn_get_code_seg_params() - Obtain code segment parameters
- * @regs:	Structure with register values as seen when entering kernel mode
- *
- * Obtain address and operand sizes of the code segment. It is obtained from the
- * selector contained in the CS register in regs. In protected mode, the default
- * address is determined by inspecting the L and D bits of the segment
- * descriptor. In virtual-8086 mode, the default is always two bytes for both
- * address and operand sizes.
- *
- * Returns:
- *
- * An int containing ORed-in default parameters on success.
- *
- * -EINVAL on error.
- */
-int insn_get_code_seg_params(struct pt_regs *regs)
-{
-	struct desc_struct desc;
-	short sel;
-
-	sel = get_segment_selector(regs, INAT_SEG_REG_CS);
-	if (sel < 0)
-		return sel;
-
-	if (!get_desc(&desc, sel))
-		return -EINVAL;
-
-	/*
-	 * The most significant byte of the Type field of the segment descriptor
-	 * determines whether a segment contains data or code. If this is a data
-	 * segment, return error.
-	 */
-	if (!(desc.type & BIT(3)))
-		return -EINVAL;
-
-	switch ((desc.l << 1) | desc.d) {
-	case 0: /*
-		 * Legacy mode. CS.L=0, CS.D=0. Address and operand size are
-		 * both 16-bit.
-		 */
-		return INSN_CODE_SEG_PARAMS(2, 2);
-	case 1: /*
-		 * Legacy mode. CS.L=0, CS.D=1. Address and operand size are
-		 * both 32-bit.
-		 */
-		return INSN_CODE_SEG_PARAMS(4, 4);
-	case 2: /*
-		 * IA-32e 64-bit mode. CS.L=1, CS.D=0. Address size is 64-bit;
-		 * operand size is 32-bit.
-		 */
-		return INSN_CODE_SEG_PARAMS(4, 8);
-	case 3: /* Invalid setting. CS.L=1, CS.D=1 */
-	default:
-		return -EINVAL;
-	}
-}
-
-/**
- * insn_get_modrm_rm_off() - Obtain register in r/m part of the ModRM byte
- * @insn:	Instruction containing the ModRM byte
- * @regs:	Register values as seen when entering kernel mode
- *
- * Returns:
- *
- * The register indicated by the r/m part of the ModRM byte. The
- * register is obtained as an offset from the base of pt_regs. In specific
- * cases, the returned value can be -EDOM to indicate that the particular value
- * of ModRM does not refer to a register and shall be ignored.
- */
-int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs)
-{
-	return get_reg_offset(insn, regs, REG_TYPE_RM);
-}
-
-/**
+/*
  * insn_get_modrm_reg_off() - Obtain register in reg part of the ModRM byte
  * @insn:	Instruction containing the ModRM byte
  * @regs:	Register values as seen when entering kernel mode
@@ -729,7 +587,7 @@ int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
 	return get_reg_offset(insn, regs, REG_TYPE_REG);
 }
 
-/**
+/*
  * insn_get_modrm_reg_ptr() - Obtain register pointer based on ModRM byte
  * @insn:	Instruction containing the ModRM byte
  * @regs:	Register values as seen when entering kernel mode
@@ -749,7 +607,7 @@ unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
 	return (void *)regs + offset;
 }
 
-/**
+/*
  * get_seg_base_limit() - obtain base address and limit of a segment
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
@@ -797,7 +655,7 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
 	return 0;
 }
 
-/**
+/*
  * get_eff_addr_reg() - Obtain effective address from register operand
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
@@ -847,7 +705,7 @@ static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
 	return 0;
 }
 
-/**
+/*
  * get_eff_addr_modrm() - Obtain referenced effective address via ModRM
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
@@ -911,7 +769,7 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
 	return 0;
 }
 
-/**
+/*
  * get_eff_addr_modrm_16() - Obtain referenced effective address via ModRM
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
@@ -979,7 +837,7 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
 	return 0;
 }
 
-/**
+/*
  * get_eff_addr_sib() - Obtain referenced effective address via SIB
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
@@ -1068,7 +926,7 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 	return 0;
 }
 
-/**
+/*
  * get_addr_ref_16() - Obtain the 16-bit address referred by instruction
  * @insn:	Instruction containing ModRM byte and displacement
  * @regs:	Register values as seen when entering kernel mode
@@ -1130,7 +988,7 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
 	return (void __user *)linear_addr;
 }
 
-/**
+/*
  * get_addr_ref_32() - Obtain a 32-bit linear address
  * @insn:	Instruction with ModRM, SIB bytes and displacement
  * @regs:	Register values as seen when entering kernel mode
@@ -1195,7 +1053,7 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
 	return (void __user *)linear_addr;
 }
 
-/**
+/*
  * get_addr_ref_64() - Obtain a 64-bit linear address
  * @insn:	Instruction struct with ModRM and SIB bytes and displacement
  * @regs:	Structure with register values as seen when entering kernel mode
@@ -1247,7 +1105,7 @@ static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
 	return (void __user *)linear_addr;
 }
 
-/**
+/*
  * insn_get_addr_ref() - Obtain the linear address referred by instruction
  * @insn:	Instruction structure containing ModRM byte and displacement
  * @regs:	Structure with register values as seen when entering kernel mode
@@ -1282,118 +1140,7 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	}
 }
 
-int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
-{
-	unsigned long seg_base = 0;
-
-	*ip = seg_base + regs->ip;
-
-	return 0;
-}
-
-/**
- * insn_fetch_from_user() - Copy instruction bytes from user-space memory
- * @regs:	Structure with register values as seen when entering kernel mode
- * @buf:	Array to store the fetched instruction
- *
- * Gets the linear address of the instruction and copies the instruction bytes
- * to the buf.
- *
- * Returns:
- *
- * - number of instruction bytes copied.
- * - 0 if nothing was copied.
- * - -EINVAL if the linear address of the instruction could not be calculated
- */
-int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
-{
-	unsigned long ip;
-	int not_copied;
-
-	if (insn_get_effective_ip(regs, &ip))
-		return -EINVAL;
-
-	not_copied = copy_from_user(buf, (void __user *)ip, MAX_INSN_SIZE);
-
-	return MAX_INSN_SIZE - not_copied;
-}
-
-/**
- * insn_fetch_from_user_inatomic() - Copy instruction bytes from user-space memory
- *                                   while in atomic code
- * @regs:	Structure with register values as seen when entering kernel mode
- * @buf:	Array to store the fetched instruction
- *
- * Gets the linear address of the instruction and copies the instruction bytes
- * to the buf. This function must be used in atomic context.
- *
- * Returns:
- *
- *  - number of instruction bytes copied.
- *  - 0 if nothing was copied.
- *  - -EINVAL if the linear address of the instruction could not be calculated.
- */
-int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
-{
-	unsigned long ip;
-	int not_copied;
-
-	if (insn_get_effective_ip(regs, &ip))
-		return -EINVAL;
-
-	not_copied = __copy_from_user_inatomic(buf, (void __user *)ip, MAX_INSN_SIZE);
-
-	return MAX_INSN_SIZE - not_copied;
-}
-
-/**
- * insn_decode_from_regs() - Decode an instruction
- * @insn:	Structure to store decoded instruction
- * @regs:	Structure with register values as seen when entering kernel mode
- * @buf:	Buffer containing the instruction bytes
- * @buf_size:   Number of instruction bytes available in buf
- *
- * Decodes the instruction provided in buf and stores the decoding results in
- * insn. Also determines the correct address and operand sizes.
- *
- * Returns:
- *
- * True if instruction was decoded, False otherwise.
- */
-bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
-			   unsigned char buf[MAX_INSN_SIZE], int buf_size)
-{
-	int seg_defs;
-
-	insn_init(insn, buf, buf_size, true);
-
-	/*
-	 * Override the default operand and address sizes with what is specified
-	 * in the code segment descriptor. The instruction decoder only sets
-	 * the address size it to either 4 or 8 address bytes and does nothing
-	 * for the operand bytes. This OK for most of the cases, but we could
-	 * have special cases where, for instance, a 16-bit code segment
-	 * descriptor is used.
-	 * If there is an address override prefix, the instruction decoder
-	 * correctly updates these values, even for 16-bit defaults.
-	 */
-	seg_defs = insn_get_code_seg_params(regs);
-	if (seg_defs == -EINVAL)
-		return false;
-
-	insn->addr_bytes = INSN_CODE_SEG_ADDR_SZ(seg_defs);
-	insn->opnd_bytes = INSN_CODE_SEG_OPND_SZ(seg_defs);
-
-	if (insn_get_length(insn))
-		return false;
-
-	if (buf_size < insn->length)
-		return false;
-
-	return true;
-}
-
-/**
+/*
  * insn_decode_mmio() - Decode a MMIO instruction
  * @insn:	Structure to store decoded instruction
  * @bytes:	Returns size of memory operand
-- 
2.34.1


