Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ECF7A4451
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbjIRIQV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 04:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbjIRIQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 04:16:01 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A863F1717;
        Mon, 18 Sep 2023 01:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHOkwaa6AsVLdyC5+KMHRJJ+q1ien4qO7wRdE3bWQ0C7bRMA+Wa6R01EeTVWMSDURX1PUQqU9v9Y45hwtyATMUZql+kMkSdklZMZfLfF47eebgBgnKyJFmquD8RYXqyJP4F3Wv+M/JIJZE58AfWJ0RpVcVMxCg55kpfvvTQfQA1tQAaHaEO+oEmJUUnSh81ZMEQ9x3zwgCzFv2YtuYBaG5andqEfpzsXr+hiGt5hoayKgzExJ5y910N3967FW37TtZDhe3iJWh+FvTfajyDwfU/wu+VPzPyIw81JX+2zW/9ylr2rdDfyQ/57bUSFjGF/UaSMqksWAcFp5LGLMHnqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj3TrJsJJKzuW4MCNofsKDP5gDS+pIj+dxyeSOlrrAc=;
 b=GYuCty+7xAcQC/OSK8zx8w4yhf7EQJ24UfxZne6Y3+Wuf+Pudpm3d/tG9Eji8429Bwn251eleApX7cFOPjCJPpv44647S9pwaMAYvPObdQoOlq8GPNmdpeKiFY4q1Oe7+kcpSZIVp33kv2FhIQBLQyHETCk3Vbm1Rd3qhDMVc2lqc6/O2gm7wAf3oxcOUu/ZHlIEkO7qJYIoXQBQJKA0CehgyKXLXdi5fqrWJsX3K79MeQlpQ8BnVGr0ufY9ADi2y24PlZIMC6+iPzfHkl3jisIW51Al5vnm0H6WpG0Ri7s2+W9cC5Mwu8IMzNYCgVLbgnKF/5NtT6NzoJcOABi5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj3TrJsJJKzuW4MCNofsKDP5gDS+pIj+dxyeSOlrrAc=;
 b=mWJg7O5XDVGejrBey/G7uQDq1dI0EWgUcLCgL0kcAAU+q3y8QawwowOClopxsEdfeOIeLEo1FdNffFTR03lcNK0WMzNbf0d/7vwYKQDHkaRmC2jen5nV1sQ6/gvPt59bgjEDZRTk9yHgQn3hPcqlqXyEJlVGBzQK11fZVAAHgE0=
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:14:36 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::9d) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 08:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Mon, 18 Sep 2023 08:14:35 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 03:14:31 -0500
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
Subject: [PATCH V7 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
Date:   Mon, 18 Sep 2023 16:14:01 +0800
Message-ID: <20230918081407.756858-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918081407.756858-1-li.meng@amd.com>
References: <20230918081407.756858-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dbcd2b-cd06-4268-bb75-08dbb81f4bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ec70DNfDNNO7ypOdHhdhkne6Q7n4MFRGb9K03WbnoIuUF6X1hFX1ZCeqgqOzvULbE9OeJDWSKjH7WSMVj6W0Z4dlzCF6VXGRmkszbSe/Y55ZE0tin+9+/glH03g3NckU7a6ctWzVZ5cYRGkBSbxdiTCjT+Dje2XTwPEmOjSplhrQVf5EE3oWnI44QiRIcWw8xFFqQME0mUMkMxF48Y93QsZucF1oFQeTjV9D5DfRNE0+WvYI4GBNjRzw6V6L/n2J8yeX+GI5lOVGIio0pT8sf807xFyPyHfa+MtfqnxEA5TXxiDpKePlgxzMxwxiFO+93pkc5JuKhT6IrPTa0JD47thfXbpifAK/KuXEywTwyLYkxyR5U9TfDoY/ySG5FBKxLv+4/+IocT5LXM56QBBZ76OtSTd1HAxPk9JU/uYivRzyhPbyDL30X0eU/EJsMyuMvv3QNWQHHk8c2qCo7NYlsGCAI2riS4IKJmLUgZ8xnB9nRYqSHuIGCZO288vVLQyukfw9Gu1XZaLxUxoo2rHXROKKBVSu0WUplru6gpdYgsQ1kYKkT/tdr+Pgyq22gvZt7t/SqTxJd54kEOiXC9zzP7+A85sGIdKyJov13/jMC6bly0UClDZvi/DQGTrmVxFtQoRrs/FoXbnZNunrdXKw5WmwQCXR+6su/RxFkgN3nmHISHN4yIDjDukj3CGzF4Urw4hcOXdDKnU7gM75uHUZfo4/0Wpq1go3j/uL/S7LNw8m/Ebx6uLUdWETdClvh0lNWVK2MJGVPxMW4sLM/e/iqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(4326008)(8936002)(8676002)(110136005)(5660300002)(40460700003)(41300700001)(70586007)(36860700001)(316002)(6636002)(26005)(83380400001)(16526019)(336012)(426003)(40480700001)(70206006)(54906003)(81166007)(356005)(82740400003)(6666004)(7696005)(1076003)(2616005)(86362001)(47076005)(36756003)(2906002)(478600001)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:14:35.9603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dbcd2b-cd06-4268-bb75-08dbb81f4bea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Meng Li <li.meng@amd.com>
---
 arch/x86/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..c37ef2e6940b 100644
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

