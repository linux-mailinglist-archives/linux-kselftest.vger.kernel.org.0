Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0B78BEAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjH2Gor (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjH2GoY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:44:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FBA19A;
        Mon, 28 Aug 2023 23:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tydm0jTi08lLNFtZcr/V0tr9CewKD4KHi1VGdIK/UXEVrCcwdmVcBxB0qryUbXKDrC1G7d+R78NauBdvKvxhlKwuqaNjOrzjeXHkGsE+HYjoQ0+IsuMUXDZoj3bRRUs9/piLTAfuf+aMdX+PkY/wi4AAD4SUddXjjsFB487BknfZfQauBYL9qumSGfRSsf1IuPkkTLIZdOLu204Hd6eHYfsElWUalF+JdN7+vH3Z6QThY0FQSXp5FDb/OBbVkilgjC2t36gionydh3/uTNOzPlgpYKd+X2ZAIZSg+SMfbY0PFe3XJhLv0D26WPbY4cY1u5dYsSjZt3nfoI6ztRQOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws2yf4YYsM18t4BNSIPeY2jo1PNGYVhD5jWIe4u2ENI=;
 b=MWcqMDMRu32R/+TuIJmwHgABp+DgTDf6U4W/XhnUG4zOwG4HN+o8g47qz/9Aw7sd2sagHLWKwkKjqj9omiV3AL9fzPQ7XwaYhNLl7i+trn8XzVxaX9XPelmoOjr32DEIU4i+V21mGZmQuSdRMony6Vcm5x92Eg2ZX5shsaaV8ZycByNDhvl5kMLCBn5TwCgrCmTFGAkNYv1qYNutWWnmsq5il256BCzqqHXVl3v3/5MBu6UM/Z7HcrBd1AAQMcBlyMUgk3FT8rLioal2qPf/xwjuyigjfSTYnhX1qnJcnrSTPKyrrjU48pc1tQ3xFZhnYOHk35GQxuGBdfpX0IQWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws2yf4YYsM18t4BNSIPeY2jo1PNGYVhD5jWIe4u2ENI=;
 b=qbtndMz0/c+bC+021BaLBlc7+c8lUVp1b/5byEpToOk5Mh18+tqGElOVUjYQTkc6zf+ztq7sqSrpxC+NSbQyudRJCaYz64VK2KVv336EpHkTPHuZuejg2pvunes9h+ZT/zTkeoUWxFyjznZWUF83a2vHWokeaeA8MgsZrTFkVVE=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 06:44:19 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::f6) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 06:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:44:19 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:44:13 -0500
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
Subject: [PATCH V4 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Tue, 29 Aug 2023 14:43:35 +0800
Message-ID: <20230829064340.1136448-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829064340.1136448-1-li.meng@amd.com>
References: <20230829064340.1136448-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efec217-cd65-4b2a-ca00-08dba85b5ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USVLYOxaxujlKR3F1k4q4SQBkgbKwlDG6ujaC5f2FxaN+9N84XcEwBXjXba8RUnXwnkdYaFERqc60vjY8nA7easQzgDdL3ccgBEC9hKzI78nPlqszhklNA3MMtSXGEb+CtgriHrVartSx+uufhOg1Svy1YJrMwujriopRUfjDzkJlIZdkTn/vTUfuVKrpl+6lEayRjVaGd9N1jNeeuQY8vv0B+QKPSm8LFOFqFGZkvVnoKv1ZE/PjYix04XxQ1eG+LT+KgzjrNIBbRyd1yWIWddlGCQNpmsP8Bv78R7bQ31dUuaL3eDGVZ7byIm8M0V/vwE5rs0J83xkJ16POCM8CiSr2fySn8+WFNWewm+MC3LhqzKZn/Hfv0HRnpDZHGfactSJbfiauxzBojfAG8fEVnh4w04Dn/13NTNIx4MVfzsyUERqX05Ty7RDl1XHlalzf6I/D1UATzP+myolruR8b+OmDEg4dB+64PeqItK79Snr8SP6p5BV5TzuGnEN+TcSmXO3owitKbdR2YGRIqtLGwSmrp3ZgVmHzhmyHzOrNf/VciHYRlnjx6uAMQ620mJwl4KXFe2aoGajR4pditlRn5OiwYNF2/xZwc/W0n7wgASzIKCNgSxD9BGQXgvVZWoYE6CP2xQNSfbvMHZ/58SaLgifWqsISzRAdXUmNu0RJ4RLsUojxweqyYyOyRn+pkJnPE3Y9e9Dy+pBpMh3xlmi4aTr3iAALdBlT+Mm08NYco0P+7UEgMffv1bmJhjQzhT0U3agDAuLN9obYRR7BDjMPp96+8emR/GaUEG0Z65plsQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(6666004)(7696005)(36756003)(40460700003)(86362001)(356005)(81166007)(40480700001)(36860700001)(47076005)(2616005)(1076003)(2906002)(336012)(426003)(26005)(16526019)(966005)(478600001)(110136005)(41300700001)(70586007)(54906003)(70206006)(8936002)(8676002)(4326008)(5660300002)(6636002)(316002)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:44:19.0126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efec217-cd65-4b2a-ca00-08dba85b5ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
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

