Return-Path: <linux-kselftest+bounces-15560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138F955160
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D6C2881D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A011C460C;
	Fri, 16 Aug 2024 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rgw7i1pR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336931C4609;
	Fri, 16 Aug 2024 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836251; cv=fail; b=XoiaS0VdbEDPLcVHEvJr6CdbQkcHNQUqzKpDLw5yocjeVObU108xlNh0tuUOZOkYY2xRmCklQ1mHwNBngv6IOSlOE7TcQfrDTTlt672eQcWV0UKCmsj/rzFhV5Jur2rfsMpK2Yuxeogk17LGN2jQ0YNkKsMUvloYoJa8X5Nc/5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836251; c=relaxed/simple;
	bh=rvNxInwGf6wUzTnOeTAMt7yYqLiCqMh268KyAcxkZtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH7THgewP9Xx2POkoKRIdU51Ec3EOB3Pxl4dXR3Agte5CiBUFbLBc/SzLbWsDxsUe7HICfLMkoCnAF4oUN5LvmgNxJpb/Ts3RWT/q8Obgt3/bCn3qdpRkCnxJ0QorWfgODKhBQHHm7QYmaPmk0LO24/Ymjlqw2Qw9suelWjpQ/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rgw7i1pR; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKYORayKdwoWm8w7y9jJjArWudASjVxv2Qqb3F9sWYhJ3dllNpFXj0a7ptSOxosS8QFWL3v8naqv4TM1mUcSD2Vw3Bcj7HCWsjPz1TeWonoy87DPFECWYQAT+HbI+xcQ0O1KlSnPLVL0ABXjgeyZ53BbWKRtPT6EEDPCq3LIuFt34gLlbMKl9N7KcV152ajFqiGCqarwkCgv4l234sr/QDY2ebvMZpz01SgCVR2n3eBfu/FDTROxWU0tTC1t8akqLZZfuJRt5lC7CyXdMcAfWL/nGIcylRs/BsplKMNDVPXKTDTi4CSx259jHO7uAks5V8MEQ1irt2og1DAMFGC41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxeV025tvPb0Xme+rrM5uNQ4QVzViIugChkTE39mgWA=;
 b=XtgIIeur2nJqQQKt/I0j/JuCDMbxAl5ksM3QdNIeRUIdfhXVX3bQXcGehDilvI7HJODIyjb76Vk8kXi9fbwE9xSZnYyF2r5yDsfYpJnKpMWbpVgHDbhjoX1Vp/YVszI/NIQU9EdALJL6MJoUuWBpzEUEnArAhu6yzYpJ1Ht10eCCnAn0s2DyzLLpipTPUreU//CU3py1h0/KQ6qCiMAfFc5gXM2ht2Yg45DeQrP/1S9bUYVTFTQgWRhIY0H80GytDDMwRnuBQYBplkfEhvVsOB53q//JKxAaQmwFh/UfOKEYFWw/bD4+ty7TJ2Bgq43zFQ15k5zmo2pL4kS2n7GD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxeV025tvPb0Xme+rrM5uNQ4QVzViIugChkTE39mgWA=;
 b=rgw7i1pRZnS/cdhTDT5PDksMr80LbqUGO9xGWDLt5vN1yfH6vpRxbLe4GxLJmydA6x1qTnvjaJKG3xlJO0iykBSFWWdp3eDBpx3Vi+FsvpvyAvACDOq1qmx1ikFmrp+KEMyOA4PQ/T7AWDhdIp2ppufH/HnuwVoNl6Mq4UyPlec=
Received: from MW4PR04CA0061.namprd04.prod.outlook.com (2603:10b6:303:6b::6)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 19:24:05 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::42) by MW4PR04CA0061.outlook.office365.com
 (2603:10b6:303:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 19:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:24:05 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:24:04 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/9] KVM: selftests: SEV IOCTL test
