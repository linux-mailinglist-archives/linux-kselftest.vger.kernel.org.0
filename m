Return-Path: <linux-kselftest+bounces-13396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAC592C2D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F5D1F22E0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641617B047;
	Tue,  9 Jul 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DDobn9dw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50C1B86FD;
	Tue,  9 Jul 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547536; cv=fail; b=BYKRsr6P4itICYC9TB9MBMrsEkgiOeU4D1z+6W9StZruOvLHcGdkqdzEvSPdAPFVuTA9tk28WVmjDNxCRLGqu63JgzHJPYcROlTi6zVyb4Yzh3RJyG5DIHcu/xrl/id5kMpynEIB3EKYfNXVIFnhqXctbTDwjUpoD121zDxXlAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547536; c=relaxed/simple;
	bh=aSJnP0zt4vtuRNAl2x0h9Fnje3oE3QS1YV8ibS/s5cc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EDm+0T/uG10Ipvsvule6ER3/j9/Z0ucCKIVADX34ZkbjSzawqiz6ELE3w5lSWywWau4VLHjCd9j5FOBIqrYEHv7QSN+u/GjlRbqLBPkazNmuWvrHI1LIoEAlMHjf68NsCOTT6hkAh+GCsj7xkC5TCEoVGxnvuoJQCoTcyoC0y1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DDobn9dw; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfXe3dyGxbjF0L717Nw6TU8rfnUxdmfDBy6kVIrgrGNITrwSFadPUmDQmdAaIWMQ3QaE7bKZ0L0ppfN0gKCJQQHpdOBluMgt04UDk9Locjw8iVhyqwMJ5iWW/i6pRZuQ6zbfTTu2UwaIN2j7kWoYpEO4hVaIqrTyFsdXyZn4oZCdV1229YHxhV3T2Cb4YomYDL3qPoaesOJ0Jo6lH50ZsFB1Md/E37F5pmOh/3JMNm204Fb+N3mLpTlWO7lPqQ7GuzDR5NvZ546P9AJSNlS4Z26LdEoIJc1XJpnv2bA7ohyQ7VQUeilNgz4XImC/oWNtbuV+qSMo5+rrHx/xlUCDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb5b4vq0toJFVAJUNC/1FKxmmoeAiy8h15f2wUHcgQM=;
 b=aWWqGjFOFGGieiecOvIwkveRck+NAdDsppL6DOcZIuTMuq4F27ibmcH0zUoyrY+MnmFZWI7lY05aVmJYXo6kWoA/1lBztRVBPvBrAZRiujJDQ+yXCUu1Psi0ng6dbP8HvjWIJQorj+mvsXnk9nTzlVz5DLs/gts2LvGzbOxG9RJvhvRNOO0Gvkf8xNkff8Tp8DR2B2nrqbGk9Zo33Juf0G4X/nIrARZw0U4Cfh5FMOj2Bjn6XtNT+fSjSzffYJLPtvC5TKaHUbhSksUiNkBww0s/JKOBcWUYhxmC0WfbEA4AslpMEMi73b8n29puk9J//dmdjRDvk1lYZGwZI5vWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb5b4vq0toJFVAJUNC/1FKxmmoeAiy8h15f2wUHcgQM=;
 b=DDobn9dwCntFUTdLRE6Pgmlo6JBY5EI5OjFr7vaq386nDzQjP3Zt54tWCXIgSelqmcTvM3U5z5lS6oZBfRQCKWG4bSfjtBhlSAWb32O3ASyj5VBjn4Dcwq4C5iivk0sbHvkqQZ5jzauoTFNCfIid1aXqT7lO0tZCyLrT12+M9XE=
