Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC147EAA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 03:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351015AbhLXCxO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Dec 2021 21:53:14 -0500
Received: from mail-bn1nam07on2074.outbound.protection.outlook.com ([40.107.212.74]:57886
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351000AbhLXCxN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Dec 2021 21:53:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak3VBsdF0MKZFCUcbnqPONAPBbgxgYWaSA497DogHi/rGW6iLbJNMtIcdRIVFLmJljuuIpKGL5EyKuPG5M/oTdSRC/zNgBRjyUq5aed0HDqdHUScBa+zBa0bfp+wMLUnlRmk++kg7YWBEugPj7oF0w4Jp0TyMK3xj22WKwkTzjnUuktiHlx6mFL8VoE7VoiRYRtEDuDVtxClH8xDrOcHtD0jTZkgdc6RFNqKay14MBeAxr0YUrJy562W2P4+o2te5KtB6fd6rJgV9uNuDD2CtJQ6oYHoByA5+SS1uyLWfSbDqbuiekIOXloodBgursb12RMfvpCuFRK+W64cDn8UrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdwDZg1OhQE6G7jYa+z0WpxpblpG57nS9h5ObE3/uKU=;
 b=VVbxG0TyuX5pPmPqvlPoPz97SjYVMhNctwxzEgW6VN0r9k+4kDRTLxBgWp9vyHTzHmaKGnNzQXmWGzNY3vdOQ1qSg8g7fV9NmtGx816X9QixubUrEkfqHFNua45vzvyVDYaZbDABOMcm4XkKE48y/DXGBFzp+IiHRE3R8dGkPmGIlxdmSpGptFHKqMOZAbb0JNBTKbX67AL3I2KZC2feZ3iKFs+qdPWPJKlJI3zVca3U8hsC/t5AQTVNsG88RiMtW/GVxhG3+PWwGzvtwtimxrxq/ffB/iSwzC5xL9nCnzaUECkYKoKoN4ZBaAPXV/WpAZgn16HZF9rCK8qbw6ZxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdwDZg1OhQE6G7jYa+z0WpxpblpG57nS9h5ObE3/uKU=;
 b=ujWmdVKR49jCXpl9C6gsBXI0ob0dsj1S9wrtyF0T8xPUQbEjsUir5JLWrR4q5t+XiLl6YfHVjrIcT8dFrkLckX70RLexPLleAq4Nf1kCrRd0kR9hu8DgJn9ujlZBdKQv3unX273c6TIpb8SqO2jxDbUq/h3ooveaPP/sNA+l20PntNSZ0KU5scSbDuTm+b8NZzSPy3WAdF7CcMWofGHs9JBuXfRSwA133Jdl+cPuR/rrH2ZCK/6tYHojp7N6+nmTHRtD7WyeeHHyqKojx37vRp0H+Mgp9G0z6jwOFfkvKX+m9BxholTwYjucmtMf4qvITAIhfAeZ3/DeEaxi2sFXZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 02:53:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 02:53:11 +0000
Date:   Thu, 23 Dec 2021 22:53:09 -0400
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
Message-ID: <20211224025309.GF1779224@nvidia.com>
References: <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com>
 <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com>
 <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com>
 <YcPA8gJ0OBPTdCdB@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcPA8gJ0OBPTdCdB@casper.infradead.org>
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30cc9cc4-0480-48e4-e109-08d9c68885bf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5336E6FDBEDB0E251EC9F9BDC27F9@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmFHhragQu+5ONrVnySpdVWhWz5Dbu/RD8meC8ke1YR7iRB12OjcPuX5CYK+QIi+KXaPQe9VJf+TC1++JDP+H0Er0esQLABHUjKQAZBUq/zolc3ovmZ/P9znE5IFYdYrQlBeCAJ3m5yC3IY/ESlB1cF+zojTM8NrWfOB3nat/m1ylQHADxn5ZSbjLu12f1HLflZBmQFx8EDjPxpvt12HJh3rHQUCcViaOSBnBv9gl7O3FRiE8+piN3pHgz8RnJ1NhSaJMXj2J6AUOYVE+/EI0Lg4ZaTQQEq0KHH3udEJqpDOBP37wMaDBertzhBqLf/+ZuhAwQ4VAk43rS5H1XIrnmzB+FcB9uN7ih7igM/XIC2K/y3Ncuhxt2zF6ejrejbbPpSmZypNO+sZxs7oMwvPBSLGax53X+zwvB5xSVyx3741hBo/fS8f28cfTI6IQYCCUeJxVgQMjKTbK9zsK5TTVIuDikN0JkvDScn8lL2SjwoK0EMyftDd6ywz5jNePqtpEgZweZLb0obNVKw62+QeltGrIN2s8bq2h1AqWA++a6T/Yn9b1ThsBqEHj5/e1Z0kyKHmzztcIm48gbZl32D7Q+3jaTmL4DZkNFT/rFmMoKoKKXqf6/RapPd3cSnud4A7GPXy4tgGAexXi+bYaIPR+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(8676002)(186003)(2616005)(26005)(508600001)(5660300002)(6512007)(6486002)(33656002)(8936002)(66476007)(38100700002)(7416002)(6916009)(66946007)(2906002)(6506007)(54906003)(316002)(4326008)(66556008)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iiryEynWNRGh53dUX7gmKuFGPdi0UAJu5f0/zaLVoB81GUsgnPpb+7+f4Br6?=
 =?us-ascii?Q?VyJBYg/KzdGSt5iQALpVFMU1eLah8tprXheGvXyruFDviONNjx+XvGk0svJ5?=
 =?us-ascii?Q?6GvI5G/wa8gEJqLDfWlQ9yAfr4xy6NRhQMkl0w42DND+ehNvY10X4gKrjfj9?=
 =?us-ascii?Q?yxsR/7gwVtG/6RtxxW7clmKBE7xpd5oofpQfyNkpcHknc2PoIaPn4vmY65xC?=
 =?us-ascii?Q?9Ka/aMRpyy7bYlBkBS3Ld513N0kl1KkCbWw/32FIVHbKaEk9eAMu9YAb9SSN?=
 =?us-ascii?Q?hjdT1juq4OLJDNs+qT9NSxTX0RNjIPr50w83NtLQtdQE+qKEAskUGqCDfkHY?=
 =?us-ascii?Q?eYQ3nt3NLpBpf8NoKRl3jVfHFg3jGAnSw69gv+Qmrh94hwGpFocenvqLp/7N?=
 =?us-ascii?Q?c7YxRycjIudZTZPh4+hAR9VEqRstXreIjJV8QVA80/R+/6GxGIplnwnVcJqT?=
 =?us-ascii?Q?kALymyrg5nKek+PcIkj93jXOsxyMZx2EPXu6vDu1jr88lOlDZ9izLtg7wPyN?=
 =?us-ascii?Q?nYVzgidxJGjr1rkb+CzENSD58g6xqhepcWzV0NV+8H7s2kfddhvFy8c6ob0O?=
 =?us-ascii?Q?xUmX3IWRLL7KnPv+HEZg1qycNsHD24/VBQN67tWHTdFJwou+qqarKxCau4oI?=
 =?us-ascii?Q?VIZ5u2YFdUv/6PEg/8vHdLwyy5mSe7PHhmO37w3DsnZRSHsaoinYkBYonwpx?=
 =?us-ascii?Q?bfQMPQnKi1Q12dQ3b0kKwO+WyW3adrQwqJ69JTjNUX45zKeLI/HpE7P/8//0?=
 =?us-ascii?Q?4zyZLSBe6mW7BY0Xzg8/rGDaGyQApXV35D0hfTBylxulE5ijIOg90ovbNhQP?=
 =?us-ascii?Q?DNzRWigbUduAv5wL09s8/xmuovhETkMdyq1o+WCAcrKFxCcWeriD75Y2bPeH?=
 =?us-ascii?Q?Oe7Oxvet1gDigq+c0yfrJdzKmY/Iuzvzfdif0OcC2WN02yZD+4Snt643cuff?=
 =?us-ascii?Q?q8SOMF2H+tcdiOcSexLcU+4oGXHWd2gPp4JEEY0/Cpc5TS1Oca5h2/92Kmq7?=
 =?us-ascii?Q?55cyhkHRYJA+HeiN8yodY5lY8zBRiEis1Rkq4FucHl9HcVhqmZNLA77I+c91?=
 =?us-ascii?Q?ifyoMlRengjrGv+m7jMcjK9H0ZTpxyKjxS6WhO8Jv8XEUJAwOa3NhgIxXcM8?=
 =?us-ascii?Q?Uxj5SQyUymcoo7gK7r/+Ssj7vfG3QvoEwtwEzkAXUSXhPlLHDH+efzUiYSf5?=
 =?us-ascii?Q?4Yufc3Bu0AA7UOaO/D2Y0tN6OdwpzeV4Pgaxfvx5OYZm2Azl7/7SMwPGj/Yr?=
 =?us-ascii?Q?6ttG1A+skW0CrpkeAqj9vJ9urAl3RQaqpglJnzX9OKP01A9vutP9kvqxczmB?=
 =?us-ascii?Q?kH727aGlhYr9yVXTBEr5pAJ7JKE5m/8m1HaCNpZd/aWc50KI1W8uAwO5icpk?=
 =?us-ascii?Q?o9GNtpM1ZmSQjeONTzevc3pCQBaQdromK3j0NIzOa7kZD80fd5vG6j/4eq6w?=
 =?us-ascii?Q?fvslGu75wYf1rADsG1sR0+qwznrNKigP0DZOoCt49SMMouggSGEykShpEOvE?=
 =?us-ascii?Q?MOhyXB2h7gFjdeZhM+Tqz0KgUHua2uNWDCcEKEHLQ4r46j8MYoVY6jT8Hn/5?=
 =?us-ascii?Q?yZGznm8e89w8EK7WvFo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cc9cc4-0480-48e4-e109-08d9c68885bf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 02:53:11.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7gG7kcACLTISje4DDTaIgl5qagVsL8VHLN7Ws+bf/dsWqfeCmb9FiavwlgBah0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 23, 2021 at 12:21:06AM +0000, Matthew Wilcox wrote:
> On Wed, Dec 22, 2021 at 02:09:41PM +0100, David Hildenbrand wrote:
> > Right, from an API perspective we really want people to use FOLL_PIN.
> > 
> > To optimize this case in particular it would help if we would have the
> > FOLL flags on the unpin path. Then we could just decide internally
> > "well, short-term R/O FOLL_PIN can be really lightweight, we can treat
> > this like a FOLL_GET instead". And we would need that as well if we were
> > to keep different counters for R/O vs. R/W pinned.
> 
> FYI, in my current tree, there's a gup_put_folio() which replaces
> put_compound_head:
> 
> static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
> {
>         if (flags & FOLL_PIN) {
>                 node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
>                 if (hpage_pincount_available(&folio->page))
>                         hpage_pincount_sub(&folio->page, refs);
>                 else
>                         refs *= GUP_PIN_COUNTING_BIAS;
>         }
> 
>         folio_put_refs(folio, refs);
> }
> 
> That can become non-static if it's needed.  I'm still working on that
> series, because I'd like to get it to a point where we return one
> folio pointer instead of N page pointers.  Not quite there yet.

I'm keen to see what that looks like, every driver I'm working on that
calls PUP goes through gyrations to recover contiguous pages, so this
is most welcomed!

Jason
