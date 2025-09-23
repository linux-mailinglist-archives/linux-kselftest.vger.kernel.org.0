Return-Path: <linux-kselftest+bounces-42118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C5B945F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4825E4408C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6C30DEA7;
	Tue, 23 Sep 2025 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OCO6sNRS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86991A3142;
	Tue, 23 Sep 2025 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604693; cv=fail; b=liyXaai6g1NuJCiHhHD0fHWS9eNQVfl23/Fx1i9hmvyJSkl4u2bkLc211ZLxfqxFkBTOSJRoLg5trkwMjJ1uRguZFOnKGcmhzUwObkiiotF59iUSeqP6RiM+s94rU3g0eM7UufDwTmusFLSc4aEWicJ6esXInrNy22e2ZfZnhW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604693; c=relaxed/simple;
	bh=KX+QENdWtr3ZV6Mkoh/DNY6C+y9GE0Q9ijz0elMvtjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgoWuL1P3uqemoTOioMILmJcWjPINoTYphFh3g1+L4l/P2OF3fJ9e5V68VGePSF0s8UkVCEj8NBuB17UYGbQtTnaw8YqVZq2SiV17y3EgmaQHEfWaPNyJBq9O6ZoIBJN5T4kA/+3Bcum+qLKXscxQQ3Vf/Dk01YEBL8aa/aj/lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OCO6sNRS; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRLyXXtlAIxYcdehVb64N4jk1w0r8uLc7m4xHoI6PiLXKsljCfgrJpqNHKTumyrdPZuWNIna/MRX0RQEDzaMB5pIGYCp4wwJkw85ZyGi8DW35CWe20l5dvaw/eyL2NVfPfCTZX2PecY8BH8zlkTb/TFKpbWyVi0u9oAzJRtnmguEjYlENMLnf1DrRbGuApMv0S2EW7NPh/I4/QfRGm6EMT/8olZ6Tdrfv5FsrQGJVO8KgOoJ1aePGSBdIhCE1yKSXWXftGu1N3HtreTTdTJ0Qu/ln4rm9i9b+hcWwcNU8zkY2gsPDTIzsyjRL3LLvs+5FC4uO1BwFAb1Qrn0pToJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBZG+hxak/+fUz0yvuwL273kO42JHHc7TBl1uKbEjVg=;
 b=PcGhjZRiQBY+qMxpF3jXX/vezbxWE1+691d1487G2z8+YCI+wZvTY5C/SAL0qRiiW8S/hR8YJhy0iYANkY+vfUQio/iivaK3l//DV4aEl7zKlIMs9yngwsYkPXvPx3gtClZzn06i4w28n57RwPoveNm/czqO4fLPZTm1eHMkabaOkqqw0U4FidoV303BshydMtW9fE52wvH8RdNXjKbSG7c9VfMA1kSWLaS03ictFSFX6JGqpAesw1+JZVc+ocDcrJR65KWygQn7+dmw9H1N9+CervINss/ZLh7Jqt4YZwMQRU3KvESPx1Z3nK5n5hT//5ygPAqQlgsaqMH+8LqAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBZG+hxak/+fUz0yvuwL273kO42JHHc7TBl1uKbEjVg=;
 b=OCO6sNRS2YrrL/ipebvNxUMgmIuMclbMFihBf8n3eWyxL7JLgp7QD2ZNzgrFfstzZuzGfwQttbvQMuneGFD728CfQ51yZnOBmhSknfcDvR+HdJoYYyN7k6VRzBfBerRbudG8D5uvmVCIRWb0Xj25DOYMeF+/Dz2ky37daJrUW7s=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Tue, 23 Sep
 2025 05:18:04 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::16) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:18:04 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:17:49 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 27/35] KVM: selftests: Add args parameter to kvm_arch_vm_post_create()
