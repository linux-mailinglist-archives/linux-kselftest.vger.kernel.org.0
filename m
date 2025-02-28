Return-Path: <linux-kselftest+bounces-27856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC8A495DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1B03B299C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B925A2A8;
	Fri, 28 Feb 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g1/Nd44i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532C258CE4;
	Fri, 28 Feb 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736205; cv=fail; b=lUH0YKV97B3Y23GoGTC8OqR/0m9SAaDOwNnSp9FLmAJ1lxg4SDLzfxABUWB/nuW9MzFs6T6Z+ftxRgXDgXLIEmFnufouYVysPjEvFg/DpR6A0JnOrf08hk/S492obh6V/PVCtsH/oaRfZzCX7UIXiwED/Fx0sdKFN/aTTt3y+m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736205; c=relaxed/simple;
	bh=1JUK3obeublxvo4e/gV4GaEfKEXLpx15rEF7jOfDvV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akB8DWfvHsREh5fOwAQU8RqMOEg+y1D3LA3RlddJIUzN3UU4m8XN8V5JGxDc1tT8gXanx4Itl/K0hbnsBQPjWHc4sWV90aDCgd/e1jc1kEc+/TphTV4bzknvpUww5M4cYnb8dcNzm5jhno24HKMxIIxFtrXDil0uHTTVGFyysdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g1/Nd44i; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCvJQU6XtstMUHPcMiOA+e27gV/xc/3+as+M/0spG2Js5U5Dvz+Wpf7YkmgzIz6+kcCgmzeD2/1tzVnBLEACzsoct2Rgiifk/5FEm02cDiFtNLF0LojvcauF4su4IcFp1Cb6Gm7zsq7jSyRfA0baaajymL3KUjNKrkUnf/OgJTQcAoIO6EiVqUpQoYNFGhlnqM63Ne7/0tyWRJyJNqJsD0yBBPFlUfLa85wkQFKyw8Dexus9LDuU7rtt4Kovmdcjeg+OfyI+PnngjsoWRKphJ0FvZwPI+T9HEDBSW8+x9wIetK9IdqhVxnkZuMoXS7EiB/eoGhFYR4f6P3waTqieiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSgv/mXuA4I9W+srFDajKf0GOwHiQGffypCIyRaXIeU=;
 b=m/ROfcSpqQcqqdnhHJfjfGWC9zzZYFSVL1Tu6FTltQGoNUswlbOJJoF6T/KAy4BRn2RV1C75SpCh2vRolRMlB5Mj5p5S37EbNxjDB87pXI2W/FleKl08lWZp3KUXJRO/i7/InSdJKZ3Udbqa0eJsdCG1gIWy2qtUlXAX7tB18Kq/0RvJo2+Jnz6IpFQ0royAU+w45wRNjD6CwTEFvdvRK1CnC0O6C64SIwDXaJjcTuaAXrV7xv/5NFyd4fGk49c5ZgTjdMHQEQr9X7+iL9dDrDUs9zmMwDlewBnXGRZy0bJN0YtNqo0kXESBuqBVKBScTBUDlCkqHS92fBcYubccLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSgv/mXuA4I9W+srFDajKf0GOwHiQGffypCIyRaXIeU=;
 b=g1/Nd44i0IEY/8cIHWkHONJKu3GOExbLXdPN+2wTPGu7RsRZ3RV+Z061k0mfHO2i7NjfLHNA1VrE3eH2JpG6+nJzn7Bmisac13aTNFrzMKiU/NwdOYZJxxKS9045JdEWpAPAHJyCFbMq2Es+WhzhWajxdk9mkCKrA2VKIaMHP40=
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:50:00 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::eb) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Fri,
 28 Feb 2025 09:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:49:59 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:47:24 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 14/31] KVM: selftests: Add MMIO VC exception handling for SEV-ES guests
