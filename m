Return-Path: <linux-kselftest+bounces-15558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0958195515A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AD51F2230D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0911C4612;
	Fri, 16 Aug 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aHCMuvgG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD91C460F;
	Fri, 16 Aug 2024 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836228; cv=fail; b=Yfs6xnDi6USMsL5pamZrznrXeZEDYIV/N6GztOXYWOyLsnJUU/JVuJbhhoxUtRCHHOGZYQHCttuM9vbljCwUief4CCllUW5PByf88Fw4/F4p5LvY3cOo21UnY474CxvEt3fvtayYODdeHMkrdPkO0iPouG4ceGP0SLLm2Ta+SkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836228; c=relaxed/simple;
	bh=5G0T+/JQ/tmth3im4O/XnGOO34YIKXOqxeI5kHS/eEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKsO1F5EOM1pLSuVZm7J6TvtjeMnzB+qFQkdofQw/KL4KKiy+XurF7aomv8j9XFNpp4xsDh+fQS4P4kyLwbSehyI9xonk37NDy/6iQ9x1VoYquV2RNr7mQAsEHB0WV66it/KSIopwjoRQBLN3d9MOqN6AfEybcImTMiliG5nqiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aHCMuvgG; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/Y+PMUzc+84lv42mPKYG1BromtsPFIJC9TViKTQ8WOdbVrHXyKma6LIH3+yIJO8TG5pgFfmssxytda03oBA8/NB9FshgxsDaaNWPWyEHvTPwrw6apsURQaZZhT4YC5hA+NenK7EZN8z7zKmz1DLWk5t2YYSuRWKnOwYS4OUfjWWUikj8emTQfHbOh29C141/EEV20bIrkRJaf+Xl+q/D14I0aX+S73/pxAVc8Q38biI1OwAqzdlK23iZfG8Nih4QkejT4WIvZSUkC1xXn2p1gLbM5po+RVHtbQX+BC8pAeMvskPiK7kmxXMZ7z3TdtZxE/6T7V3rpVXdbyP/A1ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvUU+MgTFdNdlmcaF8T7ucBMdN3CuqsOBgVk4jmPqDM=;
 b=T4P4ZCQqozATWG7g2cyQ9HGmqO/U9TOCI8BtBDLfU4/cowVn1MUkyrHtKVmDCRfx2r9sNj1mc6eKTfLab4kLCW50SF43BltkiWE5xy+MWmnXKCstZHfotYZ/l5TBj5/9qgDNjKvXxpEIWZXyC9CLyeuR2SVV0Z89Z77sjV8cV9yIX/QGFcUaeq+7XCbIyXskQ8rTs6VcJvVCaf+x8MH5sF5H3dAvbYdMq1X14n9nG8C55ZF4A2bCo8tdbwPSEyJF8kSsvaxpV1rDvtOVEBv1TNJOVmTjxx5asfabguvi7ZzQA5Xyz4+zDHiRNh4z+PENGHDhqPJKklgXS0NknYLxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvUU+MgTFdNdlmcaF8T7ucBMdN3CuqsOBgVk4jmPqDM=;
 b=aHCMuvgGxJx6tqaLDiU7CN1yuxsaR4aqZxclgLggNCwmQ/+c4e8rUqWtuzmmJXweLs8G1ovns5sA+9ghdAg8TmadzYu6msx9XlsLwNvnCOQYkFpSyy94dJCupBkNlUE8uP62WmxJ6ABUvw+BOpX4f7N9GYYthe0phGsZr9nceN8=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Fri, 16 Aug
 2024 19:23:40 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::11) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 19:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:23:38 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:23:37 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/9] KVM: selftests: Add a basic SNP smoke test
