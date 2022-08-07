Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A311D58BE07
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 00:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbiHGWeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 18:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiHGWdl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 18:33:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5EB5D;
        Sun,  7 Aug 2022 15:22:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277J3wll014171;
        Sun, 7 Aug 2022 22:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wjqbEeyeEEEjv5oi9cfBJIi/Tbb1BRpx9Oo080ZpbE8=;
 b=QSfMs73PYG670ROBFFSGIggfOcWxGvRKvXsN7NRpmKernCLFuHABKYQcDVhneRXElJhq
 Eo5fx2in1UG5K6DY7j/KdSb4lIdshrL5xCfL+LXZ0u6coiT5JT5khl4JPZ9yc1XTdaW0
 wIFGx2XKD7VHtyBJ5jqp9TMJRuxih0Bbpj0xLRIC8U1PPqvPnRqe8NKpAc6z9JVzRZU9
 Hjr4pWwaFpFNmZnTxOb+jDrzIUgkhR5oc7nLZ8T77bSf+loBbrtm3B8gOsqEfcY21VhD
 conHEahVdubeEN8cy9lI320/4R3GmdBYa7hCyeD0tlm6c9EVwl4osNRLabzzZxfYgaFd wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsfwsj14q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 277EZHKs004533;
        Sun, 7 Aug 2022 22:21:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser1dd61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTeRSkZCKmCTVqXNgYXjOyRMOuDHBITNE9nHKYE5pNC/bFmjGkwK+lBanPb0noyqBKAOtbIOeBQVSTA3pDKkDviuISlcjA4l4Elxu3bg/ZsgyZWnU8MynibUew4ePkipOajzL3cn3LB2gOyXylxs3peDbFXqpqEugMNSPoJOepmt49SwqwnaZRqNNMgSzsDp0lW+5Te8XvLxrmxaZlRZds8aPNvL7/+mb0Ldb3AWePngCA8132Z/WVtIyvznc8M89cde+zZxiyOMzdY94zcF/b6Ui5oVIwnwonPM9/gCDrs6jgnOWVvzHyWutB6uX1MAekWsVElDmMSQfBz/kq5xiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjqbEeyeEEEjv5oi9cfBJIi/Tbb1BRpx9Oo080ZpbE8=;
 b=BA4LI9XCrZ2p6UhGfpgKeLKtEi2e0in/tC76oPjaThjTnuA/g7CrhSqRRlBYxXjkBjr03tm6MnTLYkXczYK7w449ECvEvXpppTqA7BZ96NexPIYRaU4gkAVrr7XVS/JFZ26dt0soQhyT6cPT09pZZAFV1GtG792SPQtTZ6hXYSqQ55QI6e969O7pffpJoJP/zUVaOCLy/4c8rV7q4Hif34FqHPZjw5JXk+g5GBzMUZY436oexu8IcuuZxuVg9F8lPQRjdIO3I7QyWZ94I+yVOpBoG6udpyH2X6DaZWa6J+yWwiiF6ujqBouRCwvCnDJQDe027/GJTqnob/Wlk32C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjqbEeyeEEEjv5oi9cfBJIi/Tbb1BRpx9Oo080ZpbE8=;
 b=SfJ0ozqrDwNS3L7MY7os+WIGRXCN6ouxkHh50AqmSEM1W5K3xY1eREhzU6NEDJkNiC9GLCA8KwDe3MPHp3Ovg5HRE3cNEWOANxOqfq/WkZZH1mL1jxu0NofKYoot7YffmxrpganBcTWES6DPFJglJ7KE+e0ggOclOzqPyGPr910=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MWHPR1001MB2381.namprd10.prod.outlook.com (2603:10b6:301:30::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Sun, 7 Aug
 2022 22:21:56 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%9]) with mapi id 15.20.5504.020; Sun, 7 Aug 2022
 22:21:56 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org
