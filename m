Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0972520445E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgFVXSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 19:18:44 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:27808
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730985AbgFVXSn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 19:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ94JVSqeW+ttmMmXRY0jB4gajRS8479iYuEY45tgatCjgkM1gXEltGtngJT0d515X29GjsY2jSyrsDC6zSM248lmvJGZVCBPkhpZePCx/QWsbM1bQkF1roxy84pASiG7A9kezqjrY5lLpxclxuksLCybNdxD+WeiPHOGEeqBaM4Prz9rHSbZlCVt3NC2eWsYxzjyZMBuPA4sS5mVwNR1Zs0b3HMZOBQ8KygXAJB0cdfUFbNySfXvwCNeOJwKj2IiYDd1p8fnc2dfEmQbU05/MJyt3SezDUhKhXDWUAc0Y58N+vI4qNwgFKHj223UHDLhvoeV+gLU6iCoTtqw1tOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZMHBwPe9PevUjsdaAW1A+MwncD8CSrccysxt0Rz9ig=;
 b=ndKtVaqnY+38BhS20tEyL7/PMboeksLsgORuHllHnkuvANhfwMe+pvR0nuwvbyRI100YYahLR0baxDBIF+LBs1gkL2w5YP7jdDaQBE/zjPQoEXPazjtL9VwVim+/VJDVcwjcSy56GKF1Hz0LyBbIAcio/Q46oSoqA44yF4NQxULU9kgIBQ0QodB/kTmZykMrpaAyMJSRoaCCmtjVcWSnNmQ4LQaD2SToLEx0dRBZx/rVpDgl02bGZfhSJBB0Q0qRXHx5rtA4ymTYuXPxdRmo/lubjh7PgHx75X9jypdOUVWlhDOWfHq1EEpDZy8M++tf2tIbz+/19F8s861GPJPwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZMHBwPe9PevUjsdaAW1A+MwncD8CSrccysxt0Rz9ig=;
 b=AA8lufUbAdEML2txd18vvCs0m7MKW6IbGvqZcXRV0umydfoltnYfECoJjB/3mo0p/TBUx2HPe8NSDO3mFpUHPeckwXqkkVOVx+Z6yd3h81SX2fYRi5FTDBoxmc42tULzYHT/reCtP53RtPZyKE3KWm/BmTcl1OVdbNN4/LWvtZg=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5856.eurprd05.prod.outlook.com (2603:10a6:803:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 23:18:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 23:18:40 +0000
Date:   Mon, 22 Jun 2020 20:18:35 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 09/16] mm/hmm: add output flag for compound page mapping
Message-ID: <20200622231835.GD2874652@mellanox.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-10-rcampbell@nvidia.com>
 <20200622172520.GB2874652@mellanox.com>
 <15ba19a9-5f71-546b-bdea-31e65fc39693@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ba19a9-5f71-546b-bdea-31e65fc39693@nvidia.com>
