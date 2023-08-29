Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1578BEA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjH2Gor (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjH2GoW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:44:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916FB1A2;
        Mon, 28 Aug 2023 23:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOaTfF8nAg84RzokfJeZzx27b9vyAPvNqNPmFCMKQv/qpCH3juoqA+6Pkd+zckXa8pk7z/gdYQktetJE3AmFsv4vBF7cXiuqLgIpOY0gkrJH4Z2+uP63qrVENcGqFEHuJ82NFu0LDPgkUikMKv11xp6+2FQZ1jNsUmY2w9VPj/uaojSqEnG1U0+FPA0js7qr1iU6ilFzSbVebQVeH/ap76GBtLhgz4v3swcimG8uHUcj683JpGAKl6xoFubbo0shKQuWaUCqfcSRdYoRjsT5pMELGGY0qgKpBflIuc+1ZWIcrghFPvvs2CIMPCIG6d51JvuCfv3y5Ltug1VTFWIPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGu8fRjxA/5ga0dJbpFWiyY+95bFnMwxw4KO7X008ZM=;
 b=aLyDv3w29xdhMaSKd45xaTrprb/mCYVv7WaQFZpSBPGnlsK15TrAad8dVn+9GH/g+vr9WGMCfvz9yYuzOswa5p+Fj7T/om7M80YzfW8rOYPy4b35eEWdscOKd+yg2k1J8gHGNEvG7r/xOC6UsjZWhtZh9dsuZW61Kz1hBm6aYs9bcGmRsRMP8OX41GDmLugdmuJy7tVpUmSJKXP0h8bUgzXNVo4Fx5DbG52TEtWtln3wxazFZ9MNNbv/6nwN+PHkj3qf2Gq6ePBpev8hYuZS8LMHxSTJudESlL5XcWm08F0Gkd4bTQGKM47TMhmTj9Ln+Q3BiFsQuJ+LcfisRY2GdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGu8fRjxA/5ga0dJbpFWiyY+95bFnMwxw4KO7X008ZM=;
 b=MKxratFrwjopNhJHi9rWstU5uCQKVcDWYp4fHCl/RXXBzhU82LF5hKeygOPDbpdY20kjjYjke5bSseXyhyJE2s6MmjLHUge/oLcCTvt6hNibSkoU+Gtv2XIRiCxpTGCx4wTjcx7ed/tw75En9cBf8Rnla/oTKeSW5SL8J5k9U1s=
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.36; Tue, 29 Aug 2023 06:44:14 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::af) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 06:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 06:44:13 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 01:44:08 -0500
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
Subject: [PATCH V4 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Tue, 29 Aug 2023 14:43:34 +0800
Message-ID: <20230829064340.1136448-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829064340.1136448-1-li.meng@amd.com>
References: <20230829064340.1136448-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW3PR12MB4505:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4b0bad-e624-4550-22fe-08dba85b5bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+kfW/NPA+/3fXbIahuqZT1PZLlNDICKYXYI50h/n2b8Uny7UAYQ4G9iU1Jkw75usrdqTWf/0ZO0v1LBTd6w9Qs0gHE9gh97plzMIJnIHDfFThWYLlsO1Cqor4M2XCISuwjk5asbd3G6RY7pGV4LZqs0A6ZMge6RFe9qKu+2ALA3tHh/xG2+EkkR0ynE11mmBZtpHrNH+mbIs8axwZu0wtQ+rpsdqB5Sh71YN7JYd3jClPLtVPmCx/EcIJep3a3wUWAE69LhCWbuTht9FzK1kGaxNzuFO9zWqiCPRHvwy5mi8R0qeFUUFRZQI2sz5aENA9lhY+0iZ8TqIGELozFtJuDyeJDbBETgYw2jzUqM9MaxXzau95SjPfNquTCg2NmdUbnLHy2kt31QAosfQixWyThvcDtwRs20zRcpcSsba8AH7DDW3vgRmRuTYLWHe5uOHEoMIqWFxh7ny3WKft6XA8QeFQG5B7k7Z4itPQ67iHsczPWUC6fT/6jGEoaUnuXgTYyzw77/Kseg5+UGa8wyr8ia+WGsdq0IBcprY+qrzE+yM8sIgzfN6m/YNP0ZZbjZ+6rXWzigAJaaOdW346Kmb+VeEtYsJFMY/QCkHQmb+U4SfjHstEKUdhuaCAlP7xD2rsHXKbuBV7NNhv3rz95BOUCZX/m8CqU9pHVFXtm8u/iPthT66+lVAE1eEZ/ng9mbB9Pfj5PqLNsSAOV7TMcQyITXLgYjdy8MWHNSFh6plkXAlHtfsu5GSNPEXxKG6tKm1Eofy5RjE1PpNfs1KXHGig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(40460700003)(316002)(6636002)(41300700001)(4326008)(426003)(336012)(2906002)(83380400001)(4744005)(86362001)(47076005)(2616005)(16526019)(26005)(36756003)(5660300002)(1076003)(8676002)(40480700001)(36860700001)(8936002)(6666004)(81166007)(356005)(82740400003)(7696005)(54906003)(110136005)(70586007)(70206006)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:44:13.9161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4b0bad-e624-4550-22fe-08dba85b5bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

AMD Pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
without Intel CPU support.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e36261b4ea14..16df141bd8a2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1052,8 +1052,9 @@ config SCHED_MC
 
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

