Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2C79256E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjIEQHn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbjIEBwW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 21:52:22 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B26FCC5;
        Mon,  4 Sep 2023 18:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJKo02BrP69mJRtID9DDw7BD6vPeZNDyWSy7v+C9WaACkZO3O60VbF3nhNyb83cqinQEmYmMbwgBBUTPCqYeuY6ARRZHNayrUAvXRkze3nqOXcaGELL0CHMrLyLc472uOIw5f3Iw81XPrp+UghQm6MNauYaV5dcAlYZPLG8YEwiNziTskAPJd8Yko2mwamUVcD1p4pCF9VjlTXpsX4Sn1GWUav4w4vTWeE2qcxf9XGsSSL9igVqHe4e4hb3/0Xh7TuHVGBtBEPdy26DovBVEC2Sht/QcaT/oZE5o4fuh/IciawXDr9t4GrKD8CoOoBN4kNx0K1wmBVrlPvuB/YjoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QafCinqhB4JcZBw/TmFTAco1fQuxkYe9Bs1oA3tu0UQ=;
 b=m0kZixesAmV5bmH/vBa4b5L9FdGiNHFrejZSYoiXMc6SwfSgdNwb/6lIMFcvjzfXNJPj0sZ3kTCkDKFWZrROor7LVT7QKWtWp8nay9BurWuOoNhO8Gto0RQ1NcSX1UiX7HAWvXQlTPxZ5ziXI02vyXYKetxooa5h4yDJ8fqZg5nR6rsl0GZZdBHScvYsOSVB5dD3ONtmLqInp03ke3B5CG1qRe8v8WGLblgkR0czP7sOzdpyul1sbBAO6k4/IwNm1AUjG3+7xHk5ojaab2Wsl3ntwpoLd/WNzjJE0bN4PozC3Vjgjja/Uyxb9AnzQIoLHKf68xgKb2JOac6nxbHcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QafCinqhB4JcZBw/TmFTAco1fQuxkYe9Bs1oA3tu0UQ=;
 b=BNYc6Znqa/1lFkeiJidyQ7H1NhhDcXeOFRxnEdnBuF17yUOHXlBwlNwtKeId82Oi0VU8whSoOMl7itWi4fC/rOb0otgK0mm92jdkJa9yDtEUWlYf55WUyeNbR8v8/nWZk5lAt8E8CpXbyaOr3bVlU59eNU25+gCDv/1doiojS8k=
