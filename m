Return-Path: <linux-kselftest+bounces-42096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D6FB944EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE05516B861
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1930DD0F;
	Tue, 23 Sep 2025 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="12VZXVGc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910830CDAF;
	Tue, 23 Sep 2025 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604288; cv=fail; b=Mk88PzoWISTJvNg95LHzSQO+22gatq3jK+aqdeUgErZrBApK8w666MWSwOGwqAinDOV61ED2/pQvtkL5ryHAexrU7s6IbGodF6iHYr/5ZP4rE4CUTi/SFPquBtCdrGWxZbpzP6iyDsdjNkseIe2VEc+DDsYZwPzqGzLDEkn0syw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604288; c=relaxed/simple;
	bh=dlcVOkG41p5tNaz/SsF6JKFUPVJRHmJWmcDex7yzU8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHPhmdtrQugZpbWSu0gbXTWdTyEEUphrDTmFOH+iTewOIrmBg8XDyJ1fx7JcWMgnzR5H4Y9rDOKVTiwaiO6xqWtQ+Dh/td4AJ8Pze71RYdOrqIc2xO/MAPGFIg34bfRVVENH1NfaqY03KEYQR7HB7eEE/eou3zasuj+a/kaX6qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=12VZXVGc; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIYHPlkAST1APGSsptWCeBEHtV2SvhOxKLQhu8zPmAvvtxsaEKjjSw9E9alvdGjRdh+c2qGDB1xjmlOtmVNfPGSm00RsQussDU6OPLpbVEvsinIwRW6bX9GIlGJZDYmGPwl2i82AJ7VexF46k6C6CYsHQp6ctR19+6y9kEEBvsNVHSnc6rqfLJfPeYRedYiyNPx3k8Z2sTzFDvy8MHjDyZqcc8zALHWmnxopMbWpY008K+HaF5BS8WJu2HfGgm3EwOhOaiKROTtDGQYQia9oE9BgLWmp5uDt5q0WgpjTg0ouDCPWAS2iFAcNPWfAWvZLB/XULDGag9GZw7vtCumECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUKpzU7azTdJ7Gdo3q6syH6q+G8cqFbTZDLbm2APJU0=;
 b=sZpTSt1NEz7GjybdFKOT8qKxThkXCkOveg02vzDd+IwGuRB0vRhJSG+dQlTk6LVf1RmQlAs1FmopdjTi3JjkDvPQWgtrhKzxgTaBukuw+VIx8cMdkcIMEm/8hsAA9vrlqCpAVXatH5x3LspDzb1EOAnglUtsYXu9JIkHCwnZ3rc1rouVO99QEa5OISA5rqqLGHohHqSr7cvM2MTUaD/W4cYR4fVU8QQvMqI8qYFni0iPoT3mL0N8WN/nTKEjQDdJR4qyU4+dilQ5z9BNaj6r0ygiaSnyImxFbsdIy+E2ODmQ9Xvmoti01DtQigMa2kvrRgbisSs81EQjh7EVDO9JEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUKpzU7azTdJ7Gdo3q6syH6q+G8cqFbTZDLbm2APJU0=;
 b=12VZXVGcmEZ4X02r1iaw/RFl2zsie5uYR0xI6TF9Gmh5ywHcC7z9cy1Qh98lBfjhegzllngIKHqJa1hBXlkyubyBh/thTwxYjftySYdr5EMZ266/63TTQkYpEbus/b6BftPtG3c7SOD+JNs64q1E2pkukccZO1YAn3eXxMNCrA4=
Received: from CH0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:610:74::34)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:11:23 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::5f) by CH0PR04CA0089.outlook.office365.com
 (2603:10b6:610:74::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:11:23 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:11:18 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 05/35] Add is_sev_enabled() helpers
