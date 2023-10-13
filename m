Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EC97C7BC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 04:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjJMC6W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 22:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJMC6S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 22:58:18 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578CCBB;
        Thu, 12 Oct 2023 19:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRh9booojb2PUi8c/v6xiwYTBmts0pnICAUgRgCfDggaWkm06n1jVV2d8mN2Vd8kD3qReRv23n6Zpl8oDXvuT+q0QoeRtNv0WIQ1KRDxNIwy3nmgy8DRaQ8FUgBkc9jQE9liVbbTEh27Wgmf8OYd+nUb99kNIwpVRZWDLWvIRG5PnkJxhTCXVGg2NPG+DXcT1mle7H2IfuYugHPyCcW13srkJCucOQ/WNoyTeeMc80+Hoc7F9hAd56umaIEdUjqvw0yhVh1Uu7aWv2SHByFjsN5DDlyMTRwUXNfofS5C8diLAF88qc11lEkCaHxUwuOtzT3NEZevRt3AdX+FQFyObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlF2WKiSUPyODRJ7ueMUccEPh7maCKY1Dj6+XRqyp7A=;
 b=RGTtfBBRENrPUDtU75chx5P7fyIIToJ+nXRx15fEqhGbdXIX2+5JOSzTKwiyRRUBXbLxmfey2zGxvIoxm/+XjlhXVWyw7evwrslZqLTpKdPQDsTMFkfl08ZB8i35bdz3AY9u8UTmzzufU9BCWcGC6C0kcdQgtdpLlZTvsekYji8ZZbbp4LjKaVpf+Js7rTIy5MorDLbRx5AQHa9IiT8A82WP0LZpCl0s34tkmxk0yEBFh1WzR+9ccHmgoTYfG6qA28KiyTOP7MVUs3qaZiDeGRZYFs4+JTV6EDb1iWns1zg5OJ4+WeAEv969l07mgFUx8zqWxG6K+/mxhCBCpMHQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlF2WKiSUPyODRJ7ueMUccEPh7maCKY1Dj6+XRqyp7A=;
 b=0mz+fOC0BAYWWiyiVlUfLDPlXUoUjwcyfCgNm5ttURPba8H+VMmV9+E24teDt4iRPTbCZkj8ImcfE+xmfQAPhtNLkLTWGRWmM82piaKKM5I1NM4vUO1Ww/Hr/kqByisHC5RW+PeiwLaDoU2+5cSGoI16rOvQfBKdD9JnLgJ3FPI=
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 02:58:12 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::86) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 02:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 02:58:11 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 21:58:05 -0500
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
Subject: [PATCH V9 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Fri, 13 Oct 2023 10:57:36 +0800
Message-ID: <20231013025741.3332520-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013025741.3332520-1-li.meng@amd.com>
References: <20231013025741.3332520-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 540aa639-883f-452d-9732-08dbcb983cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI5K7RfbfAnmQLVAy2m5ZqE03TXMrhqZOdlOcjqq5RbeivNCFFlyv+v0+i+Gag9ee6R+kEd9lurPMZOAUimSHRdIwiiCVgv10bBoVG0p9rgDR0wXMGUsiItPd+PBnst2ak6IF2adDMqkoChLDQ73pLrHXRX4fpYOqUMLEK6ezx0L+u5VDtKNdiMg80hed0ozaX38WBKC6GpUL1N8h6/7gLiMFLEb8UBKbGXDSpqdHAqoq0kgbGpkRJuOF44hE49z2orLRYr9J++r3dXcGyGXV4DeJxkiA6fsVcsNgd3KpqGIPKKtLjVuOf99mCRC4UnInTvxBcR02qe+o/aMsS3Dp0Y7y41xHXCon4x9qvQmygPjNQPetJysgh9pkAaUh0dhTpFamKE6tTKPZqpP0ka536w0yGsKWH3y2YyyE02e+E14t6E+yMJPM1LaoK6Ehm1nm9YpxgVDxcJF+ard5YsQbAF6cWWIDHSmIi+sYG5C9h4WsBAq0i09DAGhwF4pfSkCQvZMqjPKPZuNgnoSjOB/Ljx7ks+NYsykIR7Jzp9WJdh0ybZjpHlzwUR3udBoggGugXCE4mODzrWgDTajlLi5BvT2nVrzBj1l7S69FR1xZ6qcjL1slwzlyTT2Qg41lSM70SiLO1DSbZrTapCza20+Y9QygGDSpeKEzEthwpgn9YsPzcb9L07QjFtZV+3EDvVoQ/r6I4UyDcBp3g5L0H1nQ7RaTB9tb62AhjKev7EHIwM40EVkRvyXLOG8t7ZVLn1aIzC4cNKpAmLfBBnUZmtXyekHKodmMd+kdF/FmChs12I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(426003)(26005)(336012)(70206006)(40480700001)(54906003)(5660300002)(36756003)(36860700001)(6666004)(478600001)(47076005)(86362001)(7696005)(41300700001)(1076003)(40460700003)(356005)(316002)(6636002)(82740400003)(70586007)(7416002)(966005)(8936002)(4326008)(2906002)(81166007)(8676002)(2616005)(110136005)(16526019)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 02:58:11.5324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540aa639-883f-452d-9732-08dbcb983cb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
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

