Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31B87BD21E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 04:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbjJICvK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 22:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345081AbjJICvG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 22:51:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE8EDB;
        Sun,  8 Oct 2023 19:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcO88dDW9r5MdvwdyHWHoyK0MaDM/3qMjsWBqOmVOVocqanFi+aNFFjthqWGmXIKLWFN8Oa/YjqAFoACkJuBCH0drN93mt347js2EXCKDn7Q0BbSOcgaFaMf5BxFnmzppA7aM7G0E6hUVeCfZjz8Xkyng6VDasKWsewhe4Dyzc7YV3AElI6U1vv30OiLRJoSLjmVmup2COfiKTQva3hGROkEKjxLhrs/SPcQSRHjCRNQyDoO1ULLKmnLGrsjA/NUrphGqAULEPpzRH3jlyiuOTUBIw1KbljSLl5LSjk7wASyUa4+WivAqMEf/7buQ3pVCH1APqZOLNtXg3y7lMF5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hneoerr6yrWBbKcNzxSGDk6ANxsTr+qLx51Zn6rqXUA=;
 b=my+ubAc0TU2ZdDfSJu4irmAI+Sot4f2LCyGyXdGy9tbgsMNMtiywBryNBtScRNm/0he11/3uI/XeAc8HQQzyXuWcGuxjBce8u7C6hBQoOMuh2HpZ9ujkupC1ykg74QJcaNaHZ05iCmgaXqenGjDAbBbs5e3Xs5V4/+WiAD8g6DFv/IEeDRNxYAu/NTweO/jA+H04XI+nbxLHtwgdWGE1BtH9extyDnAPfQpE4thmsP3sK6agPbwO+VhTlE8ZF55ahu0bEyHR1gF2FTrvG6kP9JtheF/KJGMtvRsTDsu66+W8ldQdJZ6SFFUNvwYxfMQtONy+LGfjmT/7JmMajTQQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hneoerr6yrWBbKcNzxSGDk6ANxsTr+qLx51Zn6rqXUA=;
 b=kwyuyb65zt32N5f2FeNSLr6hVmqYwQeqV1SuD97TStcGaMW9pOqpAidspU3RAu5tuG3hMl8BT3/cBeGtfDp6F5fm0vwJiHtTQlGe48PffqW+iDbIhLraxzdWJe/slhf8WoeZlkdY2wN1FHkkk5pM4LTe45glpQNt+fcar3214fc=
Received: from MN2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:208:e8::32)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Mon, 9 Oct
 2023 02:50:59 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::fb) by MN2PR20CA0019.outlook.office365.com
 (2603:10b6:208:e8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 02:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 02:50:59 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 21:50:54 -0500
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
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V8 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date:   Mon, 9 Oct 2023 10:49:32 +0800
Message-ID: <20231009024932.2563622-8-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4bae77-f719-4c60-2102-08dbc8729148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPs+KhFcmpizslPneYl4k62+j3RQm0cPBB9/t5cTRrWHRlTpwbOnq6aY91cXXsYAcKT0sHpF++zrrDuhs2FZnB2Ct6QG33SIIX2sWY7IQV3+XVVSXqHK015/O+2pmu77s+rqtcMIkVFHj3vSyrUN6gt8rJSOLky7242Xhcc7tUvbexI+jRxwFwDE7H86Y/6sQX2HxYZ4iJ7/GIBjU4QYA4W4ujIFdgvR4r27HPbxmDoHCEgvPGRdfQgkdSmPL0LMp+4k9ml8sUQ1G+PrKYn1beANMIh5yvK5hqeNYcSnaZcDQc2+SbSt1pIShmK+VBkDTf5/Q04I6/xufCYjSAWBBdda8djtibIWqHA+WfGs7g0sQ0UuS6IU/9nwFfDg5SdSlAcKbpQZZsPInT0+y1pcOgw4YSzUIHigR3bdF3IP2OGSdm0rorPY2eeL4+DPiSybVvcL7rSK3D0newKXe46cSTAjBmY81ZnS7v35rrxjsYtGlra+bTMRYhvIolhkLYUR+PnLn4LayCgtHKD4QIOydFckWwyjJJyJ/79ytCcnspnUAyqPCvw3Qt+ZrVOp+xFIN+GnLYwvHO5Rd/GfP2ZldW4XqyDvoKbWGEoa2mxQfJDdBtapTOGgFUaVMEt4GEr1OfbkIBXe6OmH37WnA6j0+orR76Uxq6Y6EoFLnusAA9hto3ofwHZq2c2V0QLiMGZuRYRS4vYU7qSpkt4YsG7/L4YlEU5RmLFgo7ThE4e8/TbFnZnRf+//YQrr+wUx4Slh23EhCn7yPHofBQTaRjhDFX0sTRBu+KZXYSJQABDk+cYepjrsz0z4oj0e6Kx9B9LJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(336012)(1076003)(40460700003)(7696005)(478600001)(6666004)(26005)(86362001)(82740400003)(2906002)(356005)(16526019)(81166007)(36860700001)(316002)(110136005)(6636002)(83380400001)(2616005)(426003)(41300700001)(36756003)(8676002)(40480700001)(70586007)(70206006)(8936002)(47076005)(4326008)(5660300002)(54906003)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:50:59.1838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4bae77-f719-4c60-2102-08dbc8729148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

amd-pstate driver support enable/disable preferred core.
Default enabled on platforms supporting amd-pstate preferred core.
Disable amd-pstate preferred core with
"amd_prefcore=disable" added to the kernel command line.

Signed-off-by: Meng Li <li.meng@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..e35b795aa8aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -363,6 +363,11 @@
 			  selects a performance level in this range and appropriate
 			  to the current workload.
 
+	amd_prefcore=
+			[X86]
+			disable
+			  Disable amd-pstate preferred core.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
-- 
2.34.1

