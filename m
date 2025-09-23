Return-Path: <linux-kselftest+bounces-42111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC6B9458E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482253AE281
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E055B30EF68;
	Tue, 23 Sep 2025 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iQ9dQkTQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FE30DD29;
	Tue, 23 Sep 2025 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604556; cv=fail; b=VPjrPZsKAnsEzvgAwQU98DuZ70oSzaQREtkmPv0XSisQS+u/Uhip01puwq6cAl/OCQSFVx53A7ArWOnLwRclZP57Z+/r/LMqbxGnZHQqWw1vXX3HyAIEJF2ptfCczSwhrV0Jt7FM1nOsCRYa6PmLtxdgI4v8YA4+uqUGTmigqBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604556; c=relaxed/simple;
	bh=AgXPabw3DDbaE0F5W/SEvErDlrK9zQ66sDJKfUixsTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eti0lwQfUaQ8Wk6e01mkc1HjB33C5eccPSt8uS6J+i2JeQqionPS1eEev6aNASJXOPGHmGnTS+iSiRu6dg/4hiVcUpO/wlDiqsf5ZxIngac1PwInU20DsInITiGtTim6c7QM1atfIry0LdSjqL2WB+A1W71Q2N2MpuQ0WIyrC/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iQ9dQkTQ; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K63WZaqDORGwO6n7fGzFs3tnlyAPrq3XZ3mG3ek122/7en2bbt3W1yvxFH9O3HWqVfQ0ea8VyEHIjj0UA+e+feKpkk4mUirks9+kh+5tpr0prQMptTTQfnbOyG6WJpqD9rlEGK52MFOzUS/QFCc3kX11wcycNZ4jM5rH/w9fz4jNGjMq2vyeLa8hBiEKHs7SGVpyMX+PLCA5OjVMu25c6qoS5sKo1GlN3olRk4660WgTkR8Wydd6ZqfSQjQSiifzZZ4Z9555SD2egZneMIY3luLJJpW4ic4H/faiY7tqT+TDByRWTliePIhar1L5m9TX9UxyK7JvBPHeoAFbUiLsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4EW6KnXNPeHrTO6otr1T7qE1RE9/+V98mwK327+xFY=;
 b=XQgor+cGr2wUntv15OGTLdetrHOFX1a1EbsADOXfksI+HFDEn5w21HmpeOOrnKZoVDapjbmqUbVcULn93jbKMXZDKtpLK1B6L/CaSNxUmILLi88Vck/C8+ozZiQUF9TagG5z4zydd7aR32D5t2XKxoLTxU5rtXxyqv10GjAfkSzE7fdWlvY8Ke13XLrn6RjpOgr85LCS/brDfhQl22Y3sWvEcWr3R2kVRM05IhaBFNDGp3vunD3bdJD9JRQPqA+4eEy5gReuDId+D7A58yKDqXom7a2JGQLm2OhwMI6QmgPnVi8S0wdJvkoi4fo5FL7MqNH1gXZZOONAOaQnGuMviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4EW6KnXNPeHrTO6otr1T7qE1RE9/+V98mwK327+xFY=;
 b=iQ9dQkTQ56yBZeLskPFUOMGeTMF/z2VW39EQbERA0UQicIJYWnPV7FnkvdWrf/drShej70KUVzAk8YLRdCfDVDWKp2htY1bJyCjLqXqgGNhNoQroj/yUBUDSumEv4mnP0lG+ZekK6yiJzgG9cjhy8O/aesKLWE5vEUBHrr+7cwk=
Received: from CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::26)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:15:51 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::cd) by CH5P223CA0012.outlook.office365.com
 (2603:10b6:610:1f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:15:51 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:15:46 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 20/35] KVM: selftests: Add instruction decoding for movabs instructions
