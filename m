Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B113C479C19
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhLRSmi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 13:42:38 -0500
Received: from mail-mw2nam08on2084.outbound.protection.outlook.com ([40.107.101.84]:8929
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233837AbhLRSmi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 13:42:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9kdAfrsB/kZKY++6op8DCc1c6Vap8/mUQBYWA3F5RYRjbHba5IQ74eiAVeqHAGhR9p0l5N3F0w6ZRmDr/IhxcGGbhoMLy2FL3LDWZzJebOMuySWS8xB5OYIwlWRIGHZXqlQqJrrAQh8+0/Si0RP2SiwhlcL/YJrzBwks2Cg8i3B37aodV+rV2pwLfZVLBp1s2sDeJ6YXyywYz+p3MoO08humNy9XSrGbgcraLgp9R8Vz+2WyLUIwbyMchKblWw8zmc+SYNJ5b83N1c7//7c0lbrCQOcpILUQAU09MHxVs5uDf/sJTMsG6+QQZEpP2Ds1lzy13b5aJ1h+BobZiF/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiizjnnpB6GVBmYbe/rJst1xTKs/wm3Uf5zlJ4pNCQg=;
 b=UOnPl6DPUIU0HXcAv3PSfk1yR6zGP9NJWQ6qboQW6PUn6QidSnNPBY1CR7OxllBksRKY2QK2ysG95+JnssuHcUnZH3T0HTWVjFA5ZclXmJj8/7pOr9+kO+pVsTadckGP9xZ5gj2FR91zS8mgo2rBmDdc/57kSwC/VVH323lOaabJEhqRj0J+kLJINkM2GWbjyebzMuENXrzCVhzuV97/6Af1HAModjNcMH1SjhHMWQ9vFjGYLNvJvWQzwSUI08etkmCNE10XJTZXrDqmjq7cNP4PydAeZWmTXhIrtTsIr6ejwHpH1eTcZC3OlNp8vrmG2EDkBsAxqpe5NMTim8WI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiizjnnpB6GVBmYbe/rJst1xTKs/wm3Uf5zlJ4pNCQg=;
 b=TArVGwjoKt5P4RqCa49CtltW47bQa402WjSpg8LVjjCEdmXdkUjyt0fMd1iG9xyUOm0rXC/Qa+23GFn/9BmeTM8NitSQ3gRE0kmSuI3flJcBJ9eqC7bZ0CN69f6q4ngLRW7pJBR8B8FJakzKIygJPEbDG0zza8gMOr7mlP1BEUgjhZhDVMHyV+dQy964LYdFuaKKdTlly/2UQJp0/P0jM4vlUfmEgQ3biZsbsRdMKAEwn7B5Mv0ZyhFEVGVlDkS68cdtXzpAci4+ZAEuYBlR7x9kx4IPMNLm+/vVhySenSWlExVcbr2DUFLfluJm2IJK20/ZPYunz+W28/MpfSsP8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sat, 18 Dec
 2021 18:42:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 18:42:35 +0000
Date:   Sat, 18 Dec 2021 14:42:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <20211218184233.GB1432915@nvidia.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0266.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 071ce01c-a18c-46dc-a7ba-08d9c256282b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55078DE7FCF54EF37FC33E30C2799@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aq6qEb3LGJeAM6ix9c4bt4859uMnJZUcYe494g2rPULobSFj8tUp8MfvAZY28WA5/5/i4gt9FxngradxScGziHXDAV0fzmlwdd60CLhwptTjHjwSdRLgGXnL+a9jBnRjMQ/6o6zLj4r6arNxV/MC/GANF4/U2OHkZoxquRY84ncTxQKkWPE9JUoO1Ra9UbARfVWqdFiMXIqpo4ZR32ykAW3WYPKQaslUv9oz4XkSofHtBIuH4sKkSiF5WzEDzNVHkdSaMiwWur56R6TRBLUXpN2vSzRNZwFHydE+vejUeHpJmwFccARGzKvaboEm4nvu/LVd56hjeSj+xNL6OGE6e1f7Nor1HWxIodp9wNsA2LaOkQhInLPCswwQDJhuBT1Fx2O5mSt1GSy0EvQAEdBxXAGXX13Z1o2hEBhUXgaOkVOjreHAzZ/wX5K1AfNPA1owL1Nl7FrOddJEA7o9XonZJynunfxCAOO+ErBKclt1LlHmqO6ISJKmX9MGL+jbs77sFXfX5j8lBCTEbbijRAHcQRQtOzArYtvaVJLfWQvsHGklSqi2EElG9qHy0+bxklBq9/blBsHJGwtTPsG56nHi/QluzwB3HwvUbVX/czjwtBBEtKK6pscZ6pTqH0vc4vGH2rD3tgoa0vVGIEYbBnWLdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(36756003)(33656002)(38100700002)(8676002)(2906002)(2616005)(6486002)(6506007)(53546011)(6916009)(508600001)(1076003)(4326008)(66476007)(186003)(54906003)(26005)(66556008)(7416002)(316002)(6512007)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6W7Xd7dVHI321VHs3AbHoWuAOqF5l1A4y7fUqTDkhpRpCfWiotbNYsKQeshi?=
 =?us-ascii?Q?93nMyKgB1O4tiElQCa3QRqJVFHYUSPEKKwGYvfkeZaK1rUP31sfbqZ4uZIBO?=
 =?us-ascii?Q?y3vEbPBAPZNNqV8RLuI4GtVJcXuQlLI9g2/p6sYMWb9a42A+GsFCSGdbtYfN?=
 =?us-ascii?Q?4r9hK22UBcWJv9NgBlZjm3imVLon1I5eSZ8MLfuqwagLjaTW7CPwzlVgmFgy?=
 =?us-ascii?Q?UdT1vOVWqrbNm7nIa8elZi2fd7+nm0MZo8pwigDodKuT516VmWVpV+JPhybR?=
 =?us-ascii?Q?vF2+EQh6toxgQbEji0q+TTdvRtAAETvEhJtFkuXjUDhE1oEz31BjrWDVH3Ya?=
 =?us-ascii?Q?8I8bvoZbTG8TccijNUW6HqVHdSP1cGYGm3tnkixV66l1JRUrx8hCxM0n3Il8?=
 =?us-ascii?Q?fkJ6ZCvguE+rbImdsNf/RsNqNkZlii6arJBrX1LenFr9uYAdgDL3XbFyjytQ?=
 =?us-ascii?Q?VZa/ytXPL9Q9o09OFJZjM2vwrXQMsmtN5hWAxhrdUFzVTWdUxCz+UjPUjrdN?=
 =?us-ascii?Q?4A/KDOJowxuko4N16sJSgrYrjlefhWZugz8enkipaQqi+fO4SwN4IVPY4yHm?=
 =?us-ascii?Q?sPkihdR29U7qFRBTitomV2nlZdTXAkHcunbYvCybdt9O4D7XUXjKd8nmcmVU?=
 =?us-ascii?Q?6Mcv0hHtVWfoyH6+ZhDpSSADltrbNkRSC3/2waf85h0ytij6RkQ4+GEkD0Pt?=
 =?us-ascii?Q?Vq0WWLg2kwIQfRseIBKCS9MyRjzMQsVZjTjPCnS6+PPVsHp85mbiDCtf32cY?=
 =?us-ascii?Q?8XzwuPbonfHriTiJ0r4fqvZvW4KQhfBt4PcSFfeLnAsVoGsUHr3iCnqHex8F?=
 =?us-ascii?Q?pPWH8qT1Fl/43xfW2yQTX3Q+Br6mXksCoJ9/8uZrIkd3Gb+vGndXyDJBxfIS?=
 =?us-ascii?Q?auJxKM1L+Wp4RhqmO9tLnBXX0hkmSqRGCO911ZPJ/S2Olpg+14sEq5hPMoi6?=
 =?us-ascii?Q?T/M42aHTcDow0H9w9omxKm5eF4rCfozJj+7jCp44l9+iM3eV17HStaIV/uyn?=
 =?us-ascii?Q?hbD+QrW12aO28aTMOmBnJ1B/cmAgK27tdSTozhYibOEcNxEYD6mRFm9e52sR?=
 =?us-ascii?Q?u/IpgDY3pXHFuqUH7JoU2s/XoYqAPj0Bvu0YC+Q2oPy9wc+bQL9YzxRFZpdW?=
 =?us-ascii?Q?2yV4VdoJ6cJflZ/DTfez4XisbRr9exvJaCZ69NqroTaq/heF1YNi1zAN/I0I?=
 =?us-ascii?Q?9lEnQHied6te8mwvX09OFflrRaXNBfRca6x8wyjiemhHA9StH6D6VG6bA9ne?=
 =?us-ascii?Q?sMordOWEWg3310QN+p/3iabrAWZnyjBZBXHjgavWmZaxfkHVzAmaeibZJ99J?=
 =?us-ascii?Q?BuKtkauER7UxbYN6uZfpTlmGJPRWLMvnv+V4P6dmJs2WUqR6PvTVwDcX+tG2?=
 =?us-ascii?Q?TSpsTkg23GoxNAplF6ovw4iJd4b5BH51CdsRhL+t2DdquZcNfzFAkU3gBFzG?=
 =?us-ascii?Q?EFoTeozK0SBrfDX+U49+PpTdRSlre+4NGkcxqYAYalpDz0+8mzvDmfzsOIhe?=
 =?us-ascii?Q?gPQvVAObgIkIHGECzlgRWycqJXOPt15E4mNjg1NsB6krmxojZkMera61jPKI?=
 =?us-ascii?Q?cB/Mcws7rtg7olRzF1Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071ce01c-a18c-46dc-a7ba-08d9c256282b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 18:42:34.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x00JQl17ZK7PIM7z7E1JBFX9+9/UTdLL3o1bp1H5el/loDZD1SYdcEEW0Jxd5ksK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17, 2021 at 07:38:39PM -0800, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 7:30 PM Nadav Amit <namit@vmware.com> wrote:
> >
> > In such a case, I do think it makes sense to fail uffd-wp (when
> > page_count() > 1), and in a prototype I am working on I do something
> > like that.
> 
> Ack. If uddf-wp finds a page that is pinned, just skip it as not
> write-protectable.
>
> Because some of the pinners might be writing to it, of course - just
> not through the page tables.

That doesn't address the qemu use case though. The RDMA pin is the
'coherent r/o pin' we discussed before, which requires that the pages
remain un-write-protected and the HW DMA is read only.

The VFIO pin will enable dirty page tracking in the system IOMMU so it
gets the same effect from qemu's perspective as the CPU WP is doing.

In these operations every single page of the guest will be pinned, so
skip it just means userfault fd wp doesn't work at all.

Qemu needs some solution to be able to dirty track the CPU memory for
migration..

> So that sounds like the right thing to do. I _think_ we discussed this
> the last time this came up. I have some dim memory of that. Jason,
> ring a bell?

We talked about clear_refs alot, but it was never really clear the use
case, I think. Plus that discussion never finialized to anything.

David's latest summary seems accurate, if I paraphrase at a high
level, Linus's approach always does enough COWs but might do extra and
David's approach tries to do exactly the right number of COWs.

It looks like to have the same functionality with Linus's approach we
need to have a way for userspace to opt out of COW and work in an
entirely deterministic non-COW world. WP&GUP can never work together
otherwise which leaves qemu stranded.

Or, we follow David's approach and make COW be precise and accept the
complexity..

Jason
