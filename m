Return-Path: <linux-kselftest+bounces-6948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7D4893CC3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E1EB20E51
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74247A5C;
	Mon,  1 Apr 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ago/TfE2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A445BF9;
	Mon,  1 Apr 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984856; cv=fail; b=VMlFGD1hwtgqNNzVctqpjUFCilhxHABxqFdS/6a3wT/ndM5sVHDMTJ9y+cWmsDLQ799URvFGGSfZIBD9iWVQ0qZ3U6AtsK0DVDrWLzV5apDSbp6RCnYlwB5DEOdlWh47fq9RnZAYo0hsiO+uCwlULTRPKEI6Wfa64uyTbSWICJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984856; c=relaxed/simple;
	bh=SkgcnncwvNsa46ffTlhRMbwEsfaM2MErO8EH2oIJcGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZaXT9/eDxaeiqypSZCacjC1eBv8ssrZqgA9Mtoowyo6Gc3mVYpZAWWsgxP761RupOrSkulw5wgE1IhmXn6eygdkX6YmVY4bRjvubRM3/6LiA7ndaiAFWljYSwGwVuN5p7c54Gbjbu1pdU68WZchN0RVgZkVLuLRbgat7xw0jPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ago/TfE2; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWERJmw8UzHUOl4vqxhm78TKmgbQOwUWorrmIDxM3ZAcETkWfetseQrRPvoZ9EH3SluPy5+aGaDKVGjJzkkqHeK/kAtK/kWNpdB9h64psyFsNE1HR/HVjUv2KBy2zwU8yDA95EiQ5boryNmJxqanVRsYTG+pu1pd96OfOFNehzsyP3C6ZNWjGfOfnTBXZBTuJcxURHj+b9le01I9WLDYSPLzceWB0ibDndQOZWQ36aVhSGJdGMVD8rmWKAZDL+mAVlUciieUBHpEbvU4+oY3kerZZlhqvuVAM/wJBIazcG+gxoIbBQduL7iY05IJalKdDPZaX7vCM9hPGAXYjNu9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWy0BvLzcmDiATFcGPlFYN2W1W9D2CiwcqjK082S9/8=;
 b=GHtyChryJuvRq1wuM87hNt4QLsZYbh7LZ+S37qKa0pCNq+SRqMihCXLQlBJSX0mJucO6MNrSR/+3HZdFHTRgQiY2v5epk2RRBlVUoN1P6oKoV4AYq3LnYpPqiQ6qe6Q0ZmX/ebN5+rZNYW9RTXMd4YFvvcQtokobHnvXIyssu2cp2A4Ii2d+rVZ2te6jO0Pb7l9o4I2qKmDvxy2qGW6Z+586oK6CxVmyDSdFZzj2jz5a9bRbnWeiOr+VgjQhXsLwGuFT1iiHFLYBYvMspa5JqWwtvbYmjUn3wEcyN2SLPO17LA0WF0ShnEVI+K+jPEC/R/S99qHkO9JZSRV1gNOSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWy0BvLzcmDiATFcGPlFYN2W1W9D2CiwcqjK082S9/8=;
 b=ago/TfE2FKDZlv5VxQZgbBj9uPp10ZzdVSV4BAam2DGRxbguMrcKXL9M0fEtzkjOHhtKyfATr/l17C+9qJfao4WPNTiznvcuO4CnkWGI9kfO3Mlvi5/jbrJBOQqysWljN0Ir2GXpMb1qGfg1faEGKOn1AtCQyR/fz6mELc23I4s=
