Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9847C6131EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 09:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJaIuN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJaIuK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 04:50:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DB9D12C;
        Mon, 31 Oct 2022 01:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P33/idVFhSpkiemiPqR1HOKcI+/8ehQbjUaGoupeR+ceE8stq/RouWIRjgNINpiDKQ3Txh+6SI7BOc+POV5dVnUHi8RPHWiejJJLiVSE3baEm3R9c6cSEYxXnDYRlzeOMarmusgOI3y8SgYfsqlTmxpsY2HYpUeYCdicHBaUU73HJvGKzD03D81a5FM2bjQr3YnwdsIUAeyu8gs2/MD11YZFiElzH3MpmqlizdfOVvg4JskWVLxJrOdqaZxOZsgerHZayJhSz3mlXBBk7zhwewUix+KcmV61p4CCNJtKtgnjHFBqbvxWHluuL2BUeoKO3KJxly5KU92L3DzldycJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FFxjy9HetRKgWssK01K23mHZ6k5DylxGmXiL6QBlHI=;
 b=QfDfF5mv2O0a3ruO7J91RhowI5DgaiyIQuANWYLMhGBII3edoXs9Z0BB9PhX/8Ao3wvhiCnrZiWL1q3yrCtfRrBFZGfueiOMlZRbTMpB4MusRV8Z0Bo1O6fVSme4KK63FRSS42grLhoBY6wsO8v2EjLL/+48dnCiveyPTMbFitAYChtEjqXgiWQgL1v2XNz9weMPWfO7u/tIBtLCUE0PKyUCeF3QUnzzllZT8VGwwkGyII0XJ9cPV/9U2+CJF3gkZ1p0ntzo7B9DNpsyODyzpqu+VKx4QV8X9Y/5IS+MRqop9YckltYfOAlqwEmWS+wvrA06PgZt6rqfkaWr5XJbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FFxjy9HetRKgWssK01K23mHZ6k5DylxGmXiL6QBlHI=;
 b=wE2Trgglspgia0qQtGDtGM6SS7dzZ8dRIabvuPnnQJxGI7oLOQx2Az0GsogeP4L4n2T48IRqiOMEEldyje+FO2SDx9MzdEQZreHTxsbv1YbqWrq9HjwwJhhVcDCp+lbMiuWbRgk2H4IiTIMkWPGJvy7lj1+LYPporosH4Zqt3GI=
Received: from DS7PR03CA0347.namprd03.prod.outlook.com (2603:10b6:8:55::6) by
 PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Mon, 31 Oct 2022 08:50:02 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::d3) by DS7PR03CA0347.outlook.office365.com
 (2603:10b6:8:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18 via Frontend
 Transport; Mon, 31 Oct 2022 08:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.17 via Frontend Transport; Mon, 31 Oct 2022 08:50:02 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 03:49:57 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>,
        <linux-kselftest@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V5 3/5] selftests: amd-pstate: Trigger tbench benchmark and test cpus
