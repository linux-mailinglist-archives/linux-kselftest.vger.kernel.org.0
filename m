Return-Path: <linux-kselftest+bounces-3227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2F832628
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C107285B5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73222200DE;
	Fri, 19 Jan 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FINBWkf5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329D208C6;
	Fri, 19 Jan 2024 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655131; cv=fail; b=EcqjfdAGCUBp26fFB+vw1lOYme6cfh9Uc5dyI7RU+/Rabo5djT/0gzqrD0cOfn7IYxXGMRK/CVAV/36MtLj/ydCEBuWyYpCzG1+WwKevOajF3XQPq5MOxzGvVs+63Ey8PRjc0loCaK+4N9/jYK9nXyUPGjBUVeQ32Q84vGnHmAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655131; c=relaxed/simple;
	bh=k9tZXa0FGa0Tf2Zw7gXamq8S/6G7r3RJ70KsfNVMOQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TusdZZglnAZFuX+s1zhnJ4ixSJg1XgduCKZSQ1Zj5JgPTBDewZ3SsoXqL2IUj071ORb8xUVGBbbTZLsNuLr0HOFJGOOVe0Jfb1bHLtAwhugm5HyzXEp0l9CMEa719GZ6J9oEoAgmmEnYJNXeLA3S+gXJWgmw8SekhhqhfXNMZmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FINBWkf5; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eocUA8Dcuux7nmV40OhLVPbrMrYXk7WKKtHM2t5nXqWMkMiEpfH/KQ8AsuxOB8Q1ldnPdBwd5RV0Gs28poQPjJIgrtseEAhXFE15Yi/GYmI0SQ+bpKCsuOgybFjq5ir6J3yS3sml3FBSXTyEAVq9m1fSPQQRuG1Mb+pE6P/411/X+fKiN1AUzv7qxbRZ2qHJXTlN3o0BJEkEzHUx+bIgRBIuTIfxX0VzAz2z7jryP26XMw+m6UuUUuFiVr3zoq1qnNvIhi3kfGUh11uq5Z+LGC91I9yr0YLceGl4ENGGrZrvQtnYYDfoUMyi7Kmf1K5MIx8joGDEUjp7LN1qHfZCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwatftxozgpTz8H9hxy3w7AoWbP2md/pGLMPpfFenL4=;
 b=IStzMd7+2Z3qB7dAllVo4ri1iGQkw3GGKdcb4a0/F3JA7LVoNQW/zuRduA5LdWavart3cWirGviLa/H6FuIcdP/MnEnX7i0JpkgwdhKo67AsEU7QF9nJ4wNd/xzaHdLibiLPsP4dosAlVUGJxeuTSMSUZMgBuonns5vTt0eaY32dBKGwhQ3XQITHt6n+oXsS0dm90qDesBTO3DbOcW+oVRtQq03Fs+j3E0cLH/ltMRRwboMGTRmJkNv2Qg0RbWsM31PHn+un908fJ1XI8w6uqux8UmttHp8uQprNkQW7bbToyef38w7gy9BN+A8LQ3BmLRD5+Q8/P2NqERp3+nbsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwatftxozgpTz8H9hxy3w7AoWbP2md/pGLMPpfFenL4=;
 b=FINBWkf5WNIp0XnioCwuvr6d1vxuaGIN8QA0xRXL7maPvkDMsMwWxkI9QDOpGRcfv239VKGo0MN/vfKd5e/R0oJw9xy77Vwe675/EjEOpiJgWGDJnfHMwqXhlit9OycSozJFwNljAiBRke3uoEDW6lac5Ttu0rSnUkoR1x9d84Y=
