Return-Path: <linux-kselftest+bounces-6695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B04D88D5FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 06:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB1A1F26891
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 05:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBE717BAF;
	Wed, 27 Mar 2024 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tg/iRoW8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AA12B93;
	Wed, 27 Mar 2024 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518196; cv=fail; b=Sh00xa/LGyIIHVfh0Pa59ICq+PhPwrQAv7t71KINS9WmDPNJhm47v5glvBYrqHVRjfH5QM0JZEvvSIjszsJ3Aa05Ipvw968q108px70YslPYr8O0lgA6yLqKnfCfPi/1Sc5XwQb9nqhFZS9excWMdTDpW3XDDXbszxvBA/noNxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518196; c=relaxed/simple;
	bh=rBEOAhMOr2Mc6g/4ZxVEi2d8HDiDHEUUh/g6HdOt+2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6wk6LSb+3qXPj2OCfLIUNbwh88UAZkUSX3UtApfDciyxrqR9Aquvm4PJR9/H1hxhyMTgqHRPTTiOBoYAUlGofTyDfpP8ctoeC0TMG0ujmhddOzMV3HL43Wmlat79rqo1fsfn6GixvBG979U5UfOFwCv5vXIfeiddmXlVK8Nwfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tg/iRoW8; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoZBvkDAyUuSKqCo0LGg1K4tSmp6oco7CIC90XaqAduOxP6aNrMdW4FQv2wRC57MVUYVQjjaqR1Jy3YnRv6pytA8KtK1H9kHdK83GWj6re4RJxD9RfyAj5Z3DYPBPL8OHXiIfFxURzEnkT/m2jc79i+brICRCLELDMMqN6i6kefMQpQr8vkEi3lrNZJD72tK2EOqXlXKPLXSyW5axdfLhfPyTq+AXHtcgG08D0Pr0yKdtymIhNH+xfgvWU65jIonQneukAwW0JJB+VeJIn4SHComgvE1EEepkix7EjWnEvWRJyeLxjTQ0+QO6McMMtrO36vlXbDaDTp0fvJJonwq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL+MOT1mtFeALiF8LL04IVbAndrtX+CkHbK57hwB8Z0=;
 b=DtwbBI42WzQ9h4+1Rb7b5hv9FOv3Ddeq5l2/0n1Rv6E9vSpyS1n84mEAhaqL7/bHRBqzM7RBGHyoYP+YueMfVKxGgMtjGYT4ueXj4jw6+bxZUd6ibjeOn0+qUPUi3xNsgaNlnsDVYTscwu+t6iaA+uMttJlEIBXU+5gUpOyPtG12Gbul5oORKU0N5Hb2RGUkGXixnOordTyJGvY+/lYBAj4ZQwk6IZsfZgqi7iSxZJlIJ7C1FQUgh4aHk/6hW0csYkxULvZ92TXW13ulxhC+5iLUqzrpwp2rqfIdAmajLaXCadIdk2V/YnejFU6GV4muXv0hI2tah5408TSV9Co0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL+MOT1mtFeALiF8LL04IVbAndrtX+CkHbK57hwB8Z0=;
 b=Tg/iRoW8U4EpyqV0CZU6Gj/gWdZ9cnILftpD1MK5zFsg4Ks/VgaaF2i0yRHt1bsTGcSI7eIOcFVpJoeeg8TvVXC4C8eSAYeKbhd4OG78eWQ3IzBQTqkACDHc+/m9vznkUFJUDOdo3cTQsogiMg0s/jMHfAOr2so+6fVx2ggxv0k=
Received: from CH5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610:1f0::7)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Wed, 27 Mar
 2024 05:43:12 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::63) by CH5PR05CA0017.outlook.office365.com
 (2603:10b6:610:1f0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 27 Mar 2024 05:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 05:43:11 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 00:43:10 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 2/3] KVM: selftests: Change __vm_create() to create a vm without in-kernel APIC
