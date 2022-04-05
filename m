Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102E74F4CE8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 03:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244745AbiDEXgC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Apr 2022 19:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577966AbiDEXRw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Apr 2022 19:17:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6A2DA;
        Tue,  5 Apr 2022 14:48:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235JD6JH004895;
        Tue, 5 Apr 2022 21:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=PZq5ChKisZCmJH8uBFij2EVaothlaiicCmQBNtGA2io=;
 b=AR4CSfGUuLOHIFWck+o4gvh+ZbhRdy9XqwaW8gE4fD6fshjBK3OLsGvxRJuJWI2dmJyp
 l4I6bhxzIBCp/yw6dznk404m9fdsa7znRh48OcjPCzYutqPoIDhEE4fIEw7YYWg5iITg
 P6HR02TKeWQ1gCI2OjoXk5Cni4VSMddtaaexIhUUEFZ2Ndh54/8BCqt0rDy0cTO42mmg
 L2ygvKpntNm2SoKdpJJufDJZHijnNPYh9db/E9CD6gsRsJmRe1YoCYIxFjxMx9ykFdaQ
 UGkN1NjX5VPp5NAqsNDJjv+OEacDw7mOfK087nGlLwese7VwwtnNEeqJWKVoYkGIxkva ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92yacy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 21:48:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235LflPZ019135;
        Tue, 5 Apr 2022 21:48:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx3u2jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 21:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a83Zrd4z7YqdCeAnSwuIcUwZKLWYblPXd9MIGrv8+a6FdAsgNchBc3M8kAyEelu1THEqAUGo26oTGs8feqa2az9zV54Pi/Rb7ryYLtqPYpQV7eT+ShPQL8A+E21hkgQeAab7cX/K2jb+hULy79luIgV84Mm1ZpM+u9LPd+e4ppufKhY171UkCFeCHvkmzLaY50K7REc9D1yvZ2Qpv3sxnL6yykoxzFiOMRH1Ejg2Ax63GGum2B9KNEJVicP6n7AteT9rFBbbdBR8zi/cTBFwFDZXYSrurtQN9jYu8Iaj59VKv8sZwDLlP0/T/hhYqqjqBndWPHQI8Bg5F0cWet4QdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZq5ChKisZCmJH8uBFij2EVaothlaiicCmQBNtGA2io=;
 b=XS0vlLMsqt0eyFjZGAcyGc1NUvyEW+6kROnCkKNosVWx/E5fT55yvC1aGYyLFKDIkBBc/Qrs5SakxdUy9NE+iscAHgkXH8BJPvtVzbTQR5ZV5/HJaaZQ5DzzDLmoPJDb2+6fZ082kuydI4Veus2IUshU+pK6W+fQbAVtvsjH3IDGr5mKN8s61cfwXtxo/MGsq7EgQBL+dQY+rj8YaPGNaqbybOVLO6R5+q1rkmHXJ2vAhV2lUalE5sasoaCkZW6q+CleKN9i08XAgyxRq41k89prM6H/XIs1MN3/YQeospbWiMuB55UBjzn+Il/ibHW0NJdkRb0FdEqf7XIlec++6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZq5ChKisZCmJH8uBFij2EVaothlaiicCmQBNtGA2io=;
 b=jZY/2OYwjBsfDKBxR7t3A//pUBsJ98fKKANFTz9RK4TN4g0cDUg6Z0ZTCDGyRMopvNCPjT1T/RyaqZl9QB1BfMaNrLyppckNc+DZcPXi5Rj0Ausrxv4rpoUSsHL+i9CLJy2NirCLp7+n4RKvqakSZDEg9LDYqcjhS8j1NQpmWYo=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB4613.namprd10.prod.outlook.com (2603:10b6:510:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 21:48:27 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 21:48:26 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftest/vm clarify error statement in gup_test
