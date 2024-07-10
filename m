Return-Path: <linux-kselftest+bounces-13522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E380392DB94
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 00:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D8EB22DD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171214E2F4;
	Wed, 10 Jul 2024 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j/uZXfHf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888D14D6EE;
	Wed, 10 Jul 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649191; cv=fail; b=CsVjXPI2fgQIIjXVFwx6MgRiFjX08fW8q8449sC+rFqJKXsiqXmxQ56oEy7A/4mq7lJahR5+wlfQUN1GU9N0zvqxcZmZNBkToKvl+z+GVxAss/e90yVOZr6UvQaLxOXABin0S6HuPvVeqh4vsnz+sKTo/2pjcv5D4a+UFy331BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649191; c=relaxed/simple;
	bh=7Vxn1SmbIv4BPoSvtLIYYMiCQgQmE2FMPJJrNspSehE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzLXaF/iWR77ksTuhHtknm4viNM/el5OJAWL0x1NBaOrWY0D9QE8Qna0KNWZtLKbuy3RJ33E+4ShgqMUuQlITSMVFuAycCH7yQJI6TuCjSGHSjKBAOnROoTRtNydEYi4pA4sJF/W8GwOSQZIJEj2qWumgsGcPfQQ09Lc1LNXUlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j/uZXfHf; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho8J/E6QNkHoc9icR2F6PUn25Yue6NHiR/Nto9YZa+qE85dThnbFAkOUYUcr05PY+SIad4aiRHiqagVluPU1BsKjmDL/LX3zPmG2pJaJtfOYj6P7bvHDV7DWdXqbxF7AsFhYsX5hEe3Hx38B8bzoTCFKeeS6kJuL0AKcdwYOyqS/G0a+lLXsZRVyTwfUvePOWhiUpwTeng8qMzSFAe9X1XGHCq9dA3yruqLNnVLNkcxQNtYGNQmIkA/UpTAArkd9Z5fjG8UgOK+Zk9kaCYlm9McqzjFCH7WNjx9HfXgrKqOzNpeCfbg2OWRjThiO8dTzFtYrxOqwZD56B09MVuRrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp+k1rdDLFvLVftIV3kfo1K7DQqs0zfla0Di57gRrWM=;
 b=oDTXbD43LMwshrtJVVlSShj74nJTJZGaqF3/tdrlpeXDnTDD2LWrg8Ys6kAXSBvosLTF7HSp7mBEls2S8OINfzh1YblOhcOpPJlL3xx52rOjps+bEkFFVFppf7RIEcl5nEP2PcJVFNQfh6jGNxUml4wcwmi7q7W43LVGV9qS/E8bvLDLG2gmuaY5ZW5do42QUKlLT97yd6hYCUB9mY5G4It3berYdLz7PILRx4GXWwFOf58zlOZWHIF9kBF6xvE0PxYNqSVf/9tFYO6AZhaaP+XgH3/7RdZ0iPDAy6S4d+PQGLfaj/HANR6WqbNDVbq0WadcWE5Qc0jIFHm3hrJ2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp+k1rdDLFvLVftIV3kfo1K7DQqs0zfla0Di57gRrWM=;
 b=j/uZXfHfy9GgnvaZbIIDCjidcbXdyNNrCy/eD4CrsduJxs/GL6fwh+1jVwvb0mBzu/gIQwRrxvT0xjAWkZxj/pI3o69pIEQBZyjWJA4yf8DHmsrCET6e42QmLjifEa3MIn4s2XORFLYrpXu2VcxO27UOXh7cPpEXAQSq4mAT8Sk=
Received: from BL1PR13CA0344.namprd13.prod.outlook.com (2603:10b6:208:2c6::19)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Wed, 10 Jul
 2024 22:06:26 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e5) by BL1PR13CA0344.outlook.office365.com
 (2603:10b6:208:2c6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 22:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 22:06:25 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 17:06:24 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <shuah@kernel.org>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 3/5] selftests: KVM: SEV IOCTL test
