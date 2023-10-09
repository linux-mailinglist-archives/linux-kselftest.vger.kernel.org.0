Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DAF7BD210
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 04:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjJICuE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 22:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJICuD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 22:50:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1207BAC;
        Sun,  8 Oct 2023 19:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et0oDnMQy7rmgaLvZgrSHTXGUNwJlV8fb1ZfYO6FnHN5Fp/t8Zk9bYCUDVt3vY4qZQkTvco6oBJixq+iDygggAnCS9QFvTu0qPGTapsIMZePQ2DNXaoOxls98EzfQ78K1GDbTjZlDw8sjWXZRTJNBygoIEGDI3AijJJBZx8QEYp6R/LVGxYzs2TgfJ4OO3sPWxMQ9c8i8zUmrACSlFwAMOn/8f3DyITF55PFhE/rbH/ZVnQSHAmi5RuzsIAirS7x7KMQ/lPWXik5IMZ9I12tP1KUQ2IkYP0ArLQpu+P2QcU4Kj+es2LRgvagArwD6m51k06Y9Brz1mLiQh95EKywiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjcQ49bg8CAFre4NUkzFDvQ8GWwZ8FmEd7dO3NaTlE8=;
 b=PeW98c//99W7Zx6ZaFzBFKRKSUWxfQSQiIMY4abmK/+ZaRcAIQLz7ec26BUgt/lbTrG6oXTuxTTSqY7tv/weEZqpuzKeO1r/mpbaLHcrLvzktaV+hfuDZ+6WKIleeLhzdm2Vq+9VUI5lG+fMqBpos+dd5ocK2fL8cWHtBRGi5pwdgrTyJ/NenQDQ2VHj/vqJTBseyUe+Vh51nTfOTQKInR6lKrxjrlLDSdpeqlP6Pvxagvpo5eJYWMYKKXES7v39okeFpqNNNzgCnKSLBxw7UesfquocrKBkv39caVlLW8vfsWLB55dG5Hh5IVfjuBHz9dlu3wCW2ENGekkdLXKMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjcQ49bg8CAFre4NUkzFDvQ8GWwZ8FmEd7dO3NaTlE8=;
 b=ld29TM/q6oLxheWCOj2X4t87Zwv1dmwlK+2++j0TvQDAOWhisxPIG994s+sNo85OkWkAEhivAqvF2c1KmPUIsGyhWtFEMHXn7toyD+eEH6+k+8G3A9mTg2yqYfCzFwXaleBjph8NKT1ucexh94VB5yTj39qH0aS0DlaLaXeJAT4=
Received: from PH0PR07CA0099.namprd07.prod.outlook.com (2603:10b6:510:4::14)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Mon, 9 Oct
 2023 02:49:58 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::aa) by PH0PR07CA0099.outlook.office365.com
 (2603:10b6:510:4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 02:49:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Mon, 9 Oct 2023 02:49:57 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 21:49:53 -0500
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
Subject: [PATCH V8 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Mon, 9 Oct 2023 10:49:26 +0800
Message-ID: <20231009024932.2563622-2-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: b02c98c0-9344-4a96-6961-08dbc8726ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kchJsCtkhH8gnux0MqD+aofDU57h+pJq94qpca4IKHGu1D3bbw3c9LQdRH660AyVpe9sfWZcyiNo7/Xs+MuLHuHTY476LMiVENSpYEpxNXmgu5VEvOGYHiKGJ6velPPY3Ba1cQS8Qm1Sj0N17iF5rsbQYA1vp28hWKze8nh3TRgEdufLlE28klVQR5Eupc9qgrGmN4Sczf/k7lQLHrSJk4j6kymeas7+/dfAvxB8ZJ9z0hgVgAHbju3C5seinZXxsl78dcWo3FN6Qk1oLNHV2/lxJ2KUfRXaChTY9BViqjKSxF01tolzwsFZcW/Ns6latOm9wp0/OcNdRR2Cs4EZayNVbGPLpt9N0d5/3wK6a7e30aPpBv9SHz7gLbRPvlCx7kOnsj5HWWAblvPnslui997rV1OCRAJ/k1ADerBRfIhIjgU7vJ4jnbcWZbUHY9LH5DSsA34jp7cwo2ewddvFmfkROU+AhbK+pIbvbd/BZxsTvMwE5hrTOMUtg16ghCSVdNRCoenC2Hd0o7EeQ6vbJ+aRUCzyrFqGdLHSgTwtiy5cHD1VVaIhiax4XZX5EzUxRvvVITq2Ce5wA7Gbwm45OPorhw61mMZjB1e9VTFT1YNj3nYoesxpFelY94XxNENCe3UrN/Hsip9zHUsHMlX8UxuQ+Lxva3dv0hG7d7DNizMNFjye35pXgvZiDbqUalPsT5OItiLOF0CUCQd3JIDo1KugVBsLmOhAf6qK0ZpICCZOcfGRGOGzqE8TsvCyNSDJePbRCesFK55PGdN6KiJp8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(7696005)(40460700003)(70206006)(54906003)(6636002)(478600001)(426003)(36860700001)(356005)(82740400003)(47076005)(70586007)(83380400001)(36756003)(8676002)(40480700001)(16526019)(110136005)(6666004)(2616005)(1076003)(81166007)(336012)(86362001)(4744005)(8936002)(4326008)(2906002)(316002)(5660300002)(26005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:49:57.9594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02c98c0-9344-4a96-6961-08dbc8726ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

