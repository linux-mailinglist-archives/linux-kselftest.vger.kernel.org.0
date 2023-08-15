Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E415777C794
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 08:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjHOGQr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjHOGQN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 02:16:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6072183;
        Mon, 14 Aug 2023 23:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSiZwu9ehuX9LKpE4/eqeCQ2ADQt5qDmX99scLaoXSEtjteCG9/420GkvMwlHA/Jh5Rt3QhZ7P0l0GgZCKKUYMI3NQLIKCWeOsCM1xadb7mgvDRUJz+JqNlKfD0ia5/T3sBQfFzxPAoLcLdF17Njf4fXdaRwACiN/aVVGCy3hCVGO1q3hREfUdohl46S/D+WrcybUiPeRnAb1DFdLT5lovWDa8PFHymLWzOT+QPTF3TKKWraVZ6VVrYoEN9hYxtSAV06/mIo0oaulMEUX1mX5ItmOW3+gvz8I2BFcGXVEfV8aY6P4DoX7PKnihAg4yI2yM5jfxZy3ydbq1t831e6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr6tYcyJnpQUoOqfK/IAVeqXQkT4tMaEKIh0UCMHWWs=;
 b=JZEQS+0svO5OjDvksIF/M5movHYaQKGEb2I/sWzVXw8vcUGffU0sjnNE+3A/gTbxcBu51BKRcZTb8O+Ol7j1Eb+jJD3R808XXAmoj2yc7TBF8qDAFSV5CntP1de71NMJZ/gneowzyCe37SvAL7+mT247Q2L02bN959QwED6RFGyjf/Vu3QCRr8uOtZyKqjpKe7DjtvdHu/WTjTO5z1ujjFRF5Zknhzt3gHn9OlLVhw76tYeByfF9KtL8KB7DKGDAOFuR/zeqep6MlALGXEy69ZsxN0wJCDpx4iQ0YDw0vMDr/Y54L2c/qmxywEz6P7XIuuOLtT2PxAGVIq0XDayOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr6tYcyJnpQUoOqfK/IAVeqXQkT4tMaEKIh0UCMHWWs=;
 b=M7tqLS/88x67QQQ/SI6V4jveo65nzX9F7UhWlvsvTd+u3zAbKC0w4gPzXamApRRFhsxbeUiIe7R7cqTsddujZtukrPkerV60HOyv1kaQjmvqfR5CTKHuBbQGeovitdyFDkXsyeYbSCzlPk60Pfkq9p9MPVWHbqeJNCJABhSm8ZE=
