Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0219F6D19CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCaI1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCaI1k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:27:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7BB44C;
        Fri, 31 Mar 2023 01:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpuajdG+X4Sky6wLGdQ3NzBmRPthCbzGMOUNKC/qeI4WoL6jRoZx3Sbgj0TngkA4Zc8iyOrcD+ZLM6PO0UFQtESVZ76CNaRdOiwbjTuNzIQUCOD1oo+SDpLAg4hPvwiC/C5BiFpwtaoa8SsYaUd9Pc4fal4P25oVe0JDrJd6aClti16q/rxNnSrvGAxVKdzPCCMBWboOYUQpRjno9Xqzf/FuzCBRCYnbVlkzukCYl9+JGx+hRROeBCIMzMk1Ld0lXz35F0y4uUTv8zt5tXx1PnnlEiSwQgpzdy4RBEa2sErZPriufAASMKhuIistmfDRUgQhPTp8ZZXMFKp//y4akA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+LFsFcUzfSlFWvrwqo86BFI9ah4JmCB5vBhpOhV4Bo=;
 b=VGDqCHv0kB64TNT9nbi9aTuMNju4iDIWDGcaUphUsEbgUh1tKhTpfL0JNlUV05o1ilhqHDWhZt9Bjup/KEeKh7J7rtV5PXg5xxzi36c1wOVWohpgZoechl/8k+8w1y4ImzXxiSNoOxnEehTgDvkWnaReEPXBvK56Zc4uKY1xi7s0bYwDYsP+0Nqjyxlj3K0kCH69JPYKfhVh9lCwfMGzzQftTaC85ujgWwcJ+A1zvzNgASD3MAgyT4oppX3AB8ecjmXEOwhbDgTjKknOfXN+hpZrCTvnOUSU8Vozvz+35zfXdFbfDfp2WubM62JAV7HbbhVqs1YCdT/N9/vbfZgdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+LFsFcUzfSlFWvrwqo86BFI9ah4JmCB5vBhpOhV4Bo=;
 b=5rIIKLftEyRunuOhB+OfWoQMwDDAznxOGbec58twnwIjzX4R2nfrg3lXLdMKiLRCCCRhX05pIIGuOWFVJswqIzBggwE7JNNTqTkf96BHyKgNIyloaR0/HmCWmn2DvMOSypEuhUMdenu6SQAlgPpItjHKwDf/w5ZxZS2itOrcnKo=
