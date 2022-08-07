Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8858BDF9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Aug 2022 00:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbiHGWeD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 18:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbiHGWdj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 18:33:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A9E80;
        Sun,  7 Aug 2022 15:21:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277J48t2022517;
        Sun, 7 Aug 2022 22:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2022-7-12;
 bh=JyyDj0EDBU3gXLp7WDCu3LF4u2KVOuFua0EfbMhPhgI=;
 b=aH5PgtQQ9DhAuDAlCH3dwLULWEG9MH1lVAWhhr3IyQSGGmXkXNT2w7drW2eJ5v5lZ74A
 VgL2Er6GO168pbj631HbwlsU9H5SD20xHqHpgu3fB5zQ/kplB6IN9y/0RXm9wgrdwW8Y
 s6NYvNK9QNKbLPmcoMXEqP6VJZ7RyIiqn9yU1OtrAYz+tWD/8TdCMJQcUSWityR12IeF
 Dkm2fzSUNvD3jDwWFBeVyyhg4WhmuNL6Ov1mR36JV8iBh8d1YRSAbsr7rxgDGYyDukCD
 ysFSLy1HboEjTb3nphhNom1jEcCWZuu5U/YRI4eSEzV4ifYeLRJrtRVYFc5J9C/BL9pb OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsgut205j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 277Cj4Wk008519;
        Sun, 7 Aug 2022 22:21:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser1du2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Aug 2022 22:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZsC5EwApoVZGtqYhW/rrZ8JzGHvczzh9h5sS3acX5v1evqlfBOpBLmn+gRtJ6k+FsHKC8Tux2JO1GQzmiQCv/UVXH+hucHAeP2WgXzUt4oxsIc8Bgvh54LnpYgDOTuJJKnGH7YhcVFE35fPtELTpy4B1fc04J5XlrO0K66gT9nZ2D3+LJqny+t054UzGIz4TSuGYxFqmyGP8Oi12dC1jD9Bp1eeAZ62dk1576lqtkgcd4fZCmHbUVpD2rzmZyXLqMOxHvkGvZX9WKaPO40X5bv2G/k+8unzZq3TgAt/hSZQNZC8Pt32fsUR2xDODfRyVvYUzcuyk0omhwpOJZ0J2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyyDj0EDBU3gXLp7WDCu3LF4u2KVOuFua0EfbMhPhgI=;
 b=OM4tmjaOJ3H18nb7+v0jYVxaLhQrMQSlHrzlSlS9J19VyQlTX1DuRoE+TO67eJoAJupuGXpXCmsB8lhkI+2T9qTsAhEKbFpc0H0VmPaG4sjJvcuqPk2KLDPv/FAc54DZJpoyXDvWnGehoPxqz0Zyvh2A3U7zrOYp2ullToGUa2hxkG87Kh7sIdj8r86IKibWhWXT29Hx1iKc+2Jmr7XMVF/+lfXcEZEcLgfL6ZDxoRcn8029gGsAI8+n1oRMN9+Bsh3e0gf10mNhkQCWawbas7ZS3f8gDqEjsuCuNU5A3wJKcQ+sQ+A/YMRzrAO12/NIPNJaAi6nv9rNk13jdIy55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyyDj0EDBU3gXLp7WDCu3LF4u2KVOuFua0EfbMhPhgI=;
 b=Lgt9JCGcVfD+TaTHO83JcpGI7dy4ymLAxiIRQ5jQyJo32QVKomqSOClIhEJAdN32lSiOTSW9hlFds9V7eV+rfUlZsx5nFPtT/XMQdqpSZ0nHykS8TkKGnepqqYBHVCjFRjpBJM4lJKbG3Zfjj4B69bTZs6KeIdcUDjq8ciIzmmY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MWHPR1001MB2381.namprd10.prod.outlook.com (2603:10b6:301:30::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Sun, 7 Aug
 2022 22:21:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%9]) with mapi id 15.20.5504.020; Sun, 7 Aug 2022
 22:21:42 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org
