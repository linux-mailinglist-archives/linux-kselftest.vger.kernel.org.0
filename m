Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8A77C798
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 08:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjHOGQt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 02:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjHOGQk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 02:16:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC7513E;
        Mon, 14 Aug 2023 23:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Reg6xABXAkhslzg4MscyaovEkUE+LgV49FbedpyL0HK2qII8Ny0f+wvvUbjV8ZfdiJsXcaQlj0Ou1pSF7LM4KWcgExFRIikxf7Hvf+/5NQIpUXvZpJ3817Bp0huRKZKN3w6bjl3NUwmOEM55WNWw/huaITeUt57Uq9x8H91AzQivGtl2wJKlaM50X2f19g6K2fZ2Z38TpANFD3lu0Q1LcAU91tSxqaHohaBLQXY1FJc0d4pj4VS0ukrv89YfnZVjsV1cZVKtvF7bW7acWoeO43Vw6lNnby7p59vH1jmkDvYrKb5GOgDznNLsPhmyf9JYOUbMxdWkYajY7f2VaH0voQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFDn6jp+E1OfjmJLdn866JLVFhZZ4KpifA7cfk25OJ4=;
 b=eVq9Af0IMWrWC4jfW4yizJiI2Rq2kJjyJSVmKyUP80XMetV77XYa/zY6DsJ1wCOT0u1uuPtAsGFnnZbesKZIiyEYvALqfePaQ1FTskhEclZ35NRdftIwlQDKCipFeraZLEEva4ig7cM0EHYNEA82XimzQFVUlpEnTu85bgtuJIIzAOkNs1a2LigsJxMRlA0VuGulJTJdGpfLg1UioE4Zp5tqQm8mAHZ1HDi8lXJITf7mDnmVabN260LrVOXYwNVVhvhwYk7G3+R4xp+CB7PF9WcdniIq4nDmfQPEj7p6lr4Ktq3ykAfNQgaF8wicnQFVbhVgPnqEQCeBGbqbRl2pNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFDn6jp+E1OfjmJLdn866JLVFhZZ4KpifA7cfk25OJ4=;
 b=DmuKpQv/Wdq6A+MeK1TxXUQEevuEiJmnYZOIybmZmVKgnCgEsjcPzyGiMI/F0knjtsbuQwYOPggk0JcvWKALZNuZ1VUyye8sVfznlUMlIaeEwvhvSjTeKojEGHTO2s68wSG2z7slzfzsvfKWQpAmGYf0tGvhoi2wA2VDlmTQucc=
Received: from SA0PR11CA0142.namprd11.prod.outlook.com (2603:10b6:806:131::27)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:16:34 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::33) by SA0PR11CA0142.outlook.office365.com
 (2603:10b6:806:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 06:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.13 via Frontend Transport; Tue, 15 Aug 2023 06:16:33 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 01:16:28 -0500
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
Subject: [PATCH V2 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Tue, 15 Aug 2023 14:15:41 +0800
Message-ID: <20230815061546.3556083-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815061546.3556083-1-li.meng@amd.com>
References: <20230815061546.3556083-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: dab7208b-421f-41d9-e724-08db9d572c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaySYEuvZYHnHhX8e8XYH0ysoUzCLRlRFuHM1qJOvpoF62XhFlSTOcMOANOC1noYL1Y01Tisjv3idiCQ99Az5bwiUoM86c9+Nor+M7LN7l+aRcpFQ4PW5JVXXt66EbdoqU7PRgHEYb6c9ClOfRY2UkjROJaCVtcGaulVqsPtT1Tzo3gxEbdRG/uGjPC8gHrHgo58AFaWduDnK1+g/MSyVEl3pLtDKLwA17bTksYzTDA7n/WWELtqnWrEjos7NyPPLG0vkjLM+btXnJrZc7R8sPrHJqX0n09/ixDWED4qsoZz0NHvAm21OVolZzVTagXU74SRChSPCcd+wroPHi+TQiK6ya3L0LtrRcGF7nKyJDZXTC5l/G5s7RMtD0CTkTZxotRf5f15x5HJm+8okddzNp/2rYim6gViNAOgaVNkvvoe2TKEHC2QoBv7anJLrzHZKBSz2I4eex/gLMkMY3TkJb3gqSDQWflrkzAROtD4kA0T5BUEVra2wOZwJWFTDf7hGKHFKLSWhH+7NHMEa+tI1Qk/JLZvX8erAunQLO3q9jFCfDV4rdrFIQgIyHaf8S8dWnTaYpmU/zfvwNx9kBA9/HqxTfsXJBjDgQV6nBkU96eLbqOIWbEFmSMXZbDA4b7JtQ2JqoSIf3LI0g531b7Q/UVMezOvRdkGXm9OGtmacGJn+luzBIJVjC65tR7zW3iDYRG/1jzp/C2V/HMxM4XtL/U58FLCVdgc48Oj/hOERX87NrU1wvShowE5cUO3sFxJJx5JlGoL2gwym1bXXisZtf5iYGk5uQCmFE5nEO5tyoE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(186006)(1800799006)(36840700001)(46966006)(40470700004)(40460700003)(336012)(426003)(16526019)(1076003)(26005)(2616005)(36860700001)(47076005)(7696005)(41300700001)(54906003)(70206006)(70586007)(2906002)(316002)(6636002)(5660300002)(8936002)(8676002)(4326008)(478600001)(6666004)(966005)(110136005)(40480700001)(81166007)(356005)(82740400003)(86362001)(36756003)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:16:33.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab7208b-421f-41d9-e724-08db9d572c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

