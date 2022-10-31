Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D16131F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 09:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJaIuU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJaIuM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 04:50:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5794765C0;
        Mon, 31 Oct 2022 01:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH0Yk7IqZHgw1TlLTlSdzdJNqQYAucyil2BoAtLGswIZ0q6yCki/Sq2Xn5BnMpyjE4fdkIkaZYF5P9wqZMVrN0Q02AxBwb9DmlThcNhQlcgTyNY5i0ZkV4LJLK+KPdq23nggPkffYGdRomLkGuswX9kiO/s1ugUdvEVr5MCS4dipuu3+xueVDvgKDYG42s/7yqlJctRuhUZgC4eTVDPTyKeYBz5C4QRmSPA5FQIzW2zCG3U6lW8zj1xKH7oI97hc6gsBlxSG55LOpkUwu3USoOVaDrclxs4G1Tq803cwGgPKP0C+iLx6MCC7uDPcMpQpa476H8ARhJ252XnKPwuIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C1p61J+ySmWLuVcSzHaIrriFSPDdlSOUnhsDKPEy+4=;
 b=PVIYfEg1gNLMS/Yg1I1msLxv+SE+s5KIBPpnTotOpFbHW/dCgJl2NhhfjeHN2HiiAJqiZc8cDFb9E5O1oXO75YjVfmVd3KhMx7PAp3tfquVru9fsmylAlqviG2u/b0HU2LpW67LCKlq6xM5KcHkQ5pMTEXdRus3ccuGP2FlgOQWBS8KjCQNy/fTqZWnYDNwvxqyVRaF6OcqjZIB5M1BFUaPdFQ0uWpwPyA9RE/durKzNiCbkSgkuZ9bDh9zkw70/vFic5y+6UnDTo6+UaXZG9hvTkhSuS2XBFK3qZfiku4cW7AjivZGpaMuzua2OVJ/fhPAxAko5zDHSf6rRJX8SrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C1p61J+ySmWLuVcSzHaIrriFSPDdlSOUnhsDKPEy+4=;
 b=tUdBSDSGZHNRZRAUmevdj+wbCQm+0qawbWP57ECbjZMXGlNkmgmCHmjKMeUkuAcMVAWQfsqN2z24C3Aq0Ouuc7hdulynYn9zQKfnyxNNaMJjM4d6nnAhK94GEMdybODnLIprUxkSm/shdYbdgYgHB7xNvIKi321Ozoksl6YHCPI=