Cc:     corbet@lwn.net, mingo@redhat.com, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC tracing 1/4] tracing: predicate matching trigger crashes for > 8-byte arrays
Date:   Sun,  7 Aug 2022 23:21:20 +0100
Message-Id: <1659910883-18223-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
References: <1659910883-18223-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 927b604e-6fe5-467a-2fdb-08da78c33434
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lp5igK+aIUp9LpAlk4S9PyYN629GN+VTpvQLFxzrgU7Qj99jXeaxzqtwhxe5UxxjaWzKCTOtV4T9QyaSXfFkmi0vl3rjqZIn6G4mgzAZq4E5HxoF532XfIaGjMK6sJcrkv2rS/RdJy6lTHta6xAal1Lr74tgaq2lFufJ0WUlDcf18IHQRyaGbul7OUtg49M+H/v1gfFsZFX//aloUqZQvK1y1uQr6ygeJO5mtxazdu25pmdyWc69n/SG9JmAw2MobnslNTHZxD7c62jlSYHDeW/YSua8I2nXWIaQ/SPWcbjY7Y4fgcq99eQrIejQwRSH+dCnEVVXfUfdYet8TtQ+NvNlEZ7sB5B9pZy30qe8xxYZ22gm6F4SS2hVvs1aNWHCAp6Gx6Sm7SKyV2AJ3J9P4BniQ0s7Eae1ridYhDr7O/PxbBupItvmX+mLSZ73Y54v9s43n4TuXztWAPrZoqbMWrqzKgESEcFcR91G0tLsRyLw+GGfJdlqYvigRY0yW+Emqw1N58nK042QtncP/uoXmlTTTC47Ie/mv/AzDVJLf5jMmobIz3VmPpjMEC2L69fGEyETjygJUIQ+tR13sNuGq3AGO9GJns7DL3OCycpxx1ty7WOWpcCyVA4szrUtjaxeQdCTMvzdgTcYl91VinCdtZB82xrim05/aDgRSBska35s/BD1OpxVlyEzCV169fdU94lo9oNagWyzjcFY1ftPFTYBNmUlMQgOuL/eO8yAr2iY04EzrsRwKf5tduNgmvaos+AvIt22U6bYx59sl4KzXfYUtb72mSAufTt53eapzWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(6486002)(186003)(52116002)(107886003)(966005)(478600001)(86362001)(6512007)(26005)(41300700001)(6506007)(2616005)(6666004)(2906002)(66946007)(66476007)(66556008)(38350700002)(38100700002)(4326008)(8936002)(44832011)(5660300002)(316002)(6916009)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0Gj0tzHs5/Y6lVWWHkoe2wboqVrm3AFi+fYO0Fhpf5hjBwXOm5z/bscyejY?=
 =?us-ascii?Q?WuLSjdF/hKyWdO/WH3GXIY5EmcxhlSOcAjVlY92ZS3M4437adqBsfjUQiB6K?=
 =?us-ascii?Q?nV78Ed8hmCJFR9aw3+Nd0VTtse2ztlh9eDNEEgrjASJ27NYQbze4mnJ1YWrg?=
 =?us-ascii?Q?GqDRW3u+lsNb0vBxFR/z7+4M9DpxRsvxD5h+Snf04kQyhtWuxC5sC6VqnVmL?=
 =?us-ascii?Q?cXaD3piK6MxJifrbGUIKowyspmSmpGSuFkjA25fSVOySYPQEsaHtmGD/npRZ?=
 =?us-ascii?Q?Ko9axWWgtCN17/rrEhE0P2ZnmThnDPPnXRhYZS9bXGsLfNN2cMOXTgw715dl?=
 =?us-ascii?Q?UMONyOYAIY8E8WzbWRGNJskkzxwWLeyM9MK8jY7joTb20aaBFsyIrc2MSxMk?=
 =?us-ascii?Q?VUROlgjkqbeZYjhAr8gEhGJVlpWzMVpdsoYFUAOWV4FO+p4YG0MmHKM9YSTA?=
 =?us-ascii?Q?+W6SM++zdgTbz/40ZmXbLYp2zvmH4g5OLv/IiiAYct0nQULExlTLSrrmvnMd?=
 =?us-ascii?Q?s5DnM4HOTdYJKinPrzEbYlP42bDQvXzmb6ykCDAzrWYMCRcCpFpNKigkEZX3?=
 =?us-ascii?Q?NlDj72/GST6IEAkt3TX3yc0lg4p3NZt+Crm+ajKKgjHSmmQSJF7Jtu1D0DEu?=
 =?us-ascii?Q?SIsQ8IvoQ3xccevOjdH/S0Mo8RuSsRyKEjqjTMgH6vM9yUIb9qmevg4+37YB?=
 =?us-ascii?Q?xZFOD/QQj4iqgo/i8Xk5jStSAGUUoaSJQQakklWz3AAnQd0gzNATtTtc2s0+?=
 =?us-ascii?Q?lx4CiP2hywmtSNWT6/g80qRN9eEQ/BQOO14SLfwQCSLwD/skCD/Fqjg/J8Pf?=
 =?us-ascii?Q?eFpRVJywsYEY1E6SdWZEW+VFe+GWSXhZyVWf2Z9mU0ZNdIQ/pk5qi7uLXdZy?=
 =?us-ascii?Q?UH7RQqMgn+ZJIYh6oHcuqePd093FRZlbBu3Sj0vvsiYw/AXDOs1w1Q7phJMq?=
 =?us-ascii?Q?3PX956ou7s215JRgtZWbzD76FX2Iof7e3up7RtIIhP9GV9Cyrk5jguJ2Dl0C?=
 =?us-ascii?Q?ZFtWTwjfcBbrOlzlNrSUbmuCA4o/bj2p14brAkCLJxsjVWhwda0VSgDfTNGT?=
 =?us-ascii?Q?2jMuYOZay9/P7xyHAKss3aNB8r3GBfM1Ys9JQMQz19eTpW6vYnXPrjK+LFFQ?=
 =?us-ascii?Q?j6wZVcRTuCVOsVeAL9PfS9pmN2PB5KNWFdmb12TfsWYP19wim+kBvi6dNFvp?=
 =?us-ascii?Q?JDRmbgBVElHpkZ5HR9zUFk7Iyndy1KEPkarbPv+cJJwjkNPKZp/8hrOfcutW?=
 =?us-ascii?Q?hM+xZnuS/pJC0/2kHQatwh4kJH9lW14pBDpPNP1LJNpOJXvDd7I3OyjIu5wH?=
 =?us-ascii?Q?VzLpIGDKOaVcb39qdBEctsrzakmyp26O8HE6FeY3+yXGR6PVtg2VC/yhkUr3?=
 =?us-ascii?Q?lT5YT9lNTcREckkHwR1T+m1MB+QZ049Jn0tb5OU9yFN8WcPwAbif2Uhpb6Qi?=
 =?us-ascii?Q?XaQ3J+/rZh2+Fuf97HjmqkalgrfIJU8VlbLrUjN17mUQvUBH5fPfUNP5CyZi?=
 =?us-ascii?Q?FEfW1X9oHWEtIgq0sEELJVJA8WI9Xva1klYVX85camXDEAtysHco0muF/Pyj?=
 =?us-ascii?Q?i7aGl5lEgFV+G91oEPsGWDuiEyYzRyWeiUW3d8VG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927b604e-6fe5-467a-2fdb-08da78c33434
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 22:21:42.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgsYxPHj86oM9s63s0wFNnz6KTIQ3TeDW2582J3ONqk2Q7prlFrpG+z5/CL+BIL81OhDh9E3a6fRBAT8FygNOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_15,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208070119
X-Proofpoint-ORIG-GUID: qQu79qGieTzk9J0YXpICAxdrlkyuYRbo
X-Proofpoint-GUID: qQu79qGieTzk9J0YXpICAxdrlkyuYRbo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following (wrong) use of tracepoint filtering was enough to trigger
a null-pointer dereference crash:

	cd /sys/kernel/debug/tracing
	echo "saddr_v6 == 0x0100007f" > tcp/tcp_receive_reset/filter
	echo 1 > tcp/tcp_receive_reset/enable
	wget https://localhost

This works fine if saddr - a 4-byte array representing the source address -
is used instead.

Fix is to handle case where we encounter an unexpected size.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/trace/trace_events_filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 4b1057ab9d96..65e01c8d48d9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1490,6 +1490,11 @@ static int parse_pred(const char *str, void *data,
 		else {
 			pred->fn = select_comparison_fn(pred->op, field->size,
 							field->is_signed);
+			if (!pred->fn) {
+				parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP,
+					    pos + i);
+				goto err_free;
+			}
 			if (pred->op == OP_NE)
 				pred->not = 1;
 		}
-- 
2.31.1

