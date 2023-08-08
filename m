Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648B773FFB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjHHQ6G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjHHQ5S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:57:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16972210D;
        Tue,  8 Aug 2023 08:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG6SR1ItAaplwh7WpJ4xDeRBmPQIVp1FSuIRx9kU/GKctc1j/lNOQ7Q+5sxGoOsaN2EVfx7qSP/RyFiQt7FbDYRhkZY0KdiT1Wrk6qDXkr3IsA3cgIEc6VB95MtvBJTy5ttEG27Ay84wvpgWVGtB6IzmrqZUdEbYfg/iJt8KEIN8bObDheZXnh4k0d7azIus7YhwM+ax0bQkZ1ZzwN47HMfV5s0h+bnPYrmExxTMulp/WzNcBtI47jduQP9m3a6cPR/T1uWc+3zxtdHaNEtE+QeJUedxEfyujSlvUk762KhvtN0jvVYcnAnxhjAycAGbZIk/L4upRyjdre00BiwcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SqfDFHBC/ajNOzpFm4f1gHf6k0T8vldnjGMcmJVBZw=;
 b=CUYwhmu5W+0GVkUGKhYXr7wxeubJFZzcp/7dIIWSj9jpd/ERT1cXQdmaSAjeDDmuHwOwDGjD/kyoauxV/6YP0wldxIIOjHrSLCHXFs/yN/CoFhvtni8cuE+J1VRUg8Ke3oSIRwUnNCvirA4hHiO3CWvcs46mkCJ0YmZek3tzrSzMfa0KyRqvpLRDb2jk53nhdb7AfDz3G1dBPmsJ/Hy8U4zLk76nJycm7DRc/WrwzQf5tuCIpMPGk4Sjo5SWtMQhjnR8v6yW/cWLTZoactyLZw2+tGZ13xdWKdW7Nl1aITeXVXUAtSobCJsJ4B3ZxaW4yl53ZjtknG/GB9pA5+9l0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SqfDFHBC/ajNOzpFm4f1gHf6k0T8vldnjGMcmJVBZw=;
 b=o16Kzihzu6IV22pT7c8wozXhlh2GgOMs1E9TR1kT2ydkLVVmhLZMXG1dEunQ7sJXFe6OMX2xahohINlyqXIitECzaBW8/lUU4oZ9yo4XAqd44oHu4CPoejgyBvtSOM6ueHPOrRu7mzC2GLm+HLqKzmSCyIbw9pTKT3AVTWrbSi8=
