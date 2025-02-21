Return-Path: <linux-kselftest+bounces-27226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42740A4019B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157A63BB212
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E77253B7D;
	Fri, 21 Feb 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XkBS5ity"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFA24CEEE;
	Fri, 21 Feb 2025 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171765; cv=fail; b=FcXZKE/y0Y9qF1mLRWn6q4taGT/Dv51NH7v/QrxkL5ep+ybWgdrVH4kUws+3LVzTIj+34fwo1Iaf8UiDctfiM2Q2qX/nVj35eMjCypS1E4sC3AkZkOMJBEI4U1fWis32QRu7d1GWATV7Y1+IOfQf66/4Q7DtEoiH3iuRxFlRa80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171765; c=relaxed/simple;
	bh=HeobsnJx2ut3bid0GVVsn5d8Rw0pJHYstyYfSln7Xf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLpzX6pBbzWlgxQiy9zKBmNDCTOaWABODoM0WyihGH2Fbzn4FCNVvjx+DHXo5wTvvJBmEbsgdHjIY+ypQIzex+pEXSeewUOglQYqpln1pTFC7jPDBH7jNxNg7Ityfw4Da73IQQuqYdUtMmQapqecSFVz89LlCgXinqVKmUX5lw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XkBS5ity; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMpH840f/nZpx6Nbo716671MD4k9Zmz+OTfRd9NRa6A0gYhXY0Rp0SsdQRulZgcFBSYKyrkyjRb8IIRM8yWhII/WT5q6YwyBJXuGPxRrQBkg0Lg2QFFwC+pRnkM1Jo+Uwn0yNKmgRwnWlqtnwdtN5kHcFy/Kc/KRlJhY0PYeVzjqDeAp453j6CHyBFwqviEgE5hnvJ+X2ke/9+9iWdvPQ5HVDKWf+VlMeXu3EeATlc8AjmNNQzSJbDQU6hK2Y4cugW7lw8Qfks4s1KbCZwaBgEADuATL/yzMBwUUDqs4Cd83jtnpz7VE486lNjGbSkzBmptAvca2VU+W3gXFHDZoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW2KqwJZBVQaX0gnP5NU6UKtopLc4rSHm7f0g0J4fK4=;
 b=hep4KfY3Ybaw20qfjUjOTTLtU/inSWQpz65PQ7FuKmmU+yF582CKNHH/1lg7Rj38jrYAceV+aMHkSSRI4xQQ6sK7VWJTj/837KxVCbnEZqylrreSwvlRga6ysDde7FinuPUVeZXOFaHECiRfx+O5D+++VpVLUYZIDsMZdmdUE1xPb6VLeokz97feW+oGLfwC0YTMhYq/lEnxFvJsP3nW4RqlKARKrQrZW4upWvhwDwaGTBYFcCnBCuwVXlgvadyf3dmaEH14/RMC6/c/k8OJ6ZoKTqFANNKkteuooMyVEj4eTHFACLiD8o7v4lkGfP1k4+5H5MnU5bre3smEVj64eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW2KqwJZBVQaX0gnP5NU6UKtopLc4rSHm7f0g0J4fK4=;
 b=XkBS5ityuDdNatqWOGiejbOkurizR8wL5pO+7vROdR2fd7tZSWc8meSCxvk9vTVGubrNLXI/9951a4AQb74t7gfp09AC/GE4lhJgEjNgCAjwWg0ueGShc5u3fj+AUNUSBYSsuChMk00avCMei1vyaQcK8Is5wV/VbuJ1IFQoxX4=
Received: from BL6PEPF00016417.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:5) by PH7PR12MB8106.namprd12.prod.outlook.com
 (2603:10b6:510:2ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 21:02:38 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2a01:111:f403:c803::4) by BL6PEPF00016417.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.20 via Frontend Transport; Fri,
 21 Feb 2025 21:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:02:38 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:02:36 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 02/10] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
