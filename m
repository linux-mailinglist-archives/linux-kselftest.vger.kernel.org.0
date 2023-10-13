Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580C07C7BD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 04:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjJMC7D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 22:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJMC64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 22:58:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0DDDD;
        Thu, 12 Oct 2023 19:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA1AU0d/H4z2Xbg8YRvgiUQ6/MDordUJC9AZgUqjDgp/9KCKb86HISriwhXW8XbdSKQKXnt29lIU579qZARTicMzzWio7RO7xwPE75Mtjc1YV/r2XjMc4B/9cC9kO/fAJAMbz1aYmpZWx8exfSXQXJo/GWqEXKj80/brYZMflFV3enbf+poy3ZPbym4LAgcBS8ezFB3/LmfeMmxHVVaTOHMtcEEiiBLV3j2t7Xf0rAkY9RvUqZp7nTSD5om8zwrP3+LewNefOIsELic84qawlEAIursC/sd5afQc5rDSlIYiW3yYTmTa/XgXQSvVgo+qIqIi5TsYOpzIUwrmglJfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BATVT8xDKQmxK5ddKWQeikq5vTddHGyEfuh2meRohc=;
 b=YCxqq5dxEVLUoflJtK+1gEgDwfmFQ9uOPP8LQnssYRoBrJ51qmbeYOpFZJHVsijJjn0WG/rLUkBoNCutK6eJcgUq6aoV9QkAPyCdW7BqfCHmIhrhyfYEqfz5rehBuJwJ8g/5oJzrUpoAaP2VVGrKcVnztd6WlLlwfLLCDoQ7OPSyUvTRj9nG+0tl5IpYH/IUAAF+4DHWLf4gK2vSSa/TU8hptVNd5MDUGNZhJQW3MRkP+nZnS+Qq2ldOYRveRyzD9+nV9oRAX/qVSbGQ6kPv63vjWPgaJnFsb4rrY+kxzdMyE2mYAOWDcWMAzpcjkv+TuKFyZgIpTLyhKUGcMNCODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BATVT8xDKQmxK5ddKWQeikq5vTddHGyEfuh2meRohc=;
 b=IxW7pDJCVqfuJRlAT5gnjvuxfWZ2CJs3vqP1sCqA/NcMbe5l3K4phA7u6ahk1Jt/Y4ag3iUWLX9FHVgEl9XltEBIzpAp7U/RjgOTly4TdBL9aqb+eijCtENuMmCEsFVKDy5qFWu6i1kFXmUHfqcAW5uYo/KMME5pzwJpVMpCYmY=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by CH2PR12MB4876.namprd12.prod.outlook.com (2603:10b6:610:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 02:58:37 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::1b) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 02:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 02:58:36 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 21:58:31 -0500
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
Subject: [PATCH V9 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date:   Fri, 13 Oct 2023 10:57:41 +0800
Message-ID: <20231013025741.3332520-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013025741.3332520-1-li.meng@amd.com>
References: <20231013025741.3332520-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CH2PR12MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a06fa91-9e31-4d93-0640-08dbcb984bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXAQELx4UB6K4K7/BxYZxajtXdm+MsQoQ8GIMc3MZtv7lBykuwLrFjEFHKS4vNJ1ROto9a742LMHKI+dlL2LhOM/V8AdLHW7mQa5yECm78Gop5XlA12G1mYa6QL7n6sDc0GX5LGYNYJkneKphh4o/kTrOzLBFXON6qiT6IV0deN+6RleEk6L8PTLh6jSV8esCe3obeVUBW2DUR186LXQfIl6sKtNyf6S5/Nvrj9InjfPKdFx2kx7hknVq9TnH3eVFB0KlpbD3+TVKWWgLq2mssTH00aUdOSDNg05bO7N1vaBfwqgc/IKnUGQ46DnXtnmKo01/RNlKsYTfSktp5fCbE9JqL1KPb9LYAHIFnQN4o+k7r4yS+KjncjdERTUmyi2qco1QBBJMCZXUcptDWNxfAaXzXadiFIIskuq8vBXtQKn7PeYMbR0y843UK3jH5mHM6BM5TagfKRfqwazm4LTqQo3rZvwpBRnPpNBt6r2EINeufcWAtAwmks8lC2ty/7sFq6Puj3cX5jC9KdWvhw/fMDzw6Um40Z0bZZs/Tp2i8nidmKcIrZhWvJroxdNJAphNi2UBCCBhodahvfOYx4AyzCnj2CJuhJo4IXxbaxDHPpgKJ6Gdf0OBgVRZYXjAVILq0SRXt/W/YLODMscBtqAxCtTKpy1OCcUqVyyOC7KWcbZBd0OO6DpF017TTx+ltekTcVMEBeyZrjLtt9K1TR7TZK767awhvDraAEV7rXi4r+fZrVDBKWlN2sJDvSqKhfcChZ+BCd+t1dBOhJtfiqrzB5qdTwnUqByT4y3FqIzqeYyLAkOb6li+BTd3QX99RlN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(54906003)(41300700001)(316002)(6636002)(7416002)(8936002)(8676002)(4326008)(478600001)(70586007)(70206006)(110136005)(40460700003)(7696005)(82740400003)(81166007)(356005)(86362001)(36860700001)(40480700001)(47076005)(426003)(336012)(83380400001)(26005)(2906002)(16526019)(36756003)(1076003)(5660300002)(6666004)(2616005)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 02:58:36.7666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a06fa91-9e31-4d93-0640-08dbcb984bbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

