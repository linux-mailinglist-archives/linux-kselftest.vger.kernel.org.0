Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1C7C7C2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 05:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjJMDdD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 23:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJMDck (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 23:32:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FE10B;
        Thu, 12 Oct 2023 20:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVfRAHGyN7Rn90sTKQEmRm/90AsyznakreBR0tPsJ1jzzaPo89cFTtWqhDqS2gK3/0dZoifv9haVFaGW9Aq1fnkWVSxtTwpeeR0G8rgiaqm9NSMrQoDIVCR6/RFYT83e5A/uF4GbkLKHMjmIp2yVqrnRIVYCSzBZK2L9pRMpIWW5tORWIuVAzdakAa/Xr+2r+bgLgxRUUBSQnaXzZUUIG88e2GyYUMdYtfHHSf6lwusEOzgXuM00YfYhGbpbNDj6VQJMHoacd0YzWi40yVqRQLTDFRM8Z+fApJfb4zVjiXFB6cxHTUJwtoIfyN5JjoTePal28cpmbUJ4J+HEYi3PeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BATVT8xDKQmxK5ddKWQeikq5vTddHGyEfuh2meRohc=;
 b=dXLhSQezqxVauLgCQBkqTWjOLa4OKQO1rKOLkV+35SDAQWCT4iOzyLfqE03AFBndU09EVcNdCq7A4HYNE4ri2vaSE9FAwLKFRLpyHhbXv4eJeRmnRrD8K92q/ONYxNblHT5Ze/fLV/Z+6usxSRXu5KxaFWWE4fBHrZOeeqzVLLn5JUBubw59GaU9X37TTi75K0n4nwUP1V37+bVoAt0xnVJdpPfuAxRIlhD2nXp0Of5qFrcbY1dUtiJp/k8ZwXjbo+bOK9X7thlULNNmI8jInrDLQpQviDI4G8ua/Q7FUB6pbm0PaTxILS35CjDHvzoj62sIl4+r23soYSUM28XcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BATVT8xDKQmxK5ddKWQeikq5vTddHGyEfuh2meRohc=;
 b=SWppC7lTOhJnDtjhz8YBRRposp1J8oT9guV+mjkwYnjp/4mpqUucErzsCjWbST5vo1BWdNLDxCqwByJieaIeKJLXTHAY2z0/ZfzV5VzZARWcSXbjKyM/nNgNOV3y76FgaloOj6iCgvEFfDleY0+mYHVyG7FBuu4s/FNVA//R7FI=
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Fri, 13 Oct
 2023 03:32:31 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::52) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Fri, 13 Oct 2023 03:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 03:32:30 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 22:32:25 -0500
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
Subject: [RESEND PATCH V9 7/7] Documentation: introduce amd-pstate preferrd core mode kernel command line options
Date:   Fri, 13 Oct 2023 11:31:18 +0800
Message-ID: <20231013033118.3759311-8-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013033118.3759311-1-li.meng@amd.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f75f42-f6b0-4d38-58b5-08dbcb9d0814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzLHNGMGu2sbnFNqFpxLFKF2DdXvxtzdC8XouRvXu8+H5U6lYhdCyRMXym9u5RxHNZwL4IEPP6FA35JnlRTPc2uTXAduaFpwsTq1Typ5cz+098cOaur/KEab52OU5szE7vJs+k0HTH4JLTmjKhkqoa45CLFrLORHzqQ3h0s1e0QmeJ/XlKJaoT68KaTVudI5wNkHjAVQ/N/C0hSDLZLg/iFZ9TNwFIlHk8ana9iZyZwlUeg/u8Lax6tvWEAQW1cVCbddCnLOm+e6HDVxHuXPDbtYTO/Xta2xlA6dISZXdvj0061ejCph3/rjJXgQ23RcNjprn8sNNruZPG4CRS+uiNbG4AKWwLM0lFfn2sUZdjMayg1yrc0OOhl7YYgJ1074qlANz+w8kVYyYH1xjrmtGEqr4N0b/lmBj7alVpjErOSdYaLQ8GVlE7yZE8JToY8y7zWZSCvbMdx2SOhqmYv3kDWNAdJAexSuFS2GJeIa2nY2RApk4rYI4+qJsOtohRGMicsoJGSJC8dT7hs42OxbttVzzh9jyHIJEqoUIDfUudicScSBGyAe270TQprBqLwDwK7y36IcwH/gW8zcLGTl0x5+2mkIrHOnKS4rV5rDbgfcJ+qWYDI1PEyRq3v9eiv+PrRt0VYhbofW5+VjrAfvHEZzwoVcTGVPNEK/sVfJWpSXaDaFZfFmjJsPUAJnrNcmQZtr1djPkaU1U2oXrkLMH0+z+7exwJjNCgC/tMDSM0q4x8jCtMZrn4tuS9XddyRHKdWTOVVYFuD4Rz+ghoBq/u554LwaEW5WXudreFpz4QKT8Q/X7sob22up8e6Oxi6B
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(26005)(2616005)(47076005)(16526019)(478600001)(1076003)(7696005)(83380400001)(40480700001)(86362001)(40460700003)(6666004)(41300700001)(36756003)(426003)(336012)(4326008)(8936002)(8676002)(110136005)(54906003)(6636002)(316002)(70206006)(70586007)(2906002)(7416002)(5660300002)(81166007)(36860700001)(356005)(82740400003)(36900700001)(14943795004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 03:32:30.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f75f42-f6b0-4d38-58b5-08dbcb9d0814
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

