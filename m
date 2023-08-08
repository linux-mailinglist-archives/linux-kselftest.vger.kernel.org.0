Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD8773B80
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 17:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHHPwB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjHHPu0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 11:50:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B294C2E;
        Tue,  8 Aug 2023 08:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwY//AhIw3VaYNP45S3krCGMe/2s+nbc9xy4D2jjcUZHhvEQl3OT4GO+PXleD66W9jBgz5tz8OpFfZFwygHUo4NWGIUoxQrmWmOfarr0NxwphojV8pzUOcl/LdgaWBMlqx8B/FW3ziBmjzLqznqN8OM28YlFmfo2b4VTAjNaCDjr5FYui6+d1Rjtl2OVjexVTdhgZvWNIDyavWUMzWY2YwBiuKXcukgeDCdXwbanHoMGODXtg3+ROD/snj7GLxF4maFx078YcnQpcI15DL3O2yBo2SVa1+ITmzL+Kxii+oiYjCQphbF9c4oCQN/4GYt3IP5SNJlHsSlwdFOzQbJX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwWlvPvZP8nSXJC7vRCtZ+7JJWekIXzmKLV2dFsiH+Y=;
 b=PfI0c6p6DmTbPONjeUaz8ay3lKqJ/oXCeHoyuewk200LFe5fU93Q24k/x+8JMI1hyaw7aKHw8ZKou686+MLppSLkw7+7w7AdaH1YFA0vh+16UQhwqViy8MFboGWqdYdLSx2R4fF4ZgmJMI5ndp3WuCStYfI7r9EgQTsRfKVcMxiBymdjzCCKlMsUNXOZ+Ufhpfwu/mwbfkmVCWRFFsIXih9GB4gieoNThvWiFx5Dh1sjpWem+hkXaQamVwAaOcbsrF0YbLsKXKT3ROLGzVOEPUrzmXLxffS9z77UK7BXUC5FAIr3qux74DshJ//NkyPCWF1KK3TnXhOjThmo6x5asw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwWlvPvZP8nSXJC7vRCtZ+7JJWekIXzmKLV2dFsiH+Y=;
 b=y/J11qhOhjrA47gZ0fnYwAt0XUev7u4ZoGBHKU0UX4xHMNW5JopVhuOd9V806JGzw4KCysJBdB/yf3tjug29JgMdr2m0MBoL0MPPpbr4KzQ2dhp1GJXGV0JSIUjyJ50vLYWE00lxFpbisuuP4leeiXkJ6UkoelbeajFlXkRxBhU=
Received: from SJ0PR05CA0101.namprd05.prod.outlook.com (2603:10b6:a03:334::16)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:11:00 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::9e) by SJ0PR05CA0101.outlook.office365.com
 (2603:10b6:a03:334::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Tue, 8 Aug 2023 08:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:11:04 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:10:54 -0500
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
Subject: [PATCH V1 1/6] ACPI: CPPC: Add get the highest performance cppc control
Date:   Tue, 8 Aug 2023 16:09:56 +0800
Message-ID: <20230808081001.2215240-2-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: b0970465-1843-47ad-0c82-08db97e702e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78HoVerrP/U/kIRrQ2gfxx238Oy6x0CWZbE/Q7St3oixRkBgrUQPvhwHXN9096Cu2lE76xalC1YPK47DQLrwMa3tS10sf9K64VzzM87TflzGcIFM5QQEKqqH191grv9i5TxIsZC67OBz1pDGY07SMUt/pRAA8THd3FIpJbYkyJ7zBa2bCxm/7X3hsq0dN8pbn6vceCXog2SPyjSXrSZ54xP6hgrUKd/E0LGa+yOlBjVS9Qo3z5sfH1hPvXuSTMp5mutSu4bK/fb4U5B73glgzOGUB4fYQ5auuEEHjIbChwvqfOKBB9quJMH3uVFJmKwYib8xlJOpfwb+VkRTpKuGZQ3S15QU2DAq4b4zPHYgE5sXF9sZ+BsbeLtKiWG4MPpE2c0ZNORPJum9uXIJ1Gis8dxaOKnY4q2Vf8yjhO3SMUvqQVIvi2bHZn3Sjj43IZHjtObh9aIqaLvSemEOKmen8Tql9sCt6TQwqRPuODR7qW02eb0SE2sDNlmqLKAVDQxX4mgA3WvkfTFaImQ+4UEp1Yn7LEjOSalaOB6EMJ16DTcYmZcxv1QvMDOel1GqG3BY+QRgDKiY8mJo+1Lii2TiKh+AYGnnK8hBEHCFbrxZ18x5hTniSrbznY6Dx6cbvCfKzK7HH3S/QKWC3U42+nu1EkmlkwE9s4ZKntpj1QJ6WDbtUuComJpwvbZ94xWrsMG6EIcjxEPlcX2csL5WCGjSSB61J9bcDex1kLEba1RwcvOFpmpY4wFx3hJ7m2Zt9dvLNYd+4Nfkx6Ggt9aYS1HQ2N7Htb9aGrlvajE30sDYIf6WxweNlrzebI+10T40PBTuo6b2j3Joky0UNDUn4fL8UWQ/ajtbs/obhUqMUjfhayI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(1800799003)(186006)(90011799007)(90021799007)(82310400008)(40470700004)(36840700001)(46966006)(40480700001)(316002)(36860700001)(47076005)(426003)(40460700003)(2616005)(2906002)(82740400003)(356005)(81166007)(36756003)(16526019)(336012)(8936002)(8676002)(26005)(1076003)(5660300002)(7696005)(41300700001)(70586007)(4326008)(70206006)(6636002)(478600001)(54906003)(110136005)(86362001)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:11:04.3718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0970465-1843-47ad-0c82-08db97e702e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for getting the highest performance to the
generic CPPC driver. This enables downstream drivers
such as amd-pstate to discover and use these values.

Signed-off-by: Meng Li <li.meng@amd.com>
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