Received: from MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 09:05:26 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::a1) by MW3PR06CA0023.outlook.office365.com
 (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 09:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Fri, 19 Jan 2024 09:05:26 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 03:05:20 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov
	<bpetkov@amd.com>, Huang Rui <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>, "Nathan
 Fontenot" <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, "Perry
 Yuan" <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>
Subject: [PATCH V14 0/7] amd-pstate preferred core
Date: Fri, 19 Jan 2024 17:04:55 +0800
Message-ID: <20240119090502.3869695-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dceb1d-0260-4c5c-bd60-08dc18cdc6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lveV0AWRzpzoRQ+g5hJeBxRxBBPfNjafs/VZ5sL0+/iQxnK8b7uIGPVbpDc/jXJ8nujJFxM19npH3DJKQ+i2Uznl8Z5RbHZpCzbom2ANWHLmm+u0jkfSKL/H3pHxz43PIQhliVHAQSZIbRNAYpDcp/m7YBlLMVfUHkzsGImM8NDzYiiTDinOHhKYGLBtcWK1XJKj5hFMQV2B4aQdUnVTYc/VYzrrPbBVWgULZ8++xqRMQK8pGg+q/NSdjXgMvHkxxg9n07oDJnGykFcfyD6o82vvTUzbhIlzbiXHlkW30NaY7NXUQnjbgj9qXIxoRx5dRM9F4VBqMuzBfI+hRKjzogh1rMTLBbtNoI3BKSEkG3h609TK0740dCrd4j1gZonui4pwGTusfLzjy7A/zUu6xlrCODZ+90ysRw3WxKhPwO7050X87pmFAINMKTZOpJwt2wLorOvVWzkoADzW0CsSfNX3Bx+VvrfLV6VrrrSOBwioVb6djxN9RvgBjhXJ8nOgpSYZWJd+1OTfJEDkMmtvfcrDGQv7gRtSlun1UP5n9zArKCXVBZs6vV5zXwU61akQ2xUGswoyvc0VhvV0LacVGvYEhgk9U0lNzmx9ILffpWuD362i3h2smZ1PXutcvpwfiZp/drNW5Umkghb48HXi5uDNoU5/FsKJUOWLtk7ta6SK+vJ112a7UDIF5Gp86EbMN9j8WE3gZ4Q8GpGZIgW/ndNQuzjmMgHWjcgpzjcF9B96psYrdArP8EMLhHZigKONitEXjqwCj+W+3h18VHx2/X3CqDyv8Ai5S2xxm3YTT0LHlplFICNlosOrWromNp2t
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(8676002)(5660300002)(7416002)(4326008)(47076005)(8936002)(36756003)(40480700001)(36860700001)(426003)(26005)(16526019)(336012)(1076003)(70206006)(110136005)(70586007)(40460700003)(2906002)(7696005)(6636002)(54906003)(316002)(478600001)(6666004)(86362001)(83380400001)(2616005)(356005)(41300700001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:05:26.3586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dceb1d-0260-4c5c-bd60-08dc18cdc6f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379

Hi all:

The core frequency is subjected to the process variation in semiconductors.
Not all cores are able to reach the maximum frequency respecting the
infrastructure limits. Consequently, AMD has redefined the concept of
maximum frequency of a part. This means that a fraction of cores can reach
maximum frequency. To find the best process scheduling policy for a given
scenario, OS needs to know the core ordering informed by the platform through
highest performance capability register of the CPPC interface.

Earlier implementations of amd-pstate preferred core only support a static
core ranking and targeted performance. Now it has the ability to dynamically
change the preferred core based on the workload and platform conditions and
accounting for thermals and aging.

Amd-pstate driver utilizes the functions and data structures provided by
the ITMT architecture to enable the scheduler to favor scheduling on cores
which can be get a higher frequency with lower voltage.
We call it amd-pstate preferred core.

Here sched_set_itmt_core_prio() is called to set priorities and
sched_set_itmt_support() is called to enable ITMT feature.
Amd-pstate driver uses the highest performance value to indicate
the priority of CPU. The higher value has a higher priority.

Amd-pstate driver will provide an initial core ordering at boot time.
It relies on the CPPC interface to communicate the core ranking to the
operating system and scheduler to make sure that OS is choosing the cores
with highest performance firstly for scheduling the process. When amd-pstate
driver receives a message with the highest performance change, it will
update the core ranking.

Changes from V13->V14:
- cpufreq:
- - fix build error without CONFIG_CPU_FREQ

- ACPI: CPPC:
Changes from V12->V13:
- ACPI: CPPC:
- - modify commit message.
- - modify handle function of the notify(0x85).
- cpufreq: amd-pstate:
- - implement update_limits() callback function.
- x86:
- - pick up Acked-By flag added by Petkov.

Changes from V11->V12:
- all:
- - pick up Reviewed-By flag added by Perry.
- cpufreq: amd-pstate:
- - rebase the latest linux-next and fixed conflicts.
- - fixed the issue about cpudata without init in amd_pstate_update_highest_perf().

Changes from V10->V11:
- cpufreq: amd-pstate:
- - according Perry's commnts, I replace the string with str_enabled_disable().

Changes from V9->V10:
- cpufreq: amd-pstate:
- - add judgement for highest_perf. When it is less than 255, the
  preferred core feature is enabled. And it will set the priority.
- - deleset "static u32 max_highest_perf" etc, because amd p-state
  perferred coe does not require specail process for hotpulg.

Changes form V8->V9:
- all:
- - pick up Tested-By flag added by Oleksandr.
- cpufreq: amd-pstate:
- - pick up Review-By flag added by Wyes.
- - ignore modification of bug.
- - add a attribute of prefcore_ranking.
- - modify data type conversion from u32 to int.
- Documentation: amd-pstate:
- - pick up Review-By flag added by Wyes.

Changes form V7->V8:
- all:
- - pick up Review-By flag added by Mario and Ray.
- cpufreq: amd-pstate:
- - use hw_prefcore embeds into cpudata structure.
- - delete preferred core init from cpu online/off.

Changes form V6->V7:
- x86:
- - Modify kconfig about X86_AMD_PSTATE.
- cpufreq: amd-pstate:
- - modify incorrect comments about scheduler_work().
- - convert highest_perf data type.
- - modify preferred core init when cpu init and online.
- ACPI: CPPC:
- - modify link of CPPC highest performance.
- cpufreq:
- - modify link of CPPC highest performance changed.

Changes form V5->V6:
- cpufreq: amd-pstate:
- - modify the wrong tag order.
- - modify warning about hw_prefcore sysfs attribute.
- - delete duplicate comments.
- - modify the variable name cppc_highest_perf to prefcore_ranking.
- - modify judgment conditions for setting highest_perf.
- - modify sysfs attribute for CPPC highest perf to pr_debug message.
- Documentation: amd-pstate:
- - modify warning: title underline too short.

Changes form V4->V5:
- cpufreq: amd-pstate:
- - modify sysfs attribute for CPPC highest perf.
- - modify warning about comments
- - rebase linux-next
- cpufreq: 
- - Moidfy warning about function declarations.
- Documentation: amd-pstate:
- - align with ``amd-pstat``

Changes form V3->V4:
- Documentation: amd-pstate:
- - Modify inappropriate descriptions.

Changes form V2->V3:
- x86:
- - Modify kconfig and description.
- cpufreq: amd-pstate: 
- - Add Co-developed-by tag in commit message.
- cpufreq:
- - Modify commit message.
- Documentation: amd-pstate:
- - Modify inappropriate descriptions.

Changes form V1->V2:
- ACPI: CPPC:
- - Add reference link.
- cpufreq:
- - Moidfy link error.
- cpufreq: amd-pstate: 
- - Init the priorities of all online CPUs
- - Use a single variable to represent the status of preferred core.
- Documentation:
- - Default enabled preferred core.
- Documentation: amd-pstate: 
- - Modify inappropriate descriptions.
- - Default enabled preferred core.
- - Use a single variable to represent the status of preferred core.

Meng Li (7):
  x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
  ACPI: CPPC: Add get the highest performance cppc control
  cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
  cpufreq: Add a notification message that the highest perf has changed
  cpufreq: amd-pstate: Update amd-pstate preferred core ranking
    dynamically
  Documentation: amd-pstate: introduce amd-pstate preferred core
  Documentation: introduce amd-pstate preferrd core mode kernel command
    line options

 .../admin-guide/kernel-parameters.txt         |   5 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  59 +++++-
 arch/x86/Kconfig                              |   5 +-
 drivers/acpi/cppc_acpi.c                      |  13 ++
 drivers/acpi/processor_driver.c               |   6 +
 drivers/cpufreq/amd-pstate.c                  | 183 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |  10 +
 include/linux/cpufreq.h                       |   1 +
 9 files changed, 275 insertions(+), 12 deletions(-)

-- 
2.34.1