Date: Tue, 23 Sep 2025 10:39:27 +0530
Message-ID: <20250923050942.206116-21-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: bb52b2a7-0398-4cc3-2123-08ddfa604366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rnotQud+MyqmAXK2yUwMiMQEGS0LPqQhoLedM4vI+MFms9mwdSxqqmmbt5be?=
 =?us-ascii?Q?/SqxcnEzf47Hr0w07N2xkZRyE6YURSu6Z93HglAZe29rCSjnGBrbKcm8uhPc?=
 =?us-ascii?Q?BiJddaaLDObHOkzudtT8x7Oj3Pp4H+oABzk7UQnEhBpyquawtVxIEAsgvDyx?=
 =?us-ascii?Q?VmgGvAEj978vBOGuaPjGJ1/B9omDJjVsZzctcoMKKjsI2JyFf1byM6vnA4dX?=
 =?us-ascii?Q?4il7+h9A/kWh9SdWZbOqovIfhZEzaJBFTIMpN/Cc/oxRi94nWWCgtfP9Wrz8?=
 =?us-ascii?Q?JSNN5GpL1i7kKojjjU82LdgQJqp+lvVHBg5Kpm6jdIzSP7wgXm9HSIqRGkqM?=
 =?us-ascii?Q?z4xqu1E9hNhMi5tNSEX8PO2Xs9hLlyS1yAQ35mP612k55+diB2nqT5ANhuZt?=
 =?us-ascii?Q?rXkC6ctl1E6rbgjXFOyVhizL3Ko9WCOm1NhxtegWuaZfa//QhbK2axp0kgHX?=
 =?us-ascii?Q?NWnkJs4TRlX+BykGvC/YDZnUZLD6ZsVgCFHl23ci9Pf/lGLB82UDC7v1BW5s?=
 =?us-ascii?Q?WZtwaxOWDYSJ3GZJQRi48Ph2wpMsgwivk5hpAlV0dYXl3PQtG/dujOPXwSRM?=
 =?us-ascii?Q?88eG4T8/fMer8mSdX2XYcQ2AplwZnas+dU4n3Fy826Do994Owx8EORPkwDrn?=
 =?us-ascii?Q?gi2bIp5yAwd7DKbEgLx+P1UXSMCTLWDYz+L+tJvYYsWN5TtHqEkaEaILqyP4?=
 =?us-ascii?Q?FtuzrWeD0yoxKA6mq+9KLZktEcdeo30+JCsBaPEVZ0OtQckkC6RW4RepzRCo?=
 =?us-ascii?Q?FhsAjdaPvs8Q3eABWKk/PaBx13tvT7Huz1dDARqtsZGFzo/fFd9e5vDBIAGb?=
 =?us-ascii?Q?zSgE4JkPjZ23uJ6tjUKhVSfTPw0HfoPfIwMNlCCjLEVNta4UuIdmh2DOl8Pb?=
 =?us-ascii?Q?yzBAaUl9CwlbqpfaBscGwt4CEu6wkhwfrF/JTRx6SlYNQuAN1QxAM2tGi2po?=
 =?us-ascii?Q?w8aFXpA3zo1fVlvOzaPlgdnDSquKHm7Qu2Fm4tNWzKP2tnOEK15aRyCjWxDB?=
 =?us-ascii?Q?JIUdQ+Kq2zyVsxHLGzuwSyd7C2JQds/giYM6mcbxzbKQF6y+wXIbbIN5+9Mz?=
 =?us-ascii?Q?s1EsnL+0yTDAxZcnlkyOQZklYuF0iGNDrEsmIl1hWz8HtvbMZet4DR7NLgkf?=
 =?us-ascii?Q?HgtAuzouhbMgzES9LdN761KCd7IPBmPo3ZpvveIiX65dB4ahtHeCuioo/8Zt?=
 =?us-ascii?Q?I7vXhgMlsTfo22ngcNTO3tdNp1muVOPv1aVOy4CDiMAsoEko87INNd6c5BdR?=
 =?us-ascii?Q?YMbQd/nrfTB2enCitjoQALrJmmiyE3H2/q4swAe9B04UoWZmMKys2DWGIW2L?=
 =?us-ascii?Q?O4kKReW/R1UkK4aofOIHwPatpMRB1UOLm7oN10te1diozLvJZ+ttXQ7rlii2?=
 =?us-ascii?Q?zbBkDn9Xtrgttcn32U0T85G4HQ//dslL8s+n5vb+pHWSWigeBLfjpcFHPHuU?=
 =?us-ascii?Q?kXRV9z7tKcVhe4830AME5cLJyDAt4FrW+3i7mMB6648fWxiCO3vNS+Awircs?=
 =?us-ascii?Q?DKlcd1cynw25T4dZhWIaNJ7adwfVv4pqRCjb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:15:51.0507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb52b2a7-0398-4cc3-2123-08ddfa604366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

