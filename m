Return-Path: <linux-kselftest+bounces-13519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44492DB88
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 00:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424361C214A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D8143740;
	Wed, 10 Jul 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="piye27sd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFFA12F365;
	Wed, 10 Jul 2024 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649151; cv=fail; b=AaKv7tQVEGImu17ml/bsOKMEXRAasYlpOwKGvRt6iGVI8AKAjyhKqq3fLlniHqkkgnxAXLs1FPdqNdIsrr0yW+9SSVI1qNJmFUZekEeAYgdryiwGHu1b1YWvLhoBylS1aN2FaLRwL1IccUNvZfOz98b0TRfVMBxgR6JfxjXyKSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649151; c=relaxed/simple;
	bh=1DVqmZDv/vxOlQUjvCzPjZi2ky48wqIrpXY6CAOA1QU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=epM8f2trmgqc7haEwE1K7pOgkQyAi27gUPhq66isqltOgBNWhGvpkPzJbn/9oxor3YsQY+FLAQmR4xW50O+hWJljgrS/Iz1u9a4SvkeUGwi7YJovgSsJQi9aFT4y1p3AgqyMteb/JS2oTF+4UeG/Um79muu6lfexMnUjyhUzuaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=piye27sd; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXd/x1MSm+sB4K09VGFDKIFyZvYOSIv2KNJgk3d8VmQGwzcPNHkJ4Yu/ugQzS9uVGeEi023z+MXwmbJa59a/bmhIozh11iv8vOIZpl6O8+31H1FVjZ3hhqY4vcm7rRTlCCTkm2tICb0gMCyygv5iXnUPEtRcySEs6l/m8k4bJbw1hhiHEw0c09cKtV+n0x0WKXHqLCuH0m5bX7ijvGm2WyxzM5T/z69z2cluYeiBDeseIRn9ynIKX6KkfwDInlm0bMBKC7SZv20fMif/bDjiH3fODVgirR9STbXJEaLA2DTzXoUdRhwNqfh6SUBsSlm//j4J7U+UUWOhpqBLAU8yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyjQPxLeuBkRD7iyqlYZYUUa+KBrfEKxAhuJ6eX3TQY=;
 b=IotjNP6AoqeVUgADwYEbKlI69l8A4fz/iS3HH8GgAZI0yjvrlrxwxhM5lLByGz7k3h80cMGXPN7PMJ+gHvxyxFRTigBGgnUJwJqKRTkU6svMGBzLdEop9MkNixnHxTwfpqgrZTHHVs9ildvkM76BdR5Va+AJ5f+LNLZniqpiYI2D2qYer1ujSW31lklLi4/XwVbaAvENc7tu4zPPsHrYMr7ionllJ5AzacDFUyWvjCYjJCygfTrfo68AHNAczs1Wzd7OpcdFQg6aNGBRu0JsGhjqWykLCbC0d7lTqyJ4SK4gmUUNCng0gBYAeHayknU4eyFsujMs4XbUuMTh+6bM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyjQPxLeuBkRD7iyqlYZYUUa+KBrfEKxAhuJ6eX3TQY=;
 b=piye27sdoFrmmybwCVtZu0EuzXPsnZE+hzK8z4rQio+IvYacyMg8eUKCjLtCQ/fwFQE0vlyxOREirTUNDrpUoQOBMbMJOGyopPMBmuDB84EqnU1T3JJaDB/RPMuNvv8bWdQWH1vsjBMAx6qxOUP8R8d/XuH/Hrrk81rbVQy8dPg=
Received: from MN2PR01CA0036.prod.exchangelabs.com (2603:10b6:208:10c::49) by
 CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 22:05:47 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::e3) by MN2PR01CA0036.outlook.office365.com
 (2603:10b6:208:10c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 22:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 22:05:46 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 17:05:45 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <shuah@kernel.org>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 0/5] SEV Kernel Selftests
