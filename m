Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E6315966
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 23:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhBIWYg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 17:24:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36368 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbhBIWNp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 17:13:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119MA92L004960;
        Tue, 9 Feb 2021 22:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=hDPnwXDLBtWJGf2OZ1vqJ/KBxY2GuGD0AOVqOwylbGc=;
 b=DO2Xvgzrk+mT1u1CGebZaQyS3EMhckSrWBsT5nDgf7Xe9U6sfJP4ALFItMh2RNJq8pwC
 J4bKtUUHD2B2ZPrfoQpHRF5a6J3a11rgHN7cog4MgDh2F1AbSTGoQvxaTrJxNS7fPvSs
 i+TH3K6lPnIm69+gIojLpE4zFQ+ohYf64rsDbxYw8DOdgZcD57joPmByI0WMMq5IDS5N
 lWHLY4C3tY+tZIbgLwiGJvKUcaIS+bjQH5oZhr3YAr+7Kgx7ZJhsB05wkU95j/2dRgOo
 8DucdfUHEXH94zKxTw04Eo4OuXnsY+L+vZFei5xNH82oo7OLxH/X9/ERB11d6NYRhE+f cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrn15pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 22:12:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119MBQ03059552;
        Tue, 9 Feb 2021 22:12:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 36j511usjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 22:12:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmV1PCJGVbXayak8IUEjcjex4A52ISAuhYA7hObTp0tG1KYkR/uZVvqBzTpKN7DeHO1JQaeHBbfnKRJjBXlqZsAbxvG9soI0OZ9jN5Cg+6UPQyzxfQLIE5avGH59RFauaRIH3ZuVqm/uIJ1ZF3zyjg7ZZEGUL7RpLPKLgkVRTVoObxGxJm5uaGt2smgbzbkb4KXyK4Eesnd78VBKsJk+aFASBriguDVGAP7HZDRREzRjggT+Saqjc3xoVTs1Tf1vpolAdYWni3lhBXCxzeNDu38f2EtzgbuPzQ9OE7C7jm+bqtSwGU6Pa+vauaSX2EiS1sAg/QRS+ez74Pu1qp2MDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDPnwXDLBtWJGf2OZ1vqJ/KBxY2GuGD0AOVqOwylbGc=;
 b=AX8VVQCq/9jjdAf/hBD8T66QLrk+ZoovmQDJt506ULgFScULFuRNQ5lr86xy0pEqy1W5mB9ixaahbDOoZ+lV6a5pcKIewLlSUJv9hCMoyxeNf8Tbbmiha0MTfulsPrxId/9qCJNqF2x2q9wBSqf6azmp4vFrTPM1fDNGCEbs1Sly7pfC9OBocN29mF63xTTjD++n5DpfbKxx4qy2tmKpAnEcJYQ/ZkhG6xNeo4H3pUJ0VV+clRtCyqCfkacLiJNqbZZplFZxd33QpgFcxSbbV1toA9WeWT0viZ5KskvfnzaKdm404+d3dKfludhBBIw7zN9eyzv8YpU8bjZPoZsk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDPnwXDLBtWJGf2OZ1vqJ/KBxY2GuGD0AOVqOwylbGc=;
 b=yHneQ30Jp6uzBoonaWqyW4P+pOgJq10EBNpPBwYLaD0eJFT9yGP4C8cmr+N4onqZcLOL3fFYLX5pxaUdwW1pC1cegRCiGHGVfhukjcG5l+tMne7QJtePpypZH1PSU62FzywLJZaDk9k5sapDf2SXsfTsAtJB/+2VgPgsGsiy8Xo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19)
 by MWHPR1001MB2112.namprd10.prod.outlook.com (2603:10b6:301:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Tue, 9 Feb
 2021 22:12:51 +0000
Received: from CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::c922:e8a7:1a09:e714]) by CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::c922:e8a7:1a09:e714%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 22:12:51 +0000
Date:   Tue, 9 Feb 2021 22:12:34 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Daniel Latypov <dlatypov@google.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Uriel Guajardo <urielguajardo@google.com>
Subject: Re: [PATCH v2 1/2] kunit: support failure from dynamic analysis
 tools
