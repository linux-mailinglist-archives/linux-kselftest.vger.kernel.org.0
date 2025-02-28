Return-Path: <linux-kselftest+bounces-27847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74627A49572
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3636018860FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24544257430;
	Fri, 28 Feb 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jf1Sjp4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0F2566F4;
	Fri, 28 Feb 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735546; cv=fail; b=CouoZycNhv6aq3NmRpToKB6RJ4CvyVrEFJVYYLEyEpWV4NTIiolaXWTGBRe5NdcmoP3ngy6sN1IMKet1AVIhil4cRfbwj00J4bygzaTYhgf6lbhSw4LuT9tffdNRwxuSEqAk49Z/fQsxNW/Cq2rQbu7tbh6a7WWFt8ggNv9CJbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735546; c=relaxed/simple;
	bh=jpz7jnEhqJVgQi0b4+LeCxmRimP2f4Ybd5uGKDlld48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/P8dTDSOwTPGlKql1N+vc6IbOQhfU9G6kxSc/cyFM4dkxuVjPd9K/3waH195oyD+5Ql7L0rcyzla05xwi6XF1/hnMlWB4dhVE16cJqiNKnRYC8/ME4PuxuYT1gFfCbuIxUn+KJRsOg9WSw0AxYDOMk6v8RekVF0evWRmnwLf1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jf1Sjp4o; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP7K9o6drAS/g5piQmOcxvIRe8YqAWRSKROihwceBZpP2gNd0htl3GuE6Zc38Kjp5JYAaqfRcitZB5o5ASj5QOUzsukKHkuD57lMl48sV5/bJaJs79MTkakCVGTFbPiFogd5PKH3NCGeXhotYNn3u0aBubFSsBGc6Ypt69TlCEDZARf+Q7TDmrhNSli/0zGe4Zbniz3XaJD5qM3QN4MmrXA4U2Vre138Qzxx3BtOzOWd2b4sMuW5UBIyN6nHdF+zCLYoNUpTm9t0pUSw1PawvWm2I2NyBLTZgoZi4PFd7r6bBkxaSExmtyaNYLAbgEoYUfL7KubyIaYr7Eci7olG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5zicL4dowQw8aj39dkhp6d70D8vuOsuL+DBbtzNVrQ=;
 b=eyw5MEBXFTCszeECOOV/HmzV/wGXhbVed8iu0uKW3c3FZeHYP5h8qS+wsg4x2JrzjrjA7GvxAiqzGhPnglRTj5psd7LS76y5VcqpBMH2xPwuzEN6OJjONpe/ejrhOMxMzg/vhLLsqF3lqowa2kH0iUixbe2fP8EtDmc0cppdYhgkMklPvaSUnCPavKlaE+CE0L9kUALII1A3blIUtUj13FnZu/44wuxxCMcEtTT3vjGXkzSVvHFGTB0rXHyRYwHkhlFZi+13Em+u89E4OAgYe+c2YuyeoqteUrPb+biajIElMHA8ghOFufiWlf74l+HFudrKw1qb1SlEyaYosHPRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5zicL4dowQw8aj39dkhp6d70D8vuOsuL+DBbtzNVrQ=;
 b=jf1Sjp4oQQCBIxDAD77tez2Fzodj+w98wspQdXmkCGVo93ejcsueHfjuYWeVKphkSgzs9xc8o0TADT7cR5ciW8hk2hjqcskF2mo1pm9pX0A2Lw+y8Qi/LTOn0nR45tSHOE87NSansWrOrb7buvf5ydtZX3amxp+Bc6L9A2l7IKY=
Received: from DS7PR03CA0193.namprd03.prod.outlook.com (2603:10b6:5:3b6::18)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 09:39:01 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::96) by DS7PR03CA0193.outlook.office365.com
 (2603:10b6:5:3b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 09:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:39:00 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:38:17 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 05/31] Add is_sev_enabled() helpers
