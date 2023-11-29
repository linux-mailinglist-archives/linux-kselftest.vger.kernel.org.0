Return-Path: <linux-kselftest+bounces-802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52837FCF73
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 07:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC9B21615
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA60F9CD;
	Wed, 29 Nov 2023 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zH4/wNIY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B8A1735;
	Tue, 28 Nov 2023 22:55:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ansy1M6vfdaJ9qwtID0fJPhk6a5rEFG/3sgvRzKJRrswzV73XA3sceNucsi1h63vNeg2WSbI4HddNqDaklCwmgh5zyflwDuicq8IaHy4q8Yr4ZTPdBFPMhSQ1Kt4ID62P5MOfb1Qos/nP2qUkqNAT+GLgJnhXENUOb9LhdLuS5Y42bNtbCqxUVHAPJ1Oiatte7ykILwPUav7ajNT6mjVIWorMjdUXgDHLaf3KG3xeNe+oXvJInFaeNlR+S1Iiq527BJEcEl3O/W1q3TdC2DlQRTR4fEByd0SwdL0P3JAvt3P1kata5xYbMaHqYp4DPeewutIiIv0e3q9Qbel9UXK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxucxfDQdZKt4AwASrDVKfEBTnWdsqudDVSNFlm7pzw=;
 b=Rt+G3D6hG+3Fm7ylfl6UT+3QcSe6N9Bfeup7tFzULFsm+6kxL9AykRGJhL9RuT91QXofUMBDa1J+YbH6PAu2kH6OTHBDxbYd333deJg2dlkG4KN3A2jSgkokKifPqmUWXfByb+aVCL76neuYifRCwvChvkQDTNI7Nxt+G+GJeg9BDFKfgFHqIva7zg3wRFgygPgi8T5ComEt8p3k1NhEgFSQaDwwzc6otPMa/Pz+M+81jAjaki/otLPOXf1LjbLgZm0iM7mOSqehwwS4JyX0CF0vJJZPn6z5lepBcQrSrYAnXaZ7oL25r7Q5znhlIGQbSLMpZzIxjzRwEZrpBHj2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxucxfDQdZKt4AwASrDVKfEBTnWdsqudDVSNFlm7pzw=;
 b=zH4/wNIYLIAUKftU7mmtSZdH9RR1QBZ445GBlcp4KpgqoPpuyFI6rRuz5SNnh4RhalhTWteeyZNMjXZjzogGBIV8EQ6Yw5leC25TxQNJhzuHPqausimB3uNWGHgqouMTlIQPzSbhgqfxCOg9uwGF9TXoMpYBiVBEWBtZDUFjvdo=
Received: from PR3P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::14)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 06:55:22 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::fe) by PR3P192CA0009.outlook.office365.com
 (2603:10a6:102:56::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 06:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 06:55:21 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 00:55:16 -0600
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
 Natalenko" <oleksandr@natalenko.name>, Meng Li <li.meng@amd.com>
Subject: [PATCH V11 4/7] cpufreq: Add a notification message that the highest perf has changed
Date: Wed, 29 Nov 2023 14:54:34 +0800
Message-ID: <20231129065437.290183-5-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129065437.290183-1-li.meng@amd.com>
References: <20231129065437.290183-1-li.meng@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbb551f-047b-467d-dd60-08dbf0a82795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p7S5H+ky+iKAKMgMff1dN2yIxs6bzvSnStefVqbEfB8V1j6doAK74Yr4rMQmcuRDCM4GmNqRXB/YS60zAdX21LIcXV6Yhm+eDP0I0hRIz2qk4MGujB7OSbPCjHrpUouL+Ll+FLA7qb9CoO79Wc7lVFF8agwq+GfCm3Igdkr1KUZwxJ2Wp5TdbzozVkd9C44LKVBwN5PW/GVkHvnxG9lIYYNaq9O5I8RIENKn2W/briXlNmk2pl3P3yte9Yw4/eor99G2w7urWVALBi/r+gjmoAWG94i1ppTFEmn7tdJxa8YWT+1ATeA4a1ADokvtYR13P9ubLM3N89s9gveWArX9SsdPTD+lNt2a/RwdwdZA6OGajMdFfkiZy3pkMOgYEj259EguEEx8bKHoFjiEk7+T0hNDRlZnvVSyymnB4jsm+wOpw8Rx+azrQWbGlwvihqvgrYREl5+MvaLxnY14Qk5/AOcZDdeVJiWc3oVR6yhv10joWl44kW3UE/nXmcER5jg0WoDDucKDgB/4v4gye68WcmngAIjt29+pmK4F3GyrnbHQ9QvXKSBdt2mbgpd/9ZtDEYhLVtJGnZLZVORpYTeNIGzzzvM/fKmBFL9RisrdkLuYRUblTF/X68Zey9eDzrAvavn+U9t+L56XVQh6wXZCOkxM+fAPi7H8pDbCIohv7C3zU3bxFqYtmAnOjdfkhZiTiptAnvELnjSUXrko4tRMoO+eB2c5KB60yb6GxG4mB/kigVRKarQ0AgDSAxUpap84G8jU5jw1Aa80mzZQs8Ry6+aw9e9dfyRqjzshlbdTcBw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(26005)(83380400001)(81166007)(6636002)(47076005)(426003)(336012)(82740400003)(86362001)(4326008)(8936002)(7696005)(70206006)(36860700001)(316002)(70586007)(110136005)(966005)(54906003)(15650500001)(5660300002)(8676002)(7416002)(478600001)(356005)(2906002)(36756003)(40480700001)(41300700001)(6666004)(16526019)(1076003)(2616005)(40460700003)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 06:55:21.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbb551f-047b-467d-dd60-08dbf0a82795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245

ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
emmitted to cause the the OSPM to re-evaluate the highest performance
register. Add support for this event.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
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


