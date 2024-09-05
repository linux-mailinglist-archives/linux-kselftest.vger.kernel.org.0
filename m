Return-Path: <linux-kselftest+bounces-17229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE396D91C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BFC1C21206
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFDF19CCE8;
	Thu,  5 Sep 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5mgCwpC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38519CC35;
	Thu,  5 Sep 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540145; cv=fail; b=jsGZbhTXN596RnJ4RZe/BbE3REUCCJsMxrHEHPLBAAmRnn3Gwu+KB+O/AwpTrvqiJTQzkr43EZcggRWnainVC6NkOR7NabVOIJ1+aZG7Bkr/kPGiiRDpr16k5BfqeLSGJMNXQFOSzjH9S4Zb4eIqHS7y42pkkDjnyUZ47OsJNFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540145; c=relaxed/simple;
	bh=kj3rUdPlhXVSrtV4FHdsguqKCFisoovbXDZcGscdRU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2UEkJHUprX+G6Dpr/mkV+6gsCVST+w7IuLDz5WhEHpAuXHmoWObv/5rFplLtZ1pbQ/LqUe/SSzH921Q+UgeTEkbcAUGagGUzWPuKp8JbeoYE/NnWSqV4Dv7dEaPSL6XFbmH6C460g9EJBa8qK9/DNzv4QDA9KO+tKrnYngtRkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5mgCwpC; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNIBOCIyDWVIe7AAU1T8m89pT3HW3iVQ9kbFuww16KQ7AFX0V3UYyKadzhssi1TAMRdZg1bFV1VE/s2Z3mCqm2HSS+8CMyPnyyq/zl6vJwyGgb+uimDY4kqlHn9Vz8W9RAvSJEwxqiqhJIHSUbQa1TgHx9hLWdsktBQF66A1UYaF3naez38SQdh1c/aZ/ctJwWGdqVAgcFZceQDSjLMamQtYu3MAR2Yhoqf3yaSjNN1zZq8MTnmmDRMSNU6niHU6ouOc72yyufX1R7FySnFOVUk9L27S0jgH98t8F650HiqV+Bn9da5hs95o855Z9N3gPmzv8+jP6eExkclThaxZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqAZxxX/m8PMVrfiNDL2O56Y29MBfQlaq7YFFW52KcU=;
 b=JEYdiYNIJ4Xh3fIBl+XhkhIAQnuDW3a5oRJSJd3UsRjVptRV60jbnanfEEa4bQ/fB8tN0QbCtfLnEyLPiWFRo5FBUmfytADmPS+WRFWE/Ol+OEsT882v+COoB28cCO2Zm4lYLeDI+sGaPwQ4OLSWtKwv4HKSFnqbmaNoxUhgt5wxZwUJuSsRAgtWEx7vNvD0MWhrDkw8N8v1xLfdg5Zg4oasURfNUKt5/SJhgIu5ZBa9UYtVHMHs8slQGYx9UxrKSfb3EkkbsuA5iZJe8lXhtrPBk+uQXF5Jy/EUmdA3hGlPr6vo60fLK+m/NQwf1rYScj7dBTYILR0zbyY6CqGfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqAZxxX/m8PMVrfiNDL2O56Y29MBfQlaq7YFFW52KcU=;
 b=d5mgCwpC33fbHR1VWA2hapWMovE+HrX90y6FOqTyqPtAdTUhQr4xQuN7nR7LigPKPXVuRtQXXzSZ8Ja4x/I1AfOmttpqN+7g5D+pYkioAmKHiTyjZy923N90X98hpda7F6y1Cff5nl+FfjF5ksn8nqXxcerRMr2KsyW9qP0IuZk=
Received: from BYAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:a02:a8::34)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 12:42:19 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::1c) by BYAPR03CA0021.outlook.office365.com
 (2603:10b6:a02:a8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 12:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:42:18 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:42:17 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/9] KVM: selftests: SNP IOCTL test
