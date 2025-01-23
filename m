Return-Path: <linux-kselftest+bounces-25047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D02A1AC4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939B316CA0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49181CDFD3;
	Thu, 23 Jan 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ym7h/uDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8951CDFB9;
	Thu, 23 Jan 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669708; cv=fail; b=s5YrF6S2gI51jrUrQK2woI1xfgq1aQOq2ffrnvjrF6xPSakkmmYcjeMCbtM+Tk651YYbcak17TNym2NL9enZX1WYCOxxGBQCS63DZATvXoK1uQyojH0wJmQ+r9zja98qkUSyHXMC5z8Zhcu6R+6AaATUH/E4n/IFY8GHd0E6dQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669708; c=relaxed/simple;
	bh=3LvNXHDGSKJYnI3Y15fb8Fx1X1WqrVf4TxbHOSbrPV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCshAGIzc1wV2GJk1cldqIImbxl9Ta1aO3+1g93NMVeD4dW+2c/ieVZMxhKAIFmME+mcjNKBjeBSKQMxegYZKs9UJ/Pm4bpXGCzIj47eDFk1VqzcuiAPOFf+StNLM2vniL3FJ9OQhyMA2cPC3unVZseXXcAoaSzBKrL1tma7sb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ym7h/uDh; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAsJk6Sm426dcMCr1bOBXHzlF/2YGde+1WnoFf9KUSOcPFOFP4KKhGbAqbrsQc6iwN0Ua626RnmhP41XLdVoKiwUCZ0yTfTe86OXZp8eHZ0njRK2QMoUCKA5diZOqa29HUVGZeUWRZENIz2wePhHQcF5ZR/P7ZUcporugul3FXqTnxqghXBNEqfTctZqAbJkH/NJ0dEwI3tfBKrGXoLz0ChwuhF46cME3XwOX43fxjoQTcIztd5fZ+hEaPooc8Moh0FZ7fGFLR7CIIqT6BdDi2DYL2xxX5OY50/rNqQllO+jBEwuhdXXuTo592lidKhu7FMDXlsHmT9f7hWphRfhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqFz9y8T+D9y9DwlJUeY2mHF1w0bWZrXG4FpTuLg/hw=;
 b=kFzFhbBGnoZrEMSe3i/nzw+k7BNCmThHkGI4NytGIRKeds8Z3JNkd5ll4RmT1M47PCtw+s/ZXtFdFMmn0ifRD1Dw5nrPvSSuavOinQhYiyfTuJMxuUnmi+74kSqLx/sbqhvw7kHnYVQlKjvZ+6RBlfLRRV9uEwJYreDgJaOCqiiuuY3bpUcPy/KL/K7Ld0EmUY3j7G89Ca/inrOQI5z973cvwQ1UP4V8EQWpgfsVLhEEJOPdT7++OIu/fqOeR2oEN8bs5QdwNvR2gI5s6hbBjYZFkJzz0RmHdl8QgMCTm253IDfbOVV06Z0ovtO5HP1GDkYgCirQrhZuahD2RofVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqFz9y8T+D9y9DwlJUeY2mHF1w0bWZrXG4FpTuLg/hw=;
 b=ym7h/uDhO67YRJB1TOYAf1ZFYQBYEmAxPE1Tb69BVcwIUoXEshtmyFEJPpYygWEjqp696TveG7iNp8s0gX/2WiFH257y2cbHfn04TBU9xduTy0FbIOPQgnfHuIqagXrbuMEMNg1ninK8lOSbTjBbZym9N/JdwNs649RW+cmj/vQ=
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 22:01:43 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::5f) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Thu,
 23 Jan 2025 22:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:01:42 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:01:40 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 3/9] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
