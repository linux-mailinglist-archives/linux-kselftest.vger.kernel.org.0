Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3B478BEB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjH2Gos (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjH2Gog (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:44:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54D19A;
        Mon, 28 Aug 2023 23:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVd6uEoMzgwxCyjohRuQx5QKSH0qjLk9UTWEfNi6Sd1wn2CTfvzC/lNIao5n+Azcb2NTdog9LdGREwcV+hYDx4L3bEdzIyz6dZysWuoospLV1018ZvZHJQb7LkIuY+9U9FpVBsDgih2Xag3bgw2/E2DIgqQZd3NeCQkGipGafWGZ9dlwzuCbSdtvaeqgcruejTSIhO2h5zRq8zhh20C85qZtofB9Gqv5fiCOqCjNnC+24imW2vp9lF/PP/Z8tdZ8Qm7O7npsqeDa32ivrrWkJaZ+SRnBFrTXDB51KlHIAOHfXTa8YOBtZCa/aH7Caroz7Ka1s6wMEH7rqL3GxxcJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeg8ZcyDn4t8Y70ZJHtotz35t0wSh2z3U3cvlssn7Zw=;
 b=dIaKoDMkQKDD4NG72R6X3tvMa2MjkLIqp159vSI+LHgF+1G+un1sg+61is+8xT3f2CBLa2gL77GlmrleYRPAD6WkPikCrKiIgTvB4qyFFwvs2j/2i+a/FFKdk8O/KwKR+koZvaykfvZMUHsUIZZIPPoCY7DpqBLvSMfkxRIj+RTMHHUnupQoN0HA1B24ZF/50D5YEDIcPmMBCpt8yqfjl+G8nztbR/r7zAHqZgTXRzqO3ujWyO0evuzXNLI8wMnW9rFe1Ffu5/VzujejsdllBzOr/hqrkAgF1+UcDnxPyhB7xEMquUaDaGnN9phaAHt0Snk7njudD+qdHawwJSdQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeg8ZcyDn4t8Y70ZJHtotz35t0wSh2z3U3cvlssn7Zw=;
 b=Q1ftVEljU7o4CEgKjyHxySuu90vxlLeChsdG98F/9FcITEQY63Kuq0F9GpGsjfAd9pq6c+LIdKUayWLrpjkfKN0lnNt6tbefWsQF3xDQGPjHZVUAqKigU77TXEbdCImr4pGlYj/FZ6m87xAs1Bjc/2ZCrXvGkxJZ0BsTAWkbGXk=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 06:44:29 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:44:28 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:44:23 -0500
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
Subject: [PATCH V4 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Tue, 29 Aug 2023 14:43:37 +0800
Message-ID: <20230829064340.1136448-5-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 9068fe20-67d6-4d2a-9a0b-08dba85b64d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kp4MfXwW5EySTHbAYcaJ8OLt7P3kmCgT/fo5JLvcns4p61mUs8tr3s3aHGbK89AH85bKntk1Y4kbKcclQABaTaS+/3Yw/oJ2Yw82hEsPWPAZHAxpw3Jdy0cjgdhxuI2gWF1Yc19Mv2G6HrFRS+gh9AQlAAh4pOWmpMJxTiPl1x7OtAZDhLJVsJtDuO5PxV2qAypD3h4cxJySW9w7f3fObIzvwSpMpJyM1xY3J0Q0/yS3fe12uvFqlN6Cq/JvyFn6qCEDTfIhD1UR9geM4CmJrJ2w/gFszyRG4RNDOcdX/pl1rlWWp2HAxwSs+DRl5HsvHYpvqZ19uU7A1a0TUbaYxhwebCu+uUGNka3sziQGw7fAIXvMnRGiXVFmnWY2b7HrK9jciEq19cjrDAyNZAj2cibCIgW5CleJLqWlZOffC0ILERAln3HdZcJYusDpi9PnQu7lt2heur5UjcBndoYQujUsbR4P+rB0cDfzhwGAii5v6iVqujDlqDNSOzza3OgEK2qjmngPbDtLr878kn4yVkd9wYGszUZ1K8EKCL4pI7309bCbmN3b/cQbdqmQEjwlXsGpluoqZ43v2vpqE2Rij/fyP2JOYkVcn0Asgkgi91iWA5JF1lsgjSXU139Vqq2O22U1IovwG5MVyD45boYTBV0sOTmgIXt7tirCBK/b1wsXS1+YAmwDt1F3KOH/jxH+TjCvSmtgPRzfeNfPpgLgIzb48rAy/Pkn4FKkN4vhbWEC9lh56MdzXMiW4gpVXVDIu+A5H0AhOq/EZa5E6f+dsDr/hxM/JBkQutInF6tHnMc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(82740400003)(7696005)(70206006)(110136005)(6666004)(40480700001)(40460700003)(36756003)(86362001)(47076005)(81166007)(356005)(36860700001)(1076003)(2616005)(2906002)(336012)(426003)(16526019)(15650500001)(83380400001)(26005)(478600001)(70586007)(4326008)(5660300002)(966005)(8936002)(54906003)(41300700001)(6636002)(316002)(8676002)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:44:28.8130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9068fe20-67d6-4d2a-9a0b-08dba85b64d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401
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

