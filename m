Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4337926D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbjIEQHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245137AbjIEBwN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 21:52:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA552CC5;
        Mon,  4 Sep 2023 18:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAFwX0oGDYa3jaEko7nhw3KV9TfZYM1abZd66OYO0wQeEHq9WBCYVsmbqcx8zJqR/O6blT2sl6RfSpia1aCHJ4GBaG0qry0Xmt+5IoSiq12kfrIAw2AOfptj52vP7eZMdv/BzQlU9fWyOYKacHPDtlowY30sQTkw27ePrDymtJsQJjIAJ162MuPWnwxWDPASL91foCwm7ghlWTaGFYfB+x9JVeCbKujq4UQlNXaat1Hn8ht4npDwtctwRY6CgceaYnvqKY3p4pbw6D1CiDvaRh9IWZlFH1KpZK5VJaXOx2a1AICaHccxGjfrXtITDqSeNWriPXBwSpfTQqpXxzxuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rYYjru5MFpQdUVUJLzWNg5oNLj/dmhUp4r6eeXJ58Q=;
 b=Aml8ij9saqWuxC1ZW/P3eKzoe7rnrmA1W3145c1VNHquMGEUOblgaciB361TcS4y4426lw//yf5A5pFy7ogMdvFo0THEKWsBrlzOMI5s1T1CbMLZqHI37ezKlrjPtaMHSEyivRtVoE80QPtmm6YCP45XzFix7JWJ7IaWA/j14xJ1HJXOv88m8y9e5K7qpmaqz5V3SMKIiDEP5UPUmOkXTnzWBafRXkF6T/vzAe/oz+A8emBoYrA7oZdWFRpHxbDNuvnXApyMAyEKi+IDkoUN+B26Gof2/0hkHIHrL5UXiJ7PaJZx5MZBowO/XW06Eq+xbZfuD3bsASEK5ToBVIhmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rYYjru5MFpQdUVUJLzWNg5oNLj/dmhUp4r6eeXJ58Q=;
 b=tm1weuOfdxnfdfLtdw0hIcB9rY7r8jDdRhjkhu4Y0qRI7Lxd4wP3YQ6TwpcpoobmC5NtWJ2XcjTXuj2MRsQmp/aKj+wQU+REeGYPvkBaC+pZqpxZ9Nfa00/5xJ+feug7XZ6mK8Oghs9Pt4Ptso9zvjgltuwOdZ6mS548N/TDM4I=
Received: from CY5PR18CA0059.namprd18.prod.outlook.com (2603:10b6:930:13::22)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 01:52:07 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::cd) by CY5PR18CA0059.outlook.office365.com
 (2603:10b6:930:13::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 01:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 01:52:06 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 20:52:01 -0500
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
Subject: [PATCH V5 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Tue, 5 Sep 2023 09:51:13 +0800
Message-ID: <20230905015116.2268926-5-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905015116.2268926-1-li.meng@amd.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BN9PR12MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 60923eb7-b5ce-4e4c-d7bb-08dbadb2b5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+gKFbH4gmmeGJUbB35E/2195MHfBk1XBEZE/4+MuIKhrjFdyhO5h7SPjzkFGbJRB8TF4tQ6YLsGFx8DCpUU8A8XByrCraulDeRMG3+c2ibct/Gys9gFNCqNqA+gloakR34vofTUxaflsIV+qF6Fu2bOna9hpIkzd3yX0mXNYh21aDAqec9b+r4uQ40WBQVKgVrFlCV9lZwY+mA2F1utUufnMTisrCuUvHArBVpeGhoPQya4KaECSket84ikxzVvK+C8vQLXEBtNJRWrfT4JN6bBfKR9rEsMVf6XZRBywaavPVoRysnI1Xc6EqhWsaLg7W6td43EctBpfXhoGUzlWG9wxDmlzYTEbtoFJcdEVFPf6EE9SHc+TqSO9erHUnB0V0xEUhm3EUgC+iQIv9Jnv2YjFzLrjI3aHHyeXAaAos3dT5/lf4y7UPYH07ZWlZ3/xwkHfxfsEpGNW4yNihxRK0r+pVSxPqkNSA6UvmAmIWallMvif7EPDXo9xNCVhdNxfAKr1nwpiQpNvlax/pHaokAPwC2/VvWdA6K73FglKZd6PO6uVSn9yxyXxUf5X+OfxkstW3q7uRDEFYK+EhT2NBnqn02ru9of11//kdm055nCwPDvdq9pN3fKcXFkg9LOWezO0xRbSZQaqvM4ToWorAwYrSjZYA9iJqq7uL6dArsBkR0YKSld4I3xOUs+KSvDUlcijwWPVrKymeLyQFp3k7odhk/KmWmESC7/IHq33yTwM//3EWF54V47I8Tvi3L4idvO4TluHKO1PVMypTLi66Ad8dAOfPSAudP44/6PFIQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(47076005)(36860700001)(40460700003)(15650500001)(2906002)(36756003)(86362001)(81166007)(356005)(82740400003)(40480700001)(41300700001)(7696005)(316002)(6636002)(54906003)(110136005)(70586007)(70206006)(4326008)(8676002)(2616005)(1076003)(8936002)(478600001)(966005)(6666004)(336012)(426003)(16526019)(5660300002)(26005)(83380400001)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:52:06.6118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60923eb7-b5ce-4e4c-d7bb-08dbadb2b5b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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

