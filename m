Return-Path: <linux-kselftest+bounces-22068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE49C9647
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8501BB268D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDA1B4F3D;
	Thu, 14 Nov 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JEeNag17"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC3374CC;
	Thu, 14 Nov 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627715; cv=fail; b=dIO76GRqPsT/p4C/L2AlAWOTxZ/9gbIXaG5ei5yStKisEz4H7H5r5uSNFA8czBb0sSFaPFWXiGJAagNf/apCrTQ7dlGsgDueBcACtAWuOnqMwvvPgshWYtyME/vbBatGp1mE+Ij2MxLk58WIBJZiUBETxAH/cwYLN+58TEwSPBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627715; c=relaxed/simple;
	bh=zgY2rLcfQeFbqyLUA7CqmjFUE/VqiyQix4+kR/9YWB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d08S4JTc8R8dMPDRKZNDzF407YDxuTDyvHOtlEwH79mo4UUmX9q6eonlnyELzf7mQOWQlQ6fBUD8FdKF/m8zmYnwpYBeQP/yY6E7eCIRd7mqKJlkSA22Id+5wCWoyZoggX2VHbPU/Z84c2yrVKy3cPlOx9/8GVlGvPhsxH4oBkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JEeNag17; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmCAdJCOfuQtv6FUKLGR+lFKpWQLecwl085sc4pcWiyyhtXAD8Gpy/Hs6i81PG/S//INlnnuRitt5YjjuOJwJ1ASYdaeqZBLyOO/QdsVk9vqBpf+xXMqyp+45B6oJrIFIirrKcJ6Gy0cMOxXNk4Vbyz/JPpsio8PWVt0WLwP0+XY9DM0jKdWZ/8ng94uzADZX9xqtiLAExk8ZTr1ekC2Tl0/xjOWLy8dBVR1m/R4B2dctFaR/81PguKiLO/LVRJSKFldiawcvaPt31jywLhZUO2yq1bbuHQAL4xwQgFeCQuP7K5cByYwnDjH2hAwdh8WWHw3YDmwRi8k3JYogSuDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrRHrJ6nFFsjRo85R60cfEKQFmuYnHJ5oxdyVTRZzp4=;
 b=mOQxZnkycGkYLSCUC6PyGt3DnWIO/0x53E4j6y2zcQT0grsfDMBH0rR76SB6a1UW2gl2y/yHJNqOoZZ4RM5Gf3SNd93QEfnD+sf1Vw8MhAs85cXbhUT73M5gcxz51M/MuKOmv3RedEY4Uh03vJUosgKJAVhO2/DnGa7FtZG0u0rhmcnV4R5WPmioXfshbCwsxyFwwDz82up4WzKzOgAhgcR7Ka0Nojuin1wl7REFWQdoSIS0HbloAVQk5xbXwGYqEIxmH2+0dWwV2rQX1SipAECmOE4DXIS2qI5lCcL1nJR8U4xPprlxyZiyicOptcKHJv0qqQH0OEc58owUYLDtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrRHrJ6nFFsjRo85R60cfEKQFmuYnHJ5oxdyVTRZzp4=;
 b=JEeNag17ONj7AMFzR77ITKueZKH4ouUHsHfYSMT4hqvKX9UvwL0s9r4nbXd6vGXVT2CCgVlOtykmDNVH2w9z8lYq0CQhCC1E3Xmki/qPTHgteR2OoU8uJJITxmit5zD24oOMBgysZSuT3qaiWYhE9X/LdAnnAIP5UCS4auUS2sc=
Received: from BY3PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:217::16)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 23:41:50 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::aa) by BY3PR04CA0011.outlook.office365.com
 (2603:10b6:a03:217::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 23:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:41:49 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:41:48 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 3/8] KVM: selftests: Add VMGEXIT helper
