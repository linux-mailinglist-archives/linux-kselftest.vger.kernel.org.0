Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DA5720D3F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjFCCQn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbjFCCQY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813AAE59;
        Fri,  2 Jun 2023 19:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV6FLV5pff9hLsDatj2El0T/ow/JqXsTB25pmjR4SDVw8xnOtWrjJBGUonc2uJeH8JzL3iej3nnnXhhzaYrsuRt341/g4OQ4KfmkfPvqWW+k91Hzm6H1cnMLurUvFyTTnirkmbnCpFsewPplPrSEyH2zUznBo2ubKwzgayFlN8WjQarCNTvIglAZSKcktJAQT8aU9O807eGOtKmMmI0//ULS/Bxv5iXm4GAe29G8TRb1msi8+aB+hrOS6rLPgPBjq+i7Kgtirw7JUBZSn9I324CcGiPlt156Pao3cZ2AuvoGaHPxGuI28EWMdMNFNcm7VrfytQ7kRL2yPEWtQVn2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S08M6qCxf7uj+kvbpIUgDzdHbXyg5xFGSG/3z4Es1Z0=;
 b=NEvx2FmuvNyjKK8QlOc6hFT6Y73UJyC2JHkTqTidcZsyjjOKX15B9x1fRv6tStXvAHwLEy1+XOso9b+vFsuU67UGugjcOesycxTeVoPP/N6lr+4P8WTORv8OidgieDaUu+jrKgVrtIEx8d7NdPon09t/hTquMuBpXraLth1kjg9svJ6x/0wu0MJ9RQ9BHj9cB4oSyb6nkpz2jCiNbwTI+AVxP36Y/TMPDoPNCFwL1i7SeOBnYEGI0WEVcn/I7QlS2cy7wPnH17LCLrzm+1I2a+gXSKzhHCiSs6canBFUNBQtGqKU0ZtkmZA1nhw6u0rLGgELHez5hf1t65Yz/9aKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S08M6qCxf7uj+kvbpIUgDzdHbXyg5xFGSG/3z4Es1Z0=;
 b=Q8DS1aZQTa4JD4GG+etFFtxHcmglTd3wwD1MWVa88YeAv/CQUW400IYeHNyBHBsfePsjRofqwclYxLZhOPa6LV2DxLKvoD8kY2G240SiIocHurYbf6dlReTF9cnXvg4ldtTTEtmj/RI3q5X+BwpYjzxPXtyrk7rkeNALeVl1hfnWJSmqbrvfh4suSxxqw1EBBjhCYzTZi4+zBLKeI+Q/ogt7OEMCqxPfDRwjRiA/+3F+Zyp8k/ye6vBm4AeZsBDmjiADVMyjX4J6r8QeHcCITGXbFAwt0CL7jO/VyDInBb2HqIZKtc3sQhq10++G3BIXMFwKGSIJw/emOSg3uCgpVA==
Received: from BN0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:141::17)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Sat, 3 Jun
 2023 02:16:20 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::d3) by BN0PR07CA0002.outlook.office365.com
 (2603:10b6:408:141::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:07 -0700
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
Subject: [PATCH v2 03/11] selftests/mm: fix "warning: expression which evaluates to zero..." in mlock2-tests.c
Date:   Fri, 2 Jun 2023 19:15:50 -0700
Message-ID: <20230603021558.95299-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3027a1-f891-4d0e-8ebf-08db63d88580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiCJJMDGvbPxsKulWMxttmazFQNskF66+XZ8A8azwvDMb6mf9tUvqRpH31/wsnBGIoIGeKUkKHI4+zVHmlmQ/AvYOxfql+T9wnaJeERmxon1ubM2XdxyiBqDZi0aKnS1JmT32JMRth3i5ec4ygLRPxuKupkHq0QGajJqq0vqDYdIsaLu8qgN9vpc/LmVfyJkLFcboWQrCv6MHLPi21ZpsFNqq74rHm0umI+bEJzXnCNgIsfuf8F/WrE15wQKt/C8B8Teyj66Kz5b2mp3d+aHQ28IUUI/hFbIlEL11Myt4vxe7y/FlrKYT0KT0pv2WEzTGO/HDwcG4BnPgkvXZzpCjjqFZsavqdPl1VHZLML9b+8mvktEXV44Butixsur0ziLyNmr24xzTjKgBg89cLD4EU2qxBqkomawsgFGfWQ3zMwnBEv7bTsSCRD1S0FoyQjMpA/M6AF3mtOWzIIkvymJHpJ0ZeT+zGfB/uXiKD79jKcxJ7gxV/0TwrJJT1BYPtrpzLRG40JhVw2XsVe+/WWZjWIF/3I2lEWquFxm9YKjeCFgpu/XP/UOWt7XdcKhhgQffVLViUHvX3RsYj5uxF7y8TGNwMfa2Ydg/8+3/U7w4AJiD+cmT5y6jiGuSb0ncf3bnKtXVwQD6oZ1eGY1DMdziqkhwbJRwX8WmNwFCUSvfjUOHf3IyP4qxHeTsr4tka8KGPLbTowPaO/IhmoaHejHm0eek3x0HK2BsD5FvggFL23DtfpLVh46xITUaHsgFtyg
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(186003)(36860700001)(86362001)(47076005)(6666004)(2906002)(4744005)(316002)(70586007)(7696005)(8676002)(4326008)(6916009)(83380400001)(8936002)(70206006)(7636003)(107886003)(41300700001)(36756003)(356005)(5660300002)(336012)(426003)(478600001)(2616005)(40460700003)(40480700001)(82310400005)(54906003)(82740400003)(1076003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:20.5063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3027a1-f891-4d0e-8ebf-08db63d88580
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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

The stop variable is a char*, and the code was assigning a char value to
it. This was generating a warning when compiling with clang.

However, as both David and Peter pointed out, stop is not even used
after the problematic assignment to a char type. So just delete that
line entirely.

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
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

