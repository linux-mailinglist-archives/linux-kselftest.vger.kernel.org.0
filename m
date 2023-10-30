Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426827DB376
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 07:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjJ3GgN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 02:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjJ3Gf5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 02:35:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179DAC;
        Sun, 29 Oct 2023 23:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjuBfGJPQOEH6WBqK1iDTBmyfGUlcRn8Wm94gTmTLDbBbipVD9xNLcYA4JaQuMDRSkn+DIgMX2SFQveqgnzWdTUyOsLOf7H35VgUevncWlIjM4eOh2jZK3M9SCj0xt5f/+RHp3PjyGS8h9ijnhbXuvp9Rb8VRLcTGtHLfXZbWlnY6jt2YHvDqZr0oJOH5TwT5PXWepWNdFQkPo9fRWn1GTmo8GGXpH0Ezj6jb+ENk6a30SyGuwv1Kyn7UZmxFR5Fxn/sBgdViRrRksqGEJTLJ2agUtPds1wgv4Sm17xiAuyf3DIp56WIbwMFSoK5Rtq7Ew/n2PTJygjC3T8sMFRlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+Hf7usC0hQZ6XEfTNBCV+zk7l8w2H29ZawyubckUuM=;
 b=IbB5R/C8y5B5b6PdPIglgrRoUSFEM6cro8/7P+70CNX2I3LsmO/P+71DziZaDySZRLjFKV2MEH412bgvdm7WiepPT8zXYSSxuJtCtCn7wr7IFNb2/dVSiSsaxHMiFIwmwl97xXvB2rad2s54LDbsKgALyqBx7f+S0mRr4tfY8iRX5LU1Dt69iz5xBcDt5IDAZOe/GjuMCAR50vZZFMcyIkReilytWuLWAxUSdjzA31RLCFsKUOe/DJD6kJLHbSh96zByywY7+YsHFzubMX6U/T8NbKKrnbvYuF7G4N1zhiP1e2BWVC2EiSzg0+DzFcJ9X8k5swrA/kWHjiIZpavfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Hf7usC0hQZ6XEfTNBCV+zk7l8w2H29ZawyubckUuM=;
 b=1ncqpKoOyJ57r4SPHbChhKFFrMuhhuvP8IsiiVYeyG+0zNMYFAZmdQ6Hu25N0488XiaYhqwncFMc7Yx1eo2suue09PtlY6FoCn3qHO3zjIe5Avhict014iWSEH+J3gZG+flQdWjruq4sUyk9ujuYDzFdnPxxWRUKbQr79DCrDDw=
