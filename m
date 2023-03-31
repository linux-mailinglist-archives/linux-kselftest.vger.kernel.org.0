Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF546D19CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCaI1q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjCaI1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:27:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699CF18809;
        Fri, 31 Mar 2023 01:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmoH61vO8hLf5hO9vi3iVpNoLUCcOIHAlMW2qjcHf+95EoV09fWxxwJJvQxtgFtBD83QUEObKV18StfHUCEAIxt923Z6R9J0YkRzvklyZ7fsjPZIJTbfVK7Hh3AE/RH92WvKTu3XE+oCosJYvrnX7OFSKzolYNEGfbix+hSG50XFCmvVRi6RASoCQCag4sXRsEgoxXssOqnghm5Hu4a0ha1hvgRi+mt+pRXbW7nUHWh1Qo70R8au+wEoSN0LmJ152jZHcoe61B3iPFask9a0XDRfhkjGGXD5g0Asf1QjO2SMt3z6JohUfcFQtVS++P59CGLUqTpVKAMG8W/NvKInjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJuzzUGNVlcJ2WGAlAfgfIYFgZzZy/JuVBhhxTB2PDY=;
 b=gD5e7anMalBtQPITaUNi7p/bHrC9pQGk32/VszQL97jQicWcXtFCzGGjX/wORZjyJ/wCZCNgGEaDkpJ+6Ik9V9/gVwF5lZLJvdfARvfKSRGURHhHjrv9xuTOX2O7E6ImBuQbcHIuxob223hGdNUw9eeTytkX7FiN1UF0M4bEZ88Qbz3HE1E2S24OzNyNavgfrt+eUI5UyaxdQQNAZJ1222mTS4gZza10cQRjMUKS1mljcVMwkwP2TvpKxlhdJRblD/Loj3Qc/+XsHwBquLqbQtzECin9Kvw3J3yP+35nZ5j4iQQ5Y7+58oeZVf39YIahh8+nsKueQJr8u3YUAohS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJuzzUGNVlcJ2WGAlAfgfIYFgZzZy/JuVBhhxTB2PDY=;
 b=ZcuEqLkyCBa1SZ3C+4ymH3MPM4U/94rPclvRZdAY043865vpBXVXxYBeLlF2b2ag6NLnYRUu3XD+1zZll87l68G+71fliDoWMVJCy+dqUF8gNH767of/8iztGTCk9bbTNEM/wCznIvNSfRi1YNA7MW5Tg+VbnrU6mafMGjb9JiI=
Received: from BLAPR03CA0178.namprd03.prod.outlook.com (2603:10b6:208:32f::32)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 08:27:38 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::e3) by BLAPR03CA0178.outlook.office365.com
 (2603:10b6:208:32f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 08:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.35 via Frontend Transport; Fri, 31 Mar 2023 08:27:37 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 03:27:33 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>,
        <linux-kselftest@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V3 2/2] Documentation: amd-pstate: Add speedometer test introduction
Date:   Fri, 31 Mar 2023 16:26:59 +0800
Message-ID: <20230331082659.1887946-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331082659.1887946-1-li.meng@amd.com>
References: <20230331082659.1887946-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef0f9f3-bd12-44b5-3e0b-08db31c1c942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AVK7pHSgahDYnSUnaS7DFe78h4G6Jkk2MZOpNSSqjot3qlnlYDfSftdYRnJvjRuWh4oFjAhuAp1Hl0aCOhr51ovUMbUQ2p70kpBOPvE51NJrabVSLdM3wIlnJJpFnMbCRcCHt8W2yQYsP9RZ3aSsNi9lSejcpV2HI/WHWSO5QK9HbUWviM0d/lV0RrprIt4EHRNi8tFoplNgDwecmqKg3nPd7U+CpsgWDt5Gr3pfDTcynlv9EcsCWnV8A5Hh8sf4PWAd3i742KHd43bYZtGESLEovQ0vG3X7eIFvb5F43cHdjLDpZnqcbYoZiN3CquDpkYDpZP/pZLhn8oCdQ9j8F1jfrAn1WA+gOgGMNcZdoGqjtCiF1/kKBGSryEFBL+EcX1EeOtefKeRxECGOdbCbK7f8xB7SkH01JsvwXeXer6JccDwteIVoF32yOGlraf0R5J6EgHuQTSE0opPAxAFOjBZBdmK2X6pzv1uRUaUqJh9jOmgC5u6iWAlo5LrNhhl0Vfrj5nHAkeuBu5MvqV1jYF3VjHlOyHBlkRlw38wGQXr6RhuqaWtpmo0Jvf7TbQT/O55ly/cXvkIwnZW/55fGum5X3KthY//e4ch/w3BElf1D3XndIUAj+iFEnsTcjDVI9zeR77hGdJbgv12w5FgA5R1hAQK39ClT0y2NUmXMelIe7nKrZom4ozAicTtYw6vO4fOA16NRLWV1nW/jv10qPwgPiCkQeUZW8JIqF/DLpw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(110136005)(478600001)(7696005)(86362001)(83380400001)(4326008)(70206006)(54906003)(6666004)(41300700001)(316002)(70586007)(5660300002)(82310400005)(2616005)(82740400003)(40480700001)(8936002)(8676002)(81166007)(36860700001)(16526019)(356005)(1076003)(186003)(47076005)(66574015)(336012)(426003)(26005)(2906002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:27:37.7599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef0f9f3-bd12-44b5-3e0b-08db31c1c942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce speedometer test cases design and implementation.
Monitor cpus changes about performance and power consumption etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 88 +++++++++++++++++++--
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 6e5298b521b1..d0158128a0a3 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -517,6 +517,23 @@ Unit Tests for amd-pstate
         The specified governor is ondemand or schedutil.
         Gitsource can also be tested on the ``acpi-cpufreq`` kernel driver for comparison.
 
