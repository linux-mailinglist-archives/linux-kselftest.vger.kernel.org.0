Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E169D77C797
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 08:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjHOGQs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 02:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjHOGQg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 02:16:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B30A13E;
        Mon, 14 Aug 2023 23:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1xMGM9J737diObX1xS0wi6g+JvAy/sMYdO7pYgvEB1Dl0p+ClSucMZVoUql7nBIMDQ6xERAcubA3ZYLUvZfJ4GIEHtkA4ToYjsnUut08VP3RARe58uLgDOtiM08tozUx4oJqGqPhzdmSCCy46aj5alhNUkcd4Q/eRkTB7Rp47skSyj1+49P9JeNDrF6P2v23f/1Mx4ROM0mWPyPlg0lq6OhpDiEI9Rfc7cwjYXtadJ9NOHcsM0YrEOHRGeIau6Z+MxGIALTjjauucgOh4nOfxu4wEJQwjt5KfoGQGpWWwVuK1Byt+xfIImlJ84MPAxWBMmwyvFsuic7OV6XnMsLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGMKrfJjfM7H7f+ewFWhuvkX6F6TCyO9t4LyoFXlpnA=;
 b=Gl5F800Khljr2Uod3xRSa3KYk+WErgFF9cCn5M0/TDTjTsXtEY7CKk6zXG1cngG74T3CYtesp9GXuuDVCXAW/BzVq9x0dLlxqNLEg137S/G2+aN1StBpTdS4EiNmP1a/nE7w0Te86vTbvEYrpHogpULQpsN2RP5P1nQaDBN3U3+Cr5KYMOFmH2p5p8CA0p7G1vi3QjoQIMYGyK0/HC4QMaa8jcHdz8V6uneequWgTXNO3iH/yhQ5waG8frdSUGP9uEN35zrzXJf7DOnvpWCWLpe8t2WQ3O1+584ZTvOT7cJ5lfDDjrWFeZ1EVZdGo0nFXGEs6WCMWDhodofWOa0X1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGMKrfJjfM7H7f+ewFWhuvkX6F6TCyO9t4LyoFXlpnA=;
 b=pxcTf7ixq9kA7XnJvewngumqJ0IeD9QZgHLGSo/wyqN6ZOzmtyvHuxa+1IaNQI2Db88Elso7LXeb66vUv4iSHcq/hCq0E/DbTeY3WUab0zg0y5aEHxbGkhPW322dMhnLe0FItIw9d4sQToy1vzMp+2D48BCnL0ndScwJ8VJgMl0=
Received: from SN4PR0501CA0125.namprd05.prod.outlook.com
 (2603:10b6:803:42::42) by SJ2PR12MB7821.namprd12.prod.outlook.com
 (2603:10b6:a03:4d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 06:16:31 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::31) by SN4PR0501CA0125.outlook.office365.com
 (2603:10b6:803:42::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 06:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 06:16:30 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 01:16:07 -0500
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
Subject: [PATCH V2 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Tue, 15 Aug 2023 14:15:40 +0800
Message-ID: <20230815061546.3556083-2-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: c097c808-1e3a-402a-6f49-08db9d572ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvX89iqEawjo07JMeXTi184WbVD6xMa4JHXk210DA775zz15UVmLA77XTfoIO40CJU9WH83b3HAXxoUYyeBv/dQ/j/z/30H4SuiNIhp9L2Bm3+ybdKyZjvDJHW5LYjaPoY5xgJuslMLGuewYClrZlS66f33Gzzqy1fKTen6PXAh1RQPxuD11Zc5HqmNYNqFAyrqDY7dgwJBd0WDlH+Rd1VocIVVDxdQMLuA8YtCI/iCevvz4juTJtOKn0eWjNgZgM0mthlvTaZvlEJudtDWVoxQpwalP+SzgItJUZ6e2R+8Pwy7u5JKZovyM82bCmW/uz4AQwhtmfOTm1i4da1BXkefDMlXcqaeCy68+qFPjuue6l2pyRwbPppmqkvHdT0tIMoESbbTyZT9trq5nrix3Q4jrOIXcqBTP5NGSC6ofEXyIvMnJzjK6a5qi+5Dtbkh/1sEkKBGp46HX5XezCLwqhHjzldttXxhexHNF5M4Kx5N5TJDGVGfHjO+QQ8rY3L8RS1FFbe+ys+zRzd6fINYNKtohUEczzUqCdTakb8ubucFljrlKkL1kqOWI1SXEjlIDwtr8xPtE9f9xPkUS0FI/eD+72BWvA6ctyPkmqAjDwZJrA2ThgbWSw7JqmIid4mHnTY2nt0W60nU+kDNGPZk76IMjtPTsa1WZi6eBW68DLIuA0mz2paW3V0+luOHJOdYq6JSTyrt/E1MYaEWK7M3LfKjjzhtDGB8nrK/f3BtVKHSce635zEBiKymCQBXpfz4txHg0nprYeUIsINsXwudzFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(82310400008)(186006)(451199021)(1800799006)(40470700004)(36840700001)(46966006)(4326008)(8936002)(86362001)(478600001)(7696005)(8676002)(316002)(36860700001)(82740400003)(54906003)(70206006)(70586007)(110136005)(41300700001)(6666004)(6636002)(16526019)(5660300002)(26005)(2616005)(36756003)(1076003)(426003)(336012)(4744005)(81166007)(83380400001)(2906002)(40460700003)(356005)(47076005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:16:30.6575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c097c808-1e3a-402a-6f49-08db9d572ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Drop CPU_SUP_INTE from SCHED_MC_PRIO, and it can be used by X86_AMD_PSTATE.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e36261b4ea14..03322d2840fa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1052,8 +1052,9 @@ config SCHED_MC
 
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
-	depends on SCHED_MC && CPU_SUP_INTEL
+	depends on SCHED_MC
 	select X86_INTEL_PSTATE
+	select X86_AMD_PSTATE
 	select CPU_FREQ
 	default y
 	help
-- 
2.34.1