Date: Thu, 23 Jan 2025 16:00:54 -0600
Message-ID: <20250123220100.339867-4-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123220100.339867-1-prsampat@amd.com>
References: <20250123220100.339867-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8bf5da-0ea1-4bf8-3b87-08dd3bf98543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s9JlLh+TWZ3sEJEAnCszzw4HaFTQSLZZ75rYTlTasBnV81IP7TqmSVywVwa2?=
 =?us-ascii?Q?sFilZIfTVzHHoxJ3TCKKZ7GUh48wanJoi2dMoQkbZoxrtXWXpMTUw/OaMcIO?=
 =?us-ascii?Q?bNNTkIKXCXkITmbwqL3/U0zT+llwgkZTjYtkXWWEv55xV+Kq/8ZlEqZLUqct?=
 =?us-ascii?Q?s0Jcs+hiHnE9t1tlpmi5F1sMJzTYWUwQIEY1APSwQWi1CpU4WqnKie7mXHGF?=
 =?us-ascii?Q?oNsu1JS0fDAa2XDE0bhputs2ZBitJoXXu+Xw+4XocgloBoHQ+Df5dBF9/kXU?=
 =?us-ascii?Q?BJpoJthrGIyY561TrrB5iVpxfi5lVHYpw9o87bo0Hxbw98KSQbpzj5uYRJkb?=
 =?us-ascii?Q?Rf/R4Jrms55SH6LlTH76OTEUw2JZE3M3OG6ZJZGSibktXdMYiP67COLV6lox?=
 =?us-ascii?Q?C9PbpEPf6jYZIh7d2Qis/Hyrbdo/w4T+4g6A85+wy/35tioJCbkqAm7TxD4k?=
 =?us-ascii?Q?T3CucMz14v2TVdPvW9iV3Y3/I+DxaRxdoKsTumfAMecw1H28ow7/Mzy9kNi9?=
 =?us-ascii?Q?fuDHoTNySOtUaSDTg/yTvj96Bz2UI+lqkv44JYswDcChiAJWesVb9b6QYBo9?=
 =?us-ascii?Q?US7sPv711n5X04kaKjZvP32yS9yc+hOO2lQ7dtlpoVjPTcbYj17A+jGsQGRh?=
 =?us-ascii?Q?2yavgYrGJmSTNa6D70GXHFtQnYFZsS1abMgf2gns9e6fN8ptzng7xhIRKns0?=
 =?us-ascii?Q?hnY0ExkAqd8GA6ERnfxkEiaCG02jqYuW5lYxYwlde8G0FohN7HXwOgWIwbVQ?=
 =?us-ascii?Q?edUgcNb7qAPjQgHh0y8tcoBRMfqsbtUAVpRFB9qJsEdbUkXBmZk5O9OrLQaO?=
 =?us-ascii?Q?C5kvXYfOT2p+vyLkq2/hExVVK4FfcsS4rFN5KnsSDWmPTdzkVMA21tdGsP5c?=
 =?us-ascii?Q?VdXW9S20qKrcgNR7kzALmvmjmmRvI24rfMmHoVl7KzaEnvssJNcgNuiDtZe0?=
 =?us-ascii?Q?7JrC2aBKFY+Dmhpy7Kf9kSQIoDq6+EJ1oZzQ5WbMCv7fXJksVUsuitBBLVE3?=
 =?us-ascii?Q?g3cu2gnmd9PxwDm3vGrF7RvFlAIwticukJOLvMk4w9RKMXfXTgevba9p/pvJ?=
 =?us-ascii?Q?Rs4dcEfvt7H+KTLRZd/0GGl16bw2kLP1tc55og3GbMb8C72ck86aiIvE4SLN?=
 =?us-ascii?Q?69+uhcAjJ+nP811dXwLW1EkI2rg1F+jZo9HfRzs5UND40mvvNnIi9KPbP6LJ?=
 =?us-ascii?Q?fmdmUuaw48VHJqJRr+2pM+xt5C4XMA2yHmQO5sTtFWvmFQyuw/SYBQtPbvxJ?=
 =?us-ascii?Q?xu4WWdY0RD4WnkNysHdP5gi4ewPSlGkb0YcmZcW8sVs7oTL27zyyeeuUhtZO?=
 =?us-ascii?Q?JcdgC/kZHk52h4V+IpeAZ7X2Nmbclw5h7KnMKCNMq5/f8JFZr6ElyXrZ/buu?=
 =?us-ascii?Q?zblLRELdjPXzSNu0Bkc+DrtigNcQ3us+m8wEceNouZfe7SVa8VaMMZkzGBtr?=
 =?us-ascii?Q?FXCeK/oFOJRHO2F+FMKEY8O6L3kcXxvXioHbgWT1OgKgZBsAU8v8u8ok2bRr?=
 =?us-ascii?Q?o/z3H1qKMONu/Ps=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:01:42.3587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8bf5da-0ea1-4bf8-3b87-08dd3bf98543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446

Add the X86_FEATURE_SNP CPU feature to the architectural definition for
the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that the
SNP test is skipped in scenarios where CPUID supports it but KVM does
not, preventing reporting of failure in such cases.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h |  1 +
 tools/testing/selftests/kvm/x86/sev_init2_tests.c   | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index d60da8966772..1e05e610bb06 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define X86_FEATURE_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
 
 /*
  * KVM defined paravirt features.
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 3fb967f40c6a..3f8fb2cc3431 100644
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
2.43.0


