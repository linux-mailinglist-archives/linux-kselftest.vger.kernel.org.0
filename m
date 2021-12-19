Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E07C479FDA
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 09:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhLSICE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 03:02:04 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:37120
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231314AbhLSICE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 03:02:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LINLM5o+um24Ts8yRdhBeQvLozDCvfVamP4KRF9TnUCQakcezEEnMyp19oWITbM40kiFg5gE20eujZx+DPAFnL2UIkgzvZgh34A24Ia1hrq5x832Y65JPXvyQ6iwMhMLUhvCrR7FPd7KNvjyyeYV/NsyQTy/5a3uPOqPbkuQwi+FTq3t4+Jgz+fNlgl32AofBILTDQn2DqzD3RLOPcbGrn1j7gs2/C5wtsRB9ND238NR8OeyE4lPbdLsoalc56w+09EYS6qX6uPV9A7s+jwUpziuZxPQXx++E+v0MxRncBSAMmLsIqNdS5R4+UwClnJN9b18yllV/3LTV6CazAQDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeKhCefrT+uS6J4YqyJzpI7GW9rFfNOOpw3vgRLwqVk=;
 b=W3DMmSD2Im74LIoiLel60l6fsHpxihWT0N57i/gDoAa53DG86o+28dVKnAky3Ez/UOmgLwGwwHTir9Me2PKHFIyTmiMvnWGFl4YDQ4J4mtfkOVtPbwLi0LYgQJ5swOWev+qqOePp5TbINvS2/61Zuhy4tg9E799o4wTzan3elFs9pqeYkqQK/722vXhJCJ010gc62mdbTR2iIh38F1YrPRx/yVMzmjI69AcF6N+qwDILHcZcFKRfjr/6G4xbubuaEy5xP8lsryXApQYgzLWT4zSJEM+7NlDygXAzqf0OI4i6LI/DET42VIco+MAFA31eGtAvtNd1jgquNByzZA+jBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeKhCefrT+uS6J4YqyJzpI7GW9rFfNOOpw3vgRLwqVk=;
 b=S+t3cZys/v1ROzpsD/uath57hZbzWOBdX9H6c7SPKvVjJi3qamia7kKJ4OdSm+iR0dXxH2NTPGQ1cInwgfjm2fpSih8pCiFlQ5NFpGwkfuN+M5rwvMm67i6h4xVj+AnUfrgzUlSG0Z0nv1ib2OE4Q16u4dQCEwhGSeKyLQBOnDM+Hvj/mKxSwDw45ODyFz23WEnlxCg+GBsAkkMwNC3QNQzkJI7ZpKnoIGtnO3b5iEmYhCSwxijIm7bWk6KixnVQlrX3Fcmce1qz6CeSAg4wK3ylJZ1iIoHGD3gDZTZMfcQlLae2Rlf5ULPSMq+2D/G0QfjzRdYQmczia3CGPSoyxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Sun, 19 Dec
 2021 08:02:01 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::8844:5a42:b1a6:c541%3]) with mapi id 15.20.4801.015; Sun, 19 Dec 2021
 08:02:01 +0000