Date:   Tue,  5 Apr 2022 21:48:09 +0000
Message-Id: <20220405214809.3351223-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0012.namprd08.prod.outlook.com
 (2603:10b6:803:29::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c316e2c1-7cfe-4a07-6585-08da174e03e4
X-MS-TrafficTypeDiagnostic: PH0PR10MB4613:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4613266BB03149FFB6B7A49195E49@PH0PR10MB4613.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmsRyh13ObIwKBRNz19uagTuu0JqeG/S4Bkd7Ypf4XD7zo7fexBrXZCFAfq+Yfv64jKH32CWaqHlhgDz+0PNO8HTMzS6k1UeV/7SrzHjvS2Ff07+dgxL5tV0rWZBQjAmKJ4RhC5fsxYvY3NQJ1ZTDClu/+p0rqFsdF/ErU9Ik5oKI281BxmY6lF+MuHha8sHSSJjqIsnrl4SslKgr8uBmLSMFfLjtyCmdXsUf2xqx0HdYK3IEOT7PH6gtQ1FJ7hcyYC0TyoJnQured/YJTZLgqIGoR9fCE3xyv9dzPwX7PGiB/YSzOlTHR9Jq9Q57Yj+7cvAUr7+Trpr4v67K8BoONIGpTAyY9N4V9Z+TxONqLsESfgZ7eYlH3O3NwyvVLVwvekRPh4LwsUycpj+PtDV1XVDmZ6Z/tV19ZhiavyPMicJMJmEE51ZR4dLg54TEGqIFuC0ZFXIn96Yf13U1gg3uewz5Flv0CJXOaOPhwMUKI3YFQ6MWVc1ka31/xiYC0G0Z/ZIjTCtI70KoiKSLD7GHS79LBUs+TkLFd++tqapYidfrvKfnRKYnYRKcwfM2YNDSRu+GaCBP5ThD/F/6Liq18u8jVXMR501ojKzRbUksKzDnvGI9WTLDtOfUTPDnSJTbW3cy3J8YWvj3wq2PqY14GumbiG+gwV9xp1AHo4CJFGQxvuCMpPbrLxwm/OkblNJ2Vc57UsDtrLWKtBQUITGOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(44832011)(86362001)(508600001)(1076003)(6486002)(2616005)(6506007)(5660300002)(36756003)(2906002)(186003)(26005)(38100700002)(83380400001)(6512007)(38350700002)(316002)(6666004)(8676002)(66946007)(66476007)(4326008)(52116002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SVXTjnOxDwnhmGWCAMlFas5lVbuFJmAj0YoLIWMpb82CkGNmMXH9/HSTqmEj?=
 =?us-ascii?Q?sOlKMtt0VDtSPQDG7IBfuvBHaBvwfZPK7+/byVZ45xXm/TqFsrC2KTNhWLrZ?=
 =?us-ascii?Q?NmE3sa00Dabw2rjt+ZQv+3Dgm+jWYDLUJ+C5p5SW0QAj/xXH4SSdbJgRdM7G?=
 =?us-ascii?Q?C11BY3U36ob9ztlfNZRw60VPopwKLO9mCKiwfYywJOG/a69jZnZceQAuMGSz?=
 =?us-ascii?Q?tNOtspy4MWIgFZjZSaw2ZT3f1Q7mjDmevrHvKHWnSsWdATHvnQvM+r3dhZ6+?=
 =?us-ascii?Q?gXuTutfNF+90hUAyMvYyy7Er9QkwuEswHDhYtteViIw74LYoBdOJmVlJG41+?=
 =?us-ascii?Q?GILCZ2qgm5KOIUqxUMYEZ7XbcciW4szy1NZWqr7J9MRRf9lnBbH2ynm6qLhE?=
 =?us-ascii?Q?BdrJ9yGckn+RCSsBaFhETKJckx9b+vePi2vYUtAJJy8GBT6Pj3O+tEdOslbb?=
 =?us-ascii?Q?sjr86XTi3AZ6FcwvaboLYnjTS+sSIyg0DAwdGFHFaOc2J6GhJAEAVwtMmzCc?=
 =?us-ascii?Q?gu5oThL9Rca4PZ4pWCc6Yts3DZnmosdpD3XuqfDaTVlpN0yOTUpf3ETk7E+I?=
 =?us-ascii?Q?A1a5Uk7Zj+aRbfGusGJxkIu+4sL/uCzATFia6J5li7QV1KBoKZXdKLZ1k5l2?=
 =?us-ascii?Q?k5pwRIrLIzurL4SBCfJib2/TDWLUXn4uDnoIqYnLg1TIi4Vztbinihb6bQsy?=
 =?us-ascii?Q?bObpk/j7sH/j6MP5q/GlhdlT4elEeZ9Pr0j0MTda7PRG+UWlqKmf9paDn0Jj?=
 =?us-ascii?Q?vRSneLpTJKOg51Deth8PiB1YN/1b/dlreb9xAvkiN/uI5gyWPyGecPA4dQ16?=
 =?us-ascii?Q?OpjkUQJRkOcRfKhb6CLJWTmGOyebYndPOM94NefIek/TUVC8ggD2TIRl+8U5?=
 =?us-ascii?Q?fBxnDgWTp3HDKyag9r+HG9x4eNG6grN7TP2dM1t826ZpSJ1d1A5YnzB5KUoi?=
 =?us-ascii?Q?o0RM7nYmTeXBr8dsAuE039uuhCbz2ew+97hQWfBUUYN7CX65nKLwcuuAzjyr?=
 =?us-ascii?Q?n2syHPaW7jtOMLBYTaW/VmKH0XUc5Ujz5WYj3dx7wtFBSgd8oQMseiv7Diys?=
 =?us-ascii?Q?y95eJuOp3uieUeCIIreT9D4d2AGwQAjJ8l6fZANxYLnw5n/u1BS0iENlWG1l?=
 =?us-ascii?Q?ZZAoK3RO45mlCFc9GYNuWP3UNG+66p3MrBM6DrMH6PeK5lwX+NghkEm20fu0?=
 =?us-ascii?Q?hIKeaQrW6aJ9jHg9VEjNcC1rnd9OsFr4hl4zzJJGo4uA+NMHdOR/d3M5r0Lw?=
 =?us-ascii?Q?Y4PEVMqqPaIRX3frOmr2JQRSppXMla24lKvob0ozeComwBwqHaWVDXUG7uCM?=
 =?us-ascii?Q?QgixJCd8Ui8I0/Lf5AlGVJQkqzFEpXjRiO1QqeuA1sVqK+jgIjDC7lJfF2QW?=
 =?us-ascii?Q?rMW35vM2I0wO2GmwHHRdpDd1BONPIhlu0clR2blFYzE4dxyrHyXngCJVzlky?=
 =?us-ascii?Q?lp9TVwRHg+Q5MzQRyNQ+P6zVqLj2Gy90glttefK91lWZZWrsbKX1BoVs53sx?=
 =?us-ascii?Q?8OiuxTgCrC6snMiNpdF8R5+lf8Bh2nZZSP+XlzYhBA2BppsOwufDd97vVUBs?=
 =?us-ascii?Q?ER9rhdP2GHs5yDZl9c01BYnXnn/yTTJoBPS6dq3gi4FZQ3sZ/G6e3HGz5jCQ?=
 =?us-ascii?Q?e26I7N+cftEzExvKJX69C//P+0hARxROGo0jrIWufuW430/G4CBrLzeFyZBf?=
 =?us-ascii?Q?dvXyMsMSAg5U3jfe6oW3235ofQ5vubchn4zpY902YKs5g3KqziOxWkmX7SHa?=
 =?us-ascii?Q?EaULvbYVwP9ccQTy3mWSliEzH0DZJso=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c316e2c1-7cfe-4a07-6585-08da174e03e4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 21:48:26.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMJxerPEze1mpkIpUXRwAvZDFk46QLQeAto4NrYjfd1afUyj/mfjj5YvCrJh2rjbrahWWEqgJxVojm/GTRz8eR6m7m3TzG1B/SDEEkIOIxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4613
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_07:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204050119
X-Proofpoint-ORIG-GUID: Azhrdroc8bGtH9ksK2J1lXtuv0meceOB
X-Proofpoint-GUID: Azhrdroc8bGtH9ksK2J1lXtuv0meceOB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Print three possible reasons /sys/kernel/debug/gup_test
cannot be opened to help users of this test diagnose
failures.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
v2:
- Add support for skipping the test due to unmet dependencies.
- Use errno to print a more specific message.
- Add check for root privileges.
- dropped CC to stable.
 tools/testing/selftests/vm/gup_test.c     | 22 +++++++++++++--
 tools/testing/selftests/vm/run_vmtests.sh | 33 ++++++++++++++++-------
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index fe043f67798b0..bdedaa6c58e18 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -1,7 +1,9 @@
 #include <fcntl.h>
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <dirent.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
@@ -9,6 +11,7 @@
 #include <pthread.h>
 #include <assert.h>
 #include "../../../../mm/gup_test.h"
+#include "../kselftest.h"
 
 #define MB (1UL << 20)
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
@@ -205,8 +208,23 @@ int main(int argc, char **argv)
 
 	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
 	if (gup_fd == -1) {
-		perror("open");
-		exit(1);
+		switch (errno) {
+		case EACCES:
+			if (getuid())
+				printf("Please run this test as root\n");
+			break;
+		case ENOENT:
+			if (opendir("/sys/kernel/debug") == NULL) {
+				printf("mount debugfs at /sys/kernel/debug\n");
+				break;
+			}
+			printf("check if CONFIG_GUP_TEST is enabled in kernel config\n");
+			break;
+		default:
+			perror("failed to open /sys/kernel/debug/gup_test");
+			break;
+		}
+		exit(KSFT_SKIP);
 	}
 
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 45e803af7c775..88e15fbb50278 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -127,22 +127,32 @@ echo "------------------------------------------------------"
 echo "running: gup_test -u # get_user_pages_fast() benchmark"
 echo "------------------------------------------------------"
 ./gup_test -u
-if [ $? -ne 0 ]; then
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
 	echo "[FAIL]"
 	exitcode=1
-else
-	echo "[PASS]"
 fi
 
 echo "------------------------------------------------------"
 echo "running: gup_test -a # pin_user_pages_fast() benchmark"
 echo "------------------------------------------------------"
 ./gup_test -a
-if [ $? -ne 0 ]; then
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
 	echo "[FAIL]"
 	exitcode=1
-else
-	echo "[PASS]"
 fi
 
 echo "------------------------------------------------------------"
@@ -150,11 +160,16 @@ echo "# Dump pages 0, 19, and 4096, using pin_user_pages:"
 echo "running: gup_test -ct -F 0x1 0 19 0x1000 # dump_page() test"
 echo "------------------------------------------------------------"
 ./gup_test -ct -F 0x1 0 19 0x1000
-if [ $? -ne 0 ]; then
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
 	echo "[FAIL]"
 	exitcode=1
-else
-	echo "[PASS]"
 fi
 
 echo "-------------------"
-- 
2.27.0

