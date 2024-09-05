Return-Path: <linux-kselftest+bounces-17228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284DC96D90E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB8D1F2B942
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F619CC01;
	Thu,  5 Sep 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wg/g1OTN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8C1A01D3;
	Thu,  5 Sep 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540133; cv=fail; b=iyH1BrU90dAUmmG8D7KVYo+hhNWW+tmiREiW7DPEQFbq1nIn1Us2rqGUFTzmBXLXqzlKXQ46TMJCz6XliMYWyLaaTUQgMl/tr8IEOJXRB7SMSy1w4IXcgJjNCF5/f+lzhs1mlilJN9OsruychJGqpEWLP+9SVzILb16bpuCcxD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540133; c=relaxed/simple;
	bh=srOAcy/Fn9v5xu4u/RA3DjG1mfNTFVpTISMEILJuc4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3WURbXheiFDunDn6wNUgVd6uVna7Ho8bIF8nrlNJDS1Lpk8wzzECfCkkruGQO5NNGy09o2t5xFb5XItO4mhHHZFCCQIOke4OT6e7/ttuXE4jUsx/yyHa5lqYS81OGGUaSB48upsOxVtEUIVizbdxLgtfT64pA6oBXKgo93mXS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wg/g1OTN; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifBK+LACMQsJhr1m1sadP0PB/O3fZRYyFtgWrGNAessxUA1/EgJlgw4gMd8h1W/Js+7pTfAkZqhGE+YqUnHl3XabbiacUkd2VWhgyKPGM1pmnBsI90+rl2hB+eNJk1Izt9n9t+H45f9KGGe/VI+BAj2t2mazEb3ILEASeOpzXLTkzMIrLGi68nErNLpXHi75z/Vt9c56rCSf7f+R9+mrAHQLvhLjkbovJ48d/wEqW2Pv7MjLzpXhsRO9Etm6YkU91HSIoOkhSMC//DYyXay4BeHJURZgqxSiSlRVAA0SwoFs2hfBX4TA73BCW1+8XGo9LAAnTvTMf70G0ZtbIqqD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI1XELw5Rf5M5zqREfMHQ6JMcc9KN9dkEpbr/aO2VHI=;
 b=P21fBiKT0KGEqrYOEVCmWIyVks9DFq1ZHqMkPu1XkMe2Ox1tI4rb5fdLjKg4H1hmBaKgK+ceWjpS9KuBB8SHAWbPT6M1kRrNZ/0Hnf1aJ7rzuR+GeHY8/1SNmIsHWkTAsK9WOAWGEKayg08ETCT16yfMlXjp+hD8lDZWN08P+qB0ZQjwQdJZR0lgcWIzgfWnWS+00Gy/f/vzRKEMuSO8vwKSaMiGiBIc+SCsEvTptLDdEBtmc00FbxWaARzfda+MJZelezFt/rqKU9hrGqW/6dEFU2lajKKgDUdfQ7nH8aBOLPKOfu8Q/AuTsYQXVm7gjeLYwXws1qU9V3I6Gb4+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI1XELw5Rf5M5zqREfMHQ6JMcc9KN9dkEpbr/aO2VHI=;
 b=Wg/g1OTNnQn9szkffyroXgvhcoN90MoCQdHRQiF3i4/shZ7VKUhF4W2/+4OGGfmy/48o4eqKSRBTr0/KMHn4FtRcp9+qlaPOmrKHgn21eOs76J0jPezouABN3ofAAly0cwnvynutRUG23vg1BIkahuWi5udTWRB7UC2xWHomjr4=
Received: from BY3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:254::12)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 12:42:07 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::22) by BY3PR05CA0007.outlook.office365.com
 (2603:10b6:a03:254::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 12:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:42:07 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:42:05 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/9] KVM: selftests: SEV IOCTL test
