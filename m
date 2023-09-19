Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DF27A5FB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjISKeX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjISKeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 06:34:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189C1F3;
        Tue, 19 Sep 2023 03:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/+p4SpHwMzGOenirB6mxUBiVlg8P3pOXPH2DBme6iSkJqbuNSKufkz4bNgzTny6yMCsLf9O+Mpwwz3J9/SX9vSX4UZxzATYbMXOSUTALnUFVVqQNxi4UtUgIkJnIQ3PqdwvHPr6p4Wtqe4iCaCP7zIM6/5iu0WfIP12HSzPWxb7i8uNvVN3T84cvy2umwyvMVhlJapFq7EpDtLVozPPcmrwznu1h/AI9hRpdMS5xvJKyErEaJo7/oaw3EZ+QSXs+7POOP7uA1jsWzW+CnGozYcT6HG2brqfEjtHv2MMWXpNy6g50YPmzPAxEZFCCkRWdo0PXZRESVOO292xkTD62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64FcbRcrXNerMZTZqvliAuI+D0U18OuyO2Dusc3iYGw=;
 b=kUxbefKvcplejxQeuAbBsySz8/DSbr7IQt1zMtU6k7HSdchQOqKeqIgsYRg21nwc8d/H1QieVJh8zqn03cDxEvYBrZsZ2v/SkullBc3aXpSgLOYZv6hJYwqLdtEM+mpxZdfkyx1DsckcUj3HVf7Bs5LYF0sCTK13YY1pJXbSopufGBu+Pny3hkumUisthTMlsOVmGJH93dMWxVNX7wpeK3pUdITUx4zW9n5bQ2Ulw1ErjhPUa7H/l7U7Lwen2AQGAG2LzS8shDdOhcTKLZqBYElMCRZG57Bc4zPMNGSB0fTlcIFsubbX/j9DH6W0A2d83kDXS71wwf+uC09/Anuk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64FcbRcrXNerMZTZqvliAuI+D0U18OuyO2Dusc3iYGw=;
 b=4e8bDlPrLT5aI7MCOnq6CFPsotpaqOqNqnZudscQSRvHsBWJ5KN/0GM9awfjfoRuq0WMNFVPiKhadhRvdy7AbwAierYZ0g4ybIVjJKAWVHFhxEUa1UKBkEyqORSeBziiEiqfM1yBGfL2nJCNCJO2Vu7Ubz2qjgpO+9u7+AKgbsc=
Received: from MN2PR17CA0021.namprd17.prod.outlook.com (2603:10b6:208:15e::34)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 10:34:09 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::7c) by MN2PR17CA0021.outlook.office365.com
 (2603:10b6:208:15e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 10:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 10:34:09 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 05:34:08 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <li.meng@amd.com>,
        <gautham.shenoy@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>, <Mario.Limonciello@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v2] selftests/amd-pstate: Fix broken paths to run workloads in amd-pstate-ut
Date:   Tue, 19 Sep 2023 10:33:51 +0000
Message-ID: <20230919103351.48681-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: cb118fbb-4c44-433a-231d-08dbb8fbf545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTnZLji9Vw17P/MJiNG5YK89E6Mrd3CJanRi4Z+lGIaSRcWRcnS+1GUpQHodxJdzFQcO9QPOqwc1WknMp02Ny0zFmPFSlWUR2tXB5EJqxmUpB9Y/qR0t+8NkTWhXPhQaMJNAhxe4txpKTbytoywSM+qrBIEBlWjW4onkF88S4omlstrc7UwcCbp+p/bigFVg1KowR8kOjc5pEdhUXe3Q4S3Y6CBzMRq8QU7Y/4edKNTdkcZZJSJ8tpvdvOXF++RBhzJpijYn6sTiNijnam9qfn22u1E6kDj+SwvVvYZEO+9eQMMV76jRm0xR/xUEDVKKn+n3K23nuWGH/B8djs83j/20g4scz3tN2WLV8x+DXftSHZ6WLi+6SVHyOZHI70Hg3lkmZLwI1K9OvrdALif+OWKGwLynuTw4r/kjSbMjYiC/3kCBjsGG97NDdFSF1lw6ObujWQRDmdPbTzpNS3ax8F2KR2nR5iKxme3OK8YsrCyAH4GdhxBfMMt7PaE6x/aLKt5XnBH+jDOQ49wwaln6wAEgCAF6OARmrDS0n9HZF0SoNI0NEpNstjK69xpY4D+fT4Q6+FBeA1OrivUPe5uI9nSCr8reIZQSKa79QBhgVKa+ak3n8bzZuv8QO8C/MYJhcfOhqiKfDrsq6SJVY0slt08GE6hFYLBOjgLtlDRE1HUxQPAT24r5Eil+FummErrgs9ILyTp6OR6dagI5ttJIyj2Ni9uUOzjEVoBW8uE8PudT8H76TtWfocyXKcFDKH8L5h5fHOcNwwSCdMD526OIgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(36756003)(81166007)(86362001)(356005)(82740400003)(40480700001)(36860700001)(2616005)(16526019)(1076003)(26005)(2906002)(47076005)(336012)(426003)(478600001)(83380400001)(44832011)(8676002)(5660300002)(110136005)(4326008)(41300700001)(8936002)(70586007)(70206006)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 10:34:09.3839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb118fbb-4c44-433a-231d-08dbb8fbf545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In selftests/amd-pstate, tbench and gitsource microbenchmarks are used to
compare the performance with different governors. In Current
implementation relative path to run `amd_pstate_tracer.py`
broken. Fixed this by using absolute paths.
Also selftests/amd-pstate uses distro `perf` to capture stats while running
these microbenchmarks. Distro `perf` is not working with upstream
kernel. Fixed this by providing an option to give the perf binary path.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 .../x86/amd_pstate_tracer/amd_pstate_trace.py |  2 +-
 .../testing/selftests/amd-pstate/gitsource.sh | 14 +++++++-----
 tools/testing/selftests/amd-pstate/run.sh     | 22 +++++++++++++------
 tools/testing/selftests/amd-pstate/tbench.sh  |  4 ++--
 4 files changed, 27 insertions(+), 15 deletions(-)

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
index 5f2171f0116d..c327444d3506 100755
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
+	$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
 
 	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
