Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B477509271
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 23:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382726AbiDTWAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382731AbiDTWAp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 18:00:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51F3EAAD;
        Wed, 20 Apr 2022 14:57:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KJBjVW019298;
        Wed, 20 Apr 2022 21:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=AOGzhEy8TC1CJCi3CB19nDcaVPsQOvWqY5h0L/a6TbA=;
 b=tw7KS82+76Hf9whgr4XnfYK7L0YY5n/qRSh8bDxrVZN05ddYI2PmJVGJnX9/aDe4prJr
 TEN7iQ6BwCGzUMRrlrsSMXvbgQh3yh0tnhSwCshyUP12frSP4VHqQKNMESn6/24fsXkF
 R0OzskVsZ8ntZGS/B/qKK1MCHvLu5v7MQ7uhPW9+6rbHvEYyTixo5N2pWUkdPFOxWP5h
 hRUQxXfX/4AOcyCMFbtAgnzeTaUE4g3e95ha4NOfUsXG1oM9fWqBMM2bQAznxvmaAVHw
 MA4c/hkIh0UjXkwPRxZsS/NuyA4t1xLLdjjxl+ZKfKWrwZKwUZFpjwmm1jX8fL1hjj/T MA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7ct737-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 21:57:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KLuGQb016193;
        Wed, 20 Apr 2022 21:57:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8823qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 21:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMDLev8r4XHug0A+c1irykKgOCsCmJPJXFBvT9O1v7mBjkGxfVh/6sIZ9GL44gWDxoZ5IFNTKia7DcdqVYDa1L0adwKx8AkCAHE5MNoK8e1rhi7W20gxBZ7hWrUoL6JWVlJ0K40aum6u/M2L11AkXSijbvmbmw42CPGgNhszvW25fiAzvunE40z4JBhLa8bH0cWoAfspLLHQvKgOIsQjzXXlbqhOfYIm6riUNE6nXIOwyBnAxeaez0K2I/WmfuCLBNR2X70rNfYn96x9XjRSlSZX7sEGqi1v+lwXjmbTkO7Nvnp6kFGvYyBCNmNkDx0UL2t3ekI81RWX2YeTZBnaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOGzhEy8TC1CJCi3CB19nDcaVPsQOvWqY5h0L/a6TbA=;
 b=Y+jvPma5RRvz33B454LcEwShd6szpoj+nnCZxO14vjaqLfu5gufXixUSq20OhIt85f9ItjQP0XqyDYLI2uI16RkmIQXEkICqWmtq8loAd5nrDsjD+X5nooxm9Wt/bKHkLkFZkjcyourJJ1ovnVb1437nZWP1jeD0tZ2/dgptApTsLvXl8RiZI3XSO5xbt4MB9oaPEvXZu89oZeeIvcKCm5nwfIw8902t0KABIV52lBd1jHSPg3qnxKBw3mdqdpxW1CsKM2LI18Lhf9NY5GtOblQTO+MUo4ARzDVSS3wtE0AZkOLWJBqylcwJVojUwrWRtoGrp7rVsy+t6Dy0dPHA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOGzhEy8TC1CJCi3CB19nDcaVPsQOvWqY5h0L/a6TbA=;
 b=Em0g2q3Lxw5mx1LlaxB+EuV4/Xpnehm4ojwUq9Iz+HtqatOPL43qKrKqgTwARK8/noLN3SV+q5k1TskKL2vmqdD0wqpGqZyn/EzMWbrIUiB9hu5gp3XEx89R7K6phGPQm7TrYatvVTeUTVFv9QfscoQUjEjif1oATx/lIXB3aOY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5350.namprd10.prod.outlook.com (2603:10b6:408:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 21:57:50 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 21:57:50 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 3/4] selftest/vm: support xfail in mremap_test
