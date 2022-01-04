Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF96483979
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jan 2022 01:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiADAd5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jan 2022 19:33:57 -0500
Received: from mail-bn8nam08on2054.outbound.protection.outlook.com ([40.107.100.54]:48448
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229527AbiADAd4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jan 2022 19:33:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJI78bNNpn/OG0J7JOoYDQTocfWUdkI5Luav43NjAWo+txI/ElqzSizCeeM6pP2v0edKdhDQ3jEQ9Xm2fjt6auqNi36j8ZUpkhghThCOCAKKjyEmcH/QZVl5rqcoAXPe3HfP/KdGuAdrsTah2e9GygWOzwjcHlEAos8R3mHQcji8Bjuq6osC1e9FvBV5ZiVzclomG8mY1VprLl0FNB/RvBQ9Y3gfH354S1TRLr4/HDjAX+/P359U94mXlXVDT+YwHf+KnUGJr26olsTGdlOuPrF4RSOqzUSV660/I1rwHeQvN//KpIM6Rdi2K41/xXqUll2D8HnAEQldv0HMJzjc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRzq7pas1JcEhIhHmqQ0JMTJkC0nNrBSXS9x5hFS4KY=;
 b=cFtiDkG7fKyU+YilSGomO07Emt7USYkjba5p4xfGNotAQsfzxIFVGotzI2IFRQdv/N2H+fXxjrMzRy049Bx1IcEqTybKCFHwx2+vOf2Uq2V/ZAlE0B4iP1uzZBa5UGlV22nHdRP1USw7u/k0rkcLVGi+UzmOCKxmoVVX9X1uwaCbanrNcsrzXr9J86AFUQvmSGx29X2luDcmh/0DdD7EB+aPCaIDKGplLBtbYxFAC7UrIDl8pZcVcqp+IdHb6CiMKem5BGdoV5HiCuOKfJp9PetxZC5eCgSvPx78Wjb9i4EL4VZeUIX3FQe5mc0/A0UHes1WVX3VNczy6EeyyMdkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRzq7pas1JcEhIhHmqQ0JMTJkC0nNrBSXS9x5hFS4KY=;
 b=Ktq880fMVGBeHiLVnFWnaS/acF+z5dR65M91QomMIPrfBQ00eSg94kXLsyhd6EksgBZ0rAkc/TOsWIwOT8XwPceZtylMZTRuf6xGzrWNMgH2RHz+nY/6tXYSFZg6aUXechP3IGP8M8Yd78QOTzGwN3FiRkFiL4a75Mzn6CLpqa2gQtkrpg2NUdO7IUw/P/Vf0odCDz7H496rlu4ne/2ALRiJni8nCclv75l2e+A+WHKgYdm9gcvKYKIA85H3elCpcwqnEZMQZbRVLok3eeJ2rQlRU2g7jz9tkGyVyqf67xbu/Sz8Al/IX0lzjI4pqupGGEv3GAEzXRg8PNZhKYrv9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 00:33:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 00:33:55 +0000
Date:   Mon, 3 Jan 2022 20:33:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <20220104003352.GD2328285@nvidia.com>
References: <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
 <YcPA8gJ0OBPTdCdB@casper.infradead.org>
 <20211224025309.GF1779224@nvidia.com>
 <YcVSUmfzTrhjZapc@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcVSUmfzTrhjZapc@casper.infradead.org>
X-ClientProxiedBy: MN2PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:208:120::42) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab21c687-1319-4bc7-530c-08d9cf19e339
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB515734AD4CEBBAECE44062CBC24A9@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUyrUe9LncZ6E5Un3GU5S4qb4FKlAeR8LTRYvahnjzv1xpTLCh8FrCKdIOCB0GfmlcbdXaYlQqK9D37mnNLkgbj/HaKW+zRbAnfNrwdQLkMY29YG5GfLefTtyfkl6NxfRgwNS+fDBkGuJBMKmu/9Pf/ppmN2cYBlbv3Zj9jJEsLv6Eav1a2PSCJ6eX+f7pQ0pkFOJAQ5EAzZnM1hw1LzHW06O6K22Z2unIoinhyN0HqjGh4S8DDzMpG1TVl/VI/9BNneEwoL4Jw2WdIe1WU7R8IF5RGtvL3495NUqK1bFNvD4crsrblUbq8c8tI+WZtpUwdKu89EkLe0zslMo+7JsJVGsvCe6CQaAO5WaR1E9f1z35YrRcx4kp0buiJC8Kuiv6vxTGQoMWs3M8Xt3VtuNdpcAjf5pexrLg0uKspwgoPsrMiZRCucCzviiuqcGc7iV7IjZwudjE5JhD780Jx2W9EieFc5gECzMiOpyUPckOfqXIcBLwqF1Y1zH+xdGXIrkjNOzAO/MAHFvhNXfZupmcinID9mkCJlfcIWZGMV6/pwszFB8BKwfAHHTYrY6KEEqX3nboZ+duSyHrvJm8uFiXYJ/PqfyLLJnxDhEjwltvKfouIZ/XsOEM9qbqxVX/fQMvpGPDNYiX8VP6FRBGQ9pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(86362001)(508600001)(186003)(66946007)(66556008)(26005)(4326008)(33656002)(1076003)(2906002)(6486002)(8936002)(6512007)(6916009)(83380400001)(54906003)(5660300002)(8676002)(316002)(66476007)(6506007)(6666004)(7416002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jVyzjEXUKmhVG0H9sdahBSW5VsIj6kaJGdiB+U6H2+0mk98Yz9jsZOoY5tfD?=
 =?us-ascii?Q?6TKvAoiHhZppzPGT2ppj4g6tZ/wsfmikRBHgl7tDR8Jq9kGejHy8E37i39wq?=
 =?us-ascii?Q?YkqOHsyQnTvFLmkfauvOuri9c1Y1pxzX7WOgBTTI2oYYwYth4NuQYIU5L+Xr?=
 =?us-ascii?Q?rENrzPfLIAruWlKWwd7AOXdbugTIsDW7sI2zKJA9p0m4pI4iDyl6Zuuh/aRg?=
 =?us-ascii?Q?IyX6eaW8r47FjYQKuWsN8oItj0m/QSduxnf95Sy/b0hHhb3YP4GPy3UaPFOJ?=
 =?us-ascii?Q?KjHtAOIse8TdRHO4ApxqLskNDABuslsugkZz0HNiVes8N3LDEafo5XWfOmu2?=
 =?us-ascii?Q?XarZAMGfOggaQ9Urym961YsaL9A9h8fg5ZZqT32jRwZ2V1yWi1OSQ9jdyNKf?=
 =?us-ascii?Q?7V11EkD+DSnLjF/QqtnxTPGWJfwVexnHhY07Bmvk9E8UhAX9RKaE7NFpi1vR?=
 =?us-ascii?Q?yAlGRcBjIg2Tt91nHB8IR3yPhnK9IK3fV65WvLaQ+UjabJGr1vsSy7QTUE3g?=
 =?us-ascii?Q?tQBYyX8xpA3Def+xQ94OA6yjFkCJuffZH+5GVqn+GHPMlOpMPpCL/Z0WeV8W?=
 =?us-ascii?Q?tZtUj4MFszFFUkJ1DIxsf2mJFiaukxMjdwaLkSwr3nfcgOnPgKNzOHi8ru6I?=
 =?us-ascii?Q?VGu41NpJHpB4CWh0o7nbhwtp5tWT+RW3OHiRkeu9/odmHFyQGtHzGNu+xJ+a?=
 =?us-ascii?Q?UK79bSs5zT7AC+7Mtw9bLla80HzVvJ1vAd8s6T005+6Fji26AJHcT7BafeyF?=
 =?us-ascii?Q?XXt1Ep/926/PO0V+jwRnek6nGF+NJktq+x19xA2zxJf5xygyXBL4JVbsFPlz?=
 =?us-ascii?Q?Wzrf/gLUtPTudDpP6JjYx7Eml1mABUFc/h6KzlrjPT/DHyyHJJz1wwkXx2uA?=
 =?us-ascii?Q?/OWrrhQmf1iZH5/GVJ1ePAZxKMIl6IcnqkHIkGsvN2mB7cKKmZx4NFSNbzKg?=
 =?us-ascii?Q?SNQTFMR3Qas/VRBKgyESm5fzZEYfBkz/u2xNS2/55F4NxKdlNyAzYcHYlyeE?=
 =?us-ascii?Q?oxzPBUviYPK4FtJ1lI6OuzeiGII7lQg7b6RH6ohfXBhZFylEWOf1xvuaFRGd?=
 =?us-ascii?Q?LBYHa/qQrDLDhec2+YIJj6+U12ExbGWJv0SURLxZoyRKUdWLp9ucTO2sQDqL?=
 =?us-ascii?Q?Fstx4c4HvoW9H3d1S00yh6aTALQWSbh48gBl1HLseVNiv5LNp2ye9zat2oVo?=
 =?us-ascii?Q?jKqptR9VJ32giBnxShjykWiJ0GntUSgxC1BmC/uFYUP5Gi5VgGyPz9YPgy0E?=
 =?us-ascii?Q?EYsCuN4CVIhrb0LR8SAR6s4UvE/dgLbxeeZ0pzsQcBymrPbuavxaCCfsLTN9?=
 =?us-ascii?Q?ozLNC+02LKrd2cDIiAYHyj9bHiseavesfAgcYvZP1sKCrn49A+s7XDlk1p9O?=
 =?us-ascii?Q?OPr4zOJq9EQrx9jBmVU6irG5jpqzDonRUN5uSXoiiMCzbapE1QLyxCpmG7YB?=
 =?us-ascii?Q?BUBEnZ36Iz6LJynYN7jsqJ7uohpnORosWPYmx7DfszAV7M+2vDfJqMjip/o8?=
 =?us-ascii?Q?vAQhM+/5TBOPRizq60BBveT72rOoXfQ13FKW6WTjq13ahIM9gfqJMc9E5XU5?=
 =?us-ascii?Q?gBbCd1T3pXq8E96aIio=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab21c687-1319-4bc7-530c-08d9cf19e339
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 00:33:54.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2VKtoBPylbbAAZBsil6R1UMmm1LBmUTw8cSqco252DWG2KJWt0Tiu+yxKEs0rSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 24, 2021 at 04:53:38AM +0000, Matthew Wilcox wrote:
> On Thu, Dec 23, 2021 at 10:53:09PM -0400, Jason Gunthorpe wrote:
> > On Thu, Dec 23, 2021 at 12:21:06AM +0000, Matthew Wilcox wrote:
> > > On Wed, Dec 22, 2021 at 02:09:41PM +0100, David Hildenbrand wrote:
> > > > Right, from an API perspective we really want people to use FOLL_PIN.
> > > > 
> > > > To optimize this case in particular it would help if we would have the
> > > > FOLL flags on the unpin path. Then we could just decide internally
> > > > "well, short-term R/O FOLL_PIN can be really lightweight, we can treat
> > > > this like a FOLL_GET instead". And we would need that as well if we were
> > > > to keep different counters for R/O vs. R/W pinned.
> > > 
> > > FYI, in my current tree, there's a gup_put_folio() which replaces
> > > put_compound_head:
> > > 
> > > static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
> > > {
> > >         if (flags & FOLL_PIN) {
> > >                 node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
> > >                 if (hpage_pincount_available(&folio->page))
> > >                         hpage_pincount_sub(&folio->page, refs);
> > >                 else
> > >                         refs *= GUP_PIN_COUNTING_BIAS;
> > >         }
> > > 
> > >         folio_put_refs(folio, refs);
> > > }
> > > 
> > > That can become non-static if it's needed.  I'm still working on that
> > > series, because I'd like to get it to a point where we return one
> > > folio pointer instead of N page pointers.  Not quite there yet.
> > 
> > I'm keen to see what that looks like, every driver I'm working on that
> > calls PUP goes through gyrations to recover contiguous pages, so this
> > is most welcomed!
> 
> I'm about to take some time off, so alas, you won't see it any time
> soon.  It'd be good to talk with some of the interested users because
> it's actually a pretty tricky problem.

Sure, it is a good idea

> We can't just return an array of the struct folios because the
> actual memory you want to access might be anywhere in that folio,
> and you don't want to have to redo the lookup just to find out which
> subpages of the folio are meant.

Yep

> So I'm currently thinking about returning a bio_vec:
> 
> struct bio_vec {
>         struct page     *bv_page;
>         unsigned int    bv_len;
>         unsigned int    bv_offset;
> };

The cases I'm looking at basically want an efficient list of physical
addresses + lengths. They don't care about pages or folios, eg often
the next step is to build a SGL and DMA map it which largely ignores
all of that.

As the memory used to hold the output of pin_user_pages() is all
temporary there is a sensitivity to allocate the memory quicky, but
also to have enough of it so that we don't have to do redundant work
in pin_user_pages() - eg traversing to the same PMD table again and
again.

> But now that each component in it is variable length, the caller can't
> know how large an array of bio_vecs to allocate.

And the array entry is now 2x the size and there is no way to scatter
the array to 4k segments?

> 1. The callee can allocate the array and let the caller free it when it's
>    finished

It is not bad, but a bit tricky, alot of the GUP code executes in an
IRQ disabled state, so it has to use a pre-allocating scheme. We also
can't scan everything twice and hope it didn't change, so exact
preallocation doesn't seem likely either.

> 2. The caller passes in a (small, fixed-size, on-stack) array of bio_vecs
>    over (potentially) multiple calls.

It is slow, because we do redundant work traversing the same locks and
page tables again and again..

> 3. The caller can overallocate and ignore that most of the array isn't
>    used.
> 
> Any preferences?  I don't like #3.

#3 is OK for my applications because we immediately turn around and
copy the output to something else and free the memory anyhow...

However, being an array means we can't reliably allocate more than 4k
and with 16 bytes per entry that isn't even able to store a full PTE
table.

What would be nice for these cases is if the caller can supply an
array of 4k pages and GUP will fill them in. In many cases we'd
probably pass in up to 2M worth of pages or something.

There is some batching balance here where we want to minimize the
temporary memory consumed by GUP's output (and the time to allocate
it!) but also minimize the redundant work inside GUP repeatedly
walking the same tables and locks. 

eg ideally GUP would stop at some natural alignment boundary if it
could tell it can't fully fill the buffer. Then the next iteration
would not redo the same locks.

I was once thinking about something like storing an array of PFNs and
using the high bits to encode that the PFN is not 4k. It would allow
efficient packing of the common fragmented cases. To make it work
you'd need to have each 4k page grow the pfn list up from the start
and the pfn sizes down from the end. A size entry is only consumed if
the pfn bits can't encode the size directly so the packing can be a
perfect 8 bytes per PFN for the common 4k and 2M aligned cases.

Jason
