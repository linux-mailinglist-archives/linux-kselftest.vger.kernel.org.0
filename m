Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7246077402E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjHHQ7v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjHHQ6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:58:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0E4558F;
        Tue,  8 Aug 2023 08:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSRRgGEhne9Y6XCRzaK7SQUAS0lpw/E1qd94rYEXBsuxFJu/7h1k3pVfSQH/LmyxXN0ZhSf/iip7AnslCu9x9Dzd1iTs8KonH2GP6528lkihnlqytpTdndza24xKqMP9sNE3U5Z+9CXH6o/iJI39YkYXcCW3trVJ/TPV8yHtSAb235q2KRFdQH3ShJp6oMzECqaNaiv99g51+w63xSvSGS+TD6b9O7xsdlQdsALQTAVvPSmgUULo64m2zTSy8e7MOZY0zG8OvkNIgYj8rAndK0Sr2yb3FLe12b6KgMa3SYmFdWwqYp4R5BE8Mup4tIThqMCgLSZ7JFw2qfTbQ3b1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW4KpB9SvJg6/bqbIlP7JzLgR5j9uxWrEy5QKxHZ5Ps=;
 b=gzU4rMyvGRbUtTnabN+ZPMiXYPIuWJwyCotOMSn+XY5hXJ3BzI7ArTTOafgcosnOSIRiWTS3BymxY0P6nECLoKB0zL5Yh8PLKP3DnGI6e5vHGWKCCk3wx0b9zYw9hEN0Z/B7wSQIONrMiRqIr9cguI7FnzsCfK0rTmLlr0O1in79metHfz5qSM2UvcPiDrb2hl35GujEy+J4cS/sIIq7q3tMEvAMmJCo6TbISKRFRxx5AwKE79NRyMzki3tEyvwHJ++hY5dXUM2rUtpdfv3Jkt5OInagEbsUAHfPRNJY8u9cS3TFZQD15qNZPSYXAmhIgrvOV/7TpnwEOnEAIAVecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW4KpB9SvJg6/bqbIlP7JzLgR5j9uxWrEy5QKxHZ5Ps=;
 b=CRVTjTDMgM4YwqAQ7fWjEADKywPSdAsohV12skwScKdTyjVlvA9gdAiJ00NZjN/Q85CyNpUaLp3f82b+M0z+PsQT1xCnj/gvefsFGGWJpg+MhPSo6v+6tKTzQu85pIWeTD4suSMuhD5QaIGhAbkn75BlUcLMpuQploGzV+bMCp8=
Received: from MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:10:59 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::6) by MW4PR03CA0318.outlook.office365.com
 (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 08:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 08:10:58 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:10:24 -0500
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
Subject: [PATCH V1 0/6] AMD Pstate Preferred Core
Date:   Tue, 8 Aug 2023 16:09:55 +0800
Message-ID: <20230808081001.2215240-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: d634f86c-58a5-43a1-f5ed-08db97e6ff81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFoo3tL+ug8jWfHdqYrnFYpJNLeZVwPcYS4oVIp5XzPnosUOe5g867P3WWu25iU8sKybabwa0ML2IQUoL1duwcjatHxOZ+0JaLndWmQFLhYBQ12j0gEEMhOQhwns6pSW9wLAYhK6Z834H+yGWt6bAyZ5x0bQggfNIBKNrRaxjq4RPrqQEldtW+2bq3B6Dtl2EkJapaKbgvQJPGCWsMbuGpc/oXO0QZZx55RBHPftht1eikrYfnKVr3+GOd6OCi9IqvkJRG7A/moSlfiTXH7h6zqeRhyMM2BwyUfWjua9AEpXRzSB6ImIQEu1OvCypzM9f1Uj38hXn4p+snCBy2KcJUchcrgo8+elrNwlxiKsPNxLr9+2F3BvAZAqCVxobRFUpNNBT5OWvYnZVFwJhzyorzyqbNWuZKKiQ2G9tvzofZhUtFDVUIBuBW1dA0lkNVSHVKHIt3OY55iFyL0V0PDV9U0kHyUvnfplnCHXsN3Jh+EdfMzrWeti2Bcqm6lHEJ9HRCqUjGEodIa1BKMJsiUshlYOUmbf/0eADbc4VeYJYejG5yGd3XeZFq1vwsGl+YRRLwkh9hZoBZEX/g8o8sDS7gLUaJsEb37GL3oKozvwVM/fVxj2W/D/og5UZFpXVoVTy+w50PfXR5R8I0mE/XPzifWBReDR68rtCRx07onisum8eztkfQgThWWBEB1RsDuQWJ/olLF+Sq9Ep4/43K9Sv5G8SqmCMBdiU4Ituw/hMy5ldU0bmjIfUyQkU0UWeDBIRP/5q6PsK5UvqcXaotKDlTtT6j85qFJCpu0ZVTZhs+bb3Rg6QEGyASgb62/13bqextzR+8cAy9CrFdwvsC/GtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(82310400008)(1800799003)(186006)(90021799007)(451199021)(90011799007)(46966006)(40470700004)(36840700001)(2616005)(7696005)(1076003)(26005)(36756003)(16526019)(336012)(6666004)(82740400003)(478600001)(81166007)(356005)(110136005)(54906003)(70586007)(70206006)(6636002)(4326008)(41300700001)(426003)(316002)(8936002)(8676002)(5660300002)(40460700003)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:10:58.6630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d634f86c-58a5-43a1-f5ed-08db97e6ff81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

Meng Li (6):
  ACPI: CPPC: Add get the highest performance cppc control
  cpufreq: amd-pstate: Enable AMD Pstate Preferred Core Supporting.
  cpufreq: Add a notification message that the highest perf has changed
  cpufreq: amd-pstate: Update AMD Pstate Preferred Core ranking
    dynamically
  Documentation: amd-pstate: introduce AMD Pstate Preferred Core
  Documentation: introduce AMD Pstate Preferrd Core mode kernel command
    line options

 .../admin-guide/kernel-parameters.txt         |   5 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  55 ++++++
 drivers/acpi/cppc_acpi.c                      |  13 ++
 drivers/acpi/processor_driver.c               |   6 +
 drivers/cpufreq/amd-pstate.c                  | 181 ++++++++++++++++--
 drivers/cpufreq/cpufreq.c                     |  13 ++
 include/acpi/cppc_acpi.h                      |   5 +
 include/linux/amd-pstate.h                    |   1 +
 include/linux/cpufreq.h                       |   4 +
 9 files changed, 267 insertions(+), 16 deletions(-)

-- 
2.34.1

