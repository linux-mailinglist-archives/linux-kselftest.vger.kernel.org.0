Return-Path: <linux-kselftest+bounces-32038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E459AA526C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F89A18F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 17:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1F3264F9A;
	Wed, 30 Apr 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5B7i+NFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA492609D1;
	Wed, 30 Apr 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033303; cv=fail; b=Ue4w4/z8ywdkCGgNNVFCvQVUuOUKPDVTlSMcGs4HU82Henxd4LlX+CD/1xyCRnEsYLIl13XAELCyLo8H5h2k2yyWP3vGYcWz7OB1Y7C+TvfNyUC9k/0nnsfU4MSVRxrPyn0Ufs972fze85ZAxE7h9K1pEm7Ae5wxNNo0TS8Utd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033303; c=relaxed/simple;
	bh=CB264QTP0aXxIIRF/00d5JIm9ix7C7Tq6t9VuCPMLcg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4H6HctRijxmNhz89Gs87sk5yfgjek+ydys2WU9O9hn1PfA9elrkfXBi8yUIzRDypVkys1lUWYOAPAqHiM2it4h4RV/XHy0OOFoGFk2tlBEbP3AnqhKMSAgwiesAr+r/PAXvmgCcX18Tu/XSlppRgkJ88LQnQii9DM9Mo0xsHtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5B7i+NFK; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RORiuh6hIMs7Zo05XrgRtXFCaTWug4JoIZSNO6N1TC6dE3zkbv7akrfisZKvfi9q3RwQca42up06ipWHi7yZGVO0vAK7Wzo8nbkpM31ClL5P03s5OTbn3H4ywekZEnXLEkJqkNW7qoP9tIuKW8q5Qw3xsaBJphvnOoLAK4EKOebm4m2Ns8NZmBAiEE2D1QXi0VbomIs35s7YknRIj0X/osqTMkAt5mdcgVAuXFd5mcuXQbuX2Lx40WXlj23FRxUQiwVQyUIsWxLoGZi/Odk7kXi7eqbYrWfX7YG/HUfIrAdHPkKVIorkstSDP5W/IQbu6iw2cKYbUcpL7VhhAZES+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05VS0uXcuMNGxVdUPrdCwaumCtMQE+MJBy4wJ3tTbRg=;
 b=KiMnAN1rojcI1neniP4+vK1MMphpsVeFhsZSoE2KucjxFchXDsdkk6gPjI/485t+00bbCGzTZvPxyYGqERe2WhC7jfLZ/ki1IkQ3QdTa8Q8LNRtwF18zsPB2qEZhFu+Yy4R1sbSFqmH6k2H+wEcBpc/xkU6vTApUmTn7JZLEXqdnf00SwStDwhowLx/nzv/BdKKq+PabwoGqhPG+CB5LNmlZ93TJVfnvPUaP1qDE+B3RK4t4qJGCOupcQWiOHsFNFoMEJWI4iG2RDTujRmt6p+u8TmraEESSWabkH1uILhouZ47Qk3tpwKnLnky9RteFCMSlXZ3sC/nx8iEL0lt3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05VS0uXcuMNGxVdUPrdCwaumCtMQE+MJBy4wJ3tTbRg=;
 b=5B7i+NFK/Su4K+ilfrtvNw9FhGQtpdAKI7T4HKOc4Z4e5EmKRIZU/OeJ/56lSEvBH+W2HScItsE09ovhLtESJjTvpmARLujfrdTtBxxXxLLWAF+oRv3A+nPPBH4kuqX0VqIrUuAoHVa2tOBmOW77/QBO1ZbqeJ5QRPtaId/FRzs=
