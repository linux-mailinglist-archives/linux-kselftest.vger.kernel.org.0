Return-Path: <linux-kselftest+bounces-28352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CDDA53D5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A624168397
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8841FFC56;
	Wed,  5 Mar 2025 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ocpoJFo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F8205E22;
	Wed,  5 Mar 2025 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215680; cv=fail; b=Lr5a1E97oo0IU+LeIfZJEsU3MgRzwMkEk0MYz7VFgUcRrSBu4zII5J7gngF5xFGuqOEnVEiqFhu/CWys7fpH/uKkS7bBrvtDYbJ3Q2N+Ghp/X1TFmBMc8smZP4nNKg9ghskQG9r2F4OpO/eUknldeoB4dU0aqe2YQ5FM5sMsFLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215680; c=relaxed/simple;
	bh=ZDmrcdsAlkFz5FjlETMqbuVEt4sdShCPnaXBqw2ejKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crlfDZ9HbNijcDyvopDC+9iuo0pVtRjUKsvWPfISwJtfwuXEoAGHqRPj8XLpDXhzGmy5JjECLOXEe/svdQU81VoUePu4NiOhZkvMz3xn8WbNyl2cdXDInKJBbV5z2Q6WLw1KufohXIJlZf2kU+v76xcHVNT+tnu8JUJ/sBGU4P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ocpoJFo; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMGDbnFn3ZfK4qCvR1kyg1Zj2Ns0bj2SgGT0QgiNWULaDyAUHYSRGOePtLFp/9kIUaTMozEpWVr/4VbksEI+FNsGDAB0ai7F1z/lFILhuVSXeMGtTGmIGYCrwD2k8EX5xlE1qFPnf/635FdYKp4QxMJRFNbBGAfGUaCJ1isSMgT87g0EVSvi3/lgrRwZhm4r4Twg2awbmAjKih9sc6bWU38zhigp833fnE/0DD22Mjna9tiAC3FtqyiKlnHD2Ngi6OLjDjdmajJexXRdDhQTx8pcuY5JiKKlibBaW4McGTaXwh2P8ASrrEMtYZVwkh5QGNppZ/Erc2lXiZYtNdAMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSLJ6UUOZ7n/LI5/3Ddu8SU4NNJReLU7zATinl/ARwk=;
 b=gVceQUB2eK/6JLJfPFrxjGn+TgV3Duv0qdMiJSgADpcRenPHj4CHlaTS/7oV0K39uBPSlRmqXBQto3eHcQS5JevYdm1aJo1xiohd4PtVuz8Rj5yEEaEdQNwxb/H9/DeIR3XbRtt6TxXtuXaNuAreBJ9WpW4yh3yfwhwT0CTh2vLNBnw8AsWCqgiiAg7wZo59Uikrelyl73NJRTYM65HQOvx+ZxC+O04bcE/oQx4jADM+7pOzcBVOAnL1xUmfi3An9yiPJLupz8Iuqv8OaSLGy+vxvwuBqS1UHrX46yDtYNJ5g4aMik/LM6eENdXEL5QrK4/m9e7jye1IULl3uWY1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSLJ6UUOZ7n/LI5/3Ddu8SU4NNJReLU7zATinl/ARwk=;
 b=2ocpoJFof01wcb8HRxMdtIpoJ+eoDRrqcmKRYa5NjyN0hJu4FlmW+cUG/bWzdDBJlbN2x1EVfr1eivtOnnKD+mKNEYMocYkn9S3JoV2H/7gfwKzcjwtteSBIItQVqsOd8l9VvKLEl1fL82pTgj7tXcfSuCHGCiAzDjxkn8Z0ODQ=
Received: from BN8PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:ac::37)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 23:01:11 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::4a) by BN8PR07CA0024.outlook.office365.com
 (2603:10b6:408:ac::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 23:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:01:11 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:01:08 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 03/10] KVM: selftests: Add vmgexit helper
