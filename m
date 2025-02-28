Return-Path: <linux-kselftest+bounces-27857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5FBA495E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7EDA3AE0AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E924C67B;
	Fri, 28 Feb 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dtvumz0Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765A1F9416;
	Fri, 28 Feb 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736240; cv=fail; b=MBULEHVZjaqpeN16DWvCEqJYshJPAhnJoH2NqdrV+ANUWoNnK4xwMcJbECp+1Q5er6cDB2CIxj5J3Wx/Yx+A8lacidQpbSQFV/sNgUDpirH4PGOAA7pn2/cv1c9VsTANmRmAQkOXhEu2o8eASzN0Of7r0RWvmfEw4fHxdOK2Unc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736240; c=relaxed/simple;
	bh=8vNTa7wxKYVDUbBMShkckl2o6YaP9kaNsQqrl0BpARE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyTvfGpEdM63gCwPwlpn8y5GrZWE6+9tTkhEDf7WhE9IsSk2jBPgKHIEJ4u75zAnR94jiB1Z3P4wskPuB1KtPDoVxR7A0BnvQZGNvzRdP8fFfetU0rwBAd5EUR2mm2rct4OKn6Ht6txc9WXL59hK/aLKbbPiRuPZclpRTi+N87A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dtvumz0Y; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4zIhNQuzVcE60EguauWM9RBT/xBkQgvQzzs16ja2CrzlbmK8QEuGEEDY9Bnt89Zg+KifF5L7o979TeugztmeWYhWTcNUrISVoHJ02qpkIU4e6HUx9BX+ZFaARc5ZjaVk2hK9b+buBxjBlAg4kGe4wW1dS0qXW9nV/XRY1oSus1VjtxiuuLpcjOvWJ3Wh3uHrNkhSSNfj3CDjqgN0YHi7SHkpEcemXuuKMNrDs+wlHY1yjzsFYqW/NmWaZJs45JX2oym3Aly79lPoEOIRGjD5Tt2S99LKL1gkQCFpjn6XRcjuuYPDO2hHdam2FaUEgFNLcTeNr2SQJcopfdC6Yn4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cwiHMZ2gmDOaZW4CbDxLEcxXV9VqJTg/fuLd73gr3E=;
 b=r8OthB5jf6URpfYeGB18Fd91s16uyFE1ecy9+OB5esfgZ7PG169o+WSYeicPA3+xZxvkel98ALy/B+rBOsUxScdfAamOVAoUap1fuSs1whiuyzhrVHu5kX1WJjcTonT2qkQ4OC+GTJGPv/lOfYs97LmU+5vjvsl2yVaAG72z53m7PM/7PYZ5AIArCPSQO842igZQc+mggqbW9zC+1babollxAl2DHrcUEs36/XOt2uqaJOcmMXFUv05XhnRA0qQ+UqruAIurWR5jA54M4i9I7BY1tELFwPFGveUvFDqutLiioTb8F4BlhjqD2kDdlilozrAIHfeStmHzYL8A8ActgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cwiHMZ2gmDOaZW4CbDxLEcxXV9VqJTg/fuLd73gr3E=;
 b=dtvumz0Yoqwv56mlqt9ERclT+V+XuV6L/cK9hPfUR0MgkP0fBJx8dnD/TI6ZrC1MbFOQisLMi1oBQsv2vhGd8PcNqwcBBjJENmj4Myt5NYxHQ8SA/ozcmBSJSL0czeDdafUKDEhSfH8LChZD1oyF0OPeq5Z2gPlUEjIpZFeJhW4=
Received: from PH7P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::16)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 09:50:35 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::56) by PH7P220CA0004.outlook.office365.com
 (2603:10b6:510:326::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 09:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:50:34 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:49:37 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 15/31] KVM: selftests: Add instruction decoding for movabs instructions
