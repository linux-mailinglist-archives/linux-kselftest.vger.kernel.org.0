Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CA05019DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245437AbiDNRTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345807AbiDNRTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D62630F;
        Thu, 14 Apr 2022 10:15:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EFuT5p031505;
        Thu, 14 Apr 2022 17:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=h+3Yp+2ll8sEAkTnMwI+chofBR8PwXQtteB9632ICt4=;
 b=bf1nBTiZVbqs6Ez8hOCBGni0X9FqEuDbTXou+waBw2vrjmAaNTUZM89W+U0SxEVb2xQu
 z60oAmh2m7TdVmF7B6tjgZiLge0SqtBSxVtxT3LgYixhnOqpI4fkcz9MgGTCYexY5RNJ
 sL/RGzQzVGGnDCv1WOvud7DIAMRgm8wlrKX+e/aWZlS7lkVDaSgw3sQGIgUMNuA7zZIk
 I6qlHK0jwShNhnOpCrmS/Gz5x9jHcet7gy6Rcr1fATAb4GGYv/+Ei5ku8+/cPuXIYsBx
 jX1pQ7W7RYMhBY/7o6SI/PRldlI1lTrNxxbghotgIzAPHBlITAy1ScsNC8YMKyXoXHk0 JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rsdhw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHBmiN012522;
        Thu, 14 Apr 2022 17:15:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k57g29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqksKiqdm6G6gqYKXMIZEse/L7Gt1voxTbvlsmjbpyWMKSifJriRfkOwgkI5VQrTWW4kRWJ0c+yQbqD5iYed3qp0qbGIKaweJYnwWsxXcW/oMvhoR1DYSXpJanH4L+uGNIls+SojCQN0tOgdlSZ8rLgHlxB2K+B76JZKAivla2n4l39HBKEyAacRW409lsX+Kfd2KQY1Os3GIPHydbLhjkU5uK1/l44e03PK+7sRZI76HHAUZAlLLC/jfMfybmmrNaREx7+UOxaumchhrYrDBoy4fVilYSI2XfjwhcD7nbAdKPv+8NDg+tBi1dHt5q1+1mplWS6OkG8IviMoLWiSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+3Yp+2ll8sEAkTnMwI+chofBR8PwXQtteB9632ICt4=;
 b=kbly4DrR24kJbmHszHt53WS+ivbckYOUHseWxplvSfbDHstUU2IA0bDngCtj/U0d0P28hkXEy7a8nTxzVFip+8v3/R7C7fM1MLSTVVPFDde2UMe+cON6O/gRTf0BJOhjwXxxqRbfP8lJTg4uNhHK6gn3kWKfIxP9tBK9aWEAraPX0Omx+f+t8SgYQK/NHxaz02USC4NK0Lr3fEPjIY8bd4vywykP6Q8E/o7mYbd9LZ/2J8A0xpEG6Um2HYuHXArTrGb3LQSmY5x6cwhOgPP6Sinbc+EVHM2uUQCHXlM8gi4EGvWURX3cf86veB5KmCIVwFqXaZMDe+QmxE5zK1LKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+3Yp+2ll8sEAkTnMwI+chofBR8PwXQtteB9632ICt4=;
 b=CApg6/iyoqvyYGcB0i7vBw/gdazJ/Yp0AJmlbIicoENlhACeSAeGAQhbDjel7byFxXGRm/2tBO75xjWvXgm0z/foB6Y7/E5JR1nvnU9lT/1US4FXwuDjmgmu45qBAk8fdFFvBCJztF0aJ1slqb0hmX68Seu39U1LEUuxvtGmcno=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY4PR1001MB2344.namprd10.prod.outlook.com (2603:10b6:910:44::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 17:15:42 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 17:15:42 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] selftest/vm: verify remap destination address in mremap_test