Date:   Mon, 31 Oct 2022 16:49:22 +0800
Message-ID: <20221031084924.1742169-4-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031084924.1742169-1-li.meng@amd.com>
References: <20221031084924.1742169-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|PH0PR12MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 564a3977-f401-4a23-ba8f-08dabb1ce629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBTsPQ84IDwRbLpe5p2JPNNP9ouheLthmbv6C2l3aDHewPGlWhJ7m0joSOGdN8bZzkeSswr3UxFUYVh855T/hjrq5SfdYItCd+6C61PWzMYK9QjMoYlfBPYmLobhm+igaq567xx1b3EDYCwiQyqeRlKCPINJaYmi9DqcqPZiPoPQVzzJFKAqRPQYFGKgtfWiSx4W76FNi4FRdqKCqIAy4vgSyts3nZT1Gn2Gu5asWImi4PqV7yyWLnOjLsBvSizs/R2FFUGC6HsrwaU9dXFbbYuHr/h79nuHdNdHmVTs7lHB2gYaIJwt45Fb7GXSek4z+Y5Ydu8z1FxWrA5OKOKbajD+OJ4VcOBGsYbJtJfctkFNGy1bEQhGKQaSeuLXtkDMO0+7oWWQ18tVXQkdlYgIBYgSaf9LvaS0hIVSqWLSlgg42d0X8Ij+KUcs6uZxOf5lE2vrr4D1n8BtY1gPCxfF9m8vAxJNZVg/AFJD3PcDPVsDk/H7dPR99LuF7d9qPWe4yng9dyJwJ8HeAT730aaFg6CBw8olgNE6cEvX12/hd+UnkRzYwX8kY3UhlVGXkmKe/w5kCSdHpVHounxs4+DfacCudmXlCx07phvOLPgH0H8ArvLWFdyyHNOYGWvqe1Q/iWZ+b84VW2bngcLA/JYRGfJRWq0EIYhgjqDCWJicPNuLnDDABAI/fBG7dvOLIuJHhwcxJx2HvoKpyiNP6WsfD4/dXZvVyOFEdQeURS59ybdm5SvA1pQWI9F5vUUggtvTRpfRhcR5NoIGoo3O0w9JQhbbSCcC91aPmTM+5oAbrQSnu1KeNjsnf3b4kOZjDIw6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(110136005)(8676002)(4326008)(54906003)(41300700001)(5660300002)(70206006)(70586007)(8936002)(30864003)(6666004)(478600001)(2906002)(81166007)(356005)(336012)(16526019)(2616005)(36756003)(26005)(186003)(7696005)(1076003)(47076005)(426003)(83380400001)(316002)(82310400005)(36860700001)(86362001)(40480700001)(82740400003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 08:50:02.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 564a3977-f401-4a23-ba8f-08dabb1ce629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tbench.sh trigger the tbench testing and monitor the cpu desire
performance, frequency, load, power consumption and throughput etc.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile  |  10 +-
 tools/testing/selftests/amd-pstate/run.sh    | 245 +++++++++++++-
 tools/testing/selftests/amd-pstate/tbench.sh | 339 +++++++++++++++++++
 3 files changed, 583 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 6f4c7b01e3bb..cac8dedb7226 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,7 +4,15 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq (x86,$(ARCH))
+TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
+TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+endif
+
 TEST_PROGS := run.sh
-TEST_FILES := basic.sh
+TEST_FILES := basic.sh tbench.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index 35c0a0b16ad3..e7e98068a03b 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -9,16 +9,107 @@ else
 fi
 
 source basic.sh
+source tbench.sh
 
 # amd-pstate-ut only run on x86/x86_64 AMD systems.
 ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
 VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
 
+msg="Skip all tests:"
 FUNC=all
 OUTFILE=selftest
+OUTFILE_TBENCH="$OUTFILE.tbench"
+
+SYSFS=
+CPUROOT=
+CPUFREQROOT=
+MAKE_CPUS=
+
+TIME_LIMIT=100
+PROCESS_NUM=128
+LOOP_TIMES=3
+TRACER_INTERVAL=10
+CURRENT_TEST=amd-pstate
+COMPARATIVE_TEST=
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+all_scaling_names=("acpi-cpufreq" "amd-pstate")
+
+# Get current cpufreq scaling driver name
+scaling_name()
+{
+	if [ "$COMPARATIVE_TEST" = "" ]; then
+		echo "$CURRENT_TEST"
+	else
+		echo "$COMPARATIVE_TEST"
+	fi
+}
+
+# Counts CPUs with cpufreq directories
+count_cpus()
+{
+	count=0;
+
+	for cpu in `ls $CPUROOT | grep "cpu[0-9].*"`; do
+		if [ -d $CPUROOT/$cpu/cpufreq ]; then
+			let count=count+1;
+		fi
+	done
+
+	echo $count;
+}
+
+# $1: policy
+find_current_governor()
+{
+	cat $CPUFREQROOT/$1/scaling_governor
+}
+
+backup_governor()
+{
+	policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
+	for policy in $policies; do
+		cur_gov=$(find_current_governor $policy)
+		echo "$policy $cur_gov" >> $OUTFILE.backup_governor.log
+	done
+
+	printf "Governor $cur_gov backup done.\n"
+}
+
+restore_governor()
+{
+	i=0;
+
+	policies=$(awk '{print $1}' $OUTFILE.backup_governor.log)
+	for policy in $policies; do
+		let i++;
+		governor=$(sed -n ''$i'p' $OUTFILE.backup_governor.log | awk '{print $2}')
+
+		# switch governor
+		echo $governor > $CPUFREQROOT/$policy/scaling_governor
+	done
+
+	printf "Governor restored to $governor.\n"
+}
+
+# $1: governor
+switch_governor()
+{
+	policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
+	for policy in $policies; do
+		filepath=$CPUFREQROOT/$policy/scaling_available_governors
+
+		# Exit if cpu isn't managed by cpufreq core
+		if [ ! -f $filepath ]; then
+			return;
+		fi
+
+		echo $1 > $CPUFREQROOT/$policy/scaling_governor
+	done
+
+	printf "Switched governor to $1.\n"
+}
 
 # All amd-pstate tests
 amd_pstate_all()
@@ -27,8 +118,19 @@ amd_pstate_all()
 	printf "***** Running AMD P-state Sanity Tests  *****\n"
 	printf "=============================================\n\n"
 
+	count=$(count_cpus)
+	if [ $count = 0 ]; then
+		printf "No cpu is managed by cpufreq core, exiting\n"
+		exit;
+	else
+		printf "AMD P-state manages: $count CPUs\n"
+	fi
+
 	# unit test for amd-pstate kernel driver
 	amd_pstate_basic
+
+	# tbench
+	amd_pstate_tbench
 }
 
 help()
