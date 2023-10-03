Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62F7B6047
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 07:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbjJCFLC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 01:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbjJCFK6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 01:10:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B395B4;
        Mon,  2 Oct 2023 22:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCGi79T2aSazPDthvG+cKnC8OxNvR0PRILvVa9Ok57ytH/DgmEVQBhgK3yq/wuEInXuMQFkL/iFwYxpz3IkzDb2CU4PRPSZejuX6feduFE2QJpSXgXduspoln/eRKS4kDFAiRvr7dczDiimtHH1jtxL+mR3Li3k9ZUSja/rqnpNdfUqfV14l0sD4+fTiTzkg3vaYgXI8PUSZCDGFT+nN99JtAgCQV8nMKt8221z1yriEmbid/EjczNeFe3PBRl43oro8bg5y8q75KVY6q+h84w3hkW/GpYmod0fAPGgxkZB6UJh/flagM0XDmNpjdDdyEqdSvMpCaEAQEhdjv8fvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQa8JedNR1fo25+2UQDrWIJDmzjgNihz4DK5NAGM+7A=;
 b=Aoqu4x1iGZxjPOuwwKC9GedcScotSXNFWUu+pvmtseI7F8mGuUnt/qKg72dB6UGNZ5Hjco8wyPoUKT7J0wbESOYaTc/kugQR2/DFytHGRMtwA3YwbYpEDng1/91EyjfuytkEwqbnUB1VmpdjnAH8jMD9edab9qnQFGj9V8oJ6zSEBUm+0QNmwWMUCudbwCLT1l1UHjDkUSuUUKvgocJFsxgDZx/9rp8ByZ82DGvODgHOC6wmXhRnFyAv5S/DXTkNK1gKegDx0Ife5nNZN8ZejsN5+pwydnuQZsmV7U/8esT1a6vs8W3U5y9UyTeJ3RCMJFuMx99WiZPLwcqDDR2jHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQa8JedNR1fo25+2UQDrWIJDmzjgNihz4DK5NAGM+7A=;
 b=0SV3wbxp8rYMZ1oLLD1UfuZFj/o/2YmyTln7bD5iCShfYt2QJGMBZkWJMO4oOqXqy32/lkl/yN6fPpSmRXRf152MHu2i1NBY/ils3Tjv39G7GDf9q0euTGYfmluh5RhpDk+zsRMVP+uMhzwV0lyv8z9e2xSM5C+a9pg7AgVTH3A=
Received: from BYAPR11CA0055.namprd11.prod.outlook.com (2603:10b6:a03:80::32)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Tue, 3 Oct 2023 05:10:52 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::8) by BYAPR11CA0055.outlook.office365.com
 (2603:10b6:a03:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 05:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 05:10:52 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 00:10:51 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <li.meng@amd.com>,
        <gautham.shenoy@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>, <Mario.Limonciello@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v3 2/2] selftests/amd-pstate: Added option to provide perf binary path
