Return-Path: <linux-kselftest+bounces-13520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0D992DB8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BDC283085
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9ED14387F;
	Wed, 10 Jul 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBGm5n+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3626127E18;
	Wed, 10 Jul 2024 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649171; cv=fail; b=LU7zWgFtXbl4FNlq4gmeFnJWTWE5iBDNdvkMXbdIRhwnQdOOV4i7eapC0OQERTw4osIr6rxCiT532Aqh9oiD/0dEvAnRyQw4UbeDAPguyTOzPqqLQDGbk0FpCrN5aShhb7qcSwhjHOJRPwRAgwTY8v3Erk1GYX42vHJ15tEm3y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649171; c=relaxed/simple;
	bh=26qztKqeOuRmGJ53tZ53SadDDNnkqYnk5QiTb6H0wWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyc0HnNjH4ljrNXVFVADorb18/ntNS3fJQGIbFVqvU0yo7Tb581w6KdlEzHwoIKmwLYT15MfEiqqAAmk0cGkxED21yHT0bhg1x7sSKHVufRq4TUkGahs1vCSdwd9ERJky7BRHWAFeEF9hLbcVZ6uBeL/Q1NN6TGqwdldXQqmXZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KBGm5n+R; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8sZ1eRsTaObEBHDgrNvQZu4mMA4wQWx11WuIIRHL1ADjbhGNAeHXQqQ1+0mGuUaezH1xtxVYbEsS6vlzdqiuN6Haoq7tBYrWWTu605zqqm0V5e+Q/FWZsdK+TCBwlUW21X/mk8jkHfvrXhcoGt0DmfO3tziG+q6x7InQXl7qXg1hKVwyqOThGd71mBCWmp+B3vtk1FErTozxUJ6llep2B85JI8tbdZbPIs2YLdeKyUQTvTGRxmJ8wgAr8XhwKpvO88I/BAyAITiuGLYzV92A9kGnfUB03PdHUYkK3Nq/KcYQj6JavmGM7v5j+0GYv9+NTPAWgh6MCCgDwB9f/GQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2aR+9j2Vgbi/ow8TksJUGzvT9sJHq1KTRdu06EH2UY=;
 b=YjiJhfKhjoWMQw1GNWqqz86HYFc1ToOaeBZXW+uixFRpEeNhed18bzDr1lLhg/0oKXn+DiXn5DIbAHPhRxaHNX6Jr8xa9r7zqwJYtMJ6MnKr3N/bfSAuySMWNRM8WtFgc4eOW2vxZbVQhGg+ELVCEkzwZmY7iavxCZ7DTwdxkzxxFmyQZms3xm1T39g5Hq5BuCZey60TMIiKqJ2MEyoQI87wmndJfkhZ7H1EpaKwDYIcL/ok4x03XG2LdfQynRCarEDxK95FhbN82+PsVeUgOUvOEjm4gNGLiHo8i3bzGMxkZn3QHXFkEL/No5j2u/cyNQylYOinncN7jt4Z080+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2aR+9j2Vgbi/ow8TksJUGzvT9sJHq1KTRdu06EH2UY=;
 b=KBGm5n+RPEETMAqK7fQmemJHENS8CxiCgSe74zj5q3SBbg1RzgKT9Rk2lzfD72/CiERYYuAlqKQzHCUr/kNL9BQyG68cAfcvA/fiC33kdyPVd3Ud7zBTwGu32M7O/Vt0iIKsasLdUoGf2/Zop8j0PObp04rPRleIulXEZwKrrFo=
Received: from MN2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:208:1b4::29)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 22:06:05 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::4e) by MN2PR15CA0016.outlook.office365.com
 (2603:10b6:208:1b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 22:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 22:06:04 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 17:06:01 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <shuah@kernel.org>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 1/5] selftests: KVM: Add a basic SNP smoke test