Date: Tue, 23 Sep 2025 10:39:34 +0530
Message-ID: <20250923050942.206116-28-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 870b6b0d-444b-4425-ce66-08ddfa6092fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zs0lPR0bsp//EnadEoRfOY7O8+8X0XdU3l7vlzwQg22WCxbHhkYbIdYUe8nu?=
 =?us-ascii?Q?UUQD6vejk8O3LUrPk03zc5Yvj5uoVJZ38gfFsD6PG5TTse7GehnC6OFQDmdD?=
 =?us-ascii?Q?kbXIhEmXBztZL4xjMnbMknYdoG3lkF7F+NsvoiOWaiq3hjvhpvaVsTjZyaU4?=
 =?us-ascii?Q?5zVxuLblfIBDWDmM/tkN3GTNqlRyqpxHaC5+Bh+Pl7YOyjdN2SByDVJvpdmw?=
 =?us-ascii?Q?ok+QBr4kmG5yrdMXMxNtadJxHi4VXobbr57uOyz1xthSJ9hBO1NPu2mHN6P1?=
 =?us-ascii?Q?cAqd+EM62DofVpThaOSFz4jVS4jg50Ix2uKHr0NO+Z8JNZ5p527K4mF0lAXY?=
 =?us-ascii?Q?M3sGZTnurBN8zAEsIXakHGom7AGwRo8hw4sQABZ6Qv/7mhunBwcBxC+9USNo?=
 =?us-ascii?Q?2PDLko/YfJu55DbHH1gkfuNKdfwMDChsdQ2NT4OjEEdhxC5SmnkJQX5wCJZx?=
 =?us-ascii?Q?PHp6AaD5ynxUUl1QlmHzc6v/SjQQi9awja0u0/Zy7fgun/dCfaQE5/OiXSOq?=
 =?us-ascii?Q?Q8fpJ6QOMJmaz4OwQzogqttT3OF4WJIrYD0CWzknjkiIwnr7YDsibm8WHNwU?=
 =?us-ascii?Q?wfiJ4o+gwpU/t4Jl8J0YSemE9z79EZ53laYeY7GUPM9jt+qGM7O6B9qleNml?=
 =?us-ascii?Q?x+kUxZ0zR5Os0/HGRSWRH1YSNFLOacQrMcMP99PpUeSJQTuzoRCwjQo41Jit?=
 =?us-ascii?Q?JnCS31ncPgiIrmLBC/5NKx8DjPCv0baFf0bFa654em9e9EjApBUupDvR4E3L?=
 =?us-ascii?Q?Y18Di2KzBz1GUtJrzGrl6fAIo+mTo+MTVRvX+3hYVUBQReoaFXZEd1sgA8B/?=
 =?us-ascii?Q?dZJfWTxqlfJWXlU78Jvzy0+O7rETG9dEKPtAVLnQUxk6qixy/VIuDc+eaXu2?=
 =?us-ascii?Q?poTwqeoUA6XkCddOBkw111YPJwNNQrkH/oe4kyJOxiMgXFe63QLLsPxrDc+p?=
 =?us-ascii?Q?8V3iB2ZmdVEgQc0/pmVojvFx2oyuXJADX+I+QWtIwU2DEXBAkQgcc4//cxZY?=
 =?us-ascii?Q?FwyjP2clA5d8d6dPt1HNFW1fnJP010yYyvwjLlOZY9C86M2EXWL0JhVtLnEQ?=
 =?us-ascii?Q?KZL33nPelhiM1Vr6iG3igEKuy7To2obs/FAQawYKoezW8hlnDrzYicKClUaT?=
 =?us-ascii?Q?F22uQp5CVhKUtwlFT1xRPyq7iS36yDk7N8xgOr/+BlSqk/VS5BgP9dJ02fP9?=
 =?us-ascii?Q?KlSqh4uofDXPAy9fnHwtfKmWI4Pcj81gygD5+oUhEFvrORP4opB2wJmqn4ph?=
 =?us-ascii?Q?TGHiXkMdQgeGIB2nm8xRWA3IGE+Qap469b1zeCGxsk3TMEDFZLEpEnLokcKe?=
 =?us-ascii?Q?jJgiTAPeDNg8eZHCezjX2VEJAV6bhv0lUIK6lVNa7PouJSsFurPRK7NKEACc?=
 =?us-ascii?Q?614KpaKUWutwG+vkqx+5/3ZhFmVNrihOpSdj4Kz2NqGmvQ/LYE7MrMvYYBRb?=
 =?us-ascii?Q?aQ4kOPoRpVYbl4evVicW2lu40LzdnuyRGnYzGnuy/HP8Zyr3cDFRPvZ/GDy3?=
 =?us-ascii?Q?3FOEFbU9tIoWl9zA/HPHGQnMpG0+YTR3PG9f?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:18:04.4983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870b6b0d-444b-4425-ce66-08ddfa6092fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339

The kvm_arch_vm_post_create() hook allows for architecture-specific
setup to be performed immediately after a VM is created. However, it
currently lacks a mechanism to pass custom configuration data from
the test down to this setup phase.