Received: from DS7PR03CA0360.namprd03.prod.outlook.com (2603:10b6:8:55::33) by
 BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Mon, 31 Oct 2022 08:50:06 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::e4) by DS7PR03CA0360.outlook.office365.com
 (2603:10b6:8:55::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 08:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.17 via Frontend Transport; Mon, 31 Oct 2022 08:50:06 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 03:50:01 -0500
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
Subject: [PATCH V5 4/5] selftests: amd-pstate: Trigger gitsource benchmark and test cpus
Date:   Mon, 31 Oct 2022 16:49:23 +0800
Message-ID: <20221031084924.1742169-5-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|BN9PR12MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: f70fca35-8e2d-4a29-eb7f-08dabb1ce8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6oK72rnpeN9NwN7IqsNNFdvCDCBb/I6udpET/a/w9Zd8jXz8P1nL64WWYLyHZQZduV7MCP8tETpS+i5Ge+ffksqUYhM9Xyr+Sj8sdZTE39rxdvAYTviAUq+HZQpYxTh02CX7Oa1g7Qzrdk39BdbESvtpWccSjx7t3r2CBnvQFUe1SIYXz3Z6ahliXts5+eqMaT0XFWCbRhT13+O6SGHri+Oa/oLN+0Ov5sI/hfhBkNvndAks62PPW0toVg8ZrJS/DmQ0PoYZWhtlnWZwwzxeLJqEezoKda53Fy0yUNadHzzn6D6Ve1ELUGcXm/QGgZS9S8M+gTsAyrRJsLq9oPtqhDBJ6VuD9dGZnRV+K2maM/Ycg7JHlsQ4Z6gIwarM0SDHnrVi4x0zYgnX9QbH3oQoqsdIGyXhfu8xB/62UIM5bBI5p5CPS+xyoAHWYWHEMMy3MS+fdJf+9u35ceKSqSgfZRV/5CzaCALrPvyYXJiXIrja58cTNCRfNcSuNsSpUmeMyAu9UuMqGSLHG/iLxgQs3UqW8n5L4HH8xf782RdA2P3fEy3SdbXfdXqMQG3r4efvXmLrQNxWNM40htMGTTeKJ95b3m1LO9FW5j2vC/5T6nw4E+tqZXdYdFefqc6/uAkcbR6e0umgz2BVoZ/+DYQ30rLQeS90PmsBXtUsmr3zDBZwWiirc+1c403zfSHcroDBDsi5PvKp3lpW7BpOYF1Us0WRZ4rqxqeNrUIAHWBVgyNgPHH3oY+F1Ap1/oZ7QSU8jgXvi+M4/QKdCSfKn/eTfqXTDI4/acpiiV8qvBRHAahLI/MQ9hMiKzmcYTW3SrfohhDodk4n/LxG0lWeU5M+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(336012)(83380400001)(47076005)(426003)(40460700003)(6666004)(30864003)(2906002)(36756003)(356005)(81166007)(40480700001)(86362001)(82740400003)(82310400005)(26005)(16526019)(1076003)(2616005)(70206006)(36860700001)(186003)(70586007)(316002)(8676002)(4326008)(478600001)(8936002)(5660300002)(41300700001)(7696005)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 08:50:06.1943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70fca35-8e2d-4a29-eb7f-08dabb1ce8a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add gitsource.sh trigger the gitsource testing and monitor the cpu desire
performance, frequency, load, power consumption and throughput etc.
1) Download and tar gitsource codes.
2) Run gitsource benchmark on specific governors, ondemand or schedutil.
3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
4) Get desire performance, frequency, load by perf.
5) Get power consumption and throughput by amd_pstate_trace.py.
6) Get run time by /usr/bin/time.
7) Analyse test results and save it in file selftest.gitsource.csv.
8) Plot png images about time, energy and performance per watt
for each test.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile   |   2 +-
 .../testing/selftests/amd-pstate/gitsource.sh | 354 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/run.sh     |  32 +-
 3 files changed, 381 insertions(+), 7 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index cac8dedb7226..5f195ee756d6 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -13,6 +13,6 @@ TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
 endif
 
 TEST_PROGS := run.sh