@@ -37,21 +139,27 @@ help()
 	[-h <help>]
 	[-o <output-file-for-dump>]
 	[-c <all: All testing,
-	     basic: Basic testing.>]
+	     basic: Basic testing,
+	     tbench: Tbench testing.>]
+	[-t <tbench time limit>]
+	[-p <tbench process number>]
+	[-l <loop times for tbench>]
+	[-i <amd tracer interval>]
+	[-m <comparative test: acpi-cpufreq>]
 	\n"
 	exit 2
 }
 
 parse_arguments()
 {
-	while getopts ho:c: arg
+	while getopts ho:c:t:p:l:i:m: arg
 	do
 		case $arg in
 			h) # --help
 				help
 				;;
 
-			c) # --func_type (Function to perform: basic (default: all))
+			c) # --func_type (Function to perform: basic, tbench (default: all))
 				FUNC=$OPTARG
 				;;
 
@@ -59,6 +167,26 @@ parse_arguments()
 				OUTFILE=$OPTARG
 				;;
 
+			t) # --tbench-time-limit
+				TIME_LIMIT=$OPTARG
+				;;
+
+			p) # --tbench-process-number
+				PROCESS_NUM=$OPTARG
+				;;
+
+			l) # --tbench-loop-times
+				LOOP_TIMES=$OPTARG
+				;;
+
+			i) # --amd-tracer-interval
+				TRACER_INTERVAL=$OPTARG
+				;;
+
+			m) # --comparative-test
+				COMPARATIVE_TEST=$OPTARG
+				;;
+
 			*)
 				help
 				;;
@@ -66,6 +194,32 @@ parse_arguments()
 	done
 }
 
