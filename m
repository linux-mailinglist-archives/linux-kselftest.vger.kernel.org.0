Return-Path: <linux-kselftest+bounces-25610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AEEA266B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB0D161DEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA320211479;
	Mon,  3 Feb 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wgQaf2za"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF58211471;
	Mon,  3 Feb 2025 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622010; cv=fail; b=BQFuvUqNG0frzRn7/xh4s9Sy+eWc8KjRii/DmLX1e5bOeaVJZoOvaZEkGPHgbQboSV7EBBYLWrm1fLDMl+v7aNsbCop5Sll8ZC23eCQwEP1pY8pxN2cTa1MhNNbsAk8t8SdytF91yeeKY3J4vdUi1UnvpLM8ElxdaSdlyY4mWtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622010; c=relaxed/simple;
	bh=aI/XFdPV8tR1zsYy3w3XWHy1nZWjMMWjUpzn7DEhq6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/32CfmeU60GUTR2lXnqRcyXwWMZKmWn7o5noFBvTGePS1rredTwlhtFUf0YSg65CpYVzNUc5fIF0NPjF7BPPCQenRMt6tNwSygrgyYqSElFgKJjWS2aAOI7UG05dHwB9dmF7clmtwZyjMoENGAYNC4kLwCNgnu2cGNwdvstMLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wgQaf2za; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv+x9FDgoKzI4Dbw12Je0Bml0fWeexCZVD1pXbsi7jgAHeCErvlmcFL8kv8uFiqB1sD/7m7+1aQ1Qc0Rt9b2Bj05INuDggNCU7PIbYMfGKJ/ktLTTPaChixQxLdk6KeepVpltAJM55XyPx1zgrG0+MJI332etpM+t1Zdo8Et4xxZn2QmgRLHfuf20NelepODmLBll9adM9zqzUkZSJgU3SyC1080tbj03jlJmXTwVKvDCrrsSUP0nH7JJD+fWVxmFZtzxEXQJca5dNqgWqsZZx5/iMirVV7/ou8N9LCuI7/gqKyJNkWC8IOsljPHMpMU4or4OjitVrI7zuy3qq5TBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB+m17vZRaIn9rhyDe8cjTnD1OxYa+bgZE1uuh+UL9M=;
 b=CSy2pE8luUZj0hj6+dnB2T+x+4pRsG/ZB3b7B+AOZVB0OzD065oNSWgzJAXbEBflixklrOtNA1RwS7OIBNTMSErozJsdZ/SOxJNLV70Q+bzdSNLeCntrLR2W/zfsDtuVTNN7DA+YirA6AybX5dwB9f15jVpL+q+j/nbqvBnB4e0Bm4CIgkXVr9+LtgkFI3op5W97TMholkjoErhlL3qrVtkawuwCk5aTgrpReNttfGib+H5OE2rkXbBMdNFZP5WnQBU8Jd9SoxHTjVIw6ex1BCoojITbJhXMm0lTONImNDlGvopCdbGNk0EA6NpVJJXPNH4/B9cOe3nHeInBkShP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB+m17vZRaIn9rhyDe8cjTnD1OxYa+bgZE1uuh+UL9M=;
 b=wgQaf2zaRk8g4gpQMkkD6//0JkUJP8KzEOVgtf+zpnLQXCDImhZjLXu2TeuQ0yzof7fQYJ9O9FXMaMQOF6h0kuKVmb62qc76GpNx1fNrHouok7RjE1/nBTLx5DmPcobwnN5uoeCVMeQGPzOVxg4Y6A3KH5Tnv7YliJ2v+aOUWIo=
Received: from SA1P222CA0130.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::21)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 22:33:26 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::9b) by SA1P222CA0130.outlook.office365.com
 (2603:10b6:806:3c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 22:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:33:25 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:33:24 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 5/9] KVM: selftests: Introduce SEV VM type check
