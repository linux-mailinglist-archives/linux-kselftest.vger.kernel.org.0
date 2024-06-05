Return-Path: <linux-kselftest+bounces-11233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC68FC2E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 07:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446AF2858D1
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B133213AA45;
	Wed,  5 Jun 2024 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iGhqrvCB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAA61FCC;
	Wed,  5 Jun 2024 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564142; cv=fail; b=NgGD0A4Jvh405dIplDowh8rzf9uAk5frbScc3LVl/Qm1W0kw3VbBI5XBIgvufsN2cwGDVjYPXILSCU+UPxip1xBvNuj03PjGgIV7JlhhOCQnsxBraPbcdJEM8RdVLPnU1V5N4A4n2c7GWxqQqIaiqut9qooY3OcL7cA62i3vGqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564142; c=relaxed/simple;
	bh=FfSz3ZE9IZEzvxYeU36v54qUyHAxokoUFLXBP5R7ubw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RfEU4bpE5OTv4Ord9McPLdGeG/BSSPX9pxefgNPEJfvE7gn/xRQeIvoZghGELA7/IaIHtTCQt5V0F5WSR3a4njD8sphe0XhyHm79YKudCrGd3hx8+PEmTwC4yOJ2I3Oq48opRRzTZdaqUMMtcc9u8QgAkvFja1MRQmx7urU3cQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iGhqrvCB; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/iFk+eL1qncZkmmdvR4j9F+KGCEaQ1xbvTKRa5ogEtxpcVjDuQml5LySzfLcuJkfuxPlIDQOegJ9LJhmoOQ42YIyT9NzC+0Ui9Qt4j5WSH1WpSzvBTRPgXIttIZweTvsBfgsQD4+0G4PhV/gFgphjlyTVhbeyEuJeHFP91qekvR6C8KASCgyuf+eYZfcZOrY4xFrQn4qWaa6xzH4BssPeG/dOfMFKAS3m1QWbvuE38bQLetYhO8/QoY/dCs4RzRJBPg3wv/P+WQP+E97wI2rgtckR4G64NRCnomjdfnkSDd9qSzd2NaZg9bFJOGzb73cJmzAa4EKOzBmyiQm/YfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9vr3isAp4nddjTJ5fceeALbkBx2aCteWLQOUBOtx0w=;
 b=G5mjIYm2TQyzg8HbdmAvY3PO7s7zsj7zAn7XwwIkYSwW122+sYVrCCEtZ3//kbmekZ9CeiUtFBmsudVf1bCU2xB3B+32VLAEBL1jRJ1ltHCquKubwAR7TbJ3Y8uwczrvURaU+rG9qhMVIRpSHkN8pHI/B2yTbG100YrbpyPYIXDNbe3Pt0FjUR9gvkPUNnJwAfX6xfHG7+gyZoriJthMi2X/HvkBTu317jI976XY9JgF13ikfMfmozrWlvfHd50R8XqO2PyrDMqbjsxVngHfC7F9rT3PNZRBWhhqt/jW5hkPEzXufQc4Z6VTd4bW7JQC46ADbKaoTjLxsMD2UQHrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9vr3isAp4nddjTJ5fceeALbkBx2aCteWLQOUBOtx0w=;
 b=iGhqrvCBI27pPOtfO3xTLcn5QlRS0/sNvdeVy2k3JCtGCu1O4B5PszA3p2gTlCZ7ZtXscO37XFPt4HQHqtTLrYceh8ppxVb5u+9ad9KPl5EEQdiQdN0cxFYN3jVmfvQW4ymsUMnFeAi4cdwgIAasPyoVvgNv+WGv8dlRLsy9WHU=
