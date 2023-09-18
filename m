Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240277A4471
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbjIRITA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbjIRISB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 04:18:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0001CCE;
        Mon, 18 Sep 2023 01:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3geTbYZcSYPDXbtESoqrdUYlfojnQ+mUOrO4eTzmPMMvujmLMw0Y48uFNfOtcftL22K2i6WeEP+t5whNHT54m4+EYryxbGAYHEO6eyfzfUKM7sY1p3ecLk7TvzeSJkCS66UBRzAep4tEEbh6Nso+Hz+9FBronGELnoyPhEKgafjalfqOSVTx8G/m0Kn245WTyrLZHr4FI/i3J7pCItLgW8gqoEbZn8S99zlwat55RA11BMlW1dzQ+WOaYbEmm1UnI2BY6LWnsCRWmlRrqhsSVIUN9SrCCO9X2XnKjXSakl8IlXgh/S8Rwh07CyluDn0lw0AaA38M9WX8YpmKAJodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUfFVYO1h0xYmkk8WkmHzLQ+Tt+z0gOk/jevQoCQxGY=;
 b=XtGUGg8EDlSG3r9yxI0PV7MR9SXsa8VvaeYAfBuOXWDpOfLESa8CIZ3bKWPT9crTtm590p8pnX/1OXA21+6/QS0MvR28YrueNs6xdiapnqt25MUYweKTvzV+TnpGRT6MBiOrespOy33qKIYPhujQbsbxatLUWTKMrciDjTxIJwA6+sFmCTfnNdTTlKCaQvIFtPmrLZ+OEgQZEafUO/C8Gpai6sRGmuYcol+GlWWsPQHhRdN3/GIfFpYU1HpNenS/2zDMUbKz9f7PmOv3Wj0IzSspzGAxTQUGuAc4ARHQR/rqIdk9iOblH8vdW/X4wEBtsH06aEgADpRJSjdR1/pZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUfFVYO1h0xYmkk8WkmHzLQ+Tt+z0gOk/jevQoCQxGY=;
 b=XzRZhmJC1Q9aHGxi7CK0el2UBl7hKbELmRFVOhDH0cEPfBtm3EEJQCNrJUzHypT5duVhe6wuOSyFgrD1pa6EzN/HxbJWGOnw7Cb1bJKeKbqsB/FvcRae+PApVAzaC0mzmXHwDp9SL6cvayMXGGzm3yhu6xap/9Hv6gV1TnnA8EI=
Received: from SA9PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:20::17)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 08:15:25 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::a4) by SA9PR03CA0012.outlook.office365.com
 (2603:10b6:806:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 08:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 08:15:23 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 03:15:17 -0500
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
Subject: [PATCH V7 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Mon, 18 Sep 2023 16:14:04 +0800
Message-ID: <20230918081407.756858-5-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BL1PR12MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: 1202dc42-8bc7-410f-b7e5-08dbb81f687d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5JS4/4spnPfBBhFJ4Y6BDQE0vSNeLFhFrnBm4cu2x18QaCZmz/fmfS2kux7tA+kXqTpbpmPDPIw+MDhkwi2rETOutGCzr/A4mnNFVelrixqRexQ1N0jA02GSpyQ/bHcok5p0m1JHmUj2demctdfOkjz7rUBQsu6QhjBn2QmBd0Z57Dm6dVmfZ23pddWHmRW/LFaT4V66iEKDk3YVvG4tQEgOZoI/ugV3M/0QNxFcFgRebuH/5N7PrZcz0lpTGDwUJoIOgyzLVEpu47hGfBLsnV14vq11tfMJi1mIPU1GGZhViALEFe3HKOSEgID448+IObrKcsghPLtSdgt0lgfJ9iF2Y+o3Z7lb82fwTMDpj7Mi3CDiRSS1HoA8MOE2VlqeW/Jbusgj8zI/eGeX3AHtYTHL5lkZYkJ5wi091vQgRUUJaycxW8sH7KeTtkHundgrhBKrNjkOmxAF7I/fHTmjn2mqdqDe2geWDgW629r/wG2hEA8W7T/vZ0cCW4GZ4CwWLeEapEejgGP8vXS3Z7aMgrfgd3Hyr0j2imUp0FhSqucVEt2vUqqjaj0PTZLHHezHR+pLZjOn7IazXJINJ4zFW3opQY0vPCYTZgbKZYSihOeBbvqaug3tQMe2WhUju6qZ5K5N70AdDuqBiunFx9zUcM93xi0yulG/m976OCkJpPSv81Rm6ShimdoPaxcQZF9kBtlwGRhQnI8a3hw4egWVFi9joMlEnVb3lJkjcuS+XtAYfBoPAj6VTSGgB0vbOj1Ie1/QtrDNDNd29oZKkVjKRa8537VeZR2f2GMR2MyVbw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(2616005)(40460700003)(16526019)(26005)(1076003)(7696005)(36860700001)(47076005)(82740400003)(356005)(81166007)(36756003)(86362001)(426003)(336012)(83380400001)(40480700001)(110136005)(5660300002)(15650500001)(478600001)(966005)(41300700001)(6636002)(70586007)(70206006)(54906003)(316002)(8676002)(8936002)(4326008)(6666004)(2906002)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:15:23.8998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1202dc42-8bc7-410f-b7e5-08dbb81f687d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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

