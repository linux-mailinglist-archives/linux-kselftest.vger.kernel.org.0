Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2A5019DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 19:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiDNRTd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345803AbiDNRTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F77A6305;
        Thu, 14 Apr 2022 10:15:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EGh4U7029741;
        Thu, 14 Apr 2022 17:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZJS2TazoVpOx6lNLJpMOjqk/mT8Hy8aLpYjiZyXj5JQ=;
 b=HrlyaOSdI9jPt5SGVGntYzlhAAJDZ17q9GD2/Y5ZeAaRqDAvsLRUuU+Bnom3L6vPzKNr
 zA8zifz6m6IxlY1UjzoxWf01RQsZVESyczhVBPkQT8sP6ysDZqTQG88bDn1X8gJ+Tm9o
 YXA12Rg/enliUEvPLwjUhRSYKW99zEEUJQiNkLEO68hcbgVUEOE8UVu34XwihazNPfdi
 kQobgVyAj8Tc/pRXQmBGAqinz1k7lYYu7cZ0D1E4/Z6yD10Ls5K+6Tl9O3/EiaAyuTCT
 fNVdG3d7qsAz/L1haQWlNNqSRrIDL0aadqyF/LaBXqWIIgPFDdsT0150DVPysC9spLdz Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jdd1w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHBUvG029678;
        Thu, 14 Apr 2022 17:15:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k5kxpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws/nqQelAA0yuwtSE13jrJ+z/mUgM+HNdB5JPCjfcxS1WSVcseg69P0LCLMzgSsIZwtcbhtzLf5un6KacHSfNZSzlM1JclX3IiFAuTOFuR3FaxuNQ0l9iqFpw7teDvjcgEwC9bfx8dEvEGZPCm7xTDuFIpaF9UmQCN3QvpddMpIE7XgHXMJkjqeHeSa7Vyu45gRascz5cYRda3oaJQUeRE7VQqQZJm/UbScT5lDatfLQx3fbdaF1sqRtA9UTW2+J5zg3pHBzTJR6aUL68PDngkt3ket2DE2e9U57GJFm3jmfI5klS9iEGWmSJcxdd+bcKj37LIdgt7jEv8MFZ7UMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJS2TazoVpOx6lNLJpMOjqk/mT8Hy8aLpYjiZyXj5JQ=;
 b=jK5F4/6X8AukDiOtqvFjMswIJbET4fZ9/j9Ds/7ZP4WgwDXARHNmakBQzM+mAwznmCshcc+9lBMGJpP0j/WTVLEXXsDVaV/59WddB1wf4E7c4l+hFRC5U/hJ3ExMaw5qUo8QgTTtySSAFFiLdfrT83wDgGyteHsqoICGfNT9tqhPjc75voGxMkW42D4X5Oki1GDOLW/m5VkNjP+4UNnlDaELNB8NTCQcXr4i/+vmMA0FhOVrYRuDP3aY46zgdKbSJsZUyUtuRoyhfh4n6X3vOy7qb5ZTyX0+9eTjsTZFxfVTD8WQO9Ng+IX/zmWUfruRyV5p8ox9scbGb8NDyrtBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJS2TazoVpOx6lNLJpMOjqk/mT8Hy8aLpYjiZyXj5JQ=;
 b=BLFPh+8JKt+qQ5Xw3u9GNo9PC7IiUkvZ8jzSYJK4H2X9iU/3WnUivmjpW/UFS1ZijfnUXt+Bb0jo7dZxjHJtsKa0JMY2CfUaQW6iofMN2rRcjOSflQ5jsGz8X2k6qNJlAENxjGuyF91b53mjwhorQpHIkEXsdPQ7qWgmd2iOfaQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM5PR10MB1516.namprd10.prod.outlook.com (2603:10b6:3:7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 17:15:46 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 17:15:46 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] selftest/vm: add skip support to mremap_test