Date:   Wed, 20 Apr 2022 21:57:20 +0000
Message-Id: <20220420215721.4868-3-sidhartha.kumar@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: d84d2533-2d5c-4a48-aa12-08da2318cfe2
X-MS-TrafficTypeDiagnostic: BN0PR10MB5350:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5350069E1FF7C15209697AB995F59@BN0PR10MB5350.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW15ORnnS1RBqe92O03bI4IxMJOfzoleuSLMYVvrLAS++Ey/DAEcqL1MMIMZ2QrDPVKSfHnJFJLAkznfLLGwFUOgyRWbqUE92fxX9s+sZ3MeaU6BxdmD5ItujGZkOSVF8fAW7pMcQcNrsJT3hZdZu0AXmQJzhAGddq5jSpA7lwAvPHWQZ5vLqh+N9senZjogyBJnIfNEVqzvXuftUJJaZBLCskzX0UpQDs4l4Ymu9RVI7S7B/QgtTTGPNiKdKXoeq2vGSs+ef+3X2hTz2Q3D0W0tVqCiYp1FfdKdw5WLawuK7lTbtmG5NlB5YOuBGGa4blFHpJtHNIDQvnUyhaeQZMDNcujBn8hph89V60IWFVIaXWcv2I9KaurWJ4ABYfCH/OPhyGEDKG1ZCKw52NGNZqNchiCezrPmYVyXeHC8pi+WN/O5oDT2ATV66UVp7+N6Oj71KOjgILIZbaIaEna2ePbcPZ79rFAhsBkevAOW0O50We9NjbPXUYZZIpwKEcWP0CoX6xr8pmVNLBT1iuEOeAqX/Hq6iY88ddIVBQk4TUhlg1s47DjwvqMM0lqp84lgbSd5Ax2HZKJHgPCMkvx3+5eLKi96sI26Q7jsy9xBpRlvPt5LAW4HYatWkXOsTvXuzYx2NkLNDC8CqFLMwSqcYV1dbGelbusTVpZGVfcIRIgX/gz1DG3WV9I4jASMnMxDwe5+x/dRd9PX5es3RfNesA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(8936002)(508600001)(86362001)(54906003)(316002)(4326008)(186003)(83380400001)(66556008)(36756003)(52116002)(44832011)(26005)(4744005)(66946007)(2906002)(6506007)(6512007)(1076003)(5660300002)(66476007)(6666004)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTNW9FJv7BDWKAS3rquBSHz63oD97Sxom/MDkWt1sDqgA4HASlokB7ixEDAX?=
 =?us-ascii?Q?PiX82uBuHEOTGnzujPMGTveDdi69JBkLfuAOSHx6mI72uZhwq3U+jmmH1bAm?=
 =?us-ascii?Q?lQBUtzBSFWcWRZp6MiY4bvf++qBTTG0YQXqOSI07O+xSWQ3xRyZd2LLDRSQO?=
 =?us-ascii?Q?SyDWQDyYlZhTuCGXkMbynhWNd2T9LilD+KNBD0z0OWMvtJs0aG1oOmZKKK7n?=
 =?us-ascii?Q?7bDZPzO2vLLCJkw1vaPR5dINMjcsOM/1KkXvl7V1PoMsvQqi/ZkzDOM4m0vf?=
 =?us-ascii?Q?RGstiGH+98FOLwAQk/mYOikcqZFPVoidnGt22di8fC8eEgvy2tqgQNN2S79g?=
 =?us-ascii?Q?Q02pRcMsKp6iQX9nkwLn7J3MCM0Kq+sE9qa/rCtexxpzITEdfJq3vwSyqC7T?=
 =?us-ascii?Q?DjLvxOBX1dD9EizJ74ijzzlsUpGb9bLoclloyYP0GJycZ5/aGHB/TT73Zg/8?=
 =?us-ascii?Q?Q0NM2luxE2o0ibzurEtfJto1eKkRN3Y28hdL9SvfYFTj4lRSAAen0MnXx4lI?=
 =?us-ascii?Q?ZYhJL6L7XrUbHe3vJssNdeTcYiHXZybcCjI/qWHf01W2ET20UKAdXltD/Z5C?=
 =?us-ascii?Q?RwkfUXNV7dTVOrv9b6L0dBQwDBZvRy868KNrpIG94yie2Oa2e2n8VEJZ33C+?=
 =?us-ascii?Q?5NfrjL2FZkGnfUJ56/gGpqbLGUxTKEp0mn+aBsNjUQo5Rfq8ci/62dLCP0WJ?=
 =?us-ascii?Q?HEuaJZhqV66aHfmWCL3n3eiOO4G4nVZlTl+zeFx3YA5PB1UerJ0Hyv2R5/JH?=
 =?us-ascii?Q?yG9NTtz2S2XbTj4Z9S2A2CcAUZ3bzzC77MmpcMxRIxnmktPutX9Bl2fqzW7H?=
 =?us-ascii?Q?EnQR3fqiqHHkoRzeAKc5p9L2bo9j8HSc3wdUm0Ag7Cm8TUW0rdvqhtemt61g?=
 =?us-ascii?Q?PoSC031H6QQtyRcruRoUcNdE6Fz5+WDULjDWIcI0ul7eBKaKly2oc34sAVw0?=
 =?us-ascii?Q?9+SePOqxxbtDQ5IV2OQYGswHTewFE+OLLfI+UYBUfsrkPRmt7vBKvVOgEanS?=
 =?us-ascii?Q?iSRQRCV9mTLUkIxKMPyFFY5Ltk/bky6tlI53JieN5ksNg4Q8atOHXVYJ3kwz?=
 =?us-ascii?Q?a7wm2C5wlgAW9N9Te9anTZubT4EODQjPInXZ43mgeod9C0jCUPKFgZ6rnOXU?=
 =?us-ascii?Q?ioGvepXzPk+zntEo+JnGsgpgxRrs5LGrYQW0ktKkfHvSGTBSqcD5dTknS6Di?=
 =?us-ascii?Q?j4IiCifxt1+sQx4nsA4Hjw9sEjAvYpUUR53y+SqSC7P41ez1OFjQL4Auw+s8?=
 =?us-ascii?Q?KKCAi0e/OmflZKaX2JNP46GCs/X/+0rYYnBlBg/+b/OBD0R/TJ1PRofQdHud?=
 =?us-ascii?Q?/M0Ukj5hmUVaKNVbDYfbvw0j23vfjwCaAS+OHxr/HCq6pzNt2ItVlcgg+woj?=
 =?us-ascii?Q?ATP8PkOjEWxaYaksrxBqcPusjBU1Nh0u9rjS7WYwgc8vbFvEeX6KekQbGfnY?=
 =?us-ascii?Q?y0b2TfBJSszgX5j2EUy/oz6NSsMeYU51tSq2WquzxM0w5fRAssB7LhGvipor?=
 =?us-ascii?Q?T6PB8EeaLwUzksoqnyV3IxoFh9Sde8kyueihpi5cjKj3AZ5dL3/gPpUBeFeI?=
 =?us-ascii?Q?ZDn85resqWivVF9qltsuhBwo7kNq+ItkEva+LLZBiqXJZs255VLAls5ouewQ?=
 =?us-ascii?Q?WILG5MBg0dUnk9fmJnYNe8/wJ0uMmLBS8p2xDMiqodvKPfLeKZCkwzyDS+p1?=
 =?us-ascii?Q?Pn0niI/dAIWuTWpqqqMN4MvaIQNKs8vrBUM9t8CnErHTy+TSpPiDFP4GMt1p?=
 =?us-ascii?Q?uRAjlVYBoOAQce0csmWOQ85SIA7ZeIU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84d2533-2d5c-4a48-aa12-08da2318cfe2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 21:57:50.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpVdrwk8SQk2YJ0OlKvg/lhorPb7zYrMxPEWFAcVe4JoKGqr3et/pk3XU/cLCDrcQQJTTdG25apJ3UziEMDQNh++xVmuTBki3DuAsvka4qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5350
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200128
X-Proofpoint-GUID: MO7mMbxHZ1K1x1tl9y7sSWOeBYU0W422
X-Proofpoint-ORIG-GUID: MO7mMbxHZ1K1x1tl9y7sSWOeBYU0W422
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use ksft_test_result_xfail for the tests which are expected to fail.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
v2:
-add Reviewed-by tag
-fix commit message formatting

 tools/testing/selftests/vm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index e3ce33a9954e..237b7ccfa333 100644
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

