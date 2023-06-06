Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1B7238BB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbjFFHRh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjFFHRa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C448FF7;
        Tue,  6 Jun 2023 00:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJooluIYCXO7Bo4oxRmnm+GE/+bdE/UI1gt/CmdnnvMrBX0JsqYKBWYF60hKDg9SUBYK1RDw3lfUzoxa6DT6Nxx4B4WMBV7+9Yv5pGCRbNts4Komh8dkw5gl2veFrVBneR1HYX3Y6dwGDOdK85VdIxWW0YbdO68+lmHjZ1uatf/6YTW5WludfTyA/N3FYuKjhtPFHXwG8raXVVraynSGOkRlHDUUsEeRSYgCJDDe1eKptB8jWYEix64DLfBsRBQLZYathBmFr0nWDtrARJO9ldOSGUN7LXbu30E5lCtztrdKR42rWpgrEzCldIBGMbNtIl4WSk6LbRwjRDx2nesqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fine+ULcirLmEqNWkiHf+fbRUQNrgpAQqF8Q8I9Jv8=;
 b=EEnTF4VoOkwRqJnksL6DXhjUeRtUi46wf/CqhXZ57IwCWPqgoqKovyJzzKgmXazjL/YUbp6J5qp56AAulDq7dN9G5lwP66asBPjdFsYzvImNbA8cHqSv0aOEdlW+zJgaNtC76vAiKGFLi7izQ8UMHdzu6GkyonSZ+ytbE15ULPTEREFbDbG3pIzvTxRnSTtxGuiOODqk36HnZBAPXzzYtIb4IShg74hCzMvRo5QlObK8MuyeqkMP9GzBH3BQfpo+UHz8GbuMXAoUGOiYDsYTDRl+xYbu2FLUcp5ZcPYUkZiC+a1gobpeL8yoZd8T+DlJBHuPvt0k2rl7Rb7DqfFHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fine+ULcirLmEqNWkiHf+fbRUQNrgpAQqF8Q8I9Jv8=;
 b=btuvmAMYyzE27ABu7VBwlvAcjEci5vRX18QHREurNcFKmdPNUJtoqvLPH7Qr0qriZG8Bd0KJRYZd5wsIC5oUNI+ahY9cgMOvxHaQK0RgkczQFMgMJuqZF0AjFU2M/9fvRYG2YfJci/3oiE5TwVy72u9VKEbFYkiwfRlK6IMBsfgsEhcgbg61sTSpECqlwvzd/raMzw0GenEVcO8pyCGX6exsbzuvSZTcrwAps3Frxy58hYJZG2R4TZQ7sUCSUJW1rZ7vcFfak4fAawhAq34SndraL1KBO03Lh7sOTEFpOu/LxGogBpHakT96hSxYE+RIbswVG1c7/wPA7HKW/cOM0g==
