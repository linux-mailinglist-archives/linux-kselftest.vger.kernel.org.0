Return-Path: <linux-kselftest+bounces-22065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1499C9639
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33CB283384
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A241B4F1F;
	Thu, 14 Nov 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pnuEIFtn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E701B395E;
	Thu, 14 Nov 2024 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627676; cv=fail; b=oWPE8r6OpkZ7cR4d1OQEwULNtSp/A5B1GC41jGjDNx3oUvWs7Cf6XH3LIy6siaKaU65ahTabJXL9TivnZCI6jfXNtPZhALhiF0/JDRlUAEzo+q5khw8Ypt7h0uPZBTjHrtJ/asutNyNfwNLSeUKCL/80cFRfwsqX2n/n86zFAJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627676; c=relaxed/simple;
	bh=QnAE0wTLHLVzvfCE6+QxnHoCF1CE+h/LBr9ChTxHxs0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a9aEI40DWtKDnvqEPjyhbmaLCIRr0BNz0o4Sklj5hxlK4Lb6WuYaJtXhD300Adl5Fjz0jSToh005OScKay7mICFX79vNWt1USye25FqnrSJsfn/fsc7HMx2XQui8QcYtCldrsR8NWogAZ3ccTHl03l23uSWO3PyWfXpCDg2HShE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pnuEIFtn; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTnQ/wEDUgT0CeMr45yXtZy96yfqRP6vmsoxQd2uqsR4kyIsk29vhJdPIwmR1Wdhk0BApi/btk8gdoUKQ2DXtq8z1E7uGxUFVqIUUZLYEwH8Nl5QPZCZTMsPrOJNw19bYlkmZ6gCxLrscLNJ3Olxf3kwYHRcx2+wsVcIuwnRgx/StjclVodIG7NfMh3lH32DovST6Tmun1ToNBcpj5MJxRNOdUB+dvBMrs8FGVqnQlrIFvvS3eeRN1fI/Vw1dfzNgEhtpfqcAC/avoDNinmF5fxYsdzgj9o+jHZY6amzTcGl4i5ODyqIyw0ck94wNtI17m3wwA9YUgXIc8NzvhFy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+IMuphZ83yfunAMPCDnyfoz7UIxGkEW/T6U0bYwvHk=;
 b=qHer5PHvSIkw27JJAZaP2Kl4ZnTUWg2uOY+HE0UXMAmqkFrrD3yJJmYPmtbG8HTPtDYUac8VTvwuKK0P5hQnDYxgHiL8CcYRNTzdssG7dsdDt5xxNljOPSjUf1Z9LXP06zKraJBumdGS2BHmcrxxf6M9Uac97yMMDkBnWDA2hpmYy3NhCnnaAH/dDlu9LtVIhLI4h7iqqG8j6AqXIn1nW3PcdBmMhuvz7Lvbq0fhhZDCXWY5z1DW0xfANRdpVemFsuRcVm7g9ZxRkgIz+//nXLpTHcVz0mpgWfi8RoOAFBFEC1Y/xSuuyLLozpNiOuzrTuFsuegBLlEqXOZt+x1uKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+IMuphZ83yfunAMPCDnyfoz7UIxGkEW/T6U0bYwvHk=;
 b=pnuEIFtnghnAfeJYRqwyxYEpi3J95NgJ3wrniEhXugfwo3WKwG4a9qRqSxzhti6/5FDUS2QCyrX+Qdu8qSnQe0zEfTDYih6xAKCdpHgjC9c1mKCWl0LEk675xXQBfoGYMtu/rDH8GxzoxIDKK36rWkojYjJfkRBm8LuMZlRh6pw=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 23:41:11 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::79) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Thu, 14 Nov 2024 23:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:41:11 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:41:09 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 0/8] Basic SEV-SNP Selftests
