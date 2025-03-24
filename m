Return-Path: <linux-kselftest+bounces-29638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE86A6DAB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C109216E342
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D26425EFB5;
	Mon, 24 Mar 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j3j2azf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAB802;
	Mon, 24 Mar 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821396; cv=fail; b=m5WhKnoF/+lAMXcW3NDOKX5u2rdKr4YN6CCW438dnJ+xqxvN0pzc8ZpJvBldmMVTNWdIo6/axBP2CuCrDr23ALsTX6eZgp+SlDYHjpyHpRlMehTu97G1yshMqPw24cmTx21SvJ46C9xbNePp8H0wwZf9BuVwY+iiB02jWgOLCpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821396; c=relaxed/simple;
	bh=UyIObMIYpmFd07keEKtf9i5/hNc31sOX8FWeszW3b7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APb49bd/KDlqPCaPHrHiREm0xpXIscec+AYjI5xdnnstYSDWQOLiK6vUuh8LxfomlnRTQe4Bvtk0tKZtECdteAoMlVeTGInpwthw6jIOLllJifKg6BtIjBJfJYm1o0vxEflKWVflEgWYebJGFOZonCrP1NxOhRWMrAbEc9u8ki4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j3j2azf9; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4O4sQEunfXMBE2DggN+e1oayvEBJkJTNFU7VRZUQR8aQf2Ib/cdzfErBTd07mGIYIQ8T3KCIkujnSkbTb8cxJLaQ5qitA7M1fAvroa9uypfzkWHwKXaDZv3EFEKjdtp+EfVou1GSF9iQ1KmkvZpi5JfgDrH+Zfh5GJD4YtPimzbQ1oj9jD4NvgJ6+AkfQI3e2xPhkGz5s0KBfzeA2bhGQKLuZxX+TjG1BSq6E4BxDzxCYILgmWaO1QmstxOdNWOCN+4FKd8GzQToJ11JwSdjR0LloPk3DtEIVVGcNbmTNRd1Rrv+u5TPrL/C5NE7vYKlurkZtV5zuPTY7b9bdqF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbTj3D9+EcuEik0Hc0H5A80EciJ/iLTb9aJppxKCXEo=;
 b=RPneMdMsTB+WMD44bM0fZ+uf91SaRcFj5WQ7itPe3PST2S7NUh3rbxyI5e1iPullN8SnnP+r7utXqz/ZZ9G2jwclGCL3E+LAoj/oZNGsafD1aR+d6IoEvhfq+6VqFINI1IxNA+LywvmRRDS/HCclpa9sfuuumTPM6O2OjBeRkAYL5syR3HOjY0LH2w3KiOmI5pCk/38gZ2YO8HjxH2AKYZXDXX9OkZ6fJtYTL6Zzrd6TKHkeftRksTHNBPH7gLxqaeUvJ8KKwq0iOWpbrL+t2q0MPaDbkJ66shHiLm8YitAK0uCKidAZs+u/pUYsnX6RwleUHmHmedBbHDPnb+GdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbTj3D9+EcuEik0Hc0H5A80EciJ/iLTb9aJppxKCXEo=;
 b=j3j2azf9h25rmyx2puT3BMt9M/haHsHC1gabenCB8XGm4KN+tfeE343d16zIOYubvDwEqRvubpQNM/0390Mv3aMR9uyfmQKSk++4jvvCR7Fi+nwvxp41T6MxKNitZxpHgClh0p/quRYwJ5lzwyHqn8AGuvUZ8LZY5QaH1UcA6qs=
Received: from BYAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:74::19)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:03:12 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::e) by BYAPR05CA0042.outlook.office365.com
 (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 13:03:11 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 08:03:08 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<thomas.lendacky@amd.com>, <manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v4 0/5] Add support for the Bus Lock Threshold