Compilers can generate movabs instructions for MMIO accesses,
when accessing fixed addresses like the local APIC base. The movabs
instruction is unique in that it moves data between the accumulator (RAX)
and a memory location specified by an absolute 64-bit address encoded
directly in the instruction stream.

The existing MMIO #VC handler in the SEV-ES selftest was unable to
process these instructions because its decoding logic relied on ModR/M
and SIB bytes, which movabs does not use. This would cause MMIO
emulation to fail for such instructions.

Extend insn_decode_mmio() to recognize the movabs opcodes (0xa1,
0xa3). This allows the SEV-ES #VC handler to correctly emulate movabs
instructions, improving the robustness of MMIO testing for
features like the xAPIC.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/include/x86/insn-eval.h     |  2 ++
 .../testing/selftests/kvm/lib/x86/insn-eval.c |  8 +++++
 tools/testing/selftests/kvm/lib/x86/sev.c     | 35 ++++++++++++++-----
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/insn-eval.h b/tools/testing/selftests/kvm/include/x86/insn-eval.h
index 0547b622295a..911b7f4e5473 100644
--- a/tools/testing/selftests/kvm/include/x86/insn-eval.h
+++ b/tools/testing/selftests/kvm/include/x86/insn-eval.h
@@ -35,10 +35,12 @@ enum insn_mmio_type {
 	INSN_MMIO_DECODE_FAILED,
 	INSN_MMIO_WRITE,
 	INSN_MMIO_WRITE_IMM,
+	INSN_MMIO_WRITE_MOV_ABS,
 	INSN_MMIO_READ,
 	INSN_MMIO_READ_ZERO_EXTEND,
 	INSN_MMIO_READ_SIGN_EXTEND,
 	INSN_MMIO_MOVS,
+	INSN_MMIO_READ_MOV_ABS,
 };
 
 enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
diff --git a/tools/testing/selftests/kvm/lib/x86/insn-eval.c b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
index 369530badba9..9d370b1cef84 100644
--- a/tools/testing/selftests/kvm/lib/x86/insn-eval.c
+++ b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
@@ -1224,6 +1224,14 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
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
index 610342b8e479..1e0719dfd6b0 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -469,9 +469,11 @@ void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write)
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
@@ -600,11 +602,12 @@ static void sev_es_vc_mmio_handler(struct ex_regs *regs)
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
@@ -616,7 +619,9 @@ static void sev_es_vc_mmio_handler(struct ex_regs *regs)
 	mmio = insn_decode_mmio(&insn, (int *)&bytes);
 	__GUEST_ASSERT(!(mmio == INSN_MMIO_DECODE_FAILED), " MMIO decode failed\n");
 
-	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
+	if (mmio == INSN_MMIO_WRITE_MOV_ABS || mmio == INSN_MMIO_READ_MOV_ABS) {
+		reg_data = &regs->rax;
+	} else if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
 		reg_data = insn_get_modrm_reg_ptr(&insn, regs);
 		__GUEST_ASSERT(reg_data, "insn_get_modrm_reg_ptr failed\n");
 	}
@@ -627,25 +632,37 @@ static void sev_es_vc_mmio_handler(struct ex_regs *regs)
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


