Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D25F38E70D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 May 2021 15:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhEXNEz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 May 2021 09:04:55 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:14689
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232409AbhEXNEw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 May 2021 09:04:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7U0CtzHj9vY/4htR/XgvcGNqeZMrLVh2ZB9Ql1gviqC1M++tlqOeiJFh5KMeZn5J6zMulerZvCeiiiY2np6IdWVGqhy8JIFYVLL5p95osFsQ9K8c5jf01NoIyszlG+kH1/hPr1qbte9UwER/h+g3yOUjTB0ozZhMnzEUXcTVkHLgV442udX+xVv3wlIKhlMhAsu4fv3lT+uTLWQOq7qMCjpqlg6RFl4l+mhvj1tz51ypybmuNxEdPNhJo8L9mNOdALT7m1ITavr4llVxMfrAY7C6nc/3PxKRvzmrKLvZDjkhsTbmxxU3GAqC8/1M4EdqJlm7rkNXi5vNNjQXRa5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u12rhws254qlQ93/9sKbN2RA6hodp+05HkgRLsZWrZU=;
 b=RP+++lIEYi37xj4ETXn6vEqsZwWsLyxM6DOUfbadKBMknclQDAkmZ2dkD51v7vavL7v+LfGsBR1SnQW/mSHALaOHW5pbvrkg1lGHtUuk0ip6es3kOwn1Jmg68NV6MdGKcbaoZVOCC2GM+EhcJPl2zz/lpyzCZzEG/5WDoQOclSaztJ7KXbmDRnAR7D2Dpuw/hkhXlbxeZ6iSOZXBxkosSEfAAq6mVWBO9A+jbucwLhTm5EVYY/ATXF296SpZ6H2Q7RJZN2Bwjz9Xu5x8V3FX+eGOiq4/gGEfdNkQmPuGbpX1k4byaSBsqzHKoW7g2Q87LBff6lroStCuR9JTP8bmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=us.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u12rhws254qlQ93/9sKbN2RA6hodp+05HkgRLsZWrZU=;
 b=DXckpAlmfKeSV7GiyP2Kmbk64/RecScLtf45CfJm0bzpEX/MfIfwYi/7AnX/jjgEDnfjHF5TJ0qweGCogDlCcfXKT/Ioc1FrL+p4/y6yowA1zVCjW5Ocotdo9+TS7KBIPkd2L/gQccacdfXjoFvLAe/SPop0y8NmzZrrx9gxcsQTxV9BqZXXMdhE9fFO4fgYq3Yl1lYEK2SVpQ2IXWaIDJmR9P7+OlMhqdUUQHo6nSUmpiqe8tRl2o0YIzEyJiB43ES3HVd48uAnu8F8H/NmmXfLp1V+WQ5W4FaXcOxM4SF8EYa64OlxrtsKBGjCj/WyR0UB0K8E55hsXb+PcxzEyA==
Received: from DM3PR12CA0117.namprd12.prod.outlook.com (2603:10b6:0:51::13) by
 BN6PR1201MB0099.namprd12.prod.outlook.com (2603:10b6:405:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Mon, 24 May
 2021 13:03:22 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::8a) by DM3PR12CA0117.outlook.office365.com
 (2603:10b6:0:51::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Mon, 24 May 2021 13:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; us.ibm.com; dkim=none (message not signed)
 header.d=none;us.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Mon, 24 May 2021 13:03:22 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 May
 2021 13:03:22 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shuah@kernel.org>, <akpm@linux-foundation.org>,
        <jhubbard@nvidia.com>, <sandipan@linux.ibm.com>,
        <linuxram@us.ibm.com>, <harish@linux.ibm.com>,
        <dave.hansen@intel.com>, <rcampbell@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 1/2] kselftest/vm: Rename TARGETS to BUILD_TARGETS
