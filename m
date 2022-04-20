Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCE50926F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 23:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiDTWAn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 18:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382726AbiDTWAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 18:00:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E563D489;
        Wed, 20 Apr 2022 14:57:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KLbMha019753;
        Wed, 20 Apr 2022 21:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=WycdjKiNqmEMh+xFeVDykSO/BvYKbAnJWJ33/MmaFIU=;
 b=yuzvpLz5NhWqYPL4Vu7HgPK9aBrQ8YtAIHB8QqHHn1rv3tNHJPtt9HyGPmwp1wVNWQJg
 xL1xRb8MJCccXav/JeojNYbCaNrRQYn4VWA8x8ADRpzh24S7JQBBIbMlK459V02T52bM
 Eokh7Moc72CWipeWji2YRzTqSPA+GCL0c1CeaNh5qK7GEmnvpWdduw8mem61XbsROo3m
 J4dEZOZKK3T9LIQ6NArRwF8ZxIvTRQv4L6H4+n6Fo2cclVH6qfkx2Ou6fbr05s7E4axA
 W+VOsEfD3XMNolIpVEL4HWgPPVQbc9VhSB9ZCtDy82tMaCHJd7xo4Z9ALgVJJv24a/vB QA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1agv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 21:57:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KLuGQa016193;
        Wed, 20 Apr 2022 21:57:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8823p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 21:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fupFxWnyxsBFXJlkJgeN0DAnq7SM32ZK45D41w1x0+TaN2J1OImNY5UYP3I+sxySb7i4+UTbszDjVPyHPs0z1Q8IUyS3NN8qSaT1L6MjGgcN6xFVV1YcHts4DBXRrVgTAx3QtCTe1NnQU7G/vnuPUhLT9S9E9etscMWF84Nxx2pugZeWfxcgyQsYnQy/LJB6pHCFC7tM9jO3iP4CfFkKzI72DX2LQIvMemtzH85M5sJ0pgPH2Sh7tJkULLfJhAUnG9lprlnTUz2TQbXQ5o3t7tyWriGj9eGf52aM80JfvuojkE4SmKlEkEATRCj6JRuUn2HDpiKccvFJU2PmLb5zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WycdjKiNqmEMh+xFeVDykSO/BvYKbAnJWJ33/MmaFIU=;
 b=hY0dVnnE/WpW4k1BgX7YwpkvMm3XbwanMV8D3l8oaHh7KZSMaccoLrMkUU2VU9E3mcElzH48JbNM06PgZkN8uXqxq6s4T380c51Q15s1szXlHMtYWcOoTZ41fmz3Whd6tW1FHMhahBZWccHlru2CDKcTqpHTVON+/ao6Oe1D3n0CUdvJ3y5I1RiawBvypN3cOpQ2BMpexgAuQwsOqVLrzhBz2W7cF3DqXUX6RIIFF0V7ufLG5Mx6T/E8Bu6itWXLIpK8SG2xl62ozH+8fLarsENpMPsDP4TMjJnOO1NvmFaKH6i81fomHY+iGJv0opOrmwBcOlKN+Y0jlJ1pbF1wRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WycdjKiNqmEMh+xFeVDykSO/BvYKbAnJWJ33/MmaFIU=;
 b=tFB7fI6vx9LNrhek+c8ydGVbfkmgf/Jj6i29kDq/nrIkulYRTY91WziuPHqee+hObphaxEtNaHqbztlvnODYFsSGnEuy0FqwcEMWrfzkfckjVJSehhEZ5/c8HbOw1sS7RL5oFaXsXVo7qO1D15xoEc8zpiv6u7hBL8wxVQf6Wn0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5350.namprd10.prod.outlook.com (2603:10b6:408:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 21:57:47 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 21:57:47 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] selftest/vm: verify remap destination address in mremap_test