Date:   Thu, 14 Apr 2022 17:15:29 +0000
Message-Id: <20220414171529.62058-5-sidhartha.kumar@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84fe81bb-f08e-4c46-4e81-08da1e3a6a34
X-MS-TrafficTypeDiagnostic: DM5PR10MB1516:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB15163424CC3A6BCB5076502295EF9@DM5PR10MB1516.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZf1qsfv/Fp22HJMHIlxnpvtBO5C0t1/4kBuxaQeT+Aw8VrGncQCXu/CbX59ztLVyxAng/k3EI9qj/39s+ti23SdLw8jtSdhkTVI+YGagK+sNutiXT3Cam2UhB0mJ9e7iq7o89F5qORr4cuhsOrzClXuKgLzmkgIs6IBGMJzuA4T5YApTBiN0E5/C/bqAGtVoNG8oETBSLAiNV6o2qLnbDoHPg54U/XPolwckZ7FE5X605DCIT7UqAS5HzBMVDadlGn7exKqkpa8kNQPRsocGd0lYT1HfrkJo2sIg2FysJpVhKP3hszw7FK15K+JsFXEgc5Q3HUU6WAdRj2ljT6Pqyz4EbXZKk+zIbWk8IjSecobwhirYn6au3k/vNW48RQp7+/MY2pamw/nD2iet/B8+vOJ9oawpivJvyXG40D57XZTDoJeZeDzOTVtJNAZk1txWQq4W/ODgzn0KEZ3/CmnUMK0Iz8YJ6nD0QvN5iCJ/irXbEuV8kwHdY3WMX7180m+THoYfaKaN+8lG2j+8rugXsQz56Cl6XRSgRYYh6CR5f0vHmZAiGrmauQhDUng0z0r/N/oTlCotEJoj0kFHWlH2prImzDtiMwIx10HfOV5/8hlapLZw3gBTExhXoqeLaK3ekzO67cMSLYJaikLLV+2b5hvndsKPp2KaitGM99pTU+9YDQBb1lvKD+t77P061Ajt1sYr7JM2WksI7BW8VzSlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(8676002)(5660300002)(44832011)(36756003)(6486002)(52116002)(316002)(66556008)(508600001)(2906002)(6506007)(4744005)(66476007)(6666004)(8936002)(186003)(6512007)(83380400001)(2616005)(26005)(1076003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UzrP0bppnEWvlKbAyWtzHRP0L4nEjiK7EX6JgJ2YrStBLb2jm+8ia08wQonD?=
 =?us-ascii?Q?VQtbUmJUZdc9FNhmY1NxbtjhZDjajLu7MelP76C3tAYYAB1yZi1kTkgFokcj?=
 =?us-ascii?Q?Pn6ejj9ofvnZ2Cru3yUVr4LOo+Mnjnw1ItpwvTHC/yb48mJSuBUHR2XTurtE?=
 =?us-ascii?Q?yMrlkl/f7obztZqr1m5R5afJti99f+qIxj/qYXht8ehv+v5mxWTycejHMFN4?=
 =?us-ascii?Q?HR5NMyJ6JwEJxbw2XvDHzs3LI+oyrlPAS/Si2P3qTl3nDpYsthtR3FwD/DzK?=
 =?us-ascii?Q?Pr0wTBY9z/Z+6SPxd13JUcqVF0ieoetOd2FeGqDLrNmSuwVjv2AyFS+f2v3V?=
 =?us-ascii?Q?fwAebAAmYQnZzY8v/7A9PERxmBqW7IldD0itHnfTJcGRC+6NEH8EM6u1EXz2?=
 =?us-ascii?Q?bRRkFfKqZu1NsaICpqU9MrQKdGKDORNrdHMlP5+KO+9rDHQBkufguYKvtSrc?=
 =?us-ascii?Q?/ERMSM2w9UWk3VGTrPzOqzYG3fO4wjmWkuhu66KNxgWxraQgIFDrk8Iv5gwY?=
 =?us-ascii?Q?3Muvh5EymvgbO2GUe4SxdpopstOKmnYaah3559OSssK1hxrugjH9TsD9UN8d?=
 =?us-ascii?Q?pyP4PSeWUS0rbhVGQmTmj0l9woQ6flfsNmIFZM5lsKpZF1hvte8TJ5K/DUNE?=
 =?us-ascii?Q?g1lbFI9oUaVJ1YUC1LOZmsrd2GmJodAUOkgwLlmRxGJovuy+g3t+fHPoUdtx?=
 =?us-ascii?Q?LeCsoB1xzkZUPWPbK6zJPpAW66qQi7kWXH7AE8Ei44cao7GlXBQE3bVYWnUu?=
 =?us-ascii?Q?WqmrhU/kkIsa5Wf3VaVZbWw6Fnd8h/tx15YDQNvoo0fvMIEqdCPudfBBzw/L?=
 =?us-ascii?Q?TcFphxVx2DaIPjWI75urieuDo2JNSvejfSVn6nDRsBziC9znKuvUq7FN98Zf?=
 =?us-ascii?Q?DKzqlSHaeznJSzREjDu3BMJm8YLWr3qAhmVNopgQBfy/nJpdKngnfoduLFkM?=
 =?us-ascii?Q?6B9A09RS2lXeWcenviCfcf3b4Twv/33JuejheWcxFU/13H+SCcNE4onUYwje?=
 =?us-ascii?Q?GG/4TgmJirXfsbkvjjErZa8fWm//IRfwEstvyNKm+sWB+B491BS6OzFEJCYr?=
 =?us-ascii?Q?u1HHJNAhUl6lje9uGgu4SVqTYliB/3BVpqSS2xOr8+Ofy16/gGZIXwyK+PbD?=
 =?us-ascii?Q?Jo97/m+6HpdKhio3JKqHpRAb0gB8GGPS/65jolQQkXF9TVvbYGYOaO8oJjyz?=
 =?us-ascii?Q?BPwPwqRfbSEt4crRyQrfAUqRWEJfG7kfy1LVmeF+m4sAyil413W2CAiBzRhi?=
 =?us-ascii?Q?q2wuNhBLdiTyWRi0mvizNDbHRMZG+CX6HwqXaR5tfqYl/FBlqcU8dzfUBYGF?=
 =?us-ascii?Q?vPRYG44E8OboMXY006b0hrYypPQNYo8Vmp8B2amGX7B4Dxb/0sP5iucosE+/?=
 =?us-ascii?Q?6BZmP3ghhofG3MhHEJ9FHhAcU7owcTGp75eFEAhg3w1v9SaJKY6LM+n7Nmey?=
 =?us-ascii?Q?VsbzozvzbX9CfbFZZWLXSZ/f+mcIBf7lRIvMZFU5hHITkQWQ+MdkIw+MSF/K?=
 =?us-ascii?Q?4hBuJzmngR506EyzFLP+N6sp87rxNK5FTIf9agod3YUDvmGnieOk5P3xMQe6?=
 =?us-ascii?Q?vdxnSm6zPZ2Z+LA3SC/HftHBqkPWa3owrmpas8TWp1jzhjBcU8Th8qfOyr1e?=
 =?us-ascii?Q?w0SkmJtBTlCsQX9bkHZUFhrWR9/JvBHXVED2xKgia0q5fjgCuiec7ajYo0gP?=
 =?us-ascii?Q?KbDvgwBGGLGWRkM17Lqfthz02QYp7VX+zXXR/PEqt59lEWrq0kJ2AlwwRhnB?=
 =?us-ascii?Q?vSVi6sIIylIvTvDP3XZvNzo5eeKTxco=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fe81bb-f08e-4c46-4e81-08da1e3a6a34
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:15:46.6657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjDmtRYptHXgwiXbjf59FFahPO39V9945OGYgtOH5NoDIhIZA0Gg67VxphjuEjzCHl5dsP3HuwT0REKVk7OBOEucnCcNYNuollBMZJtM6O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1516
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140092
X-Proofpoint-ORIG-GUID: JwvzBQskxDtkGd1Aqiv_QooF-N8wZa1Q
X-Proofpoint-GUID: JwvzBQskxDtkGd1Aqiv_QooF-N8wZa1Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow the mremap test to be skipped due to errors
such as failing to find a valid remap region and
failure to parse the mmap_min_addr sysctl.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 88e15fbb5027..eae98f5de2cc 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -272,11 +272,16 @@ echo "-------------------"
 echo "running mremap_test"
 echo "-------------------"
 ./mremap_test
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
 
 echo "-----------------"
-- 
2.27.0