-TEST_FILES := basic.sh tbench.sh
+TEST_FILES := basic.sh tbench.sh gitsource.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
new file mode 100755
index 000000000000..4cadbfe8c058
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -0,0 +1,354 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Testing and monitor the cpu desire performance, frequency, load,
+# power consumption and throughput etc. when this script trigger 
+# gitsource test.
+# 1) Download and tar gitsource codes.
+# 2) Run gitsource benchmark on specific governors, ondemand or schedutil.
+# 3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
+# 4) Get desire performance, frequency, load by perf.
+# 5) Get power consumption and throughput by amd_pstate_trace.py.
+# 6) Get run time by /usr/bin/time.
+# 7) Analyse test results and save it in file selftest.gitsource.csv.
+#8) Plot png images about time, energy and performance per watt for each test.
+
+# protect against multiple inclusion
+if [ $FILE_GITSOURCE ]; then
+	return 0
+else
+	FILE_GITSOURCE=DONE
+fi
+
+git_name="git-2.15.1"
+git_tar="$git_name.tar.gz"
+gitsource_url="https://github.com/git/git/archive/refs/tags/v2.15.1.tar.gz"
+gitsource_governors=("ondemand" "schedutil")
+
+# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: time $7: energy, $8: PPW
+store_csv_gitsource()
+{
+	echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_GIT.csv > /dev/null 2>&1
+}
+
+# clear some special lines
+clear_csv_gitsource()
+{
+	if [ -f $OUTFILE_GIT.csv ]; then
+		sed -i '/Comprison(%)/d' $OUTFILE_GIT.csv
+		sed -i "/$(scaling_name)/d" $OUTFILE_GIT.csv
+	fi
+}
+
+# find string $1 in file csv and get the number of lines
+get_lines_csv_gitsource()
+{
+	if [ -f $OUTFILE_GIT.csv ]; then
+		return `grep -c "$1" $OUTFILE_GIT.csv`
+	else
+		return 0
+	fi
+}
+
+pre_clear_gitsource()
+{
+	post_clear_gitsource
+	rm -rf gitsource_*.png
+	clear_csv_gitsource
+}
+
+post_clear_gitsource()
+{
+	rm -rf results/tracer-gitsource*
+	rm -rf $OUTFILE_GIT*.log
+	rm -rf $OUTFILE_GIT*.result
+}
+
+install_gitsource()
+{
+	if [ ! -d $git_name ]; then
+		printf "Download gitsource, please wait a moment ...\n\n"
+		wget -O $git_tar $gitsource_url > /dev/null 2>&1
+
+		printf "Tar gitsource ...\n\n"
+		tar -xzf $git_tar
+	fi
+}
+
+# $1: governor, $2: loop
+run_gitsource()
+{
+	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
+	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
+
+	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
+	cd $git_name
+	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
+	cd ..
+
+	for job in `jobs -p`
+	do
+		echo "Waiting for job id $job"
+		wait $job
+	done
+}
+
+# $1: governor, $2: loop
+parse_gitsource()
+{
+	awk '{print $5}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-des-perf-$1-$2.log
+	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-des-perf-$1-$2.log)
+	printf "Gitsource-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_GIT.result
+
+	awk '{print $7}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-freq-$1-$2.log
+	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-freq-$1-$2.log)
+	printf "Gitsource-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_GIT.result
+
+	awk '{print $11}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-load-$1-$2.log
+	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-load-$1-$2.log)
+	printf "Gitsource-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_GIT.result
+
+	grep user $OUTFILE_GIT.time-gitsource-$1-$2.log | awk '{print $1}' | sed -e 's/user//' > $OUTFILE_GIT-time-$1-$2.log
+	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-time-$1-$2.log)
+	printf "Gitsource-$1-#$2 user time(s): $time_sum\n" | tee -a $OUTFILE_GIT.result
+
+	grep Joules $OUTFILE_GIT-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_GIT-energy-$1-$2.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1-$2.log)
+	printf "Gitsource-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
+
+	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
+	# senconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# and t is time measured in seconds(s). This means that performance per watt becomes
+	#        1/t     1/t     1
+	#       ----- = ----- = ---
+	#         P      E/t     E
+	# with unit given by 1 per joule.
+	ppw=`echo "scale=9;1/$en_sum" | bc | awk '{printf "%.9f", $0}'`
+	printf "Gitsource-$1-#$2 performance per watt(1/J): $ppw\n" | tee -a $OUTFILE_GIT.result
+	printf "\n" | tee -a $OUTFILE_GIT.result
+
+	driver_name=`echo $(scaling_name)`
+	store_csv_gitsource "$driver_name-$1" $2 $avg_des_perf $avg_freq $avg_load $time_sum $en_sum $ppw
+}
+
+# $1: governor
+loop_gitsource()
+{
+	printf "\nGitsource total test times is $LOOP_TIMES for $1\n\n"
+	for i in `seq 1 $LOOP_TIMES`
+	do
+		run_gitsource $1 $i
+		parse_gitsource $1 $i
+	done
+}
+
+# $1: governor
+gather_gitsource()
+{
+	printf "Gitsource test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_GIT.result
+	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_GIT-des-perf-$1.log
+	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-des-perf-$1.log)
+	printf "Gitsource-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_GIT-freq-$1.log
+	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-freq-$1.log)
+	printf "Gitsource-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_GIT-load-$1.log
+	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-load-$1.log)
+	printf "Gitsource-$1 avg load: $avg_load\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "user time(s):" | awk '{print $NF}' > $OUTFILE_GIT-time-$1.log
+	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-time-$1.log)
+	printf "Gitsource-$1 total user time(s): $time_sum\n" | tee -a $OUTFILE_GIT.result
+
+	avg_time=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-time-$1.log)
+	printf "Gitsource-$1 avg user times(s): $avg_time\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_GIT-energy-$1.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1.log)
+	printf "Gitsource-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
+
+	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-energy-$1.log)
+	printf "Gitsource-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_GIT.result
+
+	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
+	# senconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# and t is time measured in seconds(s). This means that performance per watt becomes
+	#        1/t     1/t     1
+	#       ----- = ----- = ---
+	#         P      E/t     E
+	# with unit given by 1 per joule.
+	ppw=`echo "scale=9;1/$avg_en" | bc | awk '{printf "%.9f", $0}'`
+	printf "Gitsource-$1 performance per watt(1/J): $ppw\n" | tee -a $OUTFILE_GIT.result
+	printf "\n" | tee -a $OUTFILE_GIT.result
+
+	driver_name=`echo $(scaling_name)`
+	store_csv_gitsource "$driver_name-$1" "Average" $avg_des_perf $avg_freq $avg_load $avg_time $avg_en $ppw
+}
+
+# $1: base scaling_driver $2: base governor $3: comparison scaling_driver $4: comparison governor
+__calc_comp_gitsource()
+{
+	base=`grep "$1-$2" $OUTFILE_GIT.csv | grep "Average"`
+	comp=`grep "$3-$4" $OUTFILE_GIT.csv | grep "Average"`
+
+	if [ -n "$base" -a -n "$comp" ]; then
+		printf "\n==================================================\n" | tee -a $OUTFILE_GIT.result
+		printf "Gitsource comparison $1-$2 VS $3-$4" | tee -a $OUTFILE_GIT.result
+		printf "\n==================================================\n" | tee -a $OUTFILE_GIT.result
+
+		# get the base values
+		des_perf_base=`echo "$base" | awk '{print $3}' | sed s/,//`
+		freq_base=`echo "$base" | awk '{print $4}' | sed s/,//`
+		load_base=`echo "$base" | awk '{print $5}' | sed s/,//`
+		time_base=`echo "$base" | awk '{print $6}' | sed s/,//`
+		energy_base=`echo "$base" | awk '{print $7}' | sed s/,//`
+		ppw_base=`echo "$base" | awk '{print $8}' | sed s/,//`
+
+		# get the comparison values
+		des_perf_comp=`echo "$comp" | awk '{print $3}' | sed s/,//`
+		freq_comp=`echo "$comp" | awk '{print $4}' | sed s/,//`
+		load_comp=`echo "$comp" | awk '{print $5}' | sed s/,//`
+		time_comp=`echo "$comp" | awk '{print $6}' | sed s/,//`
+		energy_comp=`echo "$comp" | awk '{print $7}' | sed s/,//`
+		ppw_comp=`echo "$comp" | awk '{print $8}' | sed s/,//`
+
+		# compare the base and comp values
+		des_perf_drop=`echo "scale=4;($des_perf_comp-$des_perf_base)*100/$des_perf_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 des perf base: $des_perf_base comprison: $des_perf_comp percent: $des_perf_drop\n" | tee -a $OUTFILE_GIT.result
+
+		freq_drop=`echo "scale=4;($freq_comp-$freq_base)*100/$freq_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 freq base: $freq_base comprison: $freq_comp percent: $freq_drop\n" | tee -a $OUTFILE_GIT.result
+
+		load_drop=`echo "scale=4;($load_comp-$load_base)*100/$load_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 load base: $load_base comprison: $load_comp percent: $load_drop\n" | tee -a $OUTFILE_GIT.result
+
+		time_drop=`echo "scale=4;($time_comp-$time_base)*100/$time_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 time base: $time_base comprison: $time_comp percent: $time_drop\n" | tee -a $OUTFILE_GIT.result
+
+		energy_drop=`echo "scale=4;($energy_comp-$energy_base)*100/$energy_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 energy base: $energy_base comprison: $energy_comp percent: $energy_drop\n" | tee -a $OUTFILE_GIT.result
+
+		ppw_drop=`echo "scale=4;($ppw_comp-$ppw_base)*100/$ppw_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 performance per watt base: $ppw_base comprison: $ppw_comp percent: $ppw_drop\n" | tee -a $OUTFILE_GIT.result
+		printf "\n" | tee -a $OUTFILE_GIT.result
+
+		store_csv_gitsource "$1-$2 VS $3-$4" "Comprison(%)" "$des_perf_drop" "$freq_drop" "$load_drop" "$time_drop" "$energy_drop" "$ppw_drop"
+	fi
+}
+
+# calculate the comparison(%)
+calc_comp_gitsource()
+{
+	# acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil
+	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[0]} ${all_scaling_names[0]} ${gitsource_governors[1]}
+
+	# amd-pstate-ondemand VS amd-pstate-schedutil
+	__calc_comp_gitsource ${all_scaling_names[1]} ${gitsource_governors[0]} ${all_scaling_names[1]} ${gitsource_governors[1]}
+
+	# acpi-cpufreq-ondemand VS amd-pstate-ondemand
+	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[0]} ${all_scaling_names[1]} ${gitsource_governors[0]}
+
+	# acpi-cpufreq-schedutil VS amd-pstate-schedutil
+	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[1]} ${all_scaling_names[1]} ${gitsource_governors[1]}
+}
+
+# $1: file_name, $2: title, $3: ylable, $4: column
+plot_png_gitsource()
+{
+	# all_scaling_names[1] all_scaling_names[0] flag
+	#    amd-pstate           acpi-cpufreq
+	#         N                   N             0
+	#         N                   Y             1
+	#         Y                   N             2
+	#         Y                   Y             3
+	ret=`grep -c "${all_scaling_names[1]}" $OUTFILE_GIT.csv`
+	if [ $ret -eq 0 ]; then
+		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_GIT.csv`
+		if [ $ret -eq 0 ]; then
+			flag=0
+		else
+			flag=1
+		fi
+	else
+		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_GIT.csv`
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
+			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[0]}", \
+			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[1]}"
+		} else {
+			if ($flag == 2) {
+				plot \
+				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[0]}", \
+				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[1]}"
+			} else {
+				if ($flag == 3 ) {
+					plot \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[0]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[1]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[0]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[1]}"
+				}
+			}
+		}
+		quit
+EOF
+}
+
+amd_pstate_gitsource()
+{
+	printf "\n---------------------------------------------\n"
+	printf "*** Running gitsource                     ***"
+	printf "\n---------------------------------------------\n"
+
+	pre_clear_gitsource
+
+	install_gitsource
+
+	get_lines_csv_gitsource "Governor"
+	if [ $? -eq 0 ]; then
+		# add titles and unit for csv file
+		store_csv_gitsource "Governor" "Round" "Des-perf" "Freq" "Load" "Time" "Energy" "Performance Per Watt"
+		store_csv_gitsource "Unit" "" "" "GHz" "" "s" "J" "1/J"
+	fi
+
+	backup_governor
+	for governor in ${gitsource_governors[*]} ; do
+		printf "\nSpecified governor is $governor\n\n"
+		switch_governor $governor
+		loop_gitsource $governor
+		gather_gitsource $governor
+	done
+	restore_governor
+
+	plot_png_gitsource "gitsource_time.png" "Gitsource Benchmark Time" "Time (s)" 6
+	plot_png_gitsource "gitsource_energy.png" "Gitsource Benchmark Energy" "Energy (J)" 7
+	plot_png_gitsource "gitsource_ppw.png" "Gitsource Benchmark Performance Per Watt" "Performance Per Watt (1/J)" 8
+
+	calc_comp_gitsource
+
+	post_clear_gitsource
+}
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index e7e98068a03b..57cad57e59c0 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -10,6 +10,7 @@ fi
 
 source basic.sh
 source tbench.sh
