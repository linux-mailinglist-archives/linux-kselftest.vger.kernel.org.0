Return-Path: <linux-kselftest+bounces-17230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC096D920
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A88B21A3E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8983719D064;
	Thu,  5 Sep 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u1PBGZV0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81A19D067;
	Thu,  5 Sep 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540156; cv=fail; b=SoqxvggWNACgOWimO4IbNrXskt12InHewY0CxT8GOrmYuv9+NNLCghyM7NUbzzAnSsVCqEnDUI3q5Q0AGIykgU/7CwitWHPmj2snLNJ6OWz3BBIOJvwYpAhH+fsfiuom+1S7AGzxVefcX7kXiER26V05lKAMhUuBggWEXEG04bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540156; c=relaxed/simple;
	bh=SsmhtrOFjcfRHu5vjZUqOMBnu6HhoSCRy3KffPR9dHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6cHmIHD9b80nE2UdEuZY9kO3fx6ZBajzKtP8ezAWGXmDpSzkbbyojgFNwDBzX7i5UTBzGMT/bfWcKnfn4lGNFoyvdSEynsRrskdt0yuq91xVbv6JMBdYZkZnMgX4O6+XS3IGt5CCiEY941KJxz9OqZpwZABz1eyBdJ7Hd3MAt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u1PBGZV0; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmzqmSW22xG2RozI75RPe8lmHym2YQxerSH0792coJrbq6uwK7R32MFt4kYd1WvHLZ1b2XkV4LbXlC/zV0/8dEoDyHc3mx/Hp2x3HqrHpkIF0R8HZgyMPTUPE9q7awAVdQ/agsuJ+T2fa5P5sO9OtBgEJ9gI/MND0GWu1SnlTTLm2w58doOVh36Lkeudm81OYN1XFS63sdhYxh0zRQ5MG2TjC99RypW28gg3qebFkkFr3xz2sORXerJCiE6/iRGo6J/jXubvKjAUPLGUoX9XBEeakfJaKKiHUKi6oZbsJrq1JJifFQdF2aC8z9RtBhC4Z4yD3S0dlUmdC+zwWpV5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KN0Tg9GmVh0C1FLK27wr+GLwqAvReHFx4uSQtoZgK4=;
 b=l3mImXChSdEgq7vs32gtINtQWMME7qteRrWw65orUwuWj2CcFhRUWEyyiy0HUW1H3HubH3dkKlrcHmKP5gKKPMXYsLRn5p0yHvKi5vcmsR2B2AUuyhEB45sV9ZlmHWi1zjepVzgfpgLrrTMFvP6Bb6OgsAvQrhYK/EVZlK1AY6tJJTKp7LoK4kBx8XwmYt7CCN3CMw3q+DAth0dY5Y9EZmy5j9rDc8Y0pAxjv8IdSV0ai0z37DMyLLI+THjp1B1dT8d9yUmFKXC+Goj2YDhr+QZatTTanFO2bWTNcmemUuWgHmfqBl54y9kug/SBq3BMPYITnUcSIK9bLz6wVNr80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KN0Tg9GmVh0C1FLK27wr+GLwqAvReHFx4uSQtoZgK4=;
 b=u1PBGZV0iFxYl/62VFe1RaWCIgBd+Smldv2UFhKUuKbCKaK26T1kZqLZRllTh98fExTcSHCtIfxb24qmYwV9e/QWmot+zPbNN3qA2FvBAcjk5R1A9hYU5IKI0ConkE8Wpwvj8u0O8f3J8KjiWmeDDaXhoRWU5JqBVZ+mBE4WHYQ=
Received: from SJ0PR13CA0190.namprd13.prod.outlook.com (2603:10b6:a03:2c3::15)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 12:42:31 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::8e) by SJ0PR13CA0190.outlook.office365.com
 (2603:10b6:a03:2c3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Thu, 5 Sep 2024 12:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:42:30 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:42:28 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/9] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
