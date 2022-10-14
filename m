Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9D5FEBC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 11:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJNJhp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 05:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJNJhn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 05:37:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288A16086B;
        Fri, 14 Oct 2022 02:37:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E9U237009410;
        Fri, 14 Oct 2022 09:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=R8dVPXpuA8X+c5WW/Nk3nBhpKnilhL3ErY59oEFpQ9Q=;
 b=lX7Zr8ru2JAyDHtRcrrNgY+JCjbWOTL5Vi+8HUY3sC8GYRCYcWt+N4drSBAROo2ug2Wc
 d0tZXBd4aZhotfYjglM6/5uUnSppYIctSP7JOC1nTKqriFJf6Oqmw+zjaPUvmx2j5vWg
 bkuN372WOIdDd+Hkq5Ai8UZsy2lhpiwmVuSaSBMlHrQuRnQBR0pilVItiUjXyuZI6EZ0
 7h6AwtMkjmBiwiNrCFgbXdKosMipewKlIn4dMbEoS8S66R1UiX8jZm5bD2zzpPddrcz0
 VE4BECXssKRoZW6hIzaQPF7YHT5SOwfUfhP8WOiGdbu3WVafsUp1Z4t/pBTyFcsfl1Y7 Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mswj9e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 09:37:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E8MiNW003830;
        Fri, 14 Oct 2022 09:37:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynddrwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 09:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGcPPm/rCfKBGP8O5MCcEVyWtKOf1LIgKm1Cb++fSReX/NNy7QZAcVGBPBRgtW2Lz8xPrT78BYxb/iliYs4tKIAVVEQxxM0tfSAz2+QPzINrTUina/j98VujD0wiloo7FpuHHcCaQf3QqNwUqXyBRtOEWKphx0wNBpGkcP5q2zP0tYg6kJY0hEtue2VDrmw+TOZv0H9nJNkW0hnvWSWPEdKIzKoLteAZumG7ddYzZKAfyZtr8NvYWZUM2Z/F566qroQuF0t9jGY4gYLTNTYtHyxRmo2x8dL30jS2jEwJs8FJSwPMUHl8Dma5tyKdhTMide91vkme1sQGMQAd2yA+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8dVPXpuA8X+c5WW/Nk3nBhpKnilhL3ErY59oEFpQ9Q=;
 b=Z6QG3LseVxH/CtQ4vlRwmeQP1+RDivqB3fpYHzwhbecFmk0fY1FN8jqugiUuB7zxoBYoQUEmbqrR37RN8MrS+18AebLvLValHv/Wh/umYr6V659rFNGAoHHtAYJzc81Z7PxVGFBRtrIbDMK0HOvZCRka3ko9V2sHp8KMueGach5M5kINymls5FPXpOUaDijLNPp2EFVfNNQodw6gZr0/lAaJNSjbBzaIBkPQX/goTXUErulW4/eeMrlwMD4EZTWPs4roFKXXP9haMUAdRV4rsaT9drfMeucCkRWAqr53q0h3youxrOSS6altAiwTxx/oCKarkJsW01LGviDN3AwuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8dVPXpuA8X+c5WW/Nk3nBhpKnilhL3ErY59oEFpQ9Q=;
 b=PyRx9gwfC2DW1f9m4VGuKcfzEFfbHleX5qeY09MtZi4CqNFA/Jxn4quFHNo53avAcizYXjLz9C7PCJPD1X8ZzCGM1gcRE28smSsWisrU6iAXF4/zHVcvzImoCZ549UglpAc2HFYHEvaVhgMX3i0Xt8et8wjXG4reeQZZvmeBhfg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 09:37:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Fri, 14 Oct 2022
 09:37:31 +0000
