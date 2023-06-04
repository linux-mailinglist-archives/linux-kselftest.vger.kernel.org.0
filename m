Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32ED7213F6
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 03:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFDBhI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 21:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDBhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 21:37:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75811B1;
        Sat,  3 Jun 2023 18:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPACAR2yQJ4F6oa7rXn3+iBpMmN5QR+Z0uoVrN8xUjVkP8WM46l2zhitZGahNYq9fJk75koUw51CRgCZSom8oi9GxH2GS5uSNskFk7FGpl8BJ9v7aTIX25RIRzvHDtfUMWHQYADeptWKrXINNnFCDe4oEbDxR3XmzBzexGHnR4h/bY5YeDBkVwDQXZqu+NwkH+ZZsck6M5b4GXjiZNC4Z9DZUcIzYa8vyFmBavBMdXvKx+0bns9eZ1qzoOigvHtjOXeLQZ7DDwIHhpn18bMUaF/5W5LRJGSQDwhqJ5cINfSu+w+ijTaJZuSBGOVpy6tMW5XUkmd/f60I+/QMee/JlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fine+ULcirLmEqNWkiHf+fbRUQNrgpAQqF8Q8I9Jv8=;
 b=MdzxRR3TZKcLeiUaWCfxSwlYFXYJcpfoRDZ9p6YAuJpetYlXOUkwkJ+/R3ykmKe/lZf9mhmZpsKmXxjThBy9ZY4FLSL7/4mYmD4/AXkLaGDcHM2ZBntHSR7z9/6KfYdqaVDXyqIUV83zV2mhKMKQo/YOpUhpn2q/Q9XlBiWHPRs35DO7lotfJMtlaOGHVFypTT83AJTMH5f1mmO/4CpjI9DuEkzQGKoj5IknP9HpaNuKFoAd0kQJ6H6wdoMO5xjXkw3mpoQjST7Qdc6KUf0y0qnwAiQjfryn66Ij7y0zwBGgS8D3/2NE+9DvR0F+McfLcakHLunmlWz8mw4HzeBK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fine+ULcirLmEqNWkiHf+fbRUQNrgpAQqF8Q8I9Jv8=;
 b=OrI2m++9//JoC4ACk196ao5xHrEWWVeaOx2P0WZH4LjPEJyfWQl/MvogU5jaU4aBO6fenHTHyogoE8YHokrKy7MwpwLZ0McFrrYkYgLXDMVVxNmnIP2MenBKlXbZ1nZuOJXiSjHU+0XPcRu5hPtYri6sBV25obA+Gsz3x0Buo5uDrPqj/0hj9R8qeqzcFnadhHVxX18duclW+q1A1xUgM2viYmjCaMBhLOZOkB98x5YYEAevHE4yRzyhs58t1Fk6ikBbvwy7tJp91vYxWr2DXuEWAZByE6LOrajvG6am9+OMks1A8utYw8r/UAG98514F31kn9CtKIpceFhfadyw6g==
Received: from SA9P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::22)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sun, 4 Jun
 2023 01:36:58 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::a8) by SA9P221CA0017.outlook.office365.com
 (2603:10b6:806:25::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.30 via Frontend
 Transport; Sun, 4 Jun 2023 01:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Sun, 4 Jun 2023 01:36:57 +0000
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
Subject: [PATCH 1/1] selftests: error out if kernel header files are not yet built
Date:   Sat, 3 Jun 2023 18:36:37 -0700
Message-ID: <20230604013637.203330-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230604013637.203330-1-jhubbard@nvidia.com>
References: <20230604013637.203330-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f3a09b-c919-4a52-1891-08db649c2fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfSfAzMPoASKlerMip8fOPLFriCPAAIezR2vgk+T31bRmXTJHlmw/VbtrNDT3NFWSBfKP91+9tJG+pR9f80IOf/KC9EnLHJblGc9uQnwrSKt081eTg8YD1W0IP1+7wnv/8ia4OeWgnA0KcfQdvsAY2I1tlTrWQdpkYUr0mSmRL8AMC/7BEdybJ951do7xKbMyK0yAc3SirFZ1RPUOpi0unxJL4fvK52/qL8ihEgtLOlAmFx0fq3otxyY1Z/W0DGHs2NO3WZ/nzJkS4x6CWFPtbmIRvrs7p+q8hq2anWWEH4xq2eMZLCOz3zZ34W28wGxRbujIyC/wuj1o3vwaRf6lEEZk0Xn22OyBvmcVHMNzndKkTOAgLXyex7FpwDu1a0f0q1eyhB+f7sMT32La+doh3qivG1ap2UElcsdss6V2O4ciRDQ+s+axnd+aacQrkB5arQPjOXZFlwXX4XnYbgJWAVmRBsyWqtix4xqeZPMxENcAHtulGiVMDOX1B8Nd3FfqzF+FfFNVezkUShq9VYKYy8KXfqv6LlVKmTo7/+oZnmxgm3HY/H/f/Bg1rJCV0E+KfURPac5s7MNhid1PMt4NL5dcu8JmNKVhtzFnVPkM4dzQmq9ie/gAFqGNaE2QoAIBcyvY1sBMWIFBbfSjCUG/nWdb3AAsYOo0XMUAe61q/ex+txr2nPWMnDGkVSrCHHS8/3O0+2xyco8dWXgPq7iE9TkTXoTj1H6d5xzHFO2vph4epJxZWzi0rgERSg9jRecSt6mdC+x7sdDcLdC1iyjOQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(7416002)(5660300002)(8676002)(8936002)(316002)(4326008)(41300700001)(2906002)(70206006)(70586007)(6916009)(966005)(54906003)(7696005)(6666004)(426003)(1076003)(26005)(336012)(186003)(36756003)(2616005)(83380400001)(47076005)(36860700001)(40460700003)(7636003)(356005)(478600001)(82310400005)(82740400003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 01:36:57.8831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f3a09b-c919-4a52-1891-08db649c2fa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

