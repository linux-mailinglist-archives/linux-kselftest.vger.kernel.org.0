Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F37238B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjFFHRf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjFFHR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E50F118;
        Tue,  6 Jun 2023 00:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2+CmJOknzOVObATngbCndj5iKnYErmTawNWfqhtSn6UXR0xtVj6v6/27vDdUVRAyerww5C5IIBBgCA5QsgY6lNcMdIRATW1vthSDHrRgY4zDN7Fa9tXXXcxmfvRAOk4LlP144MTFP9bHookg017VUw5tndB9+en0f0l10E+0OgCDrOPhGrJkOM4GUiJSX7h03Gw8YJZHCAKjHQqDoxKg2ygp8yKt+t5BKQYKnPNuQKxkRhgLhK758FjSevlKc1J69ZeB4VWzlEdYkuFrAjrcOxJ8kbWw4v5G/7UFnh1ZthqfODYmqZRtAvYvoyckh5TZLbS4QoLhAhNZV4UR8xeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7qWJ0iKcBH5AScsmOvvAEPpASsgJNPE7K/FjHHYXLU=;
 b=iC0EQvt+uC/D4dgHBveGWXP3WZMd6ueA2+hWS+Gguiv7sqSIHoFES0GqHPniw1yq4wzSTTxMgn5ry+yLenFNOm11ADBEZWiCVVDcmcJ9mZ1CrEeyZti4w3hKDjPpMdN23A+5fD/zcsqndoIC/bGDLftyT4QdZ63T4BHzZIi1xpJ0vkh3JXzZrRRBqUP068qU+cuDv/9cUXXqcQpvzbLX2pF1MFnK84j26Dc+pgRaXucz8xqN2LMblX78ncO5rn8oCENHVVwI4jxWA5ROMXRLopweWc/TADdW83Hzg1VDEFRNAbDg6/3MHwQGUWWFBrxsOy/sBkynZ9Dzw5BNK9xibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7qWJ0iKcBH5AScsmOvvAEPpASsgJNPE7K/FjHHYXLU=;
 b=jI5PQzww6bCAvu45bK6aiQuKfHqGm/DsQJ0YelBM0ekYCsleZAlUG0cnHtUdYAwa2YqkiWeO6QgvOtwKSWLmKRFTgQyLKMWi7ZoNGSM9kh8ludXQ3nZy7me5Il4H8GWaqpV2riffj8oVro5KITO6d7XftR6v+bcMSkRZRjeWCLlo2NuTDzxk4gV1J+o16FZkrQ9kDDRRMc2fbJ727O4275bpQu8Ys66mNtl+NoY5o8F7AqLs+/hmgQH8yquBGaXmcgaQ54Z6k06zv3QEUEaxCGEdFUVsmze0+znvny4IQgE/L4Xkt3hJfoqrzu584dC9nG9TXGps+iD/XchDeDY0eg==
Received: from DS7PR03CA0156.namprd03.prod.outlook.com (2603:10b6:5:3b2::11)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:17:24 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::51) by DS7PR03CA0156.outlook.office365.com
 (2603:10b6:5:3b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 07:17:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:11 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:11 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Muhammad Usama Anjum" <usama.anjum@collabora.com>
Subject: [PATCH v3 08/11] selftests/mm: fix build failures due to missing MADV_COLLAPSE
Date:   Tue, 6 Jun 2023 00:16:34 -0700
Message-ID: <20230606071637.267103-9-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: c254bc15-b3ae-4900-90c5-08db665e1392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJA1BoOtz50E7jA7krOEBGGJ8vpO0oO9I069MuRt8i/FQL9yUg04697EN3M8YVLpRCAOU3R/Z6JJ4+4FsVvLWT1m7yTEtry1V5JHVY0ogIp8m00Qo5qxNy1FWGGZe7AAhcoVdOnCRToY/C6oeADVJ3E4iTolbZ3mg69UczU2QZDU6QYMXMnOfvmFmDQlIG/JBpuVdannau89tYcxVz/Q/J77+HMhHPSImi/WggiHdXZytLEFLis35vM/7+8Ztc2pOJiCb8+QylP2z2xPJqiUg/VLR8HIj+ChhaJFrQCDnBt1xTMOQ/S5DGQRckXCFBVMSTho5XjizWqYxG8I0zOgvHuwOYkUKrTl8R2nQRV06Xw2wm868bNdKdArg9agz/VYirUsBcFDVfQXZ/GhKoE188wd8eRtgSJnQ5N5gj5jtz/8Kl59xcNcfBDDlJrJgN755yFK4ooMaB1EALny4KbU+yzqY/8oZsTLJErFBFSl13NWJLj7lekzh0B0JZkHVlOY+SL4WZpgKoOSeflzSWMqK6D5hGsOhQ/qQddzr6O99ctquFcJmcAdzcYqnzHyiSXiNr0zg7DYPmqVUROOkkv+7slEFOI0UJYBNCqSvOzg6xG2b949H/NfzyjhUbfxAOFBFHnZXLryJZKZl5V8X7TbWzq+ln55+5YCisaHjc4FOP6dkq+PU5XLfJ3jBI98yzYA0w8XjS4+yaFy3iyx6Ag7vWw6PMy1sRdI5pQD69keI1RFY1CnQ8pSGZo+DE6/UOiq
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(47076005)(426003)(336012)(2906002)(2616005)(36756003)(86362001)(82310400005)(356005)(7636003)(82740400003)(36860700001)(40480700001)(316002)(41300700001)(6666004)(5660300002)(8676002)(8936002)(7696005)(478600001)(54906003)(6916009)(70586007)(70206006)(4326008)(26005)(1076003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:24.3138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c254bc15-b3ae-4900-90c5-08db665e1392
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

An alternative approach from Muhammad Usama Anjum was: rely on "make
headers" being required, and include asm-generic/mman-common.h. This
works in the sense that it builds, but it still generates warnings about
duplicate MADV_* symbols, and the goal here is to get a fully clean (no
warnings) build here.

Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
index b950bd16083a..07f39ed2efba 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -63,3 +63,13 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 
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