Date:   Wed, 20 Apr 2022 21:57:19 +0000
Message-Id: <20220420215721.4868-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20220420215721.4868-1-sidhartha.kumar@oracle.com>
References: <20220420215721.4868-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:805:de::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 492aa591-bf3b-4cb4-e758-08da2318ce4a
X-MS-TrafficTypeDiagnostic: BN0PR10MB5350:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5350D6161E0FC15E61F1CFA495F59@BN0PR10MB5350.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVA4rj2eoQQ2QXlb4i+5rUDOuWbFr0FY7RoGAQM2eDlCNoAp2d9W5XB7z8+qV4UU+5EyKt8VXKSGkpv2CGZey2NYHHlMS687hhsHSN222zzI98Q+8YaCfZBGs/gAs8IMS0RvZ602PJFGziLrQNexzRrhnCt4y4+OVvd1nh+ptQE3bW96roTdcwEzlB3SjeWZkmOluRucGZtnFWQIDB21fm28eVCXoQczrX/LtqzLm75g/XNBeK1Su7q9tu4TSVphAHnNuZmPOf1gTN159DXpJgnzzCbnvKFVKtU/x0RqdPM/er505VkqlR7o5kfIbPu1RSvMAre27W8U89ip6ii3qGeyFG3i/kvrdYkPheYjYhyT7xjZFMg+9peQU6SYmbBfbuike/UOkPKATV6+BciVxFaUnfXMUlq0X65kuvQb1rc689EBD3iE2Q5qxasQzo/nAQoOGLq8Qraeay5hYu8RCv3oD04+TIuRgn9WUTbtNqQyBThEVTlmQuMTCDXQJEDTh6EnnvEvq3iwZuqAPvP3e1WWYQRe7yrovuCT6ed3B2ezf+J3XWIyt44Uf1yB96V5FkwaekWSJUi1s3DzOyoHl2wkT7dhWeu62iY47gHObfv0XMrkFJwg/J8orfcsVb3VAOQJt/OpIN1rJxrIDLufaGBhISsySURIxrJ3CXnw9COFWL7Yfk/8QS/VlDtH95b0jPzYJ9nilRspt1pXfz8bUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(8936002)(508600001)(86362001)(316002)(4326008)(186003)(83380400001)(66556008)(36756003)(52116002)(44832011)(26005)(66946007)(2906002)(6506007)(6512007)(1076003)(5660300002)(15650500001)(66476007)(6666004)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3s3ewYO1NmiWCTLee23jO5ORkzr9+TqgqgPaBzIJPXrfy47zYfQvjFJmZ4L?=
 =?us-ascii?Q?/fV72E989/aJ/bPCxjlxl7pgRoh1NMj2cCgR2eq6ho2dKVzoXZw6+PGHnVXV?=
 =?us-ascii?Q?x82AwehFfQYZTVzUUNetVb9L9fhFN8mjb2dTqAtawBkab+XeGLSvC95O/WaO?=
 =?us-ascii?Q?kEXwMNoJy0XX/bNMN9BrN4im/VGvQLE/8yb3kPBLqrciDWddgP+SuAAaDxx4?=
 =?us-ascii?Q?tsZCKm+ucReGlBX9XMa9TvqHj2TwjlwZTFB3EPQ3bgZOxK39iSq7/KN2eaxk?=
 =?us-ascii?Q?gTrbd0lIDn1TNTteloXmOK73heNHGLCEgVq1NethYfZq1nz271Wa24luNLgJ?=
 =?us-ascii?Q?SoQUWVnW5bnUJhC7oDSUMVFtsSyZ2JjKO6L9K+yD/PCdjviTugJus06xTv8I?=
 =?us-ascii?Q?41jG3E1Xb0zmb0GDNLLBeF8q3r8QSCur1sqmXqYXkTxNKdLOG25w9YWoSNhU?=
 =?us-ascii?Q?AgvS0EMGZQDXJFGhegeO5G6wSCy/q3ZeyiJlbCXCSu56D/ZQ/+5VcoXV6L5X?=
 =?us-ascii?Q?qGVtSiAMZR0w5mg2vl7bX6hmbUt/LpvLszbSyg/V4qrCRBxF2u/npCfSV1Eu?=
 =?us-ascii?Q?ebsMRklU32HkVzUVIqCXSs12+TljZnfLw6MQzG96SGDSuVAz4y2b33rqnSaf?=
 =?us-ascii?Q?BM97OJhiua5hIKuAGI5DDDoXIJGHsBIYuYfR2+9hyQFvdvSwel9WnFQ4cQEg?=
 =?us-ascii?Q?A0TEJO+pYjFa4NhCCltELfilUhaON0MalkLgv6c6PxIzzIgjg9v2ICsg9HYy?=
 =?us-ascii?Q?fn5VrWxx521o2euB/S08T7NUaIy5HuzrTDxW1rBvH1CXa8HqGKWuwHDeTYoA?=
 =?us-ascii?Q?0OwC0fAgojkpXqIK2OVQVC0vIkA0p19gWiuyioCd/7U6i/35gXZUc0azegoB?=
 =?us-ascii?Q?etaUXHGlsi5aj7dP+KKQsFj9pUKE2frvvaMFvY+galNyKn7onPgkREF/H0cm?=
 =?us-ascii?Q?hh3zfVqeUTMr5htvF/GtCt7JIiieToORsQwV5mMaVfSe/Omb8M0xEwfc1tNH?=
 =?us-ascii?Q?+elRXU4gXxvVSCSi3AOKjv+/QgaP6IyAYIMbnyhp+NuA2jL0tWFib1DVVGhh?=
 =?us-ascii?Q?m3nn2gjI+/azBx87PQEGFazIfcLLmuP/t7fv4a8xFDPpNy47FEKV8IURQVGp?=
 =?us-ascii?Q?XHmbvJ0RII+bMbvCxb0z32mxiDWzUg9gAXs+dt3RKRmX3MqWmkydJF0HLyZ+?=
 =?us-ascii?Q?p+rEELd7TUI28dWWW3BaYn1/mzmA5Wj+b4wZTwrmsHZa4P5BuKBefvMqN2Wu?=
 =?us-ascii?Q?JixOYBrGEXIGEUHQmgJa8PzASVXP7I6jHuUd5lNGEISZNaCmarGjtbi5ZRLn?=
 =?us-ascii?Q?FFG4vOnRRLS0D+7yEDH2lX53TE4FcJIJT049LvjXZlkq8LZPMcSRfCx3CrMC?=
 =?us-ascii?Q?HllDpFDMe7vq9WcBfkWpF59orO9T7uV7qeGDneKGrdqlfbgay4DpTxnjMpl9?=
 =?us-ascii?Q?9xKDEKAjKS9uYQ5HsWUIddBd2tg/7GcFpyrUrONnBzsbHp4Sj55kb7WfZkTn?=
 =?us-ascii?Q?Ecf1hUHrkaLBXr8pS4Qi3nnSvxfNFN/PUlmpYnwzoP7Dl+NEkh7n3WtjkyL6?=
 =?us-ascii?Q?ocnQ27lQ9GZr4wvCFh1wo8QGfLA1OaQaDA9DrWmeDXFxLH5/7b7N8KkTTaru?=
 =?us-ascii?Q?tk/TySBYeickHA2GnXj2JxW3SWTldwgW6Xo2hgN2xijQ4opCXIoziWQAMKGH?=
 =?us-ascii?Q?zHfZfe8yNOeyIV8FnefDzkJTDzGnd7gCUoNjAd71Kza3sHtxZ/L2qOgKJ8Ft?=
 =?us-ascii?Q?nbLsGE+qXLoH3HnlvntChMmxwWZBYQ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492aa591-bf3b-4cb4-e758-08da2318ce4a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 21:57:47.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6OcFB5CCfNsJNOtJHbcbhqmkGg4nG/DadvBchxNST+s/5qp/cbzt8i3wsFZriL9cm4f2S1mg2e4EoP0tsNtnoHQU6FyUQEZs5DHiE78NQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5350
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200128
X-Proofpoint-ORIG-GUID: pN0kphForBB1PCry6DTyRKtsSvcvSOqH
X-Proofpoint-GUID: pN0kphForBB1PCry6DTyRKtsSvcvSOqH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Because mremap does not have a MAP_FIXED_NOREPLACE flag, it can destroy
existing mappings. This causes a segfault when regions such as text are
remapped and the permissions are changed.