Date:   Fri, 14 Oct 2022 12:37:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: update NULL vs IS_ERR() tests
Message-ID: <Y0kt1aCTHO4r2CmL@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0193.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO1PR10MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7122ee-a130-4898-37b4-08daadc7b743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjucW1x6GPm4zWUo6BGNxjt8RariDqKe0lgmjVzNlrFccj5IrsVRBqDwGQ+OKboor8YoiqjY+xaxWWrf8ToBmWq/z9aMo5SdTIHX4Q0XTR1taWvkbbCfIjL6j2eM57vKBFz3lxxGzV9ZjEH47lUG6G7iZU11wxPQrVPs48CVr8N3Gt+OpA4n1pVuwTcKjPYxKuSzR1Sg2C1z8Uwd9RvVPqtvV4sLjyfgE2LrmnPcWHQwaKrshZiM6eCAtA3enKI8T/09Bx3xaqwIe617BQuBWt3Ozsf5W2Cq5ibxr2qelJkWj1Pw2i7hMOLRHlC3YtOdQBMQcBmmZSmUQ3b867guif8u9SBWPTtFrTDuWQK6hr5Ev+ELH5vMpiU/+A5xY9mWOGoWhf9RG+TlUZF8Zca3DbXvCF1ii5A//Gxr0OpgWXhEAkgEyezcglL/uIVD/9jOvAuUBRkBfVnEotn2lwZL4EKy+s5109cqEyDom8E0yxtMB42hAJ61gIMN5EtMN/FseKM4lt0NTjujau0EJCyzK0wJtAEPFlktWXl4V7WBni4ifhLtQ20lueWHTgVUoMgnKsbahRzLK0lNqU3/PfjBXvj81ZgpQzG1RtY5dZerznP97A4f6z2yQO0nVrDLyFytjCyq6VH7wohIyZFAg//JJwLP5MJ/hD71sDQE/e/Xmq7IyKIQ5MY8BZTqVdznHQWyIPIOs+Abl8VIFvQ24TfDqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(86362001)(2906002)(38100700002)(5660300002)(186003)(9686003)(478600001)(66476007)(66946007)(33716001)(66556008)(316002)(26005)(6666004)(8676002)(8936002)(44832011)(6512007)(15650500001)(41300700001)(4326008)(6486002)(54906003)(110136005)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fC6kIrjrMBICCwIo1I/exp5SdtvCE6BSHCWGjovvXE/wjBSm0miM3GUs7H+Y?=
 =?us-ascii?Q?LpM5MrVe5355wx8AXg4vPCy23WGkoDiS/E4Lj3PWtWdhSofcLSZOkC+BAjRO?=
 =?us-ascii?Q?8rRnweWQD4O8dQd2M973z8sAt+rGOR2lWANL3k6tqwGcoMrQLlWPmx2jQI7N?=
 =?us-ascii?Q?+vekFnfXOnYQsJ2tBy4TAbxbU0P78Tj3BiyJfVzSX7ukSYwwBMG4vyFhtpgJ?=
 =?us-ascii?Q?HJccNh38pgpfbc7ZLujBPPS7lDPlFwjmkrM48WpPOaszH4peoJMI27ciwN2W?=
 =?us-ascii?Q?1LnLrKA2UJycWA/zlFtUL0CJRKEyoMYYoos2Tin6ISCJlJqUE1XGLqIOoYec?=
 =?us-ascii?Q?5GRzR4ZJ4B6/zxe1+tN5A8FbjcLh8od8AG3bJuIjXwqCYDaCGWHl834PR7Vl?=
 =?us-ascii?Q?kv3aDKUUm8pOgFqHDGPfTd/CFHkfVWINSxB49jzH7xkw8O96QCQwyAY9apvL?=
 =?us-ascii?Q?NabHnkNWi/wX+hwalPynanG+7OQUVR6VR/4QsFMimtcIV5pNMu84lgujm+K3?=
 =?us-ascii?Q?8AomBfoF21TC2aoRP8McijCYwswxZRzxCApTHsyS5Lf1cYdAaAzjShLoSVr9?=
 =?us-ascii?Q?z1e8pcqmC0jjrx3iQv52Fy3KdxwWS+2HJsZbK7HNc2et5H0PSq+lz5VJtMuj?=
 =?us-ascii?Q?knQVUhPePHBS2d9qQe3a7pLgEaf4yF/90hO6FGtsAKEDCcmi2/XyAtGKS6u5?=
 =?us-ascii?Q?CBt2Qa99QxuD5bJ88zbNbG7me3gGlwgm/Gr5KLMwrVzMFg0kjPFMvtt3yyCm?=
 =?us-ascii?Q?yht3WL0/hecS6lI09xTtnCQ6M8DdorLj7k5C0tJyQTygl8gsdXqBGnTDzMmY?=
 =?us-ascii?Q?roR2ugNMjVxXx28sBsrKrlx71be4nmKJwxpx5F9oE85+tJb+h/DR3nxnHXP8?=
 =?us-ascii?Q?FBozxDo7Ud5TY5PWltPmmJ+YPbIr93c5BYKBxVgahMVjoQfs03L9XF2m09ME?=
 =?us-ascii?Q?wVxat+AmuoaMkcz7muHZRSgniNth0jHttixlJxVL1HKm2EMEGC2HUktJE/AG?=
 =?us-ascii?Q?qknj3j9g+hJg97tJArJNNHfIEYfZdG674ckjXS1Sw2Hns0hboX0sEV6IMrbC?=
 =?us-ascii?Q?NEuJRyi5rkbqofTJjEg25Pflhp0oz4ZLXlIzxjof/lbcS9tZ7FOjdssJNAog?=
 =?us-ascii?Q?xLMAi3MWLm8SDdM5RRltYd4sjvwfByRTynLmcN+u8aRT4QMRZ795JbP3zbs5?=
 =?us-ascii?Q?dFnxWdCYcY0JrfEIv27Qq/6jpLXny6sMi2Hm5O75xl35pdxOoqPKTtEORGYt?=
 =?us-ascii?Q?fKTR7haOd8WrkfVhq2PDzaVIThLjFrxSrQczUnZLrprjybrrlrJoJizu1osX?=
 =?us-ascii?Q?wCYBsh0mjG3tlTIKRwoDHEsCqxCBwoDTAGZoqMrQpiTKd0GKNlSiz0CteemJ?=
 =?us-ascii?Q?wskkx4h2BIf/4x0GaCku5lzEa3q1OJF4l6OhBYwgsIQAJg8g96p1tSk37Aps?=
 =?us-ascii?Q?bcJdEtpwVuyW3G9ZbxXkdQV573OAK2GzD1qiuRvDpcq2XFa7zPYUCwI7Ybph?=
 =?us-ascii?Q?oJ0xcXxIW9oBEDAljUQZZILyModLbcHdsTEmmclgnizr1VJYJ9XEfb/QozHz?=
 =?us-ascii?Q?CNe1HOBRHWdH5KuysG1/Ut6xtxZYwqyJxoITXJ2G3gpkepdk7aTn4kCCsBkm?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7122ee-a130-4898-37b4-08daadc7b743
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:37:31.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sQsUy5eNPhXEF/cKh4UABwndyjQ+wUTqkKwwwjM3dvEhmcQqaqrYh1Q/tDuktrCpYEx1Uy8NptzQ4CkgpB07kK/RJ7fBEeBhIvYIw9jZg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140054
X-Proofpoint-ORIG-GUID: CMqut4GZtHlA2Z4RL8AXnrpU6aAt4cAA
X-Proofpoint-GUID: CMqut4GZtHlA2Z4RL8AXnrpU6aAt4cAA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The alloc_string_stream() functions were changed from returning NULL on
error to returning error pointers so these caller needs to be updated
as well.

Fixes: 78b1c6584fce ("kunit: string-stream: Simplify resource use")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/kunit/string-stream.c | 4 ++--
 lib/kunit/test.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index f5ae79c37400..a608746020a9 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -56,8 +56,8 @@ int string_stream_vadd(struct string_stream *stream,
 	frag_container = alloc_string_stream_fragment(stream->test,
 						      len,
 						      stream->gfp);
-	if (!frag_container)
-		return -ENOMEM;
+	if (IS_ERR(frag_container))
+		return PTR_ERR(frag_container);
 
 	len = vsnprintf(frag_container->fragment, len, fmt, args);
 	spin_lock(&stream->lock);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 90640a43cf62..2a6992fe7c3e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -265,7 +265,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 	kunit_set_failure(test);
 
 	stream = alloc_string_stream(test, GFP_KERNEL);
-	if (!stream) {
+	if (IS_ERR(stream)) {
 		WARN(true,
 		     "Could not allocate stream to print failed assertion in %s:%d\n",
 		     loc->file,
-- 
2.35.1