Received: from SJ0PR05CA0119.namprd05.prod.outlook.com (2603:10b6:a03:334::34)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:11:05 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::c5) by SJ0PR05CA0119.outlook.office365.com
 (2603:10b6:a03:334::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 08:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:11:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:11:04 -0500
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
Subject: [PATCH V1 3/6] cpufreq: Add a notification message that the highest perf has changed
Date:   Tue, 8 Aug 2023 16:09:58 +0800
Message-ID: <20230808081001.2215240-4-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 00895c46-dd95-418b-75d1-08db97e7059c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1mekc82Xxrn0f6Pi9ueUJ2MJEQxyfA51/Vunt8JGsPlMXehrh4MDiIV0UBNjcxZPb+EoLvS88lh+heHULl0MPXT6AblQTDCcOv2vxgByqprqbu3YGn0PKilKVW0U7YzbiSt7bec4l6AmhgAA2de4hGzv/yOIEgpb3jljAB12vtN7V5FKvVzsJFa80gjfS2Owzh82g2US6A9DxyNQu2u6XloSANBvxsUaP43pJU3W/ZNawLOnulYJFC2j5JXwrlwTGFH46H3AGlSyDoyiT5lPJwWDXbjexzHlBOO2QaGjeyEVkZoUzwGPpU0iDjnvx73DT5pkLqgeSsdT+biwD5qDjP4LXXTki8Vsaj9hWf2ztK+kTNiqUuSbB6tnrHXvb42UtinWfi0spx4UWxTrXF6fmmUPNGUHh6y2dwgNgekPu8Bb3XttbT2oertaeA9J5/P4PQck8E+YxOsYm5Bfup7rQmalHC6YptD6205YC9RhkG7SgsnfPQLBcOmHwjBGAY7j7QtGM5XtmumFmzEfniuNFR6yITOIyQg0+B/1eyMOkNSXkjQOV0wQ5tPfl3ydY9YFgS+PsALNe26oeFUuVXsF0/+9piQrduAxQU2qovM4NO9fsaX2HZL3PM0kKfzkn2KEr8+zdZTJSiMZn1mkwfOwWnvvwAaCwiI/mYoCN8gUzUxfjeGSy8pFPKesBH2oZhxn/uIkJRWvzZMeMnlmdZJ7pAZDUb9qaa7UtdsevV35sAASqoSulI0/PjKT+5zh6vZJT2oKM3r1he3hnIZ28qyedBE1WkXZUjSMww0dSNLbnFO80WDrLr+qimNmooS4J6d/9J8kyL9bIZLPqBjNSwR0EnXYRMQgWufw07oAKKBHkg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(90011799007)(186006)(1800799003)(82310400008)(451199021)(90021799007)(36840700001)(40470700004)(46966006)(8676002)(110136005)(4326008)(41300700001)(8936002)(40480700001)(70206006)(70586007)(54906003)(36756003)(6636002)(5660300002)(15650500001)(316002)(40460700003)(81166007)(36860700001)(356005)(478600001)(7696005)(6666004)(966005)(2906002)(16526019)(83380400001)(336012)(86362001)(26005)(1076003)(82740400003)(47076005)(426003)(2616005)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:11:08.9030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00895c46-dd95-418b-75d1-08db97e7059c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Please refer to the ACPI_Spec for details on the highest
performance and notify events of CPPC.

Signed-off-by: Meng Li <li.meng@amd.com>
Link: https://uefi.org/htmlspecs/AddCPI_Spec_6_4_html/08_Processor_Configuration_and_Control/declaring-processors.html?highlight=0x85#highest-performance
---
 drivers/acpi/processor_driver.c |  6 ++++++
 drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
 include/linux/cpufreq.h         |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 4bd16b3f0781..29b2fb68a35d 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -27,6 +27,7 @@
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
 #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
+#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED	0x85
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
@@ -83,6 +84,11 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  dev_name(&device->dev), event, 0);
 		break;
+	case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
+		cpufreq_update_highest_perf(pr->id);
+		acpi_bus_generate_netlink_event(device->pnp.device_class,
+						  dev_name(&device->dev), event, 0);
+		break;
 	default:
 		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
 		break;
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..842357abfae6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2675,6 +2675,19 @@ void cpufreq_update_limits(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpufreq_update_limits);
 
+/**
+ * cpufreq_update_highest_perf - Update highest performance for a given CPU.
+ * @cpu: CPU to update the highest performance for.
+ *
+ * Invoke the driver's ->update_highest_perf callback if present
+ */
+void cpufreq_update_highest_perf(unsigned int cpu)
+{
+	if (cpufreq_driver->update_highest_perf)
+		cpufreq_driver->update_highest_perf(cpu);
+}
+EXPORT_SYMBOL_GPL(cpufreq_update_highest_perf);
+
 /*********************************************************************
  *               BOOST						     *
  *********************************************************************/
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 172ff51c1b2a..766c83a4fae7 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -231,6 +231,7 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
+void cpufreq_update_highest_perf(unsigned int cpu);
 bool have_governor_per_policy(void);
 bool cpufreq_supports_freq_invariance(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
@@ -376,6 +377,9 @@ struct cpufreq_driver {
 	/* Called to update policy limits on firmware notifications. */
 	void		(*update_limits)(unsigned int cpu);
 
+	/* Called to update highest performance on firmware notifications. */
+	void		(*update_highest_perf)(unsigned int cpu);
+
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
-- 
2.34.1

