Return-Path: <linux-kselftest+bounces-42092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B959B944CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC471734BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2C26E16F;
	Tue, 23 Sep 2025 05:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ClyBV+XA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FED1F16B;
	Tue, 23 Sep 2025 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604221; cv=fail; b=C7PH56puaFPgbS7eM9TDzASfDgkqh+Opa/f+i5bpRPlEGsm11tqw3S1watZTpWROTLVJlMqhMS4r2n5LKzpO+cD+ivCBQUBcGA59NDdh4lCJXKiSOotM89HUO11JefjqBxKfPwAS4cUo0CsIq+Aim8No4N0fnnWgqaPh+kyTAF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604221; c=relaxed/simple;
	bh=UMNZLlSMbh/iYLAkfLQTuaB0nAXrzX6CEG0P9g6nlEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lx3bveeMqgb44JVNVXyWiL0S/SI1zy6vxlRh45j39sigCmIZo9bMLoVGVEntEL/4o7q4ZBJOMvcNLqlff6RKPIGvRwDRHvH0Wf6998SqwAJ8VNn97OXiA6I33VeNsch0RUR1DqOCyapIlzP9+iDC8WvaOI4N7TNz6vTuZ5mz3zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ClyBV+XA; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXVn441nQNGkfxly974LcfmmpInaSL73QQnfBYpuviTqRzzrM/YXloYLG8gUPxIQPxJK/tkfto85OIKedSzxm4EK6nCRORCJLfvawqcMkK44waJhP1Kttqv4mOGlShueHyuJNfO7mjP+Y7Lzxs0pnLz3ACg3TLGIuxtBSSRhK3b9oIgO7+gxyb7EU5qQpwKkohQAO9+/gFcsz0yOeB7GJS0GUAKxgjRRBsi/1elULq5OrNBWbHtIWWSniWChLZSVdqxgoE6Ppc3NnVM6CDxs1y2nBg1N70wjh9dwp4oxdry6hU8JTMXKsXewqSG0WQGp6ChDZ1rvsg7Bi4ApnUh0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipbmMEFgDc0dbI7doanDN8mcBqNvyMhS6QosGwi1E1E=;
 b=vXzuDq7CTLMaLQuvrgFB36MmC+6vM1R5g6I+Kdwv5KNhaDXuMJqmOegQQAsr/VvtJmqx7A9Z/mV3TxlD4f8CD8pYVrv7gy8sJLdGN4iz2aJqUieoDjqFfNTNy242SsJRXb95T0e75GU6mRK13w+qDDsEUErZ4GboMOmAtk67+2QdESSYYIhXEWeXeNdQ3rpNb8eUFz12wkxsPOUaMJ5PgZKngQJLfJsFPlmFrAFGM8CaNN/TTppFDDoh5tCPrQzBZNRmTOBOl4Q9gdO+ojupdWDjGnqhf5TM4G8vdbc/U3pCx+IiASa8Y84fkXfJkjj/haCLqOFHjP3Ih7RbB7wgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipbmMEFgDc0dbI7doanDN8mcBqNvyMhS6QosGwi1E1E=;
 b=ClyBV+XAFZgBXMOeHweeV6f733mt38tqylP7DQhbtmsq1hmhdMheYcpWvmhlQz0pzBa0mfcM65xDw17/9qBtWKO2xHxjM2iKpKEGNfd2imutTKwRqlOWlwRAKsk2J7Dnuro3I+AnHkK7RqHxiTNhp79bXTLrSEvx4+QD1U9kIRQ=
Received: from BN9PR03CA0346.namprd03.prod.outlook.com (2603:10b6:408:f6::21)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:10:13 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::7c) by BN9PR03CA0346.outlook.office365.com
 (2603:10b6:408:f6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:10:13 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:10:08 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 01/35] Add GHCB with setters and getters