Date: Fri, 16 Aug 2024 14:23:03 -0500
Message-ID: <20240816192310.117456-3-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d87cb51-0fc9-41aa-9a61-08dcbe28eea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKDwqo0xkvciNOZR2rktPHxqDFgWMqhn8dDZox3n/8tIDDlAvbQ8PXO6NuVc?=
 =?us-ascii?Q?0X5vBrWvEZWJn7DYR46ARhb971gfILUCFDRNsM50veiKsVyP1W4k30uxfkyO?=
 =?us-ascii?Q?Brd4ePEfg3XryTfcdV38UOM6o7l+b/uPxEC3stMVeOlzU30Eb+WqsoII/f1n?=
 =?us-ascii?Q?AD4+cB4wYSawwVcQl6Xfb/DDX7pCLIUU8VoqXpOWF2OXArq8HZmsp+gIzZgb?=
 =?us-ascii?Q?iwJr1ppsSH4kt4j3yIY8c++GlNQm+iKyftfL7UnpMgi8H4eCcv9NAG+vDra/?=
 =?us-ascii?Q?Vrk0EfoLQf3opLLhLQq+cT4s54Gd16C4YN0rXxN+MbEzsKSaWqHORdvlAi1W?=
 =?us-ascii?Q?uPakY1sBSTKTqEA5510Qk1vPPLe9d+JBd/IrfcBmdzRcbYjUxPGoJHFutTc2?=
 =?us-ascii?Q?YfyTKW3P/KTDxMnQgqKuCCCtdkoP74u6P14+itpPG7FgTwHxoI0Zbf7OODa2?=
 =?us-ascii?Q?yl16g56R8AFz1bn5IPiIVUho4nivvq4NPffK88e6PQJcLipLieOVUAvKQas+?=
 =?us-ascii?Q?i+Xxd7+Ilwj8VOkLkrZ30TLaVNypUxmCbk89405NnxXwh1RLNuKKyBk9Nxzs?=
 =?us-ascii?Q?txg0h1EwNh1YIBdt79PjMYKCipe/aYZKu4zyQt6VcDsVxq0Tso1kbd5FhzDU?=
 =?us-ascii?Q?B+q7DIvq2b1laEtYhnLlQI30pNri9nqT/uCJKKR6Ik67Uk3Uk4/FU8yM2EFJ?=
 =?us-ascii?Q?rS+PgsYAXFMRwj7kqnKUZO4/xxvjqtO4vPaeqczhx2zDhVRGmWGHK5OJhXC4?=
 =?us-ascii?Q?TeiafPlJ9mt+lf2DajeJG3pz4pmjL0T5CgaXX2XAOWklP/HLgrc3kYDgzxO1?=
 =?us-ascii?Q?ukWloU+H2ZMalY5Zp0wFbJHc4X7BLgbHPNCVyXaSWaU2YiiPmgfBG2rKsY7q?=
 =?us-ascii?Q?CVd8ClpZ5nP+08LMO6W3sXzjdh7OtOdK4k0KDe6S7SecX6vTYOI0AUj1g7Az?=
 =?us-ascii?Q?hkguNlLT7z71/1lKIEfreWDS0z2mImLNEiR1Em5Aea5vKs3N66joPCLa3cxK?=
 =?us-ascii?Q?DKPJQkOM90rl2+4k2Shx8CY2s8LZjAQG1rskbIB3jvtxMRSX0ks5uML81NuC?=
 =?us-ascii?Q?GpzP46gRe1Cz/bkJ6Pl35MfD+K9Iu8f+BlcS/mNQV5C65XegRfSJsnp88oJ/?=
 =?us-ascii?Q?J1ulMw0ESBhor+vmXC/kTA5V+LQM8B5dZE72JAHBL4eq7nU9JBl+R/PwuES7?=
 =?us-ascii?Q?GcA6AHvl6mbRwAbuI0604l21zE8f7Qc6L2hTuSIqeell4curXUKLO4nC1aSM?=
 =?us-ascii?Q?X7YwrEigyJ9BsOsQUKttOguLx/SKP2hj+doNUMvbxLrVj4/P8VB+/oDPPm5u?=
 =?us-ascii?Q?0xNeReHnKmRP6lH3FPT2WHWBzBsK6ia9O8YUpBF/BTc0wejHfjFhWw7w8FnT?=
 =?us-ascii?Q?mf6lJxK6wbknJqBevY0GBeBcuDY13jj6vhI/kOozfqegkBYL5uOyda74Cg07?=
 =?us-ascii?Q?MX0VaGIRc04Uynxe0dGX8PRqfL2V6IBD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:23:38.9742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d87cb51-0fc9-41aa-9a61-08dcbe28eea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126

Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
initializes and sets up private memory regions required to run a simple
SEV-SNP guest.

Similar to its SEV-ES smoke test counterpart, this also does not
support GHCB and ucall yet and uses the GHCB MSR protocol to trigger an
exit of the type KVM_EXIT_SYSTEM_EVENT.

