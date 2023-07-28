Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD03767215
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjG1Ql2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjG1Ql1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 12:41:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C43C35;
        Fri, 28 Jul 2023 09:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQGFh3hl/WCG5LhUQ5cOec0irgUEd5kz623ZeLSo3LE3+T8AtXh6BRexgY757mi6OqN6eIS7vaY56yf2/asIanpkSGE3GSsf9tCmsxMibMzOVLPzsMZ55pAlr30UzRJ16AO1Hk1KyIPRijspHV+7w3MbSs1T82EtbDlZsvxxz2BtmNZgpq0xTcHKJL3V5SCVQymuLk1DgieSt+Y/drB3DCb0+Qny7XMMFrdfk+TIXTzzIztA2/Shmj1Vlr1g6jaPMqG80QLC2OV6LIht533vkRZMOFYitTDeFW72mBq/TDwGba9AYWBe9E6zLJ0s09QKdBgdBA7qSS3HxrsP7vbL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsQ3Wj4IegLGfYp83/8UeU/kJXCVWeck5aXmwz6/aSg=;
 b=EQvAb2+sUqPhbHzG4eBgjPsxbiQt7IjE2WSbnz+I9adCIcZvpCCHl2KA1FBTkwida0ogF1VBZ41cGHyhBW6anM7mgmZa8cxZ7YiCE32vV+fuqq25low96a6DQNmJpr+31xONOE6n9uNCF6ux6AB0IqMjHiI5zWl4mxZLueKUyKY3d9Q+FXkvP3FQYQu1f5vHDhGxBfms+FlPKdPLftUXeJn/+Lyos5h11pMVjpe4heXU1yLnaBaId7wKDJGjUQ+PcfWeI1MxQXuJyf8zBZhfh7fjdMxnQPePoCk5/tr5N3bOlmU15cUMpqOT6nQcKdXlpJPWAY4Q1C6ndFyJnl6VWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsQ3Wj4IegLGfYp83/8UeU/kJXCVWeck5aXmwz6/aSg=;
 b=AH3yAzONhnExP/A9nk7HTKfDBELXkxIMsQLO8s4IgEcdh752krIGlQBi/7PD2PS3HFFrAKlCYonL5eCSCOzSujBpqxif8mIQz/RL/gUg50EkWcJ/QAHb8ATIVOCHkA2ubmragFqSk1S+yQi0fiQ7HOSF9ERVENubA4lo4uLgJG0=
Received: from BY5PR16CA0017.namprd16.prod.outlook.com (2603:10b6:a03:1a0::30)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:41:22 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1a0:cafe::41) by BY5PR16CA0017.outlook.office365.com
 (2603:10b6:a03:1a0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 16:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 16:41:22 +0000
Received: from BLR-PF38F8CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:41:17 -0500
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
Date:   Fri, 28 Jul 2023 22:11:02 +0530
Message-ID: <20230728164102.4655-1-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|CH0PR12MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 91682171-bea5-4911-69e7-08db8f8979dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yxy0vHFlWv/w8ya7wgiL6OmB9I74OV59heuMawk+pf2ZsZ9ubivde8cV5ZxN0p7IyTFoe7OCCnk0ZaVmXVqvTwciBeRiI8CpRsA+0JEkmPYeNcuXzExIIbedJ7zQM33oLIFQHd5SBhG97pfHoG/rmXGG52MnmjtKpThJdtXiNPKR95TiW3lE3nVQVQiNoIeqBtG4CgAA57aXySgcg+dRuRJZnlMhV6wxJTWkRS5oRIR9+XucWjeltvBeOPtG+skL5beqph+ZeVaTO0ustGH3htUtmqCWczJwXCqThJp2yIGBTOEAl/bWDt+g67c12lWC+ank8Hok08kxHKosPhWZbUxw6/0r+bzZUnchNuJl+ibHhI6GQfkrg5kXtWBkzlQpKtaaF3q62kOo9/+9O/cM27AFsuvcUEo8T02SUog5xdoRksaXfm1tONpet3k+GlZXG4l6PLZZET3lIeDkR0klSk0E0NyEQlxNdnCcIsEM4LXKLe9VwV3cO3h90mb29nBdy2Psrw5eUiJSPHw2xpp+dahzV0XXtcs0G0dNEP6tPXhaD2pQaWicq6De9UmiVmGtt1jmMt7xBjhvbUs9na7h343jxjMPJ/AdeJCG4iWBE98fdy298ZGRODHybI7lv5nf3+FTH3zPA9UcgVNjEY4ExMTJIHXi6alPchZLAYDiTxOwQAhc8m0zd0MXtvLDw2b554G4tWYyrPtywxL4fg4DVXfnqNLrkU010033gE8Wl2JYEjoDT/GKhQlS+mKOXN+3pPd43/DaF1pFy7qOch/Bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(2906002)(47076005)(426003)(2616005)(40480700001)(16526019)(1076003)(70206006)(336012)(70586007)(186003)(6666004)(7696005)(54906003)(478600001)(110136005)(26005)(41300700001)(81166007)(86362001)(36860700001)(356005)(8936002)(316002)(8676002)(36756003)(6636002)(7416002)(4326008)(40460700003)(5660300002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:41:22.0055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91682171-bea5-4911-69e7-08db8f8979dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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

