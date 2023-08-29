Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0662E78BEC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjH2GpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjH2Go5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:44:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A8419A;
        Mon, 28 Aug 2023 23:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8YkC0nWynra7lSbg3+j4EgCeDuCrE0gVlgVWIy1b0q4HKzCdX6csB/OGIJvrBAVMYu73ezLcZ3PuZIoJWnRhLcL+werTHdH2daFDbO4nwwGSJv/zN1G4y86OPE6dI123xpwie8jiCywdrwE+sdBEpuNic1oA375tfZm0i5oAR7ZiKgohr5dZukFjVo7rVhaT6uLqQ1sk49S+GsQzA+6i6zzw+iP3KjAGX1RwW60JtcMxx5S96ypJwrRwNgyLYKLEdqfoHQs/kVZYf9MYJ+rDaQPoMQNznv+shU3oegHiltFpWcej5oskIdSRU3gxtol+OF66PYdSXnodlfCOKY7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/twzkum7HMH2eS7Eu5xBSnhyLh3e3aQVrnNsAB5bIE=;
 b=JavVL25W7NjtVqUMFHDViO+BudPuPsOBvvxtX7Y1mtVBzbrPSsKKMN5wTpJiy7UjBy4y+fWTs7W6fmEIHGOahgrzHcLi3D8jB6qxOOlp3BmCyzahm7/auDHI9zljqKRC+0gs/KfhDcXms2BAZ35EJiF1Va2Y+ccrAP0+oqiR2ZyAjxiAgxpUbgAPdgpkp7uVrgRSDMG/LlHF1oBfrH+hb4GlD4VRd/jG5K04RBxKj9ltA29iAaIahcD9JSa/G7mGAxY0/EhMaEe+zG0m5R3YFVLFGjrJ2/SIrN2P0zfySUGLU/Irta6CH+Gm7YYNt4p8NilWkqa8xPMBTF+sRgj4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/twzkum7HMH2eS7Eu5xBSnhyLh3e3aQVrnNsAB5bIE=;
 b=IMFgJPo6N/H63a44zOYS+JiQbeT+BITm+eyrfmLXNgrP1pGhlS6+QcOGe27WOod4VsFQrclh+zfaao0s/SLvqa1NVj8gjKmuQ8Scnn9Y1shLoALBUshQ54eAFseC4lHViW3F+r4nxHedWZe4OgOJofU4rNLoBQ2dReILvVYEfzI=
Received: from BYAPR07CA0002.namprd07.prod.outlook.com (2603:10b6:a02:bc::15)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:44:49 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::c5) by BYAPR07CA0002.outlook.office365.com
 (2603:10b6:a02:bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:44:49 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:44:42 -0500
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
Subject: [PATCH V4 6/7] Documentation: amd-pstate: introduce AMD Pstate Preferred Core
Date:   Tue, 29 Aug 2023 14:43:39 +0800
Message-ID: <20230829064340.1136448-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829064340.1136448-1-li.meng@amd.com>
References: <20230829064340.1136448-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: da167f23-97c8-4002-1e91-08dba85b7105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDpil3JS0UL4C8MxXHbgm647nKXM89A53zWAmMd/mbryS2QvKVWGGXqJFy4hcgmcgWTTvlbv8XmU/uYRipO6Xs9WGlqfL71VrXJ8XAtLDMXrHxdd+foZnBgLh2On6I+YEVF0q1AuJbV8pBi+p5EYg5XOHjG7VTTx5F6lwJKmtzcM1G+7F3/0hjdX6JDCr6TxvQpGW6NULnrFYDtDLQWzN7nLM8SO8SU212o4QefT6ilb15kvemRScI8PcM5zsEk2JVoDfZjgg3HcOosDcXKwm0pwaFDgMUMRHQ5hzJZ1gfw9vgMee20/sJRuYW+O2j6HXLA3776MBUs5bilpctQEYa9/WOoiaVtPu/SXLs68vpd/MpPl7+ej1WAkBE1EMLznhSifpuqRedRZouU7XTeMpjZ/vJF/pEA0ktSUDXCqMjxQJMbgtmvRUqP7+jKeAUNEKMARtnAGt6O9xzT5pPmrBqsf1TabipD/iTscX3cu4H1NUA0i5GhyFSKILU5hfKgGp6fAXuP+yPN7obBvBsiVzw3iLnTTwy1X7ajrd1FKfbIWTxupLQNRizWCVOhxdk6d0DzxdwwbGbJNwtRX6EHemEHW2FophcUfU3ZxYEU8mLZMHCHqcxijWxJle2tOG22pE+nFz4RrxeBj73sdDDHy0zmqF7oysM19+9y2IF8PhVAX2dDhKaO1a1B9+g1++ryYyGmfK5gY3I5VLuzx8UmM7F0zrCf5EFzdt9tijkuk1r/GlxL0pJGB46ZQQI8e0EC9P695YMLcGlO0f86I93vC4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(356005)(81166007)(82740400003)(8936002)(6666004)(110136005)(70206006)(70586007)(478600001)(7696005)(54906003)(6636002)(316002)(41300700001)(40460700003)(36756003)(26005)(16526019)(8676002)(1076003)(5660300002)(83380400001)(2906002)(2616005)(86362001)(47076005)(36860700001)(40480700001)(426003)(336012)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:44:49.2989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da167f23-97c8-4002-1e91-08dba85b7105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce AMD Pstate Preferred Core.

check preferred core state:
$ cat /sys/devices/system/cpu/amd-pstate/prefcore

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..400264d52007 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum and maximum performance
 level and the platform autonomously selects a performance level in this range
 and appropriate to the current workload.
 
+AMD Pstate Preferred Core
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
+``AMD Pstate Preferred Core`` enables the scheduler to prefer scheduling on
+cores that can achieve a higher frequency with lower voltage. The preferred
+core rankings can dynamically change based on the workload, platform conditions,
+thermals and ageing.
+
+The priority metric will be initialized by the AMD Pstate driver. The AMD Pstate
+driver will also determine whether or not ``AMD Pstate Preferred Core`` is
+supported by the platform.
+
+AMD Pstate driver will provide an initial core ordering when the system boots.
+The platform uses the CPPC interfaces to communicate the core ranking to the
+operating system and scheduler to make sure that OS is choosing the cores
+with highest performance firstly for scheduling the process. When AMD Pstate
+driver receives a message with the highest performance change, it will
+update the core ranking and set the cpu's priority.
+
+AMD Preferred Core Switch
+=================================
+Kernel Parameters
+-----------------
+
+``AMD Pstate Preferred Core`` has two states: enable and disable.
+Enable/disable states can be chosen by different kernel parameters.
+Default enable ``AMD Pstate Preferred Core``.
+
+``amd_prefcore=disable``
+
+for systems that support ``AMD Pstate Preferred Core``, the core rankings will
+always be advertised by the platform. But OS can choose to ignore that via the
+kernel parameter ``amd_prefcore=disable``.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
@@ -385,6 +427,18 @@ control its functionality at the system level.  They are located in the
         to the operation mode represented by that string - or to be
         unregistered in the "disable" case.
 
+``prefcore``
+	Preferred Core state of the driver: "enabled" or "disabled".
+
+	"enabled"
+		Enable the AMD Preferred Core.
+
+	"disabled"
+		Disable the AMD Preferred Core
+
+
+        This attribute is read-only to check the state of Preferred Core.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

