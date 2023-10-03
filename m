Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF947B6043
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 07:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbjJCFKu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 01:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjJCFKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 01:10:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F64E6;
        Mon,  2 Oct 2023 22:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/89HJ1aWdSMUujcqX3O60wnapyILMgwK2wox/jAmSXGztIyHDpbpys+FyL79oDuJuEg/r9vEqT/c6mVgmz/k4AhDl0Riik3TdzCvqW0VOs1jLQ6WZEvBZSfQhteE3GKnU4+F0K+XHP+d/0ZBRkWLsTH6lq7Rq3+SpzIWX6twHygD57QLZD5vZ7O/uWm+Mb+9SuJDPC7OfSLq7LhoaVaMPFZAZOLMi6lQ9vlllmThpw5PL65+oGuqNlg1Iw9yA6lX9F/N5iT3Y6neOt6Ye/b/qKQBO1JqxTp1hPlt666LeDS3JQ71BmNREfRLbIFlgDeoWLV4Myc42VKaUUlIv7w6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/54wVZnxuVLSg0HoGE2dBFTLJCv33ec2ldZlFq6DlY=;
 b=V7Z4w8le6cLZjhhXXRSljNbpbdysmyJIqfEJy60iqWPid5QPMjC8WYu07Pt5K4imfsxXYdpL8FdZRsMzLkmWbkb212wbE4Yu8tswiFczP64VmEILqmlisS79GF3Zgeft9SMGC75I7QVUvKTbJfIpawtD/G6UrQOJoRcTuEbfJxBGMHxG9ow8bQiec3mnAwQJ5JMkfVzLL1QYwcpW4ta7EeFwF+/K3MHbIlIzKcEI4wHKOHCb8X01fito2Hr9EFvxE0eqmPnfc9pc0lMLaeEgJvgA4lujIDb4e+74TWZHvdYhC4OdSSA+ZyOgfwmVjL8qEzHLHMz2+yws2DGE9IAWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/54wVZnxuVLSg0HoGE2dBFTLJCv33ec2ldZlFq6DlY=;
 b=UDIHBuoz0+GKj+ZNYe5icKQzjyRD6qdG3IQNGDPA/DzEvUaXCtEijCV17uHnkkn11mo/5MhbJnAg+BtHNQDZBDnmDixDaes0sPrGFUq6//oLP3S+uia2ToISTRQ7GrCcjpuk0k5kDJ9WF6H8nQYii22ukV39QQzxmvZAimYc7SI=
Received: from SJ0PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:33f::27)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 05:10:40 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::eb) by SJ0PR05CA0052.outlook.office365.com
 (2603:10b6:a03:33f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.21 via Frontend
 Transport; Tue, 3 Oct 2023 05:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 05:10:39 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 00:10:38 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <li.meng@amd.com>,
        <gautham.shenoy@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>, <Mario.Limonciello@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v3 1/2] selftests/amd-pstate: Fix broken paths to run workloads in amd-pstate-ut
Date:   Tue, 3 Oct 2023 05:10:05 +0000
Message-ID: <20231003051006.6343-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003051006.6343-1-swapnil.sapkal@amd.com>
References: <20231003051006.6343-1-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1d27c1-d0c8-4ef1-bcd3-08dbc3cf1609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCXJHaRQ+kVLrHnjzvLAQ1pWAtDe9GNPmDBa06bwzFsAlimSsYDn0eUrScx+y/fnWXlBfcYu+2eHfrCGkZvzCoJYiNSYgVVsTO4gDGHcuym+y8IywMsRtaXqtL82hnGrIuLZYOOp/NynhpAXh0wtPFtZqGaoyPODxcmoDyWtvPljL+/5v3sClRW+xHwgGBE8nSjo0Jpsux+XOeW2J9VDi4nXtGwlYe0sod3imZ/ccCYN7C07oWIbz48IqY3Rg4nV2U4z9L2mO06bryYo4yAKEDuiL6uN/fGSEiXO4XbpjloRUt5+j5EiCjclL8jX7NJG2VPrlRTHj+PDrw9Ku4xupvNns+MYIhOtuXJtDpgIhQce+rN4LdzSN2QZkGARlZxoEdrhS/HLjRKWZKPZP97QR3m9HDKWnKOJhkexHGMRrhx0aDCn9PXfTi0+JjRxtZaUgJ7eBCesW/sQj/nEXiA5gUIywKfQ515P3wIntn3Y/15RwX4pMQi4XtgLFuNgvlQtUIRiwHUawyhDSv4MQhZkIiiGV397TZwzCE0PjKcgJrHgWMU//khf504TM0bKZT1WWWQog9pxkROJFFgZQ1pC4agEnExId8FAlNEMIcMPW3LV1FEhMeQ05jGl9nTDWipWVoHiPgz8KF85HiLR2Cswe0o+clENJELS51+KIK9rOSaMurOEpY7esa64NA2PkrXwxgMZI1qXMVW5IFwz27i3DzqGjfGl+PnDZvLhbv9MWSTIELPBkEAdDgYcMAmuLTCWMjHJQ2HNJ2AODgQqygslLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(41300700001)(82740400003)(54906003)(70586007)(70206006)(81166007)(478600001)(356005)(110136005)(316002)(2906002)(8936002)(2616005)(86362001)(4326008)(336012)(36860700001)(44832011)(83380400001)(7696005)(1076003)(16526019)(8676002)(26005)(6666004)(47076005)(5660300002)(426003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 05:10:39.6878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1d27c1-d0c8-4ef1-bcd3-08dbc3cf1609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In selftests/amd-pstate, tbench and gitsource microbenchmarks are
used to compare the performance with different governors. In Current
implementation relative path to run `amd_pstate_tracer.py` are broken.
Fixed this by using absolute paths.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 .../x86/amd_pstate_tracer/amd_pstate_trace.py      |  2 +-
 tools/testing/selftests/amd-pstate/gitsource.sh    | 14 +++++++++-----
 tools/testing/selftests/amd-pstate/run.sh          |  9 ++++++---
 tools/testing/selftests/amd-pstate/tbench.sh       |  2 +-
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
index 904df0ea0a1e..2448bb07973f 100755
--- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
+++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
@@ -30,7 +30,7 @@ import getopt
 import Gnuplot
 from numpy import *
 from decimal import *
-sys.path.append('../intel_pstate_tracer')
+sys.path.append(os.path.join(os.path.dirname(__file__), '../intel_pstate_tracer'))
 #import intel_pstate_tracer
 import intel_pstate_tracer as ipt
 
diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
index 5f2171f0116d..d0ad2ed5ba9d 100755
--- a/tools/testing/selftests/amd-pstate/gitsource.sh
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -66,12 +66,15 @@ post_clear_gitsource()
 
 install_gitsource()
 {
-	if [ ! -d $git_name ]; then
+	if [ ! -d $SCRIPTDIR/$git_name ]; then
+		BACKUP_DIR=$(pwd)
+		cd $SCRIPTDIR
 		printf "Download gitsource, please wait a moment ...\n\n"
 		wget -O $git_tar $gitsource_url > /dev/null 2>&1
 
 		printf "Tar gitsource ...\n\n"
 		tar -xzf $git_tar
+		cd $BACKUP_DIR
 	fi
 }
 
@@ -79,12 +82,13 @@ install_gitsource()
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
+	cd $SCRIPTDIR/$git_name
+	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
+	cd $BACKUP_DIR
 
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

