Return-Path: <linux-kselftest+bounces-25044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4875A1AC42
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D033A228C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAB11C54AF;
	Thu, 23 Jan 2025 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aL/4TB+P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644198BF8;
	Thu, 23 Jan 2025 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669680; cv=fail; b=aXpHoeMrfBwJK8V/3miIlDdJtD3P1X1F7KrGg1eSiWQltoEAR/Fl/Z0DiRrfyanpWVDkCiixrZt66uHSpfHpuImBCd5F3m5rm+R7M+GTmLpg7h4N6enQl0YuvSzOyKVwjFJ9iJ/6/2xjstU8OqR6pq1dh4O6dYxfPHBVOgyLFPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669680; c=relaxed/simple;
	bh=84FVh+CF8+JwOk3kbUDL4PVgVjza4QrZ+/hxSFz9Cvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQzOONgHhlquRyRVNTuj3Bu0W2SpPo0q2pGg5aNinAzeiWNWsRMGW/cOV9pY2935U4TcXH0AVa0ghMlkqdgfvV457sz5ARVTrY4Qmkz0AdT/jZNth/rl/H5iMj+/ImIDx4Q40Ocy9spXo7SiP326H3iw6FbD1UBDHXbV3pHwxO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aL/4TB+P; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRW27yMsOKy9MR/Icp9d2CJkWJJ5nWudjaZNPlT3cSpVPqJpQtKK6cslOHfH1fbWPR1kO/PQZwLUeKj9xUCPa9IGGh2DdM8rYN8PFQAoE1IOCzFGFgTSHxu4Uyuq1d0c4ZrBk9XJCAqoWWuNzhrr7ZOKH/KWnast33OWQgc/jC++0SerG4SFxaCa7+2Vhuk5i3Lm26fvLaoAOT6Mkz4Lz/HrPFSfyd+qyc8Gjmu7EGUtRANNxpcA98oVPsUGzQnXR0uHJtwhLBoPgU4y6q4C/NIfBDXysKz1ox1WETWVyyZsdogGgKGpeoEcTDPHilsJu1wSQnTJWNNOtH3TCeKdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTFSSxhB+boCPf+wYdv2ATI13XSLk2swRhPqU5Ugypc=;
 b=kglhgvYIsZvDOefgE7wDL0xmHLJx9gqFxMLlMbUuKh+FDLUyBkz+LY1XNZuh9uIfwdSihDTWeqHbuU3uY5N+xPfaBzTeu0OEM1Bn6uN7elrjOTL4YN+KpZ3zLAgFJZlYODlBE2vpCWiGQrul/fXEnmVoG26gXahrvLzJFGSN0MPXwbJOd7mDS7SFur6wTropIqBJKiG9+7FJkPzzIy+C6/Jhw6a0ebiY22JFUKz559cG7WgaSabYSsTeUbIpAEzCeJGAEB/A6nekQm9UiRYnx8zj/0y4+8QIWKOfuhYZOvlHnVgNIEXKaVgCmfYGclUKjQUnfQc3jibO7Z4dHxMC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTFSSxhB+boCPf+wYdv2ATI13XSLk2swRhPqU5Ugypc=;
 b=aL/4TB+P4HsnksTx0tLGs5PCPRK61A+mv5UaeW/bMCLyVEMmAKY8/+oRMnGvQpknBSrvSoXcc8Vdvg1qgFGBJ+HDOmlIVTfqkc/7kahU6TOcc8qN2GO6n+XbjCHMDNouTVu/GCzdx8UPJeilludw/CJqbRUky5nUrC5O82esWgE=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 23 Jan
 2025 22:01:09 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::9f) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Thu,
 23 Jan 2025 22:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:01:08 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:01:06 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 0/9] Basic SEV-SNP Selftests