Date: Fri, 16 Aug 2024 14:23:05 -0500
Message-ID: <20240816192310.117456-5-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bbc030-6965-4c79-7950-08dcbe28fe49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1cAFafD+GaomxnvbEgc66+CsZLayNv3hXZvTnhVVLwxsov3K8zEB6aByeU5+?=
 =?us-ascii?Q?RH66tYDuZc7XCCiQTRc8dRpFPaZ3s2aaZydyFmFv5R/j6S263zc6YuDpqeM5?=
 =?us-ascii?Q?ZWYCORheKg7nuPrZYRYjGYn4lpnrSw2dftmOLwWf/cmN3SZ9cSEOYqWtEbIX?=
 =?us-ascii?Q?gDMZjV3iZ3UeT0q659X74UcMz3RtbINnOntnDbHqNiMDVjxD8o6KAtCwjROx?=
 =?us-ascii?Q?1xGo9CBZ9qQje1LfBR4OS84KUdqvud2AI9MNxL3QDDUK4WTmV6GaTdC9UJAK?=
 =?us-ascii?Q?syqvurd7/2YPHkOBJe50sfVeWm4cCHvFrLIjn1YTZ58HM+1npHup8JPLDTUk?=
 =?us-ascii?Q?5KNosSoPGm6JiMAprfCgKu0wY3bEKqWzFLqwQ4Nd4aFyFJumL6ut8zPtguaI?=
 =?us-ascii?Q?5JRPmRvWnqygOifjcc96IAS99hzuiUqxmppwcySkCCMyIJkD8PgEmz+yp7K0?=
 =?us-ascii?Q?P8fr/ZaSZHL6u466N7qfFjywM/ZU0T3f20F+QvkQx14neQXLqjT2jjPd4ZtN?=
 =?us-ascii?Q?CMVpYxR9j38d7geS6R3bfMY198WanxrsS4ANDifwVa6nK4S3iQin0jg8BFu0?=
 =?us-ascii?Q?st0pyE5Xtu8U43295pwllQk64JU4RRRGlRko7JAcWlqcf17zzuUhpQAr4o5X?=
 =?us-ascii?Q?wWHlmJT9yC+C0pZGjyV2kSCM7Vf2Ba46hykzkz8QBWvaFDOe3qJBVQw8aXru?=
 =?us-ascii?Q?VQqr9Luz2/lgYKmpe98HZT4q5/36PZyFEIVoP0W6/p4AYOu7OUC53ezwTGSO?=
 =?us-ascii?Q?8tz0/vYGJ2K0n9tnlYOHiEsGqw4yW0nuBpTHdMV/eAJigP+SVmnNUMq+8TSs?=
 =?us-ascii?Q?Hf45mIqxfJ+e48dyyuOvuzX/EKWRXCF94bgvPrTHaxjdHUChyqss9v3gsher?=
 =?us-ascii?Q?nKEBya07IHGnNYB1i85zMslAd5YFkAKPRMjVtAOYSY41L1fxFJ993P6Mg9a7?=
 =?us-ascii?Q?bOeVOsudeiwXWBNZH/AaKqYUHTQAFJVEZIoCs45EHG9Br2tRyK8db0ZEPHD9?=
 =?us-ascii?Q?V3QPAgyRHoc5MXubJyCJGUSoElLerZaTL70+NkGvfmRyJioETQCu3kN/ryOp?=
 =?us-ascii?Q?0CFO10NlJSUh9QQrnAhKExkGBMdOLsxAOtmIfbdeLBlTJ4qENVzxfEE5eDiA?=
 =?us-ascii?Q?sNSCctKKighVEFm+PP8cKzsCFoRQ8tVmUyjIwL/n5Zx+JFAX980Imei3dhW9?=
 =?us-ascii?Q?aIUD0vpqTxE2xe231Cmk3SykCo4JLFCqTOTFS0MDIwJoipVkMXSB9wqYWU1N?=
 =?us-ascii?Q?H3889EnEkIynnritIms/MuohKHM8ZdPoSPM1flOyR08TgPSGHR/Tmu2OR4tR?=
 =?us-ascii?Q?VHGjOXNZ9wvG52r626qqfrGl7s8gCg4TSvbVf/TuoLG5RgJUyxggp/sBXnXs?=
 =?us-ascii?Q?xkcdzzCY9LdONbi7PcSeYOcp6KPsIbSjS5bnKZ6c1sAyuAYrstx2T4CAdk7y?=
 =?us-ascii?Q?2NKloLNSaSF8j1gCf1qoAdJJXIEGr8nw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:24:05.2402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bbc030-6965-4c79-7950-08dcbe28fe49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