Message-ID: <341cf567-468e-b5cf-6813-b26c49e851b5@nvidia.com>
Date:   Sun, 19 Dec 2021 00:01:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com>
 <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
 <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 362baad7-4a4c-4d2e-b26b-08d9c2c5d63c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4049:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB404906B716B4A34602BCF1B7A87A9@BY5PR12MB4049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ql4/zuB4AaCmOepUbjJPLvOu8kanKh9Hfs96BKBAJ+/Xe06cCc+zl73owMUpmEZzfpYOMsziD8V6Swwn5Bj6dtj3SeJ6TchK2ymrm5zCyouB6qh40hYqlBX36O+AFRpsxuwjiH1cR3KqA9wsI1hTPn8vkgwO8ne1oRn5RHWq5XA7ulOa0V9Uqz04xasAZzv8lbjIagOUdK/t0jJep0hdaKNrCK4a5kVXR6TA1a1GtyUN+EiU8cBkodpOqzzTZDVkOAcodh0aASY+xdNWwYRTcFglkmynHAn1K2HvzDndNe8jChKasa6uLa3pR9zI2i7A29thRl0JI79wvMFokLOIm8B9putl6jx+oAJJTVjQMcScl4Pm02AhtzzrZCWBoOZ297dPjR8YZwAb25crmESujrHOzmC+Gd7SdjdlnrJnnpOeecbRDJEglB3KeLF3HqGlK9VB868td7CrrVJH7DpnvF8C2k7pvsaQUcdWg30O986Ok9Dqz7upYhRALOCxkS2FoLmz5J9WJcGqKfMMhMcQzdbpz1cM4W83bJoUc+Rn+CnXb3PyRqJkgNb8cvRZjO7vkjb5t352HSI5lMWraG8SZofRLNO20OqsUpOyrlZcMSk8QyxMedK9+y0fvpYRb3E/qF0Hy/Y12axKvuynJhWXjMkKinhit2+4X+HRV8Q1jcohhFYnulcQfdxh08BEn9kRfgiRNwLF/MALGMy8rEzbRDibprKzPTu+3ZQWURfJUlDwTSKJhx7jWdeSif+XF2Gt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(186003)(7416002)(26005)(508600001)(2906002)(86362001)(8676002)(6512007)(66476007)(66946007)(2616005)(66556008)(6506007)(31686004)(110136005)(4326008)(53546011)(6486002)(5660300002)(8936002)(83380400001)(31696002)(36756003)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZxR1ZCM25TSVpoakFBWS8zcUpxb3lsSU9GQ3lhTDl2TWZFNG5tS0VUVjRQ?=
 =?utf-8?B?T20yTGMwWjAxSm4vNFNzcytBeVNtcXlEcFpLaWduemM0anhBbWQ3eHprbHZy?=
 =?utf-8?B?d3I5WGhFd0xDSXdDd0VTRmx0UjdLQmpjeGZ6ZUtxZFRZNEx0ZCtVOG9HcWxq?=
 =?utf-8?B?aDJsMjlLT2wyMXAxZlY3MGtjam1ibWVMeURQNVRIS2RhT3BSR3Vsck5TZ3Qv?=
 =?utf-8?B?NUxNN2EyTFk1UWNrUGU0VnhzakU4Q21FRmhnaXd5cTFTUFd5NDZBc0VLMzVk?=
 =?utf-8?B?dU14SEd1c2t4dDZPN25WVU05eUY5dzdwVlV4TFgwYmQwVzRHZHJISEd5SVBV?=
 =?utf-8?B?K3Nmc3RBUlg0ZHI4U3RmTmEwSEZJMG9VK0ZsVjNHVFBudmV2dGwveUJPMG8z?=
 =?utf-8?B?M3VpRUZhSXBucWxUK05yb0RUM2lQUHdJQ0FKVXVzZXZxZDdKeE1RVjNFYVpP?=
 =?utf-8?B?K0ljRGFVYXpyd25UZEdVNlVzays3U1Y1aHVVQ3B5ZUp2THE0TGs4Y0NzZDdN?=
 =?utf-8?B?Y3A3dDdUcEhQRFNsWHEvWU1nU1lxODJ0TzNtQzJzQmRVNC9DbFV3OG5xaDIv?=
 =?utf-8?B?WlpiUm01dWRaOWhwdE1VU2J6ejZaVlllcllvUUFzZi91YmhwTkhxZkRJMGVB?=
 =?utf-8?B?a1ZJa1BCSGltYVRLaHpDM0l0enEzcG96aHlxcDdiREVqZHUvbjkzSFZDTTVF?=
 =?utf-8?B?dG5DMEhVdlhxbkRIZ1Q3ZS83RzV4TWxBdVUzVkNHTjVnMmsybXlXeXR1SjRO?=
 =?utf-8?B?SmhIUDBnS2N1cENBeHNGa0dOci93Q0t3UTNwY1dUMjBNblBSNUFqcW5VRWRU?=
 =?utf-8?B?QitWMTBmYUJmRTgrSFBsaEkwQVRPRkdHbEh2WjI0ZXdxVEdDN0k3N0FaVklm?=
 =?utf-8?B?WVNId0o5WnMzUmRvMExpWG5UOWdDYXRxZnlVeDN4ZG0vdnc4RFNhREY1SXI3?=
 =?utf-8?B?Y2xUeVdWM21hTEtRbnBhYUlHWmNZVGdFZmNNNFdKVnhuTkF5WGRGd0lkc00v?=
 =?utf-8?B?a1JBWFQ1c2FnWHJEM29pRzhRbGhZS2IrcEhTS2doMVdaQzJFazFrTWUybmds?=
 =?utf-8?B?Y3gyN3NibXhjKzhPNXE5REdadlF6NkE4dnNZZmNnMGpzQ21ndUZ2Z0JnRjhN?=
 =?utf-8?B?QkZmRlBockVRdzB4ZDh4NHc3Vm5HdGZrRkYxbGQ4dUdRQmQ2cGR5MmcweDVo?=
 =?utf-8?B?cUR3ZEVBUEd4ODhHbmNZN082cGhVbVIwTE54empJTmtFb3lFZHcyTElBZWwy?=
 =?utf-8?B?cjhDT0NGTU1XZkdJQTZkT0g1aHgwclhMRmVCYW1KQXRSaUxhWFRZSWx0bmlI?=
 =?utf-8?B?VFNYcVpseVl3QW93VXJwcUNFUkdHaytVTTl2cndwR0ExN0JZQ3VXZlU3OEtZ?=
 =?utf-8?B?RUh0ampyRG9GWG1GK1ZkZU5LNm9LbHB2c29OWVpaY0lrODRDRXB6ck96K1dn?=
 =?utf-8?B?bHFHOWhHQ08vR3FZOVpSSGhabkh3SjZFekZVL0tZRUY2VDBQUDVOVWVBQXNl?=
 =?utf-8?B?STUvWkV5aS8vZGw3cHpzT2lzS3BZMHdEbHQ1dkFGSXJvY3kzeG8yUG9Pa2NO?=
 =?utf-8?B?SjJWaU1FTEV5cll4WFZ3MFFwcGZtMHB1cmZSckltNUwzNm52ZjNaL2RHcVhS?=
 =?utf-8?B?ZUEyb0Zubm1BQ2tJbE9sOU9vMFNJSzNsSUZ2ajAxMFBTYjg2TllqR1p2eXFH?=
 =?utf-8?B?MUlOYy9mcjB4UHFIQVNIcENDVWhUY2NNYTY2YUZtMFRtRExWMUtDVGdQSGpP?=
 =?utf-8?B?MHRTQjhKcXJ6Mi9rM2NrZStxY3ZtRXE4YTlGeExtK3pteHVjSml4WVM1T0JH?=
 =?utf-8?B?M2JEMGZUbW4wdnUrKzR0RExRYnJSTDBraWhjcmYxN21lVGNKOC9QL2N2WEs1?=
 =?utf-8?B?L1ZMN1VubFZhV3Q3ZGd1M1Z3eFJRckY3M1pwMldOTmxuSUViUlErNDRwK0x6?=
 =?utf-8?B?SVNCcVFveGZGUzBxYjlTWmF4SUpEWEw4bkErM01IdG9oS0RHeGFGb0RVcVVj?=
 =?utf-8?B?eEw1TmNoOVhTTmplbWxTUVdYNHh3cXdlT1NTWUhDS3BHVHB2Tnh4Y1cvNDZ5?=
 =?utf-8?B?SE5KMWZxSk5YSzZsZFRuQVk0RFltSWRFbGs3MURBNk4zUVhZMWViOG55WjVs?=
 =?utf-8?B?OFc1a29IRkduVkRGbnRPMUYySkN2WlZ0dGZONjNZZ3UwbnB3NE9vODBpWWtN?=
 =?utf-8?Q?J4RoTZPeJenZwvT35JZIQVg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362baad7-4a4c-4d2e-b26b-08d9c2c5d63c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 08:02:00.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJJH/ECbjJFwEtajUMADefTf7Mb92WxyJmtayasklVjH/SOQn2ogdRNuslCyWnb2asNN/Pz35OKBlMdXohKkgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/18/21 22:02, Nadav Amit wrote:
