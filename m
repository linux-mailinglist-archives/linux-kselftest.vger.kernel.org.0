Return-Path: <linux-kselftest+bounces-27855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9CA495B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C693B2BA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8E25744D;
	Fri, 28 Feb 2025 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gUDhlWRp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6006724A046;
	Fri, 28 Feb 2025 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736029; cv=fail; b=BFunhyhEPMLIRlbbeBeKaVvQmeb8CFDIEgCcIF+aI7pj9qHm9rDBJr4JTgQfvNQDHOxhXE68wgTLpxvhVrFxVKjIHfgvuUBRlexWIv361JqrU63W9+B1TXx9PqzcgwnzUYTVZv74bZlQyopp8nH673mWh2C8c10Zi9W08gQ9hxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736029; c=relaxed/simple;
	bh=FXVh/zuHDRHbPOa6+9mMlgbu3VuCcYOPqoExnVyUDik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPub67H54YV43hIEiyGfGhd1ERDH98LQyPjEl1uvAzgPT1YYsUHzv1MWB4HSKvB3kKge6nk8DRdmjWrz+/NiQ7KiOL3+kWCWfjOgLsMGTOfh8VTc5wdzHA++eR6Qx0kLXByFcY3PKEQTXpwQsdPTjhyEkfl6Hs08NwaOsKHHycg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gUDhlWRp; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHwZIccdeAAlhsknP+KXG9gtHLxtYFOHdAk/h6XGoZHRKY0aaEUCqrf04A0wItrETW5fGIcpBEAV9UeYMGwvjwo9KlX+GbzMlNHnFZBKL4FOIMBBdqFJcsxtnTkiZHqpY5RAbrHZLPp4JnnWSZdjZ84y53dwSNqRrIAW5fyh4GU1iSzrXqtHs/XSi7P6d+xLZUh3v+KwKayB13G3L4ehX9QtGIa/JNN9TsK2uA9irKnSR+XZVyx/kRXs4dLhsR4JHyMDXW8ksAfaIufE0DzbsZy/i0yKoguNIOzPpO4KZL21BIskWERu0ScT5xiqa7kFJhufEm5kCQHKOzsuqfue6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6vnjCrD/2UqBEd6FjHRpFaruWh9l1c8uXOm6CBKRdg=;
 b=KqIyjzOTdS+EQxsn/JKZBeReRVA65sU6Kny/495lxbFIbQvNSi39x3S8Vj8nDRPoRbQZKRYu+Ge1RsXbeojpSf2cXp2rkGgJ32QbVdT0LTwh24nx5W+b3P32WhbwK+//gXokz6HA2q9RjNCLof9/RW+7fuZLR9fln8+PHIsKqQ+Eh0oMLs6GSTCwqQGiuEOyzHoJ7koCX2X39C1SDjre5kl69deBRNBb7jxzr13jKC6UMROumGI1tKrOlW875esu7zQxMbqW67b0NBJxeP832VVpibQMsVIORDAUbCUKXzz2OOOCeTROMZCX9jTvFwR7nenQLtnJu0s2ZJ1BowWfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6vnjCrD/2UqBEd6FjHRpFaruWh9l1c8uXOm6CBKRdg=;
 b=gUDhlWRp8ruvspMgoyNc61KicS6P7WeQcEfTUbKAYG0cndhyyebTqLz06bvgGQ2vzPic0VDcUX7X51dt6bzdnwGQL9C9C4NsObg0U9oaPS145HkjtphhMgyOIbqr2rIXmWLLagrHdOqklxWeJyvUjjj0rY0p19bwMV1YfWSLjdQ=
Received: from PH7PR17CA0020.namprd17.prod.outlook.com (2603:10b6:510:324::11)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 09:46:59 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::d5) by PH7PR17CA0020.outlook.office365.com
 (2603:10b6:510:324::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 09:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:46:58 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:46:52 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 13/31] KVM: selftests: Add instruction decoding support
