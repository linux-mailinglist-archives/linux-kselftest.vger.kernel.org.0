Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11E3720D2A
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbjFCCQR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjFCCQQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB746E50;
        Fri,  2 Jun 2023 19:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr/dHVBDkg4fEY1auOksrxB+HY23ZzoVV1Miv4gF5rlXi8NV4oK/lBam/8TGoOQ1LmJsoduJGzn3ExgPhlzGY5cNJkR/ZtcdHMmxF59ja1RPukwjWACcKw7XgiKSk4DRDOiRES6bi5sSfwPDudZ9YeQ69GFKr2fFA/QaOkyh6Ww5D2NCh9b5t0hpLridKCK+Rk3Hxj5hHhvwjm3mPZTQwgggp1frwU/yqHFKk3S6JlU/QI/3wvB4DVGQL4WrySZ5jySE2y0T8UrZHuz2ELW/BUHfXLsxrBmQeoewbu8i9HalIL6TX6hDz6g50DuMJ8HLUQPo6iyE3Hj1OvQn1Ourmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQZhGUwkoU04C3ryaMpvsp8ELkjH/HHSIJHZlngWhEc=;
 b=Hb36wA6dRAyiq9W3Ltlvz3CuPxTSfPrwxniPW73RhQfOuR0JcfHZsyh38RS9+AnzT0/mXY/q/JC0LJvh3PKrBSpuud7O5PeIO8tsZRkH1vt4F2JaoDR2U8JfglevVWzO04E7oWmBDArf/ULKVD5XOE2pGDW9GuRejq4kWSr0+G8gfZXDfO2O9aadCePQD71zHG7JXMzU6kbXsOos6CuNO/NVNIuRE3hL/1EFkAJ7KTNaGXeP5Cd9BTkp7A9J9dJo9u2LKxE6BOolQIYO4eKItT6UXqOJJYmReHXxCaAy/lNpepziyzpY4Tj1O+Dif8eCV0/1kvE+rTVsDqiQbT9kog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQZhGUwkoU04C3ryaMpvsp8ELkjH/HHSIJHZlngWhEc=;
 b=JuVr7N7pPUhQfpFKDPfiI3Z+HavWQkb83KpDVu4Zwp1vmgsYmPmynqA8ojwRCk+x9rzadIySfdMokYRED+tBUqy4d22mEdGziV1iX7qoSV5CL19/KOGrZEKRJEh7a30bmcbecSPAgVMR+zceWe4PfJyRlEjf3WtGwWfse4JxPUBixW5Q8cKojqNz/WfEN7zvjpcdfCquFzzfI6WMS0fySNzPx23f5CGSE7SDPnNCsV1PWARkNR0hmIgQKJGpCit3rJPUCPSNZixDMo8IxZegX2zcJ6XARjtFv5q4a9T3AoLI9FUWUOpuU321KyQxkUuW7Lg+FiLarLhTUDRk1pznVw==
Received: from DM6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:5:80::49) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 02:16:13 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::89) by DM6PR08CA0036.outlook.office365.com
 (2603:10b6:5:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:06 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:06 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 02/11] selftests/mm: fix unused variable warnings in hugetlb-madvise.c, migration.c
Date:   Fri, 2 Jun 2023 19:15:49 -0700
Message-ID: <20230603021558.95299-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d7e732-6a60-42fc-b98f-08db63d880de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5DUClvMxV3rKsFAPWZuyCdOYaQ+O7lnv/Oau7TJ1zljJ9uYgrAifuhPWYJXWlC97QAEGr0XqFViyLTuIQP9kVM4f4zcKl9C/04c98yirmfETKFwolsSqZoo14E90fIotOhABcG9fO3hWODzzRT/zGc+++kJ7SqDGRfQPAKz4+SfnE40IHAcotYLtUhNy9wZg+k4ng9BRuKU/6aFz4ORFVCCUYSc1XLJ4V5m29t0lnMflIVsCzCbg1W0r9fF5AvhsWliNrLVttjqL7x82deLDDzQZoNk6A76grUC/MRU5AJ/f2q12Atj5TCc/2Irs8cUIDG77+zvY2WldJRgMF8cYJg7HJC4LuKBKkbbNgbTXQJLaXUUGMSctCxuLOLq2GUMZXgwM78GVUhaxQI+pa50KdoHleUZEuEQcnNSI8AV9MTo2prhIP895VAah7J2yyfY+Lhq4hkrESFXjyLtWgf0E/Y5CMPgM2F5qSvxPSJl+04IqNm4BggV8Zgv6n4UqpQyhI1J3rmYvY0yD95CobBhewx8LNKDw+sNqs7ofn1Va/MW9XeYnadu6WbJjDy3zSHWCvFKHcK0Nt2rXGVy8+29YF/iR61yp0HzKDQsgQ+eJvNcYL8V7IqNaui3xQecvNmwEpTC9n4yfjfsovEDbPrL13YQYlPu6CdRNdSoFCJXGFRIHQ3265V6YtLE1WMEuN1fabDR1/9Ous8ErQZ/OvqMhEiWICctuCNQKNog2Bcm5asWAF8Vjj38dgVRonAlprOP
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(186003)(41300700001)(47076005)(107886003)(83380400001)(36860700001)(7696005)(336012)(426003)(2616005)(40460700003)(54906003)(478600001)(6666004)(4326008)(6916009)(7636003)(70206006)(70586007)(40480700001)(356005)(82740400003)(316002)(82310400005)(8936002)(8676002)(5660300002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:12.7660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d7e732-6a60-42fc-b98f-08db63d880de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

Dummy variables are required in order to make these two (similar)
routines work, so in both cases, declare the variables as volatile in
order to avoid the clang compiler warning.

Furthermore, in order to ensure that each test actually does what is
intended, add an asm volatile invocation (thanks to David Hildenbrand
for the suggestion), with a clarifying comment so that it survives
future maintenance.

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 8 ++++++--
 tools/testing/selftests/mm/migration.c       | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index 28426e30d9bc..d55322df4b73 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -65,11 +65,15 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
 
 void read_fault_pages(void *addr, unsigned long nr_pages)
 {
-	unsigned long dummy = 0;
+	volatile unsigned long dummy = 0;
 	unsigned long i;
 
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < nr_pages; i++) {
 		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
+
+		/* Prevent the compiler from optimizing out the entire loop: */
+		asm volatile("" : "+r" (dummy));
+	}
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 1cec8425e3ca..379581567f27 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -95,12 +95,15 @@ int migrate(uint64_t *ptr, int n1, int n2)
 
 void *access_mem(void *ptr)
 {
-	uint64_t y = 0;
+	volatile uint64_t y = 0;
 	volatile uint64_t *x = ptr;
 
 	while (1) {
 		pthread_testcancel();
 		y += *x;
+
+		/* Prevent the compiler from optimizing out the writes to y: */
+		asm volatile("" : "+r" (y));
 	}
 
 	return NULL;
-- 
2.40.1