Received: from SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) by DM8PR12MB5493.namprd12.prod.outlook.com
 (2603:10b6:8:3d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:16:08 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::a1) by SN4PR0501CA0104.outlook.office365.com
 (2603:10b6:803:42::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 06:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 06:16:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 01:16:03 -0500
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
Subject: [PATCH V2 0/7] AMD Pstate Preferred Core
Date:   Tue, 15 Aug 2023 14:15:39 +0800
Message-ID: <20230815061546.3556083-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM8PR12MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: 21572701-3295-47d6-2141-08db9d571d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWRTANEAUazUZKLgK41l2paFWe5fcjvhv81D9IYaKjP3m9WcB5k24RDBEPmQ1Ow9M8kJbcD5sUWtkx2ioSMjm/CBUJXyz+IvlIxvqEAPcIrsXHMSxV450sbuER8YGkfaueS0rBCBplTsg1ZCrvu5YrhPmYmB5ehsj/6BofSopZY9chFzr7DYGMlH1vSD6Yzt4oB8ElTOBb7Chs0o0E9P5jqwR/kAKWwKr+R8ffolJflKWz2VAwVEJK59yj2b2zmADLmPFqkpGAXzMnT7COI8MCyA+Zg8OmfbquAOXHUSybFb/vFeyx0HPkOmRa8wcnRQ7dl/BxXQeeWV49u+q4SI1Btlx/KgZr3z+VgaKMLLa2XJbrh3Bv2Z9YbLKf6yYVUqYCAIcyOAzf+YD0oLLPv8A+VmrRslEIrVwqTtUEqLGm7T+7daMWLo6IaCk56SVfDOsSrPfScyi6W/xuVwJqc6FxWPhLPC+KBeTL/Bk/QDYHk1fMBJIVoqnsCl0JJ+3JLGg+v59S0IvMfWAm7Cr4KIAdzncYKtr0CYvmzKgCSPElFU2KAL5CmlFQbWcWNqrEnbaFk+Ys9dhzAi0fhimFQdRlxIpEYnDOgOcEoD22yrsFy9q7G/OHYnkhaqCtR8DhjC6vE0eknYFaLxxnG4ZQvn91MyZHNPpV88tym0xcTL2QQJdRapSvcFadEi6RLCqGOWyHDofaNVCtjPRPxQLyKno/fRKtVHLwkjltF3zSdOhG4QZTxaDCIzPEHELXdM7Lj7ymxMIqIW68qRhzxI9mVBaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(82310400008)(451199021)(186006)(1800799006)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(356005)(110136005)(54906003)(478600001)(86362001)(7696005)(6666004)(82740400003)(41300700001)(5660300002)(4326008)(70206006)(316002)(70586007)(6636002)(81166007)(2906002)(8936002)(8676002)(16526019)(36756003)(1076003)(336012)(83380400001)(26005)(426003)(2616005)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:16:08.0168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21572701-3295-47d6-2141-08db9d571d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
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

Earlier implementations of AMD Pstate Preferred Core only support a static
core ranking and targeted performance. Now it has the ability to dynamically
change the preferred core based on the workload and platform conditions and
accounting for thermals and aging.

AMD Pstate driver utilizes the functions and data structures provided by
the ITMT architecture to enable the scheduler to favor scheduling on cores
which can be get a higher frequency with lower voltage.
We call it AMD Pstate Preferrred Core.

Here sched_set_itmt_core_prio() is called to set priorities and
sched_set_itmt_support() is called to enable ITMT feature.
AMD Pstate driver uses the highest performance value to indicate
the priority of CPU. The higher value has a higher priority.

AMD Pstate driver will provide an initial core ordering at boot time.
It relies on the CPPC interface to communicate the core ranking to the
operating system and scheduler to make sure that OS is choosing the cores
with highest performance firstly for scheduling the process. When AMD Pstate
driver receives a message with the highest performance change, it will
update the core ranking.

Changes form V1->V2:
- acpi: cppc:
- - Add reference link.
- cpufreq:
- - Moidfy link error.
- cpufreq: amd-pstate: 
- - Init the priorities of all online CPUs
- - Use a single variable to represent the status of Preferred Core.
- Documentation:
- - Default enabled preferred core.
- Documentation: amd-pstate: 
- - Modify inappropriate descriptions.
- - Default enabled preferred core.
- - Use a single variable to represent the status of Preferred Core.

Meng Li (7):
  x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
  acpi: cppc: Add get the highest performance cppc control
  cpufreq: amd-pstate: Enable AMD Pstate Preferred Core Supporting.
  cpufreq: Add a notification message that the highest perf has changed
  cpufreq: amd-pstate: Update AMD Pstate Preferred Core ranking
    dynamically
  Documentation: amd-pstate: introduce AMD Pstate Preferred Core
  Documentation: introduce AMD Pstate Preferrd Core mode kernel command
    line options

 .../admin-guide/kernel-parameters.txt         |   5 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  54 +++++++
 arch/x86/Kconfig                              |   3 +-
 drivers/acpi/cppc_acpi.c                      |  13 ++
 drivers/acpi/processor_driver.c               |   6 +
 drivers/cpufreq/amd-pstate.c                  | 152 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |   1 +
 include/linux/cpufreq.h                       |   4 +
 10 files changed, 239 insertions(+), 17 deletions(-)

-- 
2.34.1

