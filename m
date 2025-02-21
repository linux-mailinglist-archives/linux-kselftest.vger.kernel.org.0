Return-Path: <linux-kselftest+bounces-27227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62544A401A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226903BFA68
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A7A253B73;
	Fri, 21 Feb 2025 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GOyS1UUY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F29A2528EB;
	Fri, 21 Feb 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171779; cv=fail; b=VLF7wrzUtYCBx4IP+NINEHdBnwa4iHiTrLZB3VvCoCJr6tSSxQEzy3i/phwrO5XyxcnbR8elbY/kU388+o55gSvsvfrn5J9PFDZ+0ykBuxA76uTRVLj0ydZ3/+ujJGNqw1mm5deekLY5VFwynrH4ZfbzrChpnL64yphgVZLvvgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171779; c=relaxed/simple;
	bh=pRP3F3YeFCpn3qqIbKS+hQMhC7fJO6anzPahcl1cn7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aURpZKD6yvF86U5WBTHp4+QKGOiJlfphL4SDKx7qufaPq6R7eGCfieo10RJHAMtuTY9GOous3VUS2Mjdb6MFiq5RzyEqnPZXZ5DCST3qPkSK32AzZ9hMMWJKUt5KcpPlR0KUbm0TC+4/pX5h03lTj9bBmZb/f6a9DX3qlUDSZ5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GOyS1UUY; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSpvgMU+/avS9u61zA+RmcXmrb6qwVy5BstHvGfNAPAa5TelI0XMS/7C3rIKE6xgxJSxpIZWW2p3kElGkm5qG0Pjwf0aFFfW4CQgkzcQK09q5NOB5du2rjKBh8nldWl5hWV0KNPGnNrJjATdzvLaUcTXLN/qoOPv9FGQwa5Wu8xbI4L90hIzjXp0cX7vbpCIB/0+kHvLF/Sq/PYJJIqRbH76t60Wpy1ypLr0xVETFGGNDTrKbrS12rRh2FxSK/OXfPk999a/7vFzqGwaaurHy3Q+LxtmLJgFjuGPw+Iog7uAK6hERGoDOYAFRI7H99iXqWt6znAuDsQN6VgZCPLMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pYZD+3R5NjnhheMHS0S0uLU2q7EAY1JOU3YB1yjzPs=;
 b=oF+ZZ+jWp/ex2fd+bxIRXNFw+L3umAXE/GFkyVlSPjYC9ckW8se8UgmuAWBhthqKXE/VBgYoWIR4ZC3wOWa/qSn20R+c1Ak4tS5YddbXegSmYs99GyX5q6uF5FGMK/y+kawBBJhMCvfcM+dEIyUy1Wg7Y/doEY/wMLv8aj9cXYtR3C/YkJf4M+wYsnWjvsp4o+wWP3G1Nu3j4a+jUPNa2Prqtc1lzSTqTHs8OU9Hjh9hQUJ8uiPVrIb/XZ+kf1onm0Muvkv6qz7oDgbil0/8MaqWmjDsK6APeq2FW2ikriffLOOt5thvv/lBGSK6DU1A73cchdOHUe17LnOuP+/aVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pYZD+3R5NjnhheMHS0S0uLU2q7EAY1JOU3YB1yjzPs=;
 b=GOyS1UUYWkYV5MRLXLJKRMg0kX3s8/BzEHfbyF0BVln1ZsQ33LfU0OHgcO+qEUR60R8PmzaZI04ttyfzvH0vo6GL07sN1MsOiNTT5XTVCmTO5Va/UL9RnRKZwX+XRgNRS3+FPACxOiGwLQGMn66OuRKbJTuf4g1szb/hHUKxMnY=
Received: from MN2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:208:fc::19)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 21:02:53 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::9f) by MN2PR02CA0006.outlook.office365.com
 (2603:10b6:208:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 21:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:02:52 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:02:48 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 03/10] KVM: selftests: Add vmgexit helper
