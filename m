Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DB5798378
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 09:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbjIHHsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 03:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbjIHHsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 03:48:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393D19A6;
        Fri,  8 Sep 2023 00:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrYBwqNSeyveJGgCmaflfWRa7GYbtIqnyf6XZy0G6JaVTgxSI3pEVk08pKi+KNTK2SfmV96uXkHF16VNv4dmuOtSyydgC0ESte8N/OAc9N+Fm3PoCBYPQjWQ3uKV9psN7pbHmUZ5BUOHijOajH8H07sO/ldGMLiHIo9BPfOR7I99+uuIpAFTUmmPeYA9Sxo9XmQiWYvVMYvw8ZKVtLzefRfQAf9Z48AkT7tcin3cVcPpluCqA7SabCabfOFcc7D/uxRDoaUP/lauz/BsgimvzwLEcgnEFMkeyJt/x8/aohmEy3sVshcyjNs9dU2bx7bBYQWk5y2mYBe3r/6ujCkCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rYYjru5MFpQdUVUJLzWNg5oNLj/dmhUp4r6eeXJ58Q=;
 b=X+5npeJh3Q3UmvaVlhFpjNRXzEg5934EcJCTOJO3lF19tFvhSWpD2hxSemO2TItyigaMtI/Xmz7Zaz2cbJgh6hnXMISM4sTT+bQZXwXBoUgnjTC8/raBmbVw/3rMfguQ5K2uTL9AD9uqpyZeeJFTgohT8K8RyussN4D7YPH70K4vrYpurntcLY7hNvaEUuZ6X4t5wyha4ritEiX2S7GOZXp6FnE54FLv/ixvaWM+kWJR1JdFmISWdcal0cftXukZLRseGyuzLeEO1KxwC9JhPH8SnmPPLziKebFBLt2GrZR9RxwBZtLz/2hVrF8IXEltFDo9rRfqOn+qRGbYRqFlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rYYjru5MFpQdUVUJLzWNg5oNLj/dmhUp4r6eeXJ58Q=;
 b=0ycYZGRllKNAaHm5lDvUmxkxJnfMT/r+zZan8wBFLzAtFntw/wbvfpD/o62/LU2U+673G1FJs3S6ly3CkNKphtZ8BG8xB+ZdSE2Bu6TMGJqo+flEexB7tecTHooy+c1d55HlOhd7errcHgdhoGyG2OrRAMtyZgjUtlu1uuf8jVE=
Received: from MW3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:303:2b::18)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 07:47:55 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::98) by MW3PR05CA0013.outlook.office365.com
 (2603:10b6:303:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Fri, 8 Sep 2023 07:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Fri, 8 Sep 2023 07:47:54 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 02:47:50 -0500
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
Subject: [PATCH V6 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Fri, 8 Sep 2023 15:46:50 +0800
Message-ID: <20230908074653.2799055-5-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 194781e2-cfdc-47a2-48e4-08dbb03fe97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7MZyPIsOK4MeSjL8ZLsBbL4RqgUaPcZ64VeqUjXPuqq9F7LS6KbBi+WbuoUub/gYt000HfjSDWr02IA4pA2Iodi/XXtC4q78RGgYyWkX/XxzmE/z6UoZUZ95PT7lGuNrsu3P9Lgz9oloWKx+VQLIsBu43piMvgUT+Rp9YVs1gpn/KY/z2+SC/qfqj9zUGrVg363b3vzf6bnGA1a145KDOqPSHIUTGzSZq04MlLDg5v9MPK7NpS5LGUVDsoM9IbvED0bwwoJOzBFYhrdLdgGzlm/zVYLcRgP2/M+tA8U/lDV4DQybIuDCZ0ygDuauqkQu7Mdsold0GyJmqPPjdw9ZFDQs2MOMkgzPydnPODr3uoxAWIt1Z0u55qGrql2AwGX/AyX5hKZ7Ld4MMOrCDoYdWdjK38yn25qWbiET/1530IvewwIvRummf736929+KSVMzyicuXx0fqCF9GzrUnZ6jmGvQL++X8LscH9CKf3Np/WaiMK6MJ0hvbFhQUcectVbBL7CCibOZuDJ78m/1StJBk8CB1k5319Fr4Q3QeBaB+e2au9SK//cGMjAWgW7nqjaDNQ8ZDA1fdx6As49lWNvnt5z/LWd6zec1o9QekY+OLNNBQn3hIBmOPM5pB8Ep1o8IG2qlzkM4kPqegsJ7l2u1tBEpbXi0Hmvv2VlGfCQpK0B5ZVe+qAQDZdyWaIbhvhj5f3ul1keONNG2sce0UaB0fLfrEzjxZdO9h7X9SrF9cTou72XKRXhck8bV7S0Z5g4izvLCc6ZlxJFvv5c/TLjLDvrha1kGEcwRYisKJtY/8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(15650500001)(966005)(8936002)(8676002)(4326008)(478600001)(110136005)(70206006)(70586007)(5660300002)(83380400001)(40480700001)(41300700001)(2906002)(54906003)(86362001)(316002)(6636002)(82740400003)(26005)(40460700003)(2616005)(356005)(1076003)(81166007)(16526019)(7696005)(426003)(336012)(47076005)(36860700001)(36756003)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:47:54.8093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194781e2-cfdc-47a2-48e4-08dbb03fe97b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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
 include/linux/cpufreq.h         |  5 +++++
 3 files changed, 24 insertions(+)

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
index 60ed89000e82..4ada787ff105 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2718,6 +2718,19 @@ void cpufreq_update_limits(unsigned int cpu)
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
index 71d186d6933a..1cc1241fb698 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -235,6 +235,7 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
+void cpufreq_update_highest_perf(unsigned int cpu);
 bool have_governor_per_policy(void);
 bool cpufreq_supports_freq_invariance(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
@@ -263,6 +264,7 @@ static inline bool cpufreq_supports_freq_invariance(void)
 	return false;
 }
 static inline void disable_cpufreq(void) { }
+static inline void cpufreq_update_highest_perf(unsigned int cpu) { }
 #endif
 
 #ifdef CONFIG_CPU_FREQ_STAT
@@ -380,6 +382,9 @@ struct cpufreq_driver {
 	/* Called to update policy limits on firmware notifications. */
 	void		(*update_limits)(unsigned int cpu);
 
+	/* Called to update highest performance on firmware notifications. */
+	void		(*update_highest_perf)(unsigned int cpu);
+
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
-- 
2.34.1

