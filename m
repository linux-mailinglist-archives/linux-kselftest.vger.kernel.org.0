Return-Path: <linux-kselftest+bounces-13523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96592DB97
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 00:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA3B1F264B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32354147C60;
	Wed, 10 Jul 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uXvufqp2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD113D2A2;
	Wed, 10 Jul 2024 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649204; cv=fail; b=NEEwdLSJfDUWPIrE9vMyitzkoUqCOxxrWYuI3+NemuTFqqz3AWuWexZaxd8wTIq9FSPlwzaxrbDBPAahWntXuIw9efg9FB2LFaUSVtPbeCqFPS23KHa9ZOijqwnrzzM1aax/DUQET0IhbECqkvJKbGoyBO52sVCIUKP9TH444Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649204; c=relaxed/simple;
	bh=8Z2xgmdt23qq5LiddQPlGGZ+0D3tXUdQ8P0evJu1uhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3bLfVEba/STG0NwqXmDuawLnSWdGfwJOUqLqvHiGgn/2KVVzbwvcxTUHUrs07gX0nxgctkLamRhQCTXPyNhD2yNRZbVm//E2YdPXkMgEAc9rI8Gx54WqFYsyem3mYqucou9s4N/amPECDhPdNQ92lrhIaZ2IFP6YfR9aJ4R8ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uXvufqp2; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3XrRBCopprTS3gnSP2wN35kVN2DPLAUxO913LOw5rIofeFmL7Hx18jg+uDFDDvrZfNbtpZnuojRQ/oTJviYCxYyrwcvoMV33fDNrtD2PEPp2svgFD2+85qntWH5kiQuZiP8CSussB/iU5FjM4kG9upMIQoAdmbyvXop9f6LGtmbp4KMR9HqYuPH5dsKELACLGpTv80zAYJQVLR5vh//pNtElI2Cd9oGorygYWfXpCAgubxy0x75H7geX6V34Rs4pzCtrXHT+o0SjBJRWEpakJ/Z6IyvsN2cF6DtMmOhu76KzXavxfsXSiWEM13WbxXr4S9NtYRxE9Haf1CUmpySXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrK4KskF60Txi8Z387BhdEIyAqva9WBu/dv4UO9DQ4s=;
 b=TjSMA6W+bbumW3RnWcOfW2KB+1W5IR7+16oNgeB/BoEbSbakCrbhpjsNq5UBgS4/2H0zw9TJEgT6komYBky5dejSntl3WQO6J5jt3jOQyDzoeqkEZOC8PB9GqeN5g71KKioE3kIt1Qi+25veSPC+DwQGZGH5VI1Nz9O81nmy1cSURPnzUW7YDb8n4F2bhRFzzZaYXK/KHtpCyPnDo1RvOtV/eBchyEYgbDyiFt/KptFmQZoXu5MJ8ndSJeX64OnyZ/DYgVxrgnOiMtDoook9ysJGEf4dseOTCSNru5eSCJpk9Q8pO88/h4BgvMiRZb3BnO454ivwE7jHqkOF7Kiw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrK4KskF60Txi8Z387BhdEIyAqva9WBu/dv4UO9DQ4s=;
 b=uXvufqp20JNJWrvV3U9tZkIJK4Wq6910B3cyPsDGe4BZn1GWqu22gwZAybsyPUDXdUFhF8bVLnEW+d8eBqy5DXs/SQIjbPLKuPIjJ32SXBPieYMl7TiyA42jRdFuZfaySXwuhJvCXVWHDboqIbvztij/oFEHKDHoZaZHgFN6nE8=
Received: from BN9PR03CA0716.namprd03.prod.outlook.com (2603:10b6:408:ef::31)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 22:06:37 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::c6) by BN9PR03CA0716.outlook.office365.com
 (2603:10b6:408:ef::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 22:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 22:06:37 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 17:06:35 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <shuah@kernel.org>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 4/5] selftests: KVM: SNP IOCTL test