> 
>> On Dec 18, 2021, at 4:35 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> (I have only ever seen the kernel side of uffd, not the actual user
>> side, so I'm not sure about the use patterns).
> 
> I use it in a very fine granularity, and I suspect QEMU and CRIU do so
> too.
> 
>>
>> That said, your suggestion of a shadow sw page table bit thing would
>> also work. And it would solve some problems we have in core areas
>> (notably "page_special()" which right now has that
>> ARCH_HAS_PTE_SPECIAL thing).
>>
>> It would make it really easy to have that "this page table entry is
>> pinned" flag too.
> 
> I found my old messy code for the software-PTE thing.
> 
> I see that eventually I decided to hold a pointer to the “extra PTEs”
> of each page in the PMD-page-struct. [ I also implemented the 2-adjacent
> pages approach but this code is long gone. ]
> 
> My rationale was that:
> 
> 1. It does not bound you to have the same size for PTE and “extra-PTE”
> 2. The PMD-page struct is anyhow hot (since you acquired the PTL)
> 3. Allocating “extra-PTE” dynamically does not require to rewire the
>     page-tables, which requires a TLB flush.
> 
> I think there is a place to hold a pointer in the PMD-page-struct
> (_pt_pad_1, we just need to keep the lowest bit clear so the kernel
> won’t mistaken it to be a compound page).
> 
> I still don’t know what exactly you have in mind for making use
> out of it for the COW issue. Keeping a pin-count (which requires
> internal API changes for unpin_user_page() and friends?) or having
> “was ever pinned” sticky bit? And then changing
> page_needs_cow_for_dma() to look at the PTE so copy_present_pte()
> would break the COW eagerly?
> 
> Anyhow, I can clean it up and send (although it is rather simple
> and I ignored many thing, such as THP, remap, etc), but I am not
> sure I have the time now to fully address the COW problem. I will
> wait for Monday for David’s response.
> 

Hi Nadav,

A couple of thoughts about this part of the design:

a) The PMD-page-struct approach won't help as much, because (assuming
that we're using it in an attempt to get a true, perfect pin count), you
are combining the pin counts of a PMD's worth of pages. OTOH...maybe
that actually *is* OK, assuming you don't overflow--except that you can
only answer the "is it dma-pinned?" question at a PMD level. That's a
contradiction of your stated desire above to have very granular control.

