Return-Path: <linux-kselftest+bounces-6039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D38747B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 06:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE64B21C3C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 05:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA9B1CD08;
	Thu,  7 Mar 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V1SlQoNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BE1CA83;
	Thu,  7 Mar 2024 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790414; cv=fail; b=CsN8Bv25/XEb5JuzBWZFQ4wQF3gTylha/Py/CRg0WJEkCU4BP4NK0j4Rf8bB1xRukpnT8B4vKsYXxRyXmn8yy1RKjLfK7P9g/wFLyemylBSWKDr/w7OU8fm2j0IEF+zKnhoPQ0xDUcLs0owSReeotIMbdfXZxLmfaZeFFX/XpY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790414; c=relaxed/simple;
	bh=bAjO314ciVrCF+94M9UvgNY22pwQXfrbDbECdfTzVJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtkn3iYgPW3pYfOGsmnL0hfzu0DesWa9gEA1ybkjzLJGBYqPlQ/RoMbM3GIRQRSOBM2w23swgiQFMyHDm1eASwnbBJLQmXNemYKR0pTjvs8pK7E3tqt/PEDnB53hmqwCic4bMQ3JGE0E2+IelP4qNnJ4DWGGiOWv6emeiaNH2jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V1SlQoNz; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEWPuUBdl2D6qo0nef54xP2jX7mVGeD+B0J+8CVrFQcA3T+LEsqXSCgtrTNnf1cMzHlNAvV/f25oT1Kx1h7IX4zMGiF7bHGxmDd1oIW1uf/JoUq8hcdyC0jPp1Ueiz5r+4TYmVoXoVcCkzcBFttGx6jJ/MIoGQgYUiSCrnqIx95ggYe77cEySJIqonLhqnWWMOy0MDGtB4ZAfv6s8SQlKmAgFy6Y3/EV5dnGnxwC+0tyB4LbavldkjqNN5bt9bqqgr3I/wsHgknfPfqFcwWHsgmio7+TVWaHjXlXaIB5Pg91vRN1+48SdQKUTSgyq+rCx2AG7gvHdvcDerOGm0wImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e829xi7zXSXC6+lziItPzgd3I2nLjYUcDCjcci0rWUk=;
 b=R7VnKNqxSMcAMDYTJljOAp9/mu0uQfFypIzpAacKoy/uCRHct4KiTlo+AHC/LNpiIGfhmktOsYji2ZySlHprht+L3zh3FNgOOPnwKJPUP4ev3A5GKPpeB4D2y/EQyxsjlE9YF4g83pjIYxnONjHPFbpzLqL2veoax2dvOjLmn6JarzM82M2hXtKNh3tdZ6k+cehJsw6PtOj95EDyN5NVSSvmz4SBGFX38srjxCy10Y1f6LUyd58liPbvC/iBmaECaRLQTVAjIzt4oLTXfY9Eqh6D9bScGlv2HwrX1j/8OOmcpCt7zp8bBqWRAIth8gswq0R5HC8qyiXa8fY5V1wG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e829xi7zXSXC6+lziItPzgd3I2nLjYUcDCjcci0rWUk=;
 b=V1SlQoNzWyNZkPw2U8w/AohWZ52380t5f1DP5jFrShk2BQiiK9CcjsrVTxRFpY0jLFvDJvTPnZOs1bYJZlHGFPNtvM1jdij4DvnCykhf6qMQyxvc64V/jbuLW1+lq+UCmZiX+9NNBPBpsAPQg3mYw/Sv46aaoJXFWFdec66C85w=
Received: from BL0PR0102CA0014.prod.exchangelabs.com (2603:10b6:207:18::27) by
 SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Thu, 7 Mar 2024 05:46:48 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::53) by BL0PR0102CA0014.outlook.office365.com
 (2603:10b6:207:18::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 05:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 05:46:47 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 23:46:46 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<bp@alien8.de>, <manali.shukla@amd.com>
Subject: [PATCH v1 3/5] tools: Add KVM exit reason for the Idle HLT
Date: Thu, 7 Mar 2024 05:46:21 +0000
Message-ID: <20240307054623.13632-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307054623.13632-1-manali.shukla@amd.com>
References: <20240307054623.13632-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a88b56-519e-4444-ddf5-08dc3e69faad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OtwQkyhIQXfPMIpcqO/r+A3O4ti62t2XpgOtmfR5mvUZ/DZuUeRuxU8bfJac72UoCC9XqUe+jl44CbRXXZ6DK9rlGCxJierDUL58rOB7b45nUAd8xvQugQlcDEcy7T7LWcZqJSLzQsl47GPt4/iTafpZFtI7iYW2+K6N4maYC97rxjGEXiG+mKb3UawvMvLWUIHyC+yEcj+2k4+NeV+9sM3AebD+ER7MuGhwK8MgKxNw05mH680wIOxx62o1zZD2BVi43WDy9GqoQ+Zk9QJS/P9iNBBcKqvvHU0LDqJK34cCTGds4GuGJVLBvM90hluiWFUnGacZMDuZq1pbG2dYra/gf/6ymCfxqxH5jhq80+RJVjYWSO9r+yvzn2pOd63HkBbnSbrROnzt65i4CMlrbghtoYBhlpnNW4Lt+K4N1qGPbXhga0XWyElHlpswuMrEgfGPNTquYkQnDE6MwB37DmS7RanQctzLBFDqXmrzkhBFi82dQDolF5Jd7ruoWyjJsP/JNZyIqQuYQx6YUmDJNShFMapsYs9eeDQfA8BdZYAY38Yal7EvMy8ddmxUixDkoEtdB1WBlwGWBF97QXz9QiOsnAM7SMdxQL3H2aK33kBAVSySiKye03GaKdSdltfROnmMn+RE/QIipbKmD+w5fTujDdt1R+ePAYoABCOOaiSpznP39jvEluc4bhq6ZOlBSlTU32ki7U/CH+uNLcOjze102yxrGTLxXmkratVbG12cd7LfsSBWE6eIMzdk4BXI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 05:46:47.7485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a88b56-519e-4444-ddf5-08dc3e69faad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139

From: Manali Shukla <Manali.Shukla@amd.com>

The Idle HLT intercept feature allows for the HLT instruction execution
by a vCPU to be intercepted by hypervisor only if there are no pending
V_INR and V_NMI events for the vCPU. The Idle HLT intercept will not be
triggerred when vCPU is expected to service pending events (V_INTR and
V_NMI).

The new SVM_EXIT_IDLE_HLT is introduced as part of the Idle HLT
intercept feature. Add it to SVM_EXIT_REASONS, so that the
SVM_EXIT_IDLE_HLT type of VMEXIT is recognized by tools like perf etc.

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 tools/arch/x86/include/uapi/asm/svm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/svm.h b/tools/arch/x86/include/uapi/asm/svm.h
index 80e1df482337..5bf1ad15e1ee 100644
--- a/tools/arch/x86/include/uapi/asm/svm.h
+++ b/tools/arch/x86/include/uapi/asm/svm.h
@@ -95,6 +95,7 @@
 #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
 #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
 #define SVM_EXIT_INVPCID       0x0a2
+#define SVM_EXIT_IDLE_HLT      0x0a6
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
@@ -224,6 +225,7 @@
 	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
 	{ SVM_EXIT_INVPCID,     "invpcid" }, \
 	{ SVM_EXIT_NPF,         "npf" }, \
+	{ SVM_EXIT_IDLE_HLT,         "idle-halt" }, \
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
 	{ SVM_EXIT_VMGEXIT,		"vmgexit" }, \
-- 
2.34.1


