Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFB578652C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 04:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbjHXCOQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 22:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbjHXCOE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 22:14:04 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F216F10FD;
        Wed, 23 Aug 2023 19:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwL+PeBKhtjqiGwOlcPEYd6oj79TdV5kw1/MFpyFcwyhomYKcMp07contbh75PJAPCcp5+V8N1CIzu2JCX8Lw2RuYSebd/ujFvAhAX9vRFtxXIfi9K1UMTeemEo59DUS76MK9SU605HvO1+hti5d2JO9Vc8LAbVxrqclg9FZCJi9Z3wuTC3vGhHe4msHOhcFMNVaywNK4jsU8/Jb2EC6c4dWQ0fL4ysCeFBY/RzjN18R2mUuwCHHWhXYNcHO458eZnbhb2/n6wAVPvDLFDzB0AbyrGipCxsL51maD2p+79F8hnIwpdQlckuppTipvdQBqKtDEneRODirqauabHUOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFDn6jp+E1OfjmJLdn866JLVFhZZ4KpifA7cfk25OJ4=;
 b=aaHoEklm3qGfKluvIfA6ypSCZf59Na8T0wxyhLS3G+hp+06L0FujNiD3BmTwrj50ESi8wkJRHwiHkm1T6Sm6nWh1AmiTRrbGHdwXLBijC4Sydc3qj9Amv8oKhoIXyTLFV9sP9VoTFIiKWZcnZOQCylhFFx7PXjNutpTGlGQuUAKfwByJlnSkVRN1F2Fjbd4foPm/mr2ddPCMoXp7NiPHfRe6Fhc9sw+Ny87nNnhZNw+w0wmQqvIPtxUh6VMF5lus9vdu1f/+dJkSbsHv2titxXJPLS0sbAZu7RAD0W7UaPIbLQZ39F78qyVRANtVJeNyiM2lid8elEtNZ7TYyt8Dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFDn6jp+E1OfjmJLdn866JLVFhZZ4KpifA7cfk25OJ4=;
 b=yLksfGVsw7eqrfRynInXbQdaf5Bz+HCR5c53aIYynvOJyux9UPRBmdxU4o/piIGPeYONsLLeYd2cX8Z3ULSzrQCCdBF/HfrtqfTDaoNcY+3dWGRGZkALSHUGlR8E4x931VZncsQWJSEpbPnd6RxTgRzXGLfb3O1Ebl54BvccBSE=
Received: from CY5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:930:11::16)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 02:13:56 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::4e) by CY5PR13CA0031.outlook.office365.com
 (2603:10b6:930:11::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 24 Aug 2023 02:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 02:13:55 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 21:13:48 -0500
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
Subject: [PATCH V3 2/7] acpi: cppc: Add get the highest performance cppc control
Date:   Thu, 24 Aug 2023 10:12:44 +0800
Message-ID: <20230824021249.271946-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-1-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: c792e3c4-69ed-4631-85a0-08dba447c4f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugwDC4Az0jpoDO5JrWyZt1NnjJ2wilX57IV0svMQFI92CiUbijkdAZ6pFW3Z4HN31WL/FniLzod12dxsQAPJbTDCB69GLl26yffj+N9ZFTkIuo4ciSgRSj/kOSnmid7mywTlB+igTpXPmmwEqZAJIOfN+/+jFn0PP/TEZxmRMPHTdvs0R16OfgTbob0hE+VObWUMx4d2NMFn2q3YYUryegikn717NKYKae7C4d7gkAxosqfk+Vdswn10AK+c6S5eJz7Y5S6yhOuS/Cpgi96Dnc9klcr3pPB8FnO0OJcNro02Vhvf8DzTHI2a6Sb/NVtEukOevDEG4neSL2nSDwOD2jtr4+KO73vlhYIwcZ6qBvVg1mxOAJvj9f+CyTL/F983KWeQFW0dcyB2WocxyTq7ysiXuG6G38dO5T3BpEumTG9pufw4+HYJc+1dxdR1PAVmwiBZRM9VcV/3ALb9ystCmgnvoBoZFOyS4KHWBHQYNgpitjsnwAsU9oHmYcZ8eAzhkfnCSK7HVL7EuLLCmNu8I4BxNenIFI4rFCNEgNiwod29qY6eql4QEzHSIzZxXCe6kjWy2YdeJVzj16H0B1NqKTIpvG0vFzui9gpH0XnDXK57nSKvDMEWgXNm7Jx3DH0RiQA1CDVNUdhaAekewqPhaP+YBXoCov7TVVSaYkScpTiMkgeWY9iLByjwHQen0Mzv4V+k95smtwnvErGKdaDwkeNI2hIEiCvNqQVOJY7VR4/k6lUP+clrOLlzkDUt1FbgWhQQrbKo7bQ3VTZpx8dUGQuy2/X3Yxnsr/wsOFf8tuE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6636002)(316002)(110136005)(478600001)(966005)(41300700001)(2906002)(7696005)(86362001)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 02:13:55.5290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c792e3c4-69ed-4631-85a0-08dba447c4f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
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