Received: from BLAPR03CA0176.namprd03.prod.outlook.com (2603:10b6:208:32f::26)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 08:27:34 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::16) by BLAPR03CA0176.outlook.office365.com
 (2603:10b6:208:32f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 08:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.35 via Frontend Transport; Fri, 31 Mar 2023 08:27:34 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 03:27:29 -0500
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
Subject: [PATCH V3 1/2] selftests: amd-pstate: Trigger speedometer benchmark and test cpus
Date:   Fri, 31 Mar 2023 16:26:58 +0800
Message-ID: <20230331082659.1887946-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331082659.1887946-1-li.meng@amd.com>
References: <20230331082659.1887946-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|BL1PR12MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: c46f3b47-485a-45db-57a7-08db31c1c714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzDtfWACbaKb+Fg9/7RYhCtd6t3FmElZpH8K895sbb5Y5DPBf+PWnd7xnl5bT7dQrq9cTqo3P7V7fPs9mEBeyhXPvruHQNzFj1TxToeMLEvpKvWS6Dn3xiVgsATc5wf2Mj6fSYkw1N5RdzuvIALIQYFiK5fbUt9owIfWPkRdPCM1i66WAp8eC6ogDMf8UvTfeKyynejwpwyXDf5T6uQgpjMrp1ifjgp8lXqo7PW5CfeBqlTWtEXsB5PurQiUWMgRQ3sr/YL0aqgDimcAckYz4Fu4Fd8jfDQGhMKuwD6OAOIq8fJDKntOAsr42n/KfHRzM5zE1DyBJXTRhZcS1+KPVMkfEuNGPYR6vfzV78PFsYRQZpDpzK3LrezlMqdhbmdaeWFE0uGUn4BPo9JJIo5SI4ltO+71XnTYXCao7GRM/t03/fEQxoehEmR9fqLtL2IKO5IHwUKRtEWlOgdGIw1xPhsH708DufXgCh/nu3NXc0wBSWa86mpCQxWeImGYoIkYfm3VjBpl+NDYgmfAlGAxCDDLBJ+/xhmoFLKMMHiq8MiCPp5xHrxsZB8XkgUVJxlob8H/GmxS8QWPtSbRztovo9NCKffAXXFWQB/3fpUawL+eqdiwuR/86nstcoJOSN2aM1uXAzsr0sOEdrM2CyJiO7bkelnbAKB053BsV0jUTU2P8YVVWEXLu9Vw7sDBDXnRmeoikvsHqFIbtEgEepW/O4CW45w5S1izrUex2sHXq+g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(1076003)(40480700001)(186003)(16526019)(6666004)(82310400005)(8936002)(36860700001)(86362001)(30864003)(5660300002)(478600001)(110136005)(54906003)(70206006)(40460700003)(316002)(70586007)(47076005)(83380400001)(26005)(426003)(2616005)(66574015)(336012)(41300700001)(2906002)(82740400003)(81166007)(36756003)(4326008)(356005)(7696005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:27:34.1036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46f3b47-485a-45db-57a7-08db31c1c714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add speedometer.sh trigger the speedometer testing and monitor the cpu
desire performance, frequency, load, power consumption and throughput etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile   |  13 +-
 tools/testing/selftests/amd-pstate/run.sh     |  32 +-
 .../selftests/amd-pstate/selenium_server.sh   |  15 +
 .../selftests/amd-pstate/speedometer.sh       | 348 ++++++++++++++++++
 .../selftests/amd-pstate/speedometer_web.py   | 106 ++++++
 5 files changed, 504 insertions(+), 10 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/selenium_server.sh
 create mode 100755 tools/testing/selftests/amd-pstate/speedometer.sh
 create mode 100755 tools/testing/selftests/amd-pstate/speedometer_web.py

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 5fd1424db37d..13335c00239d 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,10 +4,15 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-TEST_PROGS := run.sh
-TEST_FILES := basic.sh tbench.sh gitsource.sh
+ifeq (x86,$(ARCH))
+TEST_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
+TEST_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+endif
+
+TEST_PROGS += run.sh
+TEST_FILES += basic.sh tbench.sh gitsource.sh speedometer.sh speedometer_web.py selenium_server.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index de4d8e9c9565..f29673528572 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -11,6 +11,7 @@ fi
 source basic.sh
 source tbench.sh
 source gitsource.sh
+source speedometer.sh
 
 # amd-pstate-ut only run on x86/x86_64 AMD systems.
 ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
@@ -21,6 +22,7 @@ FUNC=all
 OUTFILE=selftest
 OUTFILE_TBENCH="$OUTFILE.tbench"
 OUTFILE_GIT="$OUTFILE.gitsource"
+OUTFILE_SPEEDOMETER="$OUTFILE.speedometer"
 
 SYSFS=
 CPUROOT=
@@ -136,6 +138,9 @@ amd_pstate_all()
 
 	# gitsource
 	amd_pstate_gitsource
+
+	# speedometer
+	amd_pstate_speedometer
 }
 
 help()
@@ -146,10 +151,11 @@ help()
 	[-c <all: All testing,
 	     basic: Basic testing,
 	     tbench: Tbench testing,
-	     gitsource: Gitsource testing.>]
+	     gitsource: Gitsource testing,
+	     speedometer: Speedometer testing.>]
 	[-t <tbench time limit>]
 	[-p <tbench process number>]
-	[-l <loop times for tbench>]
+	[-l <loop times>]
 	[-i <amd tracer interval>]
 	[-m <comparative test: acpi-cpufreq>]
 	\n"
@@ -165,7 +171,7 @@ parse_arguments()
 				help
 				;;
 
-			c) # --func_type (Function to perform: basic, tbench, gitsource (default: all))
+			c) # --func_type (Function to perform: basic, tbench, gitsource, speedometer (default: all))
 				FUNC=$OPTARG
 				;;
 
@@ -181,7 +187,7 @@ parse_arguments()
 				PROCESS_NUM=$OPTARG
 				;;
 
-			l) # --tbench/gitsource-loop-times
+			l) # --tbench/gitsource/speedometer-loop-times
 				LOOP_TIMES=$OPTARG
 				;;
 
@@ -249,7 +255,7 @@ prerequisite()
 		fi
 	else
 		case "$FUNC" in
