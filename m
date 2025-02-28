Return-Path: <linux-kselftest+bounces-27843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5EA49520
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F4155188C0C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7FE2566DF;
	Fri, 28 Feb 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T1OuRbK7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275C255E54;
	Fri, 28 Feb 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735253; cv=fail; b=Ocjo0nUedQd7haxfvc3Rx5I30v81P/HDqPM5d+Dvn7eWsB1qVJIX+Pshv3hC1s73HADR/yx/cF5CWXz04ZQHUB/y3v7GNrjaHp5MBaGrHdBlNZnlVCjYmLhENX+e/RmDnBGLP1Hzv+dRGrhS2fCymlLIxZyID4G08R6gwOjYWtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735253; c=relaxed/simple;
	bh=XpAnJjgKhVW9CuPBioVE7fEw/OdvsBcHTbG60ub+YSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzZNfpou5ncWcnnc96j/UaecSB7M+2GBiKV64Vx+BR7vnoekTx+I/ZSxqv7+q4mmWGWDNg64Tme/9IyYOrvPR2pzvqIBI4Z19Vckdzw0YpXLBRhemYOQ4wX08zEcRGHd8bxanDPtBmr181Kj6W84K2dF9Ty4F/IEys2WzVLdCt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T1OuRbK7; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSel9BSHlVWT0QotaIYe+N1wv3a5Tj6nZuNXMg9U/Yx+7aVBHTV5inSfEyu70OAb2Wi0cyHhy8RL9YH8Dxi370c86GEMIgXuPzUKZTfF6nMn3NRAQYr3fYhdhtbrnfPBpbL2wZeDHcM/tq4Np/CLsqE7GE/pbozA56K3M0LqxneGf0mY9tStjyR/oWG38Ohy7PzFh7dnYJGmmPP2aGvL5xCBdFRa+sGOzxIsSvFn2Tzc+HMLDYhpAnZEcDO2on6wZDAdCOACuZGgsch7VHOoZfZvI+nTF8i0WRy7LuNw1lcS2Z+ooDwuo9p/2jWpVDDKzeHf1xzfBy4qCYHmEPDKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZVP3aZvBRW8rsS2DLI2Brk7MEZneNdCPE1hyu3aNS4=;
 b=pSrj2EWSD8g30zj11BzcFunJZ9iTTL/D6ag7EpzvRW0o1FMNNuamqzhGUNU8iSF1I5JceFEVS7vVC1io2rCkiXm2pvFZY70TL6aoyOvwHajUBIW7rXQhQKiABD9ZlLWwon6D9QiAmtjnx5knF9IwyGZE2hMqhImyB1DF6kaSBuqP/WXFYqjay65nTV7mKRtJWcMI9xXBnJ62ac2uBbgzeJhunrPE21+rYu98vZlA6aCkBS+WOHa38ZxKkN0cFcWj0HwPf82Cf08D7Ba0M62H0Vrt/+4QePaGwB1C6jZ+qeUf3O9JaNz3+SlcZQHFMp14iUa8e5lz8ctMriG6xlb20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZVP3aZvBRW8rsS2DLI2Brk7MEZneNdCPE1hyu3aNS4=;
 b=T1OuRbK7/aH7eFnXbeJ1yG2/8+K5sFK55LAEYGgf6iAh056bEOa4RL9PavUYNpzCTFB4+T+V8Ezm16xuo2RDAupjFd6TfEz41+P+osIpWOPM26gnfqMiUuTIa8ESXgDUK4b90Wn9OcQYWyT/+4qcPkJOVMfDP1gOC9n+nf5Gqfc=
Received: from MW3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:303:2b::34)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 09:34:08 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::5f) by MW3PR05CA0029.outlook.office365.com
 (2603:10b6:303:2b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 09:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:34:07 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:31:54 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 01/31] Add GHCB with setters and getters