Date: Fri, 28 Feb 2025 15:00:07 +0530
Message-ID: <20250228093024.114983-15-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: b922af5f-93d7-4791-2afa-08dd57dd441e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hoAZH3RkTTzyJnr8sXZc5EXC0+1bu2w1LwgiPwgpRIOvMZo4gMCtoNLqmr/A?=
 =?us-ascii?Q?8B/RkjPPnPFDNOPXDRSR0joJ6bFZB/FfWx7a+7nSxuAfraZ6Qld94g4ebC8X?=
 =?us-ascii?Q?4ujNLE/KSOcn5gv8Bq/h3oRHdm9qwkEjGiOjpuJmThxjpYfl8npQakdRWao2?=
 =?us-ascii?Q?o6P5a4R+Dk204/TG2k7NxdUjDe5Zy4+s4a8mu8aYWcI+4nPKyZfiyqnzu9Ma?=
 =?us-ascii?Q?iKLFGI+OweHiDiIiXSvWQ4QvMYg3dnhuq8gvJ/o7s7YSWxJZOZLf+Gn5yoWX?=
 =?us-ascii?Q?ifR4XMWsoR6//j8lTjMglPcsfKAr2ccblFkimUcSS1Pi5CI8ZAXSxhZg2tFE?=
 =?us-ascii?Q?pb84vLFue+Q4PZXSCf/TWJs04cDUz4/An+7qyb0zak798sur2O+DdpCYMVDs?=
 =?us-ascii?Q?yMxd9mcwOFXNtmjmnbMKesWdlRPNn29WHHnOTd+jmOQVhOs8Aqy3WV1hdBaW?=
 =?us-ascii?Q?4T1APdsfIn4zJkv89enYnh85ga/NmTr8vxyji3noOMZKGNOgFAFflpiaMxS1?=
 =?us-ascii?Q?DUYi1h+7tvxFzeN0vDL9VwoCtOzxGDJjhRhukB1dg0e9QkSjYCQvigDaVtJ+?=
 =?us-ascii?Q?3X5pyoSPFM+0Xx+F1JG//xOjFvf02o1s3hrGpgWZgQSzgvJ/hOrDkLB2qsHJ?=
 =?us-ascii?Q?DJfCQ9JZ80bL6Q6scnHcpUW3LxAHH/M8d/TThrmGGR+8Our0HbFwuJ5SphSS?=
 =?us-ascii?Q?1EgPllLkx5fY+ff+oYrdq07tqEXrPhCHEaolfvzqkkjUZBln+E8HDJcDQzRU?=
 =?us-ascii?Q?d3ve+7tK0/Km2HyBO4tcW8VKUnGryF4gop7JmFBgOmJE8LlQdQwHPW/B7frn?=
 =?us-ascii?Q?Bb1uJ9yR7+roqTChwUvE4HvaTdKfu8/dnxCevprAfFbSLEMzXA/C3OVh7GMO?=
 =?us-ascii?Q?90YExGDgcnLXwDI3jaqZfVNZVeMc25pNV9Om2okjIZgOdNxfLu3TfhhTlcHc?=
 =?us-ascii?Q?g7TWkibeZQ4an6fFE++5l1A0zaFK/7Xl/drvcB7IvTeeZet+Yp04+k++cWcW?=
 =?us-ascii?Q?yo3BsKCgjfOBcEEeQCkMyNydRWXVS9f+9XLwEsSw4IIX4TvL7nKm2qFwOCnz?=
 =?us-ascii?Q?VjgxEjRunsd1xV9qQEJ6A1ZQqtgaR2lR3uqp2twbHTr76nTgd5DrJl9UCFSl?=
 =?us-ascii?Q?Lc8+XqXm+VbuOmVcbb0a0TNdRDbbAjim37MeeU10orx1DmGc9Ax/TsuFLOF2?=
 =?us-ascii?Q?G4W9IQahquqUBROEKHq+ECGY83lOrIreUJ3MVlMJzcE0XBS4jsE8ShN2Mhtb?=
 =?us-ascii?Q?e23XqrmpU7wP30TM5nLPT4MPMGbwC4gWdNteFivTE4whNmzwqjX9azIidjQF?=
 =?us-ascii?Q?7t9tNc0Sdro00g2vDYdciX6FoHPPe3wxqVvSgZ9u9htUnF6FRyIkiFRkQcoi?=
 =?us-ascii?Q?Zu6/rB8J8TxLbdecXXNUJcxcO/zrzYOS0MfTfSfNx5uer52+eacmlghYUH0E?=
 =?us-ascii?Q?cvj6AmexkdiOWQXVeYDkpkBp9C+kLEBulIVU4V/X6G6VtlImGLWbXqPYoxx2?=
 =?us-ascii?Q?EHBYeqHo6SPjZPg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:49:59.7133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b922af5f-93d7-4791-2afa-08dd57dd441e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

Add MMIO VC exception handling support to allow xapic mmio access
for SEV-ES guests. In addition, add a PV interface for xapic MMIO
guest accesses from outside of VC exception handler context.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/include/x86/ex_regs.h       |   2 +-
 tools/testing/selftests/kvm/include/x86/sev.h |   1 +
 tools/testing/selftests/kvm/lib/x86/sev.c     | 259 +++++++++++++++++-
 3 files changed, 257 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/ex_regs.h b/tools/testing/selftests/kvm/include/x86/ex_regs.h
index 172cfbb0a2d0..fd773b6614bc 100644
--- a/tools/testing/selftests/kvm/include/x86/ex_regs.h
+++ b/tools/testing/selftests/kvm/include/x86/ex_regs.h
@@ -4,7 +4,7 @@
  */
 
 #ifndef SELFTEST_KVM_EX_REGS_H