Date: Tue, 23 Sep 2025 10:39:08 +0530
Message-ID: <20250923050942.206116-2-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e4f126-52b3-4177-3df8-08ddfa5f7a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kp7VsGn33VtrZ9lEaUMyBrpZPpwcrv0wU4wqEmaoSF0BFqmqfwd5d46zCCNP?=
 =?us-ascii?Q?Y59/seP9cp+7RnssC06AtIdu1XAdkEXwbkLiLBajIUgGIlikMOtDe313GlhD?=
 =?us-ascii?Q?A1DY+9HqkCcRDLvlHhcetYFyC0UdnQYEo1eRTng3ehshA8c/QU4k9k7lJQYn?=
 =?us-ascii?Q?aPRxgtVupuXWiu+uw473PFbsqBRhiOp5bhUwUoJ2vSDTD1YkZ8UpppMD1foU?=
 =?us-ascii?Q?ZNSAJriBY21bHk4ogglrSttSo9S/Hnvs6rDFRfqdrrKvhmEVjUDtNy+21aEY?=
 =?us-ascii?Q?NrZHQfwEuCAlXgH/7z+0Ta83NolVPu3dpmKQ4YwI0BPXqBIVDJpdpPdo7QUZ?=
 =?us-ascii?Q?v0++Vkc5wuVrWKLxi0G+SxHwxtHbSFVefgCVF2fYqsMMjnkmixPVksDDtcRv?=
 =?us-ascii?Q?eG+w8DlZc3JoiKvEVi+6gzm8QG5L0FvGsMWyQQ8MR8F3udSc6g7z25K+i8WO?=
 =?us-ascii?Q?mO/R07JiSkfjlm7KErdpGt4UJ+QmyC0voKcUMtRoO/sm7WJfD7UeCUW2ZBzj?=
 =?us-ascii?Q?ZLe7LqB+XYxiEDh1EVm6kHbPCmdR5Mu3MUE7X4B/kxusTdnnNIHe6HIy5dUA?=
 =?us-ascii?Q?6vNTE/SRDbJhLGbtghvJGsEIwOIKdgJyzAIRxUTDGLTIzE5mZSejDsfGL/mz?=
 =?us-ascii?Q?2N4UNrhvueBsHjdItmq4OjhnGg1BwsaviRKr6aFz3FuL2WouxW2R3oy0rLsi?=
 =?us-ascii?Q?gr2TJrIolcs9wy/MPHRyW0vqyN1OfO6U9C9sSD/+En0W0aHGuFuIdmzt3tsL?=
 =?us-ascii?Q?pm2Un5F2OWOaERAGU4FjRwG4rPcTrwIv7JoDGFFxw295xSoFhBkVO41Hbzu2?=
 =?us-ascii?Q?KLyT/18Qj995sygaR72fkSPcYJ5tvW0ueJ7Mpe7Qwg+3KfnTH5NfuN4RnZTA?=
 =?us-ascii?Q?LJq/xEcRbm56J3eFR0zE/DP/cJZ1dFdEA8EbpULWmXXpOfmBxiX2kisq04WB?=
 =?us-ascii?Q?TCVkXHJriikmRjG1yNVjQHQ9COrAI8fnBfPdQ386FO2McEuMgsPe8p9FAAHH?=
 =?us-ascii?Q?Kjeqhqn3jmErB2m/n7SKyI23GGwgSeNFG3XzS+IAItsmU75AYaqbMIXAflaP?=
 =?us-ascii?Q?RsPEwUR1ay+JgaQaxBI0T73+PLQaNrovvoqKcchVqF8iRiRqqEUPPNVzkjl2?=
 =?us-ascii?Q?wJ1gPbPvhLUkwq2TUDjGgTkbL+ILSf5qsWr09krWeZDwDgD5ufNDkj+2r2eT?=
 =?us-ascii?Q?G073N60vk0JSKaAFoMpq1USL5treI+/pK0uBI+Fi9Qky1BChf7oPkKo2jZ9H?=
 =?us-ascii?Q?wQwuI0Yx01g8Z/Wz+s50W56PqpjZMWXFCL3+iIQlswZjmUs5m2euNvTZYWTi?=
 =?us-ascii?Q?C68cAZftTr31elrwvTFebNrjYJJwfZuCEqAEti+Q6T5rov2E5hNOk8js/De9?=
 =?us-ascii?Q?z/ROnO39z6pXAD5yQq1hS3nlIj7U3Pf5NQlUrZ93icu23Zm+ldZXM6oAjt+h?=
 =?us-ascii?Q?cut5J1LlDLCht1HGoa+hZ9WNSYkP0olbDncAGJ/ncwJaGEmqX15ZCliJKncn?=
 =?us-ascii?Q?+BMRZrq1eMhNC5D1+F+hapV4Dvtl7TeRaat8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:10:13.4810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e4f126-52b3-4177-3df8-08ddfa5f7a2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915

From: Peter Gonda <pgonda@google.com>

Move the GHCB definitions from svm.h to the tools/ copy. This allows the
SEV-ES selftest to use GHCBs which are required for non-trival VMs to
paravirtualize NonAutomaticExits (NAEs) when SEV-ES is enabled. GHCB
getters/setters have a warning with address-of-packed-member, so removed
this using the CFLAGS.

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +-
 tools/testing/selftests/kvm/include/x86/svm.h | 106 ++++++++++++++++++
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 90f03f00cb04..6dd8675b4861 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -237,7 +237,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
 	-fno-builtin-memcmp -fno-builtin-memcpy \
