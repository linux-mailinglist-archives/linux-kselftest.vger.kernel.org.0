Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC550926D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 23:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382719AbiDTWAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiDTWAk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 18:00:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A553DA46;
        Wed, 20 Apr 2022 14:57:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KInIsI009531;
        Wed, 20 Apr 2022 21:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=tLsqQ6KwnxR8ySvJVD4/a33QtGvbjfVSrXNfY9lKlgw=;
 b=mEN8TsdljbtTz+bp3nabxvSadaZVCdsIJoGBfLlhu9wi1VgysZ4+pYHfDMFry8tnwAc6
 QGb6DJ12lhSvT35qb1W92SZP8eZV2jIevkRTkyQdWxJ2o1rtfVeeqm3mph9Qf3RgM626
 YZKDq6rtH0b0R1IlFLZE5EcC2msLaZ3kVlFOwQSQLQfV7GQf/NXViGugbE9CJPp1ZLKg
 m2AP0CYdx/jc6uReY6rD8KP9ihTugZcYo6nc0SRUJz2FhvCwuhKY8L3nrxNpnSdT7xda
 QmSttnaLt+N2V4d0f6ji/Ceqgwa91suCeSyrW0ir48pNzE/6RJ8DJvsWWkOxnZYDDXgC Yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2te8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 21:57:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KLuBj3015959;
        Wed, 20 Apr 2022 21:57:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8823md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 21:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jep9vFtZiMKbWXQNwFYqorqNruvFSZC2AP8aSA19t3hNxjbFyosg2YTgNMDLT5TsarzqDKZcmqGdkZ9BzcI9rYxs64ntltg4rPIC8h3WHtMdKq06OvTwR0smcqm1e55Mkn8mXDq2zckhe22vrD/LgWfmf1OACcDVKf1/Esu6OOr4dl4phpDBpKWG0c8UrbrMYWnf5LhqOk1Oe3FblScvPnyeiZC4sU2dVMU7m7fyZz7mIiXV5P6vtsXdGhtiu95b50JFND8Tc3VStQP171oh3NvJpqbpcgMqMoiSI8E/zE0HQP+/vEz1IFFOn7ffVxAouZfkoaN0tM189EqT5NJQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLsqQ6KwnxR8ySvJVD4/a33QtGvbjfVSrXNfY9lKlgw=;
 b=apzfJGnZezbaWvX1C5ORvpWk6/DvhmKY/XNCoTKARSgfbiLLyiAjT7XSKwVCGSjkCskxvId7vPJXszW++WiC/HGVPDZtLhi1Bm1HrGIqPv4Tdp16L0FdV7g9HI1Q0Q1T3pH3cHbldU6Tc/a3h0WnnnA53oMhI4VPJtROwjUfsKLSdtjhy5HjmEdT/hvmZTHo14mZiipjFzSQp4mACv6tOq+czDo5KuxgkJ36bJJMuTh55uXIySHEDn2l/h19nVIQr+0OlBPaoDt84iP2wnBYUqp7P3WaJiaRa9pXDK8v4zol4B20CxY4Bt2Rg/FhwdYXe2+LNdWLLqPZvSOgnQX8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLsqQ6KwnxR8ySvJVD4/a33QtGvbjfVSrXNfY9lKlgw=;
 b=g1xUbNfSLSMgnmXLk1FZ3vG5AKGgLqzcoK7krsq6IX9VyAWL77kxPBRaIv2cAngciwa395S2ZMgspNL/gw1e/fwKoWfyHY8JtJH6L/AScY5jn7oEdn6jjuT2w/ryOSgYa1WBzSWugJ5oiPM2CoDhotYxa+0EfNwwopsfqTH15PA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5350.namprd10.prod.outlook.com (2603:10b6:408:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 21:57:44 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 21:57:44 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] selftest/vm: verify mmap addr in mremap_test