This is a limitation for features that require non-default initialization.
For example, to test SEV-SNP with Secure AVIC (SAVIC), the desired VMSA
features must be configured via the KVM_SEV_INIT2 ioctl. This ioctl is
called within the x86 implementation of kvm_arch_vm_post_create(), but it
currently uses hardcoded default values.

To make this configurable, extend kvm_arch_vm_post_create() with a generic
"void *args" parameter. The x86 implementation of kvm_arch_vm_post_create()
now uses this argument to populate the "struct kvm_sev_init" for the
"KVM_SEV_INIT2" ioctl.

This refactoring makes the VM creation process more flexible and is a
prerequisite for adding selftests for Secure AVIC guests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../testing/selftests/kvm/arm64/set_id_regs.c |  2 +-
 .../testing/selftests/kvm/include/kvm_util.h  |  9 +++-
 tools/testing/selftests/kvm/include/x86/sev.h |  3 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 51 +++++++++++++------
 .../testing/selftests/kvm/lib/x86/processor.c |  6 ++-
 tools/testing/selftests/kvm/lib/x86/sev.c     | 13 +++--
 tools/testing/selftests/kvm/s390/cmma_test.c  |  2 +-
 7 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index d3bf9204409c..b732ee9efbed 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -749,7 +749,7 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	ksft_test_result_pass("%s\n", __func__);
 }
 
-void kvm_arch_vm_post_create(struct kvm_vm *vm)
+void kvm_arch_vm_post_create(struct kvm_vm *vm, void *args)
 {
 	if (vm_check_cap(vm, KVM_CAP_ARM_MTE)) {
 		vm_enable_cap(vm, KVM_CAP_ARM_MTE, 0);
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4a4f9621082d..e5f322994f44 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -992,6 +992,9 @@ static inline vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 struct kvm_vm *____vm_create(struct vm_shape shape);
 struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages);
+struct kvm_vm *__vm_create_with_args(struct vm_shape shape,
+		uint32_t nr_runnable_vcpus,  uint64_t nr_extra_pages,
+		void *args);
 
 static inline struct kvm_vm *vm_create_barebones(void)
 {
@@ -1016,6 +1019,10 @@ static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
 struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
 				      uint64_t extra_mem_pages,
 				      void *guest_code, struct kvm_vcpu *vcpus[]);
+struct kvm_vm *___vm_create_with_vcpus(struct vm_shape shape,
+				       uint32_t nr_vcpus, uint64_t extra_mem_pages,
+				       void *guest_code, struct kvm_vcpu *vcpus[],
+				       void *args);
 
 static inline struct kvm_vm *vm_create_with_vcpus(uint32_t nr_vcpus,
 						  void *guest_code,
@@ -1261,7 +1268,7 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
  */
 void kvm_selftest_arch_init(void);
 
-void kvm_arch_vm_post_create(struct kvm_vm *vm);
+void kvm_arch_vm_post_create(struct kvm_vm *vm, void *args);
 
 bool vm_is_gpa_protected(struct kvm_vm *vm, vm_paddr_t paddr);
 
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index d9794f5c2c16..73a23043d6c5 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -72,6 +72,9 @@ void snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy);
 void snp_vm_launch_update(struct kvm_vm *vm);
 void snp_vm_launch_finish(struct kvm_vm *vm);
 
+struct kvm_vm *_vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
+					   struct kvm_vcpu **cpu,
+					   void *init_args);
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 360f262f5f3f..23272f797f5f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -473,8 +473,8 @@ static bool is_guest_memfd_required(struct vm_shape shape)
 #endif
 }
 
-struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
-			   uint64_t nr_extra_pages)
+static struct kvm_vm *___vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
+			   uint64_t nr_extra_pages, void *args)
 {
 	uint64_t nr_pages = vm_nr_pages_required(shape, nr_runnable_vcpus,
 						 nr_extra_pages);
@@ -519,7 +519,37 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	guest_rng = new_guest_random_state(guest_random_seed);
 	sync_global_to_guest(vm, guest_rng);
 
-	kvm_arch_vm_post_create(vm);
+	kvm_arch_vm_post_create(vm, args);
+
+	return vm;
+}
+
+struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
+			   uint64_t nr_extra_pages)
+{
+	return ___vm_create(shape, nr_runnable_vcpus, nr_extra_pages, NULL);
+}
+
+struct kvm_vm *__vm_create_with_args(struct vm_shape shape, uint32_t nr_runnable_vcpus,
+			   uint64_t nr_extra_pages, void *args)
+{
+	return ___vm_create(shape, nr_runnable_vcpus, nr_extra_pages, args);
+}
+
+struct kvm_vm *___vm_create_with_vcpus(struct vm_shape shape,
+		uint32_t nr_vcpus, uint64_t extra_mem_pages,
+		void *guest_code, struct kvm_vcpu *vcpus[],
+		void *args)
+{
+	struct kvm_vm *vm;
+	int i;
+
+	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
+
+	vm = ___vm_create(shape, nr_vcpus, extra_mem_pages, args);
+
+	for (i = 0; i < nr_vcpus; ++i)
+		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
 
 	return vm;
 }
@@ -547,17 +577,8 @@ struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
 				      uint64_t extra_mem_pages,
 				      void *guest_code, struct kvm_vcpu *vcpus[])
 {
-	struct kvm_vm *vm;
-	int i;
-
-	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
-
-	vm = __vm_create(shape, nr_vcpus, extra_mem_pages);
-
-	for (i = 0; i < nr_vcpus; ++i)
-		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
-
-	return vm;
+	return ___vm_create_with_vcpus(shape, nr_vcpus, extra_mem_pages, guest_code,
+			vcpus, NULL);
 }
 
 struct kvm_vm *__vm_create_shape_with_one_vcpu(struct vm_shape shape,
@@ -2357,7 +2378,7 @@ void kvm_get_stat(struct kvm_binary_stats *stats, const char *name,
 	TEST_FAIL("Unable to find stat '%s'", name);
 }
 
-__weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
+__weak void kvm_arch_vm_post_create(struct kvm_vm *vm, void *args)
 {
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index a33a09a161d3..fc57b948c041 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -9,6 +9,7 @@
 #include "processor.h"
 #include "sev.h"
 #include "apic.h"
+#include "savic.h"
 
 #ifndef NUM_INTERRUPTS
 #define NUM_INTERRUPTS 256
@@ -631,7 +632,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 		REPORT_GUEST_ASSERT(uc);
 }
 
-void kvm_arch_vm_post_create(struct kvm_vm *vm)
+void kvm_arch_vm_post_create(struct kvm_vm *vm, void *sev_init_args)
 {
 	int r;
 
@@ -648,7 +649,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	if (is_sev_vm(vm)) {
 		struct kvm_sev_init init = { 0 };
 
-		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
+		vm_sev_ioctl(vm, KVM_SEV_INIT2, sev_init_args ?
+				(struct kvm_sev_init *)sev_init_args : &init);
 	}
 
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 113f33ca40b2..257988fce107 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -260,8 +260,9 @@ void snp_vm_launch_finish(struct kvm_vm *vm)
 	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
 }
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
-					   struct kvm_vcpu **cpu)
+struct kvm_vm *_vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
+					   struct kvm_vcpu **cpu,
+					   void *init_args)
 {
 	struct vm_shape shape = {
 		.mode = VM_MODE_DEFAULT,
@@ -270,7 +271,7 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 	struct kvm_vm *vm;
 	struct kvm_vcpu *cpus[1];
 
-	vm = __vm_create_with_vcpus(shape, 1, 0, guest_code, cpus);
+	vm = ___vm_create_with_vcpus(shape, 1, 0, guest_code, cpus, init_args);
 	*cpu = cpus[0];
 
 	return vm;
@@ -288,6 +289,12 @@ static bool is_savic_enabled(void)
 	return supported_vmsa_features & BIT_ULL(SVM_FEAT_SECURE_AVIC);
 }
 
+struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
+					   struct kvm_vcpu **cpu)
+{
+	return _vm_sev_create_with_one_vcpu(type, guest_code, cpu, NULL);
+}
+
 void vm_sev_launch(struct kvm_vm *vm, uint64_t policy, uint8_t *measurement)
 {
 	if (is_sev_es_vm(vm))
diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index 85cc8c18d6e7..0476dace3473 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -145,7 +145,7 @@ static void finish_vm_setup(struct kvm_vm *vm)
 	slot0 = memslot2region(vm, 0);
 	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
 
-	kvm_arch_vm_post_create(vm);
+	kvm_arch_vm_post_create(vm, NULL);
 }
 
 static struct kvm_vm *create_vm_two_memslots(void)
-- 
2.34.1


