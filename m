Return-Path: <linux-kselftest+bounces-23848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D549A005A3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 09:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B81161E5B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F91CD1EA;
	Fri,  3 Jan 2025 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rSexzEfs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DC4C62;
	Fri,  3 Jan 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892334; cv=fail; b=H+pobC3v20bYTMi2U/RBIIDh2D5bvWDOnAkEbT0iaYKr2TDxq+IKANH/u7Gg2S776q04tcGe08/4DpIxvFbZYtcqxbMn5roJ3r9KEr/XlsnYtYF5Q+pHutdWM5sRjhKMI9rmP2uoOhGQjA0l7kaUWsr2OiVtKqyKdIOvhM7gwO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892334; c=relaxed/simple;
	bh=F4bkq/AFGZWfy8G8Z2t5D51SFOBxGT3dCMX3DPMG7yM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7V/AY80z0iV6oTQePBuo4S4ES4l4hIBRU6Dh3LGM9j1UF2eKl7qE71NiSjrnT1UrFF7ip5fe74v8ZewsKx12rTw3nc2Hg4ngyWau/d04zzoLnXQ1E/cuThTDQVDZ+j41eUSvML15ecD5TRiqGZ4p+poetWiqBYl15NQZka2IPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rSexzEfs; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAxiaRoZmU0np55MZn4bQfSlPeGiOXvbBbvszWGVorguNlOHDGs76kZIeJNjiUR0s7R8JDbdhAUAxtJi1mI6+cxQUL8R4ABf3a9KgIFPRYAf+Po1XkTPFIhT4vcjbuypJYhcNLPBgVvP9BFn5mH/s+hFjjz+uppZ4zhVsqY2monWDSoP1sDOsi65fDbHe7fDKUbRB+dqxFINSgi54+DFHL3RcuE3hGu+b8IErGW8pfAMhR/3yQIsgqrVuD9p7Rn406vjVZ8rebwEGlvzdoTX4pGgSp7+M2gWESPy5sIPUiJkuR8tHKy96nNcLe4FDU2MrCZNpA4RYSgGminEvNirCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvkTLdMSJwdzcGA2FHYbzybg0KDVssrpF1pO1ZN1aZg=;
 b=o5hWc8rSChpvvtJwWXaHYf8PzI9BqEicFaIuNB62wS9goWjLJaU3jG8DUvnvrlPtBsLsfO42AZadGvdCqXg7eyJ3WjjVYeThrvlcBDz8Q2QmvwOYJZwCh46nJeu/x4q8r/0QXsUAlF6525nOl7TEdoI9CwlsRpFjJmOmB66ROnJbyInF0rf36LBxTJ5r0IuaFQcj6WBmCIqWhdIS5gvYNKQJ3bKaQdbibnnBANirGiePKTuPNLmOklSvF+z/+3A5YdHBduSAUPhQYkmH8Iz0TQ/WBDMe0Yce8qwA3SGe7Fw7ZnXqCWkwAFf0oUqUOcckLiq2VqZZUxyDZT+xzXBrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvkTLdMSJwdzcGA2FHYbzybg0KDVssrpF1pO1ZN1aZg=;
 b=rSexzEfsEvyq4QZm1zRetqZkIUiGA/GconuyXEmqXoU1TSWz2RLzf1zZpgqAzyEiipGZJwQTtWR/ys+eBQus5XmAKf2HI2JOML7iNuAxkXRBBhvE9z+PpKlTe2LgjyMbkAL+K4WFeFEjsPL/3+9zCYFxeiSTpG6ypQVOx6NiN14=
Received: from DS7PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:3af::16)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 08:18:44 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::90) by DS7PR07CA0006.outlook.office365.com
 (2603:10b6:5:3af::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 08:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 08:18:44 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Jan
 2025 02:18:42 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v5 0/3] Add support for the Idle HLT intercept feature
