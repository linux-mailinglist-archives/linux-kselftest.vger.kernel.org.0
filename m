Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F425B0948
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIGPzo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIGPze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 11:55:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7783E75383;
        Wed,  7 Sep 2022 08:55:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287EnGdU004998;
        Wed, 7 Sep 2022 15:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=uAvPlJ9cB7dtFK1LQ0CENoW5hqcEKSxgY+MBzM0s/uE=;
 b=YoT3dmTJDrBa3z3QOZnLGjCqYrr+3vRtrB581XYPGjQo3a3r5T8ggR8HyM9zzEb1Q/iJ
 IWXq86SIY/rGtTu5NkvqL/iwycCACeFpRXWT5xKGq9LhbVE4WSnvknKWtInmq0HeMoxC
 zUcoj8x0QkSy7Xp/pULhJMbkHC9INCpZo9q2an1sfTMElTNAkj49CwuNQF+jgC9JjkQN
 VrLTDFbWxGE9ev3qB2XNvuo0HF5tbMbLoBDJWVfGVr4MnLYcbYDMGgG/qeRzA6hhCENk
 uEMV0ImqMJppvtrBAq8UeWkliMyREqPbcUEQU2Mflxu/VjF73iOADQIHtuYopcgfPhL1 uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1hba3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 15:55:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 287E26wX035064;
        Wed, 7 Sep 2022 15:55:22 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc49w5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 15:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVGYL4dpG+FNhui+g0D0KriMFZsgom7CDROb2Zd1omRrT1bqJBdHT4/guhl3xUrQ+1za0yXpi8h1oIRLHG/WH80KFuUkgAPXdsaXLCIByORS6Rwu+737V+fHmCkCILXhH5BPP+Zr9/TtMOSGl2bfei5LYxSqy9FR4y0moEzhk0KHQ2KslNyn2xRjeJqNTu2F7EaaqDXLv8jCGoNMp7ZGfnUGeRmJC5r/Ss/BpiPf45LTObHFtIX5LkON3p9Qv+lBlrPf+5JgmLNFPDPDiyyW1zC2onyrbSzRC976HeE9hK/jTLjZEmngrpg13dNtaTqKLz3wC3MPvZsvFqOlIx7D3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAvPlJ9cB7dtFK1LQ0CENoW5hqcEKSxgY+MBzM0s/uE=;
 b=hAur3xj/tHMFy4//118OKwWoInegOb8ZbsmjOSvLEvJi852nRr6D1pmSd2aM7wzICCcf+RR70RXTGIPFySe/R3GenAJ43LQz6H0AEl6AVQuM2pIyMhw1AUxI63sDnCntqM1g4U9/kEjE7lPQn6BcacuYGoudXlWc+Gjl2K/ZNzm2MuX3Wofi/mTUvuHJgQOfgcg5UAzN68NYJiic4HqC0e0UEXa9cgZVxWUdDDnzP3Vcy4/VhZhDvAbwLy4NYKqf9dDCEIFYCV/R1q7Tu0xgb6u02qvFvXFkpvL73r/XMJoVKsh9PiDpZCSX07bx3CKX7wHtGv3p+once9a6pNMaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAvPlJ9cB7dtFK1LQ0CENoW5hqcEKSxgY+MBzM0s/uE=;
 b=PWeCRkRcq18u1DMLzyGhIwhDsMrVMPl59IlomgKdCJQppNZ005uSPuApd7YSxzuLQgKu8lHIO5kVxLOJeaX4B149yFuQ1dWdp7xW5yxTcEh25rEbQNo8oXeEp0NA2mla8OxdvwefoZXSRQRXz2FwJJe+LqarAmkOzFCf/cnBSM4=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by DS7PR10MB5085.namprd10.prod.outlook.com (2603:10b6:5:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Wed, 7 Sep
 2022 15:55:20 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::9034:820:1811:4ca0]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::9034:820:1811:4ca0%5]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 15:55:20 +0000
From:   Liam Merwick <liam.merwick@oracle.com>
To:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     liam.merwick@oracle.com, pbonzini@redhat.com, gshan@redhat.com,
        oliver.upton@linux.dev, andrew.jones@linux.dev, seanjc@google.com
