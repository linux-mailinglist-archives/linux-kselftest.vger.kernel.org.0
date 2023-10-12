Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8C7C69BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 11:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjJLJeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 05:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjJLJeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 05:34:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2491;
        Thu, 12 Oct 2023 02:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Po2tu5Fb1p4iAD1wXN7u22XE18jrE43u0aWxoOFl3c+RQIMFSO/PxATp1GjZmH/Dg3NxarHGBMft8QnMl7TZAYBK3KnEsCNcfHzmk7vROalaxI9QP1sHP31O3yf1bS9ShkofPmjNHj2EeAokTb1onQZWQOEkQvl6ecchbMMVvNBun6MxL2xwU7Lvv0gph/TRSgTHhleDjd1Ah9uub4ViVhUaCW6LnjHi+zFzidvpRPJzHiUepbNrsScqyvusIZCaVR8tYdVBeeBWjfz6uNVMsxd/ia0xvgr0bcGSB8GDtylxwHe4Vs8DV/jFTnIm+MZQQvFWu1JFOkKyquV3zuV8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mydanlmyetqG7EkI9buSs6oeQip5k8fSclJ3o3lEIIk=;
 b=bfOA9WD52V5BrEGoJ2TXDARukLH7PJhbvSPkVdzgjUujo125qapTm+pPIbySpyXzXBq7T5ppkW9YJn6FLlNQlCkebzAuzxh0qy3VjqvarTxyb/0qp08DJjV5ak2NY7j7Vas5zOBh6DAgMKOApsokU+syLZOi4SsXQM2MpeK4oNb6DURB+TgwSoTLZfqW/2N64naO0VOvRxKTc+xUmVWFeggIGyEgqZbn+/QddT3wzYwqAJ3kFrbfcpdJQ6WNh9WeWr4IM8nHZV/yNaJh7QOqs7eJTg+JrIYijx0O0JJNLYCaiON9m72n0/fgq8lG3QZNApfNfQaTo74pwZO4PP4yww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mydanlmyetqG7EkI9buSs6oeQip5k8fSclJ3o3lEIIk=;
 b=zsZBAC98fGuwDXJYm237ngzotVmJ6vnEi0KL5Qafq7e42LBKTJFO60cyUbjRu9gOtPiJWdIx2A3G7cw4hcHyLWeAuHrAEX4v4JpGTQ8EJnGZrWIgVGJbFWeEcs9aBhnbPv8QuUPJzQI5A0gNEo4GMJsfbhRhp09coKnIxViR45Q=
Received: from CH2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:610:4f::37)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 09:34:04 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:610:4f:cafe::f8) by CH2PR18CA0027.outlook.office365.com
 (2603:10b6:610:4f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 09:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 09:34:03 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 04:34:02 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <ray.huang@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <li.meng@amd.com>,
        <gautham.shenoy@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>, <Mario.Limonciello@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 2/2] selftests/amd-pstate: Added option to provide perf binary path
Date:   Thu, 12 Oct 2023 09:32:25 +0000
Message-ID: <20231012093225.2045109-3-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f28917-2c6e-4c6a-7478-08dbcb065fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8a+cM3aJzT+EmITa6Dgj6Ewf6+T6UCN5CJLjgdf3dMl/dDmZUH277g1PgsoqUbPPlFRE7NBVTU4oseXpXwaW1vrYsLDCCrpGI76Gn0lvaAZOzH9G7WqXISHBxLboHIRGtvXTLvW/ZgDXPH7g3aVY/IY2VT2dynXNdRdJCeQ3b7DirZhoQkHoE/RBTFnGL0BFcnv2RZtxMCGl83MXmkBFTxDSYfk98BEvwQH50S8n4fxyjNnjVOsu9MxOpL6E5jnsqtJEi657Ep2c1NRhdx41HGH4jcnWyO3EadBH8LILkYxUCc6BHW1iPoMBMZI8c1HmCiFdVy9iyZyVmEGu5CJzpsMl1dPe2tYa2TfkjsSz1SVj+th/3vcEo0mfENCiowO3+JNPnmnP+2p65QIFZtj+XQMfWjywxs1kSjOybHoXhOA6yswkwQSHDVOR6yUVolkIPjcZ8C5bbxBxU/4CwVr5yV5bhFjV+gsrreQHVguaWpch0HBAI80abSwRbus3AP0/5vWkXSLlJZBYMBWndiIPr8IUPseEcZoXiWaDWnqYi5prBVqw2iAG/Dc3DxcGTpZ2TU0ofwQW/axsAMmwV03ZNJIKwyp0pE/BwlcVcavC2ImKyz9qq4q6iusbjwtcEMt3w0mvetZbdjKItcTxKaejNuuiqG+SxSknWuWCN3N/wNp3MVAUgTZ0tEqSE3Jh9VUCUTfhEhqelawNa/lbo9wtJufb0IGclbKX+1YR7Zk8nKQGUuU3bPpt1VXRxSfV1Hv1xTiwa23BEy6cMGG+Y8fjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(26005)(2616005)(47076005)(16526019)(478600001)(7696005)(83380400001)(1076003)(40480700001)(86362001)(40460700003)(6666004)(41300700001)(426003)(336012)(36756003)(8936002)(8676002)(4326008)(54906003)(316002)(70206006)(110136005)(70586007)(2906002)(36860700001)(44832011)(81166007)(5660300002)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:34:03.8376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f28917-2c6e-4c6a-7478-08dbcb065fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
upstream kernel. Fix this by providing an option to give the perf
binary path.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/testing/selftests/amd-pstate/gitsource.sh |  2 +-
 tools/testing/selftests/amd-pstate/run.sh       | 12 +++++++++---
 tools/testing/selftests/amd-pstate/tbench.sh    |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
index ab195ddcba4d..4cde62f90468 100755
--- a/tools/testing/selftests/amd-pstate/gitsource.sh
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -88,7 +88,7 @@ run_gitsource()
 	BACKUP_DIR=$(pwd)
 	pushd $BACKUP_DIR > /dev/null 2>&1
 	cd $SCRIPTDIR/$git_name
-	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
+	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
 	popd > /dev/null 2>&1
 
 	for job in `jobs -p`
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index 279d073c5728..b053eea8bb19 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -25,6 +25,7 @@ OUTFILE=selftest
 OUTFILE_TBENCH="$OUTFILE.tbench"
 OUTFILE_GIT="$OUTFILE.gitsource"
 
+PERF=/usr/bin/perf
 SYSFS=
 CPUROOT=
 CPUFREQROOT=
@@ -154,6 +155,7 @@ help()
 	[-p <tbench process number>]
 	[-l <loop times for tbench>]
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

