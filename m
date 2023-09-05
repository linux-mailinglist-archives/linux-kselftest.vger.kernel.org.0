Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80D4792639
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbjIEQHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245106AbjIEBwG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 21:52:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F2CC6;
        Mon,  4 Sep 2023 18:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTrjf0oqiMFjZpZ6c+jnsJagu1o/fY7Iy7JutLeQlq/Hyb+8xNeJWtGFbkM6iWiN2+ZYWm2/vquLqtzlww4uUXce/2sSr8oo0WuEjL5EExK8ww1OoGjWCF6nidSuBiQgXRh2BrYZnzuiPg6IEA5HwKimghBbKFgT6/o9ifri8G0vnOMrHefvgJ0ZA1ivjQchgyWkZ7BZtMVbf1Ag2fAmOdDBvHqeKvrnidZje5puVeDtMyvaB2w1fhER1J4B4XQsrpgEHpMBUA6ZBofxdkvucJ4KaPZNf3987jBKMMKGLB3A5YGXfHIIbGjesoPj7ZyWd6GLeelaY41tEuwAPmlRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws2yf4YYsM18t4BNSIPeY2jo1PNGYVhD5jWIe4u2ENI=;
 b=jjwXHO8IuKcs7xnPNHAojVEJhXrJ9yyN3avhGRwl+/p8Q8CWrc+y+dm8e8jfJ1zRw0KR+ubYyX+nyLOE3ZaAu2tl9O8nt/DNvrjfScfkRMfI/vilynKjp3yFUtny0slLagkYk3EyFVKZJn4FPcZWh8d4zhIOEuRgzyu9Vr4mU0fvXWOVCsaA18Cpx+LnI2r0VcB76VXsa4HEB+uI+Bo2aJWIIlQc9w+Q+z1m6rZ4KYaKnqv09aFbtIAr2v1EjcnbxlKXcVdTMVLgibJlJHsuTeJLuEDN7Ze8TFQoIWiNT7R5T9YYB+2LBaezW8bCCVzmeGviO5LwzTWOA2deIKjSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws2yf4YYsM18t4BNSIPeY2jo1PNGYVhD5jWIe4u2ENI=;
 b=Eh3uai1HrJCHy90FgJH0LuabRvYhIl8Mlgi1sT0bHAzpKB+/5Aja6w0CpTnhZ3Jw/W/BubRu71nW5TIcjHFrtFg9CUJV+8ZH9E4Y5tbRkxH3jsnwfHY+RcTpE73bWURXaOo7SQ2Cm2M3etkQhiJ3uzDzEj5hW1d0mnnrelRtkx8=
Received: from DS7PR03CA0187.namprd03.prod.outlook.com (2603:10b6:5:3b6::12)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 01:51:57 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::9) by DS7PR03CA0187.outlook.office365.com
 (2603:10b6:5:3b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 01:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 01:51:57 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 20:51:52 -0500
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
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V5 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Tue, 5 Sep 2023 09:51:11 +0800
Message-ID: <20230905015116.2268926-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905015116.2268926-1-li.meng@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6848bc-7f2c-4300-c552-08dbadb2b031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcYr3VaIOjM1Zi7R6CUufjJGsJ5TZ85JqXXMxfoWBYv/Xh+hqjzaFuMCyC8ZDZsTJWX48wJw1gnQASbSe2JCIauln3VLnyEDhhd0XtwB3KryHa4DoOBSPTWlJTCkYwA5lgg5ZDU0bzf4PVtZ4om2vzg7wPqx/vkfRHiaXS6IUkwqU7Xjegbd5IZNJB3uoeiGt/tb+U0xVT/s3Hpa80sfHMF5KnYVyimuOm0zHiv0mFXesNm9+qrjRcF1qvgwni/C2K2xhWy9esRGpXtar1PwzaceI8SUn9OespmEzdE52VwFvfWXnUZrBa9JEjOIlgfn1AXYypV7YN9GjQ+WPoKYBfZMkK3Xp0vHe3J+BOOil72PAaEHXPx3bSC/YMQcvGj9/sfSeox8YnzN3r1YO+w/4Y3o7ri/BDZR2pPBGPnxdyOz7SIpX4bELAQJKzL4h4vx24oYKzEFgryCqq9K3dMuUS2jwMTb/s1FR1+/KSFrAMMWWUfz7Vl2dHwp169EHdqexH5CNsgjyzau70n2LN+BKDcqKPZ196Nzp7NRek8i96gFGb/Egn1C5K3tXEmoeC4izMcrDIV1xW0cz5a6QuqW65Kv5jTij84aZvetljPlyKtR2DV6LlcyZQ3g1cSLuJLyRzlXg1TdhoYpskk2hSmOfo6k737nKYESaurXNiNab7OUhu+CXHEP+2qg3jF7irISp7nhqxDGMcEWJLRNVDQA1k9DQpXmNkoVLXoRoBIj5Q0VFyEYw4lh5eYJhJvCJFW4aXZKZdwYnfmpUXIGh7xHpUr92hDMar94JXVU3PMTq0g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(70206006)(316002)(6636002)(36756003)(110136005)(54906003)(86362001)(70586007)(2906002)(40480700001)(8936002)(5660300002)(8676002)(4326008)(40460700003)(41300700001)(1076003)(36860700001)(336012)(2616005)(426003)(16526019)(47076005)(26005)(966005)(478600001)(81166007)(356005)(82740400003)(7696005)(6666004)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:51:57.3799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6848bc-7f2c-4300-c552-08dbadb2b031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#cpc-continuous-performance-control
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