Date: Fri, 28 Feb 2025 15:00:08 +0530
Message-ID: <20250228093024.114983-16-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cba5754-77e8-4f37-b4e6-08dd57dd58f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2XSS5bwDlVvz7Epyc59g3J25I04D09316ib1VsFye19n3QkLeyRTC5yiANmI?=
 =?us-ascii?Q?rtu5DhP3p7p9LE3HyVeaHHV+on1HPEXkUO46VGv8FfrHHdJgwj1VxNjGfNUc?=
 =?us-ascii?Q?f2zI0277tPL43jRv0RAS60VadDP99lHxkQaBisl3NOrLC/pCLJSjoi2kP1ZF?=
 =?us-ascii?Q?tZVVapZ3R5MS9zGZSHecTy6cy+SFcAqPbnR5Nwo8cX6AzLY2eS2q4qfdOYVn?=
 =?us-ascii?Q?+GNo5sGSZLRdp3UFBd/1mMlMhdNZRpAZuYAq2sQbrm4V6uZd4SiZMB/V/366?=
 =?us-ascii?Q?hyRIo2ZN2lEyGMdFHCZtLF56wtl6qbfxeLp/lJPi55up6WXZM4Bh5F3D9gYz?=
 =?us-ascii?Q?WmA2bbuKw3MBZBqzEb2LNlOv+enX/gCIVuHgSqFevkAx/nc0CCCKLDCL782d?=
 =?us-ascii?Q?hemgzCsQydeFjGJNNtvBYA+CRTl5kr+mTyiREUaPaFejJgW/Q8+CJBLatDXV?=
 =?us-ascii?Q?uCQxawZWcWeyQLYyYcZKuMxoMPxkN6lzqrScNVz/t/w+2nHWHpE3mJHwKGvj?=
 =?us-ascii?Q?TLPudmrab87lTfuP7B1zL1AJAK1JeLU2aKtVojUBZWYPEa+m5u+KgCe7oIpD?=
 =?us-ascii?Q?dQiYWLY56eCf0fcYwO4n0y6ZzMXmbDNh+ztQfg0bs86MtnvAePJKjvLUj5Uf?=
 =?us-ascii?Q?ci0VtbgSpKk6kQo0y3TwmFRcWud/wru0Bkn5oc8Yr2aDAG+8B71BjtinhYJ9?=
 =?us-ascii?Q?VfGU0Sn7rMtO+SBJd4UpiRj1ckSY/Uwa/sbsPXmx0WLbMbheqGLBn5lYa8SX?=
 =?us-ascii?Q?B4650oYoOVa/kvlo7w2eu8nUcwKsttwTDEUVXKTw324ieIwW2auHZZZc+sUZ?=
 =?us-ascii?Q?8X2nc8+RGfrcUjMCyN2fZGB5xeNWlN3iJUc2Fj3kRZhQ2psjno/TYrgXjB2j?=
 =?us-ascii?Q?sTiCH4YT93XgpAxyKc/xOR8eW+/XtsslSaYyRrlFD+2IjtOuroKCkHnAia/m?=
 =?us-ascii?Q?WoOl/VdJzZYxJialJxqRCMAfXECfwfYXeEjXGgDubjzTmfxS+R9GrhWIlkrH?=
 =?us-ascii?Q?Fybt5UXFX/jw+c0nTkbCBBDPJwl4FRh50mPOY3BV4LIwqRNpxf5e9Gs5alqo?=
 =?us-ascii?Q?kdUlhMRN557KJILlqbe3BMKiqBrhv1oXaw/MCQdjEHxsigkMDHICqx3TVeDx?=
 =?us-ascii?Q?tm1oEcuhk/VN2I1S/N2s5hukeHtTj4tYo5frEuftp3KnzGU8l+ZZvJzjHptg?=
 =?us-ascii?Q?OfAH0quK4oyPqL6l0LJcpCXx2+X4epYciC6Ta5MP3lyQdXQ2N5gmH2HrePvR?=
 =?us-ascii?Q?5UPE/ufd82kvAjviEYA6MrekryfyMixdl0kROK4dZb9gNwJREeFr9L/Umfws?=
 =?us-ascii?Q?CG4kgulUkTm3MvBkEzO+QCVvkW2whOOE5qXtVvfhXM+lZNpbUuV5AVl4eTae?=
 =?us-ascii?Q?CqWqSPIstuz6OaVVbT5TuYPTTtZDl2MnJBsrsKDovBJOM9H0A3CFDlFi7DTn?=
 =?us-ascii?Q?vB0b27XFsuywO1hQRt6aB4LSMc/h01Jq36wNXaWHbFr9xPR+gGCXTvfIV00X?=
 =?us-ascii?Q?Lmm6RBtHEaQ1UTY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:50:34.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cba5754-77e8-4f37-b4e6-08dd57dd58f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496

Certain xapic MMIO reads and writes get compiled into movabs
instruction which uses rax as the register containing data and
8-byte address encoded as part of the instruction. Add support
to decode these instructions.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/lib/x86/insn-eval.c |  8 +++++
 tools/testing/selftests/kvm/lib/x86/sev.c     | 35 ++++++++++++++-----
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/insn-eval.c b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
index efa4d3fde504..60c8c7cf5658 100644
--- a/tools/testing/selftests/kvm/lib/x86/insn-eval.c
+++ b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
@@ -1712,6 +1712,14 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 			break;
 		}
 		break;
