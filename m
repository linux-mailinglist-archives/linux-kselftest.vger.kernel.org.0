Return-Path: <linux-kselftest+bounces-25609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C1A266B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87442161D62
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8C121128F;
	Mon,  3 Feb 2025 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tc1a6pNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD91FF5EF;
	Mon,  3 Feb 2025 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621999; cv=fail; b=nlI7kbLb44PBHkhFO+wrLHlsVyXL2vWYa60f2Ot/toCu1AvG0DRtgAVcMHJexXuen6NkL3HDoHwTmKk0B9wzoGgzArR62O1n2F8wdoQJ48763XH1DREtWE2Y4d4OERiu6dFFtP794C9TauOtAoBC7ECdLotE0nHZyWPBIRkw+/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621999; c=relaxed/simple;
	bh=A0BwxVGPZJVQNRvk+DEwAG6GriwqEHIVvaJRtAiHOdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OABOiFnU4d184oYCyEY2burVuHti6rFa/bMAtC6bocYMtI6DGe0c4MhZgAzM/ihRTwpWT3TDSBUaAB4UyPEnupQ9LPtvByUMcIS2ufV2ifFxYLDpKvEKc/wAEjMhm4LJsCVBUSJy49NZEPP+ryfkBiH/LvLcAyIX/mRWv4Z+i7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tc1a6pNq; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgUREeK5yc9yIe/6eFd4/HUTSZnvWefbQ0j0EXwlasMQp4+SdWwbCTG7cYPZOTqrjHfP+79y24iNwpb+TfMggyOJ/3diJc7M8o/sGCYm+KzSRWQsUr8/hqcG9GE0cfLes3LBGVo+FwzjRNoPvzwB15ZxvhG5M4BN4FaDTQUUiliil8i31lR73q+UnIn+aCn0acLkFfeDpevi8PAjrW4aCFpNtTNr1RR84E1I/js5vpGdc3Ph5cSrHdmQXsZqqMpna9Le3e0rBKnZ6ZEQYD21P56BKOYTJ7FwIqVM8owzhxMMvVPZpCqOoAfydiYFEwipssB5Dprc6XJKQdMgOZ2LhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbUS11oFN3vmEn/o7Bg/Dfl3ndwdJDqk8EGT/s2BjnE=;
 b=yxMJlVbIAHS9lBcRXmBEGGZ86Ylnj4dZuuIGeVWQ/ZrsPXBPW4lXNvtWWYDDQY8FyX80D15R3zwj3/3swCpvFmr8HGg8rlvqgpT8CVGIxH1LsKnxFzzQnByVM25Ol/gR2eIvrCgNfmyEx+aS7qQnuWbn91IqPALKgTukT3diGfekp0hjvhKK95afZLNdfnxZpMFOomHn206AAynkze0LjFzuNNgLRtBy6kzxlI3tWJmo7Chb73iMjoZm5vZL3M2oJeFF5LuzKMFE3e6e9KbB/JnY2D+cYIAiejpoG1Itx30qtKMym40tOshpKpQjhNs1B7nYvgsBJpY+8jP4BfaXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbUS11oFN3vmEn/o7Bg/Dfl3ndwdJDqk8EGT/s2BjnE=;
 b=Tc1a6pNqQGR94kClKxjbq3lhlhM/LpGBnB//GmIkz+troPHwkKAuBr9Z6rUfOfo4rbbzVJAphnhpK8YElnBV8CHxxtcpUXwGEeI3ZCDtAoohsSXFkanGrX+SXmyVVCNIlHPd3WEx6X4NewQxFkAU+QS8XhkPUMGz/eXIz71Yg0U=
Received: from SJ0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:a03:2ef::19)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Mon, 3 Feb
 2025 22:33:14 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::cf) by SJ0PR03CA0194.outlook.office365.com
 (2603:10b6:a03:2ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 22:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:33:14 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:33:12 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 4/9] KVM: selftests: Add VMGEXIT helper