Received: from CY8PR10CA0045.namprd10.prod.outlook.com (2603:10b6:930:4b::23)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 05:08:57 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::74) by CY8PR10CA0045.outlook.office365.com
 (2603:10b6:930:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 05:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 05:08:56 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 00:08:53 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <manali.shukla@amd.com>,
	<sandipan.das@amd.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>
Subject: [PATCH v2] KVM: selftest: Add a common check to identify AMD cpu in perf event filter test
Date: Wed, 5 Jun 2024 05:08:35 +0000
Message-ID: <20240605050835.30491-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: bc66be14-f857-4075-6a9d-08dc851d9a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QGLo/ksVg80icgykRI1tWWiY2ZBb4YGUePA7xisSKcKXOXP4TH3PsfOzo1CF?=
 =?us-ascii?Q?jOI6zGKDBz+u9/QsCMUvuxgqJvGxEvRyCI5bpkBjzCTMnIsVt4gJ33kkppxt?=
 =?us-ascii?Q?jpdDND1LUarzJwEuAJTishhYfwsMhMB+AljZGzec3Cz26NefqbLLsX8F9Ipm?=
 =?us-ascii?Q?5amsHQYLe4nj/REwiCMY1nnrvdddZfZtFLbypE2Ox20V/D/2NkGMBL1lZax4?=
 =?us-ascii?Q?4LLMeuGQk/xfYKC1lVFWcfKuU6Ug/+LqDQcYb62IiFLBxxIs8W1Ow9NJe6vD?=
 =?us-ascii?Q?leo8KPtySKeKbDqHUtKVmVR6ms2RLIt9KdxQ+yXMRUHweg1h8R1VjWS8CRR6?=
 =?us-ascii?Q?Yusa7RZCofTWSk3BfGbDcpREfjUfbxlRaWY8j3+wfqJ7mltSiBIwE1f+2zs+?=
 =?us-ascii?Q?iElMua3R2EBDnmDT5U+sbgR8JU9uK04OYR6lZLafTM4wmjmB/mzaVTm8QCao?=
 =?us-ascii?Q?qlwwPccH6mOFZ9RrsCV9tRP8R8KGkI44xB2A2Tq21E9ZnQQQbhf2iCH0/e2a?=
 =?us-ascii?Q?EA6Q5JiPJ902SGKmhbyNQ350KR0eIpurWXPaJZQMYHu68kwqJ1i4FfEaszT3?=
 =?us-ascii?Q?yEw1iGQoPODph3fMDHpVNVjJCCZRi3rijf/2XFSgJW1KjbAFSFKMGGR7IsQH?=
 =?us-ascii?Q?Yl7rZP+vT/qWVT/eQ0jfXBgrthVMOIc8Nc4IhBD79cQYKeBql59xjwONTihC?=
 =?us-ascii?Q?LNW0xb1YU7m9wM4NkED1QEdGWy1WYVzE1xpT12lo67H1CQ6C21Pl9/RAglTn?=
 =?us-ascii?Q?MfUxml7JNJaf6OBCaVcl3KB+ISwuV/8mjQbaj7lDmo4HfuGQg2g906z9ZDG9?=
 =?us-ascii?Q?bQqH997KlVYHFyVb/s5Q6UvaiLH4Xdt3syXodOir8650cU7ScZw6raLVnKBv?=
 =?us-ascii?Q?7ZgyJL2oBjuAKmxqvZjdItWFZlv3YUOXqbEiNp5KHoF74NKRnZvl40AksUNk?=
 =?us-ascii?Q?qKYBQqPePZqrnMIaDDU2TTDxqe/DWbOHiqK1FcWumvqpozTQPbNbtwAotiqk?=
 =?us-ascii?Q?Jz3If3xnW4RoZNq62TCI/6b+HKxv2GH6s3q1HFmTVMfQnu17dhwwVUnKKFCh?=
 =?us-ascii?Q?ziL5eHk0uj4Wik8A9zzuXH3i4TIKWPXALYSkVPfFWz8NiBYOou5B45coOr4q?=
 =?us-ascii?Q?dhBrU3VUhqloGIKfhyi7jkscIXmfRcXZS73Xzr4XRj3qXVkRmF2/U/tVjG2F?=
 =?us-ascii?Q?l8mfohdd2hK5HyocuVGrN60c5ZcV6DKaMW9Y2A+BxUHGHoXkbb+baC9X4ye5?=
 =?us-ascii?Q?CIumlGDsOwjVsqhBJ/m1oSBq6SebnZ/wFbRRxEMGuENh7EsWuXcoWd6F6K60?=
 =?us-ascii?Q?2GA/wRgKu9Ut7diZW4zqQ6RCpZ0HO0fGl7kJmYFnK/SAW/IUMm44fFc7YSLL?=
 =?us-ascii?Q?SVqK12Xu75NemAATJu3FjqsrmpKX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 05:08:56.9376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc66be14-f857-4075-6a9d-08dc851d9a67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164

PMU event filter test fails on zen4 architecture because of the
unavailability of family and model check for zen4 in use_amd_pmu().
use_amd_pmu() is added to detect architectures that supports event
select 0xc2 umask 0 as "retired branch instructions".

Model ranges in is_zen1(), is_zen2() and is_zen3() are used only for
sever SOCs, so they might not cover all the model ranges which supports
retired branch instructions.

X86_FEATURE_ZEN is a synthetic feature flag specifically added to
recognize all Zen generations by commit 232afb557835d ("x86/CPU/AMD: Add
X86_FEATURE_ZEN1"). init_amd_zen_common() uses family >= 0x17 check to
enable X86_FEATURE_ZEN.

Family 17h+ is where Zen and its successors start and that event 0xc2,0
is supported on all currently released F17h+ processors as branch
instruction retired and it is true going forward to maintain the
backward compatibility for the branch instruction retired.

Since X86_FEATURE_ZEN is not recognized in selftest framework, instead
of checking family and model value for all zen architecture, "family >=
0x17" check is added in use_amd_pmu().

Fixes: bef9a701f3eb ("selftests: kvm/x86: Add test for KVM_SET_PMU_EVENT_FILTER")
Suggested-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 32 +++----------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 26b3e7efe5dd..f65033fab0c0 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -353,38 +353,16 @@ static bool use_intel_pmu(void)
 	       kvm_pmu_has(X86_PMU_FEATURE_BRANCH_INSNS_RETIRED);
 }
 
-static bool is_zen1(uint32_t family, uint32_t model)
-{
-	return family == 0x17 && model <= 0x0f;
-}
-
-static bool is_zen2(uint32_t family, uint32_t model)
-{
-	return family == 0x17 && model >= 0x30 && model <= 0x3f;
-}
-
-static bool is_zen3(uint32_t family, uint32_t model)
-{
-	return family == 0x19 && model <= 0x0f;
-}
-
 /*
- * Determining AMD support for a PMU event requires consulting the AMD
- * PPR for the CPU or reference material derived therefrom. The AMD
- * test code herein has been verified to work on Zen1, Zen2, and Zen3.
- *
- * Feel free to add more AMD CPUs that are documented to support event
- * select 0xc2 umask 0 as "retired branch instructions."
+ * Family 17h+ is where Zen and its successors start and that event
+ * 0xc2,0 is supported on all currently released F17h+ processors as
+ * branch instruction retired and it is true going forward to maintain
+ * the backward compatibility for the branch instruction retired.
  */
 static bool use_amd_pmu(void)
 {
 	uint32_t family = kvm_cpu_family();
-	uint32_t model = kvm_cpu_model();
-
-	return host_cpu_is_amd &&
-		(is_zen1(family, model) ||
-		 is_zen2(family, model) ||
-		 is_zen3(family, model));
+	return family >= 0x17;
 }
 
 /*
-- 
2.34.1