X-ClientProxiedBy: CH2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:610:38::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:610:38::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10 via Frontend Transport; Mon, 22 Jun 2020 23:18:40 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnVhz-00CGFf-JN; Mon, 22 Jun 2020 20:18:35 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a4b40ae-2712-4119-38c2-08d81702994e
X-MS-TrafficTypeDiagnostic: VI1PR05MB5856:
X-Microsoft-Antispam-PRVS: <VI1PR05MB58562EB71E0B16CDB3B2F27CCF970@VI1PR05MB5856.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOnRFXWhhyvqbyTrGya+99DOzxb3yQd1yV/ltd4hSpn6/lsfKxykEvMVWv1PV3lMqL37vQBiDwgh6RxMqKnMn5GV/MuIERcWMoTR1XqZ2bsJ+iAF4j14O1fuZvyg/rNEkc86EtYA9Tj/xKj5m3ifcvkl2nJh4h/IXt3fYGQShmnOorU/6izhPa2JoVGNX0GfljZ9q5aKmuUSlmj8TouP3h3pBdKaPVFNL15G7YXJWXAZWdueffK2W3t9yQzV+5aZIlEaLcISaMpac2jH1jpcD5tawQ9mZC9PStdQEaxnKvgQCRrh2spIOmUKD36gZOHQCHduRt9ffhtYvwJoyxkAYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(53546011)(83380400001)(316002)(54906003)(426003)(2616005)(6916009)(478600001)(66476007)(26005)(186003)(9746002)(9786002)(8936002)(66946007)(33656002)(86362001)(7416002)(66556008)(5660300002)(8676002)(4326008)(1076003)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VrAejFoPIIV64/GgvGopOXRsg5LByeeAHwocV+7KqNAlPHvBxv9nQlwPaZAgEKw1215txebLlc7WpXENFHcAXAqPzlgUP15ofHjvU5b1cHaQXcfp8eXjbsEXYO1eaty+8IAF/Ib0DfnuN5FD1SAHV8i8pRG/zNV2poFaId50kv7kfYOQo/CuaV9+sfYV5a9TvRF2G15ZMKFkmzAh20yGHv8lOnWYxwwwVhseqd0YBJr28a9dx2UrhtJ3mab8SqgpddvojB37ZZmjvWxRp2D4/1BJv2ujyITyvK9s2lIV9DCgjUAHM1lvqj+vJpXI/QGkgBO7PZd3nGrr1QjiPFvUS7dtBkLfb52bIQpUOB4f07kY7IO8mEPf5LF8FEGbXSouFc9WwDfkzuIP2g6A+bR6ITGTuvNGkFZC7EUgfrUzgKjhrZiAvebi10+8Bvkk880Eh9VCy+nhpi455b60MY1r+UtxRgmpqdg/mEg8O0eDMBX1Y9IaskeKKJEPE0BoH+vh
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4b40ae-2712-4119-38c2-08d81702994e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 23:18:40.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0isG3R4TsctPuixrbANu6NtBNzu/cKx9p7XwP0Z21fHNnSnjMIA08+yAzhscuHrcKtFhR7a2Zcln1g2rLwjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5856
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 22, 2020 at 11:10:05AM -0700, Ralph Campbell wrote:
> 
> On 6/22/20 10:25 AM, Jason Gunthorpe wrote:
> > On Fri, Jun 19, 2020 at 02:56:42PM -0700, Ralph Campbell wrote:
> > > hmm_range_fault() returns an array of page frame numbers and flags for
> > > how the pages are mapped in the requested process' page tables. The PFN
> > > can be used to get the struct page with hmm_pfn_to_page() and the page size
> > > order can be determined with compound_order(page) but if the page is larger
> > > than order 0 (PAGE_SIZE), there is no indication that the page is mapped
> > > using a larger page size. To be fully general, hmm_range_fault() would need
> > > to return the mapping size to handle cases like a 1GB compound page being
> > > mapped with 2MB PMD entries. However, the most common case is the mapping
> > > size is the same as the underlying compound page size.
> > > Add a new output flag to indicate this so that callers know it is safe to
> > > use a large device page table mapping if one is available.
> > 
> > But what size should the caller use?
> > 
> > You already explained that the caller cannot use compound_ordet() to
> > get the size, so what should it be?
> > 
> > Probably this needs to be two flags, PUD and PMD, and the caller should
> > use the PUD and PMD sizes to figure out how big it is?
> > 
> > Jason
> > 
> 
> I guess I didn't explain it as clearly as I thought. :-)
> 
> The page size *can* be determined with compound_order(page) but without the
> flag, the caller doesn't know how much of that page is being mapped by the
> CPU. The flag says the CPU is mapping the whole compound page (based on compound_order)
> and that the caller can use device mappings up to the size of compound_order(page).

No, I got it, I just don't like the assumption that just because a PMD
or PUD points to a page that the only possible value for
compound_page() is PMD or PUD respectively. Partial mapping should be
possible in both cases, if not today, then maybe down the road with
some of the large page work that has been floating about

It seems much safer to just directly encode the PUD/PMD size in the
flags

Jason
