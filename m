Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926C07213FA
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 03:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjFDBiE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 21:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDBiD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 21:38:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E771A7;
        Sat,  3 Jun 2023 18:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjbRVKv5W9IkKeLJzQH2wybdmJuk+aVROpgQabY+tCkiRsSmldYp7dOrIJODlD9DNJgVZZDxT+RQ8yKm247xt8kPiDke8ub3diF5BDrynoiRwaE5PQZBoChQT8/w5dlkbTRjxaA6am5SCvMsr79oz5E8xJ9om6rAgMPwluAXfgcpQthVGLH7zUb+2xh7oW+UifQkdt/QXIGFx8EAs5E+Yiqh5tndii9mvDvXWp+jSV6x6ph8cOIiBoVE/zR2rNYcDhh19nd1ZSKgqzOiGdYwVDOVi4lvHzKz5FOV0Hky2SGzD4ACCu/LoyLO+RQzTxNr87fmlcCuNmMkOehkcVUOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvv+s8qBLJz2k4c+kDEAOagrqhFac5jQQKnaAxYvobE=;
 b=YO/6sPTXWA/u026609Ie+vLLD4ChrhtgK7+yNCQ6ppDPymJTRk81x+3lbEWD/U+JRZ2NHPOlYwIAfyWBRYziGVCa/36CKDiM6ENN/v4zwHauDF9qgClf3nPR4GwAmyQAj1bLg4bWbunEqqTAZLoZYXy0Nz73FFD6XVaJhTMSvYih4E2RW0t2WRap7BF1L5arMI4kFG/guIi6tjVvu46weJbF93/WS9RRe7FpApn368sipjU1f+J71t8Y4a4VLin5OqIcVE4uAaOWhjJ4iditLGySlk3uMlDGL0Q3qWgWaNSzfl8W8V58r8wHjl8T+py8GP7GRXL18CqwKU8oZLZBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvv+s8qBLJz2k4c+kDEAOagrqhFac5jQQKnaAxYvobE=;
 b=J1ByB9LDD5fWLdFFd4YJ6SLsw/n3JgTfegy6+8LSpAX8FRHR0YT1arCC3o5/4nFCqp+f2F+jm/PsrKMvj8BRUbZuroDEpFgVxcsZrZ5/W2aJVOM2XbFgTizIeQhOyhz6jU02nm8C2FavThYLnhQ3Xg6Yp3VJ0fWfCK7hBRLeHCsLgqgT5IWqjvplwwnGyVpRDHWof428pZ9RkmSZHAeITPHgk+phfZPcqtkMyVG/p0/jj7HnxIXLkNFjfmC3lxU9WSqQX+IvJjAj4+YkwfAsFLWybtfja0O7e6cYxRXdxNf36I9KAnU3VOfiUIYp+T6CvVXZMeqWl7syFY+wGc73kA==
Received: from SA1P222CA0104.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::14)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sun, 4 Jun
 2023 01:36:57 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::92) by SA1P222CA0104.outlook.office365.com
 (2603:10b6:806:3c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31 via Frontend
 Transport; Sun, 4 Jun 2023 01:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Sun, 4 Jun 2023 01:36:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 3 Jun 2023
 18:36:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sat, 3 Jun 2023 18:36:43 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sat, 3 Jun 2023 18:36:43 -0700
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
Subject: [PATCH 0/1] selftests: error out if kernel header files are not yet built
Date:   Sat, 3 Jun 2023 18:36:36 -0700
Message-ID: <20230604013637.203330-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: e1866bd4-a5c4-44bf-f2af-08db649c2efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9GUBV2tW2jDkBtc9+/NRQ0YTp+rhXpgJQarArjN/BYHHV7cTzDS6hsO3cNqzid32tCbz3OGPiYEjJOBB9+fVulCS7+KT7Yp97FvwFMpaY9tkpgAla8jX7HJkYirZ7jJkmqthFUavM80ZFsB+TCGgiugqjV9u+T9Klxn8exUAB4k4mSdWL3CZL7QBESUMKn49lFGXs0HP87pJAv+wsjWq+Eg5qWV7MqjFTgfGTlYwgCslxgf2VIGQYRMQR904GoZYNLzywbZ8J3K177dCuhzYNl8A3qG/jcrJLTOa6aE+zBqzNrw2uLsx+CH14VcQSq22xzwPbJM13a8NTZHTH05UJ1AIM3r17qUSKgS1ujZGL/DtNTLsz1NCiRcDY8xqBFdjTE2Rn3QIXKt0m6Az14SBeQvR26MRQSdPJJ53giVChjXe4atzdQYIUwoQPuux3L0pdFFnrRZC0mfQ/o+FuLvECwyUa4t2afOHbb6amC21yl8nZ7aPAPj7ymkm56BPa5QT19qzhONkEYXpDgl7DWf0z/XCPaRBQPZfZezxfknXBHGypLijRnmcRmVnBL2c8VOWf4eDABL0ncdnGgwoTPcAcd6PiPaChunp00kxN/YdpezgsiZYdUQDHA82qO1ZiYM3n/JwBEuPpHkuPAgqCMJm0dscn926GC5w3jvuUiV+P+i+bHFeiAyOYIFFMR+u144JUFBbyEIddSjtugTBbkERDUcILIBtm285J2MYefQfu21AQ+NTpLrrCrx9zkI+aiwRXw41Pxu+nlFXhYno4Q8Bw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(7416002)(8936002)(5660300002)(8676002)(2906002)(316002)(41300700001)(4744005)(4326008)(70206006)(70586007)(6916009)(966005)(54906003)(6666004)(7696005)(426003)(26005)(1076003)(336012)(186003)(36756003)(2616005)(83380400001)(47076005)(36860700001)(7636003)(356005)(478600001)(40460700003)(82310400005)(82740400003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 01:36:56.7746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1866bd4-a5c4-44bf-f2af-08db649c2efb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This is somewhat related to the 11-patch series that I just posted [1],
but I hadn't originally planned to go this far with it. But since David
Hildenbrand asked if we could warn in this case [2], here it is.

It turns out that automatically doing the "make headers" correctly is
much harder than just warning, so I stopped at that point. It works well,
though.


[1] https://lore.kernel.org/all/20230603021558.95299-1-jhubbard@nvidia.com/

[2] https://lore.kernel.org/all/a4fbc191-9acb-5db8-a375-96c0c1ba3fcd@redhat.com/

thanks,
John Hubbard

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org

John Hubbard (1):
  selftests: error out if kernel header files are not yet built

 tools/testing/selftests/lib.mk | 36 +++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)


base-commit: e5282a7d8f6b604f2bb6a06457734b8cf1e2f8f2
-- 
2.40.1

