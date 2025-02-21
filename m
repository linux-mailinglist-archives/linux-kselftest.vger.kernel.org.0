Return-Path: <linux-kselftest+bounces-27231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F2A401A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275AF166E1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C8255E2E;
	Fri, 21 Feb 2025 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b+fjETR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37C254AEC;
	Fri, 21 Feb 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171832; cv=fail; b=aSQtt3mfmXyNwtg6BzQ1omvsmb7hYexWME7+xKYiPW5b1u+JA0HRDh1mAAplgX+d7GwRz66yyk9pt6jd6Z50BAUk5qS+GRUsc5wRHvMojuZAZQu2zsaEBBIJUoMiUVPbpIIx4PZ09gw3gB69P40ogS0P4puA55yFnuEFOi9P39M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171832; c=relaxed/simple;
	bh=xGcpi5tbLFDS4wxp0mjwRAbkOwyGX0GxsaVvG2TeTRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6NhjM6zwHbT76MPWff0OcBAurO68KzDg55nimRG9jVBeN454CILnQrFz165HC3FLP+lfU/s90G7I2aDLtbVTHBbVxT2p69LeLS5bJGp6zHEyYOgEdq7/8T9slDhgk7Wma8s01NgP5gfs//c5PE7FhhGhvE5EYYvuzNgXPHnQD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b+fjETR2; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO/uaIA5lLH5FhjHI8OmDp4HmX+CKl+oQh0dSKMsNhg54JC2EGgyG18c6UlVNf7QW5vBEmzWaePnxo854BLAu/t+mt/UDi5rm7IRvt3EJ4NzKwHOsEg43ojVuC6TB0MzjdnZYR4FmSDaufVqW40oPjfd5pyAVUq0yI0JBINyAW302kHVOcgR23lQf2T9QNMdQQp3I89bSSbqe4sll/8uEquQFCiJqtajmOZ6CzGcJJOdEGvefge+TndDtmtHbZbMi3kMpuUo2QCcDTX2ZT/AeDVDZIRokDxGee2qyxh95Q5fYtagIE3fzZLLCGJrg/JxOiGh2eKh8N4PtaCEFY8omA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQxc+7jdVdapNoCcckmAYhwqXgpkxLvFaO/j5Y9an0M=;
 b=dmHXiTPCgNmBqQaC86VyfqKjCKsqH/HsXu3+iMKIQByt9eQnK63xu3RWNP4o6qPyJi1dMmUnXJOUFD+CblwUBstM4ekQrKU0RcljFZFKGTHEQFj1RK33KHd/tgL4S9zv8NYFsc5OvvEsvRocuaykOg7kg+4WC9LOgvutxNK5DpN6PJFbInoxYRIkNVPgTeDZX1gyMlrFEO6QoXsw82aB1OHEg90Z6oQwMeH0kNMDlRaEMrD9DwfTcWxCMnAggKXVDGnloBJEhIihgKBjSL3uX6w3T22kQrwDpBzrm/2qoBmsz4CCokGkyQ4kiKud8YuVZ5OhZnvrYdP98J20kGB4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQxc+7jdVdapNoCcckmAYhwqXgpkxLvFaO/j5Y9an0M=;
 b=b+fjETR2SaEAHYZOHyG47YNs5Qqnl+2+Y+BYMmJA+g9azqwhdD+8/nGSLQpIw2NFW5/mTaP1s/OYtXsvquxfwJw1MgguxT8zOHWYKYRDiPlFdGDVE/SGRBIZcOBbYapTDJCIWpGlRauV8M/7UJa0JSH4Y+Q27Djl7cBqL7l8e08=
Received: from BN9PR03CA0841.namprd03.prod.outlook.com (2603:10b6:408:13d::6)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 21:03:45 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::9c) by BN9PR03CA0841.outlook.office365.com
 (2603:10b6:408:13d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 21:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:03:45 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:03:43 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 07/10] KVM: selftests: Add library support for interacting with SNP
