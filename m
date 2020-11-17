Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014E62B70FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKQVf6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:35:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbgKQVf6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:35:58 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHLP3bs003230;
        Tue, 17 Nov 2020 13:35:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=a3rya7AoGm/KrctQKzOWuNB0OMnCpCcZ4C6xXUUZqfY=;
 b=NPHCvB/Wdl8yVVAOPUlWP77BNoEvLMboIc6XyDQdF58KKwSEmxOuHkkj5+zMQ9JdgGKH
 3AGxYRoBhlVxAGYdEIk7u50kl6WU/LZT6aXyJmwxqzEQbKfxv1VqoRixaI95oh9n67El
 A+bOYLqNVRqZfIRZLeGBeqiVD0mXLWYNCg0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34vhqja10b-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Nov 2020 13:35:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 17 Nov 2020 13:35:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQvE3zvcMewiY8bnJc1kqW+uEIVgBq+Rqf+e7r/kWYz/muFYF03a7X9O/GXybQAk4PRUF/DC9CnAKwb021G0JGDhd6Bril6qY2dw7L/4pMjlZJdLfj7606wcYY+8i8qjtg/+t69o3pzxLyY0ms5rj9mcv707POrkUL1M5T2Oim0SwVaHFWg69h6/OAMqcYNdKeVFxp+lOeQuXqU8tyjiwZMF1m35WV0qRxE95ZVITBlhfTktB1b5b4yfaBkxUvrFpJY7tKwWh3wXdwHwm9v/115FNEH7LXi5vlkuXjrM6HNxHHMIzm+oFdTOatnUA6yHnuRn56MjONyKxd/dpiDHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3rya7AoGm/KrctQKzOWuNB0OMnCpCcZ4C6xXUUZqfY=;
 b=a2oTgKpR4UpTjaDFi2p21LvQU8UrU32WNNfHcNzjKySmF3ZdKTd5ErmcAwqdr4HtmwH+AqtdO8LKVHFm6dVdDptOR39mLf11S2WavHcVsJpf36o+0TPKbQ66tRjC2KSDYnR2k8pi5MHFwIxxKXFl+QR8Ih6oFb6W+fGSDJaxA1Frh4386ZQELD/P7kuChPaXT1lYlDTo1O30MI+k8eRip1H/54hMfyeuniJyFcq/VegfgO5lATxbfLHSCITCRGJxFe+O3++d9VF61VwpaXQmHiBsKTjgk/v82ulUbyoPBm0mgHmW5Urn+modtaBKv3/2NoaWuhf/5LWQ6OUZ+Z8o5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3rya7AoGm/KrctQKzOWuNB0OMnCpCcZ4C6xXUUZqfY=;
 b=ZBuTg9dSco45mBN32TzBmg8eh+gTnjGUw5UipHdjWkePpKo4CkqvcshIQel0H+jVFOwRPgqy8xWf3heRCctFOFAUUfcZIkNjxWqv2na+TOp7jOYHVuxvAVjREPOzSbHR9D+Bj7gXT07Wvp37qX4//Bemp/zntt+xKdqDaGXOYWw=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2661.namprd15.prod.outlook.com (2603:10b6:a03:15b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 21:35:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3564.031; Tue, 17 Nov 2020
 21:35:42 +0000
Date:   Tue, 17 Nov 2020 13:35:37 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <20201117213537.GB156448@carbon.DHCP.thefacebook.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
 <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
 <20201114013801.GA3069806@carbon.dhcp.thefacebook.com>
 <20201117210532.GX29991@casper.infradead.org>
 <3E32BC50-700F-471E-89FD-35414610B84E@nvidia.com>
 <20201117212255.GZ29991@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117212255.GZ29991@casper.infradead.org>