-	cd $git_name
-	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
-	cd ..
+	BACKUP_DIR=$(pwd)
+	cd $SCRIPTDIR/$git_name
+	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
+	cd $BACKUP_DIR
 
 	for job in `jobs -p`
 	do
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index de4d8e9c9565..0803e70b04da 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -8,9 +8,11 @@ else
 	FILE_MAIN=DONE
 fi
 
-source basic.sh
-source tbench.sh
-source gitsource.sh
+SCRIPTDIR=`dirname "$0"`
+
+source $SCRIPTDIR/basic.sh
+source $SCRIPTDIR/tbench.sh
+source $SCRIPTDIR/gitsource.sh
 
 # amd-pstate-ut only run on x86/x86_64 AMD systems.
 ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
@@ -22,6 +24,7 @@ OUTFILE=selftest
 OUTFILE_TBENCH="$OUTFILE.tbench"
 OUTFILE_GIT="$OUTFILE.gitsource"
 
+PERF=/usr/bin/perf
 SYSFS=
 CPUROOT=
 CPUFREQROOT=
@@ -149,8 +152,9 @@ help()
 	     gitsource: Gitsource testing.>]
 	[-t <tbench time limit>]
 	[-p <tbench process number>]
-	[-l <loop times for tbench>]
+	[-l <loop times for tbench/gitsource>]
 	[-i <amd tracer interval>]
+	[-b <perf binary>]
 	[-m <comparative test: acpi-cpufreq>]
 	\n"
 	exit 2
@@ -158,7 +162,7 @@ help()
 
 parse_arguments()
 {
-	while getopts ho:c:t:p:l:i:m: arg
+	while getopts ho:c:t:p:l:i:b:m: arg
 	do
 		case $arg in
 			h) # --help
@@ -189,6 +193,10 @@ parse_arguments()
 				TRACER_INTERVAL=$OPTARG
 				;;
 
+			b) # --perf-binary
+				PERF=`realpath $OPTARG`
+				;;
+
 			m) # --comparative-test
 				COMPARATIVE_TEST=$OPTARG
 				;;
@@ -202,8 +210,8 @@ parse_arguments()
 
 command_perf()
 {
-	if ! command -v perf > /dev/null; then
-		echo $msg please install perf. >&2
+	if ! $PERF -v; then
+		echo $msg please install perf or provide perf binary path as argument >&2
 		exit $ksft_skip
 	fi
 }
diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
index 49c9850341f6..70e5863e74ea 100755
--- a/tools/testing/selftests/amd-pstate/tbench.sh
+++ b/tools/testing/selftests/amd-pstate/tbench.sh
@@ -64,11 +64,11 @@ post_clear_tbench()
 run_tbench()
 {
 	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
-	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
+	$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
 
 	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
 	tbench_srv > /dev/null 2>&1 &
-	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
+	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
 
 	pid=`pidof tbench_srv`
 	kill $pid
-- 
2.34.1