Date: Fri, 28 Feb 2025 15:00:06 +0530
Message-ID: <20250228093024.114983-14-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b244cb-e1e8-477a-729b-08dd57dcd865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0UOuutW4lFWk9snXIwMb0cxqhUX34sdEKo8uOaWZLVjBWjTMmgGPWt6O985?=
 =?us-ascii?Q?t92p3mgNueUjpshxNzoMJY5E1tGoZV+1d21tfYFY+mnVSkbbuYpYik5TY6OZ?=
 =?us-ascii?Q?d9p3auDRb5/9YiumO0gtPWy84MjM4Gzmat/iIWbLhzp/9TM5vmQgsq8vO4iD?=
 =?us-ascii?Q?qofzyIV5eQ61M599xDIc9D41KPu5wLhaZ0jzX1CSf7T4jc8qbuPjlJlOwUxW?=
 =?us-ascii?Q?Se8IBEpQWBFNWCePokxbCZhW2CEx0YYt/zSIH1FDw2HsjUou02f+//oWcB02?=
 =?us-ascii?Q?1t7EKat+PCPFgiVnYKPeyh+lZTSXTbxcx2lChm1fRcSutVZai03WJFAAH95m?=
 =?us-ascii?Q?zpca9lFQtdRrZIMGl3DLbC8xsCXrh08+AdwwDeGf3z4L9B4b9QaoJE4VuUzR?=
 =?us-ascii?Q?7WfLq+8lvgG5BlfzAPR4dGGIfz5TypneP3hO+J3yFxPvffwThvaEGRElecZW?=
 =?us-ascii?Q?4ygElf3KzlVTROir2KvRDSNupFfkMYsQlIdZTW85vzLHemimS11XSKt6K1Mr?=
 =?us-ascii?Q?ccVDHOzNcCZqkYzVXX/eMGQp6avekdexg/i4OTKP80KYYX+PEAGpRlwQc5zi?=
 =?us-ascii?Q?dMKHpI9vkgO14VBQF4rQXYTexa3cNod1/aY0cMgrJzJrT9MWl5nFeh3yOfvn?=
 =?us-ascii?Q?3isXj1S9T5nrKyrPC5TTrksG1ZNPixCqQjQIPp4CFavWNu+BY4G5Rz7jHTge?=
 =?us-ascii?Q?iuyu1CGb1Ttne3uqZREspJCXpsBziuhm21LMyPhIEhZ+1+Rdu+UphndxEyV6?=
 =?us-ascii?Q?BQNg5wA06xXzHXN5JF/pgIJ765VdXhhhU6I3PpqYd5MLdcRS1wgUrZMss31R?=
 =?us-ascii?Q?P9UcqShmNEn2DgFclBNAnWZP2lGp16KbeHl5Ej34EjcrQDZSgeY5zHbslVU4?=
 =?us-ascii?Q?uPkGYWiBrKzQivgbsaJHqN6O2YZ0rGTWEdPraHLYBU+xwseA7ba+TdnYr0sh?=
 =?us-ascii?Q?anTSEDQ3toECzOlmOHRNvDOa4MxzvmZBpGBImIcSZP31rkwUK6s4WcJqZsvq?=
 =?us-ascii?Q?EphF/dF06lZ1ZWEEvZk6qonltj1CflWFCzgWGLu3ygBopu2jeMFcNQLShxQx?=
 =?us-ascii?Q?QWEw14xJY4ddui9QcBY9FGbSFfDTmpsiW5UQgNHX6LXAMbvLmwm/EGS+pZM6?=
 =?us-ascii?Q?bvb/7zxD1hy6RCs+t4ev+FVZpfYF2Fkx3lEdFrgJOpDSqTxzICLZDYXbCjSn?=
 =?us-ascii?Q?tHszfSQ+xx5d+wQH6r8X8A2ZiKHi9eTUB0Z2hoSHdu7tsZkneKg7d6Y1yiVf?=
 =?us-ascii?Q?ag3hWA25wdvUGC2lcAMYcYmAhvpC2YYi+B/xu6uxoTIitLY9nyDgtCBO7rdb?=
 =?us-ascii?Q?FG++IcSOMYEeBHZcWFjh3l6/FbFK8JnGgnR7fEGmSEuoZqzyvbgPNG8Umb1U?=
 =?us-ascii?Q?qpP3DYOR6rAupMUcLNoEzraSSTH7YQLK/Cf4GAg7FWecLw6xVmMRpnbQzjw/?=
 =?us-ascii?Q?qrJLXS6yQwS9YpZ5gcAJbkf0RrA67BBVzVYwVKXsBm6oGymtOFSIuPFWSG1r?=
 =?us-ascii?Q?IbrLh/nd3OzfwPA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:46:58.9708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b244cb-e1e8-477a-729b-08dd57dcd865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

Update insn-eval.c to prototype instruction decoding for MMIO
VC exception exit.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  12 +
 .../selftests/kvm/include/x86/ex_regs.h       |  21 ++
 .../selftests/kvm/include/x86/insn-eval.h     |  48 ++++
 .../selftests/kvm/include/x86/processor.h     |  12 +-
 .../testing/selftests/kvm/lib/x86/insn-eval.c | 268 +++++++++++-------
 5 files changed, 240 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/ex_regs.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/insn-eval.h

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index b4894cb56861..5a67e79ae848 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -21,6 +21,7 @@ LIBKVM_STRING += lib/string_override.c
 LIBKVM_x86 += lib/x86/apic.c
 LIBKVM_x86 += lib/x86/handlers.S
 LIBKVM_x86 += lib/x86/hyperv.c
+LIBKVM_x86 += lib/x86/insn-eval.c
 LIBKVM_x86 += lib/x86/memstress.c
 LIBKVM_x86 += lib/x86/pmu.c
 LIBKVM_x86 += lib/x86/processor.c
@@ -238,6 +239,17 @@ ifeq ($(ARCH),x86)
 ifeq ($(shell echo "void foo(void) { }" | $(CC) -march=x86-64-v2 -x c - -c -o /dev/null 2>/dev/null; echo "$$?"),0)
 	CFLAGS += -march=x86-64-v2
 endif
