Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03897A444D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbjIRIQU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbjIRIPq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 04:15:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367610F1;
        Mon, 18 Sep 2023 01:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVAnxL0RRZAadAtvY84y3ii/OL4Km2l/WY+3gNMVGKSGF53tTgL4Aso98c2Pf1HItKTmLZJRgi7C8EJ+j1yZKakENR9/S/dmgWLA4Bv68zCGgUoAOFZA+tGhubpjR4ZUQlvApydIgDR4DYYvTXHJ5H8ReffZ7WjfCI7sSFm4x/9uLwMdtLrCuPEa3IGMQncyYy7wBoiGlF5Ob9yypmvxJ4W/n99e+WBuu/hi6VMLdBTS01EVyRlpS/p4TDJ+J6sBFUBSLquG1MY/n/CIKQWZtM3Vvkvvz+7WYBDADioL2NhQ42zO++S0wLGw22MPFYJ5DlZQL1lVLXt4ez1Zltb7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svr9vMr85sPOS7iq5wIO8wycccVehap+YpEZF5UKLvQ=;
 b=DARN8WVK1VZfQt9v9xlQ0jlmkWjz0UiJxhg4+2cfZtEwYfNIgqDie2gCxcDzhZ0KUOw4g5TqbyOVJW4vf5IEbIb349z/cE61aQLjiKP9JrsGKHQimA91QK7/DfIe1CC6ZA3eVtrfjSpUm3o9z5IOTiXu+1FUfDNiFsK9SQR+svohvhBzrtYR7b20HvtRMT3/YTt18QEIMlc02yWy0xgou/TsNK3EHlgettjhb/ZA8mXkVL4NX1k9TsMxcC2w8qBbvzHrjO0xs+FoS6zPBmmB6LVU5YjQptZcImC+LdiWdisX1zhet2w3kGfwRgKldyYY7BiIa96uTbnYFxs8CVfbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svr9vMr85sPOS7iq5wIO8wycccVehap+YpEZF5UKLvQ=;
 b=kIx/SeY0WEbj273PfqWa6Y4iNljXXetTpmepW54BOfljmkvo/u3nsG/RugNskp0K7vJXZujoIC9iWCYjJIhmko4lyKFqHeLEbFZKbrRFCD77L2YCPv03kOQ6huPxutvRcVFhS/BOiTU8QtbM6FrdK6glyIn8mN/vW73pVRgJGgI=
Received: from DS0PR17CA0016.namprd17.prod.outlook.com (2603:10b6:8:191::7) by
 PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Mon, 18 Sep 2023 08:14:32 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::f4) by DS0PR17CA0016.outlook.office365.com
 (2603:10b6:8:191::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 08:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 08:14:31 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 03:14:26 -0500
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
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Subject: [PATCH V7 0/7] amd-pstate preferred core
Date:   Mon, 18 Sep 2023 16:14:00 +0800
Message-ID: <20230918081407.756858-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH0PR12MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbf6ee3-3578-4826-4bed-08dbb81f495c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4440z9IRKIMRoradHND1Xwu37k0GWj9GtE/20Bq540AR8PVqJdY2zDUH56Tam4v8G87DjCx9fW78ssXYjx/aJiSqlKG/qPlHfdJK57e93Iv8+hBvt1kmApwu1IrS2UvSweMHhB22CHfUYUQXtMWm7UmH9oXuStZlgwerxD9+kz528r1MWV3PnT5Sw1kZkBv4XEqS3LIJG5uKWjGGIDblnkvJ3tezHqmhYRZ/aH7S2SemKsbEAFh/V998VNQAmQ9w0Q3TonynNSc6lxdVahKF6yx8U7eQpSf9kBpu1aVEj+E/ppEHo3m2/EwqiZjOlXoRv5p38py45mEbAGP5wBK00sngCO0VbKwMUQ5Q17D0so7OvSvzFxGQhBYQclrYrIz8Qd190Mwr361IVallRMiO6KpBPJdf7blhqj9VzUrPjp3DO24FSSChyKeEExsvhqtt553rp1ANbh5v9RhWwsoq7vN3SLb3VJV8jm4j9B581R4DgFR9HRvALgRRFQ2M3a1qI6aATL5cgva3b54vRJCoEJdm3XDRIkMNE9AGukeDWMjOymeawS6dqEg7lciPn+GSu3EAULwDPRXnCeH1ZfAMqox1Y5qpwXcDr+6cG8mADA67MKCqhoFslvU6bs+SeyDNB4R4+yUTQCk+7dG1DstKqNSlB8NgEuSXo5v7n4eyaLPgWxI0wEtvaLFeuhrgkzL02Q2r+0VhNeqQ+BK6A+QfAOlgUbhrQbFe2UeY7Uoco14/VGp0mVP3PPvNe5kjyJ6oByhhb6szvoOvooBRoK+TaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(16526019)(1076003)(2616005)(81166007)(426003)(356005)(26005)(336012)(40460700003)(82740400003)(47076005)(36860700001)(40480700001)(83380400001)(54906003)(70586007)(70206006)(110136005)(2906002)(86362001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(316002)(6636002)(6666004)(7696005)(36756003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:14:31.6714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbf6ee3-3578-4826-4bed-08dbb81f495c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
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
 Documentation/admin-guide/pm/amd-pstate.rst   |  58 +++++-
 arch/x86/Kconfig                              |   5 +-
 drivers/acpi/cppc_acpi.c                      |  13 ++
 drivers/acpi/processor_driver.c               |   6 +
 drivers/cpufreq/amd-pstate.c                  | 197 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |   6 +
 include/linux/cpufreq.h                       |   5 +
 10 files changed, 291 insertions(+), 22 deletions(-)

-- 
2.34.1