+	case 0xa1:
+		type = INSN_MMIO_READ_MOV_ABS;
+		*bytes = insn->opnd_bytes;
+		break;
+	case 0xa3:
+		type = INSN_MMIO_WRITE_MOV_ABS;
+		*bytes = insn->opnd_bytes;
+		break;
 	}
 
 	return type;
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 16d6b21649d1..24aaa75ec450 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -517,9 +517,11 @@ void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write)
 }
 
 static void do_mmio(struct ghcb_entry *entry, struct ex_regs *regs,
-		struct insn *insn, unsigned int bytes, bool read)
+		struct insn *insn, unsigned int bytes, bool read,
+		void *ref)
 {
-	void *ref = insn_get_addr_ref(insn, regs);
+	if (!ref)
+		ref = insn_get_addr_ref(insn, regs);
 
 	register_ghcb_page(entry->gpa);
 	__sev_es_hv_mmio_rw(entry, ref, bytes, !read);
@@ -648,11 +650,12 @@ static void sev_es_vc_mmio_handler(struct ex_regs *regs)
 	char buffer[MAX_INSN_SIZE];
 	struct ghcb_entry *entry;
 	enum insn_mmio_type mmio;
-	unsigned long *reg_data;
+	unsigned long *reg_data = NULL;
 	unsigned int bytes;
 	struct ghcb *ghcb;
 	uint8_t sign_byte;
 	struct insn insn;
+	void *abs_ref;
 	int ret;
 
 	memcpy(buffer, (uint8_t *)regs->rip, MAX_INSN_SIZE);
@@ -664,7 +667,9 @@ static void sev_es_vc_mmio_handler(struct ex_regs *regs)
 	mmio = insn_decode_mmio(&insn, (int *)&bytes);
 	__GUEST_ASSERT(!(mmio == INSN_MMIO_DECODE_FAILED), " MMIO decode failed\n");
 
-	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
+	if (mmio == INSN_MMIO_WRITE_MOV_ABS || mmio == INSN_MMIO_READ_MOV_ABS) {
+		reg_data = &regs->rax;
+	} else if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
 		reg_data = insn_get_modrm_reg_ptr(&insn, regs);
 		__GUEST_ASSERT(reg_data, "insn_get_modrm_reg_ptr failed\n");
 	}
@@ -675,25 +680,37 @@ static void sev_es_vc_mmio_handler(struct ex_regs *regs)
 	switch (mmio) {
 	case INSN_MMIO_WRITE:
 		memcpy(ghcb->shared_buffer, reg_data, bytes);
-		do_mmio(entry, regs, &insn, bytes, false);
+		do_mmio(entry, regs, &insn, bytes, false, NULL);
 		break;
 	case INSN_MMIO_WRITE_IMM:
 		memcpy(ghcb->shared_buffer, insn.immediate1.bytes, bytes);
-		do_mmio(entry, regs, &insn, bytes, false);
+		do_mmio(entry, regs, &insn, bytes, false, NULL);
+		break;
+	case INSN_MMIO_WRITE_MOV_ABS:
+		abs_ref = (void *)*(uint64_t *)((uint8_t *)regs->rip + 1);
+		memcpy(ghcb->shared_buffer, reg_data, bytes);
+		do_mmio(entry, regs, &insn, bytes, false, abs_ref);
 		break;
 	case INSN_MMIO_READ:
-		do_mmio(entry, regs, &insn, bytes, true);
+		do_mmio(entry, regs, &insn, bytes, true, NULL);
+		if (bytes == 4)
+			*reg_data = 0;
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_MOV_ABS:
+		abs_ref = (void *)*(uint64_t *)((char *)regs->rip + 1);
+		do_mmio(entry, regs, &insn, bytes, true, abs_ref);
 		if (bytes == 4)
 			*reg_data = 0;
 		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
 	case INSN_MMIO_READ_ZERO_EXTEND:
-		do_mmio(entry, regs, &insn, bytes, true);
+		do_mmio(entry, regs, &insn, bytes, true, NULL);
 		memset(reg_data, 0, insn.opnd_bytes);
 		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
 	case INSN_MMIO_READ_SIGN_EXTEND:
-		do_mmio(entry, regs, &insn, bytes, true);
+		do_mmio(entry, regs, &insn, bytes, true, NULL);
 		if (bytes == 1) {
 			uint8_t *val = (uint8_t *)ghcb->shared_buffer;
 
-- 
2.34.1


