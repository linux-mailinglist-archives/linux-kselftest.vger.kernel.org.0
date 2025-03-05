Return-Path: <linux-kselftest+bounces-28351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E41A53D5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16E5189192E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3B1EF0BC;
	Wed,  5 Mar 2025 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sfLEAkj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B541C85;
	Wed,  5 Mar 2025 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215664; cv=fail; b=Dg9fS2CuSFpbMaqWTIkjNX9vjlDYzoq6UhPwj5k70dQnDqusIMH38Kez9yhYLwvAMIbraukrC9nq/1pjyT53XuXUppdiTFKecF2h64HSDtkrtnXkeZwyLXf4KHjSirlPowVKAyV9klH8peioVOPWTcMfwNirGk7EKIwQsjjrjMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215664; c=relaxed/simple;
	bh=98lLaXJYMtWt4aMP17S+XOWQAaIU4ZcqBAYHNEJcTDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svThKr4rzbk4NcF6MmMN4K1HZCaMiyY9hIGUsmCF7waDM9ohUPelKPnZTb6FhbA5113D0LiNUtdajuoG3kximsJ7Kg2ZolPQFagtEK5NROISNvWHm6AZImWEGMMJJhZCiAA3CPlVYYRfHacZLpd6gva+U5ajhEnIy8R3FskQBgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sfLEAkj6; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDE4xQaoLR8ULAf9A0QlL1KUemGCSg2kDzIrVeXVRCSzYDD9fKf/vSDONs0DonJqDBKaA9ulQ3NYavMDRPskK7ar0A1jCx9n4y0vmGLZiU/GB6+Jyyslby0136vVQq+IcXZ9Av64G0a/UTQ1RjOgIxNXj7RAFtUTd+j6Lypj96zVJ3zhQsanl2fY4VnQZPv/7RjlBte8jGTpSpu+QsbWcBpzu3tYg2a/rYbpKtk4+TnoCkmasjhXHBittsHH3WLDqvJP/Hk2yzlRxbZX0BsONHDwSDZJfdAkY5CPWhYxjRc5lkbx03CoXK8lUrpavmXcLlA2b/G3dsIMKqo8nuHp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBE7zHekxYgxiNuv+IPzAsIVxl7ku2EBHE1X1i3NUfc=;
 b=a/YJ2NkdeN4jpXmqXKswh7rU9ZnybTmGu5SCddHTxtkS0+Pb+QWRzjTQiMF0ITsQtt9j8T3jAWkVwX4wLYV8Ifrlkvqj2S2l15MEPZPU38ImPVa0tM6utm6wDVD9QuhwuuUAxeUkKBe8rP+Qk/a7UoYjQrOfgzfqbC478s+PF+PWrGHhCOvrKkRsIWDgwkPOLYPRBWTAaI1+kUtwFVAZ5y/bh2Cr/p9CYDAtaop9VV2Km0szuk1PdmH10hCI8ZzXR9PN8EVeDrso1Hx9P+DIyLvpOhgeSkSgoWOY/FHQYpsOF5Ouq6gS5qHv+G/0s8UicUXVpEYDhz1lTXeGoHft9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBE7zHekxYgxiNuv+IPzAsIVxl7ku2EBHE1X1i3NUfc=;
 b=sfLEAkj6duyiR6M/hjp+HD1rejDCVPrAykJAYT4itHOHNbYT34DxwnMdAvG7QHjuzYXLtzXyxE6mzBjjN0nTv4SZpmyWXCl169ud7MwT9QzYaxguWUzZEM3FeRwtoldkO+qEVyPPJsKm7UdouNzlyaPuCQrQft/GkKKPrm0OGIE=
Received: from BN8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:ac::28)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Wed, 5 Mar
 2025 23:00:57 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::44) by BN8PR07CA0015.outlook.office365.com
 (2603:10b6:408:ac::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 23:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:00:57 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:00:36 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 02/10] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