Date: Thu, 5 Sep 2024 07:41:02 -0500
Message-ID: <20240905124107.6954-5-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: acd33b14-c9f4-49f9-603f-08dccda8272d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQEJzZ4Ss8SXavonFJHyrWeOfyEhNJ6bLOX3VJMcJBBt45yG1pMnoxtFpJqU?=
 =?us-ascii?Q?L0g67vQYIdXPLfvxNtYAXdlwQ/IIy0OkI3KFHVFcGCoHTQnh9MwMrYR0rAcQ?=
 =?us-ascii?Q?q6s9H/MrThS8UU3OP1n83JhsxOXA8I1nfFm/+ixe+9Haeo6x4oRO9kw7UYi8?=
 =?us-ascii?Q?l0Dg4S3zHiKvLmBzmJM1DzMhOMTSm3oh0rfN0QuOJbeNd9KSyapoVPm7/0H7?=
 =?us-ascii?Q?wmgAJePyNi/GhWh59QbYouHnmLArmAaJiJOPsQYQxSj1XpvQkrLC/rB0kVCY?=
 =?us-ascii?Q?M77Fc9+meTd6mssdT/I+xcbEDNPBNmPs3RNL6u18KPPu+Dpv96onE7Y7i4FM?=
 =?us-ascii?Q?HeA+CghXqLM+KAwQWZP3bZ2idY093x7E7WvbnbeH2KxFKZLCbcJuCcobVBqm?=
 =?us-ascii?Q?Q4zBiA/VrdRxrIvZqWQGwvcVJew12DsswMSkWk96+T6CHxz55lSZHP56sg11?=
 =?us-ascii?Q?KCFsnWjyyIH8hdBEwTpAWt82Da2q9iie3HbWuBslkP3LHinEaIdtuzJxqNsN?=
 =?us-ascii?Q?I2f2hMjISgY4FJabyhrH5W3z7S1sJ21NN8SJwgSt2QIgAqNCIUbCp/ZaNhV/?=
 =?us-ascii?Q?ikOCvhxWHV1Uf5gu/GfHrkhQjkXUrrXe2OHKmpzVBDfH9jDdTxsWs8vDlX3u?=
 =?us-ascii?Q?24YpvN8g3GDe4hONSB4dDepD+GVipieph4QBleDmlIOj+656UgpP+2RJVaAB?=
 =?us-ascii?Q?Le1PAYJJN+ADWBn7U8Qmot1RivD2qDiydnriRL+fJoFwZn7EvSqpg95Lyzvn?=
 =?us-ascii?Q?DgrU0pWO+rOJIG7h0rxbdN/Vp309xPlVKuap0cKEQKr7Onn2KzVl91t4FXCp?=
 =?us-ascii?Q?estyAnAXznswiS3txcC38qXCcmVPYq67hND8DtfYiLo/GaJXeMhRRxqZ5Q9O?=
 =?us-ascii?Q?oDklnS4W1YKMWEQiT8ycu3i3+L/UVaOZgzRQY+V8n8vAYvvm9iuHukMKUaUo?=
 =?us-ascii?Q?kRj3EVxpB3ayr7D8CtsND1dDoJ2pHn9KhswQFvQUphPwvJvX5LxyPAlcU5cE?=
 =?us-ascii?Q?jABfDXx8i4oa/Y/5ZGkhlRYpfWyw2vFdRpDPbbViAS04F3eSyPSMKvRaZco0?=
 =?us-ascii?Q?oCApEdUHoOLI/TH20fFVMlBljq3jGdl/W4Exzk+ZWwFXzQf1HI+Hcvca8BdQ?=
 =?us-ascii?Q?AbQW5+XfFn3q0c5r+xZL9/tG17eu1xP/WVJMy7/T4L72S3YjWf2pqRjLBgNj?=
 =?us-ascii?Q?c16LkABUFkv9nRSOs+ZrD/bsWjh4pDXJrUb0BKyte+1UFPTAinATsa/s9pUB?=
 =?us-ascii?Q?Q9JrXYNblUA6CBs4gg61/W0OX0zwnB3xtqUouo0cUw9ILqADDC8LyXM5DGf/?=
 =?us-ascii?Q?ea+O1T4khR3rkmA+6LoESaPNP6ydaIKCD7hW0oxV5wnYoOX24QEkqOrgZUCq?=
 =?us-ascii?Q?YEW4LmdiQM1z5qhSN3zNaLy1FreGhT/HnPuk/nP+RTU1qrbm7JVo9bYI/DCi?=
 =?us-ascii?Q?sHd/oRP7c74m8plTe9ZOV5j3rY2VLdVE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:42:07.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd33b14-c9f4-49f9-603f-08dccda8272d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423

Introduce tests for sev and sev-es ioctl that exercises the boot path
of launch, update and finish on an invalid policy.

Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 8e798f5a2a53..5fa4ee27609b 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -142,12 +142,96 @@ static void test_sync_vmsa(uint32_t type, uint64_t policy)
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
+ * VMs of the type SEV and SEV-ES are created, however they are launched with
+ * an empty policy to observe the effect on the control flow of launching a VM.
+ *
+ * SEV - Expected to pass through the path of launch start, update, measure,
+ * and finish. vcpu_run expected to fail with error KVM_EXIT_IO.
+ *
+ * SEV-ES - Expected to fail the launch start as vm created with type
+ * KVM_X86_DEFAULT_VM but policy passed to launch start is KVM_X86_SEV_ES_VM.
+ * Post this, calls that pass the correct policy to update, measure, and finish
+ * are also expected to fail cascading.
+ */
+static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
+{
+	struct kvm_vcpu *vcpu;
+	int exp_exit_reason;
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


