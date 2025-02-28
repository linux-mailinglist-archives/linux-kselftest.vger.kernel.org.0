Return-Path: <linux-kselftest+bounces-27862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96C3A49603
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736143B5831
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9452F258CEC;
	Fri, 28 Feb 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yHC+t9hI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD89A2580CE;
	Fri, 28 Feb 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736415; cv=fail; b=BxM/jahfVQOm52s1BGO7hFcywiIxaEqBN+4JiTgEJ7BgQEfXi/gZLVWI9M+qFEZNu8NMi+A9AhDuANrpnFDlS0t29CS7PpMc0ZZlWLoHSeXBnxlwyOEJo1cIgrjLeUL2X/xcQg7i7ytYU8rq8ukI5nuWlbYpoTmRoU8m2gf+n9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736415; c=relaxed/simple;
	bh=9nkeusDo+mnJavezRsOmXyKU9uVXIz32DGnKGaZDjr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/rF3z/sENS5cgsEq3CHh2+wM85qdrgGW8MFklepkzc0qkiPIdGe1Ybu95Dq+jPIKT0+znDDuxPsqg5si6YEoSgottlXQaPU7O55MOMrvAvYcstVmUXB9J7mJ9jXZP5mHK6jcY2IWrq0x5gfwWCRwEMGVfcAN8G+yu7O/4AT4lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yHC+t9hI; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vmd0SUy2ggJV/yHeLmEwCL+Ba9/JzjQ8YRIA7rHtZ2KtjCp1j2pjjulaCc7AgqZmgMxsix6QVj4qXwkpmwKUJuWabS3kHoTUL25bQ4mTubOKCGZuTAU+jpF8gSxHtbEPM8EJUdUbCKdzp5ZDwxFW54JDuGRQ2+ZLloBSZZdWEwbG70PIkQXX3Y1KPSirJkYFIRedyPzixnPnCXtGFwDoAN8sd1s+3GuEIwQ3tymVlW0JFk5twJKlMXJZ/fgP5aKb2pKQ+A4fSopWAroF17mKM3eZQTZ+PDDHyxixTOqFg0QRlFL/dx2jfuCYjZG1xAmSYrRLe4qWI1ubDPtTvqjOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lenrXz8ZRl7sZ39Vx5ZAlgu1sD540YDxOqFepZm5rj0=;
 b=NY0Ex+n5YUoYUy9RR1jvjW2gBvEKEQQzQv4kWdduTgwWnBbh6YC9p64jq+qsdHhEMD1RAY+SN/jBWuVv42FB5p3cohWE/WeWgxrLHC0H5BiTioW8+Qxrb8wFnz60CKHE+XpW1Y58fLBintYo/5Ta5sVZ49dLh04l59sbOIU908QmrR7BjWc8fJphz9h/LveCSdhiYoOV1fkbGVQLQ2Qyh3TbILXQDUETfnBePTi9ZwXNGk59/PglQL2YAQQPZaJ5fSikZ4a1HdES/oSCUopf3zrLhqzy/eWLWTqg/EwhksHnYF4Pb5p5biM3audCJPJ/CCbBGLR9Y7l0ZOM/pf5rEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lenrXz8ZRl7sZ39Vx5ZAlgu1sD540YDxOqFepZm5rj0=;
 b=yHC+t9hIvsknN5ihwuQG86esGaQvLqp2TZ5ZrivGDSQTdA2he5K1TjeS4n1LAZSSlfnSOyDiP27fbkPoZnN+ehO+m+9xS4GzSH14YBkcu8tbNDf8uWXISc2nCf5DT4v2eRGrXO7h+E3DPvrvgMrPZ9IT3ZxJI+1BSCt5/OgiUsc=
Received: from BYAPR07CA0034.namprd07.prod.outlook.com (2603:10b6:a02:bc::47)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:53:30 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::76) by BYAPR07CA0034.outlook.office365.com
 (2603:10b6:a02:bc::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 09:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:53:29 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:52:33 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 20/31] KVM: selftests: Add unaccelerated APIC msrs #VC handling