Date:   Thu, 14 Apr 2022 17:15:27 +0000
Message-Id: <20220414171529.62058-3-sidhartha.kumar@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ad12b10-ae26-46a6-0ccd-08da1e3a67d8
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2344:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2344203F3418DA56A209BF0195EF9@CY4PR1001MB2344.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCXWtGA4JFwZEbN1yIygN0GriIAA8YtFylOlEVWWJdlkuBMSY4Jh9drGoeyYjNkvvc9ceJPParsmFTu7PwPIs3bjqw8MqM9Gg1UHwmP8uUCgCsUhJnGV/y5kySGo4H1mUXlozXhveadGBM1jxqOuHr+epf7mVuHXzCReMbedZLBTH7+rqLn+P+5VUc40D6p6QaqiFTfTA78CNRWy40xiaQdwsfhcZI1j1PPwfJdAJZ1J5drOnd34YK7KjfFFbEkxSQjabUPyC0mvudYzF+tPCtxshq6OIMli68tRUQUqQp/AoR+H2dFN0PGfGACaza2kvr0mKxch+BF43ZPP/oaIQy7RAEJKCas8W3qzTzfir579udgfHzhYp4I1birxqmR1ScUr20VbkQj0cSol6PFXBI3UHpBhmZ/AGL59V1ZMc1fLvEboxdZGw2oz3Y4rtcrcT6kHBEHxSFI0uBsBSpVVztGx0HbLTA5DzYDpC3I/BiAi6q0sDIweTn1GL6hfq6wKc8vprp0o/WomIdxOFBMvERXLFLQJ4JY58tzHfQDmBQeykvJzzmdU8OVnTlKJmtv6nEdhUpfHSp8FIQwmFOYFIarqPSgz0U9gTuxPYJGGiqCAvh/XNuSZDYX0zVTIwWHdffZmyF8GOu4Ex/GGF7cp4IjKDvf9tJ+nwgYM58GXpJSg9PWGoxPVM9WErU/ra3sqQz4bvs8WmJnDfVvUZErGUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(4326008)(36756003)(186003)(6486002)(86362001)(508600001)(83380400001)(26005)(6666004)(1076003)(2616005)(6512007)(6506007)(66556008)(66476007)(66946007)(8676002)(44832011)(5660300002)(15650500001)(2906002)(8936002)(38350700002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVkCTqMhWt4QkIDcNkzUISWR6DjlNgaJgXXH1ebTw1vs8fX4IoBmF3xakAFw?=
 =?us-ascii?Q?jTJG2IsZtcmv+zLFCx55HYz577UgsxdQ2jtYlezgIutgD56Q+seJxkgNlJWk?=
 =?us-ascii?Q?oVk96fOG4BynRW5M1mGbKnekBXbnqw8zpGcei7iMgxXgtBBu+1j5Qy0WLTmi?=
 =?us-ascii?Q?sSwXj5C9lUpQ2HFOMJvk59aXDeZ+6Z9/xZYyX5yDCGKzMhCAuyjQizXFSNX/?=
 =?us-ascii?Q?EvViTQWb3yZ+uVzVwyFipvlb+dkf18bA3NEcC8wnMJPiF41pC6HilwpLgSr5?=
 =?us-ascii?Q?+bButpvBjn1xae6i8iIccGE0pkYUDrPbx+wFpqbOP/h8zW0DtBZLRyF/7b5O?=
 =?us-ascii?Q?ghpET3p3AltNV8oNYRXPbKJs/3RMG0g0eTX/yWPfR34w5rfiLdfInmukE8I7?=
 =?us-ascii?Q?Nci74u+M2Jsa4+3p8HGHI8Y0RLiurowa7t+fT+KeGea45dtaBUzp2QMk44hN?=
 =?us-ascii?Q?SsjprtdsKmcoUuizrrudxmWQ53ss4BIdK2xUoPI5uPjPKr2oUvzwjLOK8wOW?=
 =?us-ascii?Q?xKWFD39sEpqLmsViZzc7i2bIE0RbkaieszPwjG+06gck7Ueqhlq3Yhg2ID9G?=
 =?us-ascii?Q?9w4Nj8y5AXF3SIJZewEdNMwDeS2Fk+24HvjMQdQTh72ZKAnuMEh4/ddS9Mz6?=
 =?us-ascii?Q?wWz02WYw6yhSeKFm6zKrDAXWAdlc+926KNLurM4XZyCXiJEV5+OCMyvsljx9?=
 =?us-ascii?Q?3ZIcMqAaPz4NkZYH9ntAfm82liLmz/b+cEJWvNi+Fpkze0iKI+Erg7/Gn/HT?=
 =?us-ascii?Q?wM5CoLrpgtDNjG6+lgeM9fSIkVXxaekTcksvTKAQBrdbqc5gyKYLZAw43Q3y?=
 =?us-ascii?Q?2hZJfkaeHtu3GrG7Wkzu+XooCBxr5+aUXL4obi2T8pyy2QroezRoKfdxwKdX?=
 =?us-ascii?Q?Xbc4+B7F5WTHdyhBaOJ97uHe3LLOQhm6L+bqDzvGG727ecA8B30DsXjLn9qA?=
 =?us-ascii?Q?oB61v3h1f8xdC7k1CmE5Upo6c/x+rUn9W48vsgIKnaf0ybYr1pPbQUw7rCIZ?=
 =?us-ascii?Q?UCqVqqTq63B7zjMxoSjR1gLm+xdMdbdW4Zs8MyZc+SuF7fp/ye8LjtWmWjdO?=
 =?us-ascii?Q?t2KgqVGQkWgQqSvLSpHrL9WCoUmbIYHC010LbTUx0H6YzJUvkEOq599HUvoo?=
 =?us-ascii?Q?Lb8ZtHTloFKChfs5h5ZKKKfVfNwvc3mP59eTn2PYOK11lFvPKaBxEXvHaJ8D?=
 =?us-ascii?Q?ZI0DAbhQ6W/JqEtZQuOt2E482nm7GVXyIj6qQlAkFtRMEoFgL0okBV0FJVAp?=
 =?us-ascii?Q?AdbQuFXgaB2VqXb4mHEutsKO4No8wEk7D1A1zyiIXAlI6Q+RR7pd7clo/PbV?=
 =?us-ascii?Q?Jlanr6qsTXAkmui4yK3OkDk4rMutoKhFFlxsqX85krMBI1pyRZAuaZP6+ycN?=
 =?us-ascii?Q?J2TOEzdj0Z/56trmGWc7ch7V7PSXjEcmuhydvVmwKKxJQNH/KVO9qpzyhYqB?=
 =?us-ascii?Q?XkfOMEDxbGy7gVsOYBoDI1HrzQTuOAIKGbtbgEVlgHa67znicbUAbTvcO84l?=
 =?us-ascii?Q?ROtTw7jUAwzXFtHxoV6jJ9jjq6gElC5sz1nFlgSomwM3dYljux40d8KnXiQ9?=
 =?us-ascii?Q?cJIAJjU7/aKv9QECd8GgcZdnowHuh2StHOALXWSLjGRu/T5yd/0HorEwFT/y?=
 =?us-ascii?Q?VgqlPlIyrKT3yVxqshuGv9OSp1H0YP7bSoBv9MdS8EfvNuRanPpVApOXLB2d?=
 =?us-ascii?Q?lFINRENzwymoAZn+KEGb0KgWrJns/cqxoclf5ViiFx3TuKU0PR7APTM1nKSM?=
 =?us-ascii?Q?jS82WiG0w84v+GVpFQsXXYrtGMJGtlA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad12b10-ae26-46a6-0ccd-08da1e3a67d8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:15:42.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ9COhVnSdhAYplyZrzNq4m5Wr0m8bquTUF76A0Lri299pdTJ0jHtyu1PYD8T4tAmigvcTlgyHLxWVoUz3/ebRWN4GHeAmh9XbbDrVoAYqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2344
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140092
X-Proofpoint-ORIG-GUID: x5R3_Fugc65hwKds1ri1zvaYW1h0CZ_d
X-Proofpoint-GUID: x5R3_Fugc65hwKds1ri1zvaYW1h0CZ_d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Because mremap does not have a NOREPLACE flag,
it can destroy existing mappings. This can
cause a segfault if regions such as text are
destroyed. Verify the requested mremap destination
address does not overlap any existing mappings
by using mmap's FIXED_NOREPLACE flag and checking
for the EEXIST error code. Keep incrementing the
destination address until a valid mapping is found
or max address is reached.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 tools/testing/selftests/vm/mremap_test.c | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 58600fee4b81..98e9cff34aa7 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -10,6 +10,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <time.h>
+#include <limits.h>
 
 #include "../kselftest.h"
 
@@ -65,6 +66,34 @@ enum {
 	.expect_failure = should_fail				\
 }
 
+/*
+ * Returns 0 if the requested remap region overlaps with an
+ * existing mapping (e.g text, stack) else returns 1.
+ */
+static int remap_region_valid(void *addr, unsigned long long size)
+{
+	void *remap_addr = NULL;
+	int ret = 1;
+
+	if ((unsigned long long) addr > ULLONG_MAX - size) {
+		ksft_print_msg("Can't find a valid region to remap to\n");
+		exit(KSFT_SKIP);
+	}
+
+	/* Use MAP_FIXED_NOREPLACE flag to ensure region is not mapped */
+	remap_addr = mmap(addr, size, PROT_READ | PROT_WRITE,
+			MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
+			-1, 0);
+	if (remap_addr == MAP_FAILED) {
+		if (errno == EEXIST)
+			ret = 0;
+	} else {
+		munmap(remap_addr, size);
+	}
+
+	return ret;
+}
+
 /* Returns mmap_min_addr sysctl */
 static unsigned long long get_mmap_min_addr(void)
 {
@@ -180,6 +209,13 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	if (!((unsigned long long) addr & c.dest_alignment))
 		addr = (void *) ((unsigned long long) addr | c.dest_alignment);
 
+	/* Don't destroy existing mappings unless expected to overlap */
+	while (!remap_region_valid(addr, c.region_size)) {
+		if (c.overlapping)
+			break;
+		addr += c.src_alignment;
+	}
+
 	clock_gettime(CLOCK_MONOTONIC, &t_start);
 	dest_addr = mremap(src_addr, c.region_size, c.region_size,
 			MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
-- 
2.27.0

