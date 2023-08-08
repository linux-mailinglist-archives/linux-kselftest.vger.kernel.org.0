Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA8773B65
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHHPt5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHHPsA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 11:48:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C444AD;
        Tue,  8 Aug 2023 08:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg1MKg0iKK+6bi20LWtb/XW6Z3q5VVuiZbf/EhBS1l03tN+CRIeIAA2TuoVkswnuKj9LN3md8yCXqdVCysts/XCZyPrBQUYJPXYkaDEjHLWOOvBwQCqu6fuEBh9rjJ6mWSNtxOgRiA8S6GPm3PNsK5lJW67LhcOt6mA+n/0wZ39upasMSereG+3FVqGh6xgqhORNLRxtz3MCRQcDOE02d1QXqCWYFDoWu2wlefJxC2pYZDfpyzhDYUQSIIV8F2nx3ZAHdNnV+QvEuQ6NPWBSKlrsGKHuSKa7m8U9VKkdFGVnDq7TvTK9/ZBisLeKzK71ObhadJxXgN2HO7ecInZdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbJA0k0zgg8v1ItiAmZQ/Mnfwpi7dvAXloPxR/Tl+HI=;
 b=Tz9c3wpipiF95r8lG42rsMayXLQxhI4L4G1EQ0OkoquEvoE6CcObrq2oTwzhSr6OR8egp16zEHNSw+blA9EGZXJKRrqJ8Djuy1E82f5TSzXlzvAJwB/70xND1lFKLn8XU/cdSjWSE05QZx05IpRSfNx9C13o8GDqcn8u6hejWFf53fGByB+fJsOWS2l77wYPzYNrWND2x+CycU+4en9sXUJ89TsTbfxftjxwijc+HA1tLq+EbG96oy9kQZPgT/BtuVNrzReSpS5n9LhG4HLlcRL+TTf1AMgkDddvO9k/8S4lRkA1Nrq0JNvbdD7EmN3EKM7jisxW2uu0xT39f7xMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbJA0k0zgg8v1ItiAmZQ/Mnfwpi7dvAXloPxR/Tl+HI=;
 b=FX6ZGq3E/pUs6ONniob+v7wRMpOCY5EqxZd4UfDGsHQqf1IlH/jdR+UnyW/82vyaI0E13vOiaP/7bkAo30n29V2JwOCP70LoKbLeweXkas7+iLO0ClLYuiPdlmMR4tiVjP6+xPD5/9phKXDoyd7/vpRF6JJGrFTDj1n0dZ5dlZg=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:11:37 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::e6) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 08:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 08:11:37 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:11:14 -0500
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
Subject: [PATCH V1 5/6] Documentation: amd-pstate: introduce AMD Pstate Preferred Core
Date:   Tue, 8 Aug 2023 16:10:00 +0800
Message-ID: <20230808081001.2215240-6-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808081001.2215240-1-li.meng@amd.com>
References: <20230808081001.2215240-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a7daef-589a-476c-cb13-08db97e7169d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWb6XxjF625mNZLRF3t+HUs8Isfb387RRx8nm8QYO1UxjzusdxVMrp4AfLpKy9EPOIPsf8oVQvO3ZRV8ZXsenLY+DkW3BtLigx4H3Bz4/5a2npCeIJJDFgmIRxwfcdCHlo4e1xRkniclgmiUZvF72sR1HTzOfPC7rMGKSiJgjuvLWI8H+hWMc9AXUbpD9gqqbfmEMqCKIHWEQgqL1JgAQWH7CGtaLi/a5LAFhtc6qXmSNv64dxcn0+z3LuT5YlZuQKnvDyae3u0It8GLpD/x2RDphz8XTR4Ogol9/UG5UV0MMAJLLEnv0umbOpoUVm4Tjag1iv4iUjKOP0F8/t7TJ/nn2JqfWnN5Ak6xyskUuusuPnC2NnK/xSRZG/HuLO2ALagJgOH5uAs1QvU9pHIir/MsztwIZctuzniNqBDYYgTzTGe1Nfg1tB67GuWetrtG4X25aCSc+V3qJqumPNTQQ/gjTjyrtdG3tx8/pa3n8CVBzPGZ99ZU62T9do8bwMeDELisHRPAVR0DfbA1dziCQwPGiG8stx8wcFjwYAYajzAV3LGdmjM+PZfQAhrZnk8WVaBtOxa+OdQyfaRzS6p4FHyP9QrhJmICpmaSwEsM56mc7xs3SqaAa/8ozB2t3E5M260MBTM92JuJvssEbK1LaHzi7TBR525Ovg4vGUpvY+NcbujCADq/x3XZGqSRnrg/Ey9M8NvmINe9OOZSAcxdb1mSPQjDSpvEBbLfJncErzw2DHrOejXv3g2S3bJiVw/oPTm+9GRywka9TM1X9XtnTVLwVUoN3ZQoADlaeg1r9u0nWHXzaaVTUzR5t82cSA6OQ9rYUnixnkiMaJZSVMi5lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(90021799007)(82310400008)(1800799003)(186006)(451199021)(90011799007)(46966006)(36840700001)(40470700004)(426003)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(8676002)(36860700001)(47076005)(8936002)(16526019)(40460700003)(2616005)(40480700001)(336012)(81166007)(478600001)(316002)(7696005)(356005)(54906003)(70206006)(110136005)(70586007)(82740400003)(6666004)(6636002)(86362001)(4326008)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:11:37.4174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a7daef-589a-476c-cb13-08db97e7169d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce AMD Pstate Preferred Core.

check preferred core state:
$ cat /sys/devices/system/cpu/amd-pstate/prefcore_state

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 55 +++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..4a30cf235425 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -353,6 +353,49 @@ is activated.  In this mode, driver requests minimum and maximum performance
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
+``AMD Pstate Preferred Core`` use ITMT arch provides functions and data structures
+for enabling the scheduler to favor scheduling on cores can be get a higher frequency
+with lower voltage under preferred core. And it has the ability to dynamically
+change the preferred core based on the workload and platform conditions and
+accounting for thermals and aging.
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
+Default disable ``AMD Pstate Preferred Core``.
+
+``amd_prefcore=enable``
+
+If ``amd_prefcore=enable`` is passed to kernel command line option
+then enable ``AMD Pstate Preferred Core`` if the processor and power
+firmware can support preferred core feature.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
@@ -385,6 +428,18 @@ control its functionality at the system level.  They are located in the
         to the operation mode represented by that string - or to be
         unregistered in the "disable" case.
 
+``prefcore_state``
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