-			"tbench" | "gitsource")
+			"tbench" | "gitsource" | "speedometer")
 				if [ "$scaling_driver" != "$COMPARATIVE_TEST" ]; then
 					echo "$0 # Skipped: Comparison test can only run on $COMPARISON_TEST driver."
 					echo "$0 # Current cpufreq scaling driver is $scaling_driver."
@@ -258,7 +264,7 @@ prerequisite()
 				;;
 
 			*)
-				echo "$0 # Skipped: Comparison test are only for tbench or gitsource."
+				echo "$0 # Skipped: Comparison test are only for tbench, gitsource or speedometer."
 				echo "$0 # Current comparative test is for $FUNC."
 				exit $ksft_skip
 				;;
@@ -284,6 +290,10 @@ prerequisite()
 		"gitsource")
 			command_perf
 			;;
+
+		"speedometer")
+			command_perf
+			;;
 	esac
 
 	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
@@ -335,6 +345,10 @@ do_test()
 			amd_pstate_gitsource
 			;;
 
+		"speedometer")
+			amd_pstate_speedometer
+			;;
+
 		*)
 			echo "Invalid [-f] function type"
 			help
@@ -364,6 +378,12 @@ pre_clear_dumps()
 			rm -rf gitsource_*.png
 			;;
 
+		"speedometer")
+			rm -rf $OUTFILE.log
+			rm -rf $OUTFILE.backup_governor.log
+			rm -rf speedometer_*.png
+			;;
+
 		*)
 			;;
 	esac
