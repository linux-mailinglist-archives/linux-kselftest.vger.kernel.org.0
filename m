Return-Path: <linux-kselftest+bounces-20231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC29A5A3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782781C20F8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 06:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99012194ACB;
	Mon, 21 Oct 2024 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LroLCCvv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB72BA27;
	Mon, 21 Oct 2024 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491830; cv=fail; b=hNehfsdaBNTpF9YOy5+bQdMcMYayiS390vdcvGSrHe/OhLOZufO4huPw0KFu153WJEyGiuF2Z24mw007z3VmevE+wytqpKVFK6BqYGO1V4PVLch5bVcTqrd/th5XuAPllWsHHDy8SDCJiTEErQVcooojEic3LiDLFmCiw9NsPbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491830; c=relaxed/simple;
	bh=cek8BVY4ENfOwzH3nqR6LJXGgBVqLpDsh3fWSS782PE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ckkzEwsQgMrCEeq3v9ABw2PwRPLjV55qLHUp5ORqzJdGMMc3GjdBdqrxsf8+XFUNHU2P6CJ5KB/2FqDJYsajSHpbmF6tSYNxHHJoT0N1MRWXrJ/QtQsUOOdUxq+Z81uHn/czRgrIJLlc94N2QEE9eJ1d3LQ5os3vC/Yw1SMLwds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LroLCCvv; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE7QgLPTta66mAz/O94qmztJNCcamlisuR/yEbuswn7lGml+uz4Y6OuDRbYYhuT9HBP3Q2doVc9026HN82zGQqvIEg2ElxuyE7DiZOfPH+NMk9Mw1uVHRz0d7svCyHUm/gDG7nIHtLg9zIGQ3KqH8MH4g7NrKuAb5GdM4fUo041I2pyyQaYAzJP6IGh7263jGgYAz4ZvaAgSPRrvymZd1uYzt1+F4psLQsz7XBCJsGGrf6AVbjWyjkUIfZfqXHdOfqbMGtMApsraIxiO9sAcqwRnCPGOoUuV/+MnH6z9nw50npuInjaYNJz8sazCFQE0epNXL99Ym4GTluo3LElSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2goq7D9UrEqNL81CbHnhUobG4WNRDC3l14Y/J+BpOKw=;
 b=bgHzbd/kTAB1cPtufkU7cI6KaDXGevXqJpPcS1nwGnWpBzqyQUxVaS1cILMy3WCWkfhYlqfOGgRjkozwRxrzXerrydmzlkQIVlkoXFTi+hNhqS15l0Sw8uv5JH2Gqsp57kGdQ/3N26h2HKzw37fDZQ0+PclamXFkX22BoHcyx23fiWyT4S94T/xvGCCE/o38VkxWUlUo4JcgbPD7HaiodWbugOJ/k2B8qXz9GN2G+c5039aea+zYKhP2u4+XzY5CfU7gOBFHnrTqSpsr4iTkUIXodercapTkM8ByslG7YSfLYVwAe8cvj+5BtnAKlRIh8AkM/gQYdsZ6N5P8flhmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2goq7D9UrEqNL81CbHnhUobG4WNRDC3l14Y/J+BpOKw=;
 b=LroLCCvv8Jsxwo25IaJe/1AEK7o2YucspK5Rm6s5V4SyvzVxkdAR+VxUGDP6uoNRkZMBJNrR20JfovHMQ8hLbhA4Ge7lybIX+jv48ASEcMkXISXheyYvpeURfFRe3mdaMnJU8k4DF3zjM//FCvTVQLCRijApIAW4rvcmsSTgUWI=
Received: from MW4PR04CA0040.namprd04.prod.outlook.com (2603:10b6:303:6a::15)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Mon, 21 Oct
 2024 06:23:45 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::3a) by MW4PR04CA0040.outlook.office365.com
 (2603:10b6:303:6a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 06:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 06:23:44 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 01:23:15 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 0/4] KVM selftests enhancements 