Received: from DS7PR03CA0284.namprd03.prod.outlook.com (2603:10b6:5:3ad::19)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:17:26 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::da) by DS7PR03CA0284.outlook.office365.com
 (2603:10b6:5:3ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 07:17:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:12 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:12 -0700
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
Subject: [PATCH v3 11/11] selftests: error out if kernel header files are not yet built
Date:   Tue, 6 Jun 2023 00:16:37 -0700
Message-ID: <20230606071637.267103-12-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee2a593-f893-404f-6ef1-08db665e14a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6JyrV7UKBSncKCDQBDtupx10E0cen55WxHrGHi1nSH0HXH1Sg17VGW7XRQvJhO49sgPrX5cgXy3yK/rtw90NG9gScesFqMLSV1t4Cjl/SfLJhFRtrs1AJjuDXtqQXLNXEEBWwbus2XCzOSpVQ62eFjccCm8mJl4VG8ddsPoebDb3kWvrFtC7e6540rEvNshxVUBkGXC4KiombXlO2QkvftKNtuFsxzcqNKSbsU6Q8Y+xIHEzBCKDFCD9WL0kUvFjX8x7QK85ZpyCAOl6gvmIoYcWhgCwO9bzoEbvPjGHW8PjPsgffdEKguA0iX1A7cW61ANo0vWhguxJ5ibwGilo1oM6OE82Kjmh/buiiizjjj6idBDD+Nt7bpJ3DuCIRci14K+WQ5krZEm3votMvzu0eKGCQ/G2jPeaqX+goSWz7UV6TpCTwbFDLONi+rIt93g2brxk2KyrYfQrYsx6WM7jqvEb9DdYSLzZVMVcSEive/SQxdGHIGgl4RYgFGyrOlWhrBcOzVKaRQVWo7SlFB0DowwPyk/23tygD/S1rq7/cVLPIlmTaLwxmAIveQXPj8yCSyvUSh6kB386wP03hQGT9Zd2/wcD8ls6bSgRotOPYzv3gov/NjtdbvSYaMedLkkIdCBGDHOtD5n2HCsA6ckYbhaUJkmBegdu+D3L+O/DWPQjwv2CQ2nO7ou0htHizgMPnCP5eLJzGDKk6umHgthTJ/8jgvz7SLXi2u4GQ0nBNmWu3WCYVqh72G+HO/CSNgvcBmMlKBSPUyxZFUagD2aLg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(966005)(336012)(426003)(40480700001)(54906003)(82740400003)(4326008)(478600001)(8676002)(8936002)(70586007)(70206006)(356005)(7636003)(316002)(40460700003)(5660300002)(41300700001)(6916009)(86362001)(6666004)(36756003)(7696005)(2906002)(82310400005)(36860700001)(7416002)(186003)(26005)(1076003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:26.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee2a593-f893-404f-6ef1-08db665e14a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
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

As per a discussion with Muhammad Usama Anjum [1], the following is how
one is supposed to build selftests:

    make headers && make -C tools/testing/selftests/mm

Change the selftest build system's lib.mk to fail out with a helpful
message if that prerequisite "make headers" has not been done yet.

[1] https://lore.kernel.org/all/bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com/

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/lib.mk | 36 +++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 05400462c779..b8ea03b9a015 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -44,10 +44,22 @@ endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 top_srcdir = $(selfdir)/../../..
 
-ifeq ($(KHDR_INCLUDES),)
-KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
+ifneq ($(KBUILD_OUTPUT),)
+  # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
+  # expand a shell special character '~'. We use a somewhat tedious way here.
+  abs_objtree := $(shell cd $(top_srcdir) && mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
+  $(if $(abs_objtree),, \
+    $(error failed to create output directory "$(KBUILD_OUTPUT)"))
+  # $(realpath ...) resolves symlinks
+  abs_objtree := $(realpath $(abs_objtree))
+  KHDR_DIR := ${abs_objtree}/usr/include
+else
+  abs_srctree := $(shell cd $(top_srcdir) && pwd)
+  KHDR_DIR := ${abs_srctree}/usr/include
 endif
 
+KHDR_INCLUDES := -isystem $(KHDR_DIR)
+
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
 # custom build rule and prevent common build rule use.
@@ -58,7 +70,25 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
+all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
+     $(TEST_GEN_FILES)
+
+kernel_header_files:
+	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
+	if [ $$? -ne 0 ]; then                                                 \
+            RED='\033[1;31m';                                                  \
+            NOCOLOR='\033[0m';                                                 \
+            echo;                                                              \
+            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
+            echo "Please run this and try again:";                             \
+            echo;                                                              \
+            echo "    cd $(top_srcdir)";                                       \
+            echo "    make headers";                                           \
+            echo;                                                              \
+	    exit 1; \
+	fi
+
+.PHONY: kernel_header_files
 
 define RUN_TESTS
 	BASE_DIR="$(selfdir)";			\
-- 
2.40.1