In-Reply-To: <CAGS_qxoRt+yibVgVBoMGp+GpVt9TSKuyyk08vfcSyQeTyAgN+A@mail.gmail.com>
Message-ID: <alpine.LRH.2.23.451.2102092210150.20236@localhost>
References: <20210205235302.2022784-1-dlatypov@google.com> <20210205235302.2022784-2-dlatypov@google.com> <alpine.LRH.2.23.451.2102091717001.1783@localhost> <CAGS_qxoRt+yibVgVBoMGp+GpVt9TSKuyyk08vfcSyQeTyAgN+A@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
X-Originating-IP: [2a02:6900:8208:1848::16ae]
X-ClientProxiedBy: LO4P123CA0211.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::18) To CO1PR10MB4516.namprd10.prod.outlook.com
 (2603:10b6:303:6e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:6900:8208:1848::16ae) by LO4P123CA0211.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Tue, 9 Feb 2021 22:12:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70a6171b-1b76-4fe0-c55d-08d8cd47d738
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2112:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2112F44AB9C62F6F8C22B31FEF8E9@MWHPR1001MB2112.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EyFrR+N3Y+F5bCc+5DGG2WA4hc3KaJqbQmWnBsDl7EtefW4V00VdetDO8JCC1JxVYoY9+S8jIqJOhd0bL2ROwTGkgp5b4Jni84VunTttDTXs1OCdAB7Pi/6zTYGTJSC6eipGguTX1QHhym+Pq3NcxjE1qrD0RynRj7GHs+MC4jljUmp5kuBsKhK0fws/DnElX1NctQqwjnGWtDWoUOd+sAitu9/iL1z+yQRm5SgdOT6cFXd1I3xvN4Nw4FNp2s363QWadqpev6+7sYVpFQMW5HPsJDVIn9G36aYAv2+g4XwcXYYMha5QS3ziUQvPq+FhDcBRN53JKNlNFgJgns+Fatt6dIBxMyu/0EUJM1u7WYVsTmCvwQxR7GIXOcdFokc/ch1+D04ZhTz/0OMD5BBN5eLVDASrXqfbGS078XxCE/yR2chwzT63UKdZ7DFqz97ngLBc3VbLyjYdVgW95wRYINdYuqXUGoFCT2TDAenf5toj+TVuR1TQv/U5QOQTMhRf2EaIHMEsriOzY9QTBV5WKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4516.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(66476007)(8676002)(9576002)(5660300002)(9686003)(6512007)(8936002)(52116002)(6486002)(66946007)(478600001)(54906003)(83380400001)(316002)(44832011)(16526019)(6506007)(186003)(6916009)(33716001)(53546011)(4326008)(66556008)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/yWoM6yrHVd9JO32qJE43kcamfnka1wCguxhRfLDORC0HNJy05ql2zPuRXqA?=
 =?us-ascii?Q?3PcnbP18Q7TE6X07oQptjiHVhG4UYWYdFi3xRX3dOSUJ/5ae74TTaXbBbQdR?=
 =?us-ascii?Q?XaWfbhN/58MidDTh87RnyCSa8HFMVW/X3L7j6lrwKOPG2nGuIttDpuipv54l?=
 =?us-ascii?Q?m2AyV/RAf+Qe6Ajin60B7QCbUL9yVMZqK0JPDI/hnsV5L4pPw7jKlmHH6zvx?=
 =?us-ascii?Q?dOtqTdAQ/72Ot9tNFfU6M8Wuo/XiDcB8Ui+doWAp56DisyRSAisL6nFRAJeH?=
 =?us-ascii?Q?rhv0YLx2VZNz+DNkDSVBH4ttHja/HpR97dDqIGvohM8zZLPHeAwnW8EGFbmR?=
 =?us-ascii?Q?Gye1o7NdnJIuxV/YqFKLins2uqjgJUNbY2I7KnedOBmo5gCQP7y9hLZgKLGP?=
 =?us-ascii?Q?Brx3wwSJ6fk6SjAxrWxe98B7JFHSnYvnO8wKNXb+voKQX8Omkw8ClmQ6GJdF?=
 =?us-ascii?Q?F2SRsRbpB7r7QTxFDpd9RJqF6XbxBB2qSvF3HD8x4dD/WVEbyOjIj3B4mHxM?=
 =?us-ascii?Q?LLjrYf3q1XgJlUlAIQBKq7/Ai8zKSA+Oo14Mqr0J2pTXu+BLhttCvwB+vsU9?=
 =?us-ascii?Q?FTKgxPMS0m/NjhAy8KyDSxvm8635yhKTVgd/4/2xOtRQ49mqVVjj1bbPSy0B?=
 =?us-ascii?Q?NyCufe2FlaUVjovNLHRtaxTt9xV0ZsHfWMegqlRLD8ZDt6Hj5uZ4yZZmo5ep?=
 =?us-ascii?Q?XABjbHQz0aVrMj3+WkR2i+gI35c8zGbLAF6MloedkZYhv9w6mtLA7CpxI4lf?=
 =?us-ascii?Q?R2Ave9FCQF12CLcjuSOBxN7QZpPG014aVwnySceKWDVIkJdFPlLpkoG+loV8?=
 =?us-ascii?Q?UeJdJ6EQJ4Bf0kk3Q3OuSMfD/3oeh7NHT2u7P+la1UlukjwE3zomJ4QPWziL?=
 =?us-ascii?Q?tv9pWA5VB68rs/muEcF0RExmvPiNp5jz9XAhzufEWjcssUBIl1Qvi2kMRitM?=
 =?us-ascii?Q?OC+HIMjUjAFwWmi9wJYelApmdUIfMnajMcC4um+4SVTWSG7dz9goYlfo9BWE?=
 =?us-ascii?Q?2PLAeuAvNkuEaHZlmP96/m1I97Pzr39v/idvwcDnT4r1uckQhILcW5jXsYs7?=
 =?us-ascii?Q?D538bh5vhBGPpbc8K0v/UGpeRukb6VuU8Me5t7wPfkfx2JKqY2IbA/Gvxz6f?=
 =?us-ascii?Q?3ZkkyWCwRdtAal08qRQkDUs2o/8kqbbR5gAfqY2V3G8SPpVDWz0ths95ja0A?=
 =?us-ascii?Q?yj/YjjL3R0ZUhhaYvapSVIE/YSlxubWazKgprIGTkuvgn9Q8SzIswlVJ6ok3?=
 =?us-ascii?Q?CiyfI6lQRj/lBuXvW0y98L3EvOpesXCw7oX/2P1XyNhkXh4Ip3rMEAH8Oh9r?=
 =?us-ascii?Q?+wD5qxdnugKf8CbXwEmO1uU1H9XnCigJobeZjIy8uL5gwwG5BLbDkCzRVzPe?=
 =?us-ascii?Q?pCWo2z8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a6171b-1b76-4fe0-c55d-08d8cd47d738
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4516.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 22:12:51.2200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE0dfBNFB/95eF1/L3MzSpi7a3Zx1xrcFQ4lx6rnh2XYqFbfSBj5hSn3bW/Co3aEw1eOdAZutEqKVkN4EG+KoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2112
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090112
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090112
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 9 Feb 2021, Daniel Latypov wrote:

> On Tue, Feb 9, 2021 at 9:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On Fri, 5 Feb 2021, Daniel Latypov wrote:
> >
> > > From: Uriel Guajardo <urielguajardo@google.com>
> > >
> > > Add a kunit_fail_current_test() function to fail the currently running
> > > test, if any, with an error message.
> > >
> > > This is largely intended for dynamic analysis tools like UBSAN and for
> > > fakes.
> > > E.g. say I had a fake ops struct for testing and I wanted my `free`
> > > function to complain if it was called with an invalid argument, or
> > > caught a double-free. Most return void and have no normal means of
> > > signalling failure (e.g. super_operations, iommu_ops, etc.).
> > >
> > > Key points:
> > > * Always update current->kunit_test so anyone can use it.
> > >   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
> > >   CONFIG_KASAN=y
> > >
> > > * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> > > to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> > >
> > > * Forward the file and line number to make it easier to track down
> > > failures
> > >
> >
> > Thanks for doing this!
> >
> > > * Declare it as a function for nice __printf() warnings about mismatched
> > > format strings even when KUnit is not enabled.
> > >
> >
> > One thing I _think_ this assumes is that KUnit is builtin;
> > don't we need an
> 
> Ah, you're correct.
> Also going to rename it to have two _ to match other functions used in
> macros like __kunit_test_suites_init.
> 

Great! If you're sending out an updated version with these
changes, feel free to add

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