Received: from BN9PR03CA0256.namprd03.prod.outlook.com (2603:10b6:408:ff::21)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 17:14:55 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::f6) by BN9PR03CA0256.outlook.office365.com
 (2603:10b6:408:ff::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 17:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 17:14:55 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 12:14:51 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <shuah@kernel.org>
CC: <gautham.shenoy@amd.com>, <narasimhan.v@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update testcases
Date: Wed, 30 Apr 2025 17:14:33 +0000
Message-ID: <20250430171433.10866-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcbdc78-8030-425f-fe52-08dd880a86f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3Td5Tvf0Ru0vLuCH4Sv03PtPRShDNjFVvWqe5euFuuBT+pxzul4sUJuunBl?=
 =?us-ascii?Q?Xlk4XUOti8m6+dls0wKyhU8B2rgkNuZyWVIYmHhCZm3dVoRTGZhn22rT2gCB?=
 =?us-ascii?Q?Fxu0+WcPwtnGocNQsuxGoQvFmc1xfpo/nluPTRlDGGzWXsS2RNica8NYF1H6?=
 =?us-ascii?Q?w37PZA1qz+gUCh+XglSfHcEJpJQzJ/WhOACWLcOxXAi821fPKjHdlwLxFGGY?=
 =?us-ascii?Q?W4JmIQYrW8u1L8ar2l47nb3kQKHecag17I/xRFbI/rNsuRrhlOpijky4GlpZ?=
 =?us-ascii?Q?wfRGNQ1dY7jMONuXF4uRr+MNtPZSaQRagtaTSZrVYzgfiwM1bkrXqPMCQsYY?=
 =?us-ascii?Q?sfMTsLkJoCZgArw9GYdUzI7qT4Rt86LL52bieARdwq9z9jvcVKCEAffKD1wA?=
 =?us-ascii?Q?v+zpLXr+b5U6qseROh5KADw+VDb9hzh8B3Wbx0p4NY/yYtrwoiUEqy0aQ4kD?=
 =?us-ascii?Q?Os3if4e+atCy4/HGtkWwO+vzZpFLb8QMuIVPJqp6jwfoaL0yhkqBsC1vjfgj?=
 =?us-ascii?Q?7FroqlaTEfX6cqhHDCvQdrWHaUxEnSaNA7U/Wod58ieB7kIi1dBkUitXjvZz?=
 =?us-ascii?Q?d1jqlxGqvU081G09uGj9AYcJ7zLU5TLWqnX2DzDFig1+WL7H+xhmN5DPFY7V?=
 =?us-ascii?Q?fI5N3sWkBaLuORthHZudAkz8AzxCMXbSZ6jXCTEEzobQPH6Zx07c0u2qzY0f?=
 =?us-ascii?Q?bKhznybGOmaTgF4iyYRN24ahFcXv8QA/DLHQOrUZ/ItPNmTaPU/mEJqDFOmT?=
 =?us-ascii?Q?9hLPVlNCSGrm9wbK9u5dEgWCTqa0WnhEncCdNPdS7kyb3xhUZg3rqNJGrhwp?=
 =?us-ascii?Q?5fUuRr26MvcR9swZhuMdx9aDT3mBRg0YxhJCBkLFTF4ddTdvHK6QngWGC5PH?=
 =?us-ascii?Q?jQLzkOJqCqEdnRccftO9rcXS5RCyUPke7JEde40zZwo0B6knqwUL7kwry1vj?=
 =?us-ascii?Q?rk1rKA+LB3KsGlmLXGLYXV4UWcntBRztfAiwSsBuytB3A18wvIC4driBYKQM?=
 =?us-ascii?Q?qnGDsoI6k+Yz27rx6E/SyQmgxXBx7cjmLua8LGlMpVH8hbxro5kNh7y6Rfji?=
 =?us-ascii?Q?UYfuwEQ/uFwYTHKCJcaJl4Z29RdlpdxA06pNCi3m6weVTECPzYMlcjLc8lbu?=
 =?us-ascii?Q?lE71yHTAf9KQCWzZ3KxTOC18MSnb4ZjYT8ql/kckfY7u9jL+6FptYqcMAC50?=
 =?us-ascii?Q?BPpPA97JctJWes4i3TMvtXWDzNZnr5jTpVInqM6uC+bUpFRy6gVaH1vh51RL?=
 =?us-ascii?Q?mo/PGL4YLR2q/2kMkaewODMTJSxZdliNOj/mEYr3e2pIc/SL/ObTGfm11h9a?=
 =?us-ascii?Q?6b19W9lvSkrf/Bxrq8wPgcyaAumiLIvdVam5wm53I4aJtw9Z8VmRFJTzmYtA?=
 =?us-ascii?Q?y0S2qXLJXdFEznx9o16pEF5x21S8aBvSUjXQHuVDSiOaHjsNYbUplnQrVR0u?=
 =?us-ascii?Q?uglDp3PeETkqwCmK7l/YRL86oX5mN3KS+iIZoenaer7adiT7fXsx3AIFlr63?=
 =?us-ascii?Q?FfOx9yL76MbZs0z1vyU9iYvQPKEthKUjUHLu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 17:14:55.1506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcbdc78-8030-425f-fe52-08dd880a86f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

In cpufreq basic selftests, one of the testcases is to read all cpufreq
sysfs files and print the values. This testcase assumes all the cpufreq
sysfs files have read permissions. However certain cpufreq sysfs files
(eg. stats/reset) are write only files and this testcase errors out
when it is not able to read the file.
Similarily, there is one more testcase which reads the cpufreq sysfs
file data and write it back to same file. This testcase also errors out
for sysfs files without read permission.
Fix these testcases by adding proper read permission checks.

Reported-by: Narasimhan V <narasimhan.v@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
index e350c521b467..3484fa34e8d8 100755
--- a/tools/testing/selftests/cpufreq/cpufreq.sh
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -52,7 +52,14 @@ read_cpufreq_files_in_dir()
 	for file in $files; do
 		if [ -f $1/$file ]; then
 			printf "$file:"
-			cat $1/$file
+			#file is readable ?
+			local rfile=$(ls -l $1/$file | awk '$1 ~ /^.*r.*/ { print $NF; }')
+
+			if [ ! -z $rfile ]; then
+				cat $1/$file
+			else
+				printf "$file is not readable\n"
+			fi
 		else
 			printf "\n"
 			read_cpufreq_files_in_dir "$1/$file"
@@ -83,10 +90,10 @@ update_cpufreq_files_in_dir()
 
 	for file in $files; do
 		if [ -f $1/$file ]; then
-			# file is writable ?
-			local wfile=$(ls -l $1/$file | awk '$1 ~ /^.*w.*/ { print $NF; }')
+			# file is readable and writable ?
+			local rwfile=$(ls -l $1/$file | awk '$1 ~ /^.*rw.*/ { print $NF; }')
 
-			if [ ! -z $wfile ]; then
+			if [ ! -z $rwfile ]; then
 				# scaling_setspeed is a special file and we
 				# should skip updating it
 				if [ $file != "scaling_setspeed" ]; then
-- 
2.43.0


