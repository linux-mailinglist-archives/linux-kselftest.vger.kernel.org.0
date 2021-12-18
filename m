Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71547984C
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 04:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhLRDFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 22:05:13 -0500
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:38056
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231715AbhLRDFN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 22:05:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyrGKjO273iZtg+w0nVfflq5xkcRi/4SkRygz5PzXi/HEQ0/zf01C96HH/W4/BnIQ+7H7Isz0FEbiekymm9tHk06bTdcC+MTCzpPkJuu/TgCd+bwSbJUkHN71khILcpyRqF6+fLhZMCExjUMR2hYJYEa1pXMBrT47oqSDUJQg3mDosYPjJ2QLMv9ZDhNd/EOp0qYPLa0DvNLQVYM+pLX/EkJ++BO5cY7WDjobj+CVTVsdtrBNTzm5itrNZ12YTGL7wb+Pdv2I5PVlSfMkMBPWJ1nAH1TYb8WJLLW4LUxbKaFu65NnZScdkNf1PrkGkXmJu2ssgjC8GtNCaKMo8yw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+LYi2UYyIPUaGIGsvEc3hkTlkrUEiSLQBZ5xzHhHBk=;
 b=JhHuNCTi0IAuzeTNUSbNzv6h0egxoz/BOL/rWk/NI0Wu0nWekr+ghAjxmZSQKEO1fl15TmMV4rH4+PVPycJRj+qTNSf/6iMXnAzj1cFWY/upusxTJIXRZLnzxJ/MtS+tdoA6DtopOkULZe1An3+emXt1ECIdy721UAAF7aB88OgRgWfAQ6+4Sy3n3yY11KpNZ3ClJ3eLpXEQ/UAjVHEfQDPQWA4OIIj55WfzlhKKlHpNHzW6RZW6GESQOF4AHz0pncm/RCBR+Eoln8N2NJywBUp987GpqzFFsHRUA9UYw2qQsMYKjmqdXsJ7n6YD+NfQ2XZ9cuJw6pOBzh9qYuRyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+LYi2UYyIPUaGIGsvEc3hkTlkrUEiSLQBZ5xzHhHBk=;
 b=d0KxPH3PZPuait2w/8zvFacdx6VfAR93goD14NGxKoNiPDwyhnnQZRkjwQ0ZJBuBnET5oHQSovlO0LZDhOwGYFOucQuqollsxAkWEptkG9AkePy/VeeB+nXvTlDsQZJHAQ5CpWFQT6qttwSalJxnkbqqWIhcxLjO9QzK93nPoqCBGn2q3TMLl8+e80wccnGMLzELB/17DqfXhsvcFtTOUuF/zq1Z+PW7vZ5LSOaKv4MqcZMGbwvZA6ZPmHF4HB4iB13dETVencs8kw+5+k5NJl2/0DSYE9bca13THxTdcli43Jx24osYN64yq9duqmKLRwcQXdvbp6xBiu88sHMAGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5553.namprd12.prod.outlook.com (2603:10b6:208:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sat, 18 Dec
 2021 03:05:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 03:05:10 +0000
Date:   Fri, 17 Dec 2021 23:05:09 -0400
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
Message-ID: <20211218030509.GA1432915@nvidia.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
X-ClientProxiedBy: BL1P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48dc4b8e-4cb4-4414-0f82-08d9c1d33407
X-MS-TrafficTypeDiagnostic: BL0PR12MB5553:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB555348FB0FFB4ECF5D5A14AAC2799@BL0PR12MB5553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zr9FAllzYOrZnLB7qmLFLVbAGViSEJmXtpzLPz1iXUA91oo97C4FjiPzISkiuklf3nECgU5i5/Hc/EtSCvIOXvbCqvS3jkdDIGnAsbZ/VFZdi5FaNQUS3GcftQiqUV821BKnOTpTqFBZ8hugF607ojCZ1wqiFE1o9hcZ7UCLxEtF0WvtCEpUEo8F+eoJjoS7TxrLDgmNOPHb4oMlJpzahWssgRmTJXv5Q5CXJ7iWxx2Prp21jshp+DJWJEWbNH7iGV1gfu8HdJbNas2bwcfzdSSFoAg7pCeHcOH6X+AkKLnWfs42/z1lgWBfTj5JZC5wib3J81T13KpF/b0h4x+yqBfMcTTyzfQMMbaLJZZoXGDv8b0PWGkcFZxO7Cm+SgeApucMQrzdMSEC2HwR8ZHUtULrCmPJ3p3R6L4x4feIaEr4ne0pqou/EL9L+y9FzFyYwU+e381C34ZQrYBR7LKHhbEN3LdX0nKZqvFB7IwhKCgXXW0JJBP4IEfm7tV21L8iYxZIZvlAlHhe5QuQ0O+F5ge/bLwSaHjGx2TRfy5jJmWFRyIuFJ+Wimqhd4S1WaWY9Fs3FtYPzmKNtXzH8qb0jWDMAMxAsKt/NyLgvKgAkElH75U2+f6Xv2voPjMt/cGa68lVuzQFOF0p97CGP0B9Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(38100700002)(8676002)(6506007)(5660300002)(8936002)(66556008)(66946007)(66476007)(6916009)(33656002)(6512007)(316002)(2906002)(6486002)(4326008)(1076003)(2616005)(86362001)(36756003)(26005)(508600001)(186003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjoi3uI+7IL+gtoderG3PmVxYZassog3vB4NDXy+QOGJKUR2bWWMYPzMjjEK?=
 =?us-ascii?Q?Vr4DcoQxhQcqVsbsgUlIHq2XpJizhOsPqykMJbvm4cxNKHsvQMgrD4JgbgIC?=
 =?us-ascii?Q?ds/026xWG8ueZjnJkBKHZlWKzW8oO3uZbRgvJ9n8fVN00hBFoga1kHOIMcus?=
 =?us-ascii?Q?2LaqdZSbwl57dOIRBpXi9H7kGJml/WWwPr+6pGlZXoHsgz4LdtVSUjlB8w2i?=
 =?us-ascii?Q?R41+VcHVu6MUN0p9zwGHChBo1DoXywgbr8H+AkoV234eVmVKA4n/SVWXdw6H?=
 =?us-ascii?Q?WNgekY2TO16eNt3Nm8bn9u2yIGOLQZj75VjEOOdNnBpoLp02wquEJHHdTB2B?=
 =?us-ascii?Q?DtuUy6UKAe2uHTTl5dFia04g4arzh3MvYjezbgfu4obC2Ir5uGv2zkgw6ocn?=
 =?us-ascii?Q?vgHrQsDDk7BPUYSdqJzUi+TjiKy0VosBZthkzqegSQKrQgS/B7XU/3DrDnyb?=
 =?us-ascii?Q?WVV+WBDjBpCSwmYQHh6FWVnipwszvp7g4sUCW4AiHWtFyTfGpbJokoQmbH+5?=
 =?us-ascii?Q?05ExF9QmR9xjcb1fiK6oAQgWI+EhqV57ieig94KYUwX6xT4UXk93Xd+zLW24?=
 =?us-ascii?Q?fDsIYB6ReMYVMiKNsdavuy+6HZ90xhKMBa8aBGHEoX88y4jJgwoTmYsuBQZR?=
 =?us-ascii?Q?928rKiD4QReRCKvp6oKTF+t5FL1Pmt/p/tzvZZny2MygOn/N0sXX9bUsZOqg?=
 =?us-ascii?Q?NYHdll7f3lw6Z7i/yIM+M0MXCHSsliX33tSMgBSzoSXJh70FXHDGCTOrCSG1?=
 =?us-ascii?Q?Zy5/ScYHPApcVaHneN+qKYbBPCTPIR4rFr1SMpbpbZSYUtRdQLj6hQIUSkpY?=
 =?us-ascii?Q?ALTEwlrkUs24KbJZUiPNoGA6zElQI759YDTY7WEvd4ZXzgKkwhE/cDASC3F4?=
 =?us-ascii?Q?1ksWUQbVZITH34KQboDit1Y2GaEEPhEc7F14NMtnZtBN8bONfKS+5UlI2dyR?=
 =?us-ascii?Q?H6D3mB0e+tkF9ONfsRzQ5IC5/thtzip0G2NboZdxRCqXjLRmyg8hQL7YhfB9?=
 =?us-ascii?Q?9hMjctPRaL5zcKonhy8XItjLK71UaWUdM2j5enesjJQMO1GCH632bGVFOVNw?=
 =?us-ascii?Q?HTpeeEKHg+oMlLH65eIx9c7GV3NGN22d8x7+l0FndfLCv2QSYOEmAu8BjGoe?=
 =?us-ascii?Q?xhLc5EiNIk/+lB1qynPZHe3iSMhw/NrLpjdJ0fiZtjefb/e7XvhG8yB2sMga?=
 =?us-ascii?Q?qzmoRzn1+YhmmrOy1KV99epEWRpKokEmtI07wRtti/zd7pzMGOm3KWBexe4w?=
 =?us-ascii?Q?XWQrDl+QzGIalWscLJXIGbUz3Kn7c81cKcvHMRPDuBzLBp79fTLV0KG7I4/t?=
 =?us-ascii?Q?sJ2l0bXR9Q9Sc65QRhq7X3I8lpzkx90+MDw62Ew1StY8wDEeCR4cfqk+Es+r?=
 =?us-ascii?Q?9cuPmThXBoYP1rhM4QrAkLknTeBhw/EtHIXDYumbjMp21GhjaKVXlPqJn0yY?=
 =?us-ascii?Q?QneUNwkIX2gNJKwjwPTQei6FclMJ0A0FteCVI0LgXxm0sLoYAPyNmkCNuDI3?=
 =?us-ascii?Q?AlMmJsSjC0Ec1icR4wfwCKaGOgCFvnAaBGuYHhCPOYDcfaTkKF5QBpmNW2uo?=
 =?us-ascii?Q?OasCbbmq6oijtuvA3wI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dc4b8e-4cb4-4414-0f82-08d9c1d33407
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 03:05:10.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSmuCUsPBLmTJGQG/42bYe3DDdhgxCYOS51DYlF9rD85D2Pn9EDFV99Q3PQR3M8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17, 2021 at 05:53:45PM -0800, Linus Torvalds wrote:

> But honestly, at least for the second case, if somebody does a GUP,
> and then starts playing mprotect games on the same virtual memory area
> that they did a GUP on, and are surprised when they get another COW
> fault that breaks their own connection with a page they did a GUP on
> earlier, that's their own fault.

I've been told there are real workloads that do this.

Something like qemu will use GUP with VFIO to insert PCI devices into
the guest and GUP with RDMA to do fast network copy of VM memory
during VM migration. 

qemu also uses the WP games to implement dirty tracking of VM memory
during migration (and more? I'm not sure). It expects that during all
of this nothing will COW the pages, as the two kinds of DMA must
always go to the pages mapped to KVM.

The big trouble here is this all worked before, so it is a userspace
visible regression.

Can this be made to work at all? I wonder if qemu uses MAP_SHARED, eg
via a memfd or something, does the COW then go away naturally?

Jason
