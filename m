Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2943361E828
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 02:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiKGBMC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Nov 2022 20:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiKGBL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Nov 2022 20:11:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B8CE38;
        Sun,  6 Nov 2022 17:11:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODZ+hv65q8ZAg1fv4B3JtdbnrGQVbmsSdJPEDDz4/93CmGnhONwS8Z9cRKO3J5Ygr9BjDAA45i+HfWK/iOEmsb55bPu0RYd/3xoXrQ6cYJIzkP+dX05NmXkIyWyoNRxJARlbQunx0HmL13s1S2A2jtfHicm+i7Db+T+svtSc14Tsr3k3Y9CeZ7ODuKLFaqhTQcUkMTMyF7FeuJSiHXKiKSB0aCWZ2LLtdOEF56ECl/h0gj0spLVvtmKNn8xtdaPsh41luyd01Oeqj3t+nt59NJjO4Nog9kBk3oZFgPV+R9Z1TFrvh+hHgKI9KjkHNLAguMii6KxOK9Sx7NtFMD8zIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yeAbtMZB4RTWAW8Xo4yyHYHNQG87gd44WNzdLH8uZM=;
 b=KqW04HpLphTekIFCygtWl6h7/W2+fbSg2xfBRn9IpBW+mBEzhSjR4m+WUlyHu+M04Bv86joYsSSvX2irpeBm2cHOuqd0VaQfBgfeO5KA3KFzdC+oFwWQFzD36Q9GrUwhxG7XWS8VizvgJwMOz52RDKUcb+DvIuFs135dqdBRZ/bO/VVeLYAFwAD6jTjTVXjhhzB84SuFzLj9m02AslGG7OaYfQk1Y0Q+m91mT8XxGLpQZf0ayl81j+So45UXxHfnR8/5DNNrwUlQlUdiV+0pAYgzc04XIuSvsL/EAVV1/w/25V/QkAFjOTjQ10y0Diw1jPKg/Sp4ZT0IUda0LUjDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yeAbtMZB4RTWAW8Xo4yyHYHNQG87gd44WNzdLH8uZM=;
 b=tyFlo5oQMFxbO/oAI9KIKhT4DL6N8arBADaWkljGX2ynoeIPMFAQQZDMjQN/0y61pg7eBvj+UDT+QNWjkUG2tHZ2ZCyDXIVxj2xhSoMaXX6ym+PpuV29Nt7VGBa5ZfO4jWNOyTg8Lh/A4Axxa6FD5M9iuVf29RO6iH6graLH9Zk=
Received: from BN9PR03CA0313.namprd03.prod.outlook.com (2603:10b6:408:112::18)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 01:11:54 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::31) by BN9PR03CA0313.outlook.office365.com
 (2603:10b6:408:112::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 01:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Mon, 7 Nov 2022 01:11:53 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 6 Nov
 2022 19:11:50 -0600
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
Subject: [RESEND PATCH V2 2/2] Documentation: amd-pstate: Add speedometer test introduction
Date:   Mon, 7 Nov 2022 09:11:27 +0800
Message-ID: <20221107011127.1818705-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107011127.1818705-1-li.meng@amd.com>
References: <20221107011127.1818705-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|CH2PR12MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: c85780a6-4329-4c95-3ca9-08dac05d0ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8fjh4tOptWVvg9Ws9JFXUvdiHAfJY+OCFj7WZFYTwIivHOLJW8tWnxJnfU56G+wf68YUwVVHLfUahopTAaTsx3GY7A9XnOY64zTGVc6/Wv+kiwwZVd0gwf0+uDDWRfbnmM/3tSytHoAQW64krbDy3jVtfV0Ox1u2EEwV4WlldaDqPSayezz+Wg43a98vElavtE0EIjo0Hqlo7V6x4xlpNXQWSxjWsKqoGP/u3SiCnHfv/ZTrPWt9cKJNn0l2qmWOMHAtWZM90MI83AJZkYiOtO5mrTp5EQMeHuKyQWOJeOmnv+Ag15Bx34Za4rfVz2ob/CXdkREhvSoXDdomzp14Gby+cpgMBAW3BI/RJUUwhJnstgyUivaWaPkRg+6wi4pIMyCuld7QMhSzYtAKS0oWaCoTYYdrM8D9ymoJvVlm4JXnit1xz1WgHIhFIHjVSlOT9Fresa5MdMQGLFtD1HGOapTg99vOV7VA2bVhM12Fe8yFncTpdG9NLrE+ZgfNo2BZuV35r/uSEI89/uvMTHytL/p+XZXdOqwNn7pJo6ywa/mNADJ41Q1F1V+0ySiAm9D2OOzDoAD9AWJmwmO6RpBVzLlxVq1q3dsX+KUN3lgFzIcngzN1W6Kq4OiymtqgYn0RUII2T4Dd7s9uNuu9pKbuzMGQqD09vgmbenOInX5lKZCJ1WSrdBFsNxXGz+Rq3NpSJ1pbHVV+bJ0muyFR/KXhG71h3m6b58cqHmssmPHO5LVsiqFVlz9cyIokpxIdAUKujDtdMKsdxyMgrHKCgWdJhgMqsujYVywzhjx3ZrPdZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(70586007)(41300700001)(81166007)(4326008)(70206006)(8676002)(54906003)(110136005)(83380400001)(356005)(8936002)(478600001)(40480700001)(2906002)(316002)(5660300002)(36756003)(26005)(2616005)(336012)(16526019)(186003)(66574015)(47076005)(426003)(40460700003)(82740400003)(1076003)(36860700001)(86362001)(6666004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 01:11:53.9487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85780a6-4329-4c95-3ca9-08dac05d0ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
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
 Documentation/admin-guide/pm/amd-pstate.rst | 75 ++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 29c50e96eb95..0163d1231aa7 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -451,6 +451,23 @@ Unit Tests for amd-pstate
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
@@ -487,6 +504,8 @@ Unit Tests for amd-pstate
         $ sudo ./run.sh -t tbench -m acpi-cpufreq
         $ sudo ./run.sh -t gitsource
         $ sudo ./run.sh -t gitsource -m acpi-cpufreq
+        $ sudo ./run.sh -t speedometer
+        $ sudo ./run.sh -t speedometer -m acpi-cpufreq
         $ ./run.sh --help
         ./run.sh: illegal option -- -
         Usage: ./run.sh [OPTION...]
@@ -495,7 +514,8 @@ Unit Tests for amd-pstate
                 [-c <all: All testing,
                      basic: Basic testing,
                      tbench: Tbench testing,
-                     gitsource: Gitsource testing.>]
+                     gitsource: Gitsource testing,
+                     speedometer: Speedometer testing.>]
                 [-t <tbench time limit>]
                 [-p <tbench process number>]
                 [-l <loop times for tbench>]
@@ -621,6 +641,59 @@ Unit Tests for amd-pstate
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