Introduce tests for sev and sev-es ioctl that exercises the boot path
of launch, update and finish on an invalid policy.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index c5a9fda49554..cca2e0467f3d 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -142,12 +142,97 @@ static void test_sync_vmsa(uint32_t type, uint64_t policy)
 	kvm_vm_free(vm);
 }
 
+static void sev_guest_neg_status_assert(struct kvm_vm *vm, uint32_t type)
+{
+	struct kvm_sev_guest_status status;
+	int ret;
+
+	ret = __vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+	TEST_ASSERT(ret, "KVM_SEV_GUEST_STATUS should fail, invalid VM Type.");
+}
+
+static void vm_sev_es_launch_neg(struct kvm_vm *vm, uint32_t type, uint64_t policy)
+{
+	int ret;
+
+	/* Launch start with policy SEV_POLICY_NO_DBG (0x0) */
+	ret = __sev_vm_launch_start(vm, 0);
+	TEST_ASSERT(ret,
+		    "KVM_SEV_LAUNCH_START should fail due to type (%d) - policy(0x0) mismatch",
+		    type);
+
+	ret = __sev_vm_launch_update(vm, policy);
+	TEST_ASSERT(ret,
+		    "KVM_SEV_LAUNCH_UPDATE should fail due to LAUNCH_START. type: %d policy: 0x%lx",
+		    type, policy);
+	sev_guest_neg_status_assert(vm, type);
+
+	ret = __sev_vm_launch_measure(vm, alloca(256));
+	TEST_ASSERT(ret,
+		    "KVM_SEV_LAUNCH_UPDATE should fail due to LAUNCH_START. type: %d policy: 0x%lx",
+		    type, policy);
+	sev_guest_neg_status_assert(vm, type);
+
+	ret = __sev_vm_launch_finish(vm);
+	TEST_ASSERT(ret,
+		    "KVM_SEV_LAUNCH_UPDATE should fail due to LAUNCH_START. type: %d policy: 0x%lx",
+		    type, policy);
+	sev_guest_neg_status_assert(vm, type);
+}
+
+/*
+ * Test for SEV ioctl launch path
+ *
+ * VMs of the type SEV and SEV-ES are created, however they are launched with
+ * an empty policy to observe the effect on the control flow of launching a VM.
+ *
+ * SEV - Expected to pass through the path of launch start, update, measure,
+ * and finish. vcpu_run expected to fail with error KVM_EXIT_IO.
+ *
+ * SEV-ES - Expected to fail the launch start as vm created with type
+ * KVM_X86_DEFAULT_VM but policy passed to launch start is KVM_X86_SEV_ES_VM.
+ * Post this calls that pass the correct policy to update, measure, and finish
+ * are also expected to fail cascading.
+ */
+static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
+{
+	int exp_exit_reason;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
+
+	if (type == KVM_X86_SEV_VM) {
+		sev_vm_launch(vm, 0);
+		sev_vm_launch_measure(vm, alloca(256));
+		sev_vm_launch_finish(vm);
+	} else {
+		vm_sev_es_launch_neg(vm, type, policy);
+	}
+
+	vcpu_run(vcpu);
+	get_ucall(vcpu, &uc);
+	if (type == KVM_X86_SEV_VM)
+		exp_exit_reason = KVM_EXIT_IO;
+	else
+		exp_exit_reason = KVM_EXIT_FAIL_ENTRY;
+
+	TEST_ASSERT(vcpu->run->exit_reason == exp_exit_reason,
+		    "vcpu_run failed exit expected: %d, got: %d",
+		    exp_exit_reason, vcpu->run->exit_reason);
+
+	kvm_vm_free(vm);
+}
+
 static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
+	test_sev_launch(guest_code, type, policy);
+
 	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
 
 	/* TODO: Validate the measurement is as expected. */
-- 
2.34.1