Also, decouple policy and type and require functions to provide both
such that there is no assumption regarding the type using policy.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 .../selftests/kvm/include/x86_64/sev.h        |  54 +++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +-
 .../selftests/kvm/lib/x86_64/processor.c      |   6 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 116 +++++++++++++++++-
 .../selftests/kvm/x86_64/sev_smoke_test.c     |  67 ++++++++--
 6 files changed, 230 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a0c1440017bb..8acf06cc66cb 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -195,6 +195,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define X86_FEATURE_SNP		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
 
 /*
  * KVM defined paravirt features.
diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 3998152cc081..658c3cca208d 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -22,8 +22,21 @@ enum sev_guest_state {
 	SEV_GUEST_STATE_RUNNING,
 };
 
+/* Minimum firmware version required for the SEV-SNP support */
+#define SNP_FW_REQ_VER_MAJOR	1
+#define SNP_FW_REQ_VER_MINOR	51
+#define SNP_POLICY_MINOR_BIT	0
+#define SNP_POLICY_MAJOR_BIT	8
+
 #define SEV_POLICY_NO_DBG	(1UL << 0)
 #define SEV_POLICY_ES		(1UL << 2)
+#define SNP_POLICY_SMT		(1ULL << 16)
+#define SNP_POLICY_RSVD_MBO	(1ULL << 17)
+#define SNP_POLICY_DBG		(1ULL << 19)
+#define SNP_POLICY		(SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO)
+
+#define SNP_FW_VER_MAJOR(maj)	((uint8_t)(maj) << SNP_POLICY_MAJOR_BIT)
+#define SNP_FW_VER_MINOR(min)	((uint8_t)(min) << SNP_POLICY_MINOR_BIT)
 
 #define GHCB_MSR_TERM_REQ	0x100
 
@@ -32,14 +45,22 @@ int __sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy);
 int __sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy);
 int __sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 int __sev_vm_launch_finish(struct kvm_vm *vm);
+int __snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy, uint8_t flags);
+int __snp_vm_launch_update(struct kvm_vm *vm, uint8_t page_type);
+int __snp_vm_launch_finish(struct kvm_vm *vm, uint16_t flags);
 
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
+void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy);
+void snp_vm_launch_update(struct kvm_vm *vm);
+void snp_vm_launch_finish(struct kvm_vm *vm);
+
+bool is_kvm_snp_supported(void);
 
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
-void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement);
+void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement);
 
 kvm_static_assert(SEV_RET_SUCCESS == 0);
 
@@ -74,8 +95,18 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
 	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
 })
 
+/* Ensure policy is within bounds for SEV, SEV-ES */
+#define ASSERT_SEV_POLICY(type, policy)				\
+({									\
+	if (type == KVM_X86_SEV_VM || type == KVM_X86_SEV_ES_VM) {	\
+		TEST_ASSERT(policy < ((uint32_t)~0U),			\
+			    "Policy beyond bounds for SEV");		\
+	}								\
+})									\
+
 void sev_vm_init(struct kvm_vm *vm);
 void sev_es_vm_init(struct kvm_vm *vm);
+void snp_vm_init(struct kvm_vm *vm);
 
 static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 						 struct userspace_mem_region *region)
@@ -99,6 +130,19 @@ static inline int __sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
 }
 
+static inline int __snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					   uint64_t hva, uint64_t size, uint8_t type)
+{
+	struct kvm_sev_snp_launch_update update_data = {
+		.uaddr = hva,
+		.gfn_start = gpa >> PAGE_SHIFT,
+		.len = size,
+		.type = type,
+	};
+
+	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
+}
+
 static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 					  uint64_t hva, uint64_t size)
 {
@@ -107,4 +151,12 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_UPDATE_DATA, ret, vm);
 }
 
+static inline int snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					 uint64_t hva, uint64_t size, uint8_t type)
+{
+	int ret = __snp_launch_update_data(vm, gpa, hva, size, type);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_SNP_LAUNCH_UPDATE, ret, vm);
+}
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 56b170b725b3..9cc4dfc72329 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -413,14 +413,18 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
-	int i;
+	int i, flags = 0;
 
 	pr_debug("%s: mode='%s' type='%d', pages='%ld'\n", __func__,
 		 vm_guest_mode_string(shape.mode), shape.type, nr_pages);
 
 	vm = ____vm_create(shape);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
+	if (shape.type == KVM_X86_SNP_VM)
+		flags |=  KVM_MEM_GUEST_MEMFD;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
+
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 153739f2e201..670fb09c43d0 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -629,7 +629,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM ||
+	    vm->type == KVM_X86_SNP_VM) {
 		struct kvm_sev_init init = { 0 };
 
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
@@ -1138,7 +1139,8 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM ||
+	    vm->type == KVM_X86_SNP_VM) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 290eb0bd495e..75c1463b98d4 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -14,7 +14,8 @@
  * and find the first range, but that's correct because the condition
  * expression would cause us to quit the loop.
  */