+    4). Speedometer test
+
+        Test and monitor the cpu changes when running speedometer benchmark under the specified governor.
+        These changes include desire performance, frequency, load, time, energy etc.
+        The specified governor is ondemand or schedutil.
+        Speedometer can also be tested on the ``acpi-cpufreq`` kernel driver for comparison.
+
+#. Preparations before tests
+
+    1). Speedometer
+
+     + Python version 3.0.x or higher
+     + Install chromium-browser
+     + Install chromium-chromedriver
+     + Install selenium on the client
+     + Install selenium-server on the server
+
 #. How to execute the tests
 
    We use test module in the kselftest frameworks to implement it.
@@ -536,7 +553,7 @@ Unit Tests for amd-pstate
         + make perf ::
 
             $ cd tools/perf/
-            $ make
+            $ make && make install
 
 
     2). Installation & Steps ::
@@ -548,11 +565,14 @@ Unit Tests for amd-pstate
     3). Specified test case ::
 
         $ cd ~/kselftest/amd-pstate
-        $ sudo ./run.sh -t basic
-        $ sudo ./run.sh -t tbench
-        $ sudo ./run.sh -t tbench -m acpi-cpufreq
-        $ sudo ./run.sh -t gitsource
-        $ sudo ./run.sh -t gitsource -m acpi-cpufreq
+        $ sudo ./run.sh -c basic
+        $ sudo ./run.sh -c tbench
+        $ sudo ./run.sh -c tbench -m acpi-cpufreq
+        $ sudo ./run.sh -c gitsource
+        $ sudo ./run.sh -c gitsource -m acpi-cpufreq
+        $ ./selenium_server.sh
+        $ sudo ./run.sh -c speedometer
+        $ sudo ./run.sh -c speedometer -m acpi-cpufreq
         $ ./run.sh --help
         ./run.sh: illegal option -- -
         Usage: ./run.sh [OPTION...]
@@ -561,7 +581,8 @@ Unit Tests for amd-pstate
                 [-c <all: All testing,
                      basic: Basic testing,
                      tbench: Tbench testing,
-                     gitsource: Gitsource testing.>]
+                     gitsource: Gitsource testing,
+                     speedometer: Speedometer testing.>]
                 [-t <tbench time limit>]
                 [-p <tbench process number>]
                 [-l <loop times for tbench>]
@@ -687,6 +708,59 @@ Unit Tests for amd-pstate
          + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | 2.1115      | 4.2873  | -4.1110              |
          +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
 
+        + speedometer
+
+         When you finish test, you will get selftest.speedometer.csv and png images.
+         The selftest.speedometer.csv file contains the raw data and the drop of the comparative test.
+         The png images shows the goal, time, energy and performan per watt of each test.
+         Open selftest.speedometer.csv :
+
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + Governor                                        | Round        | Des-perf | Freq     | Load     | Goal        | Time        | Energy  | Performance Per Watt |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + Unit                                            |              |          | GHz      |          | Runs/Minute | s           | J       | Runs/w               |
+         +=================================================+==============+==========+==========+==========+=============+=============+=========+======================+
+         + acpi-cpufreq-ondemand                           | 1            |          |          |          | 209         | 51          | 731.84  | 0.2427               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 2            |          |          |          | 205         | 51          | 759.03  | 0.2295               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 3            |          |          |          | 206         | 51          | 755.15  | 0.2318               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | Average      |          |          |          | 206.667     | 51          | 748.673 | 0.2346               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 1            |          |          |          | 206         | 56          | 775.08  | 0.248                |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 2            |          |          |          | 204         | 51          | 762.06  | 0.2275               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 3            |          |          |          | 207         | 56          | 776.35  | 0.2488               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | Average      |          |          |          | 205.667     | 54.3333     | 771.163 | 0.2415               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 1            | 24.7974  | 1.73142  | 7.71728  | 195         | 64          | 756.6   | 0.2749               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 2            | 26.1653  | 1.91492  | 8.5525   | 195         | 51          | 705.67  | 0.2348               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 3            | 24.1789  | 1.69516  | 7.41152  | 196         | 65          | 758.98  | 0.2797               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | Average      | 25.0472  | 1.7805   | 7.89377  | 195.333     | 60          | 740.417 | 0.2638               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 1            | 67.0214  | 2.76691  | 17.1314  | 197         | 51          | 737.52  | 0.227                |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 2            | 64.3032  | 2.75981  | 16.1196  | 198         | 55          | 763.57  | 0.2376               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 3            | 65.5175  | 2.59423  | 17.0067  | 201         | 51          | 735.96  | 0.2321               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | Average      | 65.614   | 2.70698  | 16.7526  | 198.667     | 52.3333     | 745.683 | 0.2323               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |          |          | -0.4838     | 6.5358      | 3.0039  | 2.9411               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) | 161.9614 | 52.0348  | 112.2255 | 1.7068      | -12.7778    | 0.7112  | -11.9408             |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |          |          | -5.4841     | 17.647      | -1.1027 | 12.4467              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | -3.4035     | -3.6809     | -3.3041 | -3.8095              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+
 Reference
 ===========
 
-- 
2.34.1

