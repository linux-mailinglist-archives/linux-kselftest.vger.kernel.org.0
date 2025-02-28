Return-Path: <linux-kselftest+bounces-27865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC53A49624
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23FD16AC7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6D125A33F;
	Fri, 28 Feb 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0i4vXZKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1AB1C549E;
	Fri, 28 Feb 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736733; cv=fail; b=u3DagAzw18oTkiioVdkgPOUL/zEjT1fu5kMdo5ONL32BM4Y2OTJI+ubIZTtLDxcZ0kAkhNkJ5G1VDp3ujKk6JHK7IvOd/g4dZYP9TiOTr95vtpkmBOT0k12vpfSeIWvmjEjFn15XBoZgM8QagKraRBn+6KtCu/2im0xZcTo2zgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736733; c=relaxed/simple;
	bh=X5AtZqwYNiN2IO1TDfOJihxa1Se4EYS5vBE54UoPrCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbWNLKsiFLplzRhZT69rRr5uwS5rFPuE06tThLX1k+L/clKxf8gv6roYn/hzGWug8Ei3YWKp7s7ZCl7t7FnenigR3sua6eZ+1eTN0TZ+y/GOdhLj+XUlvJpWmRuvkFw/MTmuLa1UEAkvIV7Lmm13yf0RPS4vux5ZMu+sFIQhCGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0i4vXZKk; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvmAow1YxH0INgZXXRrSklYcxS7xGPjoYKblwMcYDnFxKTVb3W9A709PwltV7quGnkuq+dahuVPusjRECbsTDO5TEloJpHcJmgVeWG2IIFN86m9q2dfckHLekx/IFeyaQCyS40UMoj/FZpqAMmSNdCZIBVWc8TpCHWKODWh5qTiQ3+PJsFI3gxgf29tLpMZDX17ud8QiX0JYyk+ZuxV6YWtC/CXrfEQ8qkMCrA8Na1alzBBrNSZPkt/EqAmfy0y9vmUVUprfYSdum/3Tra0cONNTxofvtvzoW5JKcQEOLIvcKZA3MpZ3xsO/9qCZG2ib+VSL6iy9oPH69QzkefgcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U6QGD3k90AAUfGnLFNyGgKhdR73Mp/Q25y+ARP8ysM=;
 b=SV5aos21v+TiwiEqhu/Ejq4Qjc7o4z1gcqLFwtObb8TW0aQy5+GVLVX4O74mVanYiaObbUwXh4WVh6VQNehCnRW1l+yfgkxIFd9r9WLe7eUOqVsV0zPQVLgInPK/1qSYqoifqB5V+vjmquqfKf5586iqB+JJmeWLU49WD7A+5o5/5TDwMRel9V8WmHu70Dpr7eCjATcTj64rsmpUVO1BmaRrBAvRgGPByGfTdlQ4dl2GjYNQW8TUMuf8i5Ecdt8Hl6QmykmiIFOWfIW2nK6CgtEjR9SfV5/plU20R3SpxVJNhiMHzrTvlHRHRk93aE1uIDSR5MwXnIXasn+QqzLZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U6QGD3k90AAUfGnLFNyGgKhdR73Mp/Q25y+ARP8ysM=;
 b=0i4vXZKkJ2eBKTSFVfx0mgden51RnZxPzPKO8jFtWfeyLwK6G+wIDjq2UvX9ir3vaOfe66+KoMp8ZBSbtBjnsM8VB3WnAXkUg+PoaIVZ8xkLai2SMENp+uSsDDpJ7GPgCn/m/CCuOobutcnFG4kFDhFvPT502PwxMqD7AKejvQ4=
Received: from SA1PR03CA0005.namprd03.prod.outlook.com (2603:10b6:806:2d3::6)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 09:58:47 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::49) by SA1PR03CA0005.outlook.office365.com
 (2603:10b6:806:2d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 09:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:58:46 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:57:50 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 23/31] KVM: selftests: Add SAVIC GPA notification GHCB call