Date: Fri, 28 Feb 2025 15:00:13 +0530
Message-ID: <20250228093024.114983-21-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ae5257-5b41-47f4-f577-08dd57ddc166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/okJ6659nih+OiBe/i/QKu7/GUWmx5nnkFcwGR4pG+Kq13TdYmTw89gzinZ?=
 =?us-ascii?Q?IDJiXfuSt1xPEv6FIFFYQ8lRvLeWBlHujuFddV7U3Xo2gAxUHVWJ5qg/wvNL?=
 =?us-ascii?Q?Dz4yjLGEwmvhpxTTMGxVeGRFsPCA2+KYNrE4Bdw1a7OIdy25hJhH0VcsChDU?=
 =?us-ascii?Q?b8Azw/V6PYzIpXwBXIUO3miybfZ7fEsv7xuvFP6NFp26tv78xP4coQ72CfwR?=
 =?us-ascii?Q?+ZpNchku8EoRxSefSL8oZYP/FokTXGdW+ImemTBr5gCjFBgnvB4Tqh1JicKP?=
 =?us-ascii?Q?2sy0MGBCnhi9Ol/NFuAv9iE8gGvoG9iRRTggZAyi9BxHVIcYqPPhTk9Rnwfv?=
 =?us-ascii?Q?nYU/N7BfyHKKOV8a9f8GRUAQTowvD+Hhc/N0eb4KVTUAgtrmeFEsXfKsjQca?=
 =?us-ascii?Q?2mYP/rZnRuIeUhG6KIgwauF0G2y0nI2o6juLLFZ42WMtE29vzRzE1YL1WcMD?=
 =?us-ascii?Q?7R/H3zPdgO7fDnx9ZqQRLlPx5beu1degMbfviV6xTvjFMC8eXeR4S8zNuq3z?=
 =?us-ascii?Q?x8e7l13h72VGWS6V3rqv89JtkXr157s7z82XiGJKP0YCsIaJK5CTQ8iXBiCa?=
 =?us-ascii?Q?yGFOiB6SOARELgdY+/z2tohD4WEntL/FBxY1trnjMz5jgBZeS+FJHvhBE83i?=
 =?us-ascii?Q?MxRhA8SzeY+n7dP/AEiRSehN6byzaBpjHtU0plr7fDx6cGKbMDrHyrAIIw0k?=
 =?us-ascii?Q?iapBSajlgHwCCAfmHujR1TWp3RDJLNUL+mTwWAItkmYU2DNi4Q3h2LqkOr/W?=
 =?us-ascii?Q?UdZGhOfUP38LTj+YW3Xn4jA0XLOMlPjJM+L1VGHpJaa7MaErH6CD833ZQBmr?=
 =?us-ascii?Q?tF1051IU0dPhIV10Gv5pSeJ12CDdani1VEeD5FWHdI8fLIqtPfCtFUE7fFRl?=
 =?us-ascii?Q?1Q+eTNMFPvQNbb9Fw6IN0tBPwBIZLJqTCESfBEzVd/pqA9xqX0k+VBVmZ4UC?=
 =?us-ascii?Q?zYnzupYduGsfS+Vx0wGNKExwCqRUpKMl0bSNQIGiytROx4iljFHnG4QBxhyH?=
 =?us-ascii?Q?m1RikV4xBYUsXXzBNsih5PYunnf6uDyaOU1hU+3CVEY2K/2IJsE+MC41LKaH?=
 =?us-ascii?Q?lBiboDR5N9Veflgle+2bmorc2VLn/fquJvm7+QCUwoe1qwYVOEvjFjHvKq2u?=
 =?us-ascii?Q?6SpUHKup7Y8LDtYsIOO6pZ//JhMzpo9qlxZOE3N09ulqnEWKGa1a263B1DZK?=
 =?us-ascii?Q?4CqSUGQ9HWCSiXwGwBWu66vizQmzGlkzQ2gO+dQFMQWOwTxy/nmyWdqAEmm5?=
 =?us-ascii?Q?szW+p+RZXnMpRRmPweiE4Zt0RPRdJ93r88P0mOMzXoNCZC8OAKjbo9REP4Vf?=
 =?us-ascii?Q?rWbI0rm+F6G4+AfGBF/qeb6fylI1ZC53YHllPRs1LciyAV1aJ5WCwW+lGFsS?=
 =?us-ascii?Q?tsGb1711lLei9eje4jZaya7qxo76TMSg4URdvWjWkieUl/4xI9HkUry+qdvl?=
 =?us-ascii?Q?FryBAQzkMfUbQmtcgGP30pB2fKJUUMyMa2mXwBOb2AK9ZjFqhizdTKdCEXoF?=
 =?us-ascii?Q?+nEsNc176VlB+3w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:53:29.9055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ae5257-5b41-47f4-f577-08dd57ddc166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

