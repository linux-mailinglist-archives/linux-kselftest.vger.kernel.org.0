Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978678BEAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjH2Gop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjH2GoO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:44:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF119A;
        Mon, 28 Aug 2023 23:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dho6Bzu4yGydBI+L6vILGgcu8QYHA+BjO7bpSgh1xTxOcYH/XRaIR2qgfdwIH5emNB5jWah505q7i8/qzN78P2Rx7Vk8n/fM4l0v3vLLRT1w3uhANivZo0H9+pJ4aT4maXfoRWUEc6yKKhdc4ufrZJnoLF1TRubz8/4oQgo3zjGhi+48/ZUeD4GUrswSbyBuEtyensZlXvdpts+ERB3S03DBcFJbU5/Yr9wvFMj1X/H3mdATReqABQn4dSXX7xXlN8rBcLa+xGVCY2MPFenplGwcGbEqJBFS9eV8EViAC/x1+7av/igB8WMqm6GsIRXIMK9o3nhFo4OjAxebWqCjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PV4Cju0aBBt8xCMXGFT2hoWCnpNCuBMMMRKZHihLt0=;
 b=lk4fUploaHvtuYujbftBx+uV4iFkmGbSnXV4WiP3feD5W66Sj9yy1DjAGJE0P11ETqzUZSLM4QvthHIc1GWkD193lq2KBbAXjZfnFf42k8tKZCpXFEX+cOwM3CUwieDuKtyyPcBlj77SsblR+2AWuwIM64H/HetlNkkOCjZk8segk6w/M/P6ExN4xID867rQ0Yekeut22MxUzKJlxqpnJKeACS50cK7SVIn0TUD3lpkdlZ05gIyv2tVrSnR+A59n6fk5C9wkIs1jip7gyFXdTJCDR5bl6qQh5oSwKlZ6ybD1shmoLu1sdVNhjSasWA/ljhNCo5B35YpisRiHnG6zxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PV4Cju0aBBt8xCMXGFT2hoWCnpNCuBMMMRKZHihLt0=;
 b=XGegHHn+EpWywri+I0rf1jvGRi+pPWmy0JXv9i3AqTOKS7sYYpmi7bRT2P0bvBy8bdcwvw0J0uPuItLl/zMj9GtKjtVYfhwHp/ywtmu3/qUv1Fo2g5sxTGzpIsSZe6d+H63Ll6GdFqm4uwnX5gecaM+nWg8cNioxzLuyCBPIyG0=
Received: from SJ0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:a03:3a1::35)
 by MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 06:44:09 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c3) by SJ0PR03CA0390.outlook.office365.com
 (2603:10b6:a03:3a1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:44:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:44:01 -0500
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
Subject: [PATCH V4 0/7] AMD Pstate Preferred Core
Date:   Tue, 29 Aug 2023 14:43:33 +0800
Message-ID: <20230829064340.1136448-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MN2PR12MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 6673a5e3-9c68-4909-d70a-08dba85b58c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1aYhjBC5bcW8fcz6Q2elt88rWNUKSBpxFAC/hviAGbqdB2CODlsNTrQ85+8qmhQybhOPKjEC+73TuaKu0/3sBiLBFOemN4ozG3KJIBMK15UE3hNYei7vWWKSQIAMcT9SDGUalwsaT7n0i+2hG5Dt7vZWkqwRZXqdtCKLvsMbnzCQoF7MK7MTEWo1rjxzLW6RDdHGL+mAPbPb23fyaa6bk1yF46RTH1d6pTUNZj8jo4loKlNZ+l5I6sjiXC1St7M3AHwqEYlp68p3fdvzSqPF5A+6matwCPm0pzr4O45Hw+6MQHSkZSzNZn3UXg8PuQDnqnaYVGncxf+f8Lre2IxiFFqauuvSRVLl7hbeUllhSfoTZP8OP3VLAv9Tum2jcXpfU6NIbZMiA5upwCzn8a3iL/6VXn6uZbxcjoFczLGAxu5bnXrBHdY9qJI8/UWk1lbD4jyVGjyWNYRCdlzR2paLAqvrsLUtYsQc3wIZk4/Hq5oGIjqRdbov7Y5iByvCJXntR0ynu9/W1Mz+1HBl1RVWDaYE8H+il7sAfxxfl0z8RVEZ36nYfOWitfaMwG3MAmzH5XHK0uwQhCuIAHU7t5qK86UsRXODi7ynjy3Tto9jGaw+5jNcxF7p4F662WAwWtvipAIQ/tfk2MsZM5V38Z7j1otUzZij7cIgOojnmF2YjteTY31XmOt9cXLF/FF0eXF975W05S6M+p/A7jDNKyt+Pq/kHq+xy7tpC4ff689Y6i+fESDlVZN7btHlvzoXiO6TIfYb5z/CfWbPV2qmjPTTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(40460700003)(316002)(6636002)(41300700001)(4326008)(426003)(336012)(2906002)(83380400001)(86362001)(47076005)(2616005)(16526019)(36756003)(26005)(5660300002)(1076003)(8676002)(40480700001)(36860700001)(8936002)(6666004)(81166007)(356005)(82740400003)(7696005)(54906003)(110136005)(70206006)(70586007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:44:08.6254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6673a5e3-9c68-4909-d70a-08dba85b58c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568
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
 arch/x86/Kconfig                              |   5 +-
 drivers/acpi/cppc_acpi.c                      |  13 ++
 drivers/acpi/processor_driver.c               |   6 +
 drivers/cpufreq/amd-pstate.c                  | 152 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |   1 +
 include/linux/cpufreq.h                       |   4 +
 10 files changed, 240 insertions(+), 18 deletions(-)

-- 
2.34.1

