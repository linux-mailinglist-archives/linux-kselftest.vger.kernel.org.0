Return-Path: <linux-kselftest+bounces-28356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCCEA53DDF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DBC169F69
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76020766D;
	Wed,  5 Mar 2025 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f9cFY8Rv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97320764A;
	Wed,  5 Mar 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215738; cv=fail; b=WmWm/Hoo8v5hZxnE7U7S82Huya09Zy239HOJpg8WjLNKdIrekKYmtux9RqDEdQCPbXxOXJarmJEnAeyAeb94VMdRYDGpLrKGP7HeaLl8Cv05f8oIM1J7mUhmR8TvZxOkpvR9FEc6vVXuD/ZVGSyq1XwnEt7C9gPOjSdKH9lDQB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215738; c=relaxed/simple;
	bh=8Zm+saQvm3iQHWzwa0AFasdrYzPnqdivK+SQZq6xe0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYaAadahDPU27iLwqD9Dl7MtawwKr2ccNA5cy8/6C1OmhRYSSBto5zbqfHn2BtWM+tVOnn3OhDPrQDEmyWzS3E6IpHukYfc9Zq1HJG8EVC9S+vPd0p+sOPA/EvyAWNdV5W2xB3wrmtTZF90axk3aSx6jrgoxca9Jny15jhISGqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f9cFY8Rv; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9YMZUzAum6z2Qbb0lqlSB1EHkfasJ1LuF4xzG4Kx/g5Th7haUH+g80L6wmOR2jCMDVAS6bsCJNTfaz0eALtWwyGxUvDzM+kZ6vvGJhAv9fHzydzRo9Ylg3sukoDSm81dILO71STppCoZ8KwcnhAfnn85yImKsxYAHmntrTa+3tE+OFEGiUL8WMWa4bAFO+xNg1iELfomukiU8q/RuOniLQyGNpqOeoKEQ/txUmrepfZpuut6CpN8URehJ0cCZvlc2n35pU4nHxkk6m4XjFBGlcIZTvx1QNcE1df07+jEC53GMRX3MsDV/K7s05b2+M+MK2iq5BOo/va4Q+Ed4rExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hECz9pFVz/suIaR60vbxBLgnenR1cmtTB1A+tesJQlg=;
 b=gkMjiYxF/y4jkSYc4HxslKFQeJle0Aj/veHwa+NNXNg5rt8WfdSzz1ZaABDu3vzrYa1aXRS/CcDYUMke81KAleQi2hp5xvN0v+pwdJG1NFGpDs6nr2BNraFDNkNLApHRs+p4wLZoay4XkqgNl78pSFvQ+ExNba5XrhEQYi/olXxiBm1SrEoFm3h49EaITCrysr/0pkZWupmWv57rjhbV7NnAt0SY9HnK6fBt1STFXOH56LWoPCHKAFNXgFhQJO9462oX8o+8YtwhY0YYHpDfOCXij5zPP3nkb7NWSIMmcGEs/tWyeTjjTTRCckmbG8uM4EK1SvmIsmbALowtGbk/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hECz9pFVz/suIaR60vbxBLgnenR1cmtTB1A+tesJQlg=;
 b=f9cFY8RvGv4rrOxi2n/ac8PtoZcf2s2XQcf4adBfXZxsudB7tDNO6xnCTLli9v6Ur0MH7EFbFCSqPWus0GnmKrDrJNG4rBxzYV4Eja0fqztdtGnS/OpulXIe4C06y/vxrcSf8artEHigswB4NmFpZiGuGOxSyJpvpcujjNOIwfk=
Received: from MN2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:c0::25)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 23:02:12 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::c) by MN2PR05CA0012.outlook.office365.com
 (2603:10b6:208:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Wed,
 5 Mar 2025 23:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:02:11 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:02:09 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 08/10] KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
