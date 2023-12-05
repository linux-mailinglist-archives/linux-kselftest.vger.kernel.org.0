Return-Path: <linux-kselftest+bounces-1109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81533804A46
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35771C20E3E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 06:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794BDF60;
	Tue,  5 Dec 2023 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zbCNn17x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7352D187;
	Mon,  4 Dec 2023 22:37:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jz+fXr+Oynql+8Cts9a7IPTTyl9xtXYuombYAFaMR40swgrauevSMo/BR/G7PGdtIGPsnryGz4klvX5qSJCFbLc91xeAlYHInYN2hgh/IUV4TQVOMONvU5LT3PdBdkyWwSEc7+Fkl2Nue80F4xg7j8S/ErprxNl3GLucOOYtguFb0BkWC+jZCUZAmwtr3dCl/9yFAwF1GL7BTrwPi4ZGrTDMNRmm9z9zeSFXSNQvtH0HV3Ep6DaPaW9HXl2mdO7ZD/zp7c/2F/J2TCyQCoPsiUp5OdWd2VIftd4mPnU+8WGdMd/RSi1AzyS8KhELc9H3Vfm76OpCwyaC9+uP8QRmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ux801oDc2/jPQfcd2LJKW7IHrraAjnhHTID3QGb/M8=;
 b=QoTdTOcYvaUe7eBeuTddThCtw+L58kprzQ1XmR5B3Au6MOInLSyNICGfKT0+78MtpUNPvIaECEMHt6+pt+ZZ8ciGOoQ8YzWIWMwM5jnjwyXpkjMNNPlvctsagmHSpmh+yFbcZZUP0JdLhueLNARWT0offkZEmj10vecHUs+b3FWnqO8eU2/vfc06bB1AO2FeRCpNVlQkd++eTkZdN5dMxZN+9vQmLwrZ+tmxDOHEUfvqw7sIFHa6f8I915YPnUzx/vHaUpUeLPaPE8cXztFnr9GQlLaxfzGL/EuUMpPNgWZGT/523b+h/rPdQ6KyGOKAGuLDnwHT4jSOpjMTY8zDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ux801oDc2/jPQfcd2LJKW7IHrraAjnhHTID3QGb/M8=;
 b=zbCNn17xDK8pVb3EG2tcARy6b8qWD4XAMce+F9Pj8vtflyD69k9ZAVpjzoilaWOkiYpsPdH3jjs9bUSjskEaJhcj11I+JsOWOTGbLdgT3I7lmTi08D+VfrkOmKmS8d1FFHVoAtrAiHeLc9fslC4mLl+ia2QUw9HKUAff1J1Bmy4=
Received: from DM6PR04CA0007.namprd04.prod.outlook.com (2603:10b6:5:334::12)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:37:35 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::bc) by DM6PR04CA0007.outlook.office365.com
 (2603:10b6:5:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 06:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:37:35 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 00:36:47 -0600
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
Subject: [PATCH V12 0/7] amd-pstate preferred core
Date: Tue, 5 Dec 2023 14:35:30 +0800
Message-ID: <20231205063537.872834-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b47cb49-f6d5-4241-ffff-08dbf55caad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UjpSo33khloO4fd3mV4iqtLKINk+Ew6foyV9KnE+XaLOx3fsslDe3kClIzh6TQsVCQmh0BpMAEprI75VjMs/eXnP2L2ToFBblYdbd5FHxaNUjgHl/BEjrFmlkMHDuxPidfMJSkNZvfokCUPOqUAhvTNV7l7BztQtzvRfkexUGLeGTJras1GFKBz2b8NFlAX1EyjBo56ktfh4Da3dzLjV5yFnYHqiAhlPXvitNIuTQNpXNIZbirmSDMD2hCyASll4ETI8X22mkJOg/gdiahm04j+VUGTEdJunDS4JAxNKU7kvzIAvxx03BMIIGKqBmYIdB0iJCwharCJi5SYwxHwBF85zke5vbljeXFyWrdIr+nfqNqTw0yrTcUNyd8tT3M1CZf98qWB4pBcpECLtFh5fiR88EbZF2NbYNHyKb/1mhGb3XtN54PnP0m1iewkEZQDmKkqoUvzuAHaIAFLKCAaOxGUeUsF1HUpVzrc7+04cP8KsmacbpER4CM12qceGbHQb098tLREtNS1dsSDII43Y6X0AcBVzzgtDjzw3IiO+UvxDJFbpnssNK+1zWD834PfKJDcW2Ha3ncJGO2jQi6zrSPjhl768aq+Qc+oDDfW1zQYpy8jd4rLxbJJ5Kg1QJAJaFHU1P8Duyf0Kdpq9N7cvTulxCyU91TJXT69OJR3HxQql7CX/UAuskZIsK2K8ME6Wbp6KQUZ4zcvOEnzt9gai/9JLWzvk+Faz4u5Mu2PR5RLQekeQaa6Q3merY2CQKYfy2qfBw+LDU7PKULW3+rzfIQbqi5+6ltstZBNV5n0ZkAiVa/r6CkCr4xg6OJTM87WV
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(7416002)(40480700001)(36860700001)(2906002)(110136005)(316002)(6636002)(54906003)(86362001)(70206006)(70586007)(36756003)(41300700001)(8676002)(8936002)(4326008)(356005)(47076005)(5660300002)(82740400003)(81166007)(83380400001)(478600001)(40460700003)(426003)(16526019)(336012)(26005)(1076003)(7696005)(6666004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:37:35.3951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b47cb49-f6d5-4241-ffff-08dbf55caad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

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
 drivers/cpufreq/amd-pstate.c                  | 175 +++++++++++++++++-
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |  10 +
 include/linux/cpufreq.h                       |   5 +
 10 files changed, 284 insertions(+), 12 deletions(-)

-- 
2.34.1