Date: Fri, 3 Jan 2025 08:18:25 +0000
Message-ID: <20250103081828.7060-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d7c2a5-b700-464d-7d18-08dd2bcf3d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckxGRFJMbVcxSjBYMzVFdUFoV3dDVTg0ZHc5aWllTW9NUmJubzlCUXMzVzdw?=
 =?utf-8?B?RWpOSGZvUWk0TFk5VXBVb2lzVEhFVXEzOWVjODE2LzlqUVo0bm5veE9mcGla?=
 =?utf-8?B?Q3RJbDd5NTRoQXBPei9JelcwZkk0NXhXQzlQSDBwQUdNb2N3ck1iVXlraHNx?=
 =?utf-8?B?bnhOdWdDdlNsdDFjOStZdnZXYmZNZlJIbU1BV1lvMkJIa3lZK2FEalNxWjR4?=
 =?utf-8?B?ZE5KemF2aUc1TDdXODJySnlvY0JWaFNab05qeXFNU0pObUhKYy9tcFN3ZWQr?=
 =?utf-8?B?eTUxSXJkanZ6TzM1UXh2UDYvdU5OZlJvN1cvSDljUTB0MzBPOW5XMFJ6dHNO?=
 =?utf-8?B?OTdPK2UzQnZncU9GVlBQY0hoZDJ4em9VZm1reGI2Rk0rdXZWUFRGcHRlQXgv?=
 =?utf-8?B?M01RdE9WKzVIeDNuQjQ4VFN3L1RuZmVQYnEwa3hQM1UrVlM1ZFltL3ZLY0RC?=
 =?utf-8?B?d2pQbm9FS2JuWU5YNDRSSlYyVzAxTndGdURlQ2JsclJzU2x1RWR5WE5ia25U?=
 =?utf-8?B?bGNVMUFzVUY5Y3BYMGF5OHRLQzZKdjlyVTdFSk5xa0M2eFJXcWROcGExQ0NK?=
 =?utf-8?B?OHNoUDUvM0VYa2FmVWdabnZkeCs3MnNnV3dDK2RVc0tnN3o2TDhPbnNBYlR0?=
 =?utf-8?B?czh0bWJQaVF5ZnU2NkY5KzZlSVg3cCt5dWoyd0xHTHh1K1dUYUR1VUZ1QlJK?=
 =?utf-8?B?b3VqSkNJN1Z3Mk4yTm1WaWhwemFOSnR5VVkyeWJUdjdUdnlCR2xPcjYvL2Jm?=
 =?utf-8?B?RTJ5WGZoczN2WFJvLzRtMjBHdWUwK1ppTkd0cE9kaitzRWRHcytRa05DVTI0?=
 =?utf-8?B?ZzJEV2tveit0dlRCRmp1Mk8wUUszdnA2cHZlTXdxUzVVWGVYUXc5bHdoNDFK?=
 =?utf-8?B?amE2U215Y3JFQWZGZ2hMV3dNa1V2Q3N4Q01IU0NrVGQrcEtudGF2bmZ3UXln?=
 =?utf-8?B?eFN6SUlhS1FjSXdLTjRDZ3JmNlZIcFdoeXl0djA1ZWYrYUtjcE90TFZCaUNj?=
 =?utf-8?B?Mjh2dEh4bEJodDBIR21vVEptc1h2UjJCb1pWd1JmeXl6cTI2VWhEZ2VOWGZq?=
 =?utf-8?B?KzBLS296SGVxSTJuMW00U2UwZndtZVgwSHpZVkw2VWlDS0VxeXBJaDVlK0hq?=
 =?utf-8?B?OU5BUmc0WDIvV1h5VXAvQkRLZ2FFUUx4cmxsU3NneGhKa29Zc2hYaVdnQzNz?=
 =?utf-8?B?dUdWNlFrS0hSYU8wYVo3MU4yMTlhamhtUU9yYXVSZkRDYkRsdE50Z1RXK3Uv?=
 =?utf-8?B?R3l2dzBVUGRaWEp1eCtpLzhsSFhHckVQTzhyWEtGbkxoWjZjdkh4U3BYV3I3?=
 =?utf-8?B?aTAzdjZLaUN1UEdycFFtNS9Gdm9pZWlBNUhLMzBYS3c1cDJqaDc1Ykd5U0Yw?=
 =?utf-8?B?YlFsY0ZVejllN2I0SFJweFd4UlloWTltMXhmK0xuWXpBOUpWRTBWbXJNR1c3?=
 =?utf-8?B?Q0lBSlpkR0Z4WE0xUkg1WW5tY2loZWM0UUlnL0lyY3FSU0d5ZXZRTVVCWGNQ?=
 =?utf-8?B?cS92elBYTmp5NmdYWDJLSFIwOHFmbjhtWUhnejV6OVlGellrdTU5L0VaL3k4?=
 =?utf-8?B?dVVMQlVKTGFXdW9aUGlBVjJoZEdMdmtxV3RLVDBGMld0SG1PM1BoOGVIYWR4?=
 =?utf-8?B?YW9adldIemtLbVpOMWdVVnJodXY4bjBzN0djOVJaUk5NVnZQTStqTnE1SVBX?=
 =?utf-8?B?NUp3aDY5NFllZ0RWc2ZKY0xJTW1zV0dSdzR2ZUtyNmhuMEI0SWszekV2UktM?=
 =?utf-8?B?RWpkWFg4cE9jdkNJVTh2dmJDUmhHemlyemtqWDVFUENsMW9MRkw4OTIzUUFD?=
 =?utf-8?B?RDNWOVNUUWZlM1VzM2JqU0hJTGxWYXpyZEVVTmdYOXdGMEkyZHFObllKb3Za?=
 =?utf-8?B?U2JGaHoxZVNuYmNMbkk4ZnJlZDlDcjF6VVQ1Z1hMTGJ5OXNmK0NoQzVxRXB4?=
 =?utf-8?Q?C1qO6WWafpNGFYAtroiiuYe0fmE1gU/r?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:18:44.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d7c2a5-b700-464d-7d18-08dd2bcf3d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604