Date: Wed, 5 Mar 2025 16:59:58 -0600
Message-ID: <20250305230000.231025-9-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b35c14d-64d6-48d9-e6cd-08dd5c39c377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3liftS6auFeKJkTP9Ub5Ll71JKVuKwpRkC71fIs5tF6L0wUWjKaAnFnumUIx?=
 =?us-ascii?Q?dAoKBwpzeJSwOJ4PSV2Jc06MunAp8oR3cZes47n/jX4n0/bVC60moSxQn2cM?=
 =?us-ascii?Q?SX79wl4rzRDkkdXQjj0uAYPvMu5gQ374iZc000Yxzh4ake3kP/v44aSPjpJV?=
 =?us-ascii?Q?fwH38Zg8qGcfcAesfgEsGrtsMx4xQAWOj0SWRpgoiukNbKNPtctKWsH1AHWw?=
 =?us-ascii?Q?g+IDmAMOwph1LmFujTT86pQr+aTvC9Irz0Dhe6VjKZGd1R4Z+hVenhi3sRC+?=
 =?us-ascii?Q?bByZbp6MPaz6HunoeiayjaqfV8KxIo4I/7vG7kdS9Ce5hcDJ+uDzIrMk96QQ?=
 =?us-ascii?Q?maiuId313ndbzaWc9DI05Vv6+j1B5BqeW6s44P81+uF8ErttRRJWFxFkc2Pw?=
 =?us-ascii?Q?uQNbeO7Meulxiq3m1rRDysr2egUE2Q/1wCGPgiqj5lninasNMbWRIoipkcmi?=
 =?us-ascii?Q?ZENU3XxhPxAp9kHwz7VtlmPZGQgU8+wqk7vXFODDL25bOZ389dXGtigI2GjP?=
 =?us-ascii?Q?KglDmmz8kgTrLkDX1e+6PU6gDbM/++n2oVTZTpbDbU6aV1eihjPx85z5nfYH?=
 =?us-ascii?Q?mI4z8Yms+2VHRxbadQI2chjJOpR0U6rAL4WCQBn0uWfBjmKVmdEfl2uBqDVc?=
 =?us-ascii?Q?tF7jez9eLN4XxgIBHc9wngcYQkh4CmFsfczdZP0EJfQqgXBJWZnlD9WYk7r4?=
 =?us-ascii?Q?EyTGHc01NO/pLPsNk7NLM7I4KNubW09ECp4JtLNJBFsdtCqDF2nDJO4pSLCd?=
 =?us-ascii?Q?azBwzqlwh5BO8R95WS7kM9o1CCzn+jUKyYUfwAnWeuWzDC7oRJWBMR13Iv21?=
 =?us-ascii?Q?Kygmd5P4KVYuvltScAdOdKzZxRktvs0pycvISJXYSdIqOzsHMvrISaZpwa+z?=
 =?us-ascii?Q?9biN6BcjAusSWQt3ferlbY322WTw6ja3C8pT7t+zMzHpI0WNY0b1wgkV7nke?=
 =?us-ascii?Q?mvWPwsp1ZC6dVk2IBFBpU7HU0eC4i+MlhI1aLGKh+4TBUcBxhfCwAgDvkPJ0?=
 =?us-ascii?Q?6mxlLYbjJ/jrf9KvTfGcBCnVb7le/ZPe7oshMhvbfw59zziPBmSv4Hlhi5bp?=
 =?us-ascii?Q?SsCrZbWcAStgyRRa2bnv4SyQXl2yqMkLXg0Yo58yUrnWUPS5zY54p4feREpy?=
 =?us-ascii?Q?qH7qvIq3j2CJ5EMVMyPLTOgQCzeje4qWzNXff+nYXRS7T1XxGQp4iRBK98Mq?=
 =?us-ascii?Q?2Lbh2uyPFYFw8MOyZU65Cg+Manx3XOslfxsvYdx43gtwAN4Zy6Ps8W6BZ3Yq?=
 =?us-ascii?Q?VvwkO7NZk9MRqUEtIDB8wvsW0VdJ2EqxRXFF/wnY05oLUeX/x/MLskx/gCaF?=
 =?us-ascii?Q?eYvl9Kslbd8yb4hfj7Px8k/0qMfSzi6xg0ZZpZJq7eEKMvmWDyE/5FNPGumL?=
 =?us-ascii?Q?XEzjtWc7j2cxk5EcuFHvtJO2JzeGG+/DuP11bTk8jWqJDGrhs/x258Y8x7BG?=
 =?us-ascii?Q?xNmPIpUQp4kqCv1uzB81m3IZLXTrTS8y2l1X7Mu9gzbBA8Kfs/Bhvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:02:11.8315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b35c14d-64d6-48d9-e6cd-08dd5c39c377
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467

Force the SEV-SNP VM type to set the KVM_MEM_GUEST_MEMFD flag for the
creation of private memslots.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 33fefeb3ca44..089488e2eaf6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -413,14 +413,17 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
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
 
-- 
2.43.0