Date: Fri, 28 Feb 2025 15:00:16 +0530
Message-ID: <20250228093024.114983-24-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0aebf8-2303-4c25-f31c-08dd57de7e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CIoRQgyVlx8tC9AU+N9P1jXA5yDabSbzAVAP9G3dfN30dr4vPRFbOk4XsWdo?=
 =?us-ascii?Q?UYQdAtg7xAR+QMz7/hvS7OklCglxcxa8DvU9CJLPAUEsAlPrC4ert2BSamIQ?=
 =?us-ascii?Q?eM/OEcAJWe7/V7CRx1UMUWgD7zOY4+V6sVdw+2MCilK8XSOKAyeX+cVGXfIm?=
 =?us-ascii?Q?W7J/DceKfYrtNp/0A8G8yfQqCLofmLoyGeUnnPePW2lPnRw8eRqfLEwsBPIN?=
 =?us-ascii?Q?T870zShu4hPLpw9CuM/OFO1ENbaB5HZJNNXvaJQN/7hY8NLFGRN5s5nrsel3?=
 =?us-ascii?Q?vcO4mtMQtuzd2Km5WW18FxLftKHP3hQPxHBOHHjHdtw4J7rqG9PKB2xXiY/h?=
 =?us-ascii?Q?3ktjpPH3LeDgTdYgh7PMEJTsWM+R6WQPpFE7lxpLxIl/QOgbPukNkjHVSCAO?=
 =?us-ascii?Q?vPmfeln3rgpDzV2k0cDpaHpPGLf/guv6ATp0ZbdGQHofHZ4o2dZr1Y9kZuJ8?=
 =?us-ascii?Q?TMWspHEcO6hTK3EMLfQieSbrvYIJRAznvitjZGhFtQj5Z+BlTkHA3opXxKjf?=
 =?us-ascii?Q?xrFx7eocnDZxcOc389TZM2uN3i/SNtXh6TR6IzgHZobAql1We36mG8cR19hR?=
 =?us-ascii?Q?DpObMPZIpyrq9UCSZwM9qnOEPNTIN04Di0jpwimfOPZ0/PTQ8ye3pSpBSipF?=
 =?us-ascii?Q?fK+aIJtpcJQwz4CHlo8Cen2KbFZI4htl2WjJFrd79HCQDG/UJ31hkt3OI9X4?=
 =?us-ascii?Q?cHKRaVey89FrcmA5nqKTDgfZbgpQSF8CA8NNUdV+41qqgjyZPKyGTb+pLSQg?=
 =?us-ascii?Q?TWFT6BHkXP1n1qg5bWORogDNogxpaR8s4CR20Mso3XfSQdGEMdrBPL1+aGJL?=
 =?us-ascii?Q?IiaVF3c/886D4AcKQvfx9cFX3451fgUSPighmFxnqCLl3YnwfdKI7A6OgGpA?=
 =?us-ascii?Q?ncAmae6bjLVJooU3VzcIPZvMxYNv0qi0nn7kH0FzK/R5kn+VutQFA2YQXbgN?=
 =?us-ascii?Q?dfwlduBBuYZaIp9FMfRCTfsAo/uK7qLpwVX0n4PS+k07nk2bwcUQgAi+OFV4?=
 =?us-ascii?Q?l+LcmKzMQ6xVw32k9mALlK8dmj4ZcNgTAzpI6lPXOTQvhZJKGui3l2TbXNDv?=
 =?us-ascii?Q?bVxMXV46YprwMH7dj7xsZjhBXhVY5AhFcomRyC13uenToIOQ7FPUAv7mQq/9?=
 =?us-ascii?Q?yWyo7QemxtnnylflxzjJoh6+4m8Pd/G/GzMxapCDiYtH2HHA7NknYWFO6p5d?=
 =?us-ascii?Q?R7wtq1aH7qHcWkDa0lwfGg4PvtwSA8VRgbdpM2mtiP5IijEFb0jmkAqk82UZ?=
 =?us-ascii?Q?nzdQnAMEPqckYW2pF0F1+oEAXrSTf27ayFd+Pa3k+EZzPSZeGTjAuNMBbgw7?=
 =?us-ascii?Q?CgPAKTPYDCLEa/SFxXH1WLn86RbY+HUqIuvGijxjwpPbI0A2MaHpEGiEyTy7?=
 =?us-ascii?Q?FEYxPEYayhmxeOZx4tyMOmrNgUKK1oQ9Q41KLJoPjWj9mkaqRB+Lh2pfgnFS?=
 =?us-ascii?Q?s6n43ESEXSEgkZR2WEIfkAOtZzDuaDJPlJi/qsc/I+OKie47mIDsKEzJ1k2U?=
 =?us-ascii?Q?4qfMLuLiilGxleg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:58:46.8476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0aebf8-2303-4c25-f31c-08dd57de7e46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

