Return-Path: <linux-kselftest+bounces-19004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B0C98FD0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 07:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F481C2145A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 05:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC028120C;
	Fri,  4 Oct 2024 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qQpQ6WgK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3949641;
	Fri,  4 Oct 2024 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728020045; cv=fail; b=T8nNccS0FsJ1AQFrQ29IX3MQwyOHk/UnZ1PYtfaJRlGmK3SmY0J9gpt948ITW166xm1OZ4pu3Wgr2GCXXStRr9b9AWxzXVhAih2/DZ0ctDmFyytAn4cp/qiTbhaa3ryauTvAsohpzDnPxCytV/KpDmGygP1WW/cZlKp/4qjp5FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728020045; c=relaxed/simple;
	bh=72mrjgpJcFHR92ObdIiA6CTgjPW70E/5Yijg7Bg/q8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=StZH2JQjZZBC4tAP9kZkbTZ/4zHjgurZbyQ/SBSa/k2gAv2OUXYTGw1+g3I7ZDujRAhYbntboz5Kylsvmzg3DhDZWOTvGAz5PKz7+BjJ0/W0XTgKvLp7270FHgn/jKscxDTm4uLvn6WAMZi99GeolvQqPDHnHnkLPAy6oTZMEjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qQpQ6WgK; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrhW+4G91Owxt2XIBwB7tYtjFJOZusm7P7w/hDS280xk3RFBTM0m2Au5hMyQJobY78Me+oAWG+SNBENBxxIueuygoJ1iiPQmtA3/WcQGiRX94iVBAqDxrQQLkOO0lw1FQThfgGSBe4Kj46nIR0OmDFYeov2T/rLvlZqJKVCU8fm7lmQ2Ly7mSMmQb4pBRL1pHrPV8pPYrMgQQPy0BbaB2MjYFhJ/Uh41Ek/NbiMRKlXblMwG0dWAL5Trn4zmHQpERSc4B+S262yp/ug5BKDbbik0ifLIQluaNtr5oGu3ddHQduh+/uIfp6rF+p6E6dKQPiw6qmRDrNSbIRm2HYnpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sNu0spT7uBUfTQ5jo5L4yWe/rZLJGgjO4qcF7nJbMQ=;
 b=XgSZotIxk1wpTIAX2t8l5UCvBlJ1YWgB9q0RN3C1d7iPAptjGQIRetH8I9pD/X5gZnbqLiWgSXoMfzAuODEx9Q+cRoCY/oVJHQtaUV94Xx/7KDp2GxGZfOOSGHgG7n9sEFd3LEFcFanZHnxSAU3/2IKH1j5GoXe1+vw3g8UhWUP1NMbJWrb4k3uE392MCgxtUppU/AjCXZKjMpWiO0ai7eQCiaQW1tZbM/ZgX43kLEu+XRCw3OdHj/lZeKkCnpIRYmMDe1oh0BLi4eHxRDS+Zh5n8crG9gwDmvkVfGJXcARzLgP9/1QfmHtzHlYXW019ltLPAuw/uibLzUmNxrYbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sNu0spT7uBUfTQ5jo5L4yWe/rZLJGgjO4qcF7nJbMQ=;
 b=qQpQ6WgK3zL8a35zstSmCWDkYBEZR4GUSXMzBXpfVJ6oHH9IeYAsi0sX8Q1sjyb2zRxs2PkDnTuFnP098ldcbL7miec2QBrPWZB+ka6OsFZoNcaWDs3HXQmkgU4CScVzZvK+VMrTsrVdMK8h4yrfyrDMNKhDQLrfMhbBNQVivQw=
Received: from MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::22)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 05:34:00 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::ab) by MN0P222CA0017.outlook.office365.com
 (2603:10b6:208:531::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 05:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 05:33:59 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 00:33:58 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v3 0/4]  Add support for the Bus Lock Threshold