Date: Fri, 28 Feb 2025 14:59:54 +0530
Message-ID: <20250228093024.114983-2-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6fbac6-6cb2-4a0e-5361-08dd57db0cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a99YpjueFmuHi8ithtN2i3pNDeq29vduWb1hpClA/X32vYCm8nUYDr4C+lta?=
 =?us-ascii?Q?2gXytNke3nMo4c+gNy3XYajgiVclbn5S8Oe6/wWC8Q9XrlTJVoEn4k9KWLw7?=
 =?us-ascii?Q?5qKfBn+oFh77X6DVPBZNS1AwN9Vxkh0zon+0yh2xhqbKC4PCqqP1ccTIDLPC?=
 =?us-ascii?Q?V8KCQNTYYhGtPwvNJnyrLVTDnPrINRVXytPcQbz1mcPkz+JrK1aTfxEK2EQ/?=
 =?us-ascii?Q?8w/OKkA5zXjAPEOPvdTlTG2iNSuxn+P/jvWS4dziTwdAvJHiwHK/cXI61jaD?=
 =?us-ascii?Q?atz6CHymMwZ0m6zdmlKOEnDgZDZdWPHUmP2LI+h1gsY3/eTHpNVgXXAQMbWq?=
 =?us-ascii?Q?acaZ9c0PWzOSDoW23+5BKzzGbsibOT1GZMqQ0B0CS9k1ilak7YR8znh0H8s5?=
 =?us-ascii?Q?Nsr/Hp1mc0BIqCy/EYumggK9s5JzK5wxNQWvDiZ+G5l/V4CE4yV/Gp6ks3mS?=
 =?us-ascii?Q?7T2oCCevcSSO3Ac8KeJC+apwevKIwo4Y6d0DAFINzSGGMOepGsdk9K90XLCU?=
 =?us-ascii?Q?vlU0Jmupqzkd4rJEZCL7UAzTGUCGVPMm2SBbZwDaZGHOAYKtRPkZYm1wwG9P?=
 =?us-ascii?Q?Juy8pYCNhGOurSd3OJ1T+0AafpnW3TI5CXCXT0zs4AXpDi8Y5L5lQWsQmTmX?=
 =?us-ascii?Q?hLsDFMBriq3PZry8PYnGR0TmkuXxVFnircINGHiHcAL9DqXn5i3bZb3kcaUs?=
 =?us-ascii?Q?ZVKElAFoRGfpWSDMCicyr/JP+ta8rABh4h7jZLH4ce3znNnETlMO9H0QO+q1?=
 =?us-ascii?Q?TUvf67/M/KvxSNI0T+EImaQMbv4tEXOtIrzlQbNsGvBE+AOc8oudARuaTSte?=
 =?us-ascii?Q?p5ozwaP0wqGTpxbLtmypH+XV1V8zJ25pwV4uzzYSM+EhnNq2KbzJlhJq6J3z?=
 =?us-ascii?Q?NQw0zxJRonRY24w54D2qBlwb9I08ibLPwGwa3tGGyLfK5Oo4WeV7e/k/b6T3?=
 =?us-ascii?Q?QRTxzXrP1X+pJVNoc3tKSZMMdcjcDlgF59ht2F66QHWbiRw5IkiQ9R086avC?=
 =?us-ascii?Q?Lkxbt/W1qtb4KJUC/ePGrVeZDOrgjW+ddzwyIdQ6/DvOshfuHjdnPYFmKVQ9?=
 =?us-ascii?Q?dSbmHxRMS+i073lbLIEglUTCIJYJ0wvj87iqV2NisY4py6LisxyjI1ELVF4+?=
 =?us-ascii?Q?wYj7Fhqx+5gHnoUkpMPijtjPPkhA1StnCsXXh0f5wc4a/O1Ws1ggWm349Sjo?=
 =?us-ascii?Q?IFmzz+dV7ZzSYNIWzEC1lEJMUMH+eCXJDBa1LW/7WrBVH6jjj6T59jDRLpc6?=
 =?us-ascii?Q?HtDiPVbH/3KHWbeKMAPCP3F13Omz7qq78Ks+YnjL68rik5rjydjkVwqh+HEk?=
 =?us-ascii?Q?b/6VAJH/ZC/mS2Sck7bY3iJifd3ZRwKpEtjP15Qs2rwPek/kfF3V1rUXkkSG?=
 =?us-ascii?Q?YR216sg4hX9O+sjHEG0WoKeyenXtEUArl7FSV+5UIYO4g4NBOxSerYjkkIp3?=
 =?us-ascii?Q?/ONTRoFQwEMBbkYIIvSEGT5F1Nx68ZQ5ER4fjQ1dgLUt6gjY3L+a6tBo0OWB?=
 =?us-ascii?Q?epXGqSvk3ELsO4g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:34:07.9390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6fbac6-6cb2-4a0e-5361-08dd57db0cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911

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
index 4277b983cace..b4894cb56861 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -226,7 +226,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
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