Date: Thu, 14 Nov 2024 17:40:56 -0600
Message-ID: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 1453a5bd-c4b1-4b58-9d03-08dd0505d204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXG8nRvkZp79vwFFpoBrNHXoTcRFxbFkQeIL36E1ZWFNkZQ3Bosf2KLRkkh9?=
 =?us-ascii?Q?8lieUPoa8/7S9cQgXA+RM2vfglvi388nRSD37rSGOnLutb+Dqpr6Jzr4t6dx?=
 =?us-ascii?Q?/CYpmXzXCdCGImmgk2Y2lrapPAj/Qh3Y2YFpPAxAkD9rw7wj+R6PFRtfEL3n?=
 =?us-ascii?Q?Le2NZNNmiXslx00vEh0qQNeghCmKuLW1/bF4mlNpVTRR0qDzp9AB0m+MWUld?=
 =?us-ascii?Q?uDBCxkTLyjmO9WFWBlJip/MdQO2MSKb4wH1DVVMGeLwMg3DhZxih7gqs7psG?=
 =?us-ascii?Q?BYYU/MqlzoXMJlo6ZOSyzWRsz1xehtwOkAsYbwpdjqzr5WdqIDVzM/ug/eIl?=
 =?us-ascii?Q?PTJX31fqiT3LP7Bn4oXHzybut/KmCkD+yonMjVAg+yUOjWBai+QYecGQWBxC?=
 =?us-ascii?Q?RiBVPCkgqmtChHHT26Ix/UMcR9Jk24RhYy25AxfX3Smz+fab6EQI57iocMyc?=
 =?us-ascii?Q?qMxc4dL8ADkFMwsTQnbZ4oYQ54Ge0IXhD8TwUDwYjqIxZWFiERF2rpXQjtBO?=
 =?us-ascii?Q?my7ThJdefxzPQbLd6G5YXDt8Vqg/kTZz4ahG9hsPAhipDa5q9S4WiZfd+e4q?=
 =?us-ascii?Q?IA3UK9FNXwol9OocvkbdlxIczliLz9pNgwIo+bkec8/7VwMnSNEiX7BnQ4ub?=
 =?us-ascii?Q?ac3f4Na7+NXIIdPqCl09Yy4qSeqGT9+rvP1kWflTc3Gc8Egde93dkbwHK9E4?=
 =?us-ascii?Q?YWD4f6JYiZoM7kd+MJ9YEbBxayvcN2LNQmLNk+LN2llivIIbSnF6A7hHIdpj?=
 =?us-ascii?Q?TChJh4zot7d2reJApt5kuQdz6TZ0+Dby5l+2795sHod9mD2yBybSoRcj3OIm?=
 =?us-ascii?Q?RCdDT2nPkPILwxPrQhsgbQcIECMwLcZSNDxCmV0iz6W03n5TM8eHVrd09BAL?=
 =?us-ascii?Q?TwvcSzfFxabISFKbNC+DhaJ6/8mJyLmrK1Q/aFk/LHvRwJNSOzIwGdGN2+dG?=
 =?us-ascii?Q?X32zY8DL/ysq5fRj74I3llYA5t3fZoq9fombsE0u+CCISL5VCrocs+0BqLKE?=
 =?us-ascii?Q?WQtzwYpHJhx5Seje3l+EyUDiky94jSa73nnR33k61wXP0tIQQMV6Lm81EfVe?=
 =?us-ascii?Q?7X9pxEUbBgYlt/J7MYQdkvou/8WGSq8M7VF6hGNZLpBwPF+e0S105u22y1Hw?=
 =?us-ascii?Q?TY3KRrAuYPn+0G6l76CjPeYEk0nZzxE2dcwO6sOCZA18zj6MbgHzUTJQoPWq?=
 =?us-ascii?Q?fBMoOCssG0m4mYuxccjMvQB0kzB2slDoXl9yYp7ho1bBv+sM2AlIfJC+73Oj?=
 =?us-ascii?Q?6P82hEMjha3l7byV+zUzTTJU0L8SCSakKZ2h159TaLk8iG6ZltRa1d0EvngO?=
 =?us-ascii?Q?Pgug84jfE4eFxp3xGT0+j0hU4+PycMYZH9Ptrd5tOeqcTQqtqz4Mqcjf+a8l?=
 =?us-ascii?Q?oHVe118QIF/2sqLazZdhu7HszyYL3+NUz7u5EWPfKhJcBWUU8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:41:11.1252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1453a5bd-c4b1-4b58-9d03-08dd0505d204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699

This patch series extends the sev_init2 and the sev_smoke test to
exercise the SEV-SNP VM launch workflow.

Primarily, it introduces the architectural defines, its support in the SEV
library and extends the tests to interact with the SEV-SNP ioctl()
wrappers.

Patch 1 - Do not advertize SNP on incompatible firmware
Patch 2 - SNP test for KVM_SEV_INIT2
Patch 3 - Add VMGEXIT helper
Patch 4 - Introduce SEV+ VM type check
Patch 5 - SNP iotcl() plumbing for the SEV library
Patch 6 - Force set GUEST_MEMFD for SNP
Patch 7 - Cleanups of smoke test - Decouple policy from type
Patch 8 - SNP smoke test

v4:
1. Remove SNP FW API version check in the test and ensure the KVM
   capability advertizes the presence of the feature. Retain the minimum
   version definitions to exercise these API versions in the smoke test.
2. Retained only the SNP smoke test and SNP_INIT2 test
3. The SNP architectural defined merged with SNP_INIT2 test patch
4. SNP shutdown merged with SNP smoke test patch
5. Add SEV VM type check to abstract comparisons and reduce clutter
6. Define a SNP default policy which sets bits based on the presence of
   SMT
7. Decouple privatization and encryption for it to be SNP agnostic
8. Assert for only positive tests using vm_ioctl()
9. Dropped tested-by tags

In summary - based on comments from Sean, I have primarily reduced the
scope of this patch series to focus on breaking down the SNP smoke test
patch (v3 - patch2) to first introduce SEV-SNP support and use this
interface to extend the sev_init2 and the sev_smoke test.

The rest of the v3 patchset that introduces ioctl, pre fault, fallocate
and negative tests, will be re-worked and re-introduced subsequently in
future patch series post addressing the issues discussed.

v3:
https://lore.kernel.org/kvm/20240905124107.6954-1-pratikrajesh.sampat@amd.com/
1. Remove the assignments for the prefault and fallocate test type
   enums.
2. Fix error message for sev launch measure and finish.
3. Collect tested-by tags [Peter, Srikanth]

Any feedback/review is highly appreciated!

Pratik R. Sampat (8):
  KVM: SEV: Disable SEV-SNP on FW validation failure
  KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
  KVM: selftests: Add VMGEXIT helper
  KVM: selftests: Introduce SEV VM type check
  KVM: selftests: Add library support for interacting with SNP
  KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
  KVM: selftests: Abstractions for SEV to decouple policy from type
  KVM: selftests: Add a basic SEV-SNP smoke test

 arch/x86/kvm/svm/sev.c                        |  4 +-
 drivers/crypto/ccp/sev-dev.c                  |  6 ++
 include/linux/psp-sev.h                       |  3 +
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/include/x86_64/sev.h        | 55 ++++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  4 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 98 ++++++++++++++++++-
 .../selftests/kvm/x86_64/sev_init2_tests.c    | 13 +++
 .../selftests/kvm/x86_64/sev_smoke_test.c     | 96 ++++++++++++++----
 10 files changed, 258 insertions(+), 29 deletions(-)

-- 
2.43.0


