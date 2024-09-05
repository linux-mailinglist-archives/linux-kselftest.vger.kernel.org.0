Return-Path: <linux-kselftest+bounces-17227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6996E96D8F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF71C21A88
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CC19D08A;
	Thu,  5 Sep 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YUdVJu8q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104719B59C;
	Thu,  5 Sep 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540120; cv=fail; b=Qn5NAEK4otZNx4CgxXyXfIdEOD2zDlNStTyW5DXJeiiRXQJvUdLqi5EDoarsm8ycFVBtidZr0U8qof/ifN9b8J4W+fwusT1rVbpYWNtiuiCykjcIydKdy6HMaIqAxMiiJnpzRPK7HVowJ0HLdCdYjlO05F7NiXpyAajc63dh/DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540120; c=relaxed/simple;
	bh=yZKlmJaLI71CfqWBzsJmh6YxT5C23b9q6NrbHu3OCxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQtycPhGyt+JE18ST6CJ2qo2zxbeWGh3I+CR5/SA21uaDw9ymJ6OHemKld1VJqC9JY6lptAy6FjorE4fr5c3ATZrNcm3hH1ynxjaGBkLvk2alLzDz7PNDmCxEv4eN1o2pZJbQGR8eJA+mZCIlxYJU3TQZDwEvm30iK6MGzxMb5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YUdVJu8q; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7gFIJBELUiMnFRnuc0z4uYIQOVoLAMUj4nhngHVVRyLWvsVjDPiLHxz0Hr5jhF6LGV3i5Qr14UsA9Gm+CmG0s7iZuvCj6jbpjiT3o2id1crNeF5MidTC8gOpw22zatQUOAGpUOx/wbMoqHw3diamWOJRhEURveOhtx00I+bqNURgOGXl92K4jd2JoAhdrzCq8r+mR0Z1k3RGqsw4F010zrd2R0m/RSA/ex+eMBSfxjHQxU1CpUWMbheII2zOB7DsEqjsL2P+I54bTujbXcSF2X5AiOXb0NXR4ZIh0eyUALbkAWdu5eXV0KMSP2PkeoS/s6STIYZiut2ESuY6DNL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m07Gc3GLSrqef5vkXDOpGgEiMpBzWIWFDwl7MHw7kEs=;
 b=yerG0q5wMYfnbkONGlgCVhrLDY4oRO0DOUtHq8sUrSpwMSQHm2kh0scadqZfXB/gUCla3rZDxLIJtJJbpupa8Mh5oA5VV+8kRU4qGd84FeYbjtUtHd7APbMvuBYQCgi4QGBhua8ntrh2Vr0Hnp6YVcYtLH1YbhHTyaZINqFgEmMjX+ZShesx7k+XQo7UIH+3TmrWmEwtzsqNJw2r1Mv6CQlCqoBXKYi3RMa0fxE7i4tx4hU32ucSLINz/gZTrzmijKC3OtY2gHc3tU1K3YiHgcD3nHbkOM90TwJp49XaTvU2d8hm/nWcpMWZTtHN58Mw/p/VehHzH9Rm28yaDrTBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m07Gc3GLSrqef5vkXDOpGgEiMpBzWIWFDwl7MHw7kEs=;
 b=YUdVJu8qfA7+mL6Ajr/zJnen4QWrwBxi2IGqJzHb4AFBLThu88GShK6XS2p1mNxeunMZ9w9p3ABABae5HPbE9vIZedfjWbmpoJBjUdONNLigefmrxoCQjSf9vmHe39ojP3oszYQ9BbJ9RWQmZY/1kHjrAy5k6wh/hEavVU146f0=
Received: from CH0PR03CA0115.namprd03.prod.outlook.com (2603:10b6:610:cd::30)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 12:41:55 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::19) by CH0PR03CA0115.outlook.office365.com
 (2603:10b6:610:cd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 12:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:41:55 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:41:54 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/9] KVM: selftests: Add SNP to shutdown testing
