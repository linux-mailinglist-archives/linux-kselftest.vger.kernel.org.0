Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C8786529
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 04:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjHXCOs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 22:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbjHXCOm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 22:14:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219F10C4;
        Wed, 23 Aug 2023 19:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jgmt7X74/GyJzY26nfebweOG//dVLJOhobMKG4aLwshV3+eqszGKSHwC5wEzsbhgwd1aGj6+p/UDCfQWLBlSzAP1/TFGuBl+MlBBYR202vPMIaGeFSKW1LmJ0IY0JKR4TcNrJO+0kkml9fuZTxR2YG+9FMIFPKptqERITJYDgC6yQV4QoxPfKreTG5jwGAVkHt4AMmCJO+rQcGjY8jgGNplQX6fsJKeHwyrx1yhpFvBOqS6JGKcM6n7W17V4alKnyqP0N8lh9A0ZPzeys7e2ahpPr7Z9zGmfp23Zsu7ejMj5dOqf7GkkVFa38Onx1USCoM/Syph+XvQcFErAuax3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdQmgPZ0zUlC4SlUyNmWx6l2lYzdtFJA5PmVErBA9Hs=;
 b=HPIErkHJWVm+DPGn633ouDOxcQryDCdPVhpl3L8Yh1nic3mtFZc36sQIpgPa1W0Nw1iYPiqXUPu+kpq2LQ1ct15HmQ8RT2t0Rv+g+1/zzV9502K+d3CYcs+12Kdf8c1gCytTc+9ZKyEeFCZ79k3R/saXSLZK+WFvgcfFpqDuAtUY5C/drcTxHc9+ZEh/x8pEGpIAuYCM39HuA2b0/ztPqZrXsbCwTGS+mgFwdrQDuyMw5eNeCVCcz2FGY6NU/biuNWsQnE+rN1TfNFuTBWenMP4xRet7AV/Ewd9yX4PdgTbRmN6skjfqYiH18N9zTIZycLpGp5OR/nhf0DDAtWq4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdQmgPZ0zUlC4SlUyNmWx6l2lYzdtFJA5PmVErBA9Hs=;
 b=jxn0LnXOgLgAe6gmHhGOe+hNh3RTeMG4MxspnM7v+IP2Dyc5+ZUBirzNaEFoy3xVdOlBafmO2gLQugrVLMXLt7FpyHuiX3BGJL8ElsOaZ/p1FW0TFG14p55F1AdKyWqi+quddK55Jbu6QF8dCAzgfnLwmjL+XmvsnxCi4HgXHKg=
Received: from CH0PR03CA0431.namprd03.prod.outlook.com (2603:10b6:610:10e::22)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 02:14:36 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:610:10e:cafe::39) by CH0PR03CA0431.outlook.office365.com
 (2603:10b6:610:10e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 02:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 02:14:35 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 21:14:29 -0500
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
Subject: [PATCH V3 6/7] Documentation: amd-pstate: introduce AMD Pstate Preferred Core
Date:   Thu, 24 Aug 2023 10:12:48 +0800
Message-ID: <20230824021249.271946-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-1-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: a53d6250-08b2-4273-3df1-08dba447dcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LS3AHKJx4jeigzGSV0u5LC7NR8zAB9ZqSGCefB3Z64kbmfnmR/bVuMxSs64U5+XDb65gQhuYRdHqRRFkfOSQgfl0bEyg3ZdBPOONsb8PKQrkrkYJeIVgEPpHyIbI3ia3rWNbQQONbzRXm/tYVjnfPXLmbptKUxsVQ9ODYxwEsKPp01QlZ4DxSzdpC4plnA9bhf1WwZ7slXUubZEBCOqsTh3nziEtDfXKNySR6TVpL2inRlAUbkSjdlECJM+5VfSLa0qpGtx3I6hGnqD2XJl6ukcoHacEO0K1xYa5rGY9mlHHcnYIcGAAm39+t76ote7dpCOumAp81le+FKAjkF/xtKYPtHXYNrHkSxQWdrmbMju274X4Osd6F9b5b9c9W1ot8EiZEMiseFM6+ZlR8KUj1nLTJ9QvEHV3gRlV0I2njLKKFZh7OC2xwy5eBhhws9B1+tsbcjBXcGzykpUgmKZSvcdQpP/hMHRoXOZoEg9bOTcmUg/Hi1UkB/AKkjoksVbByHoP59sV0277YgTEeVWK6FPidMM9j70gq38nJoX/HmRNfYc9HAZFfnRxCDQefZRkwnh8R5+cGBf6EnTJdNk8dtosxmSAkDZd9apyh1/LFGeXrmc1QzU+9MIlr9kwbS0u2J2SWh4BZZaV6gkR2Yh39vNiGyAjwJyUCBkc7Zjj+aiwXN3QOpcxFQV6UN/zaTcgWfDcWXwcO5AgpEPs38AKd0MQFMwaAcWT0AGQ3GLsgHmhfSkmasLD6q+kny4F4uWB4LMl3iO7R1Uje6odQGE/KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(86362001)(478600001)(40460700003)(40480700001)(47076005)(8676002)(8936002)(36860700001)(426003)(16526019)(26005)(2906002)(4326008)(1076003)(336012)(83380400001)(5660300002)(2616005)(110136005)(316002)(70586007)(6666004)(82740400003)(6636002)(356005)(54906003)(70206006)(41300700001)(7696005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 02:14:35.5445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53d6250-08b2-4273-3df1-08dba447dcc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
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
 Documentation/admin-guide/pm/amd-pstate.rst | 53 +++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..2369b58a3521 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -353,6 +353,47 @@ is activated.  In this mode, driver requests minimum and maximum performance
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
+``AMD Pstate Preferred Core`` enable the scheduler to favor scheduling on cores
+can be get a higher frequency with lower voltage under preferred core.
+And it has the ability to dynamically change the preferred core based on the
+workload and platform conditions and accounting for thermals and aging.
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
+``AMD Pstate Preferred Core`` will be enabled if the underlying platform
+supports it. It can be disabled by kernerl parameter: ``amd_prefcore=disable``.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
@@ -385,6 +426,18 @@ control its functionality at the system level.  They are located in the
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