Date: Fri, 21 Feb 2025 15:01:52 -0600
Message-ID: <20250221210200.244405-3-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 415957b1-501f-4346-627d-08dd52bb12e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMgCc5UkATdQCokx75C+JFUYjpDB9xeTD7yr0uKZbG2WvoiUEVSjjLoW1J19?=
 =?us-ascii?Q?5x2Lz55QhXVOKSiCctd0xuRWmHv+MOv7XKyhs5JdaNYX3xWpkeikEMJvblJF?=
 =?us-ascii?Q?rgCsPAarpXF7J9MrnD3m22tdcyLDIw+oY0/5yFgKoCgBRIHua6opwOcLx4uF?=
 =?us-ascii?Q?E1urN0AU142jSEhOlwqvzQgBuI2XVnerXBL6KQDSZs3qbAQeUM9sKdxCaTZJ?=
 =?us-ascii?Q?Db3fKA2N2OQQQXeiq5f43EVOOxJE3eD9ORgYDLGaqpAuftgTDQ4QP3OpoNvq?=
 =?us-ascii?Q?GSQ4F5awyzYafMzS+gBcp205OINzzqqKP/1RxuS8esfOqWW/rgzZCnH76Eiw?=
 =?us-ascii?Q?WgmuyfQRYXWwtuGWuJskiFrVeJlrp7wKbA7jac8TCgnX4ls7fXC0CThQ5Qfe?=
 =?us-ascii?Q?vSASe1hCeD6P29kHPubq/Nfh3caNhy9Z8Qi3FPvSlsgmDvDYS7WOjU9cBGfU?=
 =?us-ascii?Q?D3SZH11oDepueYfRdkhsfZIpRGqOvM0EqmgC5kzjHIalQKJqt4lfXTXiquSk?=
 =?us-ascii?Q?tcVjacPdEf8ObuLbzeR3R/LZigMrR/QZpWm1df16aJ4Yb1P/9y9aw9M5/NMn?=
 =?us-ascii?Q?yj88kZqJFgr9Cv5vamxW0iwUamAinVggR6RpM7DYtZRFNUSBekS/92mCgK9s?=
 =?us-ascii?Q?ZAZvLAToVPIzwJtkDFHJgTVr0uW0K62orstIGmg7TUd4NAhdARNGD7kr3ism?=
 =?us-ascii?Q?aiW6rH5g8XANzyWE4H4J6k5GW6GBGhZqTKm3fFJAWTRLaC/VeLC9W9Tb8Nac?=
 =?us-ascii?Q?2/kRslEwLRbQXwnFaoo6URAXjU26GbsdmXCRg3heuyOHi6xzXrCKPjTHy5pN?=
 =?us-ascii?Q?ujqoIOyjMXuX25WwFH5VAsGOVSm79Ii5NI+cxX+u+xZq12cn1y/u8DgCW4GV?=
 =?us-ascii?Q?c7PepLxh5c00U1SAYTQ4dmYJ8nCOhve1xlHnEJWWsPSt2zME8Vzq7/VUSaWS?=
 =?us-ascii?Q?FS7clJ1U++8RxdraKTDPqldMAaHUmLgqnysTtTZOGuNT0cUkIrPUl1SZ1chI?=
 =?us-ascii?Q?Zntn+AqEGgsV3/zLZvz8P9D5lBQq80kcnctGmy6xFK9JbiehqjMbrapod1sg?=
 =?us-ascii?Q?i7CMQDSqG/u1nRFBCrpQcTyYtTpfzyGNneqLMn5ul9BqOG9JwaFrqY5r8pkD?=
 =?us-ascii?Q?sBUgLhRB+q67fom8yH26bFCeIcLevuYQjjyXxvPRGyvEB64bl7hDXoQm2pYI?=
 =?us-ascii?Q?csRDxOKFjH9cGB82cwsloTqk+2EsHM4pjXaTI7q5oWIrzKdxXVN5lNZmEr7P?=
 =?us-ascii?Q?5Bu5O3AxjIgVXZf9OTm2NvAWTodB16eVSAUY8j1xgtuUnGRhuvkidOegeaMS?=
 =?us-ascii?Q?URp8VIkUW0G79kun5C4Bvd0EDTwamMZZbmej8hB+kMDXu68l2nPQhZN7Dhdy?=
 =?us-ascii?Q?XluL0/wc+6AjFZS3S1QbKlekELVsYYpCbfyhjnD/HPkM7yqY5u+ycD5IEpg+?=
 =?us-ascii?Q?hBV5fB6VfZRSha7UqhjTvBSQLcsxV2t1/LQaLxBJpU8L5yJKqnxqbVGs5kS/?=
 =?us-ascii?Q?NVTB2OBAEvuR8xU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:02:38.5082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415957b1-501f-4346-627d-08dd52bb12e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

Add the X86_FEATURE_SEV_SNP CPU feature to the architectural definition
for the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that
the SNP test is skipped in scenarios where CPUID supports it but KVM
does not, preventing reporting of failure in such cases.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* No change
---
 tools/testing/selftests/kvm/include/x86/processor.h |  1 +
 tools/testing/selftests/kvm/x86/sev_init2_tests.c   | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index d60da8966772..6f63fd10bbc6 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define X86_FEATURE_SEV_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
 
 /*
  * KVM defined paravirt features.
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 3fb967f40c6a..ab3dd11ac163 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
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
+	TEST_ASSERT(!have_snp || kvm_cpu_has(X86_FEATURE_SEV_SNP),
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
2.43.0