Date: Thu, 5 Sep 2024 07:41:01 -0500
Message-ID: <20240905124107.6954-4-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e9f80d-de86-4567-cd86-08dccda82022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pnR4tadJdIN7DGM+NFe/OxgiGRfG51hSwqANZTyO6RtiYXGjZYqEMVlGLhAN?=
 =?us-ascii?Q?8LvNqgtxxdpYjamfCmQgtiH85Or8oPPVEG0G0Efc+it2U6Dc17ZnVdhMSKy+?=
 =?us-ascii?Q?WoceH6lMgNurbM5YY+b/aH0jsOkd+adATYI7yha4RgkxR6HySlpcbv4OUDXK?=
 =?us-ascii?Q?IQep6JqlIFP9wBU64SJ5yZuHtzUsizp5tEy4pQvLbVZdF0HQW9+QU6umlnOS?=
 =?us-ascii?Q?vmhbe/n3l08AvkggtGCiUDx9HWRYqxUGxxRqLB1lkf0OpaElpGAC30VktXJA?=
 =?us-ascii?Q?bHmnwFjbl0JRDjaeVhn9IAmN7+c6lE9CrIU9K2xhoJNRmnlWEc4V4EVqvHz6?=
 =?us-ascii?Q?TAgNsJlO1RdefGHRMvM03qZgwOfuJq6lzKfHQWRkQHtpIBoIUxwa4sqYm0HH?=
 =?us-ascii?Q?hp1OtEaEr7UbiDdHbW8cGp6FMmlt66YPZrntyd4wbk4DSYEGUDz0QOSCxANW?=
 =?us-ascii?Q?QNYRqReBsZ/2toT+Gv08TFyc/4kdj60RCzLZu6k+lrjYBeEmITPGnkj8Rpp8?=
 =?us-ascii?Q?PQv/Jbdpy+ugXQMf6Lt5DxwKldfSq9Idhe2inwYwQ0BWuULzIRBj/eaUxS+O?=
 =?us-ascii?Q?dTYuCeOLEGKvoUS/TdNuNaCohqDSLMi1bMvz3EsFEygdoAD+r6SODLUL8x+k?=
 =?us-ascii?Q?OSNZeMM4j+qbpl05VmZc/ohWmKkNURerEZKkW/en5RQvCsEd/L0QX6Dls/IQ?=
 =?us-ascii?Q?v2l4XRjP+ZR+JNDWjUv1nLZ7hnzfwIFT8W2dPiOK7g9a3Y/0EoTtUwmRUsFO?=
 =?us-ascii?Q?iBA1IKsLYExGpgobiAg3Vrlwe18qGhcf7d5Z/I7Qq2Tax1TVHUR32ghPo2Ni?=
 =?us-ascii?Q?E4xybbZvqwk7cb/nXSY05bvFebir7g6wErxFYtVQok2CMml2ReIfDVv4HJnA?=
 =?us-ascii?Q?Tzd0J2X5UwtWY7KDtFOHen7hWWSPcTAHd5VMtk3ZyWj4xkGBMrECH/QXHQa6?=
 =?us-ascii?Q?4jZQr3hwJ1fT0qIETlY2l9ynWAU5J0dmJxINR2FW//fmXSjwIekkI9LZweec?=
 =?us-ascii?Q?xnMEmZ+jFHvEyZHAHGL/8N8Xv5YhH8XvRqdQqemmnMCysmymovxHGqFg/vnH?=
 =?us-ascii?Q?lITdORdeoS8Nq9eQ8xM7fsrorB+kMvEgYXP/21h+ABixJQ4KY1XHPdfwIaH8?=
 =?us-ascii?Q?/ga1IFjNwFlX1yCYgPVq5/k2rhuHZ1asI6KB6YzGnFqpOpcsgGIqcdfh+bV4?=
 =?us-ascii?Q?2zO51Y8OIxvb0uJCXr0RcNN6wl+05Uo2W5ylXjWH3uG5IvDlUrCLb5G2ecer?=
 =?us-ascii?Q?Ej9t4kQQLQLNJyhR7CqfOUs+B3kXuElRcDXkAXRQ/yyBXBOvlEzsdWp+ZIva?=
 =?us-ascii?Q?QgxbqmdnWhpQ7JdrpV5pqexcipaN53gPdDJh3sAQimzhvFvr7bqN8/kKwFXb?=
 =?us-ascii?Q?r+055BqvBAjmolVgr4ggtwcGGzVGCyyZ6Uslw30H3uZ+vA+/pmdW8CvJh9ZO?=
 =?us-ascii?Q?3x2uiBCdocdlV3PLPkJlVFMJgxHFKWQb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:41:55.6025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e9f80d-de86-4567-cd86-08dccda82022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

Parameterize the shutdown test to include the SEV-SNP VM type

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 tools/testing/selftests/kvm/x86_64/sev_smoke_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 12d466915074..8e798f5a2a53 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -193,16 +193,14 @@ static void guest_shutdown_code(void)
 	__asm__ __volatile__("ud2");
 }
 
-static void test_sev_es_shutdown(void)
+static void test_sev_shutdown(uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	uint32_t type = KVM_X86_SEV_ES_VM;
-
 	vm = vm_sev_create_with_one_vcpu(type, guest_shutdown_code, &vcpu);
 
-	vm_sev_launch(vm, SEV_POLICY_ES, NULL);
+	vm_sev_launch(vm, policy, NULL);
 
 	vcpu_run(vcpu);
 	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN,
@@ -223,7 +221,7 @@ int main(int argc, char *argv[])
 		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
 		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
-		test_sev_es_shutdown();
+		test_sev_shutdown(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
 		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
@@ -245,6 +243,8 @@ int main(int argc, char *argv[])
 			 SNP_FW_VER_MAJOR(SNP_FW_REQ_VER_MAJOR) |
 			 SNP_FW_VER_MINOR(SNP_FW_REQ_VER_MINOR));
 
+		test_sev_shutdown(KVM_X86_SNP_VM, snp_policy);
+
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
 		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
 			test_sync_vmsa(KVM_X86_SNP_VM, snp_policy);
-- 
2.34.1


