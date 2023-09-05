Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF3792811
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbjIEQHa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245091AbjIEBvz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 21:51:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529BCC6;
        Mon,  4 Sep 2023 18:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAmiZ/rW+Ir+OyFCN19eHXDgFjumMBdOjDdksAGvmkyaY483bX8ibP8gBKOocctMrNepnsJG/SSFOdsTn4akhhq/ak+eicRFUnEIGqMi+z9ZeecAWJvRyeQnvI1qftWQ4ee1AMosGt18vlUX/xdM0bMH0HHIAsqSCHAYYm2LygsVJHX2pbSSFNmG9C5x6LVxcXFMj654A8PeiRS32k+UlvA7S3xmK8+GeJY7h2ch7fNuwELolv5280dZbxd2OMDQExenVJw6HT5C29As+kdoUAu/uEanbV8vICpPFJ05CMBC4WMMW/x/q44nMDzuX76k1tkDeGGn8sPsCamJq93N5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBaHOq6ndVbIuYsTuruhF9Qt51VCssQon0WUuIKHkH0=;
 b=XXKbiVrY4xpzgRunPkLqqUz0H3hSHHM1s2eho8jGhGdf2cOVu3A08tpPVcMtu+jubxGi9LibjHFuaEkdVElTEdBzdn0tfE5KJJosKERyAU/xvZha8m8EfNBqJDDwMk+xmYbv6IpIv5o64XqdsBEr6K0Z7XDd6pSiCqYLKpL/8rejrJlLKysdybm4386a1aELHV9i6mCpaw/HFcqKGfo8YE62JYPuGVQl/z3dYublmW4+0sOfn92DGV4A6iuTczP1DHXHnPWKseAkWNPwi1CSEf1QeXBbgtIGQBF48tFVX/CnfLdVSNmk+djy4vLkIQk4MZybVMiAQrOub+NRNARRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBaHOq6ndVbIuYsTuruhF9Qt51VCssQon0WUuIKHkH0=;
 b=F7wV8+tQqgXh5QT8XDt9a+tiGPNIrxtKFHahaJz6uKC0YpWMEjhAJLnZofhkCMzUkXhMWkEuaWw4Z5MKCLEcmykxG9bnrhzmGVY4tEIMnbFTk7uXsGaRl/tL0WOWol+AugQoFm28LtKP8axO/pdOFMuRkNsEmCDwQLwVxlSV7/0=
Received: from DM6PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:100::23)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 01:51:48 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::56) by DM6PR03CA0046.outlook.office365.com
 (2603:10b6:5:100::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30 via Frontend
 Transport; Tue, 5 Sep 2023 01:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 01:51:47 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 20:51:43 -0500
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
Subject: [PATCH V5 0/7] amd-pstate preferred core
Date:   Tue, 5 Sep 2023 09:51:09 +0800
Message-ID: <20230905015116.2268926-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 7520ae53-24ff-4f11-13d1-08dbadb2aa7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afIeJhO1SkFYq3fY0JRjF7rlAIYoGYvgiCnJ+xoZDfxp/ukFNq844wuP2E57T0orI+IaM3y5UTb+9UcQIkpHT5s5LZoEjGXEigkRkj5dxJaNWWLdW5sMURv4tmsvTGCXuyvfRvSIO4WHN75QNIqRyoiYQFP/noRB/2Q04FHtMocUquaFHWpRRIfmp2QzyJQSetCdblSb3VCvZ6efoup6khZ6TfMxCL89HdAHmkP59TggoX8Qgo3B5iUeWBOUylWGxB3LVK8uGogqdb/x5KhEWYAXFckKlKdJatqGnIhencB6EaLi3mNvx8cFbPzxaMkvNsQCeBClK35tAz8mITZTXI6EcO0ZLlESU3i8MiZlqXAXjwrfzxmjKa/dWniHffpGPNofjTgAsOOTVJEwAFSHbJeF4xhLB7P207dkgXJUCTo78UuRkR/grzfp0RZVqKchc68gOD99NizazFpXB2wFKy3TzKOH01P5AzgHsFsIrkwA1TjzwH3erWTbH3NHFD7QFKKRlyOcm/Xbmxcdpy1AdjZfUIseqQQTLqygV74w5Qr06Se9icSSefqJRUvSwZpWsH8ylTIJHUPbxFsHCOH8CXJrP+jqk4mL13duK3KXiQXX3m8OcY2WIVXES46zkKtvKavkHgdzPsFAushVibhgkBR706ib5InPS0SlFvQK45fW3UyygxezhdjsspSw4Ee03CXmhTfbRJQmhtE10W3zheT9dsqfLZCLsv28V16jBsDaw06ZPFhfNvlNtrLXF6F9BtFWdRv33qRj4Fgo/Rv/ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(8936002)(8676002)(5660300002)(316002)(2906002)(6636002)(54906003)(110136005)(36756003)(70586007)(70206006)(4326008)(40460700003)(41300700001)(7696005)(36860700001)(426003)(16526019)(336012)(26005)(1076003)(47076005)(40480700001)(356005)(82740400003)(81166007)(6666004)(478600001)(2616005)(83380400001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:51:47.8383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7520ae53-24ff-4f11-13d1-08dbadb2aa7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
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
 Documentation/admin-guide/pm/amd-pstate.rst   |  68 ++++++-
 arch/x86/Kconfig                              |   5 +-
 drivers/acpi/cppc_acpi.c                      |  13 ++
 drivers/acpi/processor_driver.c               |   6 +
 drivers/cpufreq/amd-pstate.c                  | 167 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |  11 ++
 include/linux/cpufreq.h                       |   5 +
 10 files changed, 277 insertions(+), 21 deletions(-)

-- 
2.34.1

