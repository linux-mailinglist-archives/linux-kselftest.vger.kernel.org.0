Return-Path: <linux-kselftest+bounces-17224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C296D8E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ACB1C25949
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32519CC32;
	Thu,  5 Sep 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GP82Rf2y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E119CCFC;
	Thu,  5 Sep 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540080; cv=fail; b=Y4Ydj/xCO/2r3RsF9RiSEQJUlGkEBbSoN+rAEBHOQXyDqBu3bjY8uqir43haQNGZs9eDunLDYJ5Xpz/PfRXV/AjbShqGxII6Ewsy8hWLl9V67tXYl7U8L075CIrBkA/y8A50jvf/jtUYDct63neXC2Gf6etOuN8aR8ln7uxerwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540080; c=relaxed/simple;
	bh=EJy4XrLjPzrhmLKACyZ7WikXv75RIYJtPUkd7S6TT20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wx8zlAsheuMN2MN/IkKyeFhS2RiimMU3zvCxlXdW8ZdcO4E4zvioSz5fYx0xhcvzGoeMjMzT4nkCrjN2WoK7zfzxFexiEV/Ms7Tv5Ypkga5QMGOTzfsVCJW0+1VIq7TOzbRlkISNuPVyK6RihCeqXZvnCUIRt1jvfwXSo+2dRpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GP82Rf2y; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdeC2jbkACRo05ElRfIFagrxsfu8TiqSoXrHtJvak83GwYc/4wMBQ82KFa6NJh/WFtNGkcFvdTBPlSYoW5L2DRbK7KyQIkrlb54Ocj6D4UWl4v02ktI/MIHThPvzbf81LDMI93/VR1TQzAf67KXGosoq/CdQEfQ6Ds6EKzNX/EDvoP8SL6MlpKvb+okI55sVmkAlsiKlRgWrvBg65y0jBDUrUTuTxvU0RdZ5MsBrsVYYPfgN69hwmpXZLu7RXoc8r+dvrjT1BO7UL4+LbagrOZ1M36eOm9QMpnUZYYfgzpOtjB7nARkv6Cd9KH/2nTToP173m74MiKtgWIKdV94Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuyypuQDGwaoVJKNRGOHFR/hOdySwa1pIxnAJdkIbQA=;
 b=r8i4nZTQ4yZeGwIqF/nLqcR71sgdYXuxD3NQCuBIzoD/iTc4wrjw3W7udMQFUtwzp3/uecabUDHjTUDdu+mfQ8vBkhYSvmp8FiThK1ldjeo8x8LtjI+vLVH6LzUYeJjFGwk+7xYvXwyXR8jIPgg2PQEqR704YGrMtkejpvJjyhUgjWSuEo3BAy5DhTgw6Cyan5zmSwj8zvP6Vi2tSaupP1z7WI6lFCAj+LjbAsIsbmzbnMa0Ec8gcimYmjwJJYb9MzUabQXir5757PjvB0KBICqjIc7TQ2g/rx7ov/m4bAPDuA4TdOVvmHKo8Q3qtk+7gJIr7cE51m3TTIAGu68rsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuyypuQDGwaoVJKNRGOHFR/hOdySwa1pIxnAJdkIbQA=;
 b=GP82Rf2y/m4B/vA/mFJJDO1dCDyoXloLKFMX/tZ4aa6/q+GEj2CLHxO4Rb5ENN8LJTwkeMUvq+tNLzmu5pmK5FPNSkw1uGhbef0IKWNrxXgrgB1srzeWyUgsmUlMHgudWrqPJUdEb/xh0m4YqIGwwZljcfnCQSMnCP/mlOPyDL8=
