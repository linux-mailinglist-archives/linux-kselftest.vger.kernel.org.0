Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3417C5019DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbiDNRTg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbiDNRTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0F4630B;
        Thu, 14 Apr 2022 10:15:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EGmU9X008887;
        Thu, 14 Apr 2022 17:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=VLpyCX0yjxAxu6ZycAniUTGqJ77JJFiBrIjSukyXEHE=;
 b=AreQT5W2JoSVzuOeJ8igdbcIPxQCooqLiNuPM7Vuvvdf5WXRWTguveAuebL/xeJKNzkc
 MFh2p3xwUWMFv4U666ofj8vixjjjVAxRvUJv7PdiPy1tRHbpl0NVmu7dnvLCnt9+rhDf
 mTU1Tv+0zTRE/JYbJ9LMLdzpv0+mK2WgV94s9TQoC1ZnTxdpeXKqIdWYZ9OWVuPW+ipb
 hB5QvACHLLMzkRJUpO7fIR698q7Jw7wGJ2JX+pBC2hw0QtAsNPCbDjJ7BRatFc09DQyJ
 z0+qGQnDL2ZK1PQElzwGZ8M+WYf45T8U/wTznQcQL0crWOhQHgAvz3m9LD1T4VGBBsmZ AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2neyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHBPGK016054;
        Thu, 14 Apr 2022 17:15:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k50a2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XO7J8IXFDuci6JrduIkyV3WuUMdgqC2p8dGHMZM7ECuyK60zZCq592LbzO0FrEsnJf4TH2kEmR+WiuwhbI18ijk14wzsTAg+W1trkaDMVxbPWRkClhd7k5CxPaf+XdloJhEe0V1k6xI7nHN23Bcv8cFH5pEFNM347Ro89Hi5zUPQCjyuabXBW3S5GCzOdZWTQlxZoBgqr2udUtROvSZD/sM8J8YtC6BKw6ZYjEaPZUoNXX1pED0yIiUHK5k62cE5J7IlQjFmM730bw6i1QpJjFBQb+Ctq6TnSiJVuh9nTaV4tYfUbiGOXjfF0UdsrxNFQB991KV953laqWlpVQk7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLpyCX0yjxAxu6ZycAniUTGqJ77JJFiBrIjSukyXEHE=;
 b=E61tqEVqkesXmf9yyqgTnpUmXeY0uqaLPTqdePaGncUN1kXe8C9wE31cSEhRtkeZtoW0d1f2XI4G3KBo+ODiIlY8O94V6rt8GfRyDQZksmy6XwnEWMoAoUTeQhSN284URTDrcyGvDQ51mgN4HCpxuZhdi1QbKNyhEHkXk9oSSPDUKDRvC2YOaQjbLGLGn2r+8njwN+1Z/+WKM9py2v21jMfjA41Uu6RPM/XYcvDZw1k4mIqJZBSPUSVDeqSYPazBLcC0s9fid8HM3S5ZHo13zoeOrZvpetMGsStRutia27CoUnDoCg5ZtqHGwyloe+Cyj6Pd92vCjauLDDDxkULJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLpyCX0yjxAxu6ZycAniUTGqJ77JJFiBrIjSukyXEHE=;
 b=kxWQZVwHR+uEtj4mQVjl9GWoJqjcLkFD/PqF50JGzMCzmtlOF8N4UdBZ1jsRPmyKr1rnZCLr94VXl+lBAsZiWaJKVUtbvTTcj7HSwp4zYfwQfsjTQS3z+tWMIaETtkoZ5RdJzIGHPNqv48QdP/umBSzwVHOPzB61aTXrTdAo6yY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM5PR10MB1516.namprd10.prod.outlook.com (2603:10b6:3:7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 17:15:41 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 17:15:40 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] selftest/vm: verify mmap addr in mremap_test
