Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF3509273
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 23:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382731AbiDTWAy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382742AbiDTWAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 18:00:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E463EAAD;
        Wed, 20 Apr 2022 14:58:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KIcDF7019815;
        Wed, 20 Apr 2022 21:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=nTtXlw1vb0XLA6Hgk+3TmkEWN64YMp9QB868rDaE8DY=;
 b=PPqAVY5VUZvIKGQ12bGYOdedCtDuh++pVRqDWoJoCu3+3njTiZF+ZEvOsLIpkgFmCuI6
 iP38Lx8laNazws+7S/voOjl8yFDOwuLqn5aOg79Sn8sApZo0WTx48KWR3x4EFc3DnjT1
 TEC/EuVJnt51tVG51bElh9t8cStaKmkiIWEsxn2dgrtuSb2qwjs4vb5M57mx13bhib03
 KG1gvG8G5yiNJkzsdqPHa4VJJtL6IRDScqfyKz5j4fa0SfIdKY4XMLUVrpd5ljuJwyrp
 JRNFFza/oZgusk4AQTIO+MWGTyMmtKdTbx0cdCt7npM4gjSbUqQP4fmk53/q4icT9S/C mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1agv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 21:57:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KLuGQd016193;
        Wed, 20 Apr 2022 21:57:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8823s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 21:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCHD5QORfAVvHADDQqFmJxxzq9xbu2wxRwAYVU543LqfPlo/ilWmKqxssjDXPwlJGI3O1mqBXQgkDdEbFV1YmwS629U4ZEM9w4DB35rl/ACV4B9qXsUB5Jhi0D4HhNzD2Uuqaaz62hYJgeO4mdw8LmzawGUPrBVSAmP/+wjpx3/iF3WVyJ+16RO+8jlXYUde6eJgh+pPjv0cz1ReCbpa5i8iVwmrV4nkTOXjcM2vpQC+Rit2kcCdELN2FREwPJ/JQgPbwlc7pZy9o4hOjD+lJbXpbCFUgwTAfiudUn6faRYCy6sI74+yMB6FgxySoZhPZXbUR4WtRzeVFvT2MhoFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTtXlw1vb0XLA6Hgk+3TmkEWN64YMp9QB868rDaE8DY=;
 b=C/e/Z4fE8zFV72dcoOATolgPUaEbgjfArnC1ulhtT0NZjn++QD9EhJGOYvfADmYyaih7DJ4gz5Wo7PCNeHbvmG7tYpeLHHcmow9nah7MKfNxVMac6Oocs9rB8gyuaT8D6Mml3enQ7xS55y2Zw35nBZU8Qwmf5BaMiAuUfeWnP68jmFxdnGrL4pRVhzrgx8KKyQaw0omz4hrieI5Qlna8aeVrPetLLa0PaPIHP8vll/UW6C+0ArIYCvg/FQugG/t7Oessf6SQfBikDZEDgUK9eaUl3kJmOrpnqPRHSRov90sfgjFtCxd8Neu1qYE3BRweO4vHthsj+xXfkVX5LQHK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTtXlw1vb0XLA6Hgk+3TmkEWN64YMp9QB868rDaE8DY=;
 b=if5aATh/YfPGMekdeC8/NAqKbpfC25dhS3wdx0exvQKQzqIpO4CIjuabZeEHlgrhnbmZAvMTOaGZDML1ThHUqILXohXe/zcCEF+pyt+vALSkRs+C9XQ5j4s6s+y+Nv68pzamjqsjT9VcYmJVNzfoyk24N/Nwh9g+M8PqwW0+Q6k=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5350.namprd10.prod.outlook.com (2603:10b6:408:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 21:57:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::a8c2:7a0b:5845:1675%8]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 21:57:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 4/4] selftest/vm: add skip support to mremap_test