Date: Fri, 21 Feb 2025 15:01:57 -0600
Message-ID: <20250221210200.244405-8-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f489aba-b9b5-4232-e340-08dd52bb3acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xEE0ZYFOyx9LZu5toqI9qAFNJQP14jIkRQCnfU0cwmaETW/Zi2ztzOvcmZhL?=
 =?us-ascii?Q?Szjds6uEzh/4cSnY7AiEiGL2BItVzgTeI7mvp4fzxfazELgrw4xqNm3rOkPc?=
 =?us-ascii?Q?cegi2gVnEKf4VZcmhifP88g0dAw+Ehead58PTE+v6uorwTtgvQ3on65xgK4J?=
 =?us-ascii?Q?sCY5LTO6NfnIzhApNxUcnfp27br/kvmLiwBlP0VQQ8mRVlkTGQAOgcHXEYc4?=
 =?us-ascii?Q?KSQSJWV7P6hApo/b28YtKzKU+Aa1lA2e5G2YIqfCuL9DtwAouFODIB3mrG9B?=
 =?us-ascii?Q?9gLO73YSBXqQoSnsESfLdgqXNSbuWrCdYrwxgqNOuDWKRsC7DyhDYFIOJ7hC?=
 =?us-ascii?Q?TUMfMttIOeiY3KOiA5kyleL1qddPhRnWG6/6Dy/MTD12pBsBFfpYwWhgJDM5?=
 =?us-ascii?Q?Dl/sPTTxHnC3aBFLtJ2RpchDnY8uscFf9rHJICJm9JaNuoBLC4IRc+94YXQP?=
 =?us-ascii?Q?gt7opjwQ+rH0WwRVVRYfriKj8cRjXbc7rALsqwp4R6RLDDuz0zBfHNHweYvH?=
 =?us-ascii?Q?CQ+RqzRuguVBzkai1njWI4PCnI1klB0YrkgiA0aXKgZYM1eeEZX2gKwofJV/?=
 =?us-ascii?Q?Ct+ny71mYiUhOCPJOduA9sE/pwBD31Q6ugr+CjLI0Vu1Yxj7utEdUWHKi1RV?=
 =?us-ascii?Q?72N4LyxhRF9xFHgKEjYPpbgE/n5cQFFyDpZkJwdi2dMpLU3VaZwQqmlbCE5P?=
 =?us-ascii?Q?OpFgkSt/eKKuRIZbbS3extM+P/ZVc6HmUQXfcKnUcSnWb5rbVAIZR8iLBVUp?=
 =?us-ascii?Q?kWzh4yh13oApW9wpbZhxt6Nkv7Na4ga7jwl1PbYTMwfE/A+RoHJ0KTdCbkE9?=
 =?us-ascii?Q?vWXn0BrkkV1Q1LGhpH5riFBUXXgDzg7Ci3EYckfJP0kgEW63W8eHFNE1nuiZ?=
 =?us-ascii?Q?ZJpxjMBAWoQNpel7aBxvuyKUqFp8D8bYMfgjMwfM4XJErMfAWbeP9as3FLsO?=
 =?us-ascii?Q?ta5d1LOTDgU0eFGi1gyZa01wiRNgHVuMBS6XLvwe3bgT763VcDjG29Qu55Oz?=
 =?us-ascii?Q?iBlOC8Ezr654WYOVMFKKnl+7PtxRaEtLgb0XpURnRoOR9UY8HIxZf61MLkgG?=
 =?us-ascii?Q?OC47ErcvwNgFaLeByymMVV72DdBF9GBNDiU2yZ3WtnLl6mdu2lYJ5dvcThkB?=
 =?us-ascii?Q?s+vxarVQPXZzBk6eKWpjk3Ys37CGeiBpFtngq2lqhhlJAnj9GZdahjtOKOoZ?=
 =?us-ascii?Q?bpd7kLJEM7nxuJmwHG7N7QkM6Xw+z4VEBj+x4mYgAvvlX9eyCm5FJKziTCX+?=
 =?us-ascii?Q?S+ZZERTr9gmh1pBnkS1o1uIRHb3A+LBaNjuN7TeYM8bu+6xhfrs2IfTF7lq/?=
 =?us-ascii?Q?Eue2hGBbdi5AtaG65W98h/a1Uf9r0Mza5qpRLWpXlUYXsGGQ6xkTH5s7vk3E?=
 =?us-ascii?Q?lzrkqzdxO0UrizS07ENfXpRTQ9BgxuVHsEK7O1JSTNp8nPMJfb+2J+NWUOZW?=
 =?us-ascii?Q?btzR/+ThGzPnoEhyQ7pcIb1K5bk+DsSNib3V7jK9CcHY5/LIsU44B+BrM4jV?=
 =?us-ascii?Q?t682zxLF44PkTpg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:03:45.4630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f489aba-b9b5-4232-e340-08dd52bb3acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

Extend the SEV library to include support for SNP ioctl() wrappers,
which aid in launching and interacting with a SEV-SNP guest.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* Remove FW version macros (Sean)
* Define a new type KVM_SEV_PAGE_TYPE_INVALID so that encrypt_region
  called using the SEV path does not have to pass a literal (Sean)
* Replace assert() within snp_vm_init() to TEST_ASSERT_EQ() (Sean)
* As SNP currently uses privatization and encryption of a region in
  tandem, remove privatize_region() and include it's functionality
  within encrypt_region() by adding a parameter (Sean)
* Minor cleanup of code braces (Sean)
---
 arch/x86/include/uapi/asm/kvm.h               |  1 +
 tools/arch/x86/include/uapi/asm/kvm.h         |  1 +
 tools/testing/selftests/kvm/include/x86/sev.h | 33 ++++++++-
 tools/testing/selftests/kvm/lib/x86/sev.c     | 68 +++++++++++++++++--
 4 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 9e75da97bce0..565e4d054627 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -841,6 +841,7 @@ struct kvm_sev_snp_launch_start {
 };
 
 /* Kept in sync with firmware values for simplicity. */