Subject: [PATCH] KVM: selftests: Make rseq compatible with versions prior to glibc-2.30
Date:   Wed,  7 Sep 2022 15:55:10 +0000
Message-Id: <20220907155510.968666-1-liam.merwick@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0107.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::48) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|DS7PR10MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfdab1a-0470-44c1-bed5-08da90e95e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +w54Hb4YEDIuzkkCCPxFVQ8z4niVjanBnKdQKzcAIpzQzafT5QWUV8PGRF8UTkSDA30EUJnIwohM+FMV+ApEfe0U+96P6P1LL3po5KFQBOYxHaVtBEYn7CpUKWOeVxDgAVMVt0U1Jsm1XQwYnMD//LHpqJFxHQScR4aYEeAcKFCGRh45kj5wQFj4qBaPy3AZGc3VNb2LVzGynv/oGanZzxIYO19dVcjKmsH1qI/a6K/O8hUX4k/0OLBu+NzrW9RWdjQiK5R1Zpwc0+JVUYvcBpM7Z7xLtByzXOrgh1Q237B9UTSCvNypW95TesO4kmGvAqLHSB64yXM/J4UEJft9X/nUjbZQsPcnj0tn0fu5qeZmuAeEFrmDoibhPEH+AbisE21O5Cp6Zq+PjJDH6AKp1rpJEBF4Uqsry9lyAnEmQn6aMozpyMuuszoxNxhAdwKmYOp29FBeTIglKAGZrv67WT5znVEN4fkWETY1Woyz9cULtl7ERjrGoZdl+WOzinVUfbc8NcL/3fPvIawLhuaEOf7lwXZcIhj8jwN9d7B671ntOQ8XmijclJyKONg1CY7HSNbFdkGPGGm6HN17maxqBI2jH0uo70OKOUEHpBSTAqphSSiyyBCj1nrIazR8zJ55Lzvw+eIdVxbNbMEMb+IYaiEvX/f9qJftMwRV43OE23TecSoYc2najXL0aH+NFcBh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(376002)(136003)(39860400002)(41300700001)(6506007)(1076003)(186003)(8936002)(83380400001)(2616005)(2906002)(5660300002)(44832011)(86362001)(6512007)(36756003)(478600001)(26005)(6666004)(6486002)(38100700002)(8676002)(4326008)(66556008)(66946007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eojvggWdCSGg6qIFoMPId+A4GbchFdAGxW6q3vY733nGkREqqegD+nYK/OfT?=
 =?us-ascii?Q?sTjxOdWtHxYljpR8EEp7m/P2DrPMrx13xAsodCBR7H/dk4lODyZ+MPVUXqto?=
 =?us-ascii?Q?w3dkl/RYZFDk+amqQdApQFUdf/lFs//B3DqagLiYHYP3tdvr0VYtRWyArebT?=
 =?us-ascii?Q?BcTMXZn67mvZ3ElQDUNQByYTHC67Oxd0Trx2BOjQJBvLYE3a5EqUVhsbQ9El?=
 =?us-ascii?Q?0MWYeTexTxlfr/kWE10N+rMGbkSdPHoFXHCu5UIxr0S68UrmRpfSg2/mcJC/?=
 =?us-ascii?Q?qZFaNzvAVK3kNURE7H45V8eMtweL+tFNehDGgpslNqA3GpT93QNNbNHaLRyD?=
 =?us-ascii?Q?kxWlylLHZNpsZFbEpUS6/RkLyzYUCKh6YF6KPBC4Vic0WKLHGoWQP4ca3E/D?=
 =?us-ascii?Q?hRN5IGq1/CPibhdoT4/YLaFh+3DtF6uXGfFe3nflqg966SO7P5w7NfOcERMf?=
 =?us-ascii?Q?0eQ7CHJaZ4Gfc8nh9RzSYKY7sF7gRBcCKvhLGaGAjJ39BQpp3lWIcf01PF/5?=
 =?us-ascii?Q?iKxcHtvXtBlDqaQ2w+0deMz1acjFZvFaxy85VGn24IvBETUm8UKMA48dwf+a?=
 =?us-ascii?Q?SJTabHvLnmH9Lu9I+ijYzB1zmFCfEI9xnMR4g2ptZOz/NW4ueHzoA2XTlUXg?=
 =?us-ascii?Q?sxr8hrJdyvDLdNCA1Xf6SHRc1tYuFQ8etSkyqd50oo4TMQqc+d2MDtWEuyeF?=
 =?us-ascii?Q?NNFv+iZ/tP3jzz0rz4lUgl4wu0nwoGlJhzkMYhPeR4+BJq1SeWmE49PdGwlj?=
 =?us-ascii?Q?rqylbjQeSmP1KGlreWl4m1pLAS90XQ2/psBD7EXiNcRYlcHv1pLE8cUNPM9M?=
 =?us-ascii?Q?GBUM5nfMy9FPrj/ths95KEwQIMRNJNEGm0VD42zFKsIE69nCCcxhiHodSNYf?=
 =?us-ascii?Q?21neLBpIgGFpYqXp2mJxha1gftzNlnZhRSzn0mnTOH8EFhAkkl5pgVdU/JHD?=
 =?us-ascii?Q?AOF93aczc2sgUpdfzN/cjOzILPfOG1tbvH4TN1rSd5TYAdGaz1GygCiLz2L0?=
 =?us-ascii?Q?gNfw8FevCDbX49ztDf7NDdcZeXl3CZxecc3RyJZXjy71IYJ5285Qxk5RKxDd?=
 =?us-ascii?Q?jA7l1HuIH34HLJAzHY78hDibJZ1GQmOph2Opqbk3SnFnW4NbUQyFSF5qoWPD?=
 =?us-ascii?Q?r9rlqWTixPPB0aY1LgGlx1nPjNnuORwqgLXk+Yp3BGYuhs6bYGT3DGWNKdnH?=
 =?us-ascii?Q?BEyD2oGSjo+nfoLnu+GJsi+/3bHqoSrueVc2EjJ7auxUrOHgn9bX2KDw0a48?=
 =?us-ascii?Q?mAFg/OmTzSYh7Mq7FiqGCdTj+28fsTEL2W+R4XLcfgypF8gwWcS55w3A1lK9?=
 =?us-ascii?Q?a0ZBhf19ECfZwq9wdFEydMylzGZX9S9RNkD+nN+vrkDuCgNxOnw9pVeWueHj?=
 =?us-ascii?Q?y48kRnQackPc4VV1kMZ90kIcX3KLUkIDOhHX+fNt/WfxWwXwmkwQX4A0aSpD?=
 =?us-ascii?Q?U+4w0XP0AKvxJx+FXh2y0aN7IP7P1zSeWHzvPw/GbAXL9sFXgYsrYCptoHiz?=
 =?us-ascii?Q?wefp6D6vaa1CZpvcjArXQWlLMW/8Ra9VxuLP6QIu42nzpWSv2JavZ5kLCw7l?=
 =?us-ascii?Q?CjXS8za2bEESVGeKjfRmRuk09amtNgXfXB5Nr1zY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfdab1a-0470-44c1-bed5-08da90e95e03
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 15:55:20.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqZ1U94U4Esk9O4AvIWrIsxMutnHGuTtxiQ6hOC9URDqwbRAlJPOJj0cu7Tz6k38EnGKbLCZZzxxFuvAHf37pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070062
X-Proofpoint-GUID: tL3J5HAAF5S3zrJR1lnbdPG4_5Q78CtT
X-Proofpoint-ORIG-GUID: tL3J5HAAF5S3zrJR1lnbdPG4_5Q78CtT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The fix for commit e923b0537d28 ("KVM: selftests: Fix target thread to be migrated in rseq_test")
added a call to gettid() which was only added to glibc-2.30 and fails to
compile with older glibc versions.

rseq_test.c: In function 'main':
rseq_test.c:230:33: warning: implicit declaration of function 'gettid'; did you mean 'getgid'? [-Wimplicit-function-declaration]
          (void *)(unsigned long)gettid());
                                 ^~~~~~
                                 getgid

Switch the call to syscall(SYS_gettid) which was the original advice in the
gettid(2) NOTES section and which works with both new and older glibc versions.

Fixes: e923b0537d28 ("KVM: selftests: Fix target thread to be migrated in rseq_test")
Cc: stable@vger.kernel.org # v5.15
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---

Verified with glibc-2.28 and glibc-2.34 and ensured test case from e923b0537d28 still passes.

 tools/testing/selftests/kvm/rseq_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index fac248a43666..6f88da7e60be 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -227,7 +227,7 @@ int main(int argc, char *argv[])
 	ucall_init(vm, NULL);
 
 	pthread_create(&migration_thread, NULL, migration_worker,
-		       (void *)(unsigned long)gettid());
+		       (void *)(unsigned long)syscall(SYS_gettid));
 
 	for (i = 0; !done; i++) {
 		vcpu_run(vcpu);
-- 
2.31.1