The upcoming new Idle HLT Intercept feature allows for the HLT
instruction execution by a vCPU to be intercepted by the hypervisor
only if there are no pending V_INTR and V_NMI events for the vCPU.
When the vCPU is expected to service the pending V_INTR and V_NMI
events, the Idle HLT intercept won’t trigger. The feature allows the
hypervisor to determine if the vCPU is actually idle and reduces
wasteful VMEXITs.

The Idle HLT intercept feature is used for enlightened guests who wish
to securely handle the events. When an enlightened guest does a HLT
while an interrupt is pending, hypervisor will not have a way to
figure out whether the guest needs to be re-entered or not. The Idle
HLT intercept feature allows the HLT execution only if there are no
pending V_INTR and V_NMI events.

Presence of the Idle HLT Intercept feature is indicated via CPUID
function Fn8000_000A_EDX[30].

Document for the Idle HLT intercept feature is available at [1].

This series is based on kvm-x86/next (13e98294d7ce) + [2] + [3].

Testing Done:
- Tested the functionality for the Idle HLT intercept feature
  using selftest ipi_hlt_test.
- Tested on normal, SEV, SEV-ES, SEV-SNP guest for the Idle HLT intercept
  functionality.
- Tested the Idle HLT intercept functionality on nested guest.

v4 -> v5
- Incorporated Sean's review comments on nested Idle HLT intercept support.
- Make svm_idle_hlt_test independent of the Idle HLT to run on all hardware.

v3 -> v4
- Drop the patches to add vcpu_get_stat() into a new series [2].
- Added nested Idle HLT intercept support.

v2 -> v3
- Incorporated Andrew's suggestion to structure vcpu_stat_types in
  a way that each architecture can share the generic types and also
  provide its own.

v1 -> v2
- Done changes in svm_idle_hlt_test based on the review comments from Sean.
- Added an enum based approach to get binary stats in vcpu_get_stat() which
  doesn't use string to get stat data based on the comments from Sean.
- Added safe_halt() and cli() helpers based on the comments from Sean.

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
     https://bugzilla.kernel.org/attachment.cgi?id=306250

[2]: https://lore.kernel.org/kvm/20241220013906.3518334-1-seanjc@google.com/T/#u

[3]: https://lore.kernel.org/kvm/20241220012617.3513898-1-seanjc@google.com/T/#u

---

V4: https://lore.kernel.org/kvm/20241022054810.23369-1-manali.shukla@amd.com/
V3: https://lore.kernel.org/kvm/20240528041926.3989-4-manali.shukla@amd.com/T/
V2: https://lore.kernel.org/kvm/20240501145433.4070-1-manali.shukla@amd.com/
V1: https://lore.kernel.org/kvm/20240307054623.13632-1-manali.shukla@amd.com/

Manali Shukla (3):
  x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
  KVM: SVM: Add Idle HLT intercept support
  KVM: selftests: Add self IPI HLT test

 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/svm.h                    |  1 +
 arch/x86/include/uapi/asm/svm.h               |  2 +
 arch/x86/kvm/svm/svm.c                        | 13 ++-
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/processor.h     |  1 +
 tools/testing/selftests/kvm/ipi_hlt_test.c    | 85 +++++++++++++++++++
 7 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c


base-commit: 13e98294d7cec978e31138d16824f50556a62d17
prerequisite-patch-id: cb345fc0d814a351df2b5788b76eee0eef9de549
prerequisite-patch-id: 71806f400cffe09f47d6231cb072cbdbd540de1b
prerequisite-patch-id: 9ea0412aab7ecd8555fcee3e9609dbfe8456d47b
prerequisite-patch-id: 3504df50cdd33958456f2e56139d76867273525c
prerequisite-patch-id: 674e56729a56cc487cb85be1a64ef561eb7bac8a
prerequisite-patch-id: 48e87354f9d6e6bd121ca32ab73cd0d7f1dce74f
prerequisite-patch-id: 74daffd7677992995f37e5a5cb784b8d4357e342
prerequisite-patch-id: 509018dc2fc1657debc641544e86f5a92d04bc1a
prerequisite-patch-id: 4a50c6a4dc3b3c8c8c640a86072faafb7bae4384
-- 
2.34.1