Add GHCB call to register Secure AVIC guest APIC backing page
GPA with the hyperversior. This call ensures that guest APIC
backing page is pinned in NPT while vCPU is running.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h |  1 +
 tools/testing/selftests/kvm/lib/x86/savic.c   |  1 +
 tools/testing/selftests/kvm/lib/x86/sev.c     | 25 ++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index ffb5ded0a35a..81ee79f63b7f 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -159,4 +159,5 @@ void sev_es_ucall_port_write(uint32_t port, uint64_t data);
 void sev_es_vc_handler(struct ex_regs *regs);
 void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write);
 void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write);
+void sev_es_savic_notify_gpa(uint64_t gpa);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index 8259f7521e73..ae48978479bf 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -204,6 +204,7 @@ void savic_enable(void)
 	apic_page = &apic_page_pool->guest_apic_page[apic_id];
 
 	savic_init_backing_page(apic_page, apic_id);
+	sev_es_savic_notify_gpa(apic_page->gpa);
 	set_savic_control_msr(apic_page, true, true);
 	savic_ctrl_msr_val = rdmsr(MSR_AMD64_SECURE_AVIC_CONTROL);
 	exp_msr_val = apic_page->gpa | BIT_ULL(MSR_AMD64_SECURE_AVIC_EN_BIT) |
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 7675950efe56..24a2a29a575b 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -8,6 +8,7 @@
 #include "linux/bitmap.h"
 #include "svm.h"
 #include "svm_util.h"
+#include "savic.h"
 
 #define IOIO_TYPE_STR (1 << 2)
 #define IOIO_SEG_DS (1 << 11 | 1 << 10)
@@ -17,7 +18,8 @@
 #define SW_EXIT_CODE_IOIO	0x7b
 #define SW_EXIT_CODE_MSR	0x7c
 #define SVM_VMGEXIT_MMIO_READ		   0x80000001
-#define SVM_VMGEXIT_MMIO_WRITE		  0x80000002
+#define SVM_VMGEXIT_MMIO_WRITE		   0x80000002
+#define SVM_VMGEXIT_SECURE_AVIC	   0x8000001a
 
 struct ghcb_entry {
 	struct ghcb ghcb;
@@ -775,3 +777,24 @@ void sev_es_vc_handler(struct ex_regs *regs)
 		__GUEST_ASSERT(0, "No VC handler\n");
 	}
 }
+
+void sev_es_savic_notify_gpa(uint64_t gpa)
+{
+	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
+	int ret;
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+
+	register_ghcb_page(entry->gpa);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SECURE_AVIC);
+	ghcb_set_rax(ghcb, -1ULL);
+	ghcb_set_rbx(ghcb, gpa);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+	do_vmg_exit(entry->gpa);
+	ret = ghcb->save.sw_exit_info_1 & 0xffffffff;
+	__GUEST_ASSERT(!ret, "Secure AVIC GPA notification failed, ret: %d", ret);
+	ghcb_free(entry);
+}
-- 
2.34.1


