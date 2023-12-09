Return-Path: <linux-kselftest+bounces-1469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D72880B1A1
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 03:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB19F281937
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68927F8;
	Sat,  9 Dec 2023 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NB40n4Dr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA4EB;
	Fri,  8 Dec 2023 18:02:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3FIz9CPDnmdjyejnX6O9BJbp/mrLU+D53NsdtvFwK72EN97yJLbD0+oTSLyRwmyJSi5hmhAjwsMHF17uQGUBDykaKRoik/VRgxn9mKfKTkP2nN+RFc6fbCMraTMx7zWFVN2nSYTlF65Naq1QnC8n+JN75mXzTmJbVhhCwJoF9QcM1J0oWLdtWjI25f6VJMc7gblokkNNMenH0Ia2gUzrY8MRfYunao1lNSys4I4Tue2blr3r2DBdTgGKSKjmiYykW1f+/uWdHqpYHzpSO0pLgma8kjIyxR3IiHVjj7IaXTez1BTZlFbYYJK6MoMrs4IMXBGYbmIS0TVsqY1lQr8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmWOXvwg710M+qzCCZLI1CG62sHXiD8UxWuuyqUgLng=;
 b=M7bSbHbLxRvAyxjAq/NoHzDxaplV2u2ywzXGx3bspwKkjCdV4+rf6/PidmiVd6YRjt/zo367xnhyUS5+GfdWNevs5cGfYONtPoFymBBX+cJ6lewL9yQ+SKW8oFtKjzrEqk2tXIcHkTtrFPH8c8UO4dL+kkeltAid11YjrQqXrxAVRL24/opvQGuaVbIDcDQ23FTfsYoxpkEgs6+cvRXN6v93ulOVDH7ni4jQjh52sSAO40QXtn+9w0+s7/HP5rjDUNr5j65dPMMMY2KKDgCGlII7JAY+LwN1QnKcPWouyTwKHSMn839jQnEKxXL4Bdr2StRm63BJGUs0JErfBDJcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmWOXvwg710M+qzCCZLI1CG62sHXiD8UxWuuyqUgLng=;
 b=NB40n4DrfG1HVQG5eRvX8j5kvghpQwqL3ij1ZL2Kf5PIpBEG56xw2tnwyW5ETY8nNKwHtfVUMEiWfZJZEYDjH56UrRYEYPEEb5SG52B43vvHQTQSc7f/ZEZkPj8XWQO6IQw/uHhXsgRrT8pqw/e4k+DJTC3H69UaHLo1WOQTr0Z8fiO7sGUTvc5akbtDstztqfK/736LX+ALlrTq46wJKaj+uQF+fBXTECaOtoVFoBMP1pCFNr/F1rmCcz3hraUJrGarM9tuSN7dH2Ex3R3RX6LUYbkg1asbSu2IDS9i10i9g6FB7HA2nqQ6fJuERPnF91pDgL/xYc8uUeIbwWMnoA==