Cc:     corbet@lwn.net, mingo@redhat.com, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC tracing 4/4] tracing: document > 8 byte numeric filtering support
Date:   Sun,  7 Aug 2022 23:21:23 +0100
Message-Id: <1659910883-18223-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
References: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f98d52b-e918-4b49-87c8-08da78c33cc8
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbsYLbNbksXibrr/Gv6bk49TLpn9oNVtSLMIqsaE5uMJiNkr5yDJGs2rbWQ8O72tTCdyzdIiw5Q7Cz1zq9+L5517LO+vsk9DbyC1wsy6IVrfOE/kIyDvzEXH9BdYc8cdYukUTpWekWzLlrJz2QzRj6S8zASgRPqSV1P73O6qRqdcMDtCq+CAw6yVOKJ3OlEkVoHqdlAooePS3kcVQsDjg7IyTenzpyOmHrcC3skM/9PCeVKTPs4Ozd0+jFogL4GaSkVBzMGbhwWVD10HcOMn4XRr66S4NJ8ovbp4K3w00osgiAJf5SjV8N3O2opFV7qsXRNZCfyVN/W0UxipFw2nB+oEaaxQOUdCEV04TPi35g56zKh4m4AezBd4LPXXjWd+KMpNvnFKMURc3ApnEuV8HoEzxFf57kZ1GbA6zhppBZkkQN+Zu/oXUu7740h55lSWrhU2h9fsc7rMfQE9RlOXX1AexYIh+FGh5Ut/S6JU1+fJFd86Xpt5HU8gp/yBvt9CM0Q+ls1Qe+xWGLI4xaCdSc9Kru8f3Op9XdwgjEXCk5s02SzbDhFkBdbxwfZ90ekgaiqsg1MGTLnyBsf2wXBxz/nT0QNZApqhS2NNTFa5KuJTjlJ8F7Y6dkPRZutRn3K6e/iy3RMl/aUUsKX4HAcFCgSnpNyid1j9ysZ3tmH23xFAlbrjrNyiJC2UlA/7j9c8fOlZFG7WfOdVce6215taQkkMRiUV+hq3mMsL5dxsA1MCsmXVlcmjcWlyAtDkPnbOcw1uB9MGMc58t06TVVUVEGbGWQAbYKD7vikRUS33F3whjhYRjFRJFco6OEbrkVGP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(6486002)(186003)(52116002)(107886003)(478600001)(86362001)(6512007)(26005)(41300700001)(6506007)(2616005)(6666004)(2906002)(66946007)(66476007)(66556008)(38350700002)(38100700002)(4326008)(8936002)(4744005)(44832011)(5660300002)(316002)(6916009)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y4hyenqr3VlJBK4J+Dni58SpOXtKWdp/AOT5N6boklXlEt9LHAfnOBGIzyAE?=
 =?us-ascii?Q?9U5lzPX+czJCaos8V84WXQ3i0nuI40hiQ3EOdgjXfIF6yK4Itit+W3PbVbkQ?=
 =?us-ascii?Q?VEVky6gCei0eYPk4U5zajxhvPJtPfTj1B77TRNDa5GkeOnFAuJpn3sH11fS6?=
 =?us-ascii?Q?oDYbjhTbGM7P9FMS+p6weZ9vx9UIH4LX/Ijxp0XuNxCGVbPdtIPxqjbVwl+x?=
 =?us-ascii?Q?stgYu1AekG6HfvVF4wCUpqnCaU9wY8c3q0rVi0X4WZbLuoe2THrgGVMLPuT3?=
 =?us-ascii?Q?qVQhDieocGyVxX7INOk4ntQQlzwv6qRXaNcfOXP+ac1gHuzvgrD4jitq9A7e?=
 =?us-ascii?Q?eydBHnBFerZkDf/K+YYyBKd35M2ABgjvdZTVL7xnSxwxoc1UfyVIq8ZGuVGF?=
 =?us-ascii?Q?vc0AwduUyHYvAKUj9zLvSfzd554Zmn4HJfi628jTwR75amEVhxGeyxFwafRd?=
 =?us-ascii?Q?ydlL/8KesUu0ty94loYgTbO393ADq/Bp+Em/pqUXEpydrvBP6U/w8hwIjk0l?=
 =?us-ascii?Q?CnpCvW++JRMl5wX+Sm+/+djyxyOR8GpRPFdNFgUXN26DH+X90fyqbUZ6KIbj?=
 =?us-ascii?Q?STXg8fJ7nhlOmbpsrjZe+3DfPfxRLE4hWTCSt3ZQHn/ZOJ+XkoV1fee8PwE5?=
 =?us-ascii?Q?HZqi4m18jzQdvQpJ7ykRDpn9FfalLuHcvX0vFmAW0dSXrAb53b+EU+XNf/Mb?=
 =?us-ascii?Q?t0mqjtDf1eiULGghL1z6a92PQhkdd4oyPLnN4AQ3xkmMx9efFEcXLy2deasY?=
 =?us-ascii?Q?dXBOOpxHnNRDGv+iaB4ATuRvGlbg9sCPsoabNgSC6i+Fbb2qrESr5SaNdzPJ?=
 =?us-ascii?Q?ZYodS9XrS2N92MsNiwdsF+diZHFaSS9b6gke8uH4nBo3PLsskKsK71dCXm8y?=
 =?us-ascii?Q?pkLt37xiBToA27ZiKh1EvsLLd8mUN4I4rMMKy2YLkx54yuC93Cma6b6lH/kN?=
 =?us-ascii?Q?FFlnffDzF1YmJ1eqt+rY7GKASnO24MTzZpEuG+WF1OKBpfMgtQNgG1HIIFP8?=
 =?us-ascii?Q?492Yib8fJnGVeNfjoCSQbnDQILsh+ELLnmk1Hv9uS9VnGtEGd4dxYZHNP6CW?=
 =?us-ascii?Q?rFm3LTO1VIIsVcEeywPxsc6xl2i9xQNbPKpHHfLolcrezhgDth8TxUx7OIW3?=
 =?us-ascii?Q?aD2Ojc9CQgv+jDcgtljYi//xqjz5Df8tRYLKY2T3mhqaB5X2+QSRe7sFTP29?=
 =?us-ascii?Q?kKOO8cEbkGT5YHGeVbDLYUl5f21kOZfgsTP9p38imsvxjT4VlLZ7RsQLB/lV?=
 =?us-ascii?Q?xDR7i6MjNk+rEJSri8AwZlciQSYc7U0K5VhVNIJjhaf2AVB9JKYukNyZdZA8?=
 =?us-ascii?Q?QU0u6tu4pa6ntNEPZBBMsAUwHv+I35yICKwPi++2vX3v1zrWcktXHLd7A7Bj?=
 =?us-ascii?Q?6Ja+hC121ZRlZK6MiaBWIy9r6HPyv7diopqQslNDgAbhd5GNsWaJkQ1Tp6Fz?=
 =?us-ascii?Q?Vp7LcdtIz3dMSJrCBmaT8p0wyx7v1mlktRdMCbBRjOKEUyR9RKNcURX8x5HA?=
 =?us-ascii?Q?TzC6uA2p7EzW9DqfDhBMWlsOYKc8opg8u60f9g32bZVV4DFgjrYLQ62LjGtk?=
 =?us-ascii?Q?YBhGw5DzHjqNp62A7TbIzAhs+hVBsfKcyr47AfX/Lg+bbRQp79co8IKx8Hwa?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f98d52b-e918-4b49-87c8-08da78c33cc8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 22:21:56.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2eVXhodokg4Sk0gQcuEafICdQAoU0ZOE/1I/e3+3sfcFz9OVBCHH4/g6LCkOO5cz/gRGhYV5glkTAzTNDgB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_15,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208070119
X-Proofpoint-ORIG-GUID: ReqRWd_8AqnxOw73ZmFFIHuWInWL8xeQ
X-Proofpoint-GUID: ReqRWd_8AqnxOw73ZmFFIHuWInWL8xeQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For values > 8 bytes in size, only == and != filter predicates are
supported; document this.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/trace/events.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index c47f381d0c00..318dba2fe3ee 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -186,6 +186,15 @@ The operators available for numeric fields are:
 
 ==, !=, <, <=, >, >=, &
 
+For numeric fields larger than 8 bytes, only
+
+==, !=
+
+...are allowed, and values for comparison must match field size exactly.
+For example, to match the "::1" IPv6 address:
+
+"dst == 0x00000000000000000000000000000001"
+
 And for string fields they are:
 
 ==, !=, ~
-- 
2.31.1

