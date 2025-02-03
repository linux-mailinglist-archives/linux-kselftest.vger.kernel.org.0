Return-Path: <linux-kselftest+bounces-25605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF3A266A1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9109B1658CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D5821129D;
	Mon,  3 Feb 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ObD50ky4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E520FA96;
	Mon,  3 Feb 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621940; cv=fail; b=FoDsGwMJAf8fNylouyognScO6AI/IkPzn7Aieh046DEeFZIKULMjqaUqUo9yfhCtFb3UU8GTu+f/lcxcsGUaEXMIoGhcBKwy9WEtgDgG8Q26Pnf9tTuy9h8M5fZk5J87OJmfellk3FjJQtArRIJjJvDSVY8hR7LBP7Hv9IFmGcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621940; c=relaxed/simple;
	bh=2ss985WV2tdPPssmP7oeLYFe95ulGCPT4yORPgj1WWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jyfABWGf6TKFvHwhIa3+BOtB8ISvSI3WsSyQYtUJx/+LdOf1yaj7RL6el6Hjc7ZaoTnJK+xnq1R8EXDUkOdhfG95I6IsgjhDYShHZBP+ITkK9LD8wSquQJvHf8QWiC1jtFXNEE0tiP71uewdnYZPeRkb+XoIxr3+0AxK+CCMktM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ObD50ky4; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybPn7Ynv0bPrNyZEOtrRbVPnRVmJmSUZ11orxkzZpCUrLml40POJbTdReqWK7EePMhs/VTXq68aQPNjAhZwJR4AInPttPTp8sFSCGt4sT7VPAO26xOdtF1zHSoeLaSQ8VBjfAHtv9jz7F7D5YY34x8OGBZkxGHKYJl5zxZQ6eSte+M0p8NmagTRIBAV86ye+Jy+FQq4fDz80DAnG+FsSQ8NdCyUv9ckY3CytzG9MF5stKESmPJYU5zPvuHCMevX/Rap3F3GazbMraUaCRI3T6JYX449NXHL+DipaVwHZVaNStp1nuBK61anU8/Q6FXHUNdNXHGc2zhQFsRw5b8/T6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPNTuMvGqNsWF5TGFrn8OnVpsDB9TM3KCO/BFeexGBo=;
 b=n0HXSv/2S8A4KlemNGYNeBNGIoI4vRQGlz+QkSt7QdnshQRzMu/HPPV2Dmlxe3tmPSJxb1wd2nJ6aMVMgW48G/QPx1iAkeMH8DcoLIP6GrG9LcEdwHqMNTafXXPCyn598pR7i1uSEFaxt36uaj2J0CN+zSmHWNxA368PcbAn401UGlLusKbcVtULsnsdF94Oxm+zEQQH2+AwaB8sY5CDfDPD8rZEtYtuCKtHCxlfqncar8i58BMP3adbEacGtL5M8p3bcaVPqV2HzKJ+RL78bvJRUeC1xkn9AS+T0BoWGX3g7BFRhiTHgpUXxwhVUaS7/osRrJ1UkWLa0p5eZoD38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPNTuMvGqNsWF5TGFrn8OnVpsDB9TM3KCO/BFeexGBo=;
 b=ObD50ky4ZCo7vv72MeV6qcU+QTgC5Bz9WXvDo8+ATHvw0YJDnnGfbOa700fVj7KE6Cqrr5CXBs8hGZwDB5rs1w4T5/zkqB4g1Eq7zIWQOOVyPun+rIXx3XYYiKIb1MGBfMuly2fEyVABl86ilB9se2KBkSxltJveNsg/J38OFgA=
Received: from PH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:510:5::7) by
 PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 22:32:13 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::9f) by PH0PR07CA0002.outlook.office365.com
 (2603:10b6:510:5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 22:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 22:32:12 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 16:32:11 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v6 0/9] Basic SEV-SNP Selftests