Date: Wed, 10 Jul 2024 17:05:38 -0500
Message-ID: <20240710220540.188239-4-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: dcee6cfe-8739-46a9-3900-08dca12c8abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8AoOM+6Qre4pbeM2nwMk6QDCzib33mcc/2j4TNQ8NJKpaxvkTU+6UWfmwLOU?=
 =?us-ascii?Q?hQawqzC2FsIeYsmZR0QusQq6YtoUfcUnO9Z7PVzMkh4wezqe2eWWhebbZHzl?=
 =?us-ascii?Q?o48MoJIMuDAYf163QasUDzJpobXLszQrGdL0ASMNCSVR1Q8pAnuRUkZr1mmD?=
 =?us-ascii?Q?J+dpZPnhePR7RDGk9xBALys/Lx4twg3lfcLG6Dcz0OzABSUzgjo4xYo/zctp?=
 =?us-ascii?Q?okEPQMRur2qoqiI0YHnJMNOVFHOtOwDzg9i4kCUr3opAvf3Ohr6QuBqMQ+qT?=
 =?us-ascii?Q?mZM3DqTrxhorzwQKV/nRHBEiirufTMg9fyWSIpwJQ61quu4TNrbsA6sUm7zw?=
 =?us-ascii?Q?J7hYwHz2Q6vS+0l9Nr/MgPJXvM4tF4w/PbU5xfgsnbkHZvBPzPmhMt3mUOnq?=
 =?us-ascii?Q?P0xUo6Oj0sFEWltZ58AnEnZysC42WahW0WEYRK6bwOrX3EQKxsem7hB0vi85?=
 =?us-ascii?Q?uoQyQlYoC4J2c0ph1ZzcceHnYZnnA2t82nrBzkF8flu0c/QwT/BZRclASzA3?=
 =?us-ascii?Q?vZkYzYTexcA+plzsjtSzLmMRVvymX9trpIb78LuwSInt7BbhwOaqDUinZOu5?=
 =?us-ascii?Q?96+crOBDbeGC5v6h+jiIdDDxuhPW+nc4Ip5zJKT8Ez410pm/x5Q4m1anZESC?=
 =?us-ascii?Q?7hk3Zzyo3ZVWB1xhryyxCV9WmgwV56/BeFILdKFRUcG57/S2h1oKxaAu8JJO?=
 =?us-ascii?Q?l747GGjBVGzgN6Rk638IBApuPP71MqUwRrSi1R6yRxdht4fgwQhtu4JvOhtG?=
 =?us-ascii?Q?3sx41nXAPR4U7SKNDuZhVTmqLeu/neAjHpsvsI7a3ciSpYtX8IbT+jtpW0BP?=
 =?us-ascii?Q?lV+xLByAxt8NGN7IXKff/EgpsNLndtYD9TLj5UUcnSmUniLS6hp1WX8iJLoS?=
 =?us-ascii?Q?/ppSELD1DjQsIm9riPmK/OppX54VJJyHSj19WEMfrLGKyeScPBUGeeIKBB1Z?=
 =?us-ascii?Q?5t3hjmXT+XSqFhPAkqFkE/6Egec4NjuPPPLcWFt3vghknsWkj3LYgDkax1+t?=
 =?us-ascii?Q?8gfpqdWgSdVj0m0JVhxq4tKNsdRIgbSFVh5IsvjPxZxrO596sz+q3lCW4nIN?=
 =?us-ascii?Q?mDLwdHLc45yGuMaKQkcZ1mgwtaFHo99pZKEBioxWq0TyOPgD2vxYxncu2emH?=
 =?us-ascii?Q?ncp3nKXSNeMQhTz89hMwyXGVZ3Sre/Rg4geJ/Oruf5zVDdC9O4Y79evkvCle?=
 =?us-ascii?Q?FYRBEuDRo01zz6qWx1MTqrmXoeyw5d4ZWqVC3t501qlCpL6yGrs2yjaXNrsY?=
 =?us-ascii?Q?RRTnpsjavNf9+JQnwP8HpYRGkuAQ2X2pIQM2vfivsCGNQEhyOTuxQw3uloM0?=
 =?us-ascii?Q?5NIrHteeL/o77+hXn4h51naJhntJlszOigGL4WVR34wg0ey/W+9NmxTyaPy/?=
 =?us-ascii?Q?iTQssdrMmbePh3oJDcQiqrDwAEKHtm6b+y4ZfMrcJ4+D92isIKcbaOGOWnH/?=
 =?us-ascii?Q?0ZiHUge99DqVv69qacorUBiFBKh9720n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 22:06:25.5582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcee6cfe-8739-46a9-3900-08dca12c8abb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

Introduce tests for sev and sev-es ioctl that exercises the boot path
of launch, update and finish on an invalid policy.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 1a50a280173c..500c67b3793b 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -131,12 +131,69 @@ static void test_sync_vmsa(uint32_t type, uint32_t policy)
 	kvm_vm_free(vm);
 }
 
+static void sev_guest_status_assert(struct kvm_vm *vm, uint32_t type)
+{
+	struct kvm_sev_guest_status status;
+	bool cond;
+	int ret;
+
+	ret = __vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
+	cond = type == KVM_X86_SEV_VM ? !ret : ret;
+	TEST_ASSERT(cond,
+		    "KVM_SEV_GUEST_STATUS should fail, invalid VM Type.");
+}
+
+static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	bool cond;
+	int ret;
+
+	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
+	ret = sev_vm_launch_start(vm, 0);
+	cond = type == KVM_X86_SEV_VM ? !ret : ret;
+	TEST_ASSERT(cond,
+		    "KVM_SEV_LAUNCH_START should fail, invalid policy.");
+
+	ret = sev_vm_launch_update(vm, policy);
+	cond = type == KVM_X86_SEV_VM ? !ret : ret;
+	TEST_ASSERT(cond,
+		    "KVM_SEV_LAUNCH_UPDATE should fail, invalid policy.");
+	sev_guest_status_assert(vm, type);
+
+	ret = sev_vm_launch_measure(vm, alloca(256));
+	cond = type == KVM_X86_SEV_VM ? !ret : ret;
+	TEST_ASSERT(cond,
+		    "KVM_SEV_LAUNCH_MEASURE should fail, invalid policy.");
+	sev_guest_status_assert(vm, type);
+
+	ret = sev_vm_launch_finish(vm);
+	cond = type == KVM_X86_SEV_VM ? !ret : ret;
+	TEST_ASSERT(cond,
+		    "KVM_SEV_LAUNCH_FINISH should fail, invalid policy.");
+	sev_guest_status_assert(vm, type);
+
+	vcpu_run(vcpu);
+	get_ucall(vcpu, &uc);
+	cond = type == KVM_X86_SEV_VM ?
+		vcpu->run->exit_reason == KVM_EXIT_IO :
+		vcpu->run->exit_reason == KVM_EXIT_FAIL_ENTRY;
+	TEST_ASSERT(cond,
+		    "vcpu_run should fail, invalid policy.");
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


