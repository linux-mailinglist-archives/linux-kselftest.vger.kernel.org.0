Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550CC76A5BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 02:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjHAAr5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 20:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHAAr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 20:47:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79871116;
        Mon, 31 Jul 2023 17:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ6z8cOyG2RuV5C/rlcmDSpSIjSAKawPu7oUylADb1vLhNDcBi3/NiHJtPXRgFclC5Ym27RCPx1RfrUjgz6o8KGWYf2ckYdz/1SzFrJ95lN7MI+JxVr03Z1m7Jnm6t0u/9mpYs+FKIyEbPhiGX0zMNRgwWAx0VctsHZZ0lT5pyWHPnoj2O07u6GQe9LBpZJTnAdNvmEmGfIIJuqdZkhVBuCw4x3p+Rr1XcQXMUA2NtFzkxf2vcJmk1VxnvrTYVwiLrL3IR3SBBcCzdbKMQ7Zwbd1Lg+4T1SSemgYK0CqIiiLcfW18BP7mvGQtDk08kbiLV5LAtqiW6PSbrBGr/tl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE7X7fcwHH/1ZPRFv1kNy0X2k1euQPRBSK+CtCg2RkI=;
 b=ihoDAEegGN0gONKzsb4rZSdbubHbKC3Qg2BbYkQB3M8uHFmHxSmWaeOjS3uaGucyipiY0NDbmMxpNdzuewuelG7TlIKULtAby+iP7wlY95lLoNLsJnjdvhAvLMkniolqUOjjsvWpC7mwt6Bvs5Lmrzn2+ErDlT2pcSjnJb5GvBBbuiCYChtgcF0Ywyr9vqjaOMEWWp2GlE8+rlo5nHsCARvVkzr9OtTLP9elD8I/NUz8Z9ZAoX3gHzcIW5d7uN5EEX5IXREH12E3WBumStw0MgLpIe4tqIcONm05BzTZHhjec0aSSo444uZ80FVzcx3s90n/xEMin9gxt+vmKezFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE7X7fcwHH/1ZPRFv1kNy0X2k1euQPRBSK+CtCg2RkI=;
 b=jViX5XjJzoqrmrHQ/B8NeQgEBrbYYFFyu7XL0laOo6iQgLAOwvyoY77gRpZ8ZWGH/HDQdMBGOoEaJNGJJOYB8Il1p3bDw0NNdPBGbCSyqi4eYAmF3yuPvSfZQltiuVpucGnW8dMZyfObFQG6xRaxh5hzzb32ebBKQ0vEXlNM9ck=
Received: from SN4PR0501CA0028.namprd05.prod.outlook.com
 (2603:10b6:803:40::41) by MN0PR12MB6342.namprd12.prod.outlook.com
 (2603:10b6:208:3c1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 00:47:53 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::81) by SN4PR0501CA0028.outlook.office365.com
 (2603:10b6:803:40::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Tue, 1 Aug 2023 00:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 00:47:52 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 19:47:48 -0500
From:   Meng Li <li.meng@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Borislav Petkov" <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH] Modify the function to et the highest_perf value
Date:   Tue, 1 Aug 2023 08:47:19 +0800
Message-ID: <20230801004719.1298415-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2772ce-8042-4ae8-342d-08db9228f011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Szmsx6TssNdYrdy6BzcDRnia2FL6zmHu8XPR4aUKqN0kzvGzcDmd07XIJk8qaZ7VNmCKqDLvgXj7Z+JTGDN6YCaeKu/0clsLSSI7Np0buZdvODwdDSpAE0ixC2duNpAT6VyiftpRLnwKgRmR3gsC509eWP3RciTMv6kzhbWiCtUtrvfHLs61chKnQfUj2SLc5ttVKFKM6HGm+ZcQHOprKxZ2KGrFf+J0wbdZ4mQVYsPOW6FLtm9eAJSrhCwjxCsbVdAmI5l3K2dYoShEPxzaPPIPVO6811CXKLzFVJOlNj3y1CY+aQ3t9ZFaG097kEiX6bqQ2tZx+U4BYfF9CPOMbF3Tyq44KkYbrWLccu1dIXV6JvTLELM/+DZXOifKpXms7kq+62+iGCrVxfSGnN6JJ4/zZV7aImja92RQacX8qDWMKvtnPlo0VIWyFQf+CJbnSQw28h+veb95QYIgMMxIB9VDeWawe/E8wF1qk1Yt8X7a3l3Keh69p1lNsM/k151YxEgiKZFp3Dsrh96rQBizmBBzy4Zb/1NaF2id8In8LSVjySeYs9di0NmNA4rwTx+TN/qv27hmfY4+3KxMZ1hq14s3XP662YWc7uiZSEIb3R2L6SCxpv1DFMiIKNYJ11nICU+y8wyABn7+TIA56AqpSHx8qcysRecomznCCBIht4rQo223Gdgbrl5dGac4zSV99/q/G8Eesj0Y2oBYMm5v7YEE3zX4fAe0J6c+R924vcZiuW3jtwBrZ5QfIIueIYLcjTIMwlfxyA5LteefoEUzJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(7696005)(6666004)(40460700003)(86362001)(47076005)(40480700001)(36860700001)(2616005)(36756003)(336012)(426003)(186003)(16526019)(83380400001)(26005)(1076003)(81166007)(82740400003)(4326008)(2906002)(70206006)(70586007)(316002)(5660300002)(41300700001)(8936002)(8676002)(478600001)(110136005)(356005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 00:47:52.6438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2772ce-8042-4ae8-342d-08db9228f011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The previous function will be deprecated.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 7f3fe2048981..9c889a4a0177 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -145,8 +145,6 @@ static void amd_pstate_ut_check_perf(u32 index)
 	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata = NULL;
 
-	highest_perf = amd_get_highest_perf();
-
 	for_each_possible_cpu(cpu) {
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy)
@@ -161,6 +159,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 				return;
 			}
 
+			highest_perf = cppc_perf.highest_perf;
 			nominal_perf = cppc_perf.nominal_perf;
 			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
 			lowest_perf = cppc_perf.lowest_perf;
@@ -172,6 +171,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 				return;
 			}
 
+			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
 			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
 			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
-- 
2.34.1

