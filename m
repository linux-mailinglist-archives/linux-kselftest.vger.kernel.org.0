Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17E7A1C81
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjIOKlr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjIOKlq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 06:41:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFBBA1;
        Fri, 15 Sep 2023 03:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdvvOCFqKwbn4gDyLyUCD9xtU9GrsSVTzD9a2DI26tqrwNLiJrzoGdFQFC0bjclBXwLGAmnkVnGjAPWSaXGxyFDoCB3MplF7UUFLPbl8UUOTvNWoc0vYyPWOtd6EIqvacVZh5UsBfkkV5nmVkcVxJ1JoNXSmk0CDYWvelb3YAfftSjT8Fy+T7CzF6WjaiZk+NmgTj2rCl5qvkaqp4s8+4/sA2FZO6T+Sqc0ml6FvvntXM534CDWb+PRJoXYyWYuS89jTofB9i/3izbj4xYZTIcnMKiKNgmna8FF5WCqxnZafk3IRfr/WN89KYrPk4cksE8cTs+g2+ivX0ZC/W2y8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64FcbRcrXNerMZTZqvliAuI+D0U18OuyO2Dusc3iYGw=;
 b=Ya+RkzjUHvCpZReynInRdwoKuLf2mvxIoUOSabkAEc1hhz1x3h8O1awcNoAJ+ygeBR9ml4Ff3DeGsFDFFFfsOqsqaRdMubTTuF1SnGHYDTlrzkvn/HWR0M1rN6KCuRyDBrmfZWZS7llOvEATOvmVoCFOryZYwPZtmktpGhkbkpqWzXX/U/AFBq4g84H2gbvLWQXqFoyX0VaTm8XMJF/4JmGcQmlCatyA+UWO1D9CeqYMZY1bPZWUNFnMaelDh8ayFXfhLBLwc3ObX3lAyeZmupUgEptfN8BLrJAqDJ8AvRqWH+ylubpuhglIl2NILHSea5aeFApkTTsoHMyMZ1dFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64FcbRcrXNerMZTZqvliAuI+D0U18OuyO2Dusc3iYGw=;
 b=48G4E5Sjp7LQkHoq9PtXprOUA/GPJsYCN40svvagAs8IoxCr8+9cb8xXlNQHDp8mJWsGPKJM52Scs9FKuhFxFx89R3k+kR5LsIFM991wBcDAD1iBTlEKJoYo00sspHrD0qodeFOejNkZNpmOj4GNtCYgNI3Rx39YmFXQngjKiKA=
Received: from CH0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:610:e5::32)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 10:41:36 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::7c) by CH0PR03CA0267.outlook.office365.com
 (2603:10b6:610:e5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 10:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 10:41:36 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 05:41:34 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Ray.Huang@amd.com>,
        <li.meng@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <gautham.shenoy@amd.com>,
        <wyes.karny@amd.com>, <Perry.Yuan@amd.com>,
        <Mario.Limonciello@amd.com>, <zwisler@chromium.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH 1/2] selftests/amd-pstate: Fix broken paths to run workloads in amd-pstate-ut
Date:   Fri, 15 Sep 2023 10:40:56 +0000
Message-ID: <20230915104057.132210-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915104057.132210-1-swapnil.sapkal@amd.com>
References: <20230915104057.132210-1-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: de0ab8b7-f833-48d4-f181-08dbb5d855f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzs44niQPX5I0G6fJ9zG4P++S8Mh7ywSIrdQ474rpmMM5iACSRmNhwOxZSVPF2DTRMP33JvHxBp/gHyyqzPRzcNcnrHYxsK2qX+TNpvpXxqEQiT94Dz3dGKviz1ynMu5Nl5NYf0GWSk5dMuIZXKeg7LfI7djbFeJi56nmngjF1Ot11sumzFLip0SSXP6fRBPkp9oc2n7H7/0fIx0PcAYgPdUyoB8DoDEz+TDJY5ukB3JSvPE2zuHm/YYkv4HzQ0Qgf9cMNitCZo+DOCqGE7//enmmJCe6Azc6f1nc/Xv7VU33q1rKEvO+2fUdkYbZYvUJfEoorG/m+tQ1tN7SEH/Gujt0nAMC1UbAECpz233D0ExLYcAALuHHog9Wxhs0aPol6kDsTU/DtRHt3/uR/htYeY+P0zsioiMtuHvuzHwwgzZWtTGy2HPeOlipmRxwQCWYlJlTBfK1haF1/3i7A0EWDpPpd/AB1CORvdLfhC6E5GRcj+WkHFrFIG7Tb/ocLf5CN5rp2XL+hrgIdrwzq/ZGQEBtnKxhxVZGzjEFOKIibQGzXnZAIKCnKNSXDygFMAsjfE9qRr8z+J91Od8gYkJI4KRuPVtMmgMFU3htV8ISQ1xOvfdzSWABS5wNFDp/2wKKwvxZOlTeGYTP9CJiq3VGeF5eTJSSiHydM/E2oKqJRpKvU02qO/JyBEL3I1I/8whzeROonIZ+0SEpN7jpj4X4lLNZx81hiSZFnVc77o8f8Uh2MSLuhWc/Xnn8Cf6QN9lHEMctAbMIwtRnFDCP7uWjCndONum0LMtab5EcIiUOBM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(7696005)(40460700003)(6666004)(82740400003)(83380400001)(86362001)(81166007)(356005)(47076005)(36860700001)(2616005)(36756003)(1076003)(26005)(40480700001)(16526019)(54906003)(110136005)(70206006)(41300700001)(70586007)(316002)(44832011)(2906002)(8676002)(8936002)(4326008)(336012)(426003)(5660300002)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 10:41:36.1693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0ab8b7-f833-48d4-f181-08dbb5d855f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

