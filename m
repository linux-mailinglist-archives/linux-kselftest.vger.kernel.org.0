Return-Path: <linux-kselftest+bounces-18721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A570298B485
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333B51F2453B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AC1BD000;
	Tue,  1 Oct 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LmvpH7W0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6D29CFE;
	Tue,  1 Oct 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764480; cv=fail; b=ZNempwwIvdUe6m4ZdSZi9HIckwbioH1KLMln7CH6yeOMAMP7w5nreUFYTLNmjBckdqrT6m7w32MpeEUTLyM+hxvpGW0WKkYoROCUgnR4tdXezTzKX6ombFMkH1Rvosv5KEmLUhvOHDKR0lIW2183thmM3j/U4uMan4Q8W9fjSTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764480; c=relaxed/simple;
	bh=sqkh6ghssAMk0w1CrrIFA1A22luv/gG28d6jjtIETIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ceknoqPHg2NZNHZrtACK9tPLS4JD67/tagiKOCjfNUI6zFIQYWykOBgXR3T9gLihKf2wHccOu7o3fp18DsG7VYgA6n2AakTjWwK+QpaS0iNrArfQJFcmbigp5Y3OdQJJjww3Mk8SAC7VY47hL5WMr/7OUZ9yqtUDQkwZfhh0kwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LmvpH7W0; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaOhyNsuR1+t51N71GUurFBZivtfRxMRW8mac3PGuBVRx3lgWknOzuvOCGI8tHYcAob/b79/pKoWwa1BoBn5O2g5/0fbbB/qMFs3kiqagir3/iUSgzYY8xUftfNGT3lLRLCWdZV7X1y7/83CXiikhioVhmJyarQFfZJ1dkGJX6t8EHwXF6Vf2zZ/eAsHl7mmFdgJFGoQECqjUygQsmCkkqeg9ubT1Thg/BU5IvNN02IMcGpXywuyncAVZna2p+sYS2eMBtTPrL1bT6LnBLf2lcQnikfa54/4WY9AUzCpNUcZY+jaJX59y9qb6eL8LBc3Yd8WptBruT04QXgV3NmAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP9oIs+WP/clDRlBBUmq+4oex78u3KG2bQ8DQ/lAAg4=;
 b=bdrOBLr2oXD9rM07BS4FEpv3ktcKxpzI9VKOvi81q3hIj4NSr/PRGuI/5IhNbac6jNOlAw/m2Kl6+IwrW5W+erY8m1jxnQyYm6gWA7dByYKNlVmKLg4KMOnMPKvyQsMPorJ63zEZAX6qOKxKTpRavod93fb9LqK3i14TIkMh4uDiT4EzXQp8alaxN+Rc5Fm85nLp69jbSqWl1wqdu2ZkfaTzKdXo0s2FucDxSHgN1rDuticW0T5LaAcu6ToKc1yL3HqH7eGZRXbWa4Y5otKqE2nkMUxmT2egDXa6WhnfWcilwlVJJhVlji4tWVDJutNswGiY5CwJuKaF4rVeQC1rFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP9oIs+WP/clDRlBBUmq+4oex78u3KG2bQ8DQ/lAAg4=;
 b=LmvpH7W0naOXoANlLf27rTEAhchSvkGDQXnd5zsNX6ICQihhGAV4m3JuyA/eyj0o+1zVKoGuuO7UmNVQND2jpZyqbpiHpxTpFZ5HMCtlypse1Y7f9QanBHDKe3lvqR+zlPZgj7DqY1kOL+bs+qzHkWeCl/fiiMjAI7KeF7aTUKg=
Received: from SN6PR04CA0104.namprd04.prod.outlook.com (2603:10b6:805:f2::45)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 06:34:31 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::b4) by SN6PR04CA0104.outlook.office365.com
 (2603:10b6:805:f2::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 06:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 06:34:30 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 01:34:29 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v2 0/5] Add support for the Bus Lock Threshold