Date: Thu, 5 Sep 2024 07:41:03 -0500
Message-ID: <20240905124107.6954-6-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e22a20-0b50-4bc2-a35a-08dccda82e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qbho2PkvUd+4mIR21zJaVn+pw2k0lVd09Vfl0iUBzZErwS5zMc7mtxJgCzdP?=
 =?us-ascii?Q?nivdA6HW4Tm8IwG8/dGH+Dz8PozZm3VBtmx78WK+WO7tdApDAEmbwFnT4AXJ?=
 =?us-ascii?Q?NLKdl/az3dn3gCdwEwcY5V6KWEWPJLpJ25fCUv+1NOolhkfpY5aX/Fcm+gYO?=
 =?us-ascii?Q?5olCxHvK/DJcMKIOiCX9mp5Q5fW4X93/9LnAAj/22DaGyK1ugebQjeb9FrhN?=
 =?us-ascii?Q?aLZe4er9jtMDSO2TQ5CbJU6GtfmNu3md9vLyTYNc8/L9PVX2hdeXB8jhseyN?=
 =?us-ascii?Q?AXcne0w+8/vYgYbZGG9LwBqHrx25eg2d8iFMbJgZwrsAcea9u0AWngTAdGgW?=
 =?us-ascii?Q?2t1qD+tUJb7jAlwsd27Q2D2ZRbx4D7mwjpJUpR34SV2Xn4vK3n32N3fdptrU?=
 =?us-ascii?Q?Os9htRIJcppiNR/l6AkDmArsPRbNn+2eNxBeZKZePMHtjfASxAUzghpFpPFw?=
 =?us-ascii?Q?F/03SbUSjnFeFYs5XbxoUcCVZ+t0NNFEAe2d8fh10cM8idHbB0d5tNrSfaiA?=
 =?us-ascii?Q?VqYsPNsamV5/qjrN3HMR2iUpfiEw7FbtCEwJSnWKu68hC08SZs5ixiQOyEDR?=
 =?us-ascii?Q?ux7ia4EGNo/Z+TCIJ/0fVCqze5kO7VAC+uQTAQ4k0rYKfxirSjMstx+dg8ct?=
 =?us-ascii?Q?ZIhpcZTqXoz0f/XxO8GMei7v3ibkQycl1zL79aLYvrnglKinmR2erXgafiDr?=
 =?us-ascii?Q?lIhvzfWOMHtkLiJamrxsvOKQ418mgX89eGnh0tLTUbnJ3XeKkkm0BachhWdi?=
 =?us-ascii?Q?oydqDPhG5l8ted4/56dgbhZjH/siTYaiHbwUwyarhYb2UXVpzd49uR08uUlB?=
 =?us-ascii?Q?QKs0HevLpVDZoVBNOIByTsf6Lcxqd/O9tjP64ygEGvrJnhY8g+J3s3150QS/?=
 =?us-ascii?Q?FYmlputXzDHnpD0RdzXObqCC47OS2c0cwBEZzrRTDPl3YOTJ4tMD78A22Wy9?=
 =?us-ascii?Q?Za7RW8b41R2MbIIbZt9p/Ny6Kh/RQABbK3IIxESbSQNNinhb+NWfm/jeSBhX?=
 =?us-ascii?Q?J4Xt/qw2yZ+sLyDmqUbFM3N00UqPsaNkh9X9NemyvEzyKgskhMaeE9WqpRXf?=
 =?us-ascii?Q?L8gtmXwtj0aC5AucbGTMlVV+Pzd4LfXAWzTtu+yKL98UtE83wqIndx8WyNZc?=
 =?us-ascii?Q?iRcwg4mW3bxrcV6RnAUgbz3DoJSLSrvD2nOTVacJF5DeDO4kXmwwSX/J8rLK?=
 =?us-ascii?Q?q0N60MhZjHLR/IJZ2nVsTJWrb1ABheAh2AHOen15awtihcs/Rydm2EP4/Iia?=
 =?us-ascii?Q?zR90GpjSivFHk/+zbYyY0lqmW/n2GQP9ArGjrihSgZkTJq+eexnxtLoP9NkE?=
 =?us-ascii?Q?4q0C/1JUE72utWWTUjEIJ4F5XnD1DUfCkz3+y4Y/+Oc7xhslpmo8X+v9TkY4?=
 =?us-ascii?Q?N3cXByj35smeubNk+8p7BHFjNDUNNOm9D9a32ViF5LpqxKqwAd2qakEBiZ2B?=
 =?us-ascii?Q?c5nPy/YRpbEXTiSBhVFcFDuh+a80Kkas?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:42:18.8829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e22a20-0b50-4bc2-a35a-08dccda82e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