Date:   Thu, 14 Apr 2022 17:15:26 +0000
Message-Id: <20220414171529.62058-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
References: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0007.namprd04.prod.outlook.com
 (2603:10b6:803:21::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffa977c4-0653-467d-e065-08da1e3a66c5
X-MS-TrafficTypeDiagnostic: DM5PR10MB1516:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1516AB908CBB447E1196AE6395EF9@DM5PR10MB1516.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTABynwnnmoHj90dEILMC2h+hiGvvtMbAhtEtcb7Y5JUlHpOMg6u9lpJ/luJjiD4HBB/0iwKXiOCKpYfVNzaOMeTt+/9Hywq66hZjak769UHc/CUD3G5vzATZ8sfoTyCVDaynKkZVEf5hYlWDzyrHXb6Chuk5jJ+gKq5XT+6A+6dWVrycCEfeyrHK6yGh2Jesxb7DFEahOahrDJ/6fFb7zUpSxvjZVQVuX17vOUlKiff3q89wS+PVHPHw9RBwtf7hzgrt9wHetzNMj9pl/DIETYiEoxQNh1PJaCsIYrnXwjtbD+sc7+kj7pi+8AhGJ4/IZmGem736wik3kweBIw81aplEnBwVf4oMWarZ17a6Lv0edilgvQ/lTB6Pl1EBuNNebnQV5GwuwpUYDyOsdekmWdCS126AEiIeA5Bt/7Mpih7yIKRt/xKrsr8wf3EnFnlZZ3s29OB6HMpIKPYx5lA7x9tYcLYmsCw1jPB9m5dB8vlc2mgHvusJHzgrSB8UgeOn6FN9F+mfcUQFIONcMoFzcUmNvatlO/0ReKpjSISGmLcPVP9d7qi2h5KBSqkASc81NePTE/UX+SkYomYIqxvsuDrMEZBazp0QrLWQsjByTWu/iorVJ9E3az7ADPxzBxgNJIwhG2NM3PLfpTcJEEHOs9hzAigAviEmTNSrE06zycw8fByLBDQpDoAGbDLVzM2DMYYqCh5W8/H1gTgX0bdjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(8676002)(5660300002)(44832011)(36756003)(6486002)(52116002)(316002)(66556008)(508600001)(2906002)(6506007)(66476007)(6666004)(8936002)(186003)(6512007)(83380400001)(2616005)(26005)(1076003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FYkqross/IQrDx5qp8DQp8U95mwfLiehRRvwcrBQqJGDVnoLQSe4OMMdIYmI?=
 =?us-ascii?Q?0q8jVOprvnxnxxoOpoqsMHQKZKTw4UMz39GNzb4t2TzWiidqRdquZTva2Zmh?=
 =?us-ascii?Q?0JCDzhyWXV1GBTIgZKm6wIfQXOGDJsdk7mwAwnL9MUGZG82oUjbI1xuQRwjH?=
 =?us-ascii?Q?6lhTEOZyGvmLkfdp+DwlZDYVp0Iyo0sXhR1kEXL9VqdxxsTWFC1sTFxNvUjo?=
 =?us-ascii?Q?JkJKUHKN/UlM0D5wlzNqWoZl2A22Dn+DQQj23vXUNVlLXZAxR83b263g/0zA?=
 =?us-ascii?Q?Nx++0FpfQrbO9zDlFjxOs7gOWIqMQmqkUw62ZpB5Va4zhMZuTTAeqPv6UDA2?=
 =?us-ascii?Q?mYiHe+z0g0n/zc8HEmirdrORIEjV1u8CvMSDAk58fqfTDyhwJMOUYvE3ahJD?=
 =?us-ascii?Q?8mmK145JJPqZ2Suc7JUe/VKquAaHNTqxojhhIqdZvKEkxQGWhBlIspUEk+za?=
 =?us-ascii?Q?g8BrWEaSbAYtrfXzlVAUC164wAvqr1pquNaEayZnSLpJ1dxeh4CyO4pOOQTp?=
 =?us-ascii?Q?fk7Olm1S1deQ3LowBPejz97auCmeYe6vOnsUm0PJbtZXrNQQX7+KR9GPeEx+?=
 =?us-ascii?Q?xKssTRXj8Z8TmadPvBD/3EyY5sSPNr4zQURuC2MgjOfY5Mxlu41CfRxdtU8M?=
 =?us-ascii?Q?e9rZFGxbi7AEJwaWJExht2E/CqsSABPkdbMrEfKg5QyqgL5u3bFH8rWgoPto?=
 =?us-ascii?Q?r5aOXkVyIuNl/Yik6KkJRlufrM5ol/mOvoxoO3rm7jMGdmTsgxYTR0NDhywQ?=
 =?us-ascii?Q?hEtitXcn8J7K6eiyq+5cTDb8K8BbX9N5bSFQNuclLYkR6rlreMkASk9VYeJ7?=
 =?us-ascii?Q?ehcQqalJE4z0ndFeyhTkgqIyV5LRZpmJyN8qyu0AU2KQVaiC9WBD5P1OV55G?=
 =?us-ascii?Q?s6muWRi3orKMms3hjRiRkpV8n22JLNOaHrpwAwbp8geVudydOGpbVxSx0qw/?=
 =?us-ascii?Q?84Xal+5w3sqZI4djEE/sjuias4meE8W0jzD+YkMre9bO4E2/n+C6/Ssq2oNO?=
 =?us-ascii?Q?megthUvQPjE1yPsRgPxW/FaaxywIM/cDHqidPGUCyijUzJUgosC2jRNRa78U?=
 =?us-ascii?Q?sRWX65cKw1P+6s0UEGPonXbuxrzNgRilgtFf3CNOCMAbJMWNyOejtBAlrnEY?=
 =?us-ascii?Q?gQn+pHHdb+kzrw6PqvwjlvaXPsMB5aRKna4LseviJ53ZEKIu+oJYacEGHSbc?=
 =?us-ascii?Q?x8IEq2Bbu5/Z5eJbkCRB4AB5Or9GbkZiRFQrJ0/EcUl2oa4QEewysNZcddXD?=
 =?us-ascii?Q?1z6WTrLaOkyG9QIxuSO+D2slf7f4f6sLR3yIAkIUPNrdsr3uhAJkk82/HWhG?=
 =?us-ascii?Q?r9mwjXDkaoa48TF0cll+TkL4otNpKuy796J4f5Pxsb1reV7qDkpX4L+mxp0R?=
 =?us-ascii?Q?BP4NFmDetaN84uCBAhMWStlP3OamjJB6BWnP0mnki0cMhrCF4fc9IaSqWTny?=
 =?us-ascii?Q?fh3RZiwXBaKMWRruJmK78+NJxu2Q3J5LTxYz08p7fFrbrcwQjXZ5743yxL/I?=
 =?us-ascii?Q?e7Fm10L44P7TBqZ2nFrScYuSv2pxMNcDvderdE2ZqcckIGf8HqNbfIAZ1HZt?=
 =?us-ascii?Q?Faj9nviqDQ7peW+Ndbw/Lf9ZS++wGt8/s+Y1uoYB9Erlzhy97D6XfIxj2Q+y?=
 =?us-ascii?Q?82Zhsf/AT8hE6ggPbj1dZrc7kDBLOqZta74IPjkQ9pHxmLCmjdR5aMc+qslP?=
 =?us-ascii?Q?mjN603X2fJLaZYDIM1rCxf2ojpKxBEarwL5nzwpt1sTaJQVu78kzYD5RvM8A?=
 =?us-ascii?Q?1A5q1Spsgyk/7mCsdlrjOoYEv24O0ik=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa977c4-0653-467d-e065-08da1e3a66c5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:15:40.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaB5YMR4zlj+AjOsfXmh4WfLEHsa2F6xF2i3HMnIQgHjXmHQW5QvzEKFbD+PFI61rg67LVgukk+vSW9dBYsP3uFE9DfMQsNCLecuiR+2Fto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1516
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140092
X-Proofpoint-ORIG-GUID: j4NuLrqeGoPFuI0stfdAncyLKm-ALcE6
X-Proofpoint-GUID: j4NuLrqeGoPFuI0stfdAncyLKm-ALcE6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Avoid calling mmap with requested addresses that
are less than the system's mmap_min_addr. Running
the test as root returns EACCES when trying to map
addresses < mmap_min_addr which is not one of the
error codes for the retry condition. Add a munmap
call after an alignment check as the mappings are
retained after the retry and can reach vm.max_map_count.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 tools/testing/selftests/vm/mremap_test.c | 41 +++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 0624d1bd71b5..58600fee4b81 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -6,6 +6,7 @@
 
 #include <errno.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <string.h>
 #include <sys/mman.h>
 #include <time.h>
@@ -64,6 +65,35 @@ enum {
 	.expect_failure = should_fail				\
 }
 
+/* Returns mmap_min_addr sysctl */
+static unsigned long long get_mmap_min_addr(void)
+{
+	FILE *fp;
+	int n_matched;
+	static unsigned long long addr;
+
+	if (addr)
+		return addr;
+
+	fp = fopen("/proc/sys/vm/mmap_min_addr", "r");
+	if (fp == NULL) {
+		ksft_print_msg("Failed to open /proc/sys/vm/mmap_min_addr: %s\n",
+			strerror(errno));
+		exit(KSFT_SKIP);
+	}
+
+	n_matched = fscanf(fp, "%llu", &addr);
+	if (n_matched != 1) {
+		ksft_print_msg("Failed to read /proc/sys/vm/mmap_min_addr: %s\n",
+			strerror(errno));
+		fclose(fp);
+		exit(KSFT_SKIP);
+	}
+
+	fclose(fp);
+	return addr;
+}
+
 /*
  * Returns the start address of the mapping on success, else returns
  * NULL on failure.
@@ -72,8 +102,15 @@ static void *get_source_mapping(struct config c)
 {
 	unsigned long long addr = 0ULL;
 	void *src_addr = NULL;
+	unsigned long long mmap_min_addr;
+
+	mmap_min_addr = get_mmap_min_addr();
+
 retry:
 	addr += c.src_alignment;
+	if (addr < mmap_min_addr)
+		goto retry;
+
 	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
 			MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
 			-1, 0);
@@ -91,8 +128,10 @@ static void *get_source_mapping(struct config c)
 	 * alignment in the tests.
 	 */
 	if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
-			!((unsigned long long) src_addr & c.src_alignment))
+			!((unsigned long long) src_addr & c.src_alignment)) {
+		munmap(src_addr, c.region_size);
 		goto retry;
+	}
 
 	if (!src_addr)
 		goto error;
-- 
2.27.0