Date: Wed, 10 Jul 2024 17:05:36 -0500
Message-ID: <20240710220540.188239-2-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c39ec3-e3e8-4ca1-69f3-08dca12c7e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rtwzP9K0WYs0f/mQs3xTtqcyw5CsTEH/i/Sp6R5LdftAlLdhgQAj0thZYjsS?=
 =?us-ascii?Q?iRRRWv83ym/fvadmsWmmXTzZZiAI6Bg53MSBZ200djKoIjOXDi3HDRWnWa+V?=
 =?us-ascii?Q?ZFfO/I3ejxKVB/+Q5yoyxTy/6vXVunHXDU53cp46vvHLLERlhGMJPmhn/ei0?=
 =?us-ascii?Q?QrcvwHjSthaE/Nc3Yug0AuMHYDZ7P6FCJ5p9OZXbu07qXH8F8Vml8k1Q8xvo?=
 =?us-ascii?Q?rXoGLMNS7bazpfGgx6eTkJyz2sDsYcwwiPqRLSrfUPkT3VMvh3LeokWN3BRn?=
 =?us-ascii?Q?WP6NmZfbaY8URHL9AE7CqAFvKvr2/u1IlaRvXTMMAdDNhzgcCJJ4jd5D47Lw?=
 =?us-ascii?Q?AxeJsK6Ii6ylSRggDVXMtUPen2MZVANmV0kvP7FYDBxnPzKDcZv9yNUh2d/5?=
 =?us-ascii?Q?9s9qTVcczyyHuypzHfHC2KhnCRPfztW9gPEiAJsAlHt0nj8NVaxpdtGnqRM1?=
 =?us-ascii?Q?nJtst58hYBvpeUndk9gxEDHeSwM6SccZ48yiDTPAhCl6D5+z9u/39d/fCEkW?=
 =?us-ascii?Q?obsgRiZvWGmG6OBQjYfZVXCDk3FtFhn//R9ye48F0Zz9g5/4eCY31wB0yeAy?=
 =?us-ascii?Q?6OFZK6A1ImST1TnDcvvm0LVA3gyGV9DdPoVevdyx1/SwvXcuzZUTKKSjcD/G?=
 =?us-ascii?Q?Mnld40Hm9eBRcqel4Z2NbQiG95f0ZVVd5SEkACEk2eBOte7tdy3aihbYVAPv?=
 =?us-ascii?Q?k6pZz0SlX/XzLlkvslkkojP7TdMq6FLIPG8gfO7GPC7q4cTbsG32nkcPJol7?=
 =?us-ascii?Q?eQsMu+UTpbz0jST5RvCyG8rKntwCIenPrIsV4tHB2wOHStSjDJIMH6uZka0G?=
 =?us-ascii?Q?v/lIHNfjzaHrltWrw3bXOMJP6jYqxiWp1ovcjEeslysvdE8o9Kgk/fckwCyS?=
 =?us-ascii?Q?+3nygqED232xbEjOWw/JC3jCh17lREPWaSghxPxSBiFRLgNkYo0wgEMjNcrJ?=
 =?us-ascii?Q?hWN7UUNpVACQ/WvgkAmrTGXM2Zn/8IJKohktwW9cu5+ChToo1ebMtO5PCXp2?=
 =?us-ascii?Q?xUieSeL78wCn8LoeGCwWesGNoIbnMRgIiRWRF/1jw1+bZ1WAc9UkfvAJZjRD?=
 =?us-ascii?Q?Ow64sRanuEy47f2dEQ46Ovuz+AdzUUnv1VzIBgFLgTt0I/YjrQgt2NjtzSiA?=
 =?us-ascii?Q?goOQBNTL62xLkcg95XYNBv4oyb5ukqHGnFKpXlgpdVy6OnQEAgSUJxID5/C4?=
 =?us-ascii?Q?shjZBCsLCn0llWecnhZGxfYC1n0HnaGFarmAHnze2EjO+r/npjH8dCnkwND1?=
 =?us-ascii?Q?L2lw2tRT+HW3rOgTK0J9tVFOL+cf0TMmfHNJzROOSz/atBpAFyOfm/5r91rk?=
 =?us-ascii?Q?zBIAxvb+AB2puOxNe2f9inR8eDLtXIPzhjdG3+v/1uVXzW3WT59pcL7RR1HA?=
 =?us-ascii?Q?zmdIwd8B7QijBhrVhQQNlNKfsI1iGrCaFjTaco+hwPL/vsY7/stAh2QRMAhP?=
 =?us-ascii?Q?UGnR3er7o2wAMI7wRkGopx2AUOFCJTF9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 22:06:04.8738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c39ec3-e3e8-4ca1-69f3-08dca12c7e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887

Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
initializes and sets up private memory regions required to run a simple
SEV-SNP guest.

