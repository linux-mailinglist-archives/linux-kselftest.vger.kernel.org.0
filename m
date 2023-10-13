Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD57C7C29
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 05:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjJMDcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 23:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjJMDcj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 23:32:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6FEB;
        Thu, 12 Oct 2023 20:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxsvnF/sBWxbG5P+exCym4MfvbtchUlb51gsSKnijpnukVgAsl1XgSULlitdPYmPuHZUJRsMP5czUgN8mfxlCz2CnKirfMOXQYfTXsS77690lqnUa1fvReXAPFKd1k6d94mnM4MC/TQYo9qwqFbIkLNElzFj006ne9/sM0RS00+WhxbQImLR4c5c/EtG8aUzKasIIdUzVjLePf+wdu7u62oDrz6qkZZ5gD7J1j7UXd5SdvNtFrmqgQ3wy6U1ZnvMh2hIDhd6nI2GVpNQwmUXWb/fYPnIJ7K3TlR+yrZVV+jDFWmB/x5qBaR0fJ9wyIX6/rEr988AlaC6vxjf37YhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+Hf7usC0hQZ6XEfTNBCV+zk7l8w2H29ZawyubckUuM=;
 b=jiBSz5/myggP5CNznliYfLqs/SJKAC+ZON6sDuhWVf+9GjyG6yt5VfT9HvuIVMQ5KeAoYxs3dfBI7knYu7C4AXm5GPxwTyTGgas4WN7Y1MJwslBlrACLyZFROjE5g1Mh4my19Ow2uqwY1bdszNy7DTPq/JMYPZg7SmsUUqlh4Zk5RausPawZ6Ee23/piZ6JMr+N2w46BQqR73tO1DBZHP649HfafHSpH5756TsPzENS18tOT8dQTAkU2twasAEkLs77FFUeD2H2/ux6NrXXtZqED8Y64FQa6An1w7pceQhIWK2l57vMVuVSYgNjxDZ2CgGQUoqEUKdbszBIGsBe2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Hf7usC0hQZ6XEfTNBCV+zk7l8w2H29ZawyubckUuM=;
 b=KsO5OjYu4S6ov5cjNLk+sZCFdcPf3teivJO3FDG1pvHrSrCBugl+pFRhmyEuWPoFJVpwj0XIovHK3W8AdVnKL1kGYVT+5kI50Pr/fed+lCkLt0AC80x6I7qoXw7dZmbQtKq3QEQXqk+KSWigxLxbb+ithSWGfs4+0hREIMYPDms=
Received: from BYAPR03CA0028.namprd03.prod.outlook.com (2603:10b6:a02:a8::41)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 03:32:26 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::16) by BYAPR03CA0028.outlook.office365.com
 (2603:10b6:a02:a8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 03:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 03:32:26 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 22:32:20 -0500
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
Subject: [RESEND PATCH V9 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date:   Fri, 13 Oct 2023 11:31:17 +0800
Message-ID: <20231013033118.3759311-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013033118.3759311-1-li.meng@amd.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dd36ee-65e2-4c52-4ac5-08dbcb9d054d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvwHaaVnvP8lSk2R4DjRTCKV/BXH0i2/CXzF4wJX5yjsbdZKYN+ysYdUBolnpys8qGnPKo+iCaEEoGV0wVj4zOveBB43SEjA+rDn4M8iNZd5we+FWjtOT5LPkviKMdDB8mbGMmANRs8p6ihNCF7OzaiETo8fJnaT6OKukpBAsE23nnYa+LqIFt6eIBcnr3CB3+a9DP/7lKWeqEpoAClWX0z9mH7S2Y4wOIihFYvwrDp/0X2JFpn0s0/K6uRC5iOonCb3xZgg0BFgoP4UWsU21jSfp7eMo5ndvzhGNOPfUsocci/vUJiQWF0Ri5Z0I6xLbgIwxnCcQAsBHnbjF1XiepDh9Vx804NCru24StnGqvYxt1xY2kPA0ZdmDHxR2gJ5dyAoQF1yRsTJ3t4PWDwNOXKSNhF+XgNbqv3ItK9Wh5l0GV1YIwRjzM/OmPVUKR3vjId7MoKbTngI2K2iFw/Q2Xg+zSDMbAmP3LbnB0eoTYq/k0/7rkxl+ppPua2l+9AYH0CME8HcTM0NOUVzR2Q5yA+TD94EwSzdu7u/jAw0Alm5poVp9WMaL7/qR1NdSgchg6DeiTm8wWDBdnKmo9lioGjsKmjAXYT0ctSU9LXJu3Rd76f7FQLQ+iu3jAATqFwfTDbSC7ZoUll2vFD9aCMGmzpwmdhx2kT2gEviKY15IC/+jd44+t8m3UbWu12LoZan9LNtVhgv2KbZ/yIAl08iIQMiIXJqv2mRwR6YTx/Bgz6olVnxx+Yx591SoXltPMV0mxnjcY4gxaywjUbQIBlWRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(83380400001)(7416002)(36860700001)(2906002)(40460700003)(47076005)(36756003)(86362001)(40480700001)(82740400003)(81166007)(356005)(6636002)(70586007)(110136005)(54906003)(41300700001)(1076003)(2616005)(26005)(16526019)(6666004)(316002)(70206006)(7696005)(478600001)(5660300002)(336012)(426003)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 03:32:26.0750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dd36ee-65e2-4c52-4ac5-08dbcb9d054d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

