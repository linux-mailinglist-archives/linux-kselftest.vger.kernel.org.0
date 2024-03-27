Return-Path: <linux-kselftest+bounces-6696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB588D5FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 06:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098DE2A4BC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 05:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C98FC1D;
	Wed, 27 Mar 2024 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DIMxxUda"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E1171CC;
	Wed, 27 Mar 2024 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518197; cv=fail; b=nD/mcdsS4in6p+bhyjCYhjunR5UkW468zYZNPZOSwvCNvm9DumxGm7KwkuaT1n4E3NAZHlLhYTZwr3xU7tNjv7Lus+v5Z48klUrvbnVUWgDXjiFrSIF+AkgAn2V+qHw4CEJhVigNCSd1HNqT09j6e632qnSPWiLsMN42BeHGFPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518197; c=relaxed/simple;
	bh=dw8dBinq3tE3t53/PPwMenGmaGsRyDZL+du91C9yWnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAGCF9dszhErcoM5iRgEV3KcaVKoVWWj54QNcoxEGpV7jDvg2zUtlO2D2BwQLViYPoxn0zKs8mSAKvSn1gi62iFQ2rYq6KJtMUiMO+rYpYwFiZ0GJ3KphAu/Uj9HO9Cct25durcKMvlBus0+b5ZfocgznWsLru4n904Nhk3p2dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DIMxxUda; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGGG1mwLvI2a8psol5ueVmfPVxRocquNoAtZoXOgh4q3bHSp2uB6L8BQyPK0c4mnq1aYAM8f9oYksQ5SB2Z7rS6zqOMejGG4lO9ks9mIGujHnhHxpxK9L0KE1xUb+mSf6YY0cEK46BxKX88oBMl/eU27+/oLXN19O4a2jgUUCfB9o/+oZIH3RVDpnrLzkb2VAwoITIVdqbIn9J17BpIj54CWFQEN4oj0PCN8sSTsHXZdnUmczoHdja+IQiRdSb3QsE62zhKPDJrV1G0TfKCTyVom+B5O35gA8ECOkyFM9Ly/bz+BjuYOHzemuVxNJCpdNDep1CP7i03qWzNbwGJ6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ejoj9ojfpD7FEqtatnIcbZZK+y1kNu1zg+AMRd/T/E=;
 b=DA4fldq9rkf3/bBeLdXU10U5sCLo3IBwYt6w2RD/JiJ1C0Uqb6bGdj9Qsnq6K412ZlAexe2W5xtBMfVxxYumvqP6xBy1k0zd/SvrFBXMHqvQcDqxblZSDuqdAYj54LX5vqRTd1Swdnz8fKuRl/7Wt/LuJdTsTDO8WcApHsmWMtu5V9C+RKBKxhl0tCp3ZWo3wvFSV/a7oLu2IRx4hF+Pmor+iwZZfC/zcGVSGwediFulwPnMXqxa+LKKKAiwe+5sIdLovNA4Uc+cQHgkVQVYYDZsOT6KSOcqaPl0ndHJXLYEOgd1FDFXCktspq0FZH+tyjdzn6ldAhY0G7jmun677w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ejoj9ojfpD7FEqtatnIcbZZK+y1kNu1zg+AMRd/T/E=;
 b=DIMxxUdaSs0kQcS4MWMnI2zn0ASIqKJma8/vkn3pCsFPSyx8EQbhTwV+GBx0REVM5pqjLEa0lmx4cOO5kFkRBUqDJTCwEMC6PGByeRQ4u6lbh/8szvmeW9alVIrS0rL3vRMOpFm37Rtw+x9uGj1tZKdp45CuQbM3HStd1m2Z1oA=
Received: from CH5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:1f1::27)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Wed, 27 Mar 2024 05:43:13 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::99) by CH5PR03CA0019.outlook.office365.com
 (2603:10b6:610:1f1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 05:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 05:43:12 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 00:43:11 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 3/3] KVM: selftests: Add a test case for KVM_X86_DISABLE_EXITS_HLT
