Return-Path: <linux-kselftest+bounces-798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9587FCF65
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 07:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7F51C20980
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 06:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C336FBD;
	Wed, 29 Nov 2023 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S6TF5Sco"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D3170B;
	Tue, 28 Nov 2023 22:55:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIQbIqTYWSVSec0VsnT6QhJPTZqCSIWR8kpGO/172YGV9NlX0IQrbgDDMRQSMYJL5FJARHqHbsb072uEyJ3OGEt1dMM4AD2alu2O0Oys5dhvyoU/88HiA3JsxjceO6u4Lf41FS2YpYl/KS/V9E8pHUZ6J6Lp57hMoj6/kD4V6MHT8bYZ3COh8hvQ7DZ7A6tCwBOgluUSte29ZMs7Y83J0Gw6MC/YV8H5S/xaHTuQsysMKqQK93gnWgJ5ZQvtnqIB8qxgbdBb8FioTqiDqTY2NCg+Uie2HELaCrIzt/KBIYIULwzw9Z58VOgWS7kjscnxm5ZJ4BXrDQUDiJVcJy0GWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWl/tvKCUGPPwMLXwkXZfnSLt4Ct+NNkFb6YW2X/jGM=;
 b=ds7ko7xn/MbhDtz4UuF1zIrzh8w4tSTB7UC4dLS67q+84o+ayrtQV6v6vkVI9qfwch9UmsgaMbiheyJKuHSwENIytkdyV2Ho7MLPRjDxrxzVSAtkiF26tCCFdFaCTHsFqBOHTNS79sWOVBlG5hf5jGmt0DORcn7X2fwk06EGe7Up7tCkrPaNdRYrY7LZWGWmOulk1Ara/wLpIdVivCQ2LsYXVurXmo5griEBOPJ4+lNi1acJdkMufoDSHRHtLhrelHvPZj2To+Jq6arCYHvoo5SHCGEVsUMlYl/S4CYXgd0MCWJjJilpH6OZk6ZVjQWAZHXfWEjZ+YPyzpqhoKASZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWl/tvKCUGPPwMLXwkXZfnSLt4Ct+NNkFb6YW2X/jGM=;
 b=S6TF5ScoIRiQzm8ZQx0JaHkaYa5e+xhwX7WB6EGY1f+SWBlqqH/SDIYuyV9sYS3V81UXOUOBeVhbGXXLVvTSR67or54o/oeCA12yFoaZivU7a5wPN80YLPkMpID1l6KOOp29b66sgOrOVVQQtWTE+8ZQq1ykFPVNmUS+gfLuhWg=
Received: from PR3P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::29)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 06:55:03 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::2) by PR3P192CA0024.outlook.office365.com
 (2603:10a6:102:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 06:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 06:55:01 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 00:54:55 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui
	<ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>, "Nathan
 Fontenot" <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, "Perry
 Yuan" <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>
Subject: [PATCH V11 0/7] amd-pstate preferred core
Date: Wed, 29 Nov 2023 14:54:30 +0800
Message-ID: <20231129065437.290183-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 77946fd5-45f9-4d34-e90b-08dbf0a81c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	juMCpmu6LcviVCIXhcFwH2DoRtRAFxtQ1nsKvhxJd4GJbuboc0qklW+PgXOIEKR5jz8URiES1ZPU3an27UO3suRl/2sVuKwjpPZS90pWW+lHzsFtw/tctdsFTo0ek6Xdc/WRPFMRZJcrsdIc1q7ye0MXF7NxBI0br6dFz8eyw7QJv640qmL1QWD8Eh8Luoxe76HYhxw0gO46tKJHcTnzi23N7P2ehlP0JdOkdfMkN5qYu+/FhL+65eS0tUve2z6mF8DCEAg6umJTO5mkTiUGDg0JiNUvhnfSNyXz7GcwbFBv/Qc/TVOl4ccDJaueCRGt5u6AVw+KDV+jxsf4B/kWwv953nkrxhuO7G4iBYcjrrHoxdl549AywC6Vgnzu0SZkHO2Sh6UqmQhygi7b+i+aM7vrOv09Oq9od7eqQ9g9x/w+b1563qZm1w6JZJ+cENZzdgOy+d5tdJUpSQzZ3pijNKvoSAs4On9LHDfy6R4rcw64RHQNoNOQVDbLinKn3KxmjTgc4L68j96gnEIP269ubpVvRDlsEoods3B/vNryXTxgqk0lLPo9GsB8JSUoDoFfhj1IdsSHL13enNDN/oacptTxYGRItZebMWvASyWuyvrnXOaVT/sE+83l/QoFtYaw6fMe9GIwI+lpmPsVXrMUB2zpQ/Es+9+2vy5MOBItGYPQ65eMoihYwpaHPorppIvokOmgUMqMTUR4EA2i0z74Ziq8lIm1MS1ctec8glTY/D7JkhWbpE9auD8Cc3281Vkre5VnsQAQ0U+FM9Xn9j2nrukNMFpwA+ypLWACVwYhZDzAbPMLA0/lbBhED/V4Wvab
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(5660300002)(7416002)(2906002)(8936002)(4326008)(8676002)(70586007)(54906003)(110136005)(40480700001)(16526019)(26005)(478600001)(6666004)(2616005)(1076003)(316002)(7696005)(83380400001)(41300700001)(70206006)(426003)(336012)(6636002)(40460700003)(47076005)(36860700001)(86362001)(81166007)(356005)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 06:55:01.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77946fd5-45f9-4d34-e90b-08dbf0a81c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

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
- acpi: cppc:
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
- acpi: cppc:
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
  acpi: cppc: Add get the highest performance cppc control
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
 drivers/cpufreq/amd-pstate.c                  | 187 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |  10 +
 include/linux/cpufreq.h                       |   5 +
 10 files changed, 288 insertions(+), 20 deletions(-)

-- 
2.34.1


