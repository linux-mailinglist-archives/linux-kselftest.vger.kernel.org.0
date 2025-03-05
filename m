Return-Path: <linux-kselftest+bounces-28359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E7A53DF6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0CFE7A421B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF7207A2E;
	Wed,  5 Mar 2025 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KHf+sAxf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8622066C8;
	Wed,  5 Mar 2025 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215777; cv=fail; b=en27+nFeez4PKZ+5lwKV2VMn+m8uvxMR3UrJB6Gx10nfXtltenLhDB61rAqPt/A32Hk6DROJALM8DCnF4hnz248VjoGSaFP5YYWWyoUjfgOgsY+nF7QyqNUFcIztQUWMEhsgoxVsOrn9b3T2cAhq5EhOj2Zy1sNCshFWuwWY7tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215777; c=relaxed/simple;
	bh=qen85s0LwJUlM5XBA0ntJFYWNvR1Ym8iBLEMugdM78c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJmcyuSLeLHD148l9BTm7z+tYU+xwMP2UC9weARczF/9SfbQ7vbSQhnQaKZR6NXXdOyzFMI4yEde/H46Gjb9lHGVv4Gam0lxGiFrfSIOA/bi+/Iivoe7+LBxSO2OqL1xmCur87VRkuZYSfGpT/h+nVb/gFMx76mLWUJQTN1JmHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KHf+sAxf; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMNpB00mTwSBN5CtgE13iXM7mfqi5VHoZ2KBpHlr2RY9LHuaxxdFWFSUUBHctCkf1j6cCO6j4+RnSn3YnNfnSCYs0I9Cv3Oo+gzEGu1t3KMsHnP6m30eWLGJ68X8jfR4O8KcMbSYG6BMisMF1I60v49PyAbWwSIIrbEK5JC+o+suYG4jOgam5i8DWcgBFidZBnIhnwv1aqz8YpdvBrYkWRY8DFN45HmZWH02S8ZWcqHHvLLiqpt42qIE0iEfYuPczH56b86yIWAIdvDOKFP8OuhPHa4eNHtHHFvNbsEJBRK493zNJzfeSC5Hw3kIQeLBICFNO4BXRSaZNC1J2+Z1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9baNceY/XMXT8QqzJ8sp90hyfzSXu0IJEsC0zfNT0pw=;
 b=b4CDIBJplt6KszvSjiH4Bdwuz/Z+lHuuroPpn6BkgfuIr+jUNeIN7vyHrVeIB/1qeH9Bh3bq3INZLtTJdEiHgpPO2+VviYdfWPj1B6n/HEhhiyUdSg1EB9A2PAlDxwT2TGmW2kckGj/6sW3X7v2tlcnUjTwumeA7ruvkWkriJYLriaL352TFNHPNOho3tSYAQQnPCFt9m1sLsmuEqWlxymKwywF5PrYvSnQ3yddxIrhUZvYjTo9DCmt5vMoPrRq9YDNCKaY5PKf/aplf9MKzP0VVAiK16ShBQKK2JGocSu7MUtkH5hRoq5R1upRbClRK8Ik11POqcVeWkUlbh6ekkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9baNceY/XMXT8QqzJ8sp90hyfzSXu0IJEsC0zfNT0pw=;
 b=KHf+sAxfA03IDyn2bS1grTswldCDRwabDQMvjOn3RmfdGfiCGyvTvA/5O+3GZtpijfgkjwZieTFmZ8IdFqCwAdq70yXoghXeP+eQUO5Vog6+sPxgE+u1EaoKJHHbc/M4TbnIhu8gdu7MKQSW8q6mue8ej6bVEE2mq+SQ/facsbk=
Received: from BN8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:408:ac::40)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 23:01:35 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::fc) by BN8PR07CA0027.outlook.office365.com
 (2603:10b6:408:ac::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 23:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:01:34 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:01:32 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 05/10] KVM: selftests: Replace assert() with TEST_ASSERT_EQ()
