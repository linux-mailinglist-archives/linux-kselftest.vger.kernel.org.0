Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0A7DB363
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 07:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjJ3GfF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 02:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3GfA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 02:35:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CD2A7;
        Sun, 29 Oct 2023 23:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3TnNIzHJFpBFORc9ooG9GZxW4As8KLY1qMqMInVuj801DHFgfDFpBtVe7yBDuP/lMYTlo4VIeogtXXTMcuCcOaG3A8Y5xUZ0zsvwdKGkGcVemKGdIJaOIHFjZHqI70myfGBY4Ve4PmPHgYuvdBauzLUInxkoGs6IaS9dqt0jrvNuHxB1lDMlmZ2ZqRF98qtfwItqX6wDB9HZ04KoM+XICPVmrI2b3vkWqfPujn0fT80WKMHQ/aKCn0b3850yKfSxoBxN2swQ/GFulJX3bQD0w68gD1V3ddR5Srmu4ZJ4bGVHY1+4oOoW9sUBUDnVCFLqy/rExc437Rv2D02f2EbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzEIHZpUA3AMJxzqDK5FWIBnTdRjO3KqmrHE7LsmiW0=;
 b=ZsRS6MrsT1Aov35BQTTAeo/CdsY/j2A5EreF+7SRvl0jEg/pXtIB4jgXXKC/f1COi3jWwpw+OOCFLcPH3JBE3Y7fsCeUbK94v2EQURg/jjz83hKYaD7PsUeeoo+0dWKHtNJIY5AQ8x/pixFzaiKxTG9bTN9/khPhNoZ+JUaXkacqUBfJpWxEWsMdGLl/cukyYakVypiTVsROfnhlIfn/q89LLpfg5GTSe/YmWadHu/VaGt/+d5cgwx0aq86PbAbOIeVzvILk10YKgQAwiGCE/5WwyjCmLsOHEqbxzF/3v8YzKBefILh1gWRz8SkQOUrcf2sjpCswdeRvhKX1zKWVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzEIHZpUA3AMJxzqDK5FWIBnTdRjO3KqmrHE7LsmiW0=;
 b=pdpHbGcOEQIqwGj3xtkd7q4sjTSDqM3jLE+NyOmFz4HEphmT2uTeL5JBpyJ3RsvIn4h8WgkAqC/rT+MdQ0hoa1IKTZZ+Z+nM9dh0B5pLvZXsZnMFylbvsyU1tt2Pz+H4qyVefWLdjNhRlWQeX1valoFPW0FN7Apox8OWeVo36Uk=
Received: from BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 06:34:55 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::6f) by BL0PR02CA0126.outlook.office365.com
 (2603:10b6:208:35::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Mon, 30 Oct 2023 06:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.22 via Frontend Transport; Mon, 30 Oct 2023 06:34:54 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 01:34:49 -0500
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
        Meng Li <li.meng@amd.com>
Subject: [PATCH V10 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Mon, 30 Oct 2023 14:33:57 +0800
Message-ID: <20231030063403.3502816-2-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: a8448bc7-4d65-4927-9a65-08dbd9125431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAlCGr2AV/ABos/mx0ShWk9gK37uAm96BjgS8cky+XuJ5HJ1PTThRJNXQ+rbe+JOHFQqO7/st1R59GZGi+llv4K6AnO3RCjaTIno9skt+RygSRceu+B4CeYJ2w1/ZaCmx62qFI8v5MxYmWHSRMGy99rtkYNkso7y/Euz7kTrLjYxhBfQRHrpl1cS7W2wQ2coJfpCfMDXzGZkPpHg90SKsz3XTjXvKSNRc9Ea8pY4bxjMfAB/aQ/OoI/JJDihKAcHjY3tESx4R1tTqRILGIj2DTgXfWdjCJtn2h380/ZuqIKn+MwyxkkmLaZvgvCpanZ2L2w1O3YLgsjWilJxmaGxLOkIzw4aVk0t9E+9BHUzN7RKRjswLQGpf+ZuFRPUqGxWnTbM4DSPnhMyOMz20ZaLbkxnHmX/me5IbPzNfDEjgNJK7vR0nBsYfUSF1z7nqQFbilsasexABD/oQCchB5EVF4fSiwGVYrsrV8LhZHmOjgmynUW/XUF3uK7SWhjohIFjhvq09TOTlKonfJbZEpiaGyPc7REVZZipimhhlXPq2TuI2TqpJRCP3au4LL/kuMpNV/ix2QIni01AU5CC566pAb9jl7YhB+iB/odza8ECUM5rv6kr0qODqraVXjrK7VC1yr3TnlgCRum4JOdsBPMFg1Et2/UO6rz0wld6RuzH86S7wvJjhE+CRclDgEBx0tg5GrbdQz999mj9EA9MFp0ZEFjbibDR40cgMZEcmC/UKpZefv2SDuzbYgd+QxLkmWpgX3zVffn7NwPotN/2plt6og==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(478600001)(7696005)(6666004)(110136005)(70206006)(70586007)(426003)(16526019)(336012)(26005)(1076003)(2616005)(41300700001)(2906002)(54906003)(4744005)(316002)(8936002)(8676002)(6636002)(5660300002)(7416002)(4326008)(86362001)(36756003)(36860700001)(83380400001)(47076005)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:34:54.7920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8448bc7-4d65-4927-9a65-08dbd9125431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
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

