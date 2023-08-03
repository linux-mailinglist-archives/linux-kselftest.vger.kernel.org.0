Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F82776DD6F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 03:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHCBo0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 21:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHCBoX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 21:44:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAB41FD6;
        Wed,  2 Aug 2023 18:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO3uS0ZBtx9Kd1Qls9ZjSJeSudpMblQM8qYmvSTQPMyMKXjG9Cho5Eu842YPru4EIZUktak4DRTKglYsRjHSp0sFag5y8Vd/Cv7NHYOz/VrVrrbplJQlNGrCnl9u3yGTLS0XiCiO5hTS12KOVRzj2XPKaIObhgSsdHjq5K4FXNfZ/SKmR3yVUrSu0shmIro4cG07v4D2WDlJpYdmEdubdkYTx/oLBHlzwDvP+Iu7zjEg0Duj3xRxowHw8Le/dUPDIlU5lkJ1SKqQcHu8KNNe7HeQ334GKWqt6DL1es8vK9auoVoHu+Qh9OR+0b5QHMgXSlMfNMo4lPITQDHtLFpoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLz33v7muQVXBnLTuFnusy+MRgsK/6izW/fvDl9ntsc=;
 b=nvmCskvl/c9eJ6u4eIdw+hEQZp9NjCZzkeXzK3e1mlftWhdM5oZ2tE8fuipHNIj2h4to55j98EJWvM0HGYzu7qN1xCkPZRjDFq7+HJWGwVfSgvOTMGJTnm997+QTX+klGs9tPWox3I4SP+tdJ/o0lC4VgHm57Ob3eQ9jlrqwi/mSyCrVXQwo7SWzecD399/+gpCGrFv/KBGEsIUt+qsEB92AoxgJeq399wtjpoPapmVKHS7LOX+bAHXw93UuaK5V6HtGa8k3KgqZrQdY2Q9zw01URiEqEAVxGixwY7gd3nu4nYAeCyc1kSziYUBGSK3piXwfnnVLAT4YgH0aFkhpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLz33v7muQVXBnLTuFnusy+MRgsK/6izW/fvDl9ntsc=;
 b=2O049jbnadShkjOgrXJ++5/b0eVhUJ2YFzQ4eJHqhBu/tf0RBhe2Gy/Bpc/A1tE9PKv5dTQxi4IG3G7shKp2A6lElzX3yoW/CSPb47CyG9xuMqBizDseZrXKN4uqHPE9EAX6YUZ9oIjQ24dgkJgpq71CNoiWnoOWQpMaBghkoEc=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 3 Aug
 2023 01:44:17 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::27) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 01:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.47 via Frontend Transport; Thu, 3 Aug 2023 01:44:16 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 20:44:11 -0500
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
Subject: [PATCH V2] cpufreq: amd-pstate-ut: Modify the function to get the highest_perf value
Date:   Thu, 3 Aug 2023 09:43:54 +0800
Message-ID: <20230803014354.3304825-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bf6bf6-e9c7-49bf-1889-08db93c32618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAKEi+o3zGF4dwxv7phs8cLjMFQ0ZHsVs9XFP4ikO09babc5tX61XzoEK3g2rvpUE4T4Zzfx6O4J0DTMlDK1pvbk4CIzjzMKTlTg/ZaOiPsKkJ9Y2rFfXUIR6WLahQqU7+7WAke963cjF+UwV5uS60K0+KBK02Q184xvnZJ6z4Omq67PZS/NLaY2dCyRs44lqHM5ExbvyC7XBV/c798rswmTJ7KfoYYLXqYKcaTaJ1pjuhtLffvjcjQwi5/YAVcbtsspqFNZl9VNZVDkxQ4pU0uv/yg/1Xn01Uwkonx4C/0E7iR1frjwT023IgEscj1FPYJoxMJM6BUfWB4w8LOHiNNqDjulYyphLHR9GFR6e8Ofi3bhE/sfIw4Z3tRKpi+ICCQCYst1/kOq0sJ4xeLwGBgayj+UmPkxkWESpDO1ABlnMXhOb6xmpQwgsrYQ2z1+VQ96p6AiPMHdpRaD8HLU0wckQplCxx8TtkYLUgxHEf/w4o+wwKdZpdK7i5p5tpQ0EOOdDpRFbzVtyG8Y7E2V83OG+m72q9IEI2UCdkk802H4WbYuJIO66pQQW+T3VcfCapO0hgyGuJnlEjhK29WOb+ZSfvrUphItlzlsJoaOrO/B/blHkx+N1hLlPwXA8X1lCFevEPhGx8InAoo6QRfOlO2XlIDDiW0GRRQdlK1douKBp4byl2SAe9BixBEmc5Ce+CHH9ph6jjqLq7JkB1dz9sGaRIxIacrue3NvCOsVb/wKLKMkxZMQm3UNgr1A1gHZB4OEapuu4itJ5Yn+66Y7ZxVm9plU9xJ8e4FueYP+kCw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(86362001)(316002)(8936002)(8676002)(6636002)(5660300002)(4326008)(54906003)(356005)(110136005)(41300700001)(70586007)(70206006)(81166007)(82740400003)(478600001)(2906002)(6666004)(36756003)(36860700001)(47076005)(7696005)(1076003)(26005)(83380400001)(426003)(186003)(336012)(16526019)(40480700001)(2616005)(40460700003)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:44:16.8513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bf6bf6-e9c7-49bf-1889-08db93c32618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The previous function amd_get_highest_perf() will be deprecated.
It can only return 166 or 255 by cpuinfo. For platforms that
support preferred core, the value of highest perf can be between
166 and 255. Therefore, it will cause amd-pstate-ut to fail when
run amd_pstate_ut_check_perf().

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