+command_perf()
+{
+	if ! command -v perf > /dev/null; then
+		echo $msg please install perf. >&2
+		exit $ksft_skip
+	fi
+}
+
+command_tbench()
+{
+	if ! command -v tbench > /dev/null; then
+		if apt policy dbench > /dev/null 2>&1; then
+			echo $msg apt install dbench >&2
+			exit $ksft_skip
+		elif yum list available | grep dbench > /dev/null 2>&1; then
+			echo $msg yum install dbench >&2
+			exit $ksft_skip
+		fi
+	fi
+
+	if ! command -v tbench > /dev/null; then
+		echo $msg please install tbench. >&2
+		exit $ksft_skip
+	fi
+}
+
 prerequisite()
 {
 	if ! echo "$ARCH" | grep -q x86; then
@@ -80,22 +234,80 @@ prerequisite()
 	fi
 
 	scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
-	if [ "$scaling_driver" != "amd-pstate" ]; then
-		echo "$0 # Skipped: Test can only run on amd-pstate driver."
-		echo "$0 # Please set X86_AMD_PSTATE enabled."
-		echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
-		exit $ksft_skip
+	if [ "$COMPARATIVE_TEST" = "" ]; then
+		if [ "$scaling_driver" != "$CURRENT_TEST" ]; then
+			echo "$0 # Skipped: Test can only run on $CURRENT_TEST driver or run comparative test."
+			echo "$0 # Please set X86_AMD_PSTATE enabled or run comparative test."
+			echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+			exit $ksft_skip
+		fi
+	else
+		case "$FUNC" in
+			"tbench")
+				if [ "$scaling_driver" != "$COMPARATIVE_TEST" ]; then
+					echo "$0 # Skipped: Comparison test can only run on $COMPARATIVE_TEST driver."
+					echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+					exit $ksft_skip
+				fi
+				;;
+
+			*)
+				echo "$0 # Skipped: Comparison test are only for tbench."
+				echo "$0 # Current comparative test is for $FUNC."
+				exit $ksft_skip
+				;;
+		esac
 	fi
 
-	msg="Skip all tests:"
 	if [ ! -w /dev ]; then
 		echo $msg please run this as root >&2
 		exit $ksft_skip
 	fi
+
+	case "$FUNC" in
+		"all")
+			command_perf
+			command_tbench
+			;;
+
+		"tbench")
+			command_perf
+			command_tbench
+			;;
+	esac
+
+	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
+
+	if [ ! -d "$SYSFS" ]; then
+		echo $msg sysfs is not mounted >&2
+		exit 2
+	fi
+
+	CPUROOT=$SYSFS/devices/system/cpu
+	CPUFREQROOT="$CPUROOT/cpufreq"
+
+	if ! ls $CPUROOT/cpu* > /dev/null 2>&1; then
+		echo $msg cpus not available in sysfs >&2
+		exit 2
+	fi
+
+	if ! ls $CPUROOT/cpufreq > /dev/null 2>&1; then
+		echo $msg cpufreq directory not available in sysfs >&2
+		exit 2
+	fi
 }
 
 do_test()
 {
+	# Check if CPUs are managed by cpufreq or not
+	count=$(count_cpus)
+	MAKE_CPUS=$((count*2))
+
+	if [ $count = 0 ]; then
+		echo "No cpu is managed by cpufreq core, exiting"
+		exit 2;
+	fi
+
 	case "$FUNC" in
 		"all")
 			amd_pstate_all
@@ -105,6 +317,10 @@ do_test()
 			amd_pstate_basic
 			;;
 
+		"tbench")
+			amd_pstate_tbench
+			;;
+
 		*)
 			echo "Invalid [-f] function type"
 			help
@@ -117,7 +333,15 @@ pre_clear_dumps()
 {
 	case "$FUNC" in
 		"all")
-			rm -rf $OUTFILE*
+			rm -rf $OUTFILE.log
+			rm -rf $OUTFILE.backup_governor.log
+			rm -rf *.png
+			;;
+
+		"tbench")
+			rm -rf $OUTFILE.log
+			rm -rf $OUTFILE.backup_governor.log
+			rm -rf tbench_*.png
 			;;
 
 		*)
@@ -128,6 +352,7 @@ pre_clear_dumps()
 post_clear_dumps()
 {
 	rm -rf $OUTFILE.log
+	rm -rf $OUTFILE.backup_governor.log
 }
 
 # Parse arguments
diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
new file mode 100755
index 000000000000..49c9850341f6
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/tbench.sh
@@ -0,0 +1,339 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Testing and monitor the cpu desire performance, frequency, load,
+# power consumption and throughput etc.when this script trigger tbench
+# test cases.
+# 1) Run tbench benchmark on specific governors, ondemand or schedutil.
+# 2) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
+# 3) Get desire performance, frequency, load by perf.
+# 4) Get power consumption and throughput by amd_pstate_trace.py.
+# 5) Analyse test results and save it in file selftest.tbench.csv.
+# 6) Plot png images about performance, energy and performance per watt for each test.
+
+# protect against multiple inclusion
+if [ $FILE_TBENCH ]; then
+	return 0
+else
+	FILE_TBENCH=DONE
+fi
+
+tbench_governors=("ondemand" "schedutil")
+
+# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: performance, $7: energy, $8: performance per watt
+store_csv_tbench()
+{
+	echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_TBENCH.csv > /dev/null 2>&1
+}
+
+# clear some special lines
+clear_csv_tbench()
+{
+	if [ -f $OUTFILE_TBENCH.csv ]; then
+		sed -i '/Comprison(%)/d' $OUTFILE_TBENCH.csv
+		sed -i "/$(scaling_name)/d" $OUTFILE_TBENCH.csv
+	fi
+}
+
+# find string $1 in file csv and get the number of lines
+get_lines_csv_tbench()
+{
+	if [ -f $OUTFILE_TBENCH.csv ]; then
+		return `grep -c "$1" $OUTFILE_TBENCH.csv`
+	else
+		return 0
+	fi
+}
+
+pre_clear_tbench()
+{
+	post_clear_tbench
+	rm -rf tbench_*.png
+	clear_csv_tbench
+}
+
+post_clear_tbench()
+{
+	rm -rf results/tracer-tbench*
+	rm -rf $OUTFILE_TBENCH*.log
+	rm -rf $OUTFILE_TBENCH*.result
+
+}
+
+# $1: governor, $2: loop
+run_tbench()
+{
+	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
+	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
+
+	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
+	tbench_srv > /dev/null 2>&1 &
+	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
+
+	pid=`pidof tbench_srv`
+	kill $pid
+
+	for job in `jobs -p`
+	do
+		echo "Waiting for job id $job"
+		wait $job
+	done
+}
+
+# $1: governor, $2: loop
+parse_tbench()
+{
+	awk '{print $5}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-des-perf-$1-$2.log
+	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-des-perf-$1-$2.log)
+	printf "Tbench-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
+
+	awk '{print $7}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-freq-$1-$2.log
+	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-freq-$1-$2.log)
+	printf "Tbench-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
+
+	awk '{print $11}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-load-$1-$2.log
+	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-load-$1-$2.log)
+	printf "Tbench-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep Throughput $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $2}' > $OUTFILE_TBENCH-throughput-$1-$2.log
+	tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1-$2.log)
+	printf "Tbench-$1-#$2 throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep Joules $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_TBENCH-energy-$1-$2.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1-$2.log)
+	printf "Tbench-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
+
+	# Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
+	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# and t is time measured in seconds(s). This means that performance per watt becomes
+	#       T/t   T/t    T
+	#       --- = --- = ---
+	#        P    E/t    E
+	# with unit given by MB per joule.
+	ppw=`echo "scale=4;($TIME_LIMIT-1)*$tp_sum/$en_sum" | bc | awk '{printf "%.4f", $0}'`
+	printf "Tbench-$1-#$2 performance per watt(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
+	printf "\n" | tee -a $OUTFILE_TBENCH.result
+
+	driver_name=`echo $(scaling_name)`
+	store_csv_tbench "$driver_name-$1" $2 $avg_des_perf $avg_freq $avg_load $tp_sum $en_sum $ppw
+}
+
+# $1: governor
+loop_tbench()
+{
+	printf "\nTbench total test times is $LOOP_TIMES for $1\n\n"
+	for i in `seq 1 $LOOP_TIMES`
+	do
+		run_tbench $1 $i
+		parse_tbench $1 $i
+	done
+}
+
+# $1: governor
+gather_tbench()
+{
+	printf "Tbench test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_TBENCH.result
+	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_TBENCH-des-perf-$1.log
+	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-des-perf-$1.log)
+	printf "Tbench-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_TBENCH-freq-$1.log
+	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-freq-$1.log)
+	printf "Tbench-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_TBENCH-load-$1.log
+	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-load-$1.log)
+	printf "Tbench-$1 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "throughput(MB/s):" | awk '{print $NF}' > $OUTFILE_TBENCH-throughput-$1.log
+	tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1.log)
+	printf "Tbench-$1 total throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
+
+	avg_tp=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-throughput-$1.log)
+	printf "Tbench-$1 avg throughput(MB/s): $avg_tp\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_TBENCH-energy-$1.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1.log)
+	printf "Tbench-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
+
+	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-energy-$1.log)
+	printf "Tbench-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_TBENCH.result
+
+	# Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
+	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# and t is time measured in seconds(s). This means that performance per watt becomes
+	#       T/t   T/t    T
+	#       --- = --- = ---
+	#        P    E/t    E
+	# with unit given by MB per joule.
+	ppw=`echo "scale=4;($TIME_LIMIT-1)*$avg_tp/$avg_en" | bc | awk '{printf "%.4f", $0}'`
+	printf "Tbench-$1 performance per watt(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
+	printf "\n" | tee -a $OUTFILE_TBENCH.result
+
+	driver_name=`echo $(scaling_name)`
+	store_csv_tbench "$driver_name-$1" "Average" $avg_des_perf $avg_freq $avg_load $avg_tp $avg_en $ppw
+}
+
+# $1: base scaling_driver $2: base governor $3: comparative scaling_driver $4: comparative governor
+__calc_comp_tbench()
+{
+	base=`grep "$1-$2" $OUTFILE_TBENCH.csv | grep "Average"`
+	comp=`grep "$3-$4" $OUTFILE_TBENCH.csv | grep "Average"`
+
+	if [ -n "$base" -a -n "$comp" ]; then
+		printf "\n==================================================\n" | tee -a $OUTFILE_TBENCH.result
+		printf "Tbench comparison $1-$2 VS $3-$4" | tee -a $OUTFILE_TBENCH.result
+		printf "\n==================================================\n" | tee -a $OUTFILE_TBENCH.result
+
+		# get the base values
+		des_perf_base=`echo "$base" | awk '{print $3}' | sed s/,//`
+		freq_base=`echo "$base" | awk '{print $4}' | sed s/,//`
+		load_base=`echo "$base" | awk '{print $5}' | sed s/,//`
+		perf_base=`echo "$base" | awk '{print $6}' | sed s/,//`
+		energy_base=`echo "$base" | awk '{print $7}' | sed s/,//`
+		ppw_base=`echo "$base" | awk '{print $8}' | sed s/,//`
+
+		# get the comparative values
+		des_perf_comp=`echo "$comp" | awk '{print $3}' | sed s/,//`
+		freq_comp=`echo "$comp" | awk '{print $4}' | sed s/,//`
+		load_comp=`echo "$comp" | awk '{print $5}' | sed s/,//`
+		perf_comp=`echo "$comp" | awk '{print $6}' | sed s/,//`
+		energy_comp=`echo "$comp" | awk '{print $7}' | sed s/,//`
+		ppw_comp=`echo "$comp" | awk '{print $8}' | sed s/,//`
+
+		# compare the base and comp values
+		des_perf_drop=`echo "scale=4;($des_perf_comp-$des_perf_base)*100/$des_perf_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Tbench-$1 des perf base: $des_perf_base comprison: $des_perf_comp percent: $des_perf_drop\n" | tee -a $OUTFILE_TBENCH.result
+
+		freq_drop=`echo "scale=4;($freq_comp-$freq_base)*100/$freq_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Tbench-$1 freq base: $freq_base comprison: $freq_comp percent: $freq_drop\n" | tee -a $OUTFILE_TBENCH.result
+
+		load_drop=`echo "scale=4;($load_comp-$load_base)*100/$load_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Tbench-$1 load base: $load_base comprison: $load_comp percent: $load_drop\n" | tee -a $OUTFILE_TBENCH.result
+
+		perf_drop=`echo "scale=4;($perf_comp-$perf_base)*100/$perf_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Tbench-$1 perf base: $perf_base comprison: $perf_comp percent: $perf_drop\n" | tee -a $OUTFILE_TBENCH.result
+
+		energy_drop=`echo "scale=4;($energy_comp-$energy_base)*100/$energy_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Tbench-$1 energy base: $energy_base comprison: $energy_comp percent: $energy_drop\n" | tee -a $OUTFILE_TBENCH.result
+
+		ppw_drop=`echo "scale=4;($ppw_comp-$ppw_base)*100/$ppw_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Tbench-$1 performance per watt base: $ppw_base comprison: $ppw_comp percent: $ppw_drop\n" | tee -a $OUTFILE_TBENCH.result
+		printf "\n" | tee -a $OUTFILE_TBENCH.result
+
+		store_csv_tbench "$1-$2 VS $3-$4" "Comprison(%)" "$des_perf_drop" "$freq_drop" "$load_drop" "$perf_drop" "$energy_drop" "$ppw_drop"
+	fi
+}
+
+# calculate the comparison(%)
+calc_comp_tbench()
+{
+	# acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil
+	__calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[0]} ${all_scaling_names[0]} ${tbench_governors[1]}
+
+	# amd-pstate-ondemand VS amd-pstate-schedutil
+	__calc_comp_tbench ${all_scaling_names[1]} ${tbench_governors[0]} ${all_scaling_names[1]} ${tbench_governors[1]}
+
+	# acpi-cpufreq-ondemand VS amd-pstate-ondemand
+	__calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[0]} ${all_scaling_names[1]} ${tbench_governors[0]}
+
+	# acpi-cpufreq-schedutil VS amd-pstate-schedutil
+	__calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[1]} ${all_scaling_names[1]} ${tbench_governors[1]}
+}
+
+# $1: file_name, $2: title, $3: ylable, $4: column
+plot_png_tbench()
+{
+	# all_scaling_names[1] all_scaling_names[0] flag
+	#    amd-pstate           acpi-cpufreq
+	#         N                   N             0
+	#         N                   Y             1
+	#         Y                   N             2
+	#         Y                   Y             3
+	ret=`grep -c "${all_scaling_names[1]}" $OUTFILE_TBENCH.csv`
+	if [ $ret -eq 0 ]; then
+		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_TBENCH.csv`
+		if [ $ret -eq 0 ]; then
+			flag=0
+		else
+			flag=1
+		fi
+	else
+		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_TBENCH.csv`
+		if [ $ret -eq 0 ]; then
+			flag=2
+		else
+			flag=3
+		fi
+	fi
+
+	gnuplot << EOF
+		set term png
+		set output "$1"
+
+		set title "$2"
+		set xlabel "Test Cycles (round)"
+		set ylabel "$3"
+
+		set grid
+		set style data histogram
+		set style fill solid 0.5 border
+		set boxwidth 0.8
+
+		if ($flag == 1) {
+			plot \
+			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[0]}", \
+			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[1]}"
+		} else {
+			if ($flag == 2) {
+				plot \
+				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[0]}", \
+				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[1]}"
+			} else {
+				if ($flag == 3 ) {
+					plot \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[0]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[1]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[0]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[1]}"
+				}
+			}
+		}
+		quit
+EOF
+}
+
+amd_pstate_tbench()
+{
+	printf "\n---------------------------------------------\n"
+	printf "*** Running tbench                        ***"
+	printf "\n---------------------------------------------\n"
+
+	pre_clear_tbench
+
+	get_lines_csv_tbench "Governor"
+	if [ $? -eq 0 ]; then
+		# add titles and unit for csv file
+		store_csv_tbench "Governor" "Round" "Des-perf" "Freq" "Load" "Performance" "Energy" "Performance Per Watt"
+		store_csv_tbench "Unit" "" "" "GHz" "" "MB/s" "J" "MB/J"
+	fi
+
+	backup_governor
+	for governor in ${tbench_governors[*]} ; do
+		printf "\nSpecified governor is $governor\n\n"
+		switch_governor $governor
+		loop_tbench $governor
+		gather_tbench $governor
+	done
+	restore_governor
+
+	plot_png_tbench "tbench_perfromance.png" "Tbench Benchmark Performance" "Performance" 6
+	plot_png_tbench "tbench_energy.png" "Tbench Benchmark Energy" "Energy (J)" 7
+	plot_png_tbench "tbench_ppw.png" "Tbench Benchmark Performance Per Watt" "Performance Per Watt (MB/J)" 8
+
+	calc_comp_tbench
+
+	post_clear_tbench
+}
-- 
2.34.1