Date: Mon, 24 Mar 2025 13:02:43 +0000
Message-ID: <20250324130248.126036-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2a22b3-5b52-4e1d-7181-08dd6ad43b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?706OGTs8WD59HmchcWl0TjPDMxxH0XjIZvZFiNNhrYCkSHrqqq92VNB6DFgB?=
 =?us-ascii?Q?al36seRZzBqwTQ/OW6XSL5RfvS7PmifMHTSxDZQ4l5noYZW3lAAgMP8450TB?=
 =?us-ascii?Q?dGzba0ug3cZS5tS2aINy0m43fnxtQluXR+G5WjeWL6jAlJZoceHb4f/eIv0B?=
 =?us-ascii?Q?yiLAB55JToT1pY/DK7+jps0TMr159T3cPfnWY1cmIq4eUvblvXOjMGJopONN?=
 =?us-ascii?Q?RFXClkAA3o/U6Yr8uAe0P8nCdvP4usoZWgR/UKIxJQrymqLZqWnEamzN7/qv?=
 =?us-ascii?Q?whsKMIUgQaYdTh1jEkYTBjBWgxahTMMSw0faBgpfwzWAo++izpD/8/bU5XrG?=
 =?us-ascii?Q?ctJW+tx5s1f2v2Nh7K2a1Q5bbjsbmM+nudCY/bR+elIgzdDzL5ROxaTz9uwD?=
 =?us-ascii?Q?yeR6r/Chktqf1rzH8TVAQMuw0GcwOocmFwfOtb/lSF+0cXSbGZRKGXwyH2Q+?=
 =?us-ascii?Q?yVMYRfcmhQEjCORUjT14B6hgUPTCN/pdtu1zzVPdgIzAgIfNO9icVN290MIa?=
 =?us-ascii?Q?iPjY76rdBrJGhyhFucCzkwIS5JoH2bGmZsE/og4NAHB33+lGL32KofBUAJdu?=
 =?us-ascii?Q?SwMmXMvTd+wN06JmKBGjjUrVR5jL9TSuaZedKmCtqXq8fnMidZOvQoNYGdl5?=
 =?us-ascii?Q?DfQ3a8cofX2Asnzn8T61lKyKXCGBTpU/tXWnd3zQLvoPisf7CIwMKBMtVeDk?=
 =?us-ascii?Q?6vFNEoUoAAQ0DV+0fZUWhaEm+Pp4G2eI5nwfg+RAAkAKHhrVxByYAvFic+tL?=
 =?us-ascii?Q?XHqYRPGK0qI5DDZDc9VGSFaiwZHwf3TBcVsM1iaZ1+OqITs+x2mSHrnA+jHD?=
 =?us-ascii?Q?ASVTy1MsJfRZRhBq/cZvRA7O08+wWtu2qkzw999IpfEeOMlPa+ML9G0o5dg1?=
 =?us-ascii?Q?YhAXhOsyQeOUpsoFOPQwkY8IAiu38wluICSQ58ozv25EQn8s7H0li3MrJdUn?=
 =?us-ascii?Q?+Pdiaykz7b1G4wns036petIDNmIC07eo7/P3saofAlBO8hRxPdFan7CMsifd?=
 =?us-ascii?Q?5kiYRLQ1q6UAfFgo9u8Pt2fPEcAaMnraO7uwKtAWUY5qkqItToiuRSlwu13r?=
 =?us-ascii?Q?IXxvmU7msartNbdrV5IYVCGNjxfLrqSftevN6x0mKKIECLdR6TxwTnskeOyQ?=
 =?us-ascii?Q?1+zFeIV6r1rEGJnS64HclC8MmoqiQ4u9lLR5XcbVueN+U8bJFoihqLcHAd7k?=
 =?us-ascii?Q?Ii1xgtFPlt5f7JQifru4CJ39B3vpMtkbR8xNdgGLvjhX+l5684d+QpC+pSwX?=
 =?us-ascii?Q?7Yc8lVi/5GtvlDtv9OX1sk4riM8pXITHfkt0z1Wbhq9DQeVdSFE9ChItABqB?=
 =?us-ascii?Q?hzBkJitFkmy5V9Sol9eYIikeTBmlODGYu51Ni3vVKVAU37HmJSKSdPeW7tjk?=
 =?us-ascii?Q?+6JZq509q92ySG7QFEKLu5rCuTHYxkgEAYEBK8VosuOtRClhJi5k22wcjTr5?=
 =?us-ascii?Q?HyxtMyBemDY+R5+RC0+bYhYZWIS+0s2Zo4zXRB19KB3m8UTMS4Z9fo6im92a?=
 =?us-ascii?Q?sQO/XYs+iYo9oio=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:03:11.7378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a22b3-5b52-4e1d-7181-08dd6ad43b5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