+source gitsource.sh
 
 # amd-pstate-ut only run on x86/x86_64 AMD systems.
 ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
@@ -19,6 +20,7 @@ msg="Skip all tests:"
 FUNC=all
 OUTFILE=selftest
 OUTFILE_TBENCH="$OUTFILE.tbench"
+OUTFILE_GIT="$OUTFILE.gitsource"
 
 SYSFS=
 CPUROOT=
@@ -131,6 +133,9 @@ amd_pstate_all()
 
 	# tbench
 	amd_pstate_tbench
+
+	# gitsource
+	amd_pstate_gitsource
 }
 
 help()
@@ -140,7 +145,8 @@ help()
 	[-o <output-file-for-dump>]
 	[-c <all: All testing,
 	     basic: Basic testing,
-	     tbench: Tbench testing.>]
+	     tbench: Tbench testing,
+	     gitsource: Gitsource testing.>]
 	[-t <tbench time limit>]
 	[-p <tbench process number>]
 	[-l <loop times for tbench>]
@@ -159,7 +165,7 @@ parse_arguments()
 				help
 				;;
 
-			c) # --func_type (Function to perform: basic, tbench (default: all))
+			c) # --func_type (Function to perform: basic, tbench, gitsource (default: all))
 				FUNC=$OPTARG
 				;;
 