Date: Wed, 10 Jul 2024 17:05:39 -0500
Message-ID: <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe86555-8677-4e27-28d0-08dca12c91a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8r6o7Ru6VKzFiFp23xTWOkSUzS40Da+JtCp92jKIvlrmcvTHuH1454MbP1pM?=
 =?us-ascii?Q?fv8yDqfFNumbRzwN1svhA29yM7rmfngRCevp6OwHhGtsqD1YZZwDs46kY97Q?=
 =?us-ascii?Q?nJKI5MwAERCAgDJ7TgS/EQmcYM5jtUkk9yDkrcy2kxOlDdmkqM6HdLdGOFwB?=
 =?us-ascii?Q?SZtI9Sqf5Kbxna7lYFt/o3LMqI9b2Mv+7tAI2NjnYy/y+hHyZmhxANWORz9y?=
 =?us-ascii?Q?daCvef60wKeapYQlECRq6nihH7ZO3mDi6MtoMCu+hITgERmNxvxdLz4m0DeR?=
 =?us-ascii?Q?x7UP4oPYlefCRKXtAXYOgEPSFFOPKjMbWlLU5EH1ieixhWL3CGf0ksaTUB1Y?=
 =?us-ascii?Q?ZGKonH+xILo4H40Mi5Bjwg01h7wjp7u+eqC4hNPxhznrBP2Ym04WIqDQq0rt?=
 =?us-ascii?Q?+KALku+0NH4QqPbXkRu4deffRixeaNM+KEin1K2LRXQb9T0GJSZJ8NbvUM46?=
 =?us-ascii?Q?34GuQxG4jyQmMSVZct4yIMX41FPI5MbSdBrauwBE9aTR63Qnyrd2GPAFuzRs?=
 =?us-ascii?Q?9EzJF9cxAIpCLsXD9wQZJJtVRxTlzdu4nCoupf5kL1d5asLbwdeWNd0O6Mib?=
 =?us-ascii?Q?9y9zQLBuFyYykjlQRveA0L4xqhDEnJtvcrAERzD0dKU8n7QGAGzvrtzRvbZR?=
 =?us-ascii?Q?aFnDsgyusuPRBm3NCQeDImnjPvkE0G3HNfUFB6xucGqBBezuFe6Nw3lRM3oi?=
 =?us-ascii?Q?1KsCFNA+KZdU8cCItb9WDMJmcZzmlpoXylbBksQ5ZVCyVXr4JiPHQgmowL6E?=
 =?us-ascii?Q?lbUAA2qCri1UPLLAHuDmjLIHmf9pEMlOOQgQlwDTFlLLtj3wCoTy7fjtxapL?=
 =?us-ascii?Q?ETB5v5N0MCY4ij1DifHD7xN0kbDZAuYNiGdVIguR+tx+hzxnxcRVoAlSnD3x?=
 =?us-ascii?Q?9vnoWycA+T6WNYlNfqU/v3X3jeYo3Osl9WTdJHxtAykLeebegAUiooTLvAGR?=
 =?us-ascii?Q?0h+MiXY/ZXddopxspsd1uixHABHiQeOkLRvu6nebga/LaMRGdfmKb73jKkgX?=
 =?us-ascii?Q?QUJ9nx2owqOoEGvejEzv+rbgudSv3La6/UZYyfeoAOWGBuBL8eBrv8jC4vJ4?=
 =?us-ascii?Q?fZWrcnIFm3F/QSmEzDA0DvbcptpTzWYtrJhfW7EAnpWX5cTWF9UIGKJuy5He?=
 =?us-ascii?Q?2s90ceumyFk9P9W5F05A7/GpI/+wh0A9ZE41Bs6E74QKcUsVZV1zey3/WYXD?=
 =?us-ascii?Q?X0OD12csTmNzT24mWHRZSUNbBJwN7kl533ixva5UTGB550LlwtUqcowaavqb?=
 =?us-ascii?Q?wEhGBmJfSjcyWUk20Ay/IfiSQL64+wrFqe5KomoUtounimn6vX2Q5tDZhq3T?=
 =?us-ascii?Q?aA+QBAZDTCwIf6Hgblw+Fm86Pb9n6p79y1y49LOsvnqD8gRnBivG7pjHEkrM?=
 =?us-ascii?Q?clV1PDm7AiHrGGnuDXeN3Z2awzEEMx3oOdUh/8813mIsYAQ8YM4dMJDYMDoo?=
 =?us-ascii?Q?q48eapZSOxv7TyYjtgCKA+bC+Tewtzrw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 22:06:37.1930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe86555-8677-4e27-28d0-08dca12c91a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

