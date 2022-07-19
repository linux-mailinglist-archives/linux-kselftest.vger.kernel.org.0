Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C847D57969B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 11:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiGSJqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGSJqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 05:46:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7496594;
        Tue, 19 Jul 2022 02:46:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J872FW024566;
        Tue, 19 Jul 2022 09:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=tYhTDaiKvaCpdj5IormPKDV/QN7a5o8gORfTDx4gHiA=;
 b=wTBV7qcz62YZV8EyYrUyp8M3I2XtLVKsLylPCEF8jlj5Ted5M+46GV6jayTGW2z2nqIz
 aFGt+v20AHpxCTP2Ok+Z+kBJTaLC4ZA5NQ8hqKDQbAy4Aow1K1HD0ayde9KX4aiSj1J1
 k7dmpjxDzo3GBNX7zAORNmZlyKMydSxtkG9QJkDpC/nhmmNZkPCaFrrezCJUhffQcqUE
 YLc0jNnb12LSOptHhi7+R6WY6HcZhMBiNPDle31jk1BF8irKD/ikXStvvuFpVY1SOs6o
 UIjxtmfOQuL4ktfY90OWCXX6yfkrQJ1i5jOzyeNdOp5iaypmRQ41fMNG7hAEkLx8fi1c RA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42druy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:46:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8ZhKA039355;
        Tue, 19 Jul 2022 09:46:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k4k52q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:46:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4VWa75wcNuy8FkPDGVf2h0HgJ6MD7yy2T6z3hwALYFjdVHXsoa33sljGOELrLU6hNvbRElg6bVqybQsPE2H8YfbCXQZ4UD8lRcI+n7/BdBdzBFxxN4ASKR4BCOgI9v72PyUUxfsWvR3sUhUi0IZ8fKPXCJNgced+cNSosw9uBUuvuIoT2exjHnw25Zlfx/ISDV+mBVzJATworlz5h7TrTPWB0pqtcWPGu6r1IH83ytc/Kb8LhruTd9+wFHN/ZSiks1dtAPEBnPr36Xlfr9FhSSIOsn1NiZgYADXia6ah9enfA78zT2EDyeTjKXWROjZIuxY6fImUJvZSLCikZETCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYhTDaiKvaCpdj5IormPKDV/QN7a5o8gORfTDx4gHiA=;
 b=BaBXgs/3lCyZgX8exBTNA48va1HYZRbl8iAaSyNyw5rmQnN+gtrHA7xtXyuJz+0OExa4UZqHD47O/u68pGrWYMT5ZkL4A2P03d0VViJcMI1PSGrSUCz27LaBmofHXKUC5sdCZ22ZNckSO6jCSaRk3a6yI0DqDjsfs3OJOQDBkc150VBwnBIq4wJS0VxVOFiXNmIgCmBo2yPxq307rkgqA+dYoZ+0jKKsW1DUTXobg703REq8g2gMmqtWf+HqYeNMn/TKVHlEC6FwmTJoINt5gZNSHohkc2Yj2f2SVq1ARiJ6aQZZsLKoJXMdGrq2swe25L94jN22CFBh+6LqxMyHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYhTDaiKvaCpdj5IormPKDV/QN7a5o8gORfTDx4gHiA=;
 b=hLBXK37Deydb06HR5uTiyNGbyLNFRhGauxxMSXS8Sx5llEVVVr8+RoGtdkMsiCHaVnU7vt7PnduzhHZS+8K5cGPyVRNje+Cgw7Kz2N+Q4xyKe8wdh1f/UZ6/zZeJJVQFqUbJvYDTMxnukg0LD9h2WctRs1JWLmOq+8rTL74c/H8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB5924.namprd10.prod.outlook.com
 (2603:10b6:208:3d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 09:46:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:46:23 +0000
Date:   Tue, 19 Jul 2022 12:46:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] selftests: memcg: uninitialized variable in
 test_memcg_reclaim()
