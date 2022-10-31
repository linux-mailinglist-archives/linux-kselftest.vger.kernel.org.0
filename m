Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92DD6131EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 09:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJaIuJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJaIuE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 04:50:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA7465C2;
        Mon, 31 Oct 2022 01:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcxeMFw59ykvc5TZ6bzJkohA/tj2dQpBip/LbNcc4oEXej0Byz+H6NPYpzZO4Acj6ozLrqDxfwZ0hwcaguw9MNQIm254DOMZO89A58u5RecyDL5BMfTMZT/sKhtLBB8jyPhUVfu/NmD+hZbV63DnVCVOQdRBhY5U5gCTeOVLHm25oNelB9avZ4ikvOBHZBtBuB0DIGujb00TUILfDbAg4d1Vs/YFAFMrOwsTHSig5ydO+ck3be9EVgTqi1p/TrE6bgRpD9sYrNYTTvkFxgO+2YyzhCM3PZoOltWBfNvzeIkGpJQHMqVf73BmM1R4SllCAsvZg6apjf+flPsTqy3G3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7NtDKTk0wEiinCcedT0s8+Y/el4wE/reEDMREBYyto=;
 b=F3sTfcmg0jDV0ddcEOPkApeTsdUGDH6MVrCfIfcY8GBqr6klOYEXrGmnxBIbeckkWaQ0+uVMsWjYjefd48C6k5Sv3wahl/B91V2jfCSPjdkpaDJgtk9GfhjY7FusrqKucKtPeqt4cwjjly0nU4MjqcqlpkBY8q+0lPbPfqJcVdQ8kpsi8yDuAKPXJD0UD9ZemFj9+tujwhuRCwR1z0UUdZP/UR1zZbt+VBL8728Do0Lr4xdpOtV88vXEHTTFJvc2yafahrkjDVwFww+lxPMPmmSdBN8Udl57XJBsirciZmqh3f9JFr6ovodqr4BMORQt9sbGKTkGKAJsO+/N7ea5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7NtDKTk0wEiinCcedT0s8+Y/el4wE/reEDMREBYyto=;
 b=dCaMFfgFyf1YQw3GDhDwthVYEEVluboyy8lBkBJvHeuh9SFxI18OJ4j4X36jtUN95a+g6MaW/scBlwvISrx5DNtrK8XGX/UO/v60mRl8cz9hRcaGXAMQdYAnKRikyXTTsuuJQ8CCEwoZhIZJDU9WzZl9ZJF/tjlQO2dl6IELozo=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 08:49:58 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::a5) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9 via Frontend
 Transport; Mon, 31 Oct 2022 08:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.17 via Frontend Transport; Mon, 31 Oct 2022 08:49:57 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 03:49:53 -0500
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
Subject: [PATCH V5 2/5] selftests: amd-pstate: Split basic.sh into run.sh and basic.sh.
Date:   Mon, 31 Oct 2022 16:49:21 +0800
Message-ID: <20221031084924.1742169-3-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EA:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: af091f76-09c0-4457-9eeb-08dabb1ce38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2NkA/W9HwEoXJ8n1GOMuZ8jffN45nt2p9KLRZedUxZqZQjdAzIxPATkrd6D0QqjL+LeKYDhTNoVqFiIzszj1ZnqRBRSMoBQohWQmrg9+lCqv9C/fVwYfwXOj4vc4WGen1lYbulOewJVWbFIsq2NaVk+vN8ixphsCu8yVYYOKszSAFhDpz0PlQyHAhbpajKLKdNkVFT302sugV3vrDnrfMkd5qVTRSdwR6B/8qiaWzitgUkGPJ2otDpZsNeMDTId0v7Ku275FpOuNnmUz3xeOR6sCfmRSBfPUkvgsQcrenjkFiuBDHnw1c0VxPLHNs67umog2jt9YZBrSDbi/YJVxHWJCfUKv009sHns73PBDiVwzOR+xFGSYSDczN7RyIZmlCrW0vdYV77D0CoZhMfziLAVtTZUAMTHn0fVC9KL8jGvjVQvy2l06FqPGB+nJJpGbtf3AQxkkcZqbXB9SoO6c/lOntgAPklcH0CLB5U4D3NvRh92Juref5j7RzgeuXuC20v4WaHJoDP2kneutDMUcUhY3qSyTPNctHhx9vdF4Stp2EVx17zZ+K763YXeOCVdk1N0CLikqnyFyad+aLqplUYf4IytytLl69J/JdXo+pzYM9xoXvSLa8AfJGGjO5yvngIBrxUdjBcdilI79wf+m+MeHLvpCCgNWC1vv4wqLT3kvc4RNekhZGwcUJPBdvKSu7ZAwkWobgRqKayxA5QqPOiW3wUT37mwUMas+OaFgZk6Om8B4sGmKe4OR7EtFJfHrL0SD4pGUdn2zaIClrrloteddMD2dqGm41MyB1k6BZNI1AdV+EwefsJkK21KupVt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(8936002)(2906002)(5660300002)(41300700001)(356005)(86362001)(54906003)(110136005)(70206006)(81166007)(4326008)(70586007)(8676002)(316002)(82310400005)(2616005)(47076005)(26005)(1076003)(336012)(40480700001)(186003)(16526019)(6666004)(478600001)(36756003)(7696005)(83380400001)(426003)(82740400003)(40460700003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 08:49:57.6440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af091f76-09c0-4457-9eeb-08dabb1ce38d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split basic.sh into run.sh and basic.sh.
The modification makes basic.sh more pure, just for test basic kernel
functions. The file of run.sh mainly contains functions such as test
entry, parameter check, prerequisite and log clearing etc.
Then you can specify test case in kselftest/amd-pstate, for example:
sudo ./run.sh -c basic. The detail please run the below script.
./run.sh --help

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile |   3 +-
 tools/testing/selftests/amd-pstate/basic.sh |  64 ++++-----
 tools/testing/selftests/amd-pstate/run.sh   | 142 ++++++++++++++++++++
 3 files changed, 167 insertions(+), 42 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 1d6f962a8f9e..6f4c7b01e3bb 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,6 +4,7 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := basic.sh
+TEST_PROGS := run.sh
+TEST_FILES := basic.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/basic.sh b/tools/testing/selftests/amd-pstate/basic.sh
index f8e82d91ffcf..e4c43193e4a3 100755
--- a/tools/testing/selftests/amd-pstate/basic.sh
+++ b/tools/testing/selftests/amd-pstate/basic.sh
@@ -11,46 +11,28 @@
 # (3) We can introduce more functional or performance tests to align
 # the result together, it will benefit power and performance scale optimization.
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-# amd-pstate-ut only run on x86/x86_64 AMD systems.
-ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
-VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
-
-if ! echo "$ARCH" | grep -q x86; then
-	echo "$0 # Skipped: Test can only run on x86 architectures."
-	exit $ksft_skip
-fi
-
-if ! echo "$VENDOR" | grep -iq amd; then
-	echo "$0 # Skipped: Test can only run on AMD CPU."
-	echo "$0 # Current cpu vendor is $VENDOR."
-	exit $ksft_skip
-fi
-
-scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
-if [ "$scaling_driver" != "amd-pstate" ]; then
-	echo "$0 # Skipped: Test can only run on amd-pstate driver."
-	echo "$0 # Please set X86_AMD_PSTATE enabled."
-	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
-	exit $ksft_skip
-fi
-
-msg="Skip all tests:"
-if [ ! -w /dev ]; then
-    echo $msg please run this as root >&2
-    exit $ksft_skip
-fi
-
-if ! /sbin/modprobe -q -n amd-pstate-ut; then
-	echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
-	exit $ksft_skip
-fi
-if /sbin/modprobe -q amd-pstate-ut; then
-	/sbin/modprobe -q -r amd-pstate-ut
-	echo "amd-pstate-ut: ok"
+# protect against multiple inclusion
+if [ $FILE_BASIC ]; then
+	return 0
 else
-	echo "amd-pstate-ut: [FAIL]"
-	exit 1
+	FILE_BASIC=DONE
 fi
+
+amd_pstate_basic()
+{
+	printf "\n---------------------------------------------\n"
+	printf "*** Running AMD P-state ut                ***"
+	printf "\n---------------------------------------------\n"
+
+	if ! /sbin/modprobe -q -n amd-pstate-ut; then
+		echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
+		exit $ksft_skip
+	fi
+	if /sbin/modprobe -q amd-pstate-ut; then
+		/sbin/modprobe -q -r amd-pstate-ut
+		echo "amd-pstate-basic: ok"
+	else
+		echo "amd-pstate-basic: [FAIL]"
+		exit 1
+	fi
+}
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
new file mode 100755
index 000000000000..35c0a0b16ad3
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -0,0 +1,142 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# protect against multiple inclusion
+if [ $FILE_MAIN ]; then
+	return 0
+else
+	FILE_MAIN=DONE
+fi
+
+source basic.sh
+
+# amd-pstate-ut only run on x86/x86_64 AMD systems.
+ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
+VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
+
+FUNC=all
+OUTFILE=selftest
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# All amd-pstate tests
+amd_pstate_all()
+{
+	printf "\n=============================================\n"
+	printf "***** Running AMD P-state Sanity Tests  *****\n"
+	printf "=============================================\n\n"
+
+	# unit test for amd-pstate kernel driver
+	amd_pstate_basic
+}
+
+help()
+{
+	printf "Usage: $0 [OPTION...]
+	[-h <help>]
+	[-o <output-file-for-dump>]
+	[-c <all: All testing,
+	     basic: Basic testing.>]
+	\n"
+	exit 2
+}
+
+parse_arguments()
+{
+	while getopts ho:c: arg
+	do
+		case $arg in
+			h) # --help
+				help
+				;;
+
+			c) # --func_type (Function to perform: basic (default: all))
+				FUNC=$OPTARG
+				;;
+
+			o) # --output-file (Output file to store dumps)
+				OUTFILE=$OPTARG
+				;;
+
+			*)
+				help
+				;;
+		esac
+	done
+}
+
+prerequisite()
+{
+	if ! echo "$ARCH" | grep -q x86; then
+		echo "$0 # Skipped: Test can only run on x86 architectures."
+		exit $ksft_skip
+	fi
+
+	if ! echo "$VENDOR" | grep -iq amd; then
+		echo "$0 # Skipped: Test can only run on AMD CPU."
+		echo "$0 # Current cpu vendor is $VENDOR."
+		exit $ksft_skip
+	fi
+
+	scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
+	if [ "$scaling_driver" != "amd-pstate" ]; then
+		echo "$0 # Skipped: Test can only run on amd-pstate driver."
+		echo "$0 # Please set X86_AMD_PSTATE enabled."
+		echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+		exit $ksft_skip
+	fi
+
+	msg="Skip all tests:"
+	if [ ! -w /dev ]; then
+		echo $msg please run this as root >&2
+		exit $ksft_skip
+	fi
+}
+
+do_test()
+{
+	case "$FUNC" in
+		"all")
+			amd_pstate_all
+			;;
+
+		"basic")
+			amd_pstate_basic
+			;;
+
+		*)
+			echo "Invalid [-f] function type"
+			help
+			;;
+	esac
+}
+
+# clear dumps
+pre_clear_dumps()
+{
+	case "$FUNC" in
+		"all")
+			rm -rf $OUTFILE*
+			;;
+
+		*)
+			;;
+	esac
+}
+
+post_clear_dumps()
+{
+	rm -rf $OUTFILE.log
+}
+
+# Parse arguments
+parse_arguments $@
+
+# Make sure all requirements are met
+prerequisite
+
+# Run requested functions
+pre_clear_dumps
+do_test | tee -a $OUTFILE.log
+post_clear_dumps
-- 
2.34.1