-	-fno-builtin-memset -fno-builtin-strnlen \
+	-fno-builtin-memset -fno-builtin-strnlen -Wno-address-of-packed-member \
 	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
 	-I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH) \
diff --git a/tools/testing/selftests/kvm/include/x86/svm.h b/tools/testing/selftests/kvm/include/x86/svm.h
index 29cffd0a9181..66dd4eaf23b9 100644
--- a/tools/testing/selftests/kvm/include/x86/svm.h
+++ b/tools/testing/selftests/kvm/include/x86/svm.h
@@ -317,4 +317,110 @@ struct __attribute__ ((__packed__)) vmcb {
 
 #define SVM_CR0_SELECTIVE_MASK (X86_CR0_TS | X86_CR0_MP)
 
+struct ghcb_save_area {
+	u8 reserved_0x0[203];
+	u8 cpl;
+	u8 reserved_0xcc[116];
+	u64 xss;
+	u8 reserved_0x148[24];
+	u64 dr7;
+	u8 reserved_0x168[16];
+	u64 rip;
+	u8 reserved_0x180[88];
+	u64 rsp;
+	u8 reserved_0x1e0[24];
+	u64 rax;
+	u8 reserved_0x200[264];
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u8 reserved_0x320[8];
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u8 reserved_0x380[16];
+	u64 sw_exit_code;
+	u64 sw_exit_info_1;
+	u64 sw_exit_info_2;
+	u64 sw_scratch;
+	u8 reserved_0x3b0[56];
+	u64 xcr0;
+	u8 valid_bitmap[16];
+	u64 x87_state_gpa;
+} __packed;
+
+#define GHCB_SHARED_BUF_SIZE	2032
+
+struct ghcb {
+	struct ghcb_save_area save;
+	u8 reserved_save[2048 - sizeof(struct ghcb_save_area)];
+
+	u8 shared_buffer[GHCB_SHARED_BUF_SIZE];
+
+	u8 reserved_0xff0[10];
+	u16 protocol_version;	/* negotiated SEV-ES/GHCB protocol version */
+	u32 ghcb_usage;
+} __packed;
+
+/* GHCB Accessor functions */
+
+#define GHCB_BITMAP_IDX(field)							\
+	(offsetof(struct ghcb_save_area, field) / sizeof(u64))
+
+#define DEFINE_GHCB_ACCESSORS(field)						\
+	static __always_inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb) \
+	{									\
+		return test_bit(GHCB_BITMAP_IDX(field),				\
+				(unsigned long *)&ghcb->save.valid_bitmap);	\
+	}									\
+										\
+	static __always_inline u64 ghcb_get_##field(struct ghcb *ghcb)		\
+	{									\
+		return ghcb->save.field;					\
+	}									\
+										\
+	static __always_inline u64 ghcb_get_##field##_if_valid(struct ghcb *ghcb) \
+	{									\
+		return ghcb_##field##_is_valid(ghcb) ? ghcb->save.field : 0;	\
+	}									\
+										\
+	static __always_inline void ghcb_set_##field(struct ghcb *ghcb, u64 value) \
+	{									\
+		__set_bit(GHCB_BITMAP_IDX(field),				\
+			  (unsigned long *)&ghcb->save.valid_bitmap);		\
+		ghcb->save.field = value;					\
+	}
+
+DEFINE_GHCB_ACCESSORS(cpl)
+DEFINE_GHCB_ACCESSORS(rip)
+DEFINE_GHCB_ACCESSORS(rsp)
+DEFINE_GHCB_ACCESSORS(rax)
+DEFINE_GHCB_ACCESSORS(rcx)
+DEFINE_GHCB_ACCESSORS(rdx)
+DEFINE_GHCB_ACCESSORS(rbx)
+DEFINE_GHCB_ACCESSORS(rbp)
+DEFINE_GHCB_ACCESSORS(rsi)
+DEFINE_GHCB_ACCESSORS(rdi)
+DEFINE_GHCB_ACCESSORS(r8)
+DEFINE_GHCB_ACCESSORS(r9)
+DEFINE_GHCB_ACCESSORS(r10)
+DEFINE_GHCB_ACCESSORS(r11)
+DEFINE_GHCB_ACCESSORS(r12)
+DEFINE_GHCB_ACCESSORS(r13)
+DEFINE_GHCB_ACCESSORS(r14)
+DEFINE_GHCB_ACCESSORS(r15)
+DEFINE_GHCB_ACCESSORS(sw_exit_code)
+DEFINE_GHCB_ACCESSORS(sw_exit_info_1)
+DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
+DEFINE_GHCB_ACCESSORS(sw_scratch)
+DEFINE_GHCB_ACCESSORS(xcr0)
+
 #endif /* SELFTEST_KVM_SVM_H */
-- 
2.34.1