-static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
+			  uint8_t page_type)
 {
 	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
 	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
@@ -25,12 +26,23 @@ static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region
 	if (!sparsebit_any_set(protected_phy_pages))
 		return 0;
 
-	sev_register_encrypted_memory(vm, region);
+	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM)
+		sev_register_encrypted_memory(vm, region);
 
 	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
+		if (vm->type == KVM_X86_SNP_VM) {
+			vm_mem_set_private(vm, gpa_base + offset, size);
+			ret = __snp_launch_update_data(vm, gpa_base + offset,
+						      (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
+						      size, page_type);
+			if (ret)
+				return ret;
+			continue;
+		}
+
 		ret = __sev_launch_update_data(vm, gpa_base + offset,
 					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
 					       size);
@@ -68,6 +80,14 @@ void sev_es_vm_init(struct kvm_vm *vm)
 	}
 }
 
+void snp_vm_init(struct kvm_vm *vm)
+{
+	struct kvm_sev_init init = { 0 };
+
+	assert(vm->type == KVM_X86_SNP_VM);
+	vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
+}
+
 int __sev_vm_launch_start(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
@@ -83,7 +103,7 @@ int __sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy)
 	int ctr;
 
 	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
-		int ret = encrypt_region(vm, region);
+		int ret = encrypt_region(vm, region, 0);
 
 		if (ret)
 			return ret;
@@ -112,6 +132,41 @@ int __sev_vm_launch_finish(struct kvm_vm *vm)
 	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_FINISH, NULL);
 }
 
+int __snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy, uint8_t flags)
+{
+	struct kvm_sev_snp_launch_start launch_start = {
+		.policy = policy,
+		.flags = flags,
+	};
+
+	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_START, &launch_start);
+}
+
+int __snp_vm_launch_update(struct kvm_vm *vm, uint8_t page_type)
+{
+	struct userspace_mem_region *region;
+	int ctr, ret;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		ret = encrypt_region(vm, region, page_type);
+		if (ret)
+			return ret;
+	}
+
+	vm->arch.is_pt_protected = true;
+
+	return 0;
+}
+
+int __snp_vm_launch_finish(struct kvm_vm *vm, uint16_t flags)
+{
+	struct kvm_sev_snp_launch_finish launch_finish = {
+		.flags = flags,
+	};
+
+	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
+}
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_guest_status status;
@@ -158,6 +213,45 @@ void sev_vm_launch_finish(struct kvm_vm *vm)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
 }
 
+void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy)
+{
+	int ret = __snp_vm_launch_start(vm, policy, 0);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_SNP_LAUNCH_START, ret, vm);
+}
+
+void snp_vm_launch_update(struct kvm_vm *vm)
+{
+	int ret = __snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_SNP_LAUNCH_UPDATE, ret, vm);
+}
+
+void snp_vm_launch_finish(struct kvm_vm *vm)
+{
+	int ret = __snp_vm_launch_finish(vm, 0);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_SNP_LAUNCH_FINISH, ret, vm);
+}
+
+bool is_kvm_snp_supported(void)
+{
+	int sev_fd = open_sev_dev_path_or_exit();
+	struct sev_user_data_status sev_status;
+
+	struct sev_issue_cmd arg = {
+		.cmd = SEV_PLATFORM_STATUS,
+		.data = (unsigned long)&sev_status,
+	};
+
+	kvm_ioctl(sev_fd, SEV_ISSUE_CMD, &arg);
+	close(sev_fd);
+
+	return sev_status.api_major > SNP_FW_REQ_VER_MAJOR ||
+		(sev_status.api_major == SNP_FW_REQ_VER_MAJOR &&
+		sev_status.api_minor >= SNP_FW_REQ_VER_MINOR);
+}
+
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu)
 {
@@ -174,8 +268,22 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 	return vm;
 }
 
-void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement)
+void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
+	if (vm->type == KVM_X86_SNP_VM) {
+		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
+
+		snp_vm_launch_start(vm, policy);
+
+		snp_vm_launch_update(vm);
+
+		snp_vm_launch_finish(vm);
+
+		return;
+	}
+
+	ASSERT_SEV_POLICY(vm->type, policy);
+
 	sev_vm_launch(vm, policy);
 
 	if (!measurement)
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 04f24d5f0987..0b65b59b9b40 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -16,6 +16,27 @@
 
 #define XFEATURE_MASK_X87_AVX (XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM)
 
