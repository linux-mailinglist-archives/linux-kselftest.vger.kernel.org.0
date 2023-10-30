Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE91F7DB378
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 07:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjJ3GgN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 02:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjJ3Gf6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 02:35:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F9D3;
        Sun, 29 Oct 2023 23:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjCR0SzIphwvaDz6GBy7vLI7H/VQUCWRuDi05Vk0J1ETUyWiGRbeImXEY8AkVTxo0nRKmeE++cMttQV1dLNOw7kwTfgpMRCH3kPhf9x6+8N76eoTdAPKqEBiNdO7W7aW1APytgmCPXPBfRF0jPH2AdFFzE245Y7YbqXMYIfCW3YOYwl6jIoIrhttdI80aEttvriCQwhcrL5YGwtTUcZnQ1NAvjZeffI4f+i+iSmn7ShS8trXtmJyFep0ZIWZLGjxV8jo5/YG7LhJsVSKe8YkG9sgdVPWp2ZxzqjeSdZOk+HqjeLx4xGRUIf9SAfwK2gEaSff/nW26gOZrUSDE9+D+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BATVT8xDKQmxK5ddKWQeikq5vTddHGyEfuh2meRohc=;
 b=kc3BiW0Yqw379D2H0icN73tcK5tMJzcSozElFwNznsRvVgMKYaqpIkXa6PKni6wO/cbmYxQJuMTNOe4rmdhjoGJ9fLyUL4rhHYIEccSVc8QlsyzZ/VCuJe5HuH70HLFbZafV7b2NTBe+YSIArQSPvlpU/O4pAlKwJ3/+UxGDWTDUY7REOzhVKD7lhB12zM0fHjsywsN/LbnNSFRn8YAJWNbua0TEltt6uRa6QJxWwuL7XT7vll0eQ6/RJHMM07qZI4181/1vfZ/k/mz+7pghmEdm7Jc5QEdWUGSIJMUQDtB/5mxp57KppCKHhQoUO7PX/fhbJbV833wd09Tjq0A5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BATVT8xDKQmxK5ddKWQeikq5vTddHGyEfuh2meRohc=;
 b=S/yCjRB3v+MHvOZrsc20vzKm8dgusK0roVvW3xce75qfCUUc6KfKzKV7JKQ7LBirsRHE3TJqGcohELPIvmrKnwWZZy03ZlK7uZj2XDVW2W0Z3noag8txS611b52eDmpANm6NTduTdXmMrhpqbjP5k1+hJoA0InZ6GWG4xFvd7D0=
Received: from BL1PR13CA0087.namprd13.prod.outlook.com (2603:10b6:208:2b8::32)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Mon, 30 Oct
 2023 06:35:44 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e6) by BL1PR13CA0087.outlook.office365.com
 (2603:10b6:208:2b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15 via Frontend
 Transport; Mon, 30 Oct 2023 06:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 06:35:43 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 01:35:38 -0500
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
        Meng Li <li.meng@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH V10 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date:   Mon, 30 Oct 2023 14:34:03 +0800
Message-ID: <20231030063403.3502816-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030063403.3502816-1-li.meng@amd.com>
References: <20231030063403.3502816-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ffeb8c-0822-4f34-eba1-08dbd912714f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3PXIWQaIP6cw1g/cWry3rmRTyho5edsRoQ3A+jFzuC9CEJ8FGpAmZRRsl62qJEtoZq2rWYABXEfwj2jrCVF1XTEjkfCwQp9mtRAA+LpG1kQ2AINWrgtJN/p2E1V22nKfdy7Ka5W4zlwGA1FzByjU2qbBZmpEIDnr4y9hX5R03SySipbPXsrKRHOYOln1im6s0EyvS6pC1eJ2ZJtp7+7riVpFLkF9j1+zZk4OzgW2E4ir7Kph2a0hVfGazP+UF7um9XWZ9nRywKiNE5YLba3KCECdu3hnO/4SLEX5pk/XgUc2gs3vl9rzEYlV1uwU/3Z5EzzNGwlr8+pBUV65Cvsg53oMGLIQ77tYnF3hubj2Dlo0X8oYW9QcNNdoM7TBsuduidlGAbglVdLnsyInQfGg1MPD3+AwRfAuNoqnb7HS622/9NCNP6mrIP0qoYkhScF9Nig+HMyDujgfcQaPK/XlJacEKBHTsXGEOh9dRSPNER/Mdwn4owCf1ZV1PZDoqQ9Ctj4UStkvhcDi7XzTjHL3ZKt3RniSVk9ylrgEBSknw53eYNBVWuFEgHkmG6Z7oep5Blo/Sa5pv/96jTetfH76NyBCy8/Ot/+vqLy5sJfRKJ44PHUUD/c0whQKjDfqixziReODehJF/H77/Vi1HueLF21Sx2OFnzpt/Il4Xntu8daVQEMF7Qfs1aIjPZeFHDwNE2SzvO7heSTmxtbXWaA4i/2o1oqeFAJCUeR7LZE6XAxWHsg30WSNwoszSY52V909gqVeOOj77+KY+b9OjZUYaPFv6Tz4YnhXo/VMV3Kxw/HYXOWJs+VqFU1rRq0j8nw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(36840700001)(40470700004)(46966006)(1076003)(26005)(16526019)(2616005)(336012)(83380400001)(478600001)(6666004)(47076005)(7696005)(36860700001)(426003)(7416002)(5660300002)(2906002)(41300700001)(110136005)(70206006)(70586007)(8936002)(8676002)(6636002)(4326008)(316002)(54906003)(40460700003)(356005)(82740400003)(81166007)(36756003)(86362001)(40480700001)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:35:43.6290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ffeb8c-0822-4f34-eba1-08dbd912714f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
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