Date:   Wed, 20 Apr 2022 21:57:18 +0000
Message-Id: <20220420215721.4868-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:805:de::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e7221b-23c6-4e97-9d14-08da2318cc66
X-MS-TrafficTypeDiagnostic: BN0PR10MB5350:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5350909414B923BF8566B55C95F59@BN0PR10MB5350.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCMo77CcVWNShFSGGsQ5wGEuaowivXtL1eW0eC2hrG1sYOBmJcDwSai/GK7kJF6X+7tmvFr+uuOcypFP5i5aMegxtiWjaYgNzyVUR3EGISrxr+IKkuRT7rU3hflrso1/g98kKMIgfCBII7XOROcd/U2myv2ZhGlO2FI8zYssLVkob/P4PXWsDYU2BgnQ2uawC6kNP1H8m5lB/q4Y4i6DY4beym8JGVBrJnLvk3InW2Bwx7qDGTZfY/viQnlcPIdQfvGluq+79hxAjj37LbhGxiVJqHeoEpmHL+L98zdIySkIvnCuq9wUYqrIKNwZqXDrugDW0DqOXwccVOalEvaRZRne3sULpEZTaYVlxg34BmF/2/qTju3qeEZHGz5dEAginTQuYWh1mCdCWKPHJIBAaLHfX6h44rgKQj7y/+lEyIr6g9oDpXlGPc3oLDxWpyDXHdDuJX57bKy7FWH7WVpDpWraLWTzDTvEegVPmakdgHv1YuVvpTkOZO5fQL5LIIHJs/Bz5sAT6UN6HjdR27G9wt9un7w7XJAa4qGnEdlvY/+q3ErWcTOsngQJUfXsV5f0+wNncStZGkAEcLsmyvhn6C+PYIUVz26uZ4398gzF3gQmMcIsyTzXtvTBIu2KlfRYODhE+flIYkQ80c2Fnp3Z2hJVLIMMyyDYb8V2AGIa8zF8+JxPLZyFgD0d/vojvEj56eJyCxO1yrTpSA8IWdk7qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(8936002)(508600001)(86362001)(316002)(4326008)(186003)(83380400001)(66556008)(36756003)(52116002)(44832011)(26005)(66946007)(2906002)(6506007)(6512007)(1076003)(5660300002)(15650500001)(66476007)(6666004)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSVXKu9Spc0A7XT6iW/+vnuGeYvmXDyyCbf6jK5LHBYbaGUvNuRiSDJy2dbC?=
 =?us-ascii?Q?f/GfUGSNFymKSFdjrybOhHYsRrErDGG2ESusY0Y8GP4uma+folZW2VQAiwNy?=
 =?us-ascii?Q?5mIRBdepJfPxcZ0x+P7GhUEZrwWGiSAYnkvv8Ue1ey/H+knm68o9x3AreguO?=
 =?us-ascii?Q?CNb/SDuHqox2qW3mPJx+ZXOp0UCrrM+CAB513VBt7usXo8zPWIKrNdc+6KRl?=
 =?us-ascii?Q?y3QRXCvE9NYEeXsIeke7gldAreUWhcQbyC085xolc3Lwfe6l5Bci9U8aPDij?=
 =?us-ascii?Q?OuodaqHmm2ZqroErZg+fyDnojOMlxhDg3vx4MXKQ1Bgm+uMIFqAK83z7nlES?=
 =?us-ascii?Q?hBfRTY9rymuSZUGpVLsByN2t4NLClECDRkhjOUYiiHulWHiictPLuhUzXjaL?=
 =?us-ascii?Q?j3CL3SZuMMKS4b3vVcKWHAK2YLZjU401PiCBftIspjte2JBnAbEF7ufrK+h6?=
 =?us-ascii?Q?5PfuT2c1Xpht3Q+7Q9N4pch1F+Xye4Q9IpN3ixmaxi5OIccBreWeK0vBrcwU?=
 =?us-ascii?Q?mfneXSvE5ptiFz0ydfu8TQkdoY48RSNaW3G3KqKzpdv/kapF27CO3+CIr5eD?=
 =?us-ascii?Q?Pa7jk9Sk55c5zMTGzchEDopQX35cZqEvqS4Fd0jsy025+3rVH4GTwWxzuR2t?=
 =?us-ascii?Q?l8Z29YeEumuiNTkGdAGizKumR5J1gTHKaRy41R38ds5PlkogFmaoKsbEH0io?=
 =?us-ascii?Q?JN2ODpEhk8Qhw6DpGkDn6Nga56ZT7MB8JWVhhSd8VGE93lntQw0/nEDHXYDD?=
 =?us-ascii?Q?ZtBT7WBIacEmH+PVhW1FjyPt3Oa2Q9GZonJfD07RAhU8ZOWeQuRVIK+Y1SDp?=
 =?us-ascii?Q?8EFmASksYjOVAASxB5IU+WIEPaGupcO4jlxveROTN9sQuzhueGJ+gJyRJfIN?=
 =?us-ascii?Q?vkINgspgezdjQQI4E/K8mbvLpvOvZBGCWoi9o2KCypYjVhsVtA5rdcLgjrc6?=
 =?us-ascii?Q?aesuPFbtHucDatOt6XF5TeozxHfl9bgVA+EB+4vVUW1CV4h0MREDN2SuHilt?=
 =?us-ascii?Q?JEekJtYkF8/ZWIrJ1eaF/Hkaob6ix9RgW9om+lrk21jKzE2uUeKGwblN2vN8?=
 =?us-ascii?Q?51Yk1XloehsmvBazIRoe8c+35rMF5hrG3wk1EjphuzGGWrk6vdtyMI9g32lc?=
 =?us-ascii?Q?zqv5pw0l4fxPAHaLkW1vYtF8vD49EBvoupO931x0lRJox9dlZxxDhaUCEawv?=
 =?us-ascii?Q?N6wod3tyoLaR0jOxoJ9xqkB/Jjgpp/Onu3U2ebUVLuJOQWEtK3Z2dg6bY8pl?=
 =?us-ascii?Q?hzwvcgl17KOdfBh4hqfATJGbZWhGIkwWLASXVTMvS/+w8Eih6dGj46bBBj49?=
 =?us-ascii?Q?1gMptwfLxpYOCkdjPOokCqSQfPET3zOG+sb/0cRnu/ie2vq3e+kSmmNepIWL?=
 =?us-ascii?Q?Mc3Ns+afeXefeyzMxkW2nqCUus3zkRwHP3qghIyJjG7snrDNCJYzgsgt/HnO?=
 =?us-ascii?Q?AAmGZssKWt5rdvyakiU45YueI2CN/WtlYkaAH14lsIwQ/bXhujWcqG08p3hn?=
 =?us-ascii?Q?vfb9z5BvNIj6TnRNpS/WckbWPBdFkX01wPwLh1Z2Tu9G7YN7DiwhefmvjHNT?=
 =?us-ascii?Q?67ryvbrhOiky0bzZiETCrUhuOzyEkTkplROg1JN5YJWtjVvj3z31xfE2ssNO?=
 =?us-ascii?Q?k49CqkcCWHJ91Nz5ETABT+OgeaqWsBRmLdIuB+mglTf+dCu/7s8N3HBW3b/R?=
 =?us-ascii?Q?LyLcj8J0YUPgsj3MPPUXbhDwwRhv2VdFwAbuzj/b8nAh7xpE52KmaaJ7/eCl?=
 =?us-ascii?Q?pRAKqkr6Mt00mVj7sWdsb4bWaggR7TY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e7221b-23c6-4e97-9d14-08da2318cc66
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 21:57:44.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aqZ3aPDEFniKxz8+UiR3r+46C9viMSryrJ4WYDHM/UkltO67aAFgetyrxPwy7mbejPKwV2BeRtgLxr2VXYZTtXiLHjRvr2CNnP8ageKixc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5350
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200128
X-Proofpoint-GUID: aqTgcwaqHSVa7QiZLJPtxpr_Zqqg1JvD
X-Proofpoint-ORIG-GUID: aqTgcwaqHSVa7QiZLJPtxpr_Zqqg1JvD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Avoid calling mmap with requested addresses that are less than the system's
mmap_min_addr. When run as root, mmap returns EACCES when trying to map
addresses < mmap_min_addr. This is not one of the error codes for the
condition to retry the mmap in the test. Rather than arbitrarily retrying
on EACCES, don't attempt an mmap until addr > vm.mmap_min_addr. 

Add a munmap call after an alignment check as the mappings are retained
after the retry and can reach the vm.max_map_count sysctl.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
v2:
-change comment for description of get_mmap_min_addr()
-fix commit message formatting

 tools/testing/selftests/vm/mremap_test.c | 41 +++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 0624d1bd71b5..2b3b4f15185f 100644
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
 
+/* Returns mmap_min_addr sysctl tunable from procfs */
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