Date: Mon, 3 Feb 2025 16:32:01 -0600
Message-ID: <20250203223205.36121-6-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203223205.36121-1-prsampat@amd.com>
References: <20250203223205.36121-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e738582-04af-465c-bab9-08dd44a2c657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmKQNP81LGgYbtbpCzGCEfufVtQ+cULd4vIcWV7RIG5+kPXGqPUg5uwBDvhU?=
 =?us-ascii?Q?Lw9LAG78g32bn8ObuUjcSl4hdXtYLN8TOAwMHZS0PWBgm4r2GZZ573n3lES/?=
 =?us-ascii?Q?NbCQBGIjBmKY49xVmtACz+7yie1TAUhdW+x4gtnMIF/HGxhymYC9/+kGcvA3?=
 =?us-ascii?Q?H/MQRJ9o5J/QHsjLa3ZbFXml3lgaTtiEyGcX93Wk87TwKObXyy962Rim9XDr?=
 =?us-ascii?Q?W29571HKT8mejtb+psYUolSnbuKbhUIEO+B5gi1l5ZfV08ofj68EC2BrpYa6?=
 =?us-ascii?Q?dF7SjJXv8m2Az/JLWK3ONkYWx1zNIr9LUep7joXYnKARsOIuIRtyOT0IiNl5?=
 =?us-ascii?Q?jvElTG3ebnGmPpbwDG7ntgpW/O1ZEkDn24e4a5R2EpLZ5VRdMM29SN65d5Nv?=
 =?us-ascii?Q?uf6kbeKJ69CA4WHxvaqB+Ek1QN7aDqWgf5kgx8rOiYs0oev/UqffOvU9lgPw?=
 =?us-ascii?Q?3xAoFigEPXBWsbElYjRf9fSjYXECHCEC7EtNoGZfps+gJ+Z2kNROvG1Ty8dU?=
 =?us-ascii?Q?8pzSPLrW2/7Sz2TZc5VLcXQrfwua04hzxLIGu+h4Mor3wfrO+x/47FqVvqOz?=
 =?us-ascii?Q?R32ERnYSDfxXXuZDGA7IrGCAF1+/5s6f4t8GYvyUM8MeijYtyJKK5LDocJYb?=
 =?us-ascii?Q?Ecgdvi972l4jwLcRchMrW1DuR6k2kkF7y2WyjaBI/3rAkxsEYhNH8zAPQtTb?=
 =?us-ascii?Q?7DSrAO4PSELtcNKGd7Pr5CiMzu1rdubp3/sDpRtuJLisnI5OFBWznnzROgb9?=
 =?us-ascii?Q?84C8E4Q1/nu3o0PN8nFdeRs8BUuo06tmfmGWJocrMi//6igsHPFeuGTua+WA?=
 =?us-ascii?Q?//rv5DxL4180vvN3Rxc1aMleQg/rX9Uvkw0zUT/ahQCPQP1myUBLckLQJNLs?=
 =?us-ascii?Q?S04NFcfmU+nNpPs6dd1monOPaouzO4XPuYNc9L6/6Qy/w76jW/sbTyI+bFZA?=
 =?us-ascii?Q?2ZvxmDCIdLeZQ2DHqfe4PhObW1osdML/7eO71mJjId9JzTipCG8tJFPyH1Lj?=
 =?us-ascii?Q?2ckYnC3T321nK/LME5o5Iaf3A8LY7ZUjRNouQFIeR5k82Rz9rENnbt02xPN6?=
 =?us-ascii?Q?Dz1iuYe8CQU3hiVPymfobJEg/34FgyFa+7JmEvm+ADU9ksXmHj8sr3rgLM4J?=
 =?us-ascii?Q?fGR6W8qRXPHxq9J/cKWAlW+PYQpN4U5pt6LZoA+dDk7VJmP7E6qnTCrP1z9G?=
 =?us-ascii?Q?+irfQh1GbYGrw4T2HfQTuICEEHyIx1U1fmbFAvr0lMN0cHJo9kw2u0ILhBlS?=
 =?us-ascii?Q?I+PrNE20Vt1naljkdpcbrrzPRgnSrHlqrHD9wG24mZIK6X+7xMiZhCudt93T?=
 =?us-ascii?Q?E9ZrYKyIQWZxCPD6wesMyBPi552saQj15HOkKHLfUnmA+QUGfUXJAiuQcZfJ?=
 =?us-ascii?Q?S5wbHzmn6UJRDCIaPY1XmQjnuwTvBBGj+9G2AJDS8GproR3DcFyorshbwtuW?=
 =?us-ascii?Q?+DKg7nDRaXAOzafhZsFv6TGlV71SlcD7ISdOe4Q7ZzJ/nS1s71RLpN1i6E/r?=
 =?us-ascii?Q?0trzXrico9vIl7A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:33:25.8726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e738582-04af-465c-bab9-08dd44a2c657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

In preparation for SNP, declutter the vm type check by introducing a
SEV-SNP VM type check as well as a transitive set of helper functions.

The SNP VM type is the subset of SEV-ES. Similarly, the SEV-ES and SNP
types are subset of the SEV VM type check.

Tested-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v5..v6:

* Commit message grammar
* Collected tags from Srikanth.
---
 tools/testing/selftests/kvm/include/x86/sev.h   |  4 ++++
 tools/testing/selftests/kvm/lib/x86/processor.c |  4 ++--
 tools/testing/selftests/kvm/lib/x86/sev.c       | 17 +++++++++++++++++
 .../testing/selftests/kvm/x86/sev_smoke_test.c  |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index e7df5d0987f6..faed91435963 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -29,6 +29,10 @@ enum sev_guest_state {
 
 #define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
 
+bool is_sev_vm(struct kvm_vm *vm);
+bool is_sev_es_vm(struct kvm_vm *vm);
+bool is_sev_snp_vm(struct kvm_vm *vm);
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index bd5a802fa7a5..a92dc1dad085 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -639,7 +639,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (is_sev_vm(vm)) {
 		struct kvm_sev_init init = { 0 };
 
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
@@ -1156,7 +1156,7 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (is_sev_vm(vm)) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index e9535ee20b7f..280ec42e281b 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -4,6 +4,23 @@
 
 #include "sev.h"
 
+bool is_sev_snp_vm(struct kvm_vm *vm)
+{
+	return vm->type == KVM_X86_SNP_VM;
+}
+
+/* A SNP VM is also a SEV-ES VM */
+bool is_sev_es_vm(struct kvm_vm *vm)
+{
+	return is_sev_snp_vm(vm) || vm->type == KVM_X86_SEV_ES_VM;
+}
+
+/* A SEV-ES and SNP VM is also a SEV VM */
+bool is_sev_vm(struct kvm_vm *vm)
+{
+	return is_sev_es_vm(vm) || vm->type == KVM_X86_SEV_VM;
+}
+
 /*
  * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and the
  * -1 would then cause an underflow back to 2**64 - 1. This is expected and
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 38f647fe55d2..b18c78314d5b 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -123,7 +123,7 @@ static void test_sev(void *guest_code, uint64_t policy)
 	for (;;) {
 		vcpu_run(vcpu);
 
-		if (policy & SEV_POLICY_ES) {
+		if (is_sev_es_vm(vm)) {
 			TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
 				    "Wanted SYSTEM_EVENT, got %s",
 				    exit_reason_str(vcpu->run->exit_reason));
-- 
2.43.0


