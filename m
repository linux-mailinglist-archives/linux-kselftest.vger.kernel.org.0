Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD01D5019DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245506AbiDNRTi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345812AbiDNRTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 13:19:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654DF6310;
        Thu, 14 Apr 2022 10:15:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EGg2VI029058;
        Thu, 14 Apr 2022 17:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zZRdcGLcIn5cE4lPD6CeWBQhju46dsEH9q8WluE8gf4=;
 b=cRLTtpOhPoaQQOhJr+YkL/QnwjQNnoj1GNDtE81ygt7Gz206s//3OxPW5AstN6MtLKQU
 1/TKGz/aBlZZpcEOSQEs5lCqfx2wdo0XHMUFSqLpfRbjvRUCOnEAndsjMmhRX99R7pV6
 G9n6TEB6PZNMae5JhCI578m/HUI89PqCXxLhydlXwtWZYSwOKAARfjspmH5aOi7pZC7S
 eVijP38ao/m7BV5DVDKWe+3jScxbmXsTB4JYgw75yo/NPhx+TcZGWufmUwaMtPns3VIY
 +jB2fwlYe8flMr3EammycZGXyuPm7rAp2d4F68MMt21qZv4QJBjL4/+f/edqV8K7jSkU lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rsdhw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHCN2K028929;
        Thu, 14 Apr 2022 17:15:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9kyh1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 17:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMHTH4bQn/i6BLYMFll0mKJQ/JLfQEZNQdQu0nicN3CDN97OJbpECDVKZpSZuX9PdQnuOs3nN2dJyV4v9QPbsjwjchhCxQ16Uv+9hiWTUx5wDLkTIWQ4P1jTRuS8q/Rewk1SewaO4G4wFPFoOCcnjBwmsn7qoOqxjcVQNFgFovXE2raXTqfioiNdNPpi7fHi/6BtYWTmtYHZI9QqOnkmroMC8/tTm7D1Ju/StU3efE5eQn1l4IAci989371Fhh0S0ykLrYd1nBYZCjRFkTVe2a7zwjp07WCSfO/MIAd4X4OIVKiIxRzM8nNosvNojCuUbWM73WMYaIT+GDFZt8tT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZRdcGLcIn5cE4lPD6CeWBQhju46dsEH9q8WluE8gf4=;
 b=Qt0BXLmrNVCnCh2YGD7FELCVhIGYKFue8Jvpmd3W/1dSvCU18C3ioV/SdFEn896DXh/mp8gIdNDFYvuSEgQLoVLq2RbU4t+Q6+SxozT3OB631Roi05idU9YDj8XVKDJWgrdPDSl6MiIC6Tp6YGqBcYWM2eAYHxBSa5FgBA9igfaWasA53o0j4jKQ9UGgahDFIIxqPo/dD7NspFsjpE8JLGAGwYTLYK3WpQcW3uVX7iYsCp5jT9Zri3AYEAAntUotgNW8cN0pnwvQTxHyK7zDQ5kQWV23SzTOcuMtOaTCTfbzJM8fUcCw3o9hc0KCbgTG7fNvhlQxO6EaIbVO1t3tIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZRdcGLcIn5cE4lPD6CeWBQhju46dsEH9q8WluE8gf4=;
 b=T/GFGWku+CEbrcJ0vuaGFy8PCM4TLIdP7mhcKflOBCiuHcLHpjT4l0YmdhVGAzJ0aiYLwJGirKrVCb/xadECWhDoElg1TkTLWe9fY1+Ll0EURdZ40I+rl11krHt54jcru6uhatXk4f9YUDPhs0w/U52qENmENcxHEvJSI57/Rzo=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM5PR10MB1516.namprd10.prod.outlook.com (2603:10b6:3:7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 17:15:44 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 17:15:44 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftest/vm: support xfail in mremap_test
Date:   Thu, 14 Apr 2022 17:15:28 +0000
Message-Id: <20220414171529.62058-4-sidhartha.kumar@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d506e9a-bccb-4fbe-5783-08da1e3a68fe
X-MS-TrafficTypeDiagnostic: DM5PR10MB1516:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB151601EFA5377A7D66E9DCA295EF9@DM5PR10MB1516.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CAr/51hZtb7ydlwWAn70VT3Ewc5gkCg9/US3KWSWhU7NNBUbcchwGd10vR0kBp1puBgyowY2Oz4QXvv9oKhZa2bCL9nhRJYUJbmTZYSBUwLZytWxNgQf3Sic0kgZOv/h8KiHrVRUz9a9S5OGDon8Z9KBtLFxsOd4+Wol+byCsQbya4J+zzZ657EJ8bWOAwdtGM0jFYpiDnbQyNpbCVQqgFULGWlKACPot+gFJjbs01hUq6ASzKpxkmL0cfI+VeG0QAPO9PDJ07MAwj6OqC6fjWFe4nTiUi+du0QOIMnyiNIeylHu/5x8H9HLPjWzeGsqHmiiE02tlVwntLC+Bt1zKxi5iCZDZq40Mhegq4SV3vPLAlsHqA1CKIJae8OCDOEfJg3FGBpRxar+FlSTrUEoEfaaGiExUrWnQNuW2j0nelg3IFFMWXgBPzXYoFa+DZSn1RFjHuNnlgG1xbJQ3T8CULmnd/RH7qFvzDN46HWw6EYur3PycaHA9Xi6g6yBP65FXT0UWTFh2ylhvq5zvy9KWzFL9SLEo6FgRhipmW8ES8E3rTBwzuxX37H6fVZh6u9cqVBtGnhDXB9SpVTu+TGz0o8SjSpBw08ZnziwREkgwGTlUc5UcwBwgAISdA4c89YM2W4WbMIAahWtyrIDuI5u3wX9rscSxpBaHAaK2PU2AEuKzIwiHJRz2XLdUlwPqXNzc9FK8WdEttUxYcRip5QYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(8676002)(5660300002)(44832011)(36756003)(6486002)(52116002)(316002)(66556008)(508600001)(2906002)(6506007)(4744005)(66476007)(6666004)(8936002)(186003)(6512007)(83380400001)(2616005)(26005)(1076003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFs02Y+57VuRj5TE611RbqK83G7yP6liOIKuim/TOR+u0UFi1Zf8WlcP+Vmq?=
 =?us-ascii?Q?iP65quFaD10KTzgzVtFYpThenSit9jH1XkKUhuZivXqu47oZlkjYn/ipksrX?=
 =?us-ascii?Q?YDzcY7JlTKAketjeTjsgN46/iq2UpIz1OCwiJTRmuPsNcqFD/IagzijiQ5z3?=
 =?us-ascii?Q?YjMNePsCywyXSnJ2RmyWqsg+C0xFBK/BIuCLAp90yBTmloz4eTDqcmFBTMip?=
 =?us-ascii?Q?DfBczAOCOL4fncBlKNf8oJT8a+vjW2K/1yHg/4GuaNFpfsVOyR+6JRp2RMBK?=
 =?us-ascii?Q?sQm2/JhpfyZeIN8lq9oeQkQAucJqEwE3mUv3fJaXQZR0IS1/crkk8DeqY4tc?=
 =?us-ascii?Q?dpqEqKch2b0bXGppBoQ7PRy/yZxUX52zFVkrJe82rYRR0O7JATt8lnMGkcf2?=
 =?us-ascii?Q?8fY5xjgywmzs2LvaUjfq8LJ04dQiNubBcz2AjXK54foPRD953XZs1yFRINHw?=
 =?us-ascii?Q?XlsQhpP2W+piGAq+YtYLfeESY6OuK22iG9wwqYdo5pBdRTq1JVy822lkkTFc?=
 =?us-ascii?Q?vZZsFbJaSfnrHMrMWjmqCZcXi6iPCmuIMkK2rFTy7LITClN4IfTIIWODwBSl?=
 =?us-ascii?Q?5VbSyM8apihVwjxL+Md2TMjAMS548FAzzb8V5Wf/xIHy1/o2MRYTzxG2HIcz?=
 =?us-ascii?Q?rMOGkPR1ILL9c+/oksvRl9Kko3xHaGoV8xWCmHmmgvTHY+qKZoR39ukC9rWh?=
 =?us-ascii?Q?dxRCgWWZDBHGgp/KIQv/TCe3mhgnijQZjLQdwSKbEqU3cMpxKMckK0zlfdQ2?=
 =?us-ascii?Q?MKLiWmvrFGk3HXg2H2Wj1b07HBqhYCeaXptQoRnd5n9L310uszBknLYdzPjQ?=
 =?us-ascii?Q?YghjiYTOHiMhp8xxXvla2A40++0mgSRhMSW6zMX0o6N8kg9n/mQAY8d5zNkU?=
 =?us-ascii?Q?rpes7o/OZrQHj2X6KprEo9euq6rHfRDA7Di1DRr8uuAHgLjp75vmJr6gNMqw?=
 =?us-ascii?Q?1ejT15LkrVa79ZqyrrKpFz19NlT4l8F/6x1iRw0elmVW55TuSbtGBwI/h2DL?=
 =?us-ascii?Q?VuZAe7sqR6B28Aow/N90+F2foWy5P2FFmZ2mJ9Ir+zmDCuFLSio2YJn9dSQZ?=
 =?us-ascii?Q?MHebeCpouFNrKSp6CbXNUKizt8nZdbXyYuc3ZClFDyGvyGfcyZuRIv4RtAhv?=
 =?us-ascii?Q?wfyYntGlDWjewOBa0Myzn9r2W6W43pfmLSuNgmXmtZoO4TscYIb8RpP4bT5e?=
 =?us-ascii?Q?7UJUPKNrrVF+tB8B8feYu5Nb1i6yNBqPVcnCqq9l96lHaBNzf1E2UJL6eEvO?=
 =?us-ascii?Q?ImGXZSMIgiEeVQmbewhDWXzmKzJbWprbJmgKAAWkqN8TpLqcGAvl8VtVtUia?=
 =?us-ascii?Q?4eFs2YiLQUuzk/XrNp1Mf8QO6vCQ+BNZSf0Xx5zR4tCkTDY4djXFEI6gN+QZ?=
 =?us-ascii?Q?9xVaxp+GSPwBlNdtJ3bZ24PLCcClfKiDg5S5jxTQao5CsDfhyETWMEIdJzIt?=
 =?us-ascii?Q?VOVtpOBvGbIcpESWZFrZhAPqbhzRB/6ukQILjqst5pGtSfHmDHLsiFIw7iVe?=
 =?us-ascii?Q?I7Dq73phTiZAqwI7kz7yWAJIXTBy4IlOXNrFg9nTNcekWeNuAarcei25vSlh?=
 =?us-ascii?Q?nwbyATijc5M6OeAcAXGERVjEOeXU7Omkq/uydEPbzRCYYY1JTnroSTmR0qZ8?=
 =?us-ascii?Q?pbHDbmvo3EVjk7/ewwLGZjZoATq7w53YOh3h3Lu686/2UR5arLA2i0WdPU76?=
 =?us-ascii?Q?Ajibe2N19Sgg7fc0U+aepWLlYycRjKibXgLih67Qvo/rQK1bu6gYyTvZrAtm?=
 =?us-ascii?Q?ymC29echjACew5Bs0QBOi/krzwm5R/Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d506e9a-bccb-4fbe-5783-08da1e3a68fe
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 17:15:44.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pfKUMzC9IbbexkusaBMqulhoX+kbJIAsBC20srNWqNI0jpADFb9j16wPt0I+Vqi7W/phxTRCMixbOaTZ7uAJjaR7dVPuFO4GE5/v6r5Zjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1516
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140092
X-Proofpoint-ORIG-GUID: hup11fRWNqslPdzbF-7gU-jQfeWJ4DZ6
X-Proofpoint-GUID: hup11fRWNqslPdzbF-7gU-jQfeWJ4DZ6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use ksft_test_result_xfail for the tests which
are expected to fail.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 tools/testing/selftests/vm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 98e9cff34aa7..ace9c3596ed7 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -269,7 +269,7 @@ static void run_mremap_test_case(struct test test_case, int *failures,
 
 	if (remap_time < 0) {
 		if (test_case.expect_failure)
-			ksft_test_result_pass("%s\n\tExpected mremap failure\n",
+			ksft_test_result_xfail("%s\n\tExpected mremap failure\n",
 					      test_case.name);
 		else {
 			ksft_test_result_fail("%s\n", test_case.name);
-- 
2.27.0