-#define SELFTEST_KVM_EX_REG_H
+#define SELFTEST_KVM_EX_REGS_H
 
 struct ex_regs {
 	uint64_t rax, rcx, rdx, rbx;
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 5556ee891260..3756805197c3 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -155,4 +155,5 @@ void sev_es_ucall_port_write(uint32_t port, uint64_t data);
 
 void sev_es_vc_handler(struct ex_regs *regs);
 void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write);
+void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index ff8f02b83871..16d6b21649d1 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <stdint.h>
 #include <stdbool.h>
+#include <asm/insn.h>
 
+#include "insn-eval.h"
 #include "sev.h"
 #include "linux/bitmap.h"
 #include "svm.h"
@@ -14,6 +16,8 @@
 
 #define SW_EXIT_CODE_IOIO	0x7b
 #define SW_EXIT_CODE_MSR	0x7c
+#define SVM_VMGEXIT_MMIO_READ		   0x80000001
+#define SVM_VMGEXIT_MMIO_WRITE		  0x80000002
 
 struct ghcb_entry {
 	struct ghcb ghcb;
@@ -362,10 +366,10 @@ static uint64_t setup_exitinfo1_portio(uint32_t port)
 
 #define GHCB_MSR_REG_GPA_REQ		0x012
 #define GHCB_MSR_REG_GPA_REQ_VAL(v)			\
-        /* GHCBData[63:12] */				\
-        (((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
-        /* GHCBData[11:0] */				\
-        GHCB_MSR_REG_GPA_REQ)
+	/* GHCBData[63:12] */				\
+	(((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_REG_GPA_REQ)
 
 static void register_ghcb_page(uint64_t ghcb_gpa)
 {
@@ -471,6 +475,250 @@ static void sev_es_vc_msr_handler(struct ex_regs *regs)
 	ghcb_free(entry);
 }
 
+static void __sev_es_hv_mmio_rw(struct ghcb_entry *entry, uint32_t *reg_gpa,
+				unsigned int bytes, bool write)
+{
+	uint64_t exitinfo1 = (uint64_t)reg_gpa;
+	struct ghcb *ghcb = &entry->ghcb;
+	int ret;
+
+	if (write)
+		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_MMIO_WRITE);
+	else
+		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_MMIO_READ);
+	ghcb_set_sw_exit_info_1(ghcb, exitinfo1);
+	ghcb_set_sw_exit_info_2(ghcb, bytes);
+	ghcb_set_sw_scratch(ghcb, entry->gpa + offsetof(struct ghcb, shared_buffer));
+	do_vmg_exit(entry->gpa);
+	ret = ghcb->save.sw_exit_info_1 & 0xffffffff;
+	__GUEST_ASSERT(!ret, "mmio %s failed, ret: %d",
+			write ? "write" : "read", ret);
+}
+
+void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write)
+{
+	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+
+	register_ghcb_page(entry->gpa);
+
+	if (write)
+		memcpy(&ghcb->shared_buffer, data, sizeof(*data));
+
+	__sev_es_hv_mmio_rw(entry, reg_gpa, sizeof(*data), write);
+
+	if (!write)
+		memcpy(data, &ghcb->shared_buffer, sizeof(*data));
+
+	ghcb_free(entry);
+}
+
+static void do_mmio(struct ghcb_entry *entry, struct ex_regs *regs,
+		struct insn *insn, unsigned int bytes, bool read)
+{
+	void *ref = insn_get_addr_ref(insn, regs);
+
+	register_ghcb_page(entry->gpa);
+	__sev_es_hv_mmio_rw(entry, ref, bytes, !read);
+}
+
+static int vc_write_mem(struct ex_regs *regs, struct insn *insn,
+			unsigned char *dst, unsigned char *buf, size_t size)
+{
+	uint8_t *buffer = (uint8_t *)buf;
+
+	switch (size) {
+	case 1: {
+		uint8_t *target = (uint8_t *)dst;
+
+		memcpy(target, buffer, 1);
+		break;
+	}
+	case 2: {
+		uint16_t *target = (uint16_t *)dst;
+
+		memcpy(target, buffer, 2);
+		break;
+	}
+	case 4: {
+		uint32_t *target = (uint32_t *)dst;
+
+		memcpy(target, buffer, 4);
+		break;
+	}
+	case 8: {
+		uint64_t *target = (uint64_t *)dst;
+
+		memcpy(target, buffer, 8);
+		break;
+	}
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+static int vc_read_mem(struct ex_regs *regs, struct insn *insn,
+		       unsigned char *src, unsigned char *buf, size_t size)
+{
+	switch (size) {
+	case 1: {
+		uint8_t *s = (uint8_t  *)src;
+
+		memcpy(buf, s, 1);
+		break;
+	}
+	case 2: {
+		uint16_t *s = (uint16_t  *)src;
+
+		memcpy(buf, s, 1);
+		break;
+	}
+	case 4: {
+		uint32_t *s = (uint32_t  *)src;
+
+		memcpy(buf, s, 1);
+		break;
+	}
+	case 8: {
+		uint64_t *s = (uint64_t  *)src;
+
+		memcpy(buf, s, 1);
+		break;
+	}
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+
+static int vc_handle_mmio_movs(struct ex_regs *regs, struct insn *insn, unsigned int bytes)
+{
+	unsigned long ds_base, es_base;
+	unsigned char *src, *dst;
+	unsigned char buffer[8];
+	int ret;
+	bool rep;
+	int off;
+
+	ds_base = insn_get_seg_base(regs, INAT_SEG_REG_DS);
+	es_base = insn_get_seg_base(regs, INAT_SEG_REG_ES);
+
+	if (ds_base == -1L || es_base == -1L)
+		return -1;
+
+	src = ds_base + (unsigned char *)regs->rsi;
+	dst = es_base + (unsigned char *)regs->rdi;
+
+	ret = vc_read_mem(regs, insn, src, buffer, bytes);
+	if (ret != 0)
+		return ret;
+
+	ret = vc_write_mem(regs, insn, dst, buffer, bytes);
+	if (ret != 0)
+		return ret;
+
+#define X86_EFLAGS_DF   (1UL << 10)
+	if (regs->rflags & X86_EFLAGS_DF)
+		off = -bytes;
+	else
+		off =  bytes;
+
+	regs->rsi += off;
+	regs->rdi += off;
+
+	rep = insn_has_rep_prefix(insn);
+	if (rep)
+		regs->rcx -= 1;
+
+	if (!rep || regs->rcx == 0)
+		return 0;
+	else
+		return 1;
+}
+
+static void sev_es_vc_mmio_handler(struct ex_regs *regs)
+{
+	char buffer[MAX_INSN_SIZE];
+	struct ghcb_entry *entry;
+	enum insn_mmio_type mmio;
+	unsigned long *reg_data;
+	unsigned int bytes;
+	struct ghcb *ghcb;
+	uint8_t sign_byte;
+	struct insn insn;
+	int ret;
+
+	memcpy(buffer, (uint8_t *)regs->rip, MAX_INSN_SIZE);
+	ret = insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+
+	if (ret < 0)
+		__GUEST_ASSERT(0, "Instruction decode failed, ret: %d\n", ret);
+
+	mmio = insn_decode_mmio(&insn, (int *)&bytes);
+	__GUEST_ASSERT(!(mmio == INSN_MMIO_DECODE_FAILED), " MMIO decode failed\n");
+
+	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
+		reg_data = insn_get_modrm_reg_ptr(&insn, regs);
+		__GUEST_ASSERT(reg_data, "insn_get_modrm_reg_ptr failed\n");
+	}
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+
+	switch (mmio) {
+	case INSN_MMIO_WRITE:
+		memcpy(ghcb->shared_buffer, reg_data, bytes);
+		do_mmio(entry, regs, &insn, bytes, false);
+		break;
+	case INSN_MMIO_WRITE_IMM:
+		memcpy(ghcb->shared_buffer, insn.immediate1.bytes, bytes);
+		do_mmio(entry, regs, &insn, bytes, false);
+		break;
+	case INSN_MMIO_READ:
+		do_mmio(entry, regs, &insn, bytes, true);
+		if (bytes == 4)
+			*reg_data = 0;
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_ZERO_EXTEND:
+		do_mmio(entry, regs, &insn, bytes, true);
+		memset(reg_data, 0, insn.opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_SIGN_EXTEND:
+		do_mmio(entry, regs, &insn, bytes, true);
+		if (bytes == 1) {
+			uint8_t *val = (uint8_t *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x80) ? 0xff : 0x00;
+		} else {
+			uint16_t *val = (uint16_t *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
+		}
+
+		/* Sign extend based on operand size */
+		memset(reg_data, sign_byte, insn.opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_MOVS:
+		ret = vc_handle_mmio_movs(regs, &insn, bytes);
+		break;
+	default:
+		break;
+	}
+
+	ghcb_free(entry);
+	regs->rip += insn.length;
+}
+
 void sev_es_vc_handler(struct ex_regs *regs)
 {
 	uint64_t exit_code = regs->error_code;
@@ -481,6 +729,9 @@ void sev_es_vc_handler(struct ex_regs *regs)
 		/* rdmsr/wrmsr instruction size = 2 */
 		regs->rip += 2;
 		break;
+	case SVM_EXIT_NPF:
+		sev_es_vc_mmio_handler(regs);
+		break;
 	default:
 		__GUEST_ASSERT(0, "No VC handler\n");
 	}
-- 
2.34.1


