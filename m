Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DB3798367
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbjIHHrt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 03:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbjIHHrr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 03:47:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94719A6;
        Fri,  8 Sep 2023 00:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHFTvDiwUOZZEQKv2VDONk+vvHyMn8MeGwb52dtb7JbFNmUIhk1OFY22K+zfmydIP2/fQbGSWa+xcyfHVruwkFQ8wkYWTQUGfDPR49Cheb4CDC5xXrUl9DWWm2HtAejO12iXXjN5cI/r0DZyn28A/8NXBsxYJNbMJSwgSk72BLMuOuIcWTc2S9JOHdLq9CSDW1zCaE9GReMVXv3+1D1EUCU9lkQAwQ/QOyZjQSz2yAueIyBmUr9cISKrLFZdOh02ZA1ipFyWaRU0NUcbybYcOuHC8zDI//4IDGtyWLclGMDNwFBmLpQAUJBLQyNtIjYk+bohmGr+8cwUPv1pIR5f0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNi399GkAX8gLWdkR8shF5XjWL4LRrQZ0CDjOmlYuGM=;
 b=QHAF3+M28zjLUwTfyPofPjgIRhaAr3G8JJ4zdCR3JH9vkQAEcLks/pVkiqpd9QondHgonCI39Xwc2Zl28tEhXWLTAMbZ+gnLnjf/vd9UvavXDIOrm36S86OG2SJ/SK55gFku/a+0cHD5ynN83mjRDBHozApLqV/p9se2phQIu+umBE69mYxMIB5UuVsRjSchMewScS4kWs2EfkehY0pqsFaEVfYKzQ1s9vC32oEQ5nRelwtmVuJySpwuVSAyj21SHuUXYY0ZedBkXc57IetwYM7OPuRtOiklgBtzt1S02VD0gjuOgQQ1TjnhPDsl0Sbne5UgyqQkUubzl5oD3ETeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNi399GkAX8gLWdkR8shF5XjWL4LRrQZ0CDjOmlYuGM=;
 b=LbWYhi03L7N5jfF5RSNT9Ui2Fcnx6v9DMny9b4yN9qlWD8LHQImqJw64kqyj+0MaIcf+nTw6XIW5+ZF1sF/5PhXJ12i27XJT+f1Qcwc5NMQEaHOTQ6NHITzYhqdtxjqLbfJyUMzZm41Q7RMutNfMpt0yFaF85UWsmR4g3d4HFw4=
Received: from MW4PR04CA0186.namprd04.prod.outlook.com (2603:10b6:303:86::11)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 07:47:41 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::6f) by MW4PR04CA0186.outlook.office365.com
 (2603:10b6:303:86::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 07:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Fri, 8 Sep 2023 07:47:41 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 02:47:36 -0500
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
Subject: [PATCH V6 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Fri, 8 Sep 2023 15:46:47 +0800
Message-ID: <20230908074653.2799055-2-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab827c5-69cc-45ab-8a6e-08dbb03fe145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGPR2d+JerP6QPGbcegK2t/Yq1ScgOd2O4ye33BrieA+vMFHSyDveff73RlKqr5/sMdfW3c52sfyiMKub7Lf+ZqDkbsJgEmUTLTomQ+p42F0L9EjaRfolc1+9NWdH2T7IT3HtTCPGOi9eB3/kvmslfsINOq15bPKBOKtKxbNXKDSmIe0eWRaYJI8ZEgQ3O+blGWtquNmWmdtbR1V39dYchQWOhNDKDAH6RWD3tw4S+QNMgkDgodFsajU7pP8Z932ZP11m3B16x72Ytm4Znpg5f5ufV9Webp328a0Wnb2Aj9HhaHX3wcSOFGhczZGZgsCUcZ83pVxiv27hf68rz1m/o2lthCBXY7V5A6/sw7xcqZUghvZfufdoeWB2vkMAubYK/KRqFPu3ICq9jat0zlpHh1BZJCMa+8X0Ww1QACsXHe63gug+LAthz9LOL7AQCOFQiqdFceC+hW4Ykc3WTyOOuAKwqDrY5kvTPHhzxnt8Tuy6GbiAkeqGqymXQDmy8nFo2gCSK+pQkGG7eIm31wFSCj1JzSZ/dw+JXgnB9LaQYO0JHM74dEB2VTZF8kvjTjaB8AKwcT/ui1uAlUfD1eoHuRSydlQiPQ1L35evOutUy5nj7uNa/+6ryARmYwy4jKvLJMjiy4NbaqeNBMgMtwN7kfyx/yB4rlWApPsUTH2aMkb+Ek/p3AR/kaOgRYe3JHnsXK2edX7rf5zl0+3jJt6KUoVSIfInARSrgvltAvAGVxaw1iK7V5UX4D/ZR4ZXM46HY3KsSLVek1Ny1qWnADWrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(4744005)(8936002)(8676002)(4326008)(478600001)(110136005)(70206006)(70586007)(5660300002)(83380400001)(40480700001)(41300700001)(2906002)(54906003)(86362001)(316002)(6636002)(6666004)(82740400003)(26005)(40460700003)(2616005)(356005)(1076003)(81166007)(16526019)(7696005)(426003)(336012)(47076005)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:47:41.0353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab827c5-69cc-45ab-8a6e-08dbb03fe145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..5dd2a2fd4718 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1054,8 +1054,9 @@ config SCHED_MC
 
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
-	depends on SCHED_MC && CPU_SUP_INTEL
-	select X86_INTEL_PSTATE
+	depends on SCHED_MC
+	select X86_INTEL_PSTATE if CPU_SUP_INTEL
+	select X86_AMD_PSTATE if CPU_SUP_AMD
 	select CPU_FREQ
 	default y
 	help
-- 
2.34.1

