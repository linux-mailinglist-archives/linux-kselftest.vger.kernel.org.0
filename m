Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E535720D3E
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbjFCCQt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbjFCCQZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09048E60;
        Fri,  2 Jun 2023 19:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+GUOELodQSFJtgUeZ8N62Kylc5cHUtPDTcvOPUY3EXTizswi+NgN5Fw+v7f8WHpj4H8F2lbrJZizljU9MXUYRPsIg9hxN2oCMoKvCBMxQRfq1ciF065TDNviaA/C+ZlWI9mWHc64FZSLBPwdDClfuEQkPOClgq+1MrerH6CPbPXAUCKNDyrZ7LTahwXyCOucrRdShwq1l7/qqfzc9EczF2aqWWg42KboGyjxXlGjtOJQPYVIY8wKdABK4FA3AjW2QBa/cemhEnTWcXew0LMhuAM4nzA0GFnJOoVvpoozd53gNC05tMpZMpx0NajGgzjqMfNsVhybQv33XVfG1Pd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToV4OSx3QPDe8A2n5xRR83mlRss/zXSB19ewrV89/Lc=;
 b=FVbVeITpIg3rzhuIDKMmhvcryHEp8UW13hnSHqgLQrLygbXoExVF7F17y5ci8ChuKDmClOBpxmAPUc0xbTq/3ae0daR4RIYMuBcuaPqO2IcNJ9ZX40ZnZfc5tAxvSl4TXQCyx2ZddFcQMW1V4h3FFL9+YKTL+5Hu20TXO3hhQt/B3Z6xK8aaz82HUr5TmJb2ZeNiA9xWs0l/epIWvUGdU+sBwNJkn4SyHi87zlrDPYBC+LGvgfodCgDtxUDj0lxWwZDi6wRfdd8PO0BhZwgdwnMDE8Zx+saU+ajBs2jL8hQwUtCcEgualoMkbcTu2GljOiIl8+xrduIXhXh47pfgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToV4OSx3QPDe8A2n5xRR83mlRss/zXSB19ewrV89/Lc=;
 b=YtNmyWpoZbvA+ObWgnQgIxEcXP8geKJh1KcfYYs67RwkpUOd4gZO0rPjiDX6t3ncwfLay860KiLZL/kzc5aylM8wbIWnHsRwtCCfRiXRFtIkrQx0rm16nVn/hmgVTkGKXlUdz6YBafe+4hFjJaWL2jCruEkKMUhZ2mC0Kj+Q6sHjJzSdDVG8sLh1OveTxzIm1rjf7/2ZSF47LLvup2Y8rrc7lOewedRZXIjGtCSOuLt4lysxwmCTCAGxsvqtR3gK/XFqck3MPEjuB9dFsHH18KOFhps2rb+JxoWXfVKuP9d43orzwY1QeL71QQGbFg3CGrFZukJ2jEtdytUcSrW+og==
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Sat, 3 Jun
 2023 02:16:21 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::5c) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:07 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:07 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 05/11] selftests/mm: .gitignore: add mkdirty, va_high_addr_switch
Date:   Fri, 2 Jun 2023 19:15:52 -0700
Message-ID: <20230603021558.95299-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 99103549-f104-4f08-4d98-08db63d885e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBffJa2/V1BFw1YUkR4xCDIiEXFOD7cbGd++TXxqQhH8zNIvNtZQURJ/FXPv4lMiWG2SKieOkOl8fMtRiV2uEVeZX05olIPT7X1F7NThYEQboZrM04eUQHHzOlmLh/FSnGnR2yq9VPyWZnzvSjVuATBrUCBPbu4Uu1lRPziIQ2OwW13FAkzOIvt5GWgPTtD3/mkPwZjrzOzkicsTsqy2BSMdpHw52IrxFm3gV/qT143H7JlbNCLx8lW9MnZFy07ZhJgdroPwuDBLzqHMs+P8c7u/xnngjMTLezEFLorc+TqAhzWWmEI9HeiotVNKKnVbwdW7yyfEAyUZCRdEv9id0liguuPIaytMVthUHOXWX/zhk6lFot2ZCjmbCr0uoufaa+xegX27dUcnkqp4cMS/kS2Hq+eWPLNCQWAaOP3xzrHbpFbDqQHVJ3oBS70SFlt5SRsIbbPzHy08lPat1lP+g2gUymFIusUVCADHZoJ0F2DwIm9oDY1eDlilorEnBTPmLpgWAtPaiGd5sORgKVL6yV1R1GN1JoE3x/W9cTzzMoruIxZ2lmGVPdBGmEWTLR56j3ZGbRWoy+5JnxLGo8b4umai4euBXPagkpYOIfb2GnVItxDzpJu2aZVPlrXxgt5SA6nDWWiblujgJc6HtruUy6vmVjMlBFaR8CSMDO112VSLs1uZAn2mYg4zsnLP/0qPh7iY6hv/EWGFZzuGH6ATjOJ9xz6PbL01039yn2NNBSrhv5d+t9Z9QQcbZcJVO9EI
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(478600001)(54906003)(86362001)(47076005)(36860700001)(107886003)(186003)(26005)(1076003)(426003)(336012)(2616005)(356005)(82740400003)(82310400005)(7636003)(36756003)(6666004)(7696005)(40480700001)(316002)(70586007)(70206006)(6916009)(4326008)(4744005)(2906002)(8936002)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:21.1468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99103549-f104-4f08-4d98-08db63d885e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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

These new build products were left out of .gitignore, so add them now.

Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 8917455f4f51..ab215303d8e9 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -39,3 +39,5 @@ local_config.h
 local_config.mk
 ksm_functional_tests
 mdwe_test
+mkdirty
+va_high_addr_switch
\ No newline at end of file
-- 
2.40.1

