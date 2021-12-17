Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812474795BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 21:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhLQUrK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 15:47:10 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:42721
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229587AbhLQUrJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 15:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjBBMphFZOFsQesTz2olEKSlToOAe96PkrwzVAZv/a781Dej6XgN5xmoN9t8Ai64cfJIBxExqfhAa90owEjCUwB17ehRverL+BWYFnYI1FIxWqGAsMh9lpASq1chbm5OS/Yn44ScTDDVO6CpegghTlxPexqcv7fiW1dPQaTRrQrQk5YePlYZhv+Mi3P5zzvQvHvpXjmKrB4liZm9Q/1GMyIVTD7Jhlo6tKL7JJV9GYx+HffCy10GHlvf2K5TNv1WpGMHCcQ14QYkFFg6FpyZpbDI54m2Bs8cMjV1tZMB5oYH/yb21nmIyCvMxlgxSxQLkte7GZrKarxKGxL4lSgPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIvlkk8Ha0ed4pfpqDSCQEEMTkF16VvZH8ohpznvT3Q=;
 b=TiY1YlyeIoG85VjARI2oLmozE5nefo6m0xJ86FveNiF/txpAKaRGSJOpXHOYkmheEZbKxCAi0IOFrVnnnkpiEQr3czCUrg/KSfXFb5tLXN1o8Q27VX/WS3luvuwVh+/xu+vMsl1U58QZoKfjv0FV4uwUhAsStXsXSN0p47FFH53N151KqTvad2D12w/+DTAyV6FzR4+ddVg7DghIl7WKwSsYYHar6wX4fCCaoHkd4O6loEkGdwPBN0YnkVVhUrgofPUWKyIDq6ll6cveR8yyEUlZs7f5KB9dQ0B4ABn2yyMt9R/agDePzwjN9l7Qdt2XTaY8m3bCiCuFf/Y1exXaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIvlkk8Ha0ed4pfpqDSCQEEMTkF16VvZH8ohpznvT3Q=;
 b=b5kU60mus0JJ0gAIx+nc/BgSK27pY0vA5wC+irdStbhYQHDIkjgzG905DrSnCJCSp148PgcEM1xU0jh/hzxOKxhedWKYV60v6f5kq657bpNV85e8SRQoYoqFHH4PB4tvs7MPU4PXs7ZkPf/LPlv9ROAc14L3Dzmu0VY0CEeMPPz51fPfCYrAlDE7d/qlW4imdxnT/QvVDhm33QaUzdLlbaWh93jCJ4T1rNZVW40KcRwxN5Tg9IkiEjXkHO76py/G1h4I0sMcjY26LdAEM2i2eXbBAnKwAQPIzcIep+fwSJrXvOS/GKTezId3SXg4sbcqaJZsV/PxROEi0EwFN09WJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 20:47:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 20:47:07 +0000