Add #VC exception handling support for unaccelerated msrs
reads/writes for Secure AVIC guests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/include/x86/apic.h  |   1 +
 .../testing/selftests/kvm/include/x86/savic.h |   1 +
 tools/testing/selftests/kvm/lib/x86/savic.c   | 145 ++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index 6ba5d0545bf8..aa3a5d54c404 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -33,6 +33,7 @@
 #define	APIC_SPIV	0xF0
 #define		APIC_SPIV_FOCUS_DISABLED	(1 << 9)
 #define		APIC_SPIV_APIC_ENABLED		(1 << 8)
+#define APIC_TMR        0x180
 #define APIC_IRR	0x200
 #define	APIC_ICR	0x300
 #define	APIC_LVTCMCI	0x2f0
diff --git a/tools/testing/selftests/kvm/include/x86/savic.h b/tools/testing/selftests/kvm/include/x86/savic.h
index 1ab92dad00c1..238d7450ab6e 100644
--- a/tools/testing/selftests/kvm/include/x86/savic.h
+++ b/tools/testing/selftests/kvm/include/x86/savic.h
@@ -16,4 +16,5 @@ void savic_hv_write_reg(uint32_t reg, uint64_t val);
 uint64_t savic_hv_read_reg(uint32_t reg);
 void savic_enable(void);
 int savic_nr_pages_required(uint64_t page_size);
+void savic_vc_handler(struct ex_regs *regs);
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/savic.c b/tools/testing/selftests/kvm/lib/x86/savic.c
index f4a765b6040a..141d31637e51 100644
--- a/tools/testing/selftests/kvm/lib/x86/savic.c
+++ b/tools/testing/selftests/kvm/lib/x86/savic.c
@@ -42,6 +42,8 @@ enum lapic_lvt_entry {
 #define MSR_AMD64_SECURE_AVIC_EN_BIT       0
 #define MSR_AMD64_SECURE_AVIC_ALLOWED_NMI_BIT       1
 
+#define SVM_EXIT_AVIC_UNACCELERATED_ACCESS      0x402
+
 /*
  * Initial pool of guest apic backing page.
  */
@@ -204,3 +206,146 @@ void savic_enable(void)
 			"SAVIC Control msr unexpected val : 0x%lx, expected : 0x%lx",
 			savic_ctrl_msr_val, exp_msr_val);
 }