Received: from BL0PR02CA0127.namprd02.prod.outlook.com (2603:10b6:208:35::32)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 06:35:39 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::51) by BL0PR02CA0127.outlook.office365.com
 (2603:10b6:208:35::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Mon, 30 Oct 2023 06:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.22 via Frontend Transport; Mon, 30 Oct 2023 06:35:39 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 01:35:33 -0500
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
        Meng Li <li.meng@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V10 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date:   Mon, 30 Oct 2023 14:34:02 +0800
Message-ID: <20231030063403.3502816-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030063403.3502816-1-li.meng@amd.com>
References: <20231030063403.3502816-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 867c4433-cc14-4a81-8da1-08dbd9126ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1BrHWTNp5VXafcUwA/Ap9qFpFWgpRFG8YHT4bdFBMVMHzZqMP7+g7HqsDqGNiP9ifvM07R+3CGrQsH0YrS0clGLcymLZpel9v9yaOrKwJJXiXzdI+yChl9To7JgypsTAvgtK1IeL7JtRqoPz3GrCpDOMPt+pR3KiZaQktX8ly4Rv0iiupbH1w3BWkvBTNZbuBvb1VUAWhzRyE5lB2ezciwcCFJPN7XyO1u0RJKnCOsLOKEYfisg05vQZoSPajR2rUc4LmIMIZc4rSGiQyDCNbVg2p2FsceeqwlodXhANENVHgt8BS3k+jm5cWziTg5BVHW/1n8sWZCvIhN8V68H5NBsk9FNIlEJPwj87L83pqWe2teBTZkD7k/PaDZjuxndBL9q2+gGDxV6Qy7WklQibWzXDs1X5poh2L/b0c+emnyAEq+Cia9tiCEeCCojLTHu2GQWvA3bnPgZyKKJJ1aRVGKpPS+2fYQUHnECz0eV5W6TyoZ5gE4LmhUEm+QJp3ve3RIkGIrvArZGRxxjHqN87tEFTj+hiEa2UDgv7JjtnenJilVniEFF845NgtWySCCwUERe0WJUxPoY4oFsJzZD791PyTWVzhbpoL8kQfsrfso179H58PKCCnoU/yVZxOXtf0SlOR5rRSScpsmLv+3mH+nx2bETgzTdO0UlYNzsiAvKJ+TUu9pbEFlFLLNiI2KR5wF5WTFGnYhh+/axDl++ViWX75nIz//x8Cu3aHmzGu/4UGfB36jANjLin9i+l2TDpU11gy0LMPei3zfDS/MAZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(5660300002)(40460700003)(7416002)(81166007)(356005)(86362001)(47076005)(82740400003)(336012)(426003)(1076003)(16526019)(26005)(83380400001)(7696005)(36756003)(478600001)(6666004)(2616005)(36860700001)(40480700001)(2906002)(70586007)(70206006)(110136005)(41300700001)(8676002)(6636002)(316002)(54906003)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:35:39.3077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867c4433-cc14-4a81-8da1-08dbd9126ebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce amd-pstate preferred core.

check preferred core state set by the kernel parameter:
$ cat /sys/devices/system/cpu/amd-pstate/prefcore

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 59 ++++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..0b832ff529db 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -300,8 +300,8 @@ platforms. The AMD P-States mechanism is the more performance and energy
 efficiency frequency management method on AMD processors.
 
 
-AMD Pstate Driver Operation Modes
-=================================
+``amd-pstate`` Driver Operation Modes
+======================================
 
 ``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
 non-autonomous (passive) mode and guided autonomous (guided) mode.
@@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum and maximum performance
 level and the platform autonomously selects a performance level in this range
 and appropriate to the current workload.
 
+``amd-pstate`` Preferred Core
+=================================
+
+The core frequency is subjected to the process variation in semiconductors.
+Not all cores are able to reach the maximum frequency respecting the
+infrastructure limits. Consequently, AMD has redefined the concept of
+maximum frequency of a part. This means that a fraction of cores can reach
+maximum frequency. To find the best process scheduling policy for a given
+scenario, OS needs to know the core ordering informed by the platform through
+highest performance capability register of the CPPC interface.
+
+``amd-pstate`` preferred core enables the scheduler to prefer scheduling on
+cores that can achieve a higher frequency with lower voltage. The preferred
+core rankings can dynamically change based on the workload, platform conditions,
+thermals and ageing.
+
+The priority metric will be initialized by the ``amd-pstate`` driver. The ``amd-pstate``
+driver will also determine whether or not ``amd-pstate`` preferred core is
+supported by the platform.
+
+``amd-pstate`` driver will provide an initial core ordering when the system boots.
+The platform uses the CPPC interfaces to communicate the core ranking to the
+operating system and scheduler to make sure that OS is choosing the cores
+with highest performance firstly for scheduling the process. When ``amd-pstate``
+driver receives a message with the highest performance change, it will
+update the core ranking and set the cpu's priority.
+
+``amd-pstate`` Preferred Core Switch
+=================================
+Kernel Parameters
+-----------------
+
+``amd-pstate`` peferred core`` has two states: enable and disable.
+Enable/disable states can be chosen by different kernel parameters.
+Default enable ``amd-pstate`` preferred core.
+
+``amd_prefcore=disable``
+
+For systems that support ``amd-pstate`` preferred core, the core rankings will
+always be advertised by the platform. But OS can choose to ignore that via the
+kernel parameter ``amd_prefcore=disable``.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
@@ -385,6 +427,19 @@ control its functionality at the system level.  They are located in the
         to the operation mode represented by that string - or to be
         unregistered in the "disable" case.
 
+``prefcore``
+	Preferred core state of the driver: "enabled" or "disabled".
+
+	"enabled"
+		Enable the ``amd-pstate`` preferred core.
+
+	"disabled"
+		Disable the ``amd-pstate`` preferred core
+
+
+        This attribute is read-only to check the state of preferred core set
+        by the kernel parameter.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

