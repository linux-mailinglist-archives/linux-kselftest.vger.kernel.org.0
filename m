Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A819798381
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 09:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242483AbjIHHsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjIHHso (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 03:48:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C762114;
        Fri,  8 Sep 2023 00:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm6PWvx5bkeKRO/qMn4hx942vYS/kmmvJvWB0NasK+cPBQEAoNFS923cTu2o9KUd74HUGTUfNrsu59Quli97wUt+2zpDByBpuPNMAe571gg0OC5gjrZ+DNE3g8Mw/Y5/CBnvWyKZ7OJYmXBxpu4DXlZ1YNFMV+sft+YW9iQi2/KT1Esh3o+nGZtED+tNF3xE/wyqu5WagAPBMFW3tKN0EgrQDlauOo5rWu0bvQGEyOf2ZZ3nXQkGKWu7Av3rmuiplVu2qphZwJRetuKE4piE9hovfxYXWfBeoyNEHuMcMLxUJrPiuIzmfbpi7gw92AI3XvE4JHI/sds/2sP/ieeuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10b6i1hYViwjRtxPhP2360wO3wPsW6x4KN8SUUgV9KU=;
 b=eA4GwC25aOjF6LAbRxIcPxciaaOaGvd3GxaQv4Pw1YXu0bzR4yUg1Bf5R5zAcCfhrrJfBJ32Fj74u0KZgm0Gj7mieF32T1sSapfzIXx3JTSXKR4eW/3OPhdSTK2pOFj9AI+UVGb+2Wxmmthhfmn3ciUu75oOJxkhYAeIUY9iqcce/whFAADFNIEU3o7RkXlrGIoXKgfWbvBWSZOTFiL7F5GPn5AK+jb4EjkCU8fitBj1I+jUwRbSm3E9CJrmysj1mOUlqs9+6mexEbFNc0OT+YmPz5cBll+wr79aIuwLx2smOwvEdVPue1KdAZFgHYSSJCekcVwe05xXid3Kq4JcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10b6i1hYViwjRtxPhP2360wO3wPsW6x4KN8SUUgV9KU=;
 b=plH5InRKm8EgiFUDnaJgZmSou/RK9GijT1Wl2gOJjmRUX9hCLhjTUuPzcjjr/PNFjIWC1HhtcsO4/yMPiUMAzJYSVnvh0hvx9fvyrVJH7frwwPLpZFr46qb/DmDyIyxqvpcrHHzL1JlXtuB6uF02PHB/9OtUEZR4ql6NWwC5L0s=
Received: from MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 07:48:03 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::6a) by MW3PR05CA0017.outlook.office365.com
 (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Fri, 8 Sep 2023 07:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Fri, 8 Sep 2023 07:48:03 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 02:47:59 -0500
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
Subject: [PATCH V6 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date:   Fri, 8 Sep 2023 15:46:52 +0800
Message-ID: <20230908074653.2799055-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908074653.2799055-1-li.meng@amd.com>
References: <20230908074653.2799055-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f5bd56-b4f6-4972-a604-08dbb03feead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0a0n9L5Ke0oxVVje9azBwqkLNl7jz0RGXW3aFUTDgGPMHZKX5EXz32PN8V65HAoWI7hriZ1XdtoQrOmZdBl9YZckjtjfdrN1Q7BXYjbxXXcImtG9ikg39Jcg74uzE0/h+NVkx3DDxAQv33uTC5FTnwFDa8kkvI3nftPdBi9g0OQf4wY7y/FqqO0w3O3IqR4oDFFEk0iqOrutiIwFlL6tdzSJ94CZRkLCXOCQy6AG2lGKNHeO4BGdjnyFMBcg6KeJ0GMqTQIhTE/RbDKci9vawq3sFZje2XabfiM6KzED9tls8ak9NFoyiznDaGvOl260BGvFQygdoKPxgTEay+U11FnpjUa44rxU0dzg33JcpdGqPQzr5bQZjr3ZDLvijtzUvrg20e0fyTB8+T6U8adVq4XJekwdliLPaVKxUA7kml00tRr28msK7C8uTLz0VLwM4DSl1eLAEpcPkZicVLDtzN3R16r6SfjeDTEJ0QM5TWzJQ/BAQnIa16PZCG6GULe0t3hSISJd2o0+PsnuvWvDMhcLlddIrYxPx9fe/P1+vrv8BCgbrgF6FL88RjjJpeevWzpddnRMCaEuQNOtD587MJ3RN4mP8UImaaD7sumYBWoeD6eb37MmFqUwL99ItFbHrDDCBPKu45ssRfHOVJCklqGvg/kCwhVkhKZbQ4s6tNNZ3cdK8jxiYNNyfEve4Ba8rGilpX+eo0CnlV02HOjjExsgOANECFRRz9YZZ/U57R3tO1S4/Rx7/3PyJsMZEkkYtI0rS9A95ZRgtBlVmaorg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(7696005)(40460700003)(41300700001)(316002)(81166007)(82740400003)(36756003)(2906002)(478600001)(86362001)(356005)(110136005)(70206006)(54906003)(70586007)(6636002)(6666004)(40480700001)(83380400001)(2616005)(5660300002)(1076003)(47076005)(8936002)(4326008)(8676002)(16526019)(26005)(426003)(336012)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:48:03.5436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f5bd56-b4f6-4972-a604-08dbb03feead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
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