Date: Thu, 23 Jan 2025 16:00:51 -0600
Message-ID: <20250123220100.339867-1-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: ea685d22-4790-432f-4ee2-08dd3bf97132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JZjVdNwBx55jZAOaGHJQFOjTjSY9CpPhjmXiSduICw+YN2DAkW1JNCAqSg5i?=
 =?us-ascii?Q?yg6xEy1fl9hPyrewW1ZMWDrPnmCKlgS7rB8ThKZZro9OlHoZOhqgYduFyd12?=
 =?us-ascii?Q?P+lJmguIyWhLs2t19GpdFHLTgn69xaJaZHZNY+YtvaRjRVpUgtPhVU+6Bdbj?=
 =?us-ascii?Q?2ApqoLc4vjPy2otq1ku12vVHiALTcT+c8BOTRFPyOldtdYeXFkZ2FR7H32Uw?=
 =?us-ascii?Q?KEdqEhvpGTsVqOhm9YTk2jV2irrMjyHXQgJokmNqbdxHaRQacW+xwhP2g1F+?=
 =?us-ascii?Q?R6jQdxP2FNK38x5MzhhrdG8kvcOJS1mDCIv7P0DFd0gxhTTSZ7PGhQMIwebn?=
 =?us-ascii?Q?F/uKWed86wzUvxRy93o+RjbzIHslgxr7Zgexob50OArXVrj9yH/Wzdq9cqN/?=
 =?us-ascii?Q?l6/a5nudiC40F5q7p+qPLXAH3vVDbFeWN/p+ji0bxywct+exU2sMqHdp2GAB?=
 =?us-ascii?Q?aWH2M68qUtFIX9l8pcSJ04w0Ba8fDlqTr/czAZxetP6fiUhvHl9vhMP6SOck?=
 =?us-ascii?Q?0O2IRer1Emn5diNbDAzF9SUqQKneSKEo5ME/O/zOSityVudeGblKus1fxuli?=
 =?us-ascii?Q?EcpaVd4Fmclzvqmv2E7JzZmKOaKdoufJo2k1vuU8cu3MpeBmF3T9jG6mezLo?=
 =?us-ascii?Q?Rv9pNBwAjdz/sTJgPyGPbALPkp4e4+0GIIuDYU58TqlXpKLiEfmCFGGYrnDE?=
 =?us-ascii?Q?kH2R+tHWzfrlGRk2CbzvMCcsG7LnaKjm4B810TOGah84BhNpc1DiWzMR/yeo?=
 =?us-ascii?Q?Lr8Bqz8aJHps+ZmCja/cw+t6MwZNQPZhNh27QXynhLZGPts/cKAyOZgitktP?=
 =?us-ascii?Q?PCcgP/TyDVhCCV64qUjwKCkIHdt3z8qvgJrfYfjUuBRCHFn6igLmaBmxIKAu?=
 =?us-ascii?Q?l6b6YfufwSYY8QJjFutNQprASD7v+oYv9aJzB2ZnFDYyk3zE7BjlJAsyvcwf?=
 =?us-ascii?Q?HbnsXWVgkwVNZ+CcbLAAKbRNYJPWtijfRdt0q0GthAtbQEB1ECOPTmY67/0I?=
 =?us-ascii?Q?fHtYd06gfKKX7Zlap2sBwydiQjrJ9B8FjfDeJXCfR9Ckz/j3PXg/qTAq1bEm?=
 =?us-ascii?Q?uaPcnEyHVShpb37OAhHKQewgXAk0ID1cnWYhzPZBTAXDaofBGLLK7g1xBAs7?=
 =?us-ascii?Q?b/o1XqTLJZi2Tf7X3mSMjJe3kFxx9f7shFADvehES6oJxlT0rtxq24de0O5o?=
 =?us-ascii?Q?PK6YoAVubI7V6RYuGvzLvnXZfXEPfxaCxZcUZunTFjLYV158d4DG6bIf+Tag?=
 =?us-ascii?Q?7DwOD9+ZFYauCqWHLgtylUlXZIH4+O6Dfy1UsL00x3w+fLLh9fFmviQkiHT+?=
 =?us-ascii?Q?JREJALlff0shoxTmtkAP8M2qn7nqQxZ7jbJgCRG238Vly0Fc/v5HZddj0yzA?=
 =?us-ascii?Q?xfXLl4CHqlAdV98Nr8c9TIbC9EaQFJD3jfkaNNHOZ84cOCDZ/DnUOozuPfhx?=
 =?us-ascii?Q?d0p3TEa9sonohxIlAsoRBjGXY7hrsoAu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:01:08.6933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea685d22-4790-432f-4ee2-08dd3bf97132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659