Date: Wed, 5 Mar 2025 16:59:52 -0600
Message-ID: <20250305230000.231025-3-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1d4131-03bb-4ce0-6a49-08dd5c39973b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vQl4ahr4A4Fc3zMhYyafGxLNZfDPUfDC/QMJdfEstRJLQa64lyZf56zxUjCN?=
 =?us-ascii?Q?lBWI6fgbDeU3UoWMfcbYvkV8TQTzhs7Uw5y8Za6ZtOchNde4CmeKArpv7wQI?=
 =?us-ascii?Q?/d1AK65jAchl6Kx2SKcYKnSA53Z8tPwAjPTu96rL4eL4Lxm5S3gylSl9HxPy?=
 =?us-ascii?Q?0knHW4YzAcLZqZuaS/gxH/LaSo2+sATwDiqYnIBGsOhDa98mXeXjZ5aoVOBN?=
 =?us-ascii?Q?QYxeT9LbRtCUr3DlKHqwDaKLyX7Af7qPiBjn/Y3q5r5lfXaTnKAtFLJZwJWj?=
 =?us-ascii?Q?KdN512qnNZNOBu9We15bghx4BaF6wZIvbTotHpYbYjb2ocnlbHJqhXWFPDx6?=
 =?us-ascii?Q?x7WF0iNJ+BMjA5BmcNDYwZb7RIhHtQgMQdsqpL9mAuv+WgT5aK1MVCofFrbI?=
 =?us-ascii?Q?dFyFdE2/n86dyyZWUwL8fRxqTM3cj9LoEkBIsLAZuI7WE73QoEnRb+IH651t?=
 =?us-ascii?Q?Yu0+EzP8xJvFxnMl4SgS5yhT+mOP0Un2Zjv6Jc4FOZuh8PuTlRjGgMDjH5Q3?=
 =?us-ascii?Q?4s+dKtth9LVjS3znjuMn3RR4bAHI8ZYMFy0uXMcXjmoUQbCpJ+CPG2h7Q9Oh?=
 =?us-ascii?Q?wQdw1TpgB31kI+by79+20qKurOr/6hcf969nqiSgcdncPfyo1KKT3JzFrmGz?=
 =?us-ascii?Q?Tr/3SXaCfm+ehtIK+2B7I6Fy0/HW1ZkoLe5j+xHCCjFP3PEVNDLDqKcIofEp?=
 =?us-ascii?Q?j7ZfG7a1brus5HGsJ40eLw9vLN0U26NsFCASAcTWRbvRK45navC8jOttnulj?=
 =?us-ascii?Q?rmIH8tilbtwxL6ljD6mXnmemfhtVMTx5gXx6qDtQatfw2zPI9VfhFYDYNysA?=
 =?us-ascii?Q?JvFkgtFtJnK0ch1pCsBj5rgqJx6mYYBwldcuLtz8Rxxx7qiMhzH9JpL0QazV?=
 =?us-ascii?Q?a5azkGhjX5/GuXa6RYVnlPrDDUvkp8VePlamlsjGoCaOrqyvOp8mn9Qj3Ujs?=
 =?us-ascii?Q?6wWhwlfH2DxdgdjsN0HeUbE3yxrHHaMeRwlHssEMU7+tS7G221v5NiJx64xl?=
 =?us-ascii?Q?YDx0Bue31N22FXcCxjm1+BWXZ1Z9K67esz2j0RvZULtSPj/JOx9oB2+zVvms?=
 =?us-ascii?Q?KRblawQKix99YCACgicRxXJ9XM6pGi/rcQptfJqH5MEyOCWubTnXCZ/lQKrH?=
 =?us-ascii?Q?khZREhIcAie4XR9IQVQUa1c1dwzoUDdtvatBENp/BW/dtsLJMVnDnYQF76hI?=
 =?us-ascii?Q?ovV2v9K1pp9n71lHcF2dMYXo7nmz9iPGInNrcqhVDvAGHaPwoUd5epsTRCSG?=
 =?us-ascii?Q?v7sYHADJqZueHUb7M2RcSiJ8bZxaH6ECzaeNLW8HZX+paY7KGgvUSXzuNqe4?=
 =?us-ascii?Q?/nbx7LyPsrq1U/QjFkT5tfuJu1FjPFVGq3iEToMvJoY58g0nKQv8IB+IdfNJ?=
 =?us-ascii?Q?fS3Nxpah6vFr7QX1NvwiEb6m/4DxVddaQMS7q6ToZ8RDAhzJZEoeCrX5xLNA?=
 =?us-ascii?Q?8kwaI5YL9TkW5WSplMEPkvQjia+k70JD2Z43CahzLCGyDE4WEXy2xolXIbLT?=
 =?us-ascii?Q?/WbFTIDs0IU1svI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:00:57.6154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1d4131-03bb-4ce0-6a49-08dd5c39973b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055

Add the X86_FEATURE_SEV_SNP CPU feature to the architectural definition
for the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that
the SNP test is skipped in scenarios where CPUID supports it but KVM
does not, preventing reporting of failure in such cases.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
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