Introduce testing of SNP ioctl calls. Tests attributes such as flags,
page types, and policies in various combinations along the SNP launch
path.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  11 ++
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 140 +++++++++++++++++-
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index bc7c242480d6..ab213708b551 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -912,6 +912,17 @@ static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
 	return __vm_create(VM_SHAPE_DEFAULT, nr_runnable_vcpus, 0);
 }
 
+static inline struct kvm_vm *vm_create_type(unsigned long type,
+					    uint32_t nr_runnable_vcpus)
+{
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = type,
+	};
+
+	return __vm_create(shape, nr_runnable_vcpus, 0);
+}
+
 struct kvm_vm *__vm_create_with_vcpus(struct vm_shape shape, uint32_t nr_vcpus,
 				      uint64_t extra_mem_pages,
 				      void *guest_code, struct kvm_vcpu *vcpus[]);
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 5fa4ee27609b..9a7efbe214ce 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -224,13 +224,151 @@ static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
 	kvm_vm_free(vm);
 }
 
+static int __test_snp_launch_start(uint32_t type, uint64_t policy,
+				   uint8_t flags, bool assert)
+{
+	struct kvm_vm *vm;
+	int ret = 0;
+
+	vm = vm_create_type(type, 1);
+	ret = __snp_vm_launch_start(vm, policy, flags);
+	if (assert)
+		TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_SNP_LAUNCH_START, ret, vm);
+	kvm_vm_free(vm);
+
+	return ret;
+}
+
+static void test_snp_launch_start(uint32_t type, uint64_t policy)
+{
+	uint8_t i;
+	int ret;
+
+	/* Flags must be zero for success */
+	__test_snp_launch_start(type, policy, 0, true);
+
+	for (i = 1; i < 8; i++) {
+		ret = __test_snp_launch_start(type, policy, BIT(i), false);
+		TEST_ASSERT(ret && errno == EINVAL,
+			    "KVM_SEV_SNP_LAUNCH_START should fail, invalid flag\n"
+			    "(type: %d policy: 0x%lx, flag: 0x%lx)",
+			    type, policy, BIT(i));
+	}
+
+	ret = __test_snp_launch_start(type, SNP_POLICY_SMT, 0, false);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "KVM_SEV_SNP_LAUNCH_START should fail, SNP_POLICY_RSVD_MBO policy bit not set\n"
+		    "(type: %d policy: 0x%llx, flags: 0x0)",
+		    type, SNP_POLICY_SMT);
+
+	ret = __test_snp_launch_start(type, SNP_POLICY_RSVD_MBO, 0, false);
+	if (unlikely(!is_smt_active())) {
+		TEST_ASSERT(!ret,
+			    "KVM_SEV_SNP_LAUNCH_START should succeed, SNP_POLICY_SMT not required on non-SMT systems\n"
+			    "(type: %d policy: 0x%llx, flags: 0x0)",
+			    type, SNP_POLICY_RSVD_MBO);
+	} else {
+		TEST_ASSERT(ret && errno == EINVAL,
+			    "KVM_SEV_SNP_LAUNCH_START should fail, SNP_POLICY_SMT is not set on a SMT system\n"
+			    "(type: %d policy: 0x%llx, flags: 0x0)",
+			    type, SNP_POLICY_RSVD_MBO);
+	}
+
+	ret = __test_snp_launch_start(type, SNP_POLICY |
+				      SNP_FW_VER_MAJOR(UINT8_MAX) |
+				      SNP_FW_VER_MINOR(UINT8_MAX), 0, false);
+	TEST_ASSERT(ret && errno == EIO,
+		    "KVM_SEV_SNP_LAUNCH_START should fail, invalid version\n"
+		    "expected: %d.%d got: %d.%d (type: %d policy: 0x%llx, flags: 0x0)",
+		    SNP_FW_REQ_VER_MAJOR, SNP_FW_REQ_VER_MINOR,
+		    UINT8_MAX, UINT8_MAX, type,
+		    SNP_POLICY | SNP_FW_VER_MAJOR(UINT8_MAX) | SNP_FW_VER_MINOR(UINT8_MAX));
+}
+
+static void test_snp_launch_update(uint32_t type, uint64_t policy)
+{
+	struct kvm_vm *vm;
+	int ret;
+
+	for (int pgtype = 0; pgtype <= KVM_SEV_SNP_PAGE_TYPE_CPUID + 1; pgtype++) {
+		vm = vm_create_type(type, 1);
+		snp_vm_launch_start(vm, policy);
+		ret = __snp_vm_launch_update(vm, pgtype);
+
+		switch (pgtype) {
+		case KVM_SEV_SNP_PAGE_TYPE_NORMAL:
+		case KVM_SEV_SNP_PAGE_TYPE_ZERO:
+		case KVM_SEV_SNP_PAGE_TYPE_UNMEASURED:
+		case KVM_SEV_SNP_PAGE_TYPE_SECRETS:
+			TEST_ASSERT(!ret,
+				    "KVM_SEV_SNP_LAUNCH_UPDATE should succeed, invalid Page type %d",
+				    pgtype);
+			break;
+		case KVM_SEV_SNP_PAGE_TYPE_CPUID:
+			/*
+			 * Expect failure if performed on random pages of
+			 * guest memory rather than properly formatted CPUID Page
+			 */
+			TEST_ASSERT(ret && errno == EIO,
+				    "KVM_SEV_SNP_LAUNCH_UPDATE should fail,\n"
+				    "CPUID page type only valid for CPUID pages");
+			break;
+		default:
+			TEST_ASSERT(ret && errno == EINVAL,
+				    "KVM_SEV_SNP_LAUNCH_UPDATE should fail, invalid Page type");
+		}
+
+		kvm_vm_free(vm);
+	}
+}
+
+void test_snp_launch_finish(uint32_t type, uint64_t policy)
+{
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_create_type(type, 1);
+	snp_vm_launch_start(vm, policy);
+	snp_vm_launch_update(vm);
+	/* Flags must be zero for success */
+	snp_vm_launch_finish(vm);
+	kvm_vm_free(vm);
+
+	for (int i = 1; i < 16; i++) {
+		vm = vm_create_type(type, 1);
+		snp_vm_launch_start(vm, policy);
+		snp_vm_launch_update(vm);
+		ret = __snp_vm_launch_finish(vm, BIT(i));
+		TEST_ASSERT(ret && errno == EINVAL,
+			    "KVM_SEV_SNP_LAUNCH_FINISH should fail, invalid flag\n"
+			    "(type: %d policy: 0x%lx, flag: 0x%lx)",
+			    type, policy, BIT(i));
+		kvm_vm_free(vm);
+	}
+}
+
+static void test_snp_ioctl(void *guest_code, uint32_t type, uint64_t policy)
+{
+	test_snp_launch_start(type, policy);
+	test_snp_launch_update(type, policy);
+	test_snp_launch_finish(type, policy);
+}
+
+static void test_sev_ioctl(void *guest_code, uint32_t type, uint64_t policy)
+{
+	test_sev_launch(guest_code, type, policy);
+}
+
 static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	test_sev_launch(guest_code, type, policy);
+	if (type == KVM_X86_SNP_VM)
+		test_snp_ioctl(guest_code, type, policy);
+	else
+		test_sev_ioctl(guest_code, type, policy);
 
 	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
 
-- 
2.34.1