Date: Wed, 5 Mar 2025 16:59:55 -0600
Message-ID: <20250305230000.231025-6-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305230000.231025-1-prsampat@amd.com>
References: <20250305230000.231025-1-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 641d654a-2d02-4197-fcd5-08dd5c39ad6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L7trnC3YWnlSBiYeyjdYz8vi8Keb3vIh54005a/tzJAhhJqEj+EcWDqdoaLw?=
 =?us-ascii?Q?Tqj5UjXyoZusJDNtfurTKhQy+/S2PhQ9arn8i92CyeDwV82b58wpfgJEgi82?=
 =?us-ascii?Q?e0Jn5xUROKj43UU8miUKxsAUqF4rZQEmHlCjA61j06H6nNnvI7nL6MIv1egU?=
 =?us-ascii?Q?tXc0Dn+Y5YcGmwCnnQntr2yeb/pMr7+HTRYTTn+izlk3w2dZWVotzyWGUaw/?=
 =?us-ascii?Q?if5SD1FktVy27Pe29bvbC76mDFkdR6HWt7LWHpQUX9TOBoep9XlLb9a/XvDb?=
 =?us-ascii?Q?xxyJ8sfP1bT7baODoQNBB6xS2KhcSYaSBuXzSRQtRChoRdK0xto8rdQQ8HOD?=
 =?us-ascii?Q?QZnid8s+Fa5K/jLfAhva/R06z56ix/JoAXQ3o3GJf4f2PSimXZV3flUjG+kq?=
 =?us-ascii?Q?CHvfl7xOpioMdjjDfJ4qWZqFXJMluN70ls58FnHz3+mr7A4B6hm7YHHL38rE?=
 =?us-ascii?Q?5j25HaXeJXb3WwwBpcE/ka1SOd1wfFwVrxgeR/8/RLt2eYqh+elyEuCSmaUF?=
 =?us-ascii?Q?aUBirCPBzgGLHRoku7fadga7gWT73/WcPQhXlm91diBXJsGf2p2tFacF2qqO?=
 =?us-ascii?Q?XO9+axLR4O19AU7zW53OvifrFj2XPw8GAZ5JyY36B3Zawdpy6RpZaVKL+VKq?=
 =?us-ascii?Q?Sh/aGSmaZCd1DeQBYs+HMAWdC2gqR3S4rC1h7PgeUdyT3dOnYOzFMjCJHLhe?=
 =?us-ascii?Q?gVF2QE+i+WYnIiEq+Kfbvr72+ogkjGo8DcsJWoPtwrSLjI/C4EOhRHqfMhEn?=
 =?us-ascii?Q?AqlO+clXVhRw5Xvwi9nbWbyYky8ZDd5Sy0ek050E1J6PR42i55SPpJvxamyE?=
 =?us-ascii?Q?wOQX4INIEYSzqwaej/hxF9gKYAcqU0NaTyfOLerV6IdchX+dr+Tb1QogChih?=
 =?us-ascii?Q?sSmLgwvTSjqs/8Ev9oQkRckveb6qpuPln6MO++FlnL7jhy/YkLCAnF4e6SLp?=
 =?us-ascii?Q?fv3sfW1qXIzuAd7wEpFC2GJzR0knvky49uf3JMqNY2zsw0d/iM2sNGWVI/TX?=
 =?us-ascii?Q?RwXwEeMjmBKjPOoh09T7ynG1bN1crIFHIiZluVO1eAQqBWZuM7oHHrJC9ykF?=
 =?us-ascii?Q?qUxD6WjkWTHW22XT8N16OeK4eb+L+KzboKS/o7R2reRcWkyIBUIpNpajDyQB?=
 =?us-ascii?Q?crg4M+K/+zBKoXQwLczIuUw7HSWgWwJuiRdsqH4vWkUQygsaOiblbSXRHrxP?=
 =?us-ascii?Q?ZSCMUJgifbcfsPWNcSGRlm/9YXRAwASXKM/kXIUB4xOUBfh9FbnW6E+LDOQ5?=
 =?us-ascii?Q?WLe6u4MgF6Aj3P2FWquXdQNTAv6ArvekMAvgm2IpHhvOuHwf0LTbho/C8Gde?=
 =?us-ascii?Q?BZs+yQ05ANrc9amXJWukOmrJDbJNQ0ZhS36kY0ZpM22zlwYBwJhA/Eq3rdN5?=
 =?us-ascii?Q?pnto8A2SWlKHBD+DUBXt1CJ4SSSKZWwXdhSDhBTdxzuYZZ87opRgiJoMmiaX?=
 =?us-ascii?Q?n1WPGUCgRPtoDV+yBw73g56KRIRH5ITzX4nFfdfI/OQnf7U9qoWjfg6vJUg0?=
 =?us-ascii?Q?W+PzxOUFUXpfYLE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:01:34.8501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641d654a-2d02-4197-fcd5-08dd5c39ad6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629

For SEV tests, assert() failures on VM type or fd do not provide
sufficient error reporting. Replace assert() with TEST_ASSERT_EQ() to
obtain more detailed information on the assertion condition failure,
including the call stack.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index e9535ee20b7f..60d7a03dc1c2 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -37,12 +37,12 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 void sev_vm_init(struct kvm_vm *vm)
 {
 	if (vm->type == KVM_X86_DEFAULT_VM) {
-		assert(vm->arch.sev_fd == -1);
+		TEST_ASSERT_EQ(vm->arch.sev_fd, -1);
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm_sev_ioctl(vm, KVM_SEV_INIT, NULL);
 	} else {
 		struct kvm_sev_init init = { 0 };
-		assert(vm->type == KVM_X86_SEV_VM);
+		TEST_ASSERT_EQ(vm->type, KVM_X86_SEV_VM);
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 }
@@ -50,12 +50,12 @@ void sev_vm_init(struct kvm_vm *vm)
 void sev_es_vm_init(struct kvm_vm *vm)
 {
 	if (vm->type == KVM_X86_DEFAULT_VM) {
-		assert(vm->arch.sev_fd == -1);
+		TEST_ASSERT_EQ(vm->arch.sev_fd, -1);
 		vm->arch.sev_fd = open_sev_dev_path_or_exit();
 		vm_sev_ioctl(vm, KVM_SEV_ES_INIT, NULL);
 	} else {
 		struct kvm_sev_init init = { 0 };
-		assert(vm->type == KVM_X86_SEV_ES_VM);
+		TEST_ASSERT_EQ(vm->type, KVM_X86_SEV_ES_VM);
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 }
-- 
2.43.0


