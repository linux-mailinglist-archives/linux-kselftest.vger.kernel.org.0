Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535577BD20D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 04:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbjJICuA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 22:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJICt7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 22:49:59 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83173A4;
        Sun,  8 Oct 2023 19:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3GpHuGNqGcOAmSCkKi2BxQ+/82no7gMXl4e3eKsqfpGY/dj46n75j7HaP9BCJOJ1p9iTKx3bg20OTlwiZOlfN5L8U7MDfo4txpFWhYez0a9dOxp4p9BX+bwJvWe59o+Z8EdVAKxtAWKbS5JU9BNXUCsHneKHzg3MviZL5yOGcrcz+ekFZDL3tCwSUm0UxJc43MpC4OCJGHjh/HyEsltjCYS9tCXv89VBcgW102O2tYtGhb6AoaH37s14j/8C/XDuiJ3g8j3RkeVjvf1qKHJFRqve9V4mjmw4wNYYb747YUfynHB0X/EHmQygckhL5lTHDBzsAEynWDZMumTlW5jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5Hayc1H1AKOfEqLFqaTG1oIViw83FqMWU0AywWnwG0=;
 b=L6Bnh+N1vVzTTk1uJrvoSi5uLO2w1jj9D2+Ba9bo9jspi6SYn0C/JGXu30PtH/Fc9S5Pwy4eUY2Xa1ZpC+WKTBTJ9Q+rSXf7bVXHidpqogmeDifamNsPlV9GXqEvKgTSQIgpL6ax/US40238a8OKxex2ZX5TQ6WYTtizmF28GRrdDVSr8zi0nxklLzTFV9vxDWWZITNSpbUjlTZTe4Xy6G+0JYAW2lwvAXWwGDI1IR2QMerjK2SB5f4Hs9DMoIJEUV+X8+YzK36YLlEOYhsl4AdcurrQRF8fU8MwqrWyWD1oqBCIMS5/0KdFSpNUiC4u6hBY77wYsPp0I3iKbp10ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5Hayc1H1AKOfEqLFqaTG1oIViw83FqMWU0AywWnwG0=;
 b=IM4JVZL7REZtSWw2wqiwX00XQUW0+ZqqKVdN5sjGdNaZlaZwE4//u6ZMmTftFV0ZiNSeKkdvyN6EehGmbPCUW56WCKEyZ1Qac4KdLEipuwOTUae0QT6XrekxCsuURowRdIjT02Uw12n7qiV9Dtlun579nKij9oX52ruVx0WeVkc=
Received: from SA9PR13CA0082.namprd13.prod.outlook.com (2603:10b6:806:23::27)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 02:49:53 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::a5) by SA9PR13CA0082.outlook.office365.com
 (2603:10b6:806:23::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 02:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 02:49:53 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 21:49:48 -0500
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
Subject: [PATCH V8 0/7] amd-pstate preferred core
Date:   Mon, 9 Oct 2023 10:49:25 +0800
Message-ID: <20231009024932.2563622-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: 16388e59-00c2-48c5-7e07-08dbc8726a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSFxi2BwewJlUS44reFMyEEu5+sm59hGGyAWw1Q2XCbtYzoL2lv94N7IrGgvvoBRDsJQYVt7wv6QDplc84fnIOGSXW0ukpsrLg2RVMiDl3oo4Tz1jDklm6zSvg9vNZMPDXAbu3tFeSTG5rI77ajTXFb77gvp6EPlQZOniiFxJJDqiZnVz85pkgf64rWq5qteAlKGawXIx0pcZn1WdjXbYqJoJXeG9ZJ12+8vt1QHl3q6Xlt/L4xm5n2sz+pled+wbju/G54hKRoAKvU39O7sW1io5kyPju7LMoaw2lGcKVDYL6Yc0Wl53KYrI/2OFUBhomaPIE5kh9+Ki9m+rs75yqoNljR1Bwb6JZ7/p4c21HK+g8WLXXMt+1mgsSLyzDIKYKABChoG3Wkd8lHwLK/GjDt/aSGUwoLa4iFzUIglmxTn4ssixH0ue19x6aR3Y8bvIVUQ8rdXdTlTvHLu/+DSArVOugG6usW1rC6KFoHEwiR9decSf45tAILX6F9SlGUEzoZIDCZhMqk0MrNyTdONpJIbAF3fi5tq+j6pfa4OQpvCTd4ssED/cbQGtGqq+qdb5zfrIkHWegY20L+fPEXeEwwxqQne9zscXey3F4DZYq7vUZrUmOzFtDl1HUs9QtfYcaPShbG6DKv5ZRXydbwe8syUT5F2DF9da1Kuef1AuEhJWg5rRnaita6al2ykvkMKFV0NAz2q+5dTKAxGXFM+xbNICYh1Gf1BqkNEIiuGgpt9mtjIxbGjXtnlZV9sJrlkXTtUEflwJ2H1T15XB5NB5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(1076003)(2616005)(336012)(426003)(26005)(47076005)(16526019)(36860700001)(316002)(54906003)(70206006)(70586007)(110136005)(6636002)(8936002)(5660300002)(8676002)(4326008)(41300700001)(7696005)(6666004)(2906002)(82740400003)(478600001)(36756003)(356005)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:49:53.4314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16388e59-00c2-48c5-7e07-08dbc8726a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/cpufreq/amd-pstate.c                  | 186 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |  10 +
 include/linux/cpufreq.h                       |   5 +
 10 files changed, 285 insertions(+), 22 deletions(-)

-- 
2.34.1