Date: Wed, 27 Mar 2024 05:42:55 +0000
Message-ID: <20240327054255.24626-4-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 527d1de0-10e3-4892-894c-08dc4e20cac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mxSGyvqr/0OSg7d8IYXr7ZUxEEWW17zdnBkU8Wr6vArJBZjjzKlFGEZgoVLIGAyr4EmoYGfVNWE/5YqDp4lHMab8XAvGSbFT56V6HJJdrbuVbMvJXqw12Gofaewxe1IuefaT6mpA1bIwPLWlEmhNwdFqHol2Pik2fvylHSxzi3rnLMneyi8f08b6j8JGkAzEQ+HgbJ7GBrjFwnkI3atePiToozKTT71wGCsGKSI12F9QQ1Ae0XPBUHTk6/C/uIkwuRdp8PxpMHwbUORJW+b+9LdBs+oX2lQNwzZS+tQtRdjuBeP7JG5zXa7VXZZqDG23BORJ1nQcagEYf14d13V8jjfzJ4sRsofzqEVqGc2eVWuSKovhK8zQypBaHw6zY7LQefQlQd6/9svMl4scC0yCNz+Gh+uuA6VUgw98UwkQKrhZaSVcQIQ6LQkcSZFPBv5j53fcE1E+nH/UlTZKJbuiZGfF5eMjYSgVlX8MTVScHh7WCtfOn9qIz2d6nUu4Q75RorWjwZJYIx8XslzTBQWB65iJFtqUDoso/LDj9rfXfg8kQ9wba0ls/+632zxGrJ2Kj3A5Jwit+TsBnwx9fSF1lTgCeIBvC0aRrxOqSHQuwJ5oZPP5T4OCsmfECG1D87YenoTl7NCQu5uv6iw/6YkWNgKIoc7islohKczA+HFx4KWOE907UCMnL4DP66Gq4TFMSGAbW6dyGD2HftNG8wfi9fsE9EWpYpxvO10mDheRVq28r0SPFaAbdsEjZ3w91YQM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 05:43:12.7268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527d1de0-10e3-4892-894c-08dc4e20cac9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

By default, HLT instruction executed by guest is intercepted by hypervisor.
However, KVM_CAP_X86_DISABLE_EXITS capability can be used to not intercept
HLT by setting KVM_X86_DISABLE_EXITS_HLT.

Add a test case to test KVM_X86_DISABLE_EXITS_HLT functionality.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/halt_disable_exit_test.c       | 113 ++++++++++++++++++
 2 files changed, 114 insertions(+)
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
index 000000000000..b7279dd0eaff
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/halt_disable_exit_test.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM disable halt exit test
+ *
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+#include <pthread.h>
+#include <signal.h>
+#include "kvm_util.h"
+#include "svm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+pthread_t task_thread, vcpu_thread;
+#define SIG_IPI SIGUSR1
+
+static void guest_code(uint8_t is_hlt_exec)
+{
+	while (!READ_ONCE(is_hlt_exec))
+		;
+
+	safe_halt();
+	GUEST_DONE();
+}
+
+static void *task_worker(void *arg)
+{
+	uint8_t *is_hlt_exec = (uint8_t *)arg;
+
+	usleep(1000);
+	WRITE_ONCE(*is_hlt_exec, 1);
+	pthread_kill(vcpu_thread, SIG_IPI);
+	return 0;
+}
+
+static void *vcpu_worker(void *arg)
+{
+	int ret;
+	int sig = -1;
+	uint8_t *is_hlt_exec = (uint8_t *)arg;
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+	struct kvm_vcpu *vcpu;
+	struct kvm_signal_mask *sigmask = alloca(offsetof(struct kvm_signal_mask, sigset)
+						 + sizeof(sigset_t));
+	sigset_t *sigset = (sigset_t *) &sigmask->sigset;
+
+	/* Create a VM without in kernel APIC support */
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0, false);
+	vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, KVM_X86_DISABLE_EXITS_HLT);
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+	vcpu_args_set(vcpu, 1, *is_hlt_exec);
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
+	kvm_vm_free(vm);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+	void *retval;
+	uint8_t is_halt_exec;
+	sigset_t sigset;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_DISABLE_EXITS));
+
+	/* Ensure that vCPU threads start with SIG_IPI blocked.  */
+	sigemptyset(&sigset);
+	sigaddset(&sigset, SIG_IPI);
+	pthread_sigmask(SIG_BLOCK, &sigset, NULL);
+
+	ret = pthread_create(&vcpu_thread, NULL, vcpu_worker, &is_halt_exec);
+	TEST_ASSERT(ret == 0, "pthread_create vcpu thread failed errno=%d", errno);
+
+	ret = pthread_create(&task_thread, NULL, task_worker, &is_halt_exec);
+	TEST_ASSERT(ret == 0, "pthread_create task thread failed errno=%d", errno);
+
+	pthread_join(vcpu_thread, &retval);
+	TEST_ASSERT(ret == 0, "pthread_join on vcpu thread failed with errno=%d", ret);
+
+	pthread_join(task_thread, &retval);
+	TEST_ASSERT(ret == 0, "pthread_join on task thread failed with errno=%d", ret);
+
+	return 0;
+}
-- 
2.34.1