Also, because of not having bit 0 available in page._pt_pad_1, I think
the count would have to be implemented as adding and subtracting 2,
instead of 1 (in order to keep the value even), further reducing the
counter range.

b) If, instead, you used your older 2-adjacent pages approach, then
Linus' comment makes more sense here: we could use the additional struct
page to hold an exact pin count, per page. That way, you can actually
build a wrapper function such as:

     page_really_is_dma_pinned()

...and/or simply get a stronger "maybe" for page_maybe_dma_pinned().

Furthermore, this direction is extensible and supports solving other "I
am out of space in struct page" problems, at the cost of more pages, of
course.

As an aside, I find it instructive that we're talking about this
approach, instead of extending struct page. The lesson I'm taking away
is: allocating more space for some cases (2x pages) is better than
having *all* struct pages be larger than they are now.

Anyway, the pin count implementation would look somewhat like the
existing hpage_pincount, which similarly has ample space for a separate,
exact pin count. In other words, this sort of thing (mostly-pseudo
code):


diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..646761388025 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -938,6 +938,16 @@ static inline bool hpage_pincount_available(struct page *page)
  	return PageCompound(page) && compound_order(page) > 1;
  }

+static inline bool shadow_page_pincount_available(struct page *page)
+{
+	/*
+	 * TODO: Nadav: connect this up with the shadow page table
+	 * implementation, and return an appropriate answer.
+	 */
+
+	return false; // hardcoded for now, for compile testing
+}
+
  static inline int head_compound_pincount(struct page *head)
  {
  	return atomic_read(compound_pincount_ptr(head));
@@ -950,6 +960,13 @@ static inline int compound_pincount(struct page *page)
  	return head_compound_pincount(page);
  }

+static inline int shadow_page_pincount(struct page *page)
+{
+	VM_BUG_ON_PAGE(!shadow_page_pincount_available(page), page);
+
+	return atomic_read(shadow_page_pincount_ptr(page));
+}
+
  static inline void set_compound_order(struct page *page, unsigned int order)
  {
  	page[1].compound_order = order;
@@ -1326,6 +1343,9 @@ static inline bool page_maybe_dma_pinned(struct page *page)
  	if (hpage_pincount_available(page))
  		return compound_pincount(page) > 0;

+	if (shadow_page_pincount_available(page))
+		return shadow_page_pincount(page) > 0;
+
  	/*
  	 * page_ref_count() is signed. If that refcount overflows, then
  	 * page_ref_count() returns a negative value, and callers will avoid

c) The "was it ever pinned" sticky bit is not a workable concept, at the
struct page level. A counter is required, in order to allow pages to
live out their normal lives to their fullest potential. The only time we
even temporarily got away with this kind of stickiness was at a higher
level, and only per-process, not per-physical-page. Processes come and
go, but the struct pages are more or less forever, so once you mark one
sticky like this, it's out of play.

thanks,
-- 
John Hubbard
NVIDIA
