Return-Path: <linux-kselftest+bounces-2905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DAC82BD0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 10:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305651C250F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CEF56B60;
	Fri, 12 Jan 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DVNtmcSZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD655C0B;
	Fri, 12 Jan 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwzz6SOboxNqy6fUfKv5aAAExU60/4GMLlLep1SCwv97PWJ0s+j4jXSwRqnzc6Dh9N1LEV9MQGDYBbCiFcEY6IbpK3UPyUhGLGIskJpC8HX8ARsvnv69vbWkZyDgIPH+mVZhjEN9ek5AkNQUQYf3PrM/OKjwkKCFzTKtg5CTm/dRdqNPRpfK6Snw8KddaUrv1ifpXRYy5JvgqNvrmYVQjBdNhdMIpucSFWv0VutZDRAzsUlaMHBs87SUEVsDRUpEv9Y7Y3HLjjInUZAGhwPAsN6jRefCpbTidlzWxCrtRuUsWZU4dsnD416jkQ/uBffF38cE3FgPPQ9LWSvT8sJSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzJ2iDOD9iUQ3sKMVSGB6EZg4gzssxH+f0iAAFge4Og=;
 b=O8lhlh5+XvZOAnKO7/kMiR5iFQZdVkJXrVxAStHEuyYO11juy94oDgmfYPyR5bPMDnEysNRQcrH4svOlyK8BsrqpwVMDTRNIsjSVP1tveGOHU7kf3EDERC6woIlLv9fdxiooF7g6y/kQx3s0u5tuGr0AVFG5gkSBrvtHwTXW5xF7JwU+pJkK+cnTGDAjd8mN1zjcDNFf3g/s/RyjFMIBPn1/NEu5M1WhfRXxoBSox7Q1DkV0VkKOS9A4UPten63ceft5Xepw85I20TWgb31gHk6OC31KtM1JM8glhgIJB0WGvxdihNb0lbTUHidxPJi+/5bVQYJYWfbjtYwU2Hiu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzJ2iDOD9iUQ3sKMVSGB6EZg4gzssxH+f0iAAFge4Og=;
 b=DVNtmcSZYzRcPQAjDLj8r8Cx9L8qymfd3L2lZivXE4SrkZLZKoV7wK18mM1R4HRYnTz3hEd7iM3AGncSGROtKdVhXOSxUSgXKp8GI49VaRHta2AipD6zt5BLIUp5YH/VQvkGy4jbsO+SrpTlMKfMHBVwHbM8YVjiLefr3cl/qCU=
Received: from SJ0PR13CA0196.namprd13.prod.outlook.com (2603:10b6:a03:2c3::21)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 09:25:52 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::6e) by SJ0PR13CA0196.outlook.office365.com
 (2603:10b6:a03:2c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14 via Frontend
 Transport; Fri, 12 Jan 2024 09:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 09:25:51 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 03:25:46 -0600
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
Subject: [PATCH V13 0/7] amd-pstate preferred core
Date: Fri, 12 Jan 2024 17:25:24 +0800
Message-ID: <20240112092531.789841-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 1378c446-cb55-453b-8539-08dc13507850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tStb47taxkDBl27lkscIIPUNhMgHaO+9BSA4MpTTVxcPeq8Auu8dMH8wrXUH+h5VjzPLYKCbI51awLgaf9ECUkaIsCOr6619GjcVVwoucjAJ868yjLkRn8K0nw/rlL+B3IUIWNDwi6sEHTRu04gzi4c31+ewQjv4a/X0sgCU4GR8yZMlM8/TXW1mkMUu0Ml+469kIKcy3sycGeRws0OZqswh45LspEoRSs62xv0wl92fpiuMDNXf1foxz5jHTj9jGD1Es4TUfuDis7ZRLIhoSocBWM7tMobEAx4xabzgJtgbstnEWLUncBWxUAfwAcT6//RIoFN9aVPkFfX7Z+iWkSwBAESFw0qLlg5To8t1l0gLB6lkk4M6Bv65l7bk8J3xXC9edP8lWYoml+en44whW/Z1G3FPFcoC6vup6FKMbpcXwL8zCBxZi+sX++XnkfO0m1DxtsVNmK6gLx8fnxsijr7Js3dUiER+B6QnU/+bgw5kw2MTlxVeM1EwP95RHsYCV5EVPZaA4ETkrAkq6j9Kwnd1ZzdIVi/ZOraorKKaTLBFxzoSrDmijtEGfG/VYQ6TP+QtzPS5AgSFZpEc1MDPuvwBrTl76pPBOKMvocD/1i8fv8dQmiKErE4Yx3c20hf2YnomNTAJM7YL5CrUpuCN27ddw33nkWydM3+gV/WRUqkUNPxiyQ4T7hwILr4B8FwzOUlW16ZfjmgV+AY4LIaSMEmrmGbj7gnGdkONYp/P9VpjcTbKS3AzfUvcw+ia/Cpz0fVVet5mwN+UHOLFtiyaIg8Uw9fvQKRlwnZnDU/9DKcAwknIR08dzCtbgZDTerkS
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(230173577357003)(230273577357003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(7416002)(2906002)(36860700001)(47076005)(2616005)(70586007)(70206006)(1076003)(40460700003)(41300700001)(86362001)(26005)(40480700001)(36756003)(356005)(81166007)(82740400003)(336012)(83380400001)(16526019)(54906003)(5660300002)(316002)(426003)(110136005)(6636002)(7696005)(6666004)(4326008)(478600001)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:25:51.5528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1378c446-cb55-453b-8539-08dc13507850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962

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

*** BLURB HERE ***

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
 8 files changed, 274 insertions(+), 12 deletions(-)

-- 
2.34.1