Similar to it's SEV-ES smoke test counterpart, this also does not support
GHCB and ucall yet and uses the GHCB MSR protocol to trigger an exit of
the type KVM_EXIT_SYSTEM_EVENT.

Also, decouple policy and type and require functions to provide both
such that there is no assumption regarding the type using policy.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/include/x86_64/sev.h        | 29 ++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  6 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 70 ++++++++++++++++++-
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 51 ++++++++++----
 6 files changed, 146 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 8eb57de0b587..5683fc9794e4 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -194,6 +194,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define X86_FEATURE_SNP		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
 
 /*
  * KVM defined paravirt features.
diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 82c11c81a956..43b6c52831b2 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -22,8 +22,17 @@ enum sev_guest_state {
 	SEV_GUEST_STATE_RUNNING,
 };
 
+/* Minimum firmware version required for the SEV-SNP support */
+#define SNP_FW_REQ_VER_MAJOR	1
+#define SNP_FW_REQ_VER_MINOR	51
+
 #define SEV_POLICY_NO_DBG	(1UL << 0)
 #define SEV_POLICY_ES		(1UL << 2)
+#define SNP_POLICY_ABI_MINOR	(1ULL << 0)
+#define SNP_POLICY_ABI_MAJOR	(1ULL << 8)
+#define SNP_POLICY_SMT		(1ULL << 16)
+#define SNP_POLICY_RSVD_MBO	(1ULL << 17)
+#define SNP_POLICY_DBG		(1ULL << 19)
 
 #define GHCB_MSR_TERM_REQ	0x100
 
@@ -31,6 +40,12 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
 
+bool is_kvm_snp_supported(void);
+
+void snp_vm_launch(struct kvm_vm *vm, uint32_t policy);
+void snp_vm_launch_update(struct kvm_vm *vm);
+void snp_vm_launch_finish(struct kvm_vm *vm);
+
 struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
 void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement);
@@ -70,6 +85,7 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
 
 void sev_vm_init(struct kvm_vm *vm);
 void sev_es_vm_init(struct kvm_vm *vm);
+void snp_vm_init(struct kvm_vm *vm);
 
 static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 						 struct userspace_mem_region *region)
@@ -82,6 +98,19 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
 	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
 }
 
+static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
+					   uint64_t size, uint8_t type)
+{
+	struct kvm_sev_snp_launch_update update_data = {
+		.uaddr = (unsigned long)addr_gpa2hva(vm, gpa),
+		.gfn_start = gpa >> PAGE_SHIFT,
+		.len = size,
+		.type = type,
+	};
+
+	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
+}
+
 static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 					  uint64_t size)
 {
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ad00e4761886..4c00a96f9b80 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -412,14 +412,17 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
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
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c664e446136b..d1ea030f6be0 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -623,7 +623,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 	sync_global_to_guest(vm, host_cpu_is_amd);
 	sync_global_to_guest(vm, is_forced_emulation_enabled);
 
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM ||
+	    vm->type == KVM_X86_SNP_VM) {
 		struct kvm_sev_init init = { 0 };
 
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
@@ -1127,7 +1128,8 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 
 void kvm_init_vm_address_properties(struct kvm_vm *vm)
 {
-	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
+	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM ||
+	    vm->type == KVM_X86_SNP_VM) {
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
 		vm->gpa_tag_mask = vm->arch.c_bit;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index e9535ee20b7f..90231c578aca 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -24,12 +24,19 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 	if (!sparsebit_any_set(protected_phy_pages))
 		return;
 
-	sev_register_encrypted_memory(vm, region);
+	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM)
+		sev_register_encrypted_memory(vm, region);
 
 	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
+		if (vm->type == KVM_X86_SNP_VM) {
+			vm_mem_set_private(vm, gpa_base + offset, size);
+			snp_launch_update_data(vm, gpa_base + offset, size,
+					       KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+			continue;
+		}
 		sev_launch_update_data(vm, gpa_base + offset, size);
 	}
 }