Date: Fri, 21 Feb 2025 15:01:53 -0600
Message-ID: <20250221210200.244405-4-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221210200.244405-1-prsampat@amd.com>
References: <20250221210200.244405-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: d974136e-432e-45e7-0d23-08dd52bb1b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L7/ygGRdeBkbB0MyqlyqHmz9DXBuJVOgmPO0KpP1QVjWHs/kn3cFXqE3z0G1?=
 =?us-ascii?Q?fI7DX5BZ5DT3XuMnB5OTwwDZSRjtDj7cqnN6M2RksehzsIhpc2YY+R0WmfRj?=
 =?us-ascii?Q?Bp1NTQscIa3WbpJyC3TlEYoI+7RkTxtLNRXDq6bpzysLIx9ZwXq5dYj+7X1O?=
 =?us-ascii?Q?DEdB/vvzZsHRW2Q0NqAcgOo+FWZFvRLu5td2SaX188e8I3GbnwyXehyQ4Z/E?=
 =?us-ascii?Q?lde6y2z9BZ2bBFxmEqYm8E3gZ5FQ05Gl0TIjcPHz7uhobjYgsTvz0XHVzFsm?=
 =?us-ascii?Q?3vRnF1jgFfJvy9QFTlXnSUeO33JthJa8/Ue7Wgqc3FLDck6q2iLfRlG3zZXd?=
 =?us-ascii?Q?7gZd5nq3ZnOLOef1ZFnH2L3Ay1qE95x9dFkc/ycojudVKCK6QrNNgZsORQPx?=
 =?us-ascii?Q?nzHbTfTwCmfUbq5NqQ3pxla/Xv68pEYXfmSBjN0DPaSueOunIQFCXbc9hx1G?=
 =?us-ascii?Q?OCdz4xyvdik1rStEoopikLEcjb7kKiHxYmYEfQI0J2Wa88v9dJHB2R5entZb?=
 =?us-ascii?Q?l2a6+f0Jy4NPM1PYgSnncJniPm1Y+qovZM5CR68gl7DggxziPEyCRqwjcoaz?=
 =?us-ascii?Q?EU0NulfcTwRLp18vJnlYF4YuzsJrkh0E+/YuzrrAMIsqQOi5ZcAuB4hByfKA?=
 =?us-ascii?Q?GADJvVVHcSLpkArb8a7sG6OFnv6q+oJL1IADn/JWsreA52ZEcza95Go+QzOq?=
 =?us-ascii?Q?YxR2N9c8L2v3K9YUZdTIRD4QQZo5E483OMwKKqyZbTg//rZQLNV3nnV/UAye?=
 =?us-ascii?Q?TaRygVtofl2odrbIOIhsNdVYipGcdLiIo71tE4QEiTzLLX2C7Uxhl4+/kXYO?=
 =?us-ascii?Q?cPfv/EqpOzniqfjPOLcP0xu5LZCzC6o9a5HMWi3vcZxl1e8AF94MkCNEPONX?=
 =?us-ascii?Q?e6nNFCE6tPEivuUzONTTRT0amC/t52evvN3m8pVCPd9U16n0MLn1ZYYgE+H8?=
 =?us-ascii?Q?mR2KRdKOR5J4JhY2qhTYdtCdyTshY5uN6jfvr4dwxbD1qf9aOQuTGCU7aehO?=
 =?us-ascii?Q?fhAmtNDL6dRpc0KD9ikqJVqPIBNrnbp6ZEhXrUt3WqYFd4jF7vrNy9QbPG4C?=
 =?us-ascii?Q?oT8i8+jVBR4f6JYxGXvHhf+VPCqVfKjycUCv51tRQf8mMkftjCxS0M3SEhzR?=
 =?us-ascii?Q?DNWgHuc+0ZvGHajxQRsaTT4VaMqCj00RvrZv6R4a7BXU/YK5QQeVh+nU12Ro?=
 =?us-ascii?Q?2yJA+1kpnGb4hQw912SweotQM/eRzmNC1BEYACwqiPnaRlPbwXSDVLsS4VbM?=
 =?us-ascii?Q?xwVsfKyHq7/yILIwPMFAMZky+FfrKzoWivowcusTUvHBcWP+hN5kmvhfBETd?=
 =?us-ascii?Q?832W35ycqVW0UP0QxxwDLRPBGQflWuxw54Aek+ryBKycfwLbF0AvRIgS6ob2?=
 =?us-ascii?Q?+0eFS7w9r8VIAhFKlIMMnaFvMS2saZee9jxK4a5vgCPIcDXMchSzOBgPOmC4?=
 =?us-ascii?Q?60NNgvkPkBphSXKPnS/NMohMV+JVhKUy3Rl2nSuylLbdwTYvkQtPnikJftFS?=
 =?us-ascii?Q?8u2lpm15VvuuQpc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:02:52.9607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d974136e-432e-45e7-0d23-08dd52bb1b85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

Abstract rep vmmcall coded into the vmgexit helper for the sev
library.

No functional change intended.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* Change vmgexit macro define to an inline function (Sean)
---
 tools/testing/selftests/kvm/include/x86/sev.h    | 5 +++++
 tools/testing/selftests/kvm/x86/sev_smoke_test.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 82c11c81a956..3003dc837fb7 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -71,6 +71,11 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
 void sev_vm_init(struct kvm_vm *vm);
 void sev_es_vm_init(struct kvm_vm *vm);
 
+static inline void vmgexit(void)
+{
+	__asm__ __volatile__("rep; vmmcall");
+}
+
 static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 						 struct userspace_mem_region *region)
 {
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index a1a688e75266..6812b94bf5b6 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -27,7 +27,7 @@ static void guest_sev_es_code(void)
 	 * force "termination" to signal "done" via the GHCB MSR protocol.
 	 */
 	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
-	__asm__ __volatile__("rep; vmmcall");
+	vmgexit();
 }
 
 static void guest_sev_code(void)
-- 
2.43.0


