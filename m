Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5641B798372
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbjIHHr5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbjIHHrw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 03:47:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB7B19A6;
        Fri,  8 Sep 2023 00:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij3SrfY+wwP0AvHRD20LANpSAS83e0q8jT7FgkCReFb5Ct5rg1NnyUfRkPtlGf5+PEokxe9yI7hcqIpb/0UkOFUCoeuJ2vIJRrtNt2FeJYFWULTIxsvDPXG8PpEClNF/b66OxoSPVXn1ovcM/+w80LCitgvc1rVzm2F8gxWXAT1JNWvXiPgaaGLupMs3ld/JKLwOBEVFDWm7Yx1tBVxFBfK2ufYziG2etr7vL3EYQ0VXd42v3zju5lmXlPFgGETc8hdGpjz3rOmpPtL8eKKmX4n+d6C2+hvO6HTqHHqUK2be0RLh6pvQNM8CXjW0Knw3JJZM3TqBEK6XI1fePoS0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEcCw6Oy9jPjG9wxDtofg2lXKlE0XnBiGA6X7ukonQE=;
 b=eOvJZcMPixzezQXPlhnUsMAZ1Et4KIuYSHL/9hzkTwrBHIYKltGKNnwxA8AcNTVF/M+lRaF7jULaisICh68aVb8NC9EHonAgwCYy6mX72TjuwhaRhGxjBFx8PnNfnOrnK0NkrV/CMd/+Q12Nl/Lbjd/6ezf5JNEKugmyWI8JqRsqikkHkb/O42P0p/t0GFPsGREahtUEjcrkSEgetCPF2bGqyoh9FjJzyK8dw9H+/NRdEy3LKCOawweqVcLQH8IEwxpse6+MyOTZGXuEX8LQjWm06QsNBVdEZuG5m7t8PnjLXEzIxPu19b7McBxsjgpW/hmUlsl68tEWjQjYKWUENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEcCw6Oy9jPjG9wxDtofg2lXKlE0XnBiGA6X7ukonQE=;
 b=gLa/7R2zFe9U6DkildloRvT2hGriRwTbj/CTbwz+9+NSXxKMKrNc/uIH02M7yZPziBo4L2PT9EF8bqh+P+8hI9sA6RonK1i6wLwj5N74CAqwFJc5F0UU4Ud46lY9zwLyuxgD14ZWc0xI05ycaM/+SoA8L4e7pWZtsHg3Y+CTtD8=
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 07:47:46 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com (2603:10b6:303:86::4)
 by MW4PR04CA0210.outlook.office365.com (2603:10b6:303:86::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30 via Frontend Transport; Fri, 8 Sep 2023 07:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Fri, 8 Sep 2023 07:47:45 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 02:47:40 -0500
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
Subject: [PATCH V6 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Fri, 8 Sep 2023 15:46:48 +0800
Message-ID: <20230908074653.2799055-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908074653.2799055-1-li.meng@amd.com>
References: <20230908074653.2799055-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 372681d0-7925-4457-2f16-08dbb03fe413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PK6wyKMTIYKPYUlmxv7SiZRtxi6wop/NbC0igtDj0rIUSAyVFlPK31mVnsc4ke/ZUtWs4k4XlyeVugk+QBu7FvNBPbXt3FHy6ojeGPtItk9mp6TBijQx31Oo3ZUTowfH0WKgkF1abjzQ4Bf+Dwn3qqnvkMYNANdD+SXY0tc1xxT7J64ky8NhjGq8xSI9B5fkvPpWuNXLMhwnb6RnCiYJ9VM6fiqFZeJ3o6G4DUAxkwaIB+Nx+caZC+iGGoY7pPEH2IYTNdYylo69o1JITnSPn80Az152kiHWTb5H/kePGl8pZUiaVPKc8QV0phr1Lh/XGHacFrIC77paosaeiDiIhFUkQkGv/lqwxDK/hilXuYqITCLcyygIjIesbWNHmBNP2T2tjXWvIjOi2WhU+Y42A/MAnc+9DTtjnxPLPBlFRFRHJ2+SRbjRnynqdpb50bwFlmknybayHRlxbpzlKsJGwsNkZYpLWjF5ZRipV+PkiUIIVZychLsmzI0h28rrD2GGZqvGFhb6pk78/R119N+tWt9cqfPEZ3xCPoMbJlxCUhywnovfDkyG5lElIrVLIT1drS2oqkUMG0RP1Ghio7sM/SmKcQBOZKnwjvt/vGAQWJFwGqGajLTPshSBuPVyxRr6mjaBc3sg0zX27yUK8vE6mcEFcd++glk8UsLbINk6t3itiuIORd6zaPPCAqdkwZa7PBbFKt1yf4N7HerUJWK+1ncHTkp8Y074W9PGSCiqRaA3lTLfcV25pmt8e0xHMQ+kGuqjuAAhgwFSUTuSmZ9r1b2voWSFFPOtkBKz5wuiW9E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(1800799009)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(7696005)(966005)(478600001)(1076003)(2616005)(26005)(336012)(16526019)(426003)(2906002)(54906003)(6636002)(316002)(70586007)(70206006)(110136005)(41300700001)(5660300002)(4326008)(8676002)(8936002)(40460700003)(82740400003)(40480700001)(47076005)(36860700001)(36756003)(86362001)(356005)(81166007)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:47:45.7385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372681d0-7925-4457-2f16-08dbb03fe413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
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

