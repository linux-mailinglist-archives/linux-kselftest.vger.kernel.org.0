Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C43773DB0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjHHQUw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjHHQT3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:19:29 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CEF900E;
        Tue,  8 Aug 2023 08:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJZh0sAxNNQT2xSe9z2Z4pxhf3JBVInAWHuHYhhaVoaxh/5NPM5xZrEtW0kIVZwaW7dkuowD1a8PA2fw79oeuYF6YGXfqG/2tx6xbU02LzMqxIahi65sV3JP4bYpwgZWBJY5ab7QRwTNdR8CQhyF2PR7r3ZsS/2iGRL7gKg3iUAZ/659FvL+QT3igjd5h5xWriZvyIekCWPXpA9VIABe6S+VtCJG66aFG/llUxA7sOIQnc4+lmUh6a6jHZ8F4Qw6M3O3eRHZbXprItE7Y1jtihhPy8dlD4bo4A17iP3GASsI3oduoe8HiWi1wL73vEhYBISaPlYXl7IlKvRFvf0Jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esVSysetGhzh6t5ORSQSSD6Oz46VS/5ZRsXchN81E0w=;
 b=ZtiW7nPpIeJ1tTeUF/fFg1LQ35lPiSY1mitqay5vtkynRC/dHmMITZU0ReCLHntCtlx4SPJ55ne6WmjsleY1WgSM37qZr6KbfJnNays/3hWM7pn/BdsXssm6nvdC8Qqpo4ZQfkzhw179ZpiMIwbH3TfXG/h7WlPhVKQ7lnTKJNu/lelFycKJVM2vkVSYrttaotor0Buv6tMNHh2E13cZvaNXBx38g7RN2PHvJadIENP1xvXpp18Y9SkGYncPGIqMqjVPlnCjYuhcoAukrJ6c3pKUKtSuzxGE/GoxiRcDe8gIzeinLgy2Wswq+cuyfrvLhJSV44fFMGCE+E7vL0F3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esVSysetGhzh6t5ORSQSSD6Oz46VS/5ZRsXchN81E0w=;
 b=xqCQuWvyoG19yc6iCvifNAFK1NXDzqMwGq9GmrGBr/jTFhlWoHmvigs7Bu7+ygEwoHxZAXV5pP6DmVmVQChs1uBkjdrhpKF7u7nOUyrbo4ad9qk6KXdq3XG+FaU6rOjgrzf1xa+vXDBjoWRA0CzlayXqq9mAXF1htiRD69hhc4E=
Received: from MW4PR04CA0344.namprd04.prod.outlook.com (2603:10b6:303:8a::19)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 08:12:37 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::9a) by MW4PR04CA0344.outlook.office365.com
 (2603:10b6:303:8a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 08:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:12:37 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 03:11:35 -0500
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
Subject: [PATCH V1 6/6] Documentation: introduce AMD Pstate Preferrd Core mode kernel command line options
Date:   Tue, 8 Aug 2023 16:10:01 +0800
Message-ID: <20230808081001.2215240-7-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808081001.2215240-1-li.meng@amd.com>
References: <20230808081001.2215240-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c336c2-ae13-403f-0fa0-08db97e73a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGGRQABzEAOEQ5DAoStKk2a3nrUY92wyQ+Zvh+Gm88Flku/3tClT7AGEDWckV9FeTswTKN2nNPsEixVKbbVZwdM1p2pOpt2LauezIwoFCzHl8HjPhO5PcUIIvmh829wHGazwNncgGI/Ry4s0eZP/6GmDwhmGW+MZ5TrGtUEhgwAkbTcjnGEDWAZyI15XRe2vWxSzMX7CLfFWUHtVK+NnpWEQlZ3s9NCwHKddD0MQXiUtH8qvtauXSU/4dc0te/dXzGz4x72HkfojZM5J39dxHXfHEcndLw7C1BJNL6K5gYcwomWfVtR7smcyab75LPAelDInjWJY5giKnp1pAHNVjLsurJTZBwVxVAUDsNBFLhpK/WXHmPOAegbUzhWy6+ck6Hp0S3KCGLFqBXXfyCs7Bv22t+5sRqbKZUvoHbsw6T3VJjf33PbR1MU9AenktGt0RNSDuXRRCRZiaJYd32/wrGf/Zf8zTcCIn9dodU7lmR3DsRSHE9DXX2o+qTWetevTngxnZTsTZe5P15fZmLYwcuZHI3KfAm44SgSI4P54xYdYhe5/tyrLPvszMu6Ezz6F3L30t8wNBfmdW9H0tWhabRSuK1QdFfEIc3n9Rym1XkySITyBdg2NpYxkumzwddKtnqM1cchGMIfQtOuFkKUe8qW40Ta9cOx/Ox3HHnbM8JIYYW9pgyntB8C6CU9+acAVsyV5jSkLfJCPzPU2f4aHVpABIpB6lO9FKG23WVUbbXx2jv8eSBY4iAfQ9lDlcz1M5tFzUkTZj+B4oMLDwsNGnoqo0p8PoTj8XBiLyvougqFowkjrbZ69/rD65bFCSzplB62VHaA0IZRpGMezZpplJ0IcHgP7QHm2W7mUfMqbcxBpGKs4pYvP7uM3cUU3eYYO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(82310400008)(1800799003)(186006)(90021799007)(451199021)(90011799007)(46966006)(40470700004)(36840700001)(2616005)(7696005)(1076003)(26005)(36756003)(16526019)(336012)(6666004)(82740400003)(478600001)(81166007)(356005)(110136005)(54906003)(70586007)(70206006)(6636002)(4326008)(41300700001)(426003)(316002)(8936002)(8676002)(5660300002)(40460700003)(4744005)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:12:37.1527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c336c2-ae13-403f-0fa0-08db97e73a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

AMD Pstate driver support enable/disable Preferred core.
Default disabled on platforms supporting AMD Preferred Core.
Enable AMD Pstate Preferred Core with
"amd_prefcore=enable" added to the kernel command line.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2de235d52fac..bc92e178431b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -363,6 +363,11 @@
 			  selects a performance level in this range and appropriate
 			  to the current workload.
 
+	amd_prefcore=
+			[X86]
+			enable
+			  Enable AMD Pstate Preferred Core.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
-- 
2.34.1

