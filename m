Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223FA57C47D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 08:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiGUGbc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 02:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiGUGba (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 02:31:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F96402CC;
        Wed, 20 Jul 2022 23:31:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L0s0Hk000868;
        Thu, 21 Jul 2022 06:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=cbbtlnfByhBViYIRzMPxe2v5onrduJ/0YkAno8/IsEQ=;
 b=BeTvE++G01ylRaYREcYt6csjhHXK1czsuGuO0F4GyiAzFR6fBs9+BDvcVoW31SoXPjMs
 Sg66+VO9KOURGbv5LPf6IqbF+5pYWCchKEPZ++iwcSHyjYhFGrudcKeFgf7Y7/kNJ3Rq
 lpTfw51ouKSObiAGtTfptKH3iCtsA8gIxfNRAQCI5F3grLEhPEQ9jZ9GDaTcA/omXc/u
 lsgXH25ex0jwdwbsWpv9hS3mxMku7qpjirbKFy26Av3BdxTPt6IFk/T/1xU7wddksJid
 Qxk8wR3xWXZJ7zGak6LVqd96subgZYfgiP9FM8SiOU9p/2zgCZxw6DYKXekoiKYCE7gY yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsbgrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 06:31:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26L6AfWg002689;
        Thu, 21 Jul 2022 06:31:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mcmxse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 06:31:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1WYaI5tdaZ8A6OMzIW1tsuko7YoHgoSgm+iuVi9utz3WsKLoFssOixc9jTK7Sq03k2pD8/0SXIS0yDq6nI+9U/nqopuasaHjl5sg3yEu4m4ti8kOpUkxD/erhHpTC3dceHzTK3WoPLvDbfHXfcvu57KxdhGzokeHBM4WVOl31SJLlIxa5TxN0eNlPwnuM34VeRmJbx3CfRRZPJV6yEw8Jon5c0y2R3LAMm+SAzbe+cLUiHWgodhrm2XDcvltWP6w+yYUAMm0TaaNsxKUa4f/1cJKp6T16Xjt2QXUYFHQQZ0dFaHutRYtQHtqZmcW+rBUI3tBV1G/EGwHX8OgSZw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbbtlnfByhBViYIRzMPxe2v5onrduJ/0YkAno8/IsEQ=;
 b=LMv2muxeokdGbFKr+Edxo6XjRD9ROeOHgP2LgKoyCuU1PGIWwto8JaJnpVGILhCmw46lo2UvwtMTVW9VQxpCDfU8lh89dQy2NVTnO49f/k/6l+FUTsdmdbzENN2qvLhT3pXIeQcd9K2SPM5guBqKGXD/HcMEPj6rqkiZ6HR58QlevRR3UsmHZNLrYsSqKVvcUB/eAtrlbCmm32X1nKNwcoM+b2598Xy2ipYSuIHr47DNbbEO+zE08Nf2CUhXGmz6fkLFdP10S4fz3RcShvsw3Pw3Nl0W30d1JkScT8D/wJrS8Men3lcixq0IvrN167ikRMEIpKCAxUkB+mrvWr1clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbbtlnfByhBViYIRzMPxe2v5onrduJ/0YkAno8/IsEQ=;
 b=HS4yuVaF1uNy2GlCHXOp6XqjIl57Y+DJmzix5XMciVKT5PShuwB1Qv+HK2EpMo2oi9JjIOnVWRPzFEeqeAZ/c/6iki3bD0lHaaVv4kkavBNotUJHk7AnzFdFxn8ucqXgGJozNC8WagSnF8Ky+vpFwwwLm6o/HcMyr3xW+3grQRQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3406.namprd10.prod.outlook.com
 (2603:10b6:208:128::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 06:31:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 06:31:11 +0000
Date:   Thu, 21 Jul 2022 09:30:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] selftests/vm: silence uninitialized variable warning
Message-ID: <20220721063058.GJ2338@kadam>
References: <YtZ8mKJmktA2GaHB@kili>
 <CAFqt6zY4+=LASCQRCEg_cjEeSw+gJtYMLJtJ1pWL6XPaPB0FOQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zY4+=LASCQRCEg_cjEeSw+gJtYMLJtJ1pWL6XPaPB0FOQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0048.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::36) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b5bf11-4dbe-4148-dee4-08da6ae29a1c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3406:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKfiLwgsSfoTAm/J6mdQ/nVxXx3M/N43mF3P9F/8ZWZy94X+Jm0YE26FO1c3YznwiniGcGUhQkEH8Pgc7EiZT0byuM5ewE6tBROQMT8FhoiO+hDrnASTr5P1jpuTUNpAAzp1JPC3Vnx/j1PJUn1UTuDQTmUbrv2pCOtLoLXfZDT4T8nG1qHHoOM/Tq8Y1i8AnT/UHoDrn6oY1zmEgDgKm4m/7jAg6b6/Ib49IyRl6B2q/f4in70tlDkwGwUoC1D6Ikt1a3ydCg4xJbPAen2NWAMe+kfVbsRLJfS5KMTB/dz2UFUzg9EdA1kCZGQ/+mCUJdZDQWmYQCzYQRDem+oCCtdGknMwqCNWUY+7urXcNSayzLuWPbXTXHhye/7zknzqlHtHuqnWcu2pGfANFAHy/C3uxSlXsCZNNGJ6kcXmR/9PtG3orH7t6gKgeY5OaZ9gi5BPQtU8WpMLfOYM4BDkUjxZdLvDsMNKsxyiQBBKgnDPmM8VxxcMKdm4OBHMv539o0vs5tmtMQvUad0kgx+MF4KNIqyvlA0vc9tqwyr1IFSGjB2+iMoTaiZi8eps+d1UzAYmGChvTUuFGMhr0AUVHhmQfSuzJmckPcpvI57nLxEs3Qenp6XyynqjDg/1zWT9pmecdEgH9Ni+dtJLloX0oZNd4WcoegW2Y0cW4Y13Q+qQ/2Q/sEaQpQCxS8H5stsRaNu4H0tVJY4HrP4ZPc3J3zcTtcjBZmdKKpfASTbFS/Q7AaVeTpkAG7gF7dKRsm1lpkd2edwcDLsQ8MGcEEdgo61Q08fsoGQAfL9Fg+/gJjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(346002)(366004)(39860400002)(396003)(8936002)(33656002)(86362001)(66476007)(4326008)(8676002)(66556008)(38350700002)(52116002)(38100700002)(66946007)(54906003)(53546011)(6916009)(9686003)(6486002)(44832011)(26005)(6506007)(41300700001)(186003)(316002)(6666004)(33716001)(1076003)(478600001)(6512007)(2906002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8vG2ojL/FDk0sS2/kbdOEucIyY52iTp60gppDnMCF6uxvM/3u/HvFBHK1LPd?=
 =?us-ascii?Q?ogoJUlIZUpmJO36N/VsyYTBwkWLPdhljNV6NUxVKbewApRRPlFF4Qz4Cq4mV?=
 =?us-ascii?Q?d63fS5C2cYKFiGgw//ouCoVvkdOpt1AcotmrJcXErN5ZUEf93AP4Z1AA21lQ?=
 =?us-ascii?Q?1cogQHkjv7Hiw+PfDHdYcCgpFo9FUbyvOx48nggn2PVWojcZlPLd7TU6ei0d?=
 =?us-ascii?Q?UX5yAsQFajSh5lBrb0DXGglOL+VL7m8MxG5SZxXAD0o0AIFE3z3H9+kIs7MV?=
 =?us-ascii?Q?alhfax8F9iUacuoj0sW+5hkk+uieIAuX8e5lXx+fZZMc1cpSuQ0YHbgFhH7z?=
 =?us-ascii?Q?5lq6jShYNvLNi60c8BELeqNHTppHJIMNWY4CUX6TXy1OoJX+FGVRaJG0pxbZ?=
 =?us-ascii?Q?74euk4GYQz+b32xp7QmFf41AAkpIzIjGP/Pee+AXfxw4cKXLbXDb7Gmdtgar?=
 =?us-ascii?Q?ldfNm5vZEKnVtgBDqHmd+rrHSqr9R104T5gz1YZsr0Xrsm8Bicz90lm7gFzi?=
 =?us-ascii?Q?v9aO8Ht/he6HlesKUaai4mQhaBw/kapOYqwL6u2ZTlljqpaZjQdYpMlAxaWV?=
 =?us-ascii?Q?fG6mIckw+lPmNaJ8J0Z7X8GB0iW/HzdMf6VNZ2bC4gPUpozh7gnmPGRDlbuF?=
 =?us-ascii?Q?fCDP8h7ZOiF6yt6L3jYZsBSfS8v25QLUVVEtLo5updGAxissq8QeAvngpqUx?=
 =?us-ascii?Q?LM1y/NXD0J/IW7rKUuie2M81fFCdWVztaISUi8k0NflXYRT+TAjA0g5LJixc?=
 =?us-ascii?Q?aLWPwCH3+McMXAQJx5XHRnaHl9dHjkDiQvf2cWW8YaOPJ3JRt51tIshjVLQZ?=
 =?us-ascii?Q?rrOr4F/pauxlBTL2j2ddUuZVSxgt9dTZGgfUFwV+Pbx/mva/wiZ9FZv2y+h1?=
 =?us-ascii?Q?XJiPeR4vjo+IADhy1cjnEEfiIguVkm3yyHlHu5jC2ZrU9fRQ2SUVaxfgLiUd?=
 =?us-ascii?Q?xAsKTPrnod7BBodcrpffDS7Fova9vh+hFE0J/el7MbYZxVAmC0ScdEgEfBv9?=
 =?us-ascii?Q?rM2543NdXy34Ghca0J3AqQ1VsyrhxjxPpVjpTg0JOexSUwQnmymLnySq7NK7?=
 =?us-ascii?Q?6CU7sdgCHOopvzGxUEEj0PoY+y6tfDjj/WBmCntORsXZozK6BSxBXJsnrcgE?=
 =?us-ascii?Q?21W8rgiXgZN1rmk2pevERO2bV1QCdGiTOpUmu0k8xiTI8QkDsTUOhgD0zz6O?=
 =?us-ascii?Q?bQ2Pp9M+nePxu5ucixtUMFuSGJizmdpKlH0AN/Ef+okMHYbeaU7folekvscP?=
 =?us-ascii?Q?lGUzNhYvzxweRQKxpj4AKclLAXzoRxZu3Zrvw3gjIuT326sr7ZC4M+HBfFAS?=
 =?us-ascii?Q?xdZ1P3B3yVnTQusZQNKR2fOO5TcVl1qukG946TNSZnWoKhctZrCJ2J2qe2e/?=
 =?us-ascii?Q?TnO9Lc8qOp7YQgAwreBZ6oE0/Rzg9+vDRKQBX22IqX5hQzxCCaFbPD2vyaFt?=
 =?us-ascii?Q?1OVRxXEN0VoQfWkwGet+11t42iCsGwVQ7pgOXhBBqvpxPI3AJOev+44ZPZWw?=
 =?us-ascii?Q?D1hmb47jvS1RVEdCYRDC+2euR5nln0iaYbIIAOTAMSQSkgw+MfrzhYAEBgiT?=
 =?us-ascii?Q?wzEOdJKfICFmIDer4oWl92TJEaKSCSIPOKlxqXka?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b5bf11-4dbe-4148-dee4-08da6ae29a1c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:31:11.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CX1qw5lxyrAFznzzQppnpMeZHige/BM/6ojzhDg07W23odnbh8F++O/eDQEgZdHvkpt7nmQmcLC1Ch6Szvq3Ko0eP5QKT8IRX5Ne8zmcNiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210024
X-Proofpoint-GUID: RPxv7oPnYX9J2VxUVjokijj2BW9zVhIP
X-Proofpoint-ORIG-GUID: RPxv7oPnYX9J2VxUVjokijj2BW9zVhIP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 21, 2022 at 06:38:59AM +0530, Souptick Joarder wrote:
> On Tue, Jul 19, 2022 at 3:13 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > This code just reads from memory without caring about the data itself.
> 
> The caller has put an attempt to at least validate the address read
> from mmap() before
> passing it to read_fault_pages() which looks correct. I think this
> line is not needed.

What I mean is, the value of "tmp" was always nonsense but it doesn't
matter because we don't care.  In other words, we're just reading but we
don't care about the actual data.

regards,
dan carpenter

> 
> > However static checkers complain that "tmp" is never properly
> > initialized.  Initialize it to zero and change the name to "dummy" to
> > show that we don't care about the value stored in it.
> >
> > Fixes: c4b6cb884011 ("selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> 
> > ---
> >  tools/testing/selftests/vm/hugetlb-madvise.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
> > index 6c6af40f5747..3c9943131881 100644
> > --- a/tools/testing/selftests/vm/hugetlb-madvise.c
> > +++ b/tools/testing/selftests/vm/hugetlb-madvise.c
> > @@ -89,10 +89,11 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
> >
> >  void read_fault_pages(void *addr, unsigned long nr_pages)
> >  {
> > -       unsigned long i, tmp;
> > +       unsigned long dummy = 0;
> > +       unsigned long i;
> >
> >         for (i = 0; i < nr_pages; i++)
> > -               tmp += *((unsigned long *)(addr + (i * huge_page_size)));
> > +               dummy += *((unsigned long *)(addr + (i * huge_page_size)));
> >  }
> >
> >  int main(int argc, char **argv)
> > --
> > 2.35.1
> >
> >