Message-ID: <YtZ9Yu6HSQ2sT+O/@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0162.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0583674-114a-4282-2ace-08da696b8a96
X-MS-TrafficTypeDiagnostic: IA1PR10MB5924:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yViyR3Qym5D+b1bmwZi2BRYt5ITL4xR9uvFXbNJ0u+Ss9uZq8ViGxbs27+wTmT8lxKNzLk1jM7U4JTAToNaz3xdEZKi2uQ2/p+b9DQnJ5Vtjn6CNZo6a6apdA5dITu4fpC3nRztQygbFdwPmUwVeF1jyCUbLgSXZMwNB0NpMAqsOmy5s0JuxescWfEsmeiwIlw17Pv7f7LOzQ5GLTLj4i0hXVz2fTl5XCrf4h526MEp1hoSnlQFsTSFt5MI0ASqfY1XRAIQvxxv9BQMMlV66C+Q+MS3UYT7CCirJQSbWmKkgYoa9gCvI57p5lUVF2ZLz8+Wi+W0Gs1TLjo0WLMNGDqpVLbnOACnH4+7S6MaeuzJpsYMGDXJVb120govhhoNqBjY5jwGeWcdQAkoRhWnZzkb7YNuUHaImYMUc4opmO3d6RF4LYybLR8eECV/8np24+M4ZTgicElSrA6Wlh1GCeqW02IkVHNJpxZQq3Osj2DUkSKLRZIw5Vf1b1pRu6p95dSc3SjK519GnZ9Z+DX8+HZhRlym9Mw3Sjweq5pbCCTziShiUi03KW7UpqggPu1Ag2Sot8VbynNqenjAf64x5eA0YXmrOVsuOMthEdAchiifLdCY6xPWjJ7zR5cVkvylWIUcYCEJo3LAMrQIFycxxWze+WzVOL/6q5d2/n034VMDnq4P/O71yGULMJv2uXtLt17/dxTzv7/u2NJ2vixe9zRUkj/KJi6kcQdGC/fq+RA6wa4ffKv5BPCqhVHflDX41QdeUUCxObCzF/StEULUPPOgZ80FuYtSlOteEthwqnAm2zKFM2S17iwhBCKePf66C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(86362001)(478600001)(6666004)(41300700001)(6486002)(26005)(9686003)(186003)(52116002)(6506007)(83380400001)(6916009)(316002)(6512007)(54906003)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(44832011)(8936002)(66946007)(33716001)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCuzQg/CHL9DXepLODPNqJXsKWgjdF8HwhMl5cu1E8BssHeSL+NcHXjjMlxq?=
 =?us-ascii?Q?66f4o4rRS9j7gZiubaRdXrd/I02Nj0tMfHuQUHTYpEZj+hzMezecJcrII8Ln?=
 =?us-ascii?Q?Oa3HPvCfnSx4vBQmnAYcLXmFgXkvQ1iwIwveg3LWa1Ij1eV6nehsUc/iYsRG?=
 =?us-ascii?Q?zbtG7VJRjkZfMrh7cXd2ITK7UIFJzWxL4POeQYd1TxRR3EeSbYN1gTQ/ztP1?=
 =?us-ascii?Q?Ik+rtKpfTc7atYRdD9AD+wfg/Q5DNN6vMAGlXvioMG046rk/6RnB/SsGo0le?=
 =?us-ascii?Q?DlZ0ACs0hTqGvk2wBKrk8GEwciJgwFr/X2/NBXnFiaZjGXo44tRT2wsB5pQb?=
 =?us-ascii?Q?O2uGPMWJTSzzPHUWCLpidG6KD6LqC0lzA5NtgzN04DNo/0aqPkt8NYSe+ufW?=
 =?us-ascii?Q?WrdMOtUh4EDoWzcn6uheIkBCJsGxI8gbP7jYwp7OuKoUIOn7S+iDuYvlp59e?=
 =?us-ascii?Q?Am1uRGQO4eqM6Eq6mPf4obf5FAKI7bfvl8Hp12ebWpEqy2moLLsjLmnbSE0J?=
 =?us-ascii?Q?y83lRt4whOWaHuGXeqdm0boX5U0eoqtvkNYXhTcbShBMP++Ein/MbEI8dCSc?=
 =?us-ascii?Q?SxesMWtz6Qmk8NPUTPReCH29Ov6MNiQaU/fYy0eHvWwFifqH2JFFZTt/a56o?=
 =?us-ascii?Q?QNmwsblfnHaBj45fxQ0PW3Gd028wQONaPUhoCCGbKS8bH9Ao3R9dqdtuAU48?=
 =?us-ascii?Q?PvJngql1axn3pzeZsRR1mmChky55LsgkFijXKDu1ApfLdJ33dzOFSTmTekJF?=
 =?us-ascii?Q?vKiiehN17MxXORXGSTUEm3uAJ6PPrALFc7ECFm6OBYNSEkprUEDfwfY0Jv71?=
 =?us-ascii?Q?8zZP+kRFcvgb+9SDLOP9xECSwREvRGGCAvPqFtkgHb9zCy6E2kORwxQJ+42q?=
 =?us-ascii?Q?dS0RJzLuvUtMQMXVGbBgVv1mVcjDYtTUS0vFqqpYTQeyuqoMMoBxXWcsgZa8?=
 =?us-ascii?Q?ENBRBeaXLzkFIMz2luqn4PSoeXeyrbrNK+LOPxkb0m1p0Po1KB0AVockLyfb?=
 =?us-ascii?Q?5TVHMDzLWGbsNVhqg4EZB+ahVMpgiaCLwcfCAerwOO5NbNKS5JCcum5hJ2Xk?=
 =?us-ascii?Q?gK5KsSIkR7L9X+bn25lSq6iZ1B+QQI93AwvvA7guoZXSXxwp931YG69Kbt3m?=
 =?us-ascii?Q?UOH5TINMv1pWuXTei323qr/O8VNhPY0P6ivy7la3qi5z/pJ1GOtPc4KoE5oI?=
 =?us-ascii?Q?+XzaE0178/xFsxx4IiLVs94f6npBYV762Dl/0a3s+BLi0STM+apVfv1D5wJe?=
 =?us-ascii?Q?zNxnIgRFPrEnPAtv66ShjCeepf3qwx5KlctARBRYZAinWjTIbf/sOUJZe4Uf?=
 =?us-ascii?Q?RyBHXUjB1KMSvnh7hjl5arYlUzgl9QR6iVeF+mz/1AVb/I0wwaM/s2nxf9l5?=
 =?us-ascii?Q?2PK7y8At5QgGqPmmJdhyKH/nVFBcbBW+wzGhazkQaYR4hkKfwZZwYZiV2Fa2?=
 =?us-ascii?Q?gl/5hP9p50A8O8gg4eG0M+pU6fE2de2LfyuGEDl7JmIcdE7G+QEPx7piVtd/?=
 =?us-ascii?Q?62zIeamWkjch1XFDtZfIGAn67+C6vUxpMDqly/iqIJ8udeLFOVQwSEgDcpg0?=
 =?us-ascii?Q?OeF2MtVuTbU3RMQBEUwPT+mR0EIIGt51R3Qbw3qDrooijNzgd1UDwCThN3lm?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0583674-114a-4282-2ace-08da696b8a96
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:46:23.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Yrq2XdSfIGK0eNJrYNRJHCmwfATSYT3xo3ym/Q5IjafPtN4UlXTN1a0aULYl9g5WHK+WzgRyiViFimtmtdgGTbIi2Ez+LOvSpYLDlaJekU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190041
X-Proofpoint-ORIG-GUID: MAyuIznvpew02vtYGwVXOzYyCP3_CYne
X-Proofpoint-GUID: MAyuIznvpew02vtYGwVXOzYyCP3_CYne
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "fd" is used on the clean up path without ever being initialized.