Introduce testing of SNP ioctl calls. This patch includes both positive
and negative tests of various parameters such as flags, page types and
policies.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 119 +++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 500c67b3793b..1d5c275c11b3 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -186,13 +186,130 @@ static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
 	kvm_vm_free(vm);
 }
 
+static int spawn_snp_launch_start(uint32_t type, uint64_t policy, uint8_t flags)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
+	ret = snp_vm_launch(vm, policy, flags);
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
+	ret = spawn_snp_launch_start(type, policy, 0);
+	TEST_ASSERT(!ret,
+		    "KVM_SEV_SNP_LAUNCH_START should not fail, invalid flag.");
+
+	for (i = 1; i < 8; i++) {
+		ret = spawn_snp_launch_start(type, policy, BIT(i));
+		TEST_ASSERT(ret && errno == EINVAL,
+			    "KVM_SEV_SNP_LAUNCH_START should fail, invalid flag.");
+	}
+
+	ret = spawn_snp_launch_start(type, 0, 0);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy.");
+
+	ret = spawn_snp_launch_start(type, SNP_POLICY_SMT, 0);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy.");
+
+	ret = spawn_snp_launch_start(type, SNP_POLICY_RSVD_MBO, 0);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy.");
+
+	ret = spawn_snp_launch_start(type, SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO |
+				     (255 * SNP_POLICY_ABI_MAJOR) |
+				     (255 * SNP_POLICY_ABI_MINOR), 0);
+	TEST_ASSERT(ret && errno == EIO,
+		    "KVM_SEV_SNP_LAUNCH_START should fail, invalid version.");
+}
+
+static void test_snp_launch_update(uint32_t type, uint64_t policy)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret;
+
+	for (int pgtype = 0; pgtype <= KVM_SEV_SNP_PAGE_TYPE_CPUID; pgtype++) {
+		vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
+		snp_vm_launch(vm, policy, 0);
+		ret = snp_vm_launch_update(vm, pgtype);
+
+		switch (pgtype) {
+		case KVM_SEV_SNP_PAGE_TYPE_NORMAL:
+		case KVM_SEV_SNP_PAGE_TYPE_ZERO:
+		case KVM_SEV_SNP_PAGE_TYPE_UNMEASURED:
+		case KVM_SEV_SNP_PAGE_TYPE_SECRETS:
+			TEST_ASSERT(!ret,
+				    "KVM_SEV_SNP_LAUNCH_UPDATE should not fail, invalid Page type.");
+			break;
+		case KVM_SEV_SNP_PAGE_TYPE_CPUID:
+			TEST_ASSERT(ret && errno == EIO,
+				    "KVM_SEV_SNP_LAUNCH_UPDATE should fail, invalid Page type.");
+			break;
+		default:
+			TEST_ASSERT(ret && errno == EINVAL,
+				    "KVM_SEV_SNP_LAUNCH_UPDATE should fail, invalid Page type.");
+		}
+
+		kvm_vm_free(vm);
+	}
+}
+
+void test_snp_launch_finish(uint32_t type, uint64_t policy)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
+	snp_vm_launch(vm, policy, 0);
+	snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+	ret = snp_vm_launch_finish(vm, 0);
+	TEST_ASSERT(!ret,
+		    "KVM_SEV_SNP_LAUNCH_FINISH should not fail, invalid flag.");
+	kvm_vm_free(vm);
+
+	for (int i = 1; i < 16; i++) {
+		vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
+		snp_vm_launch(vm, policy, 0);
+		snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+		ret = snp_vm_launch_finish(vm, BIT(i));
+		TEST_ASSERT(ret && errno == EINVAL,
+			    "KVM_SEV_SNP_LAUNCH_FINISH should fail, invalid flag.");
+		kvm_vm_free(vm);
+	}
+}
+
+static void test_sev_ioctl(void *guest_code, uint32_t type, uint64_t policy)
+{
+	if (type == KVM_X86_SNP_VM) {
+		test_snp_launch_start(type, policy);
+		test_snp_launch_update(type, policy);
+		test_snp_launch_finish(type, policy);
+
+		return;
+	}
+
+	test_sev_launch(guest_code, type, policy);
+}
+
 static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	test_sev_launch(guest_code, type, policy);
+	test_sev_ioctl(guest_code, type, policy);
 
 	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
 
-- 
2.34.1