@@ -175,7 +181,7 @@ parse_arguments()
 				PROCESS_NUM=$OPTARG
 				;;
 
-			l) # --tbench-loop-times
+			l) # --tbench/gitsource-loop-times
 				LOOP_TIMES=$OPTARG
 				;;
 
@@ -243,16 +249,16 @@ prerequisite()
 		fi
 	else
 		case "$FUNC" in
-			"tbench")
+			"tbench" | "gitsource")
 				if [ "$scaling_driver" != "$COMPARATIVE_TEST" ]; then
-					echo "$0 # Skipped: Comparison test can only run on $COMPARATIVE_TEST driver."
+					echo "$0 # Skipped: Comparison test can only run on $COMPARISON_TEST driver."
 					echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
 					exit $ksft_skip
 				fi
 				;;
 
 			*)
-				echo "$0 # Skipped: Comparison test are only for tbench."
+				echo "$0 # Skipped: Comparison test are only for tbench or gitsource."
 				echo "$0 # Current comparative test is for $FUNC."
 				exit $ksft_skip
 				;;
@@ -274,6 +280,10 @@ prerequisite()
 			command_perf
 			command_tbench
 			;;
+
+		"gitsource")
+			command_perf
+			;;
 	esac
 
 	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
@@ -321,6 +331,10 @@ do_test()
 			amd_pstate_tbench
 			;;
 
+		"gitsource")
+			amd_pstate_gitsource
+			;;
+
 		*)
 			echo "Invalid [-f] function type"
 			help
@@ -344,6 +358,12 @@ pre_clear_dumps()
 			rm -rf tbench_*.png
 			;;
 
+		"gitsource")
+			rm -rf $OUTFILE.log
+			rm -rf $OUTFILE.backup_governor.log
+			rm -rf gitsource_*.png
+			;;
+
 		*)
 			;;
 	esac
-- 
2.34.1

