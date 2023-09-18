Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206F7A445D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 10:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjIRIQx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbjIRIQV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 04:16:21 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129A911C;
        Mon, 18 Sep 2023 01:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqyb0Sj1nAcfPOrsqovhP4IodarT/c79NSWlbC9djnYaQI4bXW+98WkN/lP7QThr6SsgyhOH2tEWwLVYXPtYd8jQl09dkAPlLee4ZLpPdWS/yWJ0QhIHGEupMekgZiXY1sXCI6eFoMJn/0f1hAxC0MdBB6CAtWS6ZA5R9bE5nbiT0cxWTmK67JLr8XXMSHd7vIXAN8WlTVJT6EYo2p/lUAdXRvliDBFo1EN8AYmaB5ZEqkoRo7kVtuc1nxLj76WKmTxqWzKgVu7bWqD4ogEeuGKITnAOPsMC3wOzTaapQjMtRGehJzfFIlUX60nGoTiNOaFYgqaq3tMnYR/4gql8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68m3Wjq9q0JUFz/4fisPuF3cAg7UniP1UxVS6p0LUCI=;
 b=Y4VRGnjJPOBt5VnG2sJMxr3YAfsBZUSGZZRy2lO+za1tIb5KzBb2/rh0qCpePpDx4UOKkmANRw3em18GY8UsoH28wxNi84CAecNZJk15D/L0EjS4IPGemTqGCOVExpHcSwKHHT6eXWdOsTLavZii2olFwQg4CXHNAewovlF02pQEdbMEwgQD3iafWLlCG6hy2fY1zzqH64JBmKQhCGf+cPZYG2swgCd3r81V003XKqcP8GGVDwPJNjPDHDdyShTQBwloTHipGr2bBRru3/buP1bRryGHX1PEYaK3KIIEV0tD78blkq6gLyU3HbSKKuePsyHpqH0vo2p4WLqhTvD65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68m3Wjq9q0JUFz/4fisPuF3cAg7UniP1UxVS6p0LUCI=;
 b=yAM9NRHZAXNwEpGVnd7ssucZlIYIHG36qGOuXYoUpxm0EUYcNM5Nz/Llr5b2fauvS5hw3mmFMgpodoUCBxCq3pXYbSVhv4nPrPFFlsisDiLM5q4EHcF/OKVu2L1fkSRejUwJu2RfuZ1HpyQ1Wi1nK9XTj9aypTkWwCG16Yl9dqE=
Received: from SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::21)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:15:04 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::79) by SA9P223CA0016.outlook.office365.com
 (2603:10b6:806:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 08:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Mon, 18 Sep 2023 08:15:04 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 03:14:35 -0500
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
Subject: [PATCH V7 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Mon, 18 Sep 2023 16:14:02 +0800
Message-ID: <20230918081407.756858-3-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4f84d9-dfd5-467a-a6f8-08dbb81f5cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXKNkFGRtxLiL0o10lmDPQbk4XwQzlrJq+xafejWAwL/u1TnJiAgypLGO1GjOT7UJnNL1UDAJVZt3E8vuZ+oRi1pNdeVt8zOXoDAr9ghnQbmUXdG/L1D6nvqIBQW92ip7/koXg38DkjteDbfoAgTHJJ6XwpFkyN9kYA6WUDT/Am3jb30xSgkhpv9J9iIbbx0TN7OW8T/FAhZARJZY8XqY049PmGeJQS2fSIzL5st/43P9c/XWe5nYptjK44RtLY7MRk6a7DFl6eRp+x2zCYA4gR+j7Al7IHlHmBB5nsXCnkjdIXUPDIbSDTNXEL3+nds4l0zTHJhrqKTNRABIeY52atW8e960/aacaj/2P0xDf+buV4Ti4OysaStTpQx1XrCMrHWHRtplL1FOLRimlw1dR9tSGQvV9r0NG3KHpxBPjdf5YbvJ/xHco7JLXrQAhxxskAu67IJVbj/QimRL/FQIcS5FLUwoULy+1zlkikAcqZzeuzMWwy+CKxxU7kmkvRRNhQdoTagx5aCdGbIJX8weVUBJpQM9I2iAkz+ITYX+f27FCssvEPWuSU7qk4XwBCIvYMknO7y3ZnpaCbCPnhS9PRMGn7Fa5mdyFl4zEKl94K3y/M8/3yI18K+i0Bv75pGFKtNHiTRHu82OuZ1UvOhLeYu7wnffegwA3qLrCdi5sCUZgY8/OVvfz9z2KrcDNZMpGM9MunPQ+RkRh/zlrz/WbV+afGNTXbPzOeaPlGDAf+CDfFY8eHGLIHW+UcRLftLdF1jK7/Tk/Mb2uGDrJ0t7IEebwCN3hgQEXvMZl80jLI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(478600001)(81166007)(356005)(966005)(82740400003)(8936002)(8676002)(4326008)(426003)(336012)(86362001)(16526019)(26005)(1076003)(5660300002)(47076005)(70206006)(6636002)(54906003)(70586007)(110136005)(2906002)(36860700001)(316002)(41300700001)(40480700001)(36756003)(2616005)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:15:04.5229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4f84d9-dfd5-467a-a6f8-08dbb81f5cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
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

