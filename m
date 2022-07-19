Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611CC579682
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiGSJnL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiGSJnK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 05:43:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A5327B06;
        Tue, 19 Jul 2022 02:43:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J87KFO032504;
        Tue, 19 Jul 2022 09:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=v7nTjnE4RTqkS/nk33ornVWy4i7HA3xUdMEjn7YRZbs=;
 b=WPWZLqqCgTRgzy01rB2ooiGvq/2KJcows+8KpeRaGWgQAKfBIwvgCLH9KliRfbbDGN5W
 Tarfq2xpJ4eIFBuc0cr28sJHA+Pn4MWhoVxdVBSIJ+8UGWrgkZvxuTfOzpxpdtk+ZYx7
 MBb89UyIyL/ZUGfrltwhQlGApkbI+jsiuOxGC9IlAbmuhhWVIEDiil7VkfPohXajCvXu
 N73SrWf9x6yLSosP4qv1vQKLuisOHjuDwxoTA+o2CiWPQ0fNxdwvmBnKciaLi9lfoW4P
 s2u3LEMhfdrswoLFXd7bz69JsL/pR0gkKoQt43HG0VnXZXGg6dN3GZTTvAcpbJXVy8Pb LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0wtbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:43:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8ZggP039198;
        Tue, 19 Jul 2022 09:43:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k4k370-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR2cDm9ZYclF3TKlJ+JFYbP0s2xnuoOQ4210bpoK3Np5LZGZtkdf84hbwN0f3qqBoOywGbzp/tyGoPTF/dexsFDfwyF4hE7Gw/YzcmKivdDRMGpNlS8sFRozCpZWeRviJA2NqD+6EnUab8M6o3B4km/mPAr17f393L51fWo8V7xaJjBRm+hBbQ2N5+iGpikJYC/vXnR8NQ74R1gy7lhgVCbaJqASfMybNyqCrD83xpSRtzNAPyi/upSTlT3kZPk4ioyOg7XYKyYkaUco5bDnXhaFKMTbKk8d2jKAyTu7xuWyAQQAZzIX68QNGl3rAxtEYEyqj5sRzpH1baHMUW2orQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7nTjnE4RTqkS/nk33ornVWy4i7HA3xUdMEjn7YRZbs=;
 b=kfrwqzQ57EcEVY81JfrXRW2n3afsbnDQhxF93FaJrw//A4E+9VbZBIS+xl7uX5B+QDymA2C/+j4iZJtAp+gUjbjf+ggh9pLopaspasXXYAD8BlLWd+h0zs/+aQWqdCDsJtuGSdBDUJYdotYpdKGfCFMVk5U5Sb5o1Y+wwOEXgmgjOLdCrTK/8JMtsrPN7f6XUqDLgjOhm4qOqjfFb4839q6aypROtH0tsZLTUqiduofA1QoFc3fGCD34TWySCH/pyw+4NjTgbV0YTzw/uscWkW00O1b2vDjbhzj/aNp03lZs74Zk16itjLjHJsh6JjGH6s16aoPflUQ1REkg5krxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7nTjnE4RTqkS/nk33ornVWy4i7HA3xUdMEjn7YRZbs=;
 b=FkD2MUk3rNy8nK8hf7gRKktK6ql9GXM+YLjn6pw2K2opcHvL/hSrI3+8n55G1m3Cactp8YGSbdEhjh1yP/gg3ZdcsIf9C8bGm+6K4Tz7uMjWQ8gkKyjIKIqTXKH48PKYbLSVkR7/bHhy8A3dInkFgnzmNazAf3qQsWfbApT4b8M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4946.namprd10.prod.outlook.com
 (2603:10b6:208:323::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 09:42:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:42:57 +0000
Date:   Tue, 19 Jul 2022 12:42:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] selftests/vm: silence uninitialized variable warning
Message-ID: <YtZ8mKJmktA2GaHB@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52a85800-eab9-4c60-0d00-08da696b0ff8
X-MS-TrafficTypeDiagnostic: BLAPR10MB4946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1Ii/h75icPUHIbKnpfD4X74WJqvV7FvRNA31xmE0r4VMHzv4bIX6cbYIHDbgKQKM9Dri8yknA3aaULIgnBj5CoeqrhGN5WYpOfcCO5OI5Na2ze3J8IMe4Zl/KF4vt31rIlGYlQLA6MA3qkD5V4OKhVt7OgFBd4zixASiAigE9e872lkujQThEpwQb7PothFGoCYcRgfjMRKAq0mnsQ5/mq1I84VLrtfJ7NarRnUPJvLXFDPRoWnUMvpghqX20hagGj07UK6WwAxxHUIPG/rixXMyk1eSl+yejQpn5ExaNLEdKMhtdUtJzSIWQElq1VZmQq566cZrWcEVcfPytNPhO0cS1EdNZJ9z48l1w1Z4gnPxe0ZwgCJHtKKn7eZz5rpXS8/ocMNCqV5kOvCzaHbQNAe190jbMZuDcWe8P+JeG+oKxoV8UsOnnkZGkzWOa+0IVdVNVaJ4IlsAlcg72AR5ak34Pf3FyosWN9ITz45n7+UqUZpCfUkzeuSbIjPwEj3gsEXOjMN+kBrzur62EIZf5QNmYRPCvt0XGRQB8cPrAQe6bvKA28ZCkXcS8k6G5H/hpZEkT4Xsj3Ta8nZGZDi44+VjHYLzWA2fYeYBmqD48kK37ypiJmj2A/fod89WQcjoayQK71Ir+DCh4VqclgEq9il16xaM8l8kWP1gxf0XBvHjSV4EEeTt+0b4TK8gOZ4jWKSEX37EKwwsx+R+Dxg3Kd3gjFXo/oolxbphdr8fevC1zcgws7sOwd6hub89MnsZ6Hq5j6vXnPLp8y2mGKuaqF7u7O/WSHAdVvfSIUhYZM9/nkJkYrYEGsMRvNJ2JBa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(6666004)(33716001)(52116002)(110136005)(4326008)(66946007)(66476007)(66556008)(316002)(86362001)(6486002)(8676002)(478600001)(2906002)(38100700002)(8936002)(38350700002)(41300700001)(83380400001)(6636002)(6512007)(26005)(9686003)(6506007)(44832011)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5hSg1BYxtL2MfihB04zZ8y1+l0U1DQxRBedrr+OIuWCZtF4lpLh1ZyujZ7gI?=
 =?us-ascii?Q?toBeRRtd0nr3KeBi5dmAEwI5gQxqY/sWYtCKIIswsR7PJ4lB9bZj8BtlUJH1?=
 =?us-ascii?Q?gxMUwtXCEZ3LgRIEubS+d+IowpVzjMUsY/tb0kPVzsRTTTpFx3HGdIuwVPPi?=
 =?us-ascii?Q?ooiljG0EYIEtZLdjnErcjgEROMtcuWp0TUsyciETxRWZUrM5Ax0LDZD9MBSp?=
 =?us-ascii?Q?E9M0SI+oJPDkq6I5OJWB65QjFEFujfi6HyfjK5AshZCgpU4sUVfIfB07CTx8?=
 =?us-ascii?Q?T2MOij4OMNQwLVT7wUqGAnHP5/FM0isUNPVS6QDXh03+4fojLSWCBbqGz+X8?=
 =?us-ascii?Q?GE+CZUOAG1WTTSrVGxXlEXqHrQm08Fl0VZ+DnYHDGEG2PxQ2JIKWD3Y3Ezlp?=
 =?us-ascii?Q?wCwLtu+SrdkjSLnZ32RsmwWIvNReHm8ef+PSm5LuxUOFc4VlUxqs8MkEsvsF?=
 =?us-ascii?Q?lG8hRo4bjKCeKZUhb2Yl3BP2FhXSSNron3nSSN+Qok75dOrz6bpAGIQv36P4?=
 =?us-ascii?Q?lNsImE1xw+a2r501BAMWDNEFyyw/e/4EytONL5k+06SHK/43AedMOwDSnbqS?=
 =?us-ascii?Q?BcmQ1S/DMbxR4np+0DvtZzQWakFSuHuJ9GWxqGf6pfTzFOeU9ZbRp0L2nU98?=
 =?us-ascii?Q?6qb30ecfxhxF3i3gBS42T1OoFCucV7VoZ/BpBqWkL+RisM1cuoO62sUtUvxx?=
 =?us-ascii?Q?LiR4Mwhkcjs9uYx/P3QjQtffy7j8Et+/baxpknYtifBXQM7Ljy59oRCs01PM?=
 =?us-ascii?Q?whglvAI83Xwz6XOzI2JXy4V/IIMIaPlXN/ITXQA1SiKhT5UIXtxDT/yHdycx?=
 =?us-ascii?Q?Zrvei65nPtTG20PFvnt23Cy5m9omOk37oIfPgF0b88ZvJ8zFknYARVebep7w?=
 =?us-ascii?Q?PAdmfCB+x4WbmcxJIDwRkZCgy8MseFzVEHcUox8ggLwVZjEX3fiNkekYOarv?=
 =?us-ascii?Q?q+sd0tlRVSPe3lADyKCxZidnoFfW3STMlIuURHbCetZa2F6J4H3dDi3McPXk?=
 =?us-ascii?Q?0iCpqoRuOzFZ1D+x1SPUYq4w5vS+oLUKq5gZh/RCbhFIewM/z2GQ7pqDS1Hy?=
 =?us-ascii?Q?GW8t0xI3w003L7qjVf5/e8ZLL0efIwSosyFJ2cGQTZf40J91BVMqa2AKBclh?=
 =?us-ascii?Q?jnLgkiJKEyY8h/k8Vg5rkqkC/Ugc2MEpdCS75gMq0MO7DSbufimI2xTB0P4F?=
 =?us-ascii?Q?WI2deEZWHo9Hv3lE0NF7x+yNLXSH8FFTcP2brxed5/zQ+YRxNkLvvI2/6PGf?=
 =?us-ascii?Q?arh1ql1P45OAlPldEYdrse+CvRCW1Dn8xIYhC/kk4RsLDhZzAOKUGjPcuinw?=
 =?us-ascii?Q?UHlS4Dl+nWfrFX5Tk81JaIUpk0Qx+kTl4mxUmUbQ/z65mHdooBeM2dDBgeQF?=
 =?us-ascii?Q?Gt6bQp7RkqzI99166CXxchy12g5TM0q/ptHIWHNMJ2i3LRKOEt4LdPqfzizv?=
 =?us-ascii?Q?6cqcrFg/MC4O8jA9CPm/pAtQU2NGw8YH9wyORoseii3aOxbA0xNkarH9Sw5x?=
 =?us-ascii?Q?y7jtL1Mt+JK5DVH+iBx/1pIuFc/qjZDul0MLnvy3wLr6FnOaCXhBTA/0fL4N?=
 =?us-ascii?Q?o9grDz7jjuakUWMcMKTr28tZKVu9to1VodPsaqQwF5Pg5BocfjINciauT4RM?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a85800-eab9-4c60-0d00-08da696b0ff8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:42:57.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9YtdA0pWCtXcp6rrihfK8nqnxowSVnn4rNzCEKxKUNlfhWbep3x4ZWwJynsDQeQKsnGLhmDYj1WckbYwkRVjQYSUgBqX9GLgLT/yd2NhWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190041
X-Proofpoint-GUID: aakwHGYXTPYvQHBg8sAlVkFlX0qOSZkI
X-Proofpoint-ORIG-GUID: aakwHGYXTPYvQHBg8sAlVkFlX0qOSZkI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This code just reads from memory without caring about the data itself.
However static checkers complain that "tmp" is never properly
initialized.  Initialize it to zero and change the name to "dummy" to
show that we don't care about the value stored in it.

Fixes: c4b6cb884011 ("selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/vm/hugetlb-madvise.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
index 6c6af40f5747..3c9943131881 100644
--- a/tools/testing/selftests/vm/hugetlb-madvise.c
+++ b/tools/testing/selftests/vm/hugetlb-madvise.c
@@ -89,10 +89,11 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
 
 void read_fault_pages(void *addr, unsigned long nr_pages)
 {
-	unsigned long i, tmp;
+	unsigned long dummy = 0;
+	unsigned long i;
 
 	for (i = 0; i < nr_pages; i++)
-		tmp += *((unsigned long *)(addr + (i * huge_page_size)));
+		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
 }
 
 int main(int argc, char **argv)
-- 
2.35.1