Date: Mon, 21 Oct 2024 06:22:22 +0000
Message-ID: <20241021062226.108657-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: dd781ca2-5e79-45cd-004b-08dcf198ea62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6bORS3wvTa/fqFfPG1Emp5DANVq0xhDIODWhyMnq2vs0kOmfnYAxk3CZLa9B?=
 =?us-ascii?Q?dNdBrZVE6gvJT+npD4+FWv0jdui5j185GmvxLSW8a3IHD6Dog/cMl94gjjJ3?=
 =?us-ascii?Q?lmwEU+PKFpe1RIbt8lFStJghQtrSZwjjPI959cKPoVYa0py6pqLRrhZyl0rP?=
 =?us-ascii?Q?Cz9dy39bCDorqiuSPGCTFqoq3FvEb/zH2MUG7lc4xsd7sEBkzUWIKDCuL8m9?=
 =?us-ascii?Q?6crDoJhLolprIjMe5+cYt0VY33HD+aCXg1HNomZWUj1vq5CWuNSpsMW/27xi?=
 =?us-ascii?Q?8XWK7k19aShFgqqCD/WxVXPGgWheUOnl5w9T2uqEV+W6RkPiozeVjoeJtxfR?=
 =?us-ascii?Q?HuFk1N1NwjcwsVixchjoqU+a4/xZ960K8crydVj3FpAaUvH1gXV4xpFiQ56q?=
 =?us-ascii?Q?5Lx63iwh7yUJYX80OOgZWbtyJrXSJqfxafUY/hqEozh0HSsG3c2rzbMUjdID?=
 =?us-ascii?Q?xqHJ9hRUc5ZZsMiGSAc4lucOEck0/3RRIZRoXCd02OYLDvdS4Er74qp4MOyy?=
 =?us-ascii?Q?BrNHUOQZbrI0yKgnF7zhSqZq0+apVXKbGf7kPWajPU/k9T9z8VF8A3HP/j3S?=
 =?us-ascii?Q?NGxJdzvd9pQfB2LbBzBVj1ibNPV3tvuZx69LG8ZvU1aBcHpehiKPY6BDeULE?=
 =?us-ascii?Q?Thq8juWt4qVxMIe8qnb/GBLQdYk7pJ5vhHGcy4L3ilymn0kyh9rsXUtsPpna?=
 =?us-ascii?Q?OuoFuayvkDrIPRDNmonDWjTEbOMDmGs/NzZyFVwSlWSX4Cho6/1XJQOClWd4?=
 =?us-ascii?Q?JIJl0M7hO5S3UkdWwFdvIsok0ygaz4g1gvjZD/Mifsz+PDyOKikyJa7B+rJw?=
 =?us-ascii?Q?xAmqmcSEvG3g5Tj7WazXWRSuRb2g/K3OhSGrVUH5ahfSFRsonuuoT5CaXfuP?=
 =?us-ascii?Q?IWmr8fDkJERzoLNwLqR9XuO/2atOMPP4d4QnFqEUee1qTcUHaSbDeUL4DO4H?=
 =?us-ascii?Q?/sXHTsDIr8Ca6lKvS2Nc0GG7IUwfmUa39bEXZ+/ADXqzD1vOGk2msETEDNE4?=
 =?us-ascii?Q?LmveGFyk4y3C7buZehHktI9CBECLYugFhtThRP1Uc5JBJpFktpjSh0Dqq5GT?=
 =?us-ascii?Q?MRgUeT1UGh1dy236CCoq0+iMHkKRVSy1BIMQO6+xMp2eXiq1fk5OIdj3D+YY?=
 =?us-ascii?Q?5cIuN7z34whvKxKLRdN65tPA2y7jQNoZ2wj4jSui9Rh42ndVgGLccAr0ykvq?=
 =?us-ascii?Q?eK76dt02+mhULO3Q2AT4wtMX0gNwQRp/W/3wGx3Kd39glvD8TrO0+WyXwjE5?=
 =?us-ascii?Q?Od2sdBa9OSQW8O91JewPYXPbwojBub3RUjWWWwIODRMAbqFUkp5aCC/1NZwi?=
 =?us-ascii?Q?Zbt+rUvB0iW4HZ9AkOB2OWNjhK8YnKv0l7DcxcT16Gc9tEV1FmCKIkt5nwl/?=
 =?us-ascii?Q?a2K0li0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:23:44.8600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd781ca2-5e79-45cd-004b-08dcf198ea62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992

This series was prompted by feedback given in [1].
Patch 1   : Adds safe_hlt() and cli() helpers.
Patch 2, 3: Adds an interface to read vcpu stat in selftest.  Adds
            a macro to generate compiler error to detect typos at
            compile time while parsing vcpu and vm stats.
Patch 4   : Fix few of the selftests based on newly defined macro.

This series was split from the Idle HLT intercept support series [2]
because the series has a few changes in the vm_get_stat() interface
as suggested in [1] and a few changes in two of the self-tests
(nx_huge_pages_test.c and dirty_log_page_splitting_test.c) which use
vm_get_stat() functionality to retrieve specified VM stats. These
changes are unrelated to the Idle HLT intercept support series [2].

[1] https://lore.kernel.org/kvm/ZruDweYzQRRcJeTO@google.com/T/#m7cd7a110f0fcff9a03176935ed016f49088df6b0

[2] https://lore.kernel.org/kvm/ZruDweYzQRRcJeTO@google.com/T/#m6c67ca8ccb226e5f357d943da2a2965a4224f69a


Manali Shukla (4):
  KVM: selftests: Add safe_halt() and cli() helpers to common code
  KVM: selftests: Add an interface to read the data of named vcpu stat
  KVM: selftests: convert vm_get_stat to macro
  KVM: selftests: Replace previously used vm_get_stat() to macro

 .../testing/selftests/kvm/include/kvm_util.h  | 83 +++++++++++++++++--
 .../kvm/include/x86_64/kvm_util_arch.h        | 52 ++++++++++++
 .../selftests/kvm/include/x86_64/processor.h  | 17 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 40 +++++++++
 .../x86_64/dirty_log_page_splitting_test.c    |  6 +-
 .../selftests/kvm/x86_64/nx_huge_pages_test.c |  4 +-
 6 files changed, 191 insertions(+), 11 deletions(-)


base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da
-- 
2.34.1


