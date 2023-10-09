Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0957BD213
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 04:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjJICuL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjJICuK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 22:50:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1761D6;
        Sun,  8 Oct 2023 19:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9QGp9pexlXmeJDYvPah8VHiEU2iOuTvLmQ54PxMxtJfjRYyFP5KeWSlqHgGMwlPx8k5GELbIDE1gG3DeI2oZxwrlBEGxBL+OKlgvRymxrdq28Q7HjycTk6YAiLR2KRj3XxRqpQJB+YRnR5qj+k39Akebj/bOIH14QTP+71xW7zemkKMUxam4EByDd0itM/j02MQJ8QWAaV9hfxa51aXDy6ZQtaCsfutiHnPtmEGK/tBP2fp4AUIbbMmVr/lR8NyiBKKgxq84N87Nqm5s89i6hCyBEKnPXpZFHrJpm+OC7qKVTvakrj5ZTrfqresxP3lv0UtvYJBN07Tx6QLevqTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68m3Wjq9q0JUFz/4fisPuF3cAg7UniP1UxVS6p0LUCI=;
 b=KuAQQC1uAySNnB+rOCqWToFdmNBN2a6eo53VuEJdoKKXdOLM8VpZ3KEdajbv6xGXG6KFKJenhRGpe1iwZdMty+3E3c6TT36/yBnISP3hm/w/KyZRRjKRyZbN7qYIdllyjA1n8T+MGJSU+AcLDht+ie/q8oB0dziLbgv3CKIOePc0hf4Ksmkl5/gxgUUKteBScUKl29SWjpYYqZc3Z+O5cMUNFXI9pZkXyJ0/7LHwkKaZzSirBnkeme08CoJ6kVfkqBY9WWlx71Wia6TYt58fPzPH65P7pjO4tegwPYngihnOo/XVatdl28yB0WeKrXwlnuB3Hyvna2aeHz12uXqRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68m3Wjq9q0JUFz/4fisPuF3cAg7UniP1UxVS6p0LUCI=;
 b=UvT3e8zt2MhKHVYV1GFPiLRYgHhqHYSowPbACb/K1+KHnzvIPxC43y7JT25IfdyUsXEoQIM3fOrhEBybZbY8vasS48USh6bR48n2BmJbQ7l4usDPVkDz+fZYPvoPtglA49yHQDxdBPQSRD+gzUj6ljgdBsyoJ3puTBNZFaRG9Bg=
Received: from SA9PR10CA0004.namprd10.prod.outlook.com (2603:10b6:806:a7::9)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Mon, 9 Oct
 2023 02:50:03 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::6b) by SA9PR10CA0004.outlook.office365.com
 (2603:10b6:806:a7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 02:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 02:50:03 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 21:49:57 -0500
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
Subject: [PATCH V8 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Mon, 9 Oct 2023 10:49:27 +0800
Message-ID: <20231009024932.2563622-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009024932.2563622-1-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d60eb0-7ccd-4593-3298-08dbc8726fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXpjIDmrL1sVeFsQW2CVz6skDR+/YKipZf7sA2GmNcau5QCQYDirf6NP8BvDl1kwTDFvhxOX/VuweMjNXe+WmyMAuu4K77joInvapOz2UQCl+5ij/wHlG4rxqqmWdvB7fSNctZXmHmq5DicbD/k0QpV7367Wudl6zd0CKxb17Cwu3Tcy+V9Yhp7pJKw+G4cbkMIa5cHVhLZHxZ6ODs06IqehoqRUz+YbwV6ZUKFyT7k+uMkRsLDnHw8lp4p8e3pv8qTFtpMM8PXh8nBmaswqwsxtCneg2sPbRW4SjTZzahZBTcEETZmh2Zaqc0WruOUZConSDGXGBgf9QP2KV3xODtiPYwKZ0juqTvmRHOa+bqZMREOLN3ut1lfX9DzgKbqJfD8L2Ff2lLen3Kjb/hxnnvI9f8ZUay2TN8cl7D0hGzxpAbBANUWTh97KUVg8aThZAxes0jOHplJfjXMbRhdhNzFeRorh0AbBVBpQPPPyI74vRUli6EM2pg4F2E7pqs/S8iYUAXICnn42J8Hn0/YjlNECOhtXOF+2i4bFqDdm/n1rVx1Ygb1Svj3Zs24jsUfEHy5LZOeaJwG1UWAJMBYVpJwQX5jY59CZ/COxq1+UbUUVgihctB2XIRlGqRkRBJkLSY9YtHiqZnIlIfB/yiKUtYvHNhaBUmOF60aEHJTiyEzbxUeRgnM96DrR1afqIa22FVn7iEm+kNj/eojlDWQoAZqcALhWWrI8SF8bHQvj4QQGzTK5AAK4LQlF9k14oQX1d/9dxTh/xZGbRAbYKYlBi/l/SE1jSiytSUyBiZ7Wqz8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(1076003)(2616005)(478600001)(7696005)(966005)(6666004)(336012)(426003)(26005)(16526019)(47076005)(2906002)(5660300002)(110136005)(54906003)(70586007)(4326008)(8676002)(8936002)(70206006)(316002)(6636002)(41300700001)(82740400003)(356005)(81166007)(36860700001)(36756003)(86362001)(40480700001)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:50:03.0502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d60eb0-7ccd-4593-3298-08dbc8726fd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