Received: from DM6PR10CA0005.namprd10.prod.outlook.com (2603:10b6:5:60::18) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 17:52:10 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::79) by DM6PR10CA0005.outlook.office365.com
 (2603:10b6:5:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 17:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 17:52:09 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 12:52:07 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [RFC PATCH v1 0/4] Add support for the Bus Lock Threshold
Date: Tue, 9 Jul 2024 17:51:41 +0000
Message-ID: <20240709175145.9986-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e956c3-e865-49fa-525f-08dca03fdb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fATWjdWLh6ui7HF/SyYR6drQk7EwoT6Hx7gfA/Y6CJHOYx3vf3XSpEcbUsDA?=
 =?us-ascii?Q?N7YOBlyYQahPms7AqE4MpnvvIY7DrtIp8GYm5mki2WW6qsEOQBU3AjoIQSvd?=
 =?us-ascii?Q?1hIbMctXO5AwtAeFG1hlGIICaTSKfaAKkYqWPHpVZBxzXbUq1hxIl+zeuMHf?=
 =?us-ascii?Q?2d6XckSbplogJDGZpWShU96TOWpNfUcXaA8wAlZRVmtttZx1qq/0sxh9FQ4t?=
 =?us-ascii?Q?wh/tXAVmoyN5Jr8x7vz04VejfjcMILNULa0/icyCxwEERg2ou3poZ3KnjHeO?=
 =?us-ascii?Q?NxcuYpgi/AMZLYliDMHJvlfLDZ/4UftSG0qE4uHe7NgB9aL5oM7xdSUkDx/v?=
 =?us-ascii?Q?8hG8HjC7xu3ho6G/C8B3JOTEj5GhGGN9o5rYvn8pzUdVqvKu+otNjSdSGX7D?=
 =?us-ascii?Q?75SKc+iNGoiAGH4yTs3CZ2Kh3qeBsx3dXqBq4ThOh3BAq95YI/lrQNGLpQ17?=
 =?us-ascii?Q?n2vwQ1GtScRdE69X4+xdAw/l9qvXqjXVMKM4FS1vAl0jak9DoQcchi909seC?=
 =?us-ascii?Q?gX49yQii3xlD0zZBnn6n+aKLjiPCgbl8X707YDUVv1+98Edu8Z1pMqL0A0rf?=
 =?us-ascii?Q?bZWQDb8EHg3WP8h4JexMA/Kd/+QSK0IR5h5/9YXs4gDBL+B1F/XRi3OaUbl2?=
 =?us-ascii?Q?pp7o4BON3ufgLxoKlud0icLoyyLm5uuUOag2VkXhyuWZrZvSjZrt/46JdfO6?=
 =?us-ascii?Q?pQsYN+nQnUrjdMXBERXsbQX62msDttHgNutuBn1LHRJ4YJN4erT7VukpJ398?=
 =?us-ascii?Q?lXGuKvkS0debQ14LunTccMUIMJYPNuicNGeyEl9yL9qub2tZxtuIi9UxkiHK?=
 =?us-ascii?Q?evs/o5DlxQOUvmXHCTRABj5besUDIHUDEV9rQIyYveVwz1m2RMBF5gA1D9sh?=
 =?us-ascii?Q?xncuCvUknu7LVnS4tLOefrTmJsPR0m2u3yVToSS6ccrMYoU7eob7YdkD5Viu?=
 =?us-ascii?Q?xKs60gauLtqwbHaQ0KEjeSe0DgVnjU3dK0JphGhuuPhXRBQXkm8r9iDNWWaK?=
 =?us-ascii?Q?U/xqrq1y4eRGp9MCCHOzppeCe+eOq+dbHTM5WD5czehED1Ofvvilrgudg3KJ?=
 =?us-ascii?Q?nXBgudXolCl4PqLNIur8P0SxWx3fITpFm5HvgvkLjYkGgDH3AQV1M37fYQyl?=
 =?us-ascii?Q?l9M6z+bxH/7NoXKdrxwSm6jTfvm3E+/u0Pdg7iXsveElXsMByae+r6S2taPJ?=
 =?us-ascii?Q?04QTStjlbCESzHzUEV8EWwJS/srfzujqSXkV3RZEC6AFKa8oLv+n44Ek/isi?=
 =?us-ascii?Q?HWCI2IdI4ghYnS0koTVGKei1nd1h/s39IhDiyItERFX6RAYvkqyvJok1j5vk?=
 =?us-ascii?Q?lwIzkbenmivFnaw+AziVzBZU2TyNYgk+1ijJ3ceXDEG9CdQWBhzP7KUP3ffp?=
 =?us-ascii?Q?12rNFVewwKaTWsKg+ZVl4zSf7VFfe4/aIB6577GuUXoIdjXVyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:52:09.9032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e956c3-e865-49fa-525f-08dca03fdb50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

Malicious guests can cause bus locks to degrade the performance of a
system. Non-WB (write-back) and misaligned locked RMW
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

Patches are prepared on kvm-x86/svm (704ec48fc2fb)

Testing done:
- Added a selftest for the Bus Lock Threadshold functionality.
- Tested the Bus Lock Threshold functionality on SEV and SEV-ES guests.
- Tested the Bus Lock Threshold functionality on nested guests.

Qemu changes can be found on:
Repo: https://github.com/AMDESE/qemu.git
Branch: buslock_threshold

Qemu commandline to use the bus lock threshold functionality:
qemu-system-x86_64 -enable-kvm -cpu EPYC-Turin,+svm -M q35,bus-lock-ratelimit=10 \ ..

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.14.5 Bus Lock Threshold.
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Manali Shukla (2):
  x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
  KVM: x86: nSVM: Implement support for nested Bus Lock Threshold

Nikunj A Dadhania (2):
  KVM: SVM: Enable Bus lock threshold exit
  KVM: selftests: Add bus lock exit test

 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/svm.h                    |   5 +-
 arch/x86/include/uapi/asm/svm.h               |   2 +
 arch/x86/kvm/governed_features.h              |   1 +
 arch/x86/kvm/svm/nested.c                     |  25 ++++
 arch/x86/kvm/svm/svm.c                        |  48 ++++++++
 arch/x86/kvm/svm/svm.h                        |   1 +
 arch/x86/kvm/x86.h                            |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/svm_buslock_test.c   | 114 ++++++++++++++++++
 10 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_buslock_test.c


base-commit: 704ec48fc2fbd4e41ec982662ad5bf1eee33eeb2
-- 
2.34.1