Date: Thu, 5 Sep 2024 07:41:04 -0500
Message-ID: <20240905124107.6954-7-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9e5107-053a-42d2-7380-08dccda834e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hq1Ak/1KHVBHKrCE4aBHowFkdM58EXxBsojWWPfzqvL09ZuL6Ek/01xIWR3I?=
 =?us-ascii?Q?jrktEN/EXQx0WLdCA6ncZ43Pqxr1Ts6sYA+V6UO6u4NLxkqXu7y5+ZZjUBFw?=
 =?us-ascii?Q?8fmik6aPfStwQddgqcxoeOicmg1l6Q7/pOJiqb/AkQRfy32661Qd672rlHm7?=
 =?us-ascii?Q?+/nzdbgYADQ/23SO2wYQFO2eUYKWZWG7vzB699ztmpLrArP0eaKHbNmapV/V?=
 =?us-ascii?Q?pSRRtfw4C30z6/Xoq0g80z94x4KgQ6iO9IAZ64UxfJhocvSF6iE7EA+OdGop?=
 =?us-ascii?Q?yUP0IoKUo/bQxNxsZagp69MogN9ZNgL5TrXD6ZVfhECeTlPDhfsS9foJx5yF?=
 =?us-ascii?Q?c9euMUXGBVhgVm8YVYbn5IrlEsR/3xzy3F0O0+5258uPsf0i17b6mi/jvkEO?=
 =?us-ascii?Q?dSNJodN/JmNFZQA54u6RO/VsypB1l+yRgtH9wklNuzjx5/BnRXDdMUMYA872?=
 =?us-ascii?Q?UaDk3NnXytvijBX8AZ4/Ofma9ppsj+gRWjRM09dz2WCpFzSwzssoNRN8fuut?=
 =?us-ascii?Q?OR8W6xzHwyZ45EBJDiFGPLvfEbkYUSBwrHg7sUPOI14zabHsWfRA0WzXwpEl?=
 =?us-ascii?Q?euyphauXOxwcaeNVgEfvQq8SXt1M8/VrGIpzx3kbE2jUxroUOz96hxdOVbbJ?=
 =?us-ascii?Q?p38UYQnjiHafy4aGeRBfet4mBgKlOABARP9cylrURXgVP+C01q2+o9x+yGzL?=
 =?us-ascii?Q?ASgExNniUbnv6UH721ZwpEE5NezI9vTRrOjTJAH6PDnOULl2OqfJv3YQrrFS?=
 =?us-ascii?Q?Y6OMZ48UnuRBUocnLB/bCqFHilMFU4KVR9xtMGsdM+n5DBKP/XOTAKQx03zE?=
 =?us-ascii?Q?mwWyBniOYNwl9bIYXXNmjnvQZ5eY37GH+Kig0BLIhIyVnohNi3TFgo/K0HCS?=
 =?us-ascii?Q?aO/B6bTGsAH8JbQa5x15/pc9b+LHxgJKmBJ8CFKOJloVHuAl3gbo5zh5v6yy?=
 =?us-ascii?Q?2izhgLEsimBhCq0CakdZPcrG3nhkcOL6ZePUy8vOX49iGYLsdd5a2thSiqUf?=
 =?us-ascii?Q?Rn+LcpRe1NM3QyZH03RSGP1F5DL4Dq5sjT2XpkKuJSdTXqc3L8dcXS1BsOxi?=
 =?us-ascii?Q?QCEi4J0DIin9HZK1VUMf/iL2LgH1r/z52rP228Ls9jIUMfsmXaKPL/6bqLHM?=
 =?us-ascii?Q?yo95S/fdgJ/U+Sy3acC60OwE5K1wFUjNajiPuYmEdi05KMhCnuYI7xoBafIN?=
 =?us-ascii?Q?S94S/NVUnY3qiyk4uNAjIzuwQZBOxo8AwUPdgr1TB5jkOe3i9FijIM/80ytl?=
 =?us-ascii?Q?3tUxTyLjRWWSbXQnuLOp+fjHr1HZY1iJQ71n//j5NUrAxlOh6BoyU83PClC4?=
 =?us-ascii?Q?opWU6KuCkmIov68iCLveYoOk61eqj5s+f/egdJuxka+Q357gKHwRC+8dKGjC?=
 =?us-ascii?Q?pf/MenQ0G6XnotvAsAMAffMiV2fbty5cH7e0NlQk2+cYqFGOBKqYI95/pcx1?=
 =?us-ascii?Q?I5Ll+TeZV1JwXMoUj3nYrsWtQycUuw9Z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:42:30.3792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9e5107-053a-42d2-7380-08dccda834e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944

Add SEV-SNP VM type to exercise the KVM_SEV_INIT2 call.

Also ensure that SNP case is skipped for scenarios where CPUID supports
it but KVM does not so that a failure is not reported for such cases.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 .../testing/selftests/kvm/x86_64/sev_init2_tests.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
index 3fb967f40c6a..3f8fb2cc3431 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
@@ -28,6 +28,7 @@
 int kvm_fd;
 u64 supported_vmsa_features;
 bool have_sev_es;
+bool have_snp;
 
 static int __sev_ioctl(int vm_fd, int cmd_id, void *data)
 {
@@ -83,6 +84,9 @@ void test_vm_types(void)
 	if (have_sev_es)
 		test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
 
+	if (have_snp)
+		test_init2(KVM_X86_SNP_VM, &(struct kvm_sev_init){});
+
 	test_init2_invalid(0, &(struct kvm_sev_init){},
 			   "VM type is KVM_X86_DEFAULT_VM");
 	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
@@ -138,15 +142,24 @@ int main(int argc, char *argv[])
 		    "sev-es: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
 		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_ES_VM);
 
+	have_snp = kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SNP_VM);
+	TEST_ASSERT(!have_snp || kvm_cpu_has(X86_FEATURE_SNP),
+		    "sev-snp: KVM_CAP_VM_TYPES (%x) indicates SNP support (bit %d), but CPUID does not",
+		    kvm_check_cap(KVM_CAP_VM_TYPES), KVM_X86_SNP_VM);
+
 	test_vm_types();
 
 	test_flags(KVM_X86_SEV_VM);
 	if (have_sev_es)
 		test_flags(KVM_X86_SEV_ES_VM);
+	if (have_snp)
+		test_flags(KVM_X86_SNP_VM);
 
 	test_features(KVM_X86_SEV_VM, 0);
 	if (have_sev_es)
 		test_features(KVM_X86_SEV_ES_VM, supported_vmsa_features);
+	if (have_snp)
+		test_features(KVM_X86_SNP_VM, supported_vmsa_features);
 
 	return 0;
 }
-- 
2.34.1