Date: Tue, 1 Oct 2024 06:34:08 +0000
Message-ID: <20241001063413.687787-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f61e1cf-a120-4777-8e25-08dce1e31b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HUpKuojp52iQ13YztsyAlbTdzlECe12ORz9h2XrnzysmBWsug8s1g2e/gpaQ?=
 =?us-ascii?Q?D0kvavex37CkAKDGvE5ZDT8knRdLpWYfzKKjH5H5H17z/brfd9H8D7OtX/iJ?=
 =?us-ascii?Q?D07DdvHb2M49lMcxvTeSEpLmrg9Mxl7Vok2JqShWoprHctn9qFOmZIU6bHr5?=
 =?us-ascii?Q?C/65VEKzmWgWhq5bkZNLYPbyNoGmaJjS7U4TG4NzaxegRLeKhRshnAFOZHQY?=
 =?us-ascii?Q?Pl3lkb45cfFRLWZ3baMn2zZBU4rbLinb7LoSDtk04GGxhJT+2uyE6uUK48PT?=
 =?us-ascii?Q?V8Xl8gxBsQjOKUM0YOyMh0W0Lzb9qe45fLBJ+ZCygpcQP1kapZT1cb4D9fLa?=
 =?us-ascii?Q?edde1lmQCwW0jgdmHXH9/uoG38nJu9cqjFL1BKJtCrhLCBPTBLw964yNJOAa?=
 =?us-ascii?Q?/0D2rzSfFnlUJ1SB5Mq7xAZyK14dA9ZnTAqVSPqz5MJqJDsGFzlVbGRHfvKL?=
 =?us-ascii?Q?6RTwKuYWKyrxDsIypVmN1AgkdWQGIQ5IMoyYW+V0LRXvSlUT/l14IR7nn0pO?=
 =?us-ascii?Q?OICdkpj0EHDF9etDp20ar61sM7eDjVIqz+6N01Kb0zQEZRXrV5hchpYvSvOn?=
 =?us-ascii?Q?Ax38ezuXqNSzBDt8FOsSgYwGjOga10MU8zUEWczFgMFDE6sqsfteWZ8M79AW?=
 =?us-ascii?Q?k1b/gCtAXpN1vHB6Av8JhmGT0uq4dncn7dis9h64WlpjinuBu8f9I9jomh8v?=
 =?us-ascii?Q?ROF8buWdlEgg1D7kFjVFeDL0htXvmkaCJr2STZgVkVvqJdHNO2ArcnPtWvci?=
 =?us-ascii?Q?/UrKrOLmhqd37UxFWpcXbLivcsLv6Fk73KDiVe04Cs6/f4DShEptI1c0nwMX?=
 =?us-ascii?Q?CaA15NVE9SlclFg06yP5edQHNskiQ3AxtOn6BLggp+A8z8OHezaL4EROoTks?=
 =?us-ascii?Q?jS2log/NIJYQnMyS3SF5wYDNdFhV2N9L8e+duom7BNVQNplrR0IeGdISns8c?=
 =?us-ascii?Q?VkJMhqy61sv2g9yUj1V4QJtKDF+/zHAoLsg4R/y4RGcfBxR6wJb4pSE+xAV4?=
 =?us-ascii?Q?xfTJZf7WvIb3sc8DMuS+s2iIgyDDRUYIyHtZynMSdQBZPOoHCVkGRARwB1Tu?=
 =?us-ascii?Q?V9OEU6XlVnfInujmi5snMRkKHoicWFdpamWXTKm/PQRwRYZ/JJxmvdfiS7WA?=
 =?us-ascii?Q?QBf2dAYORCaLj3MJbcAVa4KAR4cPQFy6aS9WwG8kNN/ku/AmEnw+1Gmm+2+z?=
 =?us-ascii?Q?l5+MV6NZEi3voVvo1FPZkQ7cIMhvR24kjMmt+F+7zKUXq7RBGQj8vtf4PKRB?=
 =?us-ascii?Q?g8SUhCD4tQSbf1yrEQ8XhL08mszTIafMTVaccJq/it8Dajp7fvVPyGmSQIRi?=
 =?us-ascii?Q?xLQivYCD8KqbxlYtRC0Ix2uy+jC2WzDDEyaN+Mkkki09q23qIPhCKN/3VjPv?=
 =?us-ascii?Q?/E/Qt68nlkeax3A6WRhEGTXdSg4D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 06:34:30.9044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f61e1cf-a120-4777-8e25-08dce1e31b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066

Misbehaving guests can cause bus locks to degrade the performance of
a system. Non-WB (write-back) and misaligned locked RMW
(read-modify-write) instructions are referred to as "bus locks" and
require system wide synchronization among all processors to guarantee
the atomicity. The bus locks can impose notable performance penalties
for all processors within the system.

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
internal count register.  Prior to executing a bus lock within the
guest, the processor verifies the count in the bus lock register. If
the count is greater than zero, the processor executes the bus lock,
reducing the count. However, if the count is zero, the bus lock
operation is not performed, and instead, a Bus Lock Threshold #VMEXIT
is triggered to transfer control to the Virtual Machine Monitor (VMM).

A Bus Lock Threshold #VMEXIT is reported to the VMM with VMEXIT code
0xA5h, VMEXIT_BUSLOCK. EXITINFO1 and EXITINFO2 are set to 0 on
a VMEXIT_BUSLOCK.  On a #VMEXIT, the processor writes the current
value of the Bus Lock Threshold Counter to the VMCB.

More details about the Bus Lock Threshold feature can be found in AMD
APM [1].

v1 -> v2
- Incorporated misc review comments from Sean.
- Removed bus_lock_counter module parameter.
- Set the value of bus_lock_counter to zero by default and reload the value by 1
  in bus lock exit handler.
- Add documentation for the behavioral difference for KVM_EXIT_BUS_LOCK.
- Improved selftest for buslock to work on SVM and VMX.
- Rewrite the commit messages.

Patches are prepared on kvm-next/next (0cdcc99eeaed)

Testing done:
- Added a selftest for the Bus Lock Threshold functionality.
- The bus lock threshold selftest has been tested on both Intel and AMD platforms.
- Tested the Bus Lock Threshold functionality on SEV and SEV-ES guests.
- Tested the Bus Lock Threshold functionality on nested guests.

v1: https://lore.kernel.org/kvm/20240709175145.9986-4-manali.shukla@amd.com/T/
[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.14.5 Bus Lock Threshold.
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Manali Shukla (3):
  x86/cpu: Add virt tag in /proc/cpuinfo
  x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
  KVM: X86: Add documentation about behavioral difference for
    KVM_EXIT_BUS_LOCK

Nikunj A Dadhania (2):
  KVM: SVM: Enable Bus lock threshold exit
  KVM: selftests: Add bus lock exit test

 Documentation/virt/kvm/api.rst                |   5 +
 arch/x86/include/asm/cpufeature.h             |   1 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/svm.h                    |   5 +-
 arch/x86/include/uapi/asm/svm.h               |   2 +
 arch/x86/kernel/cpu/mkcapflags.sh             |   3 +
 arch/x86/kernel/cpu/proc.c                    |   5 +
 arch/x86/kvm/svm/nested.c                     |  12 ++
 arch/x86/kvm/svm/svm.c                        |  29 ++++
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/kvm_buslock_test.c   | 130 ++++++++++++++++++
 11 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_buslock_test.c


base-commit: 0cdcc99eeaedf2422c80d75760293fdbb476cec1
-- 
2.34.1


