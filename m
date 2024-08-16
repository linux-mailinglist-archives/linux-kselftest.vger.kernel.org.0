Return-Path: <linux-kselftest+bounces-15561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC91955163
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6041D1C22BA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F21C4609;
	Fri, 16 Aug 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gKBBUkt2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603251C3F32;
	Fri, 16 Aug 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836263; cv=fail; b=WNsDefOi8gScQG9+Lx7eI4iPDuZAXp+Gqk/emb66KBa57Nxqm1OjJbztVkFyOYuolyN091jZyKpizSkVRQgKZjUJeqF6bV6vJtldnab9laXFOyLZ/Q5tH6kgx67EdCuTk17pJF2xG0GhSY/nth/bLmZRH+jY7yejjByS6Cy4OZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836263; c=relaxed/simple;
	bh=3eq4PzKo9bfvQPwtj/TEUl8ygIhzHPr4BecB7o+jH80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXDmryOZIoK4O7JK7ZZOmNCCHjFGek88keR3qIxGhwYkD79BXKzE91Y/Ir99ARxmndYHgmgj7njwEa8Iw5QwkJ3rARv3cqJKchTJSYzQPikJOLHXeOz70qzf2TMqT2Ko6j3AMeNVpFFaGRW2cL/9fVnxCB3NAOTghbZw5/XPckc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gKBBUkt2; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAyuCPXSqkhu5MprohREJsd06cmCmaLsbR86gL7z5xqPBarQJjHPajZHU2BvNwps4e0uBcUa+Xf6eezU2yISK1XblUYf4jU69yRrvLqPoolu0cfypK+D9zA4XC2Kxxo8KrmQe+Ul+6iOJwDO5nupSlaWp5KXbl/3tOoEBRIYbrSn3IYbzkIByyibkvpDcOIP2/DtwzTBFlndYNVjPvybdAZll+DbGNrg7UmkdM85qlhOqWoj/s/3fFeIEyL1X35J5v2MKfLhRw94u7POME6XRjowyPkNz7VJoL4wHSm9bw8b3IgGpQTYuEJPfoX2lE1XtO32CW4lWO8v5qGqbk/Dew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA66KCYDdQe8DKKCgR0HxvBakgkpa82FaCXVGuVZnfE=;
 b=ME8HdJa6vHrDeoYtVT8bhtUGVPjG/V+sP92S9H7OGBxBDiOqyebXDlZfPt82Sesf4/iFKJ5jn9hgHkGb0K87Bg1riC7M8YojMuV7UKgudG9ZcovdtqY5XpGoG5Iw4jYjUNMvo+Ddx+e7EifyhyY+kSbjG/vP+YSe8RzYyMHppMQj+Kt9O3udxPFlA7bISuwYdaUvkGU8viGO9NgpRHfu+wHfIKOvNMOZa7QDvyEfi8YpUFQ//pJJO+R1J+xAm6LwBjJOlWMvcTOGm2dN0nCLJmyQQYbBkfrSXq3gDnhfsdTHX2MgKMe+J8y3Uui2JtQNG54OVmypP8uWY5nV5ddrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA66KCYDdQe8DKKCgR0HxvBakgkpa82FaCXVGuVZnfE=;
 b=gKBBUkt221yCHKfZM4l/jyS/BRFwtxU2xXZZj784Q+uF1Ll/ulRR/Epi7iIeiERwKEQtEF1HZp7uXhwhZi30YfAC99kA79n0Rza2LEVHjTkiZyVz6tBFMkZLHvghKPQFO+BBBLeQlhy+t/d4Rh7VXUUoc9s1KNXvnT+a5hZVt9U=
Received: from SJ0PR05CA0176.namprd05.prod.outlook.com (2603:10b6:a03:339::31)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 19:24:16 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::7d) by SJ0PR05CA0176.outlook.office365.com
 (2603:10b6:a03:339::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17 via Frontend
 Transport; Fri, 16 Aug 2024 19:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:24:16 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:24:15 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/9] KVM: selftests: SNP IOCTL test
