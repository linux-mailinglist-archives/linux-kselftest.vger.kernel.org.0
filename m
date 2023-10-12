Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129197C69B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjJLJeE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbjJLJeB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 05:34:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D61FBB;
        Thu, 12 Oct 2023 02:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU8Df/TKr64N8zgx3tJlZcvHTG7JbfjQ4vqgZDn0zpRQNyiyadRszELw3FGIVePCNmdj2h0AKkmz8KYfILRbOIzwSLNNXAFJOuEDVAwMU1POGcCmKHCRf/B6gfBdscJblinoffxgESjW79Dw1kzJYDD1ETf+EY8Ledz1oohNxgfPIQT0XgXJ5LcIZh4bmaLPSHpv99P6smoXH7PCxJZaYlsU/iXJmYsWRkdU5ACSPaETo8kvNDaUWUVXg/TSPxBOXS4Sf8SrhG1aMNBR0njumzoFqDInwVXGLqmOMMnuutkpG723/0EgPaLuRmKO7ShIM0uwi2i/u8wzxsABFJ18BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DkmCLF1FsefB8MpDrvyCzApwp1J0D/lSH0YKPH78w0=;
 b=hDBfcp+6CIZ8x3sMndsz4Pc2iVHNUwtuShJsjAsOwRCoB66Qghbl5Lt96aSaOe45F4KVKU/rC09KRXpGoTwZKNZMHTDDfoeXeMnapVYRAFiXIun+62NSRTGcFRICRk2+/dbxLFl96An2nkFke21Sv1dawgCfMwPuhMNefI50WkwWe8XmmzVOC4hYh11+jifFgOMCYrzUViFfDENFBvZ/QWtSPl/P4je4MPdnIaetTVDbYnkFrJQJ3V+0anC1/Lhr2I3VRXhD9CNBwawjeQOd/jI6MHyFLDreeEfdx68uxe4dOXtIdzdRcX8bj5sedtCkP4Ekk14ZO+rSp+dqmLPc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DkmCLF1FsefB8MpDrvyCzApwp1J0D/lSH0YKPH78w0=;
 b=mOIPpPt4vwy5pQ0hYsV3R5hu8zGschGCdwblA2oRh+2zOZ9MAujLI2fEMu/3LheR6vktsa5m6zCw1e17IOk9DGJeHHw48CCgq3QFTK1CKywhttyonQoz+D08p21MDpZIpixRpb8SMP8an6vPA7rtbJcwFyJljYniZOmN8nfiuUE=
Received: from SA0PR11CA0106.namprd11.prod.outlook.com (2603:10b6:806:d1::21)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 09:33:54 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:d1:cafe::22) by SA0PR11CA0106.outlook.office365.com
 (2603:10b6:806:d1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Thu, 12 Oct 2023 09:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 09:33:54 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 04:33:49 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <li.meng@amd.com>,
        <gautham.shenoy@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>, <Mario.Limonciello@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v4 1/2] selftests/amd-pstate: Fix broken paths to run workloads in amd-pstate-ut