Date:   Wed, 20 Apr 2022 21:57:21 +0000
Message-Id: <20220420215721.4868-4-sidhartha.kumar@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e2e307d-c6cb-4339-8f12-08da2318d115
X-MS-TrafficTypeDiagnostic: BN0PR10MB5350:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB535082678B47B17CC1AF852D95F59@BN0PR10MB5350.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANp8XAn5ecKy7+TqJ/LqYDYgT71kgwvWfi+1QHHsDN8/g5hrPs6j7C0t6MNZF8rozUjJMpbBm6SFCpI5F2XVLQWwqIO3e6aNhoCzis5axCNoMfFU6VRSV96zzt6L0mwWxgIbjAjnSLUPfT4u5KWRwfUNqiG4ERngHHSGIBat2CfhoYz1nnyJJl8O41qDkaAde242HZBa7vYUDJLU1nx2QJNwOJ8J+ugjmjVb7FVXJMyBXqYPuteCGK+/wz0FGU7Eyt9CWlX2hU7q9FKweyIsKeYgV9RkxiupwvOICzhEE0DT/hyQrDJP//duWqsAju2Bj2/jIK4QlCOunh+NJJvXlLob4bPBGCGStvXnmUggjOiBKyy5stVN0qXI98BndDuarMraEWV79pGXnUY/v23h/5pYwaNIYc0XWMT7PUu8XBsdrHJbB6ys4Kl5vdj+QaqdMbS2EGObePCFEtAywbaVBJK757PaRgyQAhDxn/xETrVpTnr/VBC09vY8Zjyt3GYSbfTRUCc9is8TCQ7cuTbMfaRc714SpcGkyRIEUCwC2Kz/lNF2QJkvojAWFNh+SQb549TRQjtGoBm4gIMN95W2oTQjLToUaaHU55nBvD57fztzU7mtkm9qlKdFls/npHICK6udukfWBkvuhnE38k6YNY2YLD/HyHpqObh37+9MlBHhIXBUpbWFP1sh+JMQRyrIjwPCupI05fr9RDvnvjgGPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38350700002)(38100700002)(8936002)(508600001)(86362001)(54906003)(316002)(4326008)(186003)(83380400001)(66556008)(36756003)(52116002)(44832011)(26005)(4744005)(66946007)(2906002)(6506007)(6512007)(1076003)(5660300002)(66476007)(6666004)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIKgbCCVyDdS7/7/mMMta1/yOvLDFeugHjuPnd86Uqq1Iv3x6LnjFzdl/V2B?=
 =?us-ascii?Q?yj7KUa6oMZTB6jvV7qUu1nVTz4qqhIkxx1tQO9zwWeFWy4wYrGeqSiUzd4ds?=
 =?us-ascii?Q?UvccpuDT0NyEqNOa6UPNgpoBW2MYbeE6u+cS1RLmkAB7F2cHYZT9Qec0iIrA?=
 =?us-ascii?Q?hdNirDE0vSGh2cY9QgGP9pWkoqW43QL4/YPPtU4IROzJllqIIExdRnncvTO1?=
 =?us-ascii?Q?YED9zmMqosZ2Y5Y1x5QiqBML/uIXJq66z7a1+/h2w8zcvbxTnk7rZMIcS7F2?=
 =?us-ascii?Q?ZFCu2o69oQOJIwujMCBY/uZ6KrpIypscSXiTM0JX4GpaqCF1G3SPJ8XvrI05?=
 =?us-ascii?Q?fdJ/kNSM0AI1lYiggzaqcMWh7ulz0oxhrOuEHZmmT13ILX5qqGTuyCsNbNoe?=
 =?us-ascii?Q?SpiioboXLFXgZoOwC5UXsgp6ViyxHPst0KfKkVzQa7PMnV3kYAtsCbV7Fn+z?=
 =?us-ascii?Q?HohkI1ehN1Uoh4CoUOjQPas7uKIQyQovic0y5gdoJZcyOB5FBoFCJ14g6Hkj?=
 =?us-ascii?Q?1SMZfViuHCncoGjtyZOXhP0441/GSdDt0ispcmSYDDTDKgR93UJ/FQEhPD8D?=
 =?us-ascii?Q?ZsIP239l9z1Ic/UuvC/KnSUPGAJTNVhLHqtn0uM5mE76xQt6Owjpn5z9teCe?=
 =?us-ascii?Q?e40N6B+aXWCh1hJRFNtCherVtHoCsodFVLBiawruw4TBZoPae26JCaZ3tIaa?=
 =?us-ascii?Q?fC63f1kqcuvqIRaFzvfL0fqI8+NRGPq/lDl1TisDNpVxqYo9PPCLsCkSChWR?=
 =?us-ascii?Q?ZtQBIFwO/zeEkt1nkeL2hoQ67HKwphLhTDMH/EHPNUVRv2kgTVNgJd8SNL4U?=
 =?us-ascii?Q?enGUG8WHQMnTk/NPSMPhnl624GtcTNUCC7BtC4drind+DaS1+wpUowbd5bTU?=
 =?us-ascii?Q?u4wPiaJis/ikxwVp8hj9sivxajA2WnXvzHn4CpNdXgtdsHWwc4Lx6NkvpHDh?=
 =?us-ascii?Q?9SIaQ/eW9/H6B6W3fOIF1JqNc7lL1boQEMQMUx6YXxpJMV34oz/H07Nyia+M?=
 =?us-ascii?Q?krlOE74hMQEWk7u04rVtbmM+TxQDehcEwTw9Ry/v6uzYvM//2qXJyusfxSWD?=
 =?us-ascii?Q?zMdaVrFglb2cFPJyw/lj6OiOwuflrD5tCiuAExxqBv9DyPQ2TPiH7OpLGU4f?=
 =?us-ascii?Q?ygl0EfW4WwnqCfMiCEi8W/xFLOt+FfvBuk9mhY2yP4InMMXsiZ/NfZeXaiIV?=
 =?us-ascii?Q?V9oOJ1oeB4TULmV6VmGpe3NaKR+ygS5X8cmC9pCkbUgGvXVD87xtatQFZhRT?=
 =?us-ascii?Q?LQjqdttdYEUwvjvVtnbAyPFePsjiQWhynmuNUlIB1kFJANASkhtSIbj8x10W?=
 =?us-ascii?Q?+fa0xaZwSXKsESPOEw55S5U+yz+ET3Q1bvT9f0uzVNYxJQuqWxKLHP9v7riL?=
 =?us-ascii?Q?Qb3owlv0Pi89lYEX85bP5r2PJ6xkYJMfYNmgOFREfWviLWzkmw8Gvr4JHyFI?=
 =?us-ascii?Q?vPeCe01h8Xh55dOs+ZQyLmD70yXVzHfW5YP+s3dv9CrMU8CgSW2/5ICNRZbV?=
 =?us-ascii?Q?cfdVFUutmmKbC+1swXz/Ysi2TULC4Dxw7skX20vXvP8whF4fAqBARURyGm1/?=
 =?us-ascii?Q?zjwktlijMyV5Tzml+01rl3y69BhyT5zHMtwMBhOAAUZPybZnlS3k3eHqR3IV?=
 =?us-ascii?Q?C9kMapcdiUIN9676kDzIPkYWtKRlIzaTSQqqckdH7ELM/AiatHxKt/reN6hS?=
 =?us-ascii?Q?TCQsg7IaRt+d0yVx2c1ERrzcZi5Ww1+WbE4MY4Pg7/+wPdn+LbE1DtSg9nqV?=
 =?us-ascii?Q?YgniOSyUl3HlwrQihfxyhn8iEBA4VYE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2e307d-c6cb-4339-8f12-08da2318d115
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 21:57:52.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgCe/xU1BKHhOWutle1Ll9JUpRS+op1EbQk3PWEmCKQJ4GmTpwnZ4LOqPFGW5fa9Lqopv/LMXKnivuOupixdTtndnfm7Tn7QfRumlUduILM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5350
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200128
X-Proofpoint-ORIG-GUID: kwcsFTtVapGFW7a7H1rVTbFTe_eAkZrY
X-Proofpoint-GUID: kwcsFTtVapGFW7a7H1rVTbFTe_eAkZrY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow the mremap test to be skipped due to errors such as failing to parse
the mmap_min_addr sysctl.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
v2:
-add Reviewed-by tag
-fix commit message formatting

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