Date: Wed, 27 Mar 2024 05:42:54 +0000
Message-ID: <20240327054255.24626-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327054255.24626-1-manali.shukla@amd.com>
References: <20240327054255.24626-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db197ee-3856-467b-8756-08dc4e20ca4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OgF+jvQtedAXvU01p43C/LfcoHUOZhpUVM90yXOfu/UhqNo4keaH7utEyl2aOyM6Fw/9je+jChzY9sHcp3K2afxKiBIi2MwbipSkqn2lvtqt7MCeyDopnQpEEpExFEWV073sGf3Q/4VTc32QbL3w1uM/QFBNeXoMJxkfWL9FwbgunfB145GnResPC9JhTGa0+ntPhE3dbau3BdW5u1XmyBfaPfBi76FJpOlGDkUKjeoAFlFEiMBFEmKngQJWY20sID4AVMaOXX9/u11ebBE1T/kspVo5mt5wTPQwUhWvvOJMOhKHO1Alwub5aj5HZWVysaRuY13qZns2U07LzT8RIjzAN1Hm7ZY0bGLTNw9tn2YzVsIud6gjwwNH08+9gY+gzacNPQkg9izQnirXtjbcktZQWfBuL2aS0hY1Z+4OCyXtG/9rNGHUZrFiCqWpC7ShuQA+J6WxDgjF/cnbrkDFqmD61JUb4Cp6qNVID6UxEEO7UkKuv80lkqTZHOHP4U9v1MiJ1kVYYMzbuQsO3NZkBVl2oYgxJ68+ZgAoPiw9eyRJ4akGgzjryjz5y24yyxlCSobipqgi6OmRVXyYl+pzIQMf5UHuGZ6pKULax+cyWQlN9VFLoDcnrtmPqsLrwB1Hkqxxx/WqZbIHPYUuNvHbAdCoHH0fHXm2yOX9grduvZ1B7McZ28gnZJ7nUkC+9f6/OAA/EpuqmoGQnwCh0fLZixmXKkDPn9hzmnVeysOw/D7BXAcNMYKNLBRKJ5uzz8od
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 05:43:11.9141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db197ee-3856-467b-8756-08dc4e20ca4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

Change __vm_create() to incorporate creation of a vm without in-kernel
APIC.  Currently, all the vms are created with in-kernel APIC support in
KVM selftests because KVM_CREATE_IRQCHIP ioctl is called by default from
kvm_arch_vm_post_create().

Add a flag in __vm_create() for a userspace to decide whether to start a vm
with in-kernel APIC or without in-kernel APIC.

It is a preparatory patch to create a vm without in-kernel APIC support for
the KVM_X86_DISABLE_EXITS_HLT test.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c          |  2 +-
 tools/testing/selftests/kvm/include/kvm_util_base.h   |  4 ++--
 tools/testing/selftests/kvm/lib/kvm_util.c            | 11 ++++++++---
 .../selftests/kvm/x86_64/ucna_injection_test.c        |  2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 6cbecf499767..667a83d67bfe 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -699,7 +699,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, struct kvm_vcpu **vcpu,
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
 
-	vm = __vm_create(VM_SHAPE(mode), 1, extra_mem_pages);
+	vm = __vm_create(VM_SHAPE(mode), 1, extra_mem_pages, true);
 
 	log_mode_create_vm_done(vm);
 	*vcpu = vm_vcpu_add(vm, 0, guest_code);
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 4a40b332115d..00e37c376cf3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -879,7 +879,7 @@ static inline vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
  */
 struct kvm_vm *____vm_create(struct vm_shape shape);
 struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
-			   uint64_t nr_extra_pages);
+			   uint64_t nr_extra_pages, bool is_in_kernel_apic);
 
 static inline struct kvm_vm *vm_create_barebones(void)
 {
@@ -900,7 +900,7 @@ static inline struct kvm_vm *vm_create_barebones_protected_vm(void)
 
 static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
 {
-	return __vm_create(VM_SHAPE_DEFAULT, nr_runnable_vcpus, 0);
+	return __vm_create(VM_SHAPE_DEFAULT, nr_runnable_vcpus, 0, true);
 }
 
 struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index adc51b0712ca..9c2a9e216d80 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -354,7 +354,7 @@ static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
 }
 
 struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
-			   uint64_t nr_extra_pages)
+			   uint64_t nr_extra_pages, bool is_in_kernel_apic)
 {
 	uint64_t nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
 						 nr_extra_pages);
@@ -382,7 +382,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	slot0 = memslot2region(vm, 0);
 	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
 
-	kvm_arch_vm_post_create(vm);
+	if (is_in_kernel_apic) {
+		kvm_arch_vm_post_create(vm);
+	} else {
+		sync_global_to_guest(vm, host_cpu_is_intel);
+		sync_global_to_guest(vm, host_cpu_is_amd);
+	}
 
 	return vm;
 }
@@ -415,7 +420,7 @@ struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
 
 	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
 
-	vm = __vm_create(shape, nr_vcpus, extra_mem_pages);
+	vm = __vm_create(shape, nr_vcpus, extra_mem_pages, true);
 
 	for (i = 0; i < nr_vcpus; ++i)
 		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
index 0ed32ec903d0..095188562709 100644
--- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
+++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
@@ -271,7 +271,7 @@ int main(int argc, char *argv[])
 
 	kvm_check_cap(KVM_CAP_MCE);
 
-	vm = __vm_create(VM_SHAPE_DEFAULT, 3, 0);
+	vm = __vm_create(VM_SHAPE_DEFAULT, 3, 0, true);
 
 	kvm_ioctl(vm->kvm_fd, KVM_X86_GET_MCE_CAP_SUPPORTED,
 		  &supported_mcg_caps);
-- 
2.34.1


