Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041E87238B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjFFHRc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjFFHR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8FF3;
        Tue,  6 Jun 2023 00:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTzKPtksKGppwYgNWWe1FnduuQ0yXglnqHnyT3qE4dn1WY+ZTubxBcP3CHQnITDpbME5WH30ulZgFLSfuGQIdgr/WVWxCWvZRtroqnOQiQCS/Y91s0wnPIZ+a38LMXgsOvSvmvYL+4bv4PBgfTBSg66PCYIeAKNM5Yu7CWeZeOqET13quCMSpq82RhZJyekY+zdMvFT8aXd1GiSi0TH0bTKbJ+rTD+iZZekvhdo2Ot0DVQCYrvMiU4LfLD3uT26VAA3NCwFEQfhzd+fwVyQ7S8szw+x1mEeb6BwLhzRzToQDZYL2mgtx9ftUx5hGm7ZCf8tue79EQ5ixl/mVXdQO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWs0ZFZtf9AA0eJlvMtGJJaItuLyGSP7UduhhCtkPQI=;
 b=d4pQJfcB9EZrz/3udttBRs0BF/oiiT324V01U14USktRmcCSk38wYbTzMmyeGU1ilO0mX7s7J53F/7/IJxZMYr3/eenowtCBSgMBRHlU7LIEzXFR9KWTeaGmgYf6CGF33g6oZGgQ+R/FiHJv9tR8RFKF+3jEX+y0+4k3bUI2F0Df8zzmW9qlMWc15NqNmMPSIINQjoFlKpoeZGvJHqQwfIMnlyeTBbYG1HlBFG305vUZvFpGA5EOpLLcjaD3WJSFzKxk60kjRgHZtQ4SvlYf8hJ508uU8nQXz25YyXji71n3wnerNeEbYrNceuJdGeyoJvXax2b6V/d9UIZVW2g86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWs0ZFZtf9AA0eJlvMtGJJaItuLyGSP7UduhhCtkPQI=;
 b=FrW8qq3iIniRhOKjcrMk+tI9RGdFsQuV9jHdARaFNWwo9wZ/EJ7BvyuyWCKCwYL4hff2JLyo9B2RZ7h+Txiflt3FA/W3Ru6yg+RtXPSFc2LOHZy4eJWdUv6jxiuCjdMJaJ5NZ4ScNUuTMV+iFhlBDx9F4kHLzbkKNC4UO3yfBfqleI2chzAyBbdk/jvNebgEl7czaEX5utv8UVj/hN3SLBza2PtUPbzWoygCaZWRMfuxvswaipFvsPP9DGq7Uu+59r5iadLnlgNTYr8eX3PkzP2q20yCz/kpQuwy3Zk6sZL2I4VXpzqC/llXRGbSEu4M1alYLt43K+5c/XWMDT4RYg==
Received: from DM6PR06CA0020.namprd06.prod.outlook.com (2603:10b6:5:120::33)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:17:23 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::b) by DM6PR06CA0020.outlook.office365.com
 (2603:10b6:5:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 07:17:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:10 -0700
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
Subject: [PATCH v3 05/11] selftests/mm: .gitignore: add mkdirty, va_high_addr_switch
Date:   Tue, 6 Jun 2023 00:16:31 -0700
Message-ID: <20230606071637.267103-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: abbf8a5a-5236-4074-5695-08db665e12e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7I+GSKEN71Z+WjprJLpX5AT6QOgRc9tEb+m3Jh2/YvridkV0KJH+oN3dxX8mWSEdL+XiCD81a6YTBk8jsLaASgOfJRh0YphOxGrfvrX4tcnEc0pQpK2CiozxaPB0eE+onZ9oVKcYpaaTto7pvTX/u7dh/CI57D7OPagcuQOsk+fJ+lsRqAMtYrXmvDU2WtWkn5M7IiPz17UySWU2wKKiiWl7WPXGPd2eDuSF7dgh+LsNJSpfhfeE+EVt9mu0E8Nw1H6qfj3XZp1ZakUKvNhodCgVXRc+G4cunVnfZSuSkK9hZOoGLg3FgYIdKrWdyE1jRphSvZ472okpOVUeIPH1ARfIxheOprWXI8SgunEQu+xXInuiZS3laKPNxUTEb3GL2TU7CSu0K4gGQFkzv9wzU5dGXNqKftpoakp5RCEft9MYvUsTlwn9L6N6mDahljObAnzfvtLKsVPMgH/raj0Et1zGoSA6OnnSXn3snbNd5iENJj7mCS/mSzzUArYndNq8HN4Bip95U/c6MHFvmDuHm0T4UKhsyWIJOQ1BFpl4seN2Ey5fkmFEuo8qoK/K+FigGOerucipMS6dtF99VnFiNvrNxpRb5hot+ZdfaxoVrmThBGJh+G7eTCQm+Dcknk/wO59YLBjxf6eAVI7A8RE11C2XSo1Flt3O5+Va9ukRg1WziyirZoctvXefFwvICMfmRRyQLy+tNj8S1wrlCf4SgURycBKhCnOHqA96cSc3Vq33xAt4H0C3x06G9nqd7514
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(107886003)(1076003)(186003)(26005)(2616005)(426003)(336012)(47076005)(36756003)(6666004)(36860700001)(54906003)(82310400005)(7696005)(4744005)(2906002)(8676002)(8936002)(82740400003)(40480700001)(478600001)(40460700003)(6916009)(5660300002)(86362001)(4326008)(7636003)(41300700001)(316002)(70586007)(356005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:23.1695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abbf8a5a-5236-4074-5695-08db665e12e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
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

These new build products were left out of .gitignore, so add them now.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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

