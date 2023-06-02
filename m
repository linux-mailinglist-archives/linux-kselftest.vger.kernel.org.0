Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31DA71F7F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjFBBem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjFBBej (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:39 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8C3128;
        Thu,  1 Jun 2023 18:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdMP9KCsGhqmxDddDF2MrHOZrwLzj7AdoEcaYco6NAkYR7mjiDBB8izmbfxW+FdfBux27ZjVcCwVy6FHMVpFGnZPHbrm71B+K49JkJ0EYSWZxMKk+nia/Mc2/Zg0qFWY4Ubc0043rhmptdyWHf0pW/97bvvNUgu3EmPfEU44OVIAtD5G3MSm6i9+YpFZldptLJCnBNHAB3HfcpTWFsBTMhNHKEBDyVUcqjPtmR5gVt4CD7sdYYXvdu97C1GjfQBfCDtNPAPOrAiqJUduyrEhbjMC6aL0jI+G0PvUCeFz0QLcnCkFXeKfN+tU6G+kH2Lz50SFb4IVRF9YOpTz87E7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwNMzjh5s5nkmclVLYm8bSUQkCHGK/n7XmDjG5AVmks=;
 b=eOUfX9hCYJEI3YJKXLi/TZUo4wvAv0vWTFeDexlwFD3CU/xsqs3f8vTWX0opIjSwbLIO5cYNrgGziGU6RbVNepHf28Qrnbe0ZDPoieVRHgyHvdo9UL4xbHHB+AWJNk/MZtvFd/1X3skY7DyhE09viCsmBskBWDL7twEz3SVzC+ogKr6qwRQ8Ext3AcWeTAOL6T6RjHsk7SdOEl9MPArjjWtcUohyR7Nv7Tv8T1kjxIMSmzaLmWOEB7Vx8cU0h5ZfkkmdMD3xoo/76jx7nDeYFKEHeNZ7+zrCo3XU8SdmeBi6mqo3WNwTaIRPCUK/DWZmnx+i+F+sKzRbMMghcuEOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwNMzjh5s5nkmclVLYm8bSUQkCHGK/n7XmDjG5AVmks=;
 b=jNY0dvAwQA7Y8omSa2I383o+pWSnTfzz4vLfK5ja8ZglBMnia5351hpOKlPlk4EBe6ZH5j5Vl3MiA8KTaqFJ9vIbB6O1fpwubM9v3U9IL4/Qlo2aiAyFhlY64hxYImT3PS9u8GRUNLEkE9n0WzfPPGiZ0GFGwTSCbKzGT1x7t/Cetn2ngH8Azj3Cb6jXx6Dw8zX/opVIGs92+2nBJfTl8Wk4ML1Decu5Zimbw/7Wi232o8D7jkdeQVGknS1GoCpjeZls5gB8DrvC8IyjsYvOhK9X3O8fkL2CpIuXOzu84JGrsEx6nNS/xaWA7rihcMplLgMAl//NdYczEjWWGKwyfQ==
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 01:34:36 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::1c) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 01:34:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:20 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:20 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 02/12] selftests/mm: fix unused variable warning in hugetlb-madvise.c
Date:   Thu, 1 Jun 2023 18:33:48 -0700
Message-ID: <20230602013358.900637-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cd1ab2-bb23-49a8-30c6-08db63098608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpOeZFEoPonT5HtC2BW4kSCOnQK//f73J2chP6VRgMUErBUzvy5cA7Tn3e68NuUO223Gpq7emWNh/ddmAVgIwSJLYx4i2U32SmyB0BOI6IMuequ0uv1IyQZusvtPa1pv75EeGG6j40TLb/db/YrJApMzRnVzGF579rARyWbkEfxjQVlNso0BuYHQ/kKoD9bW4DQD7yT5KHiSDVNGWUGdzkRBcF/O2Ml/VtmnFGGMaIHChQQ9Fl98HXRQLGwXA++ahbppfMUcHaojZz+xhaw0rGWpDMchEuNTw3+NdLH3Fg48nf0GQ9Pweb+Sm58f6685QFrPZcnvO8HIpvOjIOcf4Cz4sgb9xvK0OJMAI2h+CTwq9LJYuhYoGLHfEIQ9gg13e1qNido86x1ecdL8fm/zNSqe/Qme9iiybjualL+n00CV6IiL6KhUzxAsFL9+bOy1lYviIf/YMQQGnba8CqTXgdDn+vQm7VwYPTZktV42nCh/e59mXAxLvOx5Y3Es8MNVAwCb85UiEP9QVoUvVkT4swfoGOmZXME6+vantvUptZ+dD1nVZjxYJub3HFC3tPyH6bwQmRF/gs9IAUyRLTQl0zbRcag3pufY7xvhKsjMLMc9aZ8tC4jwlnkPrIuX+SvsnKxben8UgjezGyqJEVgTLrA2QUa3RoTS3IlzWoIyFB2kKDCbXu5EeRfY8pvmbcfAq0PmdTvy6sFnG1t39aqqdslLHJ8yiCo5CEK/xOJrlvEMrYQ3TYVM6WXFwlUsGvUz
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(336012)(426003)(83380400001)(40480700001)(47076005)(70206006)(70586007)(6916009)(1076003)(26005)(6666004)(7696005)(107886003)(478600001)(54906003)(2616005)(186003)(86362001)(2906002)(4744005)(40460700003)(5660300002)(8676002)(8936002)(36756003)(41300700001)(7636003)(4326008)(356005)(82740400003)(316002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:35.6190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cd1ab2-bb23-49a8-30c6-08db63098608
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
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

The dummy variable is required in order to make this work, so declare it
as volatile in order to avoid the clang compiler warning.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index 28426e30d9bc..3296ccaf7525 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -65,7 +65,7 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
 
 void read_fault_pages(void *addr, unsigned long nr_pages)
 {
-	unsigned long dummy = 0;
+	volatile unsigned long dummy = 0;
 	unsigned long i;
 
 	for (i = 0; i < nr_pages; i++)
-- 
2.40.1