Date:   Fri, 17 Dec 2021 16:47:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
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
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
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
Message-ID: <20211217204705.GF6385@nvidia.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::37) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17c20d20-3ebd-4c5b-0b78-08d9c19e638b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52067CD4FAF0D08697EEDCF5C2789@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFHqgpAeYGGRUsr9uq87mdVrktShu+eLlS4cYNGAast+IuGY90hDVijy/qxWw+UeeGJ8NIAzczS0Dq/MxWDXlPTAGFddV0Ef/vHKhAxBXfWTNaqDC/xFdl0E0EfABN4c3ki+0YjutOHEZjN3b/9cblekcPAGxugPugP4QRjebZtf7C8u7AIbBchXWCJh/FkuPtakKfNqpAzaSOGPU3kIWHT/XTL2tRPVI5OZBIo/jG4e1vFoTUm+AElHBPuhkn+OxCOuvlQ9dXMrxWa950nwIt+WFm/peeQTxm5WbVN0BznqORONeo5XJ5ATwXn71Nl7+8/eCXPcicH5R1nLhyaIMsYGGstklHKZP8JN2sODaLDUBER++ere7KIQy5+DEPa7vePDqkgqDIaC6vASs9sUCUiKVMLrIaoyCqy/tciT9Zp+9GwsCy6oyKV06KrsRDPj7q0Onv3MkikElWvnAwVsjYW+WysI0Z9bvVumk8Ltq3ZTMplYzK7LaIQgcPBL8OAVmrJyLd7zsS5yS+mADZft72r6OELSKPsSsHwp0ax5UynqAjRnehCWyiRVpqli42jMxYphAp54RXWssCPujW1MJWS5H4KOy8yztwnzrmuxgK4rs4Ihq1dOoVrP0yqksEIZ978LWJZNEbJP+XzqE+ZQEQ517wD/IczDI2DfSm3axepBkrJEmrfvSxo485k9s25n7UwiuXllLrE7BQhALCPvsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(8676002)(86362001)(2906002)(508600001)(8936002)(54906003)(7416002)(6916009)(38100700002)(33656002)(83380400001)(316002)(1076003)(36756003)(66946007)(66556008)(26005)(186003)(6512007)(6506007)(5660300002)(4326008)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SN92GiVwSUInwaDBLHwp6du51Fs1QswNMoRC3t1RYZ6vtCk1KKiUulHkLHkI?=
 =?us-ascii?Q?Kv25QjXkN7rg7ii4bhH6b8AF6pMgDD1IsgYQ8goZA+tmGeERr070/e3z3vJl?=
 =?us-ascii?Q?E2xNZUF63xmsunQfKWwWi9HJOa0zRfm4f6uwmyDA2jEKbRAdOXmLsXweSEOa?=
 =?us-ascii?Q?tH1gYPowcHZWtI/PJ4JhXWUIbg5I7v6FwjD+28c6P5Fp10turuqg7D/MK7R8?=
 =?us-ascii?Q?bcKOJklVNCykzIkmvLp9b8PSoRn/xpze4jD0y9/sJ7mPUQWVoC2q0k6gN6zX?=
 =?us-ascii?Q?CeNTr+EWmWUoEAgciV2RZhNgn7XIvBeYJOu2HWYryWCUDHK4+EC6dvSE7dYi?=
 =?us-ascii?Q?sn/2fbvgwBpJMuxxDx1CtErzsFQLJ98rOT7Nuh6yMcxaw5XN5mwpwsZ7Np5F?=
 =?us-ascii?Q?2X/16t+KbTwaVRjt0Ac78YX7b67PZKGM4HJqWBzzJTHHC3ubYJVu0b9/KMGm?=
 =?us-ascii?Q?2aSW3aBiDVjJFJR980tllseQbdbDE1hod3jQefQ6vdarK/BerJw6O3iehiNO?=
 =?us-ascii?Q?OFc5BuHRLu/cWYnwOfv7JPIvmYkZvGMERZj8yoflezmWyKfsFWlaSCGOPrKW?=
 =?us-ascii?Q?a7Kg6mlWGB+qgkel8J3vSTEqKFOtJ2K77nDkmbbEzpnTsuwIeOpjI+tO+Nc6?=
 =?us-ascii?Q?D1ep/TqPSZITJ9OFxuTYD80e2+mjY83wE+L8qt70c/lM+G1ck9dWPbieshAq?=
 =?us-ascii?Q?OlQ6u1Ym51NNLtfw5VflxoiPTb4EJl0IQFJK/V39ugF2t/Y/C1UO3Xa9cv21?=
 =?us-ascii?Q?Lk6Ehsvl3LAvnhQLKbpYO6fr30zstQAdGL/yUDQ9wKVqIVbPmYzpus0lXUyH?=
 =?us-ascii?Q?Mhr8tNb80yAddiFwOBhuZBL5Br1tLxXIWWA2BlbYD27pfcmAAvp+6r50AZ5b?=
 =?us-ascii?Q?HhfFjH0uR+ySf7WN90dga+eMHXhhjUwfCkZsUww+csKmbJJ2bRuCaxcfDVsK?=
 =?us-ascii?Q?gMLvf9hf+bZfyJjFPoeblZ5Nb4E0CYyohTb8Di1WWqiIcPT1yhiCp8kkS16x?=
 =?us-ascii?Q?mz/mxVh006uGxLaTMQ8tBpKVCdyGfK6zm23kYqoXZQIraMz643IabDG1Cy2O?=
 =?us-ascii?Q?mKWbJbqJ2oqE05PAYCJqRXFMcaEvCNDRj3wmVakZyodeyzUwbfYpruybMYAx?=
 =?us-ascii?Q?9WWjA11tJxifgMP8h6iZlMCxm2Z24Q16yxB29Y3KqoYNy5XscymtCcLJxEIl?=
 =?us-ascii?Q?s3EPhJzfRq9mNf7LopkhmdaLa0SNDaIqYdkzreKtGtGPKKMAwr0Yh/5BSLgF?=
 =?us-ascii?Q?4Y2c9ZDyLx18xOmzQcOTQghuLsnRLXm6Rz1h5UHnS0s55pOSTPvXpd6wuAmm?=
 =?us-ascii?Q?M1/8m629kTp2rCPnYlsg8JB/x86RK84mwkFlOjQ3ry0N4WiXSayaoSRmEQ3Y?=
 =?us-ascii?Q?JOknCLH2JkSypsKZLe15vTa47alupHvQfmp0Iy9AulJmFk7cYBLjy0odTvIf?=
 =?us-ascii?Q?QgXKIoB9VCQ7o0IfTllGepPrxZSAZeqd9h2yHy7YaFm2H4aLuv2n+TTq4Hz6?=
 =?us-ascii?Q?cE2ZqAPBeeZzfYCs1oygIN19Shp6nw/pakQGeAKSgeidkUUA4IwVt/VF70KD?=
 =?us-ascii?Q?2lGsPlbAEsDRMblUbY4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c20d20-3ebd-4c5b-0b78-08d9c19e638b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 20:47:07.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guycdAW0uS7uq/EBNgHMx/O2ChcsO3V4OlMoHZZBSYLjVrc1eNf70ZEHRbe08ZSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17, 2021 at 12:36:43PM -0800, Linus Torvalds wrote:

> > 5. Take a R/O pin (RDMA, VFIO, ...)
> > -> refcount > 1
> >
> > 6. memset(mem, 0xff, pagesize);
> > -> Write fault -> COW
> 
> I do not believe this is actually a bug.
> 
> You asked for a R/O pin, and you got one.
> 
> Then somebody else modified that page, and you got exactly what you
> asked for - a COW event. The original R/O pin has the original page
> that it asked for, and can read it just fine.

To remind all, the GUP users, like RDMA, VFIO use
FOLL_FORCE|FOLL_WRITE to get a 'r/o pin' specifically because of the
COW breaking the coherence. In these case 'r/o pin' does not mean
"snapshot the data", but its only a promise not to write to the pages
and still desires coherence with the memory map.

Eg in RDMA we know of apps asking for a R/O pin of something in .bss
then filling that something with data finally doing the actual
DMA. Breaking COW after pin breaks those apps.

The above #5 can occur for O_DIRECT read and in that case the
'snapshot the data' is perfectly fine as racing the COW with the
O_DIRECT read just resolves the race toward the read() direction.

IIRC there is some other scenario that motivated this patch?

Jason
