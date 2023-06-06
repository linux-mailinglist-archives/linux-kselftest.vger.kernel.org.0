Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9FA7238B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjFFHRa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjFFHR0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03117E40;
        Tue,  6 Jun 2023 00:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEXPRkzoIgjMzndqE1RUdfl2XnWEZqAjORlniVPU869eqFXj4kUzllquY/EfQ1OVtUWIW5buxT1BV0m0ViirL2Wn6m6XAY6cUTWseq7DEr8KOBxnAjuM+v0Gda20M9FH5tszuzu1FmNr7UJXpfhR7G2icJH43wx+zKWGS058e4ssUwd9HOnq+5JKYtQpNxEQYYeknTV1xqphABBQiKQ50NS06ojEh0bCCre28Aich1dj6vYE14U+s/Ei3faUoJctQrw0mcHnDpHL59boRJorAzG2cq2Ehq9r6NYh/JR5ui6RSCIbcrF6+8GlxmvBCujPmLcFJxiwrZXlYqEZ8nNFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/GcSFki6gkb8xdTqFtxT9LuvcMcqdER4egYKBl3qMs=;
 b=O54/TtuCLmvck9N6s1wKQT8k+Yl2Vh9ZCgR4kGa1tQDhzUHomLiNzUo/B0VJ13gyU3z6kGPabYr5shG4zgZIZMksyXhnp1H4zMUXd2djHX9o8EPLGO1SyulmijMxcnSNsfx/ci8N+a+P3dBhgJ1fGBtgC/SjAtukLSK7rdYgz+Dz6zaIHt4eot0UIJzc5k+3n1nP0G/7svW9aVie7WpX48FbisevmRVPtQfNh6cFFEdDg4QignmV22w4JED6/VLXfvu3Ou6pEfP5AegL9aCLynai3+7rG7ivqqbh8gadxLbPqavwdp2pAPNlgJRB+C/MxpsfeC3vyPFVWJAh8HC2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/GcSFki6gkb8xdTqFtxT9LuvcMcqdER4egYKBl3qMs=;
 b=Hi+nV0obGlmHQFbDWCV9hcFJ/8lvPTd8gxq4mxIKJHEyWeVOKDiSQY82AQgqJqm7RQ6dKvjy0ZOJ7N9Y/YQzfZICz/1Ymd2boHtaUaeU3zSCicKZDU28TDPR0Cnxl4/bDpSEd+DV3c7Vx36ABBkHtF/LpLg4IVTTGL0EjR1Av+G9GSTF4QRe6XaHHhV0bxTXfsuHxST0JOG7Gdz6LlYFv3Vy6QLSppS0ZerxVDiA1OCUvFFf1Ng0PWT8O0yCtv8lcwcKeYiilINkVPid8/2+/07/PeCOYOmZQ5cCVLvrj11zmRtTF94YR8WoplWe31Le2zGvB1Km+sQeubm/Nej+cg==
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:17:23 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::ca) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
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
 00:17:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:09 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:09 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 03/11] selftests/mm: fix "warning: expression which evaluates to zero..." in mlock2-tests.c
Date:   Tue, 6 Jun 2023 00:16:29 -0700
Message-ID: <20230606071637.267103-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8f41c8-e515-4892-ca0d-08db665e12b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyMDwNmntgWoMJ5IwDjBrm5greNtHe+auxXOO3XhLmG7XX/UDDofLluMBXhWUCF/cmSc30oAG4Vr42qwJZO+sbnKXYAklTDXPMKUn3rx2X9kZfZ18hkoGysQIdoMNjQTz4/Xt2jLEz1H83AyWfJyWDB4VlqTBBElZZbLQjqMQE1r2tAgjRepHATcK1x0hzF/7V+ifze4RSHNad7r7JIBqBullWBzZ+o5Gn37WAfC8ZRuPtNegIH2oQGvd7+IYUgGC5V5j0qy+CfSkNvDog3cAkc6OAGB555zwZqRxH1MukhmWwQfItbsHduXND7zmU4xeeY7gbjfyE8g6yZCg/yyhWXkAWbJfN67oNvvNi5fU1uu3UPNyjP3M1n83VKaqqOH19mXY6uM9K83C7dE0u0lKcHsqUcMmo9/WmfgNZ+rF5OpkEO1xfgkYz3eHzb1GRN8NzHO73Lh+/kUCcMvPNHB21tF7TZwaiR6fvuhMTMTu7n/HObHhS2Uk+O1Sa6wtwNk64H752H1kM06kmRmgsFqFx6/sVZSBbTzBwgHjmzxzDIGbVhM8mkS+dAlVU1COpdydGca7uFO/qbhOkjmZvyGjskENdtGX6djwxjD8/bYpGH6QZ5OQuW7o6Y8i/lx9F/AGLpDpJSLfpm2lgN+gkAGEwJoDZKfNEZHwIg20kcN3uQUj2kg++1Yk9Nf2W0MkpwQaGxOsX2lndX+5fcP4A2VyPNaAYMzEhRIml/pWsdSsUeoMfsrSR1XDIgs5vCSbDsF
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(26005)(1076003)(40460700003)(107886003)(40480700001)(36860700001)(36756003)(47076005)(83380400001)(426003)(336012)(86362001)(82310400005)(356005)(2616005)(7636003)(186003)(82740400003)(8936002)(41300700001)(54906003)(2906002)(478600001)(70586007)(70206006)(8676002)(6916009)(4744005)(4326008)(316002)(5660300002)(7696005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:22.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8f41c8-e515-4892-ca0d-08db665e12b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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

The stop variable is a char*, and the code was assigning a char value to
it. This was generating a warning when compiling with clang.

However, as both David and Peter pointed out, stop is not even used
after the problematic assignment to a char type. So just delete that
line entirely.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mlock2-tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 11b2301f3aa3..80cddc0de206 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -50,7 +50,6 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
 			printf("cannot parse /proc/self/maps\n");
 			goto out;
 		}
-		stop = '\0';
 
 		sscanf(line, "%lx", &start);
 		sscanf(end_addr, "%lx", &end);
-- 
2.40.1

