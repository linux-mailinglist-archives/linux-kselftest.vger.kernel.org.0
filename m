Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7371F803
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjFBBfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjFBBev (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9941A5;
        Thu,  1 Jun 2023 18:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYErdeT95hdOa/5Plqw2IY3SQlK89prejzcHqkj7YIZOmAWn+J8Sr0yhajPbIyNgPqXV+elib8KlE1W6Ufndm0Bt0+9QAuQ0idGei5Mi2lq2a7hD0Y8+HUIAuORS27X4PZ0NBfG4xZYmzmIF2KhJq1lHVNzsH46tsKc/qzNBC/xZkYmEpxfaizXflMSbyHXydJPqLXUiAFrd47iBbrM+yc5/9CUd1uoo1cgEeAHtYSgJG/rXSFzSco+1MAtEG/IGFIJ1mt0h9TU5xHS5Hx/0WGnu9xeRaj1u6ellHFtRscRCvuMauVisyXBbZOkv/s3sWGqN8WZnojQiKsT8nmWH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WnTO4qxAw/9Yvsnqt/NPZv6wDuq0Yr6MQhOsWHeeSM=;
 b=HSXAzDLHVVXtM6C24A2fDRtUEZJleNQ6ExybU3g3kEQSkS2qlgnczfmh4ZIJa4PKXfU0V/Yywx4AfEDWV7DAxdL7v2+QLX1M1yL9lpj86iiYGW/sO8y1TlXuFcAsFmyD3Ocjod+UrLCPzp1eL5Dw150lqmhsoiHqNjnnruNmhmP7x0fiZXKVg6ERBDjhmSrqjykQENoUZqVEa4Ym3ekTfzLIHcgAuUP+MXrnvsV3NUUSKN6uLcnnTekxaOz9HcL5NCnP1/1qbdT6PFCZcjkz5luanSBZW0cTwYiQsA2GA4uQJJ7dIjDrA3u+BJ6+Ors8WpYyLP+jBAkF6VvPXjh3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WnTO4qxAw/9Yvsnqt/NPZv6wDuq0Yr6MQhOsWHeeSM=;
 b=FQ/CHSscA02/U93aveyxcJS1aaLiYXliF1Qkd0QWuxrc/KPxvZE1UzbcriLan6FItYpwL5XHih8NReMnD7uGI0mWrL06Pu3tdnT8BXrcoqcgFM37Vu84fZXoMXMqdDQEgV1kyecQgP80H5mjA9/scgQ8CFvpJsb92uTICe/ctZ6Cf9Sr/BQDC/ytRu/A5y14mGYuV0mQGi5pelnbTvLX+vnObw/EWegkQiUnDteAk9P+w8E0rt2YT6y+9myExXyuXJRwydtIUg4Im7o9nPZ9Nv7OAbBqg63xGnKJ6xDioN7oPVyyl/7fAfvsUW5ADiJT/TcAzay0JB0vA+oh2fN9qw==
Received: from CYZPR19CA0020.namprd19.prod.outlook.com (2603:10b6:930:8e::12)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 01:34:39 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::10) by CYZPR19CA0020.outlook.office365.com
 (2603:10b6:930:8e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Fri, 2 Jun 2023 01:34:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:25 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:24 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 11/12] selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP and similar build failures
Date:   Thu, 1 Jun 2023 18:33:57 -0700
Message-ID: <20230602013358.900637-12-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5462ff-b8b9-437d-4932-08db630987fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3djDqDQyk/cF+6fOCiZ3tunUgGsyErx6IxMNkWZ/LO1TFP9JDR3WEeKgKPBickci4I3u9N/fwNQH7pLKLSFWtRMXPzIwRX2msxSZjMw/6IUggqNmM87dlV9KF5htV4mKWL94HtxQUD5NLFTKAPEnNZ1J52F6/kOwoKpThh+2iuu0pV71UdQCHkZamooQQL9xGY7EknL0cy4Yps0Tc60yDiqJxrMpuO8syf3LZlZ0lA4kYxFQq0HH8GMU+N7Nw7FIw/OO8CPW+7D/jCsXsC/JI2SSGY6rnpT88hKp/LVbiDJdNclZeIWgbXcVBaa0af13VcPvAJ4xUiU5UqE2XtYe8Gp4s0w3gWIohBYomqfiR4TesErfjFDEZzOeBPY7P1S/cip8K0bn9sPEdwdl28qMJbftRg5uSr+7TLhxZ3CfjJPR5OSMcR1gzIsiKZNlx/nqu1t1AokciSAdCQCS761/j/iJ7D2MFFtvb1WnJg7PtDWlO7FsaPEnS2VIHTNQgN1RLm8AWQVqttO3GQAEfxrooOFc5NamJ/HTWfZQ8iAOAh+RPao9cqkEuS3y55/t0pZXKyLdhdq8UYLVETJBuEq2lJ8FfS683/+HeAGDEmvfsKHWS/rqMTtE5whOKXHqJnNx/9CMpI04sVqTpJah7ZctW1nTr4SmpZwczUSE2ckSZZHg+dYu4KTR8QEG/zN4fpBqOgYv8k8OikOsdRy5sKKDP3ssogiwBe127GdT/dw84v0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(2616005)(47076005)(83380400001)(336012)(86362001)(70586007)(6916009)(70206006)(186003)(4326008)(7636003)(356005)(36756003)(82740400003)(36860700001)(426003)(26005)(1076003)(2906002)(8936002)(40460700003)(8676002)(5660300002)(54906003)(107886003)(7696005)(41300700001)(6666004)(40480700001)(82310400005)(478600001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:38.9407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5462ff-b8b9-437d-4932-08db630987fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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

UFFDIO_CONTINUE_MODE_WP, UFFD_FEATURE_WP_UNPOPULATED, USERFAULTFD_IOC,
and USERFAULTFD_IOC_NEW are needed lately, but they are not in my host
(Arch Linux) distro's userfaultfd.h yet. So put them in here.

A better approach would be to include the uapi version of userfaultfd.h
from the kernel tree, but that currently fails with rather difficult
linker problems (__packed is defined multiple times, ugg), so defer that
to another day and just fix the build for now.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/uffd-common.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index a1cdb78c0762..98847e41ecf9 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -36,6 +36,23 @@
 
 #define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
 
+#ifndef UFFDIO_CONTINUE_MODE_WP
+#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
+#endif
+
+#ifndef UFFD_FEATURE_WP_UNPOPULATED
+#define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
+#endif
+
+/* ioctls for /dev/userfaultfd */
+#ifndef USERFAULTFD_IOC
+#define USERFAULTFD_IOC 0xAA
+#endif
+
+#ifndef USERFAULTFD_IOC_NEW
+#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
+#endif
+
 #define _err(fmt, ...)						\
 	do {							\
 		int ret = errno;				\
-- 
2.40.1

