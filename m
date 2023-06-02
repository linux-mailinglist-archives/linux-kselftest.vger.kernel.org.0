Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B914971F7FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjFBBev (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjFBBen (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CAA132;
        Thu,  1 Jun 2023 18:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZdXS6Bxm7LxHhLxBKotR1fB9vf/hnxqV7YUAWH0kzVHNCHXJI1hlTQeMN+DNYGuZAIfbCoGREY4XiWFynaU94WpyjOmFxzP3RZNlrEKuPOSd1Z0QHhAOs2f+LyJkTFBIhdD3cnEJYTXMSCVHLWMdnuuglUDOnL2KX8aKwI3q89L/g7ZjeQc0Inhb1xHGpH4X1PdFWlwhBEZF9RIwnaetWfSYMgFBhcKlDITmTSFGU90q5lC3P9NREkho12UYGTeBm7b14xMtX0/0AF3r8EBq3qJM0fvpUC1ryQU/WN8OR6MbXsOf8Q0bxfyfPFSnhVPdgh/fmHQMuaa1TXAEziUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHHg0GeUqQ9D6ypa+gYCxOv4uIVN5myD0EE5yivIW5Y=;
 b=Jk2N4WUD28Qcd9Tl3S8/p7Q+MBdWGiE/8+K5vDhr/CsG+GMhxtsZ4Mxb6HiDol1l1HPqSRKwHDjFAnWYgEYaXqtKm1cHERf203EQfWm6MQKfEP65WDfigqi3EQ0zkvKuOz2o3Sag/JQa/HwbkbFEYaDAeDc68GCgE8/R5JmBypeLSwU+uO3UgXhy0+pmLxR//1AISr8w9kUEdmkJroJiCDNWYCM7QDwKMHxmGJPHfe134grlL/KH4HV15JmWFMaobJvWX3m/mkZGqI0QgkXnsmieJlY4pWUBREjhF2Ujg3PR9goCrjQrbjtwh2YSJL4q3aVNVFh4rRirtTqX0GBsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHHg0GeUqQ9D6ypa+gYCxOv4uIVN5myD0EE5yivIW5Y=;
 b=EA9duJZBZustQFBioeABrIah4pKPWXzqnl+1RBmuBwW3kL2HZOyyds4gVfvp2oApaR6Slep4LyKZYOH0xJX7ngHiMYMfiHRMmTpBuvfrMIMG5GzhghhllesuZwT56JqOMIg5QYF3ptF31NnwsoNcALkc3wQkPMH4X2U39SxZIZhxNMni2/+hm9FLqg1OlHY2XnGakzLCQ28AmEM7IvFtusqtU3hvUWMnESH081BNJQq8ziIW+lfNOP4taQN3z0oOiCdE12Qt1eXPjV9BbriT+D2Fbu57KJqsHnh4DoC0qW3MIUBtBBVjcRi4xVXT34cuEEo/jB/GpHsL7lOSyE/0DQ==
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Fri, 2 Jun
 2023 01:34:40 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::f1) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 01:34:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:23 -0700
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
Subject: [PATCH 07/12] selftests/mm: set -Wno-format-security to avoid uffd build warnings
Date:   Thu, 1 Jun 2023 18:33:53 -0700
Message-ID: <20230602013358.900637-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: d0daccb8-1f97-4620-2a75-08db63098865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jgp4J2ItNaBKBZAB0bFP1EdveiZqOCxTamGMlUkrlMAbqxeXyuptjWOyebofMXJZtVSAEbJjeMorLo8L0oL3ueYRkpb6tGaFx49wCNBpFlOcZL0ooQb7afRyuI2azFuhfg+6XxsPCB57W/HqkZfcL3fvhFE2ieNOC/D3sBRK0VqbORcR652bb2QUtbovEeXlqNn7xFzx3khDoxMj94ajtDplqGw791YRSovDRnuWM/Ib9r7Q3cFgXRI+VqK0tlrba/PmCTIOAN7XdeNteo1n62YcAKBOFp0NJNYTu7bOGSywP0/ZGG0x3KUc91Zg0mELZWCVdvBov4t2MiV86GgpTPo5yrplNecwHlS58X0IpVMtuHoVFrm6jnB/d6b0o8ft01mg0iGxfemCM0+q8wFeewHkv5p+ggQ01pNeXUxWvB2MOCzXOzL/Z0qy+lrZIouwA8I3UMie+ytDFaKlvEPIXWsJqM2uREHlncronweuA80aDb545mjMrvw1bVaZ4fHepw7su1KvBLJTVZOfAB98ihLiT45V2gApPAGR5wxaY3PIyYxXngZvVWGI8dMZ2S0T4R5kCZ1P/6SncvC60Jsk3dLMRMs/lwnOyTOpjEY7aOj0ZOYyHfx6zb0rsXJS0slvcgBSLnNjX3BH0xKTN/BPndKWlQH9taXHVVjWfs+9Q4eFsJPTkOCd3qyoq1m5r4cToW41BPrjOGnPlJI3ow47YL6PVS9esQYOXVCte1cVwj0hVg1+edwJzPiHhJ3WyV44
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(426003)(40460700003)(336012)(5660300002)(26005)(7636003)(15650500001)(82740400003)(83380400001)(2616005)(8676002)(1076003)(186003)(2906002)(36860700001)(40480700001)(47076005)(6916009)(107886003)(356005)(54906003)(41300700001)(7696005)(4326008)(316002)(70586007)(82310400005)(70206006)(36756003)(8936002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:39.5837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0daccb8-1f97-4620-2a75-08db63098865
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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

The uffd_test_start() is perhaps a little too elaborate about how it
dispatches tests, leading to a clang warning that looks roughly like
this:

"uffd-unit-tests.c:1198:20: warning: format string is not a string literal
(potentially insecure) [-Wformat-security] ...note: treat the string as
an argument to avoid this.
    uffd_test_start(test_name);
"

However, it doesn't seem worth it to rewrite the way uffd_test_start()
works, given that these tests are already deeply unsafe to begin with.

Fix this by just disabling the compiler warning, but only for
uffd-unit-tests.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 23af4633f0f4..473bf1811552 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -170,6 +170,8 @@ $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
 
 $(OUTPUT)/migration: LDLIBS += -lnuma
 
+$(OUTPUT)/uffd-unit-tests: CFLAGS += -Wno-format-security
+
 local_config.mk local_config.h: check_config.sh
 	/bin/sh ./check_config.sh $(CC)
 
-- 
2.40.1

