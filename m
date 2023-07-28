Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0247B76731F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjG1RUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjG1RUI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:20:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B13A81;
        Fri, 28 Jul 2023 10:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVLiuRUGxo8zcrfobJlbifkQknegE5MKACQIivNJvEzzMfku6mHuah8ODyAiK8bWVv92pM6Q3v6SM5UPYwjdjo4uwFEE8HwRK/NSShCyAkY3RJRY+otqd/mNk4TOkK535jPLpLgizDAbXG3fWzNlwj3IBQWk0DfpKS18I/pjDmxhikgD2iprNjZ5BGGkkFN34qXxJCC/H5+5fFs6+wdQIXT9LQAoVW2yH1gmeXgUeeV3RIuF/Emkt5ewrpxCI5B7jD6ylx/vrdPGQW1n0B7oID4yb+peRCPuUTdGALU131/0MdoU7v4a6zJt0DEo2N6gEojlRaKw/VFN5laRWgviHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsQ3Wj4IegLGfYp83/8UeU/kJXCVWeck5aXmwz6/aSg=;
 b=YzyrHBW0euBkAxXgBcIPF/FJZajKSq7CmynV/nZamkNY99QpFur+AbVpZXdQ18GQIAbzGnbUM1GasdXQGYhm++xALN/F9WUsWAIbbw3h21L6FT34pfccWJr+kzQQSoFSYoSNcX2t9j0ddQCEa1T5OJqhQJ+0VPB4O1O1bEE6cefJHXjI+lDb/ACsfhsfZ7rY21dDtFTfLjg06ZlriX517wRZQJAKhOiPz+Y1eZhl1kAqi2SbQCYf54mA7/w53wgme6WkHnlo6AqVhNwWyXiuMWGOPqfgJCf49VSDzaarR0ljuY/jjDxaFDNW0BZ/E9KwmP0gg2fuyFHx1930IWXzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsQ3Wj4IegLGfYp83/8UeU/kJXCVWeck5aXmwz6/aSg=;
 b=P4SMeLDEA/uQiH5lFSi3jrZQbCH/F/uGfS8ZsO7jWkiwLBhz0Hn0GxONwXgRl/Sh1y0EIIZWU+AQRMzUuzZGMWfMgHAcovDV/ero1DvufFPZ2+U/dsQlGiJ3k1e4vM63E+c7yzx7aoDgyg3xjYVHGzy5bFmWRygLmr52+r1/XZ4=
Received: from MW4PR03CA0157.namprd03.prod.outlook.com (2603:10b6:303:8d::12)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:20:03 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::5b) by MW4PR03CA0157.outlook.office365.com
 (2603:10b6:303:8d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 17:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 17:20:03 +0000
Received: from BLR-PF38F8CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:19:58 -0500
From:   Ayush Jain <ayush.jain3@amd.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <pasha.tatashin@soleen.com>, <zhansayabagdaulet@gmail.com>,
        <tyhicks@linux.microsoft.com>, <shr@devkernel.io>,
        <raghavendra.kt@amd.com>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Narasimhan.V@amd.com>,
        <Santosh.Shukla@amd.com>, Ayush Jain <ayush.jain3@amd.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/2] selftests: mm: add KSM_MERGE_TIME tests
Date:   Fri, 28 Jul 2023 22:49:42 +0530
Message-ID: <20230728171942.4683-1-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728163952.4634-1-ayush.jain3@amd.com>
References: <20230728163952.4634-1-ayush.jain3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: e446e773-07fa-49d8-51cd-08db8f8ee15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rv7xQD2Cxx291vpIq/v9YNAJnnWeloFjpYG2VdDH5wy7OuNdYQQ01EQFC2zUDQjPTueQy393NyyBcqiCVojcCOkefHDSy0iB3gB9JH681VbMYgGg36620uYuMBwsSfR9AHUDmCaBmzh9Ifs/N1Op33UhiahbY60+H4VKoy0Ds+fQjVeMeSO4Jv6+Mgg8+TbaI2YKgIYfsTwNyZrGLWcCU0LdWHT4Xat1Gpr8SOY9/0IONxY7j9wdtqX86BsO0WWIahAiNJn4jY0ngj2tDnvARgy77bi/C9NRAZTTmByuoCFgwmazzHxuXDXl0MLM0vVw5xg63oeKEU1r83GKkOEMnO2lN3fSSg9ZZM38I+PZ+7/G/j+Szl0aKuU8z+QtfBfvGyn+HlSO7Evfa8tqfk/ys1Z4VtwemnFYtmBeRvsGPxhF19AjN4/JVS3sSF2Quiaf97NQfe+y1aAlOHClkU1C9xTAqDu/LS97LZ8+8AyxdNq2+NjbKoxtNsyMBU7wrJMEzbghZPS+7GAxnPrqBrLBxUo10Fdw2Pb6OeR+u+zReSxFNQevvNMTmK9zEB862fHdO64f8nofZqE0FVerMyuI6q+DArcLE462pWB1d4r7jJnjgVYRSyBpHXl9sUqh4wMiORP50G9zsbCg9+Kzkfs2xx9MUitdvmvWJzFI2PVH34SVcNV7sUg6FDL1UpAu91GDyEK82SMQiLK95RHG7VtIA69jlWVBt741/nS2Qaapk2oh8/V3rJXOjfICRsQjVH5KQKds8q6BerIcn4WV7g6SGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(81166007)(316002)(8676002)(47076005)(110136005)(478600001)(54906003)(86362001)(70586007)(70206006)(5660300002)(6636002)(4326008)(356005)(40480700001)(1076003)(82740400003)(336012)(7696005)(40460700003)(26005)(6666004)(186003)(7416002)(8936002)(2906002)(2616005)(41300700001)(16526019)(426003)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:20:03.0637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e446e773-07fa-49d8-51cd-08db8f8ee15b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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
Reviewed-by: David Hildenbrand <david@redhat.com>
---
v1 -> v2
collect Reviewed-by from David

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