X-Originating-IP: [2620:10d:c090:400::5:dcb1]
X-ClientProxiedBy: MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:dcb1) by MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 17 Nov 2020 21:35:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdcc243a-0ca9-4428-178d-08d88b40bbe6
X-MS-TrafficTypeDiagnostic: BYAPR15MB2661:
X-Microsoft-Antispam-PRVS: <BYAPR15MB266103C42ABF42E5D6B23BA3BEE20@BYAPR15MB2661.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zr+TN+3o9YfQDNV0Yq2FRNDWOQALV3xq7hALbkfvU7gXzfa6J1H8VJDvkUAnQ33YWKJz0TpqXd8Gqx7AiU2RQMZrez6fbCTk64gUWuVGZWURa2xH7raVccgs+vhgEDQJ/QRF4jVRAYdi9Nsp3uICOY+tnzkmfohXSpCjLrCnnYBdedy1KOiuIjqkWV1Jw1KN+/VMubZklSgn0pqNB/ifOdi8B3FqUnlOPxebRjpzI9rBUwGGoDmxJoO5b2JoPaYB9QDBOQWIwuRZbAII6UKxT86nLRKouAgd99dKZndBv8o630zHWbclN8jdfstiC2B1lJERiN7dW032DcP4ruCFhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(346002)(366004)(55016002)(54906003)(316002)(4326008)(9686003)(478600001)(6916009)(7416002)(33656002)(186003)(6666004)(8936002)(83380400001)(52116002)(8676002)(7696005)(2906002)(16526019)(6506007)(53546011)(86362001)(66946007)(5660300002)(1076003)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cvUK2kZnwrrhN6g/mzrFtRoTXW5o1BdZkJoMgUAhdakea840WOPj93QeGWWxfLHAGKvZfMHPYC3fVk5Z9ncGcLYuqHUqcmwOBab0tWQE4YRA6qDw12uM+ol9nqNuqHMOdT0ERXCBGrkHPzEBr5EIOrpMWkx/3AMAPTTvAZKoXwswQb23qPxwsWmbizzkHZRzEEIDt6HDhY/k+RdW+lMgxjfsm3QmJ5CI4c0sujwG1kvbDngQ9w6nR6BxywRA7BLGjHPvurxVIF0VdtCaONBcnfxCKqoYpkucKSIhp5Uss5RfAiiWpS4Gf/Q5WzGJI8LlX5NFemv6xOvajGpDjGT80tA4xMBxnal1yiIWhueiE/S9Zoj5aVBbgJuFBNFeq8N//hForGuzoOROBGbog3eGXLbJaxu+smDJppJ2MGotCSHR68PSmZUPjrUbupz33Z4NHdvY2gH8s0PCGt63gXa0T52wV9AM/efYqKObu1pBdsMJ3YWXhrLhzfywVnI8siEigkbwIXZrseb9ztkMolAXlItjYC+gUKNdBSgPuAn7N2Vz3GX10TCuxgoZIypRKwy8J/Kz4a7mzxi4GxlMwo3doJ0pzIg+BMzZ0LIUW/FSvkt3DIhrVXk6acLV+y1MS9pzC2p/s9qQA4oFRQ3GCufU/Vs0ssFRFndTFZhlrXbHU1k=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcc243a-0ca9-4428-178d-08d88b40bbe6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 21:35:42.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLh6L5wXH7ae+eZ7mMULx1Zui2R8yr4TD6AgTMjWeLC0YXaKPD/EKkq48tAJ2ORp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2661
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_09:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=1
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 17, 2020 at 09:22:55PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 17, 2020 at 04:12:03PM -0500, Zi Yan wrote:
> > On 17 Nov 2020, at 16:05, Matthew Wilcox wrote:
> > 
> > > On Fri, Nov 13, 2020 at 05:38:01PM -0800, Roman Gushchin wrote:
> > >> On Fri, Nov 13, 2020 at 08:08:58PM -0500, Zi Yan wrote:
> > >>> Matthew recently converted split_page_owner to take nr instead of order.[1]
> > >>> But I am not
> > >>> sure why, since it seems to me that two call sites (__split_huge_page in
> > >>> mm/huge_memory.c and split_page in mm/page_alloc.c) can pass the order
> > >>> information.
> > >>
> > >> Yeah, I'm not sure why too. Maybe Matthew has some input here?
> > >> You can also pass new_nr, but IMO orders look so much better here.
> > >
> > > If only I'd written that information in the changelog ... oh wait, I did!
> > >
> > >     mm/page_owner: change split_page_owner to take a count
> > >
> > >     The implementation of split_page_owner() prefers a count rather than the
> > >     old order of the page.  When we support a variable size THP, we won't
> > >     have the order at this point, but we will have the number of pages.
> > >     So change the interface to what the caller and callee would prefer.
> > 
> > There are two callers, split_page in mm/page_alloc.c and __split_huge_page in
> > mm/huge_memory.c. The former has the page order. The latter has the page order
> > information before __split_huge_page_tail is called, so we can do
> > old_order = thp_order(head) instead of nr = thp_nr_page(head) and use old_order.
> > What am I missing there?
> 
> Sure, we could also do that.  But what I wrote was true at the time I
> wrote it.

Sure, I was asking about if you're ok with going back to orders or there are better
ideas. I'm sorry if it wasn't clear and sounded differently.

It just seems to me than a function is taking nr and order (as in Zi's last version),
I'd expect that it's a number of pages of given order, or something like this.
So I'd avoid mixing them. Orders are slightly better if nr is always a power of two,
it's just more obvious from looking at the code.

Thanks!
