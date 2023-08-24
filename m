Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE7786526
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 04:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbjHXCOO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 22:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbjHXCNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 22:13:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76D10DB;
        Wed, 23 Aug 2023 19:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBJidy/t2OXeEpOl1Ri0jF4SYSLco49TaFE6VkjFopen+5vBHWhlP06zBj+/BLdVTgcjYZikIj0zuOOqZ6FMP8pWT1zgcHCd0G4CJ5bA0TUM35KYzgvkbO5QkdwLPpgAPj87kQ7aRTU5iGm+YRxM8Ik9g9mDR/lc+2T1aTsTZjJgAo1xM/oHnhSeuQd32c5mBvKgZ+RamfnTy8gQYvYlwA+NtdI5l943sVrhESe063vo92rQoHcor5NVjVzMfCJ/y/dU3cO6gcANGHFJkVIzcNHk43C2ETjy2WgoChXBIKEvdIYdULb4Z767VejUUaw7KaURxVxM3Ogrbf9LOuEiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGu8fRjxA/5ga0dJbpFWiyY+95bFnMwxw4KO7X008ZM=;
 b=VOMLlgxupa8loKp9FJLTE4DHcnyhmKxKK2lnc5Y6d3J8p9kZRK4LHygU7+qxDaisR4yQDpgw8l+CfoX9Tp4qQMKI3hRmlZ9cG+vN5SBBtlpKPr9evWU72JvtOynKVu1JHeD8i/2XoQiEt1GkKTzT8I+n57WsBInzaftxBClBkSrgZueEqctAzIdt3P6IR6noS8VqWNQO7vlQWSsG38ipbsutnUPkGp7l5OQd53oWrwY3Akm+bYWsjfohtSW/GHu0WjKBQTZUSxT3FvlpzvOW6B9iQOMfrERFgHY0d1C31gAfZ6wDZJfFm+hZwr6P90TDZMjDPG4ULsm7z11FPBOjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGu8fRjxA/5ga0dJbpFWiyY+95bFnMwxw4KO7X008ZM=;
 b=GA1J8QAzzaqF0bPxoKbEaJDTeTL649wM7xf+W3OIXMZ3QO6FPLQvY6hI5VhyKeN08M6Pe/5N6ND11wqOcPPaG/aOtQ3OpRfU+PUvfid7nnyahAtng+UtvZ2h+/GxU26lUEEg12Kh4zmQKiZLPTeAhsjivPBGuPgV1yGKgB4eQgA=
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Thu, 24 Aug 2023 02:13:49 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::93) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 02:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 02:13:48 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 21:13:43 -0500
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
Subject: [PATCH V3 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Thu, 24 Aug 2023 10:12:43 +0800
Message-ID: <20230824021249.271946-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824021249.271946-1-li.meng@amd.com>
References: <20230824021249.271946-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b8782d-910e-4e77-13f9-08dba447c0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJWIx0VSXcywbjBEcLHf5gMmF5QKCdg+Jjo9WYt4paoYpIWnrLvINMFdF8foxQYI7VOYI9/gNdcUQbaXy2mU0fBR2IfRXzu3AeNDTqijqhvJJIYSmOQTrYT0l2YRexd3gL7Ucsu1uv6LE5IsvI+UgYK08S0zi+SLSDrvvQnhgemoo3AWfwaH6+Z78/uYrRAzizvwh/WkMr3bKa83fYuGi+9P1tvagB/K5yogdO149Rvtcr2WeX1nKJfXqKWp5oU06GPaJMjIkHSbe0M/MTSidHv3le41nrsWAMhls4BI8nq8H4qJ6eeRPdpANt1WE/UV/TgkS0Sz8jlQUNEbmSqpzk/3Q1seA+bEJGlyL3bAUvPxDqvhMk+EsWrFc7EMT3eQtSfinOArO2vLiuFuH4hhegInwpKNriNkDp8RMGq8WyL1Z3fvQyHII8deCx4edvUwPeCfsnlrulol4U/mKTNiL5G+6YVbPyjbMZ25CebeJuES1/D6JNWFZphXvAnTTx0SvkWdIHM5wDW8TIEdOGwVAf+Z8C1gjj5kfKM9pYYndW5UftUmiDdnGAexgldvUuf+KQTeRgIgjoTHwKg+pzQUe2nvl8Mkw6SO9w2tk+06U0/GBeR9d+mBrA/vtRafKODl2Tev8NeYmkt7vErzCWf+Pwwx21rXKFMJM34MVqp5uIorv0xH8jlKyQqw2fxyJSmpbxKJca7doss1sABm4M44FTFpzd5B8419M+TV/fd/1Sbbh8Cn2ClZrUAdt52HpKn0hpKPgtHN/A9adRrsMyjaCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(7696005)(36756003)(26005)(16526019)(83380400001)(2906002)(5660300002)(1076003)(2616005)(4744005)(86362001)(336012)(426003)(82740400003)(356005)(81166007)(36860700001)(47076005)(40480700001)(8676002)(8936002)(4326008)(70586007)(70206006)(54906003)(110136005)(316002)(6636002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 02:13:48.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b8782d-910e-4e77-13f9-08dba447c0dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