Verify the requested mremap destination address does not overlap any
existing mappings by using mmap's MAP_FIXED_NOREPLACE flag. Keep 
incrementing the destination address until a valid mapping is found or
fail the current test once the max address is reached.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
v2:
-rename remap_region_valid() to is_remap_region_valid().
-change return value of is_remap_region_valid() to bool.
-take out overflow check from is_remap_region_valid() to 
 inside caller.
-fail just the current test on overflow rather than existing 
 the program
-fix alignment of mmap calls
-change "can't" to "couldn't" in error message
-increment mremap destination address by dest_alignment
 rather than src_alignment

 tools/testing/selftests/vm/mremap_test.c | 42 ++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 2b3b4f15185f..e3ce33a9954e 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -10,6 +10,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <time.h>
+#include <stdbool.h>
 
 #include "../kselftest.h"
 
@@ -65,6 +66,30 @@ enum {
 	.expect_failure = should_fail				\
 }
 
+/*
+ * Returns false if the requested remap region overlaps with an
+ * existing mapping (e.g text, stack) else returns true.
+ */
+static bool is_remap_region_valid(void *addr, unsigned long long size)
+{
+	void *remap_addr = NULL;
+	bool ret = true;
+
+	/* Use MAP_FIXED_NOREPLACE flag to ensure region is not mapped */
+	remap_addr = mmap(addr, size, PROT_READ | PROT_WRITE,
+					 MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
+					 -1, 0);
+
+	if (remap_addr == MAP_FAILED) {
+		if (errno == EEXIST)
+			ret = false;
+	} else {
+		munmap(remap_addr, size);
+	}
+
+	return ret;
+}
+
 /* Returns mmap_min_addr sysctl tunable from procfs */
 static unsigned long long get_mmap_min_addr(void)
 {
@@ -112,8 +137,8 @@ static void *get_source_mapping(struct config c)
 		goto retry;
 
 	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
-			MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
-			-1, 0);
+					MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
+					-1, 0);
 	if (src_addr == MAP_FAILED) {
 		if (errno == EPERM || errno == EEXIST)
 			goto retry;
@@ -180,9 +205,20 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	if (!((unsigned long long) addr & c.dest_alignment))
 		addr = (void *) ((unsigned long long) addr | c.dest_alignment);
 
+	/* Don't destroy existing mappings unless expected to overlap */
+	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
+		/* Check for unsigned overflow */
+		if (addr + c.dest_alignment < addr) {
+			ksft_print_msg("Couldn't find a valid region to remap to\n");
+			ret = -1;
+			goto out;
+		}
+		addr += c.dest_alignment;
+	}
+
 	clock_gettime(CLOCK_MONOTONIC, &t_start);
 	dest_addr = mremap(src_addr, c.region_size, c.region_size,
-			MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
+					  MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
 	clock_gettime(CLOCK_MONOTONIC, &t_end);
 
 	if (dest_addr == MAP_FAILED) {
-- 
2.27.0