Date: Wed, 10 Jul 2024 17:05:35 -0500
Message-ID: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: aa15fbca-89c0-4ba5-9d83-08dca12c739c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IG65feS6O4LnRYnbwGOyVj1oT8hC99PNruBUKx4983dip+xDaz+urST+9hYn?=
 =?us-ascii?Q?+gW6PjjdLJDhfCBUbBo1Cb31hG0+q+9840vgax32isG1JMep3LF/LnUGeQRK?=
 =?us-ascii?Q?nn5C3w64D/oi65F0iJcfhX9jMqmLlYkvRFbk5LTC/E4jW5SOzpwe/Zs5bNDq?=
 =?us-ascii?Q?T37C1TWQJfH7cQQ7FZbAJ+oaC89cqKfzdyOX8ZDdoydDgydo+yvTouZ8h3j8?=
 =?us-ascii?Q?eR51EVd+VQswvnZvvoUvECNG86Orc5q9PlMQcDQkrvNJRBx0PMugc337xWVB?=
 =?us-ascii?Q?TCpk0AayzWM4QuSS+UBsP25NyvLuyX04SeoYD/Njpo6oTvTGBbK9hYmNIcEh?=
 =?us-ascii?Q?X6WdPXrDZjdTYQUTvrZjQx5u44hX8kuMSwBRLys+nkiV5+tBChCoHU/AJ+Vz?=
 =?us-ascii?Q?fAK94+gpLjiYfClXguz/KQCmlJ/l740/zQ43sHDbSBY65wtRTub1g6DkgLXG?=
 =?us-ascii?Q?7iYcepz7XL3KF7XE/Hg0JT32v+tmNwaz+HN0GOUaQ7XAszt8mBNyfesf5FZp?=
 =?us-ascii?Q?5Ms45c5QSAKSM3QJq6Mp5l9M7YfI96OQoNLIjvZWyeq68klE/o9MRJzNkhSX?=
 =?us-ascii?Q?dzawq7an1b3qBrWwFznJRJ37dZDVU7IiccwZK1U8LUin58rPggE3HJ6lr/aW?=
 =?us-ascii?Q?6oUCE5HR0Ep4wqJh5bNc154pgdcQqfQp2njaLvehZd9R2VBPXK7NcH9hBKCI?=
 =?us-ascii?Q?iLgyB+EA20FFQ8tMmp8NWCwxtgIoNlY9gb/UtCdiNC1J2t5gXFP+DjSI8ImF?=
 =?us-ascii?Q?E6zTOADq8Ah/2vtNyL9GpeFdvNdS+pgsDHsTNnbMyyyjeRorXsVFjCtXxjA5?=
 =?us-ascii?Q?eLMM14CRCLlPa9FFjfBZilbO2oGm34OO91v5r4dDJzY/xUp3pdYYs3tIxLtR?=
 =?us-ascii?Q?0Ipxg0jQIOCysAJiEGx6yUj5c9faiBAR1sB4tHoA1yZlXWmdcJanhgZTKeSG?=
 =?us-ascii?Q?r3/eSec0beMvEtU8cA0PQx7PYZQeYdGJo6aTA3qdswdTGjaDlDJrd0kocUAf?=
 =?us-ascii?Q?7KDUsVfCeYbPqUBUrOzHt62A434RG4Y/bQPNF+UorPm4K1my4wldtTqTxHBx?=
 =?us-ascii?Q?T5tz4A+LXryEpWtEDstSfpw3xINagpFjDLH8rrejzmVPLTtm8DHgfJAzYWx2?=
 =?us-ascii?Q?DSk5COGKwMTVs98zLnAjmI7UaWl8itG90pHSK+RPgRtViE4bVoY6Ayb78k98?=
 =?us-ascii?Q?j7fW1iI/IPdyZkzLK5C7+bSTpqn5r3RDEq6KGQb9SstvRf6B33Fbg95XvzQv?=
 =?us-ascii?Q?BmQEY8VIDSstOf3BDAWAPxlbkgzww051QfJRmq02gYlFXTppY4ModD6HozHC?=
 =?us-ascii?Q?j/oA2kPcneseEUt5+43yB9YHdWJ2ypWPMSGuSBj9qb7ue5OBkio7cN0rp2nt?=
 =?us-ascii?Q?3lPGCr5YCc1ScYWaH/NOb9/E/nerqqlvAQ6uAsOh/7txUYIkFlgCC2QXRHO+?=
 =?us-ascii?Q?6R9Sj7TzWkZt7GSjGr7Kb4Y/CbYqlqB7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 22:05:46.7700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa15fbca-89c0-4ba5-9d83-08dca12c739c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497

This patchset introduces SEV-SNP test to the kernel selftest framework.
It also adds negative testing of SEV, ES and SNP VM types.

Patch 1 - Extend the sev smoke tests to use the SNP specific ioctl
calls and sets up memory to boot a SNP guest VM
Patch 2 - Cleanup patch that decouples the ioctl calls from the sev
selftest library with its test assert and status counterparts. No
functional change introduced
Patch 3 - Introduce ioctl test for SEV, ES
Patch 4 - Introduce positive and negative ioctl test for SEV-SNP
Patch 5 - Adds the X86_FEATURE_SEV_SNP vm type test for KVM_SEV_INIT2

Any feedback/review on the approach and design is highly appreciated!

Pratik R. Sampat (5):
  selftests: KVM: Add a basic SNP smoke test
  selftests: KVM: Decouple SEV ioctls from asserts
  selftests: KVM: SEV IOCTL test
  selftests: KVM: SNP IOCTL test
  selftests: KVM: SEV-SNP test for KVM_SEV_INIT2

 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 .../selftests/kvm/include/x86_64/sev.h        |  39 ++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   7 +-
 .../selftests/kvm/lib/x86_64/processor.c      |   6 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 181 +++++++++++---
 .../selftests/kvm/x86_64/sev_init2_tests.c    |  13 +
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 223 +++++++++++++++++-
 7 files changed, 418 insertions(+), 52 deletions(-)

-- 
2.34.1