Date: Mon, 3 Feb 2025 16:31:56 -0600
Message-ID: <20250203223205.36121-1-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6e55c4-d2b2-4062-bc56-08dd44a29adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lH2kUOnV2SD4DLvsy0xngebUO3XsacrgUxxIi9J3XW37fP8BSD9tO7eSLmR+?=
 =?us-ascii?Q?R3QAuE19p5YKIgTXN7y2nnW+hlGElMcZJvLp56rItb2v17Brb/mgNeHb5OW9?=
 =?us-ascii?Q?gfOBLD8Mn2XhhxSsftJrciT384JjN3qhf2xzkaPqadxrcqzPvdT3q1vvN5O1?=
 =?us-ascii?Q?xZuYfNFPN3udVM81UDAB9NSg2DiCOH/P1MoAGc1ccZO4StKPWXrnrW72Vwdv?=
 =?us-ascii?Q?iCON3iPxiN1v+w3aME/XsahYAq5JLbFAMbRq/YlLHbBW+RN7v6PMUrVse+Zg?=
 =?us-ascii?Q?6P8F4ZWYybse5RZaEKRP7HLWOSaANzjaZBxnIlnwPKGJqJpq2YdvGc3UjBtU?=
 =?us-ascii?Q?N6VVXh9alsEwsq9VIZyciZ7yayOE7BEjZLb2VxfttpTIRF0AQfk7xuiAOxgo?=
 =?us-ascii?Q?o486eONAlmZHvgXFm4wHSKlCaZLgn43fX3rB7by9wrllOZqGTN6felMOiuY6?=
 =?us-ascii?Q?VBCbv/+IWRdp81PzzEl/7VoVSoh24Gi5X6e2Z+0oVJuf6XDlcTkuX6PKzORS?=
 =?us-ascii?Q?WkHgC0RxupVlmlpGIDeZtUy34teRBQooRtEnbnGdqT/bl9mifpGmz6uw+QV3?=
 =?us-ascii?Q?5kBG4I2S6b3/JTBjYYM9x772pU7Adht/AU97oEoPXoILk4oJaEGFNlGe5P94?=
 =?us-ascii?Q?FvgWUK+LKmctXtQDKKOYyEglifeM26rTd8uMzv+aLxef7SI0R+Q+7OTYzy8s?=
 =?us-ascii?Q?dRTjfy5yc+CghGb7nmAhlFKj0hz8TwUX0hPPIfALSv5fn2AOuB2zBcABa3OC?=
 =?us-ascii?Q?xKkH3I4imjp0ZhjbAb79crsLJLBg84ApfMLakK/x2cjuXmNCNHraYpmP69sF?=
 =?us-ascii?Q?H/Yz8mvdmZLRp3XThKMIneCT//1iRaDRrEnPde/VvM1c39EYpSe3RpbMYlyr?=
 =?us-ascii?Q?gyqdGNGayT+hh1o7tQMkLoXlWoJRE1yWqx+n+qTzkjJnzg8BaKFxaIVqkAD/?=
 =?us-ascii?Q?n8o/daatnRYBhXXJjIPsG105GwWC7MK71EPs/3HWEKX+PWhB2iVQznTOyunc?=
 =?us-ascii?Q?qh8+YlUL52JJerrP61+YUPsgF36kqm60XXaijNowhWPIC4zsyGzcbVMVsk5Q?=
 =?us-ascii?Q?g0bACxrXj9ZeC2k1NT0Ey1bMYE2B229bF/Qu450UuIxtKApnjVyyjus0RJaX?=
 =?us-ascii?Q?ASc6weFPFmyBd8qu5U2dtm5YOcQQhHSv8gYOdyhHKBe5M8SQ9eTvf5tYE2sH?=
 =?us-ascii?Q?j0p46U0CrKH63mlciUi+v14igt/C2ghd037vNN6HaqMcwef05kcsdUTeGDuH?=
 =?us-ascii?Q?fzw5zXQAUbWK6hFBRZHIgrQQJ1oArpqK4U1AI3+cbvMNDK60Mjm/6schaUrM?=
 =?us-ascii?Q?J9/Q4bgJN2HanAjDh3ck888ICZP88qiClpW1yCta69uCPH0bV6xgclO52796?=
 =?us-ascii?Q?GtgkkYojzhcjae9aGwa7DXKgm7cZR63rVm4AHsVbyAbiguPcfFYlC7/+V7Q7?=
 =?us-ascii?Q?4Dk4tqZCjbXlyVskQIVm+AXoYF/ZnPHU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:32:12.9023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6e55c4-d2b2-4062-bc56-08dd44a29adb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928

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

v5..v6
* Rename is_sev_platform_init to sev_fw_initialized (Nikunj)
* Rename KVM CPU feature X86_FEATURE_SNP to X86_FEATURE_SEV_SNP (Nikunj)
* Collected Tags from Nikunj, Pankaj, Srikanth.

v4..v5:
https://lore.kernel.org/kvm/8e7d8172-879e-4a28-8438-343b1c386ec9@amd.com/
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