Date:   Thu, 12 Oct 2023 09:32:24 +0000
Message-ID: <20231012093225.2045109-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012093225.2045109-1-swapnil.sapkal@amd.com>
References: <20231012093225.2045109-1-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0630078a-2d9b-46d5-257f-08dbcb065a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQYlLIWpzEx04bvj7RLWV9CkxpHhQLhkStxbNaqj2KWAGoWCtV7F8gzjGysov0JiAjWhS9mUuJtQbw/OWVHeciT3XQo2uqVNNR6fnXtCkssNHqSQWAOzk4bszhA2/y2ydFTevi5lD/gh66dALS6QH2S7HgBUMPW1cEnZGNcUnHHp+ft4YgtAfSbncB7gdS/bX1Vx8uXxSR1NFVUPLkjQ8gCbcl4LoT2/4pgQQADBxudJRPUJFGmRClgRC4fL3r4wWpmdL1YEhAoqxZdcFCwk+gdpPX6vecz9QQGkHj9vzaXG2teNz8ms8domZzl3KD63Yp2W188fWPr5AV3HUuL+QhRiw6vmKJFZPrXEYwKu7A1ATxbgodw8ouk+3JjRjp2UIP5I+aEYSQs3slPcSMFMIWgb/wCturSAnOc3pbwaaH8sneH5hZzriy7zPUvhmVX827ko5f6XwL4qxKp8MPiWYwcMEx2WZF3s2fERgZgKeNWpZxfr5pDTKnwH3pWeyCf+pWEcO+MmKsVFyyhshvyvdeWyIEHR3V3HnTV1HbGP2FUbrJCxNQLfqOUIM8oFsayVHAmhk7YBlp9XZPnJsdMPfCnO1rTmNYH6yfuh9q0GGrTzYsRzkmxwvPVNmR2TXcQDcE6QNAN8CBSyOTYUvW7yhpcDlNOza1sjarrKR8yGFCro3MWaPZgnfZEMpgMLhFxQDxya5PEvHXAAlcHsbHwjHow0dh6cSA7s3g4Sz4dN3SBwWA0PaGAOBTH6iHelUP+cACcwPumWec0/6WngrIo1Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(7696005)(426003)(26005)(1076003)(16526019)(336012)(2616005)(8676002)(47076005)(83380400001)(6666004)(5660300002)(478600001)(54906003)(2906002)(4326008)(70586007)(70206006)(41300700001)(110136005)(8936002)(44832011)(316002)(36756003)(40460700003)(86362001)(81166007)(82740400003)(40480700001)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:33:54.4927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0630078a-2d9b-46d5-257f-08dbcb065a23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In selftests/amd-pstate, tbench and gitsource microbenchmarks are
used to compare the performance with different governors. In current
implementation the relative path to run `amd_pstate_tracer.py` is broken.
Fix this by using absolute paths.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 .../x86/amd_pstate_tracer/amd_pstate_trace.py   |  3 +--
 tools/testing/selftests/amd-pstate/gitsource.sh | 17 +++++++++++------
 tools/testing/selftests/amd-pstate/run.sh       |  9 ++++++---
 tools/testing/selftests/amd-pstate/tbench.sh    |  2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
index 904df0ea0a1e..feb9f9421c7b 100755
--- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
+++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
@@ -30,8 +30,7 @@ import getopt
 import Gnuplot
 from numpy import *
 from decimal import *
-sys.path.append('../intel_pstate_tracer')
-#import intel_pstate_tracer
+sys.path.append(os.path.join(os.path.dirname(__file__), "..", "intel_pstate_tracer"))
 import intel_pstate_tracer as ipt
 
 __license__ = "GPL version 2"
diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
index 5f2171f0116d..ab195ddcba4d 100755
--- a/tools/testing/selftests/amd-pstate/gitsource.sh
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Testing and monitor the cpu desire performance, frequency, load,
@@ -66,12 +66,15 @@ post_clear_gitsource()
 
 install_gitsource()
 {
-	if [ ! -d $git_name ]; then
+	if [ ! -d $SCRIPTDIR/$git_name ]; then
+		pushd $(pwd) > /dev/null 2>&1
+		cd $SCRIPTDIR
 		printf "Download gitsource, please wait a moment ...\n\n"
 		wget -O $git_tar $gitsource_url > /dev/null 2>&1
 
 		printf "Tar gitsource ...\n\n"
 		tar -xzf $git_tar
+		popd > /dev/null 2>&1
 	fi
 }
 
@@ -79,12 +82,14 @@ install_gitsource()
 run_gitsource()
 {
 	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
-	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
+	$TRACER -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
 
 	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
-	cd $git_name
-	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
-	cd ..
+	BACKUP_DIR=$(pwd)
+	pushd $BACKUP_DIR > /dev/null 2>&1
+	cd $SCRIPTDIR/$git_name
+	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
+	popd > /dev/null 2>&1
 
 	for job in `jobs -p`
 	do
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index de4d8e9c9565..279d073c5728 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -8,9 +8,12 @@ else
 	FILE_MAIN=DONE
 fi
 
-source basic.sh
-source tbench.sh
-source gitsource.sh
+SCRIPTDIR=`dirname "$0"`
+TRACER=$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
+
+source $SCRIPTDIR/basic.sh
+source $SCRIPTDIR/tbench.sh
+source $SCRIPTDIR/gitsource.sh
 
 # amd-pstate-ut only run on x86/x86_64 AMD systems.
 ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
index 49c9850341f6..4d2e8ce2da3b 100755
--- a/tools/testing/selftests/amd-pstate/tbench.sh
+++ b/tools/testing/selftests/amd-pstate/tbench.sh
@@ -64,7 +64,7 @@ post_clear_tbench()
 run_tbench()
 {
 	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
-	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
+	$TRACER -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
 
 	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
 	tbench_srv > /dev/null 2>&1 &
-- 
2.34.1