Received: from CY5PR15CA0203.namprd15.prod.outlook.com (2603:10b6:930:82::25)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 01:52:16 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::9f) by CY5PR15CA0203.outlook.office365.com
 (2603:10b6:930:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 01:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 01:52:15 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 20:52:11 -0500
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
Subject: [PATCH V5 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
Date:   Tue, 5 Sep 2023 09:51:15 +0800
Message-ID: <20230905015116.2268926-7-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 82820a86-8221-4716-50e1-08dbadb2bb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbEYQLH2qyRXrJfbVmBE7z8/Plj2c/0gYUlLojx7aBZCvaz813ttoH+7seB8SWt0UGBHzW2BDntxW2XsY/YSFr/5dsOoah8Urujby447xAay2PmZkhXFyE6Ld/4tRRLgmZjZzm2vqmjEZrtd9dgfLIpiGHIt+hJSSceULDy5F0peoGgCXjly1O2hJgpei2N5xEOsHeIdgcnDG7RquHDKHf+sI+ixriMc8TMeN9pQ/bms/VjYTwmd7d0VWzEegFZ61HCKRywgHTfP3Soo6plnkr3sixKldeNYMXNBbockhEFZhPxBmiTsAbqMNB349DH58fR72kVGB2L8sqZtl+h/mO5IqGzpKgzYcAHIgHoNcIFXzEg6swVXvpgtIyjULQowpRGPhAUJVVYgMUDSi1CdPaAc58f42fj8Ji2kqi2XCVvAI5AX8Pp/vJo3cMhTZdvTGFXC2UrcmZPUkQSO9hufVKLbjZ58MGDSkDyyaNd2o3bUEquDIu+TKSn3nxzRFFdAmPZ4CG88SidY3VvvSR5wUFUYU4dGAR1K1GbkLmuKsZHsR5QTv9Z0TxyKJCp9/mqT1WgCpTJxE09fGIcEk/eQ69+7hyEdriQzOv9guFkKbQvkKY3nN9st5UDhl6/m1hudHBI78L3EsBjxmnVdR84Few3uPYl2LYqWT/1pj0KBHjBtcuFBY1Tk3ARUgpr16Vw7aR8shh67ikA6eiVoRNmHoS+mMFgIvDmkjO58W3X+8XQDQ8ha5iIPWK2RSGae/rV0d+jaJ1JDEVkC/KlsllipSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(478600001)(110136005)(26005)(2616005)(70206006)(70586007)(16526019)(1076003)(426003)(54906003)(336012)(7696005)(316002)(2906002)(8676002)(4326008)(6636002)(8936002)(5660300002)(86362001)(356005)(36756003)(81166007)(82740400003)(47076005)(41300700001)(40460700003)(83380400001)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 01:52:15.8122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82820a86-8221-4716-50e1-08dbadb2bb2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce amd-pstate preferred core.

check hardware preferred core state:
$ cat /sys/devices/system/cpu/amd-pstate/hw_prefcore
check preferred core state:
$ cat /sys/devices/system/cpu/amd-pstate/prefcore

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 68 ++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..204f5d49d47d 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -300,7 +300,7 @@ platforms. The AMD P-States mechanism is the more performance and energy
 efficiency frequency management method on AMD processors.
 
 
-AMD Pstate Driver Operation Modes
+``amd-pstate`` Driver Operation Modes
 =================================
 
 ``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
@@ -353,6 +353,48 @@ is activated.  In this mode, driver requests minimum and maximum performance
 level and the platform autonomously selects a performance level in this range
 and appropriate to the current workload.
 
+``amd-pstate`` Preferred Core
+=================================
+
+The core frequency is subjected to the process variation in semiconductors.
+Not all cores are able to reach the maximum frequency respecting the
+infrastructure limits. Consequently, AMD has redefined the concept of
+maximum frequency of a part. This means that a fraction of cores can reach
+maximum frequency. To find the best process scheduling policy for a given
+scenario, OS needs to know the core ordering informed by the platform through
+highest performance capability register of the CPPC interface.
+
+``amd-pstate`` preferred core enables the scheduler to prefer scheduling on
+cores that can achieve a higher frequency with lower voltage. The preferred
+core rankings can dynamically change based on the workload, platform conditions,
+thermals and ageing.
+
+The priority metric will be initialized by the ``amd-pstate`` driver. The ``amd-pstate``
+driver will also determine whether or not ``amd-pstate`` preferred core is
+supported by the platform.
+
+``amd-pstate`` driver will provide an initial core ordering when the system boots.
+The platform uses the CPPC interfaces to communicate the core ranking to the
+operating system and scheduler to make sure that OS is choosing the cores
+with highest performance firstly for scheduling the process. When ``amd-pstate``
+driver receives a message with the highest performance change, it will
+update the core ranking and set the cpu's priority.
+
+``amd-pstate`` Preferred Core Switch
+=================================
+Kernel Parameters
+-----------------
+
+``amd-pstate`` peferred core`` has two states: enable and disable.
+Enable/disable states can be chosen by different kernel parameters.
+Default enable ``amd-pstate`` preferred core.
+
+``amd_prefcore=disable``
+
+for systems that support ``amd-pstate`` preferred core, the core rankings will
+always be advertised by the platform. But OS can choose to ignore that via the
+kernel parameter ``amd_prefcore=disable``.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
@@ -385,6 +427,30 @@ control its functionality at the system level.  They are located in the
         to the operation mode represented by that string - or to be
         unregistered in the "disable" case.
 
+``hw_prefcore``
+	Preferred core state of hardware: "supported" or "unsupported".
+
+	"supported"
+		The processor and power firmware support preferred core.
+
+	"unsupported"
+		The processor and power firmware don't support preferred core.
+
+
+        This attribute is read-only to check the state of hardware preferred core.
+
+``prefcore``
+	Preferred core state of the driver: "enabled" or "disabled".
+
+	"enabled"
+		Enable the ``amd-pstate`` preferred core.
+
+	"disabled"
+		Disable the ``amd-pstate`` preferred core
+
+
+        This attribute is read-only to check the state of preferred core.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

