Return-Path: <linux-kselftest+bounces-15556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B850955154
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 21:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7101E1C22754
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C8D1C37B5;
	Fri, 16 Aug 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rbo3W742"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE478C7D;
	Fri, 16 Aug 2024 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836202; cv=fail; b=KiV/oXRv+xshvT9As/MT5cAuBKXAedgtDcYEmQ734gOio5THivzICTLwwf/nNnW2n//Dhq7VxW6SeQcY0lzuJ7sypk2EONe/KMTqo4YCd+f5cQrdyTSyb2LJAjo4PmHoqq2uaj+2A4yw7kz9T+tRyntDgsrFElBbGb0wJXZ1G8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836202; c=relaxed/simple;
	bh=QGQ2QevigeBrqDBEERDk/Wf4Vj0dD47XacxABGvk040=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uFvTXs4f4FA2ajsxT2InmX5mV2dK6V5bdvUrgBlIkRDjp+DseIoKOlDkzKBUCW2y4JCo7Z6MPzWYyDhhxosoSFxQV6iJYu52S/hn10uI6ajvabiXZpjeczdYc7P5d9FIGmJ52AoA4oMY4BiUkwI9wbk9+4LBpC+x2UosqjkibB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rbo3W742; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWjEX24NfhGfABS/uXSpSNpQtwGbYMrczZ+jGyipm8mUg8dMKxUcGOWP78aqcgFQyK7tW9c6vpcEEBgd8goi5hIYO2TNVZnAyXJ6ear0z4lMJ4AKN7uCnC3vf2sCRIARFfl6bDjOLMoimpD1MS7xWE8IWUaz9+8PZXYkMEb8v93Cjlkr5PIZM6/KpwuQR5KAV4g1YRa+hvw17xSkcOp6zkUmW6eWc4SkU7QEkuLB9nAgStvmCrhwi+ST4MRJjwUq8tdtnf8pAbMmbYj3bX4DDOUXsUHkGOK/IsUp6jI/fha2Wjf0JQc3fC3bBjdyqQWE5DEzhgXSW07qYaCXPSDo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W0ZdZLy7CeQMQMnOQI5vL1wozV3zpFs/D34nfPtrGU=;
 b=w2bHWfGxgWaF7RM1qev60VskRV3HEBJc2DCyFtGLBrUhxT9MO0pvd5nejs0Cf9YvjUiIqs+Wlp90+LCZ0FHujX/S9nM/5RBOqA/qW1T3rlQaBiB9IrbZhr9d9z5iBOlDLIIP+UVKHsUQ+ub2cioxilYmwBduBRhg5mhuDC6ccq9XudTjOKnIzqrMznYi+qFdvrGkaaAbzPaz9TD6XWzMiruAwa7W5ZMBmk/KOo2U2Urif2D2v04k4pwYba8LWu9L8O7+nUKceM65qHAdyTHb+HERDOTnC1207gPzQcmGhBvhBjo1/lN9ibQ7KAKqpL1zct/oeQ0Pbcf+sx0Nj0Qyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W0ZdZLy7CeQMQMnOQI5vL1wozV3zpFs/D34nfPtrGU=;
 b=Rbo3W742ZtODSyEFYDdRPNbQgCi/X6uhQiNVko2ir5dJp2f59es5FzuGjSOjNrMotLBayRTy/D8zum5f8lfJubgBP/ehEvIvnrSDebmU2J0ukmB9p986ZVkb4HnOg70XIcnVJ50AsL9tY40kZvVhyE4/C7ZfzhIBvdbkhqc3NFA=
Received: from PH7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::35)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 19:23:17 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::dd) by PH7P220CA0036.outlook.office365.com
 (2603:10b6:510:32b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Fri, 16 Aug 2024 19:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 19:23:16 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 14:23:15 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/9] SEV Kernel Selftests