@@ -60,6 +67,14 @@ void sev_es_vm_init(struct kvm_vm *vm)
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
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 {
 	struct kvm_sev_launch_start launch_start = {
@@ -112,6 +127,51 @@ void sev_vm_launch_finish(struct kvm_vm *vm)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
 }
 
+void snp_vm_launch(struct kvm_vm *vm, uint32_t policy)
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
+		encrypt_region(vm, region);
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
@@ -130,6 +190,14 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 
 void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement)
 {
+	if (vm->type == KVM_X86_SNP_VM) {
+		vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
+		snp_vm_launch(vm, policy);
+		snp_vm_launch_update(vm);
+		snp_vm_launch_finish(vm);
+		return;
+	}
+
 	sev_vm_launch(vm, policy);
 
 	if (!measurement)
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 7c70c0da4fb7..1a50a280173c 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -16,6 +16,16 @@
 
 #define XFEATURE_MASK_X87_AVX (XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM)
 
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
@@ -61,7 +71,7 @@ static void compare_xsave(u8 *from_host, u8 *from_guest)
 		abort();
 }
 
-static void test_sync_vmsa(uint32_t policy)
+static void test_sync_vmsa(uint32_t type, uint32_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -77,7 +87,10 @@ static void test_sync_vmsa(uint32_t policy)
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
@@ -99,7 +112,7 @@ static void test_sync_vmsa(uint32_t policy)
 	    : "ymm4", "st", "st(1)", "st(2)", "st(3)", "st(4)", "st(5)", "st(6)", "st(7)");
 	vcpu_xsave_set(vcpu, &xsave);
 
-	vm_sev_launch(vm, SEV_POLICY_ES | policy, NULL);
+	vm_sev_launch(vm, policy, NULL);
 
 	/* This page is shared, so make it decrypted.  */
 	memset(hva, 0, 4096);
@@ -118,14 +131,12 @@ static void test_sync_vmsa(uint32_t policy)
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
@@ -134,7 +145,7 @@ static void test_sev(void *guest_code, uint64_t policy)
 	for (;;) {
 		vcpu_run(vcpu);
 
-		if (policy & SEV_POLICY_ES) {
+		if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
 			TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
 				    "Wanted SYSTEM_EVENT, got %s",
 				    exit_reason_str(vcpu->run->exit_reason));
@@ -164,17 +175,31 @@ int main(int argc, char *argv[])
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
+
+		if (kvm_has_cap(KVM_CAP_XCRS) &&
+		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
+			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
+		}
+	}
+
+	if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
+		test_sev(guest_snp_code, KVM_X86_SNP_VM, SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO);
+		/* Test minimum firmware level */
+		test_sev(guest_snp_code, KVM_X86_SNP_VM,
+			 SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO |
+			 (SNP_FW_REQ_VER_MAJOR * SNP_POLICY_ABI_MAJOR) |
+			 (SNP_FW_REQ_VER_MINOR * SNP_POLICY_ABI_MINOR));
 
 		if (kvm_has_cap(KVM_CAP_XCRS) &&
 		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
-			test_sync_vmsa(0);
-			test_sync_vmsa(SEV_POLICY_NO_DBG);
+			test_sync_vmsa(KVM_X86_SNP_VM, SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO);
 		}
 	}
 
-- 
2.34.1