Misbehaving guests can cause bus locks to degrade the performance of
a system. Non-WB (write-back) and misaligned locked RMW (read-modify-write)
instructions are referred to as "bus locks" and require system wide
synchronization among all processors to guarantee the atomicity. The bus
locks can impose notable performance penalties for all processors within
the system.

Support for the Bus Lock Threshold is indicated by CPUID
Fn8000_000A_EDX[29] BusLockThreshold=1, the VMCB provides a Bus Lock
Threshold enable bit and an unsigned 16-bit Bus Lock Threshold count.

VMCB intercept bit
    VMCB Offset     Bits    Function
    14h             5       Intercept bus lock operations

Bus lock threshold count
    VMCB Offset     Bits    Function
    120h            15:0    Bus lock counter

During VMRUN, the bus lock threshold count is fetched and stored in an
internal count register.  Prior to executing a bus lock within the guest,
the processor verifies the count in the bus lock register. If the count is
greater than zero, the processor executes the bus lock, reducing the count.
However, if the count is zero, the bus lock operation is not performed, and
instead, a Bus Lock Threshold #VMEXIT is triggered to transfer control to
the Virtual Machine Monitor (VMM).

A Bus Lock Threshold #VMEXIT is reported to the VMM with VMEXIT code 0xA5h,
VMEXIT_BUSLOCK. EXITINFO1 and EXITINFO2 are set to 0 on a VMEXIT_BUSLOCK.
On a #VMEXIT, the processor writes the current value of the Bus Lock
Threshold Counter to the VMCB.

Note: Currently, virtualizing the Bus Lock Threshold feature for L1 guest is
not supported.

More details about the Bus Lock Threshold feature can be found in AMD APM
[1].

v3 -> v4
- Incorporated Sean's review comments
  - Added a preparatory patch to move linear_rip out of kvm_pio_request, so
    that it can be used by the bus lock threshold patches.
  - Added complete_userspace_buslock() function to reload bus_lock_counter
    to '1' only if the usespace has not changed the RIP.
  - Added changes to continue running bus_lock_counter accross the nested
    transitions. 

v2 -> v3
- Drop parch to add virt tag in /proc/cpuinfo.
- Incorporated Tom's review comments.

v1 -> v2
- Incorporated misc review comments from Sean.
- Removed bus_lock_counter module parameter.
- Set the value of bus_lock_counter to zero by default and reload the value by 1
  in bus lock exit handler.
- Add documentation for the behavioral difference for KVM_EXIT_BUS_LOCK.
- Improved selftest for buslock to work on SVM and VMX.
- Rewrite the commit messages.

Patches are prepared on kvm-next/next (c9ea48bb6ee6).

Testing done:
- Tested the Bus Lock Threshold functionality on normal, SEV, SEV-ES and SEV-SNP guests.
- Tested the Bus Lock Threshold functionality on nested guests.

v1: https://lore.kernel.org/kvm/20240709175145.9986-4-manali.shukla@amd.com/T/
v2: https://lore.kernel.org/kvm/20241001063413.687787-4-manali.shukla@amd.com/T/
v3: https://lore.kernel.org/kvm/20241004053341.5726-1-manali.shukla@amd.com/T/

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.14.5 Bus Lock Threshold.
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Manali Shukla (3):
  KVM: x86: Preparatory patch to move linear_rip out of kvm_pio_request
  x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
  KVM: SVM: Add support for KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs

Nikunj A Dadhania (2):
  KVM: SVM: Enable Bus lock threshold exit
  KVM: selftests: Add bus lock exit test

 Documentation/virt/kvm/api.rst                |  19 +++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   2 +-
 arch/x86/include/asm/svm.h                    |   5 +-
 arch/x86/include/uapi/asm/svm.h               |   2 +
 arch/x86/kvm/svm/nested.c                     |  42 ++++++
 arch/x86/kvm/svm/svm.c                        |  38 +++++
 arch/x86/kvm/svm/svm.h                        |   2 +
 arch/x86/kvm/x86.c                            |   8 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/kvm_buslock_test.c      | 135 ++++++++++++++++++
 11 files changed, 249 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/kvm_buslock_test.c


base-commit: c9ea48bb6ee6b28bbc956c1e8af98044618fed5e
-- 
2.34.1