Date: Tue, 23 Sep 2025 10:39:12 +0530
Message-ID: <20250923050942.206116-6-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: c9516d5a-be85-4e25-c5a2-08ddfa5fa407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VetIsudNtbiy7/B45umuUgyzRF4Z1j8kkFPwlgChC9tj0QLEc3qr1nx6e3i9?=
 =?us-ascii?Q?+TZipNuurhyRyLgRRlIUegBEIYCqJ4zzz+L1tIhZwSMYaM3ZGi1KpULLdk3p?=
 =?us-ascii?Q?VVMHeiS/OmwzXx1Y6akYRBAPF5sx9Vpz7Oww/o3h/XGX9MO2QMK0SkaVZaI5?=
 =?us-ascii?Q?L09ZpZtdjaphkVATvACmJF4gJ8xkdr0ikTWp4fTqjgOkrn6An7p7oXijO9i6?=
 =?us-ascii?Q?jhAVRNxJTME9LeikycTc7HvCUxYXOtglFHj/sHqjFwOqZXHMI6sSWbt7C6hI?=
 =?us-ascii?Q?4959E7eWw+gsXSgt3SE7948sZygxUap5/56jhNIuFmKI/xuzlyrPvY9UCtXc?=
 =?us-ascii?Q?PPrJZmrdn7HnjkOgLM9R+Au3N3HD5jnVIRSS1yg/Tlmpf6auiodnU7jxrpVY?=
 =?us-ascii?Q?6FSrw3zMIH1po3ezxogaNNLVdVaZkwn1dYNWQ1Fzq/VaPcNVrXPdK3KTH6+g?=
 =?us-ascii?Q?LzisS85Osi2l35ye7WWlFiRlchyErm01UGRIYJZFP6H9FpdywImbTNqXwbpE?=
 =?us-ascii?Q?oi4oGc4TctPpf/Mrok+xNXn9PK8VxUJyE+n49GpDS8FkIRGZaX4PpeT1vdGV?=
 =?us-ascii?Q?vOxIUgiVt/4//yjF4VrKvtoKNeVInxsrd2va4NuTw5Bc85M6hUq218TXM1gW?=
 =?us-ascii?Q?sUdNfw1vR5iVLCjqQQ1/KlApRN0Wb19ZUJr8/I2qgGdFarJcda6nQzNyIynP?=
 =?us-ascii?Q?3fFBt+7E0uOaEspk931o/mXMPeJd8jbTDj3XI2zbGg2jJOPb/vJWtBqx5M9C?=
 =?us-ascii?Q?s4DwrFozJC1Yl+FOwjDIVl17S/8Rsyg/v2BZPAi/VaYGxCgLTvQevlQhS1dQ?=
 =?us-ascii?Q?r5BCJglBxxg5XPLqzLQ2b8v2CV7nZzyoI9eF0bj9qrpvrxm8xtUSRkc6IHKf?=
 =?us-ascii?Q?OHtNG7rX4cuoT778IE7sz95V9FT5jFvpK83kSfYoLbPK61qLllDdQPHUGeDP?=
 =?us-ascii?Q?IxYSjlXv5p9wmnbFyjMYveGAdar6hRu0jMi1cr/D0QQFBo3YpQrbz5Eh4zbA?=
 =?us-ascii?Q?MnIQ5gMf0t8VjybFtCYwQATKcPgjfJvxfQ7/MZk4UM14LeCinP9M3Eb6hSuk?=
 =?us-ascii?Q?59SH8aCElBRYWleUhnhxSvNnzTIbVmoNsdMpkkZSbhKXVa9wYzlrMy6AqKSt?=
 =?us-ascii?Q?yZ+ehUQAcLiccg7UNvqHaobzNenujw8zMcsAEJqgl8g8kdxkHM3w2Ln2H25j?=
 =?us-ascii?Q?6mclKrgmgaDsgsWWzNveJbe8cJw2tg2XZnLpSJyUBSuJ6Pu46GHNqr2+iydU?=
 =?us-ascii?Q?0RqR3rK/hJDUIVo+d+bUJ6Yfg33qL3AzDb2RSMw3WXfznssn4/JeVQjSoCue?=
 =?us-ascii?Q?roArxvw6TRZgioXZeYfN1KlhbWNHDnf0utJk0RsTtzoE1CLk8Q3zaJ9MBUaQ?=
 =?us-ascii?Q?Uf1VHIkErrMiNieJD9sWqQ1VRmdoY0s/8HAe1RRTt/kUGZsKuJSinIRi6FLY?=
 =?us-ascii?Q?06RxMnYqTGhhKRfzyaZEVFi4XR0Qbh/OFvGMEAE0LWMXxpMu8phro7epL0cV?=
 =?us-ascii?Q?/JmjOlXOziqqbIPOhFvfM+jxo0X6gV1Hrh70?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:11:23.6744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9516d5a-be85-4e25-c5a2-08ddfa5fa407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976

From: Peter Gonda <pgonda@google.com>

Add helper functions for guest code to check the status of SEV and
SEV-ES.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h   | 17 +++++++++++++++++
 .../testing/selftests/kvm/x86/sev_smoke_test.c  | 11 +++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 6cda0acd22e4..2c1bd27345f4 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -46,6 +46,23 @@ static inline bool is_sev_vm(struct kvm_vm *vm)
 	return is_sev_es_vm(vm) || vm->type == KVM_X86_SEV_VM;
 }
 
+static inline bool is_sev_enabled(void)
+{
+	return rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED;
+}
+
+static inline bool is_sev_es_enabled(void)
+{
+	return is_sev_enabled() &&
+	       rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED;
+}
+
+static inline bool is_sev_snp_enabled(void)
+{
+	return is_sev_es_enabled() &&
+		rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_SNP_ENABLED;
+}
+
 int ghcb_nr_pages_required(uint64_t page_size);
 
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 77256c89bb8d..3316427eee46 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -18,11 +18,7 @@
 
 static void guest_snp_code(void)
 {
-	uint64_t sev_msr = rdmsr(MSR_AMD64_SEV);
-
-	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_ENABLED);
-	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_ES_ENABLED);
-	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_SNP_ENABLED);
+	GUEST_ASSERT(is_sev_snp_enabled());
 
 	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
 	vmgexit();
@@ -31,8 +27,7 @@ static void guest_snp_code(void)
 static void guest_sev_es_code(void)
 {
 	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
-	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
-	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED);
+	GUEST_ASSERT(is_sev_es_enabled());
 
 	/*
 	 * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
@@ -45,7 +40,7 @@ static void guest_sev_es_code(void)
 static void guest_sev_code(void)
 {
 	GUEST_ASSERT(this_cpu_has(X86_FEATURE_SEV));
-	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
+	GUEST_ASSERT(is_sev_enabled());
 
 	GUEST_DONE();
 }
-- 
2.34.1


