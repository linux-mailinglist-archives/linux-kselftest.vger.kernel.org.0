Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2571F7F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjFBBee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjFBBed (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:33 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60154128;
        Thu,  1 Jun 2023 18:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCBHbt5YIOodjPfUOjDIYxkC8de4r+fTDA3RuBhqCkmRs9hoYwZg1on1+TNLwUMWXMEUcrZn8TZo6G4Lx7cUK7YmsoxxJ6YcYV4fZOmLuxKZUFM4DD8amoudRlgb5C4FIWTUmRfu9JsStIj6rTGjeJKn/zDY5hfaqBa9f9ZGwM4agNFMGF9ZTyVgch4UajmQoVlYVdmSkmDvbNw2pv0Fgxlt/oMb8oMRqPzKPI2zhIGGm+XTEuJfF2UXrwFT4YdXTzvTjmoBC+Ijj4h98E1+DtKnlN/6IB2bGe4ihQFWau7ZM/OwSVhO62gmoJz1kyf5VY6xyZd4zF2+cWc7yN3Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMgl0DkiCy0u8hqwUZJYdqw2AWjIMAntZIkehI+DBoE=;
 b=M4UtwI3DBX5+naKT5viVFBZlHI8z8O6Sn1MTVdtwKGR1iyF84qvX9ZIkQ5JYPWooOjOX1DSAllJcGW0ntLJ6BZkrroXRIf6SLfyKNHLk6ejGKlzi+s3sdJi7rn3y1hiDM3Tc9xfL99UjL7gBbf5rDwOt5DcFkn2a6enybh9yti986hn/7dbIwoKG//NfWmouejz+Cn84Ul3YLtyLOrMWE7v0N+fOmaiH/WVVwu6E8y7km1zKZylv+MYZhIrXlLNKMgo7BMlDK5M/Zg/mZjWlN804H8W013+Dxs6ath0cjHZubCS63rXE3KK2M/gdHkdq7auAPD+QeHwUT7Y4Y0tzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMgl0DkiCy0u8hqwUZJYdqw2AWjIMAntZIkehI+DBoE=;
 b=iu+WKdfPHy6xQA45EDYiAm8KyWSoOven0if53qufV2C0cQ0JhyVoq+qjoZAnxsywHwdcSEjsYtcKUKonXqAtkChkPEwMwJacrmdu6Ed2XPXfZiBbHvupcQOIr+f2kxa7nb7Bxyi8bV0jcPabaGLtaI7bHoIy3jl3DGjWgejvpEnjE1njDypBLdHTjLiZ69MydWx+yzOzfbjEl8tEsEMJtunCEEIPXfzzlGfMxGHqzQ5EINjJVIU3O3KK2wsLjHJ5b+9YX2r57qfwBTFt9ECnV9zSE+uyDCJvKJCIOWJ20iRVi6gEP3lMhlX6WYExhgRy0YjAiPfBeLB94AazXjyZGg==
Received: from DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Fri, 2 Jun
 2023 01:34:30 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::91) by DS7PR03CA0066.outlook.office365.com
 (2603:10b6:5:3bb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Fri, 2 Jun 2023 01:34:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:19 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:19 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 01/12] selftests/mm: fix uffd-stress unused function warning
Date:   Thu, 1 Jun 2023 18:33:47 -0700
Message-ID: <20230602013358.900637-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: ac14170e-9fdd-4c10-e96d-08db63098292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afidxTc0skUtYIJV8NCzn01xbip1EvVEiMeVpotyRY/6TOrHS3KnVeSJQHducfggHUTsmCI6v/d0w9eeI8JmWoV+gkUnn0xP+h2cLhdwcGkc1QVoaR1wyzaZ92mPyEfVoVZ9solQsCvvYxSH0VfHkSxw1d4hS+OvVH4wE3yCkSNEgkYO7UolEcO4eTHA7TJbtau3W4K7ELVBghOtr2NAI0Mxog0NB5l7xpCsmFL1NvJPMfTw8LjJOg0ngefIRr+hjVYcECJzAYleIRo4BHHmEMNNQU5NIRIKaNlJpxsYHtk78UfKtC6aahhNwo+ExJUPazl7OQCFLD1S670HDfUVIzjbsrSNbcCnrqX3tUQgsovLxekWXELq/VJxFhlDxM/MIM9nRmuII883Uo4MVd8gEAI42Cji6VdEYNLPcUfzFTRc9XlsTqQ7WiTKXOM6m8RJdhzEY1HPcdxSuSKca6qaKM2sVWTnjb2/nuoM+/8ID27yjC1cRmeXQpdU3VDADIch6fXjSQMAfVFVVfsb/OBqNhsuJpAa1x5Du7sw0PRTwrMPyrcBlAsL0I0qsBjuZsWrJkz0J+rIANAbJ5fpYxq0ORuRijmxw04WF9xPP3zrDt9T3Fqo+BJr7bhZPFEf26Pkkalxfb0GxxlN8zfEdyNzANczZv5+7gshnOpBHn9HQeN/c1Gcdk3ZD1elY4y4y9mesJ/r1L1qWKnYiQM8CsceCmKcOJmIM0oMjxXHDO/wnfmN9k6h8DPgmFk5haFV6lqa
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(316002)(40460700003)(82740400003)(7636003)(40480700001)(7696005)(41300700001)(356005)(478600001)(36756003)(107886003)(36860700001)(336012)(86362001)(82310400005)(186003)(83380400001)(47076005)(426003)(54906003)(2906002)(5660300002)(1076003)(26005)(4744005)(4326008)(2616005)(6916009)(6666004)(70206006)(8936002)(70586007)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:29.8484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac14170e-9fdd-4c10-e96d-08db63098292
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

uffd_minor_feature() was unused. Remove it in order to fix the
associated clang build warning.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f1ad9eef1c3a..995ff13e74c7 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -88,16 +88,6 @@ static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
 	}
 }
 
-static inline uint64_t uffd_minor_feature(void)
-{
-	if (test_type == TEST_HUGETLB && map_shared)
-		return UFFD_FEATURE_MINOR_HUGETLBFS;
-	else if (test_type == TEST_SHMEM)
-		return UFFD_FEATURE_MINOR_SHMEM;
-	else
-		return 0;
-}
-
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
-- 
2.40.1