+
+static bool savic_reg_access_is_trapped(uint32_t reg)
+{
+	switch (reg) {
+	case APIC_ID:
+	case APIC_TASKPRI:
+	case APIC_EOI:
+	case APIC_LDR:
+	case APIC_SPIV:
+	case APIC_ICR:
+	case APIC_ICR2:
+	case APIC_LVTT:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+	case APIC_TMICT:
+	case APIC_TDCR:
+		return true;
+	case APIC_LVR:
+	case APIC_PROCPRI:
+	case APIC_TMR:
+	case APIC_IRR ... APIC_IRR + 0x70:
+	case APIC_TMCCT:
+		return false;
+	default:
+		return false;
+	}
+}
+
+static void savic_unaccel_apic_msrs_read(struct guest_apic_page *apic_page,
+		uint32_t reg, uint64_t *val)
+{
+	switch (reg) {
+	case APIC_TMICT:
+	case APIC_TMCCT:
+	case APIC_TDCR:
+	case APIC_LVTT:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+		*val = savic_hv_read_reg(reg);
+		break;
+	default:
+		__GUEST_ASSERT(0, "Unexpected unaccelerated read trap for reg: %x\n", reg);
+	}
+}
+
+static void savic_unaccel_apic_msrs_write(struct guest_apic_page *apic_page,
+		uint32_t reg, uint64_t val)
+{
+	switch (reg) {
+	/*
+	 * APIC_ID value is in sync between guest apic backing page and
+	 * hv.
+	 * LVT* registers and APIC timer register updates are propagated to hv.
+	 */
+	case APIC_ID:
+	case APIC_LVTT:
+	case APIC_LVTTHMR:
+	case APIC_LVTPC:
+	case APIC_LVT0:
+	case APIC_LVT1:
+	case APIC_LVTERR:
+	case APIC_TMICT:
+	case APIC_TMCCT:
+	case APIC_TDCR:
+		savic_write_reg(apic_page, reg, val);
+		savic_hv_write_reg(reg, val);
+		break;
+	/*
+	 * LDR is derived in hv from APIC_ID.
+	 * TPR, SPIV, IRR information is not propagated to hv.
+	 */
+	case APIC_LDR:
+	case APIC_TASKPRI:
+	case APIC_SPIV:
+	case APIC_IRR:
+		savic_write_reg(apic_page, reg, val);
+		break;
+	/*
+	 * EOI write need to be propagated to hv for level-triggered
+	 * interrupts.
+	 */
+	case APIC_EOI:
+		savic_hv_write_reg(reg, val);
+		break;
+	default:
+		__GUEST_ASSERT(0, "Write not permitted for reg: %x\n", reg);
+	}
+}
+
+static void handle_savic_unaccel_access(struct ex_regs *regs)
+{
+	bool write;;
+	uint64_t msr = regs->rcx;
+	uint32_t reg = (msr - APIC_BASE_MSR) << 4;
+	struct guest_apic_page *apic_page;
+	uint64_t low = regs->rax;
+	uint64_t high = regs->rdx;
+	uint64_t val = 0;
+
+	apic_page = &apic_page_pool->guest_apic_page[x2apic_read_reg(APIC_ID)];
+
+	switch (msr) {
+	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
+		if (savic_reg_access_is_trapped(reg))
+			write = *((uint8_t *)regs->rip - 1) == 0x30;
+		else
+			write = *((uint8_t *)regs->rip + 1) == 0x30;
+		if (write) {
+			savic_unaccel_apic_msrs_write(apic_page, reg,
+						      high << 32 | low);
+		} else {
+			savic_unaccel_apic_msrs_read(apic_page, reg, &val);
+			regs->rax = val & ((1ULL << 32) - 1);
+			regs->rdx = val >> 32;
+		}
+		if (!savic_reg_access_is_trapped(reg))
+			regs->rip += 2;
+		break;
+	default:
+		__GUEST_ASSERT(0, "Unknown unaccelerated msr: %lx\n", msr);
+		break;
+	}
+}
+
+void savic_vc_handler(struct ex_regs *regs)
+{
+	uint64_t exit_code = regs->error_code;
+
+	switch (exit_code) {
+	case SVM_EXIT_AVIC_UNACCELERATED_ACCESS:
+		handle_savic_unaccel_access(regs);
+		break;
+	default:
+		sev_es_vc_handler(regs);
+		break;
+	}
+}
-- 
2.34.1


