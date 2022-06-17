Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808F754FE5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiFQU3y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 16:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFQU3y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 16:29:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463365C667;
        Fri, 17 Jun 2022 13:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSP+4iogq+TFLoNY5uQODqxcaOwKchkxJvKyMcPW7ChkKOKLlI0S3m9PoUEDKbpRsRSSLrxzgRuAqHvsZtFuz7sv9AyXzsek7lOVwQQnJ/HLHzm1ORI7pd9ApPTa08Yu0EVQDyqe3MLw1vsH8NF80GE++z3jhB8lOz471u7WWVXKFmQkGnoViY6byntF4rVtAwQVIkNupkyVYVH//JqciXsqU6Rht7UUZ8bgMcm/jC/ob7gQE3F+jo8QAigJUtcVtjv19W9s40MAphLYSCWtqaVymDqdU2DlQBpTNfS5IBbrQulENwCmjetKiHe9uGhaKv03rfreKpDUPNgk7gHWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h71o3MzoDzF3LLHXKe1qKHVG9WVQKO/eyAIcHygqIMo=;
 b=J/R0I59PG/NNb7DVhjCtdmfAr1QZqVoEkCwAxZHV4kkUueJnuewkgMP7UKdKeXWRMnraV4pwpcafbMOdB0s9yLdRyicLbqtj2ZMRT4WjRL7ykrR0PWoPhTtYEhB6JiQlT4tXAItvaHuAzCDpQ7V7JpICbHl9qKLs50zyDj3L6aKCbKpLXwfBhN6hYxIF0FJGUINyB8J9hnCvrApQJLmHl08X02u0dhXBEtvnmBcw348VK5hHEhZqaoGlZN7Irm2NG6Q2vWbmoj6HM6SgTLPxbVo9mk6mXG5zBadEVxRAfvclpZwvjUkgWrP+pNtDt+2lBJrPSZ31w7DgSHEz9DHFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h71o3MzoDzF3LLHXKe1qKHVG9WVQKO/eyAIcHygqIMo=;
 b=hs7Hxx06Cl9SF3NVQdxIoYXjyKgfKy/9w06xnNt0oaguAyeSl0p93r6BY3JfGb3/7YuDcGvYIiRlOwaaNE/VPnk3T/DhIaKI57i8gawZgWTkGj9Wo8tAAJJP5D0FOZ4KCL7TnBSk3F9SGQO79UnWVn88Y+BfjS7Oyr0I4SBuS2M=
Received: from BN8PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:d4::37)
 by DM5PR12MB1210.namprd12.prod.outlook.com (2603:10b6:3:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.19; Fri, 17 Jun 2022 20:29:51 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::b6) by BN8PR04CA0063.outlook.office365.com
 (2603:10b6:408:d4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Fri, 17 Jun 2022 20:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 20:29:51 +0000
Received: from BLR-5CG1345Z9Y.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 15:29:48 -0500
From:   Kalpana Shetty <kalpana.shetty@amd.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kalpana Shetty <kalpana.shetty@amd.com>
Subject: [PATCH V4] selftests/vm: Add protection_keys tests to run_vmtests
Date:   Sat, 18 Jun 2022 01:59:31 +0530
Message-ID: <20220617202931.357-1-kalpana.shetty@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec8738d-2d02-467c-895b-08da50a0219c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1210:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1210BC11A4EC8705886E24DF8CAF9@DM5PR12MB1210.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhykEKRTA6hShTR3G8CNwJaJCyku4SFFhP4KN4L6NxsGtIpPqIJXqHmrbAJFjTZ4R8uDOTEagzJufdrthR9WrZJQyEQtAg2zijsvMJeCUsg0VousraNrYZBO0AyP8PZkrlEYjLyqQDVXlzMZCgj0fdwz9hqbIVO+9gxSFoNoc9jmx4zDHSxmHkKoR0h/LoEI791poilABV1T4YcCnI2U3/8CXvWXFoH+zbOQFVg8dvoofxUd1lXmb2R6eKo/jMUkfgsBOjFj+CPGw5NPOHL5nVwit3Iw5JecbT0fkmTL505qSv6mx4fwARClVhGQMvFtr31g1SNcO0IJxHB75NPWRwapHxHo8QGPhARmfSfvPtJgHpdtZY9Mqi/baZfosS3XE76QHx1rlmaLAmjlPPf8dIejIas8JKW5x8zf76zdybjgDmg7gFfgnyjS6qD+A/9nuoCTG4K43F5SpLY5HpBwhK/vMuaIFs0DKB55iwOBj7kMvgd8+lmTKVVrK6TJQRoO7fNR22lS4KPpJJ5JpUzfnbxtfB7eGc3ZOyoROFjOXx7/3+zNElOOvI6JgXVnJjSa+qWPot755THSgyal8lyJ2YoStfbHHtSZDpItNQkRWsAThCjyv7YTeCaZ3tjtGNczrFkkGfsjHLikmOFZhuZDiuNnAT+4QlPIeSRvapVuhxQJukqhDdiwRSBpUv00hVRh67pKXE2irmZo0BRQ32jcv8K6uMNROKthnTZg68kzwRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(26005)(70586007)(8676002)(70206006)(110136005)(186003)(426003)(1076003)(4326008)(336012)(8936002)(356005)(16526019)(47076005)(2616005)(7696005)(86362001)(82310400005)(316002)(2906002)(5660300002)(6666004)(40460700003)(36756003)(4744005)(498600001)(36860700001)(81166007)(44832011)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 20:29:51.4461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec8738d-2d02-467c-895b-08da50a0219c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding "protected_keys" tests to "run_vmtests.sh" would help out to run all VM related tests
from a single shell script.

Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
---
Changes in V4:
 Shuah Khan's review comments incorporated, added -x executable check.

 tools/testing/selftests/vm/run_vmtests.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 41fce8bea929..61b1ca129a30 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -179,4 +179,15 @@ run_test ./ksm_tests -N -m 1
 # KSM test with 2 NUMA nodes and merge_across_nodes = 0
 run_test ./ksm_tests -N -m 0
 
+# protection_keys tests
+if [ -x ./protection_keys_32 ]
+then
+	run_test ./protection_keys_32
+fi
+
+if [ -x ./protection_keys_64 ]
+then
+	run_test ./protection_keys_64
+fi
+
 exit $exitcode
-- 
2.25.1