This patch series extends the sev_init2 and the sev_smoke test to
exercise the SEV-SNP VM launch workflow.

Primarily, it introduces the architectural defines, its support in the SEV
library and extends the tests to interact with the SEV-SNP ioctl()
wrappers.

Patch 1 - Do not advertize SNP on incompatible firmware
Patch 2 - Remove SEV support on platform init failure
Patch 3 - SNP test for KVM_SEV_INIT2
Patch 4 - Add VMGEXIT helper
Patch 5 - Introduce SEV+ VM type check
Patch 6 - SNP iotcl() plumbing for the SEV library
Patch 7 - Force set GUEST_MEMFD for SNP
Patch 8 - Cleanups of smoke test - Decouple policy from type
Patch 9 - SNP smoke test

The series is based on
	git.kernel.org/pub/scm/virt/kvm/kvm.git next

v4..v5:
* Introduced a check to disable advertising support for SEV, SEV-ES
  and SNP when platform initialization fails (Nikunj)
* Remove the redundant SNP check within is_sev_vm() (Nikunj)
* Cleanup of the encrypt_region flow for better readability (Nikunj)
* Refactor paths to use the canonical $(ARCH) to rebase for kvm/next

v3..v4:
https://lore.kernel.org/kvm/20241114234104.128532-1-pratikrajesh.sampat@amd.com/
* Remove SNP FW API version check in the test and ensure the KVM
  capability advertizes the presence of the feature. Retain the minimum
  version definitions to exercise these API versions in the smoke test
* Retained only the SNP smoke test and SNP_INIT2 test
* The SNP architectural defined merged with SNP_INIT2 test patch
* SNP shutdown merged with SNP smoke test patch
* Add SEV VM type check to abstract comparisons and reduce clutter
* Define a SNP default policy which sets bits based on the presence of
  SMT
* Decouple privatization and encryption for it to be SNP agnostic
* Assert for only positive tests using vm_ioctl()
* Dropped tested-by tags

In summary - based on comments from Sean, I have primarily reduced the
scope of this patch series to focus on breaking down the SNP smoke test
patch (v3 - patch2) to first introduce SEV-SNP support and use this
interface to extend the sev_init2 and the sev_smoke test.

The rest of the v3 patchset that introduces ioctl, pre fault, fallocate
and negative tests, will be re-worked and re-introduced subsequently in
future patch series post addressing the issues discussed.

v2..v3:
https://lore.kernel.org/kvm/20240905124107.6954-1-pratikrajesh.sampat@amd.com/
* Remove the assignments for the prefault and fallocate test type
  enums.
* Fix error message for sev launch measure and finish.
* Collect tested-by tags [Peter, Srikanth]

Pratik R. Sampat (9):
  KVM: SEV: Disable SEV-SNP on FW validation failure
  KVM: SEV: Disable SEV on platform init failure
  KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
  KVM: selftests: Add VMGEXIT helper
  KVM: selftests: Introduce SEV VM type check
  KVM: selftests: Add library support for interacting with SNP
  KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
  KVM: selftests: Abstractions for SEV to decouple policy from type
  KVM: selftests: Add a basic SEV-SNP smoke test

 arch/x86/kvm/svm/sev.c                        |  6 +-
 drivers/crypto/ccp/sev-dev.c                  | 16 +++
 include/linux/psp-sev.h                       |  6 ++
 .../selftests/kvm/include/x86/processor.h     |  1 +
 tools/testing/selftests/kvm/include/x86/sev.h | 55 ++++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  4 +-
 tools/testing/selftests/kvm/lib/x86/sev.c     | 99 ++++++++++++++++++-
 .../selftests/kvm/x86/sev_init2_tests.c       | 13 +++
 .../selftests/kvm/x86/sev_smoke_test.c        | 96 ++++++++++++++----
 10 files changed, 272 insertions(+), 31 deletions(-)

-- 
2.43.0


