Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786416131EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 09:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJaIuB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 04:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaIt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 04:49:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8F6548;
        Mon, 31 Oct 2022 01:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STW3SbbvGgWF9EvQHScu0kxndln9AtKciumDGFJBatCf0b9wDPCp8FiaEbz40wTjeVqVPImbSR8VXcJlkp039KJHu6UDIOXJwWaiV6LAVDj58ps5oG9iRExaHHThxmud7AOa3HTUtobMGNMxNim3JRer8epHFFLj8vi7vULf83wciw2K0Hq7PDNm0s/DTpMECF7pOS6HXsqUP2qJIbtnYcDjSFbEBMEaD10qjDpe/a7gklRRctPblTH1CaCoF5ZcQUXsM1bU1dk6eqWxEdeByy2sV9Hgn9N28j0kHl89wAhzDQGoRZjxczMcGpOyNcNEq93XiFLCFBX72IFMoTeDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkQoPEGwqdbfU+x+WB2j2Dn+fXZDwNuFlEceyEbmLZU=;
 b=Gt2xDyeEE8uXhB9PGSbKBBpM3cQNVo1RuN1PGsQb3QZ/DJVj5wyrP4xRpRy3tiDqUiOxMuO96n3pmt/yP/9KLB80QVur5RvjXpH1sAfUcp8eajjHdeSrjToUkrrG8fcPOmIfoO627j+5SwVPJHdoD5W4U1atu9dB5r6kUe7wJhmwQqFp6Tc+AP8OqwN1jOCFahh5JVKGoaRuZlzws7rK4CpzMfn7jvIlLpCBpQfz6Hsi4s5NQ3Z1T6U5qkHoPbURU9oDUfsF6YmfK6shYPd9hUY/3XSc0d1bcUPeEFYuS7v+yak8awAmMV9YyYaMCHFtKMySOEeaz1IqTYNH3VrPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkQoPEGwqdbfU+x+WB2j2Dn+fXZDwNuFlEceyEbmLZU=;
 b=udYWJnTm4NJPqKDreQG1HErsWBij4vjcqp1ouXKi9QeStzbQOg2r2G+D1nxBxS1egfkiNH4IEZkGWogg7tAML7GQtduSuArZOQXTEhr+PcYdaSOx+d6aJUUQDy/KnMEM1O8O6bVegrKUAUeAzC2MStE7/kjRz8Yv0NpMDRfH8Gc=
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Mon, 31 Oct 2022 08:49:54 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::c1) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9 via Frontend
 Transport; Mon, 31 Oct 2022 08:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.17 via Frontend Transport; Mon, 31 Oct 2022 08:49:53 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 03:49:49 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>,
        <linux-kselftest@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V5 1/5] selftests: amd-pstate: Rename amd-pstate-ut.sh to basic.sh.
Date:   Mon, 31 Oct 2022 16:49:20 +0800
Message-ID: <20221031084924.1742169-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031084924.1742169-1-li.meng@amd.com>
References: <20221031084924.1742169-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E9:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 344ea5d3-805e-4daf-485c-08dabb1ce12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRwBuBDqRYm4jVVNx1XbC/Wdw5gPptIm9mxWPWv16iAxfR7LZr1oD4kbbPkolRhzi/z3okz3UFGq8FmlXUm2cpwC37I/w6+DG9slXO/kDl1JP8UKsMrieMdcEbZ8oYsytmiOQEZBhR0bawukXKp24u7dZDGysWlBpet31n1OuawKR1xTBOU+h2M9BUwsl8hKWltx7tuOCCC2it1Tp3HHs0kC8PKQZnhFLXE9A0jpxkw6cwjHn0Zz82AdxjvGQ2qHccoIGz9rudgdWR75+XxeLjRCJBojUbTxE+ukQ/BK0MoWr+sTGu1T8TwGHSGlFC5zFRZ6DzHR1Ca9tK67+stpgvCo4rxMGsnb/7vSQt4BUs8iXsKunJnlfRBMB4+fpS8ZKxksvRmMMS1U4oBKbp23qML0sPctm+OpeHRu/+vSv6S6yHmiDxg+ICKz3fUm5mBod+Ue/Mf1Ba7y07+wD3LNvimkakhY1GBzPC1egLt9LyEYQ25k1lnOzhqALHH10EUzV1gsAiO7y+VUPFHB51x9QvBcYJh2rR1BphzbPZ1bKsZXK/SXXSndWFUk9/HwNMUznoeUFzMGK4QBgq/E1AHUo0NXFJP1IutBm5nJ/emFJF9NX90D6GWZOkK2tUUU2+r3RIznMnibPQcYCXlXVr5Q8Os32Yg64MAZJZe8BNqH8QxYG5X3E50qBSGKm4iQXwOw8Z0OcW0iCXLKuz6rQoFiJIzMcw54eUl3eeQXB5GR67It1bmYRZPdlvztFJEKeRZrPGZLNeLd72bf/m8+939U19R05NrswkwXvpuKrDBren6CCbA5NGgaXSt0KoRVMTlv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(110136005)(316002)(54906003)(7696005)(6666004)(2616005)(26005)(478600001)(40460700003)(82310400005)(40480700001)(36756003)(41300700001)(8936002)(8676002)(4326008)(70586007)(70206006)(2906002)(5660300002)(81166007)(356005)(36860700001)(86362001)(82740400003)(1076003)(426003)(336012)(83380400001)(47076005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 08:49:53.6440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 344ea5d3-805e-4daf-485c-08dabb1ce12b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename amd-pstate-ut.sh to basic.sh.
The purpose of this modification is to facilitate the subsequent
addition of gitsource, tbench and other tests.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile                     | 2 +-
 .../testing/selftests/amd-pstate/{amd-pstate-ut.sh => basic.sh} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/amd-pstate/{amd-pstate-ut.sh => basic.sh} (100%)

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 199867f44b32..1d6f962a8f9e 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,6 +4,6 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := amd-pstate-ut.sh
+TEST_PROGS := basic.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/basic.sh
similarity index 100%
rename from tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
rename to tools/testing/selftests/amd-pstate/basic.sh
-- 
2.34.1

