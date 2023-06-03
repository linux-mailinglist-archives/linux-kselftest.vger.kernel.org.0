Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66741720D31
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbjFCCQs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjFCCQY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C9DE4D;
        Fri,  2 Jun 2023 19:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODv0xcaYn5mX2+HkG42Df6fSo8OOPTubad2Cnj5pDZabQH72geVKJhvvXjnnl6d6sOLvPQWmINRgOtepltqLQkI6u+fpLXRba1dbOF1dZN7j1wkbOTlUPLUfT2qdDfF2ZZPjtePI3CyQbbdUUByBvVVDNQNf7ZJbYm6cVl5o9FH7K5rh5X8EfKAuOWuF6op7l4dVW1uXCGz0Qitmtej2+ku24KEVU524HlwpIknoBAuNSUSVMSTsNMkyORXMdKM7jmiPFQkk2F89kdFady8CEUrbmF0JqWA7pnMNes/bgXY4OMHzAB8t5ymi32HkLkLmIvl2K/23ij4hK8JbH9NObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP9o5A+zo7bJweh4Rc7yXQPSG4GKmkDno5NX83EjreQ=;
 b=Zn9G016FmRzYerGneMBU/aHo4lRLQ+I0odlfY53xNE7qgAaCrSwi4fkRLypNRnzFCeoB+lPGiw/R3Kf4WDPzq2IHcQAUdvehMCLLRR9SGZe3V29Rpgq9SyhmQcgQ706B83mWRds5Ew8L7DiAH1cAld3UwY5v4HN9RyjF3aYpdhujEuTRxaBgmDJHUaX6stTPt9WGO2mdn09hTN8Bpe01FIqqjYv1tSVonPBLFhc47uWL/M0fHRUN6dp5sKq6FPJEakXR2PuwXkfLlrk+Pffyuyj0Vv/ol5txLiKtOMZ48F6mq/z5hrE25b4lUcOBYJnXtKh4i/c5AEWBXuhNdYSRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP9o5A+zo7bJweh4Rc7yXQPSG4GKmkDno5NX83EjreQ=;
 b=BvaiXKgg1abiN0CbWMN5v1pxgd0ZC8oiQsbOv0kqz+iKm0nNT10dZLiGLnDktE0VWdU47LJY32X8C45E/L9b7vub9a8UzgNirxfAEeqAuz3IAcW5bgfIslHn9mIuA1pR8DPrPJvjoS6acuyDx5vHFvnVjzx2oic5HJxSadExNNlqrjYAyG/G58PWFGi1GvdqdXUwNFrilelMFkJaZxIw+K04L0FoAa6wdUmhUUuOGa3WJqcvhx5ydqhBfYMrlyI+PkOimn/sGnWLsCyHzOwobQygI2TO33DoDObixEQ5yq67jn5Qc6/2bs2+A2T0/jn0rAaaHm5GdGKphar+1ekWzw==
Received: from BN0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:141::19)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.25; Sat, 3 Jun
 2023 02:16:19 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::a8) by BN0PR07CA0013.outlook.office365.com
 (2603:10b6:408:141::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:06 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:05 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 01/11] selftests/mm: fix uffd-stress unused function warning
Date:   Fri, 2 Jun 2023 19:15:48 -0700
Message-ID: <20230603021558.95299-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb603c1-dde0-4f64-f8d7-08db63d88506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3ycATQ5S/ugBAf+Rk1FYIxFC4Xi/XjdtE9YKJ0mL1VP4ym+jruxrvnoyU4weVaAKygN2qNOe+HNtSfEGxy8Td5wbg7A3RU+ZWeujztbADa1e8BSYzBZUokhONYmoZ9esrpbm091etcov1z9hcjan8ug5cBUFUQasbEyjlvpArZxaDt2WHZrDnae3n7j6kzrv3pSDzWfTYjBSUAkS0wE5pMKiBqvX4vgLsD+2l4kNAbvkeP4gRmQLTphWGKfBRQp3/lS3Vlfrx+bdgne7V3qyMkmjpvxgy4yomMcVCJtBY8rytfyPENzZ2f4/DnGr6wgivomycT+qmDi9vRP6gcGaU1TdthxvezKp05nr4B0CZ4WbROoYryuX8i3ThC/OtxdfAhOsTGWnHe53A3FUCKNvD/hv7kxzOKE8Xc6Do75aDjAbsq4YEQBAIBX2yUAlMWsiUFxtGGzaVjbjb0QN84RpF4b3xLf9cHRahgq8two6wmoOMsCVjvUhS0JLaZokWw9zzTs0J7kqWSj9ohXXQ6j0UpciFGAc9awcXvyRuHY1tvgOtJAZn8WA9cQY4AC4i+6dSfZwPgC3r6xe9TT3qKfWPPQSau8QK68cKDRgZmoCm7rklEIm6JNALsC2Jkj/1tSx/eG+XU7sv4aihm0jjSRw9+pdv5I8I3c/N9ivQwN2Sb5+VNKTwADH24oTNprKCVClba0gVjuf9nCudg3ufjLm0ybVJt4XCrW9riyp+v1aWifw/86g1kvHDEc430AffOw
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(186003)(86362001)(54906003)(40460700003)(36756003)(40480700001)(478600001)(82310400005)(6666004)(107886003)(8676002)(7696005)(1076003)(26005)(41300700001)(8936002)(83380400001)(316002)(426003)(336012)(2906002)(4744005)(36860700001)(5660300002)(47076005)(70206006)(356005)(7636003)(70586007)(6916009)(4326008)(2616005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:19.6938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb603c1-dde0-4f64-f8d7-08db63d88506
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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

