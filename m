Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11671F7F7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjFBBek (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjFBBej (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:39 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A65F2;
        Thu,  1 Jun 2023 18:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7YFww84kNcRUrhBWjVUyt577NpdzHrq0QSOGiyiQqdDlptLU+z1L7mhCT9bBX0GHdO1pQoma2K5X504udlGXF0Si84fNcunnQxFleMZ4Z8fcdkR5v7LMr415/FQvQ6FFD0MAGSJ44jZE6jjuWqQeII7stSMzJ/968RsP4r8r2rceaUtQiyG2pFBjpt++SFsRiPnuKL++i7XzrcntCLkRoYN2uG92EQLpRK1M5So5ojvil/yhZOX4o33gCI2+TMZd/+0YRZdZnbpiU01IBgknDbgcDSbmfAKYbN7c2/k6bcR+Gvw9pJTc595HhrFccuCPiIQgs84dzj75cWi1TIDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1uW6Kf9/Kha/rUkpwTG1ftY2f4dCVs//lh76DXglAs=;
 b=ilmnOtAM7mlCk3Dg4VD+aJ+xL2WTUpW45OxisQafFwu8L9UXAP1u7MAoQ42MqRNId2npNY+uFEdT37Cb9ptnh6t+/UlM+di0OQvbeTOPyFElSPMjCB7+kY2+Kg7ui4cFyDFGv/hRxXz9BHBqwBJVQIF1ls4T9WFMTW1/sjP8QecSqkaxcbMYHXR9uWWIpscE+6XIGyW282qh4sQYLNcqLiV2cMcp1rlkLCFGShXr1grNGKOzVlspK4Wxha+Uim2mZF8h7s/c7GiTx4+2muOQJnBjqvoqM8HqU/QlRf2jKyUEDrhwPqLSw3T2Bnm15GVBaXPQhe5BsM7JQhg8oWhrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1uW6Kf9/Kha/rUkpwTG1ftY2f4dCVs//lh76DXglAs=;
 b=kR9g9yGFk7fjLLK2oHlTitICAeZKu1WRq/mp5PCrdmve6S6qrSWyUC6bPvTLs2DONOoVMAakq4AnmqVGx1oFpemUWioBk1tm2M0PBjndwhaX5U0epbQDJe/tYdA60lSsC2w1XLknFARyTJXAkhHwQmTsHFQ+H2PVMwG/98RXuA9mv/Pj11C/IrmPjp1f68PKJbcB+4rAIpGujMiL2r16XF1vUjgCO3fNhfOEOh3FaVm1wHpI/cEAMtD5HAIlL1uI/TIsBNNGyMmGMZjxHrEvBeG/7moiK41SBYAXnwwkr3YvRe2dwpmTzVUYdJjaiAgV3Wv+yGyf+uY1elooe+C/lg==
Received: from DM6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:5:80::42) by
 DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.26; Fri, 2 Jun 2023 01:34:36 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::a7) by DM6PR08CA0029.outlook.office365.com
 (2603:10b6:5:80::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Fri, 2 Jun 2023 01:34:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:23 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:23 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 08/12] selftests/mm: fix a "possibly uninitialized" warning in pkey-x86.h
Date:   Thu, 1 Jun 2023 18:33:54 -0700
Message-ID: <20230602013358.900637-9-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb7bf36-5713-4b5a-e1af-08db63098657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYqbbpm3wpqjO5Gtck3nXuKmdUyyk5koYVkwL3pX+c4LzFkorFcPXQ2eMBRDY9PxAyyHldAGuhXX5DC3mo8RI5MRAeYgz4IsstD1MdvAdOPLuas1tXEAaN01cOTtd+8X28+p4KcAaen2aq8jxtEUAACCiPVG7qGhi11kz6GsstReRf5QA1CkzFRedKuRMro7WmdtVairWobw6ut9epwWlepSpWaAj3PS4kbFjvP+ZvJUpydcpL9hEG3zsIfbyur4mhbguU/g6aldfblgCjO0X8rHgseCJY4AZrf+NVZ/u1N4WelWAScw4D3u2qyGe78sUXZMclivs3eLvZFes5+7PMSvzb8/qF1DOmsBRXcyMrjuszdg2Cu31p1GuQtfd4VrhqjeMsmJ0wafCMgMii9uhN+3pL+WGrpX8PXIjphvXau9kcDfc80/uz4ipFckVI8ooefhe29gqsRopBNsdVODDImkdWX+DydJHqMiQkc0XGoPuvRWXO85eA8394zzmv2Dpeu2GPD8YmgRWUNwa5iXR4uXikmsFL5IsM2ToYGOu3zrQ0y1+n9nMY2y0n8zdGYoNMdqO5c9iPHhOWyQgP68Y36+wgDNuC5M4YiLKOA+hvSoVXRaKbodEyDm95N9Krl2B97WAmsMTeTui5CFo9vMrb2ws5AGbq8h9Yfy1Ga3VCKW+7wYmg6sjCNL16m+PqNxiGGR/3XN+jQpaAVEG5YJltQ+DZg1FUIGiaJPqapUaJKRPnGZI3ZujrXjPIlf7l41
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(2616005)(36860700001)(36756003)(426003)(47076005)(83380400001)(336012)(7696005)(6666004)(1076003)(40480700001)(107886003)(26005)(40460700003)(186003)(82310400005)(2906002)(4744005)(316002)(5660300002)(41300700001)(86362001)(70206006)(70586007)(4326008)(6916009)(54906003)(356005)(82740400003)(7636003)(8936002)(478600001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:36.1725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb7bf36-5713-4b5a-e1af-08db63098657
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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

This fixes a real bug, too, because xstate_size()  was assuming that
the stack variable xstate_size was initialized to zero. That's not
guaranteed nor even especially likely.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/pkey-x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index 72c14cd3ddc7..e32ae8a1cd99 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -132,7 +132,7 @@ int pkey_reg_xstate_offset(void)
 	unsigned int ecx;
 	unsigned int edx;
 	int xstate_offset;
-	int xstate_size;
+	int xstate_size = 0;
 	unsigned long XSTATE_CPUID = 0xd;
 	int leaf;
 
-- 
2.40.1