Received: from CH0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:610:cd::6)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 12:41:14 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::4) by CH0PR03CA0091.outlook.office365.com
 (2603:10b6:610:cd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 12:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 12:41:14 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 07:41:12 -0500
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/9] SEV Kernel Selftests
Date: Thu, 5 Sep 2024 07:40:58 -0500
Message-ID: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2860df-c154-4c93-a574-08dccda80793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3N4c3MPW45+RA+cAo3tUS5uoAc8veQJSoE1hYvIsQE+ewWzwA/y5wBXrY5Bu?=
 =?us-ascii?Q?ZtcoAW1S/ewGHC7zpZEmMqrKu8vqMMxR87q4hIKmTLcqSb4WGFw04jvwm/KW?=
 =?us-ascii?Q?cpJtrPzcZUs5UeD7KI8gg+xJnwrUdUH4GCVEAumuXdJH12F0lEFZl9sSBr4A?=
 =?us-ascii?Q?Bi/84pAu4+kRiFAIote0ZUADOoMHPJQ3E3tROoaumqwSdUxE0bk3DuxPEYXE?=
 =?us-ascii?Q?91PmZxUdwLhSB8M3GWOAYYq86JA1Gkt68IEIbj/XbFgDiWqySrKlo3fp5JhD?=
 =?us-ascii?Q?Bs7qpg81HSUVmiHgs6bEa7gHwpgslI3ti1BBd2ZqbZdX/iXlSbRpnKem39px?=
 =?us-ascii?Q?JjcHRoP2+WantT5dieF6lM7VrCu47A34rY0wWxxwolmRS2T8iBHKz8T219Kn?=
 =?us-ascii?Q?71s5/Q31tqBhA/8AcmO5BwunRxhWdwEvbzb9iosF8fjxJDPqOO8YjQH+zI4B?=
 =?us-ascii?Q?Ct1OvscJ4H0Qw5lTpWfuknODEhpEzYNKooPq0P7y51icYo3N9DS9vbOVhz+9?=
 =?us-ascii?Q?ZzLWdGNTBUS0ZID2O++fD5nkp+Q1SWM3iQR/ih8l6DkQB2qm7FeKPBUm4HIw?=
 =?us-ascii?Q?mULIKEA+JxZK9XtTlgxlNP5z4IAKxFx1ZrmiilSfp4W3c1vWVy7OKhz36G+4?=
 =?us-ascii?Q?gFGv16h4uhjogK4fARRB48y0IF/82HHEK1509I6gzCIL0qMUxB9y00T8oNvq?=
 =?us-ascii?Q?TUGAez4J70iSA6loFUgprnOwRNCT88PZ0v1cK8IHcJ8iWSrS/ZM6sgx2dzCz?=
 =?us-ascii?Q?AIwrdKh/+2V0j5mIt9gBMbvMs7cEQZuoS4bMCjIOnJ2Ftjil8E4K04a+PJ7Y?=
 =?us-ascii?Q?Pg3OihLESzPZ/TBo2/f6RbPrNLO5qeduman2uFkKJud5m+P/EEWtW4S9zILs?=
 =?us-ascii?Q?1ALMDMnnJYPji6IYij3KEuAWWVS44C2tcn6I38kq3ZGDiGcOm4aw+ONGVBad?=
 =?us-ascii?Q?2LUk5z64Un7Imdu3nkgrmq8Ltz3k2OV0dQ8zpFd5fcV2fN3914Wm/BIAzxql?=
 =?us-ascii?Q?27l0sWiHYmTHdA+lhO+VkEN7flCVEa0uar6DbomAO+k8nb+Vh7XFVS5wECkK?=
 =?us-ascii?Q?0pAuL6cSXlo1amUETWfx06EjBBIVKqRvpZaKEFsuq6AaCLLWo/4umloHKZD2?=
 =?us-ascii?Q?Elmx0kec95PmvHLWxKU77TTFHiP/7hCY9IBwd7AVMgBUmHa4IWdBbkJDElmS?=
 =?us-ascii?Q?Uz/ECjEmfWEvItrl5QRf+V89H8fdg/CMOCoeY4OX+DKfIdUzH0aNQKte4bvf?=
 =?us-ascii?Q?3Gb/+RHZ9VyUxWyN7NKq1eyav7pNCJQSn6PptN64X0udr3i6pLmp9Qn7nHza?=
 =?us-ascii?Q?1kwaNkpR/a3x+YIMmyoG2n8Rqmy7FtSXBKCFQqy6Zo5g1vQtP1lS2qSWrKg1?=
 =?us-ascii?Q?d0xwZOl1mD8aJR4Z1lzyHro7RM1LK/nfBgfdsliQPyyu3wdf4ju4oO21qxja?=
 =?us-ascii?Q?Jp1BgDXklAXuJGkBXw9qsJxdOPQeYi6sDmLu/wi8HSQiyZ8mUtWV3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:41:14.3990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2860df-c154-4c93-a574-08dccda80793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953

This series primarily introduces SEV-SNP test for the kernel selftest
framework. It tests boot, ioctl, pre fault, and fallocate in various
combinations to exercise both positive and negative launch flow paths.

Patch 1 - Adds a wrapper for the ioctl calls that decouple ioctl and
asserts, which enables the use of negative test cases. No functional
change intended.
Patch 2 - Extend the sev smoke tests to use the SNP specific ioctl
calls and sets up memory to boot a SNP guest VM
Patch 3 - Adds SNP to shutdown testing
Patch 4, 5 - Tests the ioctl path for SEV, SEV-ES and SNP
Patch 6 - Adds support for SNP in KVM_SEV_INIT2 tests
Patch 7,8,9 - Enable Prefault tests for SEV, SEV-ES and SNP

The patchset is rebased on top of kvm-x86/next branch.

v3:
1. Remove the assignments for the prefault and fallocate test type
   enums.
2. Fix error message for sev launch measure and finish.
3. Collect tested-by tags [Peter, Srikanth]

v2:
https://lore.kernel.org/kvm/20240816192310.117456-1-pratikrajesh.sampat@amd.com/
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

Any feedback/review is highly appreciated!

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
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 297 +++++++++++-
 10 files changed, 1023 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c

-- 
2.34.1