Date: Thu, 14 Nov 2024 17:40:59 -0600
Message-ID: <20241114234104.128532-4-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: b38fcf4f-983d-4c50-d763-08dd0505e8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJl4owoDp2E4VwLiUjM411/LAw3qIlovZxZ5RnkNkFXgZTKIaIh6BwrZcr4A?=
 =?us-ascii?Q?bU1DKeZgC+4dn6RGq47vgdgqXHQUzD1fMWur+7XzEBvPeyUns807mNSxT81C?=
 =?us-ascii?Q?N0PSfMVVxxcEoccKt/ghAQRQnnuwsbf2ljMdqDHTU2NXch7RzcFB1MxnlN1J?=
 =?us-ascii?Q?H7ptfUDeRTTXvpLwMkE8mKMQo3UyY03fUgODRhj7GjPcub59RHThxH79BCYW?=
 =?us-ascii?Q?eFC7FEnXleTCfHPVelWRggAsR1qXAvLQCrGgNosSorlFAEc6mNmt+7aofrTf?=
 =?us-ascii?Q?Fs8/lduGPhr7hYkn3T5Rl/QusIjwk0ir88shWRxFAJ/Y3qWYthsU+R8kiAT8?=
 =?us-ascii?Q?IdEi/5L2tjuDwI2om+OOKmxMb1LsCByNO715cknrEG0pZPJcddQrOYT2WANv?=
 =?us-ascii?Q?PTJM/fchZaqXTTpeoXFc8l+BeeqNrmchDvhOHDxJpS8JlJZM1iScCvv+oxUy?=
 =?us-ascii?Q?8BWMA6qIq55nzLZCt6tN9lnM3byvuH/VomZCzUGf9LP8fFOaPFffFleNfcWo?=
 =?us-ascii?Q?CYs+t1Ss5/IMp4lzZh9e2Bw89392WkXjBNFUjKQc4hsjMmtNMGOeFWKQjWG9?=
 =?us-ascii?Q?uNq4k9tv10x4lX+j6gvhh1pYsDw0Mep1Eg1YZ2BmUsrhaks3vShbfb4EPmAZ?=
 =?us-ascii?Q?qsWXuRvFRM3qZvdupbK7q5tawJ0ICSfwo7XI1oNrJcNazWY3z4u4IOsGj5zu?=
 =?us-ascii?Q?Z43W7O+4Cd7guwpusM09WDkzRgQOT3GWILGjXw3a6lX1Vnw56xJgP9OljXbY?=
 =?us-ascii?Q?mcaLYtZxt2P5PnXNItqQHHOZ1pAbbR7YLBwn6SP7hNBHv9daK9gcnpxkr/Yu?=
 =?us-ascii?Q?BLqT+6vhZpUGHipNSPHjpJTLVGNopIREsoGFvOh861Fd3etnWXvJPO8GYuEI?=
 =?us-ascii?Q?WZSDX01HMJ8oTxnMWoVnl92pfnuEVdlPLNrX1jmCg/0q1RZF+blNtaix9Q1U?=
 =?us-ascii?Q?traqkjXjFZdTaF3dt9IczbSvZT6VNvLIouzRIFweKqMUYsAyFdK3fw5xIDuZ?=
 =?us-ascii?Q?wJhtEcPoaM5XJR3SVeKMXmndOqEVdYhWhgb23awpTIDoomVXWKGgSAEmzKHD?=
 =?us-ascii?Q?BRS4UXXIn0qr7tjBfJR4XZ57U2LNNUeBcYktF0sPtpRPimA+VS436c4/l+zQ?=
 =?us-ascii?Q?aPhF5yvZTyNleq1Tp2YjqLqZopSwJa+S/yo2EZAfXeJ0WFeuqYoGX3YkjLYY?=
 =?us-ascii?Q?cAOj7B9KVKqzKaIJvSu9sPTGUsh1Xz6X9YM9G9t5pAHwi/Ltw89IA9itiXAU?=
 =?us-ascii?Q?fSNTSf6EC3vpDt9415qNhdxx6desPCXaIzqwW4uBx+OTkKoJMdhlJEOQPLgb?=
 =?us-ascii?Q?urYouMfHV34y349GqIWrabR9GKLxp3trtrwx2k4MeMgkNPWUHXVCriehpS6n?=
 =?us-ascii?Q?0DfF3tWShPs08mPq4R3ZeB7vJV+WB4C1ye/6IV4PQHsI+Kbg5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:41:49.3473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38fcf4f-983d-4c50-d763-08dd0505e8cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214

Abstract rep vmmcall coded into the VMGEXIT helper for the sev
library.

No functional change intended.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 tools/testing/selftests/kvm/include/x86_64/sev.h    | 2 ++
 tools/testing/selftests/kvm/x86_64/sev_smoke_test.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 82c11c81a956..e7df5d0987f6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -27,6 +27,8 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+#define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index ae77698e6e97..97d9989c8011 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
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


