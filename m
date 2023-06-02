Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5471F802
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjFBBfK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjFBBes (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6369138;
        Thu,  1 Jun 2023 18:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckQwf989ZTXULbnQLkaejzyJ1xe2eyF4vKQ0NH8J5Q0TwqUgpmm71FVTr2RYeqawXOx230VzoKBwgHd2Rbxaq+zBJoyJBXmeekW/XSo7GsxqoSgcDDSEXayTjJOkDAre9nD0p7kmUaiYPPB/YXdwB5ieh89iK9zuogQ7Exp/CeE9pHp84BvI1R+osuspZ2wOSCNKb3PvAqpJJCw2zVB5HewdpTWLHtuKCv99aKa79hP4oNoexmNyWewovBiXE3CwXaKsAV103ZB8rcfyFOQafO1zm6att7m5FOYH5/Pk4FEvENMc4fNVAcZVHSPeyQ2B+bqmNK0ZQC+VA+MaWCtNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmZVj+Qts14XOWi38dHOr6DxUVKKC0XpuAZpHeEnUuU=;
 b=TgpHZv9L3P2ZyTLmu9DrASCfuPmfax5C0Ry1oM73Rcq3yvB2lVQtH07Dmqr0Sufa1/Y/0ySYZC71HJKNuy4O0p/0opOjrvCmMgCM3LNoiBwNR7lVmEbTdnh4Y5etGYR1K+pfSoaxnUcNp0JM1OXdDaSBrQZTuUqNpyjP5HdLhb1rESACKO0vRpA4IXrKZ0kVkfKS5nsXY5gWRvC8On7XEYKtWI/X9Aeb/0rPiBBZlyozdcypjuZy/sgvcLTHaradJdnDlfzcBGc22yJUtG1L5FadBmXnseWZUi8kksIDaQOYFq1dhUvTeaN78TmequynLYRcftxPCLtyYw1pJBqR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmZVj+Qts14XOWi38dHOr6DxUVKKC0XpuAZpHeEnUuU=;
 b=BxpaWauMkLCRmZ6NFWCyoKBJ7+WhzlOlFB8MBPh29vo7MX2bM7YBaGKSCskcyl3PtF38jUA21HMBypT953lC8+QRVWCtVg6W8kQ4Np6dIY/9Gi9rstyVjKLwX3UtQMpN44Ba+j2ykld+ZawVd6DTqKJKs8xQSk5aLdmcvZ8jJaNKbKjGnxR6RfUdVidzBANr0AZ6Moigv5aiq38Zo+LHqD4xjplBnCLjpvuDvP8VioRVEA1AC1NWZPIwAaeOpEkzkp2090T8iHR/DFDG4TY8t1l4q5LezusWJHAyshn0aA0+tHVhN3ZqHxV/twla4PrmWqyU8iKQFM4AqwYoS0tOAQ==
Received: from MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38) by
 SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Fri, 2 Jun 2023 01:34:39 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::9e) by MW2PR16CA0025.outlook.office365.com
 (2603:10b6:907::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 01:34:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:21 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:21 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 05/12] selftests/mm: fix invocation of tests that are run via shell scripts
Date:   Thu, 1 Jun 2023 18:33:51 -0700
Message-ID: <20230602013358.900637-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: ce607a4d-b166-4e9d-c651-08db630987ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGJ15Pz/mXq4MJhGU7HflwVMbrnMxxr3k1ykK+v2cpE+VNDtqFmcqqS8C8AXv/n2eK9g65330YRHdnwVK+qujcIYzfwb2EGgUGeMJWR3o+qxWv/s92Gg2NieiLYXuIIJks9bzQXGWo8w6jrXQa2aWWMQUYYjT7iJRhJI+32n57fVNdqOKF7fHvqwLaMUZKZ+zvlI/FWlFEYhNDuG0smBsRJhxklxW4Mx2tJdebo0yffOdtmE6iwW0dWlWH6amIlcyI5aplvPvLoxQRFipMyuXn/6BSAjog6z2iSeIRKMC1P1SR8HieNShOG+GsuQIVO5IsNrz0Am/Xt4lnU6BVgHRdtTp/yksoKu+xSBqWGwO1Je+9jp924uZz/gBb5RKLwURQsWxvfb3ctxXn3tOUnwo++tgKx9Qz++heERH/HV10loK8I1mIGH1zCXb84z6PP6Tbebo5DtUQJUSeBYlq+VTGtGzHKTSNQ0bHY8WrmlJpGMW6+3kuCw26SjcIh2U39eRLghXMqaddqcVhB6HPIhENIQ3u1noY0OyZHWvZG880JsEjmek4xfyqianMl9homdny5TR0G6aIlzUxB/pMUSlIRLBQFdYsNc5TZ+EqtqnxRTd5EWtWqYN/FX1rpHhdcfjstwEGcJzdMCwnlhtZJiaBZSO/0DLF3xUQP7ewbBKqgEyViIS2bL2hOknIRSbMgdX0QBGX1jjnfe/wQlG9vTNkvRQHGglOkxtHF6mYRZ7MbalndxiIHxTfSHA4hSsivC
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(336012)(426003)(2616005)(83380400001)(36860700001)(26005)(2906002)(8936002)(47076005)(40460700003)(186003)(107886003)(8676002)(40480700001)(82310400005)(478600001)(4326008)(41300700001)(6916009)(356005)(7636003)(70586007)(70206006)(6666004)(316002)(82740400003)(1076003)(36756003)(5660300002)(86362001)(54906003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:38.3531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce607a4d-b166-4e9d-c651-08db630987ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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

We cannot depend upon git to reliably retain the executable bit on shell
scripts, or so I was told several years ago while working on this same
run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
lately failing to run, due to lacking execute permissions.

A nice clean way to fix this would have been to use TEST_PROGS instead
of TEST_FILES for the .sh scripts here. That tells the selftest
framework to run these (and emit a warning if the files are not
executable, but still run them anyway).

Unfortunately, run_vmtests.sh has its own run_test() routine, which does
*not* do the right thing for shell scripts.

Fix this by explicitly adding "bash" to each of the shell script
invocations. Leave fixing the overall approach to another day.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 4893eb60d96d..8f81432e4bac 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -242,18 +242,18 @@ if [ $VADDR64 -ne 0 ]; then
 	if [ "$ARCH" == "$ARCH_ARM64" ]; then
 		echo 6 > /proc/sys/vm/nr_hugepages
 	fi
-	CATEGORY="hugevm" run_test ./va_high_addr_switch.sh
+	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
 	if [ "$ARCH" == "$ARCH_ARM64" ]; then
 		echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
 	fi
 fi # VADDR64
 
 # vmalloc stability smoke test
-CATEGORY="vmalloc" run_test ./test_vmalloc.sh smoke
+CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
 
 CATEGORY="mremap" run_test ./mremap_dontunmap
 
-CATEGORY="hmm" run_test ./test_hmm.sh smoke
+CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
-- 
2.40.1

