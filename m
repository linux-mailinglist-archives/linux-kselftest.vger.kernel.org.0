Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5197C7BC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJMC6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 22:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMC6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 22:58:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113391;
        Thu, 12 Oct 2023 19:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMVkLzaQ+G96RW/ej6J9jWDlS5W20QiozP7OLXsf/OnkVgk89AvGhNcvop9j6vQNbnk8YWdVH0FR3RaE9t1AFBzC7hFYHpulnUQOs6w+mMbOJFYM46Ol5o6ckdgBZAoS6Nuwj/ZcRIRaq3mfVooP8LFrUCRum+n6deIn3OFERDQkwP3dHJDinEK7m6xysOznrKee1+Tgx14BLvsSOBWARvE8EwI9Bdadcc6X4VDnIl3JxYAHCGpU4JR//atwFU7W8wu2c2bUwSesnCa7l8wBqxpdNBYs/F0cs85FuD68ssleU66H+juUhf4LEeSrv5F1xC0VzPUeFtVtZVAUtYpiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiWgNhl01VvplaAyf2iuYByBio3MNffw7BQYB+fLP9o=;
 b=I6hS9jEXKcoqpPrxhv/dT+3RIUkgpFotTRrrmQJaqGVdNaA14q0jNu3sXBDlLU34sdu1SFDbt3aTYBSlYnT9MNX4cCg3kVikvWYdtYakUbC24rliChui96dR8nj6al9R+WpccHT5XNnpo4OblnHMKNI0bzf+kzht1QCBYGKMhIj6FgXgq02lVo52/N+ZHyZt+lGpTI9Cl9vPAUHGYdms0NTAm7+JMQsnxEbsPWY+EvrSYMonOoigc7g0sQg+ehprOygFFtNtQ69/CO4G4Im8eGM3Rou8l06qq7vlOJhwDczJUO/ZJlKlyl9ZlfQpy5Gv5TXe50X9+QksASKxplx67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiWgNhl01VvplaAyf2iuYByBio3MNffw7BQYB+fLP9o=;
 b=MJybBHnk1pwBgSxCypbCmhiT9nKp3UdKvmgAOG6YcVStHWqFDBpaUSmasigHJ/kLvqYun7ncNd+t9VdSS3Pybsl2gLVuZSn0BxvLIX3OKn5ZW4wi/CRNORS792nwzFUMOnQ03tNbhNNsTOVySP48qaqP+e2bfYWBceXV3Z1DKaE=
Received: from MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 02:58:03 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::61) by MW4PR03CA0216.outlook.office365.com
 (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 02:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 02:58:02 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 21:57:56 -0500
From:   Meng Li <li.meng@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Nathan Fontenot" <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "Oleksandr Natalenko" <oleksandr@natalenko.name>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V9 0/7] amd-pstate preferred core
Date:   Fri, 13 Oct 2023 10:57:34 +0800
Message-ID: <20231013025741.3332520-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: cce2dd7d-4fba-4693-1daa-08dbcb98377b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pcl96cheZuqlefl/QDxZES5F0wCqL4ZRnfKDcwIY/Gu4XoRM5r/5SPjEWhT+OL3IkU6FOaHp/B/VwHlk8tXTINuDH5Nqy6MDYRiYcyAl5Fk+yn6NL/sZfGx5oTSzEoP6BjUxzsBIaqM7PVOImS2qX8eLRKVh6lrY5AcCyYcOVORl8Di6sb0Rqnr0x0s48aM+usJj9iLVQPldww7Nr8TPQKWuFXqgQZmnrkB89PoG5p/5U03n7poKvMhJE/EBEIUr3l4V/z7JFR+NOEP/6h+XUEa3KsXPQ0m8XdGxrf8CvP1xCZFkHikydj5J8syEkxWm6PJYiHy3+yLBvbJbCRliP5DWrqAbBds0+K/nyozGenpwCncq4smn6WAyYCFaH54kfGsd1SbOEy6RgVXH9y3+8fXXUAVaAALVKFuhzZ4aDxuXOBK/hjX8uYPiNTfLfkxA85z9j9jcWArbZdH2myxDMG+uO/BPuCqaaEQE93fSM5/MFmQYR+fwtg2p7D2KW8m50YQuRUJ9gpuMgzuXEU3VankGg1Urin4PgD43P4IzgtPVOHJ/wiQOsWQz7sWHnCZ7YXon5mxR1QI607YJEOctit3uDVffhfGMpVlyFq/fMLHF7bRtW7jFSeSNdlBrQJZqIlH3Yc/t30jp2uqJBogSaOusrNs14hxhkJnyGUJFLGhYsqXxqbF7cO2Va0l5+dxMg0M5yhlXD4x6AcPq5AF3K9jeGBcWuOm0OXzTbSYHvj2QL9WAMdWMyqRw9CiqZZbd2YZHbYo2ItRHHK+z8y/raw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40480700001)(16526019)(40460700003)(26005)(336012)(426003)(81166007)(2616005)(82740400003)(356005)(1076003)(478600001)(5660300002)(86362001)(8936002)(8676002)(4326008)(110136005)(7416002)(2906002)(6636002)(70586007)(36756003)(70206006)(54906003)(41300700001)(316002)(6666004)(7696005)(47076005)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 02:58:02.7777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce2dd7d-4fba-4693-1daa-08dbcb98377b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
 Documentation/admin-guide/pm/amd-pstate.rst   |  59 ++++-
 arch/x86/Kconfig                              |   5 +-
 drivers/acpi/cppc_acpi.c                      |  13 ++
 drivers/acpi/processor_driver.c               |   6 +
 drivers/cpufreq/amd-pstate.c                  | 204 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |  10 +
 include/linux/cpufreq.h                       |   5 +
 10 files changed, 305 insertions(+), 20 deletions(-)

-- 
2.34.1