Date:   Tue, 3 Oct 2023 05:10:06 +0000
Message-ID: <20231003051006.6343-3-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e94a4f-5a36-4822-bad6-08dbc3cf1d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1UYDHcUB9oFBSjVVwJCg3tB1ZM3qDo8OeCUAtrtfmHDlaZADAE6UsGqP5zVC4NCMiX4MTFHa5wRmA363aErNAFSUUllpymr7EAEV9PjBnVf16cMHYxv8uf1LBtCc34A+ePCX3oDXJXA4XIU6AFtQwytuqEav9dHhYo6turT1azolTdfNRVqxe/j6LLRQYkxKqoJ/i9U3wQaH5NRkFlMwUrzyQpoTPlwchg+oJ5ecI/D4/3he/EK1TZa6Y72FhN8stjWaKWXxY4tGoq8srDDNHzKb9hjHxtpc2SS9fKjr5Pk3hr47BvkpxKGjzDh3QT+euevaKJvjLQJrkGsvEYYbr9Hfd2GZqJvfI2QznxBmdbDGLj6af+DQJRrno/vzT4ixXYXKonTigkyxf1DtNU7iG7NGpBGTI51n9xnWuDHC80B6FsxWShRJCW/8Y7heBVGSJGNGTIX3LndtuRrKAundkFsEZ4v6GP4WtB0zhiOO9X7H6fnq1clLmAz1L31hGRoRC+7mxllJQl1Tjc6YT9wHcnUrCD6IHZr/Goy/i3s/uRWT8JgXTWLi5qGyARbpTOSxvt/+8R8LT5lHjs3/105U8bjTBuzlZ8GTg9nENrS1oTvDEl7TV/dEZolMAonUFB+9XiBPHU77AJtfjMSfdOroKQuaW5xMtjrF5sIRjM1IYoYHMJrazO7KOl/uGXj1Jj2fdzTHM1tqe8r1R14zTwNaF80MfwmRCF3LisqfrF/Gf4oHhLTiYSKO4fI1ec7UIL/AyavzhmCiOerGvz8dcdz3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(26005)(70586007)(110136005)(2906002)(44832011)(4326008)(8676002)(5660300002)(316002)(70206006)(54906003)(8936002)(41300700001)(478600001)(6666004)(7696005)(16526019)(36860700001)(336012)(426003)(2616005)(1076003)(47076005)(83380400001)(82740400003)(40460700003)(356005)(81166007)(40480700001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 05:10:52.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e94a4f-5a36-4822-bad6-08dbc3cf1d88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In selftests/amd-pstate, distro `perf` is used to capture `perf stat`
while running microbenchmarks. Distro `perf` is not working with
upstream kernel. Fixed this by providing an option to give the perf
binary path.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/testing/selftests/amd-pstate/gitsource.sh |  2 +-
 tools/testing/selftests/amd-pstate/run.sh       | 14 ++++++++++----
 tools/testing/selftests/amd-pstate/tbench.sh    |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
index d0ad2ed5ba9d..5acc065e9e3e 100755
--- a/tools/testing/selftests/amd-pstate/gitsource.sh
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -87,7 +87,7 @@ run_gitsource()
 	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
 	BACKUP_DIR=$(pwd)
 	cd $SCRIPTDIR/$git_name
-	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
+	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
 	cd $BACKUP_DIR
 
 	for job in `jobs -p`
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index 279d073c5728..b87cdc5bfe4a 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -25,6 +25,7 @@ OUTFILE=selftest
 OUTFILE_TBENCH="$OUTFILE.tbench"
 OUTFILE_GIT="$OUTFILE.gitsource"
 
+PERF=/usr/bin/perf
 SYSFS=
 CPUROOT=
 CPUFREQROOT=
@@ -152,8 +153,9 @@ help()
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
@@ -161,7 +163,7 @@ help()
 
 parse_arguments()
 {
-	while getopts ho:c:t:p:l:i:m: arg
+	while getopts ho:c:t:p:l:i:b:m: arg
 	do
 		case $arg in
 			h) # --help
@@ -192,6 +194,10 @@ parse_arguments()
 				TRACER_INTERVAL=$OPTARG
 				;;
 
+			b) # --perf-binary
+				PERF=`realpath $OPTARG`
+				;;
+
 			m) # --comparative-test
 				COMPARATIVE_TEST=$OPTARG
 				;;
@@ -205,8 +211,8 @@ parse_arguments()
 
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
index 4d2e8ce2da3b..2a98d9c9202e 100755
--- a/tools/testing/selftests/amd-pstate/tbench.sh
+++ b/tools/testing/selftests/amd-pstate/tbench.sh
@@ -68,7 +68,7 @@ run_tbench()
 
 	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
 	tbench_srv > /dev/null 2>&1 &
-	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
+	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
 
 	pid=`pidof tbench_srv`
 	kill $pid
-- 
2.34.1

