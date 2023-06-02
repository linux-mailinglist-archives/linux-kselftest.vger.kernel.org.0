Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57C171F80E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjFBBgu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjFBBew (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F71AC;
        Thu,  1 Jun 2023 18:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS9bDK/M9taxjg8H1l+Utf6RrYA0lGIv6YN5ecTAK3wEJlPrgl1SAuK/fp8Reksexmf1vaDGgwUw/gs5yP2IwbnAUIO/8GigFQgTkZeXGqr22Z343Onw2DcYvfjlsa0p23ZYvAmGXTJ5ECOqUI1ueNpo52CB2ktNVlJUhQ0taQiYGw7NUy7xCkZOx7yP85fwN1V2dJeXbyhb5TOTceajeIIbAfOiWVBvG16mSHgEq+l7/orQEyW2n38CUsILiRueTQ1iX8Ih9KeSKWVXIymWTJ2EPSoSjPQ8xilXi3qbhV4vPm/qLTBWCdTovAgnTSMm7rjArlZtPQKtXUE+tLHjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2zFYpTri2qrz4Mp/GE988kN6uRjrv5qlwoCMnNc/9Q=;
 b=alw3psCdmNY0oQm0r5lTzkdnRF/OtCDHSnHtRCM8q6VwTxJDmSh97vciCPObepywP9wk3Oq/MXFN9PNa51VqN2Cg7a8/wFenv5KpxIC3Q2YjmSwIsgPAEHWRSvpQB7JThUNlvY+mYAxSAkndPgod1a5bR0wDqil8wdESTVPIjCtgy6j4zexyhbOsVeRgmvdjgk6ndR0GKYu3O1nNoRybqfnFGG0SgczT20OlAgnJvQmTgxReQuhuATiTjuEkOhIN2RBx60cCuZc5ppduyk4bOoYhK/0ckMYDUURYnXQ45qdq+mvzqXN8tr4fCPhvT2InBa6TFu4mwjGmYjY3uByrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2zFYpTri2qrz4Mp/GE988kN6uRjrv5qlwoCMnNc/9Q=;
 b=N3mE7C2RQKxfLJfzra2DowA8poy0v94/YLGOotMhMnzU12AxzvRP/Iw+jHPspw84uJ8zuTEVfKoCYn36jfKFN8fCzbpDEG7Mc8IE7hfrP3HqHvElUBQUpSl2eOD8FWDweSDFWM/0To4+MR86i1EkC7WGZSKKjtCprX9Y7JKuCHYaQW21HWNhRaWx/j1l6r7+0x4yqUORHeSYkTTET0UjgFCU1IG2Nta8ZsTWl0sammQZPPsalHwBxqhPPmsej52/pquDQrm1RiQeOru2Vt3M2TtH0estYxgmEiAKaX0xs2M0apg14/Ec5jtCWgNyfBXi7Q7F+nSnEexu7fXDKeMZWg==
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Fri, 2 Jun 2023 01:34:44 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::5f) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 01:34:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:25 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:25 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 12/12] selftests/mm: fix uffd-unit-tests.c build failure due to missing MADV_COLLAPSE
Date:   Thu, 1 Jun 2023 18:33:58 -0700
Message-ID: <20230602013358.900637-13-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|BL1PR12MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efc2e15-8451-417d-f172-08db63098af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hogQB3XLr9nfYX+Y7inGO9mIpGJMMh40p9BXUHLii+LynswQ6VPfhtkYMnaHja/ZDepQYBBqMDrtm06YsVvaBEeKvXYwoZRfzlK04Y5RKiVnB4y5Oe0Mr1xoPhk/JrKTJaatBRP6w8YlcTI9b3tFi0u4Z6XRqc3QOzXTzRGrMpmPMU7lwGYtlp86Vcv1DQDvdBBt5yGw/6Mq1Q+yd569xhYAC4OXpJ5delF6bvgw7KKVo1WmqymvgUwCoI/wIx6VpAVr/4vZzpaV4NJEfwyfRPic5uOn61CYnzOZK227txXu3BAKaxIECmsexjy+IZlbG6jAotZJLEaazAl/YqioGLhHpq+vchyvGl5HgYzd+u9UBiSoI9ae3pQyb/Lb36f/RthfmnhfCOedhmc9HBBb5UB0Fc5OS0ah97dt1gZJE9gaKKpQ2Zoig9BODb0M7/DQDzPuf3L6erOPAId6iWVwolr//0GuhBiJa8QckKPrF5RqfldcPSTEkY3Zy2WkSgH2we1ck5J2oBDaV//gPNRC6PQF1PqLe9AXcHn4F4psiHmaaT5jAKf0fSsqosFfATiK4SSRr2EqTcAaELdCiGyjcg2FTDhYyCrUvfWGy7zZTchkuoUngYsufYb3I/ACH05GZAHcjdN8qtdQRQ0rrhjKyP9vrsqTLyDlJle0jVQDNZtzjRACcaOx8+PSYpkHK2Dnz6c0YkdTftYs0SlGCi5SQnefSDkeCnOmOn2GnYkGrwIml4t5dVDKR+F7tLsjODoO
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(47076005)(36860700001)(316002)(6666004)(36756003)(70586007)(70206006)(5660300002)(107886003)(4326008)(6916009)(41300700001)(82310400005)(82740400003)(8936002)(8676002)(86362001)(7696005)(7636003)(356005)(40480700001)(54906003)(478600001)(186003)(2616005)(336012)(426003)(2906002)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:43.8527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efc2e15-8451-417d-f172-08db63098af2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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

MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
defined as necessary. However, that was being done in .c files, and a
new build failure came up that would have been automatically avoided had
these been in a common header file.

So consolidate and move them all to vm_util.h, which fixes the build
failure.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/cow.c        |  7 -------
 tools/testing/selftests/mm/khugepaged.c | 10 ----------
 tools/testing/selftests/mm/vm_util.h    | 10 ++++++++++
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index dc9d6fe86028..8882b05ec9c8 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -30,13 +30,6 @@
 #include "../kselftest.h"
 #include "vm_util.h"
 
-#ifndef MADV_PAGEOUT
-#define MADV_PAGEOUT 21
-#endif
-#ifndef MADV_COLLAPSE
-#define MADV_COLLAPSE 25
-#endif
-
 static size_t pagesize;
 static int pagemap_fd;
 static size_t thpsize;
diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 97adc0f34f9c..e88ee039d0eb 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -22,16 +22,6 @@
 
 #include "vm_util.h"
 
-#ifndef MADV_PAGEOUT
-#define MADV_PAGEOUT 21
-#endif
-#ifndef MADV_POPULATE_READ
-#define MADV_POPULATE_READ 22
-#endif
-#ifndef MADV_COLLAPSE
-#define MADV_COLLAPSE 25
-#endif
-
 #define BASE_ADDR ((void *)(1UL << 30))
 static unsigned long hpage_pmd_size;
 static unsigned long page_size;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 7f5aac0ac680..f04f82771cd0 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -41,3 +41,13 @@ unsigned long default_huge_page_size(void);
 
 #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
+
+#ifndef MADV_PAGEOUT
+#define MADV_PAGEOUT 21
+#endif
+#ifndef MADV_POPULATE_READ
+#define MADV_POPULATE_READ 22
+#endif
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
-- 
2.40.1