+
+tools_lib_dir := $(top_srcdir)/tools/arch/x86/lib
+inat_tables_script = $(top_srcdir)/tools/arch/x86/tools/gen-insn-attr-x86.awk
+inat_tables_maps = $(top_srcdir)/tools/arch/x86/lib/x86-opcode-map.txt
+$(shell awk -f $(inat_tables_script) $(inat_tables_maps) > $(tools_lib_dir)/inat-tables.c)
+LIBKVM_x86 += $(tools_lib_dir)/insn.c
+LIBKVM_x86 += $(tools_lib_dir)/inat.c
+EXTRA_CLEAN += $(tools_lib_dir)/inat-tables.c
+EXTRA_CLEAN += $(tools_lib_dir)/insn.o
+EXTRA_CLEAN += $(tools_lib_dir)/inat.o
+
 endif
 ifeq ($(ARCH),arm64)
 tools_dir := $(top_srcdir)/tools
diff --git a/tools/testing/selftests/kvm/include/x86/ex_regs.h b/tools/testing/selftests/kvm/include/x86/ex_regs.h
new file mode 100644
index 000000000000..172cfbb0a2d0
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/ex_regs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2018, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_EX_REGS_H
+#define SELFTEST_KVM_EX_REG_H
+
+struct ex_regs {
+	uint64_t rax, rcx, rdx, rbx;
+	uint64_t rbp, rsi, rdi;
+	uint64_t r8, r9, r10, r11;
+	uint64_t r12, r13, r14, r15;
+	uint64_t vector;
+	uint64_t error_code;
+	uint64_t rip;
+	uint64_t cs;
+	uint64_t rflags;
+};
+
+#endif
diff --git a/tools/testing/selftests/kvm/include/x86/insn-eval.h b/tools/testing/selftests/kvm/include/x86/insn-eval.h
new file mode 100644
index 000000000000..0c7bad1c9215
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/insn-eval.h
@@ -0,0 +1,48 @@
+#ifndef _ASM_X86_INSN_EVAL_H
+#define _ASM_X86_INSN_EVAL_H
+/*
+ * A collection of utility functions for x86 instruction analysis to be
+ * used in a kernel context. Useful when, for instance, making sense
+ * of the registers indicated by operands.
+ */
+
+#include <stdbool.h>
+
+#include "ex_regs.h"
+
+#define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
+#define INSN_CODE_SEG_OPND_SZ(params) (params & 0xf)
+#define INSN_CODE_SEG_PARAMS(oper_sz, addr_sz) (oper_sz | (addr_sz << 4))
+
+int ex_regs_offset(struct ex_regs *regs, int regno);
+
+bool insn_has_rep_prefix(struct insn *insn);
+void *insn_get_addr_ref(struct insn *insn, struct ex_regs *regs);
+int insn_get_modrm_rm_off(struct insn *insn, struct ex_regs *regs);
+int insn_get_modrm_reg_off(struct insn *insn, struct ex_regs *regs);
+unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct ex_regs *regs);
+unsigned long insn_get_seg_base(struct ex_regs *regs, int seg_reg_idx);
+int insn_get_code_seg_params(struct ex_regs *regs);
+int insn_get_effective_ip(struct ex_regs *regs, unsigned long *ip);
+int insn_fetch_from_user(struct ex_regs *regs,
+			 unsigned char buf[MAX_INSN_SIZE]);
+int insn_fetch_from_user_inatomic(struct ex_regs *regs,
+				  unsigned char buf[MAX_INSN_SIZE]);
+bool insn_decode_from_regs(struct insn *insn, struct ex_regs *regs,
+			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
+
+enum insn_mmio_type {
+	INSN_MMIO_DECODE_FAILED,
+	INSN_MMIO_WRITE,
+	INSN_MMIO_WRITE_IMM,
+	INSN_MMIO_WRITE_MOV_ABS,
+	INSN_MMIO_READ,
+	INSN_MMIO_READ_ZERO_EXTEND,
+	INSN_MMIO_READ_SIGN_EXTEND,
+	INSN_MMIO_MOVS,
+	INSN_MMIO_READ_MOV_ABS,
+};
+
+enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
+
+#endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 56029d07680a..3f9369644962 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1145,17 +1145,7 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
 void kvm_init_vm_address_properties(struct kvm_vm *vm);
 bool vm_is_unrestricted_guest(struct kvm_vm *vm);
 
-struct ex_regs {
-	uint64_t rax, rcx, rdx, rbx;
-	uint64_t rbp, rsi, rdi;
-	uint64_t r8, r9, r10, r11;
-	uint64_t r12, r13, r14, r15;
-	uint64_t vector;
-	uint64_t error_code;
-	uint64_t rip;
-	uint64_t cs;
-	uint64_t rflags;
-};
+#include "ex_regs.h"
 
 struct idt_entry {
 	uint16_t offset0;
diff --git a/tools/testing/selftests/kvm/lib/x86/insn-eval.c b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
index 98631c0e7a11..efa4d3fde504 100644
--- a/tools/testing/selftests/kvm/lib/x86/insn-eval.c
+++ b/tools/testing/selftests/kvm/lib/x86/insn-eval.c
@@ -3,20 +3,29 @@
  *
  * Copyright (C) Intel Corporation 2017
  */
+#ifdef __KERNEL__
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/ratelimit.h>
 #include <linux/mmu_context.h>
 #include <asm/desc_defs.h>
 #include <asm/desc.h>
-#include <asm/inat.h>
-#include <asm/insn.h>
-#include <asm/insn-eval.h>
 #include <asm/ldt.h>
 #include <asm/vm86.h>
+#else
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <errno.h>
+#endif
+
+#include "kselftest.h"
+#include "ucall_common.h"
+#include <asm/inat.h>
+#include <asm/insn.h>
+#include "insn-eval.h"
 
-#undef pr_fmt
-#define pr_fmt(fmt) "insn: " fmt
+#define CONFIG_X86_64
 
 enum reg_type {
 	REG_TYPE_RM = 0,
@@ -140,7 +149,7 @@ static int get_seg_reg_override_idx(struct insn *insn)
 /**
  * check_seg_overrides() - check if segment override prefixes are allowed
  * @insn:	Valid instruction with segment override prefixes
- * @regoff:	Operand offset, in pt_regs, for which the check is performed
+ * @regoff:	Operand offset, in ex_regs, for which the check is performed
  *
  * For a particular register used in register-indirect addressing, determine if
  * segment override prefixes can be used. Specifically, no overrides are allowed
@@ -153,17 +162,22 @@ static int get_seg_reg_override_idx(struct insn *insn)
  */
 static bool check_seg_overrides(struct insn *insn, int regoff)
 {
-	if (regoff == offsetof(struct pt_regs, di) && is_string_insn(insn))
+	if (regoff == offsetof(struct ex_regs, rdi) && is_string_insn(insn))
 		return false;
 
 	return true;
 }
 
+static bool any_64bit_mode(struct ex_regs *regs)
+{
+	return true;
+}
+
 /**
  * resolve_default_seg() - resolve default segment register index for an operand
  * @insn:	Instruction with opcode and address size. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @off:	Operand offset, in pt_regs, for which resolution is needed
+ * @off:	Operand offset, in ex_regs, for which resolution is needed
  *
  * Resolve the default segment register index associated with the instruction
  * operand register indicated by @off. Such index is resolved based on defaults
@@ -176,10 +190,11 @@ static bool check_seg_overrides(struct insn *insn, int regoff)
  *
  * -EINVAL in case of error.
  */
-static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
+static int resolve_default_seg(struct insn *insn, struct ex_regs *regs, int off)
 {
 	if (any_64bit_mode(regs))
 		return INAT_SEG_REG_IGNORE;
+#ifndef CONFIG_X86_64
 	/*
 	 * Resolve the default segment register as described in Section 3.7.4
 	 * of the Intel Software Development Manual Vol. 1:
@@ -195,9 +210,9 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
 	 */
 
 	switch (off) {
-	case offsetof(struct pt_regs, ax):
-	case offsetof(struct pt_regs, cx):
-	case offsetof(struct pt_regs, dx):
+	case offsetof(struct ex_regs, ax):
+	case offsetof(struct ex_regs, cx):
+	case offsetof(struct ex_regs, dx):
 		/* Need insn to verify address size. */
 		if (insn->addr_bytes == 2)
 			return -EINVAL;
@@ -205,32 +220,34 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
 		fallthrough;
 
 	case -EDOM:
-	case offsetof(struct pt_regs, bx):
-	case offsetof(struct pt_regs, si):
+	case offsetof(struct ex_regs, bx):
+	case offsetof(struct ex_regs, si):
 		return INAT_SEG_REG_DS;
 
-	case offsetof(struct pt_regs, di):
+	case offsetof(struct ex_regs, di):
 		if (is_string_insn(insn))
 			return INAT_SEG_REG_ES;
 		return INAT_SEG_REG_DS;
 
-	case offsetof(struct pt_regs, bp):
-	case offsetof(struct pt_regs, sp):
+	case offsetof(struct ex_regs, bp):
+	case offsetof(struct ex_regs, sp):
 		return INAT_SEG_REG_SS;
 
-	case offsetof(struct pt_regs, ip):
+	case offsetof(struct ex_regs, ip):
 		return INAT_SEG_REG_CS;
 
 	default:
 		return -EINVAL;
 	}
+#endif
+	return -EINVAL;
 }
 
 /**
  * resolve_seg_reg() - obtain segment register index
  * @insn:	Instruction with operands
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Operand offset, in pt_regs, used to determine segment register
+ * @regoff:	Operand offset, in ex_regs, used to determine segment register
  *
  * Determine the segment register associated with the operands and, if
  * applicable, prefixes and the instruction pointed by @insn.
@@ -258,7 +275,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
  * are done using helper functions.
  *
  * The operand register, @regoff, is represented as the offset from the base of
- * pt_regs.
+ * ex_regs.
  *
  * As stated, the main use of this function is to determine the segment register
  * index based on the instruction, its operands and prefixes. Hence, @insn
@@ -278,7 +295,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
  *
  * -EINVAL in case of error.
  */
-static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
+static int resolve_seg_reg(struct insn *insn, struct ex_regs *regs, int regoff)
 {
 	int idx;
 
@@ -288,7 +305,7 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
 	 * be used. Hence, it is not necessary to inspect the instruction,
 	 * which may be invalid at this point.
 	 */
-	if (regoff == offsetof(struct pt_regs, ip)) {
+	if (regoff == offsetof(struct ex_regs, rip)) {
 		if (any_64bit_mode(regs))
 			return INAT_SEG_REG_IGNORE;
 		else
@@ -327,9 +344,9 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
  * @seg_reg_idx:	Segment register index to use
  *
  * Obtain the segment selector from any of the CS, SS, DS, ES, FS, GS segment
- * registers. In CONFIG_X86_32, the segment is obtained from either pt_regs or
+ * registers. In CONFIG_X86_32, the segment is obtained from either ex_regs or
  * kernel_vm86_regs as applicable. In CONFIG_X86_64, CS and SS are obtained
- * from pt_regs. DS, ES, FS and GS are obtained by reading the actual CPU
+ * from ex_regs. DS, ES, FS and GS are obtained by reading the actual CPU
  * registers. This done for only for completeness as in CONFIG_X86_64 segment
  * registers are ignored.
  *
@@ -340,9 +357,9 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
  *
  * -EINVAL on error.
  */
-static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
+static short get_segment_selector(struct ex_regs *regs, int seg_reg_idx)
 {
-	unsigned short sel;
+	//unsigned short sel;
 
 #ifdef CONFIG_X86_64
 	switch (seg_reg_idx) {
@@ -350,8 +367,9 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 		return 0;
 	case INAT_SEG_REG_CS:
 		return (unsigned short)(regs->cs & 0xffff);
+#if 0
 	case INAT_SEG_REG_SS:
-		return (unsigned short)(regs->ss & 0xffff);
+		return (unsigned short)(regs->cs & 0xffff);
 	case INAT_SEG_REG_DS:
 		savesegment(ds, sel);
 		return sel;
@@ -364,6 +382,7 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 	case INAT_SEG_REG_GS:
 		savesegment(gs, sel);
 		return sel;
+#endif
 	default:
 		return -EINVAL;
 	}
@@ -412,32 +431,32 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 }
 
 static const int pt_regoff[] = {
-	offsetof(struct pt_regs, ax),
-	offsetof(struct pt_regs, cx),
-	offsetof(struct pt_regs, dx),
-	offsetof(struct pt_regs, bx),
-	offsetof(struct pt_regs, sp),
-	offsetof(struct pt_regs, bp),
-	offsetof(struct pt_regs, si),
-	offsetof(struct pt_regs, di),
+	offsetof(struct ex_regs, rax),
+	offsetof(struct ex_regs, rcx),
+	offsetof(struct ex_regs, rdx),
+	offsetof(struct ex_regs, rbx),
+	offsetof(struct ex_regs, rbx), // ex_regs->sp not declared
+	offsetof(struct ex_regs, rbp),
+	offsetof(struct ex_regs, rsi),
+	offsetof(struct ex_regs, rdi),
 #ifdef CONFIG_X86_64
-	offsetof(struct pt_regs, r8),
-	offsetof(struct pt_regs, r9),
-	offsetof(struct pt_regs, r10),
-	offsetof(struct pt_regs, r11),
-	offsetof(struct pt_regs, r12),
-	offsetof(struct pt_regs, r13),
-	offsetof(struct pt_regs, r14),
-	offsetof(struct pt_regs, r15),
+	offsetof(struct ex_regs, r8),
+	offsetof(struct ex_regs, r9),
+	offsetof(struct ex_regs, r10),
+	offsetof(struct ex_regs, r11),
+	offsetof(struct ex_regs, r12),
+	offsetof(struct ex_regs, r13),
+	offsetof(struct ex_regs, r14),
+	offsetof(struct ex_regs, r15),
 #else
-	offsetof(struct pt_regs, ds),
-	offsetof(struct pt_regs, es),
-	offsetof(struct pt_regs, fs),
-	offsetof(struct pt_regs, gs),
+	offsetof(struct ex_regs, ds),
+	offsetof(struct ex_regs, es),
+	offsetof(struct ex_regs, fs),
+	offsetof(struct ex_regs, gs),
 #endif
 };
 
-int pt_regs_offset(struct pt_regs *regs, int regno)
+int ex_regs_offset(struct ex_regs *regs, int regno)
 {
 	if ((unsigned)regno < ARRAY_SIZE(pt_regoff))
 		return pt_regoff[regno];
@@ -453,8 +472,10 @@ static int get_regno(struct insn *insn, enum reg_type type)
 	 * Don't possibly decode a 32-bit instructions as
 	 * reading a 64-bit-only register.
 	 */
+#if 0
 	if (IS_ENABLED(CONFIG_X86_64) && !insn->x86_64)
 		nr_registers -= 8;
+#endif
 
 	switch (type) {
 	case REG_TYPE_RM:
@@ -508,18 +529,18 @@ static int get_regno(struct insn *insn, enum reg_type type)
 		break;
 
 	default:
-		pr_err_ratelimited("invalid register type: %d\n", type);
+		__GUEST_ASSERT(0, "invalid register type: %d\n", type);
 		return -EINVAL;
 	}
 
 	if (regno >= nr_registers) {
-		WARN_ONCE(1, "decoded an instruction with an invalid register");
+		__GUEST_ASSERT(0, "decoded an instruction with an invalid register");
 		return -EINVAL;
 	}
 	return regno;
 }
 
-static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
+static int get_reg_offset(struct insn *insn, struct ex_regs *regs,
 			  enum reg_type type)
 {
 	int regno = get_regno(insn, type);
@@ -527,7 +548,7 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
 	if (regno < 0)
 		return regno;
 
-	return pt_regs_offset(regs, regno);
+	return ex_regs_offset(regs, regno);
 }
 
 /**
@@ -537,7 +558,7 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
  * @offs1:	Offset of the first operand register
  * @offs2:	Offset of the second operand register, if applicable
  *
- * Obtain the offset, in pt_regs, of the registers indicated by the ModRM byte
+ * Obtain the offset, in ex_regs, of the registers indicated by the ModRM byte
  * in @insn. This function is to be used with 16-bit address encodings. The
  * @offs1 and @offs2 will be written with the offset of the two registers
  * indicated by the instruction. In cases where any of the registers is not
@@ -547,7 +568,7 @@ static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
  *
  * 0 on success, -EINVAL on error.
  */
-static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
+static int get_reg_offset_16(struct insn *insn, struct ex_regs *regs,
 			     int *offs1, int *offs2)
 {
 	/*
@@ -556,21 +577,21 @@ static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
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
@@ -604,6 +625,7 @@ static int get_reg_offset_16(struct insn *insn, struct pt_regs *regs,
 	return 0;
 }
 
+#ifndef CONFIG_X86_64
 /**
  * get_desc() - Obtain contents of a segment descriptor
  * @out:	Segment descriptor contents on success
@@ -660,6 +682,7 @@ static bool get_desc(struct desc_struct *out, unsigned short sel)
 	*out = *(struct desc_struct *)(gdt_desc.address + desc_base);
 	return true;
 }
+#endif
 
 /**
  * insn_get_seg_base() - Obtain base address of segment descriptor.
@@ -678,21 +701,23 @@ static bool get_desc(struct desc_struct *out, unsigned short sel)
  *
  * -1L in case of error.
  */
-unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
+unsigned long insn_get_seg_base(struct ex_regs *regs, int seg_reg_idx)
 {
-	struct desc_struct desc;
+	// struct desc_struct desc;
 	short sel;
 
 	sel = get_segment_selector(regs, seg_reg_idx);
 	if (sel < 0)
 		return -1L;
 
+#ifndef CONFIG_X86_64
 	if (v8086_mode(regs))
 		/*
 		 * Base is simply the segment selector shifted 4
 		 * bits to the right.
 		 */
 		return (unsigned long)(sel << 4);
+#endif
 
 	if (any_64bit_mode(regs)) {
 		/*
@@ -701,6 +726,7 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 		 */
 		unsigned long base;
 
+#ifndef CONFIG_X86_64
 		if (seg_reg_idx == INAT_SEG_REG_FS) {
 			rdmsrl(MSR_FS_BASE, base);
 		} else if (seg_reg_idx == INAT_SEG_REG_GS) {
@@ -713,11 +739,15 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 			else
 				rdmsrl(MSR_GS_BASE, base);
 		} else {
+#endif
 			base = 0;
+#ifndef CONFIG_X86_64
 		}
+#endif
 		return base;
 	}
 
+#ifndef CONFIG_X86_64
 	/* In protected mode the segment selector cannot be null. */
 	if (!sel)
 		return -1L;
@@ -726,6 +756,8 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 		return -1L;
 
 	return get_desc_base(&desc);
+#endif
+	return -1L;
 }
 
 /**
@@ -745,9 +777,13 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
  *
  * Zero is returned on error.
  */
-static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
+static unsigned long get_seg_limit(struct ex_regs *regs, int seg_reg_idx)
 {
+	if (any_64bit_mode(regs))
+		return -1L;
+#ifndef CONFIG_X86_64
 	struct desc_struct desc;
+
 	unsigned long limit;
 	short sel;
 
@@ -775,8 +811,11 @@ static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
 		limit = (limit << 12) + 0xfff;
 
 	return limit;
+#endif
+	return -1L;
 }
 
+#ifndef CONFIG_X86_64
 /**
  * insn_get_code_seg_params() - Obtain code segment parameters
  * @regs:	Structure with register values as seen when entering kernel mode
@@ -793,7 +832,7 @@ static unsigned long get_seg_limit(struct pt_regs *regs, int seg_reg_idx)
  *
  * -EINVAL on error.
  */
-int insn_get_code_seg_params(struct pt_regs *regs)
+int insn_get_code_seg_params(struct ex_regs *regs)
 {
 	struct desc_struct desc;
 	short sel;
@@ -834,11 +873,11 @@ int insn_get_code_seg_params(struct pt_regs *regs)
 		 */
 		return INSN_CODE_SEG_PARAMS(4, 8);
 	case 3: /* Invalid setting. CS.L=1, CS.D=1 */
-		fallthrough;
 	default:
 		return -EINVAL;
 	}
 }
+#endif
 
 /**
  * insn_get_modrm_rm_off() - Obtain register in r/m part of the ModRM byte
@@ -848,11 +887,11 @@ int insn_get_code_seg_params(struct pt_regs *regs)
  * Returns:
  *
  * The register indicated by the r/m part of the ModRM byte. The
- * register is obtained as an offset from the base of pt_regs. In specific
+ * register is obtained as an offset from the base of ex_regs. In specific
  * cases, the returned value can be -EDOM to indicate that the particular value
  * of ModRM does not refer to a register and shall be ignored.
  */
-int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs)
+int insn_get_modrm_rm_off(struct insn *insn, struct ex_regs *regs)
 {
 	return get_reg_offset(insn, regs, REG_TYPE_RM);
 }
@@ -865,9 +904,9 @@ int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs)
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
@@ -880,9 +919,9 @@ int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
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
 
@@ -896,7 +935,7 @@ unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
  * get_seg_base_limit() - obtain base address and limit of a segment
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Operand offset, in pt_regs, used to resolve segment descriptor
+ * @regoff:	Operand offset, in ex_regs, used to resolve segment descriptor
  * @base:	Obtained segment base
  * @limit:	Obtained segment limit
  *
@@ -913,7 +952,7 @@ unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
  *
  * -EINVAL on error.
  */
-static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
+static int get_seg_base_limit(struct insn *insn, struct ex_regs *regs,
 			      int regoff, unsigned long *base,
 			      unsigned long *limit)
 {
@@ -940,17 +979,23 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
 	return 0;
 }
 
+static inline unsigned long regs_get_register(struct ex_regs *regs,
+                                              unsigned int offset)
+{
+        return *(unsigned long *)((unsigned long)regs + offset);
+}
+
 /**
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
@@ -959,11 +1004,11 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
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
@@ -994,7 +1039,7 @@ static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_modrm() - Obtain referenced effective address via ModRM
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, associated with segment
+ * @regoff:	Obtained operand offset, in ex_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address referenced by the ModRM byte of @insn. After
@@ -1007,12 +1052,12 @@ static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
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
@@ -1037,7 +1082,7 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
 	 */
 	if (*regoff == -EDOM) {
 		if (any_64bit_mode(regs))
-			tmp = regs->ip + insn->length;
+			tmp = regs->rip + insn->length;
 		else
 			tmp = 0;
 	} else if (*regoff < 0) {
@@ -1061,7 +1106,7 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_modrm_16() - Obtain referenced effective address via ModRM
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, associated with segment
+ * @regoff:	Obtained operand offset, in ex_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the 16-bit effective address referenced by the ModRM byte of @insn.
@@ -1074,12 +1119,12 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
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
@@ -1129,7 +1174,7 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_sib() - Obtain referenced effective address via SIB
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @base_offset: Obtained operand offset, in pt_regs, associated with segment
+ * @base_offset: Obtained operand offset, in ex_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address referenced by the SIB byte of @insn. After
@@ -1142,12 +1187,12 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
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
@@ -1231,7 +1276,7 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
  *
  * -1L on error.
  */
-static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
+static void __user *get_addr_ref_16(struct insn *insn, struct ex_regs *regs)
 {
 	unsigned long linear_addr = -1L, seg_base, seg_limit;
 	int ret, regoff;
@@ -1271,9 +1316,11 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
 
 	linear_addr = (unsigned long)(eff_addr & 0xffff) + seg_base;
 
+#ifndef CONFIG_X86_64
 	/* Limit linear address to 20 bits */
 	if (v8086_mode(regs))
 		linear_addr &= 0xfffff;
+#endif
 
 out:
 	return (void __user *)linear_addr;
@@ -1295,7 +1342,7 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
  *
  * -1L on error.
  */
-static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
+static void __user *get_addr_ref_32(struct insn *insn, struct ex_regs *regs)
 {
 	unsigned long linear_addr = -1L, seg_base, seg_limit;
 	int eff_addr, regoff;
@@ -1346,12 +1393,14 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
 	if (!any_64bit_mode(regs) && ((unsigned int)eff_addr > seg_limit))
 		goto out;
 
+#ifndef CONFIG_X86_64
 	/*
 	 * Even though 32-bit address encodings are allowed in virtual-8086
 	 * mode, the address range is still limited to [0x-0xffff].
 	 */
 	if (v8086_mode(regs) && (eff_addr & ~0xffff))
 		goto out;
+#endif
 
 	/*
 	 * Data type long could be 64 bits in size. Ensure that our 32-bit
@@ -1361,8 +1410,10 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
 	linear_addr = (unsigned long)(eff_addr & 0xffffffff) + seg_base;
 
 	/* Limit linear address to 20 bits */
+#ifndef CONFIG_X86_64
 	if (v8086_mode(regs))
 		linear_addr &= 0xfffff;
+#endif
 
 out:
 	return (void __user *)linear_addr;
@@ -1384,12 +1435,12 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
  * -1L on error.
  */
 #ifndef CONFIG_X86_64
-static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
+static void __user *get_addr_ref_64(struct insn *insn, struct ex_regs *regs)
 {
 	return (void __user *)-1L;
 }
 #else
-static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
+static void __user *get_addr_ref_64(struct insn *insn, struct ex_regs *regs)
 {
 	unsigned long linear_addr = -1L, seg_base;
 	int regoff, ret;
@@ -1442,7 +1493,7 @@ static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
  *
  * -1L on error.
  */
-void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
+void __user *insn_get_addr_ref(struct insn *insn, struct ex_regs *regs)
 {
 	if (!insn || !regs)
 		return (void __user *)-1L;
@@ -1462,7 +1513,7 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	}
 }
 
-int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
+int insn_get_effective_ip(struct ex_regs *regs, unsigned long *ip)
 {
 	unsigned long seg_base = 0;
 
@@ -1472,17 +1523,18 @@ int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
 	 * descriptor table), or virtual-8086 mode. In most of the cases
 	 * seg_base will be zero as in USER_CS.
 	 */
-	if (!user_64bit_mode(regs)) {
+	if (0) { //(!user_64bit_mode(regs)) {
 		seg_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
 		if (seg_base == -1L)
 			return -EINVAL;
 	}
 
-	*ip = seg_base + regs->ip;
+	*ip = seg_base + regs->rip;
 
 	return 0;
 }
 
+#if 0
 /**
  * insn_fetch_from_user() - Copy instruction bytes from user-space memory
  * @regs:	Structure with register values as seen when entering kernel mode
@@ -1497,7 +1549,7 @@ int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
  * - 0 if nothing was copied.
  * - -EINVAL if the linear address of the instruction could not be calculated
  */
-int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
+int insn_fetch_from_user(struct ex_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 {
 	unsigned long ip;
 	int not_copied;
@@ -1525,7 +1577,7 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
  *  - 0 if nothing was copied.
  *  - -EINVAL if the linear address of the instruction could not be calculated.
  */
-int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
+int insn_fetch_from_user_inatomic(struct ex_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 {
 	unsigned long ip;
 	int not_copied;
@@ -1537,7 +1589,6 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_IN
 
 	return MAX_INSN_SIZE - not_copied;
 }
-
 /**
  * insn_decode_from_regs() - Decode an instruction
  * @insn:	Structure to store decoded instruction
@@ -1552,12 +1603,12 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_IN
  *
  * True if instruction was decoded, False otherwise.
  */
-bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
+bool insn_decode_from_regs(struct insn *insn, struct ex_regs *regs,
 			   unsigned char buf[MAX_INSN_SIZE], int buf_size)
 {
 	int seg_defs;
 
-	insn_init(insn, buf, buf_size, user_64bit_mode(regs));
+	insn_init(insn, buf, buf_size, 1); //user_64bit_mode(regs));
 
 	/*
 	 * Override the default operand and address sizes with what is specified
@@ -1584,6 +1635,7 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 
 	return true;
 }
+#endif
 
 /**
  * insn_decode_mmio() - Decode a MMIO instruction
@@ -1609,7 +1661,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 	switch (insn->opcode.bytes[0]) {
 	case 0x88: /* MOV m8,r8 */
 		*bytes = 1;
-		fallthrough;
 	case 0x89: /* MOV m16/m32/m64, r16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
@@ -1618,7 +1669,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 	case 0xc6: /* MOV m8, imm8 */
 		*bytes = 1;
-		fallthrough;
 	case 0xc7: /* MOV m16/m32/m64, imm16/imm32/imm64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
@@ -1627,7 +1677,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 	case 0x8a: /* MOV r8, m8 */
 		*bytes = 1;
-		fallthrough;
 	case 0x8b: /* MOV r16/r32/r64, m16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
@@ -1636,7 +1685,6 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 	case 0xa4: /* MOVS m8, m8 */
 		*bytes = 1;
-		fallthrough;
 	case 0xa5: /* MOVS m16/m32/m64, m16/m32/m64 */
 		if (!*bytes)
 			*bytes = insn->opnd_bytes;
-- 
2.34.1