Date: Fri, 16 Aug 2024 14:23:01 -0500
Message-ID: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dc15aa-dd62-4fdc-0096-08dcbe28e167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N1q7oPR4DcVm5fjpudQcJPBW1mZpuNnj4x3Sj2YF/Zir0Ww0OvXoqixxD3uE?=
 =?us-ascii?Q?fgDRILlByXJX5tibVmEj/xFhAU29Xb6BXq6mdDoGHDG8vTSN2Mn2WDg1P5lT?=
 =?us-ascii?Q?If64hQH278HoBGv4OtdzoKfCLr5Q/3pCMuK7mksqhhg2D9UiKUvVJe4QHjUm?=
 =?us-ascii?Q?7wCJxg1A8xbot2BMJ58ft1KVGwxxI88w10B2zLWNr1WFtblekQrjz2mlwjnv?=
 =?us-ascii?Q?CZRJcELWHKlBOwgOPsNIDWMFBgj0/rl7IoXcGaudZTIDz6mpnrpVSedUOGws?=
 =?us-ascii?Q?egltEzeSFiCO7XHsW3KQQSycCzvuRHGipJ+YfH8EMLOPl0uHxGR5fxgBQsUk?=
 =?us-ascii?Q?0lvnSHYpSuRht8918qHKd4q5DuVX6bq9VHemcspESzhgTBbOKSNsrRhXg3XO?=
 =?us-ascii?Q?EX1C29OavDZtiS9QfdBkHq2MwU3WhjG2z9vKbAXZLN+6hdGRA6vLuPCBXoTW?=
 =?us-ascii?Q?ueLsOIqWsxDsqmRDJgNdUgBEslU0UssT4yzO73OGvo4LVlfXKVXQEdTNKcdu?=
 =?us-ascii?Q?fdqjukGXrVGPLL97a/7NsHiu5Yn3ZGnrt2lyIKx6er/FJZuflWtEzpKK0oPr?=
 =?us-ascii?Q?Xb9u3M8mMvyyz9MSAGopnv78nY4Z/jLBJGFuTQXqrI6ha6aYEoWzMLNRKmIl?=
 =?us-ascii?Q?x7NnrBIyuw98SvHZD2UlQPHft6SDRvLDYcU+4fdGbRn3jgGlk1C7DP7bG/ZZ?=
 =?us-ascii?Q?H5F4DUpfs6xvGutMGVc5z2R9VVsUCXJqAJ/nJqB6jO79rWku3mRtwia0ydBW?=
 =?us-ascii?Q?oKGOtja3iZO6wxs+SW39nKvUnYJxeoSF/kfpMbjUGU1utk3I8jz4OBBKq1gj?=
 =?us-ascii?Q?3bWTix99vXz5IzxgRMRh0FXPaiB7ExfndO/0u31TqrQ4AMC1BjZlFMeBmvVc?=
 =?us-ascii?Q?AxPB8tK6uZGsccdtQkakSuN9rS9LJPYjxeVy5LZ1Tc78R0211+RxML+GZ299?=
 =?us-ascii?Q?/dNdONnvYqO2DF/pWKIkqm16cvym1rwkm0tGzOw6DcG2vzzm1WheccfiWqay?=
 =?us-ascii?Q?KOq+qRCLSP9DUgJPm8hFP99Hq4uDnhFtA3ORJly7FzJ7OAsdu0MxTAP70y8G?=
 =?us-ascii?Q?nzKq6YuTXm5cV6txh9oS/ncE4ffF4hKlh2enlDbYZAMrwiDOT5+mt5oi4Mxc?=
 =?us-ascii?Q?YNrfW3LTinuucbYPWLnVBUK6ccnv87VJCY7DcTAYiZbpjgy1vqE1UYF9xBtD?=
 =?us-ascii?Q?k2vYOEO1HKD0k4YJc3/RrmcOun4vYWbziCCi0Cl5ftecwrVOXDZ8Hx30g82F?=
 =?us-ascii?Q?VgfOoVoMLJCrvJJds5HSB6sdn7jmNGygcW5zBrCWqs68C2F7YM+5X0JUTAyl?=
 =?us-ascii?Q?1so/E6l8S/tBM4zz5aRkrd/N9Gvx4394McOqenJWfcEFxlO66xaO1oI4slZp?=
 =?us-ascii?Q?miMeMoEs0nVmark9RYE8j7Jgly9SadEO+JOYty76G7QO2jCDwNlKuLKUYvfT?=
 =?us-ascii?Q?7g/XNF7aWNxFh3X+tKf7cF83hbKpKONl4sMnBcSIEQLUWJzfTSc06A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:23:16.8111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dc15aa-dd62-4fdc-0096-08dcbe28e167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837

This series primarily introduces SEV-SNP test for the kernel selftest
framework. It tests boot, ioctl, pre fault, and fallocate in various
combinations to exercise both positive and negative launch flow paths.

Patch 1 - Adds a wrapper for the ioctl calls that decouple ioctl and
asserts which enables the use of negative test cases. No functional
change intended.
Patch 2 - Extend the sev smoke tests to use the SNP specific ioctl
calls and sets up memory to boot a SNP guest VM
Patch 3 - Adds SNP to shutdown testing
Patch 4, 5 - Tests the ioctl path for SEV, SEV-ES and SNP
Patch 6 - Adds support for SNP in KVM_SEV_INIT2 tests
Patch 7,8,9 - Enable Prefault tests for SEV, SEV-ES and SNP

The patchset is rebased on top of kvm/queue and and over the
"KVM: selftests: Add SEV-ES shutdown test" patch.
https://lore.kernel.org/kvm/20240709182936.146487-1-pgonda@google.com/

v2:
1. Add SMT parsing check to populate SNP policy flags
2. Extend Peter Gonda's shutdown test to include SNP
3. Introduce new tests for prefault which include exercising prefault,
   fallocate, hole-punch in various combinations.
4. Decouple ioctl patch reworked to introduce private variants of the
   the functions that call into the ioctl. Also reordered the patch for
   it to arrive first so that new APIs are not written right after
   their introduction.
5. General cleanups - adding comments, avoiding local booleans, better
   error message. Suggestions incorporated from Peter, Tom, and Sean.

RFC:
https://lore.kernel.org/kvm/20240710220540.188239-1-pratikrajesh.sampat@amd.com/

Michael Roth (2):
  KVM: selftests: Add interface to manually flag protected/encrypted
    ranges
  KVM: selftests: Add a CoCo-specific test for KVM_PRE_FAULT_MEMORY

Pratik R. Sampat (7):
  KVM: selftests: Decouple SEV ioctls from asserts
  KVM: selftests: Add a basic SNP smoke test
  KVM: selftests: Add SNP to shutdown testing
  KVM: selftests: SEV IOCTL test
  KVM: selftests: SNP IOCTL test
  KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
  KVM: selftests: Interleave fallocate for KVM_PRE_FAULT_MEMORY

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |  13 +
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 .../selftests/kvm/include/x86_64/sev.h        |  76 +++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  53 ++-
 .../selftests/kvm/lib/x86_64/processor.c      |   6 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 190 +++++++-
 .../kvm/x86_64/coco_pre_fault_memory_test.c   | 421 ++++++++++++++++++
 .../selftests/kvm/x86_64/sev_init2_tests.c    |  13 +
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 298 ++++++++++++-
 10 files changed, 1024 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c

-- 
2.34.1