Date: Fri, 4 Oct 2024 05:33:37 +0000
Message-ID: <20241004053341.5726-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7f0202-7e63-45f5-2865-08dce4362626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sk3vzlMR0FxXDIYy9JEPZvpPBTXC9upiBtPeWredE3eSwaznlrkIdNSF2DDe?=
 =?us-ascii?Q?a5FB7CUPwRY3asO0nhSvN7la6vSpSm4Gu2QNMVHaZhGQ+tAs/9D7wZ1b9z3Z?=
 =?us-ascii?Q?xfkyUnHmvCGKkNyEQIeuPILXBfP90bff62G30/BNkqcziH8sEU0jR7s4t/dR?=
 =?us-ascii?Q?vseew5t3ITq6W24VvO/KiDf92dXI+AcxHLv84QHxpRLh6WNAoHHAHaCZJXys?=
 =?us-ascii?Q?9oMa/GddwMQgb0mkzRrZ19gkvldd9z3Jwgelz0yFyFfpz9WT/Sns7jydznyx?=
 =?us-ascii?Q?PRK5IDf/yeqkDAae09M1oSt0TZwXy+IEEUyYaG8PldV3agT5LDnWBEr39WAc?=
 =?us-ascii?Q?VDCMywnBEg/Edi7cxef0Ty8Ttmy2Mvttq1QPfS1bndy7I9h7LjYhwnlSxRal?=
 =?us-ascii?Q?C6WIODT56zAOFk7mP5pV4MabQQSiDqyiLdFlnOA4pFMtGXPoc3hkt7rWHb0O?=
 =?us-ascii?Q?fnWHaE7E/ucMMK/wAftQOJgo9WuTDML6zy7sZFP+Yc09FGNY0Eq1TtagExel?=
 =?us-ascii?Q?H/POrXjFd4WT62B1NTfkutx+p9GqnZS18xYOz24e0pf3bosyff4JsHuUiWCu?=
 =?us-ascii?Q?OP80IzPxYjONc00r7jox/X8W+x3NeTixjxVZdbyRmNTm6zCAsX3/te+9640A?=
 =?us-ascii?Q?oLtvhahzrZBhXaZ/5kH/l9j+/lXfTwNQ8l/VPy+UfWogqmvdAM/5anEjf5iE?=
 =?us-ascii?Q?d9OS6WYcrrh8Q9JvxwMMNHpRacB08jhvwS0P8TXNAlgrf8mNS/Ezu9cw0igz?=
 =?us-ascii?Q?du6aoFuTUFjUxl5EJRFUOmEzueZnOBf0FVXQkmN2ShDsajEHRIKn+Xs7BmML?=
 =?us-ascii?Q?4niX1w61rTMagxMcUuE+rRUiAz5pNcbRg1cCbdmXBk+nrVe6P2KWc76EhWAY?=
 =?us-ascii?Q?Oo/YOeE+9cCxXTOOL3U7DWrb11DwCbt+qMqPsKKHs6zO7ITcYAyuscW5b1sn?=
 =?us-ascii?Q?Adc+SBDfYqkuJun+A49W12F0VP/dTYS0L6TvKmS/xJOImUIM+OuwMaAzpTtt?=
 =?us-ascii?Q?0xGX0qosf3bfubD5S86twq9XN+md/Jve2a6Pi/Fufn61tOQyaGg5YJbXy98v?=
 =?us-ascii?Q?HxYihA2C6U4WrFRact7BElCKhMlja6ZgHL9cuE8VUMSB3yg2EhKr7KU3lawt?=
 =?us-ascii?Q?tEgCcftUQUY0yszv4EbSG1aI5YCC/Ntr9q2B5Q5KLfMkSYBoQecSOtF3XFRz?=
 =?us-ascii?Q?H7gvN6bXdmWV+E0xD4usS6pay60RMcrsSo3hqQLH+NYtLHsy9K2Au7C578iu?=
 =?us-ascii?Q?xQVkKss7FSoFikBIOo8ADEY1H8oEaAwTvvOcy3qhOH9XYSkhYVQZDIJJYTAW?=
 =?us-ascii?Q?kLGJEVTLQXjKvlWbKhtxGnumUYeSaFL1eHOorbU/usVJUqd3v0t/oXedSfUX?=
 =?us-ascii?Q?Tk/ZFnn5+HssiAvqH9vwVp09WPWe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 05:33:59.8233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7f0202-7e63-45f5-2865-08dce4362626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587

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
      
Patches are prepared on kvm-next/next (efbc6bd090f4).

Testing done:
- Added a selftest for the Bus Lock Threshold functionality.
- The bus lock threshold selftest has been tested on both Intel and AMD platforms.
- Tested the Bus Lock Threshold functionality on SEV, SEV-ES, SEV-SNP guests.
- Tested the Bus Lock Threshold functionality on nested guests.

v1: https://lore.kernel.org/kvm/20240709175145.9986-4-manali.shukla@amd.com/T/
v2: https://lore.kernel.org/kvm/20241001063413.687787-4-manali.shukla@amd.com/T/

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.14.5 Bus Lock Threshold.
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Manali Shukla (2):
  x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
  KVM: X86: Add documentation about behavioral difference for
    KVM_EXIT_BUS_LOCK

Nikunj A Dadhania (2):
  KVM: SVM: Enable Bus lock threshold exit
  KVM: selftests: Add bus lock exit test

 Documentation/virt/kvm/api.rst                |   4 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/svm.h                    |   5 +-
 arch/x86/include/uapi/asm/svm.h               |   2 +
 arch/x86/kvm/svm/nested.c                     |  10 ++
 arch/x86/kvm/svm/svm.c                        |  27 ++++
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/kvm_buslock_test.c   | 130 ++++++++++++++++++
 8 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_buslock_test.c


base-commit: efbc6bd090f48ccf64f7a8dd5daea775821d57ec
-- 
2.34.1


