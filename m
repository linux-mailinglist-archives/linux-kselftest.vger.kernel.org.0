Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB17C7C18
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 05:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjJMDb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 23:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJMDb5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 23:31:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2903CA9;
        Thu, 12 Oct 2023 20:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqVSGShfG5N7BYM9J0hDkYq4wZuAmq2HtiHzqxMP0IptaTp7mXYCSAlUDT45dzvhClQMmSWP1GvFIrAhoAeQMe2wz0JZBcplUQfbcoYvmuTcorGjkGf17acsK2FJW0+XzjVn/fTd7sxzdUhF3EpyzZsskUC8VUdNkiUDjfiEIvfDcHQyAZ92sB96YWaz7RHJxcjtsYmO1UACUnA+9zcHIrLvHS6dFbmDjZhGyHOvbDlkG3O5ENsMK3v/b62DAqxfNtCelkHvv/xEKJf476PRf4jR6lCAiqIsRQu06vYqJpnl03JOs4QRHDV2oz+m+OVUFTvCZhXBcZRQhSNOmBPrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzEIHZpUA3AMJxzqDK5FWIBnTdRjO3KqmrHE7LsmiW0=;
 b=N2wdCaLngImWR0hMNOfVAqPMsWDhdnGbnFDK+Z3CJfZyT3U8axwAt0iNN5bWzK/eulez5+4/d0ioLZiWupZgAUvYm6xbSnRitpMs6jfjyBl1AISXawkhorm4JRTHZwq2IQs/5+o7dzGCMRxd2ptFgUZU7DfeX9b4lGkH86ntjPb7eCKjY7j/l24q86JA5lhbeute8DkhpGSiXz4tiFz8CYzE8E4la+Xx6fKGbkGO1lVOcI2F6lYooMdMhD03EGQs589FVLlVHUiHAImB7Ps/V5tLtagyPii7cRrvYP2gKWFH+0YYtylgyG02AOu+P+yGllHzXIxWXynKQUqQv/C9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzEIHZpUA3AMJxzqDK5FWIBnTdRjO3KqmrHE7LsmiW0=;
 b=IswG4joRuFtjSlD0mnOpxtz4EtW4iuI5EJOcJKjYyG5UWWxtZyCmdOAdOEfMZWDWE0fXLMj5n30TrUTtDf1M8atjGLlDgcOvMRIdurvLkjSVnuydxpxbSCbUne6GhuGe1SLUn5NvGnbAssxs3bVfzXNZmW5Ifyx/cXGL+xwMjDk=
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 03:31:53 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::99) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 03:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 03:31:52 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 22:31:46 -0500
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
        Borislav Petkov <bp@alien8.de>,
        "Oleksandr Natalenko" <oleksandr@natalenko.name>,
        Meng Li <li.meng@amd.com>
Subject: [RESEND PATCH V9 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Fri, 13 Oct 2023 11:31:12 +0800
Message-ID: <20231013033118.3759311-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013033118.3759311-1-li.meng@amd.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1233ce-611c-4ee8-1962-08dbcb9cf18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pW/LCxghbhh3NZ/dUrq2dPPo21wb1pmTirg3VD5S+P0loXOS2vYToUhYI9Srm6ZplOovnm+7SVQDiYwLzFhwKqryyMxGp6+/v+iHFlI3wvkocSpyZxA6s5HK23XX9O75EPB5dC6mPvMRgX1z4SVk1h2sszLeoC5bgVBk1UJm2khZ7Bwj34eAM9N8qBJTTWHyEhMHpaum7VPyE0ZgWdJ7CVLZ2nKiXOorDWbYscLU8T4YgrSH2eM2RhNalFfOwVkL4VT5TzvvP7YILHi5BC556S+Y+QHutUqDkWVUW57vgiRWhJB2hTqSEWQz2dCIMDZvrEyd4tOgLsQHp9cN57zo6sQsn3orr3sXfbPi3Iby/vbRLCB4NhLPQO+C+H1lQulH91RbSCvZsb1c5V+Qw40smO49X/iqh2swRAlB0x5BzGUyN7tej0uIReMtEhsUAYPbJqlkuh58VeLQnKDCrSs81syAm0rOVtziiPbeObtpbJKptoSSBzCcSkOL8wjhb/YMJTfH9M1Z156Nhf6YgBiQntMnphAUq/CyoUmNRCfYq3YyLb8u8wW70mn3C5aChxpcYPmOY24M/Wno3KpSC+ZExEdoAh3sGmahImRtHl/GdRSSJsNJ6+sn8F6ArixZp7gLnWRFFlqyqCw4lGUU7o/qPWA/LukrjPho5Kpv7oQWotS3gJ7vNRHdKrS3TF4QuQqzM5QSzajAgJcd7M9X3pQaDMGoQyuq5MTXc8k7aGhJR3lFD4pgQ/iUPMNqNZdsuSgZkGNE2cP5zBIQ8s5SaiW3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(478600001)(6636002)(110136005)(6666004)(70206006)(70586007)(54906003)(16526019)(2616005)(81166007)(36756003)(336012)(316002)(426003)(7696005)(26005)(5660300002)(4326008)(41300700001)(8676002)(8936002)(7416002)(2906002)(4744005)(86362001)(356005)(47076005)(83380400001)(36860700001)(82740400003)(1076003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 03:31:52.9674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1233ce-611c-4ee8-1962-08dbcb9cf18f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
without Intel CPU support.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..a2e163acf623 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1054,8 +1054,9 @@ config SCHED_MC
 
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
-	depends on SCHED_MC && CPU_SUP_INTEL
-	select X86_INTEL_PSTATE
+	depends on SCHED_MC
+	select X86_INTEL_PSTATE if CPU_SUP_INTEL
+	select X86_AMD_PSTATE if CPU_SUP_AMD && ACPI
 	select CPU_FREQ
 	default y
 	help
-- 
2.34.1

