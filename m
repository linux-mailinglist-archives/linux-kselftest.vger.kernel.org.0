Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127A7663DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjG1GCX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjG1GCW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:02:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF835B7;
        Thu, 27 Jul 2023 23:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3uOyAU7paj4htTqe4uZbykKU3HWCsRM2lmxBuRXy8rqczEWcjERHpjnpGjMBMIg+UjP8YDPGChemj8EGfaCciv8LGOCZc1IPngzRHDPSQYgE9mxH0yQYy/VTEyW5ueZj2wbd9nygCrfrKfNQUy6cojy86Uxx+xoWFRYExAtrDH5fq1W41e8TCnoVg9i8vO+aEsgLHPon7Mig9VOdvkdigTI4a0kEn08E75P8Xw2LjZwV2ehF0zTWMW+rBSjF9efBTR2SB/nLnY8GUCZgN3uV3CLfs0Zqbo94dz0I9MhmLNVkBArsO8iODf680XtdXAZYJQdMfkdgTDr/lqf4Kv33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIxQ7ohbWGeT/zbGGsdB8KghSqMQ6lQ95nvT+1vVung=;
 b=hqKEY4HPYZc0vwIdsSUcevt7qknFnU8Os0MLTm4icanmxAPzJehWhkBQemV0ISmBHYGk9m/gJhtljH0RxBnOzx7ILgakbxlQwNarLsCSggIVUrGLMOF5uaywIjvXSjkrdg3S91Z0emRYfhA9dyAsnYEBsKgqCnhwhctmykyGOF5nSv/Z2AWsnOqBu3tiYGPwis34JABmuARe+PX5hcGWLUKx0Ul/CytOEtLzxPTaedK9TrPbGVf0mmlpPopgEf456V3CR1Ubqweqj2M+0PHn/aE9vUpjyUCboD+BQ2PQh7xKY3rXh4vmDr1h2fu/j+rmosJ2KRSESlFBB/Eug4gO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIxQ7ohbWGeT/zbGGsdB8KghSqMQ6lQ95nvT+1vVung=;
 b=2fmYc3DKmaoQk1KfxqG4hEotDhoYKSKYrv2aTKoSeubKSq/GT9dubm1NzCl+uSvFXNeNuKVfM4w/dduMxL7aekRJUAIV5uBemj7FgL12lc22VH10n07X8rj/Zi5ilqdkzX5Dl26CkJtScU0KDX2nCsWXqbWpr4jYD66VnAVG/xk=
Received: from CY5PR13CA0052.namprd13.prod.outlook.com (2603:10b6:930:11::34)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 06:02:04 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::e9) by CY5PR13CA0052.outlook.office365.com
 (2603:10b6:930:11::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Fri, 28 Jul 2023 06:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 06:02:03 +0000
Received: from BLR-PF38F8CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 01:01:56 -0500
From:   Ayush Jain <ayush.jain3@amd.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <pasha.tatashin@soleen.com>, <zhansayabagdaulet@gmail.com>,
        <tyhicks@linux.microsoft.com>,
        <raghavendra.kodsarathimmappa@amd.com>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Narasimhan.V@amd.com>,
        <Santosh.Shukla@amd.com>, Ayush Jain <ayush.jain3@amd.com>
Subject: [PATCH 2/2] selftests: mm: add KSM_MERGE_TIME tests
Date:   Fri, 28 Jul 2023 11:31:09 +0530
Message-ID: <20230728060109.4403-2-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728060109.4403-1-ayush.jain3@amd.com>
References: <20230728060109.4403-1-ayush.jain3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6976f1b2-e63c-4b80-8c51-08db8f302a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Thz9uZ65+KJe+NQWE7VqUSStpptQtWfa4VsNPSHRU4fdvR2+lwRdKIAl4Cs1hLxBDU/ybo1FA8y5yUA3a3JzPqZVfkjkW2QI31vOxC6dc5CBBVCFWTLRp21GYrSrddEUD4KyzgZihPquf7BucecCDo6Nf7HM67ZXYATwayLT8lusdfG9avR9OJ+A2ATcnqf4/uouJFvAdMV2ujDlZW8x3RfC2dXZuD6lWJkQgcyqsH3VnCIUhJjFdNamVHVXVaIWXWnwZeW9EllXUQqVLGfobR54ab3vAFj3/VURq3RxxzxW0sIEIUR9G9PdL7nkq01hr/2U9Vd7Ye2caP4JuH2N1QoXM1baipEPNDkbRX5/H5mQ6NTZerdQmkWD2I1vlEm1haWkiC+yE7+OPXy0OsVGFkyovEdRDTJCGZby6tVz+fKKqwKJwUN5NTodNoKEkJnC6Yuot+imWJaNfDK29BYCIBWMGlEw0Z34/r/zQBVy4PYiHwQCvc4e+nka1sjfWzHAqoYnq1Yb5eg5iiIBp7YuNrpXDQExGZ577xL0UDNhzbgl8BgzYS6n8HNJ1p6fFiGeaYZAWg1LcpOw+/EKBZF0g8Dm+Ab7hsPzcORY+8G4jxGcGqMD8fevANrIsoVhG0hJUd17bH+MuK1Z91tcc996C6KLP9t/g6oXs34gsBBFG3e0iAbxkYw+mO88+DRATmUwthGPdf11z5Bcpu0MFOqP3XPu1a/6jmBzH1a8jUJLqCWN5JZRk2/TPukU09ZMDWISMkXPHi8VCCLdfvAlTFN/sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(26005)(36860700001)(1076003)(16526019)(336012)(47076005)(2616005)(186003)(426003)(316002)(70586007)(70206006)(6636002)(8676002)(8936002)(41300700001)(7696005)(4326008)(6666004)(5660300002)(478600001)(54906003)(110136005)(2906002)(40480700001)(81166007)(356005)(86362001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:02:03.4004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6976f1b2-e63c-4b80-8c51-08db8f302a5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

add KSM_MERGE_TIME and KSM_MERGE_TIME_HUGE_PAGES tests with
size of 100.

./run_vmtests.sh -t ksm
-----------------------------
running ./ksm_tests -H -s 100
-----------------------------
Number of normal pages:    0
Number of huge pages:    50
Total size:    100 MiB
Total time:    0.399844662 s
Average speed:  250.097 MiB/s
[PASS]
-----------------------------
running ./ksm_tests -P -s 100
-----------------------------
Total size:    100 MiB
Total time:    0.451931496 s
Average speed:  221.272 MiB/s
[PASS]

Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 3f26f6e15b2a..ca3738e042c2 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -262,6 +262,10 @@ CATEGORY="madv_populate" run_test ./madv_populate
 
 CATEGORY="memfd_secret" run_test ./memfd_secret
 
+# KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
+CATEGORY="ksm" run_test ./ksm_tests -H -s 100
+# KSM KSM_MERGE_TIME test with size of 100
+CATEGORY="ksm" run_test ./ksm_tests -P -s 100
 # KSM MADV_MERGEABLE test with 10 identical pages
 CATEGORY="ksm" run_test ./ksm_tests -M -p 10
 # KSM unmerge test
-- 
2.34.1

