Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A907C7C1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 05:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJMDcW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 23:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjJMDcN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 23:32:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FADE0;
        Thu, 12 Oct 2023 20:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGnGP/PtfGm6QcYIxijXu2V3phFknXvA+BftHwIgCmPZCq8IoTCn8kCFlIVPHZGQ8w77a8feBaUvg3eeom2QsNkk1ud93bVZCNQAbg6Mr0wjlj0Ignn3qY3hdW/7WxMWWa0xvGpEz5bLYbRsfTMpc6phcfodv/8AgC/FwOD+CFzvO7i+xFhDdzcPie13poXxmH+SkxuhZ7qRI7tcsIHAjc052bb8yzmemb5A6CV6Ovb78bQSyQE3ediLDdB+C/S88EdN3OvQD4bwoakW5+0IXr9zb22tJmORBH54s+P6am8y66vdXj7+Ec9mIxuXggfynaH2cX4W6arHpeOcre//xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlF2WKiSUPyODRJ7ueMUccEPh7maCKY1Dj6+XRqyp7A=;
 b=VKLB4VHvYXjEdAmMr0xqiHFUa7q2gcMIsEyEWaWw9c1EGaPMdaPZbmYr7W5vp6d2ll3C/RFLO5tM6rX6EvZbIS7anoQA4Bf1UrHTfSemzkJdlurFydN4P9CGFqnc5cv0lHJgmcfRwJqwtZjUn8feUhb/2YUzk9ftKSNInqyvaka/qazyOn9fRV7E7rPlM5KIgaLSo7kPtoRUkE7q/IegNKoej8Iu9kjeDJtGVT3MSud2R97NLuulg4hUpQVusAvSgJZAL2P8UY/ZglgsFqxDi1B2wZDCsREOL3Jpqg1L33HVjLd7jXp7JuRPesNot+M4fmYt2U8dfzUZnNEFVLhy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlF2WKiSUPyODRJ7ueMUccEPh7maCKY1Dj6+XRqyp7A=;
 b=TABSuQf4nAarQsa+JRWAGy3jOfMzqNLcXC2v4NSeioTo3P+AsIMCYYOAMvm9x23Ih5UvbNPxviaLjyqRFa/ktxSsD0gCF2VJuRFqaBEqO1tcBWedfhLa5DtP85RdO1X7YS3BNfNHwuNPhruX+s2ngKFBKztvG9bWr+wsof2kLJw=
Received: from SJ0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:33b::29)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 03:32:06 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d0) by SJ0PR05CA0024.outlook.office365.com
 (2603:10b6:a03:33b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Fri, 13 Oct 2023 03:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 03:32:05 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 22:31:51 -0500
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
Subject: [RESEND PATCH V9 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Fri, 13 Oct 2023 11:31:13 +0800
Message-ID: <20231013033118.3759311-3-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4f7448-d263-435f-eb7c-08dbcb9cf92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aC+v3PdFnsJg513BsNyDyiR+fzv1FVxs+iDjlJn0hRSrDm7vEuUk1hqUmkmdtC/X7rvHC9zQQMMMS4zPSyChlaP53JFJ7nNZ6xBFNOOEhutzigjScU/v/oCVs2AzsMwk0BDPeJrldFzdAZx5hYfhpFzjtAcObWrzPYXy5clXPhBAru0F9cYrlgfCY0iEpDm4+RdYsh2XIb/R9DwIWSBcXfWB+Ads978aTSMDotCuqnZ8Ioa+IEV6PInPfBiFgdWPc7dZ5GhDJuPG4QcgmoktpOnwnKOXAIavkIOvZlV/YACd7s/ezVEY4Ttvd93yvWa/oH7pvN/+sMMay8NzgDWdg8fNvjQ4cuM4JqRDbrSg1phSyEgioIr/KZy9gWlk0kWelRROATTdPFovttkLbcUvg/z+oYC+GQJ893UGBluRonxwUkjqEoSPeVKQ3RXuy/+f5t6ar61R/trvbj2wq+TZ5QvY7dHa0r9ckVE5g9wcZpUuyR1i64q1AdUwvP8ACVGgbYN+gAeccxZxAStP9MtGN0Cf8oe8W9ViWV9GojMuT899xMtDyLIwAqDqbdy4Kegd1rU7wkV7ceTT7g2ysi6Y0gyOXDqzbiimSj++aUF5eEPFfWQw8gwceUf520aU14w0FD4eRqlfvgn+fls0qR26wo+HbE/NUiwlLr/EJ9dyDa7kD78gtOCsLRQJSJIB+7j1hkUPjdqzgiKrGHDemT+m4fMngosBXZSHExBmtrn0QlzBomAbVrJk0Q5ObqZcSN+uqpEadgKfiN26ImPUreWM9z18yyGIUfb+bjn/5dlH558=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(86362001)(82740400003)(36756003)(40460700003)(40480700001)(478600001)(2906002)(41300700001)(4326008)(966005)(7696005)(6666004)(7416002)(8676002)(8936002)(5660300002)(2616005)(426003)(1076003)(336012)(47076005)(70206006)(110136005)(70586007)(316002)(6636002)(16526019)(54906003)(26005)(36860700001)(356005)(81166007)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 03:32:05.7392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4f7448-d263-435f-eb7c-08dbcb9cf92b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for getting the highest performance to the
generic CPPC driver. This enables downstream drivers
such as amd-pstate to discover and use these values.

Please refer to the ACPI_Spec for details on continuous
performance control of CPPC.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#highest-performance
---
 drivers/acpi/cppc_acpi.c | 13 +++++++++++++
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7ff269a78c20..ad388a0e8484 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1154,6 +1154,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
 }
 
+/**
+ * cppc_get_highest_perf - Get the highest performance register value.
+ * @cpunum: CPU from which to get highest performance.
+ * @highest_perf: Return address.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
+{
+	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
+
 /**
  * cppc_get_epp_perf - Get the epp register value.
  * @cpunum: CPU from which to get epp preference value.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 6126c977ece0..c0b69ffe7bdb 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -139,6 +139,7 @@ struct cppc_cpudata {
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
+extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
@@ -165,6 +166,10 @@ static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
+{
+	return -ENOTSUPP;
+}
 static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
 	return -ENOTSUPP;
-- 
2.34.1

