Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2215B7A446C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjIRIR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 04:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbjIRIR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 04:17:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD36C1739;
        Mon, 18 Sep 2023 01:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGZuHyf9moLIjof57jInMcuwdE6lVBhrahz/A56YG0Ta4aUI1PC6XY0JWIqcOhzFypl1O8H3B9P/gowtJU8pcvPkVT09uH2jTfYXsee0AOe9t/lzusyFDtg4ImWi9f0pBlXJwP4cYleR9gUGqiPgHZ1qlt29E9O1AF98LB+6O9WmbFDbABdz7wN7o9Hd7tBBQDFwk6rYrvn5xnOUT3hZmMsMLdi3y+beanSZGER3F3Md8IgHQptT8F/y+bjjwSxrIKfYzFtKOLQ/Yjvi3vhH/akhIJOmDqOPj1fqPWGlUoGJEhLxobCTOnnpoWAs5DPIkqf8XXe5KRPTY66tszjdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10b6i1hYViwjRtxPhP2360wO3wPsW6x4KN8SUUgV9KU=;
 b=EBMTU9BO/IktXNBpLo3y9NAphA/f1hrVeg2iKyzLadlciRYzg3eXWFdxzyNJqqQLEz2oSsy5tEF9Kgc7YRiSfvV7HNKlWMC2hzEBzW0a8+Y3CnbvsV2fxkF9XwDsMfKf4UIX4yZn70xKbc6/Qrs1cFEaRN1uXjAzsYP3qPkmk02lPwcQmhD5eqD5t9c9OpDwrHKM2Gi8s/D0j6KxfDMhXlfVTpXDZMvIbQBSxGpXeCfHGBpNr2NmvjzRDtcUrq7AnROH7Cjrx1mmQlsKr4Gs5YM1dsB9mOTztFt0VEtWME+ipWAFCM1C4SSMWTP86mXDV3UV9G6dnQajC+qCUvm41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10b6i1hYViwjRtxPhP2360wO3wPsW6x4KN8SUUgV9KU=;
 b=tPEF3DrVphpZq+76BIk+TQcvXEbTt/FnkFM0QFFp9d2BV+QtuyxTpXkQyaoIA2Cy/xH/ySRNvtuGKT8ww8EqRPdHZ8Tl2QWfCVfO4S3/olrILJVyINg4n0EYPV85vfOuvMRPj0gw7d5Ihu91GQvOXnQL5pw/ptK/RTIPb31vwog=
Received: from DS0PR17CA0017.namprd17.prod.outlook.com (2603:10b6:8:191::28)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:15:34 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::52) by DS0PR17CA0017.outlook.office365.com
 (2603:10b6:8:191::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 08:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 08:15:34 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 03:15:27 -0500
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
Subject: [PATCH V7 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date:   Mon, 18 Sep 2023 16:14:06 +0800
Message-ID: <20230918081407.756858-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 7361dc79-df11-463c-84ff-08dbb81f6e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhgtv/HCQ0V9aYhDq/UL2d03xrGUpfaMssFCRDFEflwogKGWvT5OEQCt5xtWeZtGahgwY96YFeW28JWM9aCamBYwo71ppfoqgwd4piaQAmaiPp05/YzBXTlpDfDPQNt2EQNLdGhh6x58hQQCzgeD9ABZ5rM3Z0NRr68jmDgZCVfTyiSNaLtmxM1yayx3OzxULmPcVM2kJag9icuDoTwUbCKAzRkbuJZgUQDYHGoT2w7GCsZmOjfDJ/EJnMUlqd9A7GOajdjumgq/0FaanyiLbNW0H9oy/l3sMMp6ltzJznB1fWP8lw9Q6bSL1Yi9Re2FgbFM4cII6OfWQQyYY/t0OlpzTQs2tVjeap9aZeLFWzzt+ZUlLxw4uxBf4kps8UaLAc/uKfw7dByPh/rygk3QTmM7tx4Rl1y+joop6gMdV4TTvajDJb4NRG+qJNNf3YA+hbRn4M5e4AM+088UAg3J3BYd3a1xDvB/LNB1TTfFswYOz/8pU2YHJ7CnXPCMqtNLMhZ29hmbnJNF+tzhsoCGrwgmybY6LmUQMHl4ROYLI81+WBvtASHUoXzhlfsmkqRlLdJxMFPVVbPvr7IObbS52aR9GXUZmE0QVQV8ttl5Dw1ImNRPDun5QBVLuZQscObkQppg59Ra0uZh1wJh8HlvycYJrtcqLl/jFgzJtIV20XsdvMQ6b49RllDfOLifFs66vvjUzDmkXppuD3OyEuIvDzreMTaTfqJLX6iZ67+9VJOEOvFHvw2JkCd3EmXHBAY9AX8m5PgAxD+ypbj9Ntv9Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(86362001)(81166007)(36756003)(82740400003)(356005)(40480700001)(36860700001)(1076003)(26005)(2616005)(47076005)(426003)(2906002)(336012)(83380400001)(16526019)(478600001)(110136005)(8936002)(4326008)(8676002)(6636002)(316002)(5660300002)(41300700001)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:15:34.0631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7361dc79-df11-463c-84ff-08dbb81f6e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce amd-pstate preferred core.

check preferred core state:
$ cat /sys/devices/system/cpu/amd-pstate/prefcore

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 58 ++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..b729bc6dabd8 100644
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
 
@@ -385,6 +427,18 @@ control its functionality at the system level.  They are located in the
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
+        This attribute is read-only to check the state of preferred core.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

