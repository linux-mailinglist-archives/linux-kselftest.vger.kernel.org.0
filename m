Return-Path: <linux-kselftest+bounces-17226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16596D8EB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE241F29BA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195A419B3DD;
	Thu,  5 Sep 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zo5SWdz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85783CC1;
	Thu,  5 Sep 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540110; cv=fail; b=ZhFogYkd2+J8e6iEFWEofmcGOJ03cpjvbcnDIU5trwpyDjvP47h63O1Ax0kyAX4GlbhdtYGSr3KTfYpPeD1LI7lAwLDYX8kP6OVQsnpS2Q+s3QlQSyH3Gr6dYTKu12gKM9n7aqYR58FeUPY/OcrNnQ8TRN0fmEvEG6vMEuKRyp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540110; c=relaxed/simple;
	bh=lwKQJOS/wlPtuO4zvxF+tuuwuDLLNhd9UNBtZRJYly4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCVyRGTvQVZVMCqNtj/4AVQ6Ev8EIDvJo41WwC5s17Aw6JYQpxylovwP08ZKZapKfygJUgCS1ZLPXsMe9KmcXWCyv4mk7BzEmiPURfyx3zWshVMMc+DGkpL/lO+5YJs5Hv+uZ8AjKYJ5bTQLBqP/EbrFMs5yg3bmI8yPrk9YNWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zo5SWdz2; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUKA3roVeZf8SiZraBa5jBvKNoYhEqJvU+zyl2fv3r8KdCWPvvTaWXAvFY1kt/epBAtK1+bAPCzFnDh8r90vNRDo/V1sqby45IIU5EEIw85J/8+uFdQBJPVf0IF2cOvZ03F2HQ+UjH//E1CBgbnrxYAanhZpnY33cNTLXwyMacBFH1R5PYPNfLcPiwbBdlBESNxSOFsWtQ3MEHZLeGDrtQg7Tc7b4/LKqvI1K8s2UFSsY4+P2vxhfcojsnNIYm7kdLbrzhxXC8pDDQfrYWIuIqnaDsitGEDadbo8wh+Vr4yl5HN7D1IxjmmzWrhQ0/aYaA/Nb5Gty935hvYisXLkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwDofsI0PAkgDYTQheZedWUPjGprRJqHrsyZYKmJEzM=;
 b=ZL1wAivLpBOaC6zNIjdTmbLqYka6PmjZZ8aWy1Y8BCLqOhdf2GB9jQbE7ie3BCGuF1QjF01swxA3hKuCgUwK2aI9D8uYYLbtD1xSo/690qc4iOd2bubNtTYrxKFnE+VpaGehMmC93mPrsTrh7cd8QpSguik4gxCJmPOj+P8syIdpxYov+YRrr3pARzqp6T7lnrC+Tk2Zlcss5DqX6R4y6huoSnG8sUnib8uvHBcche52drH6CKHB+frfp9OGvclxjJBn19gfx+qY7fE8+RpAs56ELAfHLfYaB9ZuaXmEImXrkvu2tdB7D5fOkfBaCXEf/BfXtX8kfY71wyuOjskvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwDofsI0PAkgDYTQheZedWUPjGprRJqHrsyZYKmJEzM=;
 b=Zo5SWdz2AMsoMNQbFoVvdmbxYGqUDRWAoeQRT+5HKpudDjYsm0UBTnWOCAdeSYzU+bboabz8Hf7h72ypaWija3CSguvbX2DWQ5QvQ82o8hTJLnr2XsU0gpzog2cPlGtYYcRN/HCzeMyFNTRMraSGWEjYJk1OOA1F4Fr1XnEe47w=
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 12:41:44 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::4c) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 12:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:41:44 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:41:41 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
Date: Thu, 5 Sep 2024 07:41:00 -0500
Message-ID: <20240905124107.6954-3-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: ff69540b-7b72-46f8-5ac1-08dccda81981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UIeuPrmiLVyOzBq8MqtEiFtpfpqaoOlDsoR40/4WojgX6bthmFrf3Ik6+IZ6?=
 =?us-ascii?Q?bc+KRhaOu2n8RwjxvZhk0IVMQV+Tns5Dao/umQUJIfJ3vVePdDmrdmelVGuh?=
 =?us-ascii?Q?4ogis5Bb3WEqSLn1IP7WKPPQEdwByeZL8+p6NlDVCAcE1sdnzSXeymuvqtNn?=
 =?us-ascii?Q?QtST2h7UBVhOIZQd8gnk1SL6jllEmiHKPp9icR4ac5T53D9EX4gGXcaWBhOF?=
 =?us-ascii?Q?jpV5RUKqRBhgixdbtQgD5gi91OJdKVR0gDWlS3MM+k5QmoCMnxSBa+dklLKb?=
 =?us-ascii?Q?8XT5CXqj5trasgzclL8ETlNBCu6TALwWnqO/aHwko51HmOX4IXrDfaQAHZGz?=
 =?us-ascii?Q?jISv9Hqj+Ss43eCfa6pNVfU5BrdD+IdMlNTSfgQeZOGVt2F2gfyDDm2SCQT4?=
 =?us-ascii?Q?bAbZDtaX68B8dlQiCW7K8J3AgzFoAoqFKuHLUs1DIdiuxetXMDKOdCSeV1AK?=
 =?us-ascii?Q?tNSV8gvxadZUQgUHz5voBEa5ibL7NmBLjGYt9COkTrNaTIHmReEIh+zhU13N?=
 =?us-ascii?Q?vMHH9xBM68zZ7tW5WbvaNiy97qc3rIqfos9vDiHohuCYvjbUrTqnDEHG9Rj/?=
 =?us-ascii?Q?vPl/Cf+rImHOdMo9zGvcwXtQoUauCuTizLmompBUVs6Lk8GJlR4Xso1eSPp5?=
 =?us-ascii?Q?PgcePtx270z5Ztp1c125pKXRUl4U5NJD+b9ETBAvN2FapAvC85O53bZ59LXG?=
 =?us-ascii?Q?VGr0ZYPFLM5F81RXroCDNR4xdL+EFXJ6eF/J1NXrLYCywJJ+RHKuYvSf+pFB?=
 =?us-ascii?Q?vcV08B3nwvyv6Tt8B6ht5LvH1wyPL20f9RlGeCn+Cx4q0l/ixtnZGzgQrEF8?=
 =?us-ascii?Q?nXW9x5P213vEqYjxPwKDAznFZ8pqzLHgGHpBikGXyF11KyZ5tRGz4wjoUAzz?=
 =?us-ascii?Q?13D3H8jlJnrFtDrnVQeJUEA/6qX/Elk0V288anN42baZYhcMA9EhlLyEaHQ2?=
 =?us-ascii?Q?6I95fSJxI8NHXCljL+wr2Biyxks+eoHLpIDFm2S5Sbnms8kdz764h4EToEGq?=
 =?us-ascii?Q?vIc1NjTYvMox4oEAtkZrtFKg1F0JnMp2uDqNQkDNe9Me5SAcI5F0p/NaPQWU?=
 =?us-ascii?Q?wVGtc3km2Q1Y3HDAY9QyC5Ua1rGS/o6vqyoQ7Q5Y7n8gpFVYP00cAFeb/bb6?=
 =?us-ascii?Q?kz2KV+oRSxuZpvK+rgRq2akdaZxD5dPzaodrCLGfCInzv/wzpXmg6uVhVfep?=
 =?us-ascii?Q?TP/SDBMCc29gHydDJbrB8vOplnsvpm1B7okPHfh4aVEMKmZCXhYb+vhsZPNH?=
 =?us-ascii?Q?OeARBC8Y/RNhcT/lq/Y9BzTHU2KEifkN8VrBMccYIqnKfhEDzRdPBSD9EqCj?=
 =?us-ascii?Q?A8HZ+EHk7PYeNtbcFwZ0ERnI5zHU3Eg3BNI7HFujvLKdkdfPQA4GeqaYMNW3?=
 =?us-ascii?Q?6EdgHLT1vbMLUMzFrpWcxSSDUupukcTQTIs32Q90eO8krG4V8CJrNMWToTJ+?=
 =?us-ascii?Q?PVDXw3QuW7xf7HBvEWeq31cFS9FXtVNX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:41:44.4937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff69540b-7b72-46f8-5ac1-08dccda81981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910

Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
initializes and sets up private memory regions required to run a simple
SEV-SNP guest.

Similar to its SEV-ES smoke test counterpart, this also does not
support GHCB and ucall yet and uses the GHCB MSR protocol to trigger an
exit of the type KVM_EXIT_SYSTEM_EVENT.

Also, decouple policy and type and require functions to provide both
such that there is no assumption regarding the type using policy.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 .../selftests/kvm/include/x86_64/sev.h        |  54 +++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +-
 .../selftests/kvm/lib/x86_64/processor.c      |   6 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 116 +++++++++++++++++-
 .../selftests/kvm/x86_64/sev_smoke_test.c     |  67 ++++++++--
 6 files changed, 230 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e247f99e0473..1dfa2c03b40f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
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
index a2b7df5f1d39..bbf90ad224da 100644
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
index 974bcd2df6d7..981f3c9fd1cf 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -625,7 +625,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM ||
+	    vm->type == KVM_X86_SNP_VM) {
 		struct kvm_sev_init init = { 0 };
 
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
@@ -1134,7 +1135,8 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM ||
+	    vm->type == KVM_X86_SNP_VM) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 125a72246e09..ff3824564854 100644
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
index 2e9197eb1652..12d466915074 100644
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
@@ -194,19 +216,38 @@ int main(int argc, char *argv[])
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