+static bool is_smt_active(void)
+{
+	FILE *f;
+
+	f = fopen("/sys/devices/system/cpu/smt/active", "r");
+	if (!f)
+		return false;
+
+	return fgetc(f) - '0';
+}
+
+static void guest_snp_code(void)
+{
+	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
+	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED);
+	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_SNP_ENABLED);
+
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+	__asm__ __volatile__("rep; vmmcall");
+}
+
 static void guest_sev_es_code(void)
 {
 	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
@@ -61,7 +82,7 @@ static void compare_xsave(u8 *from_host, u8 *from_guest)
 		abort();
 }
 
-static void test_sync_vmsa(uint32_t policy)
+static void test_sync_vmsa(uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -77,7 +98,10 @@ static void test_sync_vmsa(uint32_t policy)
 		.xcrs[0].value = XFEATURE_MASK_X87_AVX,
 	};
 
-	vm = vm_sev_create_with_one_vcpu(KVM_X86_SEV_ES_VM, guest_code_xsave, &vcpu);
+	TEST_ASSERT(type != KVM_X86_SEV_VM,
+		    "sync_vmsa only supported for SEV-ES and SNP VM types");
+
+	vm = vm_sev_create_with_one_vcpu(type, guest_code_xsave, &vcpu);
 	gva = vm_vaddr_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
 				    MEM_REGION_TEST_DATA);
 	hva = addr_gva2hva(vm, gva);
@@ -99,7 +123,7 @@ static void test_sync_vmsa(uint32_t policy)
 	    : "ymm4", "st", "st(1)", "st(2)", "st(3)", "st(4)", "st(5)", "st(6)", "st(7)");
 	vcpu_xsave_set(vcpu, &xsave);
 
-	vm_sev_launch(vm, SEV_POLICY_ES | policy, NULL);
+	vm_sev_launch(vm, policy, NULL);
 
 	/* This page is shared, so make it decrypted.  */
 	memset(hva, 0, 4096);
@@ -118,14 +142,12 @@ static void test_sync_vmsa(uint32_t policy)
 	kvm_vm_free(vm);
 }
 
-static void test_sev(void *guest_code, uint64_t policy)
+static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	uint32_t type = policy & SEV_POLICY_ES ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
-
 	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
 
 	/* TODO: Validate the measurement is as expected. */
@@ -134,7 +156,7 @@ static void test_sev(void *guest_code, uint64_t policy)
 	for (;;) {
 		vcpu_run(vcpu);
 
-		if (policy & SEV_POLICY_ES) {
+		if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
 			TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
 				    "Wanted SYSTEM_EVENT, got %s",
 				    exit_reason_str(vcpu->run->exit_reason));
@@ -188,19 +210,38 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
-	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
-	test_sev(guest_sev_code, 0);
+	test_sev(guest_sev_code, KVM_X86_SEV_VM, SEV_POLICY_NO_DBG);
+	test_sev(guest_sev_code, KVM_X86_SEV_VM, 0);
 
 	if (kvm_cpu_has(X86_FEATURE_SEV_ES)) {
-		test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
-		test_sev(guest_sev_es_code, SEV_POLICY_ES);
+		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
+		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
 		test_sev_es_shutdown();
 
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
 		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
-			test_sync_vmsa(0);
-			test_sync_vmsa(SEV_POLICY_NO_DBG);
+			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
+		}
+	}
+
+	if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
+		unsigned long snp_policy = SNP_POLICY;
+
+		if (unlikely(!is_smt_active()))
+			snp_policy &= ~SNP_POLICY_SMT;
+
+		test_sev(guest_snp_code, KVM_X86_SNP_VM, snp_policy);
+		/* Test minimum firmware level */
+		test_sev(guest_snp_code, KVM_X86_SNP_VM,
+			 snp_policy |
+			 SNP_FW_VER_MAJOR(SNP_FW_REQ_VER_MAJOR) |
+			 SNP_FW_VER_MINOR(SNP_FW_REQ_VER_MINOR));
+
+		if (kvm_has_cap(KVM_CAP_XCRS) &&
+		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
+			test_sync_vmsa(KVM_X86_SNP_VM, snp_policy);
 		}
 	}
 
-- 
2.34.1


