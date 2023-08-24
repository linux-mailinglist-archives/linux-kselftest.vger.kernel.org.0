Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB92786532
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 04:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbjHXCOs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 22:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbjHXCOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 22:14:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEC410DB;
        Wed, 23 Aug 2023 19:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giTkVfkyeMvX8JMk8gxVhBhk3s0qTjPDnd6GIGgyuwqc3BiuurMPfSYaKDguAn5y+85k/fi+IS1kQOcwRUTh7kqlV6Hd/ntKjm4NtxPlUQkWRffEtQ9lHmuyb8eS6spKjmRterRBaKcQtMoXoLHsdG7q/kEMRMXUqZ0GzOmsnjqjlX/1dSw20uJhxq/x0Z9bRYnBXUCLlC6X19vXW+9SMBRdMoPtWOaxm00lHgAtNBXtWaWdJIT3Ntc8nHV9uBVAOYswiS8Qzk/WferVQgG6akHS/JcOjaWa0BlfAUn/mSwVEOOauJazDqPwTMoCXrYIJvpF+GnsHu0DCAIvUqbwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeg8ZcyDn4t8Y70ZJHtotz35t0wSh2z3U3cvlssn7Zw=;
 b=fqF6J0cGRzvTYO6TNFcBD6EPP7qmA6J4IwmnlN9pd6UDhaBIWYylPJRmb4DkIYxWzjCho0qUHxhII2hVVY6UysacsKr1cCsPNRUUMLh8Aw65blf4YayVOhkBjciF0hb/JxII5gj3278WmREI1pe2bFHCIv1SIOKrYsaBmj2tj5IpeUA87Gqu440wfsmPGgwLu7Qnv51xGGWd99Gm4Vae+YQpCgpe90lvHIwg9AGjlmJxQPUitkXYs6HhThGOJBTLQFtFsusxcap/d60sslO0NfLvs6fvmswIS8rIwiXkO8feT0vAOQqAz4OeLA1sbgOobf0bKA86sbmYw/TaMjTR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeg8ZcyDn4t8Y70ZJHtotz35t0wSh2z3U3cvlssn7Zw=;
 b=5gs/zaPcfPLC5tJNEdLV5rIQUOO8OOp0zjliNFrXmrsdawIKjJ2fSzgXiVPHOSjtuwhle9pl+4qjgOfMpJ4hAKGcG/Iy0d57Ab4dufakM1hJZgYNij78BEjccJ8JFJ52mNQ44PSIuArpx6fCn4T1sxJXAx43Rwcvhb7VG5xqAU8=
Received: from CH0PR03CA0440.namprd03.prod.outlook.com (2603:10b6:610:10e::29)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 02:14:29 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:610:10e:cafe::55) by CH0PR03CA0440.outlook.office365.com
 (2603:10b6:610:10e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 02:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 02:14:28 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 21:14:19 -0500
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
Subject: [PATCH V3 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Thu, 24 Aug 2023 10:12:46 +0800
Message-ID: <20230824021249.271946-5-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a97771d-10e4-4a4a-3494-08dba447d8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18zy6u/wRDdG741J0hrwEsyybsIJULAxu36dSxrMxC1865JHo09zh+BEOMAk112YDTdyr2MDQLVtSjUnEfbHv/0HwFuE3H8bvHFfcqg7sNKHCcFqIAt/0if8U5CNpHaEoeXy3NCPa+Hop9h+wE6Ql8X2ZgVVYI/9hHcPhAE5Wvy9Tc7xAqLYCgdSi2/2OsZTUU1WD44oqfABNQ0dfN2pJXfDdXu30Wus1Cr58DhhgdpSCcxsDGHlMKGfgM9ikOdGyJQMbuiKCfih4UjgeuNs3R7i/dUm7A0WpyjH0xalQIFoBBaT75B8uexd1xSqH5HooECpFh9o+OWh0U6mCCyEJC1rUttS9Fx1tKqOmIh0jCekuEjWGuV69m+Qjlo7r2VlJpBRgx70DHnDCmM5EHa07lcNolXOj7mKn2ad1oXUhwesv3K01OSZUCEZa0X03BLe0Vs0+7k8uM7E7tu2f8RY2P4u7MYmuISYqpkho1Nowj2q+jZ8t0GH8hoabrfImsnL/BHe6fw5Jv5YHQPOw1tPp+5JrauUkbx2ZpSpP6Uutd7MeQ1tOr9xZ5nmjhgIs3s/JBsdRM+VMDMZpceb3UYMOGLc0ytN6i+4tjesXyj2HePTocr54ug8Ovv0uGLgP61fPT4LkGK08+a1gbPmGZCu6EFgf0BGE29LApLfnHv1ZwxOax8q992zlpxwnYpNKxjefdmUug8xCX8FqvAryOX46uXWfT4y99Ka1eeezVToejoD8NekhkjfywKGfYbSgA9+4sDTaTlqa4InDeXQbqgLYNkv/UMLM4I1Lmyb8wK1nPw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(356005)(82740400003)(6666004)(81166007)(40460700003)(7696005)(336012)(426003)(1076003)(40480700001)(16526019)(26005)(47076005)(36860700001)(83380400001)(36756003)(2616005)(6636002)(316002)(2906002)(41300700001)(15650500001)(54906003)(70206006)(70586007)(110136005)(5660300002)(4326008)(8676002)(8936002)(86362001)(966005)(478600001)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 02:14:28.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a97771d-10e4-4a4a-3494-08dba447d8ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
emmitted to cause the the OSPM to re-evaluate the highest performance
register. Add support for this event.

Signed-off-by: Meng Li <li.meng@amd.com>
Link: https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#cpc-continuous-performance-control
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
index 9bf94ae08158..58106b3d9183 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -232,6 +232,7 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
+void cpufreq_update_highest_perf(unsigned int cpu);
 bool have_governor_per_policy(void);
 bool cpufreq_supports_freq_invariance(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
@@ -377,6 +378,9 @@ struct cpufreq_driver {
 	/* Called to update policy limits on firmware notifications. */
 	void		(*update_limits)(unsigned int cpu);
 
+	/* Called to update highest performance on firmware notifications. */
+	void		(*update_highest_perf)(unsigned int cpu);
+
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
-- 
2.34.1