Date: Fri, 16 Aug 2024 14:23:06 -0500
Message-ID: <20240816192310.117456-6-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e6f349-0d50-4fc9-11b4-08dcbe2904c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xcU06uP83/q3vTJ6/z2gmUe4y/JwQouWIwv3qIwzYOG2GmnrGbzxpYTApLje?=
 =?us-ascii?Q?nvaEwqmNBirtzMpMv1lO8CvJKh7cR24RxdkHaHlx6Et/Si3y7S/72osiaOHP?=
 =?us-ascii?Q?1Z5RhVGeeApgVx9sN1QIae4deaY7DsnKWcyp24wl2VAKPSt39cUjwI3Hz1Y5?=
 =?us-ascii?Q?AlyMVT0mCJ1Ajxu+M7WP69RIRnnqI4W4wtCG98kDZPVs/cggIZA+eRoEZ75A?=
 =?us-ascii?Q?Y4aFrWJI2A9ugh59DXncu4c7quPDfAMszLiKTqr4Q8tgAuQ47dwNVQ+pINC/?=
 =?us-ascii?Q?nYqliiK73XxToUG5TzQvBRXTkLkpPvvu4IY0YIfbv9vNy8AH9DhuvzepmOiE?=
 =?us-ascii?Q?X5IW0TRPtBV3QGNvklVf/nRTJWW0ZvmS/X9yItpJfYxCfaAT/3Ztta+Cq6xs?=
 =?us-ascii?Q?6ZnhJWeN+RALgg6tuLaTzb8kLZACUTDnv6zCvo5TVI3qovzm5XZdLvAA4OM+?=
 =?us-ascii?Q?vBnS4kUTo68j9OzXpMc79GZ5u3CDoGp3e1moVSfB4oUQLlgiL0MkigP5ssOO?=
 =?us-ascii?Q?1u1HTQsWfYKnUyZ9pU95A9hPE8hg4fukeLz0s1oHt5vhTvMmFU4SdvzvxSR3?=
 =?us-ascii?Q?VBQ3R+Rbo6N5rt/fu9gLxEmFVzt+3/WbeML7jPN/TdKyLTBFWBKDDfhMsgfn?=
 =?us-ascii?Q?kK41HEIGCuVA7pvYHrm4WlOjps2ZhfGzFzbQMQjwOEL4swFd8YwklAzPaOy9?=
 =?us-ascii?Q?cLfoT4NSPyPnHnnggN2M+/maeSSvMFV9cMeaVHWY13BmY4TCaUQEmRIPE3ow?=
 =?us-ascii?Q?hRazCoBmOkYCz7+mfKBYsLTg0tBD+P5bEdIhLLPrLzyZ274onvnk3mY1tc1c?=
 =?us-ascii?Q?+l6qflib4ortM0nS2uKaCUAcfiemgifHw5FDQgoUwZ4AHH5gj7c5AcGYRZ6z?=
 =?us-ascii?Q?qet+sJIz9xCnB6G1PSf3G+xV4lpF13SbvfgtwQ2xmh6pfxBNTF4cu84VionZ?=
 =?us-ascii?Q?R/h1QyqhXxwWLAg+Pakgxla67UUWPyQeSDFpa5ggdfFVSiVSs1lv+NhRGod1?=
 =?us-ascii?Q?XYXeJ7o1daBuXwo769lVAx+qjt/h8BtV3lMBf7Q9C+QAL0d0jMh6OsRFgiP7?=
 =?us-ascii?Q?9Rt9Gb5MDrXnUfc4o2Jj96P60jnwq3qTgF0LAcR7zHwYlFGheBrfkM0EvlVV?=
 =?us-ascii?Q?ahjoJ4KkswMegQzcIvdH7ZYd4DPAz/Jr0juX5U0P/72p9SScMjXb9qjlTg0E?=
 =?us-ascii?Q?fdkDAz4Gr3QZCM4fG8hs7yqsCKeGjw6nxyG/xXeMOg/so08gRlezZAY9wnz+?=
 =?us-ascii?Q?TrSwvC9nxWkvf2RpETTOdPFncML3gPO5ewRfnXGTEqe6TiYdlJo09FS8MHnF?=
 =?us-ascii?Q?YHjtJ51hJiComEGhTKQ7BxpfHukesVFDd7DQMjUdF4TjuXmTmLD8klxUZAYG?=
 =?us-ascii?Q?4jrwSgXXcaH2TwKYu96mszYs5SVlC6pbUQfuhrhaPemUTITvczKTMp9IJ4wE?=
 =?us-ascii?Q?9g0jtTxkps7dPPKfmEgbhRkNeXxGnuD4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:24:16.1518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e6f349-0d50-4fc9-11b4-08dcbe2904c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

Introduce testing of SNP ioctl calls. Tests attributes such as flags,
page types, and policies in various combinations along the SNP launch
path.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  11 ++
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 140 +++++++++++++++++-
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 63c2aaae51f3..144730efbffa 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -888,6 +888,17 @@ static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
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
index cca2e0467f3d..3901a0cf44ee 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -225,13 +225,151 @@ static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
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
+			    "(type:%d policy:0x%lx, flag:0x%lx)",
+			    type, policy, BIT(i));
+	}
+
+	ret = __test_snp_launch_start(type, SNP_POLICY_SMT, 0, false);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "KVM_SEV_SNP_LAUNCH_START should fail, SNP_POLICY_RSVD_MBO policy bit not set\n"
+		    "(type:%d policy:0x%llx, flags:0x0)",
+		    type, SNP_POLICY_SMT);
+
+	ret = __test_snp_launch_start(type, SNP_POLICY_RSVD_MBO, 0, false);
+	if (unlikely(!is_smt_active())) {
+		TEST_ASSERT(!ret,
+			    "KVM_SEV_SNP_LAUNCH_START should succeed, SNP_POLICY_SMT not required on non-SMT systems\n"
+			    "(type:%d policy:0x%llx, flags:0x0)",
+			    type, SNP_POLICY_RSVD_MBO);
+	} else {
+		TEST_ASSERT(ret && errno == EINVAL,
+			    "KVM_SEV_SNP_LAUNCH_START should fail, SNP_POLICY_SMT is not set on a SMT system\n"
+			    "(type:%d policy:0x%llx, flags:0x0)",
+			    type, SNP_POLICY_RSVD_MBO);
+	}
+
+	ret = __test_snp_launch_start(type, SNP_POLICY |
+				      SNP_FW_VER_MAJOR(UINT8_MAX) |
+				      SNP_FW_VER_MINOR(UINT8_MAX), 0, false);
+	TEST_ASSERT(ret && errno == EIO,
+		    "KVM_SEV_SNP_LAUNCH_START should fail, invalid version\n"
+		    "expected:%d.%d got:%d.%d (type:%d policy:0x%llx, flags:0x0)",
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
+			    "(type:%d policy:0x%lx, flag:0x%lx)",
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


