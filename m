Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D97238B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbjFFHRa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFFHR0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C786E1AD;
        Tue,  6 Jun 2023 00:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxb4OK+blPOmfCbfbFwS7RtwdO42XYZpU5ZSW/ULzSlDNLDhFNiKBGo4v09jVDQPB2CYJYYISek9YrkqX+IrwTrFvqdj2/AmJ+u6hKRLFOKoXYk5ZkxxNBzzzxyHl6Tp366Hqc1kHXri6Zh5TsZEGE+CPzXpyZ7IPCxaZUlNyl+s0QaIfhMIZkTku9TSqinCW0uAFPo9lbCI8jJC0J3J/etSaHDtYeBs7/5z0uxgsXfY8/wyxYL8/Yam1jrvXnT5fr6lgnkoxEUM2xHjK1Z1/vdSJsEhWOA7gPUsPwM8jzQsfnqA8LNdkIGLIOOLc2cUQlOgHBsE3vb9i0Ep9va+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP9o5A+zo7bJweh4Rc7yXQPSG4GKmkDno5NX83EjreQ=;
 b=L8F4h4luMVb7aHHGY/TakNjh6bV1spHTg7Sh3v9JKC3637admAXedzvu5lSfhZQsZXezDHASjO6g+8zxIZo+E94C0rFzZYPSRZ1jP4ii25xaIFp+QMOGCP8CvHEJpJbI/CrggwZOxMxHbIICt8i1ze/rWozz4zmhieTEd1hVXZKjKH7Uo3h2cstif3hk/FmHY0m86OLNGdk0Z/zoNbpVtIj3I6SnjgjkBjDQBwnMLn1nZrpQVmwdXhy1gPhq+XPVxqk9VpeLa2SDeNi3v/b2pcyooYUeOo7t0Oy+Cu2SGNV2Yf2wcKhZVt6Joxzc7Trv0pQQ7X6erk6IiFZtGbYo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP9o5A+zo7bJweh4Rc7yXQPSG4GKmkDno5NX83EjreQ=;
 b=gbKCs76rxbUz403CqK2c52BEcRCpPw3+jUixDiwSPG4FhHSPzD/T9iZLM5ANBfJdg1cWqZY5zmKdI1/EsTY+A/77v5segMma29qvOtr64q0HN3jhpe8Nx9NzbBfGy2vv7oiLuHMNjLzRBQ0EcAqbJZmQUsA22qXk4ZtBpUu7jlAsdUqAbnuscPVxMBLD4CeeYGSwoG2fVTr3XEOYS2IRPPWyDlAfiE2PoKoxWRLRCfRihU/+zW15YynvkInoMlyftFqUHBbo+BiejnLQLlD7FNZGJuWIjsyABknUgbphy9qz7wz05SfieU/NXrjYJR5v+spTCIXWWjERhBdDF2F5vA==
Received: from DS7PR03CA0296.namprd03.prod.outlook.com (2603:10b6:5:3ad::31)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:17:22 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::60) by DS7PR03CA0296.outlook.office365.com
 (2603:10b6:5:3ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 07:17:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:08 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:08 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 01/11] selftests/mm: fix uffd-stress unused function warning
Date:   Tue, 6 Jun 2023 00:16:27 -0700
Message-ID: <20230606071637.267103-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|BY5PR12MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: a31904b5-6bb3-484f-a921-08db665e124f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8WLAVKrtcMWNwSm3gAk54ZpLalVo5DloersbxMkOh24+6SyeyJHVF2piXYfMwp+NlHC0cjge1UlGT/zSedJu6i19FxYVvVbnSsW8rr6kcZxAiROKBBpxUGqo1JKODHHH8Zm9aH6hvmTHHS5JCwpTNnnwd/be5DvbzPGRp6z1Ujx8Q450wCOO4QdErNxf+t4SWZIfUk54/bzo8SsB1vtqlgTPg1MopW4ruI0vG5lJAdq7koxysc7KxaUrHi/d/6/IcWWuoYrIz1p2Kl9+qhHURZe60crOPmh45n7l4vPLtJlS0rodUz75WkWMW4eu91+9IsXOHrtTWNXBolpc9btOapuHsFP/iwRX5FTLhi2NxDuUwlMnqiYpN252cvAAIPdexl3ZFY1vHmWwWWqbWLKyU+lRbNYmfXdRj8LT7CPha2jw+2xq3UIWRcPqXiKqAZnn6kj37DcQP8lydmQ8Cu51eORwAutLjXmXu4mGRi7rBaCUxQcRMjY2JsoCeehX84gwW9ujGhKVYL1IrergrRPFlic7IeXQbFLDHobmkchIl4nadT2da3zjqCbR2M6CvtkZDd1oAtpE9/NfGcTHit7EGoX9dsM2ejTnqkYqHWfHr6EiNbS8WwSnJ6gJFnFbpzDMZ0zKqydqDjOyB4W/Kli5IxNz22LrSSICMUUx9atlprBHg740F+S9woiLrvWneDqd4EXSC43zhtXF5xq0k7Yl+iKnG8E7+KKEQALBWiKpLyfDy+Z1DlJyVf5y+FrWiR/
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(54906003)(70586007)(478600001)(82740400003)(356005)(6916009)(8676002)(8936002)(41300700001)(4326008)(316002)(70206006)(2616005)(186003)(426003)(336012)(36860700001)(83380400001)(47076005)(7696005)(40460700003)(6666004)(1076003)(26005)(7636003)(107886003)(86362001)(5660300002)(4744005)(2906002)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:22.1820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31904b5-6bb3-484f-a921-08db665e124f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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

