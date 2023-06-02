Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A3471F7FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjFBBeu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjFBBem (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0AF2;
        Thu,  1 Jun 2023 18:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHG1pH++37QPNtBoApFjEBI8BwePdDx/OsXVxISNvVIE9LAJv+GF5ax78FULk2WcFb4O/ruxV2IPQ5Ua2eIDAXYEaHN1q8NPwYRnwySFaxXSp+6PieC3p37a+7zAg/rxve5ZJYDF+bTMzTaJxwe3f8VowV2OJcocveL5Dvn1HnOaJNfNO8lIlAWEqHQxvEFP0yNo5C8bFGEK/10ZQdFsEbQIXySSqo94cJBvjj0bWAIs4JuJyQpYppCN+Is6V8X4kcVukVtJ/3SBxMKr6NYBIYVhxr3HvjojFdsZ79kE7iD+aXxFvC5qFHkeMccbYPbP1hJ6Q/54cThOgkTnHPTO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfjU4ULTGJNdH3DsNoYwiGJtwv8DiHV2FeugHiw+gqU=;
 b=DSBMpue8LXQHxkkeoTcN4SHphDguCcUeH3cPKfpxxJP7RCE4GL1lRM5F7R6PEboWMBSdOVf4B+i7+gPMx/dVFsO4/PGc4fWZcZ2KsuYFGL7wQoz4HLA3Yw0TRRILL5dyMbqV4yeUzYjFLXTJVl/v8TY7ziEMOtEJqKd2e9sFIXhYukLwb+mnxsTxH2taQ9Xs8f9GTi8+KL6FNplBEeJu7YdF1WegAOQiDIskBiBydoaN+zUXb8F0cf3IDW0I/uQvSFE8sbd0d386hh/PXNFNJKfAg3HjA1p8xJWyeMLIv5vOpc/CN1sCHQduRH7Db/H8zLQomiLE38mktwm3nzj+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfjU4ULTGJNdH3DsNoYwiGJtwv8DiHV2FeugHiw+gqU=;
 b=UmrA7dWmkhwpwjYSfEhR3Jz6aeAcamT2kSBjCMdvEO8/jJV/EP6Sw1t2cEc77lX8EOL/frdoVE48EFfqZejgdCcSzOsxqUnVfEJL75onwfvH/fcSXcu9mh7W8RjhER22zXDAAnT0D1LoT5m6/7ywLJOQH1FCNBFLdBG/jnwUg9Fixb96oLM7aW2gmftVSMSAqrYjoBO7c/1KVpBTcYmQg2daG2X25o3HFTcibIN9HJQy1fhp7nz8aeO4EvsVFbVhkQGzVtMaEiFg/JJkQf4WUw4TvHSjRGGrR2EsCvU0ZjkWYsE2rNS+Gq8BeZroupRpyjYkyrbeeDlJ8hXkQsgYdA==
Received: from MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27) by
 IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 01:34:37 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::93) by MW2PR16CA0014.outlook.office365.com
 (2603:10b6:907::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 01:34:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:21 -0700
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
Subject: [PATCH 03/12] selftests/mm: fix unused variable warning in migration.c
Date:   Thu, 1 Jun 2023 18:33:49 -0700
Message-ID: <20230602013358.900637-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 16567e9b-afb6-493a-475d-08db63098707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dP5bJFBM1q8WREPFPiCeaDSHDQcpAMG5mM4MDjEqwyOPypWs1VdoIM5FVx0hYcHmYp8IyZJNxX3ms2OOUmrDm+8g2HgqKVAbiHpMEoSeGK2or55vMKcCLmVKmMrjr5in1fZGBM9YxrkXJRgDnqLzSTnl36c+Yu7SbFKHojzDKwdLuTWQkIoJCEt5l8ypk9U6nimYSp3dAGc/UnJuQfGpUXdT27r3sQxwIhXkNsKLNHRZ4kJOWhF5a0bxx3wQ7/bhUeykCtrPdmJ+ssnyYyfq7hrLTPpzeP1YEtzwJg/AUyN8U2V0WcpsDF7r3qVC54U2/C86DJEViNr7bqScj5BVWBdQWsCCNxJ4sIrbn5LjuXmi+/l9HQAsUfdxlWEPJY2XfBQ5Bqv9HVOwJS+9I798zb72Ty6XBZD2tS93P2ykTdGBpsvnRxtxBkOyzNxbUoJg8nEhRzLEBrF6hiJlggszR/cOTKfgPnF5FZhSXJPdLexP6U3AxcpgCFpeQ+87OWYgaW5+PNT7qkCJMmS8XJpLX8Isbq4DA0oPbEGS+TFuwcW2+E0LbikOQs2JRyVvebmywLFuqIUnlGf6ItdSfsGdHCE01syLzbWDmBcOGEOnNze17/2Ovj5meIpt+A3+evFnfaSKWE9p6rwj/nCj+OGydf11Oj4gAFjlKyKpSKTsOHq/L48jtiRK7C7RurTBXwrmmW9TE9PcG1Iabicmy/2uHeSjr7D90oVIT6fHXUh0JMRnWleozX+2KSl8uelp4m+
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(7636003)(356005)(36860700001)(47076005)(2616005)(54906003)(83380400001)(70586007)(478600001)(82310400005)(336012)(70206006)(6916009)(4326008)(86362001)(426003)(1076003)(2906002)(6666004)(186003)(7696005)(316002)(82740400003)(26005)(36756003)(41300700001)(107886003)(5660300002)(4744005)(8936002)(40460700003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:37.2751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16567e9b-afb6-493a-475d-08db63098707
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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

Declare the variable as volatile, in order to avoid the clang compiler
warning.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 1cec8425e3ca..2dede662ff43 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -95,7 +95,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
 
 void *access_mem(void *ptr)
 {
-	uint64_t y = 0;
+	volatile uint64_t y = 0;
 	volatile uint64_t *x = ptr;
 
 	while (1) {
-- 
2.40.1