Date: Mon, 3 Feb 2025 16:32:00 -0600
Message-ID: <20250203223205.36121-5-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203223205.36121-1-prsampat@amd.com>
References: <20250203223205.36121-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: de6441ca-37f5-4b6c-3a92-08dd44a2bf58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/JeP27+SKozfGe1xOvwUDBfXaofRRUHC2ujnZ6EngNdXsxkgdBFctJxfwa1E?=
 =?us-ascii?Q?gbNWF43LcxT/yw2Jtj9lNX5PmjvXOZNEgkvsBkFyYnChb1A93o3lJSQvmrq1?=
 =?us-ascii?Q?KUq1HUfh2KYLhtMvTuB+GTGk/Wg1uP9jPUAPtySafH7Cc6ud/NGIgj7nRwCn?=
 =?us-ascii?Q?5ixztgcbj9S5kGE9xovLibX2SkuJ094MZW5v9Gn1BQjLCuoQW/RcdYTRDG+S?=
 =?us-ascii?Q?1lsRrWdOFfJib6S4/6Y/IeNjvzW5XNflt6dqFiXB+VaQpbRY/2A3MYbVpsH9?=
 =?us-ascii?Q?G1eDzJVbQKyKJVCa/gqNiBzW+MQGac+1sxp5oXqGqrromVvOxBhg9DZIlT0L?=
 =?us-ascii?Q?bUChwSJtg3ZSffPoN2cUL83JqssFeQRJlASUzpMSUzrukMZjObSbV/FRoycJ?=
 =?us-ascii?Q?HGvA3j0f6Ttljt1eUSGt5jx5y+eJhcVOCrcmwehvL3nQhcvWRxl7pWoSAT63?=
 =?us-ascii?Q?2FRKuWIu865ge3DpzSeNQGEmWBdkblHiHm5U5g3NV5mhPW52d9A5bkWgeDj/?=
 =?us-ascii?Q?sFv1dmKdzkT4YFJNcBpa03Ys7KkmrJ5SDPHpd2sI6EHg13M+/B4k1UV4FMYg?=
 =?us-ascii?Q?8q2vcVPpBschnJMESR5LoIzvLNtdwRYbPKfk6SDLfsOMxk7UfRezqi3yA+q6?=
 =?us-ascii?Q?D1suwqWTcpGuREV85Ljr4TVHBJtEFK7CsVqEcUJJKCFB5ysg8kjnGHSHMS7Y?=
 =?us-ascii?Q?QHlLSoVfBV1VY8352jXbwzSSTbioMY9P/CM2OAtzC8RRIhEeU0XgiTtuQOYZ?=
 =?us-ascii?Q?H3xS9Flg75AIrEFX3oFhdYcWXJFBbA/NKRBhhSSueC+ccvTpjaflDP75GCAw?=
 =?us-ascii?Q?j+LjV1IBenBRwhhMugkBiTuRsp5jVuSM2d8GNz17rPIw9qsvKJAXA+9P8p7P?=
 =?us-ascii?Q?etGa9PSjA6uR1jeWQGpoJBmXIYLovhCE1ojuYECzX7TnCCHnQ1+Vv164QXzA?=
 =?us-ascii?Q?WVP1iTTQjjTPQpcOzhRqh78D0wvk2Fgh2sUNF6bDJtFV5KhbZLP5tloqG2Jz?=
 =?us-ascii?Q?/WGddy3UFbdyRYUGpV2OgdwbyYf6sA2EEIvlWWKBG6psZ9gnklu0GWvZ0HEl?=
 =?us-ascii?Q?bXdGzZDgaDWgHP83snYZKUOIrDl1+QTsMGYrm419MzNcqX2ehMvihgQIBUUD?=
 =?us-ascii?Q?9yuIe5oYrRh2/FOlIPiqsqK7kav8yOMeoo7swNhb0PoikxLZS9yLOFURaDcQ?=
 =?us-ascii?Q?UiXveKW2Xxg4hN04vYzBNIjDJaQv570mGJPzEso4SuWCFqDSZ5o6QEjNxORW?=
 =?us-ascii?Q?EOCrlu+I6Hbjwl0q+Los018viYQo5vVT4b/f7Jq9ADsGQzqdp1z4cz8bh5L2?=
 =?us-ascii?Q?xfsGh+lNQitGkHnahLcPi6/MixZSc2ibUHzvswMvdKtpeiwE+kjAtjSB/O8z?=
 =?us-ascii?Q?vKPAhptcwqoMbGn5pd3D7cXLhzzhWXmzpJpZTC+CxAhm7lVA0YJ0fPcqJxaH?=
 =?us-ascii?Q?iJnP8/oDGDNeVNtfeYqhPe26zLELgYB6BtakTI88YYRNDmx9gsFMIVAXP7qa?=
 =?us-ascii?Q?JhvAe0dKR/LFWRk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:33:14.1318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de6441ca-37f5-4b6c-3a92-08dd44a2bf58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190

Abstract rep vmmcall coded into the VMGEXIT helper for the sev
library.

No functional change intended.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Collected tags from Pankaj and Srikanth.
---
 tools/testing/selftests/kvm/include/x86/sev.h    | 2 ++
 tools/testing/selftests/kvm/x86/sev_smoke_test.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 82c11c81a956..e7df5d0987f6 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -27,6 +27,8 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+#define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index a1a688e75266..38f647fe55d2 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -27,7 +27,7 @@ static void guest_sev_es_code(void)
 	 * force "termination" to signal "done" via the GHCB MSR protocol.
 	 */
 	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
-	__asm__ __volatile__("rep; vmmcall");
+	VMGEXIT();
 }
 
 static void guest_sev_code(void)
-- 
2.43.0