Fixes: eae3cb2e87ff ("selftests: cgroup: add a selftest for memory.reclaim")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I kind of went over kill on fixing this as if it were real code which
matters.  :P

 .../selftests/cgroup/test_memcontrol.c        | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 8833359556f3..08681699c2f9 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -658,18 +658,18 @@ static int test_memcg_reclaim(const char *root)
 
 	memcg = cg_name(root, "memcg_test");
 	if (!memcg)
-		goto cleanup;
+		return KSFT_FAIL;
 
 	if (cg_create(memcg))
-		goto cleanup;
+		goto free_memcg;
 
 	current = cg_read_long(memcg, "memory.current");
 	if (current != 0)
-		goto cleanup;
+		goto destroy_memcg;
 
 	fd = get_temp_fd();
 	if (fd < 0)
-		goto cleanup;
+		goto destroy_memcg;
 
 	cg_run_nowait(memcg, alloc_pagecache_50M_noexit, (void *)(long)fd);
 
@@ -697,7 +697,7 @@ static int test_memcg_reclaim(const char *root)
 			fprintf(stderr,
 				"failed to allocate %ld for memcg reclaim test\n",
 				expected_usage);
-			goto cleanup;
+			goto close;
 		}
 	}
 
@@ -717,7 +717,7 @@ static int test_memcg_reclaim(const char *root)
 		 * not reclaim the full amount.
 		 */
 		if (to_reclaim <= 0)
-			goto cleanup;
+			goto close;
 
 
 		snprintf(buf, sizeof(buf), "%ld", to_reclaim);
@@ -729,7 +729,7 @@ static int test_memcg_reclaim(const char *root)
 			 */
 			current = cg_read_long(memcg, "memory.current");
 			if (!values_close(current, MB(30), 3) && current > MB(30))
-				goto cleanup;
+				goto close;
 			break;
 		}
 
@@ -738,14 +738,17 @@ static int test_memcg_reclaim(const char *root)
 			continue;
 
 		/* We got an unexpected error or ran out of retries. */
-		goto cleanup;
+		goto close;
 	}
 
 	ret = KSFT_PASS;
-cleanup:
+
+close:
+	close(fd);
+destroy_memcg:
 	cg_destroy(memcg);
+free_memcg:
 	free(memcg);
-	close(fd);
 
 	return ret;
 }
-- 
2.35.1