diff --git a/tools/testing/selftests/amd-pstate/selenium_server.sh b/tools/testing/selftests/amd-pstate/selenium_server.sh
new file mode 100755
index 000000000000..d2cb5aeaea3f
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/selenium_server.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Before test speedometer benchmark, this script trigger selenium server.
+
+selenium_server_name="selenium-server.jar"
+selenium_server_url="https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.3.0/selenium-server-4.3.0.jar"
+
+if [ ! -f $selenium_server_name ]; then
+	printf "Download selenium server, please wait a moment ...\n\n"
+	wget -O $selenium_server_name $selenium_server_url
+fi
+
+printf "Run selenium server standalone ...\n\n"
+java -jar $selenium_server_name standalone --port 9515
diff --git a/tools/testing/selftests/amd-pstate/speedometer.sh b/tools/testing/selftests/amd-pstate/speedometer.sh
new file mode 100755
index 000000000000..ff86203cf651
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/speedometer.sh
@@ -0,0 +1,348 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Testing and monitor the cpu frequency and performance when
+# this script trigger speedometer test.
+
+# protect against multiple inclusion
+if [ $FILE_SPEEDOMETER ]; then
+	return 0
+else
+	FILE_SPEEDOMETER=DONE
+fi
+
+speedometer_governors=("ondemand" "schedutil")
+
+# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: goal, $7: time $8: energy, $9: PPW
+store_csv_speedometer()
+{
+	echo "$1, $2, $3, $4, $5, $6, $7, $8, $9" | tee -a $OUTFILE_SPEEDOMETER.csv > /dev/null 2>&1
+}
+
+# clear some special lines
+clear_csv_speedometer()
+{
+	if [ -f $OUTFILE_SPEEDOMETER.csv ]; then
+		sed -i '/Comprison(%)/d' $OUTFILE_SPEEDOMETER.csv
+		sed -i "/$(scaling_name)/d" $OUTFILE_SPEEDOMETER.csv
+	fi
+}
+
+# find string $1 in file csv and get the number of lines
+get_lines_csv_speedometer()
+{
+	if [ -f $OUTFILE_SPEEDOMETER.csv ]; then
+		return `grep -c "$1" $OUTFILE_SPEEDOMETER.csv`
+	else
+		return 0
+	fi
+}
+
+pre_clear_speedometer()
+{
+	post_clear_speedometer
+	rm -rf speedometer_*.png
+	clear_csv_speedometer
+}
+
+post_clear_speedometer()
+{
+	rm -rf results/tracer-speedometer*
+	rm -rf $OUTFILE_SPEEDOMETER*.log
+	rm -rf $OUTFILE_SPEEDOMETER*.result
+}
+
+# $1: governor, $2: loop
+run_speedometer()
+{
+	local_host="`hostname --fqdn`"
+	local_ip=`host $local_host 2>/dev/null | awk '{print $NF}'`
+
+	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
+	./amd_pstate_trace.py -n tracer-speedometer-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
+
+	echo "Run speedometer for $1 #$2"
+	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ > $OUTFILE_SPEEDOMETER-perf-$1-$2.log 2>&1 & pid_perf=$!
+	./speedometer_web.py -i $local_ip -n $OUTFILE_SPEEDOMETER-web-$1-$2.log
+
+	kill $pid_perf
+	for job in `jobs -p`
+	do
+		echo "Waiting for job id $job"
+		wait $job
+	done
+}
+
+# $1: governor, $2: loop
+parse_speedometer()
+{
+	awk '{print $5}' results/tracer-speedometer-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_SPEEDOMETER-des-perf-$1-$2.log
+	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_SPEEDOMETER-des-perf-$1-$2.log)
+	printf "Speedometer-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	awk '{print $7}' results/tracer-speedometer-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_SPEEDOMETER-freq-$1-$2.log
+	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_SPEEDOMETER-freq-$1-$2.log)
+	printf "Speedometer-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	awk '{print $11}' results/tracer-speedometer-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_SPEEDOMETER-load-$1-$2.log
+	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_SPEEDOMETER-load-$1-$2.log)
+	printf "Speedometer-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	awk '{print $1}' $OUTFILE_SPEEDOMETER-web-$1-$2.log > $OUTFILE_SPEEDOMETER-time-$1-$2.log
+	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_SPEEDOMETER-time-$1-$2.log)
+	printf "Speedometer-$1-#$2 user time(s): $time_sum\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	awk '{print $2}' $OUTFILE_SPEEDOMETER-web-$1-$2.log > $OUTFILE_SPEEDOMETER-goal-$1-$2.log
+	goal_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_SPEEDOMETER-goal-$1-$2.log)
+	printf "Speedometer-$1-#$2 goal: $goal_sum\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	grep Joules $OUTFILE_SPEEDOMETER-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_SPEEDOMETER-energy-$1-$2.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_SPEEDOMETER-energy-$1-$2.log)
+	printf "Speedometer-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	# Performance is runs per second, denoted G/60, where G is runs per minute.
+	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# and t is time measured in seconds(s). This means that performance per watt becomes
+	#        G/60    G/60    Gt
+	#       ----- = ----- = -----
+	#         P      E/t    60*E
+	# with unit given by runs per watt.
+	ppw=`echo "scale=4;$goal_sum*$time_sum/($en_sum*60)" | bc | awk '{printf "%.4f", $0}'`
+	printf "Speedometer-$1 performance per watt(goal/w): $ppw\n" | tee -a $OUTFILE_SPEEDOMETER.result
+	printf "\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	driver_name=`echo $(scaling_name)`
+	store_csv_speedometer "$driver_name-$1" $2 $avg_des_perf $avg_freq $avg_load $goal_sum $time_sum $en_sum $ppw
+}
+
+# $1: governor
+loop_speedometer()
+{
+	printf "\nSpeedometer total test times is $LOOP_TIMES for $1\n\n"
+	for i in `seq 1 $LOOP_TIMES`
+	do
+		run_speedometer $1 $i
+		parse_speedometer $1 $i
+	done
+}
+
+# $1: governor
+gather_speedometer()
+{
+	printf "Speedometer test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_SPEEDOMETER.result
+	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	grep "Speedometer-$1-#" $OUTFILE_SPEEDOMETER.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_SPEEDOMETER-des-perf-$1.log
+	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_SPEEDOMETER-des-perf-$1.log)
+	printf "Speedometer-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	grep "Speedometer-$1-#" $OUTFILE_SPEEDOMETER.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_SPEEDOMETER-freq-$1.log
+	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_SPEEDOMETER-freq-$1.log)
+	printf "Speedometer-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	grep "Speedometer-$1-#" $OUTFILE_SPEEDOMETER.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_SPEEDOMETER-load-$1.log
+	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_SPEEDOMETER-load-$1.log)
+	printf "Speedometer-$1 avg load: $avg_load\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	grep "Speedometer-$1-#" $OUTFILE_SPEEDOMETER.result | grep "goal:" | awk '{print $NF}' > $OUTFILE_SPEEDOMETER-goal-$1.log
+	avg_goal=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_SPEEDOMETER-goal-$1.log)
+	printf "Speedometer-$1 avg goal: $avg_goal\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	grep "Speedometer-$1-#" $OUTFILE_SPEEDOMETER.result | grep "user time(s):" | awk '{print $NF}' > $OUTFILE_SPEEDOMETER-time-$1.log
+	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_SPEEDOMETER-time-$1.log)
+	printf "Speedometer-$1 total user time(s): $time_sum\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	avg_time=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_SPEEDOMETER-time-$1.log)
+	printf "Speedometer-$1 avg user times(s): $avg_time\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	grep "Speedometer-$1-#" $OUTFILE_SPEEDOMETER.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_SPEEDOMETER-energy-$1.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_SPEEDOMETER-energy-$1.log)
+	printf "Speedometer-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_SPEEDOMETER-energy-$1.log)
+	printf "Speedometer-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	# Permance is runs per second, denoted G/60, where G is runs per minute.
+	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# and t is time measured in seconds(s). This means that performance per watt becomes
+	#        G/60    G/60    Gt
+	#       ----- = ----- = -----
+	#         P      E/t    60*E
+	# with unit given by runs per wattt.
+	ppw=`echo "scale=4;$avg_goal*$avg_time/($avg_en*60)" | bc | awk '{printf "%.4f", $0}'`
+	printf "Speedometer-$1 performance per watt(goal/w): $ppw\n" | tee -a $OUTFILE_SPEEDOMETER.result
+	printf "\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+	driver_name=`echo $(scaling_name)`
+	store_csv_speedometer "$driver_name-$1" "Average" $avg_des_perf $avg_freq $avg_load $avg_goal $avg_time $avg_en $ppw
+}
+
+# $1: base scaling_driver $2: base governor $3: comparison scaling_driver $4: comparison governor
+__calc_comp_speedometer()
+{
+	base=`grep "$1-$2" $OUTFILE_SPEEDOMETER.csv | grep "Average"`
+	comp=`grep "$3-$4" $OUTFILE_SPEEDOMETER.csv | grep "Average"`
+
+	if [ -n "$base" -a -n "$comp" ]; then
+		printf "\n==================================================\n" | tee -a $OUTFILE_SPEEDOMETER.result
+		printf "Speedometer comparison $1-$2 VS $3-$4" | tee -a $OUTFILE_SPEEDOMETER.result
+		printf "\n==================================================\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+		# get the base values
+		des_perf_base=`echo "$base" | awk '{print $3}' | sed s/,//`
+		freq_base=`echo "$base" | awk '{print $4}' | sed s/,//`
+		load_base=`echo "$base" | awk '{print $5}' | sed s/,//`
+		goal_base=`echo "$base" | awk '{print $6}' | sed s/,//`
+		time_base=`echo "$base" | awk '{print $7}' | sed s/,//`
+		energy_base=`echo "$base" | awk '{print $8}' | sed s/,//`
+		ppw_base=`echo "$base" | awk '{print $9}' | sed s/,//`
+
+		# get the comparison values
+		des_perf_comp=`echo "$comp" | awk '{print $3}' | sed s/,//`
+		freq_comp=`echo "$comp" | awk '{print $4}' | sed s/,//`
+		load_comp=`echo "$comp" | awk '{print $5}' | sed s/,//`
+		goal_comp=`echo "$comp" | awk '{print $6}' | sed s/,//`
+		time_comp=`echo "$comp" | awk '{print $7}' | sed s/,//`
+		energy_comp=`echo "$comp" | awk '{print $8}' | sed s/,//`
+		ppw_comp=`echo "$comp" | awk '{print $9}' | sed s/,//`
+
+		# compare the base and comp values
+		des_perf_drop=`echo "scale=4;($des_perf_comp-$des_perf_base)*100/$des_perf_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Speedometer-$1 des perf base: $des_perf_base comprison: $des_perf_comp percent: $des_perf_drop\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+		freq_drop=`echo "scale=4;($freq_comp-$freq_base)*100/$freq_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Speedometer-$1 freq base: $freq_base comprison: $freq_comp percent: $freq_drop\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+		load_drop=`echo "scale=4;($load_comp-$load_base)*100/$load_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Speedometer-$1 load base: $load_base comprison: $load_comp percent: $load_drop\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+		time_drop=`echo "scale=4;($time_comp-$time_base)*100/$time_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Speedometer-$1 time base: $time_base comprison: $time_comp percent: $time_drop\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+		goal_drop=`echo "scale=4;($goal_comp-$goal_base)*100/$goal_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Speedometer-$1 goal base: $goal_base comprison: $goal_comp percent: $goal_drop\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+		energy_drop=`echo "scale=4;($energy_comp-$energy_base)*100/$energy_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Speedometer-$1 energy base: $energy_base comprison: $energy_comp percent: $energy_drop\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+		ppw_drop=`echo "scale=4;($ppw_comp-$ppw_base)*100/$ppw_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Speedometer-$1 performance per watt base: $ppw_base comprison: $ppw_comp percent: $ppw_drop\n" | tee -a $OUTFILE_SPEEDOMETER.result
+		printf "\n" | tee -a $OUTFILE_SPEEDOMETER.result
+
+		store_csv_speedometer "$1-$2 VS $3-$4" "Comprison(%)" "$des_perf_drop" "$freq_drop" "$load_drop" "$goal_drop" "$time_drop" "$energy_drop" "$ppw_drop"
+	fi
+}
+
+# calculate the comparison(%)
+calc_comp_speedometer()
+{
+	# acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil
+	__calc_comp_speedometer ${all_scaling_names[0]} ${speedometer_governors[0]} ${all_scaling_names[0]} ${speedometer_governors[1]}
+
+	# amd-pstate-ondemand VS amd-pstate-schedutil
+	__calc_comp_speedometer ${all_scaling_names[1]} ${speedometer_governors[0]} ${all_scaling_names[1]} ${speedometer_governors[1]}
+
+	# acpi-cpufreq-ondemand VS amd-pstate-ondemand
+	__calc_comp_speedometer ${all_scaling_names[0]} ${speedometer_governors[0]} ${all_scaling_names[1]} ${speedometer_governors[0]}
+
+	# acpi-cpufreq-schedutil VS amd-pstate-schedutil
+	__calc_comp_speedometer ${all_scaling_names[0]} ${speedometer_governors[1]} ${all_scaling_names[1]} ${speedometer_governors[1]}
+}
+
+# $1: file_name, $2: title, $3: ylable, $4: column
+plot_png_speedometer()
+{
+	# all_scaling_names[1] all_scaling_names[0] flag
+	#    amd-pstate           acpi-cpufreq
+	#         N                   N             0
+	#         N                   Y             1
+	#         Y                   N             2
+	#         Y                   Y             3
+	ret=`grep -c "${all_scaling_names[1]}" $OUTFILE_SPEEDOMETER.csv`
+	if [ $ret -eq 0 ]; then
+		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_SPEEDOMETER.csv`
+		if [ $ret -eq 0 ]; then
+			flag=0
+		else
+			flag=1
+		fi
+	else
+		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_SPEEDOMETER.csv`
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
+			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${speedometer_governors[0]}/p' $OUTFILE_SPEEDOMETER.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${speedometer_governors[0]}", \
+			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${speedometer_governors[1]}/p' $OUTFILE_SPEEDOMETER.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${speedometer_governors[1]}"
+		} else {
+			if ($flag == 2) {
+				plot \
+				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${speedometer_governors[0]}/p' $OUTFILE_SPEEDOMETER.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${speedometer_governors[0]}", \
+				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${speedometer_governors[1]}/p' $OUTFILE_SPEEDOMETER.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${speedometer_governors[1]}"
+			} else {
+				if ($flag == 3 ) {
+					plot \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${speedometer_governors[0]}/p' $OUTFILE_SPEEDOMETER.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${speedometer_governors[0]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${speedometer_governors[1]}/p' $OUTFILE_SPEEDOMETER.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${speedometer_governors[1]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${speedometer_governors[0]}/p' $OUTFILE_SPEEDOMETER.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${speedometer_governors[0]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${speedometer_governors[1]}/p' $OUTFILE_SPEEDOMETER.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${speedometer_governors[1]}"
+				}
+			}
+		}
+		quit
+EOF
+}
+
+amd_pstate_speedometer()
+{
+	echo "!!!*** Please make sure to run selenium_server.sh on the server before you start testing speedometer. ***!!!"
+
+	printf "\n---------------------------------------------\n"
+	printf "*** Running speedometer                   ***"
+	printf "\n---------------------------------------------\n"
+
+	pre_clear_speedometer
+
+	get_lines_csv_speedometer "Governor"
+	if [ $? -eq 0 ]; then
+		# add titles and unit for csv file
+		store_csv_speedometer "Governor" "Round" "Des-perf" "Freq" "Load" "Goal" "Time" "Energy" "Performance Per Watt"
+		store_csv_speedometer "Unit" "" "" "GHz" "" "Runs/Minute" "s" "J" "Runs/w"
+	fi
+
+	backup_governor
+	for governor in ${speedometer_governors[*]} ; do
+		printf "\nSpecified governor is $governor\n\n"
+		switch_governor $governor
+		loop_speedometer $governor
+		gather_speedometer $governor
+	done
+	restore_governor
+
+	plot_png_speedometer "speedometer_goal.png" "Speedometer Goal" "Goal (Runs/Minute)" 6
+	plot_png_speedometer "speedometer_time.png" "Speedometer Time" "Time (s)" 7
+	plot_png_speedometer "speedometer_energy.png" "Speedometer Energy" "Energy (J)" 8
+	plot_png_speedometer "speedometer_ppw.png" "Speedometer Performance Per Watt" "Performance Per Watt (Runs/W)" 9
+
+	calc_comp_speedometer
+
+	post_clear_speedometer
+}
diff --git a/tools/testing/selftests/amd-pstate/speedometer_web.py b/tools/testing/selftests/amd-pstate/speedometer_web.py
new file mode 100755
index 000000000000..2f969e261ed6
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/speedometer_web.py
@@ -0,0 +1,106 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0-only
+# -*- coding: utf-8 -*-
+#
+""" This utility can be used to run speedometer.
+
+Prerequisites:
+    Python version 3.0.x or higher
+    chromium-browser
+    chromium-chromedriver
+    selenium
+    selenium-server
+
+    see print_help(): for Usage and Output details
+
+"""
+
+from selenium import webdriver
+from selenium.webdriver.chrome.options import Options
+from selenium.webdriver.common.by import By
+from selenium.webdriver.remote import webelement
+from time import sleep
+import os
+import sys
+import getopt
+
+test_result = False
+ip_addr = ""
+file_name = ""
+
+def print_help():
+    print('speedometer_web.py:')
+    print('  Usage:')
+    print('    To generate speedometer test result file, parse and plot, use:')
+    print('      ./speedometer_web.py -i <ip_addr> -n <test_name>')
+
+def store_data_file(time, result_text):
+    """ Store speedometer test results """
+
+    try:
+        f_handle = open(file_name, 'a')
+        str_buffer = "%u %s" % (time, result_text)
+        f_handle.write(str_buffer)
+        f_handle.close()
+    except:
+        print('IO error', file_name)
+        return
+
+def remove_data_file():
+    """ Remove data files """
+
+    if os.path.exists(file_name):
+        os.remove(file_name)
+
+if __name__ == "__main__":
+
+    valid1 = False
+    valid2 = False
+
+    try:
+        opts, args = getopt.getopt(sys.argv[1:],"hn:i:",["help","name="])
+    except getopt.GetoptError:
+        print_help()
+        sys.exit(2)
+    for opt, arg in opts:
+        if opt == '-h':
+            print_help()
+            sys.exit()
+        elif opt in ("-i", "--ip"):
+            valid1 = True
+            ip_addr = arg
+        elif opt in ("-n", "--name"):
+            valid2 = True
+            file_name = arg
+
+    if (valid1 and valid2) :
+        chrome_options = Options()
+        chrome_options.add_argument('--no-sandbox')
+        chrome_options.add_argument('--incognito')
+
+        driver = webdriver.Remote(command_executor='http://{}:9515/wd/hub'.format(ip_addr), options=chrome_options)
+
+        driver.get('https://browserbench.org/Speedometer2.0/')
+        sleep(1)
+
+        driver.find_element(By.XPATH,"//div[@class='buttons']/button").click()
+        for i in range(0, 200, +1):
+            print("\rRun speedometer: \033[0;31m{:2}\033[0ms".format(i), end="", flush=True)
+            sleep(1)
+            if i > 50:
+                result = driver.find_element(By.XPATH,"//div[@id='result-number']")
+                if result.text:
+                    test_result = True
+                    print("\nTest result: " + result.text)
+                    remove_data_file()
+                    store_data_file(i, result.text)
+                    break
+
+        if test_result == False:
+            print("\nTest fail, please test again!")
+
+        driver.quit()
+    else:
+        print_help()
+        sys.exit()
+
-- 
2.34.1