Date: Wed, 5 Mar 2025 16:59:53 -0600
Message-ID: <20250305230000.231025-4-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305230000.231025-1-prsampat@amd.com>
References: <20250305230000.231025-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6d52c1-2bd1-40a9-0fdc-08dd5c399f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rM6zZXT+0RhNEaNwelGKWDTTXfZoFcg2l5B3UdTfJsB25pfvhfpL2pmXj35I?=
 =?us-ascii?Q?J5Nx+TRzZm9Jwc0G9waf46WNbHbR3TFlWtuDZby9fmyubvMYnEEGoKX8LUo2?=
 =?us-ascii?Q?XJp4vfdLcDw9Bqr6BybFadwd3Gd3hDBwmvuudVziFG72AH0hgyWqDyo66Pl8?=
 =?us-ascii?Q?11uP6zRfOwuQgBUlfkT23h7cBnpWJ+3MuKox4etMvyoj7uqjRTJXjEihvMNV?=
 =?us-ascii?Q?bQPnFnVUwb/Bgjlc3qNBzwILWVQiO097l4h2ne+npKCzVhCd2vAR4g1yND/1?=
 =?us-ascii?Q?7QiWx87nnbaAv9JwHvraa2Cqbq8q8rGJtCMXc+XpUxGNeGbtx+tLSC1qnr3C?=
 =?us-ascii?Q?Z8nKU9J67PINTX3rSncHVi5Er+19dDwzYhuUK1n8EwIoUqLdrVFn47Mpjxl6?=
 =?us-ascii?Q?p/8ym0ezFPws2mU0m7G5B3XacT0cb6mQZ2tvKqvw0yhwwV+xfFyuiKzK8iKX?=
 =?us-ascii?Q?tM6YSdKAl5xAioouHJsTSSKMraIDFifjDs0P55ezVsxbUOgbo224QJWGUZoF?=
 =?us-ascii?Q?8s47Vgp0G5tCPXks4crxK+DiCAcr151GHatWid60iyYxhJRd+7HJ6gg888tr?=
 =?us-ascii?Q?sK4rAM778TVQMwvTmVQpBpIe2tKF+w1CVAkSr1qzfT3K4iQLvn2h8Z1S2x90?=
 =?us-ascii?Q?vWBA8JC8DXmUtP7VD6hyfE+lelXNEsf4Lmbe2KQUL5CZnxM7n2CzstdwlqJu?=
 =?us-ascii?Q?XXU+QLHOLG6nLx8YEdPSEfxZpiTqXukBKYy6ygnkOJKI6tc5HR3bHGx/KQIt?=
 =?us-ascii?Q?4C3MxxqWBM1B2YWUPKLgQiejj2PvWE4kMaKv1uWw7AdCyf4Tj6Sa0/HVIqAC?=
 =?us-ascii?Q?7K8T0VdkmRCOp4v1VGK+KlkCiUHIR9oBHB0DkmByiJEkoPY/+51CsUzfJZAG?=
 =?us-ascii?Q?EzqXsEPrkaVpjk6LN5rmMylQthlml9R6Gx69apK84C0+yWOSENXhytFvOsU0?=
 =?us-ascii?Q?TMYKhe9gWIu4eZeU0d1QOyfVSqkizn9s6FOhOQr1TH8tDIUupeNcKuKJ5EQ7?=
 =?us-ascii?Q?FNpLzJ3iSM7CYO3tAwl7bgyFmV3phgWN3N9Akycaf96k7a2bPuE/WkBJFanu?=
 =?us-ascii?Q?uMO5zkuWGfGsUdz6RvFRT4jC/P2qlQ9d7ulynrFZzZAPEvv//jabvQORa7oN?=
 =?us-ascii?Q?uhLiCTHiNNxY42okX9cbNUyFWC3zyEhz/wUVRD2qHUOlopjZZ7ogPIGN+eGQ?=
 =?us-ascii?Q?sWzBT9WPYv+jFAYsSEKH7iETeErAePXKn59+aMRDHURKKLHNyn60TFEaNWEz?=
 =?us-ascii?Q?D1zKQmydOjb397BfLAhfb6GYYDE/jx56ES3K5wCjBev8bs7FrYu7714YNqvf?=
 =?us-ascii?Q?XHMxF5eqvkrIz5lVeusBs33foEfhwZblVveCDL+h7NSx84oQ/RO1UFlX2Ek5?=
 =?us-ascii?Q?ns5ILadb2hjIXRH/JLtXuMS5XklLLrpAL3N6UmenKIhtrT4FxZJHqLEKxzMA?=
 =?us-ascii?Q?FSVtoBTqs8DG3gA3cA+Kp8LHAQ74de4b8opBEGHW0YkMw8gx+5sl1+95gN3V?=
 =?us-ascii?Q?ixz+4D1Lz/geXgg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:01:11.2405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6d52c1-2bd1-40a9-0fdc-08dd5c399f58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

Abstract rep vmmcall coded into the vmgexit helper for the sev
library.

No functional change intended.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
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


