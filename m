Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA327DB36A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 07:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJ3Gfb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 02:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjJ3GfY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 02:35:24 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EBE9;
        Sun, 29 Oct 2023 23:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nShVtEPaAZIMostyrO6fKlG58LQfbFpnHtN8kG38gechT0fJGj5LJ5XH68ZwoKLB3ayZEcRwJGorAXPMFkwRt+cN9qzDBSxCsaaG1cIm96WLKJjuCgKhB+brnlQKUiLT49zHwDzyV6tDSR+91bX9lX4GsfsFG5emta9NR0x74rBbzOchdIKDzzBp6gbcJ7xnZX06tKekY1RYD1W9gpGxybTy1c63bIrjbhGI5AmM9gvBgbJhYiVkomwERmtvPmsWxNzhb7DLc584xKMhBM6RDmcmopR1E/0bQz74VzFbiw0ZT9EvS9OpTegXPpghbm30cHY1Ib42gYxpsrTjMMvIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlF2WKiSUPyODRJ7ueMUccEPh7maCKY1Dj6+XRqyp7A=;
 b=J/w0Cz8nXQK8JZQZ+HnmVGK1zxxVYYjHYJOuMwQN8FdCYOKdd8W4PelGz4xncdZq2M7hryAfy/sgSQxqdlUddq6LGi8jzxdpyiUD8bf3iNrMgDUSNsuk7MVATIG4Tl/CEoTcfN5jVU750/NaHegq9Soz3DHxHpF9z48hDFihZMoN64Tw0neboiuxgsKlEtz7AyyUiC4lkUJR6YJuieqh0qPgik+pt6yXZwHTr8ek5Vh5e+xoXSLvrJPIkQhyRiXIg/Xa1IRLGtEc5jB1Li0FkC3m7LdW/3B47nilVJl/5QWoZkOvQuPdw243143KnYrOPhIv2EQ3is31CJljFJQTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlF2WKiSUPyODRJ7ueMUccEPh7maCKY1Dj6+XRqyp7A=;
 b=FD00Zt0dyEP7j1x667PjY8bPuFxL4DBs/+4wlYMCX0ipQgf/ZUosNCSXpqLDS7jxJrhV12FSLl4WsubR3MMIh9O+t1VIg+08VrD7X6qO07I+9d7mfAJDSS0Rnfk91INs0fx9v2b/CsLrSNXc14DjQbod0bHxxcFVIBlroQJbH6w=
Received: from DM6PR06CA0025.namprd06.prod.outlook.com (2603:10b6:5:120::38)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 06:35:18 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::57) by DM6PR06CA0025.outlook.office365.com
 (2603:10b6:5:120::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26 via Frontend
 Transport; Mon, 30 Oct 2023 06:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 06:35:18 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 01:34:54 -0500
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
Subject: [PATCH V10 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Mon, 30 Oct 2023 14:33:58 +0800
Message-ID: <20231030063403.3502816-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030063403.3502816-1-li.meng@amd.com>
References: <20231030063403.3502816-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 794eddf4-1a9a-40ea-d8b7-08dbd9126217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjP155DwLX+Wk7N2cK4X+tdrAaZiYfo7jD0yJDIuaTXOcW3l5HWku21iIeMQoNGlNU27rf2IpaozneNkmpCuPuhv9f8JJU6+pBvMs69EvY3Ld94L1vEGgC4SzHJjcpWXgVn/CD6OzhNQGzhbLT81FEp0eDItNgMo4S6TKZ4tzQhs6W9YY8o1nbyBof1Yublup6IMcyqPjO9eYN/omTbNHEbK341uvZJWXRu7AHfOPDZcNE2a710y53KIlNiQxwQ/EWG9pDkB0tPRQFEBehVUphNu973w4elKRF6lFRTNSyFD5ktXL+xyNgVU9QXOLMuLzw70WJKdZE/naR3CO6bwsTPUNy+SJn68YaSg2wYPh9EuwAVo19phPknYBiGwUsBr1Nyy2kg9X0VDF5k6vFLSl02HVm1MeQmNXGPM0Zpr0ZtFhVBkSZPOMJ7t01dUli24usU5g1mEggPQPHJAPrN13laoPod6YTpwbmDtDaMxbUgPAWlfzDARBxlHqvcUZGGxH2TZWdxNpl5meSdhlpyyLr1xgQDLzLjBWn9pYa6RWRGh5tmdJdrGc+rnkqWc4Yn2ZyO9Wcr1/AozIN+kEeQxel5kL24peRjlbmKNUxP7kyiAzRr834WKjHTw2wnIcpqMQsxd+8zSr3QFuvZv1QBEDl53Xzax8M3h2uQMLnbwyBSzUFfDdJKBem0ahg+FbbpaRs3KlABla8GsTVEJgOpqQici4mw3gK46J9RBTSFCCygtkt5t242eTcF9gdRQqpkA75N5HA8G3MayzG5M1chPVmTZfrpd7xauWGA58xr1Rc8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(7696005)(966005)(478600001)(16526019)(26005)(1076003)(2616005)(336012)(47076005)(426003)(2906002)(5660300002)(7416002)(54906003)(41300700001)(316002)(110136005)(70206006)(8676002)(8936002)(4326008)(70586007)(6636002)(36860700001)(86362001)(36756003)(356005)(81166007)(82740400003)(40480700001)(40460700003)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:35:18.0332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794eddf4-1a9a-40ea-d8b7-08dbd9126217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