Date:   Mon, 24 May 2021 23:03:07 +1000
Message-ID: <20210524130308.16343-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65eac7f9-5419-4657-f1d2-08d91eb44f98
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0099:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1201MB009917FF01AB1B7EB2354B28DF269@BN6PR1201MB0099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uu07PxJAbGJoMUdaPgd3w2OzmbkFO3GD9JywYbD2zmDsV12uKZUYzAi/qAeKPvFupynF0mbWhi8PP2zR4mOXZpcZO5lNhda69MQLAy9bqDQwx0+pgKFqKsGIh7Ptb3e2xiCLECsAQl3yusscFoyIntipNB3AQQsRVnlPKBXU/YC47DS334MTiuMwBbaY3y6KU6gf5tv5HZoM+u5W0cy3y8h14Sxm6XfWF/ccIOzwJOEOB9HlWpbh8yuO08xIQxcGpO11gBYTNFgH1seS99q7U4V4DKq1clDBPZqbvqm+xg/2rK1aCtvPiGj7ImZqpOqD7JndV7EB+4c3zlqBW7a6TCKvHrAb/PaPaeJASsH1dfU8XpPwXF1gM/I8lRiutbMLTldNbahdEPk/kvtt83AOoFGlaXiL0RxJOVZHyDODZLzRgN87EHXxwZpRCtShnV2VOiSM8ob1leqJBkEn7pz9d2PLJYxDUBVWt/CiUSG1FI3AD/ZKwsRjwZm6mOYNBNw6oOSRxY+ohtN9F5LAO36m1SQE738NnYQaXmdzIpzV5R4UJY3/d3Tqzj3H0/TKmHJofOk8VUsxNfHc2nTkEwaVif3/R6lLWqeGidsW+6cSFelHZmyaMndWH9GtsKNttS8V2wOGdl9jpxOWki1qTgeP69iXehdlrTWc2EQRGpsLiqM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(86362001)(426003)(2616005)(2906002)(36860700001)(5660300002)(16526019)(70586007)(478600001)(8676002)(8936002)(186003)(1076003)(54906003)(83380400001)(356005)(336012)(7636003)(36906005)(70206006)(82740400003)(316002)(6916009)(107886003)(82310400003)(4326008)(36756003)(26005)(47076005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 13:03:22.6856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65eac7f9-5419-4657-f1d2-08d91eb44f98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0099
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The TARGETS variable can be used when building selftests to specify a
subset of selftests to build and run like so:

make -C tools/testing/selftests TARGETS=ptrace run_tests

However specifying TARGETS=vm results in the following build error as
the TARGETS variable is used internally in the Makefile:

make[1]: *** No rule to make target 'vm.c', needed by
'linux/kselftest/vm/vm_32'. Stop.

Fix this by renaming the vm Makefile TARGETS variable to BUILD_TARGETS.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 tools/testing/selftests/vm/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 73e1cc96d7c2..110751ce8701 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -49,9 +49,9 @@ CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_progra
 CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
 
-TARGETS := protection_keys
-BINARIES_32 := $(TARGETS:%=%_32)
-BINARIES_64 := $(TARGETS:%=%_64)
+BUILD_TARGETS := protection_keys
+BINARIES_32 := $(BUILD_TARGETS:%=%_32)
+BINARIES_64 := $(BUILD_TARGETS:%=%_64)
 
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS += -no-pie
@@ -104,7 +104,7 @@ $(BINARIES_32): CFLAGS += -m32
 $(BINARIES_32): LDLIBS += -lrt -ldl -lm
 $(BINARIES_32): $(OUTPUT)/%_32: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
-$(foreach t,$(TARGETS),$(eval $(call gen-target-rule-32,$(t))))
+$(foreach t,$(BUILD_TARGETS),$(eval $(call gen-target-rule-32,$(t))))
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
@@ -112,7 +112,7 @@ $(BINARIES_64): CFLAGS += -m64
 $(BINARIES_64): LDLIBS += -lrt -ldl
 $(BINARIES_64): $(OUTPUT)/%_64: %.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(notdir $^) $(LDLIBS) -o $@
-$(foreach t,$(TARGETS),$(eval $(call gen-target-rule-64,$(t))))
+$(foreach t,$(BUILD_TARGETS),$(eval $(call gen-target-rule-64,$(t))))
 endif
 
 # x86_64 users should be encouraged to install 32-bit libraries
-- 
2.20.1