Received: from SJ0PR05CA0113.namprd05.prod.outlook.com (2603:10b6:a03:334::28)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 15:20:51 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::33) by SJ0PR05CA0113.outlook.office365.com
 (2603:10b6:a03:334::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24 via Frontend
 Transport; Mon, 1 Apr 2024 15:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 15:20:51 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 10:20:48 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>,
	<ajones@ventanamicro.com>
Subject: [PATCH v2 3/3] KVM: selftests: Add a test case for KVM_X86_DISABLE_EXITS_HLT
Date: Mon, 1 Apr 2024 15:20:32 +0000
Message-ID: <20240401152032.4284-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401152032.4284-1-manali.shukla@amd.com>
References: <20240401152032.4284-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 77800e54-0342-40e5-608e-08dc525f511b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MYenObSioRc/rn5ywvKzNvcwg4SumH1nayU1ELxm2FlSbZbR+ai7YUB1LBjI00TWdbGhcBknvFLFhwApVsERB3mwNvbsavW3g8dQM9pvUocDguIKcKUEALEmV/AUL3IE/zmu5aDU/1fB3XXsYU7NxVHwMVjqiKx/S6Qa+jia7jcRO7/cFA6DU8spy67BQDbQX/9qpiRnzER1pWih7xd4YvBYkjIRn3xUOBhPmjlfbDo/ohzyzZhLw0zfA6shhMZ3+JNbEiJi6tl+0LqylW4p9lDrsXbuimtNRuxXtlP3DUV2F73gasRQpE0zDJ14UzHTzZqiOiicSdngCxdkRXorJLXp3Gz+BYvvrJNpXmZmuBN9j0dhduX+vHKlhLFixuhvlM3IA6EcpTtpR9yzU85NmIFPnvuwiw9fzWkQ9jRSHpQ79jEs0y/RdnBD0K6EFXwtSnQMMioXro7qrUBqffFgpwX6EAkayiCR5mROkun6CiPIpAq91lgRHMsdrNSPJlWcMMG1gXmIHOADFyvntGjomaKenct1aHqBk7BdDndtO1mZhLsQEtc5ILbCQnTVCgFQJ17/7O44urSm3U6lYQmJg4o9S2ObGJatfuNudjobHKf82oPW4e5TiQl0NhrG949lnKL+dcPZOqRjbVO2+1oE92cQQ6pmYDMfdkPl2gX36Hs/5TBfMl7TYF4JcK1ayx75x9gCS5N4qIv+k9tGdewCY7oTzX4vI3hjSaPv3MavPjlbCtbwCkRJKkzo3EJQvXs8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:20:51.4481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77800e54-0342-40e5-608e-08dc525f511b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679

By default, HLT instruction executed by guest is intercepted by hypervisor.
However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
HLT by setting KVM_X86_DISABLE_EXITS_HLT.

Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/halt_disable_exit_test.c       | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c75251d5c97c..9f72abb95d2e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
+TEST_GEN_PROGS_x86_64 += x86_64/halt_disable_exit_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
diff --git a/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
new file mode 100644
index 000000000000..4cc6a09906a2
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM disable halt exit test
+ *
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+#include <pthread.h>
+#include <signal.h>
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+#define SIG_IPI SIGUSR1
+static pthread_t task_thread, vcpu_thread;
+
+static void guest_code(uint64_t *is_hlt_exec)
+{
+	while (!READ_ONCE(*is_hlt_exec))
+		;
+
+	safe_halt();
+	GUEST_DONE();
+}
+
+static void *task_worker(void *arg)
+{
+	uint64_t *is_hlt_exec = (uint64_t *)arg;
+
+	usleep(100000);
+	WRITE_ONCE(*is_hlt_exec, 1);
+	pthread_kill(vcpu_thread, SIG_IPI);
+	return 0;
+}
+
+static void *vcpu_worker(void *arg)
+{
+	int ret;
+	int sig = -1;
+	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) arg;
+	struct kvm_run *run;
+
+	struct kvm_signal_mask *sigmask = alloca(offsetof(struct kvm_signal_mask, sigset)
+						 + sizeof(sigset_t));
+	sigset_t *sigset = (sigset_t *) &sigmask->sigset;
+
+	/*
+	 * SIG_IPI is unblocked atomically while in KVM_RUN.  It causes the
+	 * ioctl to return with -EINTR, but it is still pending and we need
+	 * to accept it with the sigwait.
+	 */
+	sigmask->len = 8;
+	pthread_sigmask(0, NULL, sigset);
+	sigdelset(sigset, SIG_IPI);
+	vcpu_ioctl(vcpu, KVM_SET_SIGNAL_MASK, sigmask);
+	sigemptyset(sigset);
+	sigaddset(sigset, SIG_IPI);
+	run = vcpu->run;
+
+again:
+	ret = __vcpu_run(vcpu);
+	TEST_ASSERT_EQ(errno, EINTR);
+
+	if (ret == -1 && errno == EINTR) {
+		sigwait(sigset, &sig);
+		assert(sig == SIG_IPI);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTR);
+		goto again;
+	}
+
+	if (run->exit_reason == KVM_EXIT_HLT)
+		TEST_FAIL("Expected KVM_EXIT_INTR, got KVM_EXIT_HLT");
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	vm_vaddr_t hlt_vm_addr;
+
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	uint64_t *host_hlt_addr;
+	void *retval;
+	sigset_t sigset;
+	int ret;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_DISABLE_EXITS));
+
+	/* Create a VM without in kernel APIC support */
+	vm = __vm_create(VM_SHAPE_FLAGS(NO_IRQCHIP), 1, 0);
+	vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+
+	hlt_vm_addr = vm_vaddr_alloc_page(vm);
+	host_hlt_addr = (uint64_t *)addr_gva2hva(vm, hlt_vm_addr);
+	vcpu_args_set(vcpu, 1, hlt_vm_addr);
+
+	/* Ensure that vCPU threads start with SIG_IPI blocked.  */
+	sigemptyset(&sigset);
+	sigaddset(&sigset, SIG_IPI);
+	pthread_sigmask(SIG_BLOCK, &sigset, NULL);
+
+	ret = pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
+	TEST_ASSERT(ret == 0, "pthread_create vcpu thread failed errno=%d", errno);
+
+	ret = pthread_create(&task_thread, NULL, task_worker, host_hlt_addr);
+	TEST_ASSERT(ret == 0, "pthread_create task thread failed errno=%d", errno);
+
+	ret = pthread_join(vcpu_thread, &retval);
+	TEST_ASSERT(ret == 0, "pthread_join on vcpu thread failed with errno=%d", ret);
+
+	ret = pthread_join(task_thread, &retval);
+	TEST_ASSERT(ret == 0, "pthread_join on task thread failed with errno=%d", ret);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1