Received: from CH0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:610:b3::21)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 02:02:13 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:610:b3:cafe::5c) by CH0PR03CA0046.outlook.office365.com
 (2603:10b6:610:b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28 via Frontend
 Transport; Sat, 9 Dec 2023 02:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.26 via Frontend Transport; Sat, 9 Dec 2023 02:02:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Dec 2023
 18:01:56 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Dec 2023
 18:01:56 -0800
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 8 Dec 2023 18:01:55 -0800
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, "Shuah
 Khan" <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Anders
 Roxell" <anders.roxell@linaro.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Revert "selftests: error out if kernel header files are not yet built"
Date: Fri, 8 Dec 2023 18:01:44 -0800
Message-ID: <20231209020144.244759-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 3153e015-60af-488d-bb08-08dbf85adb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UDC5APBvc/aC0gKGNv6BtrrX6Qpawyh4HBBcrUn2i9eeezXphGmIztP3W8THKw5MlfP0CoI/+yxTSsp2Zhl6dgpNYzfXKni9yR+YUzPRnDk5Jp/nXmDh5rMRjbzLRPcjx5R3BhlS8UAoiWkS78qx0lMH20VX/O7Ba4oB8nbJuL0WP5tAZ9ytHvTV/y6fX0z6YIgwlfhl5YtzwRqU61QE2Nw9Dcx/E55ghuY1mCQF6ya+bKcPleABRSqCzl37e9014BJ1YhDQYERDDlW4ckJlFiB05jd60FmWqNgMAsqYWjKbiFyjQjkRXfes6vqqjd0dHKpOKfO/hGRibjnw443j3kQaddmh9S83sYpXtkQ4+Axm9+m73rQj9sOwFpiOITxGKJ/iYWuAP1Qa6rSq88tCgJYlpDK9cd0VQSL+h4B1KzkLfGM3TR5kpAm3t2qwD34Jnk0Ezux0kEwG5imy2UEhHVbKtc3hGmojGzprixkh3WV8H9lX4brdzVeOOYl6iJS+udEGnwblywPbKzcu3a52EhQX82gM1RFKGDaAWSmyc81LZ12FtXmy4IcRxYfYVIvIVjQRDBz1jNN9FjdzV7JqOs1WjLHFxLRMYdUUPzKcVeAoKxx5WqHA6KjSATRkJX3do4yjPxw/t34eMA337DUWovKHK0x/jAOnhngs3UCrmU44qJK5e6hDf2KO5oEcthYfEf44nCsota4LTXfZymybCvVzvOIUgiA4NOODZf4Gtu61PptBoMvtFzLCsoLP6Fu//WbX7LuugIuy0JVCSj63BQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(70586007)(70206006)(54906003)(41300700001)(7696005)(6666004)(2616005)(1076003)(36756003)(426003)(336012)(26005)(86362001)(82740400003)(356005)(7636003)(47076005)(83380400001)(36860700001)(966005)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(40480700001)(40460700003)(6916009)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 02:02:11.0505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3153e015-60af-488d-bb08-08dbf85adb36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475

This reverts commit 9fc96c7c19df ("selftests: error out if kernel header
files are not yet built").

It turns out that requiring the kernel headers to be built as a
prerequisite to building selftests, does not work in many cases. For
example, Peter Zijlstra writes:

"My biggest beef with the whole thing is that I simply do not want to use
'make headers', it doesn't work for me.

I have a ton of output directories and I don't care to build tools into
the output dirs, in fact some of them flat out refuse to work that way
(bpf comes to mind)." [1]

Therefore, stop erroring out on the selftests build. Additional patches
will be required in order to change over to not requiring the kernel
headers.

[1] https://lore.kernel.org/20231208221007.GO28727@noisy.programming.kicks-ass.net

Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/Makefile | 21 +----------------
 tools/testing/selftests/lib.mk   | 40 +++-----------------------------
 2 files changed, 4 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..8247a7c69c36 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -155,12 +155,10 @@ ifneq ($(KBUILD_OUTPUT),)
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
   KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
-  KHDR_DIR := ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
   KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
-  KHDR_DIR := ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
@@ -174,7 +172,7 @@ export KHDR_INCLUDES
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
 
-all: kernel_header_files
+all:
 	@ret=1;							\
 	for TARGET in $(TARGETS); do				\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
@@ -185,23 +183,6 @@ all: kernel_header_files
 		ret=$$((ret * $$?));				\
 	done; exit $$ret;
 
-kernel_header_files:
-	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                          \
-	if [ $$? -ne 0 ]; then                                                     \
-            RED='\033[1;31m';                                                  \
-            NOCOLOR='\033[0m';                                                 \
-            echo;                                                              \
-            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
-            echo "Please run this and try again:";                             \
-            echo;                                                              \
-            echo "    cd $(top_srcdir)";                                       \
-            echo "    make headers";                                           \
-            echo;                                                              \
-	    exit 1;                                                                \
-	fi
-
-.PHONY: kernel_header_files
-
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 118e0964bda9..aa646e0661f3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -44,26 +44,10 @@ endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 top_srcdir = $(selfdir)/../../..
 
-ifeq ("$(origin O)", "command line")
-  KBUILD_OUTPUT := $(O)
+ifeq ($(KHDR_INCLUDES),)
+KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
 endif
 
-ifneq ($(KBUILD_OUTPUT),)
-  # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
-  # expand a shell special character '~'. We use a somewhat tedious way here.
-  abs_objtree := $(shell cd $(top_srcdir) && mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
-  $(if $(abs_objtree),, \
-    $(error failed to create output directory "$(KBUILD_OUTPUT)"))
-  # $(realpath ...) resolves symlinks
-  abs_objtree := $(realpath $(abs_objtree))
-  KHDR_DIR := ${abs_objtree}/usr/include
-else
-  abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_DIR := ${abs_srctree}/usr/include
-endif
-
-KHDR_INCLUDES := -isystem $(KHDR_DIR)
-
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
 # custom build rule and prevent common build rule use.
@@ -74,25 +58,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
-     $(TEST_GEN_FILES)
-
-kernel_header_files:
-	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
-	if [ $$? -ne 0 ]; then                                                 \
-            RED='\033[1;31m';                                                  \
-            NOCOLOR='\033[0m';                                                 \
-            echo;                                                              \
-            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
-            echo "Please run this and try again:";                             \
-            echo;                                                              \
-            echo "    cd $(top_srcdir)";                                       \
-            echo "    make headers";                                           \
-            echo;                                                              \
-	    exit 1; \
-	fi
-
-.PHONY: kernel_header_files
+all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 define RUN_TESTS
 	BASE_DIR="$(selfdir)";			\
-- 
2.43.0


