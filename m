Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB5720D40
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjFCCQY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbjFCCQV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B7E50;
        Fri,  2 Jun 2023 19:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUWL+FWzusZCsXa3496iA4IrJcIx1sCKGbwQxMvWawi7ygVrFpM2byfOY9J4rr1FsBMWLCcUM4lQP+a6L/K49804WRjcLgiJuLlMo0jxl4WWLgP99BFuXD85jvwAGgoOzxDLm0h7apFV+phVNSZL5zgYSITnr3SylhxUqEJiNeRLcq9HFBU2K3nrYeYIFIEsgnjqHeON3lE77IKtwrJXEoOJZ1AJWGRd874E6GGxXThHL0pg6pi3Yz96xzyskUkTt3B/MnE8CHRpAY70zxxr/X7XDSzWcYF87UagIJTdEVkweKWkPFHqQUARZLZ++ow5okkVGruHzpjvabfgPPaicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCV4OGw85JdREHNb90EA9+G/fEjEeMMfpbm2v13o33o=;
 b=S39PLRU/pLCimfpFWhiFIS+Pq8WWQt+9UKC+JDoa0uB5EDODX8qOPAIrG6ObvHlhXTqrLBQXodXAIe7AIcbHzQNpdXCtNtrKbJ9sYvTneEbyf15BEubrMb7PfKhNznPGse+nq7R20myPdfMAqcJdxWsmlVloLNqtg7Mz1GWbCwMW90/1u4WkmsnfB9+sv60IdnlMwC30J52TuM5Fi+2sqxMBlBvyj7E2qqWCIr5AT9qJil74rlIHFVFB7OAyD1vX9xY4ZsU9l4SHEnOWntwB39QZb8U94mUBYWg4waIlfJVI4TP3b3JGLPz5yy1wyHIB44JfGAtEg1IDryvMy3kpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCV4OGw85JdREHNb90EA9+G/fEjEeMMfpbm2v13o33o=;
 b=IFD2JA6b4dzfMo//LIseiwBGNQlJhDeGsWjn1hl4QeB0COmEZiOipLpp3Lzu+hwd8Y4oSefwxNNLr309j/mf002gE2UfAt4HI0ojpJkfzYB2osZz2bcBerQZEwnM1JNJi/dvO9aNrPPVexcmlpdfk7P/+vs9LvvX6OqwiQ9488ZIpgJ+kqWoDnbOhHEIwUXlf5jUN8MkJDa7C+DUGMjpo585Obflex+j8FObwO6vQMZ6OR7BpS7M85xwmyEZccVjgPkkjguevMzzjZijKn3iW41gg/DZO4hzR5blIMRYAfMZlV9L8tIXrlJV18Fb2CkZ/ddDAakaPO0xUcSSlYZTwA==
Received: from DM6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:5:bc::21) by
 DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.27; Sat, 3 Jun 2023 02:16:18 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::54) by DM6PR13CA0008.outlook.office365.com
 (2603:10b6:5:bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Sat, 3 Jun 2023 02:16:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:09 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:09 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Muhammad Usama Anjum" <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 11/11] Documentation: kselftest: "make headers" is a prerequisite
Date:   Fri, 2 Jun 2023 19:15:58 -0700
Message-ID: <20230603021558.95299-12-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ca7e7f-de61-4145-f36a-08db63d8840b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLfwVrGrq1zwE18u6qZn7XDLHadZq2ULwUAhGN3WlJQUP7TCIVVfWwBf+2DH8FazyPKw2IUXCXnXxytQqrONT/tyhRmfyleI3JxF/ObrPaKnnZBU6VUuqakCe2cp8BHGA2mBM4QEfI01aL7EVTacE5HCKOlRemTSuuW226K7PPrpvAw65+Zbx/n8lr9q7ly7wid5aMVMCJ5ZpYQmn6/GDsguSbUY56ekhVTnTE0ZSvbz1qQBLJCv/jZexgsXo+vcuOSz9hWHcaIkkFOj6XljYIijWbpg57oSYxAWBpOm4+IOwX89cXPxPFoDclsx1rUPVlW6gKtSoBHlCM6ijFygXlNbJ2QlsFWiiOs0TtMCp7aBkByWOEfFKVPIDUMannBpYMp1qkf9tD+XfeRMd5/NbTXaDOBPpD4S+bzPkdRuSsAnKTwps8mBSAlCnVTocEq/pem5fPohL08PyvVGNm1N5bjch6QhYeRNWfSE6Xg1FHie8k4cfRfgSuziN6GLXM4I5563zJG6SQWdtSN3vWXArWiH4c4ocvMmuveJ8WnqzfKDxEHqaW5+w4KsWbY+/JV4S0/yCoFmkn/rwFKLjCcwD/wuONATu/XkQPwku/NyeRw7BHVuRtZkWJkR1Pd3WeGInHTSithhn4dw+afQ9zoN+sXjWJvsk4Cx2TwCD4dC8bI2w82FVKoQrV1wXWYjSMLqm+pEjmSLegt5NKgzDnA+DKyglS4b0BYi0jU185jTBshrqAXK8+sFeqHpIBS+RlaFlN+5eKRnKVGjBjQAn+y20BLaUnR6VKN39jFvpuClWng=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(186003)(1076003)(82310400005)(7696005)(82740400003)(83380400001)(2616005)(7636003)(356005)(426003)(26005)(336012)(966005)(36860700001)(47076005)(54906003)(86362001)(478600001)(316002)(36756003)(8676002)(40480700001)(41300700001)(70586007)(4326008)(70206006)(8936002)(6916009)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:18.0956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ca7e7f-de61-4145-f36a-08db63d8840b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
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

As per a discussion with Muhammad Usama Anjum [1], the following is how
one is supposed to build selftests:

    make headers && make -C tools/testing/selftests/mm

However, that's not yet documented anywhere. So add it to
Documentation/dev-tools/kselftest.rst .

[1] https://lore.kernel.org/all/bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com/

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/dev-tools/kselftest.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 12b575b76b20..6e35d042199c 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -36,6 +36,7 @@ Running the selftests (hotplug tests are run in limited mode)
 
 To build the tests::
 
+  $ make headers
   $ make -C tools/testing/selftests
 
 To run the tests::
-- 
2.40.1

