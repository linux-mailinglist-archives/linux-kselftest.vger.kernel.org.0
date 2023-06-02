Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8C71F806
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjFBBfN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjFBBev (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897821A2;
        Thu,  1 Jun 2023 18:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AglRFIm+qSBZscSUWSbU5kIQ08iI8uhEdif6pZGyl9F4zFCUKYEKFkMsfJ0EyiiNb0zZtf3+a8+tOIQm31yBdViyGka+6vRYy/w7A5r+shudbvGpafe0FIBiqRXAXd3lNuAZmVZzwCdYPTqduM/Si/vC63m26odGDlwWZzS6KeT6chxIK7ipivCV5R0LGdovD0fEBW16vWMo4Hh07L64lCW3bLhBuX0IzYT7vaAhp+O6DxfNZgzLeLPT1dsssD583JgrYd8swk4LxOspOJzxzeoV5VK71PCvIWSbZKtaZC3I9fLz+FQ2MeTvSu+6zVTkJn9NQr5Z+VrPx++MDX1TYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSj/wHWVVrHTw92AisT3rGa5w70JG1HYobjvIzezNpw=;
 b=F+4S1Ztx9yaDRInfW5AYAUbLCc8Parf02l98JGLWKo2vmNEb45MZBdJZYbajx3yV7h4UQtp9P3X/tjiGiSJgOIskFNHIfAyg8ID+ZYKYP7X4GF1SRhGefL0iogo3z7OaKz/VM4CCK6TEwwPgK6IQKBntB893Jgr4wDJKKIOfscoPackp1n05w/wKMF/lSYrUKRdVXC8ug6p9I/lfgCrI+cBO1TElwNvNB6aNzhlvHj4HJfezue419z9u8za1YV803TflyiVbnyZKSXx+FGNzjzuhoSa5LLg2JMSMjGxDZQA0kjkzOg7S3rgkEIEL2QCWoxkCIBfg3MwexhhfnKZJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSj/wHWVVrHTw92AisT3rGa5w70JG1HYobjvIzezNpw=;
 b=mbLOle6BEWar0koouPoDh3d3g0K7N+tmi74JBTtyWTW0+uAdQnB36SXDQSOju3xyyDsLeWfQEth6K5SD8s0ZRXgYjGk98J5VNhZ05JnH63Eb1hQFNH+ANuN9pO2CcJHnKNlpMaJL8L1hdjayRSO2z9s57vKmZgyEb2u6KTLlfrOazXyt77+EA/hwAqcoP4K4q5rYT4cQ+OHBNhSxWDkvZiB51+XZxfSFIlMqVF4mPHhUDUjcZgkgEa2sWp3HmLqppxnOyavUcI1dwK3jSiUsgidmOdM7FtYd0s5O8ERCZe4wNUJBt9TfDf2bZkSCXX2rArYJw3AhGjru6JSi6DefTg==
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 01:34:42 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::5f) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 01:34:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:23 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:23 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 09/12] selftests/mm: move psize(), pshift() into vm_utils.c
Date:   Thu, 1 Jun 2023 18:33:55 -0700
Message-ID: <20230602013358.900637-10-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 2964d185-02ac-46f0-4353-08db63098999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNdFJ0JplC77gejZMpWXM7Zz6uWgwriI6JACJTt+nRbjEqXKLH26zcypFxsvEsU3SH3wOqORYJ42cYlvmS4YlsxjY0eKn9BfJklJNwtLm6Dx9aRQBGlp7yCqqGnIujLNf1kRMRwZKnVY3/CwF7XwVinxasyQ/CjssrJ2GAt4tw9AEzJt1VUKaKL0CfTVyFpCS2UNn4ifmNMHDyPulOlAuQOwXD3o7Fj/KgjpkI4gtknccZLfv5LpdCIPIxd9iT5gneLWmA2efAiLnI3ExgMDlamlmrJQ5pjh8a9mKDifMQW09GjUMtP0/ZEeVEVZw+5gcTFljbDJLuOYjcxOew1MZWxdzW7xuVCgNpSGZ46o2pHo3krt9E7BqcdKZsLnq5quJEc3vYnI1lYeqcA7DqQLjm/lkyxhF+o3D68LF176WxszFhyNDqtH1p3QdHHPIOkbU2lOJzByTKi/XhdqOB08r39oEzfyy/z1ZGx3gVFOYZlg+xACO2G7+FErKeHfrQHDWd72QxMSua5+Bbw9Ws4ZMGyczvxlEGhFFawFmlXXBUQA3+f7+RlqeCRJp9VyiI5xRcktjqM+5j3hlyDfF0n4QXtSZKaST22PYbnLe3zIouuzSc/MDzTvfJV8Biz7xkHZ3AfRZlcLm4Dp3U3+PtamM54LN/oo1cJQe96OsxKqmIolDYYSuPNe/Riw+Wk0KJDaY7GIEuh6ulqaKZiVaePChYCdp93lB5tjef4Q61t5vqs=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(8936002)(8676002)(2906002)(70206006)(70586007)(4326008)(6916009)(41300700001)(316002)(5660300002)(478600001)(36860700001)(7696005)(107886003)(40460700003)(6666004)(82740400003)(7636003)(356005)(40480700001)(186003)(26005)(1076003)(426003)(336012)(47076005)(83380400001)(36756003)(86362001)(2616005)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:41.5873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2964d185-02ac-46f0-4353-08db63098999
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is in preparation for linking test programs with both vm_utils.c
and uffd-common.c. The static inline routines would prevent that, and
there is no particular need for inlining here, so turn these into normal
functions that are more flexible to build and link.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/vm_util.c | 14 ++++++++++++++
 tools/testing/selftests/mm/vm_util.h | 16 ++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 9b06a5034808..01296c17df02 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -301,3 +301,17 @@ int uffd_get_features(uint64_t *features)
 
 	return 0;
 }
+
+unsigned int psize(void)
+{
+	if (!__page_size)
+		__page_size = sysconf(_SC_PAGESIZE);
+	return __page_size;
+}
+
+unsigned int pshift(void)
+{
+	if (!__page_shift)
+		__page_shift = (ffsl(psize()) - 1);
+	return __page_shift;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b950bd16083a..232ffeb5805c 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -3,7 +3,6 @@
 #include <stdbool.h>
 #include <sys/mman.h>
 #include <err.h>
-#include <string.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
@@ -17,19 +16,8 @@
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
-static inline unsigned int psize(void)
-{
-	if (!__page_size)
-		__page_size = sysconf(_SC_PAGESIZE);
-	return __page_size;
-}
-
-static inline unsigned int pshift(void)
-{
-	if (!__page_shift)
-		__page_shift = (ffsl(psize()) - 1);
-	return __page_shift;
-}
+unsigned int psize(void);
+unsigned int pshift(void);
 
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
-- 
2.40.1

