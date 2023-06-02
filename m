Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588B671F7F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjFBBel (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjFBBej (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DC1132;
        Thu,  1 Jun 2023 18:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSTii0ErIrgD5X+6Pd7iDfiKFJJjN1RpjbIQMoOzlKyhjwt4hsXPEWZoODMe2JkXAB5u8LAOuz1MhfUkORoO1aKb6pgD7PWuC1I9Gm3WxQnyS/osdLBBjBIVNelzxgVlZ/FixJfzE8sUVQWwSf9xu7WrzXU/7a19SCTbQOEtIuvgip+T/UjxvfNazPvkX7fZ+4P2YYHIgat8uz1SJDUTd+l+aMltMc+jYmJiCBaVcOkO731XdblMH743U3UZet04La1zm2vz4H3cA8J0k3U1Yx79Gu3gGEYfQyvCGq6Zo5e7JIwxGZeT2hdZS7Z7vPxBvmuw8DDxmiFK1+iOfxNGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5fkJHsQy/I9xsX+eBYUykMRunKRT8/bp1kU0wSayko=;
 b=KZBu7J5xDnYrm4w3II1jl36iniAlJx2d8DYbE+g82pbKGHbyHhYz6jAGSw+gpypPeN80cnNO4CfAWqye9NJf0YK9ppUJH9uU+X1HaA3tV0uYnzL8NaTrGtV5q2N2l24tH9jVbEYFB2b0WW9zzMAA8LzbynxR30KRAJjFw/Ux++jNr9Cjrlap9XJMEteam7Q8/Xw5WQHCQnLnmftKUNBgYwWoqWqoDK8C5/GRDTKPjvzblDgq3KP4FkSz/9LvYih/dJwC71RzDZGXOyiV75D87lh69siw+nbc+xj0IxQjTs3K58IyR9+RQ3aYt0BlkO8qQ8uhhGW9rtsVQ5C2dAuohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5fkJHsQy/I9xsX+eBYUykMRunKRT8/bp1kU0wSayko=;
 b=pUIPDvP6NgpZE3Ol8QT5JqGrOsKURev3KCRAgLuJv11oNMTkSvx1/eyFvEWyIuEMuIX/Z1aI49n5UhkI9XnGxkW8AT+F2OyVDyxY2qH51tMDF9JJf4iVZAMS4Q6R4kFcv9iQukP7Bkjb/azqabe/HOX7f1ADFIgq8ibjzOS6eUaBQHga70VKTJe+eAFmGM+pzttKagDHFH9SwfGIpO0jOIKQThy0QPzHNlG4LfUKy55BlY1EYdnNU7NQWJiFq5AJj3S0TOopskJNIuHqGqYiIa1t+Skl+5VeIvWz5CghlbM0panSQZs3xp7ms5bFraAdO19vEWz5yeu1g2u60Ev87Q==
Received: from DM5PR07CA0118.namprd07.prod.outlook.com (2603:10b6:4:ae::47) by
 DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Fri, 2 Jun 2023 01:34:34 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::99) by DM5PR07CA0118.outlook.office365.com
 (2603:10b6:4:ae::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.25 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Fri, 2 Jun 2023 01:34:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:22 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:22 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 06/12] selftests/mm: .gitignore: add mkdirty, va_high_addr_switch
Date:   Thu, 1 Jun 2023 18:33:52 -0700
Message-ID: <20230602013358.900637-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DM4PR12MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 417d5e84-43c4-4616-79db-08db63098548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rDcCRhqduIO1O+ALiGNNs9Z11lisuFjmqHOdFkMHrOgKD4i/6DQ1T0/YtJH6RlrkudcxS+N6SvAVbm3YQQRPb3BPLDSlQj4y81FRUJ97SZyj+uHm1O/gaXnX/e5Nj5upTenoJSiOAmHViF6kvFIjHS8QEotE93jTooA2wb/bb0zFX9EsEASvl4F7mX3hbKIqtMTVSOq45HbBm1Nio0nmtcauGSDhPa9Eht579ZYoHrALbmle0qRMZn7F8q0JQ1TStqqFRmcy3l9HPmfutGLumtZBKtFpbZaj7RhCLM+3NIXpE4Npdwua///mblySVxNMaAZoFW9lSlmMGlE2fDBEttaNpCGcv+Ofk/sPK+mpJXY42NN4JynjfTPAC1fZ9Clj7maX6rNCAqTV34R6oJ7UV0K3CDDTGQKLru107Wd33QevPEFLfzer94v4CBfSURn3EWi27r2eqjtFEkSRJ07Cxa4FS/aGhOrMZXQZfG4AAS7tW6aCxHXsFwIo1qqee4lzeoasl76NsRWTSIAvCOLO9CWwLU7Z2b9LEpUstoOHzjKvPdS+vw5NePiaDwjtSm3UZbKAMghvh/f4kE/X48nbbNtEI7OCKssfUCAOmsQlUDfpeBoSSsaNzzDWBRWU+WeFMdrGIFeHX59zrM88HUFQ3fw3XHdRdsa2tXxLhF8tignOHSukWWMlSDlfn0Hpw4WaAMm8wm+w7kqzDUJRomUPA+VQJMD3mveeYx9U1fxmy+EjZk7h/VbNouNepatdcgf
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(356005)(82310400005)(7636003)(40460700003)(86362001)(478600001)(54906003)(70206006)(70586007)(6916009)(36756003)(40480700001)(4326008)(6666004)(26005)(186003)(1076003)(107886003)(2906002)(4744005)(316002)(8676002)(7696005)(8936002)(5660300002)(2616005)(36860700001)(47076005)(41300700001)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:34.3938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417d5e84-43c4-4616-79db-08db63098548
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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