Date: Fri, 28 Feb 2025 14:59:58 +0530
Message-ID: <20250228093024.114983-6-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: abc6d85e-90ee-429d-325c-08dd57dbbae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KrWiQeSmLEBLBGYfhSTmVp6uGgXeV9POizL0JYhqvxgrg5JIgsZQZ4p2YKIj?=
 =?us-ascii?Q?tMvLHvlo8EG7Ro/dHi2n3DkwLwkx7uQ9gvxBL1gUerAPrsOBv1GgZFDqquPN?=
 =?us-ascii?Q?gy/4syOGWY4sfk4QYzmRAk3eugkBFua/jVrfuUTON/aEwnhftl1IOkz/Csf1?=
 =?us-ascii?Q?aPXOxokVe1gv5YlircoK7dBzn/5mwRw2ysvRi/O1ywupvgztB3SHCdnoUqhb?=
 =?us-ascii?Q?ZiNIo40PZweueIhSXBJOH6FMDOwzgntxrSdFDIDv7ASXAo65l/zdG1xLrhlI?=
 =?us-ascii?Q?FAmKhk3Xajv/PZlSdcJy3IKPkKaWEHUENxVsaBaXJ72rSM/sp4osJkGj45tG?=
 =?us-ascii?Q?gfBEtBh7bGYoROT0mELay/g+77z35F2lLZlXZgjHwLyzOJ7aODmnLYX/OHif?=
 =?us-ascii?Q?PBJfWQF+HKh4MNwMZOsdLqyCUFqYo+YHuISQgQfygCmadpKvr2iRihphH+ko?=
 =?us-ascii?Q?Mf+SXaS6smM0cHwqXy3CH0AfBEY+YLXRC3vY4MQd3qwSnJbp7aKhR5bu7gHz?=
 =?us-ascii?Q?bctMjQvfAnuWvWLpMlsCcvqgU5lpBMENi3ZsTZsvJpDckKBsQzsC30sd0N+V?=
 =?us-ascii?Q?1igwMgXi2WSk6pLiufPcc4/m4k28EzDSRE4l2Ye0v/1gKCXGOP0iAkH+6vRs?=
 =?us-ascii?Q?79lV5t/ddttKRiLiNQ6BtkSSgABd+xAcVwC7uK9XkrprMCsF/KXQrxU5isKJ?=
 =?us-ascii?Q?O5MO+4cRkaNOOsP6fmAordDJix64xvzjlDlb9GHXIinlPFf1OjVzZQDRvPPe?=
 =?us-ascii?Q?WxMFo0bsZ3F1oLelP14OdcEIdRtzy1wQuRQ1iqz1z6raXN0bC3f0z09ljehe?=
 =?us-ascii?Q?+gApIMDAlrK3SQVP5xuaSAu4jE6l9I4FtRc+vaPeuL1CiY3s69LS+7JgemKk?=
 =?us-ascii?Q?YSssxGTedOjL4LpA0vWq8pAQ6+xqR3zogc/GiQoRmqdM0pzohzSfNkn4rfa/?=
 =?us-ascii?Q?9DDe5lHBUo/t5qebN4IxZ8N6LrzKSryA5yoawzsQUcbp9DRg87l6bceeSXRB?=
 =?us-ascii?Q?KClp0odpGjmismFIOZXV15kk/5bs1/93EF7wMh0X188Kx80rl5Rf2U89iL6X?=
 =?us-ascii?Q?SLfoAjDmHsxg2UWre0Ciab1ygPoQ9sLHWA0AsjFKm01Xg82THI3SiIqXg9KE?=
 =?us-ascii?Q?JsLSLTjssbw++N95EnOXGsrOsBi2qI5zXfd4ooRrnAUZv84I7YqnUeIy/NTa?=
 =?us-ascii?Q?skEbILm13pP4mkjrvNCx/YLMbfhhs42ttKaUlsdKJ6qwvihACTQMH3+JAuKE?=
 =?us-ascii?Q?1BIubWjzf8CnE6cQRfG8MKcriRVNT79zB1/0jqNeCp8UE6MunG2GuznAHfQK?=
 =?us-ascii?Q?bZdBvA+oQdSpQYGUrrUL3MyQSiO12Pzc36Q1mU3mtlL5cQjGVTlF3i9CwxdB?=
 =?us-ascii?Q?OWgc+EKZzPrmnrGLzA7Rdulv2vBMFkNgVoXGrZAchfYifFMbz9BgFg08EsB9?=
 =?us-ascii?Q?sP4Jew9wU1lFKdf5lR4OiU81CoA0QGS8fn1Sg9xL0MH+4LeLTm9kvlWrBG+M?=
 =?us-ascii?Q?b1DOIVg0QoM6ndo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:39:00.0381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc6d85e-90ee-429d-325c-08dd57dbbae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

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
 tools/testing/selftests/kvm/include/x86/sev.h   |  4 ++++
 tools/testing/selftests/kvm/lib/x86/sev.c       | 17 +++++++++++++++++
 .../testing/selftests/kvm/x86/sev_smoke_test.c  | 11 +++--------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 0b4411847cbf..437e397ddd29 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -147,4 +147,8 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
 }
 
+bool is_sev_enabled(void);
+bool is_sev_es_enabled(void);
+bool is_sev_snp_enabled(void);
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index dd7ccf0324c5..0c542eae4184 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -306,3 +306,20 @@ void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 
 	sev_vm_launch_finish(vm);
 }
+
+bool is_sev_enabled(void)
+{
+	return rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED;
+}
+
+bool is_sev_es_enabled(void)
+{
+	return is_sev_enabled() &&
+	       rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED;
+}
+
+bool is_sev_snp_enabled(void)
+{
+	return is_sev_es_enabled() &&
+		rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_SNP_ENABLED;
+}
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 4fcd0f6290ae..29382dcab18c 100644
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
 	VMGEXIT();
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