+#define KVM_SEV_PAGE_TYPE_INVALID		0x0
 #define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
 #define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
 #define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 88585c1de416..17e44fbdc2a7 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -841,6 +841,7 @@ struct kvm_sev_snp_launch_start {
 };
 
 /* Kept in sync with firmware values for simplicity. */
+#define KVM_SEV_PAGE_TYPE_INVALID		0x0
 #define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
 #define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
 #define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index b112f7664534..c696d10f9332 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -25,6 +25,10 @@ enum sev_guest_state {
 #define SEV_POLICY_NO_DBG	(1UL << 0)
 #define SEV_POLICY_ES		(1UL << 2)
 
+#define SNP_POLICY_SMT		(1ULL << 16)
+#define SNP_POLICY_RSVD_MBO	(1ULL << 17)
+#define SNP_POLICY_DBG		(1ULL << 19)
+
 #define GHCB_MSR_TERM_REQ	0x100
 
 bool is_sev_vm(struct kvm_vm *vm);
@@ -34,13 +38,26 @@ bool is_sev_snp_vm(struct kvm_vm *vm);
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
+void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy);
+void snp_vm_launch_update(struct kvm_vm *vm);
+void snp_vm_launch_finish(struct kvm_vm *vm);
 
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
-void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement);
+void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement);
 
 kvm_static_assert(SEV_RET_SUCCESS == 0);
 
+/*
+ * A SEV-SNP VM requires the policy reserved bit to always be set.
+ * The SMT policy bit is also required to be set based on SMT being
+ * available and active on the system.
+ */
+static inline u64 snp_default_policy(void)
+{
+	return SNP_POLICY_RSVD_MBO | (smt_on() ? SNP_POLICY_SMT : 0);
+}
+
 /*
  * The KVM_MEMORY_ENCRYPT_OP uAPI is utter garbage and takes an "unsigned long"
  * instead of a proper struct.  The size of the parameter is embedded in the
@@ -74,6 +91,7 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
 
 void sev_vm_init(struct kvm_vm *vm);
 void sev_es_vm_init(struct kvm_vm *vm);
+void snp_vm_init(struct kvm_vm *vm);
 
 static inline void vmgexit(void)
 {
@@ -102,4 +120,17 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
 }
 
+static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					  uint64_t hva, uint64_t size, uint8_t type)
+{
+	struct kvm_sev_snp_launch_update update_data = {
+		.uaddr = hva,
+		.gfn_start = gpa >> PAGE_SHIFT,
+		.len = size,
+		.type = type,
+	};
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
+}
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 4587f2b6bc39..a56f5164b0a6 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -31,7 +31,8 @@ bool is_sev_vm(struct kvm_vm *vm)
  * and find the first range, but that's correct because the condition
  * expression would cause us to quit the loop.
  */
-static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
+static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
+			   uint8_t page_type, bool private)
 {
 	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
 	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
@@ -41,13 +42,23 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 	if (!sparsebit_any_set(protected_phy_pages))
 		return;
 
-	sev_register_encrypted_memory(vm, region);
+	if (!is_sev_snp_vm(vm))
+		sev_register_encrypted_memory(vm, region);
 
 	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
-		sev_launch_update_data(vm, gpa_base + offset, size);
+		if (private)
+			vm_mem_set_private(vm, gpa_base + offset, size);
+
+		if (is_sev_snp_vm(vm))
+			snp_launch_update_data(vm, gpa_base + offset,
+					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
+					       size, page_type);
+		else
+			sev_launch_update_data(vm, gpa_base + offset, size);
+
 	}
 }
 
@@ -77,6 +88,14 @@ void sev_es_vm_init(struct kvm_vm *vm)
 	}
 }
 
+void snp_vm_init(struct kvm_vm *vm)
+{
+	struct kvm_sev_init init = { 0 };
+
+	TEST_ASSERT_EQ(vm->type, KVM_X86_SNP_VM);
+	vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
+}
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
@@ -93,7 +112,7 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
 
 	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
-		encrypt_region(vm, region);
+		encrypt_region(vm, region, KVM_SEV_PAGE_TYPE_INVALID, false);
 
 	if (policy & SEV_POLICY_ES)
 		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
@@ -129,6 +148,33 @@ void sev_vm_launch_finish(struct kvm_vm *vm)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
 }
 
+void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy)
+{
+	struct kvm_sev_snp_launch_start launch_start = {
+		.policy = policy,
+	};
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_START, &launch_start);
+}
+
+void snp_vm_launch_update(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
+	int ctr;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
+		encrypt_region(vm, region, KVM_SEV_SNP_PAGE_TYPE_NORMAL, true);
+
+	vm->arch.is_pt_protected = true;
+}
+
+void snp_vm_launch_finish(struct kvm_vm *vm)
+{
+	struct kvm_sev_snp_launch_finish launch_finish = { 0 };
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
+}
+
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu)
 {
@@ -145,8 +191,20 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 	return vm;
 }
 
-void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement)
+void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
+	if (is_sev_snp_vm(vm)) {
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
 	sev_vm_launch(vm, policy);
 
 	if (!measurement)
-- 
2.43.0


