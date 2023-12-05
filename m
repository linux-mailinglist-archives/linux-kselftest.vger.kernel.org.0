Return-Path: <linux-kselftest+bounces-1113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69745804A58
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14E81F214FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A4610A14;
	Tue,  5 Dec 2023 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RCcgVCZp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41485FA;
	Mon,  4 Dec 2023 22:38:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3GQdh+uSW3faHocWNy4KklZRhulo6Vf8/tofS4cNZz7BOgmPXqR3YaOXLTNVXAXacqESxSCLKXl49N0k1GvaIeUbe6nBO4/wiTVlabJj9xvehIPrV3uzsWOFxS72Baj+ItV2buiwlp2nSYYgKRbkKROv/ulFRWrgFqunF6n18b00+I1vnBAYNsYjTARwpmSOpOtBSOZzlUj3cpsGqgOi72JNyUs7Rs7WeEazF/mec+o9PxOrHbcZTYID0wXB6Wp9JnZcilIlt6agPGv8XT9PFIbMFtgLh3AyhfDePaTaeP3JsixKKBflJj1hUWoFNidaeRG7K/9PG0Pz24mXfXEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5Mk/Pmr691XK7NaMy3vWvMLF4PXHaH5/AChBpT75o0=;
 b=hYX4zDDB767sM6jbJvnSyv1XTQ+5WPznoX2QpuLtCa9d1iHiz7e5rQG3s7gIgL1X0XZL3YuWL1dphh16ZyBCQIEjLmD+pkcwEc1KH6Q+Kp4AM25nvgWZEFT/LSZP0sd9JYriPoke30G52Rn147C9lzAXRaNbhp31LSpMbjvCQ5Yo0Wno9Ud43Q/qSQe/WFryoJuKwwUg+QVj9NxZavtMmBuCovS7Tdmz2dUOKHO4uQHbfyl4guyI03A69Xw5gZTvM77wNFo4JQFJbEl0rZQWMhx6dMZhpBjcs0y9WCpvxnPLRHeg9JGAV44i2ynHNoYt2N1Ecynxqb+b99YaHTDuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5Mk/Pmr691XK7NaMy3vWvMLF4PXHaH5/AChBpT75o0=;
 b=RCcgVCZp/Di8takhWu53HNlM0E4PZgIR14XfhvGW59+b/qG+hMRomRp4Y1wu1CIxIo4oxj0hXccIjZaQrekvFYflm8o8zA8v0FoCV5W18adqV/lR/oO28t3rJA3gsAaeUow3COim90k1Mn+xPkGSPqnKv2ABJjFszdIjr3cYLRU=
Received: from CH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::26)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:38:37 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::9a) by CH0P220CA0019.outlook.office365.com
 (2603:10b6:610:ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 06:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 06:38:36 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 00:38:08 -0600
From: Meng Li <li.meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Huang Rui
	<ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>, "Nathan
 Fontenot" <nathan.fontenot@amd.com>, Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Shimmer Huang <shimmer.huang@amd.com>, "Perry
 Yuan" <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>, Perry Yuan
	<perry.yuan@amd.com>
Subject: [PATCH V12 4/7] cpufreq: Add a notification message that the highest perf has changed
Date: Tue, 5 Dec 2023 14:35:34 +0800
Message-ID: <20231205063537.872834-5-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205063537.872834-1-li.meng@amd.com>
References: <20231205063537.872834-1-li.meng@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: a566373c-4b6b-4f7f-f900-08dbf55ccf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i9a90ojb7EjoYOtm4M6sBW9Z4jxcGG4YZw/oBRFC1ExXfsaBkR9v06WSQa/fjp+Ih0dKlr8ZTAtqcAe+BvqM+34zxq+mc1bZGsZG1ek5yy1iPhEgOZI2xoLNUJJ0no9F4Ze82K65KFj6l9UG8cCuIYTwxaKpQDPmR7kjpFWlDClHD/wrvmqcalMuxtwt/LjGRJceesvxKvqTkGleJcDRQHsiFkMaXqAxHTo2QmLpg0bgmP6ZQephEOGewhQ/tOMMpTwfwmp7Xedfdt3MwEQKmm2ElOm+BmWOSedpaNAWs7XPRWNXFd5Plkqe41mtFOS6Ir4PwqcGSmuIyLTPsmr5kvvejftF7UF7E1bN1Zq0dgT9J3swXod0X70roFGznQUjyuaDz2VFD2m/yrZLKdlawqcW4Nt8QQ3P7Bb9v0+FcMCrmw7luQ2ydZ+Bfa2bb4Gggeh4dfvqc0xdiTAtxjlDDMxjS3iqKvbua/wc76nPHn/P6Nm5zhKKMKdx/Siq4CEKm6Xvgw2X67AhD1AYHHv+JOYM4L7tjqCftxI3w/GsJk/8A8BcsUOG+WwuZwgDVvKpbQKNr8KODf2r2GB+aEQHuLr2K8zYPbEWT2dYaW2IUjuMQemdqC+TTjzqczPZxYRTAAKsDkis85ctsVOa69lecl2wK8Ko+ZEKe8iYrVc7xdB6ZqZ5qBJTn4cex4ZS7vRtirMcAqjlu3hjqKb43zxYbIYoLs40WRqN4tfur+Ejal+VHBXgcUMzXwzOfJB30gOit3O9hJ6Jp8F13VynpwOOiAImr+Fjz6mlU3boa7fPSrI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(26005)(478600001)(966005)(83380400001)(336012)(16526019)(47076005)(7696005)(6666004)(356005)(81166007)(426003)(1076003)(40480700001)(82740400003)(36756003)(2616005)(316002)(110136005)(6636002)(54906003)(70586007)(70206006)(36860700001)(5660300002)(4326008)(86362001)(2906002)(8936002)(8676002)(40460700003)(7416002)(41300700001)(15650500001)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:38:36.9604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a566373c-4b6b-4f7f-f900-08dbf55ccf83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
emmitted to cause the the OSPM to re-evaluate the highest performance
register. Add support for this event.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-device-notification-values
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
index 934d35f570b7..14a4cbc6dd05 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2717,6 +2717,19 @@ void cpufreq_update_limits(unsigned int cpu)
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
index 1c5ca92a0555..f62257b2a42f 100644
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


