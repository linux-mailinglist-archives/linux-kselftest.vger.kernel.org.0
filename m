Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F97BD21A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 04:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjJICuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 22:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjJICuw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 22:50:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00DA4;
        Sun,  8 Oct 2023 19:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PangInJExWdxPNq5SvFS2wYeIStjGpDdmPeSmuL3ia3jyOxKnuLlLYrQR7ndetihjcAj3fwrtb5VFNLjM5kZx0K44LXaOhqURRcqhcVndBOaxNoyZBMwcGV9GhotsRlaEA8u6Qa/wUnohpY3Es0BLE9iHovUjlcyRNVikskv5LEKIhZvw5ZSk01ip/5BbzhJe+KXdKzD8HLmBAec5Nx/3x5NVFREEZnwmtcw/rI1iTRxiWMPU6PgklCjmuV3DmD/dMdz1q4aqbXK8CV76Ll2ivLb/K1Qs2NkgteVpbFmj7ZYF4pzBSrH1pEMAJ4qVEJ3CTnuxIo4x2HtMMMGq/8PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVQLDHlBFGN8eLlpQahZ7b53ooTJ5WGoPWkmAc1H+PA=;
 b=FUPcWW8oLSC2gGuP0UbHsK5hGEShGAvU5z6qOS/KqGzbyq5FJQLD4CiCK9py6KTeCCIv6DKmmlcaEUE6Lb+ZGVvMTpP+OBimkMnMfYNXJosMGzHXBw7sr77f7/ncUvnuEzpKat746dLWReLW8ogZxQSqFSiw4KUEskxH81vVzHp62g3XQ5hsmhHGhbaeLnm69/BwIb6ahyi6Cfa+FrydXqnwCJ2ZT561TIoJGiYJFEBpHQ3m1ukYDZlznJ1NoPIEwl8MFe8yGkzdn16fregydyuQYiFSzIFXWYW0FtIEiiDjCZOHoxDa0dr+582Bl33HduQUgxZm693SSLR5GGYCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVQLDHlBFGN8eLlpQahZ7b53ooTJ5WGoPWkmAc1H+PA=;
 b=A4bq+PDUKBwpGcurO8a9hvyh5NZBVG6TH5BPBWKrfl+BO6fGfNQ8EymP7WyZUqA4hAZKQToSX53V4d9MG3dlAMuD1pqQlBQKF8i0nLBpwS+liLk21PrU9cJXiFcdjwmXE3vWbtbak2m7XIwvzQM6q71G/HxUfgE+RtVcDZUWrOw=
Received: from MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 02:50:48 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::bb) by MN2PR22CA0004.outlook.office365.com
 (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 02:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 02:50:48 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 21:50:40 -0500
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
Subject: [PATCH V8 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Mon, 9 Oct 2023 10:49:29 +0800
Message-ID: <20231009024932.2563622-5-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009024932.2563622-1-li.meng@amd.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a8c133-8bd9-4828-dddd-08dbc8728ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdQSNtUIqBL0+ONVH4HihnOBiXdlOG3joIMjJglQ6idBVDpI2XHeqJc5PctPBESdi6tWLaj2hIMyBLTP+EsNWkGTqFkabrOEN48v1gFmQh94E9rjMeksujo54hX9I37XvTA3cYqQehFlUe3zTJo4GeuFrqIUOcuxKM2U2lr761eVmb6NnjGQqCJkHFv6+bluDUrju6Zx4UBaMXOVLsFg9BQpgiBkIAr4TmpOJ2B1TJetszoR6g3jmoeeJiJtS0MjtP5jH1C4uJ2irppPlSY2o7CA6xfKOjY88gdc18QtfRSUdy2Vcc/OpaNm9NqoFT8JHuCyBJ/eaagn7UguDsJFaTPfl7Zs/7+4zMweZ6B9OlhCSNfrcfQaFVMqp9WfRd8Y16NMCj+04QsF5bKBt6CGPFc+TJI6g5/efgxzc9RtXMpZlko0fsPDOTozg9CdMIfuwYKTgt9Xn8A4rHpxie0oFW5aj7el1f/b4HfyY5AeTRu7SxfBHCkjHawi4/q3Rb8/S2LNKbjqrg1cSDfrEvKm7ddNWEtb9gCusP1B3vZt4DIU4KzoEmZLttyunrOk6tOV8NIyYVpBX0J5H5Pq7nVfClgRBZ3AvZnQN2v1XIrdR1P2q5FgdD12VpDC7gzv6hu14EuqxUrQieFQC9O+95/3kgB6d2x6qYy1UT3pBFQZyzDZc+n8J3ZMq1yTTFMEXBFqvjTvG5jScd9ZtYj3w6PtWkTLasgwF6pzb+CaKfbXLdr7A8T4F+5T+4HHx3bEFJnh9/9/2uYQMsV6dbzQOFAnAqDKgPxKccGs1yRRV0Jrosk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(478600001)(7696005)(26005)(2616005)(966005)(47076005)(336012)(16526019)(83380400001)(426003)(15650500001)(2906002)(5660300002)(110136005)(54906003)(70206006)(70586007)(6636002)(4326008)(8936002)(8676002)(316002)(41300700001)(40480700001)(356005)(81166007)(36860700001)(82740400003)(36756003)(86362001)(6666004)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:50:48.2442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a8c133-8bd9-4828-dddd-08dbc8728ac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
emmitted to cause the the OSPM to re-evaluate the highest performance
register. Add support for this event.

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

