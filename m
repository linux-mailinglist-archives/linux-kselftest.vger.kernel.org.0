Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9777C7A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 08:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjHOGRy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 02:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjHOGR0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 02:17:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2568E7E;
        Mon, 14 Aug 2023 23:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klmKXxAnmdwra9HguU882kezokXjcmsIfdPDQkP6W0la16GrZW0GnkHFLqUk7XtLvcBjeuhLTOGQ+c+RE2Z7C7bsAtJSZClcWje4folV7V1imgc1373Uc2pvV8dmXGPQVlEaENAdr0Ng2SOwD2cC8zm6l1VBDFI0shES7hMp2izAkf8dvdQRS1gAbMR2cpzOKEhk9aIHgU8MIaVw/GOq2LRdf/Exy1e0kkUtzvCAh6H1QlQ0c4jsly0B6YldDMSZ1FIQc6SdHoFFeFpItac6bTBmNtnt3TQyuKY//NbXj5QLebSfCszr7q0rxvireg2CSdHAp/GFrKuB2c2leQ4teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NswM4r5KNQfDxP4tMos8eW3yF0w29xh1Is0/AXnWSt8=;
 b=AXdIU6Zs2MRroHM18OTBer5tW5v6fB414nZFDx+1TJPzd4Z2bANUgSFjfVwsGTV6nRBImqCYYhZWilBYUhWW6BxWJaftKm3+Q0wDdEoJKmMZwaqWql+zRia33HKvZcPyJ7Z8sHjnlJhqVjKeNYrw5O0g4pu/98muR6hxr5ooD8wy5sJ2E3LfVrXHO6gIWCrxKV1ajXGD3WM0UDUL4npk9EniGr8Ppy8VPBGioiuZ06kzxUdTOf/lIoMkvaYMTNxflDZA+vbS4FHelT4Vk0+pWbs6wqlon74GLf/wiLToZhKmzxUuy7a75WIZdxUWKRVp74xgEcnuoDe27C3Ubo9i8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NswM4r5KNQfDxP4tMos8eW3yF0w29xh1Is0/AXnWSt8=;
 b=tMcSK9nsYoMec+k6LOduPC7nZTiPtfLjkd8cLOZF73PNRy/vXpY7/s34nmLfAg4I4wI1dYJRSjfjT088yzZcaP+QLR4HV/TtHYt9MKzacpmCmrFHBPNMLediwUsEqVgKiZjnknOjf0aKZ+A7ZLJsmsg6vjckthR5osiQKk3loD4=
Received: from CH2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:610:4f::29)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 06:17:19 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::14) by CH2PR18CA0019.outlook.office365.com
 (2603:10b6:610:4f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 06:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 06:17:19 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 01:17:12 -0500
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
Subject: [PATCH V2 4/7] cpufreq: Add a notification message that the highest perf has changed
Date:   Tue, 15 Aug 2023 14:15:43 +0800
Message-ID: <20230815061546.3556083-5-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815061546.3556083-1-li.meng@amd.com>
References: <20230815061546.3556083-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0cb996-8896-4f25-3b49-08db9d5747d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIRSfwb+Q637o8X3D1f+uEA7OLeuo/iXy18tj4RRQykw6G7VZh1pyugSGvhUEiu9hHhjqyq20X/7amDjFTpvpZV7flfyOZTS7NfVio1MaBEzlKy/VP5vJU6pTOLhJC4noLlxe+UCyMLVpphc54uqypkC3RkG4qmDhlCujvjX34HwpmRg6RDQ4TzamrS7jvXuTwIwNBFYokLeP8lhDbhg2B5r7YjHwWkpD8gf3v1ophY7uls01xsbNsaA6ubHgny3PPs5Dsi6RvtrDZVOygI7DwQVMsrl3+B26JY+9okq0l0bWnKcpd+uC21cCGrTWgc3R3hORhp920qCOeqrDbv03otnNgH28hjNm5h/HaCfztv+ESTO4we1aAY2/Hziqfr+dkdJqlBfxY1xyPZw2LWsyM5wSnY7CREsQUH+fg35+UVJB+m6fGHqCkAdaiE79Yy3OJZOSK/uT+QNjal1/AFufMANTBua+Dtg9gnCfLqCYTo8MqEmyBxK5Vb+o9f1L7qd8o2TddxKxXL+iLTg3lZhXzxkOZ/8NdHeR09mX88GMJqaAnLUop1LEHbd0HHY3IB8GBl1sRzQAFhmK3kAMGn8TBKs14RXhD8fzPI72l5E0aNj0PaLEQ5lg6m3ZCKtkDpPFJnGQHQF2QK5CSoyWyTE8ql9hOfCKppWMtvCanxHsrNB+0LWkC4FPEIoWOLxdZ/0uZbsVPgu5JkRq8JKyAnHSZAobG8WQV+EnJtUGvjWLGu4zRj8ppHQrEyyAt+qrDQaKCgWWWSeIS3MOm/TMN8OReJ0pn27WMJoF/7R5OwwEdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(186006)(1800799006)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(426003)(8936002)(41300700001)(316002)(8676002)(36860700001)(47076005)(336012)(1076003)(2616005)(966005)(16526019)(83380400001)(26005)(6666004)(7696005)(40460700003)(478600001)(40480700001)(54906003)(110136005)(36756003)(15650500001)(86362001)(4326008)(6636002)(70586007)(70206006)(82740400003)(81166007)(356005)(5660300002)(2906002)(226483002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:17:19.4588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0cb996-8896-4f25-3b49-08db9d5747d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Please refer to the ACPI_Spec for details on the highest
performance and notify events of CPPC.

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

